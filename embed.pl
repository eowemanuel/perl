#!/usr/bin/perl

open(EM, ">embed.h") || die "Can't create embed.h: $!\n";

print EM <<'END';
/* !!!!!!!   DO NOT EDIT THIS FILE   !!!!!!! 
   This file is built by embed.pl from global.sym and interp.sym.
   Any changes made here will be lost 
*/

/* (Doing namespace management portably in C is really gross.) */

/*  EMBED has no run-time penalty, but helps keep the Perl namespace
    from colliding with that used by other libraries pulled in
    by extensions or by embedding perl.  Allow a cc -DNO_EMBED
    override, however, to keep binary compatability with previous
    versions of perl.
*/
#ifndef NO_EMBED
#  define EMBED 1 
#endif

#ifdef EMBED

/* globals we need to hide from the world */
END

open(GL, "<global.sym") || die "Can't open global.sym: $!\n";

while(<GL>) {
	s/[ \t]*#.*//;		# Delete comments.
	next unless /\S/;
	s/^\s*(\S+).*$/#define $1\t\tPerl_$1/;
	$global{$1} = 1; 
	s/(................\t)\t/$1/;
	print EM $_;
}

close(GL) || warn "Can't close global.sym: $!\n";

print EM <<'END';

#endif /* EMBED */

/* Put interpreter specific symbols into a struct? */

#ifdef MULTIPLICITY

END

open(INT, "<interp.sym") || die "Can't open interp.sym: $!\n";
while (<INT>) {
	s/[ \t]*#.*//;		# Delete comments.
	next unless /\S/;
	s/^\s*(\S+).*$/#define $1\t\t(curinterp->I$1)/;
	s/(................\t)\t/$1/;
	print EM $_;
}
close(INT) || warn "Can't close interp.sym: $!\n";

print EM <<'END';

#else	/* not multiple, so translate interpreter symbols the other way... */

END

open(INT, "<interp.sym") || die "Can't open interp.sym: $!\n";
while (<INT>) {
	s/[ \t]*#.*//;		# Delete comments.
	next unless /\S/;
	s/^\s*(\S+).*$/#define I$1\t\t$1/;
	s/(................\t)\t/$1/;
	print EM $_;
}
close(INT) || warn "Can't close interp.sym: $!\n";

print EM <<'END';

#ifdef EMBED

END

open(INT, "<interp.sym") || die "Can't open interp.sym: $!\n";
while (<INT>) {
	s/[ \t]*#.*//;		# Delete comments.
	next unless /\S/;
	s/^\s*(\S+).*$/#define $1\t\tPerl_$1/;
	s/(................\t)\t/$1/;
	print EM $_;
}
close(INT) || warn "Can't close interp.sym: $!\n";

print EM <<'END';

#endif /* EMBED */

#endif /* MULTIPLICITY */
END

