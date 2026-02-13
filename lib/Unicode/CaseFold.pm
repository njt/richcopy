package Unicode::CaseFold;

# Shim: delegates to Perl 5.16+'s built-in fc().
# Replaces the CPAN module which needs Unicode::UCD (absent from Git-for-Windows Perl).

use strict;
use warnings;
use 5.016;
use feature 'fc';

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT    = qw(fc);
our @EXPORT_OK = qw(case_fold fc);
our $VERSION   = '1.01';

sub case_fold { return CORE::fc($_[0]) }

# Re-export the builtin so callers that do "use Unicode::CaseFold 'fc'" get it.
# The builtin fc() already handles $_ defaulting and prototype, so we just
# install a wrapper in our namespace that Exporter can find.
BEGIN {
    no warnings 'once';
    *fc = sub (_) { CORE::fc($_[0]) };
}

1;
