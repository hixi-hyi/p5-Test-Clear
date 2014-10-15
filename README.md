# NAME

Test::Clear - Simply testing module

# SYNOPSIS

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

# DESCRIPTION

Test::Clear is simply testing module.

# METHODS

## 

### 

    case "basically name:{name}" => {
        name => 'hixi',
    }, sub {
        my $dataset = @_;
        my $ret = $module->get_person($dataset->{name});
        is $ret, xxxxx;
    };

### 

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

# LICENSE

Copyright (C) Hiroyoshi Houchi.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Hiroyoshi Houchi <git@hixi-hyi.com>
