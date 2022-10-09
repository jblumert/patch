#!/bin/bash
echo "MINIO_VOLUMES=/scale/fs1/minio/data" > /etc/default/minio
sed -i 's/minio-user/root/' /etc/systemd/system/minio.service
systemctl daemon-reload
systemctl start minio
mc alias set minio http://192.168.252.5:9000 minioadmin minioadmin
mc mb minio/backup
