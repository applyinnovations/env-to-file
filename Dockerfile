FROM alpine:latest
RUN apk add --no-cache bash
COPY env-to-file.sh /usr/local/bin/env-to-file.sh
RUN chmod +x /usr/local/bin/env-to-file.sh
ENTRYPOINT ["/usr/local/bin/env-to-file.sh"]
