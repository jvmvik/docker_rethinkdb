FROM rethinkdb:2.3.5
AUTHOR Victor Benarbia <victor@vtool.run>

RUN apt-get update && \ 
     apt-get -y install ruby nano htop && \
      rm -rf /var/lib/apt/lists/*

# TODO Run as regular user
# USER rethinkdb

RUN gem install rethinkdb 

COPY bootstrap.sh /root/
COPY .irbrc /root/
COPY rethinkdb_porter_dev.conf /etc/rethinkdb/instances.d/

VOLUME /data
WORKDIR /data

EXPOSE 28015
EXPOSE 8080
ENTRYPOINT ["/root/bootstrap.sh"]
