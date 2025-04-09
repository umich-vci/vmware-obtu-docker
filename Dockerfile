FROM ubuntu:20.04 AS base

RUN --mount=type=bind,source=lcm-tools-prod.tar.gz,target=/tmp/lcm-tools-prod.tar.gz \
   apt update && apt upgrade -y && apt install -y ca-certificates && \
   mkdir -p /opt/vmware/vcf/lcm/lcm-tools && \
   tar zxf /tmp/lcm-tools-prod.tar.gz --directory=/opt/vmware/vcf/lcm/lcm-tools && \
   chmod +x /opt/vmware/vcf/lcm/lcm-tools/bin/lcm-bundle-transfer-util && \
   sed -i 's/\(lcm.depot.adapter.host=\)depot.vmware.com/\1dl.broadcom.com/' /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties && \
   sed -i 's/\(lcm.depot.adapter.remote.rootDir=\)\/PROD2/\1\/REPLACETOKENHERE\/PROD/' /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties && \
   sed -i 's/\(lcm.depot.adapter.remote.repoDir=\)\/evo\/vmw/\1\/COMP\/SDDC_MANAGER_VCF/' /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties && \
   sed -i 's/\(lcm.depot.adapter.remote.lcmManifestDir=\)\/evo\/vmw\/lcm\/manifest/\1\/COMP\/SDDC_MANAGER_VCF\/lcm\/manifest/' /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties && \
   sed -i 's/\(lcm.depot.adapter.remote.bundletransferconfig.repoDir:\)\/evo\/vmw\/obtu/\1\/COMP\/SDDC_MANAGER_VCF\/obtu/' /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties && \
   cp /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties /opt/vmware/vcf/lcm/lcm-tools/conf/application-prod.properties.tmpl

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["--help"]
