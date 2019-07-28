FROM debian:buster-slim
LABEL maintainer="Rayzilt - <docker@rayzilt.nl>"

# Set apt non-interactive
ENV DEBIAN_FRONTEND noninteractive

# Install Clamav, enable Foreground and enable tcp socket on port 3310
RUN set -x \
	&& apt update \
	&& apt --no-install-recommends install -y clamav-daemon \
	&& apt autoremove --purge -y \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& sed -i 's/^Foreground false$/Foreground true/' /etc/clamav/clamd.conf \
	&& sed -i 's/^Foreground false$/Foreground true/' /etc/clamav/freshclam.conf \
	&& echo 'TCPSocket 3310' >> /etc/clamav/clamd.conf

EXPOSE 3310

COPY startup.sh /
COPY healthcheck.sh /

# Healtcheck if Clamd and Freshclam are in a returning state
HEALTHCHECK --interval=1m --timeout=5s --start-period=10s \
	CMD /healthcheck.sh || exit 1

ENTRYPOINT ["/startup.sh"]

# Setup Labels
ARG VERSION
ARG COMMIT
ARG BRANCH
ARG DATE

LABEL org.label-schema.name="Clamav" \
	org.label-schema.description="Clamav & Freshclam" \
	org.label-schema.version=$VERSION \
	org.label-schema.usage="https://hub.docker.com/r/rayzilt/clamav/" \
	org.label-schema.url="http://www.clamav.net/" \
	org.label-schema.vcs-url="https://github.com/Cisco-Talos/clamav-devel/" \
	org.label-schema.vcs-ref=$COMMIT \
	org.label-schema.vendor="Rayzilt" \
	org.label-schema.build-date=$DATE \
	org.label-schema.schema-version="1.0" \
