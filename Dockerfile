
# Will be overriden by the template
FROM centos:7

MAINTAINER Jens Reimann <jreimann@redhat.com>
LABEL \
  name "Grafana OpenShift Image" \
  maintainer "Jens Reimann <jreimann@redhat.com>"

USER root
EXPOSE 3000

# Will be overridded by the version from the template
ENV GRAFANA_VERSION="4.6.3"   

COPY root /

RUN yum -y update \
    && yum -y install https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-"$GRAFANA_VERSION"-1.x86_64.rpm \
    && yum clean all &&
    && /usr/bin/fix-permissions /usr/share/grafana \
    && /usr/bin/fix-permissions /etc/grafana \
    && /usr/bin/fix-permissions /var/lib/grafana \
    && /usr/bin/fix-permissions /var/log/grafana

ENTRYPOINT ["/usr/bin/run-grafana"]
