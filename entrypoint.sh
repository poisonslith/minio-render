#!/bin/bash

# เริ่ม MinIO ใน background
minio server /data &
MINIO_PID=$!

# รอให้ MinIO พร้อม
echo "Waiting for MinIO to be ready..."
sleep 10

# ตรวจสอบว่า MinIO พร้อมหรือยัง
until curl -f http://localhost:9000/minio/health/live 2>/dev/null; do
    echo "MinIO not ready yet, waiting..."
    sleep 2
done

echo "MinIO is ready, starting setup..."

# Setup
mc alias set local http://localhost:9000 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD

# สร้าง buckets
mc mb local/bed-time-stories --ignore-existing
mc mb local/nca-toolkit --ignore-existing

# ตั้งค่า public access
mc anonymous set public local/bed-time-stories
mc anonymous set public local/nca-toolkit

# สร้าง service accounts
mc admin user svcacct add local $MINIO_ROOT_USER --access-key bedtime-key --secret-key bedtime-secret123 2>/dev/null || true
mc admin user svcacct add local $MINIO_ROOT_USER --access-key nca-key --secret-key nca-secret123 2>/dev/null || true

echo "Setup complete!"

# Keep MinIO running in foreground
wait $MINIO_PID
