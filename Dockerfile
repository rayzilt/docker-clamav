FROM debian:stretch-slim
LABEL maintainer="Rayzilt - <docker@rayzilt.nl>"

# Set apt non-interactive
ENV DEBIAN_FRONTEND noninteractive

# Install Clamav from Backports, Enable Foreground and enable tcp socket on port 3310
RUN set -x \
	&& apt-get update \
	&& apt-get --no-install-recommends install -y lsb-release procps \
	&& DEBIAN_CODE_NAME=`lsb_release -c -s` \
	&& echo "deb http://deb.debian.org/debian ${DEBIAN_CODE_NAME}-backports main" > /etc/apt/sources.list.d/backports.list \
	&& apt-get update \
	&& apt-get --target-release ${DEBIAN_CODE_NAME}-backports --no-install-recommends install -y clamav-daemon \
	&& apt-get purge -y lsb-release \
	&& apt-get autoremove --purge -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& sed -i 's/^Foreground false$/Foreground true/' /etc/clamav/clamd.conf \
	&& sed -i 's/^Foreground false$/Foreground true/' /etc/clamav/freshclam.conf \
	&& echo 'TCPSocket 3310' >> /etc/clamav/clamd.conf

EXPOSE 3310

COPY startup.sh /

ENTRYPOINT ["/startup.sh"]
