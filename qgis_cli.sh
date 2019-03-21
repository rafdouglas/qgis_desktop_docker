#!/bin/bash
#
#Enters a running 'rafdouglas/qgis_desktop' docker container presenting a bash command line
#Useful for issuing CLI commands, like gdal_grid, etc.
#
#RafDouglas C. Tommasi 2019
#released under GPL3

container_id=$(docker ps|grep 'rafdouglas/qgis_desktop'|head -1|awk '{print $1}')

if [ -z "$container_id" ]; then
	echo 'No container running rafdouglas/qgis_desktop was found. Exiting.'
	exit
fi

echo "Bashing into $container_id"
docker exec -it "$container_id" /bin/bash
