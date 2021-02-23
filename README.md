# openvslam_ros

##On the first terminal (terminal A)##
```
git clone https://github.com/xdspacelab/openvslam.git 
cd ~/openvslam
docker build -t openvslam-ros .
docker run --rm -it --name openvslam-ros -p 3001:3001 openvslam-ros

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
```

##On the second terminal (terminal B)##
```
cd ~/openvslam/viewer
docker build -t openvslam-server .
```
You should see 
```
WebSocket: listening on *:3000
HTTP server: listening on *:3001
```
on terminal B

## On the third terminal (terminal C)##
```
docker inspect openvslam-server | grep -m 1 \"IPAddress\" | sed 's/ //g' | sed 's/,//g'
```
You should see terminal C returning an IPAdress. For example, if you see
```
"IPAddress": "172.17.0.2"
```
Please go to `~/openvslam/build/aist_living_lab_1` on terminal A and append 
```
SocketPublisher.server_uri: "http://172.17.0.2:3000"
```
to the `config.yaml` file.

On your browser, visit `http://localhost:3001/`
On terminal A, in the `~/openvslam/build` directory, run `./run_video_slam -v ./orb_vocab/orb_vocab.dbow2 -m ./aist_living_lab_1/video.mp4 -c ./aist_living_lab_1/config.yaml --frame-skip 3 --no-sleep --map-db map.msg`. You should be able to see the visualization on `http://localhost:3001/`. 
Click the [Terminate] button to close the viewer. You can find map.msg in the current directory of terminal A.

(The instructions above are for MacOS, if you would like to have linux instructions, please see the openvslam Docker tutorial as your
[Reference])(https://openvslam.readthedocs.io/en/master/docker.html#instructions-for-socketviewer)
