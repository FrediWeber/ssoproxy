FROM httpd:2.4

ENV HTTPD_LOGLEVEL="warn"
ENV HTTPD_PROXY_BACKEND_HOSTNAME="http://localhost"
ENV HTTPD_PROXY_BACKEND_SSL_VERIFY="require"
ENV HTTPD_PROXY_BACKEND_USER_HEADER="AuthorizedUser"
ENV KERBEROS_REALM=""
ENV KERBEROS_KEYTAB_FILE="/usr/local/apache2/conf/kerberos.keytab"
ENV LDAP_URL=""
ENV LDAP_GROUP_REQUIRE=""
ENV LDAP_BIND_USER=""
ENV LDAP_BIND_PASSWORD=""

RUN apt-get update && \
  DEBIAN_FRONTEND=nointeractive apt-get install -y libapache2-mod-auth-kerb openssl && \
  apt-get clean
    
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf
COPY httpd-foreground /usr/local/bin/httpd-foreground
RUN chmod 0554 /usr/local/bin/httpd-foreground

EXPOSE 443/tcp
