FROM ubuntu:24.10

COPY image-build.sh ./image-build.sh
RUN bash ./image-build.sh
