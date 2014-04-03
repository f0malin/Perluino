use strict;
use warnings;

use Test::More tests => 1;
use Perluino;
use FindBin qw($Bin);

ok(perluino("$Bin/test1.pl"), "sub");
