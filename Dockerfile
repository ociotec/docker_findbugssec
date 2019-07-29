FROM alpine:latest
LABEL maintainer="emilio@ociotec.com"
ENV FINDBUGS_VERSION=3.0.1
ENV SECURITY_PLUGIN_VERSION=1.9.0

RUN apk add --no-cache curl openjdk8-jre

RUN curl -sL https://sourceforge.net/projects/findbugs/files/findbugs/${FINDBUGS_VERSION}/findbugs-${FINDBUGS_VERSION}.tar.gz/download | tar xz && \
    mv findbugs-* /usr/bin/findbugs

RUN curl -o /usr/bin/findbugs/lib/findsecbugs-plugin.jar -sL "https://search.maven.org/remotecontent?filepath=com/h3xstream/findsecbugs/findsecbugs-plugin/${SECURITY_PLUGIN_VERSION}/findsecbugs-plugin-${SECURITY_PLUGIN_VERSION}.jar"

WORKDIR /tmp

ENTRYPOINT ["java", "-jar", "/usr/bin/findbugs/lib/findbugs.jar", "-pluginList", "/usr/bin/findbugs/lib/findsecbugs-plugin.jar"]
CMD ["-h"]
