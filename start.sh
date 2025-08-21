#!/bin/bash
# start.sh

# เริ่ม MinIO ด้วย memory limits
exec minio server /data \
  --address :${PORT:-9000} \
  --quiet &

MINIO_PID=$!

# รอ MinIO พร้อม แล้วทำ setup เบาๆ
sleep 10 && {
  mc alias set l http://localhost:${PORT:-9000} $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD 2>/dev/null
  mc mb l/bed-time-stories --ignore-existing 2>/dev/null
  mc mb l/nca-toolkit --ignore-existing 2>/dev/null
  mc anonymous set public l/bed-time-stories 2>/dev/null
  mc anonymous set public l/nca-toolkit 2>/dev/null
  echo "Setup done"
} &

# รอ MinIO process หลัก
wait $MINIO_PID
