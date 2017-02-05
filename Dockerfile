FROM ubuntu:14.04
# MAINTAINER Juan Median juan-median.com/2015/12/05/machine-learning-docker/
ENV DEBIAN_FRONTEND noninteractive
RUN useradd --user-group --create-home --shell /bin/false mlapi &&\
  apt-get update &&\
    apt-get -y install python3-pip python3-dev &&\
    apt-get -y install python3-numpy python3-scipy python3-matplotlib \
    ipython3 ipython3-notebook python3-pandas python3-nose && \
  pip3 install scikit-learn==0.18.1 nltk==3.2.1 pytest==3.0.5 &&\
  python3 -m nltk.downloader -d /usr/local/share/nltk_data punkt book &&\
  pip3 install textblob==0.11.1 flask==0.12 &&\
  python3 -m textblob.download_corpora

#RUN apt-get -y install python-nltk
ENV HOME=/home/mlapi

WORKDIR $HOME
COPY cfg /etc/cfg
COPY cmd.sh /cmd.sh

ENV FLASK_PORT 8080
EXPOSE $FLASK_PORT

USER mlapi
COPY python-app $HOME/python-app

#CMD ["/usr/bin/python3", "/var/python-app/flask_web.py"]
CMD ["/cmd.sh"]
