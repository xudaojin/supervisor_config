#!/bin/bash

# 注册公共变量
hostname=$(cat /etc/hostname)

process_name=$1

case $process_name in
    # 启动 rosmaster
    roscore)
        roscore
        ;;

    # 启动传感器驱动 awe
    awe)
        awe run --killall
        awe run -a
        ;;

    # 启动底盘驱动
    chassis)
        rosrun can can
        ;;
    # 启动 tf
    tf)
        roslaunch perception_front2 kuangka.launch
        ;;

    # 启动前向感知
    perception_front)
        roslaunch perception_front2 front.launch
        ;;

    # 启动后向感知
    perception_back)
        roslaunch perception_back2 back.launch
        ;;

    # 启动感知安全检测
    perception_security)
        roslaunch perception_front2 security.launch
        ;;

    # 启动预测模块
    trajectory_prediction)
        roslaunch trajectory_prediction trajectory_prediction_XGI110.launch
        ;;

    trajectory_gen_and_eva)
        roslaunch trajectory_prediction local_trajectory.launch
        ;;

    # 启动规划模块
    planner)
        roslaunch planner planner.launch
        ;;

    # 启动决策
    decision)
        roslaunch decision decision.launch
        ;;

    # 启动控制器
    controller)
        roslaunch truck_unmanned_controller motion_control.launch
        ;;

    # 启动安全模块
    secure)
        rosrun secure secure_node "${hostname}"
        ;;

    # 启动紧急停车模块
    estop)
        /usr/local/bin/es_stop/es_run.sh
        ;;

    # 启动远程遥控驾驶模块
    remote_driving)
        /usr/local/bin/remote_driving/run.sh
        ;;

    # 启动健康监测模块
    health_monitor)
        rosrun health_monitor health_monitor JIANGTONG "$hostname" "$hostname" 192.168.1.8 8080
        ;;

    # 启动rosbeacon
    rosbeacon)
        rosrun ros_jiqun rosbeacon
        ;;

    # 启动fm
    fm)
        /usr/local/bin/ht-crun fm
        ;;

    # 启动fleet_truck
    fleet_truck)
        /usr/local/bin/fleet-truck.sh
        ;;

    # 启动rviz
    rviz)
        rviz -d /opt/ros/noetic/share/perception_front2/rviz/perception.rviz
        ;;
    *)
        echo "No process name"


esac
