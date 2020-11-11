use v6.*;
use Test;
use P5reverse;

plan 6;

ok defined(::('&reverse')),           'is &reverse imported?';
ok !defined(P5reverse::{'&reverse'}), 'is &reverse externally NOT accessible?';

is reverse('Foo'),     'ooF', 'did we get a good ooF';
is reverse((1,2,3)), '3 2 1', 'did we get a good 3 2 1';

with "Bar" { is .&reverse,   'raB', 'did we get a good implicit raB'   }
with 1,2,3 { is .&reverse, '3 2 1', 'did we get a good implicit 3 2 1' }

# vim: expandtab shiftwidth=4
