use v6.d;

unit module P5reverse:ver<0.0.8>:auth<zef:lizmat>;

proto sub reverse(|) is export {*}
multi sub reverse() { reverse CALLERS::<$_> }
multi sub reverse(List:D $l --> List:D) { $l.reverse.List }
multi sub reverse(Str() $s --> Str:D)   { $s.flip         }

=begin pod

=head1 NAME

Raku port of Perl's reverse() built-in

=head1 SYNOPSIS

  use P5reverse;

  say reverse "Foo";  # ooF

  with "Zippo" {
      say reverse();  # oppiZ, may need parens to avoid compilation error
  }

  say reverse 1,2,3;  # (3 2 1)

  with 1,2,3 {
      say reverse();  # (3 2 1), may need parens to avoid compilation error
  }

=head1 DESCRIPTION

This module tries to mimic the behaviour of Perl's C<reverse> built-in as
closely as possible in the Raku Programming Language.

=head1 ORIGINAL PERL 5 DOCUMENTATION

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

=head1 PORTING CAVEATS

=head2 Context does not define behaviour

Whereas in Perl the type of context determines how C<reverse> operates, in
this implementation it's the type of parameter that determines the semantics.
When given a C<List>, it will revert the order of the elements.  When given
something that can coerce to a C<Str>, it will return a string with the
characters reversed in order.

=head2 $_ no longer accessible from caller's scope

In future language versions of Raku, it will become impossible to access the
C<$_> variable of the caller's scope, because it will not have been marked as
a dynamic variable.  So please consider changing:

    reverse;

to either:

    reverse($_);

or, using the subroutine as a method syntax, with the prefix C<.> shortcut
to use that scope's C<$_> as the invocant:

    .&reverse;

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/P5reverse . Comments and
Pull Requests are wereverseome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018, 2019, 2020, 2021 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
