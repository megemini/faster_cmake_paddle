#!/bin/bash

function patch(){
  echo 'patch ../CMakeLists.txt ../.gitmodules'
  sed -i "s/https\:\/\/github.com/https\:\/\/gitclone.com\/github.com/g" ../CMakeLists.txt ../.gitmodules
}

function restore(){
  echo 'restore ../CMakeLists.txt ../.gitmodules'
  sed -i "s/https\:\/\/gitclone.com\/github.com/https\:\/\/github.com/g" ../CMakeLists.txt ../.gitmodules
}

if [[ $1 == patch ]]; then
  patch

elif [[ $1 == restore ]]; then
  restore

elif [[ ( $1 == cmake || $1 == make ) || ( $1 == time && ( $2 == cmake || $2 == make )) ]]; then
  patch
  eval $*
  restore

else
  echo "Please use: patch, restore or cmake."

fi
