#! /bin/sh
# hints/os2.sh
# This file reflects the tireless work of
# Ilya Zakharevich <ilya@math.ohio-state.edu>
#
# Trimmed and comments added by 
#     Andy Dougherty  <doughera@lafcol.lafayette.edu>
#     Exactly what is required beyond a standard OS/2 installation?
#     There are notes about "patched pdksh" I do not understand.

# Note that symbol extraction code gives wrong answers (sometimes?) on
# gethostent and setsid.

# Note that during the .obj compile you need to move the perl.dll file
# to LIBPATH :-(

bin_sh=`../UU/loc sh.exe /bin c:/bin d:/bin e:/bin f:/bin g:/bin h:/bin /bin`
echo "####### Shell found at $bin_sh #############" >&4

#osname="OS/2"
sysman=`../UU/loc . /man/man1 c:/man/man1 c:/usr/man/man1 d:/man/man1 d:/usr/man/man1 e:/man/man1 e:/usr/man/man1 f:/man/man1 f:/usr/man/man1 g:/man/man1 g:/usr/man/man1 /usr/man/man1`
cc='gcc'
usrinc='/emx/include'
libemx="`../UU/loc . X c:/emx/lib d:/emx/lib e:/emx/lib f:/emx/lib g:/emx/lib h:/emx/lib /emx/lib`"

if test "$libemx" = "X"; then echo "Cannot find C library!"; fi

libpth="$libemx/st $libemx"

so='dll'

# Additional definitions:

firstmakefile='GNUmakefile'
exe_ext='.exe'

# We provide it
i_dlfcn='define'

aout_d_shrplib='undef'
aout_obj_ext='.o'
aout_lib_ext='.a'
aout_ar='ar'
aout_plibext='.a'
aout_d_fork='define'
aout_lddlflags='-Zdll'
aout_ldflags='-Zexe'
aout_ccflags='-DDOSISH -DPERL_IS_AOUT -DOS2=2 -DEMBED -I. -DPACK_MALLOC -DDEBUGGING_MSTATS'
aout_cppflags='-DDOSISH -DPERL_IS_AOUT -DOS2=2 -DEMBED -I. -DPACK_MALLOC =DDEBUGGING_MSTATS'
aout_use_clib='c'
aout_usedl='undef'
aout_archobjs="os2.o dl_os2.o"

# variable which have different values for aout compile
used_aout='d_shrplib plibext lib_ext obj_ext ar plibext d_fork lddlflags ldflags ccflags use_clib usedl archobjs cppflags'

if [ "$emxaout" != "" ]; then
    d_shrplib="$aout_d_shrplib"
    obj_ext="$aout_obj_ext"
    lib_ext="$aout_lib_ext"
    ar="$aout_ar"
    plibext="$aout_plibext"
    d_fork="$aout_d_fork"
    lddlflags="$aout_lddlflags"
    ldflags="$aout_ldflags"
    ccflags="$aout_ccflags"
    cppflags="$aout_cppflags"
    use_clib="$aout_use_clib"
    usedl="$aout_usedl"
else
    d_shrplib='define'
    obj_ext='.obj'
    lib_ext='.lib'
    ar='emxomfar'
    plibext='.lib'
    d_fork='undef'
    lddlflags='-Zdll -Zomf -Zcrtdll'
    # Recursive regmatch may eat 2.5M of stack alone.
    ldflags='-Zexe -Zomf -Zcrtdll -Zstack 32000'
    ccflags='-Zomf -DDOSISH -DOS2=2 -DEMBED -I. -DPACK_MALLOC -DDEBUGGING_MSTATS'
    use_clib='c_import'
    usedl='define'
fi

# To get into config.sh (should start at the beginning of line)
# or you can put it into config.over.
plibext="$plibext"

#libc="/emx/lib/st/c_import$lib_ext"
libc="$libemx/st/$use_clib$lib_ext"

if test -r "$libemx/c_alias$lib_ext"; then 
    libnames="$libemx/c_alias$lib_ext"
fi
# otherwise puts -lc ???

# [Maybe we should just remove c from $libswanted ?]

libs='-lsocket -lm'
archobjs="os2$obj_ext dl_os2$obj_ext"

# Run files without extension with sh - feature of patched ksh
# [???]
# NOHASHBANG=sh
# Same with newer ksh
EXECSHELL=sh

cccdlflags='-Zdll'
dlsrc='dl_dlopen.xs'
ld='gcc'

#cppflags='-DDOSISH -DOS2=2 -DEMBED -I.'

# for speedup: (some patches to ungetc are also needed):
# Note that without this guy tests 8 and 10 of io/tell.t fail, with it 11 fails

stdstdunder=`echo "#include <stdio.h>" | cpp | egrep -c "char +\* +_ptr"`
d_stdstdio='define'
d_stdiobase='define'
d_stdio_ptr_lval='define'
d_stdio_cnt_lval='define'

if test "$stdstdunder" = 0; then
  stdio_ptr='((fp)->ptr)'
  stdio_cnt='((fp)->rcount)'
  stdio_base='((fp)->buffer)'
  stdio_bufsiz='((fp)->rcount + (fp)->ptr - (fp)->buffer)'
  ccflags="$ccflags -DMYTTYNAME"
  myttyname='define'
else
  stdio_ptr='((fp)->_ptr)'
  stdio_cnt='((fp)->_rcount)'
  stdio_base='((fp)->_buffer)'
  stdio_bufsiz='((fp)->_rcount + (fp)->_ptr - (fp)->_buffer)'
fi

# to put into config.sh
myttyname="$myttyname"

# To have manpages installed
nroff='nroff.cmd'
# above will be overwritten otherwise, indented to avoid config.sh
  _nroff='nroff.cmd'

ln='cp'
# Will be rewritten otherwise, indented to not put in config.sh
  _ln='cp'
lns='cp'

nm_opt='-p'

####### We define these functions ourselves

d_getprior='define'
d_setprior='define'

####### All the rest is commented

# The next two are commented. pdksh handles #!
# sharpbang='extproc '
# shsharp='false'

# Commented:
#startsh='extproc ksh\\n#! sh'
