FROM centos:centos7

WORKDIR /usr/dcm
ADD     . /usr/dcm
RUN     yum install -y unzip
RUN     unzip dcm4chee-2.17.3-mysql.zip
RUN     unzip jboss-4.2.3.GA.zip
RUN	rpm -i https://mirror.its.sfu.ca/mirror/CentOS-Third-Party/RCG/common/x86_64/jdk-7u45-linux-x64.rpm && \
	alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_45/bin/java 1 && \
	alternatives --set java /usr/java/jdk1.7.0_45/bin/java && \
	export JAVA_HOME=/usr/java/jdk1.7.0_45/ && \
	echo "export JAVA_HOME=/usr/java/jdk1.7.0_45/" | tee /etc/environment && \
	source /etc/environment

RUN     cd /usr/dcm/dcm4chee-2.17.3-mysql/bin && \
        sh install_jboss.sh /usr/dcm/jboss-4.2.3.GA && \
        export JBOSS_HOME=/usr/dcm/jboss-4.2.3.GA

ENTRYPOINT    sh /usr/dcm/dcm4chee-2.17.3-mysql/bin/run.sh

ENV	JAVA_HOME=/usr/java/jdk1.7.0_45/
