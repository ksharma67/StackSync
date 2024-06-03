# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install Flask and other dependencies
RUN pip install --no-cache-dir numpy pandas flask

# Install nsjail dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        autoconf \
        bison \
        flex \
        git \
        libprotobuf-dev \
        libnl-route-3-dev \
        libtool \
        make \
        python3 \
        python3-pip \
        pkg-config \
        protobuf-compiler \
        wget \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Clone nsjail and build it
RUN git clone https://github.com/google/nsjail.git /nsjail && \
    cd /nsjail && \
    git clone https://github.com/google/kafel.git kafel && \
    make && \
    mv /nsjail/nsjail /usr/bin/nsjail && \
    rm -rf /nsjail

# Set the working directory in the container
WORKDIR /app

# Copy the nsjail configuration file
COPY nsjail.cfg /app/nsjail.cfg

# Copy the script to be executed
COPY download_deps.sh /app/download_deps.sh

# Make the script executable
RUN chmod +x /app/download_deps.sh

# Create a directory for cache
RUN mkdir /app/cache

# Copy the current directory contents into the container at /app
COPY . /app

# Expose the Flask port
EXPOSE 8080

# Define environment variable
ENV FLASK_APP=app.py

# Run Flask
CMD ["flask", "run", "--host=0.0.0.0", "--port=8080"]
