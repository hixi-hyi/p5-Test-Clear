requires 'perl', '5.008001';
requires 'Exporter';
requires 'Scope::Guard';
requires 'Test::Simple', '1.001005';

on 'test' => sub {
    requires 'Test::Mock::Guard';
    requires 'Test::Tester';
};

