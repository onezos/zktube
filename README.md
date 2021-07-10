# zktube工具

兼容Centos和Ubuntu

```shell
rm -rf zkt.sh && wget https://download.swarmeth.org/zkt/centos/zkt.sh && chmod a+x zkt.sh && ./zkt.sh
```

根据需求选择：

```shell
./zkt.sh 
=========================================================
(1) 安装docker和docker-compose
(2) 安装单节点zktube
(3) 复制单节点zktube，多开节点
(4) 重启zktube节点（官方升级后，重启即可升级为最新版）
(5) 停止并删除zktube节点
(6) 停止并删除所有docer container volume image
(Q/q) 退出
=========================================================
请输入你的选项(1|2|3|4|5|6|q|Q):
```

```shell
=========================================================
查看进程：docker ps
存放目录：/zktdata/zkt1
查看日志：docker logs -f zkt1_zktube-prover_1
============================================== Aven7 ==== 
```



--------------------------------------------------------------------------------------

作者捐赠地址：0x6a3f3D5F8975AB600b5428a6f79b6d3A706bead4
