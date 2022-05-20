# argoverse-stereo-competition

## Environment Setup

### Requirements

You need [Docker](https://docs.docker.com/get-docker/) Installed on your computer in order to set up the training
environment.

### GPU acceleration

To train your model using GPU acceleration
you need an Nvidia GPU and cuda driver (11.3 version) installed on your system.

#### Install Nvidia Docker

In order to use GPU acceleration inside a docker container
is required docker nvidia runtime.

##### Ubuntu

Setting the GPG and remote repo for the package:

```bash
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
  ```
  
Then update the apt lists.

```bash
sudo apt-get update
```

Install nvidia-docker and reload the Docker daemon configurations:

```
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
```

Test that everything is installed correctly:

```
docker run --runtime=nvidia --rm nvidia/cuda:11.3.1-base nvidia-smi
```

The output should be something like this:

```
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 510.60.02    Driver Version: 510.60.02    CUDA Version: 11.6     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:01:00.0  On |                  N/A |
| N/A   45C    P5    14W /  N/A |    584MiB /  6144MiB |     20%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A      1067      G                                     404MiB |
|    0   N/A  N/A      2885      G                                     104MiB |
|    0   N/A  N/A      3149      G                                       2MiB |
|    0   N/A  N/A      3167      G                                       2MiB |
|    0   N/A  N/A   3132353      G                                      33MiB |
|    0   N/A  N/A   3132676      G                                      15MiB |
|    0   N/A  N/A   3132765      G                                      17MiB |
+-----------------------------------------------------------------------------+
```

### Build Docker Image

Build the image inside this repo:

#### Ubuntu

```bash
  docker build -t pytorch-cuda 
```


### Run and Test the Environment
After building the image you need to run and test if everything works correctly.

#### GPU acceleration
You run the container with the GPU acceleration if you have a GPU installed.
##### Ubuntu

Run container and attach to it:
```bash
  docker run --runtime=nvidia -it --rm pytorch-cuda:latest /bin/bash 
```

Run the python interprester:
```bash
python3
```

Test pytorch with GPU acceleration:

```python
import torch
torch.cuda.is_available()
```
If the output is `True` everything is settled up correctly, you can use pytorch with GPU acceleration


#### CPU acceleration
If you don't have a GPU card in your system you can run the container without
GPU acceleration using only CPU. It will be more slow than GPU.
##### Ubuntu

Run container and attach to it:
```bash
  docker run -it --rm pytorch-cuda:latest /bin/bash 
```

Run the python interprester:
```bash
python3
```

Test pytorch without GPU acceleration:

```python
import torch
torch.cuda.is_available()
```
If the output is `False` everything is settled up correctly.