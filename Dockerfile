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

# Install cuda python
RUN pip install cuda-python==11.5.0\

# Install cuda pytorch
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113

# Install some python utilities
RUN pip install numpy==1.21.2 scipy==1.7.1

# Create a working directory
RUN mkdir /app
WORKDIR /app

# Set the default command to python3
CMD ["python3"]