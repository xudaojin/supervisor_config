#!/bin/env bash
source /opt/awe/jingwei/setup.sh
source /opt/ros/noetic/setup.bash
source /home/huituo/.bashrc

exec /home/huituo/.local/bin/supervisord -c /etc/supervisor/supervisord.conf
