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
* Noise / feedback suppression.
* Audio pathing / mixing.
* Video pathing.
* Windows support(!) -- 3.5mm audio in is an option.
* Prepare a bootable Arch Linux USB stick.

