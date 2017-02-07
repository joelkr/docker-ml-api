#FROM ubuntu:14.04
# Debian should be smaller
FROM debian:jessie

# MAINTAINER Juan Median juan-median.com/2015/12/05/machine-learning-docker/
ENV DEBIAN_FRONTEND noninteractive
RUN useradd --user-group --create-home --shell /bin/false mlapi &&\
  apt-get update &&\
    apt-get -y install python3-pip python3-dev &&\
    apt-get -y install python3-numpy python3-scipy python3-matplotlib \
    ipython3 ipython3-notebook python3-pandas python3-nose && \
    rm -rf /var/lib/apt/lists/* &&\
  pip3 install scikit-learn==0.18.1 nltk==3.2.1 pytest==3.0.5 &&\
  python3 -m nltk.downloader -d /usr/local/share/nltk_data punkt book &&\
  pip3 install textblob==0.11.1 flask==0.12 &&\
  python3 -m textblob.download_corpora

# This pulls in a million useless deps.
RUN apt-get -y install --no-install-recommends nodejs npm &&\
  rm -rf /var/lib/apt/lists/*
# Might try - will need wget
#RUN wget http://nodejs.org/dist/node-latest.tar.gz &&
#tar xvzf node-latest.tar.gz &&
#cd node-v* &&
#./configure &&
#CXX="g++ -Wno-unused-local-typedefs" make &&
#CXX="g++ -Wno-unused-local-typedefs" make install &&
#echo 'n# Node.jsnexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc
 
#RUN apt-get -y install python-nltk
ENV HOME=/home/mlapi

COPY cfg /etc/cfg
COPY cmd.sh /cmd.sh
COPY ./server $HOME/server
RUN chown -R mlapi:mlapi $HOME/*

ENV NODE_PORT 8080
EXPOSE $NODE_PORT

USER mlapi
WORKDIR $HOME/server
RUN npm install

#CMD ["/usr/bin/python3", "/var/python-app/flask_web.py"]
CMD ["/cmd.sh"]
