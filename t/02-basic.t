#!perl
use strict;
use Test::More qw(no_plan);
use File::Spec;

BEGIN
{
    use_ok("Tie::Senna");
}

my $index_name = 'test.db';
my $path       = File::Spec->catfile('t', $index_name);
my $index      = Senna::Index->create($path);
my $c;

my %hash;
my %storage;
tie(%hash, 'Tie::Senna', index => $index, storage => \%storage);

isa_ok(tied(%hash), 'Tie::Senna');

$hash{"���ܸ죱"} = "���ܸ줤����㤦��";
$hash{"���ܸ죲"} = "���ܸ줤�����ä�����";

$c = tied(%hash)->search("���ܸ�");
isa_ok($c, 'Senna::Cursor');
is($c->hits, 2);

foreach my $r (tied(%hash)->search("���ܸ�")) {
    ok(exists $hash{$r->key});
}

$index->remove;

1;