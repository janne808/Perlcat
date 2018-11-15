#!/usr/bin/perl
#  (C) 2018 Janne Heikkarainen <janne808@radiofreerobotron.net>
#
#  All rights reserved.
#
#  This file is part of Perlcat, simple netcat clone written in Perl.
#
#  Perlcat is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Perlcat is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Perlcat.  If not, see <http://www.gnu.org/licenses/>.
use strict;
use warnings;
use IO::Socket;

# subroutines
sub argerr($){
    print STDERR "ERROR: ".$_[0]."\n";
    usage();
}
sub usage(){
    print STDERR "Usage: $0 [OPTIONS] [IP] PORT\n";
    print STDERR "Options:\n";
    print STDERR "  -l         Open and listen TCP port\n";
    print STDERR "  -p [PORT]  TCP port\n";
    print STDERR "  -v         Verbose\n";
    exit 1;
}

# main
my $addr;
my $port=9001;
my $listen=0;
my $verbose=0;

# parse arguments...
# print usage if no arguments
if($#ARGV == -1){
    argerr("ERROR: No arguments!");
}

# search for help argument
for(0..$#ARGV){
    if($ARGV[$_] =~ m/--help/ || $ARGV[$_] =~ m/-h/) {usage();}
}

# get options
my $readport=0;
for(0..$#ARGV){
    if($ARGV[$_] =~ m/^-[a-zA-Z]+/ && $readport == 0){
	my $opts = $ARGV[$_];
	$opts =~ s/^.//;
	foreach(split('', $opts)){
	    if($_ eq "l"){
		$listen=1;
	    }
	    elsif($_ eq "p"){
		$readport=1;
	    }
	    elsif($_ eq "v"){
		$verbose=1;
	    }
	}
    }
    elsif($readport == 1){
	$readport=0;
	if($ARGV[$_] !~ m/^\d+$/){
	    argerr("PORT syntax error!");
	}
	$port = $ARGV[$_];
    }
}

# mode of operation
if($listen == 0 && $#ARGV+1>1){
    # search for an IPv4 number followed by a port number
    if($ARGV[$#ARGV-1] =~ m/^\d+.\d+.\d+.\d+$/ && $ARGV[$#ARGV] =~ m/^\d+$/){
	$addr = $ARGV[$#ARGV-1];
	$port = $ARGV[$#ARGV];
    }

    if(!defined $addr) {argerr("IP and PORT syntax error!");}
    if(!defined $port) {argerr("IP and PORT syntax error!");}

    if($addr !~ m/^\d+.\d+.\d+.\d+$/ || $port !~ m/^\d+$/){
	argerr("IP and PORT syntax error!");
    }

    # create socket interface
    my $socket = new IO::Socket::INET(
	Proto => 'tcp',
	PeerAddr => $addr,
	PeerPort => $port,
	Reuse => 1,
	Timeout => 10
	);
    die "Could not create socket: $!\n" unless $socket;
    
    # fork writer
    die "Can't fork writer: $!" unless defined(my $writepid = fork());

    # split the fork
    if ($writepid) {
	# copy the socket to standard output
	my $buffer;
	while($socket->read($buffer,1)){
	    syswrite(STDOUT,$buffer,1);
	}
	# SIGTERM to writer
	kill("TERM", $writepid);
    }
    else {
	# copy standard input to the socket
	my $buffer;
	while(sysread(STDIN, $buffer, 1)){
	    $socket->write($buffer);
	}
    }

    # close socket interface
    close($socket);
    exit 0;
}
elsif($listen == 1){
    # listen on port
    if($verbose){ print STDERR "Listening on port ". $port ."...\n"; }

    # create socket interface
    my $socket = new IO::Socket::INET (
	LocalPort => $port,
	Proto => 'tcp',
	Listen => 1,
	Reuse => 1,
	);
    die "Could not create socket: $!\n" unless $socket;

    # accept client connection
    my $client = $socket->accept();

    if($verbose){ print STDERR "Connection from ". $client->peerhost() ."\n"; }
    
    # fork writer
    die "Can't fork writer: $!" unless defined(my $writepid = fork());

    # split the fork
    if ($writepid) {
	# copy the socket to standard output
	my $buffer;
	while($client->read($buffer,1)){
	    syswrite(STDOUT,$buffer,1);
	}
	# SIGTERM to writer
	kill("TERM", $writepid);
    }
    else {
	# copy standard input to the socket
	my $buffer;
	while(sysread(STDIN, $buffer, 1)){
	    $client->write($buffer);
	}
    }

    # close socket interface
    close($socket);
    exit 0;
}
else{
    argerr("No IP and PORT defined!");
}
