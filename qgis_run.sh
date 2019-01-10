#xhost +
my_homedir=${HOME}
my_qgis_dir="$my_homedir/.qgis34-docker"

echo "my_homedir:$my_homedir"
mkdir -p "$my_qgis_dir"

cp -n -r data/qgis34-docker/.local $my_qgis_dir/

docker run -ti --rm \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $my_homedir:/mnt/ext_home/ \
	-v $my_qgis_dir:/root \
	rafdouglas/qgis_desktop:3.4



