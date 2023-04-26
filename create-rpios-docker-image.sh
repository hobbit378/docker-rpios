#!/bin/bash

# 1. extract RPiOS SDCard images from archive files
# 2. extract filesystem from image and export to Docker image
 
set -x

mkdir ./img-content

for ar in ./images/*.xz 
 do
    xz -d ${ar}
done

for img in ./images/*.img 
 do
    offset=$(fdisk -l -o Start ${img}|tail -1)
    echo "sector offset is ${offset} ..."
    mount -o loop,ro,offset=$((512 * ${offset})) ${img} ./img-content
    tar -xvc -C ./img-content | docker import -c "ENTRYPOINT /bin/bash" - $(basename ${img})
    #tar cvzf ${img}.tgz -C ./img-content .
    umount ./img-content
done

rm -rf ./img-content
