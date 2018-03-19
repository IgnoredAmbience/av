Start slave jack with:
  jackd -R -d net -C 0 -P 4

Start mics with:
  zita-a2j -d hw:0 -c 1 -p 256 -Q 16
  jack_connect zita-a2j:capture_1 system:playback_1
  ...

Server netmanager must be loaded after slaves are online.

Random network dropout experienced. Needed to restart master to get slave to reconnect.
Automatic rewiring of slave inputs and outputs would be helpful to prevent too much human overhead.
Session manager/remote dbus?

TODO:
* Investigate NSM for multi-server management.
* Investigate mapping audio hw id to usb port id, for stable connections
  * ATTRS searches given device and parent tree
  * ATTRS{devnum} and ATTRS{devpath} are candidates -- test stability
  * ATTR{id} can be used on root sound device to set name -- see http://www.alsa-project.org/main/index.php/Changing_card_IDs_with_udev
* Jack/NSM systemd configurations. (zita-a2j through systemd or NSM?)
* Noise / feedback suppression.
* Audio pathing / mixing.
* Video pathing.
* Windows support(!) -- 3.5mm audio in is an option.
* Prepare a bootable Arch Linux USB stick.
* Request a laptop from CSG.

