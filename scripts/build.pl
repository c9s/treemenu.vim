#!/usr/bin/env perl
use warnings;
use strict;

my $source = shift;
my $out    = shift || $source . ".vim";

open IN , "<" , $source;
open OUT, ">" , $out;

sub find_node;


my @lines = <IN>;

for my $line ( @lines ) {
    next if $line =~ m/^#/;
    next if $line =~ m/^\s*$/;

    my ( $menustr , $command )  = ( $line =~ m{^([a-zA-Z0-9_.-]+)\s+(.*)} );

    my $options = '';
    if ( $command =~ m/({.*})/ ) {
        $options = $1;
        $command =~ s/\s*({.*})\s*//;
    }

    if( $options ) {
        print OUT ":cal TM('$menustr','$command',$options)\n";
    }
    else {
        print OUT ":cal TM('$menustr','$command')\n";
    }
}

close IN;
close OUT;
print "$out saved.\n";
