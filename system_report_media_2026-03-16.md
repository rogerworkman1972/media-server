# Server System & ZFS Report
**Generated on:** Mon Mar 16 19:13:48 EDT 2026

## 1. System Information
```text
Hostname: media
OS: Ubuntu 25.10
Kernel: 6.17.0-19-generic
Uptime & Load:
 19:13:48 up  1:10,  1 user,  load average: 8.12, 7.59, 6.64
```

## 2. Hardware Resources (CPU & RAM)
### Memory (RAM)
```text
               total        used        free      shared  buff/cache   available
Mem:           121Gi        32Gi        69Gi       1.5Gi        23Gi        89Gi
Swap:          8.0Gi          0B       8.0Gi
```
### CPU Summary
```text
CPU(s):                                  48
On-line CPU(s) list:                     0-47
Model name:                              Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz
Thread(s) per core:                      2
Core(s) per socket:                      12
Socket(s):                               2
CPU(s) scaling MHz:                      76%
NUMA node(s):                            2
NUMA node0 CPU(s):                       0-11,24-35
NUMA node1 CPU(s):                       12-23,36-47
```

## 3. NUMA Topology & Statistics
```text
--- NUMA Hardware ---
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 24 25 26 27 28 29 30 31 32 33 34 35
node 0 size: 64152 MB
node 0 free: 33584 MB
node 1 cpus: 12 13 14 15 16 17 18 19 20 21 22 23 36 37 38 39 40 41 42 43 44 45 46 47
node 1 size: 60359 MB
node 1 free: 37095 MB
node distances:
node     0    1 
   0:   10   21 
   1:   21   10 

--- NUMA Statistics ---
                           node0           node1
numa_hit               118843870        80581227
numa_miss                      2               0
numa_foreign                   0               2
interleave_hit              4032            4336
local_node             118830781        80226658
other_node                 22155          366581
```

## 4. Storage, Block, & PCI Devices
### Block Devices
```text
NAME     SIZE FSTYPE     TYPE MOUNTPOINT
sda      1.9T            disk 
├─sda1     1G vfat       part /boot/efi
└─sda2   1.9T ext4       part /
sdb      9.1T            disk 
├─sdb1   9.1T zfs_member part 
└─sdb9     8M            part 
sdc    953.9G            disk 
└─sdc1 953.9G xfs        part /mnt/ssd-cache
sdd      1.8T            disk 
├─sdd1   1.8T zfs_member part 
└─sdd9     8M            part 
sde      9.1T            disk 
├─sde1   9.1T zfs_member part 
└─sde9     8M            part 
sdf      1.9T            disk 
├─sdf1   1.9T zfs_member part 
└─sdf9     8M            part 
sdg      9.1T            disk 
├─sdg1   9.1T zfs_member part 
└─sdg9    64M            part 
sdh      1.8T            disk 
├─sdh1   1.8T zfs_member part 
└─sdh9     8M            part 
sdi      9.1T            disk 
├─sdi1   9.1T zfs_member part 
└─sdi9    64M            part 
sdj      1.8T            disk 
├─sdj1   1.8T zfs_member part 
└─sdj9     8M            part 
```
### Critical PCI Devices (Storage & Network)
```text
00:1f.2 SATA controller: Intel Corporation C600/X79 series chipset 6-Port SATA AHCI Controller (rev 06)
02:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
02:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
05:00.0 Serial Attached SCSI controller: Broadcom / LSI SAS2308 PCI-Express Fusion-MPT SAS-2 (rev 05)
07:00.0 Serial Attached SCSI controller: Intel Corporation C602 chipset 4-Port SATA Storage Control Unit (rev 06)
```

## 5. ZFS Pool Status
```text
  pool: backup-tank
 state: ONLINE
status: Some supported and requested features are not enabled on the pool.
	The pool can still be used, but some features are unavailable.
action: Enable all features using 'zpool upgrade'. Once this is done,
	the pool may no longer be accessible by software that does not support
	the features. See zpool-features(7) for details.
  scan: scrub repaired 0B in 01:16:59 with 0 errors on Sun Mar  8 01:41:01 2026
config:

	NAME                      STATE     READ WRITE CKSUM
	backup-tank               ONLINE       0     0     0
	  wwn-0x5000cca26af37d9e  ONLINE       0     0     0

errors: No known data errors

  pool: media-tank
 state: ONLINE
status: Some supported and requested features are not enabled on the pool.
	The pool can still be used, but some features are unavailable.
action: Enable all features using 'zpool upgrade'. Once this is done,
	the pool may no longer be accessible by software that does not support
	the features. See zpool-features(7) for details.
  scan: resilvered 99.7M in 00:00:02 with 0 errors on Wed Mar 11 11:33:41 2026
config:

	NAME                        STATE     READ WRITE CKSUM
	media-tank                  ONLINE       0     0     0
	  raidz1-0                  ONLINE       0     0     0
	    wwn-0x5002538636205a7f  ONLINE       0     0     0
	    wwn-0x500000000000292c  ONLINE       0     0     0
	    wwn-0x5002538f7081ba98  ONLINE       0     0     0
	    wwn-0x5002538e9970da57  ONLINE       0     0     0

errors: No known data errors

  pool: music-tank
 state: ONLINE
status: Some supported and requested features are not enabled on the pool.
	The pool can still be used, but some features are unavailable.
action: Enable all features using 'zpool upgrade'. Once this is done,
	the pool may no longer be accessible by software that does not support
	the features. See zpool-features(7) for details.
  scan: resilvered 12.5G in 00:01:17 with 0 errors on Wed Mar 11 15:49:50 2026
config:

	NAME                        STATE     READ WRITE CKSUM
	music-tank                  ONLINE       0     0     0
	  raidz1-0                  ONLINE       0     0     0
	    wwn-0x5000cca273d16462  ONLINE       0     0     0
	    wwn-0x5000cca273cbeb2a  ONLINE       0     0     0
	    wwn-0x5000cca266deada3  ONLINE       0     0     0

errors: No known data errors

NAME          SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
backup-tank  9.09T   714G  8.40T        -         -     1%     7%  1.00x    ONLINE  -
media-tank   7.27T   835G  6.45T        -         -    24%    11%  1.00x    ONLINE  -
music-tank   27.3T  37.4G  27.2T        -         -     0%     0%  1.00x    ONLINE  -
```

## 6. ZFS Datasets & Top-Level Properties
```text
NAME                                  USED  AVAIL  REFER  MOUNTPOINT
backup-tank                           714G  8.27T  58.9G  /mnt/backup
backup-tank/media-mirror              630G  8.27T   319G  /mnt/backup/media-mirror
backup-tank/media-mirror/mysql       11.3M  8.27T  2.68M  /mnt/backup/media-mirror/mysql
backup-tank/media-mirror/postgres    10.1G  8.27T  2.81G  /mnt/backup/media-mirror/postgres
backup-tank/music-mirror             24.9G  8.27T  24.9G  /mnt/backup/music-mirror
backup-tank/music-mirror/audiobooks   608K  8.27T   504K  /mnt/backup/music-mirror/audiobooks
backup-tank/ssd-cache-mirror           96K  8.27T    96K  /mnt/backup/ssd-cache-mirror
media-tank                            607G  4.56T   313G  /mnt/media
media-tank/docker                    6.96G  4.56T  6.89G  /var/lib/docker
media-tank/mysql                     18.7M  4.56T  3.88M  /mnt/media/mysql
media-tank/postgres                  14.3G  4.56T  3.81G  /mnt/media/postgres
media-tank/server-configs             773K  4.56T   657K  /mnt/media/server-configs
music-tank                           24.9G  18.0T  24.9G  /mnt/music-tank
music-tank/audiobooks                 810K  18.0T   671K  /mnt/music-tank/audiobooks

--- Top-Level Properties ---
NAME         PROPERTY              VALUE                  SOURCE
backup-tank  type                  filesystem             -
backup-tank  creation              Thu Feb 26 15:15 2026  -
backup-tank  used                  714G                   -
backup-tank  available             8.27T                  -
backup-tank  referenced            58.9G                  -
backup-tank  compressratio         1.20x                  -
backup-tank  mounted               yes                    -
backup-tank  quota                 none                   default
backup-tank  reservation           none                   default
backup-tank  recordsize            1M                     local
backup-tank  mountpoint            /mnt/backup            local
backup-tank  sharenfs              off                    default
backup-tank  checksum              on                     default
backup-tank  compression           lz4                    local
backup-tank  atime                 off                    local
backup-tank  devices               on                     default
backup-tank  exec                  on                     default
backup-tank  setuid                on                     default
backup-tank  readonly              off                    default
backup-tank  zoned                 off                    default
backup-tank  snapdir               hidden                 default
backup-tank  aclmode               discard                default
backup-tank  aclinherit            restricted             default
backup-tank  createtxg             1                      -
backup-tank  canmount              on                     default
backup-tank  xattr                 on                     local
backup-tank  copies                1                      default
backup-tank  version               5                      -
backup-tank  utf8only              off                    -
backup-tank  normalization         none                   -
backup-tank  casesensitivity       sensitive              -
backup-tank  vscan                 off                    default
backup-tank  nbmand                off                    default
backup-tank  sharesmb              off                    default
backup-tank  refquota              none                   default
backup-tank  refreservation        none                   default
backup-tank  guid                  14535157725148123107   -
backup-tank  primarycache          all                    default
backup-tank  secondarycache        all                    default
backup-tank  usedbysnapshots       0B                     -
backup-tank  usedbydataset         58.9G                  -
backup-tank  usedbychildren        655G                   -
backup-tank  usedbyrefreservation  0B                     -
backup-tank  logbias               latency                default
backup-tank  objsetid              54                     -
backup-tank  dedup                 off                    default
backup-tank  mlslabel              none                   default
backup-tank  sync                  standard               default
backup-tank  dnodesize             legacy                 default
backup-tank  refcompressratio      1.11x                  -
backup-tank  written               58.9G                  -
backup-tank  logicalused           841G                   -
backup-tank  logicalreferenced     64.9G                  -
backup-tank  volmode               default                default
backup-tank  filesystem_limit      none                   default
backup-tank  snapshot_limit        none                   default
backup-tank  filesystem_count      none                   default
backup-tank  snapshot_count        none                   default
backup-tank  snapdev               hidden                 default
backup-tank  acltype               off                    default
backup-tank  context               none                   default
backup-tank  fscontext             none                   default
backup-tank  defcontext            none                   default
backup-tank  rootcontext           none                   default
backup-tank  relatime              on                     default
backup-tank  redundant_metadata    all                    default
backup-tank  overlay               on                     default
backup-tank  encryption            off                    default
backup-tank  keylocation           none                   default
backup-tank  keyformat             none                   default
backup-tank  pbkdf2iters           0                      default
backup-tank  special_small_blocks  0                      default
backup-tank  prefetch              all                    default
backup-tank  direct                standard               default
backup-tank  longname              off                    default
NAME        PROPERTY              VALUE                     SOURCE
media-tank  type                  filesystem                -
media-tank  creation              Wed Jan 21 10:14 2026     -
media-tank  used                  607G                      -
media-tank  available             4.56T                     -
media-tank  referenced            313G                      -
media-tank  compressratio         1.19x                     -
media-tank  mounted               yes                       -
media-tank  quota                 none                      default
media-tank  reservation           none                      default
media-tank  recordsize            1M                        local
media-tank  mountpoint            /mnt/media                local
media-tank  sharenfs              off                       default
media-tank  checksum              on                        default
media-tank  compression           lz4                       local
media-tank  atime                 off                       local
media-tank  devices               on                        default
media-tank  exec                  on                        default
media-tank  setuid                on                        default
media-tank  readonly              off                       default
media-tank  zoned                 off                       default
media-tank  snapdir               hidden                    default
media-tank  aclmode               discard                   default
media-tank  aclinherit            restricted                default
media-tank  createtxg             1                         -
media-tank  canmount              on                        default
media-tank  xattr                 on                        local
media-tank  copies                1                         default
media-tank  version               5                         -
media-tank  utf8only              off                       -
media-tank  normalization         none                      -
media-tank  casesensitivity       sensitive                 -
media-tank  vscan                 off                       default
media-tank  nbmand                off                       default
media-tank  sharesmb              off                       default
media-tank  refquota              none                      default
media-tank  refreservation        none                      default
media-tank  guid                  8175160439354995803       -
media-tank  primarycache          all                       default
media-tank  secondarycache        all                       default
media-tank  usedbysnapshots       272G                      -
media-tank  usedbydataset         313G                      -
media-tank  usedbychildren        21.8G                     -
media-tank  usedbyrefreservation  0B                        -
media-tank  logbias               latency                   default
media-tank  objsetid              54                        -
media-tank  dedup                 off                       default
media-tank  mlslabel              none                      default
media-tank  sync                  standard                  local
media-tank  dnodesize             legacy                    default
media-tank  refcompressratio      1.17x                     -
media-tank  written               799M                      -
media-tank  logicalused           717G                      -
media-tank  logicalreferenced     368G                      -
media-tank  volmode               default                   default
media-tank  filesystem_limit      none                      default
media-tank  snapshot_limit        none                      default
media-tank  filesystem_count      none                      default
media-tank  snapshot_count        none                      default
media-tank  snapdev               hidden                    default
media-tank  acltype               posix                     local
media-tank  context               none                      default
media-tank  fscontext             none                      default
media-tank  defcontext            none                      default
media-tank  rootcontext           none                      default
media-tank  relatime              on                        default
media-tank  redundant_metadata    all                       default
media-tank  overlay               on                        default
media-tank  encryption            off                       default
media-tank  keylocation           none                      default
media-tank  keyformat             none                      default
media-tank  pbkdf2iters           0                         default
media-tank  special_small_blocks  0                         default
media-tank  snapshots_changed     Mon Mar 16 19:00:32 2026  -
media-tank  prefetch              all                       default
media-tank  direct                standard                  default
media-tank  longname              off                       default
NAME        PROPERTY              VALUE                     SOURCE
music-tank  type                  filesystem                -
music-tank  creation              Tue Mar 10 13:41 2026     -
music-tank  used                  24.9G                     -
music-tank  available             18.0T                     -
music-tank  referenced            24.9G                     -
music-tank  compressratio         1.01x                     -
music-tank  mounted               yes                       -
music-tank  quota                 none                      default
music-tank  reservation           none                      default
music-tank  recordsize            1M                        local
music-tank  mountpoint            /mnt/music-tank           local
music-tank  sharenfs              off                       default
music-tank  checksum              on                        default
music-tank  compression           on                        default
music-tank  atime                 off                       local
music-tank  devices               on                        default
music-tank  exec                  on                        default
music-tank  setuid                on                        default
music-tank  readonly              off                       default
music-tank  zoned                 off                       default
music-tank  snapdir               hidden                    default
music-tank  aclmode               discard                   default
music-tank  aclinherit            restricted                default
music-tank  createtxg             1                         -
music-tank  canmount              on                        default
music-tank  xattr                 on                        local
music-tank  copies                1                         default
music-tank  version               5                         -
music-tank  utf8only              off                       -
music-tank  normalization         none                      -
music-tank  casesensitivity       sensitive                 -
music-tank  vscan                 off                       default
music-tank  nbmand                off                       default
music-tank  sharesmb              off                       default
music-tank  refquota              none                      default
music-tank  refreservation        none                      default
music-tank  guid                  17428345860237916476      -
music-tank  primarycache          all                       default
music-tank  secondarycache        all                       default
music-tank  usedbysnapshots       0B                        -
music-tank  usedbydataset         24.9G                     -
music-tank  usedbychildren        5.71M                     -
music-tank  usedbyrefreservation  0B                        -
music-tank  logbias               latency                   default
music-tank  objsetid              54                        -
music-tank  dedup                 off                       default
music-tank  mlslabel              none                      default
music-tank  sync                  standard                  default
music-tank  dnodesize             legacy                    default
music-tank  refcompressratio      1.01x                     -
music-tank  written               0                         -
music-tank  logicalused           25.3G                     -
music-tank  logicalreferenced     25.3G                     -
music-tank  volmode               default                   default
music-tank  filesystem_limit      none                      default
music-tank  snapshot_limit        none                      default
music-tank  filesystem_count      none                      default
music-tank  snapshot_count        none                      default
music-tank  snapdev               hidden                    default
music-tank  acltype               off                       default
music-tank  context               none                      default
music-tank  fscontext             none                      default
music-tank  defcontext            none                      default
music-tank  rootcontext           none                      default
music-tank  relatime              on                        default
music-tank  redundant_metadata    all                       default
music-tank  overlay               on                        default
music-tank  encryption            off                       default
music-tank  keylocation           none                      default
music-tank  keyformat             none                      default
music-tank  pbkdf2iters           0                         default
music-tank  special_small_blocks  0                         default
music-tank  snapshots_changed     Mon Mar 16 19:00:04 2026  -
music-tank  prefetch              all                       default
music-tank  direct                standard                  default
music-tank  longname              off                       default
```

## 7. ZFS ARC & Performance
```text
--- ARC Statistics ---
    time  read  ddread  ddh%  dmread  dmh%  pread  ph%   size      c  avail
19:13:48     6       4   100       2   100      0    0  20.6G  21.3G  81.1G

--- ZPool I/O Stats ---
                              capacity     operations     bandwidth 
pool                        alloc   free   read  write   read  write
--------------------------  -----  -----  -----  -----  -----  -----
backup-tank                  714G  8.40T      0      0    898  1.84K
  wwn-0x5000cca26af37d9e     714G  8.40T      0      0    898  1.84K
--------------------------  -----  -----  -----  -----  -----  -----
media-tank                   835G  6.45T     96    184  2.81M  7.90M
  raidz1-0                   835G  6.45T     96    184  2.81M  7.90M
    wwn-0x5002538636205a7f      -      -     27     53   724K  1.98M
    wwn-0x500000000000292c      -      -     23     50   704K  1.97M
    wwn-0x5002538f7081ba98      -      -     23     39   742K  1.98M
    wwn-0x5002538e9970da57      -      -     21     40   711K  1.97M
--------------------------  -----  -----  -----  -----  -----  -----
music-tank                  37.4G  27.2T      0      0  1.69K  5.44K
  raidz1-0                  37.4G  27.2T      0      0  1.69K  5.44K
    wwn-0x5000cca273d16462      -      -      0      0    598  1.81K
    wwn-0x5000cca273cbeb2a      -      -      0      0    566  1.81K
    wwn-0x5000cca266deada3      -      -      0      0    571  1.82K
--------------------------  -----  -----  -----  -----  -----  -----
```

## 8. Network Interfaces & Routing
```text
--- Interfaces ---
lo               UNKNOWN        127.0.0.1/8 ::1/128 
enp2s0f0         UP             
enp2s0f1         UP             
bond0            UP             10.136.150.13/24 metric 100 fe80::14da:6aff:fea9:3c7c/64 
ztsjscgwc2       UNKNOWN        10.183.36.88/24 fe80::c09c:dbff:fe84:34a/64 
br-70d33ce9bb89  UP             172.18.0.1/16 fe80::902d:93ff:fec7:571c/64 
docker0          DOWN           172.17.0.1/16 
vethc0d4afe@if2  UP             fe80::74e8:beff:fefe:aa98/64 
vethcc7d1ef@if2  UP             fe80::84a3:a5ff:fefe:2a1c/64 
veth395c37b@if2  UP             fe80::3877:94ff:fecf:2183/64 
vetheeefb88@if2  UP             fe80::a874:7aff:fedd:4674/64 
veth9cebc1d@if2  UP             fe80::ec3c:2eff:fed7:f6a8/64 
veth48b0c97@if2  UP             fe80::54a4:edff:fedd:51c/64 
vethff2b5c4@if2  UP             fe80::ecc0:b2ff:fe95:c7c0/64 
vetha9c7843@if2  UP             fe80::7c68:37ff:fed3:23b3/64 
vethd32cdd3@if2  UP             fe80::9836:f4ff:fe71:1935/64 
vethb61c6b6@if2  UP             fe80::bc2f:3aff:fe97:88f1/64 
veth32ec08a@if2  UP             fe80::ccb2:99ff:fe29:cd6a/64 
vethdb4cd83@if2  UP             fe80::481:9bff:fe88:9124/64 
veth0593b59@if2  UP             fe80::b445:28ff:fe8d:7ac7/64 
vethce405ae@if2  UP             fe80::a832:f2ff:fee0:cfd0/64 
veth8d8c999@if2  UP             fe80::9405:71ff:fe07:182a/64 
vethe4f9511@if2  UP             fe80::85a:4fff:fe9e:f027/64 

--- Routes ---
default via 10.136.150.1 dev bond0 proto dhcp src 10.136.150.13 metric 100 
10.136.150.0/24 dev bond0 proto kernel scope link src 10.136.150.13 metric 100 
10.136.150.1 dev bond0 proto dhcp scope link src 10.136.150.13 metric 100 
10.183.36.0/24 dev ztsjscgwc2 proto kernel scope link src 10.183.36.88 
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown 
172.18.0.0/16 dev br-70d33ce9bb89 proto kernel scope link src 172.18.0.1 
```

## 9. Docker Status & Containers
```text
--- Docker Storage Usage ---
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          17        17        7.99GB    7.99GB (100%)
Containers      19        17        38.13MB   0B (0%)
Local Volumes   10        4         1.696GB   35.68MB (2%)
Build Cache     0         0         0B        0B

--- Docker Engine Config (Verifying ZFS integration) ---
 Storage Driver: overlay2
  Backing Filesystem: zfs
 Docker Root Dir: /var/lib/docker

--- Running & Stopped Containers ---
NAMES          IMAGE                                     STATUS                      PORTS
sonarr-anime   lscr.io/linuxserver/sonarr:develop        Up 48 minutes (healthy)     0.0.0.0:8990->8989/tcp, [::]:8990->8989/tcp
sonarr         lscr.io/linuxserver/sonarr:develop        Up 48 minutes (healthy)     0.0.0.0:8989->8989/tcp, [::]:8989->8989/tcp
radarr         lscr.io/linuxserver/radarr:develop        Up 48 minutes (healthy)     0.0.0.0:7878->7878/tcp, [::]:7878->7878/tcp
emby           emby/embyserver:beta                      Up 49 minutes (healthy)     1900/udp, 7359/udp, 0.0.0.0:8096->8096/tcp, [::]:8096->8096/tcp, 8920/tcp
rclone         rclone/rclone:1.73.1                      Up 49 minutes (healthy)     0.0.0.0:5572->5572/tcp, [::]:5572->5572/tcp
rclone-init    alpine:3.20                               Exited (2) 49 minutes ago   
nginx          jc21/nginx-proxy-manager:latest           Up 50 minutes (healthy)     0.0.0.0:80->80/tcp, [::]:80->80/tcp, 0.0.0.0:443->443/tcp, [::]:443->443/tcp, 127.0.0.1:81->81/tcp
prowlarr       lscr.io/linuxserver/prowlarr:develop      Up 50 minutes (healthy)     0.0.0.0:9696->9696/tcp, [::]:9696->9696/tcp
nzbdav         nzbdav/nzbdav:latest                      Up 50 minutes (healthy)     0.0.0.0:3000->3000/tcp, [::]:3000->3000/tcp
scrutiny       ghcr.io/analogj/scrutiny:master-omnibus   Up 50 minutes (healthy)     0.0.0.0:8081->8080/tcp, [::]:8081->8080/tcp
seerr          ghcr.io/seerr-team/seerr:latest           Up 50 minutes (healthy)     0.0.0.0:5055->5055/tcp, [::]:5055->5055/tcp
db-ready       alpine:3.20                               Exited (0) 50 minutes ago   
pgbouncer      edoburu/pgbouncer:latest                  Up 50 minutes (healthy)     127.0.0.1:6432->5432/tcp
soulsync       boulderbadgedad/soulsync:latest           Up 50 minutes (healthy)     0.0.0.0:8008->8008/tcp, [::]:8008->8008/tcp, 0.0.0.0:8888-8889->8888-8889/tcp, [::]:8888-8889->8888-8889/tcp
netdata        netdata/netdata:stable                    Up 50 minutes (healthy)     
webserver      nginx:alpine                              Up 50 minutes (healthy)     0.0.0.0:7050->80/tcp, [::]:7050->80/tcp
postgres       pgvector/pgvector:pg17                    Up 50 minutes (healthy)     5432/tcp
nginx-db       jc21/mariadb-aria:latest                  Up 50 minutes (healthy)     3306/tcp
slskd          slskd/slskd:latest                        Up 50 minutes (healthy)     0.0.0.0:5030->5030/tcp, [::]:5030->5030/tcp, 0.0.0.0:50300->50300/tcp, [::]:50300->50300/tcp
```

## 10. Automated Backups & ZFS Snapshots
### Sanoid Configuration (/etc/sanoid/sanoid.conf)
```ini
# ==============================================================================
# sanoid.conf — ZFS Snapshot Policy
# Media server: weekly retention is sufficient for non-critical data.
# ==============================================================================

# --- MEDIA-TANK (primary storage) ---
[media-tank]
  use_template = production
  recursive = no

[media-tank/postgres]
  use_template = database
  recursive = no

[media-tank/mysql]
  use_template = database
  recursive = no

[media-tank/server-configs]
  use_template = configs
  recursive = yes

# --- MUSIC-TANK ---
[music-tank]
  use_template = production
  recursive = yes

# --- BACKUP-TANK (syncoid replication targets — no autosnap, prune only) ---
[backup-tank/media-mirror]
  use_template = backup
  recursive = yes

[backup-tank/music-mirror]
  use_template = backup
  recursive = yes

[backup-tank/ssd-cache-mirror]
  use_template = cache_mirror
  recursive = yes

# ==============================================================================
# TEMPLATES
# ==============================================================================

[template_production]
  autosnap = yes
  autoprune = yes
  daily = 7
  weekly = 4
  monthly = 0
  yearly = 0
  daily_hour = 4
  daily_min = 0

[template_database]
  # Duplicates production values (use_template inside templates is not supported
  # by Sanoid and produces "ignored key 'use_template'" warnings)
  autosnap = yes
  autoprune = yes
  script_timeout = 300
  daily = 7
  weekly = 4
  monthly = 0
  yearly = 0
  daily_hour = 4
  daily_min = 0
  pre_snapshot_script = /opt/db-flush.sh

[template_backup]
  autosnap = no
  autoprune = yes
  daily = 7
  weekly = 4
  monthly = 0
  yearly = 0

[template_cache_mirror]
  autosnap = yes
  autoprune = yes
  daily = 7
  weekly = 0
  monthly = 0
  yearly = 0
  daily_hour = 4
  daily_min = 15

[template_configs]
  autosnap = yes
  autoprune = yes
  hourly = 24
  daily = 7
  weekly = 4
  monthly = 0
  yearly = 0
```

### Syncoid Replication Script (/opt/syncoid-run.sh)
```bash
#!/usr/bin/env bash
# ==============================================================================
# syncoid-run.sh — ZFS Replication to backup-tank
# Schedule: Cron at 04:15 AM (after Sanoid snapshots at 04:00 AM)
# ==============================================================================
set -euo pipefail

# Load .env for DISCORD_WEBHOOK_URL
ENV_FILE="/opt/.env"
if [[ -f "$ENV_FILE" ]]; then
  set -a; source "$ENV_FILE"; set +a
fi

WEBHOOK_URL="${DISCORD_WEBHOOK_URL:?DISCORD_WEBHOOK_URL must be set in .env}"
LOG="/var/log/media-backup/syncoid.log"
FAILED=0

# --- 1. Replicate media-tank (Excluding Docker System Files) ---
echo "$(date '+%Y-%m-%d %H:%M:%S') — Starting media-tank replication" >> "$LOG"
if ! /usr/sbin/syncoid -r --exclude=media-tank/docker --no-sync-snap media-tank backup-tank/media-mirror >> "$LOG" 2>&1; then
  FAILED=1
fi

# --- 2. Replicate music-tank ---
echo "$(date '+%Y-%m-%d %H:%M:%S') — Starting music-tank replication" >> "$LOG"
if ! /usr/sbin/syncoid -r --no-sync-snap music-tank backup-tank/music-mirror >> "$LOG" 2>&1; then
  FAILED=1
fi

# --- Alert on failure ---
if [[ "$FAILED" -ne 0 ]]; then
  JSON_PAYLOAD='{"content": "🚨 **URGENT:** Syncoid replication to `backup-tank` FAILED! Please check `/var/log/media-backup/syncoid.log` for details."}'
  curl -s -H "Content-Type: application/json" -d "$JSON_PAYLOAD" "$WEBHOOK_URL"
fi
```

### Sanoid Timer Status
```text
● sanoid.timer - Run Sanoid Every 15 Minutes
     Loaded: loaded (/usr/lib/systemd/system/sanoid.timer; enabled; preset: enabled)
     Active: active (waiting) since Mon 2026-03-16 18:57:17 EDT; 16min ago
 Invocation: e7f9c24a9e9e43fcba7c3fd2796b45d5
    Trigger: Mon 2026-03-16 19:15:00 EDT; 1min 10s left
   Triggers: ● sanoid.service

Mar 16 18:57:17 media systemd[1]: Stopped sanoid.timer - Run Sanoid Every 15 Minutes.
Mar 16 18:57:17 media systemd[1]: Stopping sanoid.timer - Run Sanoid Every 15 Minutes...
Mar 16 18:57:17 media systemd[1]: Started sanoid.timer - Run Sanoid Every 15 Minutes.
```

## 11. Database Pre-Snapshot Hooks
### Database Flush Script (/opt/db-flush.sh)
```bash
#!/usr/bin/env bash
# ==============================================================================
# db-flush.sh — Sanoid Pre-Snapshot Hook
# ==============================================================================
set -Eeuo pipefail

ENV_FILE="/opt/.env"

# Load .env for credentials securely
if [[ -f "$ENV_FILE" ]]; then
  set -a; source "$ENV_FILE"; set +a
else
  echo "❌ ERROR: .env not found at $ENV_FILE" >&2
  exit 1
fi

TARGET="${SANOID_TARGET:-unknown}"

is_running() {
  [[ "$(docker inspect -f '{{.State.Running}}' "$1" 2>/dev/null)" == "true" ]]
}

# 1. If Sanoid is snapping Postgres...
if [[ "$TARGET" == *"postgres"* ]]; then
  echo "Sanoid target is $TARGET — Checkpointing Postgres..."
  if is_running "postgres"; then
    if timeout 120s docker exec postgres \
      psql -U "${MASTER_USER:-admin}" -d postgres -c "CHECKPOINT;"; then
      echo "✅ Postgres checkpoint successful."
    else
      echo "⚠️ Postgres checkpoint timed out or failed."
    fi
  else
    echo "⚠️ Postgres container is not running. Skipping."
  fi

# 2. If Sanoid is snapping MySQL/MariaDB...
elif [[ "$TARGET" == *"mysql"* ]]; then
  echo "Sanoid target is $TARGET — Flushing MariaDB..."
  if is_running "nginx-db"; then
    # Added 30s timeout to prevent Sanoid from hanging/crashing
    if timeout 30s docker exec nginx-db \
      mariadb -u root -p"${NPM_MYSQL_ROOT_PASSWORD}" -e "FLUSH TABLES;"; then
      echo "✅ MariaDB flush successful."
    else
      echo "⚠️ MariaDB flush timed out or failed."
    fi
  else
    echo "⚠️ nginx-db container is not running. Skipping."
  fi

else
  echo "Ignoring target: $TARGET"
fi
```

## 12. Scheduled Tasks
### Root Crontab
```bash
# 1. Prep non-ZFS backups and push configs (runs at 3:00 AM)
0 3 * * * /opt/full-backup.sh >> /var/log/media-backup/daily.log 2>&1

# 2. Sanoid handles local ZFS snapshots automatically at 4:00 AM (configured via /etc/cron.d/sanoid or systemd)

# 3. Syncoid pushes the fresh ZFS snapshots to the backup drive (runs at 4:15 AM)
15 4 * * * /opt/syncoid-run.sh

# 4. Hourly sync of live configs to the ZFS pool (runs at minute 50)
50 * * * * rsync -a --delete /opt/ /mnt/media/server-configs/
```

## 13. Server Configuration Directory (/opt)
```text
total 188
drwxr-xr-x  6 media media  4096 Mar 16 19:13 .
drwxr-xr-x 20 root  root   4096 Mar 16 17:36 ..
-rw-rw-r--  1 media media  3451 Mar 16 10:14 .env
drwxrwxr-x  8 media media  4096 Feb 26 23:56 .git
-rw-rw-r--  1 media media     5 Feb 26 23:41 .gitignore
-rw-rw-r--  1 media media  1070 Feb 26 23:40 LICENSE
drwx--x--x  4 media media  4096 Jan 19 12:27 containerd
-rw-rw-r--  1 media media  1248 Mar 13 10:27 crontab.txt
-rwxrwxr-x  1 media media  1660 Mar 16 18:48 db-flush.sh
-rw-rw-r--  1 media media 24587 Mar 16 12:34 docker-compose.yml
-rw-rw-r--  1 media media 23657 Mar 16 08:53 docker-compose.yml.backup
-rwxrwxr-x  1 media media   348 Mar  3 08:03 docker.sh
-rwxrwxr-x  1 media media  1778 Mar  3 08:06 full-backup.sh
-rwxrwxr-x  1 media media  5214 Mar 16 19:13 generate_report.sh
-rwxrwxr-x  1 media media 18813 Mar 16 11:30 manage-stack.sh
-rwxrwxr-x  1 media media  3025 Mar 16 10:16 push_git.sh
-rw-rw-r--  1 media media  3130 Mar  1 19:04 radarr.py
drwxr-xr-x  2 media media  4096 Mar 14 22:54 sanoid-backup
-rw-rw-r--  1 media media  5217 Mar  1 08:46 sonarr.py
-rwxrwxr-x  1 media media  1390 Mar 16 18:41 syncoid-run.sh
-rw-r--r--  1 root  root  35631 Mar 16 19:13 system_report_media_2026-03-16.md
drwxr-xr-x  5 root  root   4096 Mar 14 22:54 zerotier-backup
```

## 14. Recent Kernel Warnings/Errors
```text
[Mon Mar 16 18:08:16 2026] systemd-sysv-generator[6025]: SysV service '/etc/init.d/grub-common' lacks a native systemd unit file, automatically generating a unit file for compatibility.
[Mon Mar 16 18:08:16 2026] systemd-sysv-generator[6025]: Please update package to include a native systemd unit file.
[Mon Mar 16 18:08:16 2026] systemd-sysv-generator[6025]: ! This compatibility logic is deprecated, expect removal soon. !
[Mon Mar 16 18:08:16 2026] systemd-sysv-generator[6025]: SysV service '/etc/init.d/edac' lacks a native systemd unit file, automatically generating a unit file for compatibility.
[Mon Mar 16 18:08:16 2026] systemd-sysv-generator[6025]: Please update package to include a native systemd unit file.
[Mon Mar 16 18:08:16 2026] systemd-sysv-generator[6025]: ! This compatibility logic is deprecated, expect removal soon. !
[Mon Mar 16 18:08:16 2026] systemd-sysv-generator[6025]: SysV service '/etc/init.d/openipmi' lacks a native systemd unit file, automatically generating a unit file for compatibility.
[Mon Mar 16 18:08:16 2026] systemd-sysv-generator[6025]: Please update package to include a native systemd unit file.
[Mon Mar 16 18:08:16 2026] systemd-sysv-generator[6025]: ! This compatibility logic is deprecated, expect removal soon. !
[Mon Mar 16 18:24:36 2026] kauditd_printk_skb: 182 callbacks suppressed
[Mon Mar 16 18:29:22 2026] coredump: 230420(sysctl): Unsafe core_pattern used with fs.suid_dumpable=2: pipe handler or fully qualified core dump path required. Set kernel.core_pattern before fs.suid_dumpable.
[Mon Mar 16 18:57:12 2026] systemd-sysv-generator[1602459]: SysV service '/etc/init.d/grub-common' lacks a native systemd unit file, automatically generating a unit file for compatibility.
[Mon Mar 16 18:57:12 2026] systemd-sysv-generator[1602459]: Please update package to include a native systemd unit file.
[Mon Mar 16 18:57:12 2026] systemd-sysv-generator[1602459]: ! This compatibility logic is deprecated, expect removal soon. !
[Mon Mar 16 18:57:12 2026] systemd-sysv-generator[1602459]: SysV service '/etc/init.d/edac' lacks a native systemd unit file, automatically generating a unit file for compatibility.
[Mon Mar 16 18:57:12 2026] systemd-sysv-generator[1602459]: Please update package to include a native systemd unit file.
[Mon Mar 16 18:57:12 2026] systemd-sysv-generator[1602459]: ! This compatibility logic is deprecated, expect removal soon. !
[Mon Mar 16 18:57:12 2026] systemd-sysv-generator[1602459]: SysV service '/etc/init.d/openipmi' lacks a native systemd unit file, automatically generating a unit file for compatibility.
[Mon Mar 16 18:57:12 2026] systemd-sysv-generator[1602459]: Please update package to include a native systemd unit file.
[Mon Mar 16 18:57:12 2026] systemd-sysv-generator[1602459]: ! This compatibility logic is deprecated, expect removal soon. !
```

