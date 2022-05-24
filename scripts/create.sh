cp --parent $(
	sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' wishlist |
		while read bin;do
			ldd $(which $bin)|grep -oP '/lib\S*'
		done |sort|uniq
) -t fake_root
sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' wishlist |
	while read bin;do
		cp --parent $(which $bin|sed 's/\/usr//g') ./fake_root
	done
