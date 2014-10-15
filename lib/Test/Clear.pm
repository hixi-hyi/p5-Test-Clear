package Test::Clear;
use 5.008005;
use strict;
use warnings;
use parent 'Exporter';
use Test::More;
use Test::Builder;
use Data::Dumper;
use Scope::Guard;

our $VERSION = "0.01";
our @EXPORT = qw(case todo_scope);

sub dumper {
    my $value = shift;
    if ( not defined $value ) {
        return 'undef';
    }
    if ( defined $value && ref($value) ) {
        local $Data::Dumper::Terse = 1;
        local $Data::Dumper::Indent = 0;
        local $Data::Dumper::Sortkeys = 1;
        return Data::Dumper::Dumper($value);
    }
    return $value;
}

sub case {
    my ($caption, $dataset, $testcode, $opts) = @_;
    $dataset = (ref $dataset eq 'CODE') ? $dataset->(): $dataset;
    $caption = embeded($caption, $dataset);
    my $tb = Test::More->builder;
    return $tb->subtest($caption, $testcode, $dataset);
}

sub embeded {
    my ($caption, $dataset) = @_;
    return
        join '',
        map {
            /^\{(.+?)\}$/
                ? dumper($dataset->{$1})
                : $_
        }
        grep { defined && length }
        split /(\{.+?\})/, $caption;
}

sub todo_scope {
    my ($reason) = @_;
    my $tb = Test::More->builder;
    $tb->todo_start($reason);
    Scope::Guard->new(sub { $tb->todo_end });
}

1;
__END__

=encoding utf-8

=head1 NAME

Test::Clear - Simply testing module

=head1 SYNOPSIS

    use Test::Clear;
    use MyModule;
    my $module = MyModule->new;

    case "basically name:{name}" => {
        name => 'hixi',
    }, sub {
        my $dataset = @_;
        my $ret = $module->get_person($dataset->{name});
        is $ret, xxxxx;
    };
    # Subtest: basically name:hixi
    # ok 1

    subtest 'optional test case' => sub {
        my $guard = todo_scope 'not yet implementated';
        fail;
    };

=head1 DESCRIPTION

Test::Clear is simply testing module.

=head1 METHODS

=head2

=head3

    case "basically name:{name}" => {
        name => 'hixi',
    }, sub {
        my $dataset = @_;
        my $ret = $module->get_person($dataset->{name});
        is $ret, xxxxx;
    };

=head3

   case 'basically uri:{uri}' => sub {
       my $schema    = 'http';
       my $authority = 'example.com';
       my $uri       = $schema. '://'. $authority;
       return {
           schema    => $schema,
           authority => $authority,
           uri       => $uri,
       }
   }, sub {
       my $dataset = shift;
       is $dataset->{schema}, 'http';
       is $dataset->{authority}, 'example.com';
       is $dataset->{uri}, 'http://example.com';
   };

=head1 LICENSE

Copyright (C) Hiroyoshi Houchi.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Hiroyoshi Houchi E<lt>git@hixi-hyi.comE<gt>

=cut

