# We used Ubuntu for our image, but as of lately,
# it includes a version of openjdk that does not
# work for us.
# FROM i386/ubuntu
FROM debian:buster

# Configuration
ARG MP=/data/Ablage
ARG SD=.

# Adding environment variables for TZ
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# If we run on ARM (Apple Silicon),
# we have to do some extra steps so
# that we can actually run the i386
# based version of abbyyocr.

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y --no-install-recommends wget gnupg2

RUN apt-get install -y --no-install-recommends software-properties-common

# Add an older JDK as version 10 doesn't
# work with the version of iText that we
# have.
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public > /tmp/some.key
RUN apt-key add /tmp/some.key && rm /tmp/some.key
RUN add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get --assume-yes install --no-install-recommends \
    unzip adoptopenjdk-8-hotspot

# Add the files that we need.
COPY src/ /
RUN cd /tmp && \
    wget http://www.mnsoft.org/wp-content/uploads/pdfocr.zip && \
    unzip -P pdfocr /tmp/pdfocr.zip -d / && \
    rm /tmp/pdfocr.zip

# Configure the pdfocr script
RUN sed -i "s!^MP=.*!MP=$MP!g" /usr/local/bin/pdfocr
RUN sed -i "s!^SD=.*!SD=$SD!g" /usr/local/bin/pdfocr

