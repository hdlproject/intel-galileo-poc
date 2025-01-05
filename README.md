# Intel Galileo Proof of Concept

### Update firmware
Follow the instructions on this [document](galileo_fw_tool-userguide.pdf).

### Build and run image build
```shell
$ docker build -f image-build.Dockerfile -t intel-galileo-pod-image-build .
$ docker run --name intel-galileo-pod-image-build intel-galileo-pod-image-build
```

### Debugging image build
```shell
$ docker run --name intel-galileo-pod-image-build intel-galileo-pod-image-build tail -f /dev/null
$ docker exec -it intel-galileo-pod-image-build bash
```

### Write bootable SD card
```shell
$ diskutil list
$ diskutil unmountDisk <disk name (e.g /dev/disk6)>
$ sudo dd if=<.img file path> of=<disk name> bs=1m
$ diskutil eject <disk name>
```

### Debug via serial port
```shell
$ brew install screen
$ ls /dev/tty.*
$ screen /dev/tty.usbmodem114301 115200
```

## TODO
- Check this error when executing `bitbake core-image-minimal`
    ```
    ERROR:  OE-core's config sanity checker detected a potential misconfiguration.
        Either fix the cause of this error or at your own risk disable the checker (see sanity.conf).
        Following is the list of potential problems / advisories:
    
        Do not use Bitbake as root.
    ```
  
