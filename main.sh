a=1 
b=$(find . -type f \( -name "*.jpeg" -o -name "*.png" \) -not -name "._*" | grep "" -c)

while IFS= LC_ALL=C read -r -d '' -u 9 file
do
	printf "\n$(( a*100/b ))%% Currently at file $a/$b\n$file\n"
	a=$(($a+1))
	sips -s format heic "$file" --out "${file%.*}.heic" > /dev/null
	exiftool -overwrite_original -tagsFromFile "$file" -AllDates -FileModifyDate -FileCreateDate "${file%.*}.heic" > /dev/null
	trash $file
done 9< <( find . -type f \( -name "*.jpeg" -o -name "*.png" \) -not -name "._*" -print0 )
