#! /stec/apps/utilities/perl_5.14.2/bin/perl
#run_qrsh is a wrapper for SGE qrsh command
#Paul Buenrostro - STEC
use Getopt::Long;
 
my ($mem, $time, $dcshell, $email, $help, $command, $jobname, $display);
 
#-- prints usage if no command line parameters are passed or there is an unknown
#   parameter or help option is passed
usage() if ( @ARGV < 1 or
          ! GetOptions('memory=s' => \$mem, 'time=i' => \$time, 'gui' => \$gui, 'batch' => \$batch, 'dcshell' => \$dcshell, 'email=s' => \$email, 'display=s' => \$display, 'jobname=s' => \$jobname, 'help' => \$help, 'command=s' => \$command,)
		);
          
 
sub usage
{
  print "usage: run_qrsh -command job \n";
  print "run_qrsh -help <to show all options>\n";
  exit(0);
}

sub ayuda() {
  print STDERR "run_qrsh [options]\n";
  print STDERR "Options:\n";
  print STDERR "	-command <job> command or job to run (required)\n";
  print STDERR "	-jobname <string> name for submitted job (optional)\n";
  print STDERR "	-display <string> hostname:number to send display out (optional)\n";
  print STDERR "	-email <string> email address to notify after job completes (optional)\n";
  print STDERR "	-dcshell job is an interactive Synopsys design compiler (optional)\n";
  print STDERR "	-gui run mode for Cadence Simulation (optional)\n";
  print STDERR "	-time <number> job time limit in seconds (optional)\n";
  print STDERR "        -memory <number> amount in megabytes required for the job, i.e., 500M (optional)\n";	
  print STDERR "	*By default all jobs will export all environment variables and use the current working directory\n";
  print STDERR "	-help print this help\n";
  exit(1);
}

ayuda() if $help;

if (defined($command)) {
} else {
	print "usage: run_qrsh -command job \n";
 	print "run_qrsh -help <to show all options>\n";
 exit(1);
}

if( $jobname )
{
 $j="-N $jobname";
}

if( $display )
{
$ENV{'DISPLAY'} = "$display";
print "Your DISPLAY has been set to $display\n";
system "xhost + > /dev/null 2>&1";
}
else {
$hostname = $ENV{'HOSTNAME'};
$DISPLAY = $ENV{'DISPLAY'};
if ($hostname =~ m/salog*/ || $hostname =~ m/twlogin*/ || $hostname =~ m/mylogin*/ || $hostname =~ m/sdlogin*/)
        {
        if( $DISPLAY =~ m/:*/ )
                {
                print "Your DISPLAY has been set to $hostname$DISPLAY\n";
                system "xhost + > /dev/null 2>&1";
                $ENV{'DISPLAY'} = "$hostname$DISPLAY";
                }
}

}

if( $email )
{
$em="-m e -M $email";
}

if( $dcshell )
{
$dc="-pty yes";
}

if( $gui )
{
$gui="-P sim.interactive";
}

if( $time )
{
$t="-l time=$time";

}

if( $mem )
{
$m="-l mem_free=$mem";

}

print "Your job has been submitted to SGE\n";
exec "qrsh -V -cwd -now y $j $em $dc $t $m $gui $command";
