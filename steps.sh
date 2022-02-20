#!/bin/bash -e
#set -o xtrace	
case $1 in
    dist)
	$0 clean build
	cd docs
	ln -s short.html index.html
	;;
    build)
	mkdir docs
	cv -cv ./gregory_vincic.yaml --max-skills 20 --max-projects 7 -s docs/short.html
	cv -cv ./gregory_vincic.yaml --template full -s docs/full.html	
	;;
    clean)
	rm -rf docs
	;;
    *)
	$0 build
	;;    
esac

# Run next target if any
shift
[[ -z "$@" ]] && exit 0
$0 $@
