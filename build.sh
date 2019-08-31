#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Please provide a version number."
	echo "$0 <SBT_VERSION> [latest] [push]"
	exit
fi

docker build -t llamos/sbt:$1 --build-arg SBT_VERSION=$1 .

if [ $# -gt 1 ]
then
	if [ $2 == "latest" ]
	then
		docker tag llamos/sbt:$1 llamos/sbt:latest
	fi
fi

if [ $# -gt 2 ]
then
	if [ $3 == "push" ]
	then
		docker push llamos/sbt:$1
		if [ $2 == "latest" ]
		then
			docker push llamos/sbt:latest
		fi
	fi
fi
