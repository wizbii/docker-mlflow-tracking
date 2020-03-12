FROM continuumio/miniconda3

#ARG HDFS_URI=hdfs://spark1.internal.wizbii.com:9000/data/mlflow/artifact

WORKDIR /app

ENV HADOOP_HOME /app/hadoop-2.9.2
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

RUN mkdir /usr/share/man/man1/
RUN mkdir /data

RUN apt update -y
RUN apt install default-jdk-headless nano wget -y

RUN wget http://archive.apache.org/dist/hadoop/core/hadoop-2.9.2/hadoop-2.9.2.tar.gz
RUN tar -xvzf hadoop-2.9.2.tar.gz
RUN cp hadoop-2.9.2/lib/native/libhdfs.so hadoop-2.9.2/

RUN pip install jupyter pyarrow mlflow

CMD mlflow server --backend-store-uri /data --default-artifact-root $HDFS_URI --host 0.0.0.0




