
Easiest install is from w/i osx, download/unzip then boot in recovery mode to install (due to SIP).
Ref:
 - http://www.rodsbooks.com/refind/installing.html#installsh
 - https://wiki.archlinux.org/index.php/Mac#Installation
 
Gotcha:
  You need to install refind *after* installing arch, also, install w/ the option `--alldrivers` then mount the ESP vol via 
  ```
  $ mkdir /Volumes/efi
  $ sudo mount -t msdos /dev/<mountVol> /Volumes/efi
  ```
and remove the unnecessary drivers from `/Volumes/efi/EFI/refind/..`
