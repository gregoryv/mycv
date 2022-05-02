#!/bin/bash -e
#set -o xtrace	
case $1 in
    dist)
	cd docs
	ln -s short.html index.html
	;;
    build)
	mkdir -p docs
	cv -cv ./gregory_vincic.yaml -co ../../preferit/cv/preferit.yaml --max-skills 20 --max-projects 7 -s docs/short.html
	cv -cv ./gregory_vincic.yaml -co ../../preferit/cv/preferit.yaml -e -s docs/full.html	
	;;
    clean)
	rm -rf docs
	;;
    publish)
	rsync -av ./docs/ www.7de.se:/var/www/www.7de.se/cv
	;;
    *)
	$0 build
	;;    
esac

# Run next target if any
shift
[[ -z "$@" ]] && exit 0
$0 $@
