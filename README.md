# openvslam_ros
Following the instructions and using the docker image included in this repo, you should be able to run the tracking and mapping algorithm of OpenVSLAM on a `ros-noetic-base` system. 
--- 
## On an EC2 machine with ROS
You might need to install docker on your EC2 machine.

The docker images that we are going to use are available [here](https://hub.docker.com/repository/registry-1.docker.io/debbieliang/ros_open/tags?page=1&ordering=last_updated). 

### On terminal A 
```
sudo docker pull debbieliang/ros_open:open_ros_topic_installed
sudo docker pull debbieliang/ros_open:open_ros_server
sudo docker run --network host --rm -it debbieliang/ros_open:open_ros_topic_installed
cd ../ros
source /openvslam/ros/devel/setup.bash
```

### On terminal B
```
sudo docker run --network host --rm -it debbieliang/ros_open:open_ros_topic_installed
cd ../ros
source /openvslam/ros/devel/setup.bash
```

### On terminal C
```
sudo docker run --network host --rm -it debbieliang/ros_open:open_ros_topic_installed
cd ../..
roscore
```

### On terminal D 
```
sudo docker run --network host --rm -it debbieliang/ros_open:open_ros_server
```
You should see 
```
WebSocket: listening on *:3000
HTTP server: listening on *:3001
```
Now we've finished the setup.
### (Tracking and Mapping)
### On terminal A
As a subscriber, run `rosrun openvslam run_slam -v /openvslam/build/orb_vocab/orb_vocab.dbow2 -c /openvslam/build/aist_living_lab_1/config.yaml --map-db map.msg`

### On terminal B
As a publisher, run `rosrun publisher video -m /openvslam/build/aist_living_lab_1/video.mp4`

You should be able to see 
```
[2021-02-28 18:49:15.924] [I] config file loaded: /openvslam/build/aist_living_lab_1/config.yaml
  ___               __   _____ _      _   __  __ 
 / _ \ _ __  ___ _ _\ \ / / __| |    /_\ |  \/  |
| (_) | '_ \/ -_) ' \\ V /\__ \ |__ / _ \| |\/| |
 \___/| .__/\___|_||_|\_/ |___/____/_/ \_\_|  |_|
      |_|                                        

Copyright (C) 2019,
National Institute of Advanced Industrial Science and Technology (AIST)
All rights reserved.

This is free software,
and you are welcome to redistribute it under certain conditions.
See the LICENSE file.

Camera Configuration:
- name: RICOH THETA S 960
- setup: Monocular
- fps: 30
- cols: 1920
- rows: 960
- color: RGB
- model: Equirectangular
ORB Configuration:
- number of keypoints: 2000
- scale factor: 1.2
- number of levels: 8
- initial fast threshold: 20
- minimum fast threshold: 7
- mask rectangles:
  - [0, 1, 0, 0.1]
  - [0, 1, 0.84, 1]
  - [0, 0.2, 0.7, 1]
  - [0.8, 1, 0.7, 1]

[2021-02-28 18:49:15.924] [I] loading ORB vocabulary: /openvslam/build/orb_vocab/orb_vocab.dbow2
[2021-02-28 18:49:16.396] [I] startup SLAM system
[2021-02-28 18:49:16.396] [I] start mapping module
[2021-02-28 18:49:16.396] [I] start global optimization module
[2021-02-28 18:49:16] [connect] Successful connection
[2021-02-28 18:49:16] [connect] WebSocket Connection 127.0.0.1:3000 v-2 "WebSocket++/0.8.1" /socket.io/?EIO=4&transport=websocket&t=1614538156 101
[2021-02-28 18:49:16.399] [I] connected to server
[2021-02-28 18:49:16.782] [I] initialization succeeded with E
[2021-02-28 18:49:16.815] [I] new map created with 113 points: frame 0 - frame 1
[2021-02-28 18:49:23.966] [I] tracking lost within 5 sec after initialization
[2021-02-28 18:49:23.969] [I] resetting system
[2021-02-28 18:49:23.969] [I] reset mapping module
[2021-02-28 18:49:23.975] [I] reset global optimization module
[2021-02-28 18:49:23.975] [I] clear BoW database
[2021-02-28 18:49:23.988] [I] clear map database
[2021-02-28 18:49:24.102] [I] initialization succeeded with E
[2021-02-28 18:49:24.138] [I] new map created with 187 points: frame 0 - frame 1
[2021-02-28 18:50:09.496] [I] detect loop: keyframe 28 - keyframe 131
[2021-02-28 18:50:09.500] [I] pause mapping module
[2021-02-28 18:50:09.919] [I] resume mapping module
[2021-02-28 18:50:09.919] [I] start loop bundle adjustment
[2021-02-28 18:50:11.378] [I] finish loop bundle adjustment
[2021-02-28 18:50:11.378] [I] updating the map with pose propagation
[2021-02-28 18:50:11.475] [I] pause mapping module
[2021-02-28 18:50:11.507] [I] resume mapping module
[2021-02-28 18:50:11.507] [I] updated the map
```
On terminal A. Wait for ~3 min for the algorithm to finish, use `Control + C` to terminate the process. A `map.msg` file should be saved in the `/openvslam/ros` directory. 

### (Localization)
### On terminal A
As a subscriber, run `rosrun openvslam run_localization -v /openvslam/build/orb_vocab/orb_vocab.dbow2 -c /openvslam/build/aist_living_lab_1/config.yaml --map-db map.msg`

### On terminal B
As a publisher, run `rosrun publisher video -m /openvslam/build/aist_living_lab_1/video.mp4`

You should be able to see 

```
[2021-02-28 19:02:15.821] [I] config file loaded: /openvslam/build/aist_living_lab_1/config.yaml
  ___               __   _____ _      _   __  __ 
 / _ \ _ __  ___ _ _\ \ / / __| |    /_\ |  \/  |
| (_) | '_ \/ -_) ' \\ V /\__ \ |__ / _ \| |\/| |
 \___/| .__/\___|_||_|\_/ |___/____/_/ \_\_|  |_|
      |_|                                        

Copyright (C) 2019,
National Institute of Advanced Industrial Science and Technology (AIST)
All rights reserved.

This is free software,
and you are welcome to redistribute it under certain conditions.
See the LICENSE file.

Camera Configuration:
- name: RICOH THETA S 960
- setup: Monocular
- fps: 30
- cols: 1920
- rows: 960
- color: RGB
- model: Equirectangular
ORB Configuration:
- number of keypoints: 2000
- scale factor: 1.2
- number of levels: 8
- initial fast threshold: 20
- minimum fast threshold: 7
- mask rectangles:
  - [0, 1, 0, 0.1]
  - [0, 1, 0.84, 1]
  - [0, 0.2, 0.7, 1]
  - [0.8, 1, 0.7, 1]

[2021-02-28 19:02:15.822] [I] loading ORB vocabulary: /openvslam/build/orb_vocab/orb_vocab.dbow2
[2021-02-28 19:02:16.307] [I] clear map database
[2021-02-28 19:02:16.308] [I] clear BoW database
[2021-02-28 19:02:16.308] [I] load the MessagePack file of database from map.msg
[2021-02-28 19:02:18.063] [I] decoding 1 camera(s) to load
[2021-02-28 19:02:18.063] [I] load the tracking camera "RICOH THETA S 960" from JSON
[2021-02-28 19:02:18.411] [I] decoding 146 keyframes to load
[2021-02-28 19:02:21.504] [I] decoding 9963 landmarks to load
[2021-02-28 19:02:21.520] [I] registering essential graph
[2021-02-28 19:02:21.987] [I] registering keyframe-landmark association
[2021-02-28 19:02:22.495] [I] updating covisibility graph
[2021-02-28 19:02:22.536] [I] updating landmark geometry
[2021-02-28 19:02:23.207] [I] startup SLAM system
[2021-02-28 19:02:23.209] [I] start mapping module
[2021-02-28 19:02:23.209] [I] start global optimization module
[2021-02-28 19:02:23.222] [I] pause mapping module
[2021-02-28 19:02:23] [connect] Successful connection
[2021-02-28 19:02:23] [connect] WebSocket Connection 127.0.0.1:3000 v-2 "WebSocket++/0.8.1" /socket.io/?EIO=4&transport=websocket&t=1614538943 101
[2021-02-28 19:02:23.268] [I] connected to server
[2021-02-28 19:02:23.804] [I] relocalization succeeded
[2021-02-28 19:02:31.424] [I] tracking lost: frame 740
[2021-02-28 19:02:31.508] [I] relocalization succeeded
```
On terminal A. Wait for ~3 min for the algorithm to finish, use `Control + C` to terminate the process. 



---
## On your local machine without ROS
### On terminal A 
```
git clone https://github.com/Debbieliang9/openvslam.git 
cd ~/openvslam
docker build -t openvslam-ros .
docker run --network host --rm -it openvslam-ros
```
The Dockerfile used here is a combination of [ros-base](https://github.com/osrf/docker_images/blob/df19ab7d5993d3b78a908362cdcd1479a8e78b35/ros/noetic/ubuntu/focal/ros-base/Dockerfile) and [openvslam-socket](https://github.com/xdspacelab/openvslam/blob/master/Dockerfile.socket).
Now you should be in the ~/openvslam/build file
```

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
(This is downloading the dataset from the [OpenVSLAM tutorial](https://openvslam.readthedocs.io/en/master/simple_tutorial.html#tl-dr))

### On terminal B
```
cd ~/openvslam/viewer
docker build -t openvslam-server .
docker run --rm -it --name openvslam-server -p 3001:3001 openvslam-server
```
You should see 
```
WebSocket: listening on *:3000
HTTP server: listening on *:3001
```
You can also run it with `docker run --network host --rm -it --name openvslam-server openvslam-server` and you don't have to do the work in terminal C. However, this might affect your visualization and your ability to terminate the program and save the map.

### On terminal C
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
to the `config.yaml` file. Note that this number can change while your container is running. If your worked connection does not work anymore, run the `docker inspect` command again and change the ymal file. 
You may need 
```
apt-get update
apt-get Install vim 
``` 
to install vim.

### On  your browser 
visit `http://localhost:3001/`

### On terminal A 
In the `~/openvslam/build` directory, run `./run_video_slam -v ./orb_vocab/orb_vocab.dbow2 -m ./aist_living_lab_1/video.mp4 -c ./aist_living_lab_1/config.yaml --frame-skip 3 --no-sleep --map-db map.msg`. 

You should be able to see the visualization on `http://localhost:3001/`. 
Click the [Terminate] button to close the viewer. You can find map.msg in the current directory of terminal A.
(The instructions above are for MacOS, if you would like to have linux instructions, please see the openvslam Docker tutorial as your
[Reference](https://openvslam.readthedocs.io/en/master/docker.html#instructions-for-socketviewer))


---
## On your local machine with ROS

[Reference](https://openvslam.readthedocs.io/en/master/ros_package.html) 
Finish all the steps in "On your local machine without ROS" except the last one on terminal A.
### On terminal D 
Started by `docker run --network host --rm -it open_ros`. 
```
cd ../..
roscore
```
### On terminal A 
Run 
```
apt-get install libboost-all-dev
```
```
apt update -y
apt install ros-${ROS_DISTRO}-image-transport
```
cd /openvslam/ros
```
git clone --branch ${ROS_DISTRO} --depth 1 https://github.com/ros-perception/vision_opencv.git
cp -r vision_opencv/cv_bridge src/
rm -rf vision_opencv
catkin_make \
-DBUILD_WITH_MARCH_NATIVE=ON \
-DUSE_PANGOLIN_VIEWER=OFF \
-DUSE_SOCKET_PUBLISHER=ON \
-DUSE_STACK_TRACE_LOGGER=ON \
-DBOW_FRAMEWORK=DBoW2
source /openvslam/ros/devel/setup.bash
```

### (Tracking and Mapping)

### On terminal E 
Repeat what terminal A just did.

### On terminal A 
For tracking and mapping, as a subscriber, run `rosrun openvslam run_slam -v /openvslam/build/orb_vocab/orb_vocab.dbow2 -c /openvslam/build/aist_living_lab_1/config.yaml --map-db map.msg` 

### On terminal E 
As a publisher, run `rosrun publisher video -m /openvslam/build/aist_living_lab_1/video.mp4 `

You should be able to see the visualization on `http://localhost:3001/`. 
Click the [Terminate] button to close the viewer. You can find map.msg in the current directory of terminal A.

### (Localization)

### On terminal A 
As a subscriber, run `rosrun openvslam run_localization -v /openvslam/build/orb_vocab/orb_vocab.dbow2 -c /openvslam/build/aist_living_lab_1/config.yaml --map-db map.msg` 

### On terminal E 
As a publisher, run `rosrun publisher video -m /openvslam/build/aist_living_lab_1/video.mp4 `

