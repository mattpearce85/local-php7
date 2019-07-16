#!/usr/bin/perl

print "Content-type:text/html\n\n";

print "<html><head><title>Perl Details</title></head><body>";

print "<h1>Perl Version</h1>";
my $command = `perl -v`;
print "<pre>$command</pre>";

print "<h1>Perl Environment Variables</h1>";
foreach $key (sort(keys %ENV)) {
  print "$key = $ENV{$key}<br>\n";
}
print "</body></html>";
