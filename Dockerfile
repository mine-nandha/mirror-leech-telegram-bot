FROM python:3.11-slim-bookworm

WORKDIR /app

RUN sed -i 's/Components: main/Components: main contrib non-free/' /etc/apt/sources.list.d/debian.sources 2>/dev/null || \
    sed -i 's/main$/main contrib non-free/' /etc/apt/sources.list && \
    apt-get update && apt-get install -y \
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

RUN apt-get update && apt-get install -y --no-install-recommends \
    sabnzbdplus \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://downloads.rclone.org/rclone-current-linux-amd64.deb -o rclone.deb \
    && dpkg -i rclone.deb \
    && rm rclone.deb

COPY requirements.txt .
RUN pip install --no-cache-dir --root-user-action ignore --upgrade pip \
    && pip install --no-cache-dir --root-user-action ignore -r requirements.txt

COPY . .

RUN sed -i 's/\r$//' *.sh

CMD ["bash", "start.sh"]
