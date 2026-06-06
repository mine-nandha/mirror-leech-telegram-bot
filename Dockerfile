FROM python:3.11-slim-bookworm

WORKDIR /app

RUN apt-get update && apt-get install -y \
    aria2 \
    ffmpeg \
    p7zip-full \
    qbittorrent-nox \
    git \
    curl \
    wget \
    unzip \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://downloads.rclone.org/rclone-current-linux-amd64.deb -o rclone.deb \
    && dpkg -i rclone.deb \
    && rm rclone.deb

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir sabnzbd \
    && ln -s /usr/local/bin/sabnzbd /usr/local/bin/sabnzbdplus

COPY . .

RUN sed -i 's/\r$//' *.sh

CMD ["bash", "start.sh"]
