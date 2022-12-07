FROM public.ecr.aws/docker/library/ubuntu:focal
WORKDIR /root/

# Install & Update
RUN apt-get update -y 
RUN apt-get upgrade -y 
RUN apt-get install -y git \
 && DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get install -y software-properties-common 
RUN apt-get install libleveldb-dev -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install -y python3 python3-aiohttp python3-pip net-tools 
RUN pip3 install pylru 
RUN pip3 install plyvel 
RUN pip3 install 'aiorpcx==0.5.6'

# electrumx
RUN git clone https://github.com/garlicoin-project/electrumx.git
WORKDIR /root/electrumx
RUN python3 setup.py install

WORKDIR /root
COPY start.sh /root/
RUN chmod +x /root/start.sh

EXPOSE 50001
EXPOSE 50002
EXPOSE 50004
EXPOSE 8000

# start
CMD /root/start.sh