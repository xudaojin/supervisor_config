#!/bin/env bash

####################################### 
# 部署、更新 自动驾驶系统启动管理器配置文件  #
# #####################################

server_ip=192.168.0.10



service_dir=/home/$hostname/.config/systemd/user
service_list=()
# 检查 service 目录是否存在，不存在则创建
if [ ! -d $service_dir ];then 
    printf "make dir $service_dir"
    mkdir -p $service_dir; 
else
    # 如果目录存在，则获取 service 列表并关闭对于 service
    service_list=($(ls "$service_dir"))

    for service_name in "${service_list[@]}"; do
        printf "stop and disable $service_name"
        systemctl --user stop $service_name
        systemctl --user disable $service_name
    done
fi


# 拷贝 service 文件到指定目录
printf "deplot service file..."
cp -f ./service/multivisor.service $service_dir

printf "deploy config file to /etc/"
sudo cp -rf supervisor /etc/

printf "restart service..."
service_list=($(ls "$service_dir"))

for service_name in "${service_list[@]}"; do
    printf "enable and start $service_name"
    systemctl --user enable $service_name
    systemctl --user start $service_name
done

printf "done"