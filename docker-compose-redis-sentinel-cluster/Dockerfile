FROM redis:3.2

MAINTAINER Gus Jiang <jiangguqiang@hotmail.com>

# Some Environment Variables
ENV HOME /root

# add local mirrors
RUN echo 'deb http://mirrors.163.com/debian/ jessie main non-free contrib' >> /etc/apt/sources.list && \
echo 'deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib' >> /etc/apt/sources.list && \
echo 'deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib' >> /etc/apt/sources.list  && \
echo 'deb-src http://mirrors.163.com/debian/ jessie main non-free contrib' >> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib' >> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib' >> /etc/apt/sources.list && \
echo 'deb http://mirrors.163.com/debian/ stretch main non-free contrib' > /etc/apt/sources.list && \
echo 'deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/sources.list && \
echo 'deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib' >> /etc/apt/sources.list  && \
echo 'deb-src http://mirrors.163.com/debian/ stretch main non-free contrib' >> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.163.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib' >> /etc/apt/sources.list 


# Install system dependencies
RUN apt-get update  && \
    apt-get install -y \
    gcc make g++ build-essential libc6-dev tcl wget locales && \
    apt-get clean -yqq

# # Ensure UTF-8 lang and locale
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Necessary for gem installs due to SHA1 being weak and old cert being revoked
RUN mkdir -p  /opt/apps/redis && \
    mkdir -p  /opt/logs/redis && \
    mkdir -p  /opt/datas/redis && \
    mkdir -p  /opt/logs/sentinel && \
    mkdir -p  /opt/datas/sentinel

ARG redis_version=4.0.10
RUN wget -qO redis.tar.gz http://download.redis.io/releases/redis-${redis_version}.tar.gz \
    && tar xfz redis.tar.gz -C / \
    && mv /redis-${redis_version} /redis-src  \
    && rm -f redis.tar.gz

#RUN (cd /redis-src && make PREFIX=/opt/apps/redis  MALLOC=libc  install )
RUN (cd /redis-src && make PREFIX=/opt/apps/redis  install )  && \
    rm -rf /redis-src 
    
COPY ./redis  /opt/apps/redis/redis
COPY ./sentinel  /opt/apps/redis/sentinel

RUN chmod 755 /opt/apps/redis/redis/start-redis.sh

EXPOSE 6379

#ENTRYPOINT ["/opt/apps/redis/redis_start.sh"]
CMD ["/opt/apps/redis/redis/start-redis.sh"]
