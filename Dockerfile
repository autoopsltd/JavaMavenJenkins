FROM maven:alpine

RUN apk update

COPY . /root

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]
