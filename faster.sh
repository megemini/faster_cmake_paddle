#!/bin/bash

GIT_RAW_URL='https\:\/\/github\.com'
GIT_CLONE_URL='https\:\/\/gitclone\.com\/github\.com'

GIT_URL_VAR='\$\{GIT_URL\}'
GIT_PACKAGE_URL=${GIT_URL_VAR}'(.*(archive|download))'
GIT_DOWN_URL_0='https\:\/\/gh\.api\.99988866\.xyz\/https\:\/\/github\.com'
GIT_DOWN_URL_1=${GIT_DOWN_URL_0}'(.*(archive|download))'


function patch(){
  echo 'patch: ../CMakeLists.txt ../.gitmodules'
  sed -i "s/"${GIT_RAW_URL}"/"${GIT_CLONE_URL}"/g" ../CMakeLists.txt ../.gitmodules

  cd ../cmake/external
  dir=$( ls -l ./ | awk '!/^d/ {print $NF}' | grep -i cmake$ )
  for i in $dir
  do
    echo 'patch: ../cmake/external/'$i
    perl -pi -e "s/"${GIT_PACKAGE_URL}"/"${GIT_DOWN_URL_0}"\1/g" $i
  done
  cd ../../build
}

function restore(){
  echo 'restore ../CMakeLists.txt ../.gitmodules'
  sed -i "s/"${GIT_CLONE_URL}"/"${GIT_RAW_URL}"/g" ../CMakeLists.txt ../.gitmodules

  cd ../cmake/external
  dir=$( ls -l ./ | awk '!/^d/ {print $NF}' | grep -i cmake$ )
  for i in $dir
  do
    echo 'restore: ../cmake/external/'$i
    perl -pi -e "s/"${GIT_DOWN_URL_1}"/"${GIT_URL_VAR}"\1/g" $i
  done
  cd ../../build
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
