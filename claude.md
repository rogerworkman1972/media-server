# Server System & ZFS Report
**Generated on:** Sun Mar  1 01:29:50 PM UTC 2026

## 1. System Information
```text
Hostname: media
Ubuntu 24.04.4 LTS
Kernel: 6.8.0-101-generic
Uptime & Load:
 13:29:50 up  1:12,  3 users,  load average: 2.18, 2.75, 3.01
```

## 2. Hardware Resources
### Memory (RAM)
```text
               total        used        free      shared  buff/cache   available
Mem:           125Gi        51Gi        69Gi       323Mi       6.4Gi        74Gi
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
CPU(s) scaling MHz:                      50%
NUMA node(s):                            2
NUMA node0 CPU(s):                       0-11,24-35
NUMA node1 CPU(s):                       12-23,36-47
```

## 3. Storage & Block Devices
```text
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda      8:0    0   1.9T  0 disk 
├─sda1   8:1    0   1.9T  0 part 
└─sda9   8:9    0     8M  0 part 
sdb      8:16   0 953.9G  0 disk 
└─sdb1   8:17   0 953.9G  0 part /mnt/ssd-cache
sdc      8:32   0   1.9T  0 disk 
├─sdc1   8:33   0     1G  0 part /boot/efi
└─sdc2   8:34   0   1.9T  0 part /
sdd      8:48   0   1.9T  0 disk 
├─sdd1   8:49   0   1.9T  0 part 
└─sdd9   8:57   0     8M  0 part 
sde      8:64   0   1.8T  0 disk 
├─sde1   8:65   0   1.8T  0 part 
└─sde9   8:73   0     8M  0 part 
sdf      8:80   0   9.1T  0 disk 
├─sdf1   8:81   0   9.1T  0 part 
└─sdf9   8:89   0    64M  0 part 
sdg      8:96   0   1.8T  0 disk 
├─sdg1   8:97   0   1.8T  0 part 
└─sdg9   8:105  0     8M  0 part 
```

## 4. ZFS Pool Status
```text
  pool: backup-tank
 state: ONLINE
config:

	NAME                                   STATE     READ WRITE CKSUM
	backup-tank                            ONLINE       0     0     0
	  scsi-SATA_HGST_HUH721010AL_2TKN8END  ONLINE       0     0     0

errors: No known data errors

  pool: media-tank
 state: ONLINE
  scan: resilvered 2.56G in 00:00:21 with 0 errors on Fri Feb 27 03:19:12 2026
config:

	NAME                                                STATE     READ WRITE CKSUM
	media-tank                                          ONLINE       0     0     0
	  raidz1-0                                          ONLINE       0     0     0
	    scsi-SATA_TEAM_T253X7002T_TPBF2308070010501207  ONLINE       0     0     0
	    scsi-SATA_TEAM_T253X7002T_TPBF2308070010502815  ONLINE       0     0     0
	    scsi-SATA_Samsung_SSD_870_S5VWNG0N802752X       ONLINE       0     0     0
	    scsi-SATA_Samsung_SSD_860_S4PHNF0M702542R       ONLINE       0     0     0

errors: No known data errors

NAME          SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
backup-tank  9.09T   386G  8.72T        -         -     0%     4%  1.00x    ONLINE  -
media-tank   7.27T   499G  6.78T        -         -     6%     6%  1.00x    ONLINE  -
```

## 5. ZFS Datasets
```text
NAME                                USED  AVAIL  REFER  MOUNTPOINT
backup-tank                         386G  8.59T  15.0G  /mnt/backup
backup-tank/media-mirror            371G  8.59T   314G  /mnt/backup/media-mirror
backup-tank/media-mirror/mysql     10.1M  8.59T  2.63M  /mnt/backup/media-mirror/mysql
backup-tank/media-mirror/postgres  2.70G  8.59T   735M  /mnt/backup/media-mirror/postgres
media-tank                          363G  4.80T   295G  /mnt/media
media-tank/mysql                   14.3M  4.80T  3.81M  /mnt/media/mysql
media-tank/postgres                4.13G  4.80T  1.01G  /mnt/media/postgres
```

## 6. Top-Level ZFS Properties
*Note: Only showing root datasets for brevity.*
```text
NAME         PROPERTY              VALUE                  SOURCE
backup-tank  type                  filesystem             -
backup-tank  creation              Thu Feb 26 20:15 2026  -
backup-tank  used                  386G                   -
backup-tank  available             8.59T                  -
backup-tank  referenced            15.0G                  -
backup-tank  compressratio         1.15x                  -
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
backup-tank  usedbydataset         15.0G                  -
backup-tank  usedbychildren        371G                   -
backup-tank  usedbyrefreservation  0B                     -
backup-tank  logbias               latency                default
backup-tank  objsetid              54                     -
backup-tank  dedup                 off                    default
backup-tank  mlslabel              none                   default
backup-tank  sync                  standard               default
backup-tank  dnodesize             legacy                 default
backup-tank  refcompressratio      1.15x                  -
backup-tank  written               15.0G                  -
backup-tank  logicalused           438G                   -
backup-tank  logicalreferenced     16.8G                  -
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
media-tank  creation              Wed Jan 21 15:14 2026     -
media-tank  used                  363G                      -
media-tank  available             4.80T                     -
media-tank  referenced            295G                      -
media-tank  compressratio         1.15x                     -
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
media-tank  usedbysnapshots       63.4G                     -
media-tank  usedbydataset         295G                      -
media-tank  usedbychildren        4.49G                     -
media-tank  usedbyrefreservation  0B                        -
media-tank  logbias               latency                   default
media-tank  objsetid              54                        -
media-tank  dedup                 off                       default
media-tank  mlslabel              none                      default
media-tank  sync                  disabled                  local
media-tank  dnodesize             legacy                    default
media-tank  refcompressratio      1.14x                     -
media-tank  written               4.03G                     -
media-tank  logicalused           418G                      -
media-tank  logicalreferenced     337G                      -
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
media-tank  snapshots_changed     Sun Mar  1  3:46:07 2026  -
```

