#!/bin/bash

# เริ่ม MinIO ใน background
minio server /data --console-address ":9001" &

# รัน setup script ใน background
/setup.sh &

# รอให้ MinIO process หลัก
wait
