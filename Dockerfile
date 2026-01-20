# Use a minimal Ubuntu image as the base
FROM ubuntu:22.04

# Set environment variables to prevent interactive prompts during apt operations
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary dependencies for Blender
# Xvfb is used for headless rendering (Blender can run without a graphical interface)
# wget is for downloading Blender, libgl1-mesa-glx for OpenGL support
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    bzip2 \
    libgl1-mesa-glx \
    libglu1-mesa \
    libxkbcommon-x11-0 \
    xvfb && \
    rm -rf /var/lib/apt/lists/*

# Blender version to download (e.g., 3.6 LTS)
ARG BLENDER_VERSION=3.6.8
ARG BLENDER_BUILD=linux-x64
ARG BLENDER_URL=https://download.blender.org/release/Blender${BLENDER_VERSION%.*}/blender-${BLENDER_VERSION}-${BLENDER_BUILD}.tar.xz

# Download, extract, and clean up Blender
RUN wget -q ${BLENDER_URL} -O blender.tar.xz && \
    tar -xf blender.tar.xz -C /opt && \
    rm blender.tar.xz && \
    mv /opt/blender-${BLENDER_VERSION}-${BLENDER_BUILD} /opt/blender

# Set Blender as the default executable in the PATH
ENV PATH="/opt/blender:$PATH"

# Set the default command for the container
# This command runs Blender in background mode, renders a default scene, and exits.
# You can customize this to render specific files.
CMD ["xvfb-run", "-a", "blender", "-b", "--render-frame", "1", "--render-output", "/tmp/output", "--verbosity", "1", "-F", "PNG", "-o", "/tmp/image"]

# Expose any ports if Blender was to run as a service (not typical for render jobs)
# EXPOSE 80