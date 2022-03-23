#QGIS 3.18 on Ubuntu 18.04
# Pull base image.
FROM ubuntu:20.04

LABEL maintainer="RafDouglas C. Tommasi<https://github.com/rafdouglas>"

LABEL org.label-schema.schema-version = "1.0"
LABEL org.label-schema.version = "QGIS_3.20"
LABEL org.label-schema.description = "QGIS 3.20.x docker"

LABEL org.label-schema.url="http://rafdouglas.science"
LABEL org.label-schema.vcs-url = "https://github.com/rafdouglas"
LABEL org.label-schema.docker.cmd = "sh ./qgis_run.sh"


# Install the bases and upgrade the system
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  export DEBIAN_FRONTEND=noninteractive && \
  export DEBIAN_FRONTEND="noninteractive" TZ="Europe/Rome" && apt-get install -y tzdata && \
  export DEBIAN_FRONTEND="noninteractive" && apt-get install -y keyboard-configuration && \
  apt-get install -y build-essential gnupg && \
  apt-get install -y software-properties-common && \
  rm -rf /var/lib/apt/lists/*

#Install preliminary files
RUN \
  apt-get update && \
  #export DEBIAN_FRONTEND=noninteractive && \
  #DEBIAN_FRONTEND="noninteractive" TZ="Europe/Rome" apt-get install -y tzdata && \
  #apt-get install -y tzdata && \
  #/bin/ln -sf /usr/share/zoneinfo/Etc/Zulu  /etc/localtime && \
  #dpkg-reconfigure --frontend noninteractive tzdata && \
  apt-get -y install ca-certificates apt-utils wget && \
  wget -qO - https://qgis.org/downloads/qgis-2021.gpg.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg --import && \
  chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg && \
  wget --no-check-certificate -O - https://qgis.org/downloads/qgis-2021.gpg.key | gpg --batch --yes --import && \
  gpg --yes --batch --fingerprint 46B5721DBBD2996A && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-key 51F523511C7028C3

#Install pdal and LASzip

RUN \
  apt-get -y install cmake++ python3 python3-pip git gdal-bin libgdal-dev python3-gdal && \
  pip3 install ninja

# LASzip
RUN cd / && git clone --depth 1 https://github.com/LASzip/LASzip.git
RUN cd /LASzip && mkdir build && cd build && cmake -G Ninja ../ && ninja && ninja install && cd /

# pdal
RUN cd / && git clone --depth 1 --branch 2.3.0 https://github.com/pdal/pdal.git
RUN cd /pdal && mkdir build && cd build && cmake -G Ninja ../ -DBUILD_PLUGIN_PCL=ON -DBUILD_PLUGIN_P2G=ON -DBUILD_PLUGIN_PYTHON=ON -DPDAL_HAVE_GEOS=YES -WITH_LASZIP:BOOL=ON && ninja && ninja install && cd /

#Install the actual QGIS package, than perform cleanup
RUN \
  add-apt-repository -s 'deb https://qgis.org/ubuntu/ focal main' 
RUN \
  apt-get update && \
  apt-get install -y  python3-pyqt5.qtxmlpatterns && \
  apt-get install -y  python3-qgis qgis qgis-plugin-grass 
RUN \
#  apt-get remove -y --purge qt4-linguist-tools libqt4-dev-bin gfortran-5 && \
  apt-get remove -y --purge qt4-qmake cmake-data && \
  apt-get remove -y --purge libqt4* libgtk* libsane *gnome* libsane *pango* glib* *gphoto* && \ 
  apt-get remove -y --purge build-essential gnupg software-properties-common apt-utils wget && \
  apt-get clean

#Create directories to be used 
RUN \
  mkdir -p /root/ && \
  mkdir -p /root/qgis-docker-files 

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["qgis"]
