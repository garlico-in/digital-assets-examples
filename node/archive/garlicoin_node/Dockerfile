FROM public.ecr.aws/lts/ubuntu:20.04_stable

RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         ca-certificates \
         git \
         python3 python3-dev python3-pip \
         socat \
         openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd

USER root
WORKDIR /root

# garlicoind
RUN wget https://github.com/GarlicoinOrg/Garlicoin/releases/download/v0.18.0/garlicoin-0.18.0-x86_64-linux-gnu.tar.gz && \ 
    tar -xzf garlicoin-0.18.0-x86_64-linux-gnu.tar.gz && \
    ln -s garlicoin-0.18.0 garlicoin && \
    rm garlicoin-0.18.0-x86_64-linux-gnu.tar.gz
COPY garlicoin.conf /root/
RUN wget https://raw.githubusercontent.com/bitcoin/bitcoin/master/share/rpcauth/rpcauth.py

# electrumx
RUN git clone https://github.com/garlicoin-project/electrumx.git
RUN cd electrumx && pip3 install .

COPY docker-ssh.sh /root/
RUN chmod +x /root/docker-ssh.sh

COPY start.sh /root/
RUN chmod +x /root/start.sh

EXPOSE 50002
EXPOSE 42069
EXPOSE 22

# start
CMD ["bash", "-c", "ls -la && exec /root/start.sh"]