xhost +
my_homedir=${HOME}
my_files_dir="$my_homedir/qgis-docker-files"
my_profile_dir="$my_homedir/.qgis-docker-profile"

echo "Files dir:$my_files_dir"
mkdir -p "$my_files_dir"

echo "Preferences dir:$my_profile_dir"
mkdir -p "$my_profile_dir"

#Copy profiles data only if not already in place.
cp -n -r data/qgis-docker/.local $my_profile_dir/

docker run -ti  --rm \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $my_homedir:/mnt/ext_home/ \
	-v $my_files_dir:/root/qgis-docker-files \
	-v $my_profile_dir:/root/ \
	rafdouglas/qgis_desktop:3.18

