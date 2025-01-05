#!/bin/bash

apt-get update
apt-get install -y build-essential git diffstat gawk chrpath wget texinfo unzip cvs subversion coreutils xz-utils git locales cpio file lz4 zstd

export DEBIAN_FRONTEND=noninteractive
ln -fs /usr/share/zoneinfo/UTC /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
apt-get install -y python3 python3-pip

git clone git://git.yoctoproject.org/poky.git
cd poky
git clone https://github.com/openembedded/meta-openembedded.git
mkdir build
source oe-init-build-env

# Check if the line is already present
if ! grep -Fxq 'MACHINE = "intel-galileo"' conf/local.conf
then
    # Add the line
    echo 'MACHINE = "intel-galileo"' | tee -a conf/local.conf > /dev/null
fi
# Check if the line is already present
if ! grep -Fxq 'BB_NO_ROOT_CHECK = "1"' conf/local.conf
then
    # Add the line
    echo 'BB_NO_ROOT_CHECK = "1"' | tee -a conf/local.conf > /dev/null
fi

# Check if the line is already present
if ! grep -Fxq 'BB_ENV_PASSTHROUGH_ADDITIONS += "BB_NO_ROOT_CHECK"' ../meta/conf/sanity.conf
then
    # Add the line
    echo 'BB_ENV_PASSTHROUGH_ADDITIONS += "BB_NO_ROOT_CHECK"' | tee -a ../meta/conf/sanity.conf > /dev/null
fi
# Check if the line is already present
if ! grep -Fxq 'ROOT_USER_CHECK = "0"' ../meta/conf/sanity.conf
then
    # Add the line
    echo 'ROOT_USER_CHECK = "0"' | tee -a ../meta/conf/sanity.conf > /dev/null
fi
# Check if the line is already present
if ! grep -Fxq 'ALLOW_ROOT = "1"' ../meta/conf/sanity.conf
then
    # Add the line
    echo 'ALLOW_ROOT = "1"' | tee -a ../meta/conf/sanity.conf > /dev/null
fi

locale-gen en_US.UTF-8

bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake core-image-minimal
