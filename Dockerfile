# Use a minimal and ARM64-compatible Ubuntu base
FROM --platform=linux/arm64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    wget \
    gnupg \
    ca-certificates \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libxss1 \
    libxtst6 \
    libnss3 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    x11-apps \
    fonts-liberation \
    libappindicator3-1 \
    libu2f-udev \
    libvulkan1 \
    libdrm2 \
    xdg-utils \
    xvfb \
    libasound2 \
    libcurl4 \
    libgbm1 \
    chromium-browser \
    && rm -rf /var/lib/apt/lists/*

# Alias chromium as google-chrome if needed
RUN ln -s /usr/bin/chromium-browser /usr/bin/google-chrome

# Install Python tools
RUN pip3 install --upgrade pip
RUN pip3 install pyvirtualdisplay

# Set up working directory
WORKDIR /app
COPY . .

# Install Python dependencies
RUN pip3 install -r requirements.txt
RUN pip3 install -r server_requirements.txt

# Expose FastAPI port
EXPOSE 8000

# Set up startup script
COPY docker_startup.sh /
RUN chmod +x /docker_startup.sh

ENTRYPOINT ["/docker_startup.sh"]
