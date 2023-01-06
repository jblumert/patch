#!/bin/bash
# configure ceph
# run from ceph1
#
echo 'service_type: host
addr: ceph1
hostname: ceph1
---
service_type: host
addr: ceph2
hostname: ceph2
---
service_type: host
addr: ceph3
hostname: ceph3
---
service_type: mon
placement:
  host_pattern: "ceph[1-3]"
---
service_type: osd
service_id: my_osds
placement:
  host_pattern: "ceph[1-3]"
data_devices:
  all: true
---
service_type: rgw
service_id: objectgw
service_name: rgw.objectgw
placement:
  host_pattern: "ceph1"
spec:
  rgw_frontend_port: 8080
---
service_type: mds
service_id: cephfs
placement:
  host_pattern: "ceph2"' > /tmp/spec.yaml
 #
 # create cluster
 # 
 cephadm bootstrap --apply-spec spec.yaml --mon-ip 192.168.252.11 --ssh-private-key /root/.ssh/id_rsa --ssh-public-key /root/.ssh/id_rsa.pub --registry-url registry.redhat.io --registry-username blumert --registry-password Washt0ning*1961
