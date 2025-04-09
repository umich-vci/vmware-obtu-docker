#!/bin/bash

if [ ! -z "${DOWNLOAD_TOKEN}" ]; then
    # Inject the token into the downloadConfig.xml this way in case it is a bind mount
    sed "s/REPLACETOKENHERE/${DOWNLOAD_TOKEN}/g" /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties > /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties.temp
    cat /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties.temp > /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties
    
    sed -i "s/REPLACETOKENHERE/${DOWNLOAD_TOKEN}/g" /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties.tmpl
fi

if [ ! -s /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties ]; then
  cp /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties.tmpl /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties
fi

cd /opt/vmware/vcf/lcm/lcm-tools/bin
bash ./lcm-bundle-transfer-util $@
