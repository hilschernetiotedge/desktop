## Edge Gateway for the IT/OT convergence - NIOT-E-TIJCX-GB

For platform details read on [here](https://www.netiot.com/netiot/netiot-edge/).

### Ubuntu with X.org display server and desktop Xfce

Base of this image builds a tagged version of [ubuntu](https://hub.docker.com/r/library/ubuntu/tags/16.04/) with installed display server [X.org](https://en.wikipedia.org/wiki/X.Org_Server) enabling the device's DVI port plus the desktop environment [Xfce](https://www.xfce.org/?lang=en) turning the device in a desktop computer with mouse and keyboard support. 

### Container prerequisites

#### Host devices

The display server needs access to the following gateway's host devices:
 * console tty0 
 * console tty2 
 * frame buffer fb0
 * input devices inputs
 * Direct Rendering Manager dri
 * VGA arbiter vga_arbiter
 
#### Privileged mode

Starting the X11 server needs full access to the /dev devices mentioned above, else the error "Fatal server error: AddScreen/ScreenInit failed for driver 0" is reported durind start. Only the privileged mode lifts the enforced device cgroups limitations.

### Container start

Pulling the image from Docker Hub may take up to 5 minutes average. 

#### On NIOT-E-TIJCX-GB-RE

STEP 1. Open NIOT-E-TIJCX-GB-RE's landing page under `https://<gateways's ip address>`. 

STEP 2. Click the Docker tile to open the [Portainer.io](http://portainer.io/) Docker management user interface. 

STEP 3. Enter the following parameters under **Containers > Add Container**

* **Image**: `hilschernetiotedge/netiot-edge-desktop-dvi`

* **Restart policy"**: `always`

* **Runtime > Devices > add device**: `Host "/dev/tty0" -> Container "/dev/tty0"`and`Host "/dev/tty2" -> Container "/dev/tty2"`and`Host "/dev/fb0" -> Container "/dev/fb0"`and`Host "/dev/input" -> Container "/dev/input"`and`Host "/dev/dri" -> Container "/dev/dri"`and`Host "/dev/vga_arbiter" -> Container "/dev/vga_arbiter"`

* **Runtime > Privileged mode**: `On`

STEP 4. Press the button **Actions > Start container**

### GitHub sources
The image is built from the GitHub project [desktop](https://github.com/hilschernetiotedge/desktop). It complies with the [Dockerfile](https://docs.docker.com/engine/reference/builder/) method to build a Docker image [automated](https://docs.docker.com/docker-hub/builds/). 

View the license information for the software in the Github project. As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained). As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

[![N|Solid](http://www.hilscher.com/fileadmin/templates/doctima_2013/resources/Images/logo_hilscher.png)](http://www.hilscher.com)  Hilscher Gesellschaft fuer Systemautomation mbH  www.hilscher.com
