FROM debian:stretch-slim
LABEL Maintainer="Matthew Pearce <mattpearce85@gmail.com>"
RUN apt-get update && \
apt-get install -y \
perl \
fcgiwrap \
--no-install-recommends && \
rm -r /var/lib/apt/lists/*
ENTRYPOINT [ "fcgiwrap", "-s", "tcp:0.0.0.0:9000", "-f" ]
EXPOSE 9000
