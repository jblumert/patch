#!/bin/bash
# patch for minio
#
echo "MINIO_VOLUMES=/scale/fs1/minio/data" > /etc/default/minio
sed -i 's/minio-user/root/' /etc/systemd/system/minio.service
systemctl daemon-reload
sleep 3
systemctl enable minio
systemctl start minio
sleep 3
mc alias set minio http://192.168.252.5:9000 minioadmin minioadmin
mc mb minio/backup
#
# scale patch
# rpm -ivh /usr/lpp/mmfs/5.1.5.0/zimon_rpms/rhel8/gpfs.gss.pmsensors-5.1.5-0.el8.x86_64.rpm
# systemctl start pmsensors
# systemctl restart pmcollector
# systemctl restart gpfsgui
# mmsysmoncontrol restart
