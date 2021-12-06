#!/bin/bash

##################
#STARTING MASSCAN#
##################

echo -e "Run as sudo...\n *This script is suitable for mid - large size external scopes* \n"
echo "Enter file path to externalscope.txt file (exclude the trailing /): "
echo "Ex: /home/user/Desktop/pentest/client/external/scope"
read path

echo -e "\nEnter in name of external scope file: "
echo "Ex: externalscope.txt"
read scope

masscan -p1-65535,U:1-65535 -iL $path/$scope --rate=1000
