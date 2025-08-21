FROM minio/minio:latest

RUN curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  --create-dirs -o /usr/local/bin/mc && chmod +x /usr/local/bin/mc

COPY start-minio.sh /start-minio.sh
RUN chmod +x /start-minio.sh

ENTRYPOINT ["/start-minio.sh"]
