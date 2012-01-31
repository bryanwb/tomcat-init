#!/bin/sh
### ====================================================================== ###
##                                                                          ##
##  Pentaho Start Script                                                    ##
##                                                                          ##
### ====================================================================== ###

JMXOPTS="-Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port=12345 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false "
MOREOPTS="-Dorg.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=true -Djavax.net.ssl.trustStore=/home/pentaho/jssecacerts" 


DIR_REL=`dirname $0`
cd $DIR_REL
DIR=`pwd`
cd -

. "$DIR/set-pentaho-env.sh"

setPentahoEnv "$DIR/jre"

if [ -e "$DIR/promptuser.sh" ]; then
  sh "$DIR/promptuser.sh"
  rm "$DIR/promptuser.sh"
fi
if [ "$?" = 0 ]; then
  cd "$DIR/tomcat/bin"
  export CATALINA_OPTS="-Xms256m -Xmx768m -XX:MaxPermSize=256m -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000 ${MOREOPTS} ${JMXOPTS}"
  JAVA_HOME=$_PENTAHO_JAVA_HOME
  sh startup.sh
fi
