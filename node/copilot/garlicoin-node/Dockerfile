FROM public.ecr.aws/docker/library/alpine:3.17
WORKDIR /root

RUN apk --update --repository=http://dl-4.alpinelinux.org/alpine/edge/testing add && \
    apk update && \
    apk upgrade --no-cache && \                                                                                                                                                                                                                        
    apk add --no-cache bash ca-certificates wget boost libevent zeromq && \                                                                                                                                                                                                      
    update-ca-certificates

# garlicoind
RUN wget https://downloads.garlico.in/garlicoin-alpine-aarch64.tar.gz && \
    tar -xzf garlicoin-alpine-aarch64.tar.gz && \
    ln -s garlicoin-alpine-aarch64 garlicoin && \
    rm garlicoin-alpine-aarch64.tar.gz
COPY garlicoin.conf /root/

COPY start.sh /root/
RUN chmod +x /root/start.sh
 
EXPOSE 29000
EXPOSE 42068
EXPOSE 42069

# start
CMD ["bash", "-c", "ls -la && exec /root/start.sh"]