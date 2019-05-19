#! /bin/bash

mkdir -p /usr/lib/fdb/multiversion
website=$1
shift
for version in $*; do
	origin=$website/downloads/$version/linux/libfdb_c_$version.so
	destination=/usr/lib/fdb/multiversion/libfdb_c_$version.so
	echo "Downloading $origin to $destination"
	curl $origin -o $destination
done