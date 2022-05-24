# parse the wishlist by removing all empty lines and lines, that begin with a '#' sign and writing the results in a variable
wishlist=$(sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' wishlist )

# we want to copy all libraries, so the binaries can run
# with the '--parent' flag the directories for the libraries are created as needed
cp --parent $(
	# the wishlist variable contains all binaries, if we echo it out, the list is separated with spaces, we need to turn those spaces into newlines
	echo $wishlist|sed 's/ /\n/g'|
		while read bin;do
			# from the ldd output find the name and path of the libraries
			ldd $(which $bin)|grep -oP '/lib\S*'
		# the output is freed from duplicates
		done |sort|uniq
# copy it all to the fake_root
) -t fake_root

# now we copy the actual binaries
# the structure is simpler, because we do not look for duplicates
echo $wishlist|sed 's/ /\n/g'|
	while read bin;do
		cp --parent $(which $bin|sed 's/\/usr//g') ./fake_root
	done
