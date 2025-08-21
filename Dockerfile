FROM minio/minio:latest

# ติดตั้ง MinIO Client
RUN curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  --create-dirs \
  -o /usr/local/bin/mc && \
  chmod +x /usr/local/bin/mc

# สร้าง setup script
COPY setup.sh /setup.sh
RUN chmod +x /setup.sh

# สร้าง start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 9000 9001

CMD ["/start.sh"]
