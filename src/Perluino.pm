package Perluino;

use strict;
use warnings;

use base qw(Exporter);

use File::Basename qw(fileparse);
use Smart::Comments '###';

our @EXPORT_OK = qw(perluino home theme menu page);
our @EXPORT = qw(perluino);

our $config = {};

sub home {
    my $pkg = caller;
    $config->{$pkg}->{'home'} = shift;
}

sub theme {
    my $pkg = caller;
    $config->{$pkg}->{'theme'} = shift;
}

sub page {
    my $pkg = caller;
    my $page = shift;
    $config->{$pkg}->{'current_page'} = $page;
}

sub menu {
    my $pkg = caller;
    my $page = $config->{$pkg}->{'current_page'};
    push @{$config->{$pkg}->{'pages'}->{$page}->{'flow'}}, {type => 'menu', data => \@_};
}

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
use Perluino qw(home theme menu page);
use autobox;
no autobox qw(SCALAR CODE);

END
    open my $fh2, ">PerluinoMain.pm" or die $!;
    binmode $fh2;
    print $fh2 $content;
    close $fh2;
    my $ret = require('PerluinoMain.pm');
    PerluinoMain::setup();
    PerluinoMain::request();
    ### $config

    # to start the server
    require Perluino::Runner::Plack;
    Perluino::Runner::Plack::perluino_run();
    
    return $ret;
}

1;
