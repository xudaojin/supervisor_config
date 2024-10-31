#!/bin/env bash

# 操作系统版本号
codename=$(lsb_release -s -c)

# 根据操作系统版本号来决定使用的ROS版本
if [[ $codename == "focal" ]]; then
    source /opt/ros/noetic/setup.bash
elif [[ $codename == "bionic" ]]; then
    source /opt/ros/melodic/setup.bash
fi

# 如果安装了 awe，则加载环境变量
if [[ -d "/opt/awe/" ]]; then
    source /opt/awe/jingwei/setup.sh
fi

# 价值用户的终端环境变量
source /home/$hostname/.bashrc

# 启动supervisor
exec /home/huituo/.local/bin/supervisord -c /etc/supervisor/config.d/supervisord.conf
