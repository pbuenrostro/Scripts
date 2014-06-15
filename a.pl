#! /stec/apps/utilities/perl_5.14.2/bin/perl

use Net::SSH::Perl;
 
my $host = "salogin01";
my $user = "user";
my $password = "password";
 
#-- set up a new connection
my $ssh = Net::SSH::Perl->new($host);
#-- authenticate
#$ssh->login($user, $pass);
#-- execute the command
my($stdout, $stderr, $exit) = $ssh->cmd("ls -l /etc");
