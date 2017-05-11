FROM h0l0/ubuntu-go
LABEL maintainer="H0l0 Gram" description="image to build TheThingsNetwork new packet forwarder"

ADD imst_rpi.sh /root/
RUN chmod +x /root/imst_rpi.sh
VOLUME /root/release
WORKDIR /root
CMD ["/bin/bash","imst_rpi.sh", "-b master"]

