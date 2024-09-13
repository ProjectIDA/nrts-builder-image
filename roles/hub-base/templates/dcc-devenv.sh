# Determine development platform and compiler switches.

instll=""
socklibs=""
osname=`uname -s | tr "[A-Z]" "[a-z]"`
osver=`uname -r | sed 's/-RELEASE//'`
machine=`uname -m`
nodename=`uname -n`

if [ $osname = "sunos" ]
then

    osname=solaris
    machine =`arch`
    uname -p >& /dev/null
    if [ -d /opt/local/include/libxml2 ]
    then
        export XML2INCS=/opt/local/include/libxml2
        export XML2LIBS="-lxml2 -lm -lz"
    elif [ -e /opt/csw/include/libxml2 ]
    then
        export XML2INCS=/opt/csw/include/libxml2
        export XML2LIBS="-lxml2 -liconv -lm -lz"
    fi
    if [ $status .eq 0 ]
    then
        ostype=SVR4
        ranlib=echo
        instll=/usr/ucb/install
        @ SolarisVersion = `/usr/ucb/expr substr $osver 3 1`
        if [ $osver = 5.9 ]
        then
            curselib="-lcurses"
        else
            curselib="-lncurses"
        fi
        socklibs="-lsocket -lnsl"
        if [ $osver = 5.5.1 ]
        then
            export MTLIBS="-lpthread -lposix4"
        else
            export MTLIBS="-lpthread -lrt"
        fi
    else
        osname=sunos
        ostype=BSD
        curselib="-L/usr/gnu/lib -lcurses -ltermcap"
    fi

elif [ $osname = "darwin" ]
then

        osver_len=`expr $osver : '^[0-9]*\.[0-9]*'`
        osver=`expr ${osver:0:$osver_len}`
        ostype=SVR4

        ranlib=/usr/bin/ranlib
        instll=/usr/bin/install
        socklibs=""
        curselib="-lcurses"

        export POSIX4LIB=""

        export MTLIBS="-lpthread"

        if [ -d /usr/local/opt/libxml2/lib ]
        then # for homebrew install of libxml2 that doesn't get symlinked into /usr/local
            export XML2LIBS="/usr/local/opt/libxml2/lib/libxml2.a -lm -lz -liconv"
            export XML2INCS=/usr/local/opt/libxml2/include/libxml2
        elif [ -d /usr/local/include/libxml2 ]
        then
            export XML2LIBS="/usr/local/lib/libxml2.a -lm -lz"
            export XML2INCS=/usr/local/include/libxml2
        elif [ -d /usr/include/libxml2 ]
        then
            export XML2LIBS="-lxml2"
            export XML2INCS=/usr/include/libxml2
        fi

elif [ $osname = linux ]
then

        osver_len=`expr $osver : '[0-9]*\.[0-9]*'`
        osver=`expr substr $osver 1 $osver_len`
        ostype=SVR4
        if [ $machine = "i386" ]; then machine=i86pc; fi
        if [ $machine = "i486" ]; then machine=i86pc; fi
        if [ $machine = "i586" ]; then machine=i86pc; fi
        if [ $machine = "i686" ]; then machine=i86pc; fi

        ranlib=/usr/bin/ranlib
        instll=/usr/bin/install
        socklibs=""
        curselib="-lcurses"

        export POSIX4LIB=""

        export MTLIBS="-lpthread"
        if [ -d /usr/local/include/libxml2 ]
        then
            export XML2INCS=/usr/local/include/libxml2
            export XML2LIBS="/usr/local/lib/libxml2.a -lm -lz"
        elif [ -d /usr/include/libxml2 ]
        then
            export XML2INCS=/usr/include/libxml2
            export XML2LIBS="-lxml2"
        fi

else
    echo "ERROR: unsupported operating system.  Update devenv.sh file!"
fi

if [ $machine = i86pc ]
then
    order=LTL_ENDIAN_ORDER
else
    order=BIG_ENDIAN_ORDER
fi

target=$osname.$machine
export TARGET=$target

gnuinstall=/opt/gnu/bin/install
if [ -z $instll ] && [ -e $gnuinstall ]
then
    instll=$gnuinstall
fi

# BEGIN DFA comment out
# Don't know why neeed.. Can't find reference in src tree
#if (-d /opt/local) then
#    export LOCAL=/opt/local
#else
#    export LOCAL=/usr/local
#fi
# END

# set OPTDIR here...
export OPTDIR=/usr/local

# IDA development environment
export PLATFORM="$osname.$osver.$machine"
export MACHINE="$machine"
export SOCKLIBS="$socklibs"
export CURSELIB="$curselib"
export RANLIB="$ranlib"
export INSTALL="$instll"
export OSNAME=`echo $osname | tr "[a-z]" "[A-Z]"`
export OSTYPE="$ostype"
export OSVER=$osver
export NATIVE_ORDER="$order"
export DBIO_DATABASE=/usr/nrts
export Q330_CONSOLE=/dev/cuad0
export SQLLIBS="-ldbio"


if [ -d /home/cvs/ida ]
then
    export CVSROOT=/home/cvs/ida
    export CVSREAD=1
elif [ -d /ida/home/cvs/ida ]
then
    export CVSROOT=/ida/home/cvs/ida
    export CVSREAD=1
fi

export EDITOR=vim
export PRINTER=slip
export BLOCKSIZE=1024

compiler=gcc