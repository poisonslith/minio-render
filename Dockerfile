FROM minio/minio:latest

# ลด memory footprint
ENV MINIO_OPTS="--compat"

# ติดตั้ง mc อย่างเดียว
RUN curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  -o /usr/local/bin/mc && chmod +x /usr/local/bin/mc

# Simple startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
