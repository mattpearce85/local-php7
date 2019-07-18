FROM debian:stretch-slim
LABEL Maintainer="Matthew Pearce <mattpearce85@gmail.com>"
RUN apt-get update && \
apt-get install -y \
perl \
fcgiwrap \
build-essential \
default-libmysqlclient-dev \
libimage-magick-perl \
libexpat1-dev \
perl-openssl-defaults \
openssl \
libssl-dev \
--no-install-recommends && \
rm -r /var/lib/apt/lists/* && \
cpan -i MIME::Lite && \
cpan -i Net::Telnet && \
cpan -i Crypt::CBC && \
cpan -i DateTime && \
cpan -i DBI && \
cpan -i DBD::mysql && \
cpan -i CGI && \
cpan -i Archive::Zip && \
cpan -i LWP && \
cpan -i XML::Simple && \
cpan -i Lingua::EN::Numbers && \
cpan -i JSON && \
cpan -i Crypt::JWT && \
cpan -i Net::SSLeay && \
cpan -i REST::Client && \
cpan -i CAM::PDF && \
cpan -i XML::Writer
ENTRYPOINT [ "fcgiwrap", "-s", "tcp:0.0.0.0:9000", "-f" ]
EXPOSE 9000
