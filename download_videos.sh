#!/bin/bash

# download an ORB vocabulary from Google Drive
FILE_ID="1wUPb328th8bUqhOk-i8xllt5mgRW4n84"
curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -sLb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID}" -o orb_vocab.zip
unzip orb_vocab.zip

# download a sample dataset from Google Drive
FILE_ID="1d8kADKWBptEqTF7jEVhKatBEdN7g0ikY"
curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -sLb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID}" -o aist_living_lab_1.zip
unzip aist_living_lab_1.zip

# download a sample dataset from Google Drive
FILE_ID="1TVf2D2QvMZPHsFoTb7HNxbXclPoFMGLX"
curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -sLb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID}" -o aist_living_lab_2.zip
unzip aist_living_lab_2.zip

rm *.zip