FROM nvidia/cuda:11.3.1-base-ubuntu20.04

# Install some basic utilities
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6 \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    python3-pip \
 && rm -rf /var/lib/apt/lists/*


RUN pip install cuda-python==11.5.0 numpy==1.21.2 scipy==1.7.1

RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113