FROM public.ecr.aws/lts/ubuntu:20.04_stable

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get -y update && apt-get install -y --no-install-recommends \
         awscli \
         wget \
         ca-certificates \
         git \
         jq \
         python3 python3-dev python3-pip \
    && rm -rf /var/lib/apt/lists/*

USER root
WORKDIR /root

# bitcoind
RUN wget https://github.com/GarlicoinOrg/Garlicoin/releases/download/v0.18.0/garlicoin-0.18.0-x86_64-linux-gnu.tar.gz && \ 
    tar -xzf garlicoin-0.18.0-x86_64-linux-gnu.tar.gz && \
    ln -s garlicoin-0.18.0 garlicoin && \
    rm garlicoin-0.18.0-x86_64-linux-gnu.tar.gz
COPY garlicoin.conf /root/

COPY start.sh /root/
RUN chmod +x /root/start.sh
 
EXPOSE 29000
EXPOSE 42068
EXPOSE 42069

# start
CMD ["bash", "-c", "ls -la && exec /root/start.sh"]