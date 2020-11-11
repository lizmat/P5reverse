NAME
====

Raku port of Perl's reverse() built-in

SYNOPSIS
========

    use P5reverse;

    say reverse "Foo";  # ooF

    with "Zippo" {
        say reverse();  # oppiZ, may need parens to avoid compilation error
    }

    say reverse 1,2,3;  # (3 2 1)

    with 1,2,3 {
        say reverse();  # (3 2 1), may need parens to avoid compilation error
    }

DESCRIPTION
===========

This module tries to mimic the behaviour of Perl's `reverse` built-in as closely as possible in the Raku Programming Language.

ORIGINAL PERL 5 DOCUMENTATION
=============================

    reverse LIST
            In list context, returns a list value consisting of the elements
            of LIST in the opposite order. In scalar context, concatenates the
            elements of LIST and returns a string value with all characters in
            the opposite order.

                print join(", ", reverse "world", "Hello"); # Hello, world

                print scalar reverse "dlrow ,", "olleH";    # Hello, world

            Used without arguments in scalar context, reverse() reverses $_.

                $_ = "dlrow ,olleH";
                print reverse;                         # No output, list context
                print scalar reverse;                  # Hello, world

            Note that reversing an array to itself (as in "@a = reverse @a")
            will preserve non-existent elements whenever possible; i.e., for
            non-magical arrays or for tied arrays with "EXISTS" and "DELETE"
            methods.

            This operator is also handy for inverting a hash, although there
            are some caveats. If a value is duplicated in the original hash,
            only one of those can be represented as a key in the inverted
            hash. Also, this has to unwind one hash and build a whole new one,
            which may take some time on a large hash, such as from a DBM file.

                %by_name = reverse %by_address;  # Invert the hash

PORTING CAVEATS
===============

Context does not define behaviour
---------------------------------

Whereas in Perl the type of context determines how `reverse` operates, in this implementation it's the type of parameter that determines the semantics. When given a `List`, it will revert the order of the elements. When given something that can coerce to a `Str`, it will return a string with the characters reversed in order.

$_ no longer accessible from caller's scope
-------------------------------------------

In future language versions of Raku, it will become impossible to access the `$_` variable of the caller's scope, because it will not have been marked as a dynamic variable. So please consider changing:

    reverse;

to either:

    reverse($_);

or, using the subroutine as a method syntax, with the prefix `.` shortcut to use that scope's `$_` as the invocant:

    .&reverse;

AUTHOR
======

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/P5reverse . Comments and Pull Requests are wereverseome.

COPYRIGHT AND LICENSE
=====================

Copyright 2018-2020 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

