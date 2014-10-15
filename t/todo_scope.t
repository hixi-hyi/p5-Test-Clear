use strict;
use warnings;
use Test::More;
use Test::Clear;

subtest 'todo scope' => sub {
    my $guard = todo_scope 'not yet implementated';
    fail;
};

done_testing;
