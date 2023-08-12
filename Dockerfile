FROM ubuntu:20.04
ENV TOMCAT_HOME=/u01/middleware/apache-tomcat-9.0.78
RUN apt update -y
RUN apt install -y curl
RUN apt install -y mysql-client-8.0
RUN apt install -y net-tools
RUN apt install openjdk-8-jdk -y

RUN mkdir -p /u01/middleware/

WORKDIR /u01/middleware
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz .
RUN tar -xzvf apache-tomcat-9.0.78.tar.gz
RUN rm -rf apache-tomcat-9.0.78.tar.gz
 
COPY target/covido.war ${TOMCAT_HOME}/webapps/
COPY run.sh .
RUN chmod u+x run.sh
 
ENTRYPOINT ["./run.sh"] 
CMD [ "tail", "-f", "/dev/null" ]