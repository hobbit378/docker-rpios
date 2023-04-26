#!/bin/bash

# 1. extract RPiOS SDCard images from archive files
# 2. extract filesystem from image and export to Docker image

# We need SUDO/ROOT privileges to run
 
set -x

function get_images()
{
    mkdir -p ./images/{content,processed}
    
    cd ./images
    echo "Download images, if any"
    
    # download images
    for img in $*
    do
        wget ${img}
    done
    
    # decompress images
    for img in ./*.xz 
    do
        xz -d ${img}
    done

    cd -
}



function make_docker_image() {

    for img in ./images/*.img 
    do
        arch=$(echo ${img}|cut -d- -f6)
        offset=$(fdisk -l -o Start ${img}|tail -1)
        echo "sector offset is ${offset} ..."
        mount -o loop,ro,offset=$((512 * ${offset})) ${img} ./images/content
        tar -cv -C ./images/content . | docker import --platform "linux/${arch}" -c "ENTRYPOINT /bin/bash" - $(basename ${img})
        umount ${img}
        mv ${img} ./images/processed
    done

}


