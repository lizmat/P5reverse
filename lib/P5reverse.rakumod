proto sub reverse(|) is export {*}
multi sub reverse() {
    die "Calling 'reverse' on caller's topic variable is no longer possible,
         please use '.&reverse' syntax instead".naive-word-wrapper;
}
multi sub reverse(List:D $l --> List:D) { $l.reverse.List }
multi sub reverse(Str() $s --> Str:D)   { $s.flip         }

# vim: expandtab shiftwidth=4
