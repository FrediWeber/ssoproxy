# Introduction
This container provides basic and generic SSO functionality with the help of Apache and Kerberos.  
The authentication is done via Kerberos and the authorization via LDAP.  

# Basic functionality
To have a minimal, working container, you need the following:
* Working keytab file for Kerberos
* LDAP bind user if anonymous requests are not allowed
* LDAP Group to authorize the user

Then you can run the container with the following parameters:  
`docker run -p 443:443 -v /path/to/local/keytab/file:/usr/local/apache2/conf/kerberos.keytab -e HTTPD_PROXY_BACKEND_HOSTNAME="https://some-backend-server" -e KERBEROS_REALM="KRB_REALM" -e LDAP_URL="ldap:ldapserver:389/searchpath?UidProperty" -e LDAP_GROUP_REQUIRE="CN=GROUP,OU=OU,DC=DC" -e LDAP_BIND_USER="CN=BINDUSER,OU=OU,DC=DC" -e LDAP_BIND_PASSWORD="password"`

# Customization
There are several parameters and file mappings you can use, to customize the container.

## Parameters
* HTTPD_LOGLEVEL  
You can define the Apache loglevel with this parameter

* HTTPD_PORT_HTTP  
Frontent listen port for HTTP. Defaults to 80.

* HTTPD_PORT_SSL  
Frontent listen port for HTTPS. Defaults to 443.

* HTTPD_PROXY_BACKEND_HOSTNAME  
This is the backend server, that the proxy is adressing.  
You can also specify the protocol.

* HTTPD_PROXY_BACKEND_SSL_VERIFY  
Please do not change that.  
You could turn of certificate verification of the backend server with this.

* HTTPD_PROXY_BACKEND_USER_HEADER  
The SSO proxy sends the authenticated username in this header to the backend server.  
Defaults to `AuthorizedUser`

* KERBEROS_REALM  
Specify the Kerberos realm to use. This has to match the realm in the keytab file.

* KERBEROS_KEYTAB_FILE  
You could change the path to the Kerberos keytab file with this parameter if you want.  
Defaults to `/usr/local/apache2/conf/kerberos.keytab`

* LDAP_URL  
Specify the LDAP URL.  
For example `ldap://ldapserver:389/OU=OU,DC=DC,DC=local?UserPrincipalName`

* LDAP_GROUP_REQUIRE  
The DN of the group, which a valid user needs to be a member.  
For example `CN=GROUP,OU=OU,DC=DC,DC=local`

* LDAP_BIND_USER  
A bind user that is authorized to make basic queries in ldap.  
For example `CN=User,OU=OU,DC=DC,DC=local`

* LDAP_BIND_PASSWORD  
The password for the bind user.

## Files
* /usr/local/apache2/conf/kerberos.keytab  
Default location of the Kerberos keytab file.

* /usr/local/apache2/conf/server.crt  
Location of the server SSL certificate.

* /usr/local/apache2/conf/server.key  
Location of the server SSL private key.

* /usr/local/apache2/conf/remoteca.crt  
The CA chain that the backend server is verified against.
