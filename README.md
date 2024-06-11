# Deploying a Dockerized Next.js Application

This repository contains a Dockerized Next.js application.

## Prerequisites

Before you begin, ensure you have the following installed:

- Docker: [Install Docker](https://docs.docker.com/get-docker/)

## Getting Started

### Clone the Repository

First, clone this repository to your local machine:
```bash
git clone https://github.com/ksharma67/StackSync
cd StackSync
```

### Build the Docker Image

To build the Docker image for the Next.js application, run the following command:
```bash
docker build -t stacksync .
```

### Run the Docker Container

Once the Docker image is built, you can run a Docker container with the following command:
```bash
docker run -p 8080:8080 stacksync
```

This command maps port 8080 of the Docker container to port 8080 of your local machine. You can replace 3000:3000 with any other port if needed.

### Accessing the Application
After running the container, you can access the Next.js application at http://localhost:8080 in your web browser.
