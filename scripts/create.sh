wishlist=$(sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' wishlist )

cp --parent $(
	echo $wishlist|sed 's/ /\n/g'|
		while read bin;do
			ldd $(which $bin)|grep -oP '/lib\S*'
		done |sort|uniq
) -t fake_root
echo $wishlist|sed 's/ /\n/g'|
	while read bin;do
		cp --parent $(which $bin|sed 's/\/usr//g') ./fake_root
	done
