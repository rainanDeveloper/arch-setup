# Rainan's Arch Linux post install recomendations
---

## Install

First, boot your default arch linux installation image, setup basic things to be able to install properly (basic network, keyboard, etc):

set keyboard:


```sh
loadkeys br-abnt2
```

connect to network (if wifi):

scan for networks:

```sh
iwctl
```

```sh
device list            # lists wifi devices
station wlan0 scan     # scans for networks (replace wlan0 with your device)
station wlan0 get-networks
station wlan0 connect YOUR_SSID
```

Now, locate your installation device:

```
lsblk
```

and finally, use the `cfdisk` to partition your installation device accordingly to your needs:

```sh
cfdisk your_partition
```
