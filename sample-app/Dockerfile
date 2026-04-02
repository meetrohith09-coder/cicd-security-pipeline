# ❌ BAD: Using :latest tag (not pinned)
FROM ubuntu:latest

# ❌ BAD: Running as root
USER root

# Install vulnerable dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget

# Copy application
COPY . /app
WORKDIR /app

# ❌ BAD: No healthcheck
# ❌ BAD: Running arbitrary command as root

CMD ["./app"]
