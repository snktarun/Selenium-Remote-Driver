package Selenium::Firefox;
$Selenium::Firefox::VERSION = '0.2551';
# ABSTRACT: Use FirefoxDriver without a Selenium server
use Moo;
use Selenium::CanStartBinary::FindBinary qw/coerce_firefox_binary/;
extends 'Selenium::Remote::Driver';


has '+browser_name' => (
    is => 'ro',
    default => sub { 'firefox' }
);


has 'binary' => (
    is => 'lazy',
    coerce => \&coerce_firefox_binary,
    default => sub { 'firefox' },
    predicate => 1
);


has 'binary_port' => (
    is => 'lazy',
    default => sub { 9090 }
);

has '_binary_args' => (
    is => 'lazy',
    builder => sub {
        my ($self) = @_;

        return ' -no-remote';
    }
);

with 'Selenium::CanStartBinary';

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Selenium::Firefox - Use FirefoxDriver without a Selenium server

=head1 VERSION

version 0.2551

=head1 SYNOPSIS

    my $driver = Selenium::Firefox->new;

=head1 DESCRIPTION

This class allows you to use the FirefoxDriver without needing the JRE
or a selenium server running. When you refrain from passing the
C<remote_server_addr> and C<port> arguments, we will search for the
Firefox executable in your $PATH. We'll try to start the binary
connect to it, shutting it down at the end of the test.

If the Firefox application is not found in the expected places, we'll
fall back to the default L<Selenium::Remote::Driver> behavior of
assuming defaults of 127.0.0.1:4444 after waiting a few seconds.

If you specify a remote server address, or a port, we'll assume you
know what you're doing and take no additional behavior.

If you're curious whether your Selenium::Firefox instance is using a
separate Firefox binary, or through the selenium server, you can check
the C<binary_mode> attr after instantiation.

=head1 ATTRIBUTES

=head2 binary

Optional: specify the path to your binary. If you don't specify
anything, we'll try to find it on our own in the default installation
paths for Firefox. If your Firefox is elsewhere, we probably won't be
able to find it, so you may be well served by specifying it yourself.

=head2 binary_port

Optional: specify the port that we should bind to. If you don't
specify anything, we'll default to the driver's default port. Since
there's no a priori guarantee that this will be an open port, this is
_not_ necessarily the port that we end up using - if the port here is
already bound, we'll search above it until we find an open one.

See L<Selenium::CanStartBinary/port> for more details, and
L<Selenium::Remote::Driver/port> after instantiation to see what the
actual port turned out to be.

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Selenium::Remote::Driver|Selenium::Remote::Driver>

=back

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/gempesaw/Selenium-Remote-Driver/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHORS

=over 4

=item *

Aditya Ivaturi <ivaturi@gmail.com>

=item *

Daniel Gempesaw <gempesaw@gmail.com>

=item *

Emmanuel Peroumalnaïk

=item *

Luke Closs <cpan@5thplane.com>

=item *

Mark Stosberg <mark@stosberg.com>

=back

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2010-2011 Aditya Ivaturi, Gordon Child

Copyright (c) 2014 Daniel Gempesaw

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=cut
