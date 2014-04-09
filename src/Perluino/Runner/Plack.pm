package Perluino::Runner::Plack;

use strict;
use warnings;

use Plack::Runner;
use Perluino;
use Smart::Comments '###';
use base qw(Exporter);

our @EXPORT_OK = qw(perluino_run);
our @EXPORT = qw(perluino_run);



sub perluino_run {
    my $config = $Perluino::config;
    my ($pkg) = keys %{$config};
    $config = $config->{$pkg};
    
    my $app = sub {
        my $env = shift;
        my $path = $env->{'PATH_INFO'};
        ### $path;
        $path =~ s{^/}{};
        if (defined $config->{'pages'}->{$path}) {
            return [
                200,
                [
                    'content-type' => 'text/html;charset=utf-8',
                ],
                [
                    "哈哈"
                ],
            ];
        } else {
            return [
                404,
                [
                    'content-type' => 'text/plain',
                    'content-length' => 9
                ],
                [
                    "not found"
                ]
            ];
        }
    };
    
    my $runner = Plack::Runner->new;
    $runner->parse_options('--server', 'Starman', '--port', '3003');
    $runner->run($app);
}

1;
