Dumps decrypted iPhone Applications to a file - better solution than those GDB scripts for non working GDB versions
(C) Copyright 2011-2014 Stefan Esser

## Prerequisite:
- Bingner/Elucubratus
    - clang-10
    - Make
    - Darwin CC Tools

## Note:
- Don't do stuff in `/private/var` (ie. put dumpdecrypted.dylib somewhere else like /usr/lib/dumpdecrypted)
    - Source: [link](https://www.reddit.com/r/jailbreak/comments/8kl7uf/question_does_anybody_else_here_have_issues_with/dz8hrvb)
    - This also applies to the executable you are decrypting, since applications are now in `/private/var/containers/Bundle/Application` ...
- After running `make`, don't forget to sign the dylib with `ldid`!
    - Source: [link](https://github.com/pwn20wndstuff/Undecimus/issues/798#issuecomment-542863585)
    - With substitute, this should work. For substrate, locate `signcert.p12` (likely in `/usr/share/jailbreak` instead)
        - `$ ldid -K/usr/share/substitute/signcert.p12 -S dumpdecrypted.dylib`
    - There should be no output upon success.

## Compile:

First adjust the Makefile if you have a different iOS SDK installed. It points to `/usr/share/SDKs/iPhoneOS.sdk` by default. 
I got the patched SDK from [here](https://github.com/xybp888/iOS-SDKs), then renamed it to just iPhoneOS.sdk. If you get problems with
symlinks (maybe due to WSL), this did the trick for me:

`$ tar -hcf - iPhoneOS13.4.sdk | tar -xf - -C /mnt/c/blah/blah/blah` 


And then just:

`$ make`


## Usage:

```
iPod:~ root# DYLD_INSERT_LIBRARIES=dumpdecrypted.dylib /copied/app/directory/Music.app/Music

mach-o decryption dumper


DISCLAIMER: This tool is only meant for security research purposes, not for application crackers.


[+] Found encrypted data at address 00002000 of length 1826816 bytes - type 1.
[+] Opening /copied/app/directory/Music.app/Music for reading.
[+] Reading header
[+] Detecting header type
[+] Executable is a FAT image - searching for right architecture
[+] Correct arch is at offset 2408224 in the file
[+] Opening Scan.decrypted for writing.
[-] Failed opening. Most probably a sandbox issue. Trying something different.
[+] Opening /copied/app/directory/Music.decrypted for writing.
[+] Copying the not encrypted start of the file
[+] Dumping the decrypted data into the file
[+] Copying the not encrypted remainder of the file
[+] Closing original file
[+] Closing dump file
```
