#!/bin/sh
UTILS_VM_FOLDER=/vmfs/volumes/datastore1/Utils
BACKUP_SHARE=/vmfs/volumes/nfs_backup/utils_vm_backup
VM_CMD=/usr/bin/vmware-cmd
RSYNC_CMD=/usr/bin/rsync
CUT_CMD=/bin/cut
LS_CMD=/bin/ls
GREP_CMD=/bin/grep
SSH_CMD=/usr/bin/ssh

ERRORS=

function die() {
        email_admin 'ERROR' "$1"
        exit 1
}

function email_admin() {
        TYPE=$1
        MESSAGE=$2
        REMOTE_CMD="'/nfs/storage/automated_tests/bin/send_email --service 'utils_backup' --type '${TYPE}' --message \"${MESSAGE}\"'"
        ${SSH_CMD} -t salab@utils \'${REMOTE_CMD}\'
}

# make sure the NFS backup location is mounted.
if [ ! -e ${BACKUP_SHARE} ]; then
        die "NFS backup share isn't mounted."
fi

# move to the Utils VM storage folder.
cd ${UTILS_VM_FOLDER}

# check for existing snapshots because we should only be using them for backups,
# which means there really shouldn't already be a snapshot unless the last backup
# failed somehow.
HAS_SNAPSHOTS=`${VM_CMD} Utils.vmx hassnapshot | ${CUT_CMD} -f3 -d' '`
if [ "${HAS_SNAPSHOTS}" == "1" ]; then
        die "Snapshot already exists, aborting backup."
fi

# create a snapshot so the backup is consistent
# vmware-cmd <cfg> createsnapshot <name> <description> <quiesce> <memory>
${VM_CMD} Utils.vmx createsnapshot 'backup-snapshot' 'Snapshot for creating a nightly Utils backup' 0 0
if [ $? -ne 0 ]; then
        die "Failed to create a backup snapshot."
fi

# create the list of files to backup making sure to exclude the following:
#       VM swap file (vswp)
#       VM ram file (nvram)
#       VM snapshot files (vmsn)
#       VM snapshot hard disk files
BACKUP_FILELIST=`${LS_CMD} | ${GREP_CMD} -vE -e '.*\.(vswp|nvram|vmsn)' -e 'Utils(_[0-9]+)?-[0-9]{6}.*\.vmdk'`

# tar based backup
#tar -czf /vmfs/volumes/datastore1/_BaseImages/utils_backup-`date +%F-%T`.tar.gz ${BACKUP_FILELIST}

${RSYNC_CMD} --recursive --links --perms --times --sparse --whole-file ${BACKUP_FILELIST} ${BACKUP_SHARE} 2>rsync_log
if [ $? -ne 0 ]; then
        ERRORS+="Rsync had errors. Log:"
        ERRORS+="$(cat rsync_log)"
fi

# remove the backup snapshot.
${VM_CMD} Utils.vmx removesnapshots
if [ $? -ne 0 ]; then
        ERRORS+="Unable to remove backup snapshot."
fi

BACKUP_TIME=`date +%F-%T`
if [ -n "${ERRORS}" ]; then
        email_admin 'ERROR' "Utils backup failed with errors:\n${ERRORS}\n\n at ${BACKUP_TIME}"
else
        email_admin 'SUCCESS' "Utils backup successful at ${BACKUP_TIME}"
fi


