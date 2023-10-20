#!/bin/bash

function patch(){
  echo 'patch: ../CMakeLists.txt ../.gitmodules'
  sed -i "s/https\:\/\/github\.com/https\:\/\/gitclone\.com\/github\.com/g" ../CMakeLists.txt ../.gitmodules

  cd ../cmake/external
  dir=$( ls -l ./ | awk '!/^d/ {print $NF}' | grep -i cmake$ )
  for i in $dir
  do
    echo 'patch: ../cmake/external/'$i

    sed -i 's/"${GIT_URL}\(.*archive.*\)"/"https\:\/\/gh\.api\.99988866\.xyz\/https\:\/\/github\.com\1"/g' $i
    sed -i 's/"${GIT_URL}\(.*download.*\)"/"https\:\/\/gh\.api\.99988866\.xyz\/https\:\/\/github\.com\1"/g' $i

  done

}

function restore(){
  echo 'restore ../CMakeLists.txt ../.gitmodules'
  sed -i "s/https\:\/\/gitclone\.com\/github\.com/https\:\/\/github\.com/g" ../CMakeLists.txt ../.gitmodules

  cd ../cmake/external
  dir=$( ls -l ./ | awk '!/^d/ {print $NF}' | grep -i cmake$ )
  for i in $dir
  do
    echo 'restore: ../cmake/external/'$i

    sed -i 's/"https\:\/\/gh\.api\.99988866\.xyz\/https\:\/\/github\.com\(.*\)"/"${GIT_URL}\1"/g' $i

  done

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
