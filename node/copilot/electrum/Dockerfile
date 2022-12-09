FROM public.ecr.aws/docker/library/python:3.9.16-slim
WORKDIR /root/

# Install & Update
RUN apt-get update -y 
RUN apt-get upgrade -y 
RUN apt-get install -y git \
 && DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get install -y software-properties-common
RUN apt-get install -y build-essential 
RUN apt-get install libleveldb-dev -y

# electrumx
RUN git clone https://github.com/garlicoin-project/electrumx.git
WORKDIR /root/electrumx
RUN pip install websockets
RUN pip install .

WORKDIR /root
COPY start.sh /root/
RUN chmod +x /root/start.sh

RUN apt-get remove -y build-essential
RUN apt-get autoremove -y 

# ports
EXPOSE 50002
EXPOSE 50004

# start
CMD ["bash", "-c", "ls -la && exec /root/start.sh"]