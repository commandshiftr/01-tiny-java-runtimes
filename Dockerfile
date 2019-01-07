FROM alpine:latest

COPY dist/myJRE /opt/jdk

ADD bin/Main.class /

CMD ["/opt/jdk/bin/java", Main]