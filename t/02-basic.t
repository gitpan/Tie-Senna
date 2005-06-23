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

$hash{"日本語１"} = "日本語いれちゃうぞ";
$hash{"日本語２"} = "日本語いれちゃったぞ〜";

$c = tied(%hash)->search("日本語");
isa_ok($c, 'Senna::Cursor');
is($c->hits, 2);

foreach my $r (tied(%hash)->search("日本語")) {
    ok(exists $hash{$r->key});
}

$index->remove;

1;