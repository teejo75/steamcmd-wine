# Intermediate
FROM debian:stable-slim AS winehqkey
ADD --chmod=755 https://dl.winehq.org/wine-builds/winehq.key /tmp/winehq.key
RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
	gpg \
    && gpg --dearmor -o /winehq-archive.key /tmp/winehq.key

# Wine base
FROM teejo75/steamcmd-base

LABEL org.opencontainers.image.authors="teejo75"
LABEL org.opencontainers.image.source="https://github.com/teejo75/steamcmd-wine"
LABEL org.opencontainers.image.description="Debian Trixie SteamCMD Wine base image"

# Copy the key from the winehqkey stage
COPY --from=winehqkey /winehq-archive.key /etc/apt/keyrings/winehq-archive.key
ADD https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources /etc/apt/sources.list.d/winehq-trixie.sources
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --no-install-recommends \
    xdg-user-dirs \
    winehq-stable \
    xvfb \
    winbind \
    && apt-get clean -y && apt-get autopurge -y && rm -rf /var/lib/apt/lists/*
