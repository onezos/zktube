#!/bin/bash

function print_tips
{
    echo "********************************************"
    echo "(1) 安装docker和docker-compose"
    echo "(2) 安装单节点zktube"
    echo "(3) 复制单节点zktube，多开节点"
    echo "(4) 重启zktube节点"
    echo "(5) 停止并删除zktube节点"
    echo "(Q/q) 退出"
    echo "********************************************"
}

#安装docker
function docker_install
{
    wget https://download.swarmeth.org/swarm/centos/docker.sh && chmod a+x docker.sh && ./docker.sh
}

#新建zkt存储文件夹
function zkt_init
{
    rm -rf /zktdata
    cd / && mkdir zktdata && mkdir zktdata/zkt1
    cd /zktdata/zkt1
    echo "请输入您的ETH钱包地址"
    read eth
    echo ${eth} >>/zktdata/zkt1/.revenue_address
}


function zkt_start
{
    wget https://file.zktube.io/docker/prover/docker-compose.yml
    sed -i 's#~/.revenue_address#/zktdata/zkt1/.revenue_address#g' /zktdata/zkt1/docker-compose.yml
    #启动
    docker-compose up -d
    #查看日志
    echo '========================================================='
    echo '查看进程：docker ps'
    echo '存放目录：/zktdata/zkt1'
    echo '查看日志：docker logs -f zkt1_zktube-prover_1'
    echo '============================================== Aven7 ====' 
}

function zkt_loop
{
    echo "请输入要搭建的zkt节点数量"
    read tCnt
    for ((i=2; i<=tCnt; i ++))
    do
    if [ ! -f /zktdata/zkt${i} ]; then
        cp -r /zktdata/zkt1 /zktdata/zkt${i}
        cd /zktdata/zkt${i}
        docker-compose up -d
        echo 'zkt已启动'
    else echo 'zkt已经存在'
    fi
    done
}

function zkt_rm
{
    echo "先确认/zktdata下的zkt节点数量，然后请输入zkt节点数"
    read tCnt
    for ((i=1; i<=tCnt; i ++))    
    do
    if [ ! -f /zktdata/zkt${i} ]; then
        cd /zktdata/zkt${i}
        docker-compose down
        echo '此zkt节点已删除'
    fi
    done
    rm -rf /zktdata
    docker rmi zktubelabs/zktube-prover
}

function zkt_restart
{
    echo "先确认/zktdata下的zkt节点数量，然后请输入zkt节点数"
    read tCnt
    for ((i=1; i<=tCnt; i ++))    
    do
    if [ ! -f /zktdata/zkt${i} ]; then
        cd /zktdata/zkt${i}
        docker-compose down
        docker-compose up -d
        echo '此zkt节点已重启'
    fi
    done
}

while true
do
    print_tips
    read -p "请输入你的选项(1|2|3|4|5|q|Q):" choice
 
    case $choice in
        1)
            docker_install
            ;;
        2)
            zkt_init
            zkt_start
            ;;
        3)
            zkt_loop
            exit
            ;;
        4)
            zkt_restart
            ;;
        5)
            zkt_rm
            ;;
        q|Q)
            exit
            ;;
        *)
            echo "Error,input only in {1|2|3|4|5|q|Q}"
            ;;
    esac
done