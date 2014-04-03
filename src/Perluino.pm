package Perluino;

use strict;
use warnings;

use base qw(Exporter);

our @EXPORT_OK = qw(perluino);
our @EXPORT = qw(perluino);

sub perluino {
    my $file = shift;
    open my $fh, $file or die $!;
    my $content;
    {
        local $/;
        $content = <$fh>;
    }
    close $fh;
    $content = <<'END' . $content . "\n1;\n";
package PerluinoMain;

use strict;
use warnings;
use Sub::Signatures;
use autobox;
no autobox qw(SCALAR CODE);

END
    open my $fh2, ">PerluinoMain.pm" or die $!;
    binmode $fh2;
    print $fh2 $content;
    close $fh2;
    my $ret = require('PerluinoMain.pm');
    return $ret;
}

1;
