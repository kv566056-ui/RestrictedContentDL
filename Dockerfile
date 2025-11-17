FROM python:3.11-slim

# Speed optimization
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    TZ=Asia/Kolkata

# Install required dependencies ONLY
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        tzdata && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install python dependencies first (cache layer)
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy rest of project
COPY . .

# Start bot
CMD ["python3", "main.py"]
