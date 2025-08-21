#!/bin/bash

echo "Waiting for MinIO to start..."
sleep 15

echo "Setting up MinIO..."

# ตั้งค่า alias
mc alias set local http://localhost:9000 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD

# สร้าง buckets
mc mb local/bed-time-stories --ignore-existing
mc mb local/nca-toolkit --ignore-existing

# ตั้งค่า public access
mc anonymous set public local/bed-time-stories
mc anonymous set public local/nca-toolkit

# สร้าง service accounts
mc admin user svcacct add local $MINIO_ROOT_USER --access-key bedtime-key --secret-key bedtime-secret123
mc admin user svcacct add local $MINIO_ROOT_USER --access-key nca-key --secret-key nca-secret123

echo "Setup complete!"
