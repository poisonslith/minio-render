FROM minio/minio:latest

# ติดตั้ง MinIO Client
RUN curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  --create-dirs \
  -o /usr/local/bin/mc && \
  chmod +x /usr/local/bin/mc

# สร้าง entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000

# ใช้ ENTRYPOINT เพื่อ override
ENTRYPOINT ["/entrypoint.sh"]
