#!/usr/bin/env bash

function download() {
    local URL=$1
    local FILENAME=$2

    local CFG_REGEX='\/\/config\.playwire\.com\/\(\d*\)\/videos\/v2\/\(\d*\)\/'
    local NUM1_REGEX='s#.*com\/\([0-9]*\)\/.*#\1#p'
    local NUM2_REGEX='s#.*v2\/\([0-9]*\)\/#\1#p'

    CONTENT=`curl ${URL}`
    CFG_URL=`echo ${CONTENT} | grep -o ${CFG_REGEX}`
    # echo ${CFG_URL}
    
    NUM1=`echo ${CFG_URL} | sed -n ${NUM1_REGEX}`
    NUM2=`echo ${CFG_URL} | sed -n ${NUM2_REGEX}`
    
    wget https://cdn.video.playwire.com/${NUM1}/videos/${NUM2}/video-sd.mp4 -O ${FILENAME}
}

URL=$1
download ${URL} motd1.mp4
download ${URL}/2/ motd2.mp4