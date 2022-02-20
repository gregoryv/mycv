#!/bin/bash -e
#set -o xtrace	
case $1 in
    dist)
	$0 clean build
	cd public
	ln -s short.html index.html
	;;
    build)
	mkdir public
	cv -cv ./gregory_vincic.yaml --max-skills 20 --max-projects 7 -s public/short.html
	cv -cv ./gregory_vincic.yaml --template full -s public/full.html	
	;;
    clean)
	rm -rf public
	;;
    *)
	$0 build
	;;    
esac

# Run next target if any
shift
[[ -z "$@" ]] && exit 0
$0 $@
