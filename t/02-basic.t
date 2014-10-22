#!perl
use strict;
use Test::More tests => 7;
use File::Spec;

BEGIN
{
    use_ok("Tie::Senna");
}

my $index_name = 'test.db';
my $path       = File::Spec->catfile('t', $index_name);

while (<$path.*>) {
    unlink $_;
}

my $index = Senna::Index->create($path);
my $c;

my %hash;
my %storage;
tie(%hash, 'Tie::Senna', index => $index, storage => \%storage);

isa_ok(tied(%hash), 'Tie::Senna');

$hash{"���ܸ죱"} = "���ܸ줤����㤦��";
$hash{"���ܸ죲"} = "���ܸ줤�����ä�����";

my $tied = tied(%hash);
ok($tied);

$c = $tied->search("���ܸ�");
isa_ok($c, 'Senna::Cursor');
is($c->hits, 2);

foreach my $r ($tied->search("���ܸ�")) {
    ok(exists $hash{$r->key});
}

$index->remove;

1;