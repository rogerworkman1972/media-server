# Server System & ZFS Report
**Generated on:** Sun Mar 15 05:46:47 PM EDT 2026

## 1. System Information
```text
Hostname: media
OS: Ubuntu 24.04.4 LTS
Kernel: 6.8.0-106-generic
Uptime & Load:
 17:46:48 up 19:17,  2 users,  load average: 3.55, 3.40, 3.25
```

## 2. Hardware Resources (CPU & RAM)
### Memory (RAM)
```text
               total        used        free      shared  buff/cache   available
Mem:           125Gi        91Gi       6.5Gi       381Mi        29Gi        34Gi
Swap:          8.0Gi       512Ki       8.0Gi
```
### CPU Summary
```text
CPU(s):                                  48
On-line CPU(s) list:                     0-47
Model name:                              Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz
Thread(s) per core:                      2
Core(s) per socket:                      12
Socket(s):                               2
CPU(s) scaling MHz:                      54%
NUMA node(s):                            2
NUMA node0 CPU(s):                       0-11,24-35
NUMA node1 CPU(s):                       12-23,36-47
```

## 3. NUMA Topology & Statistics
```text
--- NUMA Hardware ---
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 24 25 26 27 28 29 30 31 32 33 34 35
node 0 size: 64408 MB
node 0 free: 692 MB
node 1 cpus: 12 13 14 15 16 17 18 19 20 21 22 23 36 37 38 39 40 41 42 43 44 45 46 47
node 1 size: 64457 MB
node 1 free: 5938 MB
node distances:
node   0   1 
  0:  10  21 
  1:  21  10 

--- NUMA Statistics ---
                           node0           node1
numa_hit               201272180       258035759
numa_miss               13292062        29546684
numa_foreign            29546684        13292062
interleave_hit               304             305
local_node             201232338       257846229
other_node              13331904        29744759
```

## 4. Storage, Block, & PCI Devices
### Block Devices
```text
NAME     SIZE FSTYPE     TYPE MOUNTPOINT
sda      9.1T            disk 
├─sda1   9.1T zfs_member part 
└─sda9     8M            part 
sdb    953.9G            disk 
└─sdb1 953.9G xfs        part /mnt/ssd-cache
sdc      1.8T            disk 
├─sdc1   1.8T zfs_member part 
└─sdc9     8M            part 
sdd      1.9T            disk 
├─sdd1     1G vfat       part /boot/efi
└─sdd2   1.9T ext4       part /
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
  scan: scrub repaired 0B in 01:16:59 with 0 errors on Sun Mar  8 01:41:01 2026
config:

	NAME                                   STATE     READ WRITE CKSUM
	backup-tank                            ONLINE       0     0     0
	  scsi-SATA_HGST_HUH721010AL_2TKN8END  ONLINE       0     0     0

errors: No known data errors

  pool: media-tank
 state: ONLINE
  scan: resilvered 99.7M in 00:00:02 with 0 errors on Wed Mar 11 11:33:41 2026
config:

	NAME                                                STATE     READ WRITE CKSUM
	media-tank                                          ONLINE       0     0     0
	  raidz1-0                                          ONLINE       0     0     0
	    scsi-SATA_Samsung_SSD_870_S8HSNJ0L202024F       ONLINE       0     0     0
	    scsi-SATA_TEAM_T253X7002T_TPBF2308070010502815  ONLINE       0     0     0
	    scsi-SATA_Samsung_SSD_870_S5VWNG0N802752X       ONLINE       0     0     0
	    scsi-SATA_Samsung_SSD_860_S4PHNF0M702542R       ONLINE       0     0     0

errors: No known data errors

  pool: music-tank
 state: ONLINE
  scan: resilvered 12.5G in 00:01:17 with 0 errors on Wed Mar 11 15:49:50 2026
config:

	NAME                                     STATE     READ WRITE CKSUM
	music-tank                               ONLINE       0     0     0
	  raidz1-0                               ONLINE       0     0     0
	    scsi-SATA_HGST_HUH721010AL_2YH7822D  ONLINE       0     0     0
	    scsi-SATA_HGST_HUH721010AL_2YGV6TRD  ONLINE       0     0     0
	    scsi-SATA_HGST_HUH721010AL_7JJ5H3VC  ONLINE       0     0     0

errors: No known data errors

NAME          SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
backup-tank  9.09T   671G  8.44T        -         -     0%     7%  1.00x    ONLINE  -
media-tank   7.27T   812G  6.47T        -         -     9%    10%  1.00x    ONLINE  -
music-tank   27.3T  37.4G  27.2T        -         -     0%     0%  1.00x    ONLINE  -
```

## 6. ZFS Datasets & Top-Level Properties
```text
NAME                                USED  AVAIL  REFER  MOUNTPOINT
backup-tank                         671G  8.31T  58.9G  /mnt/backup
backup-tank/media-mirror            611G  8.31T   304G  /mnt/backup/media-mirror
backup-tank/media-mirror/mysql     11.2M  8.31T  2.68M  /mnt/backup/media-mirror/mysql
backup-tank/media-mirror/postgres  9.68G  8.31T  2.82G  /mnt/backup/media-mirror/postgres
backup-tank/ssd-cache-mirror         96K  8.31T    96K  /mnt/backup/ssd-cache-mirror
media-tank                          590G  4.58T   318G  /mnt/media
media-tank/mysql                   16.2M  4.58T  3.87M  /mnt/media/mysql
media-tank/postgres                13.4G  4.58T  3.81G  /mnt/media/postgres
music-tank                         24.9G  18.0T  24.9G  /mnt/music-tank
music-tank/audiobooks               810K  18.0T   671K  /mnt/music-tank/audiobooks

--- Top-Level Properties ---
NAME         PROPERTY              VALUE                  SOURCE
backup-tank  type                  filesystem             -
backup-tank  creation              Thu Feb 26 15:15 2026  -
backup-tank  used                  671G                   -
backup-tank  available             8.31T                  -
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
backup-tank  xattr                 sa                     local
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
backup-tank  usedbychildren        612G                   -
backup-tank  usedbyrefreservation  0B                     -
backup-tank  logbias               latency                default
backup-tank  objsetid              54                     -
backup-tank  dedup                 off                    default
backup-tank  mlslabel              none                   default
backup-tank  sync                  standard               default
backup-tank  dnodesize             legacy                 default
backup-tank  refcompressratio      1.11x                  -
backup-tank  written               58.9G                  -
backup-tank  logicalused           795G                   -
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
NAME        PROPERTY              VALUE                     SOURCE
media-tank  type                  filesystem                -
media-tank  creation              Wed Jan 21 10:14 2026     -
media-tank  used                  590G                      -
media-tank  available             4.58T                     -
media-tank  referenced            318G                      -
media-tank  compressratio         1.18x                     -
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
media-tank  xattr                 sa                        local
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
media-tank  usedbysnapshots       258G                      -
media-tank  usedbydataset         318G                      -
media-tank  usedbychildren        13.9G                     -
media-tank  usedbyrefreservation  0B                        -
media-tank  logbias               latency                   default
media-tank  objsetid              54                        -
media-tank  dedup                 off                       default
media-tank  mlslabel              none                      default
media-tank  sync                  standard                  local
media-tank  dnodesize             legacy                    default
media-tank  refcompressratio      1.17x                     -
media-tank  written               21.1G                     -
media-tank  logicalused           693G                      -
media-tank  logicalreferenced     374G                      -
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
media-tank  snapshots_changed     Sun Mar 15  3:41:19 2026  -
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
music-tank  xattr                 sa                        local
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
music-tank  usedbychildren        4.08M                     -
music-tank  usedbyrefreservation  0B                        -
music-tank  logbias               latency                   default
music-tank  objsetid              54                        -
music-tank  dedup                 off                       default
music-tank  mlslabel              none                      default
music-tank  sync                  standard                  default
music-tank  dnodesize             legacy                    default
music-tank  refcompressratio      1.01x                     -
music-tank  written               24.9G                     -
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
music-tank  snapshots_changed     Thu Mar 12  8:01:31 2026  -
```

## 7. ZFS ARC & Performance
```text
--- ARC Statistics ---
    time  read  ddread  ddh%  dmread  dmh%  pread  ph%   size      c  avail
17:46:48     0       0     0       0     0      0    0    42G    55G    28G

--- ZPool I/O Stats ---
                                                      capacity     operations     bandwidth 
pool                                                alloc   free   read  write   read  write
--------------------------------------------------  -----  -----  -----  -----  -----  -----
backup-tank                                          671G  8.44T      1      0  39.3K   263K
  scsi-SATA_HGST_HUH721010AL_2TKN8END                671G  8.44T      1      0  39.3K   263K
--------------------------------------------------  -----  -----  -----  -----  -----  -----
media-tank                                           812G  6.47T      9    109   328K  4.76M
  raidz1-0                                           812G  6.47T      9    109   328K  4.76M
    scsi-SATA_Samsung_SSD_870_S8HSNJ0L202024F           -      -      2     28  83.0K  1.19M
    scsi-SATA_TEAM_T253X7002T_TPBF2308070010502815      -      -      2     27  80.9K  1.19M
    scsi-SATA_Samsung_SSD_870_S5VWNG0N802752X           -      -      2     26  83.6K  1.19M
    scsi-SATA_Samsung_SSD_860_S4PHNF0M702542R           -      -      2     27  80.9K  1.19M
--------------------------------------------------  -----  -----  -----  -----  -----  -----
music-tank                                          37.4G  27.2T      0      0    126     78
  raidz1-0                                          37.4G  27.2T      0      0    126     78
    scsi-SATA_HGST_HUH721010AL_2YH7822D                 -      -      0      0     42     25
    scsi-SATA_HGST_HUH721010AL_2YGV6TRD                 -      -      0      0     41     26
    scsi-SATA_HGST_HUH721010AL_7JJ5H3VC                 -      -      0      0     42     25
--------------------------------------------------  -----  -----  -----  -----  -----  -----
```

## 8. Network Interfaces & Routing
```text
--- Interfaces ---
lo               UNKNOWN        127.0.0.1/8 ::1/128 
enp2s0f0         UP             
enp2s0f1         UP             
bond0            UP             10.136.150.13/24 metric 100 fe80::14da:6aff:fea9:3c7c/64 
ztsjscgwc2       UNKNOWN        10.183.36.88/24 fe80::c09c:dbff:fe84:34a/64 
br-70d33ce9bb89  UP             172.18.0.1/16 fe80::dce6:5cff:fe1e:df2a/64 
docker0          DOWN           172.17.0.1/16 
vethd633026@if2  UP             fe80::1c35:d8ff:fee8:dea0/64 
veth5511a16@if2  UP             fe80::54da:d1ff:fe97:1c20/64 
veth0490380@if2  UP             fe80::b0ef:62ff:febb:8f4/64 
veth12d9ba9@if2  UP             fe80::e021:4ff:fe69:52f9/64 
vethb302cd8@if2  UP             fe80::8834:46ff:fe48:25c9/64 
veth1d53b43@if2  UP             fe80::88ca:76ff:feba:2a11/64 
veth27ec91b@if2  UP             fe80::8c4a:50ff:fee1:8105/64 
veth26e5d1e@if2  UP             fe80::9cab:59ff:fe51:a2ad/64 
veth7c0ba3c@if2  UP             fe80::ecd3:8ff:fee6:61f4/64 
vethe47b63c@if2  UP             fe80::b004:d9ff:fea6:a1b8/64 
vethfee40e0@if2  UP             fe80::54b5:96ff:fe8e:7a94/64 
veth9e23aae@if2  UP             fe80::489b:77ff:feeb:48a9/64 
vethf68910e@if2  UP             fe80::18c3:82ff:fe96:710f/64 
veth2ac8874@if2  UP             fe80::ec1d:fcff:fe3b:e607/64 
veth3a829a9@if2  UP             fe80::10e3:dcff:fe11:ac40/64 

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
Images          19        19        27.79GB   27.79GB (100%)
Containers      21        16        137.4MB   100.3MB (72%)
Local Volumes   6         4         1.635GB   35.68MB (2%)
Build Cache     0         0         0B        0B

--- Running & Stopped Containers ---
NAMES          IMAGE                                  STATUS                        PORTS
netdata        netdata/netdata:stable                 Up About a minute (healthy)   
webserver      nginx:alpine                           Up 19 hours (healthy)         0.0.0.0:7050->80/tcp, [::]:7050->80/tcp
open-webui     ghcr.io/open-webui/open-webui:main     Exited (0) 20 hours ago       
ollama         ollama/ollama:latest                   Exited (0) 20 hours ago       
stash          stashapp/stash:latest                  Exited (0) 29 hours ago       
soulsync       boulderbadgedad/soulsync:latest        Up 2 minutes (healthy)        0.0.0.0:8008->8008/tcp, [::]:8008->8008/tcp, 0.0.0.0:8888-8889->8888-8889/tcp, [::]:8888-8889->8888-8889/tcp
nginx          jc21/nginx-proxy-manager:latest        Up 19 hours (healthy)         0.0.0.0:80-81->80-81/tcp, [::]:80-81->80-81/tcp, 0.0.0.0:443->443/tcp, [::]:443->443/tcp
radarr         lscr.io/linuxserver/radarr:develop     Up 6 hours (healthy)          0.0.0.0:7878->7878/tcp, [::]:7878->7878/tcp
sonarr         lscr.io/linuxserver/sonarr:develop     Up 6 hours (healthy)          0.0.0.0:8989->8989/tcp, [::]:8989->8989/tcp
seerr          ghcr.io/seerr-team/seerr:latest        Up 19 hours (healthy)         0.0.0.0:5055->5055/tcp, [::]:5055->5055/tcp
sonarr-anime   lscr.io/linuxserver/sonarr:develop     Up 19 hours (healthy)         0.0.0.0:8990->8989/tcp, [::]:8990->8989/tcp
prowlarr       lscr.io/linuxserver/prowlarr:develop   Up 19 hours (healthy)         0.0.0.0:9696->9696/tcp, [::]:9696->9696/tcp
emby           emby/embyserver:beta                   Up 19 hours (healthy)         1900/udp, 7359/udp, 0.0.0.0:8096->8096/tcp, [::]:8096->8096/tcp, 8920/tcp
rclone         rclone/rclone:1.73.1                   Up 19 hours (healthy)         0.0.0.0:5572->5572/tcp, [::]:5572->5572/tcp
rclone-init    alpine:3.20                            Exited (0) 34 hours ago       
slskd          slskd/slskd:latest                     Up 2 minutes (healthy)        0.0.0.0:5030->5030/tcp, [::]:5030->5030/tcp, 0.0.0.0:50300->50300/tcp, [::]:50300->50300/tcp
nzbdav         nzbdav/nzbdav:latest                   Up 19 hours (healthy)         0.0.0.0:3000->3000/tcp, [::]:3000->3000/tcp
db-ready       alpine:3.20                            Exited (0) 34 hours ago       
pgbouncer      edoburu/pgbouncer:latest               Up 19 hours (healthy)         127.0.0.1:6432->5432/tcp
postgres       pgvector/pgvector:pg17                 Up 19 hours (healthy)         5432/tcp
nginx-db       jc21/mariadb-aria:latest               Up 19 hours (healthy)         3306/tcp
```

## 10. Recent Kernel Warnings/Errors
```text
No recent errors, or requires root/sudo to view dmesg.
```

