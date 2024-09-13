# Determine development platform and compiler switches.

set install  = ""
set socklibs = ""
set osname   = `uname -s | tr "[A-Z]" "[a-z]"`
set osver    = `uname -r | sed 's/-RELEASE//'`
set machine  = `uname -m`
set nodename = `uname -n`

if ($osname == sunos) then

    set osname = solaris
    set machine  = `arch`
    uname -p >& /dev/null
    if (-d /opt/local/include/libxml2) then
        setenv XML2INCS /opt/local/include/libxml2
        setenv XML2LIBS "-lxml2 -lm -lz"
    else if (-e /opt/csw/include/libxml2) then
        setenv XML2INCS /opt/csw/include/libxml2
        setenv XML2LIBS "-lxml2 -liconv -lm -lz"
    endif
    if ($status == 0) then
        set ostype   = SVR4
        @ SolarisVersion = `/usr/ucb/expr substr $osver 3 1`
        set ranlib   = echo
        set install  = /usr/ucb/install
        if ($osver == 5.9) then
            set curselib = "-lcurses"
        else
            set curselib = "-lncurses"
        endif
        set socklibs = "-lsocket -lnsl"
        if ($osver == 5.5.1) then
            setenv MTLIBS "-lpthread -lposix4"
        else
            setenv MTLIBS "-lpthread -lrt"
        endif
    else
        set osname = sunos
        set ostype = BSD
        set curselib = "-L/usr/gnu/lib -lcurses -ltermcap"
    endif

else if ($osname == darwin) then

        set osver_len = `expr $osver : '[0-9]*\.[0-9]*'`
        set osver     = `echo $osver | cut -c 1-$osver_len`
        set ostype   = SVR4
        # $machine good as is from above

        set ranlib   = /usr/bin/ranlib
        set install  = /usr/bin/install
        set socklibs = ""
        set curselib = "-lcurses"

        setenv POSIX4LIB ""

        setenv MTLIBS "-lpthread"
        if (-d /usr/local/opt/libxml2/lib) then
            # for homebrew install of libxml2 that doesn't get symlinked into /usr/local
            setenv XML2LIBS "/usr/local/opt/libxml2/lib/libxml2.a -lm -lz -liconv"
            setenv XML2INCS /usr/local/opt/libxml2/include/libxml2
        else if (-d /usr/local/include/libxml2) then
            setenv XML2LIBS "/usr/local/lib/libxml2.a -lm -lz"
            setenv XML2INCS /usr/local/include/libxml2
        else if (-d /usr/include/libxml2) then
            setenv XML2LIBS "-lxml2"
            setenv XML2INCS /usr/include/libxml2
        endif

else if ($osname == linux) then

        set osver_len = `expr $osver : '[0-9]*\.[0-9]*'`
        set osver     = `expr substr $osver 1 $osver_len`
        set ostype   = SVR4
        if ($machine == i386) set machine = i86pc
        if ($machine == i486) set machine = i86pc
        if ($machine == i586) set machine = i86pc
        if ($machine == i686) set machine = i86pc

        set ranlib   = /usr/bin/ranlib
        set install  = /usr/bin/install
        set socklibs = ""
        set curselib = "-lcurses"

        setenv POSIX4LIB ""

        setenv MTLIBS "-lpthread"
        if (-d /usr/local/include/libxml2) then
            setenv XML2INCS /usr/local/include/libxml2
            setenv XML2LIBS "/usr/local/lib/libxml2.a -lm -lz"
        else if (-d /usr/include/libxml2) then
            setenv XML2INCS /usr/include/libxml2
            setenv XML2LIBS "-lxml2"
        endif

else if ($osname == openbsd || $osname == freebsd) then
        if ($machine == i386) set machine = i86pc
        if ($machine == i486) set machine = i86pc
        if ($machine == i586) set machine = i86pc
        if ($machine == i686) set machine = i86pc
        set ostype = BSD
        set ranlib   = /usr/bin/ranlib
        set install  = /usr/bin/install
        set curselib = "-lncurses"
        setenv MTLIBS "-lpthread"
        setenv XML2INCS /usr/local/include/libxml2
        setenv XML2LIBS "/usr/local/lib/libxml2.a -lm -lz -llzma"
        setenv XINCS "/usr/X11R6/include"
        setenv MANPATH `manpath`

else
    echo "ERROR: unsupported operating system.  Update devenv.cshrc file!"
endif

if ($machine == i86pc) then
    set order = LTL_ENDIAN_ORDER
else
    set order = BIG_ENDIAN_ORDER
endif

set target = $osname.$machine
setenv TARGET $target

set gnuinstall = /opt/gnu/bin/install
if ($install == "" && -e $gnuinstall) set install = $gnuinstall

# BEGIN DFA comment out
# Don't know why neeed.. Can't find reference in src tree
#if (-d /opt/local) then
#    setenv LOCAL /opt/local
#else
#    setenv LOCAL /usr/local
#endif
# END

# set OPTDIR here...
setenv OPTDIR /usr/local

set platform = $osname.$osver.$machine

# IDA development environment

setenv PLATFORM "$osname.$osver.$machine"
setenv MACHINE  "$machine"
setenv SOCKLIBS "$socklibs"
setenv CURSELIB "$curselib"
setenv RANLIB   "$ranlib"
setenv INSTALL  "$install"
setenv OSNAME   `echo $osname | tr "[a-z]" "[A-Z]"`
setenv OSTYPE   "$ostype"
setenv OSVER    "$osver"
setenv NATIVE_ORDER "$order"
setenv DBIO_DATABASE /usr/nrts
setenv Q330_CONSOLE /dev/cuad0
setenv SQLLIBS "-ldbio"

if (-d /home/cvs/ida) then
    setenv CVSROOT /home/cvs/ida
    setenv CVSREAD 1
else if (-d /ida/home/cvs/ida) then
    setenv CVSROOT /ida/home/cvs/ida
    setenv CVSREAD 1
endif

setenv EDITOR vim
setenv NRTS_HOME /usr/nrts

setenv PRINTER slip
setenv BLOCKSIZE 1024

set compiler = gcc
