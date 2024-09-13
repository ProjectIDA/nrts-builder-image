#!/bin/csh

# can set alias to use as function
#   alias source <this filename>

set apath = $1

if !($apath == "") then

	if $2 == "force" then
	    set path = ($1 $path)
    else if $2 == "forceafter" then
	    set path = ($path $1)
    else
	    set found = no
	    foreach p ($path)
	    	if ($apath == $p) set found = yes
	    	# if ($apath == $p) && set found = yes
	    end

	    if $found == "no" then
	    	if $2 == "after" then
	    		set path = ($path $1)
	    	else
	    		set path = ($1 $path)
	    	endif
	    endif
	endif

endif
