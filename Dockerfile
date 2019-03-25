# We will use Ubuntu for our image
FROM i386/ubuntu

# Configuration
ARG MP=/data/Ablage
ARG SD=Ablegen

# Updating Ubuntu packages
RUN apt-get update && yes|apt-get upgrade

# Adding environment variables for TZ
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Adding unzip
RUN apt-get install -y unzip wget

RUN apt-get install -y openjdk-8-jre-headless

COPY src/ /
RUN cd /tmp && \
    wget http://www.mnsoft.org/wp-content/uploads/pdfocr.zip && \
    unzip -P pdfocr /tmp/pdfocr.zip -d / && \
    rm /tmp/pdfocr.zip

# Configure the pdfocr script
RUN sed -i "s!^MP=.*!MP=$MP!g" /usr/local/bin/pdfocr
RUN sed -i "s!^SD=.*!SD=$SD!g" /usr/local/bin/pdfocr

