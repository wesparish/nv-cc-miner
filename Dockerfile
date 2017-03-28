FROM ubuntu

RUN apt-get update && \
    apt-get install -y git libcurl4-openssl-dev module-init-tools \
      build-essential automake libssl-dev wget && \
    apt-get clean

RUN wget "https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run" 

RUN chmod +x cuda_8.0.61_375.26_linux-run && \
    mkdir nvidia_installers && \
    ./cuda_8.0.61_375.26_linux-run -extract=`pwd`/nvidia_installers && \
    cd nvidia_installers && \
    ./NVIDIA-Linux-x86_64-375.26.run -s -N --no-kernel-module

RUN cd nvidia_installers && \
  ./cuda-linux64-rel-8.0.61-21551265.run -noprompt

RUN git clone https://github.com/tsiv/ccminer-cryptonight.git

WORKDIR /ccminer-cryptonight

ENV PATH $PATH:/usr/local/cuda/bin/
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/cuda/lib64/

RUN ./autogen.sh && \
    ./configure && \
    make

#entrypoint [ './ccminer' ]
