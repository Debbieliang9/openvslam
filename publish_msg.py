#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Author
-----
Mike Danielczuk, Vishal Satish, Jeff Mahler & Debbie Liang
"""
import json
import os
import time

import numpy as np
import rospy

import message_filters

from std_msgs.msg import ByteMultiArray

class OpenVSLAM_ros (object):
    def __init__(self, openvslam_publisher):
        """
        Parameters
        ----------
       openvslam_publisher: :obj:`Publisher`
            ROS publisher to publish the tracking and mapping result.
        """
        self.publisher = openvslam_publisher

    def publish_openvslam_msg(self, openvslam_msg):
        """Grasp planner subscriber handler.
        Parameters
        ---------
        openvslam_msg: map.msg
        the file generated by the tracking and mapping algorithm of openvslam
        """
        rospy.loginfo("Publish openvslam msg")

        # Conver to Publish.
        try:

            self.publisher.publish(openvslam_msg)

        except:
            rospy.logerr((
                "An error occurred in publishing openvslam_msg"
            ))


if __name__ == "__main__":
    # Initialize the ROS node.
    rospy.init_node("Publish_OpenVSLAM_Server")

    # Create publishers to publish pose and q value of final grasp.
    grasp_pose_publisher = rospy.Publisher("openvslam_msg",
                                           ByteMultiArray,
                                           queue_size=10)

    # Create a openvslam publisher.
    openVSLAM_ros = OpenVSLAM_ros(grasp_pose_publisher)

    rospy.loginfo("Publishing finished")

    # Spin forever.
    # rospy.spin()
