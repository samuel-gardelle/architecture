#!/bin/sh

mkdir -p build/

./macro.awk "$1" > build/"$1.src"

if [ "$?" -ne "0" ] ; then
	printf "An error occured during macro translation\n"
	exit 1
fi

./transpiler.awk build/"$1.src" > build/"$1.img"

if [ "$?" -ne "0" ] ; then
	printf "An error occured during transpilation\n"
	exit 1
fi



/bin/sed -e '/v2.0 raw/d' -e '/^[[:space:]]*$/d' -e "s/ //g" "build/$1.img" | /usr/bin/xxd -r -p > "build/$1.bin"
