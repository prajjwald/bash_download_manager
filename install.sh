#!/bin/bash

me=`whoami`
if [ "$me" != "root" ]
then
	echo "It seems that you are not running this program as root"
	echo "Run this script to install the program as root only"
	echo "For ordinary user installations (or if you are unable to get this working), please view the README file for manual installation"
	exit 1
fi

echo "Did you read the README file?"
answer="huh"
while [ "$answer" != "Yes" ] && [ "$answer" != "No" ]
do
	echo "Please type either 'Yes' or 'No'"
	read answer
done
if [ "$answer" == "Yes" ]
then
	cp downloads /usr/local/bin && echo "Installation complete"
else
	echo "Please read the README first"
fi
