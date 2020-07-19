#!/usr/bin/env bash

CDIR="$(cd "$(dirname "$0")" && pwd)"
build_dir=$CDIR/build

while getopts A:K:q option
do
  case "${option}"
  in
    q) QUIET=1;;
    A) ARCH=${OPTARG};;
    K) KERNEL=${OPTARG};;
  esac
done

rm -rf $build_dir
mkdir -p $build_dir

for f in pluginrc.zsh
do
    cp $CDIR/$f $build_dir/
done

cd $build_dir

[ $QUIET ] && arg_q='-q' || arg_q=''
[ $QUIET ] && arg_s='-s' || arg_s=''
[ $QUIET ] && arg_progress='' || arg_progress='--show-progress'

opt=$build_dir/opt
mkdir -p $opt
cd $opt
urls='https://github.com/zsh-users/zsh-autosuggestions.git https://github.com/zsh-users/zsh-syntax-highlighting https://github.com/molovo/crash'

for url in $urls; do
	git clone $arg_q --depth=1 $url
done
curl -L git.io/antigen > $opt/antigen.zsh
curl -L "https://gist.githubusercontent.com/pwnpanda/6acc65b062975f8dc3a95aa27318f817/raw/399b14ec50ccc48776dbf79936413d8615853e12/.zshrc_remote" > $build_dir/.zshrc_remote
curl -L "https://gist.githubusercontent.com/pwnpanda/b68e4a86aba8185d0ad8aca00b3bf8d4/raw/9558dae85b3c32b1b3099da6b3603c2156cca35c/.p10k.zsh" > $build_dir/.p10k.zsh

# Install fonts
#mkdir -p /usr/share/fonts/truetype/FiraCode
#cp Fira*.ttf /usr/share/fonts/truetype/FiraCode
#mkdir -p /usr/share/fonts/truetype/MesloLGS
#cp Meslo*.ttf /usr/share/fonts/truetype/MesloLGS
#fc-cache -f -v

#portable_url='https://,,,/.tar.gz'
#tarname=`basename $portable_url`
#
#cd $build_dir
#
#[ $QUIET ] && arg_q='-q' || arg_q=''
#[ $QUIET ] && arg_s='-s' || arg_s=''
#[ $QUIET ] && arg_progress='' || arg_progress='--show-progress'
#
#if [ -x "$(command -v wget)" ]; then
#  wget $arg_q $arg_progress $portable_url -O $tarname
#elif [ -x "$(command -v curl)" ]; then
#  curl $arg_s -L $portable_url -o $tarname
#else
#  echo Install wget or curl
#fi
#
#tar -xzf $tarname
#rm $tarname
