# ABOUT THE PROGRAM:
## License summary:
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

# Description:
This is a command line download manager, which uses nohup, wget, and a custom directory structure with logs to manage downloads.  Downloads can be added, paused, and removed from the command line, and you can create custom download schedules by combining this program with the crontab file.  See the Examples section for details.

# INSTALLATION:
You can install this program either as root, or as an ordinary user.

If you install as root, then every user will have access to the program.  The user will be prompted to create the directory structure if it is not already created.

If you install as yourself (ordinary user), then only you will have access to the program.

## INSTALLATION AS ROOT
You can always just run install.sh, but for details or manual installation, read below:

1. Download the tarball
2. Go to the "downloadmanager" directory
3. Edit the "downloads" file, and set the appropriate value for BASEDIR.  If installing as root, you can leave it as it is.  The BASEDIR variable is set to $HOME/downloadmanager, which should be find for most users.
4. Copy the "downloads" script to /usr/local/bin:
```
	cp ./downloads /usr/local/bin
```

5. Make sure that the script is executable
```
	chmod a+x /usr/local/bin/downloads
```
6. Thats it!

## INSTALLATION AS AN ORDINARY USER
1. Download the tarball
2. Make untar the tarball in a directory you have appropriate permissions in ($HOME/bin for example)
3. Go to the "downloadmanager" directory
4. Edit the "downloads" file, and set the appropriate value for BASEDIR (e.g. full path to downloadmanager directory)
(for example, if you have extracted the tarball to /home/tomdickandharry/downloadmanager, you would set BASEDIR to /home/tomdickandharry/downloadmanager)
Also, make sure that you have /bin/bash installed.  If you don't, set the appropriate shell: I have not tested with anything else though)
5. Thats it!

## POST INSTALLATION CONFIGURATION (Making life easier for yourself) (Not necessary if you installed the program as root)

You know that you will have to cd into the directory where you have the program and run it.  A better thing to do would be to create a link to that program in your own $HOME/bin.  For example,

```
[tomdickandharry@myownlinuxcomputer ~] ln -s /home/tomdickandharry/downloadmanager/downloads /home/tomdickandharry/bin

Usage: type "downloads -h" for details
```


# DIRECTORY AND FILE STRUCTURE:
BASEDIR: base directory of installation
downloads: download manager program
unsorted_downloads: location where downloaded files are stored by default (i.e. no download directory is specified)
downloadlogs: location where different download logs are stored
	downloads.log: master log file for downloadmanager
	completedlogs: log of succesfully completed downloads
	problemlogs: log of downloads that have been aborted for various reasons, or unsucessful
	progresslogs: log of downloads in progress (or paused) currently
	removedlogs: log of downloads that have been cancelled by the user


# EXAMPLES
## Adding a download (save location specified)
```
[tomdickandharry@mylinuxcomputer ~]# downloads -n /home/tomdickandharry/downloads,http://opensource.wlink.com.np/freebsd/ISO-images-i386/6.1/6.1-RELEASE-i386-disc1.iso
location: /home/tomdickandharry/downloads
 url: http://opensource.wlink.com.np/freebsd/ISO-images-i386/6.1/6.1-RELEASE-i386-disc1.iso
 going to add...
 Starting download of 6.1-RELEASE-i386-disc1.iso
 Filename: 6.1-RELEASE-i386-disc1.iso
 Save location: /home/tomdickandharry/downloads
 URL: http://opensource.wlink.com.np/freebsd/ISO-images-i386/6.1/6.1-RELEASE-i386-disc1.iso
```

## Adding a download (save location not specified)
```
[tomdickandharry@mylinuxcomputer ~]# downloads -n http://opensource.wlink.com.np/freebsd/ISO-images-i386/6.1/6.1-RELEASE-i386-disc1.iso
location: /home/tomdickandharry/downloadmanager/unsorted_downloads
 url: http://opensource.wlink.com.np/freebsd/ISO-images-i386/6.1/6.1-RELEASE-i386-disc1.iso
 going to add...
 Starting download of 6.1-RELEASE-i386-disc1.iso
 Filename: 6.1-RELEASE-i386-disc1.iso
 Save location: /home/tomdickandharry/downloadmanager/unsorted_downloads
 URL: http://opensource.wlink.com.np/freebsd/ISO-images-i386/6.1/6.1-RELEASE-i386-disc1.iso
 ```


## Checking the status of currently ongoing downloads
```
 [tomdickandharry@mylinuxcomputer ~]# downloads -s
 Currently running downloads:
 PID             File                    Percentage              Speed
```

## Removing an ongoing download
```
 5237            6.1-RELEASE-i386-disc1.iso              0%                117.43 KB/s
 [tomdickandharry@mylinuxcomputer ~]# downloads -k 6.1-RELEASE-i386-disc1.iso
 Checking if there are any downloads to stop...

 stopping download for 6.1-RELEASE-i386-disc1.iso

 done
```

## Scheduling downloads using crontab (use crontab -e if you are not root)
```
Example /etc/crontab entry:
#start downloads at 12:00 am
00 00 * * * root /root/bin/downloads -g

#stop at 9:00 am
00 09 * * * root /root/bin/downloads -k

#Start downloads again at 5:00 pm
00 17 * * * root /root/bin/downloads -g

#till 7:30 pm
30 19 * * * root /root/bin/downloads -k
```

Have fun, I hope this program is useful!
