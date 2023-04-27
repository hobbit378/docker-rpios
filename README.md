# docker-rpios

Script function library to create Docker(R) armhf/arm64/... images from official Raspbian OS images.

Steps:
1. Source 'create-rpios-docker-image.sh' script in shell with root privileges
2. call 'get_images' with  download URL as parameter(s), links can be obtained from https://www.raspberrypi.com/software/operating-systems/

   e.g.   get_images "https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2023-02-22/2023-02-21-raspios-bullseye-armhf-lite.img.xz"

3. call 'make_docker_image'
4. compiled Docker(R) image(s) can be shown via 'docker images'


DISCLAIMER
USE COMPLETELY AT YOUR OWN RISK. NO LEGAL LIABILITY WHATSOEVER

