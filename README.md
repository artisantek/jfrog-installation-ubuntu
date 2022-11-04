# jfrog-installation-ubuntu


## Shell script to pull latest artifact

```#!/bin/bash

# Artifactory location
ip=$1
server=ip/artifactory
repo=maven

# Maven artifact location
name=MyWebApp
artifact=com/mkyong/$name
path=$server/$repo/$artifact
version=$(curl -s $path/maven-metadata.xml | grep latest | sed "s/.*<latest>\([^<]*\)<\/latest>.*/\1/")
build=$(curl -s $path/$version/maven-metadata.xml | grep '<value>' | head -1 | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/")
war=$name-$build.war
url=$path/$version/$war

# Download
echo $url
wget $url```
