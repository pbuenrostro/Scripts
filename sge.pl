#! /stec/apps/utilities/perl_5.14.2/bin/perl
use Getopt::Long;
 
my ($mem, $status, $time, $nolog, $ncsim, $int, $email, $help, $queue, $command, $stdout, $stderr, $jobname, $display, $binary);
usage() if ( @ARGV < 1 or
          ! GetOptions('memory=s' => \$mem, 'int' => \$int, 'gui' => \$gui, 'batch' => \$batch, 'status=s' => \$status, 'time=i' => \$time, 'ncsim' => \$ncsim, 'nolog' => \$nolog, 'email=s' => \$email, 'binary' => \$binary, 'display=s' => \$display, 'jobname=s' => \$jobname, 'help' => \$help, 'queue=s' => \$queue, 'command=s' => \$command, 'stdout=s' => \$stdout)
		);
 
sub usage
{
  print "usage: run_qsub -command job \n";
  print "run_qsub -help <to show all options>\n";
  exit(0);
}

sub ayuda() {
  print STDERR "sge [options]\n";
  print STDERR "Options:\n";
  print STDERR "	-queue <string>  parameter for the queue (optional) (default low.priority)\n";
  print STDERR "	-command <job> command or job to run (required)\n";
  print STDERR "	-stdout <file path> to save stdout of cmd (optional)\n";
  print STDERR "	-stderr <file path> to save stderr of cmd (optional)\n";
  print STDERR "	-join <file path> to save stderr and stderr of cmd (optional)\n";
  print STDERR "	-jobname <string> name for submitted job (optional)\n";
  print STDERR "	-display <string> hostname:number to send display out (optional)\n";
  print STDERR "	-binary run command as binary not a script (default)\n";
  print STDERR "	-email <string> email address to notify after job completes (optional)\n";
  print STDERR "	-nolog send stdout and stderr to /dev/null (optional)\n";
  print STDERR "        -batch run mode for Cadence Simulation (optional)\n";
  print STDERR "	-time <number> job time limit in seconds (optional)\n";
  print STDERR "	-memory <number> amount in megabytes required for the job, i.e., 500M (optional)\n";
  print STDERR "	-int for interactive jobs\n";
  print STDERR "	*By default all jobs will export all environment variables and use the current working directory\n";
  print STDERR "	-help this help\n";
  exit(1);
}

ayuda() if $help;

if (defined($command)) {
} else {
	print "usage: sge -command job \n";
 	print "sge -help <to show all options>\n";
 exit(1);
}

if (defined($queue)) {
} else {
}

if( $jobname )
{
 $j="-N $jobname";
}

if( $stdout )
{
 $o="-o $stdout";
}

if( $stderr )
{
 $e="-e $stderr";
}

if( $email )
{
$em="-m e -M $email";
}

if( $nolog )
{
$no="-j y -o /dev/null";
}

if( $ncsim )
{
$nc="-l ncsim=1";
}

if( $time )
{
$t="-l time=$time";

}

if( $status )
{
 $s="-sync yes ";
}

if( $mem )
{
 $m="-l mem_free=$mem ";
}

if( $batch )
{
$ba="-P sim.batch ";
}

if( $int )
{
exec "/stec/apps/sge/sge6_2u5/bin/lx24-amd64/qrsh -cwd -V -now y -j y $j '$command' ";
}


print "Your job has been submitted to SGE\n";
exec "qsub -V -cwd $q $ba $j $o $e -b yes $em $no $nc $t $m '$command' > /dev/null 2>&1";
