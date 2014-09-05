# DOCKER-VERSION 1.0.1
FROM centos:centos7
MAINTAINER ggotti

# Install Java
FROM ariya/centos7-oracle-jre7

#Enabling Centos EPL repository, and then installs python modules.
RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/epel-release-7-1.noarch.rpm
RUN yum -y install epel-release-7-1.noarch.rpm
RUN yum install -y python-psutil

ADD ./aemMedia /aem
ADD aemInstaller.py /aem/aemInstaller.py

# Extracts AEM #
WORKDIR /aem
RUN java -XX:MaxPermSize=256m -Xmx1024M -jar cq-author-4502.jar -unpack -r nosamplecontent

# Add customised log file
ADD org.apache.sling.commons.log.LogManager.config /aem/crx-quickstart/install

# Installs AEM
RUN python aemInstaller.py

EXPOSE 4502 8000
ENTRYPOINT ["/aem/crx-quickstart/bin/quickstart"]
