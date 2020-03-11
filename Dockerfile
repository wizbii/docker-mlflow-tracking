FROM continuumio/miniconda3

WORKDIR /app

RUN mkdir /usr/share/man/man1/

RUN apt update -y
RUN apt install default-jdk-headless wget -y

RUN wget http://archive.apache.org/dist/hadoop/core/hadoop-2.9.2/hadoop-2.9.2.tar.gz
RUN tar -xvzf hadoop-2.9.2.tar.gz
RUN echo export HADOOP_HOME=/app/hadoop-2.9.2 >> /root/.bashrc
RUN echo export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 >> /root/.bashrc

RUN pip install mlflow

CMD mlflow server --backend-store-uri /tmp/persistent-disk --default-artifact-root hdfs://spark1.internal.wizbii.com:9000/data/mlflow/artifact --host 0.0.0.0




