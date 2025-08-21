#!/bin/bash

# Setup ใน background
{
  sleep 20
  mc alias set local http://localhost:${PORT:-9000} $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD
  mc mb local/bed-time-stories --ignore-existing
  mc mb local/nca-toolkit --ignore-existing
  mc anonymous set public local/bed-time-stories
  mc anonymous set public local/nca-toolkit
  mc admin user svcacct add local $MINIO_ROOT_USER --access-key bedtime-key --secret-key bedtime-secret123 || true
  mc admin user svcacct add local $MINIO_ROOT_USER --access-key nca-key --secret-key nca-secret123 || true
  echo "Setup complete!"
} &

# เริ่ม MinIO
exec minio server /data --address :${PORT:-9000}
