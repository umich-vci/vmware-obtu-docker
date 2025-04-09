# Dockerfile for VMware VCF Offline Bundle Transfer Utility

## Build Instructions
Get the OBTU tar.gz from the Broadcom support portal.  I have tested:
* Version 5.2 with SHA2 4e71a7d154425a2b315349353fd4761ec5981600d62c5ddf8c388b843ddff4bb

Then, build the image with something like this:
```
docker build -t vmware-obtu:5.2 .
```

If you are building on an ARM based Mac, you'll need to add `--platform linux/amd64` to the build command.

## Run Instructions

The image directly runs the lcm-bundle-transfer-util command and by default you will be shown the output of `--help`
for that command. You will need to mount a volume somewhere to make the content you have downloaded persist.

You can inject your download key to the configuration by setting the environment variable DOWNLOAD_TOKEN.
```
docker run --rm -it -e DOWNLOAD_TOKEN=yourTokenHere vmware-obtu:5.2
```
