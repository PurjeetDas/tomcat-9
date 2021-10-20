FROM adoptopenjdk/openjdk8:alpine

ENV TOMCAT_MAJOR=9 \
    TOMCAT_VERSION=9.0.54

RUN apk -U upgrade --update && \
    wget -O /tmp/apache-tomcat.tar.gz https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -C /opt -xvf /tmp/apache-tomcat.tar.gz && \
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION}/ /usr/local/tomcat && \
    rm -rf /tmp/apache-tomcat.tar.gz && \
    mkdir -p /usr/local/tomcat/logs && \
    mkdir -p /usr/local/tomcat/work

ENV CATALINA_HOME /usr/local/tomcat/
ENV PATH $CATALINA_HOME/bin:$PATH
ENV TOMCAT_NATIVE_LIBDIR=$CATALINA_HOME/native-jni-lib
ENV LD_LIBRARY_PATH=$CATALINA_HOME/native-jni-lib

WORKDIR $CATALINA_HOME
EXPOSE 8080

CMD ["catalina.sh", "run"]
