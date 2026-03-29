# Server System & ZFS Report
**Generated on:** Sun Mar 29 09:19:52 EDT 2026

**Report script version:** e4ef58e Updated config files directly on server

## 1. System Information
```text
Hostname: media
OS: Ubuntu 25.10
Kernel: 6.17.0-19-generic
Uptime & Load:
 09:19:52 up 7 days, 59 min,  4 users,  load average: 14.96, 13.16, 12.79
```

## 2. Hardware Resources (CPU & RAM)
### Memory (RAM)
```text
               total        used        free      shared  buff/cache   available
Mem:           121Gi        50Gi       9.5Gi       2.8Gi        66Gi        71Gi
Swap:          8.0Gi        24Mi       8.0Gi
```
### CPU Summary
```text
CPU(s):                                  48
On-line CPU(s) list:                     0-47
Model name:                              Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz
Thread(s) per core:                      2
Core(s) per socket:                      12
Socket(s):                               2
CPU(s) scaling MHz:                      51%
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
node 0 free: 7433 MB
node 1 cpus: 12 13 14 15 16 17 18 19 20 21 22 23 36 37 38 39 40 41 42 43 44 45 46 47
node 1 size: 60359 MB
node 1 free: 2248 MB
node distances:
node     0    1 
   0:   10   21 
   1:   21   10 

--- NUMA Statistics ---
                           node0           node1
numa_hit             14741464608      4038191974
numa_miss               87729405       310200638
numa_foreign           310163229        87672356
interleave_hit              3879            4411
local_node           14740248296      4036428002
other_node              88718949       311773517
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
sdd      9.1T            disk 
├─sdd1   9.1T zfs_member part 
└─sdd9     8M            part 
sde      1.8T            disk 
├─sde1   1.8T zfs_member part 
└─sde9     8M            part 
sdf      9.1T            disk 
├─sdf1   9.1T zfs_member part 
└─sdf9    64M            part 
sdg      1.8T            disk 
├─sdg1   1.8T zfs_member part 
└─sdg9     8M            part 
sdh      9.1T            disk 
├─sdh1   9.1T zfs_member part 
└─sdh9    64M            part 
sdi      1.8T            disk 
├─sdi1   1.8T zfs_member part 
└─sdi9     8M            part 
sdj      1.9T            disk 
├─sdj1     1G vfat       part /boot/efi
└─sdj2   1.9T ext4       part /
```
### Filesystem Usage
```text
Filesystem                               Size  Used Avail Use% Mounted on
efivarfs                                 128K  126K     0 100% /sys/firmware/efi/efivars
/dev/sdj2                                1.9T   64G  1.7T   4% /
/dev/sdj1                                1.1G  6.3M  1.1G   1% /boot/efi
/dev/sdb1                                954G  106G  848G  12% /mnt/ssd-cache
media-tank/docker                        4.5T  8.4G  4.5T   1% /var/lib/docker
music-tank                                19T  4.6G   19T   1% /mnt/music-tank
backup-tank                              8.3T   59G  8.2T   1% /mnt/backup
backup-tank/music-mirror                 8.2T  4.7G  8.2T   1% /mnt/backup/music-mirror
music-tank/audiobooks                     19T  1.0M   19T   1% /mnt/music-tank/audiobooks
backup-tank/media-mirror                 8.6T  411G  8.2T   5% /mnt/backup/media-mirror
media-tank                               4.9T  422G  4.5T   9% /mnt/media
media-tank/mysql                         4.5T  3.9M  4.5T   1% /mnt/media/mysql
media-tank/server-configs                4.5T  1.0M  4.5T   1% /mnt/media/server-configs
backup-tank/music-mirror/audiobooks      8.2T  1.0M  8.2T   1% /mnt/backup/music-mirror/audiobooks
backup-tank/ssd-cache-mirror             8.2T  3.6G  8.2T   1% /mnt/backup/ssd-cache-mirror
backup-tank/media-mirror/docker          8.2T  8.0G  8.2T   1% /mnt/backup/media-mirror/docker
backup-tank/media-mirror/mysql           8.2T  3.0M  8.2T   1% /mnt/backup/media-mirror/mysql
backup-tank/media-mirror/postgres        8.2T  2.1G  8.2T   1% /mnt/backup/media-mirror/postgres
media-tank/postgres                      4.5T  2.8G  4.5T   1% /mnt/media/postgres
backup-tank/media-mirror/server-configs  8.2T  1.0M  8.2T   1% /mnt/backup/media-mirror/server-configs
nzbdav-data:                             8.0E     0  8.0E   0% /mnt/nzbdav-data
```
### Critical PCI Devices (Storage & Network)
```text
00:1f.2 SATA controller: Intel Corporation C600/X79 series chipset 6-Port SATA AHCI Controller (rev 06)
02:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
02:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
07:00.0 Serial Attached SCSI controller: Intel Corporation C602 chipset 4-Port SATA Storage Control Unit (rev 06)
82:00.0 Serial Attached SCSI controller: Broadcom / LSI SAS2308 PCI-Express Fusion-MPT SAS-2 (rev 05)
```

## 5. SMART Disk Health
```text
--- /dev/sda ---
Could not read SMART data for /dev/sda
--- /dev/sdb ---
Could not read SMART data for /dev/sdb
--- /dev/sdc ---
Could not read SMART data for /dev/sdc
--- /dev/sdd ---
Could not read SMART data for /dev/sdd
--- /dev/sde ---
Could not read SMART data for /dev/sde
--- /dev/sdf ---
Could not read SMART data for /dev/sdf
--- /dev/sdg ---
Could not read SMART data for /dev/sdg
--- /dev/sdh ---
Could not read SMART data for /dev/sdh
--- /dev/sdi ---
Could not read SMART data for /dev/sdi
--- /dev/sdj ---
Could not read SMART data for /dev/sdj
```

## 6. Hardware Sensors
```text
coretemp-isa-0001
Adapter: ISA adapter
Package id 1:  +40.0°C  (high = +74.0°C, crit = +94.0°C)
Core 0:        +30.0°C  (high = +74.0°C, crit = +94.0°C)
Core 1:        +36.0°C  (high = +74.0°C, crit = +94.0°C)
Core 2:        +34.0°C  (high = +74.0°C, crit = +94.0°C)
Core 3:        +31.0°C  (high = +74.0°C, crit = +94.0°C)
Core 4:        +34.0°C  (high = +74.0°C, crit = +94.0°C)
Core 5:        +33.0°C  (high = +74.0°C, crit = +94.0°C)
Core 8:        +29.0°C  (high = +74.0°C, crit = +94.0°C)
Core 9:        +40.0°C  (high = +74.0°C, crit = +94.0°C)
Core 10:       +34.0°C  (high = +74.0°C, crit = +94.0°C)
Core 11:       +34.0°C  (high = +74.0°C, crit = +94.0°C)
Core 12:       +30.0°C  (high = +74.0°C, crit = +94.0°C)
Core 13:       +26.0°C  (high = +74.0°C, crit = +94.0°C)

i350bb-pci-0200
Adapter: PCI adapter
loc1:         +57.0°C  (high = +120.0°C, crit = +110.0°C)

coretemp-isa-0000
Adapter: ISA adapter
Package id 0:  +35.0°C  (high = +74.0°C, crit = +94.0°C)
Core 0:        +32.0°C  (high = +74.0°C, crit = +94.0°C)
Core 1:        +33.0°C  (high = +74.0°C, crit = +94.0°C)
Core 2:        +34.0°C  (high = +74.0°C, crit = +94.0°C)
Core 3:        +33.0°C  (high = +74.0°C, crit = +94.0°C)
Core 4:        +30.0°C  (high = +74.0°C, crit = +94.0°C)
Core 5:        +31.0°C  (high = +74.0°C, crit = +94.0°C)
Core 8:        +29.0°C  (high = +74.0°C, crit = +94.0°C)
Core 9:        +29.0°C  (high = +74.0°C, crit = +94.0°C)
Core 10:       +32.0°C  (high = +74.0°C, crit = +94.0°C)
Core 11:       +32.0°C  (high = +74.0°C, crit = +94.0°C)
Core 12:       +33.0°C  (high = +74.0°C, crit = +94.0°C)
Core 13:       +29.0°C  (high = +74.0°C, crit = +94.0°C)

```

## 7. ZFS Pool Status
```text
  pool: backup-tank
 state: ONLINE
  scan: scrub repaired 0B in 00:59:43 with 0 errors on Mon Mar 16 22:06:52 2026
config:

	NAME                      STATE     READ WRITE CKSUM
	backup-tank               ONLINE       0     0     0
	  wwn-0x5000cca26af37d9e  ONLINE       0     0     0

errors: No known data errors

  pool: media-tank
 state: ONLINE
  scan: resilvered 192G in 00:42:41 with 0 errors on Thu Mar 19 14:30:50 2026
config:

	NAME                        STATE     READ WRITE CKSUM
	media-tank                  ONLINE       0     0     0
	  raidz1-0                  ONLINE       0     0     0
	    wwn-0x5002538636205a7f  ONLINE       0     0     0
	    wwn-0x50025386362056de  ONLINE       0     0     0
	    wwn-0x5002538f7081ba98  ONLINE       0     0     0
	    wwn-0x5002538e9970da57  ONLINE       0     0     0

errors: No known data errors

  pool: music-tank
 state: ONLINE
  scan: scrub repaired 0B in 00:01:00 with 0 errors on Mon Mar 16 21:08:07 2026
config:

	NAME                        STATE     READ WRITE CKSUM
	music-tank                  ONLINE       0     0     0
	  raidz1-0                  ONLINE       0     0     0
	    wwn-0x5000cca273d16462  ONLINE       0     0     0
	    wwn-0x5000cca273cbeb2a  ONLINE       0     0     0
	    wwn-0x5000cca266deada3  ONLINE       0     0     0

errors: No known data errors

NAME          SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
backup-tank  9.09T   827G  8.29T        -         -     4%     8%  1.00x    ONLINE  -
media-tank   7.27T   945G  6.34T        -         -    29%    12%  1.00x    ONLINE  -
music-tank   27.3T  44.4G  27.2T        -         -     0%     0%  1.00x    ONLINE  -
```

## 8. ZFS Datasets & Top-Level Properties
```text
NAME                                      USED  AVAIL  REFER  MOUNTPOINT
backup-tank                               827G  8.16T  58.9G  /mnt/backup
backup-tank/media-mirror                  733G  8.16T   410G  /mnt/backup/media-mirror
backup-tank/media-mirror/docker          18.2G  8.16T  7.98G  /mnt/backup/media-mirror/docker
backup-tank/media-mirror/mysql           4.02M  8.16T  2.69M  /mnt/backup/media-mirror/mysql
backup-tank/media-mirror/postgres        11.7G  8.16T  2.05G  /mnt/backup/media-mirror/postgres
backup-tank/media-mirror/server-configs  1.98M  8.16T   580K  /mnt/backup/media-mirror/server-configs
backup-tank/music-mirror                 29.5G  8.16T  4.60G  /mnt/backup/music-mirror
backup-tank/music-mirror/audiobooks       592K  8.16T   120K  /mnt/backup/music-mirror/audiobooks
backup-tank/ssd-cache-mirror             4.85G  8.16T  3.59G  /mnt/backup/ssd-cache-mirror
media-tank                                709G  4.48T   421G  /mnt/media
media-tank/docker                        19.0G  4.48T  8.30G  /var/lib/docker
media-tank/mysql                         5.82M  4.48T  3.89M  /mnt/media/mysql
media-tank/postgres                      15.6G  4.48T  2.73G  /mnt/media/postgres
media-tank/server-configs                2.42M  4.48T   785K  /mnt/media/server-configs
music-tank                               29.5G  18.0T  4.60G  /mnt/music-tank
music-tank/audiobooks                     789K  18.0T   160K  /mnt/music-tank/audiobooks

--- Top-Level Properties ---
NAME         PROPERTY              VALUE                  SOURCE
backup-tank  type                  filesystem             -
backup-tank  creation              Thu Feb 26 15:15 2026  -
backup-tank  used                  827G                   -
backup-tank  available             8.16T                  -
backup-tank  referenced            58.9G                  -
backup-tank  compressratio         1.28x                  -
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
backup-tank  usedbychildren        768G                   -
backup-tank  usedbyrefreservation  0B                     -
backup-tank  logbias               latency                default
backup-tank  objsetid              54                     -
backup-tank  dedup                 off                    default
backup-tank  mlslabel              none                   default
backup-tank  sync                  standard               default
backup-tank  dnodesize             legacy                 default
backup-tank  refcompressratio      1.11x                  -
backup-tank  written               58.9G                  -
backup-tank  logicalused           1.01T                  -
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
media-tank  used                  709G                      -
media-tank  available             4.48T                     -
media-tank  referenced            421G                      -
media-tank  compressratio         1.27x                     -
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
media-tank  usedbysnapshots       252G                      -
media-tank  usedbydataset         421G                      -
media-tank  usedbychildren        35.2G                     -
media-tank  usedbyrefreservation  0B                        -
media-tank  logbias               latency                   default
media-tank  objsetid              54                        -
media-tank  dedup                 off                       default
media-tank  mlslabel              none                      default
media-tank  sync                  standard                  local
media-tank  dnodesize             legacy                    default
media-tank  refcompressratio      1.21x                     -
media-tank  written               1.51G                     -
media-tank  logicalused           891G                      -
media-tank  logicalreferenced     512G                      -
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
media-tank  snapshots_changed     Sun Mar 29  9:00:20 2026  -
media-tank  prefetch              all                       default
media-tank  direct                standard                  default
media-tank  longname              off                       default
NAME        PROPERTY              VALUE                     SOURCE
music-tank  type                  filesystem                -
music-tank  creation              Tue Mar 10 13:41 2026     -
music-tank  used                  29.5G                     -
music-tank  available             18.0T                     -
music-tank  referenced            4.60G                     -
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
music-tank  usedbysnapshots       24.9G                     -
music-tank  usedbydataset         4.60G                     -
music-tank  usedbychildren        14.3M                     -
music-tank  usedbyrefreservation  0B                        -
music-tank  logbias               latency                   default
music-tank  objsetid              54                        -
music-tank  dedup                 off                       default
music-tank  mlslabel              none                      default
music-tank  sync                  standard                  default
music-tank  dnodesize             legacy                    default
music-tank  refcompressratio      1.01x                     -
music-tank  written               0                         -
music-tank  logicalused           30.0G                     -
music-tank  logicalreferenced     4.67G                     -
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
music-tank  snapshots_changed     Sun Mar 29  9:00:23 2026  -
music-tank  prefetch              all                       default
music-tank  direct                standard                  default
music-tank  longname              off                       default
```

## 9. ZFS Snapshots
```text
NAME                                                                                  USED  CREATION
backup-tank/media-mirror/server-configs@autosnap_2026-03-16_18:41:55_weekly             0B  Mon Mar 16 18:41 2026
media-tank/server-configs@autosnap_2026-03-16_18:41:55_weekly                           0B  Mon Mar 16 18:41 2026
backup-tank/media-mirror@autosnap_2026-03-16_18:41:58_weekly                          348M  Mon Mar 16 18:41 2026
media-tank@autosnap_2026-03-16_18:41:58_weekly                                        291M  Mon Mar 16 18:41 2026
backup-tank/music-mirror@autosnap_2026-03-16_18:42:01_weekly                            0B  Mon Mar 16 18:42 2026
music-tank@autosnap_2026-03-16_18:42:01_weekly                                          0B  Mon Mar 16 18:42 2026
backup-tank/music-mirror@autosnap_2026-03-16_18:45:51_weekly                            0B  Mon Mar 16 18:45 2026
music-tank@autosnap_2026-03-16_18:45:51_weekly                                          0B  Mon Mar 16 18:45 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-16_18:45:51_weekly                67.7M  Mon Mar 16 18:45 2026
media-tank/postgres@autosnap_2026-03-16_18:45:51_weekly                              81.2M  Mon Mar 16 18:45 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-16_18:45:55_weekly                      0B  Mon Mar 16 18:45 2026
media-tank/mysql@autosnap_2026-03-16_18:45:55_weekly                                    0B  Mon Mar 16 18:45 2026
backup-tank/media-mirror@autosnap_2026-03-16_18:45:57_weekly                          217M  Mon Mar 16 18:45 2026
media-tank@autosnap_2026-03-16_18:45:57_weekly                                        176M  Mon Mar 16 18:45 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-16_18:46:01_weekly             0B  Mon Mar 16 18:46 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-16_18:46:01_weekly                 0B  Mon Mar 16 18:46 2026
media-tank/server-configs@autosnap_2026-03-16_18:46:01_weekly                           0B  Mon Mar 16 18:46 2026
music-tank/audiobooks@autosnap_2026-03-16_18:46:01_weekly                               0B  Mon Mar 16 18:46 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-16_23:30:03_weekly            80K  Mon Mar 16 19:30 2026
media-tank/server-configs@autosnap_2026-03-16_23:30:03_weekly                         116K  Mon Mar 16 19:30 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-16_23:30:04_weekly                 0B  Mon Mar 16 19:30 2026
music-tank/audiobooks@autosnap_2026-03-16_23:30:04_weekly                               0B  Mon Mar 16 19:30 2026
backup-tank/music-mirror@autosnap_2026-03-16_23:30:05_weekly                            0B  Mon Mar 16 19:30 2026
music-tank@autosnap_2026-03-16_23:30:05_weekly                                          0B  Mon Mar 16 19:30 2026
backup-tank/media-mirror@autosnap_2026-03-16_23:30:12_weekly                         1.69G  Mon Mar 16 19:30 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-16_23:30:05_weekly                67.4M  Mon Mar 16 19:30 2026
media-tank@autosnap_2026-03-16_23:30:12_weekly                                       1.48G  Mon Mar 16 19:30 2026
media-tank/postgres@autosnap_2026-03-16_23:30:05_weekly                              81.4M  Mon Mar 16 19:30 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-16_23:30:13_weekly                      0B  Mon Mar 16 19:30 2026
media-tank/mysql@autosnap_2026-03-16_23:30:13_weekly                                    0B  Mon Mar 16 19:30 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-23_00:00:04_daily              0B  Sun Mar 22 20:00 2026
media-tank/server-configs@autosnap_2026-03-23_00:00:04_daily                            0B  Sun Mar 22 20:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-23_04:00:01_daily                       0B  Mon Mar 23  0:00 2026
media-tank/mysql@autosnap_2026-03-23_04:00:01_daily                                     0B  Mon Mar 23  0:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-23_04:00:02_daily                  276M  Mon Mar 23  0:00 2026
media-tank/postgres@autosnap_2026-03-23_04:00:02_daily                                350M  Mon Mar 23  0:00 2026
backup-tank/media-mirror@autosnap_2026-03-23_04:00:09_daily                          6.19G  Mon Mar 23  0:00 2026
backup-tank/music-mirror@autosnap_2026-03-23_04:00:09_daily                             0B  Mon Mar 23  0:00 2026
media-tank@autosnap_2026-03-23_04:00:09_daily                                        4.16G  Mon Mar 23  0:00 2026
music-tank@autosnap_2026-03-23_04:00:09_daily                                           0B  Mon Mar 23  0:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-23_04:00:10_daily                  0B  Mon Mar 23  0:00 2026
music-tank/audiobooks@autosnap_2026-03-23_04:00:10_daily                                0B  Mon Mar 23  0:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-23_04:15:00_daily                       186M  Mon Mar 23  0:15 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-23_23:30:01_weekly             0B  Mon Mar 23 19:30 2026
media-tank/server-configs@autosnap_2026-03-23_23:30:01_weekly                           0B  Mon Mar 23 19:30 2026
backup-tank/music-mirror@autosnap_2026-03-23_23:30:03_weekly                            0B  Mon Mar 23 19:30 2026
music-tank@autosnap_2026-03-23_23:30:03_weekly                                          0B  Mon Mar 23 19:30 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-23_23:30:03_weekly                 238M  Mon Mar 23 19:30 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-23_23:30:20_weekly                 0B  Mon Mar 23 19:30 2026
media-tank/postgres@autosnap_2026-03-23_23:30:03_weekly                               292M  Mon Mar 23 19:30 2026
music-tank/audiobooks@autosnap_2026-03-23_23:30:20_weekly                               0B  Mon Mar 23 19:30 2026
backup-tank/media-mirror@autosnap_2026-03-23_23:30:21_weekly                         3.77G  Mon Mar 23 19:30 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-23_23:30:20_weekly                      0B  Mon Mar 23 19:30 2026
media-tank@autosnap_2026-03-23_23:30:21_weekly                                       3.55G  Mon Mar 23 19:30 2026
media-tank/mysql@autosnap_2026-03-23_23:30:20_weekly                                    0B  Mon Mar 23 19:30 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-24_00:00:01_daily              0B  Mon Mar 23 20:00 2026
media-tank/server-configs@autosnap_2026-03-24_00:00:01_daily                            0B  Mon Mar 23 20:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-24_04:00:01_daily                       0B  Tue Mar 24  0:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-24_04:00:01_daily                  0B  Tue Mar 24  0:00 2026
media-tank/mysql@autosnap_2026-03-24_04:00:01_daily                                     0B  Tue Mar 24  0:00 2026
music-tank/audiobooks@autosnap_2026-03-24_04:00:01_daily                                0B  Tue Mar 24  0:00 2026
backup-tank/music-mirror@autosnap_2026-03-24_04:00:04_daily                             0B  Tue Mar 24  0:00 2026
music-tank@autosnap_2026-03-24_04:00:04_daily                                           0B  Tue Mar 24  0:00 2026
backup-tank/media-mirror@autosnap_2026-03-24_04:00:04_daily                          5.60G  Tue Mar 24  0:00 2026
media-tank@autosnap_2026-03-24_04:00:04_daily                                        5.22G  Tue Mar 24  0:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-24_04:00:06_daily                  144M  Tue Mar 24  0:00 2026
media-tank/postgres@autosnap_2026-03-24_04:00:06_daily                                172M  Tue Mar 24  0:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-24_04:15:01_daily                      45.5M  Tue Mar 24  0:15 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-25_00:00:01_daily             84K  Tue Mar 24 20:00 2026
media-tank/server-configs@autosnap_2026-03-25_00:00:01_daily                           93K  Tue Mar 24 20:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-25_04:00:05_daily                  0B  Wed Mar 25  0:00 2026
music-tank/audiobooks@autosnap_2026-03-25_04:00:05_daily                                0B  Wed Mar 25  0:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-25_04:00:06_daily                  178M  Wed Mar 25  0:00 2026
media-tank/postgres@autosnap_2026-03-25_04:00:06_daily                                223M  Wed Mar 25  0:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-25_04:00:08_daily                       0B  Wed Mar 25  0:00 2026
media-tank/mysql@autosnap_2026-03-25_04:00:08_daily                                     0B  Wed Mar 25  0:00 2026
backup-tank/media-mirror@autosnap_2026-03-25_04:00:09_daily                          5.99G  Wed Mar 25  0:00 2026
media-tank@autosnap_2026-03-25_04:00:09_daily                                        3.94G  Wed Mar 25  0:00 2026
backup-tank/music-mirror@autosnap_2026-03-25_04:00:10_daily                             0B  Wed Mar 25  0:00 2026
music-tank@autosnap_2026-03-25_04:00:10_daily                                           0B  Wed Mar 25  0:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-25_04:15:01_daily                      33.4M  Wed Mar 25  0:15 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-26_00:00:17_daily             92K  Wed Mar 25 20:00 2026
media-tank/server-configs@autosnap_2026-03-26_00:00:17_daily                          105K  Wed Mar 25 20:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-26_04:00:01_daily                       0B  Thu Mar 26  0:00 2026
media-tank/mysql@autosnap_2026-03-26_04:00:01_daily                                     0B  Thu Mar 26  0:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-26_04:00:02_daily                  0B  Thu Mar 26  0:00 2026
music-tank/audiobooks@autosnap_2026-03-26_04:00:02_daily                                0B  Thu Mar 26  0:00 2026
backup-tank/media-mirror@autosnap_2026-03-26_04:00:07_daily                          2.75G  Thu Mar 26  0:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-26_04:00:02_daily                  267M  Thu Mar 26  0:00 2026
media-tank@autosnap_2026-03-26_04:00:07_daily                                        1.59G  Thu Mar 26  0:00 2026
media-tank/postgres@autosnap_2026-03-26_04:00:02_daily                                352M  Thu Mar 26  0:00 2026
backup-tank/music-mirror@autosnap_2026-03-26_04:00:08_daily                             0B  Thu Mar 26  0:00 2026
music-tank@autosnap_2026-03-26_04:00:08_daily                                           0B  Thu Mar 26  0:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-26_04:15:05_daily                      37.1M  Thu Mar 26  0:15 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_00:00:05_daily              0B  Thu Mar 26 20:00 2026
media-tank/server-configs@autosnap_2026-03-27_00:00:05_daily                            0B  Thu Mar 26 20:00 2026
backup-tank/media-mirror@pre-down-20260326-204016                                    83.9M  Thu Mar 26 20:40 2026
backup-tank/media-mirror/docker@pre-down-20260326-204016                              156M  Thu Mar 26 20:40 2026
backup-tank/media-mirror/mysql@pre-down-20260326-204016                                 0B  Thu Mar 26 20:40 2026
backup-tank/media-mirror/postgres@pre-down-20260326-204016                           90.9M  Thu Mar 26 20:40 2026
backup-tank/media-mirror/server-configs@pre-down-20260326-204016                        0B  Thu Mar 26 20:40 2026
media-tank@pre-down-20260326-204016                                                  47.3M  Thu Mar 26 20:40 2026
media-tank/docker@pre-down-20260326-204016                                            148M  Thu Mar 26 20:40 2026
media-tank/mysql@pre-down-20260326-204016                                               0B  Thu Mar 26 20:40 2026
media-tank/postgres@pre-down-20260326-204016                                          108M  Thu Mar 26 20:40 2026
media-tank/server-configs@pre-down-20260326-204016                                      0B  Thu Mar 26 20:40 2026
backup-tank/music-mirror@pre-down-20260326-204016                                       0B  Thu Mar 26 20:40 2026
music-tank@pre-down-20260326-204016                                                     0B  Thu Mar 26 20:40 2026
backup-tank/music-mirror/audiobooks@pre-down-20260326-204016                            0B  Thu Mar 26 20:40 2026
music-tank/audiobooks@pre-down-20260326-204016                                          0B  Thu Mar 26 20:40 2026
backup-tank/media-mirror@pre-up-20260326-204409                                      84.2M  Thu Mar 26 20:44 2026
backup-tank/media-mirror/docker@pre-up-20260326-204409                               4.46M  Thu Mar 26 20:44 2026
backup-tank/media-mirror/mysql@pre-up-20260326-204409                                 104K  Thu Mar 26 20:44 2026
backup-tank/media-mirror/postgres@pre-up-20260326-204409                             50.3M  Thu Mar 26 20:44 2026
backup-tank/media-mirror/server-configs@pre-up-20260326-204409                          0B  Thu Mar 26 20:44 2026
backup-tank/music-mirror@pre-up-20260326-204409                                         0B  Thu Mar 26 20:44 2026
backup-tank/music-mirror/audiobooks@pre-up-20260326-204409                              0B  Thu Mar 26 20:44 2026
media-tank@pre-up-20260326-204409                                                    47.0M  Thu Mar 26 20:44 2026
media-tank/docker@pre-up-20260326-204409                                             2.58M  Thu Mar 26 20:44 2026
media-tank/mysql@pre-up-20260326-204409                                               151K  Thu Mar 26 20:44 2026
media-tank/postgres@pre-up-20260326-204409                                           61.7M  Thu Mar 26 20:44 2026
media-tank/server-configs@pre-up-20260326-204409                                        0B  Thu Mar 26 20:44 2026
music-tank@pre-up-20260326-204409                                                       0B  Thu Mar 26 20:44 2026
music-tank/audiobooks@pre-up-20260326-204409                                            0B  Thu Mar 26 20:44 2026
backup-tank/media-mirror@autosnap_2026-03-27_04:00:06_daily                          2.00G  Fri Mar 27  0:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_04:00:06_daily                             0B  Fri Mar 27  0:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_04:00:06_daily                  0B  Fri Mar 27  0:00 2026
media-tank@autosnap_2026-03-27_04:00:06_daily                                        2.07G  Fri Mar 27  0:00 2026
music-tank@autosnap_2026-03-27_04:00:06_daily                                           0B  Fri Mar 27  0:00 2026
music-tank/audiobooks@autosnap_2026-03-27_04:00:06_daily                                0B  Fri Mar 27  0:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_04:00:06_daily                       0B  Fri Mar 27  0:00 2026
media-tank/mysql@autosnap_2026-03-27_04:00:06_daily                                     0B  Fri Mar 27  0:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_04:00:07_daily                 31.6M  Fri Mar 27  0:00 2026
media-tank/postgres@autosnap_2026-03-27_04:00:07_daily                                184M  Fri Mar 27  0:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-27_04:15:01_daily                      29.3M  Fri Mar 27  0:15 2026
backup-tank/media-mirror@autosnap_2026-03-27_08:00:05_hourly                          306M  Fri Mar 27  4:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_08:00:10_hourly             0B  Fri Mar 27  4:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_09:00:05_hourly                          247M  Fri Mar 27  5:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_09:00:06_hourly                      0B  Fri Mar 27  5:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_09:00:06_hourly                            0B  Fri Mar 27  5:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_09:00:07_hourly                 0B  Fri Mar 27  5:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_09:00:07_hourly                21.6M  Fri Mar 27  5:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_09:00:11_hourly             0B  Fri Mar 27  5:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_10:00:05_hourly                            0B  Fri Mar 27  6:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_10:00:19_hourly                          250M  Fri Mar 27  6:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_10:00:05_hourly                60.6M  Fri Mar 27  6:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_10:00:19_hourly                 0B  Fri Mar 27  6:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_10:00:20_hourly                      0B  Fri Mar 27  6:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_10:00:22_hourly             0B  Fri Mar 27  6:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_11:00:05_hourly                          240M  Fri Mar 27  7:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_11:00:06_hourly             0B  Fri Mar 27  7:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_11:00:05_hourly                            0B  Fri Mar 27  7:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_11:00:07_hourly                61.7M  Fri Mar 27  7:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_11:00:17_hourly                      0B  Fri Mar 27  7:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_11:00:18_hourly                 0B  Fri Mar 27  7:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_12:00:05_hourly                73.4M  Fri Mar 27  8:01 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_12:01:27_hourly                      0B  Fri Mar 27  8:01 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_12:01:30_hourly             0B  Fri Mar 27  8:01 2026
backup-tank/music-mirror@autosnap_2026-03-27_12:01:32_hourly                            0B  Fri Mar 27  8:01 2026
backup-tank/media-mirror@autosnap_2026-03-27_12:01:32_hourly                          269M  Fri Mar 27  8:01 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_12:01:34_hourly                 0B  Fri Mar 27  8:01 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_13:00:02_hourly                      0B  Fri Mar 27  9:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_13:00:04_hourly                 126M  Fri Mar 27  9:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_13:00:16_hourly             0B  Fri Mar 27  9:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_13:00:17_hourly                 0B  Fri Mar 27  9:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_13:00:18_hourly                          264M  Fri Mar 27  9:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_13:00:17_hourly                            0B  Fri Mar 27  9:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_14:00:06_hourly                            0B  Fri Mar 27 10:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_14:00:06_hourly                 0B  Fri Mar 27 10:00 2026
music-tank@autosnap_2026-03-27_14:00:06_hourly                                          0B  Fri Mar 27 10:00 2026
music-tank/audiobooks@autosnap_2026-03-27_14:00:06_hourly                               0B  Fri Mar 27 10:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_14:00:06_hourly                88.2M  Fri Mar 27 10:00 2026
media-tank/postgres@autosnap_2026-03-27_14:00:06_hourly                               114M  Fri Mar 27 10:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_14:00:23_hourly                          266M  Fri Mar 27 10:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_14:00:22_hourly             0B  Fri Mar 27 10:00 2026
media-tank@autosnap_2026-03-27_14:00:23_hourly                                        399M  Fri Mar 27 10:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-27_14:00:24_hourly                        0B  Fri Mar 27 10:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_14:00:24_hourly                      0B  Fri Mar 27 10:00 2026
media-tank/mysql@autosnap_2026-03-27_14:00:24_hourly                                    0B  Fri Mar 27 10:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_15:00:03_hourly                          275M  Fri Mar 27 11:00 2026
media-tank@autosnap_2026-03-27_15:00:03_hourly                                        251M  Fri Mar 27 11:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_15:00:05_hourly                61.1M  Fri Mar 27 11:00 2026
media-tank/postgres@autosnap_2026-03-27_15:00:05_hourly                              80.1M  Fri Mar 27 11:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_15:00:22_hourly             0B  Fri Mar 27 11:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-27_15:00:22_hourly                        0B  Fri Mar 27 11:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_15:00:23_hourly                            0B  Fri Mar 27 11:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_15:00:23_hourly                 0B  Fri Mar 27 11:00 2026
music-tank@autosnap_2026-03-27_15:00:23_hourly                                          0B  Fri Mar 27 11:00 2026
music-tank/audiobooks@autosnap_2026-03-27_15:00:23_hourly                               0B  Fri Mar 27 11:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_15:00:23_hourly                      0B  Fri Mar 27 11:00 2026
media-tank/mysql@autosnap_2026-03-27_15:00:23_hourly                                    0B  Fri Mar 27 11:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_16:00:01_hourly                            0B  Fri Mar 27 12:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-27_16:00:01_hourly                        0B  Fri Mar 27 12:00 2026
music-tank@autosnap_2026-03-27_16:00:01_hourly                                          0B  Fri Mar 27 12:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_16:00:01_hourly                      0B  Fri Mar 27 12:00 2026
media-tank/mysql@autosnap_2026-03-27_16:00:01_hourly                                    0B  Fri Mar 27 12:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_16:00:09_hourly                          183M  Fri Mar 27 12:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_16:00:03_hourly                58.5M  Fri Mar 27 12:00 2026
media-tank@autosnap_2026-03-27_16:00:09_hourly                                        165M  Fri Mar 27 12:00 2026
media-tank/postgres@autosnap_2026-03-27_16:00:03_hourly                              77.7M  Fri Mar 27 12:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_16:00:10_hourly             0B  Fri Mar 27 12:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_16:00:10_hourly                 0B  Fri Mar 27 12:00 2026
music-tank/audiobooks@autosnap_2026-03-27_16:00:10_hourly                               0B  Fri Mar 27 12:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_17:00:01_hourly                      0B  Fri Mar 27 13:00 2026
media-tank/mysql@autosnap_2026-03-27_17:00:01_hourly                                    0B  Fri Mar 27 13:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_17:00:02_hourly                 0B  Fri Mar 27 13:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-27_17:00:02_hourly                        0B  Fri Mar 27 13:00 2026
music-tank/audiobooks@autosnap_2026-03-27_17:00:02_hourly                               0B  Fri Mar 27 13:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_17:00:08_hourly                          206M  Fri Mar 27 13:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_17:00:02_hourly                55.4M  Fri Mar 27 13:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_17:00:08_hourly             0B  Fri Mar 27 13:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_17:00:08_hourly                            0B  Fri Mar 27 13:00 2026
media-tank@autosnap_2026-03-27_17:00:08_hourly                                        183M  Fri Mar 27 13:00 2026
media-tank/postgres@autosnap_2026-03-27_17:00:02_hourly                              73.3M  Fri Mar 27 13:00 2026
music-tank@autosnap_2026-03-27_17:00:08_hourly                                          0B  Fri Mar 27 13:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_18:00:02_hourly             0B  Fri Mar 27 14:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_18:00:03_hourly                      0B  Fri Mar 27 14:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_18:00:04_hourly                            0B  Fri Mar 27 14:00 2026
media-tank/mysql@autosnap_2026-03-27_18:00:03_hourly                                    0B  Fri Mar 27 14:00 2026
music-tank@autosnap_2026-03-27_18:00:04_hourly                                          0B  Fri Mar 27 14:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_18:00:05_hourly                          242M  Fri Mar 27 14:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-27_18:00:05_hourly                        0B  Fri Mar 27 14:00 2026
media-tank@autosnap_2026-03-27_18:00:05_hourly                                        215M  Fri Mar 27 14:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_18:00:05_hourly                70.6M  Fri Mar 27 14:00 2026
media-tank/postgres@autosnap_2026-03-27_18:00:05_hourly                              95.1M  Fri Mar 27 14:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_18:00:18_hourly                 0B  Fri Mar 27 14:00 2026
music-tank/audiobooks@autosnap_2026-03-27_18:00:18_hourly                               0B  Fri Mar 27 14:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_19:00:06_hourly                            0B  Fri Mar 27 15:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_19:00:06_hourly                 0B  Fri Mar 27 15:00 2026
music-tank@autosnap_2026-03-27_19:00:06_hourly                                          0B  Fri Mar 27 15:00 2026
music-tank/audiobooks@autosnap_2026-03-27_19:00:06_hourly                               0B  Fri Mar 27 15:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_19:00:06_hourly                59.7M  Fri Mar 27 15:00 2026
media-tank/postgres@autosnap_2026-03-27_19:00:06_hourly                              78.8M  Fri Mar 27 15:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_19:00:18_hourly                      0B  Fri Mar 27 15:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_19:00:18_hourly             0B  Fri Mar 27 15:00 2026
media-tank/mysql@autosnap_2026-03-27_19:00:18_hourly                                    0B  Fri Mar 27 15:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_19:00:19_hourly                          240M  Fri Mar 27 15:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-27_19:00:19_hourly                        0B  Fri Mar 27 15:00 2026
media-tank@autosnap_2026-03-27_19:00:19_hourly                                        217M  Fri Mar 27 15:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_20:00:01_hourly                          256M  Fri Mar 27 16:00 2026
media-tank@autosnap_2026-03-27_20:00:01_hourly                                        199M  Fri Mar 27 16:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_20:00:02_hourly                      0B  Fri Mar 27 16:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_20:00:02_hourly                            0B  Fri Mar 27 16:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_20:00:02_hourly                 0B  Fri Mar 27 16:00 2026
media-tank/mysql@autosnap_2026-03-27_20:00:02_hourly                                    0B  Fri Mar 27 16:00 2026
music-tank@autosnap_2026-03-27_20:00:02_hourly                                          0B  Fri Mar 27 16:00 2026
music-tank/audiobooks@autosnap_2026-03-27_20:00:02_hourly                               0B  Fri Mar 27 16:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_20:00:03_hourly             0B  Fri Mar 27 16:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-27_20:00:03_hourly                        0B  Fri Mar 27 16:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_20:00:04_hourly                 105M  Fri Mar 27 16:00 2026
media-tank/postgres@autosnap_2026-03-27_20:00:04_hourly                               135M  Fri Mar 27 16:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_21:00:04_hourly                78.7M  Fri Mar 27 17:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_21:00:20_hourly             0B  Fri Mar 27 17:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_21:00:20_hourly                 0B  Fri Mar 27 17:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-27_21:00:20_hourly                        0B  Fri Mar 27 17:00 2026
media-tank/postgres@autosnap_2026-03-27_21:00:04_hourly                               104M  Fri Mar 27 17:00 2026
music-tank/audiobooks@autosnap_2026-03-27_21:00:20_hourly                               0B  Fri Mar 27 17:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_21:00:21_hourly                      0B  Fri Mar 27 17:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_21:00:21_hourly                            0B  Fri Mar 27 17:00 2026
media-tank/mysql@autosnap_2026-03-27_21:00:21_hourly                                    0B  Fri Mar 27 17:00 2026
music-tank@autosnap_2026-03-27_21:00:21_hourly                                          0B  Fri Mar 27 17:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_21:00:22_hourly                         7.83G  Fri Mar 27 17:00 2026
media-tank@autosnap_2026-03-27_21:00:22_hourly                                       7.57G  Fri Mar 27 17:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_22:00:05_hourly                 0B  Fri Mar 27 18:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-27_22:00:05_hourly                        0B  Fri Mar 27 18:00 2026
music-tank/audiobooks@autosnap_2026-03-27_22:00:05_hourly                               0B  Fri Mar 27 18:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_22:00:05_hourly             0B  Fri Mar 27 18:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_22:00:07_hourly                            0B  Fri Mar 27 18:00 2026
music-tank@autosnap_2026-03-27_22:00:07_hourly                                          0B  Fri Mar 27 18:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_22:00:07_hourly                69.7M  Fri Mar 27 18:00 2026
media-tank/postgres@autosnap_2026-03-27_22:00:07_hourly                              92.5M  Fri Mar 27 18:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_22:00:18_hourly                      0B  Fri Mar 27 18:00 2026
media-tank/mysql@autosnap_2026-03-27_22:00:18_hourly                                    0B  Fri Mar 27 18:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_22:00:20_hourly                          545M  Fri Mar 27 18:00 2026
media-tank@autosnap_2026-03-27_22:00:20_hourly                                        481M  Fri Mar 27 18:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-27_23:00:01_hourly                 116M  Fri Mar 27 19:00 2026
backup-tank/music-mirror@autosnap_2026-03-27_23:00:14_hourly                            0B  Fri Mar 27 19:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-27_23:00:14_hourly                 0B  Fri Mar 27 19:00 2026
media-tank/postgres@autosnap_2026-03-27_23:00:01_hourly                               153M  Fri Mar 27 19:00 2026
music-tank@autosnap_2026-03-27_23:00:14_hourly                                          0B  Fri Mar 27 19:00 2026
music-tank/audiobooks@autosnap_2026-03-27_23:00:14_hourly                               0B  Fri Mar 27 19:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-27_23:00:14_hourly                        0B  Fri Mar 27 19:00 2026
backup-tank/media-mirror@autosnap_2026-03-27_23:00:15_hourly                         1.70G  Fri Mar 27 19:00 2026
media-tank@autosnap_2026-03-27_23:00:15_hourly                                       1.53G  Fri Mar 27 19:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-27_23:00:17_hourly                      0B  Fri Mar 27 19:00 2026
media-tank/mysql@autosnap_2026-03-27_23:00:17_hourly                                    0B  Fri Mar 27 19:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-27_23:00:20_hourly             0B  Fri Mar 27 19:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_00:00:05_hourly                        0B  Fri Mar 27 20:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_00:00:05_daily              0B  Fri Mar 27 20:00 2026
media-tank/server-configs@autosnap_2026-03-28_00:00:05_daily                            0B  Fri Mar 27 20:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_00:00:05_hourly             0B  Fri Mar 27 20:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_00:00:14_hourly                         1.66G  Fri Mar 27 20:00 2026
media-tank@autosnap_2026-03-28_00:00:14_hourly                                       1.47G  Fri Mar 27 20:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_00:00:15_hourly                            0B  Fri Mar 27 20:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_00:00:16_hourly                 0B  Fri Mar 27 20:00 2026
music-tank@autosnap_2026-03-28_00:00:15_hourly                                          0B  Fri Mar 27 20:00 2026
music-tank/audiobooks@autosnap_2026-03-28_00:00:16_hourly                               0B  Fri Mar 27 20:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_00:00:16_hourly                      0B  Fri Mar 27 20:00 2026
media-tank/mysql@autosnap_2026-03-28_00:00:16_hourly                                    0B  Fri Mar 27 20:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_00:00:19_hourly                 104M  Fri Mar 27 20:00 2026
media-tank/postgres@autosnap_2026-03-28_00:00:19_hourly                               123M  Fri Mar 27 20:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_01:00:05_hourly                            0B  Fri Mar 27 21:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_01:00:05_hourly                        0B  Fri Mar 27 21:00 2026
music-tank@autosnap_2026-03-28_01:00:05_hourly                                          0B  Fri Mar 27 21:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_01:00:05_hourly             0B  Fri Mar 27 21:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_01:00:31_hourly                         2.92G  Fri Mar 27 21:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_01:00:08_hourly                 108M  Fri Mar 27 21:00 2026
media-tank@autosnap_2026-03-28_01:00:31_hourly                                       2.63G  Fri Mar 27 21:00 2026
media-tank/postgres@autosnap_2026-03-28_01:00:08_hourly                               130M  Fri Mar 27 21:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_01:00:31_hourly                      0B  Fri Mar 27 21:00 2026
media-tank/mysql@autosnap_2026-03-28_01:00:31_hourly                                    0B  Fri Mar 27 21:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_01:00:33_hourly                 0B  Fri Mar 27 21:00 2026
music-tank/audiobooks@autosnap_2026-03-28_01:00:33_hourly                               0B  Fri Mar 27 21:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_02:00:05_hourly                         1.30G  Fri Mar 27 22:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_02:00:06_hourly                        0B  Fri Mar 27 22:00 2026
media-tank@autosnap_2026-03-28_02:00:05_hourly                                       1.10G  Fri Mar 27 22:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_02:00:06_hourly                 112M  Fri Mar 27 22:00 2026
media-tank/postgres@autosnap_2026-03-28_02:00:06_hourly                               133M  Fri Mar 27 22:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_02:00:20_hourly                 0B  Fri Mar 27 22:00 2026
music-tank/audiobooks@autosnap_2026-03-28_02:00:20_hourly                               0B  Fri Mar 27 22:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_02:00:20_hourly             0B  Fri Mar 27 22:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_02:00:22_hourly                      0B  Fri Mar 27 22:00 2026
media-tank/mysql@autosnap_2026-03-28_02:00:22_hourly                                    0B  Fri Mar 27 22:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_02:00:24_hourly                            0B  Fri Mar 27 22:00 2026
music-tank@autosnap_2026-03-28_02:00:24_hourly                                          0B  Fri Mar 27 22:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_03:00:05_hourly                      0B  Fri Mar 27 23:00 2026
media-tank/mysql@autosnap_2026-03-28_03:00:05_hourly                                    0B  Fri Mar 27 23:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_03:00:06_hourly                          480M  Fri Mar 27 23:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_03:00:06_hourly             0B  Fri Mar 27 23:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_03:00:06_hourly                            0B  Fri Mar 27 23:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_03:00:06_hourly                 0B  Fri Mar 27 23:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_03:00:06_hourly                        0B  Fri Mar 27 23:00 2026
media-tank@autosnap_2026-03-28_03:00:06_hourly                                        436M  Fri Mar 27 23:00 2026
music-tank@autosnap_2026-03-28_03:00:06_hourly                                          0B  Fri Mar 27 23:00 2026
music-tank/audiobooks@autosnap_2026-03-28_03:00:06_hourly                               0B  Fri Mar 27 23:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_03:00:07_hourly                31.8M  Fri Mar 27 23:00 2026
media-tank/postgres@autosnap_2026-03-28_03:00:07_hourly                              37.6M  Fri Mar 27 23:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_04:00:05_daily                           868K  Sat Mar 28  0:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_04:00:05_hourly             0B  Sat Mar 28  0:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_04:00:05_daily                  0B  Sat Mar 28  0:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_04:00:05_hourly                 0B  Sat Mar 28  0:00 2026
media-tank@autosnap_2026-03-28_04:00:05_daily                                         837K  Sat Mar 28  0:00 2026
music-tank/audiobooks@autosnap_2026-03-28_04:00:05_daily                                0B  Sat Mar 28  0:00 2026
music-tank/audiobooks@autosnap_2026-03-28_04:00:05_hourly                               0B  Sat Mar 28  0:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_04:00:05_hourly                          864K  Sat Mar 28  0:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_04:00:06_hourly                        0B  Sat Mar 28  0:00 2026
media-tank@autosnap_2026-03-28_04:00:05_hourly                                        825K  Sat Mar 28  0:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_04:00:06_daily                    0B  Sat Mar 28  0:00 2026
media-tank/postgres@autosnap_2026-03-28_04:00:06_daily                                  0B  Sat Mar 28  0:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_04:00:09_daily                       0B  Sat Mar 28  0:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_04:00:06_hourly                   0B  Sat Mar 28  0:00 2026
media-tank/mysql@autosnap_2026-03-28_04:00:09_daily                                     0B  Sat Mar 28  0:00 2026
media-tank/postgres@autosnap_2026-03-28_04:00:06_hourly                                 0B  Sat Mar 28  0:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_04:00:09_hourly                      0B  Sat Mar 28  0:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_04:00:10_daily                             0B  Sat Mar 28  0:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_04:00:10_hourly                            0B  Sat Mar 28  0:00 2026
media-tank/mysql@autosnap_2026-03-28_04:00:09_hourly                                    0B  Sat Mar 28  0:00 2026
music-tank@autosnap_2026-03-28_04:00:10_daily                                           0B  Sat Mar 28  0:00 2026
music-tank@autosnap_2026-03-28_04:00:10_hourly                                          0B  Sat Mar 28  0:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_04:15:01_daily                         0B  Sat Mar 28  0:15 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_05:00:05_hourly                      0B  Sat Mar 28  1:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_05:00:05_hourly                 0B  Sat Mar 28  1:00 2026
media-tank/mysql@autosnap_2026-03-28_05:00:05_hourly                                    0B  Sat Mar 28  1:00 2026
music-tank/audiobooks@autosnap_2026-03-28_05:00:05_hourly                               0B  Sat Mar 28  1:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_05:00:08_hourly                          251M  Sat Mar 28  1:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_05:00:05_hourly                18.4M  Sat Mar 28  1:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_05:00:08_hourly                        0B  Sat Mar 28  1:00 2026
media-tank@autosnap_2026-03-28_05:00:08_hourly                                        228M  Sat Mar 28  1:00 2026
media-tank/postgres@autosnap_2026-03-28_05:00:05_hourly                              19.0M  Sat Mar 28  1:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_05:00:08_hourly             0B  Sat Mar 28  1:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_05:00:09_hourly                            0B  Sat Mar 28  1:00 2026
music-tank@autosnap_2026-03-28_05:00:09_hourly                                          0B  Sat Mar 28  1:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_06:00:05_hourly                          245M  Sat Mar 28  2:00 2026
media-tank@autosnap_2026-03-28_06:00:05_hourly                                        224M  Sat Mar 28  2:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_06:00:06_hourly                            0B  Sat Mar 28  2:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_06:00:06_hourly                 0B  Sat Mar 28  2:00 2026
music-tank@autosnap_2026-03-28_06:00:06_hourly                                          0B  Sat Mar 28  2:00 2026
music-tank/audiobooks@autosnap_2026-03-28_06:00:06_hourly                               0B  Sat Mar 28  2:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_06:00:06_hourly                      0B  Sat Mar 28  2:00 2026
media-tank/mysql@autosnap_2026-03-28_06:00:06_hourly                                    0B  Sat Mar 28  2:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_06:00:07_hourly                20.8M  Sat Mar 28  2:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_06:00:09_hourly             0B  Sat Mar 28  2:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_06:00:09_hourly                        0B  Sat Mar 28  2:00 2026
media-tank/postgres@autosnap_2026-03-28_06:00:07_hourly                              21.4M  Sat Mar 28  2:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_07:00:01_hourly                23.4M  Sat Mar 28  3:00 2026
media-tank/postgres@autosnap_2026-03-28_07:00:01_hourly                              24.2M  Sat Mar 28  3:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_07:00:03_hourly                      0B  Sat Mar 28  3:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_07:00:03_hourly             0B  Sat Mar 28  3:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_07:00:03_hourly                            0B  Sat Mar 28  3:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_07:00:03_hourly                 0B  Sat Mar 28  3:00 2026
media-tank/mysql@autosnap_2026-03-28_07:00:03_hourly                                    0B  Sat Mar 28  3:00 2026
music-tank@autosnap_2026-03-28_07:00:03_hourly                                          0B  Sat Mar 28  3:00 2026
music-tank/audiobooks@autosnap_2026-03-28_07:00:03_hourly                               0B  Sat Mar 28  3:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_07:00:04_hourly                          279M  Sat Mar 28  3:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_07:00:04_hourly                      960K  Sat Mar 28  3:00 2026
media-tank@autosnap_2026-03-28_07:00:04_hourly                                        252M  Sat Mar 28  3:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_08:00:05_hourly                            0B  Sat Mar 28  4:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_08:00:05_hourly                 0B  Sat Mar 28  4:00 2026
music-tank@autosnap_2026-03-28_08:00:05_hourly                                          0B  Sat Mar 28  4:00 2026
music-tank/audiobooks@autosnap_2026-03-28_08:00:05_hourly                               0B  Sat Mar 28  4:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_08:00:06_hourly                          213M  Sat Mar 28  4:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_08:00:06_hourly                      0B  Sat Mar 28  4:00 2026
media-tank@autosnap_2026-03-28_08:00:06_hourly                                        194M  Sat Mar 28  4:00 2026
media-tank/mysql@autosnap_2026-03-28_08:00:06_hourly                                    0B  Sat Mar 28  4:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_08:00:07_hourly                        0B  Sat Mar 28  4:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_08:00:07_hourly                25.2M  Sat Mar 28  4:00 2026
media-tank/postgres@autosnap_2026-03-28_08:00:07_hourly                              25.6M  Sat Mar 28  4:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_09:00:06_hourly                          712M  Sat Mar 28  5:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_09:00:05_hourly                      0B  Sat Mar 28  5:00 2026
media-tank@autosnap_2026-03-28_09:00:06_hourly                                        666M  Sat Mar 28  5:00 2026
media-tank/mysql@autosnap_2026-03-28_09:00:05_hourly                                    0B  Sat Mar 28  5:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_09:00:07_hourly             0B  Sat Mar 28  5:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_09:00:07_hourly                20.4M  Sat Mar 28  5:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_09:00:10_hourly                            0B  Sat Mar 28  5:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_09:00:10_hourly                 0B  Sat Mar 28  5:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_09:00:10_hourly                        0B  Sat Mar 28  5:00 2026
media-tank/postgres@autosnap_2026-03-28_09:00:07_hourly                              21.4M  Sat Mar 28  5:00 2026
music-tank@autosnap_2026-03-28_09:00:10_hourly                                          0B  Sat Mar 28  5:00 2026
music-tank/audiobooks@autosnap_2026-03-28_09:00:10_hourly                               0B  Sat Mar 28  5:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_10:00:00_hourly                         6.75G  Sat Mar 28  6:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_10:00:01_hourly             0B  Sat Mar 28  6:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_10:00:01_hourly                            0B  Sat Mar 28  6:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_10:00:01_hourly                 0B  Sat Mar 28  6:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_10:00:01_hourly                        0B  Sat Mar 28  6:00 2026
media-tank@autosnap_2026-03-28_10:00:00_hourly                                       6.55G  Sat Mar 28  6:00 2026
music-tank@autosnap_2026-03-28_10:00:01_hourly                                          0B  Sat Mar 28  6:00 2026
music-tank/audiobooks@autosnap_2026-03-28_10:00:01_hourly                               0B  Sat Mar 28  6:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_10:00:01_hourly                28.2M  Sat Mar 28  6:00 2026
media-tank/postgres@autosnap_2026-03-28_10:00:01_hourly                              28.8M  Sat Mar 28  6:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_10:00:08_hourly                      0B  Sat Mar 28  6:00 2026
media-tank/mysql@autosnap_2026-03-28_10:00:08_hourly                                    0B  Sat Mar 28  6:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_11:00:03_hourly                        0B  Sat Mar 28  7:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_11:00:04_hourly                         6.14G  Sat Mar 28  7:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_11:00:03_hourly             0B  Sat Mar 28  7:00 2026
media-tank@autosnap_2026-03-28_11:00:04_hourly                                       5.92G  Sat Mar 28  7:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_11:00:04_hourly                20.4M  Sat Mar 28  7:00 2026
media-tank/postgres@autosnap_2026-03-28_11:00:04_hourly                              21.1M  Sat Mar 28  7:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_11:00:07_hourly                      0B  Sat Mar 28  7:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_11:00:08_hourly                            0B  Sat Mar 28  7:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_11:00:08_hourly                 0B  Sat Mar 28  7:00 2026
media-tank/mysql@autosnap_2026-03-28_11:00:07_hourly                                    0B  Sat Mar 28  7:00 2026
music-tank@autosnap_2026-03-28_11:00:08_hourly                                          0B  Sat Mar 28  7:00 2026
music-tank/audiobooks@autosnap_2026-03-28_11:00:08_hourly                               0B  Sat Mar 28  7:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_12:00:05_hourly                      0B  Sat Mar 28  8:00 2026
media-tank/mysql@autosnap_2026-03-28_12:00:05_hourly                                    0B  Sat Mar 28  8:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_12:00:08_hourly                         6.36G  Sat Mar 28  8:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_12:00:06_hourly                29.4M  Sat Mar 28  8:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_12:00:08_hourly                            0B  Sat Mar 28  8:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_12:00:08_hourly                 0B  Sat Mar 28  8:00 2026
media-tank@autosnap_2026-03-28_12:00:08_hourly                                       6.11G  Sat Mar 28  8:00 2026
media-tank/postgres@autosnap_2026-03-28_12:00:06_hourly                              30.2M  Sat Mar 28  8:00 2026
music-tank@autosnap_2026-03-28_12:00:08_hourly                                          0B  Sat Mar 28  8:00 2026
music-tank/audiobooks@autosnap_2026-03-28_12:00:08_hourly                               0B  Sat Mar 28  8:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_12:00:09_hourly             0B  Sat Mar 28  8:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_12:00:09_hourly                        0B  Sat Mar 28  8:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_13:00:05_hourly                            0B  Sat Mar 28  9:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_13:00:05_hourly                 0B  Sat Mar 28  9:00 2026
music-tank@autosnap_2026-03-28_13:00:05_hourly                                          0B  Sat Mar 28  9:00 2026
music-tank/audiobooks@autosnap_2026-03-28_13:00:05_hourly                               0B  Sat Mar 28  9:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_13:00:05_hourly                         7.13G  Sat Mar 28  9:00 2026
media-tank@autosnap_2026-03-28_13:00:05_hourly                                       6.82G  Sat Mar 28  9:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_13:00:13_hourly                        0B  Sat Mar 28  9:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_13:00:14_hourly                37.7M  Sat Mar 28  9:01 2026
media-tank/postgres@autosnap_2026-03-28_13:00:14_hourly                              43.2M  Sat Mar 28  9:01 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_13:01:14_hourly                      0B  Sat Mar 28  9:01 2026
media-tank/mysql@autosnap_2026-03-28_13:01:14_hourly                                    0B  Sat Mar 28  9:01 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_13:01:16_hourly             0B  Sat Mar 28  9:01 2026
backup-tank/music-mirror@autosnap_2026-03-28_14:00:05_hourly                            0B  Sat Mar 28 10:00 2026
music-tank@autosnap_2026-03-28_14:00:05_hourly                                          0B  Sat Mar 28 10:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_14:00:05_hourly             0B  Sat Mar 28 10:00 2026
media-tank/server-configs@autosnap_2026-03-28_14:00:05_hourly                           0B  Sat Mar 28 10:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_14:00:08_hourly                      0B  Sat Mar 28 10:00 2026
media-tank/mysql@autosnap_2026-03-28_14:00:08_hourly                                    0B  Sat Mar 28 10:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_14:00:11_hourly                 0B  Sat Mar 28 10:00 2026
music-tank/audiobooks@autosnap_2026-03-28_14:00:11_hourly                               0B  Sat Mar 28 10:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_14:00:11_hourly                91.2M  Sat Mar 28 10:00 2026
media-tank/postgres@autosnap_2026-03-28_14:00:11_hourly                               103M  Sat Mar 28 10:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_14:00:31_hourly                        0B  Sat Mar 28 10:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_14:00:31_hourly                         4.02G  Sat Mar 28 10:00 2026
media-tank@autosnap_2026-03-28_14:00:31_hourly                                       3.68G  Sat Mar 28 10:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_15:00:05_hourly                           72K  Sat Mar 28 11:00 2026
music-tank@autosnap_2026-03-28_15:00:05_hourly                                       95.9K  Sat Mar 28 11:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_15:00:05_hourly                 104M  Sat Mar 28 11:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_15:00:18_hourly                 0B  Sat Mar 28 11:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_15:00:18_hourly                        0B  Sat Mar 28 11:00 2026
media-tank/postgres@autosnap_2026-03-28_15:00:05_hourly                               113M  Sat Mar 28 11:00 2026
music-tank/audiobooks@autosnap_2026-03-28_15:00:18_hourly                               0B  Sat Mar 28 11:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_15:00:18_hourly                          885M  Sat Mar 28 11:00 2026
media-tank@autosnap_2026-03-28_15:00:18_hourly                                        758M  Sat Mar 28 11:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_15:00:20_hourly                      0B  Sat Mar 28 11:00 2026
media-tank/mysql@autosnap_2026-03-28_15:00:20_hourly                                    0B  Sat Mar 28 11:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_15:00:21_hourly           104K  Sat Mar 28 11:00 2026
media-tank/server-configs@autosnap_2026-03-28_15:00:21_hourly                         116K  Sat Mar 28 11:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_16:00:08_hourly                          484M  Sat Mar 28 12:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_16:00:01_hourly                42.4M  Sat Mar 28 12:00 2026
media-tank@autosnap_2026-03-28_16:00:08_hourly                                        453M  Sat Mar 28 12:00 2026
media-tank/postgres@autosnap_2026-03-28_16:00:01_hourly                              42.8M  Sat Mar 28 12:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_16:00:09_hourly            76K  Sat Mar 28 12:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_16:00:09_hourly                          248K  Sat Mar 28 12:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_16:00:09_hourly                 0B  Sat Mar 28 12:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_16:00:09_hourly                        0B  Sat Mar 28 12:00 2026
media-tank/server-configs@autosnap_2026-03-28_16:00:09_hourly                        81.4K  Sat Mar 28 12:00 2026
music-tank@autosnap_2026-03-28_16:00:09_hourly                                        298K  Sat Mar 28 12:00 2026
music-tank/audiobooks@autosnap_2026-03-28_16:00:09_hourly                               0B  Sat Mar 28 12:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_16:00:09_hourly                      0B  Sat Mar 28 12:00 2026
media-tank/mysql@autosnap_2026-03-28_16:00:09_hourly                                    0B  Sat Mar 28 12:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_17:00:05_hourly                          272K  Sat Mar 28 13:00 2026
music-tank@autosnap_2026-03-28_17:00:05_hourly                                        330K  Sat Mar 28 13:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_17:00:05_hourly                          311M  Sat Mar 28 13:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_17:00:06_hourly            76K  Sat Mar 28 13:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_17:00:06_hourly                 0B  Sat Mar 28 13:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_17:00:06_hourly                        0B  Sat Mar 28 13:00 2026
media-tank@autosnap_2026-03-28_17:00:05_hourly                                        281M  Sat Mar 28 13:00 2026
media-tank/server-configs@autosnap_2026-03-28_17:00:06_hourly                        81.4K  Sat Mar 28 13:00 2026
music-tank/audiobooks@autosnap_2026-03-28_17:00:06_hourly                               0B  Sat Mar 28 13:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_17:00:11_hourly                      0B  Sat Mar 28 13:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_17:00:07_hourly                58.7M  Sat Mar 28 13:00 2026
media-tank/mysql@autosnap_2026-03-28_17:00:11_hourly                                    0B  Sat Mar 28 13:00 2026
media-tank/postgres@autosnap_2026-03-28_17:00:07_hourly                              58.8M  Sat Mar 28 13:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_18:00:04_hourly                      0B  Sat Mar 28 14:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_18:00:05_hourly           104K  Sat Mar 28 14:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_18:00:05_hourly                            0B  Sat Mar 28 14:00 2026
media-tank/mysql@autosnap_2026-03-28_18:00:04_hourly                                    0B  Sat Mar 28 14:00 2026
media-tank/server-configs@autosnap_2026-03-28_18:00:05_hourly                         116K  Sat Mar 28 14:00 2026
music-tank@autosnap_2026-03-28_18:00:05_hourly                                          0B  Sat Mar 28 14:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_18:00:15_hourly                          442M  Sat Mar 28 14:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_18:00:05_hourly                32.5M  Sat Mar 28 14:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_18:00:15_hourly                 0B  Sat Mar 28 14:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_18:00:15_hourly                        0B  Sat Mar 28 14:00 2026
media-tank@autosnap_2026-03-28_18:00:15_hourly                                        405M  Sat Mar 28 14:00 2026
media-tank/postgres@autosnap_2026-03-28_18:00:05_hourly                              34.6M  Sat Mar 28 14:00 2026
music-tank/audiobooks@autosnap_2026-03-28_18:00:15_hourly                               0B  Sat Mar 28 14:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_19:00:05_hourly                        0B  Sat Mar 28 15:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_19:00:05_hourly                      0B  Sat Mar 28 15:00 2026
media-tank/mysql@autosnap_2026-03-28_19:00:05_hourly                                    0B  Sat Mar 28 15:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_19:00:06_hourly                78.8M  Sat Mar 28 15:00 2026
media-tank/postgres@autosnap_2026-03-28_19:00:06_hourly                              82.4M  Sat Mar 28 15:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_19:00:20_hourly                          508M  Sat Mar 28 15:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_19:00:20_hourly                            0B  Sat Mar 28 15:00 2026
media-tank@autosnap_2026-03-28_19:00:20_hourly                                        452M  Sat Mar 28 15:00 2026
music-tank@autosnap_2026-03-28_19:00:20_hourly                                          0B  Sat Mar 28 15:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_19:00:21_hourly             0B  Sat Mar 28 15:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_19:00:21_hourly                 0B  Sat Mar 28 15:00 2026
media-tank/server-configs@autosnap_2026-03-28_19:00:21_hourly                           0B  Sat Mar 28 15:00 2026
music-tank/audiobooks@autosnap_2026-03-28_19:00:21_hourly                               0B  Sat Mar 28 15:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_20:00:05_hourly                            0B  Sat Mar 28 16:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_20:00:05_hourly                 0B  Sat Mar 28 16:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_20:00:05_hourly                        0B  Sat Mar 28 16:00 2026
music-tank@autosnap_2026-03-28_20:00:05_hourly                                          0B  Sat Mar 28 16:00 2026
music-tank/audiobooks@autosnap_2026-03-28_20:00:05_hourly                               0B  Sat Mar 28 16:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_20:00:06_hourly                      0B  Sat Mar 28 16:00 2026
media-tank/mysql@autosnap_2026-03-28_20:00:06_hourly                                    0B  Sat Mar 28 16:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_20:00:08_hourly                          545M  Sat Mar 28 16:00 2026
media-tank@autosnap_2026-03-28_20:00:08_hourly                                        481M  Sat Mar 28 16:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_20:00:09_hourly             0B  Sat Mar 28 16:00 2026
media-tank/server-configs@autosnap_2026-03-28_20:00:09_hourly                           0B  Sat Mar 28 16:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_20:00:11_hourly                 123M  Sat Mar 28 16:00 2026
media-tank/postgres@autosnap_2026-03-28_20:00:11_hourly                               129M  Sat Mar 28 16:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_21:00:12_hourly                        0B  Sat Mar 28 17:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_21:00:12_hourly                         7.04G  Sat Mar 28 17:00 2026
media-tank@autosnap_2026-03-28_21:00:12_hourly                                       6.77G  Sat Mar 28 17:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_21:00:14_hourly                      0B  Sat Mar 28 17:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_21:00:15_hourly                 0B  Sat Mar 28 17:00 2026
media-tank/mysql@autosnap_2026-03-28_21:00:14_hourly                                    0B  Sat Mar 28 17:00 2026
music-tank/audiobooks@autosnap_2026-03-28_21:00:15_hourly                               0B  Sat Mar 28 17:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_21:00:15_hourly             0B  Sat Mar 28 17:00 2026
media-tank/server-configs@autosnap_2026-03-28_21:00:15_hourly                           0B  Sat Mar 28 17:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_21:00:19_hourly                 128M  Sat Mar 28 17:00 2026
media-tank/postgres@autosnap_2026-03-28_21:00:19_hourly                               137M  Sat Mar 28 17:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_21:00:29_hourly                            0B  Sat Mar 28 17:00 2026
music-tank@autosnap_2026-03-28_21:00:29_hourly                                          0B  Sat Mar 28 17:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_22:00:00_hourly                            0B  Sat Mar 28 18:00 2026
music-tank@autosnap_2026-03-28_22:00:00_hourly                                          0B  Sat Mar 28 18:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_22:00:00_hourly                 175M  Sat Mar 28 18:00 2026
media-tank/postgres@autosnap_2026-03-28_22:00:00_hourly                               200M  Sat Mar 28 18:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_22:00:10_hourly                          839M  Sat Mar 28 18:00 2026
media-tank@autosnap_2026-03-28_22:00:10_hourly                                        734M  Sat Mar 28 18:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_22:00:12_hourly                 0B  Sat Mar 28 18:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_22:00:12_hourly                        0B  Sat Mar 28 18:00 2026
music-tank/audiobooks@autosnap_2026-03-28_22:00:12_hourly                               0B  Sat Mar 28 18:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_22:00:12_hourly             0B  Sat Mar 28 18:00 2026
media-tank/server-configs@autosnap_2026-03-28_22:00:12_hourly                           0B  Sat Mar 28 18:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_22:00:14_hourly                      0B  Sat Mar 28 18:00 2026
media-tank/mysql@autosnap_2026-03-28_22:00:14_hourly                                    0B  Sat Mar 28 18:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-28_23:00:05_hourly                        0B  Sat Mar 28 19:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-28_23:00:05_hourly             0B  Sat Mar 28 19:00 2026
media-tank/server-configs@autosnap_2026-03-28_23:00:05_hourly                           0B  Sat Mar 28 19:00 2026
backup-tank/music-mirror@autosnap_2026-03-28_23:00:08_hourly                            0B  Sat Mar 28 19:00 2026
music-tank@autosnap_2026-03-28_23:00:08_hourly                                          0B  Sat Mar 28 19:00 2026
backup-tank/media-mirror@autosnap_2026-03-28_23:00:09_hourly                         1.92G  Sat Mar 28 19:00 2026
media-tank@autosnap_2026-03-28_23:00:09_hourly                                       1.73G  Sat Mar 28 19:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-28_23:00:09_hourly                      0B  Sat Mar 28 19:00 2026
media-tank/mysql@autosnap_2026-03-28_23:00:09_hourly                                    0B  Sat Mar 28 19:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-28_23:00:11_hourly                 0B  Sat Mar 28 19:00 2026
music-tank/audiobooks@autosnap_2026-03-28_23:00:11_hourly                               0B  Sat Mar 28 19:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-28_23:00:11_hourly                 115M  Sat Mar 28 19:00 2026
media-tank/postgres@autosnap_2026-03-28_23:00:11_hourly                               128M  Sat Mar 28 19:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-29_00:00:05_hourly                 143M  Sat Mar 28 20:00 2026
media-tank/postgres@autosnap_2026-03-29_00:00:05_hourly                               159M  Sat Mar 28 20:00 2026
backup-tank/media-mirror@autosnap_2026-03-29_00:00:28_hourly                         5.67G  Sat Mar 28 20:00 2026
media-tank@autosnap_2026-03-29_00:00:28_hourly                                       5.35G  Sat Mar 28 20:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-29_00:00:31_hourly                 0B  Sat Mar 28 20:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_00:00:31_hourly                        0B  Sat Mar 28 20:00 2026
music-tank/audiobooks@autosnap_2026-03-29_00:00:31_hourly                               0B  Sat Mar 28 20:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-29_00:00:31_hourly                      0B  Sat Mar 28 20:00 2026
media-tank/mysql@autosnap_2026-03-29_00:00:31_hourly                                    0B  Sat Mar 28 20:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-29_00:00:35_daily              0B  Sat Mar 28 20:00 2026
media-tank/server-configs@autosnap_2026-03-29_00:00:35_daily                            0B  Sat Mar 28 20:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-29_00:00:35_hourly             0B  Sat Mar 28 20:00 2026
media-tank/server-configs@autosnap_2026-03-29_00:00:35_hourly                           0B  Sat Mar 28 20:00 2026
backup-tank/music-mirror@autosnap_2026-03-29_00:00:45_hourly                            0B  Sat Mar 28 20:00 2026
music-tank@autosnap_2026-03-29_00:00:45_hourly                                          0B  Sat Mar 28 20:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-29_01:00:04_hourly                 0B  Sat Mar 28 21:00 2026
music-tank/audiobooks@autosnap_2026-03-29_01:00:04_hourly                               0B  Sat Mar 28 21:00 2026
backup-tank/media-mirror@autosnap_2026-03-29_01:00:04_hourly                         1.41G  Sat Mar 28 21:00 2026
media-tank@autosnap_2026-03-29_01:00:04_hourly                                       1.13G  Sat Mar 28 21:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-29_01:00:07_hourly             0B  Sat Mar 28 21:00 2026
backup-tank/music-mirror@autosnap_2026-03-29_01:00:07_hourly                            0B  Sat Mar 28 21:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_01:00:07_hourly                        0B  Sat Mar 28 21:00 2026
media-tank/server-configs@autosnap_2026-03-29_01:00:07_hourly                           0B  Sat Mar 28 21:00 2026
music-tank@autosnap_2026-03-29_01:00:07_hourly                                          0B  Sat Mar 28 21:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-29_01:00:08_hourly                56.8M  Sat Mar 28 21:00 2026
media-tank/postgres@autosnap_2026-03-29_01:00:08_hourly                              61.2M  Sat Mar 28 21:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-29_01:00:21_hourly                      0B  Sat Mar 28 21:00 2026
media-tank/mysql@autosnap_2026-03-29_01:00:21_hourly                                    0B  Sat Mar 28 21:00 2026
backup-tank/media-mirror@pre-down-20260328-212843                                     235M  Sat Mar 28 21:28 2026
backup-tank/media-mirror/docker@pre-down-20260328-212843                             1.27G  Sat Mar 28 21:28 2026
backup-tank/media-mirror/mysql@pre-down-20260328-212843                                80K  Sat Mar 28 21:28 2026
backup-tank/media-mirror/postgres@pre-down-20260328-212843                           1.06M  Sat Mar 28 21:28 2026
backup-tank/media-mirror/server-configs@pre-down-20260328-212843                        0B  Sat Mar 28 21:28 2026
media-tank@pre-down-20260328-212843                                                  96.9M  Sat Mar 28 21:28 2026
media-tank/docker@pre-down-20260328-212843                                           1.19G  Sat Mar 28 21:28 2026
media-tank/mysql@pre-down-20260328-212843                                             116K  Sat Mar 28 21:28 2026
media-tank/postgres@pre-down-20260328-212843                                         1.52M  Sat Mar 28 21:28 2026
media-tank/server-configs@pre-down-20260328-212843                                      0B  Sat Mar 28 21:28 2026
backup-tank/music-mirror@pre-down-20260328-212843                                       0B  Sat Mar 28 21:28 2026
backup-tank/music-mirror/audiobooks@pre-down-20260328-212843                            0B  Sat Mar 28 21:28 2026
music-tank@pre-down-20260328-212843                                                     0B  Sat Mar 28 21:28 2026
music-tank/audiobooks@pre-down-20260328-212843                                          0B  Sat Mar 28 21:28 2026
backup-tank/media-mirror@pre-up-20260328-214235                                         0B  Sat Mar 28 21:42 2026
backup-tank/media-mirror/docker@pre-up-20260328-214235                               1.77M  Sat Mar 28 21:42 2026
backup-tank/media-mirror/mysql@pre-up-20260328-214235                                   0B  Sat Mar 28 21:42 2026
backup-tank/media-mirror/postgres@pre-up-20260328-214235                              432K  Sat Mar 28 21:42 2026
backup-tank/media-mirror/server-configs@pre-up-20260328-214235                          0B  Sat Mar 28 21:42 2026
media-tank@pre-up-20260328-214235                                                       0B  Sat Mar 28 21:42 2026
media-tank/docker@pre-up-20260328-214235                                             1.91M  Sat Mar 28 21:42 2026
media-tank/mysql@pre-up-20260328-214235                                                 0B  Sat Mar 28 21:42 2026
media-tank/postgres@pre-up-20260328-214235                                            604K  Sat Mar 28 21:42 2026
media-tank/server-configs@pre-up-20260328-214235                                        0B  Sat Mar 28 21:42 2026
backup-tank/music-mirror@pre-up-20260328-214235                                         0B  Sat Mar 28 21:42 2026
backup-tank/music-mirror/audiobooks@pre-up-20260328-214235                              0B  Sat Mar 28 21:42 2026
music-tank@pre-up-20260328-214235                                                       0B  Sat Mar 28 21:42 2026
music-tank/audiobooks@pre-up-20260328-214235                                            0B  Sat Mar 28 21:42 2026
backup-tank/media-mirror@pre-up-20260328-214437                                         0B  Sat Mar 28 21:44 2026
backup-tank/media-mirror/docker@pre-up-20260328-214437                               1.72M  Sat Mar 28 21:44 2026
backup-tank/media-mirror/mysql@pre-up-20260328-214437                                   0B  Sat Mar 28 21:44 2026
backup-tank/media-mirror/postgres@pre-up-20260328-214437                              388K  Sat Mar 28 21:44 2026
backup-tank/media-mirror/server-configs@pre-up-20260328-214437                          0B  Sat Mar 28 21:44 2026
backup-tank/music-mirror@pre-up-20260328-214437                                         0B  Sat Mar 28 21:44 2026
backup-tank/music-mirror/audiobooks@pre-up-20260328-214437                              0B  Sat Mar 28 21:44 2026
media-tank@pre-up-20260328-214437                                                       0B  Sat Mar 28 21:44 2026
media-tank/docker@pre-up-20260328-214437                                             1.77M  Sat Mar 28 21:44 2026
media-tank/mysql@pre-up-20260328-214437                                                 0B  Sat Mar 28 21:44 2026
media-tank/postgres@pre-up-20260328-214437                                            529K  Sat Mar 28 21:44 2026
media-tank/server-configs@pre-up-20260328-214437                                        0B  Sat Mar 28 21:44 2026
music-tank@pre-up-20260328-214437                                                       0B  Sat Mar 28 21:44 2026
music-tank/audiobooks@pre-up-20260328-214437                                            0B  Sat Mar 28 21:44 2026
backup-tank/media-mirror@pre-up-20260328-215052                                         0B  Sat Mar 28 21:50 2026
backup-tank/media-mirror/docker@pre-up-20260328-215052                               9.67M  Sat Mar 28 21:50 2026
backup-tank/media-mirror/mysql@pre-up-20260328-215052                                  88K  Sat Mar 28 21:50 2026
backup-tank/media-mirror/postgres@pre-up-20260328-215052                                0B  Sat Mar 28 21:50 2026
backup-tank/media-mirror/server-configs@pre-up-20260328-215052                          0B  Sat Mar 28 21:50 2026
media-tank@pre-up-20260328-215052                                                       0B  Sat Mar 28 21:50 2026
media-tank/docker@pre-up-20260328-215052                                             8.25M  Sat Mar 28 21:50 2026
media-tank/mysql@pre-up-20260328-215052                                               128K  Sat Mar 28 21:50 2026
media-tank/postgres@pre-up-20260328-215052                                              0B  Sat Mar 28 21:50 2026
media-tank/server-configs@pre-up-20260328-215052                                        0B  Sat Mar 28 21:50 2026
backup-tank/music-mirror@pre-up-20260328-215052                                         0B  Sat Mar 28 21:50 2026
backup-tank/music-mirror/audiobooks@pre-up-20260328-215052                              0B  Sat Mar 28 21:50 2026
music-tank@pre-up-20260328-215052                                                       0B  Sat Mar 28 21:50 2026
music-tank/audiobooks@pre-up-20260328-215052                                            0B  Sat Mar 28 21:50 2026
backup-tank/media-mirror@pre-up-20260328-215322                                         0B  Sat Mar 28 21:53 2026
backup-tank/media-mirror/docker@pre-up-20260328-215322                               9.46M  Sat Mar 28 21:53 2026
backup-tank/media-mirror/mysql@pre-up-20260328-215322                                  88K  Sat Mar 28 21:53 2026
backup-tank/media-mirror/postgres@pre-up-20260328-215322                                0B  Sat Mar 28 21:53 2026
backup-tank/media-mirror/server-configs@pre-up-20260328-215322                          0B  Sat Mar 28 21:53 2026
media-tank@pre-up-20260328-215322                                                       0B  Sat Mar 28 21:53 2026
media-tank/docker@pre-up-20260328-215322                                             8.45M  Sat Mar 28 21:53 2026
media-tank/mysql@pre-up-20260328-215322                                               128K  Sat Mar 28 21:53 2026
media-tank/postgres@pre-up-20260328-215322                                              0B  Sat Mar 28 21:53 2026
media-tank/server-configs@pre-up-20260328-215322                                        0B  Sat Mar 28 21:53 2026
backup-tank/music-mirror@pre-up-20260328-215322                                         0B  Sat Mar 28 21:53 2026
backup-tank/music-mirror/audiobooks@pre-up-20260328-215322                              0B  Sat Mar 28 21:53 2026
music-tank@pre-up-20260328-215322                                                       0B  Sat Mar 28 21:53 2026
music-tank/audiobooks@pre-up-20260328-215322                                            0B  Sat Mar 28 21:53 2026
backup-tank/media-mirror@pre-up-20260328-215706                                      1.55M  Sat Mar 28 21:57 2026
backup-tank/media-mirror/docker@pre-up-20260328-215706                               8.59M  Sat Mar 28 21:57 2026
backup-tank/media-mirror/mysql@pre-up-20260328-215706                                   0B  Sat Mar 28 21:57 2026
backup-tank/media-mirror/postgres@pre-up-20260328-215706                              248K  Sat Mar 28 21:57 2026
backup-tank/media-mirror/server-configs@pre-up-20260328-215706                          0B  Sat Mar 28 21:57 2026
backup-tank/music-mirror@pre-up-20260328-215706                                         0B  Sat Mar 28 21:57 2026
backup-tank/music-mirror/audiobooks@pre-up-20260328-215706                              0B  Sat Mar 28 21:57 2026
media-tank@pre-up-20260328-215706                                                     837K  Sat Mar 28 21:57 2026
media-tank/docker@pre-up-20260328-215706                                             8.53M  Sat Mar 28 21:57 2026
media-tank/mysql@pre-up-20260328-215706                                                 0B  Sat Mar 28 21:57 2026
media-tank/postgres@pre-up-20260328-215706                                            326K  Sat Mar 28 21:57 2026
media-tank/server-configs@pre-up-20260328-215706                                        0B  Sat Mar 28 21:57 2026
music-tank@pre-up-20260328-215706                                                       0B  Sat Mar 28 21:57 2026
music-tank/audiobooks@pre-up-20260328-215706                                            0B  Sat Mar 28 21:57 2026
backup-tank/media-mirror@pre-up-20260328-215956                                         0B  Sat Mar 28 21:59 2026
backup-tank/media-mirror/docker@pre-up-20260328-215956                               7.60M  Sat Mar 28 21:59 2026
backup-tank/media-mirror/mysql@pre-up-20260328-215956                                   0B  Sat Mar 28 21:59 2026
backup-tank/media-mirror/postgres@pre-up-20260328-215956                              212K  Sat Mar 28 21:59 2026
backup-tank/media-mirror/server-configs@pre-up-20260328-215956                          0B  Sat Mar 28 21:59 2026
media-tank@pre-up-20260328-215956                                                       0B  Sat Mar 28 21:59 2026
media-tank/docker@pre-up-20260328-215956                                             7.31M  Sat Mar 28 21:59 2026
media-tank/mysql@pre-up-20260328-215956                                                 0B  Sat Mar 28 21:59 2026
media-tank/postgres@pre-up-20260328-215956                                            273K  Sat Mar 28 21:59 2026
media-tank/server-configs@pre-up-20260328-215956                                        0B  Sat Mar 28 21:59 2026
backup-tank/music-mirror@pre-up-20260328-215956                                         0B  Sat Mar 28 21:59 2026
backup-tank/music-mirror/audiobooks@pre-up-20260328-215956                              0B  Sat Mar 28 21:59 2026
music-tank@pre-up-20260328-215956                                                       0B  Sat Mar 28 21:59 2026
music-tank/audiobooks@pre-up-20260328-215956                                            0B  Sat Mar 28 21:59 2026
backup-tank/music-mirror@autosnap_2026-03-29_02:00:00_hourly                            0B  Sat Mar 28 22:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-29_02:00:00_hourly                 0B  Sat Mar 28 22:00 2026
music-tank@autosnap_2026-03-29_02:00:00_hourly                                          0B  Sat Mar 28 22:00 2026
music-tank/audiobooks@autosnap_2026-03-29_02:00:00_hourly                               0B  Sat Mar 28 22:00 2026
backup-tank/media-mirror@autosnap_2026-03-29_02:00:00_hourly                            0B  Sat Mar 28 22:00 2026
media-tank@autosnap_2026-03-29_02:00:00_hourly                                          0B  Sat Mar 28 22:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-29_02:00:02_hourly                 212K  Sat Mar 28 22:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-29_02:00:03_hourly             0B  Sat Mar 28 22:00 2026
media-tank/postgres@autosnap_2026-03-29_02:00:02_hourly                               273K  Sat Mar 28 22:00 2026
media-tank/server-configs@autosnap_2026-03-29_02:00:03_hourly                           0B  Sat Mar 28 22:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-29_02:00:04_hourly                      0B  Sat Mar 28 22:00 2026
media-tank/mysql@autosnap_2026-03-29_02:00:04_hourly                                    0B  Sat Mar 28 22:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_02:00:05_hourly                        0B  Sat Mar 28 22:00 2026
backup-tank/music-mirror@autosnap_2026-03-29_03:00:00_hourly                            0B  Sat Mar 28 23:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-29_03:00:00_hourly                 0B  Sat Mar 28 23:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_03:00:00_hourly                        0B  Sat Mar 28 23:00 2026
music-tank@autosnap_2026-03-29_03:00:00_hourly                                          0B  Sat Mar 28 23:00 2026
music-tank/audiobooks@autosnap_2026-03-29_03:00:00_hourly                               0B  Sat Mar 28 23:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-29_03:00:00_hourly                37.6M  Sat Mar 28 23:00 2026
media-tank/postgres@autosnap_2026-03-29_03:00:00_hourly                              38.2M  Sat Mar 28 23:00 2026
backup-tank/media-mirror@autosnap_2026-03-29_03:00:05_hourly                          802M  Sat Mar 28 23:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-29_03:00:04_hourly                      0B  Sat Mar 28 23:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-29_03:00:05_hourly             0B  Sat Mar 28 23:00 2026
media-tank@autosnap_2026-03-29_03:00:05_hourly                                        732M  Sat Mar 28 23:00 2026
media-tank/mysql@autosnap_2026-03-29_03:00:04_hourly                                    0B  Sat Mar 28 23:00 2026
media-tank/server-configs@autosnap_2026-03-29_03:00:05_hourly                           0B  Sat Mar 28 23:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-29_04:00:00_daily                    0B  Sun Mar 29  0:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-29_04:00:00_hourly                   0B  Sun Mar 29  0:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-29_04:00:02_daily                  0B  Sun Mar 29  0:00 2026
media-tank/postgres@autosnap_2026-03-29_04:00:00_daily                                  0B  Sun Mar 29  0:00 2026
media-tank/postgres@autosnap_2026-03-29_04:00:00_hourly                                 0B  Sun Mar 29  0:00 2026
music-tank/audiobooks@autosnap_2026-03-29_04:00:02_daily                                0B  Sun Mar 29  0:00 2026
backup-tank/media-mirror@autosnap_2026-03-29_04:00:03_daily                             0B  Sun Mar 29  0:00 2026
backup-tank/media-mirror@autosnap_2026-03-29_04:00:03_hourly                            0B  Sun Mar 29  0:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-29_04:00:03_hourly             0B  Sun Mar 29  0:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-29_04:00:02_hourly                 0B  Sun Mar 29  0:00 2026
media-tank@autosnap_2026-03-29_04:00:03_daily                                           0B  Sun Mar 29  0:00 2026
media-tank@autosnap_2026-03-29_04:00:03_hourly                                          0B  Sun Mar 29  0:00 2026
media-tank/server-configs@autosnap_2026-03-29_04:00:03_hourly                           0B  Sun Mar 29  0:00 2026
music-tank/audiobooks@autosnap_2026-03-29_04:00:02_hourly                               0B  Sun Mar 29  0:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-29_04:00:03_daily                       0B  Sun Mar 29  0:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-29_04:00:03_hourly                      0B  Sun Mar 29  0:00 2026
backup-tank/music-mirror@autosnap_2026-03-29_04:00:04_daily                             0B  Sun Mar 29  0:00 2026
backup-tank/music-mirror@autosnap_2026-03-29_04:00:04_hourly                            0B  Sun Mar 29  0:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_04:00:04_hourly                        0B  Sun Mar 29  0:00 2026
media-tank/mysql@autosnap_2026-03-29_04:00:03_daily                                     0B  Sun Mar 29  0:00 2026
media-tank/mysql@autosnap_2026-03-29_04:00:03_hourly                                    0B  Sun Mar 29  0:00 2026
music-tank@autosnap_2026-03-29_04:00:04_daily                                           0B  Sun Mar 29  0:00 2026
music-tank@autosnap_2026-03-29_04:00:04_hourly                                          0B  Sun Mar 29  0:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_04:15:00_daily                         0B  Sun Mar 29  0:15 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-29_05:00:07_hourly             0B  Sun Mar 29  1:00 2026
media-tank/server-configs@autosnap_2026-03-29_05:00:07_hourly                           0B  Sun Mar 29  1:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-29_05:00:09_hourly                 108M  Sun Mar 29  1:00 2026
backup-tank/music-mirror@autosnap_2026-03-29_05:00:20_hourly                            0B  Sun Mar 29  1:00 2026
media-tank/postgres@autosnap_2026-03-29_05:00:09_hourly                               129M  Sun Mar 29  1:00 2026
music-tank@autosnap_2026-03-29_05:00:20_hourly                                          0B  Sun Mar 29  1:00 2026
backup-tank/media-mirror@autosnap_2026-03-29_05:00:21_hourly                          842M  Sun Mar 29  1:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_05:00:21_hourly                        0B  Sun Mar 29  1:00 2026
media-tank@autosnap_2026-03-29_05:00:21_hourly                                        372M  Sun Mar 29  1:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-29_05:00:23_hourly                      0B  Sun Mar 29  1:00 2026
media-tank/mysql@autosnap_2026-03-29_05:00:23_hourly                                    0B  Sun Mar 29  1:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-29_05:00:27_hourly                 0B  Sun Mar 29  1:00 2026
music-tank/audiobooks@autosnap_2026-03-29_05:00:27_hourly                               0B  Sun Mar 29  1:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-29_06:00:00_hourly                 0B  Sun Mar 29  2:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_06:00:00_hourly                        0B  Sun Mar 29  2:00 2026
music-tank/audiobooks@autosnap_2026-03-29_06:00:00_hourly                               0B  Sun Mar 29  2:00 2026
backup-tank/music-mirror@autosnap_2026-03-29_06:00:01_hourly                            0B  Sun Mar 29  2:00 2026
music-tank@autosnap_2026-03-29_06:00:01_hourly                                          0B  Sun Mar 29  2:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-29_06:00:01_hourly                      0B  Sun Mar 29  2:00 2026
media-tank/mysql@autosnap_2026-03-29_06:00:01_hourly                                    0B  Sun Mar 29  2:00 2026
backup-tank/media-mirror@autosnap_2026-03-29_06:00:06_hourly                          982M  Sun Mar 29  2:00 2026
media-tank@autosnap_2026-03-29_06:00:06_hourly                                        308M  Sun Mar 29  2:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-29_06:00:07_hourly                 111M  Sun Mar 29  2:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-29_06:00:19_hourly             0B  Sun Mar 29  2:00 2026
media-tank/postgres@autosnap_2026-03-29_06:00:07_hourly                               132M  Sun Mar 29  2:00 2026
media-tank/server-configs@autosnap_2026-03-29_06:00:19_hourly                           0B  Sun Mar 29  2:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-29_07:00:08_hourly             0B  Sun Mar 29  3:00 2026
media-tank/server-configs@autosnap_2026-03-29_07:00:08_hourly                           0B  Sun Mar 29  3:00 2026
backup-tank/media-mirror@autosnap_2026-03-29_07:00:09_hourly                          647M  Sun Mar 29  3:00 2026
media-tank@autosnap_2026-03-29_07:00:09_hourly                                        237M  Sun Mar 29  3:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-29_07:00:11_hourly                      0B  Sun Mar 29  3:00 2026
media-tank/mysql@autosnap_2026-03-29_07:00:11_hourly                                    0B  Sun Mar 29  3:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-29_07:00:14_hourly                 0B  Sun Mar 29  3:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_07:00:14_hourly                     1.34M  Sun Mar 29  3:00 2026
music-tank/audiobooks@autosnap_2026-03-29_07:00:14_hourly                               0B  Sun Mar 29  3:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-29_07:00:14_hourly                 147M  Sun Mar 29  3:00 2026
backup-tank/music-mirror@autosnap_2026-03-29_07:00:30_hourly                            0B  Sun Mar 29  3:00 2026
media-tank/postgres@autosnap_2026-03-29_07:00:14_hourly                               172M  Sun Mar 29  3:00 2026
music-tank@autosnap_2026-03-29_07:00:30_hourly                                          0B  Sun Mar 29  3:00 2026
backup-tank/media-mirror@syncoid_media_2026-03-29:03:30:00-GMT-04:00                    0B  Sun Mar 29  3:30 2026
media-tank@syncoid_media_2026-03-29:03:30:00-GMT-04:00                                228M  Sun Mar 29  3:30 2026
media-tank@autosnap_2026-03-29_08:00:14_hourly                                        239M  Sun Mar 29  4:00 2026
backup-tank/music-mirror@autosnap_2026-03-29_08:00:17_hourly                            0B  Sun Mar 29  4:00 2026
music-tank@autosnap_2026-03-29_08:00:17_hourly                                          0B  Sun Mar 29  4:00 2026
backup-tank/media-mirror/mysql@autosnap_2026-03-29_08:00:18_hourly                      0B  Sun Mar 29  4:00 2026
backup-tank/media-mirror/server-configs@autosnap_2026-03-29_08:00:17_hourly             0B  Sun Mar 29  4:00 2026
media-tank/mysql@autosnap_2026-03-29_08:00:18_hourly                                    0B  Sun Mar 29  4:00 2026
media-tank/server-configs@autosnap_2026-03-29_08:00:17_hourly                           0B  Sun Mar 29  4:00 2026
backup-tank/media-mirror/postgres@autosnap_2026-03-29_08:00:19_hourly                 114M  Sun Mar 29  4:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_08:00:32_hourly                        0B  Sun Mar 29  4:00 2026
media-tank/postgres@autosnap_2026-03-29_08:00:19_hourly                               137M  Sun Mar 29  4:00 2026
backup-tank/music-mirror/audiobooks@autosnap_2026-03-29_08:00:33_hourly                 0B  Sun Mar 29  4:00 2026
music-tank/audiobooks@autosnap_2026-03-29_08:00:33_hourly                               0B  Sun Mar 29  4:00 2026
backup-tank/media-mirror/docker@syncoid_media_2026-03-29:04:37:06-GMT-04:00             0B  Sun Mar 29  4:37 2026
media-tank/docker@syncoid_media_2026-03-29:04:37:06-GMT-04:00                        22.4M  Sun Mar 29  4:37 2026
backup-tank/media-mirror/mysql@syncoid_media_2026-03-29:04:42:08-GMT-04:00              0B  Sun Mar 29  4:42 2026
media-tank/mysql@syncoid_media_2026-03-29:04:42:08-GMT-04:00                            0B  Sun Mar 29  4:42 2026
backup-tank/media-mirror/postgres@syncoid_media_2026-03-29:04:42:18-GMT-04:00           0B  Sun Mar 29  4:42 2026
media-tank/postgres@syncoid_media_2026-03-29:04:42:18-GMT-04:00                      87.4M  Sun Mar 29  4:42 2026
backup-tank/media-mirror/server-configs@syncoid_media_2026-03-29:04:42:30-GMT-04:00     0B  Sun Mar 29  4:42 2026
media-tank/server-configs@syncoid_media_2026-03-29:04:42:30-GMT-04:00                   0B  Sun Mar 29  4:42 2026
media-tank/mysql@autosnap_2026-03-29_09:00:00_hourly                                    0B  Sun Mar 29  5:00 2026
media-tank/server-configs@autosnap_2026-03-29_09:00:02_hourly                           0B  Sun Mar 29  5:00 2026
music-tank@autosnap_2026-03-29_09:00:03_hourly                                          0B  Sun Mar 29  5:00 2026
media-tank@autosnap_2026-03-29_09:00:03_hourly                                        212M  Sun Mar 29  5:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_09:00:05_hourly                        0B  Sun Mar 29  5:00 2026
music-tank/audiobooks@autosnap_2026-03-29_09:00:05_hourly                               0B  Sun Mar 29  5:00 2026
media-tank/postgres@autosnap_2026-03-29_09:00:05_hourly                               101M  Sun Mar 29  5:00 2026
media-tank@autosnap_2026-03-29_10:00:18_hourly                                        226M  Sun Mar 29  6:00 2026
media-tank/postgres@autosnap_2026-03-29_10:00:00_hourly                               153M  Sun Mar 29  6:00 2026
music-tank@autosnap_2026-03-29_10:00:18_hourly                                          0B  Sun Mar 29  6:00 2026
music-tank/audiobooks@autosnap_2026-03-29_10:00:18_hourly                               0B  Sun Mar 29  6:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_10:00:19_hourly                        0B  Sun Mar 29  6:00 2026
media-tank/server-configs@autosnap_2026-03-29_10:00:19_hourly                           0B  Sun Mar 29  6:00 2026
media-tank/mysql@autosnap_2026-03-29_10:00:20_hourly                                    0B  Sun Mar 29  6:00 2026
music-tank@autosnap_2026-03-29_11:00:00_hourly                                          0B  Sun Mar 29  7:00 2026
media-tank/server-configs@autosnap_2026-03-29_11:00:00_hourly                           0B  Sun Mar 29  7:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_11:00:03_hourly                        0B  Sun Mar 29  7:00 2026
media-tank/mysql@autosnap_2026-03-29_11:00:03_hourly                                    0B  Sun Mar 29  7:00 2026
media-tank/postgres@autosnap_2026-03-29_11:00:04_hourly                               205M  Sun Mar 29  7:00 2026
media-tank@autosnap_2026-03-29_11:00:19_hourly                                        286M  Sun Mar 29  7:00 2026
music-tank/audiobooks@autosnap_2026-03-29_11:00:19_hourly                               0B  Sun Mar 29  7:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_12:00:00_hourly                        0B  Sun Mar 29  8:00 2026
music-tank@autosnap_2026-03-29_12:00:00_hourly                                          0B  Sun Mar 29  8:00 2026
media-tank/server-configs@autosnap_2026-03-29_12:00:00_hourly                           0B  Sun Mar 29  8:00 2026
media-tank@autosnap_2026-03-29_12:00:02_hourly                                        274M  Sun Mar 29  8:00 2026
media-tank/postgres@autosnap_2026-03-29_12:00:03_hourly                               154M  Sun Mar 29  8:00 2026
media-tank/mysql@autosnap_2026-03-29_12:00:17_hourly                                    0B  Sun Mar 29  8:00 2026
music-tank/audiobooks@autosnap_2026-03-29_12:00:17_hourly                               0B  Sun Mar 29  8:00 2026
media-tank@autosnap_2026-03-29_13:00:00_hourly                                        212M  Sun Mar 29  9:00 2026
backup-tank/ssd-cache-mirror@autosnap_2026-03-29_13:00:02_hourly                        0B  Sun Mar 29  9:00 2026
music-tank/audiobooks@autosnap_2026-03-29_13:00:02_hourly                               0B  Sun Mar 29  9:00 2026
media-tank/mysql@autosnap_2026-03-29_13:00:02_hourly                                    0B  Sun Mar 29  9:00 2026
media-tank/server-configs@autosnap_2026-03-29_13:00:04_hourly                           0B  Sun Mar 29  9:00 2026
media-tank/postgres@autosnap_2026-03-29_13:00:04_hourly                               113M  Sun Mar 29  9:00 2026
music-tank@autosnap_2026-03-29_13:00:18_hourly                                          0B  Sun Mar 29  9:00 2026
```

## 10. ZFS ARC & Performance
```text
--- ARC Statistics ---
    time  read  ddread  ddh%  dmread  dmh%  pread  ph%   size      c  avail
09:19:53     0       0     0       0     0      0    0  30.0G    32G  60.5G

--- ZPool I/O Stats ---
                              capacity     operations     bandwidth 
pool                        alloc   free   read  write   read  write
--------------------------  -----  -----  -----  -----  -----  -----
backup-tank                  827G  8.29T      2      1  46.2K   829K
  wwn-0x5000cca26af37d9e     827G  8.29T      2      1  46.2K   829K
--------------------------  -----  -----  -----  -----  -----  -----
media-tank                   945G  6.34T     30    160  3.05M  6.40M
  raidz1-0                   945G  6.34T     30    160  3.05M  6.40M
    wwn-0x5002538636205a7f      -      -      8     43   783K  1.60M
    wwn-0x50025386362056de      -      -      7     42   775K  1.59M
    wwn-0x5002538f7081ba98      -      -      7     36   791K  1.60M
    wwn-0x5002538e9970da57      -      -      7     37   773K  1.60M
--------------------------  -----  -----  -----  -----  -----  -----
music-tank                  44.4G  27.2T      0      0  31.2K  16.2K
  raidz1-0                  44.4G  27.2T      0      0  31.2K  16.2K
    wwn-0x5000cca273d16462      -      -      0      0  10.4K  5.38K
    wwn-0x5000cca273cbeb2a      -      -      0      0  10.1K  5.38K
    wwn-0x5000cca266deada3      -      -      0      0  10.6K  5.38K
--------------------------  -----  -----  -----  -----  -----  -----

--- ZPool Event Log (last 20) ---
TIME                           CLASS
No ZFS events or requires root.

--- Recent ZPool Admin History ---
  media-tank:
History for 'media-tank':
  Not available.
  music-tank:
History for 'music-tank':
  Not available.
  backup-tank:
History for 'backup-tank':
  Not available.
```

## 11. Network Interfaces & Routing
```text
--- Interfaces ---
lo               UNKNOWN        127.0.0.1/8 ::1/128 
enp2s0f0         UP             
enp2s0f1         UP             
bond0            UP             10.136.150.13/24 metric 100 fe80::14da:6aff:fea9:3c7c/64 
ztsjscgwc2       UNKNOWN        10.183.36.88/24 fe80::c09c:dbff:fe84:34a/64 
docker0          DOWN           172.17.0.1/16 
br-70d33ce9bb89  UP             172.18.0.1/16 fe80::9cd2:73ff:fe0f:63e9/64 
veth4c49c13@if2  UP             fe80::5cd5:81ff:fe84:f451/64 
veth84731df@if2  UP             fe80::709a:73ff:fec1:af0/64 
veth4d7f3d9@if2  UP             fe80::cc81:d1ff:fe30:5b77/64 
vethdf12542@if2  UP             fe80::2418:76ff:fefc:7d1a/64 
veth58763e5@if2  UP             fe80::d05a:f5ff:fe5f:825/64 
vethac787f2@if2  UP             fe80::2052:5ff:feb7:7f80/64 
veth7c6153f@if2  UP             fe80::94f1:14ff:fe9b:ca18/64 
vethdb6801d@if2  UP             fe80::a40c:7dff:fe2f:70a4/64 
veth51ba9f9@if2  UP             fe80::445b:4aff:fe58:25ed/64 
veth0bc37c9@if2  UP             fe80::dcd1:dff:fe8f:ebe5/64 
veth15f6ddf@if2  UP             fe80::9478:17ff:fe61:9c69/64 
vethf2c3bf8@if2  UP             fe80::8ca3:60ff:fe05:f24/64 
veth92dad79@if2  UP             fe80::441c:5dff:fe04:515/64 

--- Routes ---
default via 10.136.150.1 dev bond0 proto dhcp src 10.136.150.13 metric 100 
10.136.150.0/24 dev bond0 proto kernel scope link src 10.136.150.13 metric 100 
10.136.150.1 dev bond0 proto dhcp scope link src 10.136.150.13 metric 100 
10.183.36.0/24 dev ztsjscgwc2 proto kernel scope link src 10.183.36.88 
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown 
172.18.0.0/16 dev br-70d33ce9bb89 proto kernel scope link src 172.18.0.1 
```

## 12. Docker Status & Containers
```text
--- Docker Storage Usage ---
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          19        19        11.12GB   11.12GB (100%)
Containers      22        14        41.92MB   148.7kB (0%)
Local Volumes   22        4         2.17GB    35.68MB (1%)
Build Cache     0         0         0B        0B

--- Docker Engine Config (Verifying ZFS integration) ---
 Storage Driver: overlay2
  Backing Filesystem: zfs
 Docker Root Dir: /var/lib/docker

--- Running & Stopped Containers ---
NAMES          IMAGE                                       STATUS                        PORTS
seerr          ghcr.io/hotio/seerr:latest                  Exited (137) 11 minutes ago   
rclone         rclone/rclone:1.73.1                        Up 11 hours (healthy)         0.0.0.0:5572->5572/tcp, [::]:5572->5572/tcp
sonarr         ghcr.io/realzombee/sonarr:develop           Up 9 hours (healthy)          0.0.0.0:8989->8989/tcp, [::]:8989->8989/tcp
emby           lscr.io/linuxserver/emby:beta               Up 11 hours (unhealthy)       0.0.0.0:8096->8096/tcp, [::]:8096->8096/tcp, 8920/tcp
sonarr-anime   ghcr.io/realzombee/sonarr:develop           Exited (0) 11 hours ago       
radarr-anime   ghcr.io/realzombee/radarr:develop           Exited (0) 11 hours ago       
bookshelf      ghcr.io/pennydreadful/bookshelf:hardcover   Exited (0) 12 minutes ago     
radarr         ghcr.io/realzombee/radarr:develop           Up 9 hours (healthy)          0.0.0.0:7878->7878/tcp, [::]:7878->7878/tcp
lidarr         ghcr.io/hotio/lidarr:testing                Exited (0) 11 hours ago       
cinesync       sureshfizzy/cinesync:v3.2.2-alpha           Up 11 hours                   0.0.0.0:8082->8082/tcp, [::]:8082->8082/tcp
rclone-init    alpine:3.20                                 Exited (0) 11 hours ago       
nginx          jc21/nginx-proxy-manager:latest             Up 11 hours (healthy)         0.0.0.0:80->80/tcp, [::]:80->80/tcp, 0.0.0.0:443->443/tcp, [::]:443->443/tcp, 127.0.0.1:81->81/tcp
prowlarr       ghcr.io/hotio/prowlarr:testing              Up 11 hours (healthy)         0.0.0.0:9696->9696/tcp, [::]:9696->9696/tcp
jellystat      cyfershepard/jellystat:latest               Exited (137) 11 minutes ago   
scrutiny       ghcr.io/analogj/scrutiny:master-omnibus     Up 11 hours (healthy)         0.0.0.0:8081->8080/tcp, [::]:8081->8080/tcp
nzbdav         nzbdav/nzbdav:latest                        Up 11 hours (healthy)         0.0.0.0:3000->3000/tcp, [::]:3000->3000/tcp
db-ready       alpine:3.20                                 Exited (0) 11 hours ago       
nginx-db       jc21/mariadb-aria:latest                    Up 11 hours (healthy)         3306/tcp
pgbouncer      edoburu/pgbouncer:latest                    Up 11 hours (healthy)         127.0.0.1:6432->5432/tcp
netdata        netdata/netdata:stable                      Up 12 hours (healthy)         
webserver      nginx:alpine                                Up 12 hours (healthy)         0.0.0.0:7050->80/tcp, [::]:7050->80/tcp
postgres       pgvector/pgvector:pg17                      Up 12 hours (healthy)         5432/tcp

--- Container Resource Usage ---
NAME        CPU %     MEM USAGE / LIMIT     NET I/O           BLOCK I/O
rclone      9.56%     3.193GiB / 121.6GiB   183GB / 1.43GB    7.32MB / 172GB
sonarr      10.82%    309.2MiB / 121.6GiB   4.76GB / 442MB    1.42GB / 0B
emby        101.27%   3.707GiB / 32GiB      560MB / 9.1GB     1.04GB / 3.09GB
radarr      222.45%   1.818GiB / 121.6GiB   399GB / 4.07GB    743MB / 0B
cinesync    0.16%     2.388GiB / 121.6GiB   21.4MB / 2.69MB   1.27GB / 0B
nginx       0.18%     145.1MiB / 121.6GiB   9.09GB / 6.44GB   8.62MB / 0B
prowlarr    0.08%     169.7MiB / 121.6GiB   288MB / 177MB     18.2MB / 0B
scrutiny    0.28%     59.73MiB / 121.6GiB   485kB / 126B      11.5MB / 0B
nzbdav      591.17%   1.691GiB / 16GiB      1.03TB / 198GB    12.3GB / 16.4kB
nginx-db    0.00%     45.14MiB / 121.6GiB   492kB / 29.9kB    2.81MB / 0B
pgbouncer   6.77%     11.75MiB / 121.6GiB   392GB / 393GB     1.17MB / 0B
netdata     16.83%    394.5MiB / 121.6GiB   0B / 0B           110GB / 20.5kB
webserver   0.00%     21.48MiB / 121.6GiB   715kB / 436kB     41kB / 0B
postgres    23.52%    2.63GiB / 20GiB       3.22GB / 389GB    1.05GB / 45.1kB
```

## 13. Automated Backups & ZFS Snapshots
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
     Active: active (waiting) since Sun 2026-03-22 08:20:33 EDT; 1 week 0 days ago
 Invocation: b259d3e502a149bc8acae895fd4a1842
    Trigger: Sun 2026-03-29 09:30:00 EDT; 10min left
   Triggers: ● sanoid.service

Mar 22 08:20:33 media systemd[1]: Started sanoid.timer - Run Sanoid Every 15 Minutes.
```

### Recent Backup Log (last 30 lines)
```text
Syncoid log not found at /var/log/media-backup/syncoid.log
```

## 14. Database Pre-Snapshot Hooks
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

## 15. Scheduled Tasks
### Root Crontab
```bash
No crontab found or requires root.
```

## 16. Server Configuration Directory (/opt)
```text
total 340
drwxr-xr-x  6 media media   4096 Mar 29 09:19 .
drwxr-xr-x 20 root  root    4096 Mar 16 17:36 ..
-rw-rw-r--  1 media media   4546 Mar 28 21:44 .env
drwxrwxr-x  8 media media   4096 Feb 26 23:56 .git
-rw-rw-r--  1 media media      5 Feb 26 23:41 .gitignore
-rw-rw-r--  1 media media   1070 Feb 26 23:40 LICENSE
drwx--x--x  4 media media   4096 Jan 19 12:27 containerd
-rw-rw-r--  1 media media   1248 Mar 13 10:27 crontab.txt
-rwxrwxr-x  1 media media   1660 Mar 16 18:48 db-flush.sh
-rw-rw-r--  1 media media  24674 Mar 28 21:53 docker-compose.yml
-rw-rw-r--  1 media media  23657 Mar 16 08:53 docker-compose.yml.backup
-rw-rw-r--  1 media media  24543 Mar 21 18:24 docker-compose.yml.roger
-rwxrwxr-x  1 media media    348 Mar  3 08:03 docker.sh
-rw-rw-r--  1 media media   3580 Mar 28 20:57 env.backup
-rwxrwxr-x  1 media media   1778 Mar  3 08:06 full-backup.sh
-rwxrwxr-x  1 media media   7583 Mar 16 19:25 generate_report.sh
-rwxrwxr-x  1 media media  22163 Mar 17 09:52 manage-stack.sh
-rwxrwxr-x  1 media media   3025 Mar 16 10:16 push_git.sh
-rw-rw-r--  1 media media   4266 Mar 29 00:21 radarr.py
drwxr-xr-x  2 media media   4096 Mar 14 22:54 sanoid-backup
-rw-rw-r--  1 media media   5223 Mar 25 13:18 sonarr.py
-rwxrwxr-x  1 media media   1390 Mar 16 18:41 syncoid-run.sh
-rw-rw-r--  1 media media 139312 Mar 29 09:19 system_report_media_2026-03-29.md
drwxr-xr-x  5 media media   4096 Mar 14 22:54 zerotier-backup
-rwxrwxr-x  1 media media   7132 Mar 16 19:41 zfs-snapshot-cleanup.sh
```

## 17. Failed Systemd Services
```text
```

## 18. Recent Journal Errors
```text
Mar 17 09:03:45 media sshd-session[60768]: error: mm_reap: preauth child terminated by signal 15
Mar 17 09:03:45 media sshd-session[4675]: error: mm_reap: preauth child terminated by signal 15
-- Boot f0bb2d4170104e3aabaa794f77e7851b --
Mar 17 09:45:35 media kernel: mpt2sas_cm0: overriding NVDATA EEDPTagMode setting from 0 to 1
Mar 17 09:45:37 media kernel: 
Mar 17 09:45:45 media systemd[1]: Failed to start irq-affinity-sas.service - Pin LSI SAS2308 MSI-X IRQs to NUMA Node 0.
Mar 17 17:32:24 media systemd[1]: Failed to start irq-affinity-sas.service - Pin LSI SAS2308 MSI-X IRQs to NUMA Node 0.
Mar 17 17:33:48 media systemd[1]: Failed to start irq-affinity-sas.service - Pin LSI SAS2308 MSI-X IRQs to NUMA Node 0.
Mar 18 00:10:35 media systemd[1]: Failed to start logrotate.service - Rotate log files.
Mar 18 15:07:46 media kernel: I/O error, dev sdf, sector 754139872 op 0x0:(READ) flags 0x0 phys_seg 2 prio class 2
Mar 18 15:07:46 media kernel: I/O error, dev sdf, sector 2576 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
Mar 18 15:07:46 media kernel: I/O error, dev sdf, sector 4000779280 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
Mar 18 15:07:46 media kernel: I/O error, dev sdf, sector 4000779792 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
Mar 19 00:10:31 media systemd[1]: Failed to start logrotate.service - Rotate log files.
-- Boot 3939808a52584e1ea4fdceabe592bff4 --
Mar 19 08:38:48 media kernel: mpt2sas_cm0: overriding NVDATA EEDPTagMode setting from 0 to 1
Mar 19 08:38:49 media kernel: 
-- Boot 70b549905d0b4507814ebcacfae88177 --
Mar 22 08:20:24 media kernel: mpt2sas_cm0: overriding NVDATA EEDPTagMode setting from 0 to 1
Mar 22 08:20:25 media kernel: 
Mar 27 21:39:47 media kernel: INFO: task ffmpeg:2251699 blocked for more than 122 seconds.
Mar 27 21:39:47 media kernel:       Tainted: P           O        6.17.0-19-generic #19-Ubuntu
Mar 27 21:39:47 media kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
```

## 19. Recent Kernel Warnings/Errors
```text
No recent errors, or requires root/sudo to view dmesg.
```

