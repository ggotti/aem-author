# DOCKER-VERSION 1.0.1
FROM centos:centos7
MAINTAINER ggotti

# Install Java
FROM ariya/centos7-oracle-jre7

#Enabling Centos EPL repository, and then installs python modules.
RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-1.noarch.rpm
RUN yum -y install epel-release-7-1.noarch.rpm
RUN yum install -y python-psutil

#Copies required build media
ONBUILD ADD cq-author-4502.jar /aem/cq-author-4502.jar
ONBUILD ADD license.properties /aem/license.properties
ONBUILD ADD https://raw.githubusercontent.com/ggotti/aem_author/master/aemInstaller.py /aem/aemInstaller.py

# Extracts AEM #
ONBUILD WORKDIR /aem
ONBUILD RUN java -XX:MaxPermSize=256m -Xmx1024M -jar cq-author-4502.jar -unpack -r nosamplecontent

# Add customised log file
ONBUILD ADD https://raw.githubusercontent.com/ggotti/aem_author/master/org.apache.sling.commons.log.LogManager.config /aem/crx-quickstart/install

# Installs AEM
ONBUILD RUN python aemInstaller.py

EXPOSE 4502 8000
ENTRYPOINT ["/aem/crx-quickstart/bin/quickstart"]
