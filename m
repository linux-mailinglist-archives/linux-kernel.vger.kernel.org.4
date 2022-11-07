Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769E861E842
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiKGB0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiKGB0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:26:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7009964C8;
        Sun,  6 Nov 2022 17:26:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 958A860E7F;
        Mon,  7 Nov 2022 01:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B631C433C1;
        Mon,  7 Nov 2022 01:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667784363;
        bh=gXgdmqW2hJETMGbRpGENG26q/pCq1OyBIpSHyLz+95s=;
        h=Date:From:To:Subject:From;
        b=FX1F1IsCCHbmxRelAwbl+TrkP/b9ynblEag4Eoyf42HcxohPJb8gu6aWB59Pe7DUS
         xUuTDzSPqZ0BHYZ2hC1q6094TPIDQanVcfAEHpbGs98WPWuT3awwbBpAasWB57ZAoo
         iOKOoSd4kX3AB+pH1aWuT+yqdJJYFn1W7OvXr3tuaTNfNJDoUEcd9AfWgcrZaLAMZ7
         dbnc8Hq0bnbkSe2XV8oPPpEBEC2PtbAlxlJfx7uS7vjokJmFjTZpysv1Uu0P60SduV
         3AF6sEJWH9OYrBwc1DQp39y1NcHSr9nkbu3wEWY1kr1TqWI/+VxPoSt4uftu18zWP2
         gWvJiDLj9Us/A==
Date:   Sun, 6 Nov 2022 17:26:01 -0800
From:   Mark Gross <markgross@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Danie l Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.9.327-rt197
Message-ID: <166778430472.25456.2119007061331575558@T470>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.327-rt197 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt-rebase
  Head SHA1: 526140e6fc728cfdda65e2c4ef6dd085eb5e3aec

Or to build 4.9.327-rt197 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.327.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.327-rt197.patch.xz

Signing key fingerprint:

  A073 BC64 746A 086C DA24  97C8 F92D 73C9 A31A 1C17

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Mark Gross

Changes from v4.9.319-rt195:
---

Adam Ford (1):
      ASoC: wm8962: Fix suspend while playing music

Al Viro (7):
      9p: missing chunk of "fs/9p: Don't update file type when updating file attributes"
      nios2: page fault et.al. are *not* restartable syscalls...
      nios2: don't leave NULLs in sys_call_table[]
      nios2: traced syscall does need to check the syscall number
      nios2: fix syscall restart checks
      nios2: restarts apply only to the first sigframe we build...
      nios2: add force_successful_syscall_return()

Alexander Lobakin (2):
      ia64, processor: fix -Wincompatible-pointer-types in ia64_get_irr()
      x86/olpc: fix 'logical not is only applied to the left hand side'

Allen Ballway (1):
      ALSA: hda/cirrus - support for iMac 12,1 model

Amadeusz Sławiński (1):
      ALSA: info: Fix llseek return value when using callback

Andi Kleen (1):
      random: optimize add_interrupt_randomness

Andreas Gruenbacher (4):
      selinux: Minor cleanups
      proc: Pass file mode to proc_pid_make_inode
      selinux: Clean up initialization of isec->sclass
      selinux: Convert isec->lock into a spinlock

Andy Lutomirski (8):
      random: Don't wake crng_init_wait when crng_init == 1
      random: Add a urandom_read_nowait() for random APIs that don't warn
      random: add GRND_INSECURE to return best-effort non-cryptographic bytes
      random: ignore GRND_RANDOM in getentropy(2)
      random: make /dev/random be almost like /dev/urandom
      random: remove the blocking pool
      random: delete code to pull data into pools
      random: remove kernel.random.read_wakeup_threshold

Andy Shevchenko (1):
      crypto: Deduplicate le32_to_cpu_array() and cpu_to_le32_array()

Ard Biesheuvel (2):
      random: avoid arch_get_random_seed_long() when collecting IRQ randomness
      ARM: 9209/1: Spectre-BHB: avoid pr_info() every time a CPU comes out of idle

Baokun Li (4):
      ext4: fix bug_on ext4_mb_use_inode_pa
      ext4: add EXT4_INODE_HAS_XATTR_SPACE macro in xattr.h
      ext4: fix use-after-free in ext4_xattr_set_entry
      ext4: correct max_inline_xattr_value_size computing

Baruch Siach (1):
      iio: adc: vf610: fix conversion mode sysfs node name

Bernard Pidoux (1):
      rose: check NULL rose_loopback_neigh->loopback

Borislav Petkov (1):
      char/random: Add a newline at the end of the file

Carlo Lobrano (2):
      USB: serial: option: add Telit LE910Cx 0x1250 composition
      net: usb: qmi_wwan: add Telit 0x1060 composition

Chanho Park (1):
      tty: serial: samsung_tty: set dma burst_size to 1

Charles Keepax (5):
      ASoC: cs42l52: Fix TLV scales for mixer controls
      ASoC: cs53l30: Correct number of volume levels on SX controls
      ASoC: cs42l52: Correct TLV for Bypass Volume
      ASoC: cs42l56: Correct typo in minimum level for SX volume controls
      ASoC: wm5110: Fix DRE control

Chen Lin (1):
      net: ethernet: mtk_eth_soc: fix misuse of mem alloc interface netdev[napi]_alloc_frag

ChenXiaoSong (1):
      ntfs: fix use-after-free in ntfs_ucsncmp()

Christian Borntraeger (2):
      s390/mm: use non-quiescing sske for KVM switch to keyed guest
      include/uapi/linux/swab.h: fix userspace breakage, use __BITS_PER_LONG for swap

Christoph Hellwig (1):
      drm: remove drm_fb_helper_modinit

Christophe JAILLET (1):
      cxl: Fix a memory leak in an error handling path

Chuck Lever (1):
      SUNRPC: Fix READ_PLUS crasher

Colin Ian King (1):
      xprtrdma: fix incorrect header size calculations

Corentin LABBE (5):
      hwrng: core - do not use multiple blank lines
      hwrng: core - rewrite better comparison to NULL
      hwrng: core - Rewrite the header
      hwrng: core - Move hwrng miscdev minor number to include/linux/miscdevice.h
      hwrng: core - remove unused PFX macro

Csókás Bence (1):
      fec: Fix timer capture timing in `fec_ptp_enable_pps()`

Damien Le Moal (1):
      ata: libata-eh: Add missing command name

Dan Carpenter (1):
      xen/xenbus: fix return type in xenbus_file_read()

Daniel Borkmann (1):
      bpf: fix overflow in prog accounting

Daniel Micay (1):
      init/main.c: extract early boot entropy from the passed cmdline

Daniele Palmas (3):
      net: usb: qmi_wwan: add Telit 0x1260 and 0x1261 compositions
      net: usb: qmi_wwan: add Telit LE910Cx 0x1230 composition
      net: usb: qmi_wwan: add Telit 0x1070 composition

David Collins (1):
      spmi: trace: fix stack-out-of-bound access in SPMI tracing functions

David Hildenbrand (1):
      mm/hugetlb: fix hugetlb not supporting softdirty tracking

David Howells (1):
      vfs: Check the truncate maximum size in inode_newsize_ok()

Demi Marie Obenour (2):
      xen/gntdev: Avoid blocking in unmap_grant_pages()
      xen/gntdev: Ignore failure to unmap INVALID_GRANT_HANDLE

Ding Xiang (1):
      ext4: make variable "count" signed

Dmitry Osipenko (1):
      ARM: 9213/1: Print message about disabled Spectre workarounds only once

Dmitry Rokosov (1):
      iio:accel:bma180: rearrange iio trigger get and register

Dominik Brodowski (7):
      random: fix crash on multiple early calls to add_bootloader_randomness()
      random: harmonize "crng init done" messages
      random: early initialization of ChaCha constants
      random: continually use hwgenerator randomness
      random: access primary_pool directly rather than through pointer
      random: only call crng_finalize_init() for primary_crng
      random: fix locking in crng_fast_load()

Dongliang Mu (1):
      media: pvrusb2: fix memory leak in pvr_probe

Doug Berger (1):
      net: dsa: bcm_sf2: force pause link settings

Duoming Zhou (3):
      net: rose: fix UAF bugs caused by timer handler
      net: rose: fix UAF bug caused by rose_t0timer_expiry
      atm: idt77252: fix use-after-free bugs caused by tst_timer

Edward Wu (1):
      ata: libata: add qc->flags in ata_qc_complete_template tracepoint

Eric Biggers (8):
      random: fix data race on crng_node_pool
      crypto: chacha20 - Fix keystream alignment for chacha20_block()
      random: remove dead code left over from blocking pool
      crypto: blake2s - include <linux/bug.h> instead of <asm/bug.h>
      crypto: blake2s - adjust include guard naming
      random: initialize ChaCha20 constants with correct endianness
      crypto: chacha20 - Fix chacha20_block() keystream alignment (again)
      random: remove use_input_pool parameter from crng_reseed()

Eric Dumazet (5):
      tcp: change source port randomizarion at connect() time
      tcp: add some entropy in __inet_hash_connect()
      net: bonding: fix possible NULL deref in rlb code
      bpf: Make sure mac_header was set before using it
      tcp: fix over estimation in sk_forced_mem_schedule()

Eric Sandeen (1):
      xfs: remove incorrect ASSERT in xfs_rename

Eric Whitney (1):
      ext4: fix extent status tree race in writeback error recovery path

Fabio Estevam (1):
      random: move random_min_urandom_seed into CONFIG_SYSCTL ifdef block

Filipe Manana (1):
      btrfs: fix lost error handling when looking up extended ref on log replay

Florian Westphal (2):
      netfilter: nf_queue: do not allow packet truncation below transport header offset
      netfilter: nf_tables: fix null deref due to zeroed list head

Gayatri Kammela (1):
      x86/cpu: Add Tiger Lake to Intel family

Geert Uytterhoeven (1):
      netfilter: conntrack: NF_CONNTRACK_PROCFS should no longer default to y

George Spelvin (1):
      random: document get_random_int() family

Gerald Schaefer (1):
      s390/mm: do not trigger write fault when vma does not allow VM_WRITE

Goldwyn Rodrigues (1):
      btrfs: check if root is readonly while setting security xattr

Greg Kroah-Hartman (10):
      Revert "char/random: silence a lockdep splat with printk()"
      Linux 4.9.320
      Linux 4.9.321
      Linux 4.9.322
      Linux 4.9.323
      Linux 4.9.324
      Linux 4.9.325
      ARM: crypto: comment out gcc warning that breaks clang builds
      Linux 4.9.326
      Linux 4.9.327

Guenter Roeck (1):
      nios2: time: Read timer in get_cycles only if initialized

Haibo Chen (1):
      iio: accel: mma8452: ignore the return value of reset operation

Halil Pasic (1):
      swiotlb: fix info leak with DMA_FROM_DEVICE

Hangyu Hua (2):
      net: tipc: fix possible refcount leak in tipc_sk_create()
      xfrm: xfrm_policy: fix a possible double xfrm_pols_put() in xfrm_bundle_lookup()

Hans-Christian Noren Egtvedt (1):
      random: only call boot_init_stack_canary() once

Harald Freudenberger (2):
      hwrng: use rng source with best quality
      hwrng: remember rng chosen by user

Helge Deller (3):
      random: fix warning message on ia64 and parisc
      parisc: Fix device names in /proc/iomem
      parisc: Fix exception handler for fldw and fstw instructions

Herbert Xu (2):
      Revert "hwrng: core - Freeze khwrng thread during suspend"
      af_key: Do not call xfrm_probe_algs in parallel

Hristo Venev (1):
      be2net: Fix buffer overflow in be_get_module_eeprom

Hsin-Yi Wang (4):
      fdt: add support for rng-seed
      fdt: Update CRC check for rng-seed
      video: of_display_timing.h: include errno.h
      arm64: map FDT as RW for early_init_dt_scan()

Huacai Chen (1):
      MIPS: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Ian Abbott (1):
      comedi: vmk80xx: fix expression for tx buffer size

Ilpo Järvinen (1):
      serial: 8250: Store to lsr_save_flags after lsr read

Ilya Lesokhin (1):
      net: Rename and export copy_skb_header

Ingo Molnar (1):
      random: remove preempt disabled region

Jacob Keller (1):
      ixgbe: stop resetting SYSTIME in ixgbe_ptp_start_cyclecounter

Jamal Hadi Salim (1):
      net_sched: cls_route: disallow handle of 0

James Chapman (2):
      l2tp: don't use inet_shutdown on ppp session destroy
      l2tp: fix race in pppol2tp_release with session object destroy

James Morse (1):
      arm64: entry: Restore tramp_map_kernel ISB

James Smart (1):
      scsi: lpfc: Fix port stuck in bypassed state after LIP in PT2PT topology

Jan Varho (1):
      random: do not split fast init input in add_hwgenerator_randomness()

Jann Horn (5):
      random: don't reset crng_init_cnt on urandom_read()
      random: check for signal_pending() outside of need_resched() check
      mm/slub: add missing TID updates on slab deactivation
      mm: Force TLB flush for PFNMAP mappings before unlink_file_vma()
      mm/rmap: Fix anon_vma->degree ambiguity leading to double-reuse

Jason A. Donenfeld (129):
      random: convert get_random_int/long into get_random_u32/u64
      random: invalidate batched entropy after crng init
      random: silence compiler warnings and fix race
      random: add wait_for_random_bytes() API
      random: add get_random_{bytes,u32,u64,int,long,once}_wait family
      random: warn when kernel uses unseeded randomness
      random: always use batched entropy for get_random_u{32,64}
      random: always fill buffer in get_random_bytes_wait
      random: Make crng state queryable
      crypto: blake2s - generic C library implementation and selftest
      lib/crypto: blake2s: move hmac construction into wireguard
      lib/crypto: sha1: re-roll loops to reduce code size
      MAINTAINERS: co-maintain random.c
      random: use BLAKE2s instead of SHA1 in extraction
      random: do not sign extend bytes for rotation when mixing
      random: do not re-init if crng_reseed completes before primary init
      random: mix bootloader randomness into pool
      random: use IS_ENABLED(CONFIG_NUMA) instead of ifdefs
      random: avoid superfluous call to RDRAND in CRNG extraction
      random: cleanup poolinfo abstraction
      random: cleanup integer types
      random: remove incomplete last_data logic
      random: remove unused extract_entropy() reserved argument
      random: rather than entropy_store abstraction, use global
      random: remove unused OUTPUT_POOL constants
      random: de-duplicate INPUT_POOL constants
      random: prepend remaining pool constants with POOL_
      random: cleanup fractional entropy shift constants
      random: access input_pool_data directly rather than through pointer
      random: simplify arithmetic function flow in account()
      random: use computational hash for entropy extraction
      random: simplify entropy debiting
      random: use linear min-entropy accumulation crediting
      random: always wake up entropy writers after extraction
      random: make credit_entropy_bits() always safe
      random: remove batched entropy locking
      random: use RDSEED instead of RDRAND in entropy extraction
      random: inline leaves of rand_initialize()
      random: ensure early RDSEED goes through mixer on init
      random: do not xor RDRAND when writing into /dev/random
      random: absorb fast pool into input pool after fast load
      random: use hash function for crng_slow_load()
      random: remove outdated INT_MAX >> 6 check in urandom_read()
      random: zero buffer after reading entropy from userspace
      random: tie batched entropy generation to base_crng generation
      random: remove ifdef'd out interrupt bench
      random: remove unused tracepoints
      random: add proper SPDX header
      random: deobfuscate irq u32/u64 contributions
      random: introduce drain_entropy() helper to declutter crng_reseed()
      random: remove useless header comment
      random: remove whitespace and reorder includes
      random: group initialization wait functions
      random: group entropy extraction functions
      random: group entropy collection functions
      random: group userspace read/write functions
      random: group sysctl functions
      random: rewrite header introductory comment
      random: defer fast pool mixing to worker
      random: do not take pool spinlock at boot
      random: unify early init crng load accounting
      random: check for crng_init == 0 in add_device_randomness()
      random: pull add_hwgenerator_randomness() declaration into random.h
      random: clear fast pool, crng, and batches in cpuhp bring up
      random: round-robin registers as ulong, not u32
      random: only wake up writers after zap if threshold was passed
      random: cleanup UUID handling
      random: unify cycles_t and jiffies usage and types
      random: do crng pre-init loading in worker rather than irq
      random: give sysctl_random_min_urandom_seed a more sensible value
      random: don't let 644 read-only sysctls be written to
      random: replace custom notifier chain with standard one
      random: use SipHash as interrupt entropy accumulator
      random: make consistent usage of crng_ready()
      random: reseed more often immediately after booting
      random: check for signal and try earlier when generating entropy
      random: skip fast_init if hwrng provides large chunk of entropy
      random: treat bootloader trust toggle the same way as cpu trust toggle
      random: re-add removed comment about get_random_{u32,u64} reseeding
      random: mix build-time latent entropy into pool at init
      random: do not allow user to keep crng key around on stack
      random: check for signals every PAGE_SIZE chunk of /dev/[u]random
      random: make random_get_entropy() return an unsigned long
      random: document crng_fast_key_erasure() destination possibility
      random: fix sysctl documentation nits
      init: call time_init() before rand_initialize()
      ia64: define get_cycles macro for arch-override
      s390: define get_cycles macro for arch-override
      parisc: define get_cycles macro for arch-override
      alpha: define get_cycles macro for arch-override
      powerpc: define get_cycles macro for arch-override
      timekeeping: Add raw clock fallback for random_get_entropy()
      m68k: use fallback for random_get_entropy() instead of zero
      mips: use fallback for random_get_entropy() instead of just c0 random
      arm: use fallback for random_get_entropy() instead of zero
      nios2: use fallback for random_get_entropy() instead of zero
      x86/tsc: Use fallback for random_get_entropy() instead of zero
      um: use fallback for random_get_entropy() instead of zero
      sparc: use fallback for random_get_entropy() instead of zero
      xtensa: use fallback for random_get_entropy() instead of zero
      random: insist on random_get_entropy() existing in order to simplify
      random: do not use batches when !crng_ready()
      random: do not pretend to handle premature next security model
      random: order timer entropy functions below interrupt functions
      random: do not use input pool from hard IRQs
      random: help compiler out with fast_mix() by using simpler arguments
      siphash: use one source of truth for siphash permutations
      random: use symbolic constants for crng_init states
      random: avoid initializing twice in credit race
      random: remove ratelimiting for in-kernel unseeded randomness
      random: use proper jiffies comparison macro
      random: handle latent entropy and command line from random_init()
      random: credit architectural init the exact amount
      random: use static branch for crng_ready()
      random: remove extern from functions in header
      random: use proper return types on get_random_{int,long}_wait()
      random: move initialization functions out of hot pages
      random: move randomize_page() into mm where it belongs
      random: check for signals after page of pool writes
      Revert "random: use static branch for crng_ready()"
      random: avoid checking crng_ready() twice in random_init()
      random: mark bootloader randomness code as __init
      random: account for arch randomness in bits
      random: credit cpu and bootloader seeds by default
      random: schedule mix_interrupt_randomness() less often
      random: quiet urandom warning ratelimit suppression message
      powerpc/pseries: wire up rng during setup_arch()
      powerpc/powernv: wire up rng during setup_arch
      Revert "Revert "char/random: silence a lockdep splat with printk()""

Jason Wang (1):
      caif_virtio: fix race between virtio_device_ready() and ndo_open()

Jay Vosburgh (1):
      bonding: ARP monitor spams NETDEV_NOTIFY_PEERS notifiers

Jens Axboe (2):
      random: convert to using fops->write_iter()
      random: wire up fops->splice_{read,write}_iter()

Jing Leng (1):
      kbuild: Fix include path in scripts/Makefile.modpost

Jiri Slaby (6):
      vt: drop old FONT ioctls
      tty: drivers/tty/, stop using tty_schedule_flip()
      tty: the rest, stop using tty_schedule_flip()
      tty: drop tty_schedule_flip()
      tty: extract tty_flip_buffer_commit() from tty_flip_buffer_push()
      tty: use new tty_insert_flip_string_and_push_buffer() in pty_write()

Jonathan Toppins (1):
      bonding: 802.3ad: fix no transmission of LACPDUs

Jose Alonso (3):
      net: usb: ax88179_178a: Fix packet receiving
      net: usb: ax88179_178a needs FLAG_SEND_ZLP
      Revert "net: usb: ax88179_178a needs FLAG_SEND_ZLP"

Jozef Martiniak (1):
      gadgetfs: ep_io - wait until IRQ finishes

Juergen Gross (3):
      xen/netback: avoid entering xenvif_rx_next_skb() with an empty rx queue
      x86: Clear .brk area at early boot
      s390/hypfs: avoid error message under KVM

Julien Grall (1):
      x86/xen: Remove undefined behavior in setup_features()

Jörgen Storvist (1):
      qmi_wwan: Added support for Telit LN940 series

Kai-Heng Feng (1):
      igb: Make DMA faster when CPU is active on the PCIe link

Karthik Alapati (1):
      HID: hidraw: fix memory leak in hidraw_release()

Kees Cook (3):
      random: do not ignore early device randomness
      random: make CPU trust a boot parameter
      random: move rand_initialize() earlier

Kiselev, Oleg (1):
      ext4: avoid resizing to a partial cluster size

Krzysztof Kozlowski (1):
      nfc: nfcmrvl: Fix irq_of_parse_and_map() return value

Kuniyuki Iwashima (16):
      cipso: Fix data-races around sysctl.
      icmp: Fix data-races around sysctl.
      ipv4: Fix data-races around sysctl_ip_dynaddr.
      ip: Fix a data-race around sysctl_fwmark_reflect.
      tcp/dccp: Fix a data-race around sysctl_tcp_fwmark_accept.
      tcp: Fix a data-race around sysctl_tcp_probe_threshold.
      igmp: Fix data-races around sysctl_igmp_llm_reports.
      igmp: Fix a data-race around sysctl_igmp_max_memberships.
      tcp: Fix a data-race around sysctl_tcp_notsent_lowat.
      net: ping6: Fix memleak in ipv6_renew_options().
      ratelimit: Fix data-races in ___ratelimit().
      net: Fix a data-race around sysctl_tstamp_allow_data.
      net: Fix a data-race around sysctl_net_busy_poll.
      net: Fix a data-race around sysctl_net_busy_read.
      net: Fix a data-race around sysctl_somaxconn.
      kprobes: don't call disarm_kprobe() for disabled kprobes

Laura Abbott (1):
      init: move stack canary initialization after setup_arch

Letu Ren (1):
      fbdev: fb_pm2fb: Avoid potential divide by zero error

Liang He (9):
      xtensa: xtfpga: Fix refcount leak bug in setup
      xtensa: Fix refcount leak bug in time.c
      can: grcan: grcan_probe(): remove extra of_node_get()
      cpufreq: pmac32-cpufreq: Fix refcount leak bug
      scsi: ufs: host: Hold reference returned by of_parse_phandle()
      net: sungem_phy: Add of_node_put() for reference returned by of_get_parent()
      usb: host: ohci-ppc-of: Fix refcount leak bug
      tty: serial: Fix refcount leak bug in ucc_uart.c
      mips: cavium-octeon: Fix missing of_node_put() in octeon2_usb_clocks_start

Linus Torvalds (4):
      random: try to actively add entropy rather than passively wait for it
      Reinstate some of "swiotlb: rework "fix info leak with DMA_FROM_DEVICE""
      ida: don't use BUG_ON() for debugging
      signal handling: don't use BUG_ON() for debugging

Liu Shixin (1):
      swiotlb: skip swiotlb_bounce when orig_addr is zero

Lucas Stach (1):
      ARM: dts: imx6qdl: correct PU regulator ramp delay

Lucien Buchmann (1):
      USB: serial: ftdi_sio: add Belimo device ids

Luiz Augusto von Dentz (3):
      Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put
      Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
      Bluetooth: L2CAP: Fix build errors in some archs

Lukas Czerner (1):
      ext4: make sure ext4_append() always allocates new block

Lukas Wunner (1):
      usbnet: Fix linkwatch use-after-free on disconnect

Maciej S. Szmigiero (1):
      KVM: SVM: Don't BUG if userspace injects an interrupt with GIF=0

Marc Kleine-Budde (2):
      can: m_can: m_can_tx_handler(): fix use after free of skb
      can: ems_usb: fix clang's -Wunaligned-access warning

Mark Brown (2):
      random: document add_hwgenerator_randomness() with other input functions
      ASoC: ops: Fix off by one in range control validation

Mark Gross (3):
      Merge tag 'v4.9.327' into v4.9-rt
      Linux 4.9.327
      Linux 4.9.327-rt197

Mark Rutland (3):
      random: split primary/secondary crng init paths
      random: avoid warnings for !CONFIG_NUMA builds
      random: add arch_get_random_*long_early()

Masahiro Yamada (2):
      modpost: fix section mismatch check for exported init/exit sections
      xen: unexport __init-annotated xen_xlate_map_ballooned_pages()

Meng Tang (2):
      ALSA: hda - Add fixup for Dell Latitidue E5430
      ALSA: hda/conexant: Add quirk for LENOVO 20149 Notebook model

Miaoqian Lin (10):
      misc: atmel-ssc: Fix IRQ check in ssc_probe
      irqchip/gic/realview: Fix refcount leak in realview_gic_of_init
      usb: gadget: lpc32xx_udc: Fix refcount leak in lpc32xx_udc_probe
      ARM: exynos: Fix refcount leak in exynos_map_pmu
      ARM: Fix refcount leak in axxia_boot_secondary
      ARM: cns3xxx: Fix refcount leak in cns3xxx_init
      dmaengine: ti: Fix refcount leak in ti_dra7_xbar_route_allocate
      dmaengine: ti: Add missing put_device in ti_dra7_xbar_route_allocate
      power/reset: arm-versatile: Fix refcount leak in versatile_reboot_probe
      pinctrl: nomadik: Fix refcount leak in nmk_pinctrl_dt_subnode_to_map

Michael Ellerman (1):
      powerpc/powernv: Avoid crashing if rng is NULL

Michael Walle (3):
      NFC: nxp-nci: Don't issue a zero length i2c_master_read()
      dmaengine: at_xdma: handle errors of at_xdmac_alloc_desc() correctly
      NFC: nxp-nci: don't print header length mismatch on i2c error

Miklos Szeredi (2):
      fuse: fix pipe buffer lifetime for direct_io
      fuse: limit nsec

Mikulas Patocka (5):
      dm raid: fix KASAN warning in raid5_add_disks
      add barriers to buffer_uptodate and set_buffer_uptodate
      md-raid10: fix KASAN warning
      dm raid: fix address sanitizer warning in raid_status
      rds: add missing barrier to release_refill

Nathan Chancellor (2):
      ion: Make user_ion_handle_put_nolock() a void function
      MIPS: tlbex: Explicitly compare _PAGE_NO_EXEC against 0

Naveen N. Rao (2):
      powerpc: Enable execve syscall exit tracepoint
      kexec_file: drop weak attribute from arch_kexec_apply_relocations[_add]

Nicolai Stange (4):
      crypto: drbg - prepare for more fine-grained tracking of seeding state
      crypto: drbg - track whether DRBG was seeded with !rng_is_initialized()
      crypto: drbg - move dynamic ->reseed_threshold adjustments to __drbg_seed()
      crypto: drbg - make reseeding from get_random_bytes() synchronous

Nikita Travkin (1):
      pinctrl: qcom: msm8916: Allow CAMSS GP clocks to be muxed

Nikos Tsironis (1):
      dm era: commit metadata in postsuspend after worker stops

Ning Qiang (1):
      macintosh/adb: fix oob read in do_adb_query() function

Oleksandr Tyshchenko (1):
      xen/arm: Fix race in RB-tree based P2M accounting

Oliver Neukum (3):
      usbnet: make sure no NULL pointer is passed through
      usbnet: fix memory allocation in helpers
      usbnet: fix memory leak in error case

Pablo Neira Ayuso (3):
      netfilter: nft_dynset: restore set element counter when failing to update
      netfilter: nf_tables: really skip inactive sets when allocating name
      netfilter: nft_payload: report ERANGE for too long offset and length

Pali Rohár (2):
      PCI: Add defines for normal and subtractive PCI bridges
      powerpc/fsl-pci: Fix Class Code of PCIe Root Port

Paul Moore (1):
      selinux: fix inode_doinit_with_dentry() LABEL_INVALID error handling

Pawan Gupta (1):
      x86/bugs: Add "unknown" reporting for MMIO Stale Data

Peilin Ye (1):
      vsock: Fix memory leak in vsock_connect()

Peter Zijlstra (1):
      perf/core: Fix data race between perf_event_set_output() and perf_mmap_close()

Qu Wenruo (1):
      btrfs: reject log replay if there is unsupported RO compat flag

Quanyang Wang (1):
      asm-generic: sections: refactor memory_intersects

Rasmus Villemoes (4):
      drivers/char/random.c: remove unused dont_count_entropy
      drivers/char/random.c: constify poolinfo_table
      drivers/char/random.c: remove unused stuct poolinfo::poolbits
      drivers/char/random.c: make primary_crng static

Rhett Aultman (1):
      can: gs_usb: gs_usb_open/close(): fix memory leak

Richard Henderson (6):
      x86: Remove arch_has_random, arch_has_random_seed
      powerpc: Remove arch_has_random, arch_has_random_seed
      linux/random.h: Remove arch_has_random, arch_has_random_seed
      linux/random.h: Use false with bool
      linux/random.h: Mark CONFIG_ARCH_RANDOM functions __must_check
      powerpc: Use bool in archrandom.h

Rik van Riel (1):
      mm: invalidate hwpoison page cache page in fault path

Robert Eckelmann (1):
      USB: serial: io_ti: add Agilent E5805A support

Robert Hancock (1):
      i2c: cadence: Change large transfer count reset logic to be unconditional

Roger Pau Monne (4):
      xen/blkfront: fix leaking data in shared pages
      xen/netfront: fix leaking data in shared pages
      xen/netfront: force data bouncing when backend is untrusted
      xen/blkfront: force data bouncing when backend is untrusted

Ryusuke Konishi (1):
      nilfs2: fix incorrect masking of permission flags for symlinks

Sai Prakash Ranjan (1):
      irqchip/tegra: Fix overflow implicit truncation warnings

Samuel Holland (1):
      pinctrl: sunxi: a83t: Fix NAND function name for some pins

Satish Nagireddy (1):
      i2c: cadence: Unregister the clk notifier in error path

Schspa Shi (2):
      random: fix typo in comments
      vfio: Clear the caps->buf to NULL after free

Sean Christopherson (1):
      KVM: x86: Mark TSS busy during LTR emulation _after_ all fault checks

Sebastian Andrzej Siewior (11):
      random: reorder READ_ONCE() in get_random_uXX
      random: add a spinlock_t to struct batched_entropy
      random: remove unused irq_flags argument from add_interrupt_randomness()
      Revert "workqueue: Use local irq lock instead of irq disable regions"
      Revert "workqueue: Prevent deadlock/stall on RT"
      timers: Keep interrupts disabled for TIMER_IRQSAFE timer.
      timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers
      rcu: Intrdroduce rcuwait.
      workqueue: Use rcuwait for wq_manager_wait
      workqueue: Convert the pool::lock and wq_mayday_lock to raw_spinlock_t
      local_lock: Provide INIT_LOCAL_LOCK().

Sergey Senozhatsky (1):
      char/random: silence a lockdep splat with printk()

Sergey Shtylyov (1):
      ata: libata-core: fix NULL pointer deref in ata_host_alloc_pinfo()

Shuah Khan (3):
      misc: rtsx_usb: fix use of dma mapped buffer for usb bulk transfer
      misc: rtsx_usb: use separate command and response buffers
      misc: rtsx_usb: set return value in rsp_buf alloc err path

Siddh Raman Pant (1):
      loop: Check for overflow while configuring loop

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV31 with new baseline

Steffen Maier (1):
      scsi: zfcp: Fix missing auto port scan and thus missing target ports

Stephan Gerhold (2):
      virtio_mmio: Add missing PM calls to freeze/restore
      virtio_mmio: Restore guest page size on resume

Stephan Mueller (2):
      random: remove stale maybe_reseed_primary_crng
      crypto: drbg - add FIPS 140-2 CTRNG for noise source

Stephan Müller (5):
      random: remove stale urandom_init_wait
      random: remove variable limit
      random: fix comment for unused random_min_urandom_seed
      crypto: drbg - always seeded with SP800-90B compliant noise source
      crypto: drbg - always try to free Jitter RNG instance

Stephen Boyd (2):
      random: Support freezable kthreads in add_hwgenerator_randomness()
      random: Use wait_event_freezable() in add_hwgenerator_randomness()

Stephen Smalley (1):
      security,selinux,smack: kill security_task_wait hook

Steven Rostedt (Google) (1):
      net: sock: tracing: Fix sock_exceed_buf_limit not to dereference stale pointer

Takashi Iwai (3):
      ALSA: memalloc: Align buffer allocations in page size
      ALSA: core: Add async signal helpers
      ALSA: timer: Use deferred fasync helper

Tejun Heo (1):
      workqueue: make workqueue available early during boot

Thadeu Lima de Souza Cascardo (1):
      net_sched: cls_route: remove from list when handle is 0

Theodore Ts'o (9):
      random: suppress spammy warnings about unseeded randomness
      random: use a different mixing algorithm for add_device_randomness()
      random: set up the NUMA crng instances after the CRNG is fully initialized
      random: fix possible sleeping allocation from irq context
      random: rate limit unseeded randomness warnings
      random: add a config option to trust the CPU's hwrng
      random: only read from /dev/random after its pool has received 128 bits
      random: fix soft lockup when trying to read from an uninitialized blocking pool
      ext4: update s_overhead_clusters in the superblock during an on-line resize

Thinh Nguyen (1):
      usb: dwc3: gadget: Fix event pending check

Tianyue Ren (1):
      selinux: fix error initialization in inode_doinit_with_dentry()

Timur Tabi (1):
      drm/nouveau: fix another off-by-one in nvbios_addr

Tobin C. Harding (2):
      random: Fix whitespace pre random-bytes work
      random: Return nbytes filled from hw RNG

Tony Battersby (1):
      scsi: sg: Allow waiting for commands to complete on removed device

Trond Myklebust (2):
      pNFS: Don't keep retrying if the server replied NFS4ERR_LAYOUTUNAVAILABLE
      SUNRPC: Reinitialise the backchannel request buffers before reuse

Tyler Hicks (1):
      net/9p: Initialize the iounit field during fid creation

Vasily Gorbik (1):
      latent_entropy: avoid build error when plugin cflags are not set

Vincent Whitchurch (1):
      iio: trigger: sysfs: fix use-after-free on remove

Viresh Kumar (2):
      init/main: Fix double "the" in comment
      init/main: properly align the multi-line comment

Wang Cheng (1):
      mm/mempolicy: fix uninit-value in mpol_rebind_policy()

Wang Yufen (1):
      ipv6: Fix signed integer overflow in l2tp_ip6_sendmsg

Wei Mingzhi (1):
      mt7601u: add USB device ID for some versions of XiaoDu WiFi Dongle.

Weitao Wang (1):
      USB: HCD: Fix URB giveback issue in tasklet function

Wentao Wang (1):
      scsi: vmw_pvscsi: Expand vcpuHint to 16 bits

Wentao_Liang (1):
      drivers:md:fix a potential use-after-free bug

Werner Sembach (2):
      ACPI: video: Force backlight native for some TongFang devices
      ACPI: video: Shortening quirk list by identifying Clevo by board_name only

Willy Tarreau (6):
      secure_seq: use the 64 bits of the siphash for port offset calculation
      tcp: use different parts of the port_offset for index and offset
      tcp: add small random increments to the source port
      tcp: dynamically allocate the perturb table used by source ports
      tcp: increase source port perturb table to 2^16
      tcp: drop the hash_32() part from the index calculation

Xiaohui Zhang (1):
      nfc: nfcmrvl: Fix memory leak in nfcmrvl_play_deferred

Xin Xiong (1):
      xfrm: fix refcount leak in __xfrm_policy_check()

Xu Yang (1):
      usb: chipidea: udc: check request status before setting device address

Yang Jihong (1):
      ftrace: Fix NULL pointer dereference in is_ftrace_trampoline when ftrace is dead

Yang Yingliang (1):
      hwmon: (ibmaem) don't call platform_device_del() if platform_device_add() fails

Yangtao Li (5):
      random: remove unnecessary unlikely()
      random: convert to ENTROPY_BITS for better code readability
      random: Add and use pr_fmt()
      random: fix typo in add_timer_randomness()
      random: remove some dead code of poolinfo

Ye Bin (1):
      ext4: avoid remove directory when directory is corrupted

Yevhen Orlov (1):
      net: bonding: fix use-after-free after 802.3ad slave unbind

Yi Yang (1):
      serial: 8250: fix return error code in serial8250_request_std_resource()

Yian Chen (1):
      iommu/vt-d: Fix PCI bus rescan device hot add

Yury Norov (1):
      uapi: rename ext2_swab() to swab() and share globally in swab.h

Zhang Xianwei (1):
      NFSv4.1: RECLAIM_COMPLETE must handle EACCES

Zhang Yi (1):
      ext4: add reserved GDT blocks check

Zheyu Ma (2):
      ALSA: bcd2000: Fix a UAF bug on the error path of probing
      video: fbdev: i740fb: Check the argument of i740_calc_vclk()

Zhouyi Zhou (1):
      powerpc/64: Init jump labels before parse_early_param()

chengkaitao (1):
      virtio-mmio: fix missing put_device() when vm_cmdline_parent registration failed

huhai (1):
      MIPS: Remove repetitive increase irq_err_count

katrinzhou (1):
      ipv6/sit: fix ipip6_tunnel_get_prl return value

kernel test robot (1):
      sit: use min

zijun_hu (1):
      irqchip/gic-v3: Iterate over possible CPUs by for_each_possible_cpu()

Íñigo Huguet (2):
      sfc: fix use after free when disabling sriov
      sfc: fix kernel panic when creating VF
---
Documentation/ABI/testing/sysfs-bus-iio-vf610      |    2 +-
 .../hw-vuln/processor_mmio_stale_data.rst          |   14 +
 Documentation/kernel-parameters.txt                |   12 +
 Documentation/networking/ip-sysctl.txt             |    4 +-
 Documentation/sysctl/kernel.txt                    |   35 +-
 MAINTAINERS                                        |    1 +
 Makefile                                           |    2 +-
 arch/alpha/include/asm/timex.h                     |    1 +
 arch/alpha/kernel/srmcons.c                        |    2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |    2 +-
 arch/arm/include/asm/timex.h                       |    1 +
 arch/arm/lib/xor-neon.c                            |    3 +-
 arch/arm/mach-axxia/platsmp.c                      |    1 +
 arch/arm/mach-cns3xxx/core.c                       |    2 +
 arch/arm/mach-exynos/exynos.c                      |    1 +
 arch/arm/mm/proc-v7-bugs.c                         |    9 +-
 arch/arm/xen/p2m.c                                 |    6 +-
 arch/arm64/include/asm/mmu.h                       |    2 +-
 arch/arm64/kernel/entry.S                          |    1 +
 arch/arm64/kernel/kaslr.c                          |    5 +-
 arch/arm64/kernel/setup.c                          |    9 +-
 arch/arm64/mm/mmu.c                                |   15 +-
 arch/ia64/include/asm/processor.h                  |    2 +-
 arch/ia64/include/asm/timex.h                      |    1 +
 arch/m68k/include/asm/timex.h                      |    2 +-
 arch/mips/cavium-octeon/octeon-platform.c          |    3 +-
 arch/mips/include/asm/timex.h                      |   17 +-
 arch/mips/kernel/proc.c                            |    2 +-
 arch/mips/mm/tlbex.c                               |    4 +-
 arch/mips/vr41xx/common/icu.c                      |    2 -
 arch/nios2/include/asm/entry.h                     |    3 +-
 arch/nios2/include/asm/ptrace.h                    |    2 +
 arch/nios2/include/asm/timex.h                     |    3 +
 arch/nios2/kernel/entry.S                          |   22 +-
 arch/nios2/kernel/signal.c                         |    3 +-
 arch/nios2/kernel/syscall_table.c                  |    1 +
 arch/nios2/kernel/time.c                           |    5 +-
 arch/parisc/include/asm/timex.h                    |    3 +-
 arch/parisc/kernel/drivers.c                       |    9 +-
 arch/parisc/kernel/unaligned.c                     |    2 +-
 arch/powerpc/include/asm/archrandom.h              |   27 +-
 arch/powerpc/include/asm/ppc-opcode.h              |    4 +
 arch/powerpc/include/asm/timex.h                   |    1 +
 arch/powerpc/kernel/process.c                      |    2 +-
 arch/powerpc/kernel/prom.c                         |    7 +
 arch/powerpc/platforms/powernv/powernv.h           |    2 +
 arch/powerpc/platforms/powernv/rng.c               |   93 +-
 arch/powerpc/platforms/powernv/setup.c             |    2 +
 arch/powerpc/platforms/pseries/pseries.h           |    2 +
 arch/powerpc/platforms/pseries/rng.c               |   11 +-
 arch/powerpc/platforms/pseries/setup.c             |    1 +
 arch/powerpc/sysdev/fsl_pci.c                      |    8 +
 arch/powerpc/sysdev/fsl_pci.h                      |    1 +
 arch/s390/hypfs/hypfs_diag.c                       |    2 +-
 arch/s390/hypfs/inode.c                            |    2 +-
 arch/s390/include/asm/timex.h                      |    1 +
 arch/s390/mm/fault.c                               |    4 +-
 arch/s390/mm/pgtable.c                             |    2 +-
 arch/sparc/include/asm/timex_32.h                  |    4 +-
 arch/um/include/asm/timex.h                        |    9 +-
 arch/x86/include/asm/archrandom.h                  |   12 +-
 arch/x86/include/asm/cpufeatures.h                 |    1 +
 arch/x86/include/asm/intel-family.h                |    3 +
 arch/x86/include/asm/kexec.h                       |    7 +
 arch/x86/include/asm/timex.h                       |    9 +
 arch/x86/include/asm/tsc.h                         |    7 +-
 arch/x86/kernel/cpu/bugs.c                         |   14 +-
 arch/x86/kernel/cpu/common.c                       |   34 +-
 arch/x86/kernel/head64.c                           |    2 +
 arch/x86/kvm/emulate.c                             |   19 +-
 arch/x86/kvm/svm.c                                 |    2 -
 arch/x86/platform/olpc/olpc-xo1-sci.c              |    2 +-
 arch/xtensa/include/asm/timex.h                    |    6 +-
 arch/xtensa/kernel/time.c                          |    1 +
 arch/xtensa/platforms/xtfpga/setup.c               |    1 +
 crypto/chacha20_generic.c                          |    3 +-
 crypto/drbg.c                                      |  220 +-
 crypto/md4.c                                       |   17 -
 crypto/md5.c                                       |   17 -
 drivers/acpi/video_detect.c                        |   55 +-
 drivers/ata/libata-core.c                          |    4 +-
 drivers/ata/libata-eh.c                            |    1 +
 drivers/atm/idt77252.c                             |    1 +
 drivers/block/loop.c                               |    5 +
 drivers/block/xen-blkfront.c                       |   52 +-
 drivers/char/Kconfig                               |   38 +-
 drivers/char/hw_random/core.c                      |   93 +-
 drivers/char/random.c                              | 2908 ++++++++------------
 drivers/cpufreq/pmac32-cpufreq.c                   |    4 +
 drivers/dma/at_xdmac.c                             |    5 +
 drivers/dma/ti-dma-crossbar.c                      |    5 +
 drivers/gpio/gpio-vr41xx.c                         |    2 -
 drivers/gpu/drm/drm_crtc_helper_internal.h         |   10 -
 drivers/gpu/drm/drm_fb_helper.c                    |   21 -
 drivers/gpu/drm/drm_kms_helper_common.c            |   25 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c    |    2 +-
 drivers/hid/hidraw.c                               |    3 +
 drivers/hv/vmbus_drv.c                             |    5 +-
 drivers/hwmon/ibmaem.c                             |   12 +-
 drivers/i2c/busses/i2c-cadence.c                   |   31 +-
 drivers/iio/accel/bma180.c                         |    3 +-
 drivers/iio/accel/mma8452.c                        |   10 +-
 drivers/iio/trigger/iio-trig-sysfs.c               |    1 +
 drivers/iommu/dmar.c                               |    2 +-
 drivers/irqchip/irq-gic-realview.c                 |    1 +
 drivers/irqchip/irq-gic-v3.c                       |    8 +-
 drivers/irqchip/irq-tegra.c                        |   10 +-
 drivers/macintosh/adb.c                            |    2 +-
 drivers/md/dm-era-target.c                         |    8 +-
 drivers/md/dm-raid.c                               |    2 +-
 drivers/md/raid10.c                                |    5 +-
 drivers/md/raid5.c                                 |    3 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            |    1 +
 drivers/mfd/rtsx_usb.c                             |   27 +-
 drivers/misc/atmel-ssc.c                           |    4 +-
 drivers/misc/cxl/irq.c                             |    1 +
 drivers/net/bonding/bond_3ad.c                     |   41 +-
 drivers/net/bonding/bond_alb.c                     |    2 +-
 drivers/net/bonding/bond_main.c                    |    4 +-
 drivers/net/caif/caif_virtio.c                     |   10 +-
 drivers/net/can/grcan.c                            |    1 -
 drivers/net/can/m_can/m_can.c                      |    5 +-
 drivers/net/can/usb/ems_usb.c                      |    2 +-
 drivers/net/can/usb/gs_usb.c                       |   23 +-
 drivers/net/dsa/bcm_sf2.c                          |   19 +
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   10 +-
 drivers/net/ethernet/emulex/benet/be_cmds.h        |    2 +-
 drivers/net/ethernet/emulex/benet/be_ethtool.c     |   31 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |    6 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |   59 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   21 +-
 drivers/net/ethernet/sfc/ef10.c                    |    3 +
 drivers/net/ethernet/sfc/ef10_sriov.c              |   10 +-
 drivers/net/sungem_phy.c                           |    1 +
 drivers/net/usb/ax88179_178a.c                     |  101 +-
 drivers/net/usb/qmi_wwan.c                         |    6 +
 drivers/net/usb/usbnet.c                           |   48 +-
 drivers/net/wireless/mediatek/mt7601u/usb.c        |    1 +
 drivers/net/xen-netback/rx.c                       |    1 +
 drivers/net/xen-netfront.c                         |   55 +-
 drivers/nfc/nfcmrvl/i2c.c                          |    6 +-
 drivers/nfc/nfcmrvl/spi.c                          |    6 +-
 drivers/nfc/nfcmrvl/usb.c                          |   16 +-
 drivers/nfc/nxp-nci/i2c.c                          |   11 +-
 drivers/of/fdt.c                                   |   14 +
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |    4 +-
 drivers/pinctrl/qcom/pinctrl-msm8916.c             |    4 +-
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c         |   10 +-
 drivers/power/reset/arm-versatile-reboot.c         |    1 +
 drivers/s390/char/keyboard.h                       |    4 +-
 drivers/s390/scsi/zfcp_fc.c                        |   29 +-
 drivers/s390/scsi/zfcp_fc.h                        |    6 +-
 drivers/s390/scsi/zfcp_fsf.c                       |    4 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |    3 +-
 drivers/scsi/sg.c                                  |   57 +-
 drivers/scsi/ufs/ufshcd-pltfrm.c                   |   15 +-
 drivers/scsi/vmw_pvscsi.h                          |    4 +-
 drivers/staging/android/ion/ion-ioctl.c            |    8 +-
 drivers/staging/comedi/drivers/vmk80xx.c           |    2 +-
 drivers/tty/cyclades.c                             |    6 +-
 drivers/tty/goldfish.c                             |    2 +-
 drivers/tty/moxa.c                                 |    4 +-
 drivers/tty/pty.c                                  |   14 +-
 drivers/tty/serial/8250/8250_port.c                |    6 +-
 drivers/tty/serial/lpc32xx_hs.c                    |    2 +-
 drivers/tty/serial/samsung.c                       |    5 +-
 drivers/tty/serial/ucc_uart.c                      |    2 +
 drivers/tty/tty_buffer.c                           |   66 +-
 drivers/tty/vt/keyboard.c                          |    6 +-
 drivers/tty/vt/vt.c                                |   36 +-
 drivers/tty/vt/vt_ioctl.c                          |  149 -
 drivers/usb/chipidea/udc.c                         |    3 +
 drivers/usb/core/hcd.c                             |   26 +-
 drivers/usb/dwc3/gadget.c                          |    4 +-
 drivers/usb/gadget/legacy/inode.c                  |    1 +
 drivers/usb/gadget/udc/lpc32xx_udc.c               |    1 +
 drivers/usb/host/ohci-ppc-of.c                     |    1 +
 drivers/usb/serial/ftdi_sio.c                      |    3 +
 drivers/usb/serial/ftdi_sio_ids.h                  |    6 +
 drivers/usb/serial/io_ti.c                         |    2 +
 drivers/usb/serial/io_usbvend.h                    |    1 +
 drivers/usb/serial/option.c                        |    7 +
 drivers/vfio/vfio.c                                |    1 +
 drivers/video/fbdev/i740fb.c                       |    9 +-
 drivers/video/fbdev/pm2fb.c                        |    5 +
 drivers/virtio/virtio_mmio.c                       |   27 +
 drivers/xen/features.c                             |    2 +-
 drivers/xen/gntdev.c                               |  145 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c           |    4 +-
 drivers/xen/xlate_mmu.c                            |    1 -
 fs/9p/vfs_inode_dotl.c                             |   10 +-
 fs/attr.c                                          |    2 +
 fs/btrfs/disk-io.c                                 |   14 +
 fs/btrfs/tree-log.c                                |    4 +-
 fs/btrfs/xattr.c                                   |    3 +
 fs/ext4/inline.c                                   |    3 +
 fs/ext4/inode.c                                    |    7 +
 fs/ext4/mballoc.c                                  |    9 +
 fs/ext4/namei.c                                    |   26 +-
 fs/ext4/resize.c                                   |   21 +
 fs/ext4/xattr.c                                    |    6 +-
 fs/ext4/xattr.h                                    |   13 +
 fs/fuse/dev.c                                      |   12 +-
 fs/fuse/file.c                                     |    1 +
 fs/fuse/fuse_i.h                                   |    2 +
 fs/fuse/inode.c                                    |    6 +
 fs/nfs/nfs4proc.c                                  |    3 +
 fs/nfs/pnfs.c                                      |    6 +
 fs/nilfs2/nilfs.h                                  |    3 +
 fs/ntfs/attrib.c                                   |    8 +-
 fs/proc/base.c                                     |   23 +-
 fs/proc/fd.c                                       |    6 +-
 fs/proc/internal.h                                 |    2 +-
 fs/proc/namespaces.c                               |    3 +-
 fs/xfs/xfs_inode.c                                 |    1 -
 include/asm-generic/sections.h                     |    7 +-
 include/crypto/blake2s.h                           |  102 +
 include/crypto/chacha20.h                          |   17 +-
 include/crypto/drbg.h                              |   18 +-
 include/crypto/internal/blake2s.h                  |   19 +
 include/linux/bpf.h                                |   11 +
 include/linux/buffer_head.h                        |   25 +-
 include/linux/byteorder/generic.h                  |   17 +
 include/linux/cpuhotplug.h                         |    2 +
 include/linux/hw_random.h                          |    2 -
 include/linux/irqdesc.h                            |    1 -
 include/linux/kd.h                                 |    7 -
 include/linux/kexec.h                              |   26 +-
 include/linux/locallock.h                          |    5 +
 include/linux/lsm_hooks.h                          |    7 -
 include/linux/mfd/rtsx_usb.h                       |    2 -
 include/linux/miscdevice.h                         |    1 +
 include/linux/mm.h                                 |    2 +
 include/linux/net.h                                |    2 +
 include/linux/once.h                               |    2 +
 include/linux/pci_ids.h                            |    2 +
 include/linux/prandom.h                            |   23 +-
 include/linux/random.h                             |  133 +-
 include/linux/ratelimit.h                          |   12 +-
 include/linux/rcuwait.h                            |   76 +
 include/linux/rmap.h                               |    7 +-
 include/linux/security.h                           |    6 -
 include/linux/siphash.h                            |   28 +
 include/linux/skbuff.h                             |    1 +
 include/linux/swab.h                               |    1 +
 include/linux/timex.h                              |   10 +-
 include/linux/tty_flip.h                           |    4 +-
 include/linux/usb/hcd.h                            |    1 +
 include/linux/uuid.h                               |    1 +
 include/linux/workqueue.h                          |    7 +-
 include/net/bluetooth/l2cap.h                      |    1 +
 include/net/busy_poll.h                            |    2 +-
 include/net/inet_hashtables.h                      |    2 +-
 include/net/inet_sock.h                            |    3 +-
 include/net/ip.h                                   |    2 +-
 include/net/secure_seq.h                           |    4 +-
 include/net/tcp.h                                  |    2 +-
 include/sound/core.h                               |    8 +
 include/trace/events/libata.h                      |    1 +
 include/trace/events/random.h                      |  315 ---
 include/trace/events/sock.h                        |    6 +-
 include/trace/events/spmi.h                        |   12 +-
 include/uapi/linux/random.h                        |    4 +-
 include/uapi/linux/swab.h                          |   10 +
 include/video/of_display_timing.h                  |    2 +
 init/main.c                                        |   34 +-
 kernel/bpf/core.c                                  |   24 +-
 kernel/bpf/syscall.c                               |   36 +-
 kernel/cpu.c                                       |   11 +
 kernel/events/core.c                               |   45 +-
 kernel/exit.c                                      |   49 +-
 kernel/irq/handle.c                                |    8 +-
 kernel/irq/manage.c                                |    6 -
 kernel/kexec_file.c                                |   18 -
 kernel/kprobes.c                                   |   10 +-
 kernel/rcu/update.c                                |    8 +
 kernel/signal.c                                    |    8 +-
 kernel/time/timekeeping.c                          |   16 +
 kernel/time/timer.c                                |   14 +-
 kernel/trace/ftrace.c                              |   10 +
 kernel/workqueue.c                                 |  347 +--
 lib/Kconfig.debug                                  |   27 +
 lib/Makefile                                       |    2 +
 lib/chacha20.c                                     |    6 +-
 lib/crypto/Makefile                                |    7 +
 lib/crypto/blake2s-generic.c                       |  111 +
 lib/crypto/blake2s-selftest.c                      |  591 ++++
 lib/crypto/blake2s.c                               |   78 +
 lib/find_bit.c                                     |   16 +-
 lib/idr.c                                          |    4 +-
 lib/random32.c                                     |   15 +-
 lib/ratelimit.c                                    |   12 +-
 lib/sha1.c                                         |   95 +-
 lib/siphash.c                                      |   32 +-
 lib/swiotlb.c                                      |   10 +-
 localversion-rt                                    |    2 +-
 mm/memory.c                                        |    9 +-
 mm/mempolicy.c                                     |    2 +-
 mm/mmap.c                                          |   20 +-
 mm/rmap.c                                          |   31 +-
 mm/slub.c                                          |    5 +
 mm/util.c                                          |   33 +
 net/9p/client.c                                    |    4 +-
 net/bluetooth/l2cap_core.c                         |   64 +-
 net/core/secure_seq.c                              |    4 +-
 net/core/skbuff.c                                  |   11 +-
 net/core/sock.c                                    |    2 +-
 net/ipv4/af_inet.c                                 |    4 +-
 net/ipv4/cipso_ipv4.c                              |   12 +-
 net/ipv4/icmp.c                                    |    5 +-
 net/ipv4/igmp.c                                    |   23 +-
 net/ipv4/inet_hashtables.c                         |   46 +-
 net/ipv4/tcp_output.c                              |    9 +-
 net/ipv6/inet6_hashtables.c                        |    4 +-
 net/ipv6/ping.c                                    |    6 +
 net/ipv6/sit.c                                     |   10 +-
 net/key/af_key.c                                   |    3 +
 net/l2tp/l2tp_ip6.c                                |    5 +-
 net/l2tp/l2tp_ppp.c                                |   60 +-
 net/netfilter/Kconfig                              |    1 -
 net/netfilter/nf_tables_api.c                      |    3 +-
 net/netfilter/nfnetlink_queue.c                    |    7 +-
 net/netfilter/nft_payload.c                        |   10 +-
 net/netfilter/nft_set_hash.c                       |    2 +
 net/rds/ib_recv.c                                  |    1 +
 net/rose/rose_loopback.c                           |    3 +-
 net/rose/rose_route.c                              |    4 +-
 net/rose/rose_timer.c                              |   34 +-
 net/sched/cls_route.c                              |    8 +-
 net/socket.c                                       |    2 +-
 net/sunrpc/backchannel_rqst.c                      |   14 +
 net/sunrpc/xdr.c                                   |    2 +-
 net/sunrpc/xprtrdma/rpc_rdma.c                     |    4 +-
 net/tipc/socket.c                                  |    1 +
 net/vmw_vsock/af_vsock.c                           |    9 +-
 net/xfrm/xfrm_policy.c                             |    6 +-
 scripts/Makefile.modpost                           |    3 +-
 scripts/mod/modpost.c                              |    2 +-
 security/security.c                                |    6 -
 security/selinux/hooks.c                           |  129 +-
 security/selinux/include/objsec.h                  |    5 +-
 security/selinux/selinuxfs.c                       |    4 +-
 security/smack/smack_lsm.c                         |   20 -
 sound/core/info.c                                  |    6 +-
 sound/core/memalloc.c                              |    1 +
 sound/core/misc.c                                  |   94 +
 sound/core/timer.c                                 |   11 +-
 sound/pci/hda/patch_cirrus.c                       |    1 +
 sound/pci/hda/patch_conexant.c                     |   11 +-
 sound/pci/hda/patch_realtek.c                      |    1 +
 sound/soc/codecs/cs42l52.c                         |    8 +-
 sound/soc/codecs/cs42l56.c                         |    4 +-
 sound/soc/codecs/cs53l30.c                         |   16 +-
 sound/soc/codecs/wm5110.c                          |    8 +-
 sound/soc/codecs/wm8962.c                          |    1 +
 sound/soc/soc-ops.c                                |    4 +-
 sound/usb/bcd2000/bcd2000.c                        |    3 +-
 358 files changed, 5106 insertions(+), 3895 deletions(-)
---
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-vf610 b/Documentation/ABI/testing/sysfs-bus-iio-vf610
index 308a6756d3bf..491ead804488 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-vf610
+++ b/Documentation/ABI/testing/sysfs-bus-iio-vf610
@@ -1,4 +1,4 @@
-What:		/sys/bus/iio/devices/iio:deviceX/conversion_mode
+What:		/sys/bus/iio/devices/iio:deviceX/in_conversion_mode
 KernelVersion:	4.2
 Contact:	linux-iio@vger.kernel.org
 Description:
diff --git a/Documentation/hw-vuln/processor_mmio_stale_data.rst b/Documentation/hw-vuln/processor_mmio_stale_data.rst
index 9393c50b5afc..c98fd11907cc 100644
--- a/Documentation/hw-vuln/processor_mmio_stale_data.rst
+++ b/Documentation/hw-vuln/processor_mmio_stale_data.rst
@@ -230,6 +230,20 @@ The possible values in this file are:
      * - 'Mitigation: Clear CPU buffers'
        - The processor is vulnerable and the CPU buffer clearing mitigation is
          enabled.
+     * - 'Unknown: No mitigations'
+       - The processor vulnerability status is unknown because it is
+	 out of Servicing period. Mitigation is not attempted.
+
+Definitions:
+------------
+
+Servicing period: The process of providing functional and security updates to
+Intel processors or platforms, utilizing the Intel Platform Update (IPU)
+process or other similar mechanisms.
+
+End of Servicing Updates (ESU): ESU is the date at which Intel will no
+longer provide Servicing, such as through IPU or other similar update
+processes. ESU dates will typically be aligned to end of quarter.
 
 If the processor is vulnerable then the following information is appended to
 the above information:
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 97c0ff0787ea..92a9a3282c5b 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3577,6 +3577,18 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/blockdev/ramdisk.txt.
 
+	random.trust_cpu={on,off}
+			[KNL] Enable or disable trusting the use of the
+			CPU's random number generator (if available) to
+			fully seed the kernel's CRNG. Default is controlled
+			by CONFIG_RANDOM_TRUST_CPU.
+
+	random.trust_bootloader={on,off}
+			[KNL] Enable or disable trusting the use of a
+			seed passed by the bootloader (if available) to
+			fully seed the kernel's CRNG. Default is controlled
+			by CONFIG_RANDOM_TRUST_BOOTLOADER.
+
 	rcu_nocbs=	[KNL]
 			The argument is a cpu list, as described above.
 
diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
index a374412610ba..dfac66c71cb5 100644
--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -781,7 +781,7 @@ cipso_cache_enable - BOOLEAN
 cipso_cache_bucket_size - INTEGER
 	The CIPSO label cache consists of a fixed size hash table with each
 	hash bucket containing a number of cache entries.  This variable limits
-	the number of entries in each hash bucket; the larger the value the
+	the number of entries in each hash bucket; the larger the value is, the
 	more CIPSO label mappings that can be cached.  When the number of
 	entries in a given hash bucket reaches this limit adding new entries
 	causes the oldest entry in the bucket to be removed to make room.
@@ -849,7 +849,7 @@ ip_nonlocal_bind - BOOLEAN
 	which can be quite useful - but may break some applications.
 	Default: 0
 
-ip_dynaddr - BOOLEAN
+ip_dynaddr - INTEGER
 	If set non-zero, enables support for dynamic addresses.
 	If set to a non-zero value larger than 1, a kernel log
 	message will be printed when dynamic address rewriting
diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 30ba179392d8..79608693ef0b 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -777,9 +777,40 @@ The kernel command line parameter printk.devkmsg= overrides this and is
 a one-time setting until next reboot: once set, it cannot be changed by
 this sysctl interface anymore.
 
-==============================================================
+pty
+===
+
+See Documentation/filesystems/devpts.rst.
+
+
+random
+======
+
+This is a directory, with the following entries:
+
+* ``boot_id``: a UUID generated the first time this is retrieved, and
+  unvarying after that;
+
+* ``uuid``: a UUID generated every time this is retrieved (this can
+  thus be used to generate UUIDs at will);
+
+* ``entropy_avail``: the pool's entropy count, in bits;
+
+* ``poolsize``: the entropy pool size, in bits;
+
+* ``urandom_min_reseed_secs``: obsolete (used to determine the minimum
+  number of seconds between urandom pool reseeding). This file is
+  writable for compatibility purposes, but writing to it has no effect
+  on any RNG behavior;
+
+* ``write_wakeup_threshold``: when the entropy count drops below this
+  (as a number of bits), processes waiting to write to ``/dev/random``
+  are woken up. This file is writable for compatibility purposes, but
+  writing to it has no effect on any RNG behavior.
+
 
-randomize_va_space:
+randomize_va_space
+==================
 
 This option can be used to select the type of process address
 space randomization that is used in the system, for architectures
diff --git a/MAINTAINERS b/MAINTAINERS
index 476e4b4802e2..2519ce19fb60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10085,6 +10085,7 @@ F:	drivers/block/brd.c
 
 RANDOM NUMBER DRIVER
 M:	"Theodore Ts'o" <tytso@mit.edu>
+M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 F:	drivers/char/random.c
 
diff --git a/Makefile b/Makefile
index bf4a7b0fe8e7..df5f7e0d3039 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 4
 PATCHLEVEL = 9
-SUBLEVEL = 319
+SUBLEVEL = 327
 EXTRAVERSION =
 NAME = Roaring Lionus
 
diff --git a/arch/alpha/include/asm/timex.h b/arch/alpha/include/asm/timex.h
index afa0c45e3e98..c3ed97c79086 100644
--- a/arch/alpha/include/asm/timex.h
+++ b/arch/alpha/include/asm/timex.h
@@ -27,5 +27,6 @@ static inline cycles_t get_cycles (void)
 	__asm__ __volatile__ ("rpcc %0" : "=r"(ret));
 	return ret;
 }
+#define get_cycles get_cycles
 
 #endif
diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 72b59511e59a..bfeafff14c09 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -58,7 +58,7 @@ srmcons_do_receive_chars(struct tty_port *port)
 	} while((result.bits.status & 1) && (++loops < 10));
 
 	if (count)
-		tty_schedule_flip(port);
+		tty_flip_buffer_push(port);
 
 	return count;
 }
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 8ccafdfbe87c..5fae9adb9f32 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -686,7 +686,7 @@
 					regulator-name = "vddpu";
 					regulator-min-microvolt = <725000>;
 					regulator-max-microvolt = <1450000>;
-					regulator-enable-ramp-delay = <150>;
+					regulator-enable-ramp-delay = <380>;
 					anatop-reg-offset = <0x140>;
 					anatop-vol-bit-shift = <9>;
 					anatop-vol-bit-width = <5>;
diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
index f6fcc67ef06e..c06d38f0df8e 100644
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -14,5 +14,6 @@
 
 typedef unsigned long cycles_t;
 #define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
+#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
 
 #endif
diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index c691b901092f..b4feebc385bc 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -29,8 +29,9 @@ MODULE_LICENSE("GPL");
  * While older versions of GCC do not generate incorrect code, they fail to
  * recognize the parallel nature of these functions, and emit plain ARM code,
  * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
+ *
+ * #warning This code requires at least version 4.6 of GCC
  */
-#warning This code requires at least version 4.6 of GCC
 #endif
 
 #pragma GCC diagnostic ignored "-Wunused-variable"
diff --git a/arch/arm/mach-axxia/platsmp.c b/arch/arm/mach-axxia/platsmp.c
index ffbd71d45008..a895ab988b58 100644
--- a/arch/arm/mach-axxia/platsmp.c
+++ b/arch/arm/mach-axxia/platsmp.c
@@ -42,6 +42,7 @@ static int axxia_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		return -ENOENT;
 
 	syscon = of_iomap(syscon_np, 0);
+	of_node_put(syscon_np);
 	if (!syscon)
 		return -ENOMEM;
 
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 7d5a44a06648..95716fc9e628 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -379,6 +379,7 @@ static void __init cns3xxx_init(void)
 		/* De-Asscer SATA Reset */
 		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
 	}
+	of_node_put(dn);
 
 	dn = of_find_compatible_node(NULL, NULL, "cavium,cns3420-sdhci");
 	if (of_device_is_available(dn)) {
@@ -392,6 +393,7 @@ static void __init cns3xxx_init(void)
 		cns3xxx_pwr_clk_en(CNS3XXX_PWR_CLK_EN(SDIO));
 		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SDIO));
 	}
+	of_node_put(dn);
 
 	pm_power_off = cns3xxx_power_off;
 
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 757fc11de30d..e6ef717f1621 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -167,6 +167,7 @@ static void exynos_map_pmu(void)
 	np = of_find_matching_node(NULL, exynos_dt_pmu_match);
 	if (np)
 		pmu_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 }
 
 static void __init exynos_init_irq(void)
diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
index 8b78694d56b8..4af4195eed76 100644
--- a/arch/arm/mm/proc-v7-bugs.c
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -110,8 +110,7 @@ static unsigned int spectre_v2_install_workaround(unsigned int method)
 #else
 static unsigned int spectre_v2_install_workaround(unsigned int method)
 {
-	pr_info("CPU%u: Spectre V2: workarounds disabled by configuration\n",
-		smp_processor_id());
+	pr_info_once("Spectre V2: workarounds disabled by configuration\n");
 
 	return SPECTRE_VULNERABLE;
 }
@@ -218,10 +217,10 @@ static int spectre_bhb_install_workaround(int method)
 			return SPECTRE_VULNERABLE;
 
 		spectre_bhb_method = method;
-	}
 
-	pr_info("CPU%u: Spectre BHB: using %s workaround\n",
-		smp_processor_id(), spectre_bhb_method_name(method));
+		pr_info("CPU%u: Spectre BHB: enabling %s workaround for all CPUs\n",
+			smp_processor_id(), spectre_bhb_method_name(method));
+	}
 
 	return SPECTRE_MITIGATED;
 }
diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
index b4ec8d1b0bef..dc8f41deea1e 100644
--- a/arch/arm/xen/p2m.c
+++ b/arch/arm/xen/p2m.c
@@ -61,11 +61,12 @@ static int xen_add_phys_to_mach_entry(struct xen_p2m_entry *new)
 
 unsigned long __pfn_to_mfn(unsigned long pfn)
 {
-	struct rb_node *n = phys_to_mach.rb_node;
+	struct rb_node *n;
 	struct xen_p2m_entry *entry;
 	unsigned long irqflags;
 
 	read_lock_irqsave(&p2m_lock, irqflags);
+	n = phys_to_mach.rb_node;
 	while (n) {
 		entry = rb_entry(n, struct xen_p2m_entry, rbnode_phys);
 		if (entry->pfn <= pfn &&
@@ -151,10 +152,11 @@ bool __set_phys_to_machine_multi(unsigned long pfn,
 	int rc;
 	unsigned long irqflags;
 	struct xen_p2m_entry *p2m_entry;
-	struct rb_node *n = phys_to_mach.rb_node;
+	struct rb_node *n;
 
 	if (mfn == INVALID_P2M_ENTRY) {
 		write_lock_irqsave(&p2m_lock, irqflags);
+		n = phys_to_mach.rb_node;
 		while (n) {
 			p2m_entry = rb_entry(n, struct xen_p2m_entry, rbnode_phys);
 			if (p2m_entry->pfn <= pfn &&
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index f4377b005cba..c944253b3a4b 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -90,7 +90,7 @@ extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot, bool allow_block_mappings);
-extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
+extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 
 #endif	/* !__ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 1e687b144eaa..2cdde8adafb7 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -970,6 +970,7 @@ __ni_sys_trace:
 	b	.
 2:
 	tramp_map_kernel	x30
+	isb
 	tramp_data_read_var	x30, vectors
 	prfm	plil1strm, [x30, #(1b - \vector_start)]
 	msr	vbar_el1, x30
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index c9ca903462a6..6a9668f6e933 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -65,9 +65,6 @@ static __init const u8 *kaslr_get_cmdline(void *fdt)
 	return default_cmdline;
 }
 
-extern void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size,
-				       pgprot_t prot);
-
 /*
  * This routine will be executed with the kernel mapped at its default virtual
  * address, and if it returns successfully, the kernel will be remapped, and
@@ -96,7 +93,7 @@ u64 __init kaslr_early_init(u64 dt_phys, u64 modulo_offset)
 	 * attempt at mapping the FDT in setup_machine()
 	 */
 	early_fixmap_init();
-	fdt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
+	fdt = fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
 	if (!fdt)
 		return 0;
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f534f492a268..ae82d9694542 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -178,7 +178,11 @@ static void __init smp_build_mpidr_hash(void)
 
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
-	void *dt_virt = fixmap_remap_fdt(dt_phys);
+	int size;
+	void *dt_virt = fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
+
+	if (dt_virt)
+		memblock_reserve(dt_phys, size);
 
 	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
 		pr_crit("\n"
@@ -191,6 +195,9 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 			cpu_relax();
 	}
 
+	/* Early fixups are done, map the FDT as read-only now */
+	fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
+
 	dump_stack_set_arch_desc("%s (DT)", of_flat_dt_get_machine_name());
 }
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 36bd50091c4b..784ea7c8d996 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -718,7 +718,7 @@ void __set_fixmap(enum fixed_addresses idx,
 	}
 }
 
-void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
+void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 {
 	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
 	int offset;
@@ -771,19 +771,6 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	return dt_virt;
 }
 
-void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
-{
-	void *dt_virt;
-	int size;
-
-	dt_virt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
-	if (!dt_virt)
-		return NULL;
-
-	memblock_reserve(dt_phys, size);
-	return dt_virt;
-}
-
 int __init arch_ioremap_pud_supported(void)
 {
 	/*
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index ce53c50d0ba4..9f0f9ecbd74d 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -554,7 +554,7 @@ ia64_get_irr(unsigned int vector)
 {
 	unsigned int reg = vector / 64;
 	unsigned int bit = vector % 64;
-	u64 irr;
+	unsigned long irr;
 
 	switch (reg) {
 	case 0: irr = ia64_getreg(_IA64_REG_CR_IRR0); break;
diff --git a/arch/ia64/include/asm/timex.h b/arch/ia64/include/asm/timex.h
index 86c7db861180..0117fa73ad49 100644
--- a/arch/ia64/include/asm/timex.h
+++ b/arch/ia64/include/asm/timex.h
@@ -38,6 +38,7 @@ get_cycles (void)
 	ret = ia64_getreg(_IA64_REG_AR_ITC);
 	return ret;
 }
+#define get_cycles get_cycles
 
 extern void ia64_cpu_local_tick (void);
 extern unsigned long long ia64_native_sched_clock (void);
diff --git a/arch/m68k/include/asm/timex.h b/arch/m68k/include/asm/timex.h
index efc1f4892357..bbaf67f3a952 100644
--- a/arch/m68k/include/asm/timex.h
+++ b/arch/m68k/include/asm/timex.h
@@ -34,7 +34,7 @@ static inline unsigned long random_get_entropy(void)
 {
 	if (mach_random_get_entropy)
 		return mach_random_get_entropy();
-	return 0;
+	return random_get_entropy_fallback();
 }
 #define random_get_entropy	random_get_entropy
 
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 2ecc8d1b0539..f295be876390 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -130,11 +130,12 @@ static void octeon2_usb_clocks_start(struct device *dev)
 					 "refclk-frequency", &clock_rate);
 		if (i) {
 			dev_err(dev, "No UCTL \"refclk-frequency\"\n");
+			of_node_put(uctl_node);
 			goto exit;
 		}
 		i = of_property_read_string(uctl_node,
 					    "refclk-type", &clock_type);
-
+		of_node_put(uctl_node);
 		if (!i && strcmp("crystal", clock_type) == 0)
 			is_crystal_clock = true;
 	}
diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
index 8026baf46e72..2e107886f97a 100644
--- a/arch/mips/include/asm/timex.h
+++ b/arch/mips/include/asm/timex.h
@@ -76,25 +76,24 @@ static inline cycles_t get_cycles(void)
 	else
 		return 0;	/* no usable counter */
 }
+#define get_cycles get_cycles
 
 /*
  * Like get_cycles - but where c0_count is not available we desperately
  * use c0_random in an attempt to get at least a little bit of entropy.
- *
- * R6000 and R6000A neither have a count register nor a random register.
- * That leaves no entropy source in the CPU itself.
  */
 static inline unsigned long random_get_entropy(void)
 {
-	unsigned int prid = read_c0_prid();
-	unsigned int imp = prid & PRID_IMP_MASK;
+	unsigned int c0_random;
 
-	if (can_use_mips_counter(prid))
+	if (can_use_mips_counter(read_c0_prid()))
 		return read_c0_count();
-	else if (likely(imp != PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
-		return read_c0_random();
+
+	if (cpu_has_3kex)
+		c0_random = (read_c0_random() >> 8) & 0x3f;
 	else
-		return 0;	/* no usable register */
+		c0_random = read_c0_random() & 0x3f;
+	return (random_get_entropy_fallback() << 6) | (0x3f - c0_random);
 }
 #define random_get_entropy random_get_entropy
 
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 4c01ee5b88c9..85efddd81af1 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -162,7 +162,7 @@ static void *c_start(struct seq_file *m, loff_t *pos)
 {
 	unsigned long i = *pos;
 
-	return i < NR_CPUS ? (void *) (i + 1) : NULL;
+	return i < nr_cpu_ids ? (void *) (i + 1) : NULL;
 }
 
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index f625fd20b21e..65fed205383e 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -637,7 +637,7 @@ static __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
 		return;
 	}
 
-	if (cpu_has_rixi && !!_PAGE_NO_EXEC) {
+	if (cpu_has_rixi && _PAGE_NO_EXEC != 0) {
 		if (fill_includes_sw_bits) {
 			UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL));
 		} else {
@@ -2518,7 +2518,7 @@ static void check_pabits(void)
 	unsigned long entry;
 	unsigned pabits, fillbits;
 
-	if (!cpu_has_rixi || !_PAGE_NO_EXEC) {
+	if (!cpu_has_rixi || _PAGE_NO_EXEC == 0) {
 		/*
 		 * We'll only be making use of the fact that we can rotate bits
 		 * into the fill if the CPU supports RIXI, so don't bother
diff --git a/arch/mips/vr41xx/common/icu.c b/arch/mips/vr41xx/common/icu.c
index 41e873bc8474..a174fda8b397 100644
--- a/arch/mips/vr41xx/common/icu.c
+++ b/arch/mips/vr41xx/common/icu.c
@@ -653,8 +653,6 @@ static int icu_get_irq(unsigned int irq)
 
 	printk(KERN_ERR "spurious ICU interrupt: %04x,%04x\n", pend1, pend2);
 
-	atomic_inc(&irq_err_count);
-
 	return -1;
 }
 
diff --git a/arch/nios2/include/asm/entry.h b/arch/nios2/include/asm/entry.h
index cf37f55efbc2..bafb7b2ca59f 100644
--- a/arch/nios2/include/asm/entry.h
+++ b/arch/nios2/include/asm/entry.h
@@ -50,7 +50,8 @@
 	stw	r13, PT_R13(sp)
 	stw	r14, PT_R14(sp)
 	stw	r15, PT_R15(sp)
-	stw	r2, PT_ORIG_R2(sp)
+	movi	r24, -1
+	stw	r24, PT_ORIG_R2(sp)
 	stw	r7, PT_ORIG_R7(sp)
 
 	stw	ra, PT_RA(sp)
diff --git a/arch/nios2/include/asm/ptrace.h b/arch/nios2/include/asm/ptrace.h
index 642462144872..9da34c3022a2 100644
--- a/arch/nios2/include/asm/ptrace.h
+++ b/arch/nios2/include/asm/ptrace.h
@@ -74,6 +74,8 @@ extern void show_regs(struct pt_regs *);
 	((struct pt_regs *)((unsigned long)current_thread_info() + THREAD_SIZE)\
 		- 1)
 
+#define force_successful_syscall_return() (current_pt_regs()->orig_r2 = -1)
+
 int do_syscall_trace_enter(void);
 void do_syscall_trace_exit(void);
 #endif /* __ASSEMBLY__ */
diff --git a/arch/nios2/include/asm/timex.h b/arch/nios2/include/asm/timex.h
index 2f2abb28ec2f..9c9b50599ea3 100644
--- a/arch/nios2/include/asm/timex.h
+++ b/arch/nios2/include/asm/timex.h
@@ -20,5 +20,8 @@
 typedef unsigned long cycles_t;
 
 extern cycles_t get_cycles(void);
+#define get_cycles get_cycles
+
+#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
 
 #endif
diff --git a/arch/nios2/kernel/entry.S b/arch/nios2/kernel/entry.S
index 1e515ccd698e..af556588248e 100644
--- a/arch/nios2/kernel/entry.S
+++ b/arch/nios2/kernel/entry.S
@@ -185,6 +185,7 @@ ENTRY(handle_system_call)
 	ldw	r5, PT_R5(sp)
 
 local_restart:
+	stw	r2, PT_ORIG_R2(sp)
 	/* Check that the requested system call is within limits */
 	movui	r1, __NR_syscalls
 	bgeu	r2, r1, ret_invsyscall
@@ -192,7 +193,6 @@ local_restart:
 	movhi	r11, %hiadj(sys_call_table)
 	add	r1, r1, r11
 	ldw	r1, %lo(sys_call_table)(r1)
-	beq	r1, r0, ret_invsyscall
 
 	/* Check if we are being traced */
 	GET_THREAD_INFO r11
@@ -213,6 +213,9 @@ local_restart:
 translate_rc_and_ret:
 	movi	r1, 0
 	bge	r2, zero, 3f
+	ldw	r1, PT_ORIG_R2(sp)
+	addi	r1, r1, 1
+	beq	r1, zero, 3f
 	sub	r2, zero, r2
 	movi	r1, 1
 3:
@@ -255,9 +258,9 @@ traced_system_call:
 	ldw	r6, PT_R6(sp)
 	ldw	r7, PT_R7(sp)
 
-	/* Fetch the syscall function, we don't need to check the boundaries
-	 * since this is already done.
-	 */
+	/* Fetch the syscall function. */
+	movui	r1, __NR_syscalls
+	bgeu	r2, r1, traced_invsyscall
 	slli	r1, r2, 2
 	movhi	r11,%hiadj(sys_call_table)
 	add	r1, r1, r11
@@ -276,6 +279,9 @@ traced_system_call:
 translate_rc_and_ret2:
 	movi	r1, 0
 	bge	r2, zero, 4f
+	ldw	r1, PT_ORIG_R2(sp)
+	addi	r1, r1, 1
+	beq	r1, zero, 4f
 	sub	r2, zero, r2
 	movi	r1, 1
 4:
@@ -287,6 +293,11 @@ end_translate_rc_and_ret2:
 	RESTORE_SWITCH_STACK
 	br	ret_from_exception
 
+	/* If the syscall number was invalid return ENOSYS */
+traced_invsyscall:
+	movi	r2, -ENOSYS
+	br	translate_rc_and_ret2
+
 Luser_return:
 	GET_THREAD_INFO	r11			/* get thread_info pointer */
 	ldw	r10, TI_FLAGS(r11)		/* get thread_info->flags */
@@ -336,9 +347,6 @@ external_interrupt:
 	/* skip if no interrupt is pending */
 	beq	r12, r0, ret_from_interrupt
 
-	movi	r24, -1
-	stw	r24, PT_ORIG_R2(sp)
-
 	/*
 	 * Process an external hardware interrupt.
 	 */
diff --git a/arch/nios2/kernel/signal.c b/arch/nios2/kernel/signal.c
index 20662b0f6c9e..c1be8e194138 100644
--- a/arch/nios2/kernel/signal.c
+++ b/arch/nios2/kernel/signal.c
@@ -240,7 +240,7 @@ static int do_signal(struct pt_regs *regs)
 	/*
 	 * If we were from a system call, check for system call restarting...
 	 */
-	if (regs->orig_r2 >= 0) {
+	if (regs->orig_r2 >= 0 && regs->r1) {
 		continue_addr = regs->ea;
 		restart_addr = continue_addr - 4;
 		retval = regs->r2;
@@ -261,6 +261,7 @@ static int do_signal(struct pt_regs *regs)
 			regs->ea = restart_addr;
 			break;
 		}
+		regs->orig_r2 = -1;
 	}
 
 	if (get_signal(&ksig)) {
diff --git a/arch/nios2/kernel/syscall_table.c b/arch/nios2/kernel/syscall_table.c
index 06e6ac1835b2..cd10b6eed128 100644
--- a/arch/nios2/kernel/syscall_table.c
+++ b/arch/nios2/kernel/syscall_table.c
@@ -25,5 +25,6 @@
 #define __SYSCALL(nr, call) [nr] = (call),
 
 void *sys_call_table[__NR_syscalls] = {
+	[0 ... __NR_syscalls-1] = sys_ni_syscall,
 #include <asm/unistd.h>
 };
diff --git a/arch/nios2/kernel/time.c b/arch/nios2/kernel/time.c
index 746bf5caaffc..3ff56008566e 100644
--- a/arch/nios2/kernel/time.c
+++ b/arch/nios2/kernel/time.c
@@ -107,7 +107,10 @@ static struct nios2_clocksource nios2_cs = {
 
 cycles_t get_cycles(void)
 {
-	return nios2_timer_read(&nios2_cs.cs);
+	/* Only read timer if it has been initialized */
+	if (nios2_cs.timer.base)
+		return nios2_timer_read(&nios2_cs.cs);
+	return 0;
 }
 EXPORT_SYMBOL(get_cycles);
 
diff --git a/arch/parisc/include/asm/timex.h b/arch/parisc/include/asm/timex.h
index 2bd51f6d832b..87aeeee5b700 100644
--- a/arch/parisc/include/asm/timex.h
+++ b/arch/parisc/include/asm/timex.h
@@ -11,9 +11,10 @@
 
 typedef unsigned long cycles_t;
 
-static inline cycles_t get_cycles (void)
+static inline cycles_t get_cycles(void)
 {
 	return mfctl(16);
 }
+#define get_cycles get_cycles
 
 #endif
diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index 2e68ca1fe0db..e46bda49529c 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -504,7 +504,6 @@ alloc_pa_dev(unsigned long hpa, struct hardware_path *mod_path)
 	dev->id.hversion_rev = iodc_data[1] & 0x0f;
 	dev->id.sversion = ((iodc_data[4] & 0x0f) << 16) |
 			(iodc_data[5] << 8) | iodc_data[6];
-	dev->hpa.name = parisc_pathname(dev);
 	dev->hpa.start = hpa;
 	/* This is awkward.  The STI spec says that gfx devices may occupy
 	 * 32MB or 64MB.  Unfortunately, we don't know how to tell whether
@@ -518,10 +517,10 @@ alloc_pa_dev(unsigned long hpa, struct hardware_path *mod_path)
 		dev->hpa.end = hpa + 0xfff;
 	}
 	dev->hpa.flags = IORESOURCE_MEM;
-	name = parisc_hardware_description(&dev->id);
-	if (name) {
-		strlcpy(dev->name, name, sizeof(dev->name));
-	}
+	dev->hpa.name = dev->name;
+	name = parisc_hardware_description(&dev->id) ? : "unknown";
+	snprintf(dev->name, sizeof(dev->name), "%s [%s]",
+		name, parisc_pathname(dev));
 
 	/* Silently fail things like mouse ports which are subsumed within
 	 * the keyboard controller
diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
index 957bdeb7a5c7..b02d5c395a70 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -120,7 +120,7 @@
 #define R1(i) (((i)>>21)&0x1f)
 #define R2(i) (((i)>>16)&0x1f)
 #define R3(i) ((i)&0x1f)
-#define FR3(i) ((((i)<<1)&0x1f)|(((i)>>6)&1))
+#define FR3(i) ((((i)&0x1f)<<1)|(((i)>>6)&1))
 #define IM(i,n) (((i)>>1&((1<<(n-1))-1))|((i)&1?((0-1L)<<(n-1)):0))
 #define IM5_2(i) IM((i)>>16,5)
 #define IM5_3(i) IM((i),5)
diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 9ff848e3c4a6..d8da8c0fb928 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -5,27 +5,28 @@
 
 #include <asm/machdep.h>
 
-static inline int arch_get_random_long(unsigned long *v)
+static inline bool arch_get_random_long(unsigned long *v)
 {
-	return 0;
+	return false;
 }
 
-static inline int arch_get_random_int(unsigned int *v)
+static inline bool arch_get_random_int(unsigned int *v)
 {
-	return 0;
+	return false;
 }
 
-static inline int arch_get_random_seed_long(unsigned long *v)
+static inline bool arch_get_random_seed_long(unsigned long *v)
 {
 	if (ppc_md.get_random_seed)
 		return ppc_md.get_random_seed(v);
 
-	return 0;
+	return false;
 }
-static inline int arch_get_random_seed_int(unsigned int *v)
+
+static inline bool arch_get_random_seed_int(unsigned int *v)
 {
 	unsigned long val;
-	int rc;
+	bool rc;
 
 	rc = arch_get_random_seed_long(&val);
 	if (rc)
@@ -33,16 +34,6 @@ static inline int arch_get_random_seed_int(unsigned int *v)
 
 	return rc;
 }
-
-static inline int arch_has_random(void)
-{
-	return 0;
-}
-
-static inline int arch_has_random_seed(void)
-{
-	return !!ppc_md.get_random_seed;
-}
 #endif /* CONFIG_ARCH_RANDOM */
 
 #ifdef CONFIG_PPC_POWERNV
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index b7067590f15c..8cb3c929641a 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -134,6 +134,7 @@
 #define PPC_INST_COPY			0x7c00060c
 #define PPC_INST_COPY_FIRST		0x7c20060c
 #define PPC_INST_CP_ABORT		0x7c00068c
+#define PPC_INST_DARN			0x7c0005e6
 #define PPC_INST_DCBA			0x7c0005ec
 #define PPC_INST_DCBA_MASK		0xfc0007fe
 #define PPC_INST_DCBAL			0x7c2005ec
@@ -328,6 +329,9 @@
 
 /* Deal with instructions that older assemblers aren't aware of */
 #define	PPC_CP_ABORT		stringify_in_c(.long PPC_INST_CP_ABORT)
+#define PPC_DARN(t, l)		stringify_in_c(.long PPC_INST_DARN |  \
+						___PPC_RT(t)	   |  \
+						(((l) & 0x3) << 16))
 #define	PPC_DCBAL(a, b)		stringify_in_c(.long PPC_INST_DCBAL | \
 					__PPC_RA(a) | __PPC_RB(b))
 #define	PPC_DCBZL(a, b)		stringify_in_c(.long PPC_INST_DCBZL | \
diff --git a/arch/powerpc/include/asm/timex.h b/arch/powerpc/include/asm/timex.h
index 2cf846edb3fc..28b8a63bc366 100644
--- a/arch/powerpc/include/asm/timex.h
+++ b/arch/powerpc/include/asm/timex.h
@@ -53,6 +53,7 @@ static inline cycles_t get_cycles(void)
 	return ret;
 #endif
 }
+#define get_cycles get_cycles
 
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_TIMEX_H */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 54c95e7c74cc..a8ddf01a1f05 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1591,7 +1591,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 		tm_reclaim_current(0);
 #endif
 
-	memset(regs->gpr, 0, sizeof(regs->gpr));
+	memset(&regs->gpr[1], 0, sizeof(regs->gpr) - sizeof(regs->gpr[0]));
 	regs->ctr = 0;
 	regs->link = 0;
 	regs->xer = 0;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 11b4ecec04ee..1413d72689d2 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -682,6 +682,13 @@ void __init early_init_devtree(void *params)
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
 
+	/*
+	 * As generic code authors expect to be able to use static keys
+	 * in early_param() handlers, we initialize the static keys just
+	 * before parsing early params (it's fine to call jump_label_init()
+	 * more than once).
+	 */
+	jump_label_init();
 	parse_early_param();
 
 	/* make sure we've parsed cmdline for mem= before this */
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index da7c843ac7f1..e98e14a5db4d 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -27,4 +27,6 @@ extern void opal_event_shutdown(void);
 
 bool cpu_core_split_required(void);
 
+void pnv_rng_init(void);
+
 #endif /* _POWERNV_H */
diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
index 5dcbdea1afac..61c0eaafb27a 100644
--- a/arch/powerpc/platforms/powernv/rng.c
+++ b/arch/powerpc/platforms/powernv/rng.c
@@ -16,11 +16,14 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <asm/archrandom.h>
+#include <asm/cputable.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/smp.h>
+#include "powernv.h"
 
+#define DARN_ERR 0xFFFFFFFFFFFFFFFFul
 
 struct powernv_rng {
 	void __iomem *regs;
@@ -30,7 +33,6 @@ struct powernv_rng {
 
 static DEFINE_PER_CPU(struct powernv_rng *, powernv_rng);
 
-
 int powernv_hwrng_present(void)
 {
 	struct powernv_rng *rng;
@@ -45,7 +47,11 @@ static unsigned long rng_whiten(struct powernv_rng *rng, unsigned long val)
 	unsigned long parity;
 
 	/* Calculate the parity of the value */
-	asm ("popcntd %0,%1" : "=r" (parity) : "r" (val));
+	asm (".machine push;   \
+	      .machine power7; \
+	      popcntd %0,%1;   \
+	      .machine pop;"
+	     : "=r" (parity) : "r" (val));
 
 	/* xor our value with the previous mask */
 	val ^= rng->mask;
@@ -61,12 +67,46 @@ int powernv_get_random_real_mode(unsigned long *v)
 	struct powernv_rng *rng;
 
 	rng = raw_cpu_read(powernv_rng);
+	if (!rng)
+		return 0;
 
 	*v = rng_whiten(rng, in_rm64(rng->regs_real));
 
 	return 1;
 }
 
+static int powernv_get_random_darn(unsigned long *v)
+{
+	unsigned long val;
+
+	/* Using DARN with L=1 - 64-bit conditioned random number */
+	asm volatile(PPC_DARN(%0, 1) : "=r"(val));
+
+	if (val == DARN_ERR)
+		return 0;
+
+	*v = val;
+
+	return 1;
+}
+
+static int __init initialise_darn(void)
+{
+	unsigned long val;
+	int i;
+
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		return -ENODEV;
+
+	for (i = 0; i < 10; i++) {
+		if (powernv_get_random_darn(&val)) {
+			ppc_md.get_random_seed = powernv_get_random_darn;
+			return 0;
+		}
+	}
+	return -EIO;
+}
+
 int powernv_get_random_long(unsigned long *v)
 {
 	struct powernv_rng *rng;
@@ -88,7 +128,7 @@ static __init void rng_init_per_cpu(struct powernv_rng *rng,
 
 	chip_id = of_get_ibm_chip_id(dn);
 	if (chip_id == -1)
-		pr_warn("No ibm,chip-id found for %s.\n", dn->full_name);
+		pr_warn("No ibm,chip-id found for %pOF.\n", dn);
 
 	for_each_possible_cpu(cpu) {
 		if (per_cpu(powernv_rng, cpu) == NULL ||
@@ -126,30 +166,55 @@ static __init int rng_create(struct device_node *dn)
 
 	rng_init_per_cpu(rng, dn);
 
-	pr_info_once("Registering arch random hook.\n");
-
 	ppc_md.get_random_seed = powernv_get_random_long;
 
 	return 0;
 }
 
-static __init int rng_init(void)
+static int __init pnv_get_random_long_early(unsigned long *v)
 {
 	struct device_node *dn;
-	int rc;
+
+	if (!slab_is_available())
+		return 0;
+
+	if (cmpxchg(&ppc_md.get_random_seed, pnv_get_random_long_early,
+		    NULL) != pnv_get_random_long_early)
+		return 0;
 
 	for_each_compatible_node(dn, NULL, "ibm,power-rng") {
-		rc = rng_create(dn);
-		if (rc) {
-			pr_err("Failed creating rng for %s (%d).\n",
-				dn->full_name, rc);
+		if (rng_create(dn))
 			continue;
-		}
-
 		/* Create devices for hwrng driver */
 		of_platform_device_create(dn, NULL, NULL);
 	}
 
+	if (!ppc_md.get_random_seed)
+		return 0;
+	return ppc_md.get_random_seed(v);
+}
+
+void __init pnv_rng_init(void)
+{
+	struct device_node *dn;
+
+	/* Prefer darn over the rest. */
+	if (!initialise_darn())
+		return;
+
+	dn = of_find_compatible_node(NULL, NULL, "ibm,power-rng");
+	if (dn)
+		ppc_md.get_random_seed = pnv_get_random_long_early;
+
+	of_node_put(dn);
+}
+
+static int __init pnv_rng_late_init(void)
+{
+	unsigned long v;
+	/* In case it wasn't called during init for some other reason. */
+	if (ppc_md.get_random_seed == pnv_get_random_long_early)
+		pnv_get_random_long_early(&v);
 	return 0;
 }
-machine_subsys_initcall(powernv, rng_init);
+machine_subsys_initcall(powernv, pnv_rng_late_init);
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index b77d5eed9520..e97b714d30d7 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -168,6 +168,8 @@ static void __init pnv_setup_arch(void)
 	powersave_nap = 1;
 
 	/* XXX PMCS */
+
+	pnv_rng_init();
 }
 
 static void __init pnv_init(void)
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 62ff57cf6c24..18f797a665fd 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -81,4 +81,6 @@ unsigned long pseries_memory_block_size(void);
 
 void pseries_setup_rfi_flush(void);
 
+void pseries_rng_init(void);
+
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/rng.c b/arch/powerpc/platforms/pseries/rng.c
index 262b8c5e1b9d..2262630543e9 100644
--- a/arch/powerpc/platforms/pseries/rng.c
+++ b/arch/powerpc/platforms/pseries/rng.c
@@ -14,6 +14,7 @@
 #include <asm/archrandom.h>
 #include <asm/machdep.h>
 #include <asm/plpar_wrappers.h>
+#include "pseries.h"
 
 
 static int pseries_get_random_long(unsigned long *v)
@@ -28,19 +29,13 @@ static int pseries_get_random_long(unsigned long *v)
 	return 0;
 }
 
-static __init int rng_init(void)
+void __init pseries_rng_init(void)
 {
 	struct device_node *dn;
 
 	dn = of_find_compatible_node(NULL, NULL, "ibm,random");
 	if (!dn)
-		return -ENODEV;
-
-	pr_info("Registering arch random hook.\n");
-
+		return;
 	ppc_md.get_random_seed = pseries_get_random_long;
-
 	of_node_put(dn);
-	return 0;
 }
-machine_subsys_initcall(pseries, rng_init);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index bb7471138862..a06ea88ff757 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -585,6 +585,7 @@ static void __init pSeries_setup_arch(void)
 	}
 
 	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
+	pseries_rng_init();
 }
 
 static int __init pSeries_init_panel(void)
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index d3a597456b6e..b381813b21d6 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -524,6 +524,7 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	struct resource rsrc;
 	const int *bus_range;
 	u8 hdr_type, progif;
+	u32 class_code;
 	struct device_node *dev;
 	struct ccsr_pci __iomem *pci;
 	u16 temp;
@@ -597,6 +598,13 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
 		if (fsl_pcie_check_link(hose))
 			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+		/* Fix Class Code to PCI_CLASS_BRIDGE_PCI_NORMAL for pre-3.0 controller */
+		if (in_be32(&pci->block_rev1) < PCIE_IP_REV_3_0) {
+			early_read_config_dword(hose, 0, 0, PCIE_FSL_CSR_CLASSCODE, &class_code);
+			class_code &= 0xff;
+			class_code |= PCI_CLASS_BRIDGE_PCI_NORMAL << 8;
+			early_write_config_dword(hose, 0, 0, PCIE_FSL_CSR_CLASSCODE, class_code);
+		}
 	} else {
 		/*
 		 * Set PBFR(PCI Bus Function Register)[10] = 1 to
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index 151588530b06..caa05c4aa427 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -23,6 +23,7 @@ struct platform_device;
 
 #define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
 #define PCIE_LTSSM_L0	0x16		/* L0 state */
+#define PCIE_FSL_CSR_CLASSCODE	0x474	/* FSL GPEX CSR */
 #define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block version Rev2.2 */
 #define PCIE_IP_REV_3_0		0x02080300 /* PCIE IP block version Rev3.0 */
 #define PIWAR_EN		0x80000000	/* Enable */
diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 794bebb43d23..64448c0998eb 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -436,7 +436,7 @@ __init int hypfs_diag_init(void)
 	int rc;
 
 	if (diag204_probe()) {
-		pr_err("The hardware system does not support hypfs\n");
+		pr_info("The hardware system does not support hypfs\n");
 		return -ENODATA;
 	}
 	if (diag204_info_type == DIAG204_INFO_EXT) {
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 224aeda1e8cc..d73d2d001a62 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -493,9 +493,9 @@ static int __init hypfs_init(void)
 	hypfs_vm_exit();
 fail_hypfs_diag_exit:
 	hypfs_diag_exit();
+	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
 fail_dbfs_exit:
 	hypfs_dbfs_exit();
-	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
 	return rc;
 }
 
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index f1330245b584..f9c222cfc65c 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -168,6 +168,7 @@ static inline cycles_t get_cycles(void)
 {
 	return (cycles_t) get_tod_clock() >> 2;
 }
+#define get_cycles get_cycles
 
 int get_phys_clock(unsigned long long *clock);
 void init_cpu_timer(void);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index ba2f21873cbd..6fa4220e34b5 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -409,7 +409,9 @@ static inline int do_exception(struct pt_regs *regs, int access)
 	flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
-	if (access == VM_WRITE || (trans_exc_code & store_indication) == 0x400)
+	if ((trans_exc_code & store_indication) == 0x400)
+		access = VM_WRITE;
+	if (access == VM_WRITE)
 		flags |= FAULT_FLAG_WRITE;
 	down_read(&mm->mmap_sem);
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 7678f7956409..1847bc3ff163 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -595,7 +595,7 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 			      PGSTE_GR_BIT | PGSTE_GC_BIT);
 	ptev = pte_val(*ptep);
 	if (!(ptev & _PAGE_INVALID) && (ptev & _PAGE_WRITE))
-		page_set_storage_key(ptev & PAGE_MASK, PAGE_DEFAULT_KEY, 1);
+		page_set_storage_key(ptev & PAGE_MASK, PAGE_DEFAULT_KEY, 0);
 	pgste_set_unlock(ptep, pgste);
 	preempt_enable();
 }
diff --git a/arch/sparc/include/asm/timex_32.h b/arch/sparc/include/asm/timex_32.h
index b6ccdb0d6f7d..b805c511755d 100644
--- a/arch/sparc/include/asm/timex_32.h
+++ b/arch/sparc/include/asm/timex_32.h
@@ -8,8 +8,6 @@
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
 
-/* XXX Maybe do something better at some point... -DaveM */
-typedef unsigned long cycles_t;
-#define get_cycles()	(0)
+#include <asm-generic/timex.h>
 
 #endif
diff --git a/arch/um/include/asm/timex.h b/arch/um/include/asm/timex.h
index 0f4ada08f748..62a0fbf79420 100644
--- a/arch/um/include/asm/timex.h
+++ b/arch/um/include/asm/timex.h
@@ -1,13 +1,8 @@
 #ifndef __UM_TIMEX_H
 #define __UM_TIMEX_H
 
-typedef unsigned long cycles_t;
-
-static inline cycles_t get_cycles (void)
-{
-	return 0;
-}
-
 #define CLOCK_TICK_RATE (HZ)
 
+#include <asm-generic/timex.h>
+
 #endif
diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 3ac991d81e74..4d3cac3c9b25 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -86,10 +86,6 @@ static inline bool rdseed_int(unsigned int *v)
 	return ok;
 }
 
-/* Conditional execution based on CPU type */
-#define arch_has_random()	static_cpu_has(X86_FEATURE_RDRAND)
-#define arch_has_random_seed()	static_cpu_has(X86_FEATURE_RDSEED)
-
 /*
  * These are the generic interfaces; they must not be declared if the
  * stubs in <linux/random.h> are to be invoked,
@@ -99,22 +95,22 @@ static inline bool rdseed_int(unsigned int *v)
 
 static inline bool arch_get_random_long(unsigned long *v)
 {
-	return arch_has_random() ? rdrand_long(v) : false;
+	return static_cpu_has(X86_FEATURE_RDRAND) ? rdrand_long(v) : false;
 }
 
 static inline bool arch_get_random_int(unsigned int *v)
 {
-	return arch_has_random() ? rdrand_int(v) : false;
+	return static_cpu_has(X86_FEATURE_RDRAND) ? rdrand_int(v) : false;
 }
 
 static inline bool arch_get_random_seed_long(unsigned long *v)
 {
-	return arch_has_random_seed() ? rdseed_long(v) : false;
+	return static_cpu_has(X86_FEATURE_RDSEED) ? rdseed_long(v) : false;
 }
 
 static inline bool arch_get_random_seed_int(unsigned int *v)
 {
-	return arch_has_random_seed() ? rdseed_int(v) : false;
+	return static_cpu_has(X86_FEATURE_RDSEED) ? rdseed_int(v) : false;
 }
 
 extern void x86_init_rdrand(struct cpuinfo_x86 *c);
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 910304aec2e6..a033fa5c596d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -363,5 +363,6 @@
 #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* CPU may incur MCE during certain page attribute changes */
 #define X86_BUG_SRBDS			X86_BUG(24) /* CPU may leak RNG bits if not mitigated */
 #define X86_BUG_MMIO_STALE_DATA		X86_BUG(25) /* CPU is affected by Processor MMIO Stale Data vulnerabilities */
+#define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* CPU is too old and its MMIO Stale Data status is unknown */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 8b6c01774ca2..aadb91d43eef 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -70,6 +70,9 @@
 #define INTEL_FAM6_ALDERLAKE		0x97
 #define INTEL_FAM6_ALDERLAKE_L		0x9A
 
+#define INTEL_FAM6_TIGERLAKE_L		0x8C
+#define INTEL_FAM6_TIGERLAKE		0x8D
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 1624a7ffa95d..3f1f58c1a9ce 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -20,6 +20,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/string.h>
+#include <linux/module.h>
 
 #include <asm/page.h>
 #include <asm/ptrace.h>
@@ -206,6 +207,12 @@ struct kexec_entry64_regs {
 	uint64_t r15;
 	uint64_t rip;
 };
+
+#ifdef CONFIG_KEXEC_FILE
+int arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
+				     Elf_Shdr *sechdrs, unsigned int relsec);
+#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
+#endif
 #endif
 
 typedef void crash_vmclear_fn(void);
diff --git a/arch/x86/include/asm/timex.h b/arch/x86/include/asm/timex.h
index 1375cfc93960..627802b6204c 100644
--- a/arch/x86/include/asm/timex.h
+++ b/arch/x86/include/asm/timex.h
@@ -4,6 +4,15 @@
 #include <asm/processor.h>
 #include <asm/tsc.h>
 
+static inline unsigned long random_get_entropy(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_TSC) &&
+	    !cpu_feature_enabled(X86_FEATURE_TSC))
+		return random_get_entropy_fallback();
+	return rdtsc();
+}
+#define random_get_entropy random_get_entropy
+
 /* Assume we use the PIT time source for the clock tick */
 #define CLOCK_TICK_RATE		PIT_TICK_RATE
 
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 33b6365c22fe..23235c5ef1a1 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -21,13 +21,12 @@ extern void disable_TSC(void);
 
 static inline cycles_t get_cycles(void)
 {
-#ifndef CONFIG_X86_TSC
-	if (!boot_cpu_has(X86_FEATURE_TSC))
+	if (!IS_ENABLED(CONFIG_X86_TSC) &&
+	    !cpu_feature_enabled(X86_FEATURE_TSC))
 		return 0;
-#endif
-
 	return rdtsc();
 }
+#define get_cycles get_cycles
 
 extern struct system_counterval_t convert_art_to_tsc(cycle_t art);
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b4416df41d63..d8ba0b60e088 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -395,7 +395,8 @@ static void __init mmio_select_mitigation(void)
 	u64 ia32_cap;
 
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
-	    cpu_mitigations_off()) {
+	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
+	     cpu_mitigations_off()) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
 		return;
 	}
@@ -500,6 +501,8 @@ static void __init md_clear_update_mitigation(void)
 		pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
 	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
+	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
+		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
 }
 
 static void __init md_clear_select_mitigation(void)
@@ -1824,6 +1827,9 @@ static ssize_t tsx_async_abort_show_state(char *buf)
 
 static ssize_t mmio_stale_data_show_state(char *buf)
 {
+	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
+		return sysfs_emit(buf, "Unknown: No mitigations\n");
+
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return sysfs_emit(buf, "%s\n", mmio_strings[mmio_mitigation]);
 
@@ -1934,6 +1940,7 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		return srbds_show_state(buf);
 
 	case X86_BUG_MMIO_STALE_DATA:
+	case X86_BUG_MMIO_UNKNOWN:
 		return mmio_stale_data_show_state(buf);
 
 	default:
@@ -1990,6 +1997,9 @@ ssize_t cpu_show_srbds(struct device *dev, struct device_attribute *attr, char *
 
 ssize_t cpu_show_mmio_stale_data(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return cpu_show_common(dev, attr, buf, X86_BUG_MMIO_STALE_DATA);
+	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
+		return cpu_show_common(dev, attr, buf, X86_BUG_MMIO_UNKNOWN);
+	else
+		return cpu_show_common(dev, attr, buf, X86_BUG_MMIO_STALE_DATA);
 }
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 48843fc76695..656f336074a3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -899,6 +899,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 #define MSBDS_ONLY		BIT(5)
 #define NO_SWAPGS		BIT(6)
 #define NO_ITLB_MULTIHIT	BIT(7)
+#define NO_MMIO			BIT(8)
 
 #define VULNWL(_vendor, _family, _model, _whitelist)	\
 	{ X86_VENDOR_##_vendor, _family, _model, X86_FEATURE_ANY, _whitelist }
@@ -916,6 +917,11 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL(NSC,	5, X86_MODEL_ANY,	NO_SPECULATION),
 
 	/* Intel Family 6 */
+	VULNWL_INTEL(TIGERLAKE,			NO_MMIO),
+	VULNWL_INTEL(TIGERLAKE_L,		NO_MMIO),
+	VULNWL_INTEL(ALDERLAKE,			NO_MMIO),
+	VULNWL_INTEL(ALDERLAKE_L,		NO_MMIO),
+
 	VULNWL_INTEL(ATOM_SALTWELL,		NO_SPECULATION | NO_ITLB_MULTIHIT),
 	VULNWL_INTEL(ATOM_SALTWELL_TABLET,	NO_SPECULATION | NO_ITLB_MULTIHIT),
 	VULNWL_INTEL(ATOM_SALTWELL_MID,		NO_SPECULATION | NO_ITLB_MULTIHIT),
@@ -933,9 +939,9 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 
 	VULNWL_INTEL(ATOM_AIRMONT_MID,		NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
 
-	VULNWL_INTEL(ATOM_GOLDMONT,		NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(ATOM_GOLDMONT_X,		NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(ATOM_GOLDMONT_PLUS,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_GOLDMONT,		NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_INTEL(ATOM_GOLDMONT_X,		NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_INTEL(ATOM_GOLDMONT_PLUS,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
 
 	/*
 	 * Technically, swapgs isn't serializing on AMD (despite it previously
@@ -946,13 +952,13 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	 */
 
 	/* AMD Family 0xf - 0x12 */
-	VULNWL_AMD(0x0f,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_AMD(0x10,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_AMD(0x11,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_AMD(0x12,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_AMD(0x0f,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_AMD(0x10,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_AMD(0x11,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_AMD(0x12,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
 
 	/* FAMILY_ANY must be last, otherwise 0x0f - 0x12 matches won't work */
-	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
 	{}
 };
 
@@ -1092,10 +1098,16 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * Affected CPU list is generally enough to enumerate the vulnerability,
 	 * but for virtualization case check for ARCH_CAP MSR bits also, VMM may
 	 * not want the guest to enumerate the bug.
+	 *
+	 * Set X86_BUG_MMIO_UNKNOWN for CPUs that are neither in the blacklist,
+	 * nor in the whitelist and also don't enumerate MSR ARCH_CAP MMIO bits.
 	 */
-	if (cpu_matches(cpu_vuln_blacklist, MMIO) &&
-	    !arch_cap_mmio_immune(ia32_cap))
-		setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
+	if (!arch_cap_mmio_immune(ia32_cap)) {
+		if (cpu_matches(cpu_vuln_blacklist, MMIO))
+			setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
+		else if (!cpu_matches(cpu_vuln_whitelist, NO_MMIO))
+			setup_force_cpu_bug(X86_BUG_MMIO_UNKNOWN);
+	}
 
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index b5785c197e53..2b2060d842d1 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -106,6 +106,8 @@ static void __init clear_bss(void)
 {
 	memset(__bss_start, 0,
 	       (unsigned long) __bss_stop - (unsigned long) __bss_start);
+	memset(__brk_base, 0,
+	       (unsigned long) __brk_limit - (unsigned long) __brk_base);
 }
 
 static unsigned long get_cmd_line_ptr(void)
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 3edafdffa687..2a5a18ca8837 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1713,16 +1713,6 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 	case VCPU_SREG_TR:
 		if (seg_desc.s || (seg_desc.type != 1 && seg_desc.type != 9))
 			goto exception;
-		if (!seg_desc.p) {
-			err_vec = NP_VECTOR;
-			goto exception;
-		}
-		old_desc = seg_desc;
-		seg_desc.type |= 2; /* busy */
-		ret = ctxt->ops->cmpxchg_emulated(ctxt, desc_addr, &old_desc, &seg_desc,
-						  sizeof(seg_desc), &ctxt->exception);
-		if (ret != X86EMUL_CONTINUE)
-			return ret;
 		break;
 	case VCPU_SREG_LDTR:
 		if (seg_desc.s || seg_desc.type != 2)
@@ -1763,6 +1753,15 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 					     ((u64)base3 << 32)))
 			return emulate_gp(ctxt, 0);
 	}
+
+	if (seg == VCPU_SREG_TR) {
+		old_desc = seg_desc;
+		seg_desc.type |= 2; /* busy */
+		ret = ctxt->ops->cmpxchg_emulated(ctxt, desc_addr, &old_desc, &seg_desc,
+						  sizeof(seg_desc), &ctxt->exception);
+		if (ret != X86EMUL_CONTINUE)
+			return ret;
+	}
 load:
 	ctxt->ops->set_segment(ctxt, selector, &seg_desc, base3, seg);
 	if (desc)
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 03fdeab057d2..c8e18144ecf2 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4492,8 +4492,6 @@ static void svm_set_irq(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	BUG_ON(!(gif_set(svm)));
-
 	trace_kvm_inj_virq(vcpu->arch.interrupt.nr);
 	++vcpu->stat.irq_injections;
 
diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index 7fa8b3b53bc0..193860d7f2c4 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -85,7 +85,7 @@ static void send_ebook_state(void)
 		return;
 	}
 
-	if (!!test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == state)
+	if (test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == !!state)
 		return; /* Nothing new to report. */
 
 	input_report_switch(ebook_switch_idev, SW_TABLET_MODE, state);
diff --git a/arch/xtensa/include/asm/timex.h b/arch/xtensa/include/asm/timex.h
index f9b389d4e973..d866bc847d8d 100644
--- a/arch/xtensa/include/asm/timex.h
+++ b/arch/xtensa/include/asm/timex.h
@@ -30,10 +30,6 @@
 
 extern unsigned long ccount_freq;
 
-typedef unsigned long long cycles_t;
-
-#define get_cycles()	(0)
-
 void local_timer_setup(unsigned cpu);
 
 /*
@@ -69,4 +65,6 @@ static inline void set_linux_timer (unsigned long ccompare)
 	WSR_CCOMPARE(LINUX_TIMER, ccompare);
 }
 
+#include <asm-generic/timex.h>
+
 #endif	/* _XTENSA_TIMEX_H */
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 2251a6e0973a..d4b4386df568 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -146,6 +146,7 @@ static void __init calibrate_ccount(void)
 	cpu = of_find_compatible_node(NULL, NULL, "cdns,xtensa-cpu");
 	if (cpu) {
 		clk = of_clk_get(cpu, 0);
+		of_node_put(cpu);
 		if (!IS_ERR(clk)) {
 			ccount_freq = clk_get_rate(clk);
 			return;
diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/xtfpga/setup.c
index db5122765f16..ce00dc2b3a1e 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -152,6 +152,7 @@ static int __init machine_setup(void)
 
 	if ((eth = of_find_compatible_node(eth, NULL, "opencores,ethoc")))
 		update_local_mac(eth);
+	of_node_put(eth);
 	return 0;
 }
 arch_initcall(machine_setup);
diff --git a/crypto/chacha20_generic.c b/crypto/chacha20_generic.c
index 1cab83146e33..56603afbf6bd 100644
--- a/crypto/chacha20_generic.c
+++ b/crypto/chacha20_generic.c
@@ -23,7 +23,8 @@ static inline u32 le32_to_cpuvp(const void *p)
 static void chacha20_docrypt(u32 *state, u8 *dst, const u8 *src,
 			     unsigned int bytes)
 {
-	u8 stream[CHACHA20_BLOCK_SIZE];
+	/* aligned to potentially speed up crypto_xor() */
+	u8 stream[CHACHA20_BLOCK_SIZE] __aligned(sizeof(long));
 
 	if (dst != src)
 		memcpy(dst, src, bytes);
diff --git a/crypto/drbg.c b/crypto/drbg.c
index 4bb5f93c94cd..1b94a4306dfc 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -219,6 +219,57 @@ static inline unsigned short drbg_sec_strength(drbg_flag_t flags)
 	}
 }
 
+/*
+ * FIPS 140-2 continuous self test for the noise source
+ * The test is performed on the noise source input data. Thus, the function
+ * implicitly knows the size of the buffer to be equal to the security
+ * strength.
+ *
+ * Note, this function disregards the nonce trailing the entropy data during
+ * initial seeding.
+ *
+ * drbg->drbg_mutex must have been taken.
+ *
+ * @drbg DRBG handle
+ * @entropy buffer of seed data to be checked
+ *
+ * return:
+ *	0 on success
+ *	-EAGAIN on when the CTRNG is not yet primed
+ *	< 0 on error
+ */
+static int drbg_fips_continuous_test(struct drbg_state *drbg,
+				     const unsigned char *entropy)
+{
+	unsigned short entropylen = drbg_sec_strength(drbg->core->flags);
+	int ret = 0;
+
+	if (!IS_ENABLED(CONFIG_CRYPTO_FIPS))
+		return 0;
+
+	/* skip test if we test the overall system */
+	if (list_empty(&drbg->test_data.list))
+		return 0;
+	/* only perform test in FIPS mode */
+	if (!fips_enabled)
+		return 0;
+
+	if (!drbg->fips_primed) {
+		/* Priming of FIPS test */
+		memcpy(drbg->prev, entropy, entropylen);
+		drbg->fips_primed = true;
+		/* priming: another round is needed */
+		return -EAGAIN;
+	}
+	ret = memcmp(drbg->prev, entropy, entropylen);
+	if (!ret)
+		panic("DRBG continuous self test failed\n");
+	memcpy(drbg->prev, entropy, entropylen);
+
+	/* the test shall pass when the two values are not equal */
+	return 0;
+}
+
 /*
  * Convert an integer into a byte representation of this integer.
  * The byte representation is big-endian
@@ -986,55 +1037,79 @@ static const struct drbg_state_ops drbg_hash_ops = {
  ******************************************************************/
 
 static inline int __drbg_seed(struct drbg_state *drbg, struct list_head *seed,
-			      int reseed)
+			      int reseed, enum drbg_seed_state new_seed_state)
 {
 	int ret = drbg->d_ops->update(drbg, seed, reseed);
 
 	if (ret)
 		return ret;
 
-	drbg->seeded = true;
+	drbg->seeded = new_seed_state;
 	/* 10.1.1.2 / 10.1.1.3 step 5 */
 	drbg->reseed_ctr = 1;
 
+	switch (drbg->seeded) {
+	case DRBG_SEED_STATE_UNSEEDED:
+		/* Impossible, but handle it to silence compiler warnings. */
+	case DRBG_SEED_STATE_PARTIAL:
+		/*
+		 * Require frequent reseeds until the seed source is
+		 * fully initialized.
+		 */
+		drbg->reseed_threshold = 50;
+		break;
+
+	case DRBG_SEED_STATE_FULL:
+		/*
+		 * Seed source has become fully initialized, frequent
+		 * reseeds no longer required.
+		 */
+		drbg->reseed_threshold = drbg_max_requests(drbg);
+		break;
+	}
+
 	return ret;
 }
 
-static void drbg_async_seed(struct work_struct *work)
+static inline int drbg_get_random_bytes(struct drbg_state *drbg,
+					unsigned char *entropy,
+					unsigned int entropylen)
+{
+	int ret;
+
+	do {
+		get_random_bytes(entropy, entropylen);
+		ret = drbg_fips_continuous_test(drbg, entropy);
+		if (ret && ret != -EAGAIN)
+			return ret;
+	} while (ret);
+
+	return 0;
+}
+
+static int drbg_seed_from_random(struct drbg_state *drbg)
 {
 	struct drbg_string data;
 	LIST_HEAD(seedlist);
-	struct drbg_state *drbg = container_of(work, struct drbg_state,
-					       seed_work);
 	unsigned int entropylen = drbg_sec_strength(drbg->core->flags);
 	unsigned char entropy[32];
+	int ret;
 
 	BUG_ON(!entropylen);
 	BUG_ON(entropylen > sizeof(entropy));
-	get_random_bytes(entropy, entropylen);
 
 	drbg_string_fill(&data, entropy, entropylen);
 	list_add_tail(&data.list, &seedlist);
 
-	mutex_lock(&drbg->drbg_mutex);
-
-	/* If nonblocking pool is initialized, deactivate Jitter RNG */
-	crypto_free_rng(drbg->jent);
-	drbg->jent = NULL;
-
-	/* Set seeded to false so that if __drbg_seed fails the
-	 * next generate call will trigger a reseed.
-	 */
-	drbg->seeded = false;
-
-	__drbg_seed(drbg, &seedlist, true);
-
-	if (drbg->seeded)
-		drbg->reseed_threshold = drbg_max_requests(drbg);
+	ret = drbg_get_random_bytes(drbg, entropy, entropylen);
+	if (ret)
+		goto out;
 
-	mutex_unlock(&drbg->drbg_mutex);
+	ret = __drbg_seed(drbg, &seedlist, true, DRBG_SEED_STATE_FULL);
 
+out:
 	memzero_explicit(entropy, entropylen);
+	return ret;
 }
 
 /*
@@ -1056,6 +1131,7 @@ static int drbg_seed(struct drbg_state *drbg, struct drbg_string *pers,
 	unsigned int entropylen = drbg_sec_strength(drbg->core->flags);
 	struct drbg_string data1;
 	LIST_HEAD(seedlist);
+	enum drbg_seed_state new_seed_state = DRBG_SEED_STATE_FULL;
 
 	/* 9.1 / 9.2 / 9.3.1 step 3 */
 	if (pers && pers->len > (drbg_max_addtl(drbg))) {
@@ -1083,7 +1159,12 @@ static int drbg_seed(struct drbg_state *drbg, struct drbg_string *pers,
 		BUG_ON((entropylen * 2) > sizeof(entropy));
 
 		/* Get seed from in-kernel /dev/urandom */
-		get_random_bytes(entropy, entropylen);
+		if (!rng_is_initialized())
+			new_seed_state = DRBG_SEED_STATE_PARTIAL;
+
+		ret = drbg_get_random_bytes(drbg, entropy, entropylen);
+		if (ret)
+			goto out;
 
 		if (!drbg->jent) {
 			drbg_string_fill(&data1, entropy, entropylen);
@@ -1096,7 +1177,23 @@ static int drbg_seed(struct drbg_state *drbg, struct drbg_string *pers,
 						   entropylen);
 			if (ret) {
 				pr_devel("DRBG: jent failed with %d\n", ret);
-				return ret;
+
+				/*
+				 * Do not treat the transient failure of the
+				 * Jitter RNG as an error that needs to be
+				 * reported. The combined number of the
+				 * maximum reseed threshold times the maximum
+				 * number of Jitter RNG transient errors is
+				 * less than the reseed threshold required by
+				 * SP800-90A allowing us to treat the
+				 * transient errors as such.
+				 *
+				 * However, we mandate that at least the first
+				 * seeding operation must succeed with the
+				 * Jitter RNG.
+				 */
+				if (!reseed || ret != -EAGAIN)
+					goto out;
 			}
 
 			drbg_string_fill(&data1, entropy, entropylen * 2);
@@ -1121,8 +1218,9 @@ static int drbg_seed(struct drbg_state *drbg, struct drbg_string *pers,
 		memset(drbg->C, 0, drbg_statelen(drbg));
 	}
 
-	ret = __drbg_seed(drbg, &seedlist, reseed);
+	ret = __drbg_seed(drbg, &seedlist, reseed, new_seed_state);
 
+out:
 	memzero_explicit(entropy, entropylen * 2);
 
 	return ret;
@@ -1144,6 +1242,11 @@ static inline void drbg_dealloc_state(struct drbg_state *drbg)
 	drbg->reseed_ctr = 0;
 	drbg->d_ops = NULL;
 	drbg->core = NULL;
+	if (IS_ENABLED(CONFIG_CRYPTO_FIPS)) {
+		kzfree(drbg->prev);
+		drbg->prev = NULL;
+		drbg->fips_primed = false;
+	}
 }
 
 /*
@@ -1213,6 +1316,14 @@ static inline int drbg_alloc_state(struct drbg_state *drbg)
 		drbg->scratchpad = PTR_ALIGN(drbg->scratchpadbuf, ret + 1);
 	}
 
+	if (IS_ENABLED(CONFIG_CRYPTO_FIPS)) {
+		drbg->prev = kzalloc(drbg_sec_strength(drbg->core->flags),
+				     GFP_KERNEL);
+		if (!drbg->prev)
+			goto fini;
+		drbg->fips_primed = false;
+	}
+
 	return 0;
 
 fini:
@@ -1285,19 +1396,25 @@ static int drbg_generate(struct drbg_state *drbg,
 	 * here. The spec is a bit convoluted here, we make it simpler.
 	 */
 	if (drbg->reseed_threshold < drbg->reseed_ctr)
-		drbg->seeded = false;
+		drbg->seeded = DRBG_SEED_STATE_UNSEEDED;
 
-	if (drbg->pr || !drbg->seeded) {
+	if (drbg->pr || drbg->seeded == DRBG_SEED_STATE_UNSEEDED) {
 		pr_devel("DRBG: reseeding before generation (prediction "
 			 "resistance: %s, state %s)\n",
 			 drbg->pr ? "true" : "false",
-			 drbg->seeded ? "seeded" : "unseeded");
+			 (drbg->seeded ==  DRBG_SEED_STATE_FULL ?
+			  "seeded" : "unseeded"));
 		/* 9.3.1 steps 7.1 through 7.3 */
 		len = drbg_seed(drbg, addtl, true);
 		if (len)
 			goto err;
 		/* 9.3.1 step 7.4 */
 		addtl = NULL;
+	} else if (rng_is_initialized() &&
+		   drbg->seeded == DRBG_SEED_STATE_PARTIAL) {
+		len = drbg_seed_from_random(drbg);
+		if (len)
+			goto err;
 	}
 
 	if (addtl && 0 < addtl->len)
@@ -1390,51 +1507,15 @@ static int drbg_generate_long(struct drbg_state *drbg,
 	return 0;
 }
 
-static void drbg_schedule_async_seed(struct random_ready_callback *rdy)
-{
-	struct drbg_state *drbg = container_of(rdy, struct drbg_state,
-					       random_ready);
-
-	schedule_work(&drbg->seed_work);
-}
-
 static int drbg_prepare_hrng(struct drbg_state *drbg)
 {
-	int err;
-
 	/* We do not need an HRNG in test mode. */
 	if (list_empty(&drbg->test_data.list))
 		return 0;
 
-	INIT_WORK(&drbg->seed_work, drbg_async_seed);
-
-	drbg->random_ready.owner = THIS_MODULE;
-	drbg->random_ready.func = drbg_schedule_async_seed;
-
-	err = add_random_ready_callback(&drbg->random_ready);
-
-	switch (err) {
-	case 0:
-		break;
-
-	case -EALREADY:
-		err = 0;
-		/* fall through */
-
-	default:
-		drbg->random_ready.func = NULL;
-		return err;
-	}
-
 	drbg->jent = crypto_alloc_rng("jitterentropy_rng", 0, 0);
 
-	/*
-	 * Require frequent reseeds until the seed source is fully
-	 * initialized.
-	 */
-	drbg->reseed_threshold = 50;
-
-	return err;
+	return 0;
 }
 
 /*
@@ -1477,7 +1558,7 @@ static int drbg_instantiate(struct drbg_state *drbg, struct drbg_string *pers,
 	if (!drbg->core) {
 		drbg->core = &drbg_cores[coreref];
 		drbg->pr = pr;
-		drbg->seeded = false;
+		drbg->seeded = DRBG_SEED_STATE_UNSEEDED;
 		drbg->reseed_threshold = drbg_max_requests(drbg);
 
 		ret = drbg_alloc_state(drbg);
@@ -1528,12 +1609,9 @@ static int drbg_instantiate(struct drbg_state *drbg, struct drbg_string *pers,
  */
 static int drbg_uninstantiate(struct drbg_state *drbg)
 {
-	if (drbg->random_ready.func) {
-		del_random_ready_callback(&drbg->random_ready);
-		cancel_work_sync(&drbg->seed_work);
+	if (!IS_ERR_OR_NULL(drbg->jent))
 		crypto_free_rng(drbg->jent);
-		drbg->jent = NULL;
-	}
+	drbg->jent = NULL;
 
 	if (drbg->d_ops)
 		drbg->d_ops->crypto_fini(drbg);
diff --git a/crypto/md4.c b/crypto/md4.c
index 3515af425cc9..810fefb0a007 100644
--- a/crypto/md4.c
+++ b/crypto/md4.c
@@ -64,23 +64,6 @@ static inline u32 H(u32 x, u32 y, u32 z)
 #define ROUND2(a,b,c,d,k,s) (a = lshift(a + G(b,c,d) + k + (u32)0x5A827999,s))
 #define ROUND3(a,b,c,d,k,s) (a = lshift(a + H(b,c,d) + k + (u32)0x6ED9EBA1,s))
 
-/* XXX: this stuff can be optimized */
-static inline void le32_to_cpu_array(u32 *buf, unsigned int words)
-{
-	while (words--) {
-		__le32_to_cpus(buf);
-		buf++;
-	}
-}
-
-static inline void cpu_to_le32_array(u32 *buf, unsigned int words)
-{
-	while (words--) {
-		__cpu_to_le32s(buf);
-		buf++;
-	}
-}
-
 static void md4_transform(u32 *hash, u32 const *in)
 {
 	u32 a, b, c, d;
diff --git a/crypto/md5.c b/crypto/md5.c
index 2355a7c25c45..419f2379b406 100644
--- a/crypto/md5.c
+++ b/crypto/md5.c
@@ -30,23 +30,6 @@ const u8 md5_zero_message_hash[MD5_DIGEST_SIZE] = {
 };
 EXPORT_SYMBOL_GPL(md5_zero_message_hash);
 
-/* XXX: this stuff can be optimized */
-static inline void le32_to_cpu_array(u32 *buf, unsigned int words)
-{
-	while (words--) {
-		__le32_to_cpus(buf);
-		buf++;
-	}
-}
-
-static inline void cpu_to_le32_array(u32 *buf, unsigned int words)
-{
-	while (words--) {
-		__cpu_to_le32s(buf);
-		buf++;
-	}
-}
-
 static inline void md5_transform_helper(struct md5_state *ctx)
 {
 	le32_to_cpu_array(ctx->block, sizeof(ctx->block) / sizeof(u32));
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 2837b2f98213..10ce6533874f 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -150,7 +150,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	.callback = video_detect_force_native,
 	.ident = "Clevo NL5xRU",
 	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
 		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
 		},
 	},
@@ -158,59 +157,75 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	.callback = video_detect_force_native,
 	.ident = "Clevo NL5xRU",
 	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
-		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
 		},
 	},
 	{
 	.callback = video_detect_force_native,
 	.ident = "Clevo NL5xRU",
 	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
-		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
 		},
 	},
 	{
 	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xRU",
+	.ident = "Clevo NL5xNU",
 	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
-		DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
 		},
 	},
+	/*
+	 * The TongFang PF5PU1G, PF4NU1F, PF5NU1G, and PF5LUXG/TUXEDO BA15 Gen10,
+	 * Pulse 14/15 Gen1, and Pulse 15 Gen2 have the same problem as the Clevo
+	 * NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2. See the description
+	 * above.
+	 */
 	{
 	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xRU",
+	.ident = "TongFang PF5PU1G",
 	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
-		DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
+		DMI_MATCH(DMI_BOARD_NAME, "PF5PU1G"),
 		},
 	},
 	{
 	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xNU",
+	.ident = "TongFang PF4NU1F",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_NAME, "PF4NU1F"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "TongFang PF4NU1F",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
-		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		DMI_MATCH(DMI_BOARD_NAME, "PULSE1401"),
 		},
 	},
 	{
 	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xNU",
+	.ident = "TongFang PF5NU1G",
 	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
-		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		DMI_MATCH(DMI_BOARD_NAME, "PF5NU1G"),
 		},
 	},
 	{
 	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xNU",
+	.ident = "TongFang PF5NU1G",
 	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
-		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		DMI_MATCH(DMI_BOARD_NAME, "PULSE1501"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "TongFang PF5LUXG",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_NAME, "PF5LUXG"),
 		},
 	},
-
 	/*
 	 * These models have a working acpi_video backlight control, and using
 	 * native backlight causes a regression where backlight does not work
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 35db918a1de5..42f0a592b5ab 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6051,7 +6051,7 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 				      const struct ata_port_info * const * ppi,
 				      int n_ports)
 {
-	const struct ata_port_info *pi;
+	const struct ata_port_info *pi = &ata_dummy_port_info;
 	struct ata_host *host;
 	int i, j;
 
@@ -6059,7 +6059,7 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 	if (!host)
 		return NULL;
 
-	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
+	for (i = 0, j = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
 		if (ppi[j])
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 07f96a032149..d1422aec9913 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2439,6 +2439,7 @@ const char *ata_get_cmd_descript(u8 command)
 		{ ATA_CMD_WRITE_QUEUED_FUA_EXT, "WRITE DMA QUEUED FUA EXT" },
 		{ ATA_CMD_FPDMA_READ,		"READ FPDMA QUEUED" },
 		{ ATA_CMD_FPDMA_WRITE,		"WRITE FPDMA QUEUED" },
+		{ ATA_CMD_NCQ_NON_DATA,		"NCQ NON-DATA" },
 		{ ATA_CMD_FPDMA_SEND,		"SEND FPDMA QUEUED" },
 		{ ATA_CMD_FPDMA_RECV,		"RECEIVE FPDMA QUEUED" },
 		{ ATA_CMD_PIO_READ,		"READ SECTOR(S)" },
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 89adb49e435e..bcc42134aa9b 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -3777,6 +3777,7 @@ static void __exit idt77252_exit(void)
 		card = idt77252_chain;
 		dev = card->atmdev;
 		idt77252_chain = card->next;
+		del_timer_sync(&card->tst_timer);
 
 		if (dev->phy->stop)
 			dev->phy->stop(dev);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2ff17b397cd2..a23c903753b5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1202,6 +1202,11 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	info->lo_rdevice = huge_encode_dev(lo->lo_device ? stat.rdev : stat.dev);
 	info->lo_offset = lo->lo_offset;
 	info->lo_sizelimit = lo->lo_sizelimit;
+
+	/* loff_t vars have been assigned __u64 */
+	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0)
+		return -EOVERFLOW;
+
 	info->lo_flags = lo->lo_flags;
 	memcpy(info->lo_file_name, lo->lo_file_name, LO_NAME_SIZE);
 	memcpy(info->lo_crypt_name, lo->lo_crypt_name, LO_NAME_SIZE);
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 17ea0ba50278..9c907c1a4a1c 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -144,6 +144,10 @@ static unsigned int xen_blkif_max_ring_order;
 module_param_named(max_ring_page_order, xen_blkif_max_ring_order, int, S_IRUGO);
 MODULE_PARM_DESC(max_ring_page_order, "Maximum order of pages to be used for the shared ring");
 
+static bool __read_mostly xen_blkif_trusted = true;
+module_param_named(trusted, xen_blkif_trusted, bool, 0644);
+MODULE_PARM_DESC(trusted, "Is the backend trusted");
+
 #define BLK_RING_SIZE(info)	\
 	__CONST_RING_SIZE(blkif, XEN_PAGE_SIZE * (info)->nr_ring_pages)
 
@@ -206,6 +210,7 @@ struct blkfront_info
 	unsigned int discard_granularity;
 	unsigned int discard_alignment;
 	unsigned int feature_persistent:1;
+	unsigned int bounce:1;
 	/* Number of 4KB segments handled */
 	unsigned int max_indirect_segments;
 	int is_ready;
@@ -296,8 +301,8 @@ static int fill_grant_buffer(struct blkfront_ring_info *rinfo, int num)
 		if (!gnt_list_entry)
 			goto out_of_memory;
 
-		if (info->feature_persistent) {
-			granted_page = alloc_page(GFP_NOIO);
+		if (info->bounce) {
+			granted_page = alloc_page(GFP_NOIO | __GFP_ZERO);
 			if (!granted_page) {
 				kfree(gnt_list_entry);
 				goto out_of_memory;
@@ -316,7 +321,7 @@ static int fill_grant_buffer(struct blkfront_ring_info *rinfo, int num)
 	list_for_each_entry_safe(gnt_list_entry, n,
 	                         &rinfo->grants, node) {
 		list_del(&gnt_list_entry->node);
-		if (info->feature_persistent)
+		if (info->bounce)
 			__free_page(gnt_list_entry->page);
 		kfree(gnt_list_entry);
 		i--;
@@ -362,7 +367,7 @@ static struct grant *get_grant(grant_ref_t *gref_head,
 	/* Assign a gref to this page */
 	gnt_list_entry->gref = gnttab_claim_grant_reference(gref_head);
 	BUG_ON(gnt_list_entry->gref == -ENOSPC);
-	if (info->feature_persistent)
+	if (info->bounce)
 		grant_foreign_access(gnt_list_entry, info);
 	else {
 		/* Grant access to the GFN passed by the caller */
@@ -386,7 +391,7 @@ static struct grant *get_indirect_grant(grant_ref_t *gref_head,
 	/* Assign a gref to this page */
 	gnt_list_entry->gref = gnttab_claim_grant_reference(gref_head);
 	BUG_ON(gnt_list_entry->gref == -ENOSPC);
-	if (!info->feature_persistent) {
+	if (!info->bounce) {
 		struct page *indirect_page;
 
 		/* Fetch a pre-allocated page to use for indirect grefs */
@@ -701,7 +706,7 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 		.grant_idx = 0,
 		.segments = NULL,
 		.rinfo = rinfo,
-		.need_copy = rq_data_dir(req) && info->feature_persistent,
+		.need_copy = rq_data_dir(req) && info->bounce,
 	};
 
 	/*
@@ -1015,11 +1020,12 @@ static void xlvbd_flush(struct blkfront_info *info)
 {
 	blk_queue_write_cache(info->rq, info->feature_flush ? true : false,
 			      info->feature_fua ? true : false);
-	pr_info("blkfront: %s: %s %s %s %s %s\n",
+	pr_info("blkfront: %s: %s %s %s %s %s %s %s\n",
 		info->gd->disk_name, flush_info(info),
 		"persistent grants:", info->feature_persistent ?
 		"enabled;" : "disabled;", "indirect descriptors:",
-		info->max_indirect_segments ? "enabled;" : "disabled;");
+		info->max_indirect_segments ? "enabled;" : "disabled;",
+		"bounce buffer:", info->bounce ? "enabled" : "disabled;");
 }
 
 static int xen_translate_vdev(int vdevice, int *minor, unsigned int *offset)
@@ -1254,7 +1260,7 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	if (!list_empty(&rinfo->indirect_pages)) {
 		struct page *indirect_page, *n;
 
-		BUG_ON(info->feature_persistent);
+		BUG_ON(info->bounce);
 		list_for_each_entry_safe(indirect_page, n, &rinfo->indirect_pages, lru) {
 			list_del(&indirect_page->lru);
 			__free_page(indirect_page);
@@ -1271,7 +1277,7 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 				continue;
 
 			rinfo->persistent_gnts_c--;
-			if (info->feature_persistent)
+			if (info->bounce)
 				__free_page(persistent_gnt->page);
 			kfree(persistent_gnt);
 		}
@@ -1291,7 +1297,7 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 		for (j = 0; j < segs; j++) {
 			persistent_gnt = rinfo->shadow[i].grants_used[j];
 			gnttab_end_foreign_access(persistent_gnt->gref, 0, 0UL);
-			if (info->feature_persistent)
+			if (info->bounce)
 				__free_page(persistent_gnt->page);
 			kfree(persistent_gnt);
 		}
@@ -1481,7 +1487,7 @@ static int blkif_completion(unsigned long *id,
 	data.s = s;
 	num_sg = s->num_sg;
 
-	if (bret->operation == BLKIF_OP_READ && info->feature_persistent) {
+	if (bret->operation == BLKIF_OP_READ && info->bounce) {
 		for_each_sg(s->sg, sg, num_sg, i) {
 			BUG_ON(sg->offset + sg->length > PAGE_SIZE);
 
@@ -1540,7 +1546,7 @@ static int blkif_completion(unsigned long *id,
 				 * Add the used indirect page back to the list of
 				 * available pages for indirect grefs.
 				 */
-				if (!info->feature_persistent) {
+				if (!info->bounce) {
 					indirect_page = s->indirect_grants[i]->page;
 					list_add(&indirect_page->lru, &rinfo->indirect_pages);
 				}
@@ -1729,7 +1735,7 @@ static int setup_blkring(struct xenbus_device *dev,
 	for (i = 0; i < info->nr_ring_pages; i++)
 		rinfo->ring_ref[i] = GRANT_INVALID_REF;
 
-	sring = alloc_pages_exact(ring_size, GFP_NOIO);
+	sring = alloc_pages_exact(ring_size, GFP_NOIO | __GFP_ZERO);
 	if (!sring) {
 		xenbus_dev_fatal(dev, -ENOMEM, "allocating shared ring");
 		return -ENOMEM;
@@ -1822,6 +1828,13 @@ static int talk_to_blkback(struct xenbus_device *dev,
 	int err;
 	unsigned int i, max_page_order = 0;
 	unsigned int ring_page_order = 0;
+	unsigned int trusted;
+
+	/* Check if backend is trusted. */
+	err = xenbus_scanf(XBT_NIL, dev->nodename, "trusted", "%u", &trusted);
+	if (err < 0)
+		trusted = 1;
+	info->bounce = !xen_blkif_trusted || !trusted;
 
 	err = xenbus_scanf(XBT_NIL, info->xbdev->otherend,
 			   "max-ring-page-order", "%u", &max_page_order);
@@ -2301,17 +2314,18 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo)
 	if (err)
 		goto out_of_memory;
 
-	if (!info->feature_persistent && info->max_indirect_segments) {
+	if (!info->bounce && info->max_indirect_segments) {
 		/*
-		 * We are using indirect descriptors but not persistent
-		 * grants, we need to allocate a set of pages that can be
+		 * We are using indirect descriptors but don't have a bounce
+		 * buffer, we need to allocate a set of pages that can be
 		 * used for mapping indirect grefs
 		 */
 		int num = INDIRECT_GREFS(grants) * BLK_RING_SIZE(info);
 
 		BUG_ON(!list_empty(&rinfo->indirect_pages));
 		for (i = 0; i < num; i++) {
-			struct page *indirect_page = alloc_page(GFP_NOIO);
+			struct page *indirect_page = alloc_page(GFP_NOIO |
+			                                        __GFP_ZERO);
 			if (!indirect_page)
 				goto out_of_memory;
 			list_add(&indirect_page->lru, &rinfo->indirect_pages);
@@ -2409,6 +2423,8 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
 		info->feature_persistent = 0;
 	else
 		info->feature_persistent = persistent;
+	if (info->feature_persistent)
+		info->bounce = true;
 
 	err = xenbus_scanf(XBT_NIL, info->xbdev->otherend,
 			   "feature-max-indirect-segments", "%u",
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index f4ae000eb285..1d3813d4f5c8 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -593,5 +593,41 @@ config TILE_SROM
 
 source "drivers/char/xillybus/Kconfig"
 
-endmenu
+config RANDOM_TRUST_CPU
+	bool "Initialize RNG using CPU RNG instructions"
+	default y
+	depends on ARCH_RANDOM
+	help
+	  Initialize the RNG using random numbers supplied by the CPU's
+	  RNG instructions (e.g. RDRAND), if supported and available. These
+	  random numbers are never used directly, but are rather hashed into
+	  the main input pool, and this happens regardless of whether or not
+	  this option is enabled. Instead, this option controls whether the
+	  they are credited and hence can initialize the RNG. Additionally,
+	  other sources of randomness are always used, regardless of this
+	  setting.  Enabling this implies trusting that the CPU can supply high
+	  quality and non-backdoored random numbers.
+
+	  Say Y here unless you have reason to mistrust your CPU or believe
+	  its RNG facilities may be faulty. This may also be configured at
+	  boot time with "random.trust_cpu=on/off".
+
+config RANDOM_TRUST_BOOTLOADER
+	bool "Initialize RNG using bootloader-supplied seed"
+	default y
+	help
+	  Initialize the RNG using a seed supplied by the bootloader or boot
+	  environment (e.g. EFI or a bootloader-generated device tree). This
+	  seed is not used directly, but is rather hashed into the main input
+	  pool, and this happens regardless of whether or not this option is
+	  enabled. Instead, this option controls whether the seed is credited
+	  and hence can initialize the RNG. Additionally, other sources of
+	  randomness are always used, regardless of this setting. Enabling
+	  this implies trusting that the bootloader can supply high quality and
+	  non-backdoored seeds.
+
+	  Say Y here unless you have reason to mistrust your bootloader or
+	  believe its RNG facilities may be faulty. This may also be configured
+	  at boot time with "random.trust_bootloader=on/off".
 
+endmenu
diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 5e79b4bfe27a..f1121a162ef0 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -1,38 +1,18 @@
 /*
-        Added support for the AMD Geode LX RNG
-	(c) Copyright 2004-2005 Advanced Micro Devices, Inc.
-
-	derived from
-
- 	Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
-	(c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
-
- 	derived from
-
-        Hardware driver for the AMD 768 Random Number Generator (RNG)
-        (c) Copyright 2001 Red Hat Inc <alan@redhat.com>
-
- 	derived from
-
-	Hardware driver for Intel i810 Random Number Generator (RNG)
-	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
-	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
-
-	Added generic RNG API
-	Copyright 2006 Michael Buesch <m@bues.ch>
-	Copyright 2005 (c) MontaVista Software, Inc.
-
-	Please read Documentation/hw_random.txt for details on use.
-
-	----------------------------------------------------------
-	This software may be used and distributed according to the terms
-        of the GNU General Public License, incorporated herein by reference.
-
+ * hw_random/core.c: HWRNG core API
+ *
+ * Copyright 2006 Michael Buesch <m@bues.ch>
+ * Copyright 2005 (c) MontaVista Software, Inc.
+ *
+ * Please read Documentation/hw_random.txt for details on use.
+ *
+ * This software may be used and distributed according to the terms
+ * of the GNU General Public License, incorporated herein by reference.
  */
 
-
 #include <linux/device.h>
 #include <linux/hw_random.h>
+#include <linux/random.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
@@ -45,14 +25,13 @@
 #include <linux/err.h>
 #include <asm/uaccess.h>
 
-
 #define RNG_MODULE_NAME		"hw_random"
-#define PFX			RNG_MODULE_NAME ": "
-#define RNG_MISCDEV_MINOR	183 /* official */
-
 
 static struct hwrng *current_rng;
+/* the current rng has been explicitly chosen by user via sysfs */
+static int cur_rng_set_by_user;
 static struct task_struct *hwrng_fill;
+/* list of registered rngs, sorted decending by quality */
 static LIST_HEAD(rng_list);
 /* Protects rng_list and current_rng */
 static DEFINE_MUTEX(rng_mutex);
@@ -296,7 +275,6 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 	goto out;
 }
 
-
 static const struct file_operations rng_chrdev_ops = {
 	.owner		= THIS_MODULE,
 	.open		= rng_dev_open,
@@ -307,14 +285,13 @@ static const struct file_operations rng_chrdev_ops = {
 static const struct attribute_group *rng_dev_groups[];
 
 static struct miscdevice rng_miscdev = {
-	.minor		= RNG_MISCDEV_MINOR,
+	.minor		= HWRNG_MINOR,
 	.name		= RNG_MODULE_NAME,
 	.nodename	= "hwrng",
 	.fops		= &rng_chrdev_ops,
 	.groups		= rng_dev_groups,
 };
 
-
 static ssize_t hwrng_attr_current_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t len)
@@ -329,6 +306,7 @@ static ssize_t hwrng_attr_current_store(struct device *dev,
 	list_for_each_entry(rng, &rng_list, list) {
 		if (sysfs_streq(rng->name, buf)) {
 			err = 0;
+			cur_rng_set_by_user = 1;
 			if (rng != current_rng)
 				err = set_current_rng(rng);
 			break;
@@ -377,16 +355,27 @@ static ssize_t hwrng_attr_available_show(struct device *dev,
 	return strlen(buf);
 }
 
+static ssize_t hwrng_attr_selected_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", cur_rng_set_by_user);
+}
+
 static DEVICE_ATTR(rng_current, S_IRUGO | S_IWUSR,
 		   hwrng_attr_current_show,
 		   hwrng_attr_current_store);
 static DEVICE_ATTR(rng_available, S_IRUGO,
 		   hwrng_attr_available_show,
 		   NULL);
+static DEVICE_ATTR(rng_selected, S_IRUGO,
+		   hwrng_attr_selected_show,
+		   NULL);
 
 static struct attribute *rng_dev_attrs[] = {
 	&dev_attr_rng_current.attr,
 	&dev_attr_rng_available.attr,
+	&dev_attr_rng_selected.attr,
 	NULL
 };
 
@@ -443,9 +432,9 @@ int hwrng_register(struct hwrng *rng)
 {
 	int err = -EINVAL;
 	struct hwrng *old_rng, *tmp;
+	struct list_head *rng_list_ptr;
 
-	if (rng->name == NULL ||
-	    (rng->data_read == NULL && rng->read == NULL))
+	if (!rng->name || (!rng->data_read && !rng->read))
 		goto out;
 
 	mutex_lock(&rng_mutex);
@@ -459,14 +448,27 @@ int hwrng_register(struct hwrng *rng)
 	init_completion(&rng->cleanup_done);
 	complete(&rng->cleanup_done);
 
+	/* rng_list is sorted by decreasing quality */
+	list_for_each(rng_list_ptr, &rng_list) {
+		tmp = list_entry(rng_list_ptr, struct hwrng, list);
+		if (tmp->quality < rng->quality)
+			break;
+	}
+	list_add_tail(&rng->list, rng_list_ptr);
+
 	old_rng = current_rng;
 	err = 0;
-	if (!old_rng) {
+	if (!old_rng ||
+	    (!cur_rng_set_by_user && rng->quality > old_rng->quality)) {
+		/*
+		 * Set new rng as current as the new rng source
+		 * provides better entropy quality and was not
+		 * chosen by userspace.
+		 */
 		err = set_current_rng(rng);
 		if (err)
 			goto out_unlock;
 	}
-	list_add_tail(&rng->list, &rng_list);
 
 	if (old_rng && !rng->init) {
 		/*
@@ -493,12 +495,13 @@ void hwrng_unregister(struct hwrng *rng)
 	list_del(&rng->list);
 	if (current_rng == rng) {
 		drop_current_rng();
+		cur_rng_set_by_user = 0;
+		/* rng_list is sorted by quality, use the best (=first) one */
 		if (!list_empty(&rng_list)) {
-			struct hwrng *tail;
-
-			tail = list_entry(rng_list.prev, struct hwrng, list);
+			struct hwrng *new_rng;
 
-			set_current_rng(tail);
+			new_rng = list_entry(rng_list.next, struct hwrng, list);
+			set_current_rng(new_rng);
 		}
 	}
 
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4792199d2a1a..86c475f70343 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1,239 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
- * random.c -- A strong random number generator
- *
+ * Copyright (C) 2017-2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  * Copyright Matt Mackall <mpm@selenic.com>, 2003, 2004, 2005
- *
- * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All
- * rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, and the entire permission notice in its entirety,
- *    including the disclaimer of warranties.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The name of the author may not be used to endorse or promote
- *    products derived from this software without specific prior
- *    written permission.
- *
- * ALTERNATIVELY, this product may be distributed under the terms of
- * the GNU General Public License, in which case the provisions of the GPL are
- * required INSTEAD OF the above restrictions.  (This clause is
- * necessary due to a potential bad interaction between the GPL and
- * the restrictions contained in a BSD-style copyright.)
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
- * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
- * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
- * DAMAGE.
+ * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999. All rights reserved.
+ *
+ * This driver produces cryptographically secure pseudorandom data. It is divided
+ * into roughly six sections, each with a section header:
+ *
+ *   - Initialization and readiness waiting.
+ *   - Fast key erasure RNG, the "crng".
+ *   - Entropy accumulation and extraction routines.
+ *   - Entropy collection routines.
+ *   - Userspace reader/writer interfaces.
+ *   - Sysctl interface.
+ *
+ * The high level overview is that there is one input pool, into which
+ * various pieces of data are hashed. Prior to initialization, some of that
+ * data is then "credited" as having a certain number of bits of entropy.
+ * When enough bits of entropy are available, the hash is finalized and
+ * handed as a key to a stream cipher that expands it indefinitely for
+ * various consumers. This key is periodically refreshed as the various
+ * entropy collectors, described below, add data to the input pool.
  */
 
-/*
- * (now, with legal B.S. out of the way.....)
- *
- * This routine gathers environmental noise from device drivers, etc.,
- * and returns good random numbers, suitable for cryptographic use.
- * Besides the obvious cryptographic uses, these numbers are also good
- * for seeding TCP sequence numbers, and other places where it is
- * desirable to have numbers which are not only random, but hard to
- * predict by an attacker.
- *
- * Theory of operation
- * ===================
- *
- * Computers are very predictable devices.  Hence it is extremely hard
- * to produce truly random numbers on a computer --- as opposed to
- * pseudo-random numbers, which can easily generated by using a
- * algorithm.  Unfortunately, it is very easy for attackers to guess
- * the sequence of pseudo-random number generators, and for some
- * applications this is not acceptable.  So instead, we must try to
- * gather "environmental noise" from the computer's environment, which
- * must be hard for outside attackers to observe, and use that to
- * generate random numbers.  In a Unix environment, this is best done
- * from inside the kernel.
- *
- * Sources of randomness from the environment include inter-keyboard
- * timings, inter-interrupt timings from some interrupts, and other
- * events which are both (a) non-deterministic and (b) hard for an
- * outside observer to measure.  Randomness from these sources are
- * added to an "entropy pool", which is mixed using a CRC-like function.
- * This is not cryptographically strong, but it is adequate assuming
- * the randomness is not chosen maliciously, and it is fast enough that
- * the overhead of doing it on every interrupt is very reasonable.
- * As random bytes are mixed into the entropy pool, the routines keep
- * an *estimate* of how many bits of randomness have been stored into
- * the random number generator's internal state.
- *
- * When random bytes are desired, they are obtained by taking the SHA
- * hash of the contents of the "entropy pool".  The SHA hash avoids
- * exposing the internal state of the entropy pool.  It is believed to
- * be computationally infeasible to derive any useful information
- * about the input of SHA from its output.  Even if it is possible to
- * analyze SHA in some clever way, as long as the amount of data
- * returned from the generator is less than the inherent entropy in
- * the pool, the output data is totally unpredictable.  For this
- * reason, the routine decreases its internal estimate of how many
- * bits of "true randomness" are contained in the entropy pool as it
- * outputs random numbers.
- *
- * If this estimate goes to zero, the routine can still generate
- * random numbers; however, an attacker may (at least in theory) be
- * able to infer the future output of the generator from prior
- * outputs.  This requires successful cryptanalysis of SHA, which is
- * not believed to be feasible, but there is a remote possibility.
- * Nonetheless, these numbers should be useful for the vast majority
- * of purposes.
- *
- * Exported interfaces ---- output
- * ===============================
- *
- * There are three exported interfaces; the first is one designed to
- * be used from within the kernel:
- *
- * 	void get_random_bytes(void *buf, int nbytes);
- *
- * This interface will return the requested number of random bytes,
- * and place it in the requested buffer.
- *
- * The two other interfaces are two character devices /dev/random and
- * /dev/urandom.  /dev/random is suitable for use when very high
- * quality randomness is desired (for example, for key generation or
- * one-time pads), as it will only return a maximum of the number of
- * bits of randomness (as estimated by the random number generator)
- * contained in the entropy pool.
- *
- * The /dev/urandom device does not have this limit, and will return
- * as many bytes as are requested.  As more and more random bytes are
- * requested without giving time for the entropy pool to recharge,
- * this will result in random numbers that are merely cryptographically
- * strong.  For many applications, however, this is acceptable.
- *
- * Exported interfaces ---- input
- * ==============================
- *
- * The current exported interfaces for gathering environmental noise
- * from the devices are:
- *
- *	void add_device_randomness(const void *buf, unsigned int size);
- * 	void add_input_randomness(unsigned int type, unsigned int code,
- *                                unsigned int value);
- *	void add_interrupt_randomness(int irq, int irq_flags);
- * 	void add_disk_randomness(struct gendisk *disk);
- *
- * add_device_randomness() is for adding data to the random pool that
- * is likely to differ between two devices (or possibly even per boot).
- * This would be things like MAC addresses or serial numbers, or the
- * read-out of the RTC. This does *not* add any actual entropy to the
- * pool, but it initializes the pool to different values for devices
- * that might otherwise be identical and have very little entropy
- * available to them (particularly common in the embedded world).
- *
- * add_input_randomness() uses the input layer interrupt timing, as well as
- * the event type information from the hardware.
- *
- * add_interrupt_randomness() uses the interrupt timing as random
- * inputs to the entropy pool. Using the cycle counters and the irq source
- * as inputs, it feeds the randomness roughly once a second.
- *
- * add_disk_randomness() uses what amounts to the seek time of block
- * layer request events, on a per-disk_devt basis, as input to the
- * entropy pool. Note that high-speed solid state drives with very low
- * seek times do not make for good sources of entropy, as their seek
- * times are usually fairly consistent.
- *
- * All of these routines try to estimate how many bits of randomness a
- * particular randomness source.  They do this by keeping track of the
- * first and second order deltas of the event timings.
- *
- * Ensuring unpredictability at system startup
- * ============================================
- *
- * When any operating system starts up, it will go through a sequence
- * of actions that are fairly predictable by an adversary, especially
- * if the start-up does not involve interaction with a human operator.
- * This reduces the actual number of bits of unpredictability in the
- * entropy pool below the value in entropy_count.  In order to
- * counteract this effect, it helps to carry information in the
- * entropy pool across shut-downs and start-ups.  To do this, put the
- * following lines an appropriate script which is run during the boot
- * sequence:
- *
- *	echo "Initializing random number generator..."
- *	random_seed=/var/run/random-seed
- *	# Carry a random seed from start-up to start-up
- *	# Load and then save the whole entropy pool
- *	if [ -f $random_seed ]; then
- *		cat $random_seed >/dev/urandom
- *	else
- *		touch $random_seed
- *	fi
- *	chmod 600 $random_seed
- *	dd if=/dev/urandom of=$random_seed count=1 bs=512
- *
- * and the following lines in an appropriate script which is run as
- * the system is shutdown:
- *
- *	# Carry a random seed from shut-down to start-up
- *	# Save the whole entropy pool
- *	echo "Saving random seed..."
- *	random_seed=/var/run/random-seed
- *	touch $random_seed
- *	chmod 600 $random_seed
- *	dd if=/dev/urandom of=$random_seed count=1 bs=512
- *
- * For example, on most modern systems using the System V init
- * scripts, such code fragments would be found in
- * /etc/rc.d/init.d/random.  On older Linux systems, the correct script
- * location might be in /etc/rcb.d/rc.local or /etc/rc.d/rc.0.
- *
- * Effectively, these commands cause the contents of the entropy pool
- * to be saved at shut-down time and reloaded into the entropy pool at
- * start-up.  (The 'dd' in the addition to the bootup script is to
- * make sure that /etc/random-seed is different for every start-up,
- * even if the system crashes without executing rc.0.)  Even with
- * complete knowledge of the start-up activities, predicting the state
- * of the entropy pool requires knowledge of the previous history of
- * the system.
- *
- * Configuring the /dev/random driver under Linux
- * ==============================================
- *
- * The /dev/random driver under Linux uses minor numbers 8 and 9 of
- * the /dev/mem major number (#1).  So if your system does not have
- * /dev/random and /dev/urandom created already, they can be created
- * by using the commands:
- *
- * 	mknod /dev/random c 1 8
- * 	mknod /dev/urandom c 1 9
- *
- * Acknowledgements:
- * =================
- *
- * Ideas for constructing this random number generator were derived
- * from Pretty Good Privacy's random number generator, and from private
- * discussions with Phil Karn.  Colin Plumb provided a faster random
- * number generator, which speed up the mixing function of the entropy
- * pool, taken from PGPfone.  Dale Worley has also contributed many
- * useful ideas and suggestions to improve this driver.
- *
- * Any flaws in the design are solely my responsibility, and should
- * not be attributed to the Phil, Colin, or any of authors of PGP.
- *
- * Further background information on this topic may be obtained from
- * RFC 1750, "Randomness Recommendations for Security", by Donald
- * Eastlake, Steve Crocker, and Jeff Schiller.
- */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/utsname.h>
 #include <linux/module.h>
@@ -253,8 +43,6 @@
 #include <linux/spinlock.h>
 #include <linux/kthread.h>
 #include <linux/percpu.h>
-#include <linux/cryptohash.h>
-#include <linux/fips.h>
 #include <linux/ptrace.h>
 #include <linux/kmemcheck.h>
 #include <linux/workqueue.h>
@@ -263,1477 +51,1072 @@
 #include <linux/syscalls.h>
 #include <linux/completion.h>
 #include <linux/uuid.h>
+#include <linux/siphash.h>
+#include <linux/uio.h>
 #include <linux/locallock.h>
 #include <crypto/chacha20.h>
-
+#include <crypto/blake2s.h>
 #include <asm/processor.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/io.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/random.h>
-
-/* #define ADD_INTERRUPT_BENCH */
+/*********************************************************************
+ *
+ * Initialization and readiness waiting.
+ *
+ * Much of the RNG infrastructure is devoted to various dependencies
+ * being able to wait until the RNG has collected enough entropy and
+ * is ready for safe consumption.
+ *
+ *********************************************************************/
 
 /*
- * Configuration information
+ * crng_init is protected by base_crng->lock, and only increases
+ * its value (from empty->early->ready).
  */
-#define INPUT_POOL_SHIFT	12
-#define INPUT_POOL_WORDS	(1 << (INPUT_POOL_SHIFT-5))
-#define OUTPUT_POOL_SHIFT	10
-#define OUTPUT_POOL_WORDS	(1 << (OUTPUT_POOL_SHIFT-5))
-#define SEC_XFER_SIZE		512
-#define EXTRACT_SIZE		10
-
-#define DEBUG_RANDOM_BOOT 0
+static enum {
+	CRNG_EMPTY = 0, /* Little to no entropy collected */
+	CRNG_EARLY = 1, /* At least POOL_EARLY_BITS collected */
+	CRNG_READY = 2  /* Fully initialized with POOL_READY_BITS collected */
+} crng_init __read_mostly = CRNG_EMPTY;
+#define crng_ready() (likely(crng_init >= CRNG_READY))
+/* Various types of waiters for crng_init->CRNG_READY transition. */
+static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
+static struct fasync_struct *fasync;
+static DEFINE_SPINLOCK(random_ready_chain_lock);
+static RAW_NOTIFIER_HEAD(random_ready_chain);
 
-#define LONGS(x) (((x) + sizeof(unsigned long) - 1)/sizeof(unsigned long))
+/* Control how we warn userspace. */
+static struct ratelimit_state urandom_warning =
+	RATELIMIT_STATE_INIT_FLAGS("urandom_warning", HZ, 3, RATELIMIT_MSG_ON_RELEASE);
+static int ratelimit_disable __read_mostly =
+	IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM);
+module_param_named(ratelimit_disable, ratelimit_disable, int, 0644);
+MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
 
 /*
- * To allow fractional bits to be tracked, the entropy_count field is
- * denominated in units of 1/8th bits.
+ * Returns whether or not the input pool has been seeded and thus guaranteed
+ * to supply cryptographically secure random numbers. This applies to: the
+ * /dev/urandom device, the get_random_bytes function, and the get_random_{u32,
+ * ,u64,int,long} family of functions.
  *
- * 2*(ENTROPY_SHIFT + log2(poolbits)) must <= 31, or the multiply in
- * credit_entropy_bits() needs to be 64 bits wide.
+ * Returns: true if the input pool has been seeded.
+ *          false if the input pool has not been seeded.
  */
-#define ENTROPY_SHIFT 3
-#define ENTROPY_BITS(r) ((r)->entropy_count >> ENTROPY_SHIFT)
+bool rng_is_initialized(void)
+{
+	return crng_ready();
+}
+EXPORT_SYMBOL(rng_is_initialized);
 
-/*
- * The minimum number of bits of entropy before we wake up a read on
- * /dev/random.  Should be enough to do a significant reseed.
- */
-static int random_read_wakeup_bits = 64;
+/* Used by wait_for_random_bytes(), and considered an entropy collector, below. */
+static void try_to_generate_entropy(void);
 
 /*
- * If the entropy count falls under this number of bits, then we
- * should wake up processes which are selecting or polling on write
- * access to /dev/random.
+ * Wait for the input pool to be seeded and thus guaranteed to supply
+ * cryptographically secure random numbers. This applies to: the /dev/urandom
+ * device, the get_random_bytes function, and the get_random_{u32,u64,int,long}
+ * family of functions. Using any of these functions without first calling
+ * this function forfeits the guarantee of security.
+ *
+ * Returns: 0 if the input pool has been seeded.
+ *          -ERESTARTSYS if the function was interrupted by a signal.
  */
-static int random_write_wakeup_bits = 28 * OUTPUT_POOL_WORDS;
+int wait_for_random_bytes(void)
+{
+	while (!crng_ready()) {
+		int ret;
 
-/*
- * The minimum number of seconds between urandom pool reseeding.  We
- * do this to limit the amount of entropy that can be drained from the
- * input pool even if there are heavy demands on /dev/urandom.
- */
-static int random_min_urandom_seed = 60;
+		try_to_generate_entropy();
+		ret = wait_event_interruptible_timeout(crng_init_wait, crng_ready(), HZ);
+		if (ret)
+			return ret > 0 ? 0 : ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(wait_for_random_bytes);
 
 /*
- * Originally, we used a primitive polynomial of degree .poolwords
- * over GF(2).  The taps for various sizes are defined below.  They
- * were chosen to be evenly spaced except for the last tap, which is 1
- * to get the twisting happening as fast as possible.
- *
- * For the purposes of better mixing, we use the CRC-32 polynomial as
- * well to make a (modified) twisted Generalized Feedback Shift
- * Register.  (See M. Matsumoto & Y. Kurita, 1992.  Twisted GFSR
- * generators.  ACM Transactions on Modeling and Computer Simulation
- * 2(3):179-194.  Also see M. Matsumoto & Y. Kurita, 1994.  Twisted
- * GFSR generators II.  ACM Transactions on Modeling and Computer
- * Simulation 4:254-266)
- *
- * Thanks to Colin Plumb for suggesting this.
- *
- * The mixing operation is much less sensitive than the output hash,
- * where we use SHA-1.  All that we want of mixing operation is that
- * it be a good non-cryptographic hash; i.e. it not produce collisions
- * when fed "random" data of the sort we expect to see.  As long as
- * the pool state differs for different inputs, we have preserved the
- * input entropy and done a good job.  The fact that an intelligent
- * attacker can construct inputs that will produce controlled
- * alterations to the pool's state is not important because we don't
- * consider such inputs to contribute any randomness.  The only
- * property we need with respect to them is that the attacker can't
- * increase his/her knowledge of the pool's state.  Since all
- * additions are reversible (knowing the final state and the input,
- * you can reconstruct the initial state), if an attacker has any
- * uncertainty about the initial state, he/she can only shuffle that
- * uncertainty about, but never cause any collisions (which would
- * decrease the uncertainty).
+ * Add a callback function that will be invoked when the input
+ * pool is initialised.
  *
- * Our mixing functions were analyzed by Lacharme, Roeck, Strubel, and
- * Videau in their paper, "The Linux Pseudorandom Number Generator
- * Revisited" (see: http://eprint.iacr.org/2012/251.pdf).  In their
- * paper, they point out that we are not using a true Twisted GFSR,
- * since Matsumoto & Kurita used a trinomial feedback polynomial (that
- * is, with only three taps, instead of the six that we are using).
- * As a result, the resulting polynomial is neither primitive nor
- * irreducible, and hence does not have a maximal period over
- * GF(2**32).  They suggest a slight change to the generator
- * polynomial which improves the resulting TGFSR polynomial to be
- * irreducible, which we have made here.
+ * returns: 0 if callback is successfully added
+ *	    -EALREADY if pool is already initialised (callback not called)
  */
-static struct poolinfo {
-	int poolbitshift, poolwords, poolbytes, poolbits, poolfracbits;
-#define S(x) ilog2(x)+5, (x), (x)*4, (x)*32, (x) << (ENTROPY_SHIFT+5)
-	int tap1, tap2, tap3, tap4, tap5;
-} poolinfo_table[] = {
-	/* was: x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 */
-	/* x^128 + x^104 + x^76 + x^51 +x^25 + x + 1 */
-	{ S(128),	104,	76,	51,	25,	1 },
-	/* was: x^32 + x^26 + x^20 + x^14 + x^7 + x + 1 */
-	/* x^32 + x^26 + x^19 + x^14 + x^7 + x + 1 */
-	{ S(32),	26,	19,	14,	7,	1 },
-#if 0
-	/* x^2048 + x^1638 + x^1231 + x^819 + x^411 + x + 1  -- 115 */
-	{ S(2048),	1638,	1231,	819,	411,	1 },
-
-	/* x^1024 + x^817 + x^615 + x^412 + x^204 + x + 1 -- 290 */
-	{ S(1024),	817,	615,	412,	204,	1 },
-
-	/* x^1024 + x^819 + x^616 + x^410 + x^207 + x^2 + 1 -- 115 */
-	{ S(1024),	819,	616,	410,	207,	2 },
-
-	/* x^512 + x^411 + x^308 + x^208 + x^104 + x + 1 -- 225 */
-	{ S(512),	411,	308,	208,	104,	1 },
-
-	/* x^512 + x^409 + x^307 + x^206 + x^102 + x^2 + 1 -- 95 */
-	{ S(512),	409,	307,	206,	102,	2 },
-	/* x^512 + x^409 + x^309 + x^205 + x^103 + x^2 + 1 -- 95 */
-	{ S(512),	409,	309,	205,	103,	2 },
-
-	/* x^256 + x^205 + x^155 + x^101 + x^52 + x + 1 -- 125 */
-	{ S(256),	205,	155,	101,	52,	1 },
-
-	/* x^128 + x^103 + x^78 + x^51 + x^27 + x^2 + 1 -- 70 */
-	{ S(128),	103,	78,	51,	27,	2 },
-
-	/* x^64 + x^52 + x^39 + x^26 + x^14 + x + 1 -- 15 */
-	{ S(64),	52,	39,	26,	14,	1 },
-#endif
-};
+int __cold register_random_ready_notifier(struct notifier_block *nb)
+{
+	unsigned long flags;
+	int ret = -EALREADY;
+
+	if (crng_ready())
+		return ret;
+
+	spin_lock_irqsave(&random_ready_chain_lock, flags);
+	if (!crng_ready())
+		ret = raw_notifier_chain_register(&random_ready_chain, nb);
+	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
+	return ret;
+}
 
 /*
- * Static global variables
+ * Delete a previously registered readiness callback function.
  */
-static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
-static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
-static DECLARE_WAIT_QUEUE_HEAD(urandom_init_wait);
-static struct fasync_struct *fasync;
-
-static DEFINE_SPINLOCK(random_ready_list_lock);
-static LIST_HEAD(random_ready_list);
+int __cold unregister_random_ready_notifier(struct notifier_block *nb)
+{
+	unsigned long flags;
+	int ret;
 
-struct crng_state {
-	__u32		state[16];
-	unsigned long	init_time;
-	spinlock_t	lock;
-};
+	spin_lock_irqsave(&random_ready_chain_lock, flags);
+	ret = raw_notifier_chain_unregister(&random_ready_chain, nb);
+	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
+	return ret;
+}
 
-struct crng_state primary_crng = {
-	.lock = __SPIN_LOCK_UNLOCKED(primary_crng.lock),
-};
+static void __cold process_random_ready_list(void)
+{
+	unsigned long flags;
 
-/*
- * crng_init =  0 --> Uninitialized
- *		1 --> Initialized
- *		2 --> Initialized from input_pool
- *
- * crng_init is protected by primary_crng->lock, and only increases
- * its value (from 0->1->2).
- */
-static int crng_init = 0;
-#define crng_ready() (likely(crng_init > 1))
-static int crng_init_cnt = 0;
-static unsigned long crng_global_init_time = 0;
-#define CRNG_INIT_CNT_THRESH (2*CHACHA20_KEY_SIZE)
-static void _extract_crng(struct crng_state *crng,
-			  __u8 out[CHACHA20_BLOCK_SIZE]);
-static void _crng_backtrack_protect(struct crng_state *crng,
-				    __u8 tmp[CHACHA20_BLOCK_SIZE], int used);
-static void process_random_ready_list(void);
-
-static struct ratelimit_state unseeded_warning =
-	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
-static struct ratelimit_state urandom_warning =
-	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
+	spin_lock_irqsave(&random_ready_chain_lock, flags);
+	raw_notifier_call_chain(&random_ready_chain, 0, NULL);
+	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
+}
 
-static int ratelimit_disable __read_mostly;
+#define warn_unseeded_randomness() \
+	if (IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM) && !crng_ready()) \
+		printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n", \
+				__func__, (void *)_RET_IP_, crng_init)
 
-module_param_named(ratelimit_disable, ratelimit_disable, int, 0644);
-MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
 
-/**********************************************************************
+/*********************************************************************
  *
- * OS independent entropy store.   Here are the functions which handle
- * storing entropy in an entropy pool.
+ * Fast key erasure RNG, the "crng".
  *
- **********************************************************************/
+ * These functions expand entropy from the entropy extractor into
+ * long streams for external consumption using the "fast key erasure"
+ * RNG described at <https://blog.cr.yp.to/20170723-random.html>.
+ *
+ * There are a few exported interfaces for use by other drivers:
+ *
+ *	void get_random_bytes(void *buf, size_t len)
+ *	u32 get_random_u32()
+ *	u64 get_random_u64()
+ *	unsigned int get_random_int()
+ *	unsigned long get_random_long()
+ *
+ * These interfaces will return the requested number of random bytes
+ * into the given buffer or as a return value. This is equivalent to
+ * a read from /dev/urandom. The u32, u64, int, and long family of
+ * functions may be higher performance for one-off random integers,
+ * because they do a bit of buffering and do not invoke reseeding
+ * until the buffer is emptied.
+ *
+ *********************************************************************/
 
-struct entropy_store;
-struct entropy_store {
-	/* read-only data: */
-	const struct poolinfo *poolinfo;
-	__u32 *pool;
-	const char *name;
-	struct entropy_store *pull;
-	struct work_struct push_work;
-
-	/* read-write data: */
-	unsigned long last_pulled;
-	spinlock_t lock;
-	unsigned short add_ptr;
-	unsigned short input_rotate;
-	int entropy_count;
-	int entropy_total;
-	unsigned int initialized:1;
-	unsigned int limit:1;
-	unsigned int last_data_init:1;
-	__u8 last_data[EXTRACT_SIZE];
+enum {
+	CRNG_RESEED_START_INTERVAL = HZ,
+	CRNG_RESEED_INTERVAL = 60 * HZ
 };
 
-static ssize_t extract_entropy(struct entropy_store *r, void *buf,
-			       size_t nbytes, int min, int rsvd);
-static ssize_t _extract_entropy(struct entropy_store *r, void *buf,
-				size_t nbytes, int fips);
-
-static void crng_reseed(struct crng_state *crng, struct entropy_store *r);
-static void push_to_pool(struct work_struct *work);
-static __u32 input_pool_data[INPUT_POOL_WORDS] __latent_entropy;
-static __u32 blocking_pool_data[OUTPUT_POOL_WORDS] __latent_entropy;
-
-static struct entropy_store input_pool = {
-	.poolinfo = &poolinfo_table[0],
-	.name = "input",
-	.limit = 1,
-	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
-	.pool = input_pool_data
+static struct {
+	u8 key[CHACHA20_KEY_SIZE] __aligned(__alignof__(long));
+	unsigned long birth;
+	unsigned long generation;
+	spinlock_t lock;
+} base_crng = {
+	.lock = __SPIN_LOCK_UNLOCKED(base_crng.lock)
 };
 
-static struct entropy_store blocking_pool = {
-	.poolinfo = &poolinfo_table[1],
-	.name = "blocking",
-	.limit = 1,
-	.pull = &input_pool,
-	.lock = __SPIN_LOCK_UNLOCKED(blocking_pool.lock),
-	.pool = blocking_pool_data,
-	.push_work = __WORK_INITIALIZER(blocking_pool.push_work,
-					push_to_pool),
+struct crng {
+	u8 key[CHACHA20_KEY_SIZE];
+	unsigned long generation;
+	struct local_irq_lock lock;
 };
 
-static __u32 const twist_table[8] = {
-	0x00000000, 0x3b6e20c8, 0x76dc4190, 0x4db26158,
-	0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
-
-/*
- * This function adds bytes into the entropy "pool".  It does not
- * update the entropy estimate.  The caller should call
- * credit_entropy_bits if this is appropriate.
- *
- * The pool is stirred with a primitive polynomial of the appropriate
- * degree, and then twisted.  We twist by three bits at a time because
- * it's cheap to do so and helps slightly in the expected case where
- * the entropy is concentrated in the low-order bits.
- */
-static void _mix_pool_bytes(struct entropy_store *r, const void *in,
-			    int nbytes)
-{
-	unsigned long i, tap1, tap2, tap3, tap4, tap5;
-	int input_rotate;
-	int wordmask = r->poolinfo->poolwords - 1;
-	const char *bytes = in;
-	__u32 w;
-
-	tap1 = r->poolinfo->tap1;
-	tap2 = r->poolinfo->tap2;
-	tap3 = r->poolinfo->tap3;
-	tap4 = r->poolinfo->tap4;
-	tap5 = r->poolinfo->tap5;
-
-	input_rotate = r->input_rotate;
-	i = r->add_ptr;
-
-	/* mix one byte at a time to simplify size handling and churn faster */
-	while (nbytes--) {
-		w = rol32(*bytes++, input_rotate);
-		i = (i - 1) & wordmask;
-
-		/* XOR in the various taps */
-		w ^= r->pool[i];
-		w ^= r->pool[(i + tap1) & wordmask];
-		w ^= r->pool[(i + tap2) & wordmask];
-		w ^= r->pool[(i + tap3) & wordmask];
-		w ^= r->pool[(i + tap4) & wordmask];
-		w ^= r->pool[(i + tap5) & wordmask];
-
-		/* Mix the result back in with a twist */
-		r->pool[i] = (w >> 3) ^ twist_table[w & 7];
-
-		/*
-		 * Normally, we add 7 bits of rotation to the pool.
-		 * At the beginning of the pool, add an extra 7 bits
-		 * rotation, so that successive passes spread the
-		 * input bits across the pool evenly.
-		 */
-		input_rotate = (input_rotate + (i ? 7 : 14)) & 31;
-	}
-
-	r->input_rotate = input_rotate;
-	r->add_ptr = i;
-}
+static DEFINE_PER_CPU(struct crng, crngs) = {
+	.generation = ULONG_MAX,
+	.lock = INIT_LOCAL_LOCK(crngs.lock),
+};
 
-static void __mix_pool_bytes(struct entropy_store *r, const void *in,
-			     int nbytes)
-{
-	trace_mix_pool_bytes_nolock(r->name, nbytes, _RET_IP_);
-	_mix_pool_bytes(r, in, nbytes);
-}
+/* Used by crng_reseed() and crng_make_state() to extract a new seed from the input pool. */
+static void extract_entropy(void *buf, size_t len);
 
-static void mix_pool_bytes(struct entropy_store *r, const void *in,
-			   int nbytes)
+/* This extracts a new crng key from the input pool. */
+static void crng_reseed(void)
 {
 	unsigned long flags;
+	unsigned long next_gen;
+	u8 key[CHACHA20_KEY_SIZE];
 
-	trace_mix_pool_bytes(r->name, nbytes, _RET_IP_);
-	spin_lock_irqsave(&r->lock, flags);
-	_mix_pool_bytes(r, in, nbytes);
-	spin_unlock_irqrestore(&r->lock, flags);
-}
+	extract_entropy(key, sizeof(key));
 
-struct fast_pool {
-	__u32		pool[4];
-	unsigned long	last;
-	unsigned short	reg_idx;
-	unsigned char	count;
-};
+	/*
+	 * We copy the new key into the base_crng, overwriting the old one,
+	 * and update the generation counter. We avoid hitting ULONG_MAX,
+	 * because the per-cpu crngs are initialized to ULONG_MAX, so this
+	 * forces new CPUs that come online to always initialize.
+	 */
+	spin_lock_irqsave(&base_crng.lock, flags);
+	memcpy(base_crng.key, key, sizeof(base_crng.key));
+	next_gen = base_crng.generation + 1;
+	if (next_gen == ULONG_MAX)
+		++next_gen;
+	WRITE_ONCE(base_crng.generation, next_gen);
+	WRITE_ONCE(base_crng.birth, jiffies);
+	if (!crng_ready())
+		crng_init = CRNG_READY;
+	spin_unlock_irqrestore(&base_crng.lock, flags);
+	memzero_explicit(key, sizeof(key));
+}
 
 /*
- * This is a fast mixing routine used by the interrupt randomness
- * collector.  It's hardcoded for an 128 bit pool and assumes that any
- * locks that might be needed are taken by the caller.
+ * This generates a ChaCha block using the provided key, and then
+ * immediately overwites that key with half the block. It returns
+ * the resultant ChaCha state to the user, along with the second
+ * half of the block containing 32 bytes of random data that may
+ * be used; random_data_len may not be greater than 32.
+ *
+ * The returned ChaCha state contains within it a copy of the old
+ * key value, at index 4, so the state should always be zeroed out
+ * immediately after using in order to maintain forward secrecy.
+ * If the state cannot be erased in a timely manner, then it is
+ * safer to set the random_data parameter to &chacha_state[4] so
+ * that this function overwrites it before returning.
  */
-static void fast_mix(struct fast_pool *f)
+static void crng_fast_key_erasure(u8 key[CHACHA20_KEY_SIZE],
+				  u32 chacha_state[CHACHA20_BLOCK_SIZE / sizeof(u32)],
+				  u8 *random_data, size_t random_data_len)
 {
-	__u32 a = f->pool[0],	b = f->pool[1];
-	__u32 c = f->pool[2],	d = f->pool[3];
-
-	a += b;			c += d;
-	b = rol32(b, 6);	d = rol32(d, 27);
-	d ^= a;			b ^= c;
+	u8 first_block[CHACHA20_BLOCK_SIZE];
 
-	a += b;			c += d;
-	b = rol32(b, 16);	d = rol32(d, 14);
-	d ^= a;			b ^= c;
+	BUG_ON(random_data_len > 32);
 
-	a += b;			c += d;
-	b = rol32(b, 6);	d = rol32(d, 27);
-	d ^= a;			b ^= c;
+	chacha_init_consts(chacha_state);
+	memcpy(&chacha_state[4], key, CHACHA20_KEY_SIZE);
+	memset(&chacha_state[12], 0, sizeof(u32) * 4);
+	chacha20_block(chacha_state, first_block);
 
-	a += b;			c += d;
-	b = rol32(b, 16);	d = rol32(d, 14);
-	d ^= a;			b ^= c;
-
-	f->pool[0] = a;  f->pool[1] = b;
-	f->pool[2] = c;  f->pool[3] = d;
-	f->count++;
+	memcpy(key, first_block, CHACHA20_KEY_SIZE);
+	memcpy(random_data, first_block + CHACHA20_KEY_SIZE, random_data_len);
+	memzero_explicit(first_block, sizeof(first_block));
 }
 
-static void process_random_ready_list(void)
+/*
+ * Return whether the crng seed is considered to be sufficiently old
+ * that a reseeding is needed. This happens if the last reseeding
+ * was CRNG_RESEED_INTERVAL ago, or during early boot, at an interval
+ * proportional to the uptime.
+ */
+static bool crng_has_old_seed(void)
 {
-	unsigned long flags;
-	struct random_ready_callback *rdy, *tmp;
-
-	spin_lock_irqsave(&random_ready_list_lock, flags);
-	list_for_each_entry_safe(rdy, tmp, &random_ready_list, list) {
-		struct module *owner = rdy->owner;
-
-		list_del_init(&rdy->list);
-		rdy->func(rdy);
-		module_put(owner);
+	static bool early_boot = true;
+	unsigned long interval = CRNG_RESEED_INTERVAL;
+
+	if (unlikely(READ_ONCE(early_boot))) {
+		time64_t uptime = ktime_get_seconds();
+		if (uptime >= CRNG_RESEED_INTERVAL / HZ * 2)
+			WRITE_ONCE(early_boot, false);
+		else
+			interval = max_t(unsigned int, CRNG_RESEED_START_INTERVAL,
+					 (unsigned int)uptime / 2 * HZ);
 	}
-	spin_unlock_irqrestore(&random_ready_list_lock, flags);
+	return time_is_before_jiffies(READ_ONCE(base_crng.birth) + interval);
 }
 
 /*
- * Credit (or debit) the entropy store with n bits of entropy.
- * Use credit_entropy_bits_safe() if the value comes from userspace
- * or otherwise should be checked for extreme values.
+ * This function returns a ChaCha state that you may use for generating
+ * random data. It also returns up to 32 bytes on its own of random data
+ * that may be used; random_data_len may not be greater than 32.
  */
-static void credit_entropy_bits(struct entropy_store *r, int nbits)
+static void crng_make_state(u32 chacha_state[CHACHA20_BLOCK_SIZE / sizeof(u32)],
+			    u8 *random_data, size_t random_data_len)
 {
-	int entropy_count, orig;
-	const int pool_size = r->poolinfo->poolfracbits;
-	int nfrac = nbits << ENTROPY_SHIFT;
-
-	if (!nbits)
-		return;
+	unsigned long flags;
+	struct crng *crng;
 
-retry:
-	entropy_count = orig = ACCESS_ONCE(r->entropy_count);
-	if (nfrac < 0) {
-		/* Debit */
-		entropy_count += nfrac;
-	} else {
-		/*
-		 * Credit: we have to account for the possibility of
-		 * overwriting already present entropy.	 Even in the
-		 * ideal case of pure Shannon entropy, new contributions
-		 * approach the full value asymptotically:
-		 *
-		 * entropy <- entropy + (pool_size - entropy) *
-		 *	(1 - exp(-add_entropy/pool_size))
-		 *
-		 * For add_entropy <= pool_size/2 then
-		 * (1 - exp(-add_entropy/pool_size)) >=
-		 *    (add_entropy/pool_size)*0.7869...
-		 * so we can approximate the exponential with
-		 * 3/4*add_entropy/pool_size and still be on the
-		 * safe side by adding at most pool_size/2 at a time.
-		 *
-		 * The use of pool_size-2 in the while statement is to
-		 * prevent rounding artifacts from making the loop
-		 * arbitrarily long; this limits the loop to log2(pool_size)*2
-		 * turns no matter how large nbits is.
-		 */
-		int pnfrac = nfrac;
-		const int s = r->poolinfo->poolbitshift + ENTROPY_SHIFT + 2;
-		/* The +2 corresponds to the /4 in the denominator */
-
-		do {
-			unsigned int anfrac = min(pnfrac, pool_size/2);
-			unsigned int add =
-				((pool_size - entropy_count)*anfrac*3) >> s;
-
-			entropy_count += add;
-			pnfrac -= anfrac;
-		} while (unlikely(entropy_count < pool_size-2 && pnfrac));
-	}
+	BUG_ON(random_data_len > 32);
 
-	if (unlikely(entropy_count < 0)) {
-		pr_warn("random: negative entropy/overflow: pool %s count %d\n",
-			r->name, entropy_count);
-		WARN_ON(1);
-		entropy_count = 0;
-	} else if (entropy_count > pool_size)
-		entropy_count = pool_size;
-	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
-		goto retry;
-
-	r->entropy_total += nbits;
-	if (!r->initialized && r->entropy_total > 128) {
-		r->initialized = 1;
-		r->entropy_total = 0;
+	/*
+	 * For the fast path, we check whether we're ready, unlocked first, and
+	 * then re-check once locked later. In the case where we're really not
+	 * ready, we do fast key erasure with the base_crng directly, extracting
+	 * when crng_init is CRNG_EMPTY.
+	 */
+	if (!crng_ready()) {
+		bool ready;
+
+		spin_lock_irqsave(&base_crng.lock, flags);
+		ready = crng_ready();
+		if (!ready) {
+			if (crng_init == CRNG_EMPTY)
+				extract_entropy(base_crng.key, sizeof(base_crng.key));
+			crng_fast_key_erasure(base_crng.key, chacha_state,
+					      random_data, random_data_len);
+		}
+		spin_unlock_irqrestore(&base_crng.lock, flags);
+		if (!ready)
+			return;
 	}
 
-	trace_credit_entropy_bits(r->name, nbits,
-				  entropy_count >> ENTROPY_SHIFT,
-				  r->entropy_total, _RET_IP_);
-
-	if (r == &input_pool) {
-		int entropy_bits = entropy_count >> ENTROPY_SHIFT;
+	/*
+	 * If the base_crng is old enough, we reseed, which in turn bumps the
+	 * generation counter that we check below.
+	 */
+	if (unlikely(crng_has_old_seed()))
+		crng_reseed();
 
-		if (crng_init < 2 && entropy_bits >= 128) {
-			crng_reseed(&primary_crng, r);
-			entropy_bits = r->entropy_count >> ENTROPY_SHIFT;
-		}
+	local_lock_irqsave(crngs.lock, flags);
+	crng = raw_cpu_ptr(&crngs);
 
-		/* should we wake readers? */
-		if (entropy_bits >= random_read_wakeup_bits) {
-			wake_up_interruptible(&random_read_wait);
-			kill_fasync(&fasync, SIGIO, POLL_IN);
-		}
-		/* If the input pool is getting full, send some
-		 * entropy to the blocking pool until it is 75% full.
-		 */
-		if (entropy_bits > random_write_wakeup_bits &&
-		    r->initialized &&
-		    r->entropy_total >= 2*random_read_wakeup_bits) {
-			struct entropy_store *other = &blocking_pool;
-
-			if (other->entropy_count <=
-			    3 * other->poolinfo->poolfracbits / 4) {
-				schedule_work(&other->push_work);
-				r->entropy_total = 0;
-			}
-		}
+	/*
+	 * If our per-cpu crng is older than the base_crng, then it means
+	 * somebody reseeded the base_crng. In that case, we do fast key
+	 * erasure on the base_crng, and use its output as the new key
+	 * for our per-cpu crng. This brings us up to date with base_crng.
+	 */
+	if (unlikely(crng->generation != READ_ONCE(base_crng.generation))) {
+		spin_lock(&base_crng.lock);
+		crng_fast_key_erasure(base_crng.key, chacha_state,
+				      crng->key, sizeof(crng->key));
+		crng->generation = base_crng.generation;
+		spin_unlock(&base_crng.lock);
 	}
+
+	/*
+	 * Finally, when we've made it this far, our per-cpu crng has an up
+	 * to date key, and we can do fast key erasure with it to produce
+	 * some random data and a ChaCha state for the caller. All other
+	 * branches of this function are "unlikely", so most of the time we
+	 * should wind up here immediately.
+	 */
+	crng_fast_key_erasure(crng->key, chacha_state, random_data, random_data_len);
+	local_unlock_irqrestore(crngs.lock, flags);
 }
 
-static int credit_entropy_bits_safe(struct entropy_store *r, int nbits)
+static void _get_random_bytes(void *buf, size_t len)
 {
-	const int nbits_max = r->poolinfo->poolwords * 32;
+	u32 chacha_state[CHACHA20_BLOCK_SIZE / sizeof(u32)];
+	u8 tmp[CHACHA20_BLOCK_SIZE];
+	size_t first_block_len;
 
-	if (nbits < 0)
-		return -EINVAL;
+	if (!len)
+		return;
 
-	/* Cap the value to avoid overflows */
-	nbits = min(nbits,  nbits_max);
+	first_block_len = min_t(size_t, 32, len);
+	crng_make_state(chacha_state, buf, first_block_len);
+	len -= first_block_len;
+	buf += first_block_len;
 
-	credit_entropy_bits(r, nbits);
-	return 0;
-}
-
-/*********************************************************************
- *
- * CRNG using CHACHA20
- *
- *********************************************************************/
+	while (len) {
+		if (len < CHACHA20_BLOCK_SIZE) {
+			chacha20_block(chacha_state, tmp);
+			memcpy(buf, tmp, len);
+			memzero_explicit(tmp, sizeof(tmp));
+			break;
+		}
 
-#define CRNG_RESEED_INTERVAL (300*HZ)
+		chacha20_block(chacha_state, buf);
+		if (unlikely(chacha_state[12] == 0))
+			++chacha_state[13];
+		len -= CHACHA20_BLOCK_SIZE;
+		buf += CHACHA20_BLOCK_SIZE;
+	}
 
-static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
+	memzero_explicit(chacha_state, sizeof(chacha_state));
+}
 
-#ifdef CONFIG_NUMA
 /*
- * Hack to deal with crazy userspace progams when they are all trying
- * to access /dev/urandom in parallel.  The programs are almost
- * certainly doing something terribly wrong, but we'll work around
- * their brain damage.
+ * This function is the exported kernel interface.  It returns some
+ * number of good random numbers, suitable for key generation, seeding
+ * TCP sequence numbers, etc.  It does not rely on the hardware random
+ * number generator.  For random bytes direct from the hardware RNG
+ * (when available), use get_random_bytes_arch(). In order to ensure
+ * that the randomness provided by this function is okay, the function
+ * wait_for_random_bytes() should be called and return 0 at least once
+ * at any point prior.
  */
-static struct crng_state **crng_node_pool __read_mostly;
-#endif
-
-static void crng_initialize(struct crng_state *crng)
+void get_random_bytes(void *buf, size_t len)
 {
-	int		i;
-	unsigned long	rv;
-
-	memcpy(&crng->state[0], "expand 32-byte k", 16);
-	if (crng == &primary_crng)
-		_extract_entropy(&input_pool, &crng->state[4],
-				 sizeof(__u32) * 12, 0);
-	else
-		get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
-	for (i = 4; i < 16; i++) {
-		if (!arch_get_random_seed_long(&rv) &&
-		    !arch_get_random_long(&rv))
-			rv = random_get_entropy();
-		crng->state[i] ^= rv;
-	}
-	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
+	warn_unseeded_randomness();
+	_get_random_bytes(buf, len);
 }
+EXPORT_SYMBOL(get_random_bytes);
 
-static int crng_fast_load(const char *cp, size_t len)
+static ssize_t get_random_bytes_user(struct iov_iter *iter)
 {
-	unsigned long flags;
-	char *p;
+	u32 chacha_state[CHACHA20_BLOCK_SIZE / sizeof(u32)];
+	u8 block[CHACHA20_BLOCK_SIZE];
+	size_t ret = 0, copied;
 
-	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
+	if (unlikely(!iov_iter_count(iter)))
 		return 0;
-	if (crng_init != 0) {
-		spin_unlock_irqrestore(&primary_crng.lock, flags);
-		return 0;
-	}
-	p = (unsigned char *) &primary_crng.state[4];
-	while (len > 0 && crng_init_cnt < CRNG_INIT_CNT_THRESH) {
-		p[crng_init_cnt % CHACHA20_KEY_SIZE] ^= *cp;
-		cp++; crng_init_cnt++; len--;
-	}
-	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
-		crng_init = 1;
-		wake_up_interruptible(&crng_init_wait);
-		pr_notice("random: fast init done\n");
-	}
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
-	return 1;
-}
 
-#ifdef CONFIG_NUMA
-static void do_numa_crng_init(struct work_struct *work)
-{
-	int i;
-	struct crng_state *crng;
-	struct crng_state **pool;
-
-	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
-	for_each_online_node(i) {
-		crng = kmalloc_node(sizeof(struct crng_state),
-				    GFP_KERNEL | __GFP_NOFAIL, i);
-		spin_lock_init(&crng->lock);
-		crng_initialize(crng);
-		pool[i] = crng;
-	}
-	/* pairs with READ_ONCE() in select_crng() */
-	if (cmpxchg_release(&crng_node_pool, NULL, pool) != NULL) {
-		for_each_node(i)
-			kfree(pool[i]);
-		kfree(pool);
+	/*
+	 * Immediately overwrite the ChaCha key at index 4 with random
+	 * bytes, in case userspace causes copy_to_user() below to sleep
+	 * forever, so that we still retain forward secrecy in that case.
+	 */
+	crng_make_state(chacha_state, (u8 *)&chacha_state[4], CHACHA20_KEY_SIZE);
+	/*
+	 * However, if we're doing a read of len <= 32, we don't need to
+	 * use chacha_state after, so we can simply return those bytes to
+	 * the user directly.
+	 */
+	if (iov_iter_count(iter) <= CHACHA20_KEY_SIZE) {
+		ret = copy_to_iter(&chacha_state[4], CHACHA20_KEY_SIZE, iter);
+		goto out_zero_chacha;
 	}
-}
-
-static DECLARE_WORK(numa_crng_init_work, do_numa_crng_init);
 
-static void numa_crng_init(void)
-{
-	schedule_work(&numa_crng_init_work);
-}
-
-static struct crng_state *select_crng(void)
-{
-	struct crng_state **pool;
-	int nid = numa_node_id();
+	for (;;) {
+		chacha20_block(chacha_state, block);
+		if (unlikely(chacha_state[12] == 0))
+			++chacha_state[13];
 
-	/* pairs with cmpxchg_release() in do_numa_crng_init() */
-	pool = READ_ONCE(crng_node_pool);
-	if (pool && pool[nid])
-		return pool[nid];
-
-	return &primary_crng;
-}
-#else
-static void numa_crng_init(void) {}
-
-static struct crng_state *select_crng(void)
-{
-	return &primary_crng;
-}
-#endif
+		copied = copy_to_iter(block, sizeof(block), iter);
+		ret += copied;
+		if (!iov_iter_count(iter) || copied != sizeof(block))
+			break;
 
-static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
-{
-	unsigned long	flags;
-	int		i, num;
-	union {
-		__u8	block[CHACHA20_BLOCK_SIZE];
-		__u32	key[8];
-	} buf;
-
-	if (r) {
-		num = extract_entropy(r, &buf, 32, 16, 0);
-		if (num == 0)
-			return;
-	} else {
-		_extract_crng(&primary_crng, buf.block);
-		_crng_backtrack_protect(&primary_crng, buf.block,
-					CHACHA20_KEY_SIZE);
-	}
-	spin_lock_irqsave(&crng->lock, flags);
-	for (i = 0; i < 8; i++) {
-		unsigned long	rv;
-		if (!arch_get_random_seed_long(&rv) &&
-		    !arch_get_random_long(&rv))
-			rv = random_get_entropy();
-		crng->state[i+4] ^= buf.key[i] ^ rv;
-	}
-	memzero_explicit(&buf, sizeof(buf));
-	WRITE_ONCE(crng->init_time, jiffies);
-	if (crng == &primary_crng && crng_init < 2) {
-		numa_crng_init();
-		crng_init = 2;
-		process_random_ready_list();
-		wake_up_interruptible(&crng_init_wait);
-		pr_notice("random: crng init done\n");
-		if (unseeded_warning.missed) {
-			pr_notice("random: %d get_random_xx warning(s) missed "
-				  "due to ratelimiting\n",
-				  unseeded_warning.missed);
-			unseeded_warning.missed = 0;
-		}
-		if (urandom_warning.missed) {
-			pr_notice("random: %d urandom warning(s) missed "
-				  "due to ratelimiting\n",
-				  urandom_warning.missed);
-			urandom_warning.missed = 0;
+		BUILD_BUG_ON(PAGE_SIZE % sizeof(block) != 0);
+		if (ret % PAGE_SIZE == 0) {
+			if (signal_pending(current))
+				break;
+			cond_resched();
 		}
 	}
-	spin_unlock_irqrestore(&crng->lock, flags);
-}
 
-static inline void maybe_reseed_primary_crng(void)
-{
-	if (crng_init > 2 &&
-	    time_after(jiffies, primary_crng.init_time + CRNG_RESEED_INTERVAL))
-		crng_reseed(&primary_crng, &input_pool);
+	memzero_explicit(block, sizeof(block));
+out_zero_chacha:
+	memzero_explicit(chacha_state, sizeof(chacha_state));
+	return ret ? ret : -EFAULT;
 }
 
-static inline void crng_wait_ready(void)
-{
-	wait_event_interruptible(crng_init_wait, crng_ready());
-}
-
-static void _extract_crng(struct crng_state *crng,
-			  __u8 out[CHACHA20_BLOCK_SIZE])
-{
-	unsigned long v, flags, init_time;
-
-	if (crng_ready()) {
-		init_time = READ_ONCE(crng->init_time);
-		if (time_after(READ_ONCE(crng_global_init_time), init_time) ||
-		    time_after(jiffies, init_time + CRNG_RESEED_INTERVAL))
-			crng_reseed(crng, crng == &primary_crng ?
-				    &input_pool : NULL);
-	}
-	spin_lock_irqsave(&crng->lock, flags);
-	if (arch_get_random_long(&v))
-		crng->state[14] ^= v;
-	chacha20_block(&crng->state[0], out);
-	if (crng->state[12] == 0)
-		crng->state[13]++;
-	spin_unlock_irqrestore(&crng->lock, flags);
-}
-
-static void extract_crng(__u8 out[CHACHA20_BLOCK_SIZE])
-{
-	_extract_crng(select_crng(), out);
-}
+/*
+ * Batched entropy returns random integers. The quality of the random
+ * number is good as /dev/urandom. In order to ensure that the randomness
+ * provided by this function is okay, the function wait_for_random_bytes()
+ * should be called and return 0 at least once at any point prior.
+ */
 
+#define DEFINE_BATCHED_ENTROPY(type)						\
+struct batch_ ##type {								\
+	/*									\
+	 * We make this 1.5x a ChaCha block, so that we get the			\
+	 * remaining 32 bytes from fast key erasure, plus one full		\
+	 * block from the detached ChaCha state. We can increase		\
+	 * the size of this later if needed so long as we keep the		\
+	 * formula of (integer_blocks + 0.5) * CHACHA20_BLOCK_SIZE.		\
+	 */									\
+	type entropy[CHACHA20_BLOCK_SIZE * 3 / (2 * sizeof(type))];		\
+	struct local_irq_lock lock;						\
+	unsigned long generation;						\
+	unsigned int position;							\
+};										\
+										\
+static DEFINE_PER_CPU(struct batch_ ##type, batched_entropy_ ##type) = {	\
+	.lock = INIT_LOCAL_LOCK(batched_entropy_ ##type.lock),			\
+	.position = UINT_MAX							\
+};										\
+										\
+type get_random_ ##type(void)							\
+{										\
+	type ret;								\
+	unsigned long flags;							\
+	struct batch_ ##type *batch;						\
+	unsigned long next_gen;							\
+										\
+	warn_unseeded_randomness();						\
+										\
+	if  (!crng_ready()) {							\
+		_get_random_bytes(&ret, sizeof(ret));				\
+		return ret;							\
+	}									\
+										\
+	local_lock_irqsave(batched_entropy_ ##type.lock, flags);		\
+	batch = raw_cpu_ptr(&batched_entropy_##type);				\
+										\
+	next_gen = READ_ONCE(base_crng.generation);				\
+	if (batch->position >= ARRAY_SIZE(batch->entropy) ||			\
+	    next_gen != batch->generation) {					\
+		_get_random_bytes(batch->entropy, sizeof(batch->entropy));	\
+		batch->position = 0;						\
+		batch->generation = next_gen;					\
+	}									\
+										\
+	ret = batch->entropy[batch->position];					\
+	batch->entropy[batch->position] = 0;					\
+	++batch->position;							\
+	local_unlock_irqrestore(batched_entropy_ ##type.lock, flags);		\
+	return ret;								\
+}										\
+EXPORT_SYMBOL(get_random_ ##type);
+
+DEFINE_BATCHED_ENTROPY(u64)
+DEFINE_BATCHED_ENTROPY(u32)
+
+#ifdef CONFIG_SMP
 /*
- * Use the leftover bytes from the CRNG block output (if there is
- * enough) to mutate the CRNG key to provide backtracking protection.
+ * This function is called when the CPU is coming up, with entry
+ * CPUHP_RANDOM_PREPARE, which comes before CPUHP_WORKQUEUE_PREP.
  */
-static void _crng_backtrack_protect(struct crng_state *crng,
-				    __u8 tmp[CHACHA20_BLOCK_SIZE], int used)
+int __cold random_prepare_cpu(unsigned int cpu)
 {
-	unsigned long	flags;
-	__u32		*s, *d;
-	int		i;
-
-	used = round_up(used, sizeof(__u32));
-	if (used + CHACHA20_KEY_SIZE > CHACHA20_BLOCK_SIZE) {
-		extract_crng(tmp);
-		used = 0;
-	}
-	spin_lock_irqsave(&crng->lock, flags);
-	s = (__u32 *) &tmp[used];
-	d = &crng->state[4];
-	for (i=0; i < 8; i++)
-		*d++ ^= *s++;
-	spin_unlock_irqrestore(&crng->lock, flags);
+	/*
+	 * When the cpu comes back online, immediately invalidate both
+	 * the per-cpu crng and all batches, so that we serve fresh
+	 * randomness.
+	 */
+	per_cpu_ptr(&crngs, cpu)->generation = ULONG_MAX;
+	per_cpu_ptr(&batched_entropy_u32, cpu)->position = UINT_MAX;
+	per_cpu_ptr(&batched_entropy_u64, cpu)->position = UINT_MAX;
+	return 0;
 }
+#endif
 
-static void crng_backtrack_protect(__u8 tmp[CHACHA20_BLOCK_SIZE], int used)
+/*
+ * This function will use the architecture-specific hardware random
+ * number generator if it is available. It is not recommended for
+ * use. Use get_random_bytes() instead. It returns the number of
+ * bytes filled in.
+ */
+size_t __must_check get_random_bytes_arch(void *buf, size_t len)
 {
-	_crng_backtrack_protect(select_crng(), tmp, used);
-}
+	size_t left = len;
+	u8 *p = buf;
 
-static ssize_t extract_crng_user(void __user *buf, size_t nbytes)
-{
-	ssize_t ret = 0, i = CHACHA20_BLOCK_SIZE;
-	__u8 tmp[CHACHA20_BLOCK_SIZE];
-	int large_request = (nbytes > 256);
-
-	while (nbytes) {
-		if (large_request && need_resched()) {
-			if (signal_pending(current)) {
-				if (ret == 0)
-					ret = -ERESTARTSYS;
-				break;
-			}
-			schedule();
-		}
+	while (left) {
+		unsigned long v;
+		size_t block_len = min_t(size_t, left, sizeof(unsigned long));
 
-		extract_crng(tmp);
-		i = min_t(int, nbytes, CHACHA20_BLOCK_SIZE);
-		if (copy_to_user(buf, tmp, i)) {
-			ret = -EFAULT;
+		if (!arch_get_random_long(&v))
 			break;
-		}
 
-		nbytes -= i;
-		buf += i;
-		ret += i;
+		memcpy(p, &v, block_len);
+		p += block_len;
+		left -= block_len;
 	}
-	crng_backtrack_protect(tmp, i);
-
-	/* Wipe data just written to memory */
-	memzero_explicit(tmp, sizeof(tmp));
 
-	return ret;
+	return len - left;
 }
+EXPORT_SYMBOL(get_random_bytes_arch);
 
 
-/*********************************************************************
+/**********************************************************************
  *
- * Entropy input management
+ * Entropy accumulation and extraction routines.
  *
- *********************************************************************/
+ * Callers may add entropy via:
+ *
+ *     static void mix_pool_bytes(const void *buf, size_t len)
+ *
+ * After which, if added entropy should be credited:
+ *
+ *     static void credit_init_bits(size_t bits)
+ *
+ * Finally, extract entropy via:
+ *
+ *     static void extract_entropy(void *buf, size_t len)
+ *
+ **********************************************************************/
 
-/* There is one of these per entropy source */
-struct timer_rand_state {
-	cycles_t last_time;
-	long last_delta, last_delta2;
-	unsigned dont_count_entropy:1;
+enum {
+	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
+	POOL_READY_BITS = POOL_BITS, /* When crng_init->CRNG_READY */
+	POOL_EARLY_BITS = POOL_READY_BITS / 2 /* When crng_init->CRNG_EARLY */
 };
 
-#define INIT_TIMER_RAND_STATE { INITIAL_JIFFIES, };
+static struct {
+	struct blake2s_state hash;
+	spinlock_t lock;
+	unsigned int init_bits;
+} input_pool = {
+	.hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
+		    BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
+		    BLAKE2S_IV5, BLAKE2S_IV6, BLAKE2S_IV7 },
+	.hash.outlen = BLAKE2S_HASH_SIZE,
+	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
+};
+
+static void _mix_pool_bytes(const void *buf, size_t len)
+{
+	blake2s_update(&input_pool.hash, buf, len);
+}
 
 /*
- * Add device- or boot-specific data to the input pool to help
- * initialize it.
- *
- * None of this adds any entropy; it is meant to avoid the problem of
- * the entropy pool having similar initial state across largely
- * identical devices.
+ * This function adds bytes into the input pool. It does not
+ * update the initialization bit counter; the caller should call
+ * credit_init_bits if this is appropriate.
  */
-void add_device_randomness(const void *buf, unsigned int size)
+static void mix_pool_bytes(const void *buf, size_t len)
 {
-	unsigned long time = random_get_entropy() ^ jiffies;
 	unsigned long flags;
 
-	trace_add_device_randomness(size, _RET_IP_);
 	spin_lock_irqsave(&input_pool.lock, flags);
-	_mix_pool_bytes(&input_pool, buf, size);
-	_mix_pool_bytes(&input_pool, &time, sizeof(time));
+	_mix_pool_bytes(buf, len);
 	spin_unlock_irqrestore(&input_pool.lock, flags);
 }
-EXPORT_SYMBOL(add_device_randomness);
-
-static struct timer_rand_state input_timer_state = INIT_TIMER_RAND_STATE;
 
 /*
- * This function adds entropy to the entropy "pool" by using timing
- * delays.  It uses the timer_rand_state structure to make an estimate
- * of how many bits of entropy this call has added to the pool.
- *
- * The number "num" is also added to the pool - it should somehow describe
- * the type of event which just happened.  This is currently 0-255 for
- * keyboard scan codes, and 256 upwards for interrupts.
- *
+ * This is an HKDF-like construction for using the hashed collected entropy
+ * as a PRF key, that's then expanded block-by-block.
  */
-static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
+static void extract_entropy(void *buf, size_t len)
 {
-	struct entropy_store	*r;
+	unsigned long flags;
+	u8 seed[BLAKE2S_HASH_SIZE], next_key[BLAKE2S_HASH_SIZE];
 	struct {
-		long jiffies;
-		unsigned cycles;
-		unsigned num;
-	} sample;
-	long delta, delta2, delta3;
-
-	sample.jiffies = jiffies;
-	sample.cycles = random_get_entropy();
-	sample.num = num;
-	r = &input_pool;
-	mix_pool_bytes(r, &sample, sizeof(sample));
-
-	/*
-	 * Calculate number of bits of randomness we probably added.
-	 * We take into account the first, second and third-order deltas
-	 * in order to make our estimate.
-	 */
-
-	if (!state->dont_count_entropy) {
-		delta = sample.jiffies - state->last_time;
-		state->last_time = sample.jiffies;
-
-		delta2 = delta - state->last_delta;
-		state->last_delta = delta;
-
-		delta3 = delta2 - state->last_delta2;
-		state->last_delta2 = delta2;
-
-		if (delta < 0)
-			delta = -delta;
-		if (delta2 < 0)
-			delta2 = -delta2;
-		if (delta3 < 0)
-			delta3 = -delta3;
-		if (delta > delta2)
-			delta = delta2;
-		if (delta > delta3)
-			delta = delta3;
-
-		/*
-		 * delta is now minimum absolute delta.
-		 * Round down by 1 bit on general principles,
-		 * and limit entropy entimate to 12 bits.
-		 */
-		credit_entropy_bits(r, min_t(int, fls(delta>>1), 11));
+		unsigned long rdseed[32 / sizeof(long)];
+		size_t counter;
+	} block;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(block.rdseed); ++i) {
+		if (!arch_get_random_seed_long(&block.rdseed[i]) &&
+		    !arch_get_random_long(&block.rdseed[i]))
+			block.rdseed[i] = random_get_entropy();
 	}
-}
 
-void add_input_randomness(unsigned int type, unsigned int code,
-				 unsigned int value)
-{
-	static unsigned char last_value;
-
-	/* ignore autorepeat and the like */
-	if (value == last_value)
-		return;
-
-	last_value = value;
-	add_timer_randomness(&input_timer_state,
-			     (type << 4) ^ code ^ (code >> 4) ^ value);
-	trace_add_input_randomness(ENTROPY_BITS(&input_pool));
-}
-EXPORT_SYMBOL_GPL(add_input_randomness);
+	spin_lock_irqsave(&input_pool.lock, flags);
 
-static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
+	/* seed = HASHPRF(last_key, entropy_input) */
+	blake2s_final(&input_pool.hash, seed);
 
-#ifdef ADD_INTERRUPT_BENCH
-static unsigned long avg_cycles, avg_deviation;
+	/* next_key = HASHPRF(seed, RDSEED || 0) */
+	block.counter = 0;
+	blake2s(next_key, (u8 *)&block, seed, sizeof(next_key), sizeof(block), sizeof(seed));
+	blake2s_init_key(&input_pool.hash, BLAKE2S_HASH_SIZE, next_key, sizeof(next_key));
 
-#define AVG_SHIFT 8     /* Exponential average factor k=1/256 */
-#define FIXED_1_2 (1 << (AVG_SHIFT-1))
+	spin_unlock_irqrestore(&input_pool.lock, flags);
+	memzero_explicit(next_key, sizeof(next_key));
+
+	while (len) {
+		i = min_t(size_t, len, BLAKE2S_HASH_SIZE);
+		/* output = HASHPRF(seed, RDSEED || ++counter) */
+		++block.counter;
+		blake2s(buf, (u8 *)&block, seed, i, sizeof(block), sizeof(seed));
+		len -= i;
+		buf += i;
+	}
 
-static void add_interrupt_bench(cycles_t start)
-{
-        long delta = random_get_entropy() - start;
-
-        /* Use a weighted moving average */
-        delta = delta - ((avg_cycles + FIXED_1_2) >> AVG_SHIFT);
-        avg_cycles += delta;
-        /* And average deviation */
-        delta = abs(delta) - ((avg_deviation + FIXED_1_2) >> AVG_SHIFT);
-        avg_deviation += delta;
+	memzero_explicit(seed, sizeof(seed));
+	memzero_explicit(&block, sizeof(block));
 }
-#else
-#define add_interrupt_bench(x)
-#endif
 
-static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
-{
-	__u32 *ptr = (__u32 *) regs;
-	unsigned int idx;
-
-	if (regs == NULL)
-		return 0;
-	idx = READ_ONCE(f->reg_idx);
-	if (idx >= sizeof(struct pt_regs) / sizeof(__u32))
-		idx = 0;
-	ptr += idx++;
-	WRITE_ONCE(f->reg_idx, idx);
-	return *ptr;
-}
+#define credit_init_bits(bits) if (!crng_ready()) _credit_init_bits(bits)
 
-void add_interrupt_randomness(int irq, int irq_flags, __u64 ip)
+static void __cold _credit_init_bits(size_t bits)
 {
-	struct entropy_store	*r;
-	struct fast_pool	*fast_pool = this_cpu_ptr(&irq_randomness);
-	unsigned long		now = jiffies;
-	cycles_t		cycles = random_get_entropy();
-	__u32			c_high, j_high;
-	unsigned long		seed;
-	int			credit = 0;
-
-	if (cycles == 0)
-		cycles = get_reg(fast_pool, NULL);
-	c_high = (sizeof(cycles) > 4) ? cycles >> 32 : 0;
-	j_high = (sizeof(now) > 4) ? now >> 32 : 0;
-	fast_pool->pool[0] ^= cycles ^ j_high ^ irq;
-	fast_pool->pool[1] ^= now ^ c_high;
-	if (!ip)
-		ip = _RET_IP_;
-	fast_pool->pool[2] ^= ip;
-	fast_pool->pool[3] ^= (sizeof(ip) > 4) ? ip >> 32 :
-		get_reg(fast_pool, NULL);
-
-	fast_mix(fast_pool);
-	add_interrupt_bench(cycles);
-
-	if (unlikely(crng_init == 0)) {
-		if ((fast_pool->count >= 64) &&
-		    crng_fast_load((char *) fast_pool->pool,
-				   sizeof(fast_pool->pool))) {
-			fast_pool->count = 0;
-			fast_pool->last = now;
-		}
-		return;
-	}
+	unsigned int new, orig, add;
+	unsigned long flags;
 
-	if ((fast_pool->count < 64) &&
-	    !time_after(now, fast_pool->last + HZ))
+	if (!bits)
 		return;
 
-	r = &input_pool;
-	if (!spin_trylock(&r->lock))
-		return;
+	add = min_t(size_t, bits, POOL_BITS);
 
-	fast_pool->last = now;
-	__mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool));
+	do {
+		orig = READ_ONCE(input_pool.init_bits);
+		new = min_t(unsigned int, POOL_BITS, orig + add);
+	} while (cmpxchg(&input_pool.init_bits, orig, new) != orig);
 
-	/*
-	 * If we have architectural seed generator, produce a seed and
-	 * add it to the pool.  For the sake of paranoia don't let the
-	 * architectural seed generator dominate the input from the
-	 * interrupt noise.
-	 */
-	if (arch_get_random_seed_long(&seed)) {
-		__mix_pool_bytes(r, &seed, sizeof(seed));
-		credit = 1;
+	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
+		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
+		process_random_ready_list();
+		wake_up_interruptible(&crng_init_wait);
+		kill_fasync(&fasync, SIGIO, POLL_IN);
+		pr_notice("crng init done\n");
+		if (urandom_warning.missed)
+			pr_notice("%d urandom warning(s) missed due to ratelimiting\n",
+				  urandom_warning.missed);
+	} else if (orig < POOL_EARLY_BITS && new >= POOL_EARLY_BITS) {
+		spin_lock_irqsave(&base_crng.lock, flags);
+		/* Check if crng_init is CRNG_EMPTY, to avoid race with crng_reseed(). */
+		if (crng_init == CRNG_EMPTY) {
+			extract_entropy(base_crng.key, sizeof(base_crng.key));
+			crng_init = CRNG_EARLY;
+		}
+		spin_unlock_irqrestore(&base_crng.lock, flags);
 	}
-	spin_unlock(&r->lock);
-
-	fast_pool->count = 0;
-
-	/* award one bit for the contents of the fast pool */
-	credit_entropy_bits(r, credit + 1);
 }
-EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
-#ifdef CONFIG_BLOCK
-void add_disk_randomness(struct gendisk *disk)
-{
-	if (!disk || !disk->random)
-		return;
-	/* first major is 1, so we get >= 0x200 here */
-	add_timer_randomness(disk->random, 0x100 + disk_devt(disk));
-	trace_add_disk_randomness(disk_devt(disk), ENTROPY_BITS(&input_pool));
-}
-EXPORT_SYMBOL_GPL(add_disk_randomness);
-#endif
 
-/*********************************************************************
+/**********************************************************************
  *
- * Entropy extraction routines
+ * Entropy collection routines.
  *
- *********************************************************************/
-
-/*
- * This utility inline function is responsible for transferring entropy
- * from the primary pool to the secondary extraction pool. We make
- * sure we pull enough for a 'catastrophic reseed'.
- */
-static void _xfer_secondary_pool(struct entropy_store *r, size_t nbytes);
-static void xfer_secondary_pool(struct entropy_store *r, size_t nbytes)
-{
-	if (!r->pull ||
-	    r->entropy_count >= (nbytes << (ENTROPY_SHIFT + 3)) ||
-	    r->entropy_count > r->poolinfo->poolfracbits)
-		return;
-
-	if (r->limit == 0 && random_min_urandom_seed) {
-		unsigned long now = jiffies;
-
-		if (time_before(now,
-				r->last_pulled + random_min_urandom_seed * HZ))
-			return;
-		r->last_pulled = now;
-	}
-
-	_xfer_secondary_pool(r, nbytes);
-}
-
-static void _xfer_secondary_pool(struct entropy_store *r, size_t nbytes)
-{
-	__u32	tmp[OUTPUT_POOL_WORDS];
-
-	/* For /dev/random's pool, always leave two wakeups' worth */
-	int rsvd_bytes = r->limit ? 0 : random_read_wakeup_bits / 4;
-	int bytes = nbytes;
-
-	/* pull at least as much as a wakeup */
-	bytes = max_t(int, bytes, random_read_wakeup_bits / 8);
-	/* but never more than the buffer size */
-	bytes = min_t(int, bytes, sizeof(tmp));
-
-	trace_xfer_secondary_pool(r->name, bytes * 8, nbytes * 8,
-				  ENTROPY_BITS(r), ENTROPY_BITS(r->pull));
-	bytes = extract_entropy(r->pull, tmp, bytes,
-				random_read_wakeup_bits / 8, rsvd_bytes);
-	mix_pool_bytes(r, tmp, bytes);
-	credit_entropy_bits(r, bytes*8);
-}
+ * The following exported functions are used for pushing entropy into
+ * the above entropy accumulation routines:
+ *
+ *	void add_device_randomness(const void *buf, size_t len);
+ *	void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
+ *	void add_bootloader_randomness(const void *buf, size_t len);
+ *	void add_interrupt_randomness(int irq);
+ *	void add_input_randomness(unsigned int type, unsigned int code, unsigned int value);
+ *	void add_disk_randomness(struct gendisk *disk);
+ *
+ * add_device_randomness() adds data to the input pool that
+ * is likely to differ between two devices (or possibly even per boot).
+ * This would be things like MAC addresses or serial numbers, or the
+ * read-out of the RTC. This does *not* credit any actual entropy to
+ * the pool, but it initializes the pool to different values for devices
+ * that might otherwise be identical and have very little entropy
+ * available to them (particularly common in the embedded world).
+ *
+ * add_hwgenerator_randomness() is for true hardware RNGs, and will credit
+ * entropy as specified by the caller. If the entropy pool is full it will
+ * block until more entropy is needed.
+ *
+ * add_bootloader_randomness() is called by bootloader drivers, such as EFI
+ * and device tree, and credits its input depending on whether or not the
+ * configuration option CONFIG_RANDOM_TRUST_BOOTLOADER is set.
+ *
+ * add_interrupt_randomness() uses the interrupt timing as random
+ * inputs to the entropy pool. Using the cycle counters and the irq source
+ * as inputs, it feeds the input pool roughly once a second or after 64
+ * interrupts, crediting 1 bit of entropy for whichever comes first.
+ *
+ * add_input_randomness() uses the input layer interrupt timing, as well
+ * as the event type information from the hardware.
+ *
+ * add_disk_randomness() uses what amounts to the seek time of block
+ * layer request events, on a per-disk_devt basis, as input to the
+ * entropy pool. Note that high-speed solid state drives with very low
+ * seek times do not make for good sources of entropy, as their seek
+ * times are usually fairly consistent.
+ *
+ * The last two routines try to estimate how many bits of entropy
+ * to credit. They do this by keeping track of the first and second
+ * order deltas of the event timings.
+ *
+ **********************************************************************/
 
-/*
- * Used as a workqueue function so that when the input pool is getting
- * full, we can "spill over" some entropy to the output pools.  That
- * way the output pools can store some of the excess entropy instead
- * of letting it go to waste.
- */
-static void push_to_pool(struct work_struct *work)
+static bool trust_cpu __initdata = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
+static bool trust_bootloader __initdata = IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER);
+static int __init parse_trust_cpu(char *arg)
 {
-	struct entropy_store *r = container_of(work, struct entropy_store,
-					      push_work);
-	BUG_ON(!r);
-	_xfer_secondary_pool(r, random_read_wakeup_bits/8);
-	trace_push_to_pool(r->name, r->entropy_count >> ENTROPY_SHIFT,
-			   r->pull->entropy_count >> ENTROPY_SHIFT);
+	return kstrtobool(arg, &trust_cpu);
 }
-
-/*
- * This function decides how many bytes to actually take from the
- * given pool, and also debits the entropy count accordingly.
- */
-static size_t account(struct entropy_store *r, size_t nbytes, int min,
-		      int reserved)
+static int __init parse_trust_bootloader(char *arg)
 {
-	int entropy_count, orig;
-	size_t ibytes, nfrac;
-
-	BUG_ON(r->entropy_count > r->poolinfo->poolfracbits);
-
-	/* Can we pull enough? */
-retry:
-	entropy_count = orig = ACCESS_ONCE(r->entropy_count);
-	ibytes = nbytes;
-	/* If limited, never pull more than available */
-	if (r->limit) {
-		int have_bytes = entropy_count >> (ENTROPY_SHIFT + 3);
-
-		if ((have_bytes -= reserved) < 0)
-			have_bytes = 0;
-		ibytes = min_t(size_t, ibytes, have_bytes);
-	}
-	if (ibytes < min)
-		ibytes = 0;
-
-	if (unlikely(entropy_count < 0)) {
-		pr_warn("random: negative entropy count: pool %s count %d\n",
-			r->name, entropy_count);
-		WARN_ON(1);
-		entropy_count = 0;
-	}
-	nfrac = ibytes << (ENTROPY_SHIFT + 3);
-	if ((size_t) entropy_count > nfrac)
-		entropy_count -= nfrac;
-	else
-		entropy_count = 0;
-
-	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
-		goto retry;
-
-	trace_debit_entropy(r->name, 8 * ibytes);
-	if (ibytes &&
-	    (r->entropy_count >> ENTROPY_SHIFT) < random_write_wakeup_bits) {
-		wake_up_interruptible(&random_write_wait);
-		kill_fasync(&fasync, SIGIO, POLL_OUT);
-	}
-
-	return ibytes;
+	return kstrtobool(arg, &trust_bootloader);
 }
+early_param("random.trust_cpu", parse_trust_cpu);
+early_param("random.trust_bootloader", parse_trust_bootloader);
 
 /*
- * This function does the actual extraction for extract_entropy and
- * extract_entropy_user.
- *
- * Note: we assume that .poolwords is a multiple of 16 words.
+ * The first collection of entropy occurs at system boot while interrupts
+ * are still turned off. Here we push in latent entropy, RDSEED, a timestamp,
+ * utsname(), and the command line. Depending on the above configuration knob,
+ * RDSEED may be considered sufficient for initialization. Note that much
+ * earlier setup may already have pushed entropy into the input pool by the
+ * time we get here.
  */
-static void extract_buf(struct entropy_store *r, __u8 *out)
+int __init random_init(const char *command_line)
 {
-	int i;
-	union {
-		__u32 w[5];
-		unsigned long l[LONGS(20)];
-	} hash;
-	__u32 workspace[SHA_WORKSPACE_WORDS];
-	unsigned long flags;
-
-	/*
-	 * If we have an architectural hardware random number
-	 * generator, use it for SHA's initial vector
-	 */
-	sha_init(hash.w);
-	for (i = 0; i < LONGS(20); i++) {
-		unsigned long v;
-		if (!arch_get_random_long(&v))
-			break;
-		hash.l[i] = v;
-	}
-
-	/* Generate a hash across the pool, 16 words (512 bits) at a time */
-	spin_lock_irqsave(&r->lock, flags);
-	for (i = 0; i < r->poolinfo->poolwords; i += 16)
-		sha_transform(hash.w, (__u8 *)(r->pool + i), workspace);
-
-	/*
-	 * We mix the hash back into the pool to prevent backtracking
-	 * attacks (where the attacker knows the state of the pool
-	 * plus the current outputs, and attempts to find previous
-	 * ouputs), unless the hash function can be inverted. By
-	 * mixing at least a SHA1 worth of hash data back, we make
-	 * brute-forcing the feedback as hard as brute-forcing the
-	 * hash.
-	 */
-	__mix_pool_bytes(r, hash.w, sizeof(hash.w));
-	spin_unlock_irqrestore(&r->lock, flags);
-
-	memzero_explicit(workspace, sizeof(workspace));
-
-	/*
-	 * In case the hash function has some recognizable output
-	 * pattern, we fold it in half. Thus, we always feed back
-	 * twice as much data as we output.
-	 */
-	hash.w[0] ^= hash.w[3];
-	hash.w[1] ^= hash.w[4];
-	hash.w[2] ^= rol32(hash.w[2], 16);
-
-	memcpy(out, &hash, EXTRACT_SIZE);
-	memzero_explicit(&hash, sizeof(hash));
-}
-
-static ssize_t _extract_entropy(struct entropy_store *r, void *buf,
-				size_t nbytes, int fips)
-{
-	ssize_t ret = 0, i;
-	__u8 tmp[EXTRACT_SIZE];
-	unsigned long flags;
+	ktime_t now = ktime_get_real();
+	unsigned int i, arch_bits;
+	unsigned long entropy;
 
-	while (nbytes) {
-		extract_buf(r, tmp);
+#if defined(LATENT_ENTROPY_PLUGIN)
+	static const u8 compiletime_seed[BLAKE2S_BLOCK_SIZE] __initconst __latent_entropy;
+	_mix_pool_bytes(compiletime_seed, sizeof(compiletime_seed));
+#endif
 
-		if (fips) {
-			spin_lock_irqsave(&r->lock, flags);
-			if (!memcmp(tmp, r->last_data, EXTRACT_SIZE))
-				panic("Hardware RNG duplicated output!\n");
-			memcpy(r->last_data, tmp, EXTRACT_SIZE);
-			spin_unlock_irqrestore(&r->lock, flags);
+	for (i = 0, arch_bits = BLAKE2S_BLOCK_SIZE * 8;
+	     i < BLAKE2S_BLOCK_SIZE; i += sizeof(entropy)) {
+		if (!arch_get_random_seed_long_early(&entropy) &&
+		    !arch_get_random_long_early(&entropy)) {
+			entropy = random_get_entropy();
+			arch_bits -= sizeof(entropy) * 8;
 		}
-		i = min_t(int, nbytes, EXTRACT_SIZE);
-		memcpy(buf, tmp, i);
-		nbytes -= i;
-		buf += i;
-		ret += i;
+		_mix_pool_bytes(&entropy, sizeof(entropy));
 	}
+	_mix_pool_bytes(&now, sizeof(now));
+	_mix_pool_bytes(utsname(), sizeof(*(utsname())));
+	_mix_pool_bytes(command_line, strlen(command_line));
+	add_latent_entropy();
 
-	/* Wipe data just returned from memory */
-	memzero_explicit(tmp, sizeof(tmp));
+	if (crng_ready())
+		crng_reseed();
+	else if (trust_cpu)
+		_credit_init_bits(arch_bits);
 
-	return ret;
+	return 0;
 }
 
 /*
- * This function extracts randomness from the "entropy pool", and
- * returns it in a buffer.
+ * Add device- or boot-specific data to the input pool to help
+ * initialize it.
  *
- * The min parameter specifies the minimum amount we can pull before
- * failing to avoid races that defeat catastrophic reseeding while the
- * reserved parameter indicates how much entropy we must leave in the
- * pool after each pull to avoid starving other readers.
+ * None of this adds any entropy; it is meant to avoid the problem of
+ * the entropy pool having similar initial state across largely
+ * identical devices.
  */
-static ssize_t extract_entropy(struct entropy_store *r, void *buf,
-				 size_t nbytes, int min, int reserved)
+void add_device_randomness(const void *buf, size_t len)
 {
-	__u8 tmp[EXTRACT_SIZE];
+	unsigned long entropy = random_get_entropy();
 	unsigned long flags;
 
-	/* if last_data isn't primed, we need EXTRACT_SIZE extra bytes */
-	if (fips_enabled) {
-		spin_lock_irqsave(&r->lock, flags);
-		if (!r->last_data_init) {
-			r->last_data_init = 1;
-			spin_unlock_irqrestore(&r->lock, flags);
-			trace_extract_entropy(r->name, EXTRACT_SIZE,
-					      ENTROPY_BITS(r), _RET_IP_);
-			xfer_secondary_pool(r, EXTRACT_SIZE);
-			extract_buf(r, tmp);
-			spin_lock_irqsave(&r->lock, flags);
-			memcpy(r->last_data, tmp, EXTRACT_SIZE);
-		}
-		spin_unlock_irqrestore(&r->lock, flags);
-	}
-
-	trace_extract_entropy(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
-	xfer_secondary_pool(r, nbytes);
-	nbytes = account(r, nbytes, min, reserved);
-
-	return _extract_entropy(r, buf, nbytes, fips_enabled);
-}
-
-/*
- * This function extracts randomness from the "entropy pool", and
- * returns it in a userspace buffer.
- */
-static ssize_t extract_entropy_user(struct entropy_store *r, void __user *buf,
-				    size_t nbytes)
-{
-	ssize_t ret = 0, i;
-	__u8 tmp[EXTRACT_SIZE];
-	int large_request = (nbytes > 256);
-
-	trace_extract_entropy_user(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
-	xfer_secondary_pool(r, nbytes);
-	nbytes = account(r, nbytes, 0, 0);
-
-	while (nbytes) {
-		if (large_request && need_resched()) {
-			if (signal_pending(current)) {
-				if (ret == 0)
-					ret = -ERESTARTSYS;
-				break;
-			}
-			schedule();
-		}
-
-		extract_buf(r, tmp);
-		i = min_t(int, nbytes, EXTRACT_SIZE);
-		if (copy_to_user(buf, tmp, i)) {
-			ret = -EFAULT;
-			break;
-		}
-
-		nbytes -= i;
-		buf += i;
-		ret += i;
-	}
-
-	/* Wipe data just returned from memory */
-	memzero_explicit(tmp, sizeof(tmp));
-
-	return ret;
+	spin_lock_irqsave(&input_pool.lock, flags);
+	_mix_pool_bytes(&entropy, sizeof(entropy));
+	_mix_pool_bytes(buf, len);
+	spin_unlock_irqrestore(&input_pool.lock, flags);
 }
+EXPORT_SYMBOL(add_device_randomness);
 
 /*
- * This function is the exported kernel interface.  It returns some
- * number of good random numbers, suitable for key generation, seeding
- * TCP sequence numbers, etc.  It does not rely on the hardware random
- * number generator.  For random bytes direct from the hardware RNG
- * (when available), use get_random_bytes_arch().
+ * Interface for in-kernel drivers of true hardware RNGs.
+ * Those devices may produce endless random bits and will be throttled
+ * when our pool is full.
  */
-void get_random_bytes(void *buf, int nbytes)
+void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
 {
-	__u8 tmp[CHACHA20_BLOCK_SIZE];
-
-#if DEBUG_RANDOM_BOOT > 0
-	if (!crng_ready())
-		printk(KERN_NOTICE "random: %pF get_random_bytes called "
-		       "with crng_init = %d\n", (void *) _RET_IP_, crng_init);
-#endif
-	trace_get_random_bytes(nbytes, _RET_IP_);
-
-	while (nbytes >= CHACHA20_BLOCK_SIZE) {
-		extract_crng(buf);
-		buf += CHACHA20_BLOCK_SIZE;
-		nbytes -= CHACHA20_BLOCK_SIZE;
-	}
+	mix_pool_bytes(buf, len);
+	credit_init_bits(entropy);
 
-	if (nbytes > 0) {
-		extract_crng(tmp);
-		memcpy(buf, tmp, nbytes);
-		crng_backtrack_protect(tmp, nbytes);
-	} else
-		crng_backtrack_protect(tmp, CHACHA20_BLOCK_SIZE);
-	memzero_explicit(tmp, sizeof(tmp));
+	/*
+	 * Throttle writing to once every CRNG_RESEED_INTERVAL, unless
+	 * we're not yet initialized.
+	 */
+	if (!kthread_should_stop() && crng_ready())
+		schedule_timeout_interruptible(CRNG_RESEED_INTERVAL);
 }
-EXPORT_SYMBOL(get_random_bytes);
+EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 
 /*
- * Add a callback function that will be invoked when the nonblocking
- * pool is initialised.
- *
- * returns: 0 if callback is successfully added
- *	    -EALREADY if pool is already initialised (callback not called)
- *	    -ENOENT if module for callback is not alive
+ * Handle random seed passed by bootloader, and credit it if
+ * CONFIG_RANDOM_TRUST_BOOTLOADER is set.
  */
-int add_random_ready_callback(struct random_ready_callback *rdy)
+void __init add_bootloader_randomness(const void *buf, size_t len)
 {
-	struct module *owner;
-	unsigned long flags;
-	int err = -EALREADY;
-
-	if (crng_ready())
-		return err;
-
-	owner = rdy->owner;
-	if (!try_module_get(owner))
-		return -ENOENT;
-
-	spin_lock_irqsave(&random_ready_list_lock, flags);
-	if (crng_ready())
-		goto out;
-
-	owner = NULL;
-
-	list_add(&rdy->list, &random_ready_list);
-	err = 0;
+	mix_pool_bytes(buf, len);
+	if (trust_bootloader)
+		credit_init_bits(len * 8);
+}
 
-out:
-	spin_unlock_irqrestore(&random_ready_list_lock, flags);
+struct fast_pool {
+	struct work_struct mix;
+	unsigned long pool[4];
+	unsigned long last;
+	unsigned int count;
+};
 
-	module_put(owner);
+static DEFINE_PER_CPU(struct fast_pool, irq_randomness) = {
+#ifdef CONFIG_64BIT
+#define FASTMIX_PERM SIPHASH_PERMUTATION
+	.pool = { SIPHASH_CONST_0, SIPHASH_CONST_1, SIPHASH_CONST_2, SIPHASH_CONST_3 }
+#else
+#define FASTMIX_PERM HSIPHASH_PERMUTATION
+	.pool = { HSIPHASH_CONST_0, HSIPHASH_CONST_1, HSIPHASH_CONST_2, HSIPHASH_CONST_3 }
+#endif
+};
 
-	return err;
+/*
+ * This is [Half]SipHash-1-x, starting from an empty key. Because
+ * the key is fixed, it assumes that its inputs are non-malicious,
+ * and therefore this has no security on its own. s represents the
+ * four-word SipHash state, while v represents a two-word input.
+ */
+static void fast_mix(unsigned long s[4], unsigned long v1, unsigned long v2)
+{
+	s[3] ^= v1;
+	FASTMIX_PERM(s[0], s[1], s[2], s[3]);
+	s[0] ^= v1;
+	s[3] ^= v2;
+	FASTMIX_PERM(s[0], s[1], s[2], s[3]);
+	s[0] ^= v2;
 }
-EXPORT_SYMBOL(add_random_ready_callback);
 
+#ifdef CONFIG_SMP
 /*
- * Delete a previously registered readiness callback function.
+ * This function is called when the CPU has just come online, with
+ * entry CPUHP_AP_RANDOM_ONLINE, just after CPUHP_AP_WORKQUEUE_ONLINE.
  */
-void del_random_ready_callback(struct random_ready_callback *rdy)
+int __cold random_online_cpu(unsigned int cpu)
 {
-	unsigned long flags;
-	struct module *owner = NULL;
+	/*
+	 * During CPU shutdown and before CPU onlining, add_interrupt_
+	 * randomness() may schedule mix_interrupt_randomness(), and
+	 * set the MIX_INFLIGHT flag. However, because the worker can
+	 * be scheduled on a different CPU during this period, that
+	 * flag will never be cleared. For that reason, we zero out
+	 * the flag here, which runs just after workqueues are onlined
+	 * for the CPU again. This also has the effect of setting the
+	 * irq randomness count to zero so that new accumulated irqs
+	 * are fresh.
+	 */
+	per_cpu_ptr(&irq_randomness, cpu)->count = 0;
+	return 0;
+}
+#endif
 
-	spin_lock_irqsave(&random_ready_list_lock, flags);
-	if (!list_empty(&rdy->list)) {
-		list_del_init(&rdy->list);
-		owner = rdy->owner;
+static void mix_interrupt_randomness(struct work_struct *work)
+{
+	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
+	/*
+	 * The size of the copied stack pool is explicitly 2 longs so that we
+	 * only ever ingest half of the siphash output each time, retaining
+	 * the other half as the next "key" that carries over. The entropy is
+	 * supposed to be sufficiently dispersed between bits so on average
+	 * we don't wind up "losing" some.
+	 */
+	unsigned long pool[2];
+	unsigned int count;
+
+	/* Check to see if we're running on the wrong CPU due to hotplug. */
+	local_irq_disable();
+	if (fast_pool != this_cpu_ptr(&irq_randomness)) {
+		local_irq_enable();
+		return;
 	}
-	spin_unlock_irqrestore(&random_ready_list_lock, flags);
 
-	module_put(owner);
+	/*
+	 * Copy the pool to the stack so that the mixer always has a
+	 * consistent view, before we reenable irqs again.
+	 */
+	memcpy(pool, fast_pool->pool, sizeof(pool));
+	count = fast_pool->count;
+	fast_pool->count = 0;
+	fast_pool->last = jiffies;
+	local_irq_enable();
+
+	mix_pool_bytes(pool, sizeof(pool));
+	credit_init_bits(max(1u, (count & U16_MAX) / 64));
+
+	memzero_explicit(pool, sizeof(pool));
 }
-EXPORT_SYMBOL(del_random_ready_callback);
 
-/*
- * This function will use the architecture-specific hardware random
- * number generator if it is available.  The arch-specific hw RNG will
- * almost certainly be faster than what we can do in software, but it
- * is impossible to verify that it is implemented securely (as
- * opposed, to, say, the AES encryption of a sequence number using a
- * key known by the NSA).  So it's useful if we need the speed, but
- * only if we're willing to trust the hardware manufacturer not to
- * have put in a back door.
- */
-void get_random_bytes_arch(void *buf, int nbytes)
+void add_interrupt_randomness(int irq)
 {
-	char *p = buf;
+	enum { MIX_INFLIGHT = 1U << 31 };
+	unsigned long entropy = random_get_entropy();
+	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
+	struct pt_regs *regs = get_irq_regs();
+	unsigned int new_count;
 
-	trace_get_random_bytes_arch(nbytes, _RET_IP_);
-	while (nbytes) {
-		unsigned long v;
-		int chunk = min(nbytes, (int)sizeof(unsigned long));
+	fast_mix(fast_pool->pool, entropy,
+		 (regs ? instruction_pointer(regs) : _RET_IP_) ^ swab(irq));
+	new_count = ++fast_pool->count;
 
-		if (!arch_get_random_long(&v))
-			break;
+	if (new_count & MIX_INFLIGHT)
+		return;
 
-		memcpy(p, &v, chunk);
-		p += chunk;
-		nbytes -= chunk;
-	}
+	if (new_count < 1024 && !time_is_before_jiffies(fast_pool->last + HZ))
+		return;
 
-	if (nbytes)
-		get_random_bytes(p, nbytes);
+	if (unlikely(!fast_pool->mix.func))
+		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
+	fast_pool->count |= MIX_INFLIGHT;
+	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
 }
-EXPORT_SYMBOL(get_random_bytes_arch);
+EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
+/* There is one of these per entropy source */
+struct timer_rand_state {
+	unsigned long last_time;
+	long last_delta, last_delta2;
+};
 
 /*
- * init_std_data - initialize pool with system data
- *
- * @r: pool to initialize
- *
- * This function clears the pool's entropy count and mixes some system
- * data into the pool to prepare it for use. The pool is not cleared
- * as that can only decrease the entropy in the pool.
+ * This function adds entropy to the entropy "pool" by using timing
+ * delays. It uses the timer_rand_state structure to make an estimate
+ * of how many bits of entropy this call has added to the pool. The
+ * value "num" is also added to the pool; it should somehow describe
+ * the type of event that just happened.
  */
-static void init_std_data(struct entropy_store *r)
+static void add_timer_randomness(struct timer_rand_state *state, unsigned int num)
 {
-	int i;
-	ktime_t now = ktime_get_real();
-	unsigned long rv;
-
-	r->last_pulled = jiffies;
-	mix_pool_bytes(r, &now, sizeof(now));
-	for (i = r->poolinfo->poolbytes; i > 0; i -= sizeof(rv)) {
-		if (!arch_get_random_seed_long(&rv) &&
-		    !arch_get_random_long(&rv))
-			rv = random_get_entropy();
-		mix_pool_bytes(r, &rv, sizeof(rv));
+	unsigned long entropy = random_get_entropy(), now = jiffies, flags;
+	long delta, delta2, delta3;
+	unsigned int bits;
+
+	/*
+	 * If we're in a hard IRQ, add_interrupt_randomness() will be called
+	 * sometime after, so mix into the fast pool.
+	 */
+	if (in_irq()) {
+		fast_mix(this_cpu_ptr(&irq_randomness)->pool, entropy, num);
+	} else {
+		spin_lock_irqsave(&input_pool.lock, flags);
+		_mix_pool_bytes(&entropy, sizeof(entropy));
+		_mix_pool_bytes(&num, sizeof(num));
+		spin_unlock_irqrestore(&input_pool.lock, flags);
 	}
-	mix_pool_bytes(r, utsname(), sizeof(*(utsname())));
+
+	if (crng_ready())
+		return;
+
+	/*
+	 * Calculate number of bits of randomness we probably added.
+	 * We take into account the first, second and third-order deltas
+	 * in order to make our estimate.
+	 */
+	delta = now - READ_ONCE(state->last_time);
+	WRITE_ONCE(state->last_time, now);
+
+	delta2 = delta - READ_ONCE(state->last_delta);
+	WRITE_ONCE(state->last_delta, delta);
+
+	delta3 = delta2 - READ_ONCE(state->last_delta2);
+	WRITE_ONCE(state->last_delta2, delta2);
+
+	if (delta < 0)
+		delta = -delta;
+	if (delta2 < 0)
+		delta2 = -delta2;
+	if (delta3 < 0)
+		delta3 = -delta3;
+	if (delta > delta2)
+		delta = delta2;
+	if (delta > delta3)
+		delta = delta3;
+
+	/*
+	 * delta is now minimum absolute delta. Round down by 1 bit
+	 * on general principles, and limit entropy estimate to 11 bits.
+	 */
+	bits = min(fls(delta >> 1), 11);
+
+	/*
+	 * As mentioned above, if we're in a hard IRQ, add_interrupt_randomness()
+	 * will run after this, which uses a different crediting scheme of 1 bit
+	 * per every 64 interrupts. In order to let that function do accounting
+	 * close to the one in this function, we credit a full 64/64 bit per bit,
+	 * and then subtract one to account for the extra one added.
+	 */
+	if (in_irq())
+		this_cpu_ptr(&irq_randomness)->count += max(1u, bits * 64) - 1;
+	else
+		_credit_init_bits(bits);
 }
 
-/*
- * Note that setup_arch() may call add_device_randomness()
- * long before we get here. This allows seeding of the pools
- * with some platform dependent data very early in the boot
- * process. But it limits our options here. We must use
- * statically allocated structures that already have all
- * initializations complete at compile time. We should also
- * take care not to overwrite the precious per platform data
- * we were given.
- */
-static int rand_initialize(void)
+void add_input_randomness(unsigned int type, unsigned int code, unsigned int value)
 {
-	init_std_data(&input_pool);
-	init_std_data(&blocking_pool);
-	crng_initialize(&primary_crng);
-	crng_global_init_time = jiffies;
-	if (ratelimit_disable) {
-		urandom_warning.interval = 0;
-		unseeded_warning.interval = 0;
-	}
-	return 0;
+	static unsigned char last_value;
+	static struct timer_rand_state input_timer_state = { INITIAL_JIFFIES };
+
+	/* Ignore autorepeat and the like. */
+	if (value == last_value)
+		return;
+
+	last_value = value;
+	add_timer_randomness(&input_timer_state,
+			     (type << 4) ^ code ^ (code >> 4) ^ value);
 }
-early_initcall(rand_initialize);
+EXPORT_SYMBOL_GPL(add_input_randomness);
 
 #ifdef CONFIG_BLOCK
-void rand_initialize_disk(struct gendisk *disk)
+void add_disk_randomness(struct gendisk *disk)
+{
+	if (!disk || !disk->random)
+		return;
+	/* First major is 1, so we get >= 0x200 here. */
+	add_timer_randomness(disk->random, 0x100 + disk_devt(disk));
+}
+EXPORT_SYMBOL_GPL(add_disk_randomness);
+
+void __cold rand_initialize_disk(struct gendisk *disk)
 {
 	struct timer_rand_state *state;
 
@@ -1749,134 +1132,189 @@ void rand_initialize_disk(struct gendisk *disk)
 }
 #endif
 
-static ssize_t
-_random_read(int nonblock, char __user *buf, size_t nbytes)
+/*
+ * Each time the timer fires, we expect that we got an unpredictable
+ * jump in the cycle counter. Even if the timer is running on another
+ * CPU, the timer activity will be touching the stack of the CPU that is
+ * generating entropy..
+ *
+ * Note that we don't re-arm the timer in the timer itself - we are
+ * happy to be scheduled away, since that just makes the load more
+ * complex, but we do not want the timer to keep ticking unless the
+ * entropy loop is running.
+ *
+ * So the re-arming always happens in the entropy loop itself.
+ */
+static void __cold entropy_timer(unsigned long data)
 {
-	ssize_t n;
+	credit_init_bits(1);
+}
 
-	if (nbytes == 0)
-		return 0;
+/*
+ * If we have an actual cycle counter, see if we can
+ * generate enough entropy with timing noise
+ */
+static void __cold try_to_generate_entropy(void)
+{
+	struct {
+		unsigned long entropy;
+		struct timer_list timer;
+	} stack;
 
-	nbytes = min_t(size_t, nbytes, SEC_XFER_SIZE);
-	while (1) {
-		n = extract_entropy_user(&blocking_pool, buf, nbytes);
-		if (n < 0)
-			return n;
-		trace_random_read(n*8, (nbytes-n)*8,
-				  ENTROPY_BITS(&blocking_pool),
-				  ENTROPY_BITS(&input_pool));
-		if (n > 0)
-			return n;
-
-		/* Pool is (near) empty.  Maybe wait and retry. */
-		if (nonblock)
-			return -EAGAIN;
+	stack.entropy = random_get_entropy();
+
+	/* Slow counter - or none. Don't even bother */
+	if (stack.entropy == random_get_entropy())
+		return;
 
-		wait_event_interruptible(random_read_wait,
-			ENTROPY_BITS(&input_pool) >=
-			random_read_wakeup_bits);
-		if (signal_pending(current))
-			return -ERESTARTSYS;
+	__setup_timer_on_stack(&stack.timer, entropy_timer, 0, 0);
+	while (!crng_ready() && !signal_pending(current)) {
+		if (!timer_pending(&stack.timer))
+			mod_timer(&stack.timer, jiffies + 1);
+		mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
+		schedule();
+		stack.entropy = random_get_entropy();
 	}
-}
 
-static ssize_t
-random_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
-{
-	return _random_read(file->f_flags & O_NONBLOCK, buf, nbytes);
+	del_timer_sync(&stack.timer);
+	destroy_timer_on_stack(&stack.timer);
+	mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
 }
 
-static ssize_t
-urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+
+/**********************************************************************
+ *
+ * Userspace reader/writer interfaces.
+ *
+ * getrandom(2) is the primary modern interface into the RNG and should
+ * be used in preference to anything else.
+ *
+ * Reading from /dev/random has the same functionality as calling
+ * getrandom(2) with flags=0. In earlier versions, however, it had
+ * vastly different semantics and should therefore be avoided, to
+ * prevent backwards compatibility issues.
+ *
+ * Reading from /dev/urandom has the same functionality as calling
+ * getrandom(2) with flags=GRND_INSECURE. Because it does not block
+ * waiting for the RNG to be ready, it should not be used.
+ *
+ * Writing to either /dev/random or /dev/urandom adds entropy to
+ * the input pool but does not credit it.
+ *
+ * Polling on /dev/random indicates when the RNG is initialized, on
+ * the read side, and when it wants new entropy, on the write side.
+ *
+ * Both /dev/random and /dev/urandom have the same set of ioctls for
+ * adding entropy, getting the entropy count, zeroing the count, and
+ * reseeding the crng.
+ *
+ **********************************************************************/
+
+SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags)
 {
-	unsigned long flags;
-	static int maxwarn = 10;
+	struct iov_iter iter;
+	struct iovec iov;
 	int ret;
 
-	if (!crng_ready() && maxwarn > 0) {
-		maxwarn--;
-		if (__ratelimit(&urandom_warning))
-			printk(KERN_NOTICE "random: %s: uninitialized "
-			       "urandom read (%zd bytes read)\n",
-			       current->comm, nbytes);
-		spin_lock_irqsave(&primary_crng.lock, flags);
-		crng_init_cnt = 0;
-		spin_unlock_irqrestore(&primary_crng.lock, flags);
+	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
+		return -EINVAL;
+
+	/*
+	 * Requesting insecure and blocking randomness at the same time makes
+	 * no sense.
+	 */
+	if ((flags & (GRND_INSECURE | GRND_RANDOM)) == (GRND_INSECURE | GRND_RANDOM))
+		return -EINVAL;
+
+	if (!crng_ready() && !(flags & GRND_INSECURE)) {
+		if (flags & GRND_NONBLOCK)
+			return -EAGAIN;
+		ret = wait_for_random_bytes();
+		if (unlikely(ret))
+			return ret;
 	}
-	nbytes = min_t(size_t, nbytes, INT_MAX >> (ENTROPY_SHIFT + 3));
-	ret = extract_crng_user(buf, nbytes);
-	trace_urandom_read(8 * nbytes, 0, ENTROPY_BITS(&input_pool));
-	return ret;
+
+	ret = import_single_range(READ, ubuf, len, &iov, &iter);
+	if (unlikely(ret))
+		return ret;
+	return get_random_bytes_user(&iter);
 }
 
-static unsigned int
-random_poll(struct file *file, poll_table * wait)
+static unsigned int random_poll(struct file *file, poll_table *wait)
 {
-	unsigned int mask;
-
-	poll_wait(file, &random_read_wait, wait);
-	poll_wait(file, &random_write_wait, wait);
-	mask = 0;
-	if (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
-		mask |= POLLIN | POLLRDNORM;
-	if (ENTROPY_BITS(&input_pool) < random_write_wakeup_bits)
-		mask |= POLLOUT | POLLWRNORM;
-	return mask;
+	poll_wait(file, &crng_init_wait, wait);
+	return crng_ready() ? POLLIN | POLLRDNORM : POLLOUT | POLLWRNORM;
 }
 
-static int
-write_pool(struct entropy_store *r, const char __user *buffer, size_t count)
+static ssize_t write_pool_user(struct iov_iter *iter)
 {
-	size_t bytes;
-	__u32 t, buf[16];
-	const char __user *p = buffer;
+	u8 block[BLAKE2S_BLOCK_SIZE];
+	ssize_t ret = 0;
+	size_t copied;
 
-	while (count > 0) {
-		int b, i = 0;
+	if (unlikely(!iov_iter_count(iter)))
+		return 0;
 
-		bytes = min(count, sizeof(buf));
-		if (copy_from_user(&buf, p, bytes))
-			return -EFAULT;
+	for (;;) {
+		copied = copy_from_iter(block, sizeof(block), iter);
+		ret += copied;
+		mix_pool_bytes(block, copied);
+		if (!iov_iter_count(iter) || copied != sizeof(block))
+			break;
 
-		for (b = bytes ; b > 0 ; b -= sizeof(__u32), i++) {
-			if (!arch_get_random_int(&t))
+		BUILD_BUG_ON(PAGE_SIZE % sizeof(block) != 0);
+		if (ret % PAGE_SIZE == 0) {
+			if (signal_pending(current))
 				break;
-			buf[i] ^= t;
+			cond_resched();
 		}
+	}
+
+	memzero_explicit(block, sizeof(block));
+	return ret ? ret : -EFAULT;
+}
+
+static ssize_t random_write_iter(struct kiocb *kiocb, struct iov_iter *iter)
+{
+	return write_pool_user(iter);
+}
 
-		count -= bytes;
-		p += bytes;
+static ssize_t urandom_read_iter(struct kiocb *kiocb, struct iov_iter *iter)
+{
+	static int maxwarn = 10;
 
-		mix_pool_bytes(r, buf, bytes);
-		cond_resched();
+	if (!crng_ready()) {
+		if (!ratelimit_disable && maxwarn <= 0)
+			++urandom_warning.missed;
+		else if (ratelimit_disable || __ratelimit(&urandom_warning)) {
+			--maxwarn;
+			pr_notice("%s: uninitialized urandom read (%zu bytes read)\n",
+				  current->comm, iov_iter_count(iter));
+		}
 	}
 
-	return 0;
+	return get_random_bytes_user(iter);
 }
 
-static ssize_t random_write(struct file *file, const char __user *buffer,
-			    size_t count, loff_t *ppos)
+static ssize_t random_read_iter(struct kiocb *kiocb, struct iov_iter *iter)
 {
-	size_t ret;
+	int ret;
 
-	ret = write_pool(&input_pool, buffer, count);
-	if (ret)
+	ret = wait_for_random_bytes();
+	if (ret != 0)
 		return ret;
-
-	return (ssize_t)count;
+	return get_random_bytes_user(iter);
 }
 
 static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
-	int size, ent_count;
 	int __user *p = (int __user *)arg;
-	int retval;
+	int ent_count;
 
 	switch (cmd) {
 	case RNDGETENTCNT:
-		/* inherently racy, no point locking */
-		ent_count = ENTROPY_BITS(&input_pool);
-		if (put_user(ent_count, p))
+		/* Inherently racy, no point locking. */
+		if (put_user(input_pool.init_bits, p))
 			return -EFAULT;
 		return 0;
 	case RNDADDTOENTCNT:
@@ -1884,39 +1322,48 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EPERM;
 		if (get_user(ent_count, p))
 			return -EFAULT;
-		return credit_entropy_bits_safe(&input_pool, ent_count);
-	case RNDADDENTROPY:
+		if (ent_count < 0)
+			return -EINVAL;
+		credit_init_bits(ent_count);
+		return 0;
+	case RNDADDENTROPY: {
+		struct iov_iter iter;
+		struct iovec iov;
+		ssize_t ret;
+		int len;
+
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		if (get_user(ent_count, p++))
 			return -EFAULT;
 		if (ent_count < 0)
 			return -EINVAL;
-		if (get_user(size, p++))
+		if (get_user(len, p++))
+			return -EFAULT;
+		ret = import_single_range(WRITE, p, len, &iov, &iter);
+		if (unlikely(ret))
+			return ret;
+		ret = write_pool_user(&iter);
+		if (unlikely(ret < 0))
+			return ret;
+		/* Since we're crediting, enforce that it was all written into the pool. */
+		if (unlikely(ret != len))
 			return -EFAULT;
-		retval = write_pool(&input_pool, (const char __user *)p,
-				    size);
-		if (retval < 0)
-			return retval;
-		return credit_entropy_bits_safe(&input_pool, ent_count);
+		credit_init_bits(ent_count);
+		return 0;
+	}
 	case RNDZAPENTCNT:
 	case RNDCLEARPOOL:
-		/*
-		 * Clear the entropy pool counters. We no longer clear
-		 * the entropy pool, as that's silly.
-		 */
+		/* No longer has any effect. */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		input_pool.entropy_count = 0;
-		blocking_pool.entropy_count = 0;
 		return 0;
 	case RNDRESEEDCRNG:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (crng_init < 2)
+		if (!crng_ready())
 			return -ENODATA;
-		crng_reseed(&primary_crng, &input_pool);
-		WRITE_ONCE(crng_global_init_time, jiffies - 1);
+		crng_reseed();
 		return 0;
 	default:
 		return -EINVAL;
@@ -1929,47 +1376,54 @@ static int random_fasync(int fd, struct file *filp, int on)
 }
 
 const struct file_operations random_fops = {
-	.read  = random_read,
-	.write = random_write,
-	.poll  = random_poll,
+	.read_iter = random_read_iter,
+	.write_iter = random_write_iter,
+	.poll = random_poll,
 	.unlocked_ioctl = random_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
 
 const struct file_operations urandom_fops = {
-	.read  = urandom_read,
-	.write = random_write,
+	.read_iter = urandom_read_iter,
+	.write_iter = random_write_iter,
 	.unlocked_ioctl = random_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
 
-SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
-		unsigned int, flags)
-{
-	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM))
-		return -EINVAL;
-
-	if (count > INT_MAX)
-		count = INT_MAX;
-
-	if (flags & GRND_RANDOM)
-		return _random_read(flags & GRND_NONBLOCK, buf, count);
-
-	if (!crng_ready()) {
-		if (flags & GRND_NONBLOCK)
-			return -EAGAIN;
-		crng_wait_ready();
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-	}
-	return urandom_read(NULL, buf, count, NULL);
-}
 
 /********************************************************************
  *
- * Sysctl interface
+ * Sysctl interface.
+ *
+ * These are partly unused legacy knobs with dummy values to not break
+ * userspace and partly still useful things. They are usually accessible
+ * in /proc/sys/kernel/random/ and are as follows:
+ *
+ * - boot_id - a UUID representing the current boot.
+ *
+ * - uuid - a random UUID, different each time the file is read.
+ *
+ * - poolsize - the number of bits of entropy that the input pool can
+ *   hold, tied to the POOL_BITS constant.
+ *
+ * - entropy_avail - the number of bits of entropy currently in the
+ *   input pool. Always <= poolsize.
+ *
+ * - write_wakeup_threshold - the amount of entropy in the input pool
+ *   below which write polls to /dev/random will unblock, requesting
+ *   more entropy, tied to the POOL_READY_BITS constant. It is writable
+ *   to avoid breaking old userspaces, but writing to it does not
+ *   change any behavior of the RNG.
+ *
+ * - urandom_min_reseed_secs - fixed to the value CRNG_RESEED_INTERVAL.
+ *   It is writable to avoid breaking old userspaces, but writing
+ *   to it does not change any behavior of the RNG.
  *
  ********************************************************************/
 
@@ -1977,25 +1431,28 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 
 #include <linux/sysctl.h>
 
-static int min_read_thresh = 8, min_write_thresh;
-static int max_read_thresh = OUTPUT_POOL_WORDS * 32;
-static int max_write_thresh = INPUT_POOL_WORDS * 32;
-static char sysctl_bootid[16];
+static int sysctl_random_min_urandom_seed = CRNG_RESEED_INTERVAL / HZ;
+static int sysctl_random_write_wakeup_bits = POOL_READY_BITS;
+static int sysctl_poolsize = POOL_BITS;
+static u8 sysctl_bootid[UUID_SIZE];
 
 /*
  * This function is used to return both the bootid UUID, and random
- * UUID.  The difference is in whether table->data is NULL; if it is,
+ * UUID. The difference is in whether table->data is NULL; if it is,
  * then a new UUID is generated and returned to the user.
- *
- * If the user accesses this via the proc interface, the UUID will be
- * returned as an ASCII string in the standard UUID format; if via the
- * sysctl system call, as 16 bytes of binary data.
  */
-static int proc_do_uuid(struct ctl_table *table, int write,
-			void __user *buffer, size_t *lenp, loff_t *ppos)
+static int proc_do_uuid(struct ctl_table *table, int write, void __user *buf,
+			size_t *lenp, loff_t *ppos)
 {
-	struct ctl_table fake_table;
-	unsigned char buf[64], tmp_uuid[16], *uuid;
+	u8 tmp_uuid[UUID_SIZE], *uuid;
+	char uuid_string[UUID_STRING_LEN + 1];
+	struct ctl_table fake_table = {
+		.data = uuid_string,
+		.maxlen = UUID_STRING_LEN
+	};
+
+	if (write)
+		return -EPERM;
 
 	uuid = table->data;
 	if (!uuid) {
@@ -2010,32 +1467,17 @@ static int proc_do_uuid(struct ctl_table *table, int write,
 		spin_unlock(&bootid_spinlock);
 	}
 
-	sprintf(buf, "%pU", uuid);
-
-	fake_table.data = buf;
-	fake_table.maxlen = sizeof(buf);
-
-	return proc_dostring(&fake_table, write, buffer, lenp, ppos);
+	snprintf(uuid_string, sizeof(uuid_string), "%pU", uuid);
+	return proc_dostring(&fake_table, 0, buf, lenp, ppos);
 }
 
-/*
- * Return entropy available scaled to integral bits
- */
-static int proc_do_entropy(struct ctl_table *table, int write,
-			   void __user *buffer, size_t *lenp, loff_t *ppos)
+/* The same as proc_dointvec, but writes don't change anything. */
+static int proc_do_rointvec(struct ctl_table *table, int write, void __user *buf,
+			    size_t *lenp, loff_t *ppos)
 {
-	struct ctl_table fake_table;
-	int entropy_count;
-
-	entropy_count = *(int *)table->data >> ENTROPY_SHIFT;
-
-	fake_table.data = &entropy_count;
-	fake_table.maxlen = sizeof(entropy_count);
-
-	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
+	return write ? 0 : proc_dointvec(table, 0, buf, lenp, ppos);
 }
 
-static int sysctl_poolsize = INPUT_POOL_WORDS * 32;
 extern struct ctl_table random_table[];
 struct ctl_table random_table[] = {
 	{
@@ -2047,186 +1489,36 @@ struct ctl_table random_table[] = {
 	},
 	{
 		.procname	= "entropy_avail",
+		.data		= &input_pool.init_bits,
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= proc_do_entropy,
-		.data		= &input_pool.entropy_count,
-	},
-	{
-		.procname	= "read_wakeup_threshold",
-		.data		= &random_read_wakeup_bits,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_read_thresh,
-		.extra2		= &max_read_thresh,
+		.proc_handler	= proc_dointvec,
 	},
 	{
 		.procname	= "write_wakeup_threshold",
-		.data		= &random_write_wakeup_bits,
+		.data		= &sysctl_random_write_wakeup_bits,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_write_thresh,
-		.extra2		= &max_write_thresh,
+		.proc_handler	= proc_do_rointvec,
 	},
 	{
 		.procname	= "urandom_min_reseed_secs",
-		.data		= &random_min_urandom_seed,
+		.data		= &sysctl_random_min_urandom_seed,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_do_rointvec,
 	},
 	{
 		.procname	= "boot_id",
 		.data		= &sysctl_bootid,
-		.maxlen		= 16,
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
 	},
 	{
 		.procname	= "uuid",
-		.maxlen		= 16,
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
 	},
-#ifdef ADD_INTERRUPT_BENCH
-	{
-		.procname	= "add_interrupt_avg_cycles",
-		.data		= &avg_cycles,
-		.maxlen		= sizeof(avg_cycles),
-		.mode		= 0444,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "add_interrupt_avg_deviation",
-		.data		= &avg_deviation,
-		.maxlen		= sizeof(avg_deviation),
-		.mode		= 0444,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-#endif
 	{ }
 };
-#endif 	/* CONFIG_SYSCTL */
-
-struct batched_entropy {
-	union {
-		unsigned long entropy_long[CHACHA20_BLOCK_SIZE / sizeof(unsigned long)];
-		unsigned int entropy_int[CHACHA20_BLOCK_SIZE / sizeof(unsigned int)];
-	};
-	unsigned int position;
-};
-
-/*
- * Get a random word for internal kernel use only. The quality of the random
- * number is good as /dev/urandom, but there is no backtrack protection, with
- * the goal of being quite fast and not depleting entropy.
- */
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_long);
-static DEFINE_LOCAL_IRQ_LOCK(batched_entropy_long_lock);
-unsigned long get_random_long(void)
-{
-	unsigned long ret;
-	struct batched_entropy *batch;
-
-	if (arch_get_random_long(&ret))
-		return ret;
-
-	batch = &get_locked_var(batched_entropy_long_lock, batched_entropy_long);
-	if (batch->position % ARRAY_SIZE(batch->entropy_long) == 0) {
-		extract_crng((u8 *)batch->entropy_long);
-		batch->position = 0;
-	}
-	ret = batch->entropy_long[batch->position++];
-	put_locked_var(batched_entropy_long_lock, batched_entropy_long);
-	return ret;
-}
-EXPORT_SYMBOL(get_random_long);
-
-#if BITS_PER_LONG == 32
-unsigned int get_random_int(void)
-{
-	return get_random_long();
-}
-#else
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_int);
-static DEFINE_LOCAL_IRQ_LOCK(batched_entropy_int_lock);
-
-unsigned int get_random_int(void)
-{
-	unsigned int ret;
-	struct batched_entropy *batch;
-
-	if (arch_get_random_int(&ret))
-		return ret;
-
-	batch = &get_locked_var(batched_entropy_int_lock, batched_entropy_int);
-	if (batch->position % ARRAY_SIZE(batch->entropy_int) == 0) {
-		extract_crng((u8 *)batch->entropy_int);
-		batch->position = 0;
-	}
-	ret = batch->entropy_int[batch->position++];
-	put_locked_var(batched_entropy_int_lock, batched_entropy_int);
-	return ret;
-}
-#endif
-EXPORT_SYMBOL(get_random_int);
-
-/**
- * randomize_page - Generate a random, page aligned address
- * @start:	The smallest acceptable address the caller will take.
- * @range:	The size of the area, starting at @start, within which the
- *		random address must fall.
- *
- * If @start + @range would overflow, @range is capped.
- *
- * NOTE: Historical use of randomize_range, which this replaces, presumed that
- * @start was already page aligned.  We now align it regardless.
- *
- * Return: A page aligned address within [start, start + range).  On error,
- * @start is returned.
- */
-unsigned long
-randomize_page(unsigned long start, unsigned long range)
-{
-	if (!PAGE_ALIGNED(start)) {
-		range -= PAGE_ALIGN(start) - start;
-		start = PAGE_ALIGN(start);
-	}
-
-	if (start > ULONG_MAX - range)
-		range = ULONG_MAX - start;
-
-	range >>= PAGE_SHIFT;
-
-	if (range == 0)
-		return start;
-
-	return start + (get_random_long() % range << PAGE_SHIFT);
-}
-
-/* Interface for in-kernel drivers of true hardware RNGs.
- * Those devices may produce endless random bits and will be throttled
- * when our pool is full.
- */
-void add_hwgenerator_randomness(const char *buffer, size_t count,
-				size_t entropy)
-{
-	struct entropy_store *poolp = &input_pool;
-
-	if (unlikely(crng_init == 0)) {
-		crng_fast_load(buffer, count);
-		return;
-	}
-
-	/* Suspend writing if we're above the trickle threshold.
-	 * We'll be woken up again once below random_write_wakeup_thresh,
-	 * or when the calling thread is about to terminate.
-	 */
-	wait_event_interruptible(random_write_wait, kthread_should_stop() ||
-			ENTROPY_BITS(&input_pool) <= random_write_wakeup_bits);
-	mix_pool_bytes(poolp, buffer, count);
-	credit_entropy_bits(poolp, entropy);
-}
-EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
+#endif	/* CONFIG_SYSCTL */
diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 641f8021855a..62e86f7ca04a 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -473,6 +473,10 @@ static int pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
 	if (slew_done_gpio_np)
 		slew_done_gpio = read_gpio(slew_done_gpio_np);
 
+	of_node_put(volt_gpio_np);
+	of_node_put(freq_gpio_np);
+	of_node_put(slew_done_gpio_np);
+
 	/* If we use the frequency GPIOs, calculate the min/max speeds based
 	 * on the bus frequencies
 	 */
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index ca266fcca186..f191057065f7 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1806,6 +1806,11 @@ static int at_xdmac_alloc_chan_resources(struct dma_chan *chan)
 	for (i = 0; i < init_nr_desc_per_channel; i++) {
 		desc = at_xdmac_alloc_desc(chan, GFP_ATOMIC);
 		if (!desc) {
+			if (i == 0) {
+				dev_warn(chan2dev(chan),
+					 "can't allocate any descriptors\n");
+				return -EIO;
+			}
 			dev_warn(chan2dev(chan),
 				"only %d descriptors have been allocated\n", i);
 			break;
diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index a7e1f6e17e3d..8ea8d04e1ae0 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -251,6 +251,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	if (dma_spec->args[0] >= xbar->xbar_requests) {
 		dev_err(&pdev->dev, "Invalid XBAR request number: %d\n",
 			dma_spec->args[0]);
+		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -258,12 +259,14 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "Can't get DMA master\n");
+		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
 	}
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (!map) {
 		of_node_put(dma_spec->np);
+		put_device(&pdev->dev);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -274,6 +277,8 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 		mutex_unlock(&xbar->mutex);
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		kfree(map);
+		of_node_put(dma_spec->np);
+		put_device(&pdev->dev);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(map->xbar_out, xbar->dma_inuse);
diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
index ac8deb01f6f6..ee3163dd794b 100644
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -224,8 +224,6 @@ static int giu_get_irq(unsigned int irq)
 	printk(KERN_ERR "spurious GIU interrupt: %04x(%04x),%04x(%04x)\n",
 	       maskl, pendl, maskh, pendh);
 
-	atomic_inc(&irq_err_count);
-
 	return -EINVAL;
 }
 
diff --git a/drivers/gpu/drm/drm_crtc_helper_internal.h b/drivers/gpu/drm/drm_crtc_helper_internal.h
index 28295e5d0d9e..8c967157aa90 100644
--- a/drivers/gpu/drm/drm_crtc_helper_internal.h
+++ b/drivers/gpu/drm/drm_crtc_helper_internal.h
@@ -28,16 +28,6 @@
 
 #include <drm/drm_dp_helper.h>
 
-/* drm_fb_helper.c */
-#ifdef CONFIG_DRM_FBDEV_EMULATION
-int drm_fb_helper_modinit(void);
-#else
-static inline int drm_fb_helper_modinit(void)
-{
-	return 0;
-}
-#endif
-
 /* drm_dp_aux_dev.c */
 #ifdef CONFIG_DRM_DP_AUX_CHARDEV
 int drm_dp_aux_dev_init(void);
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 2e85e609f125..9c571336ae81 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2324,24 +2324,3 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper)
 	return 0;
 }
 EXPORT_SYMBOL(drm_fb_helper_hotplug_event);
-
-/* The Kconfig DRM_KMS_HELPER selects FRAMEBUFFER_CONSOLE (if !EXPERT)
- * but the module doesn't depend on any fb console symbols.  At least
- * attempt to load fbcon to avoid leaving the system without a usable console.
- */
-int __init drm_fb_helper_modinit(void)
-{
-#if defined(CONFIG_FRAMEBUFFER_CONSOLE_MODULE) && !defined(CONFIG_EXPERT)
-	const char *name = "fbcon";
-	struct module *fbcon;
-
-	mutex_lock(&module_mutex);
-	fbcon = find_module(name);
-	mutex_unlock(&module_mutex);
-
-	if (!fbcon)
-		request_module_nowait(name);
-#endif
-	return 0;
-}
-EXPORT_SYMBOL(drm_fb_helper_modinit);
diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
index 45db36cd3d20..4c11711234b6 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -36,19 +36,18 @@ MODULE_LICENSE("GPL and additional rights");
 
 static int __init drm_kms_helper_init(void)
 {
-	int ret;
-
-	/* Call init functions from specific kms helpers here */
-	ret = drm_fb_helper_modinit();
-	if (ret < 0)
-		goto out;
-
-	ret = drm_dp_aux_dev_init();
-	if (ret < 0)
-		goto out;
-
-out:
-	return ret;
+	/*
+	 * The Kconfig DRM_KMS_HELPER selects FRAMEBUFFER_CONSOLE (if !EXPERT)
+	 * but the module doesn't depend on any fb console symbols.  At least
+	 * attempt to load fbcon to avoid leaving the system without a usable
+	 * console.
+	 */
+	if (IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION) &&
+	    IS_MODULE(CONFIG_FRAMEBUFFER_CONSOLE) &&
+	    !IS_ENABLED(CONFIG_EXPERT))
+		request_module_nowait("fbcon");
+
+	return drm_dp_aux_dev_init();
 }
 
 static void __exit drm_kms_helper_exit(void)
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c
index 8bff14ae16b0..f0368d9a0154 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c
@@ -33,7 +33,7 @@ nvbios_addr(struct nvkm_bios *bios, u32 *addr, u8 size)
 {
 	u32 p = *addr;
 
-	if (*addr > bios->image0_size && bios->imaged_addr) {
+	if (*addr >= bios->image0_size && bios->imaged_addr) {
 		*addr -= bios->image0_size;
 		*addr += bios->imaged_addr;
 	}
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index ed6591f92f71..0b1bb99e05e8 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -354,10 +354,13 @@ static int hidraw_release(struct inode * inode, struct file * file)
 	unsigned int minor = iminor(inode);
 	struct hidraw_list *list = file->private_data;
 	unsigned long flags;
+	int i;
 
 	mutex_lock(&minors_lock);
 
 	spin_lock_irqsave(&hidraw_table[minor]->list_lock, flags);
+	for (i = list->tail; i < list->head; i++)
+		kfree(list->buffer[i].value);
 	list_del(&list->node);
 	spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
 	kfree(list);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index ca93cfa43f64..3248aa7a35b3 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -43,7 +43,6 @@
 #include <linux/kdebug.h>
 #include <linux/efi.h>
 #include <linux/random.h>
-#include <asm/irq_regs.h>
 #include "hyperv_vmbus.h"
 
 static struct acpi_device  *hv_acpi_dev;
@@ -782,8 +781,6 @@ static void vmbus_isr(void)
 	void *page_addr;
 	struct hv_message *msg;
 	union hv_synic_event_flags *event;
-	struct pt_regs *regs = get_irq_regs();
-	u64 ip = regs ? instruction_pointer(regs) : 0;
 	bool handled = false;
 
 	page_addr = hv_context.synic_event_page[cpu];
@@ -831,7 +828,7 @@ static void vmbus_isr(void)
 			tasklet_schedule(hv_context.msg_dpc[cpu]);
 	}
 
-	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0, ip);
+	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR);
 }
 
 
diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index 1f643782ce04..c9cfc958e853 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -563,7 +563,7 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
 
 	res = platform_device_add(data->pdev);
 	if (res)
-		goto ipmi_err;
+		goto dev_add_err;
 
 	platform_set_drvdata(data->pdev, data);
 
@@ -611,7 +611,9 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
 	ipmi_destroy_user(data->ipmi.user);
 ipmi_err:
 	platform_set_drvdata(data->pdev, NULL);
-	platform_device_unregister(data->pdev);
+	platform_device_del(data->pdev);
+dev_add_err:
+	platform_device_put(data->pdev);
 dev_err:
 	ida_simple_remove(&aem_ida, data->id);
 id_err:
@@ -703,7 +705,7 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
 
 	res = platform_device_add(data->pdev);
 	if (res)
-		goto ipmi_err;
+		goto dev_add_err;
 
 	platform_set_drvdata(data->pdev, data);
 
@@ -751,7 +753,9 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
 	ipmi_destroy_user(data->ipmi.user);
 ipmi_err:
 	platform_set_drvdata(data->pdev, NULL);
-	platform_device_unregister(data->pdev);
+	platform_device_del(data->pdev);
+dev_add_err:
+	platform_device_put(data->pdev);
 dev_err:
 	ida_simple_remove(&aem_ida, data->id);
 id_err:
diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index a29ac9bae6d5..fce1906e7df1 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -203,9 +203,9 @@ static inline bool cdns_is_holdquirk(struct cdns_i2c *id, bool hold_wrkaround)
  */
 static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 {
-	unsigned int isr_status, avail_bytes, updatetx;
+	unsigned int isr_status, avail_bytes;
 	unsigned int bytes_to_send;
-	bool hold_quirk;
+	bool updatetx;
 	struct cdns_i2c *id = ptr;
 	/* Signal completion only after everything is updated */
 	int done_flag = 0;
@@ -224,11 +224,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 	 * Check if transfer size register needs to be updated again for a
 	 * large data receive operation.
 	 */
-	updatetx = 0;
-	if (id->recv_count > id->curr_recv_count)
-		updatetx = 1;
-
-	hold_quirk = (id->quirks & CDNS_I2C_BROKEN_HOLD_BIT) && updatetx;
+	updatetx = id->recv_count > id->curr_recv_count;
 
 	/* When receiving, handle data interrupt and completion interrupt */
 	if (id->p_recv_buf &&
@@ -251,7 +247,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 			id->recv_count--;
 			id->curr_recv_count--;
 
-			if (cdns_is_holdquirk(id, hold_quirk))
+			if (cdns_is_holdquirk(id, updatetx))
 				break;
 		}
 
@@ -262,7 +258,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 		 * maintain transfer size non-zero while performing a large
 		 * receive operation.
 		 */
-		if (cdns_is_holdquirk(id, hold_quirk)) {
+		if (cdns_is_holdquirk(id, updatetx)) {
 			/* wait while fifo is full */
 			while (cdns_i2c_readreg(CDNS_I2C_XFER_SIZE_OFFSET) !=
 			       (id->curr_recv_count - CDNS_I2C_FIFO_DEPTH))
@@ -284,22 +280,6 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 						  CDNS_I2C_XFER_SIZE_OFFSET);
 				id->curr_recv_count = id->recv_count;
 			}
-		} else if (id->recv_count && !hold_quirk &&
-						!id->curr_recv_count) {
-
-			/* Set the slave address in address register*/
-			cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
-						CDNS_I2C_ADDR_OFFSET);
-
-			if (id->recv_count > CDNS_I2C_TRANSFER_SIZE) {
-				cdns_i2c_writereg(CDNS_I2C_TRANSFER_SIZE,
-						CDNS_I2C_XFER_SIZE_OFFSET);
-				id->curr_recv_count = CDNS_I2C_TRANSFER_SIZE;
-			} else {
-				cdns_i2c_writereg(id->recv_count,
-						CDNS_I2C_XFER_SIZE_OFFSET);
-				id->curr_recv_count = id->recv_count;
-			}
 		}
 
 		/* Clear hold (if not repeated start) and signal completion */
@@ -992,6 +972,7 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk_dis:
+	clk_notifier_unregister(id->clk, &id->clk_rate_change_nb);
 	clk_disable_unprepare(id->clk);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 02a361de3dcc..8028bc432ffb 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -776,11 +776,12 @@ static int bma180_probe(struct i2c_client *client,
 		data->trig->dev.parent = &client->dev;
 		data->trig->ops = &bma180_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
-		indio_dev->trig = iio_trigger_get(data->trig);
 
 		ret = iio_trigger_register(data->trig);
 		if (ret)
 			goto err_trigger_free;
+
+		indio_dev->trig = iio_trigger_get(data->trig);
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 0346c37b1e28..3e4f5ab39af3 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1405,10 +1405,14 @@ static int mma8452_reset(struct i2c_client *client)
 	int i;
 	int ret;
 
-	ret = i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
+	/*
+	 * Find on fxls8471, after config reset bit, it reset immediately,
+	 * and will not give ACK, so here do not check the return value.
+	 * The following code will read the reset register, and check whether
+	 * this reset works.
+	 */
+	i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG2,
 					MMA8452_CTRL_REG2_RST);
-	if (ret < 0)
-		return ret;
 
 	for (i = 0; i < 10; i++) {
 		usleep_range(100, 200);
diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 202e8b89caf2..0e9590e071d1 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -199,6 +199,7 @@ static int iio_sysfs_trigger_remove(int id)
 	}
 
 	iio_trigger_unregister(t->trig);
+	irq_work_sync(&t->work);
 	iio_trigger_free(t->trig);
 
 	list_del(&t->l);
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9ad5a7019abf..d8b8cf36de31 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -373,7 +373,7 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
 
 static struct notifier_block dmar_pci_bus_nb = {
 	.notifier_call = dmar_pci_bus_notifier,
-	.priority = INT_MIN,
+	.priority = 1,
 };
 
 static struct dmar_drhd_unit *
diff --git a/drivers/irqchip/irq-gic-realview.c b/drivers/irqchip/irq-gic-realview.c
index 54c296401525..61024882c685 100644
--- a/drivers/irqchip/irq-gic-realview.c
+++ b/drivers/irqchip/irq-gic-realview.c
@@ -56,6 +56,7 @@ realview_gic_of_init(struct device_node *node, struct device_node *parent)
 
 	/* The PB11MPCore GIC needs to be configured in the syscon */
 	map = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (!IS_ERR(map)) {
 		/* new irq mode with no DCC */
 		regmap_write(map, REALVIEW_SYS_LOCK_OFFSET,
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2ab6060031a4..9ae24ffb9b09 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -982,7 +982,7 @@ static int get_cpu_number(struct device_node *dn)
 {
 	const __be32 *cell;
 	u64 hwid;
-	int i;
+	int cpu;
 
 	cell = of_get_property(dn, "reg", NULL);
 	if (!cell)
@@ -996,9 +996,9 @@ static int get_cpu_number(struct device_node *dn)
 	if (hwid & ~MPIDR_HWID_BITMASK)
 		return -1;
 
-	for (i = 0; i < num_possible_cpus(); i++)
-		if (cpu_logical_map(i) == hwid)
-			return i;
+	for_each_possible_cpu(cpu)
+		if (cpu_logical_map(cpu) == hwid)
+			return cpu;
 
 	return -1;
 }
diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
index 3973a14bb15b..02ffefd5011a 100644
--- a/drivers/irqchip/irq-tegra.c
+++ b/drivers/irqchip/irq-tegra.c
@@ -157,10 +157,10 @@ static int tegra_ictlr_suspend(void)
 		lic->cop_iep[i] = readl_relaxed(ictlr + ICTLR_COP_IEP_CLASS);
 
 		/* Disable COP interrupts */
-		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
+		writel_relaxed(GENMASK(31, 0), ictlr + ICTLR_COP_IER_CLR);
 
 		/* Disable CPU interrupts */
-		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
+		writel_relaxed(GENMASK(31, 0), ictlr + ICTLR_CPU_IER_CLR);
 
 		/* Enable the wakeup sources of ictlr */
 		writel_relaxed(lic->ictlr_wake_mask[i], ictlr + ICTLR_CPU_IER_SET);
@@ -181,12 +181,12 @@ static void tegra_ictlr_resume(void)
 
 		writel_relaxed(lic->cpu_iep[i],
 			       ictlr + ICTLR_CPU_IEP_CLASS);
-		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
+		writel_relaxed(GENMASK(31, 0), ictlr + ICTLR_CPU_IER_CLR);
 		writel_relaxed(lic->cpu_ier[i],
 			       ictlr + ICTLR_CPU_IER_SET);
 		writel_relaxed(lic->cop_iep[i],
 			       ictlr + ICTLR_COP_IEP_CLASS);
-		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
+		writel_relaxed(GENMASK(31, 0), ictlr + ICTLR_COP_IER_CLR);
 		writel_relaxed(lic->cop_ier[i],
 			       ictlr + ICTLR_COP_IER_SET);
 	}
@@ -321,7 +321,7 @@ static int __init tegra_ictlr_init(struct device_node *node,
 		lic->base[i] = base;
 
 		/* Disable all interrupts */
-		writel_relaxed(~0UL, base + ICTLR_CPU_IER_CLR);
+		writel_relaxed(GENMASK(31, 0), base + ICTLR_CPU_IER_CLR);
 		/* All interrupts target IRQ */
 		writel_relaxed(0, base + ICTLR_CPU_IEP_CLASS);
 
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 226179b975a0..1f5db323e5a5 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -650,7 +650,7 @@ do_adb_query(struct adb_request *req)
 
 	switch(req->data[1]) {
 	case ADB_QUERY_GETDEVINFO:
-		if (req->nbytes < 3)
+		if (req->nbytes < 3 || req->data[2] >= 16)
 			break;
 		mutex_lock(&adb_handler_mutex);
 		req->reply[0] = adb_handler[req->data[2]].original_address;
diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index c7151febbb09..521f733e70e1 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1398,7 +1398,7 @@ static void start_worker(struct era *era)
 static void stop_worker(struct era *era)
 {
 	atomic_set(&era->suspended, 1);
-	flush_workqueue(era->wq);
+	drain_workqueue(era->wq);
 }
 
 /*----------------------------------------------------------------
@@ -1583,6 +1583,12 @@ static void era_postsuspend(struct dm_target *ti)
 	}
 
 	stop_worker(era);
+
+	r = metadata_commit(era->md);
+	if (r) {
+		DMERR("%s: metadata_commit failed", __func__);
+		/* FIXME: fail mode */
+	}
 }
 
 static int era_preresume(struct dm_target *ti)
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 3f389b267e04..fe721cd9da74 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3173,7 +3173,7 @@ static void raid_status(struct dm_target *ti, status_type_t type,
 {
 	struct raid_set *rs = ti->private;
 	struct mddev *mddev = &rs->md;
-	struct r5conf *conf = mddev->private;
+	struct r5conf *conf = rs_is_raid456(rs) ? mddev->private : NULL;
 	int i, max_nr_stripes = conf ? conf->max_nr_stripes : 0;
 	bool array_in_sync;
 	unsigned int raid_param_cnt = 1; /* at least 1 for chunksize */
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 717787d09e0f..02e974a588e1 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1785,9 +1785,12 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	int err = 0;
 	int number = rdev->raid_disk;
 	struct md_rdev **rdevp;
-	struct raid10_info *p = conf->mirrors + number;
+	struct raid10_info *p;
 
 	print_conf(conf);
+	if (unlikely(number >= mddev->raid_disks))
+		return 0;
+	p = conf->mirrors + number;
 	if (rdev == p->rdev)
 		rdevp = &p->rdev;
 	else if (rdev == p->replacement)
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 0e4167223f79..707856a8618f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2515,10 +2515,10 @@ static void raid5_end_write_request(struct bio *bi)
 	if (!test_and_clear_bit(R5_DOUBLE_LOCKED, &sh->dev[i].flags))
 		clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
-	raid5_release_stripe(sh);
 
 	if (sh->batch_head && sh != sh->batch_head)
 		raid5_release_stripe(sh->batch_head);
+	raid5_release_stripe(sh);
 }
 
 static void raid5_build_block(struct stripe_head *sh, int i, int previous)
@@ -7324,6 +7324,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 	 */
 	if (rdev->saved_raid_disk >= 0 &&
 	    rdev->saved_raid_disk >= first &&
+	    rdev->saved_raid_disk <= last &&
 	    conf->disks[rdev->saved_raid_disk].rdev == NULL)
 		first = rdev->saved_raid_disk;
 
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index b868a77a048c..a02da1d55fd0 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -2656,6 +2656,7 @@ struct pvr2_hdw *pvr2_hdw_create(struct usb_interface *intf,
 		del_timer_sync(&hdw->encoder_run_timer);
 		del_timer_sync(&hdw->encoder_wait_timer);
 		flush_work(&hdw->workpoll);
+		v4l2_device_unregister(&hdw->v4l2_dev);
 		usb_free_urb(hdw->ctl_read_urb);
 		usb_free_urb(hdw->ctl_write_urb);
 		kfree(hdw->ctl_read_buffer);
diff --git a/drivers/mfd/rtsx_usb.c b/drivers/mfd/rtsx_usb.c
index e94f855eac15..fd859a7872a6 100644
--- a/drivers/mfd/rtsx_usb.c
+++ b/drivers/mfd/rtsx_usb.c
@@ -642,16 +642,20 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 
 	ucr->pusb_dev = usb_dev;
 
-	ucr->iobuf = usb_alloc_coherent(ucr->pusb_dev, IOBUF_SIZE,
-			GFP_KERNEL, &ucr->iobuf_dma);
-	if (!ucr->iobuf)
+	ucr->cmd_buf = kmalloc(IOBUF_SIZE, GFP_KERNEL);
+	if (!ucr->cmd_buf)
 		return -ENOMEM;
 
+	ucr->rsp_buf = kmalloc(IOBUF_SIZE, GFP_KERNEL);
+	if (!ucr->rsp_buf) {
+		ret = -ENOMEM;
+		goto out_free_cmd_buf;
+	}
+
 	usb_set_intfdata(intf, ucr);
 
 	ucr->vendor_id = id->idVendor;
 	ucr->product_id = id->idProduct;
-	ucr->cmd_buf = ucr->rsp_buf = ucr->iobuf;
 
 	mutex_init(&ucr->dev_mutex);
 
@@ -679,8 +683,11 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 
 out_init_fail:
 	usb_set_intfdata(ucr->pusb_intf, NULL);
-	usb_free_coherent(ucr->pusb_dev, IOBUF_SIZE, ucr->iobuf,
-			ucr->iobuf_dma);
+	kfree(ucr->rsp_buf);
+	ucr->rsp_buf = NULL;
+out_free_cmd_buf:
+	kfree(ucr->cmd_buf);
+	ucr->cmd_buf = NULL;
 	return ret;
 }
 
@@ -693,8 +700,12 @@ static void rtsx_usb_disconnect(struct usb_interface *intf)
 	mfd_remove_devices(&intf->dev);
 
 	usb_set_intfdata(ucr->pusb_intf, NULL);
-	usb_free_coherent(ucr->pusb_dev, IOBUF_SIZE, ucr->iobuf,
-			ucr->iobuf_dma);
+
+	kfree(ucr->cmd_buf);
+	ucr->cmd_buf = NULL;
+
+	kfree(ucr->rsp_buf);
+	ucr->rsp_buf = NULL;
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index 8c9a444d61d3..65bc573d6ab4 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -190,9 +190,9 @@ static int ssc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(ssc->clk);
 
 	ssc->irq = platform_get_irq(pdev, 0);
-	if (!ssc->irq) {
+	if (ssc->irq < 0) {
 		dev_dbg(&pdev->dev, "could not get irq\n");
-		return -ENXIO;
+		return ssc->irq;
 	}
 
 	mutex_lock(&user_lock);
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index dec60f58a767..99e2bd65825f 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -302,6 +302,7 @@ int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 
 out:
 	cxl_ops->release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
+	bitmap_free(ctx->irq_bitmap);
 	afu_irq_name_free(ctx);
 	return -ENOMEM;
 }
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 578d8e12e2d2..7ba724ecef30 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1941,30 +1941,24 @@ void bond_3ad_initiate_agg_selection(struct bonding *bond, int timeout)
  */
 void bond_3ad_initialize(struct bonding *bond, u16 tick_resolution)
 {
-	/* check that the bond is not initialized yet */
-	if (!MAC_ADDRESS_EQUAL(&(BOND_AD_INFO(bond).system.sys_mac_addr),
-				bond->dev->dev_addr)) {
-
-		BOND_AD_INFO(bond).aggregator_identifier = 0;
-
-		BOND_AD_INFO(bond).system.sys_priority =
-			bond->params.ad_actor_sys_prio;
-		if (is_zero_ether_addr(bond->params.ad_actor_system))
-			BOND_AD_INFO(bond).system.sys_mac_addr =
-			    *((struct mac_addr *)bond->dev->dev_addr);
-		else
-			BOND_AD_INFO(bond).system.sys_mac_addr =
-			    *((struct mac_addr *)bond->params.ad_actor_system);
+	BOND_AD_INFO(bond).aggregator_identifier = 0;
+	BOND_AD_INFO(bond).system.sys_priority =
+		bond->params.ad_actor_sys_prio;
+	if (is_zero_ether_addr(bond->params.ad_actor_system))
+		BOND_AD_INFO(bond).system.sys_mac_addr =
+		    *((struct mac_addr *)bond->dev->dev_addr);
+	else
+		BOND_AD_INFO(bond).system.sys_mac_addr =
+		    *((struct mac_addr *)bond->params.ad_actor_system);
 
-		/* initialize how many times this module is called in one
-		 * second (should be about every 100ms)
-		 */
-		ad_ticks_per_sec = tick_resolution;
+	/* initialize how many times this module is called in one
+	 * second (should be about every 100ms)
+	 */
+	ad_ticks_per_sec = tick_resolution;
 
-		bond_3ad_initiate_agg_selection(bond,
-						AD_AGGREGATOR_SELECTION_TIMER *
-						ad_ticks_per_sec);
-	}
+	bond_3ad_initiate_agg_selection(bond,
+					AD_AGGREGATOR_SELECTION_TIMER *
+					ad_ticks_per_sec);
 }
 
 /**
@@ -2163,7 +2157,8 @@ void bond_3ad_unbind_slave(struct slave *slave)
 				temp_aggregator->num_of_ports--;
 				if (__agg_active_ports(temp_aggregator) == 0) {
 					select_new_active_agg = temp_aggregator->is_active;
-					ad_clear_agg(temp_aggregator);
+					if (temp_aggregator->num_of_ports == 0)
+						ad_clear_agg(temp_aggregator);
 					if (select_new_active_agg) {
 						netdev_info(bond->dev, "Removing an active aggregator\n");
 						/* select new active aggregator */
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 1f8fbd7776fb..df81b525156f 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1264,12 +1264,12 @@ int bond_alb_initialize(struct bonding *bond, int rlb_enabled)
 		return res;
 
 	if (rlb_enabled) {
-		bond->alb_info.rlb_enabled = 1;
 		res = rlb_initialize(bond);
 		if (res) {
 			tlb_deinitialize(bond);
 			return res;
 		}
+		bond->alb_info.rlb_enabled = 1;
 	} else {
 		bond->alb_info.rlb_enabled = 0;
 	}
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 0d9226bdf661..33843b89ab04 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3014,9 +3014,11 @@ static void bond_activebackup_arp_mon(struct work_struct *work)
 		if (!rtnl_trylock())
 			return;
 
-		if (should_notify_peers)
+		if (should_notify_peers) {
+			bond->send_peer_notif--;
 			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 						 bond->dev);
+		}
 		if (should_notify_rtnl) {
 			bond_slave_state_notify(bond);
 			bond_slave_link_notify(bond);
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index b306210b02b7..b91c7c7b253c 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -727,13 +727,21 @@ static int cfv_probe(struct virtio_device *vdev)
 	/* Carrier is off until netdevice is opened */
 	netif_carrier_off(netdev);
 
+	/* serialize netdev register + virtio_device_ready() with ndo_open() */
+	rtnl_lock();
+
 	/* register Netdev */
-	err = register_netdev(netdev);
+	err = register_netdevice(netdev);
 	if (err) {
+		rtnl_unlock();
 		dev_err(&vdev->dev, "Unable to register netdev (%d)\n", err);
 		goto err;
 	}
 
+	virtio_device_ready(vdev);
+
+	rtnl_unlock();
+
 	debugfs_init(cfv);
 
 	return 0;
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index c6a176d8681c..4e3432182092 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1669,7 +1669,6 @@ static int grcan_probe(struct platform_device *ofdev)
 	 */
 	sysid_parent = of_find_node_by_path("/ambapp0");
 	if (sysid_parent) {
-		of_node_get(sysid_parent);
 		err = of_property_read_u32(sysid_parent, "systemid", &sysid);
 		if (!err && ((sysid & GRLIB_VERSION_MASK) >=
 			     GRCAN_TXBUG_SAFE_GRLIB_VERSION))
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 197c27d8f584..85380b63533f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1068,8 +1068,6 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 		m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(i / 4),
 				 *(u32 *)(cf->data + i));
 
-	can_put_echo_skb(skb, dev, 0);
-
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
 		cccr = m_can_read(priv, M_CAN_CCCR);
 		cccr &= ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
@@ -1086,6 +1084,9 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 
 	/* enable first TX buffer to start transfer  */
 	m_can_write(priv, M_CAN_TXBTIE, 0x1);
+
+	can_put_echo_skb(skb, dev, 0);
+
 	m_can_write(priv, M_CAN_TXBAR, 0x1);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 4d01b6cbf0eb..21e559943e34 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -206,7 +206,7 @@ struct __packed ems_cpc_msg {
 	__le32 ts_sec;	/* timestamp in seconds */
 	__le32 ts_nsec;	/* timestamp in nano seconds */
 
-	union {
+	union __packed {
 		u8 generic[64];
 		struct cpc_can_msg can_msg;
 		struct cpc_can_params can_params;
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 6771c51f72c3..e3dc59fffdb7 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -192,6 +192,8 @@ struct gs_can {
 
 	struct usb_anchor tx_submitted;
 	atomic_t active_tx_urbs;
+	void *rxbuf[GS_MAX_RX_URBS];
+	dma_addr_t rxbuf_dma[GS_MAX_RX_URBS];
 };
 
 /* usb interface struct */
@@ -601,6 +603,7 @@ static int gs_can_open(struct net_device *netdev)
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			struct urb *urb;
 			u8 *buf;
+			dma_addr_t buf_dma;
 
 			/* alloc rx urb */
 			urb = usb_alloc_urb(0, GFP_KERNEL);
@@ -611,7 +614,7 @@ static int gs_can_open(struct net_device *netdev)
 			buf = usb_alloc_coherent(dev->udev,
 						 sizeof(struct gs_host_frame),
 						 GFP_KERNEL,
-						 &urb->transfer_dma);
+						 &buf_dma);
 			if (!buf) {
 				netdev_err(netdev,
 					   "No memory left for USB buffer\n");
@@ -619,6 +622,8 @@ static int gs_can_open(struct net_device *netdev)
 				return -ENOMEM;
 			}
 
+			urb->transfer_dma = buf_dma;
+
 			/* fill, anchor, and submit rx urb */
 			usb_fill_bulk_urb(urb,
 					  dev->udev,
@@ -642,10 +647,17 @@ static int gs_can_open(struct net_device *netdev)
 					   rc);
 
 				usb_unanchor_urb(urb);
+				usb_free_coherent(dev->udev,
+						  sizeof(struct gs_host_frame),
+						  buf,
+						  buf_dma);
 				usb_free_urb(urb);
 				break;
 			}
 
+			dev->rxbuf[i] = buf;
+			dev->rxbuf_dma[i] = buf_dma;
+
 			/* Drop reference,
 			 * USB core will take care of freeing it
 			 */
@@ -710,13 +722,20 @@ static int gs_can_close(struct net_device *netdev)
 	int rc;
 	struct gs_can *dev = netdev_priv(netdev);
 	struct gs_usb *parent = dev->parent;
+	unsigned int i;
 
 	netif_stop_queue(netdev);
 
 	/* Stop polling */
 	parent->active_channels--;
-	if (!parent->active_channels)
+	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&parent->rx_submitted);
+		for (i = 0; i < GS_MAX_RX_URBS; i++)
+			usb_free_coherent(dev->udev,
+					  sizeof(struct gs_host_frame),
+					  dev->rxbuf[i],
+					  dev->rxbuf_dma[i]);
+	}
 
 	/* Stop sending URBs */
 	usb_kill_anchored_urbs(&dev->tx_submitted);
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 40b3adf7ad99..f3d61f2bb0f7 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -600,7 +600,9 @@ static void bcm_sf2_sw_adjust_link(struct dsa_switch *ds, int port,
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
 	struct ethtool_eee *p = &priv->port_sts[port].eee;
 	u32 id_mode_dis = 0, port_mode;
+	u16 lcl_adv = 0, rmt_adv = 0;
 	const char *str = NULL;
+	u8 flowctrl = 0;
 	u32 reg;
 
 	switch (phydev->interface) {
@@ -667,10 +669,27 @@ static void bcm_sf2_sw_adjust_link(struct dsa_switch *ds, int port,
 		break;
 	}
 
+	if (phydev->duplex == DUPLEX_FULL &&
+	    phydev->autoneg == AUTONEG_ENABLE) {
+		if (phydev->pause)
+			rmt_adv = LPA_PAUSE_CAP;
+		if (phydev->asym_pause)
+			rmt_adv |= LPA_PAUSE_ASYM;
+		if (phydev->advertising & ADVERTISED_Pause)
+			lcl_adv = ADVERTISE_PAUSE_CAP;
+		if (phydev->advertising & ADVERTISED_Asym_Pause)
+			lcl_adv |= ADVERTISE_PAUSE_ASYM;
+		flowctrl = mii_resolve_flowctrl_fdx(lcl_adv, rmt_adv);
+	}
+
 	if (phydev->link)
 		reg |= LINK_STS;
 	if (phydev->duplex == DUPLEX_FULL)
 		reg |= DUPLX_MODE;
+	if (flowctrl & FLOW_CTRL_TX)
+		reg |= TXFLOW_CNTL;
+	if (flowctrl & FLOW_CTRL_RX)
+		reg |= RXFLOW_CNTL;
 
 	core_writel(priv, reg, CORE_STS_OVERRIDE_GMIIP_PORT(port));
 
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 8887dd3abed7..619cc13ffb55 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -2291,7 +2291,7 @@ int be_cmd_get_beacon_state(struct be_adapter *adapter, u8 port_num, u32 *state)
 
 /* Uses sync mcc */
 int be_cmd_read_port_transceiver_data(struct be_adapter *adapter,
-				      u8 page_num, u8 *data)
+				      u8 page_num, u32 off, u32 len, u8 *data)
 {
 	struct be_dma_mem cmd;
 	struct be_mcc_wrb *wrb;
@@ -2325,10 +2325,10 @@ int be_cmd_read_port_transceiver_data(struct be_adapter *adapter,
 	req->port = cpu_to_le32(adapter->hba_port_num);
 	req->page_num = cpu_to_le32(page_num);
 	status = be_mcc_notify_wait(adapter);
-	if (!status) {
+	if (!status && len > 0) {
 		struct be_cmd_resp_port_type *resp = cmd.va;
 
-		memcpy(data, resp->page_data, PAGE_DATA_LEN);
+		memcpy(data, resp->page_data + off, len);
 	}
 err:
 	mutex_unlock(&adapter->mcc_lock);
@@ -2419,7 +2419,7 @@ int be_cmd_query_cable_type(struct be_adapter *adapter)
 	int status;
 
 	status = be_cmd_read_port_transceiver_data(adapter, TR_PAGE_A0,
-						   page_data);
+						   0, PAGE_DATA_LEN, page_data);
 	if (!status) {
 		switch (adapter->phy.interface_type) {
 		case PHY_TYPE_QSFP:
@@ -2444,7 +2444,7 @@ int be_cmd_query_sfp_info(struct be_adapter *adapter)
 	int status;
 
 	status = be_cmd_read_port_transceiver_data(adapter, TR_PAGE_A0,
-						   page_data);
+						   0, PAGE_DATA_LEN, page_data);
 	if (!status) {
 		strlcpy(adapter->phy.vendor_name, page_data +
 			SFP_VENDOR_NAME_OFFSET, SFP_VENDOR_NAME_LEN - 1);
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.h b/drivers/net/ethernet/emulex/benet/be_cmds.h
index 09da2d82c2f0..8af11a5e49fe 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.h
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.h
@@ -2431,7 +2431,7 @@ int be_cmd_set_beacon_state(struct be_adapter *adapter, u8 port_num, u8 beacon,
 int be_cmd_get_beacon_state(struct be_adapter *adapter, u8 port_num,
 			    u32 *state);
 int be_cmd_read_port_transceiver_data(struct be_adapter *adapter,
-				      u8 page_num, u8 *data);
+				      u8 page_num, u32 off, u32 len, u8 *data);
 int be_cmd_query_cable_type(struct be_adapter *adapter);
 int be_cmd_query_sfp_info(struct be_adapter *adapter);
 int lancer_cmd_read_object(struct be_adapter *adapter, struct be_dma_mem *cmd,
diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index 56db37d92937..ca7750f483f9 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -1345,7 +1345,7 @@ static int be_get_module_info(struct net_device *netdev,
 		return -EOPNOTSUPP;
 
 	status = be_cmd_read_port_transceiver_data(adapter, TR_PAGE_A0,
-						   page_data);
+						   0, PAGE_DATA_LEN, page_data);
 	if (!status) {
 		if (!page_data[SFP_PLUS_SFF_8472_COMP]) {
 			modinfo->type = ETH_MODULE_SFF_8079;
@@ -1363,25 +1363,32 @@ static int be_get_module_eeprom(struct net_device *netdev,
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
 	int status;
+	u32 begin, end;
 
 	if (!check_privilege(adapter, MAX_PRIVILEGES))
 		return -EOPNOTSUPP;
 
-	status = be_cmd_read_port_transceiver_data(adapter, TR_PAGE_A0,
-						   data);
-	if (status)
-		goto err;
+	begin = eeprom->offset;
+	end = eeprom->offset + eeprom->len;
+
+	if (begin < PAGE_DATA_LEN) {
+		status = be_cmd_read_port_transceiver_data(adapter, TR_PAGE_A0, begin,
+							   min_t(u32, end, PAGE_DATA_LEN) - begin,
+							   data);
+		if (status)
+			goto err;
+
+		data += PAGE_DATA_LEN - begin;
+		begin = PAGE_DATA_LEN;
+	}
 
-	if (eeprom->offset + eeprom->len > PAGE_DATA_LEN) {
-		status = be_cmd_read_port_transceiver_data(adapter,
-							   TR_PAGE_A2,
-							   data +
-							   PAGE_DATA_LEN);
+	if (end > PAGE_DATA_LEN) {
+		status = be_cmd_read_port_transceiver_data(adapter, TR_PAGE_A2,
+							   begin - PAGE_DATA_LEN,
+							   end - begin, data);
 		if (status)
 			goto err;
 	}
-	if (eeprom->offset)
-		memcpy(data, data + eeprom->offset, eeprom->len);
 err:
 	return be_cmd_status(status);
 }
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 031d4b3a544c..520ee8584962 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -155,11 +155,7 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 		 * NSEC_PER_SEC - ts.tv_nsec. Add the remaining nanoseconds
 		 * to current timer would be next second.
 		 */
-		tempval = readl(fep->hwp + FEC_ATIME_CTRL);
-		tempval |= FEC_T_CTRL_CAPTURE;
-		writel(tempval, fep->hwp + FEC_ATIME_CTRL);
-
-		tempval = readl(fep->hwp + FEC_ATIME);
+		tempval = fep->cc.read(&fep->cc);
 		/* Convert the ptp local counter to 1588 timestamp */
 		ns = timecounter_cyc2time(&fep->tc, tempval);
 		ts = ns_to_timespec64(ns);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d825e527ec1a..2e713e5f75cd 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8161,11 +8161,10 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 dmac_thr;
 	u16 hwm;
+	u32 reg;
 
 	if (hw->mac.type > e1000_82580) {
 		if (adapter->flags & IGB_FLAG_DMAC) {
-			u32 reg;
-
 			/* force threshold to 0. */
 			wr32(E1000_DMCTXTH, 0);
 
@@ -8198,7 +8197,6 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
 			/* Disable BMC-to-OS Watchdog Enable */
 			if (hw->mac.type != e1000_i354)
 				reg &= ~E1000_DMACR_DC_BMC2OSW_EN;
-
 			wr32(E1000_DMACR, reg);
 
 			/* no lower threshold to disable
@@ -8215,12 +8213,12 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
 			 */
 			wr32(E1000_DMCTXTH, (IGB_MIN_TXPBSIZE -
 			     (IGB_TX_BUF_4096 + adapter->max_frame_size)) >> 6);
+		}
 
-			/* make low power state decision controlled
-			 * by DMA coal
-			 */
+		if (hw->mac.type >= e1000_i210 ||
+		    (adapter->flags & IGB_FLAG_DMAC)) {
 			reg = rd32(E1000_PCIEMISC);
-			reg &= ~E1000_PCIEMISC_LX_DECISION;
+			reg |= E1000_PCIEMISC_LX_DECISION;
 			wr32(E1000_PCIEMISC, reg);
 		} /* endif adapter->dmac is not disabled */
 	} else if (hw->mac.type == e1000_82580) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index a93a1b3bb8e4..2ae59af3e16f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -1080,7 +1080,6 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
 	struct cyclecounter cc;
 	unsigned long flags;
 	u32 incval = 0;
-	u32 tsauxc = 0;
 	u32 fuse0 = 0;
 
 	/* For some of the boards below this mask is technically incorrect.
@@ -1115,18 +1114,6 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_x550em_a:
 	case ixgbe_mac_X550:
 		cc.read = ixgbe_ptp_read_X550;
-
-		/* enable SYSTIME counter */
-		IXGBE_WRITE_REG(hw, IXGBE_SYSTIMR, 0);
-		IXGBE_WRITE_REG(hw, IXGBE_SYSTIML, 0);
-		IXGBE_WRITE_REG(hw, IXGBE_SYSTIMH, 0);
-		tsauxc = IXGBE_READ_REG(hw, IXGBE_TSAUXC);
-		IXGBE_WRITE_REG(hw, IXGBE_TSAUXC,
-				tsauxc & ~IXGBE_TSAUXC_DISABLE_SYSTIME);
-		IXGBE_WRITE_REG(hw, IXGBE_TSIM, IXGBE_TSIM_TXTS);
-		IXGBE_WRITE_REG(hw, IXGBE_EIMS, IXGBE_EIMS_TIMESYNC);
-
-		IXGBE_WRITE_FLUSH(hw);
 		break;
 	case ixgbe_mac_X540:
 		cc.read = ixgbe_ptp_read_82599;
@@ -1158,6 +1145,50 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
 	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
 }
 
+/**
+ * ixgbe_ptp_init_systime - Initialize SYSTIME registers
+ * @adapter: the ixgbe private board structure
+ *
+ * Initialize and start the SYSTIME registers.
+ */
+static void ixgbe_ptp_init_systime(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 tsauxc;
+
+	switch (hw->mac.type) {
+	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
+	case ixgbe_mac_X550:
+		tsauxc = IXGBE_READ_REG(hw, IXGBE_TSAUXC);
+
+		/* Reset SYSTIME registers to 0 */
+		IXGBE_WRITE_REG(hw, IXGBE_SYSTIMR, 0);
+		IXGBE_WRITE_REG(hw, IXGBE_SYSTIML, 0);
+		IXGBE_WRITE_REG(hw, IXGBE_SYSTIMH, 0);
+
+		/* Reset interrupt settings */
+		IXGBE_WRITE_REG(hw, IXGBE_TSIM, IXGBE_TSIM_TXTS);
+		IXGBE_WRITE_REG(hw, IXGBE_EIMS, IXGBE_EIMS_TIMESYNC);
+
+		/* Activate the SYSTIME counter */
+		IXGBE_WRITE_REG(hw, IXGBE_TSAUXC,
+				tsauxc & ~IXGBE_TSAUXC_DISABLE_SYSTIME);
+		break;
+	case ixgbe_mac_X540:
+	case ixgbe_mac_82599EB:
+		/* Reset SYSTIME registers to 0 */
+		IXGBE_WRITE_REG(hw, IXGBE_SYSTIML, 0);
+		IXGBE_WRITE_REG(hw, IXGBE_SYSTIMH, 0);
+		break;
+	default:
+		/* Other devices aren't supported */
+		return;
+	};
+
+	IXGBE_WRITE_FLUSH(hw);
+}
+
 /**
  * ixgbe_ptp_reset
  * @adapter: the ixgbe private board structure
@@ -1184,6 +1215,8 @@ void ixgbe_ptp_reset(struct ixgbe_adapter *adapter)
 
 	ixgbe_ptp_start_cyclecounter(adapter);
 
+	ixgbe_ptp_init_systime(adapter);
+
 	spin_lock_irqsave(&adapter->tmreg_lock, flags);
 	timecounter_init(&adapter->hw_tc, &adapter->hw_cc,
 			 ktime_to_ns(ktime_get_real()));
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 84d667957221..61a9b60ab022 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -527,6 +527,17 @@ static inline void mtk_rx_get_desc(struct mtk_rx_dma *rxd,
 	rxd->rxd4 = READ_ONCE(dma_rxd->rxd4);
 }
 
+static void *mtk_max_lro_buf_alloc(gfp_t gfp_mask)
+{
+	unsigned int size = mtk_max_frag_size(MTK_MAX_LRO_RX_LENGTH);
+	unsigned long data;
+
+	data = __get_free_pages(gfp_mask | __GFP_COMP | __GFP_NOWARN,
+				get_order(size));
+
+	return (void *)data;
+}
+
 /* the qdma core needs scratch memory to be setup */
 static int mtk_init_fq_dma(struct mtk_eth *eth)
 {
@@ -928,7 +939,10 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			goto release_desc;
 
 		/* alloc new buffer */
-		new_data = napi_alloc_frag(ring->frag_size);
+		if (ring->frag_size <= PAGE_SIZE)
+			new_data = napi_alloc_frag(ring->frag_size);
+		else
+			new_data = mtk_max_lro_buf_alloc(GFP_ATOMIC);
 		if (unlikely(!new_data)) {
 			netdev->stats.rx_dropped++;
 			goto release_desc;
@@ -1231,7 +1245,10 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 		return -ENOMEM;
 
 	for (i = 0; i < rx_dma_size; i++) {
-		ring->data[i] = netdev_alloc_frag(ring->frag_size);
+		if (ring->frag_size <= PAGE_SIZE)
+			ring->data[i] = netdev_alloc_frag(ring->frag_size);
+		else
+			ring->data[i] = mtk_max_lro_buf_alloc(GFP_KERNEL);
 		if (!ring->data[i])
 			return -ENOMEM;
 	}
diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index aa2cef8675f4..7b8e0f624c98 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -1830,7 +1830,10 @@ static int efx_ef10_try_update_nic_stats_vf(struct efx_nic *efx)
 
 	efx_update_sw_stats(efx, stats);
 out:
+	/* releasing a DMA coherent buffer with BH disabled can panic */
+	spin_unlock_bh(&efx->stats_lock);
 	efx_nic_free_buffer(efx, &stats_buf);
+	spin_lock_bh(&efx->stats_lock);
 	return rc;
 }
 
diff --git a/drivers/net/ethernet/sfc/ef10_sriov.c b/drivers/net/ethernet/sfc/ef10_sriov.c
index bef23e19cbbd..41a60f66646d 100644
--- a/drivers/net/ethernet/sfc/ef10_sriov.c
+++ b/drivers/net/ethernet/sfc/ef10_sriov.c
@@ -414,8 +414,9 @@ static int efx_ef10_pci_sriov_enable(struct efx_nic *efx, int num_vfs)
 static int efx_ef10_pci_sriov_disable(struct efx_nic *efx, bool force)
 {
 	struct pci_dev *dev = efx->pci_dev;
+	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	unsigned int vfs_assigned = pci_vfs_assigned(dev);
-	int rc = 0;
+	int i, rc = 0;
 
 	if (vfs_assigned && !force) {
 		netif_info(efx, drv, efx->net_dev, "VFs are assigned to guests; "
@@ -423,10 +424,13 @@ static int efx_ef10_pci_sriov_disable(struct efx_nic *efx, bool force)
 		return -EBUSY;
 	}
 
-	if (!vfs_assigned)
+	if (!vfs_assigned) {
+		for (i = 0; i < efx->vf_count; i++)
+			nic_data->vf[i].pci_dev = NULL;
 		pci_disable_sriov(dev);
-	else
+	} else {
 		rc = -EBUSY;
+	}
 
 	efx_ef10_sriov_free_vf_vswitching(efx);
 	efx->vf_count = 0;
diff --git a/drivers/net/sungem_phy.c b/drivers/net/sungem_phy.c
index 92578d72e4ee..c5efdde21c2e 100644
--- a/drivers/net/sungem_phy.c
+++ b/drivers/net/sungem_phy.c
@@ -453,6 +453,7 @@ static int bcm5421_init(struct mii_phy* phy)
 		int can_low_power = 1;
 		if (np == NULL || of_get_property(np, "no-autolowpower", NULL))
 			can_low_power = 0;
+		of_node_put(np);
 		if (can_low_power) {
 			/* Enable automatic low-power */
 			sungem_phy_write(phy, 0x1c, 0x9002);
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 738d10fc595c..48938d00ff7e 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1373,6 +1373,42 @@ static int ax88179_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	 * are bundled into this buffer and where we can find an array of
 	 * per-packet metadata (which contains elements encoded into u16).
 	 */
+
+	/* SKB contents for current firmware:
+	 *   <packet 1> <padding>
+	 *   ...
+	 *   <packet N> <padding>
+	 *   <per-packet metadata entry 1> <dummy header>
+	 *   ...
+	 *   <per-packet metadata entry N> <dummy header>
+	 *   <padding2> <rx_hdr>
+	 *
+	 * where:
+	 *   <packet N> contains pkt_len bytes:
+	 *		2 bytes of IP alignment pseudo header
+	 *		packet received
+	 *   <per-packet metadata entry N> contains 4 bytes:
+	 *		pkt_len and fields AX_RXHDR_*
+	 *   <padding>	0-7 bytes to terminate at
+	 *		8 bytes boundary (64-bit).
+	 *   <padding2> 4 bytes to make rx_hdr terminate at
+	 *		8 bytes boundary (64-bit)
+	 *   <dummy-header> contains 4 bytes:
+	 *		pkt_len=0 and AX_RXHDR_DROP_ERR
+	 *   <rx-hdr>	contains 4 bytes:
+	 *		pkt_cnt and hdr_off (offset of
+	 *		  <per-packet metadata entry 1>)
+	 *
+	 * pkt_cnt is number of entrys in the per-packet metadata.
+	 * In current firmware there is 2 entrys per packet.
+	 * The first points to the packet and the
+	 *  second is a dummy header.
+	 * This was done probably to align fields in 64-bit and
+	 *  maintain compatibility with old firmware.
+	 * This code assumes that <dummy header> and <padding2> are
+	 *  optional.
+	 */
+
 	if (skb->len < 4)
 		return 0;
 	skb_trim(skb, skb->len - 4);
@@ -1387,51 +1423,66 @@ static int ax88179_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	/* Make sure that the bounds of the metadata array are inside the SKB
 	 * (and in front of the counter at the end).
 	 */
-	if (pkt_cnt * 2 + hdr_off > skb->len)
+	if (pkt_cnt * 4 + hdr_off > skb->len)
 		return 0;
 	pkt_hdr = (u32 *)(skb->data + hdr_off);
 
 	/* Packets must not overlap the metadata array */
 	skb_trim(skb, hdr_off);
 
-	for (; ; pkt_cnt--, pkt_hdr++) {
+	for (; pkt_cnt > 0; pkt_cnt--, pkt_hdr++) {
+		u16 pkt_len_plus_padd;
 		u16 pkt_len;
 
 		le32_to_cpus(pkt_hdr);
 		pkt_len = (*pkt_hdr >> 16) & 0x1fff;
+		pkt_len_plus_padd = (pkt_len + 7) & 0xfff8;
 
-		if (pkt_len > skb->len)
+		/* Skip dummy header used for alignment
+		 */
+		if (pkt_len == 0)
+			continue;
+
+		if (pkt_len_plus_padd > skb->len)
 			return 0;
 
 		/* Check CRC or runt packet */
-		if (((*pkt_hdr & (AX_RXHDR_CRC_ERR | AX_RXHDR_DROP_ERR)) == 0) &&
-		    pkt_len >= 2 + ETH_HLEN) {
-			bool last = (pkt_cnt == 0);
-
-			if (last) {
-				ax_skb = skb;
-			} else {
-				ax_skb = skb_clone(skb, GFP_ATOMIC);
-				if (!ax_skb)
-					return 0;
-			}
-			ax_skb->len = pkt_len;
-			/* Skip IP alignment pseudo header */
-			skb_pull(ax_skb, 2);
-			skb_set_tail_pointer(ax_skb, ax_skb->len);
-			ax_skb->truesize = pkt_len + sizeof(struct sk_buff);
-			ax88179_rx_checksum(ax_skb, pkt_hdr);
+		if ((*pkt_hdr & (AX_RXHDR_CRC_ERR | AX_RXHDR_DROP_ERR)) ||
+		    pkt_len < 2 + ETH_HLEN) {
+			dev->net->stats.rx_errors++;
+			skb_pull(skb, pkt_len_plus_padd);
+			continue;
+		}
 
-			if (last)
-				return 1;
+		/* last packet */
+		if (pkt_len_plus_padd == skb->len) {
+			skb_trim(skb, pkt_len);
 
-			usbnet_skb_return(dev, ax_skb);
+			/* Skip IP alignment pseudo header */
+			skb_pull(skb, 2);
+
+			skb->truesize = SKB_TRUESIZE(pkt_len_plus_padd);
+			ax88179_rx_checksum(skb, pkt_hdr);
+			return 1;
 		}
 
-		/* Trim this packet away from the SKB */
-		if (!skb_pull(skb, (pkt_len + 7) & 0xFFF8))
+		ax_skb = skb_clone(skb, GFP_ATOMIC);
+		if (!ax_skb)
 			return 0;
+		skb_trim(ax_skb, pkt_len);
+
+		/* Skip IP alignment pseudo header */
+		skb_pull(ax_skb, 2);
+
+		skb->truesize = pkt_len_plus_padd +
+				SKB_DATA_ALIGN(sizeof(struct sk_buff));
+		ax88179_rx_checksum(ax_skb, pkt_hdr);
+		usbnet_skb_return(dev, ax_skb);
+
+		skb_pull(skb, pkt_len_plus_padd);
 	}
+
+	return 0;
 }
 
 static struct sk_buff *
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 003c53a5bb33..db37cf9281e1 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -928,10 +928,16 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1031, 3)}, /* Telit LE910C1-EUX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1040, 2)},	/* Telit LE922A */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1050, 2)},	/* Telit FN980 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1060, 2)},	/* Telit LN920 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1201, 2)},	/* Telit LE920, LE920A4 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1230, 2)},	/* Telit LE910Cx */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1260, 2)},	/* Telit LE910Cx */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1261, 2)},	/* Telit LE910Cx */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1900, 1)},	/* Telit LN940 series */
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9b01, 3)},	/* XS Stick W100-2 from 4G Systems */
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 6a004742ec71..f1cb512c55ac 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -847,13 +847,11 @@ int usbnet_stop (struct net_device *net)
 
 	mpn = !test_and_clear_bit(EVENT_NO_RUNTIME_PM, &dev->flags);
 
-	/* deferred work (task, timer, softirq) must also stop.
-	 * can't flush_scheduled_work() until we drop rtnl (later),
-	 * else workers could deadlock; so make workers a NOP.
-	 */
+	/* deferred work (timer, softirq, task) must also stop */
 	dev->flags = 0;
 	del_timer_sync (&dev->delay);
 	tasklet_kill (&dev->bh);
+	cancel_work_sync(&dev->kevent);
 	if (!pm)
 		usb_autopm_put_interface(dev->intf);
 
@@ -1577,8 +1575,6 @@ void usbnet_disconnect (struct usb_interface *intf)
 	net = dev->net;
 	unregister_netdev (net);
 
-	cancel_work_sync(&dev->kevent);
-
 	usb_scuttle_anchored_urbs(&dev->deferred);
 
 	if (dev->driver_info->unbind)
@@ -1951,8 +1947,8 @@ static int __usbnet_read_cmd(struct usbnet *dev, u8 cmd, u8 reqtype,
 		   " value=0x%04x index=0x%04x size=%d\n",
 		   cmd, reqtype, value, index, size);
 
-	if (data) {
-		buf = kmalloc(size, GFP_KERNEL);
+	if (size) {
+		buf = kmalloc(size, GFP_NOIO);
 		if (!buf)
 			goto out;
 	}
@@ -1960,8 +1956,13 @@ static int __usbnet_read_cmd(struct usbnet *dev, u8 cmd, u8 reqtype,
 	err = usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0),
 			      cmd, reqtype, value, index, buf, size,
 			      USB_CTRL_GET_TIMEOUT);
-	if (err > 0 && err <= size)
-		memcpy(data, buf, err);
+	if (err > 0 && err <= size) {
+        if (data)
+            memcpy(data, buf, err);
+        else
+            netdev_dbg(dev->net,
+                "Huh? Data requested but thrown away.\n");
+    }
 	kfree(buf);
 out:
 	return err;
@@ -1979,10 +1980,16 @@ static int __usbnet_write_cmd(struct usbnet *dev, u8 cmd, u8 reqtype,
 		   cmd, reqtype, value, index, size);
 
 	if (data) {
-		buf = kmemdup(data, size, GFP_KERNEL);
+		buf = kmemdup(data, size, GFP_NOIO);
 		if (!buf)
 			goto out;
-	}
+	} else {
+        if (size) {
+            WARN_ON_ONCE(1);
+            err = -EINVAL;
+            goto out;
+        }
+    }
 
 	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),
 			      cmd, reqtype, value, index, buf, size,
@@ -2074,7 +2081,7 @@ static void usbnet_async_cmd_cb(struct urb *urb)
 int usbnet_write_cmd_async(struct usbnet *dev, u8 cmd, u8 reqtype,
 			   u16 value, u16 index, const void *data, u16 size)
 {
-	struct usb_ctrlrequest *req = NULL;
+	struct usb_ctrlrequest *req;
 	struct urb *urb;
 	int err = -ENOMEM;
 	void *buf = NULL;
@@ -2092,7 +2099,7 @@ int usbnet_write_cmd_async(struct usbnet *dev, u8 cmd, u8 reqtype,
 		if (!buf) {
 			netdev_err(dev->net, "Error allocating buffer"
 				   " in %s!\n", __func__);
-			goto fail_free;
+			goto fail_free_urb;
 		}
 	}
 
@@ -2116,14 +2123,21 @@ int usbnet_write_cmd_async(struct usbnet *dev, u8 cmd, u8 reqtype,
 	if (err < 0) {
 		netdev_err(dev->net, "Error submitting the control"
 			   " message: status=%d\n", err);
-		goto fail_free;
+		goto fail_free_all;
 	}
 	return 0;
 
+fail_free_all:
+	kfree(req);
 fail_free_buf:
 	kfree(buf);
-fail_free:
-	kfree(req);
+	/*
+	 * avoid a double free
+	 * needed because the flag can be set only
+	 * after filling the URB
+	 */
+	urb->transfer_flags = 0;
+fail_free_urb:
 	usb_free_urb(urb);
 fail:
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt7601u/usb.c b/drivers/net/wireless/mediatek/mt7601u/usb.c
index 416c6045ff31..ae83a5c36127 100644
--- a/drivers/net/wireless/mediatek/mt7601u/usb.c
+++ b/drivers/net/wireless/mediatek/mt7601u/usb.c
@@ -34,6 +34,7 @@ static struct usb_device_id mt7601u_device_table[] = {
 	{ USB_DEVICE(0x2717, 0x4106) },
 	{ USB_DEVICE(0x2955, 0x0001) },
 	{ USB_DEVICE(0x2955, 0x1001) },
+	{ USB_DEVICE(0x2955, 0x1003) },
 	{ USB_DEVICE(0x2a5f, 0x1000) },
 	{ USB_DEVICE(0x7392, 0x7710) },
 	{ 0, }
diff --git a/drivers/net/xen-netback/rx.c b/drivers/net/xen-netback/rx.c
index 29c7645f5780..2612810eadaf 100644
--- a/drivers/net/xen-netback/rx.c
+++ b/drivers/net/xen-netback/rx.c
@@ -482,6 +482,7 @@ void xenvif_rx_action(struct xenvif_queue *queue)
 	queue->rx_copy.completed = &completed_skbs;
 
 	while (xenvif_rx_ring_slots_available(queue) &&
+	       !skb_queue_empty(&queue->rx_queue) &&
 	       work_done < RX_BATCH_SIZE) {
 		xenvif_rx_skb(queue);
 		work_done++;
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 82dcd44b3e5e..cae036f5299a 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -62,6 +62,10 @@ module_param_named(max_queues, xennet_max_queues, uint, 0644);
 MODULE_PARM_DESC(max_queues,
 		 "Maximum number of queues per virtual interface");
 
+static bool __read_mostly xennet_trusted = true;
+module_param_named(trusted, xennet_trusted, bool, 0644);
+MODULE_PARM_DESC(trusted, "Is the backend trusted");
+
 #define XENNET_TIMEOUT  (5 * HZ)
 
 static const struct ethtool_ops xennet_ethtool_ops;
@@ -162,6 +166,9 @@ struct netfront_info {
 	/* Is device behaving sane? */
 	bool broken;
 
+	/* Should skbs be bounced into a zeroed buffer? */
+	bool bounce;
+
 	atomic_t rx_gso_checksum_fixup;
 };
 
@@ -260,7 +267,7 @@ static struct sk_buff *xennet_alloc_one_rx_buffer(struct netfront_queue *queue)
 	if (unlikely(!skb))
 		return NULL;
 
-	page = alloc_page(GFP_ATOMIC | __GFP_NOWARN);
+	page = alloc_page(GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO);
 	if (!page) {
 		kfree_skb(skb);
 		return NULL;
@@ -591,6 +598,34 @@ static void xennet_mark_tx_pending(struct netfront_queue *queue)
 		queue->tx_link[i] = TX_PENDING;
 }
 
+struct sk_buff *bounce_skb(const struct sk_buff *skb)
+{
+	unsigned int headerlen = skb_headroom(skb);
+	/* Align size to allocate full pages and avoid contiguous data leaks */
+	unsigned int size = ALIGN(skb_end_offset(skb) + skb->data_len,
+				  XEN_PAGE_SIZE);
+	struct sk_buff *n = alloc_skb(size, GFP_ATOMIC | __GFP_ZERO);
+
+	if (!n)
+		return NULL;
+
+	if (!IS_ALIGNED((uintptr_t)n->head, XEN_PAGE_SIZE)) {
+		WARN_ONCE(1, "misaligned skb allocated\n");
+		kfree_skb(n);
+		return NULL;
+	}
+
+	/* Set the data pointer */
+	skb_reserve(n, headerlen);
+	/* Set the tail pointer and length */
+	skb_put(n, skb->len);
+
+	BUG_ON(skb_copy_bits(skb, -headerlen, n->head, headerlen + skb->len));
+
+	skb_copy_header(n, skb);
+	return n;
+}
+
 #define MAX_XEN_SKB_FRAGS (65536 / XEN_PAGE_SIZE + 1)
 
 static int xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -643,9 +678,13 @@ static int xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* The first req should be at least ETH_HLEN size or the packet will be
 	 * dropped by netback.
+	 *
+	 * If the backend is not trusted bounce all data to zeroed pages to
+	 * avoid exposing contiguous data on the granted page not belonging to
+	 * the skb.
 	 */
-	if (unlikely(PAGE_SIZE - offset < ETH_HLEN)) {
-		nskb = skb_copy(skb, GFP_ATOMIC);
+	if (np->bounce || unlikely(PAGE_SIZE - offset < ETH_HLEN)) {
+		nskb = bounce_skb(skb);
 		if (!nskb)
 			goto drop;
 		dev_kfree_skb_any(skb);
@@ -1962,9 +2001,16 @@ static int talk_to_netback(struct xenbus_device *dev,
 	unsigned int max_queues = 0;
 	struct netfront_queue *queue = NULL;
 	unsigned int num_queues = 1;
+	unsigned int trusted;
 
 	info->netdev->irq = 0;
 
+	/* Check if backend is trusted. */
+	err = xenbus_scanf(XBT_NIL, dev->nodename, "trusted", "%u", &trusted);
+	if (err < 0)
+		trusted = 1;
+	info->bounce = !xennet_trusted || !trusted;
+
 	/* Check if backend supports multiple queues */
 	err = xenbus_scanf(XBT_NIL, info->xbdev->otherend,
 			   "multi-queue-max-queues", "%u", &max_queues);
@@ -2129,6 +2175,9 @@ static int xennet_connect(struct net_device *dev)
 	err = talk_to_netback(np->xbdev, np);
 	if (err)
 		return err;
+	if (np->bounce)
+		dev_info(&np->xbdev->dev,
+			 "bouncing transmitted data to zeroed pages\n");
 
 	/* talk_to_netback() sets the correct number of queues */
 	num_queues = dev->real_num_tx_queues;
diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
index 78b7aa835c81..bb546cabe809 100644
--- a/drivers/nfc/nfcmrvl/i2c.c
+++ b/drivers/nfc/nfcmrvl/i2c.c
@@ -186,9 +186,9 @@ static int nfcmrvl_i2c_parse_dt(struct device_node *node,
 		pdata->irq_polarity = IRQF_TRIGGER_RISING;
 
 	ret = irq_of_parse_and_map(node, 0);
-	if (ret < 0) {
-		pr_err("Unable to get irq, error: %d\n", ret);
-		return ret;
+	if (!ret) {
+		pr_err("Unable to get irq\n");
+		return -EINVAL;
 	}
 	pdata->irq = ret;
 
diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index fc8e78a29d77..d66c83efdd7d 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -130,9 +130,9 @@ static int nfcmrvl_spi_parse_dt(struct device_node *node,
 	}
 
 	ret = irq_of_parse_and_map(node, 0);
-	if (ret < 0) {
-		pr_err("Unable to get irq, error: %d\n", ret);
-		return ret;
+	if (!ret) {
+		pr_err("Unable to get irq\n");
+		return -EINVAL;
 	}
 	pdata->irq = ret;
 
diff --git a/drivers/nfc/nfcmrvl/usb.c b/drivers/nfc/nfcmrvl/usb.c
index 585a0f20835b..3263e2a2bdfd 100644
--- a/drivers/nfc/nfcmrvl/usb.c
+++ b/drivers/nfc/nfcmrvl/usb.c
@@ -401,13 +401,25 @@ static void nfcmrvl_play_deferred(struct nfcmrvl_usb_drv_data *drv_data)
 	int err;
 
 	while ((urb = usb_get_from_anchor(&drv_data->deferred))) {
+		usb_anchor_urb(urb, &drv_data->tx_anchor);
+
 		err = usb_submit_urb(urb, GFP_ATOMIC);
-		if (err)
+		if (err) {
+			kfree(urb->setup_packet);
+			usb_unanchor_urb(urb);
+			usb_free_urb(urb);
 			break;
+		}
 
 		drv_data->tx_in_flight++;
+		usb_free_urb(urb);
+	}
+
+	/* Cleanup the rest deferred urbs. */
+	while ((urb = usb_get_from_anchor(&drv_data->deferred))) {
+		kfree(urb->setup_packet);
+		usb_free_urb(urb);
 	}
-	usb_scuttle_anchored_urbs(&drv_data->deferred);
 }
 
 static int nfcmrvl_resume(struct usb_interface *intf)
diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 7eab97585f22..a9c8bfb62ebe 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -139,7 +139,9 @@ static int nxp_nci_i2c_fw_read(struct nxp_nci_i2c_phy *phy,
 	memcpy(skb_put(*skb, NXP_NCI_FW_HDR_LEN), &header, NXP_NCI_FW_HDR_LEN);
 
 	r = i2c_master_recv(client, skb_put(*skb, frame_len), frame_len);
-	if (r != frame_len) {
+	if (r < 0) {
+		goto fw_read_exit_free_skb;
+	} else if (r != frame_len) {
 		nfc_err(&client->dev,
 			"Invalid frame length: %u (expected %zu)\n",
 			r, frame_len);
@@ -180,8 +182,13 @@ static int nxp_nci_i2c_nci_read(struct nxp_nci_i2c_phy *phy,
 	memcpy(skb_put(*skb, NCI_CTRL_HDR_SIZE), (void *) &header,
 	       NCI_CTRL_HDR_SIZE);
 
+	if (!header.plen)
+		return 0;
+
 	r = i2c_master_recv(client, skb_put(*skb, header.plen), header.plen);
-	if (r != header.plen) {
+	if (r < 0) {
+		goto nci_read_exit_free_skb;
+	} else if (r != header.plen) {
 		nfc_err(&client->dev,
 			"Invalid frame payload length: %u (expected %u)\n",
 			r, header.plen);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6a239c9bbf59..513558eecfd6 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -27,6 +27,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/random.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1068,6 +1069,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 {
 	int l;
 	const char *p;
+	const void *rng_seed;
 
 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
 
@@ -1102,6 +1104,18 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	pr_debug("Command line is: %s\n", (char*)data);
 
+	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
+	if (rng_seed && l > 0) {
+		add_bootloader_randomness(rng_seed, l);
+
+		/* try to clear seed so it won't be found. */
+		fdt_nop_property(initial_boot_params, node, "rng-seed");
+
+		/* update CRC check value */
+		of_fdt_crc32 = crc32_be(~0, initial_boot_params,
+				fdt_totalsize(initial_boot_params));
+	}
+
 	/* break now */
 	return 1;
 }
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 6e237c46e1bd..969ee6b7b16b 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1455,8 +1455,10 @@ static int nmk_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 	has_config = nmk_pinctrl_dt_get_config(np, &configs);
 	np_config = of_parse_phandle(np, "ste,config", 0);
-	if (np_config)
+	if (np_config) {
 		has_config |= nmk_pinctrl_dt_get_config(np_config, &configs);
+		of_node_put(np_config);
+	}
 	if (has_config) {
 		const char *gpio_name;
 		const char *pin;
diff --git a/drivers/pinctrl/qcom/pinctrl-msm8916.c b/drivers/pinctrl/qcom/pinctrl-msm8916.c
index 20ebf244e80d..359f5b43bebc 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8916.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8916.c
@@ -852,8 +852,8 @@ static const struct msm_pingroup msm8916_groups[] = {
 	PINGROUP(28, pwr_modem_enabled_a, NA, NA, NA, NA, NA, qdss_tracedata_b, NA, atest_combodac),
 	PINGROUP(29, cci_i2c, NA, NA, NA, NA, NA, qdss_tracedata_b, NA, atest_combodac),
 	PINGROUP(30, cci_i2c, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),
-	PINGROUP(31, cci_timer0, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(32, cci_timer1, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(31, cci_timer0, flash_strobe, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(32, cci_timer1, flash_strobe, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(33, cci_async, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),
 	PINGROUP(34, pwr_nav_enabled_a, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),
 	PINGROUP(35, pwr_crypto_enabled_a, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
index 383977ea3a3c..0b5aba4bf338 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
@@ -158,26 +158,26 @@ static const struct sunxi_desc_pin sun8i_a83t_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ6 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ6 */
 		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D6 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ7 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ7 */
 		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D7 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand"),		/* DQS */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQS */
 		  SUNXI_FUNCTION(0x3, "mmc2")),		/* RST */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 17),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand")),		/* CE2 */
+		  SUNXI_FUNCTION(0x2, "nand0")),	/* CE2 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 18),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand")),		/* CE3 */
+		  SUNXI_FUNCTION(0x2, "nand0")),	/* CE3 */
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
diff --git a/drivers/power/reset/arm-versatile-reboot.c b/drivers/power/reset/arm-versatile-reboot.c
index 06d34ab47df5..8022c782f6ff 100644
--- a/drivers/power/reset/arm-versatile-reboot.c
+++ b/drivers/power/reset/arm-versatile-reboot.c
@@ -150,6 +150,7 @@ static int __init versatile_reboot_probe(void)
 	versatile_reboot_type = (enum versatile_reboot)reboot_id->data;
 
 	syscon_regmap = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(syscon_regmap))
 		return PTR_ERR(syscon_regmap);
 
diff --git a/drivers/s390/char/keyboard.h b/drivers/s390/char/keyboard.h
index a31f339211d5..b3172908f18c 100644
--- a/drivers/s390/char/keyboard.h
+++ b/drivers/s390/char/keyboard.h
@@ -44,7 +44,7 @@ static inline void
 kbd_put_queue(struct tty_port *port, int ch)
 {
 	tty_insert_flip_char(port, ch, 0);
-	tty_schedule_flip(port);
+	tty_flip_buffer_push(port);
 }
 
 static inline void
@@ -52,5 +52,5 @@ kbd_puts_queue(struct tty_port *port, char *cp)
 {
 	while (*cp)
 		tty_insert_flip_char(port, *cp++, 0);
-	tty_schedule_flip(port);
+	tty_flip_buffer_push(port);
 }
diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index fd622021748f..237b70463b46 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -144,27 +144,33 @@ void zfcp_fc_enqueue_event(struct zfcp_adapter *adapter,
 
 static int zfcp_fc_wka_port_get(struct zfcp_fc_wka_port *wka_port)
 {
+	int ret = -EIO;
+
 	if (mutex_lock_interruptible(&wka_port->mutex))
 		return -ERESTARTSYS;
 
 	if (wka_port->status == ZFCP_FC_WKA_PORT_OFFLINE ||
 	    wka_port->status == ZFCP_FC_WKA_PORT_CLOSING) {
 		wka_port->status = ZFCP_FC_WKA_PORT_OPENING;
-		if (zfcp_fsf_open_wka_port(wka_port))
+		if (zfcp_fsf_open_wka_port(wka_port)) {
+			/* could not even send request, nothing to wait for */
 			wka_port->status = ZFCP_FC_WKA_PORT_OFFLINE;
+			goto out;
+		}
 	}
 
-	mutex_unlock(&wka_port->mutex);
-
-	wait_event(wka_port->completion_wq,
+	wait_event(wka_port->opened,
 		   wka_port->status == ZFCP_FC_WKA_PORT_ONLINE ||
 		   wka_port->status == ZFCP_FC_WKA_PORT_OFFLINE);
 
 	if (wka_port->status == ZFCP_FC_WKA_PORT_ONLINE) {
 		atomic_inc(&wka_port->refcount);
-		return 0;
+		ret = 0;
+		goto out;
 	}
-	return -EIO;
+out:
+	mutex_unlock(&wka_port->mutex);
+	return ret;
 }
 
 static void zfcp_fc_wka_port_offline(struct work_struct *work)
@@ -180,9 +186,12 @@ static void zfcp_fc_wka_port_offline(struct work_struct *work)
 
 	wka_port->status = ZFCP_FC_WKA_PORT_CLOSING;
 	if (zfcp_fsf_close_wka_port(wka_port)) {
+		/* could not even send request, nothing to wait for */
 		wka_port->status = ZFCP_FC_WKA_PORT_OFFLINE;
-		wake_up(&wka_port->completion_wq);
+		goto out;
 	}
+	wait_event(wka_port->closed,
+		   wka_port->status == ZFCP_FC_WKA_PORT_OFFLINE);
 out:
 	mutex_unlock(&wka_port->mutex);
 }
@@ -192,13 +201,15 @@ static void zfcp_fc_wka_port_put(struct zfcp_fc_wka_port *wka_port)
 	if (atomic_dec_return(&wka_port->refcount) != 0)
 		return;
 	/* wait 10 milliseconds, other reqs might pop in */
-	schedule_delayed_work(&wka_port->work, HZ / 100);
+	queue_delayed_work(wka_port->adapter->work_queue, &wka_port->work,
+			   msecs_to_jiffies(10));
 }
 
 static void zfcp_fc_wka_port_init(struct zfcp_fc_wka_port *wka_port, u32 d_id,
 				  struct zfcp_adapter *adapter)
 {
-	init_waitqueue_head(&wka_port->completion_wq);
+	init_waitqueue_head(&wka_port->opened);
+	init_waitqueue_head(&wka_port->closed);
 
 	wka_port->adapter = adapter;
 	wka_port->d_id = d_id;
diff --git a/drivers/s390/scsi/zfcp_fc.h b/drivers/s390/scsi/zfcp_fc.h
index a2275825186f..2da269cd3101 100644
--- a/drivers/s390/scsi/zfcp_fc.h
+++ b/drivers/s390/scsi/zfcp_fc.h
@@ -169,7 +169,8 @@ enum zfcp_fc_wka_status {
 /**
  * struct zfcp_fc_wka_port - representation of well-known-address (WKA) FC port
  * @adapter: Pointer to adapter structure this WKA port belongs to
- * @completion_wq: Wait for completion of open/close command
+ * @opened: Wait for completion of open command
+ * @closed: Wait for completion of close command
  * @status: Current status of WKA port
  * @refcount: Reference count to keep port open as long as it is in use
  * @d_id: FC destination id or well-known-address
@@ -179,7 +180,8 @@ enum zfcp_fc_wka_status {
  */
 struct zfcp_fc_wka_port {
 	struct zfcp_adapter	*adapter;
-	wait_queue_head_t	completion_wq;
+	wait_queue_head_t	opened;
+	wait_queue_head_t	closed;
 	enum zfcp_fc_wka_status	status;
 	atomic_t		refcount;
 	u32			d_id;
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 0d2bcb33697f..7de76562678b 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -1582,7 +1582,7 @@ static void zfcp_fsf_open_wka_port_handler(struct zfcp_fsf_req *req)
 		wka_port->status = ZFCP_FC_WKA_PORT_ONLINE;
 	}
 out:
-	wake_up(&wka_port->completion_wq);
+	wake_up(&wka_port->opened);
 }
 
 /**
@@ -1640,7 +1640,7 @@ static void zfcp_fsf_close_wka_port_handler(struct zfcp_fsf_req *req)
 	}
 
 	wka_port->status = ZFCP_FC_WKA_PORT_OFFLINE;
-	wake_up(&wka_port->completion_wq);
+	wake_up(&wka_port->closed);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 30b5f65b29d1..7f230d0b2fd6 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -633,7 +633,8 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	else
 		lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
 	if (ndlp->nlp_DID == Fabric_DID) {
-		if (vport->port_state <= LPFC_FDISC)
+		if (vport->port_state <= LPFC_FDISC ||
+		    vport->fc_flag & FC_PT2PT)
 			goto out;
 		lpfc_linkdown_port(vport);
 		spin_lock_irq(shost->host_lock);
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 417927b279b6..1178656d90cb 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -196,7 +196,7 @@ static void sg_link_reserve(Sg_fd * sfp, Sg_request * srp, int size);
 static void sg_unlink_reserve(Sg_fd * sfp, Sg_request * srp);
 static Sg_fd *sg_add_sfp(Sg_device * sdp);
 static void sg_remove_sfp(struct kref *);
-static Sg_request *sg_get_rq_mark(Sg_fd * sfp, int pack_id);
+static Sg_request *sg_get_rq_mark(Sg_fd * sfp, int pack_id, bool *busy);
 static Sg_request *sg_add_request(Sg_fd * sfp);
 static int sg_remove_request(Sg_fd * sfp, Sg_request * srp);
 static Sg_device *sg_get_dev(int dev);
@@ -418,6 +418,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 	Sg_fd *sfp;
 	Sg_request *srp;
 	int req_pack_id = -1;
+	bool busy;
 	sg_io_hdr_t *hp;
 	struct sg_header *old_hdr = NULL;
 	int retval = 0;
@@ -465,25 +466,19 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 		} else
 			req_pack_id = old_hdr->pack_id;
 	}
-	srp = sg_get_rq_mark(sfp, req_pack_id);
+	srp = sg_get_rq_mark(sfp, req_pack_id, &busy);
 	if (!srp) {		/* now wait on packet to arrive */
-		if (atomic_read(&sdp->detaching)) {
-			retval = -ENODEV;
-			goto free_old_hdr;
-		}
 		if (filp->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto free_old_hdr;
 		}
 		retval = wait_event_interruptible(sfp->read_wait,
-			(atomic_read(&sdp->detaching) ||
-			(srp = sg_get_rq_mark(sfp, req_pack_id))));
-		if (atomic_read(&sdp->detaching)) {
-			retval = -ENODEV;
-			goto free_old_hdr;
-		}
-		if (retval) {
-			/* -ERESTARTSYS as signal hit process */
+			((srp = sg_get_rq_mark(sfp, req_pack_id, &busy)) ||
+			(!busy && atomic_read(&sdp->detaching))));
+		if (!srp) {
+			/* signal or detaching */
+			if (!retval)
+				retval = -ENODEV;
 			goto free_old_hdr;
 		}
 	}
@@ -936,9 +931,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		if (result < 0)
 			return result;
 		result = wait_event_interruptible(sfp->read_wait,
-			(srp_done(sfp, srp) || atomic_read(&sdp->detaching)));
-		if (atomic_read(&sdp->detaching))
-			return -ENODEV;
+			srp_done(sfp, srp));
 		write_lock_irq(&sfp->rq_list_lock);
 		if (srp->done) {
 			srp->done = 2;
@@ -2095,19 +2088,28 @@ sg_unlink_reserve(Sg_fd * sfp, Sg_request * srp)
 }
 
 static Sg_request *
-sg_get_rq_mark(Sg_fd * sfp, int pack_id)
+sg_get_rq_mark(Sg_fd * sfp, int pack_id, bool *busy)
 {
 	Sg_request *resp;
 	unsigned long iflags;
 
+	*busy = false;
 	write_lock_irqsave(&sfp->rq_list_lock, iflags);
 	list_for_each_entry(resp, &sfp->rq_list, entry) {
-		/* look for requests that are ready + not SG_IO owned */
-		if ((1 == resp->done) && (!resp->sg_io_owned) &&
+		/* look for requests that are not SG_IO owned */
+		if ((!resp->sg_io_owned) &&
 		    ((-1 == pack_id) || (resp->header.pack_id == pack_id))) {
-			resp->done = 2;	/* guard against other readers */
-			write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-			return resp;
+			switch (resp->done) {
+			case 0: /* request active */
+				*busy = true;
+				break;
+			case 1: /* request done; response ready to return */
+				resp->done = 2;	/* guard against other readers */
+				write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+				return resp;
+			case 2: /* response already being returned */
+				break;
+			}
 		}
 	}
 	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
@@ -2161,6 +2163,15 @@ sg_remove_request(Sg_fd * sfp, Sg_request * srp)
 		res = 1;
 	}
 	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+
+	/*
+	 * If the device is detaching, wakeup any readers in case we just
+	 * removed the last response, which would leave nothing for them to
+	 * return other than -ENODEV.
+	 */
+	if (unlikely(atomic_read(&sfp->parentdp->detaching)))
+		wake_up_interruptible_all(&sfp->read_wait);
+
 	return res;
 }
 
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index e9b0cc4cbb4d..d4ab22b42d69 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -126,9 +126,20 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 	return ret;
 }
 
+static bool phandle_exists(const struct device_node *np,
+			   const char *phandle_name, int index)
+{
+	struct device_node *parse_np = of_parse_phandle(np, phandle_name, index);
+
+	if (parse_np)
+		of_node_put(parse_np);
+
+	return parse_np != NULL;
+}
+
 #define MAX_PROP_SIZE 32
 static int ufshcd_populate_vreg(struct device *dev, const char *name,
-		struct ufs_vreg **out_vreg)
+				struct ufs_vreg **out_vreg)
 {
 	int ret = 0;
 	char prop_name[MAX_PROP_SIZE];
@@ -141,7 +152,7 @@ static int ufshcd_populate_vreg(struct device *dev, const char *name,
 	}
 
 	snprintf(prop_name, MAX_PROP_SIZE, "%s-supply", name);
-	if (!of_parse_phandle(np, prop_name, 0)) {
+	if (!phandle_exists(np, prop_name, 0)) {
 		dev_info(dev, "%s: Unable to find %s regulator, assuming enabled\n",
 				__func__, prop_name);
 		goto out;
diff --git a/drivers/scsi/vmw_pvscsi.h b/drivers/scsi/vmw_pvscsi.h
index d41292ef85f2..98ad17cb6643 100644
--- a/drivers/scsi/vmw_pvscsi.h
+++ b/drivers/scsi/vmw_pvscsi.h
@@ -333,8 +333,8 @@ struct PVSCSIRingReqDesc {
 	u8	tag;
 	u8	bus;
 	u8	target;
-	u8	vcpuHint;
-	u8	unused[59];
+	u16	vcpuHint;
+	u8	unused[58];
 } __packed;
 
 /*
diff --git a/drivers/staging/android/ion/ion-ioctl.c b/drivers/staging/android/ion/ion-ioctl.c
index a27865b94416..e020a23d05f2 100644
--- a/drivers/staging/android/ion/ion-ioctl.c
+++ b/drivers/staging/android/ion/ion-ioctl.c
@@ -64,14 +64,10 @@ static struct ion_handle *pass_to_user(struct ion_handle *handle)
 }
 
 /* Must hold the client lock */
-static int user_ion_handle_put_nolock(struct ion_handle *handle)
+static void user_ion_handle_put_nolock(struct ion_handle *handle)
 {
-	int ret;
-
 	if (--handle->user_ref_count == 0)
-		ret = ion_handle_put_nolock(handle);
-
-	return ret;
+		ion_handle_put_nolock(handle);
 }
 
 static void user_ion_free_nolock(struct ion_client *client,
diff --git a/drivers/staging/comedi/drivers/vmk80xx.c b/drivers/staging/comedi/drivers/vmk80xx.c
index 36470ee06596..6010c047f4f8 100644
--- a/drivers/staging/comedi/drivers/vmk80xx.c
+++ b/drivers/staging/comedi/drivers/vmk80xx.c
@@ -694,7 +694,7 @@ static int vmk80xx_alloc_usb_buffers(struct comedi_device *dev)
 	if (!devpriv->usb_rx_buf)
 		return -ENOMEM;
 
-	size = max(usb_endpoint_maxp(devpriv->ep_rx), MIN_BUF_SIZE);
+	size = max(usb_endpoint_maxp(devpriv->ep_tx), MIN_BUF_SIZE);
 	devpriv->usb_tx_buf = kzalloc(size, GFP_KERNEL);
 	if (!devpriv->usb_tx_buf)
 		return -ENOMEM;
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 5e4fa9206861..3e1d03a1b8e5 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -556,7 +556,7 @@ static void cyy_chip_rx(struct cyclades_card *cinfo, int chip,
 		}
 		info->idle_stats.recv_idle = jiffies;
 	}
-	tty_schedule_flip(port);
+	tty_flip_buffer_push(port);
 
 	/* end of service */
 	cyy_writeb(info, CyRIR, save_xir & 0x3f);
@@ -998,7 +998,7 @@ static void cyz_handle_rx(struct cyclades_port *info)
 				jiffies + 1);
 #endif
 	info->idle_stats.recv_idle = jiffies;
-	tty_schedule_flip(&info->port);
+	tty_flip_buffer_push(&info->port);
 
 	/* Update rx_get */
 	cy_writel(&buf_ctrl->rx_get, new_rx_get);
@@ -1174,7 +1174,7 @@ static void cyz_handle_cmd(struct cyclades_card *cinfo)
 		if (delta_count)
 			wake_up_interruptible(&info->port.delta_msr_wait);
 		if (special_count)
-			tty_schedule_flip(&info->port);
+			tty_flip_buffer_push(&info->port);
 	}
 }
 
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 996bd473dd03..5c075c3808af 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -85,7 +85,7 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 	writel(count, base + GOLDFISH_TTY_DATA_LEN);
 	writel(GOLDFISH_TTY_CMD_READ_BUFFER, base + GOLDFISH_TTY_CMD);
 	spin_unlock_irqrestore(&qtty->lock, irq_flags);
-	tty_schedule_flip(&qtty->port);
+	tty_flip_buffer_push(&qtty->port);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 60d37b225589..0a17abf484d4 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1397,7 +1397,7 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 		if (inited && !tty_throttled(tty) &&
 				MoxaPortRxQueue(p) > 0) { /* RX */
 			MoxaPortReadData(p);
-			tty_schedule_flip(&p->port);
+			tty_flip_buffer_push(&p->port);
 		}
 	} else {
 		clear_bit(EMPTYWAIT, &p->statusflags);
@@ -1422,7 +1422,7 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 
 	if (tty && (intr & IntrBreak) && !I_IGNBRK(tty)) { /* BREAK */
 		tty_insert_flip_char(&p->port, 0, TTY_BREAK);
-		tty_schedule_flip(&p->port);
+		tty_flip_buffer_push(&p->port);
 	}
 
 	if (intr & IntrLine)
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 8a063a036bc0..f13f2535cc85 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -106,21 +106,11 @@ static void pty_unthrottle(struct tty_struct *tty)
 static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 {
 	struct tty_struct *to = tty->link;
-	unsigned long flags;
 
-	if (tty->stopped)
+	if (tty->stopped || !c)
 		return 0;
 
-	if (c > 0) {
-		spin_lock_irqsave(&to->port->lock, flags);
-		/* Stuff the data into the input queue of the other end */
-		c = tty_insert_flip_string(to->port, buf, c);
-		spin_unlock_irqrestore(&to->port->lock, flags);
-		/* And shovel */
-		if (c)
-			tty_flip_buffer_push(to->port);
-	}
-	return c;
+	return tty_insert_flip_string_and_push_buffer(to->port, buf, c);
 }
 
 /**
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f07ede1cc3d2..9cfec014f750 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1474,6 +1474,8 @@ static inline void __stop_tx(struct uart_8250_port *p)
 
 	if (em485) {
 		unsigned char lsr = serial_in(p, UART_LSR);
+		p->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+
 		/*
 		 * To provide required timeing and allow FIFO transfer,
 		 * __stop_tx_rs485() must be called only when both FIFO and
@@ -2788,8 +2790,10 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 	case UPIO_MEM32BE:
 	case UPIO_MEM16:
 	case UPIO_MEM:
-		if (!port->mapbase)
+		if (!port->mapbase) {
+			ret = -EINVAL;
 			break;
+		}
 
 		if (!request_mem_region(port->mapbase, size, "serial")) {
 			ret = -EBUSY;
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 7eb04ae71cc8..c74b30fa7bea 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -350,7 +350,7 @@ static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
 		       LPC32XX_HSUART_IIR(port->membase));
 		port->icount.overrun++;
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
-		tty_schedule_flip(tport);
+		tty_flip_buffer_push(tport);
 	}
 
 	/* Data received? */
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 15b9bf35457b..fb35a275102f 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -241,8 +241,7 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
 	/* Enable tx dma mode */
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~(S3C64XX_UCON_TXBURST_MASK | S3C64XX_UCON_TXMODE_MASK);
-	ucon |= (dma_get_cache_alignment() >= 16) ?
-		S3C64XX_UCON_TXBURST_16 : S3C64XX_UCON_TXBURST_1;
+	ucon |= S3C64XX_UCON_TXBURST_1;
 	ucon |= S3C64XX_UCON_TXMODE_DMA;
 	wr_regl(port,  S3C2410_UCON, ucon);
 
@@ -515,7 +514,7 @@ static void enable_rx_dma(struct s3c24xx_uart_port *ourport)
 			S3C64XX_UCON_DMASUS_EN |
 			S3C64XX_UCON_TIMEOUT_EN |
 			S3C64XX_UCON_RXMODE_MASK);
-	ucon |= S3C64XX_UCON_RXBURST_16 |
+	ucon |= S3C64XX_UCON_RXBURST_1 |
 			0xf << S3C64XX_UCON_TIMEOUT_SHIFT |
 			S3C64XX_UCON_EMPTYINT_EN |
 			S3C64XX_UCON_TIMEOUT_EN |
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 481eb2989a1e..ed1658b61e54 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1143,6 +1143,8 @@ static unsigned int soc_info(unsigned int *rev_h, unsigned int *rev_l)
 		/* No compatible property, so try the name. */
 		soc_string = np->name;
 
+	of_node_put(np);
+
 	/* Extract the SOC number from the "PowerPC," string */
 	if ((sscanf(soc_string, "PowerPC,%u", &soc) != 1) || !soc)
 		return 0;
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index e65faa98146e..17ccfc33dc3d 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -388,27 +388,6 @@ int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag)
 }
 EXPORT_SYMBOL(__tty_insert_flip_char);
 
-/**
- *	tty_schedule_flip	-	push characters to ldisc
- *	@port: tty port to push from
- *
- *	Takes any pending buffers and transfers their ownership to the
- *	ldisc side of the queue. It then schedules those characters for
- *	processing by the line discipline.
- */
-
-void tty_schedule_flip(struct tty_port *port)
-{
-	struct tty_bufhead *buf = &port->buf;
-
-	/* paired w/ acquire in flush_to_ldisc(); ensures
-	 * flush_to_ldisc() sees buffer data.
-	 */
-	smp_store_release(&buf->tail->commit, buf->tail->used);
-	queue_work(system_unbound_wq, &buf->work);
-}
-EXPORT_SYMBOL(tty_schedule_flip);
-
 /**
  *	tty_prepare_flip_string		-	make room for characters
  *	@port: tty port
@@ -547,6 +526,15 @@ static void flush_to_ldisc(struct work_struct *work)
 	tty_ldisc_deref(disc);
 }
 
+static inline void tty_flip_buffer_commit(struct tty_buffer *tail)
+{
+	/*
+	 * Paired w/ acquire in flush_to_ldisc(); ensures flush_to_ldisc() sees
+	 * buffer data.
+	 */
+	smp_store_release(&tail->commit, tail->used);
+}
+
 /**
  *	tty_flip_buffer_push	-	terminal
  *	@port: tty port to push
@@ -560,10 +548,44 @@ static void flush_to_ldisc(struct work_struct *work)
 
 void tty_flip_buffer_push(struct tty_port *port)
 {
-	tty_schedule_flip(port);
+	struct tty_bufhead *buf = &port->buf;
+
+	tty_flip_buffer_commit(buf->tail);
+	queue_work(system_unbound_wq, &buf->work);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
+/**
+ * tty_insert_flip_string_and_push_buffer - add characters to the tty buffer and
+ *	push
+ * @port: tty port
+ * @chars: characters
+ * @size: size
+ *
+ * The function combines tty_insert_flip_string() and tty_flip_buffer_push()
+ * with the exception of properly holding the @port->lock.
+ *
+ * To be used only internally (by pty currently).
+ *
+ * Returns: the number added.
+ */
+int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
+		const unsigned char *chars, size_t size)
+{
+	struct tty_bufhead *buf = &port->buf;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	size = tty_insert_flip_string(port, chars, size);
+	if (size)
+		tty_flip_buffer_commit(buf->tail);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	queue_work(system_unbound_wq, &buf->work);
+
+	return size;
+}
+
 /**
  *	tty_buffer_init		-	prepare a tty buffer structure
  *	@tty: tty to initialise
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 4bc6261ef3c1..1d20abd7d3c6 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -308,7 +308,7 @@ int kbd_rate(struct kbd_repeat *rpt)
 static void put_queue(struct vc_data *vc, int ch)
 {
 	tty_insert_flip_char(&vc->port, ch, 0);
-	tty_schedule_flip(&vc->port);
+	tty_flip_buffer_push(&vc->port);
 }
 
 static void puts_queue(struct vc_data *vc, char *cp)
@@ -317,7 +317,7 @@ static void puts_queue(struct vc_data *vc, char *cp)
 		tty_insert_flip_char(&vc->port, *cp, 0);
 		cp++;
 	}
-	tty_schedule_flip(&vc->port);
+	tty_flip_buffer_push(&vc->port);
 }
 
 static void applkey(struct vc_data *vc, int key, char mode)
@@ -562,7 +562,7 @@ static void fn_inc_console(struct vc_data *vc)
 static void fn_send_intr(struct vc_data *vc)
 {
 	tty_insert_flip_char(&vc->port, 0, TTY_BREAK);
-	tty_schedule_flip(&vc->port);
+	tty_flip_buffer_push(&vc->port);
 }
 
 static void fn_scroll_forw(struct vc_data *vc)
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 9f1573b0e453..29037322d047 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1484,7 +1484,7 @@ static void respond_string(const char *p, struct tty_port *port)
 		tty_insert_flip_char(port, *p, 0);
 		p++;
 	}
-	tty_schedule_flip(port);
+	tty_flip_buffer_push(port);
 }
 
 static void cursor_report(struct vc_data *vc, struct tty_struct *tty)
@@ -4140,16 +4140,8 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 
 	if (op->data && font.charcount > op->charcount)
 		rc = -ENOSPC;
-	if (!(op->flags & KD_FONT_FLAG_OLD)) {
-		if (font.width > op->width || font.height > op->height) 
-			rc = -ENOSPC;
-	} else {
-		if (font.width != 8)
-			rc = -EIO;
-		else if ((op->height && font.height > op->height) ||
-			 font.height > 32)
-			rc = -ENOSPC;
-	}
+	if (font.width > op->width || font.height > op->height)
+		rc = -ENOSPC;
 	if (rc)
 		goto out;
 
@@ -4177,27 +4169,7 @@ static int con_font_set(struct vc_data *vc, struct console_font_op *op)
 		return -EINVAL;
 	if (op->charcount > 512)
 		return -EINVAL;
-	if (!op->height) {		/* Need to guess font height [compat] */
-		int h, i;
-		u8 __user *charmap = op->data;
-		u8 tmp;
-		
-		/* If from KDFONTOP ioctl, don't allow things which can be done in userland,
-		   so that we can get rid of this soon */
-		if (!(op->flags & KD_FONT_FLAG_OLD))
-			return -EINVAL;
-		for (h = 32; h > 0; h--)
-			for (i = 0; i < op->charcount; i++) {
-				if (get_user(tmp, &charmap[32*i+h-1]))
-					return -EFAULT;
-				if (tmp)
-					goto nonzero;
-			}
-		return -EINVAL;
-	nonzero:
-		op->height = h;
-	}
-	if (op->width <= 0 || op->width > 32 || op->height > 32)
+	if (op->width <= 0 || op->width > 32 || !op->height || op->height > 32)
 		return -EINVAL;
 	size = (op->width+7)/8 * 32 * op->charcount;
 	if (size > max_font_size)
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index e785a8a7f1c2..1306893d9fd9 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -240,48 +240,6 @@ int vt_waitactive(int n)
 #define GPLAST 0x3df
 #define GPNUM (GPLAST - GPFIRST + 1)
 
-
-
-static inline int 
-do_fontx_ioctl(struct vc_data *vc, int cmd, struct consolefontdesc __user *user_cfd, int perm, struct console_font_op *op)
-{
-	struct consolefontdesc cfdarg;
-	int i;
-
-	if (copy_from_user(&cfdarg, user_cfd, sizeof(struct consolefontdesc))) 
-		return -EFAULT;
- 	
-	switch (cmd) {
-	case PIO_FONTX:
-		if (!perm)
-			return -EPERM;
-		op->op = KD_FONT_OP_SET;
-		op->flags = KD_FONT_FLAG_OLD;
-		op->width = 8;
-		op->height = cfdarg.charheight;
-		op->charcount = cfdarg.charcount;
-		op->data = cfdarg.chardata;
-		return con_font_op(vc, op);
-
-	case GIO_FONTX:
-		op->op = KD_FONT_OP_GET;
-		op->flags = KD_FONT_FLAG_OLD;
-		op->width = 8;
-		op->height = cfdarg.charheight;
-		op->charcount = cfdarg.charcount;
-		op->data = cfdarg.chardata;
-		i = con_font_op(vc, op);
-		if (i)
-			return i;
-		cfdarg.charheight = op->height;
-		cfdarg.charcount = op->charcount;
-		if (copy_to_user(user_cfd, &cfdarg, sizeof(struct consolefontdesc)))
-			return -EFAULT;
-		return 0;
-	}
-	return -EINVAL;
-}
-
 static inline int 
 do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud, int perm, struct vc_data *vc)
 {
@@ -922,30 +880,6 @@ int vt_ioctl(struct tty_struct *tty,
 		break;
 	}
 
-	case PIO_FONT: {
-		if (!perm)
-			return -EPERM;
-		op.op = KD_FONT_OP_SET;
-		op.flags = KD_FONT_FLAG_OLD | KD_FONT_FLAG_DONT_RECALC;	/* Compatibility */
-		op.width = 8;
-		op.height = 0;
-		op.charcount = 256;
-		op.data = up;
-		ret = con_font_op(vc, &op);
-		break;
-	}
-
-	case GIO_FONT: {
-		op.op = KD_FONT_OP_GET;
-		op.flags = KD_FONT_FLAG_OLD;
-		op.width = 8;
-		op.height = 32;
-		op.charcount = 256;
-		op.data = up;
-		ret = con_font_op(vc, &op);
-		break;
-	}
-
 	case PIO_CMAP:
                 if (!perm)
 			ret = -EPERM;
@@ -957,36 +891,6 @@ int vt_ioctl(struct tty_struct *tty,
                 ret = con_get_cmap(up);
 		break;
 
-	case PIO_FONTX:
-	case GIO_FONTX:
-		ret = do_fontx_ioctl(vc, cmd, up, perm, &op);
-		break;
-
-	case PIO_FONTRESET:
-	{
-		if (!perm)
-			return -EPERM;
-
-#ifdef BROKEN_GRAPHICS_PROGRAMS
-		/* With BROKEN_GRAPHICS_PROGRAMS defined, the default
-		   font is not saved. */
-		ret = -ENOSYS;
-		break;
-#else
-		{
-		op.op = KD_FONT_OP_SET_DEFAULT;
-		op.data = NULL;
-		ret = con_font_op(vc, &op);
-		if (ret)
-			break;
-		console_lock();
-		con_set_default_unimap(vc);
-		console_unlock();
-		break;
-		}
-#endif
-	}
-
 	case KDFONTOP: {
 		if (copy_from_user(&op, up, sizeof(op))) {
 			ret = -EFAULT;
@@ -1100,54 +1004,6 @@ void vc_SAK(struct work_struct *work)
 
 #ifdef CONFIG_COMPAT
 
-struct compat_consolefontdesc {
-	unsigned short charcount;       /* characters in font (256 or 512) */
-	unsigned short charheight;      /* scan lines per character (1-32) */
-	compat_caddr_t chardata;	/* font data in expanded form */
-};
-
-static inline int
-compat_fontx_ioctl(struct vc_data *vc, int cmd,
-		   struct compat_consolefontdesc __user *user_cfd,
-		   int perm, struct console_font_op *op)
-{
-	struct compat_consolefontdesc cfdarg;
-	int i;
-
-	if (copy_from_user(&cfdarg, user_cfd, sizeof(struct compat_consolefontdesc)))
-		return -EFAULT;
-
-	switch (cmd) {
-	case PIO_FONTX:
-		if (!perm)
-			return -EPERM;
-		op->op = KD_FONT_OP_SET;
-		op->flags = KD_FONT_FLAG_OLD;
-		op->width = 8;
-		op->height = cfdarg.charheight;
-		op->charcount = cfdarg.charcount;
-		op->data = compat_ptr(cfdarg.chardata);
-		return con_font_op(vc, op);
-
-	case GIO_FONTX:
-		op->op = KD_FONT_OP_GET;
-		op->flags = KD_FONT_FLAG_OLD;
-		op->width = 8;
-		op->height = cfdarg.charheight;
-		op->charcount = cfdarg.charcount;
-		op->data = compat_ptr(cfdarg.chardata);
-		i = con_font_op(vc, op);
-		if (i)
-			return i;
-		cfdarg.charheight = op->height;
-		cfdarg.charcount = op->charcount;
-		if (copy_to_user(user_cfd, &cfdarg, sizeof(struct compat_consolefontdesc)))
-			return -EFAULT;
-		return 0;
-	}
-	return -EINVAL;
-}
-
 struct compat_console_font_op {
 	compat_uint_t op;        /* operation code KD_FONT_OP_* */
 	compat_uint_t flags;     /* KD_FONT_FLAG_* */
@@ -1229,11 +1085,6 @@ long vt_compat_ioctl(struct tty_struct *tty,
 	/*
 	 * these need special handlers for incompatible data structures
 	 */
-	case PIO_FONTX:
-	case GIO_FONTX:
-		ret = compat_fontx_ioctl(vc, cmd, up, perm, &op);
-		break;
-
 	case KDFONTOP:
 		ret = compat_kdfontop_ioctl(up, perm, &op, vc);
 		break;
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 2fbc67ca47d4..8b0d584e5d2b 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -921,6 +921,9 @@ isr_setup_status_complete(struct usb_ep *ep, struct usb_request *req)
 	struct ci_hdrc *ci = req->context;
 	unsigned long flags;
 
+	if (req->status < 0)
+		return;
+
 	if (ci->setaddr) {
 		hw_usb_set_address(ci, ci->address);
 		ci->setaddr = false;
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index e43d8df2d68c..ad2d66e12d5c 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1803,7 +1803,6 @@ static void usb_giveback_urb_bh(unsigned long param)
 
 	spin_lock_irq(&bh->lock);
 	bh->running = true;
- restart:
 	list_replace_init(&bh->head, &local_list);
 	spin_unlock_irq(&bh->lock);
 
@@ -1817,10 +1816,17 @@ static void usb_giveback_urb_bh(unsigned long param)
 		bh->completing_ep = NULL;
 	}
 
-	/* check if there are new URBs to giveback */
+	/*
+	 * giveback new URBs next time to prevent this function
+	 * from not exiting for a long time.
+	 */
 	spin_lock_irq(&bh->lock);
-	if (!list_empty(&bh->head))
-		goto restart;
+	if (!list_empty(&bh->head)) {
+		if (bh->high_prio)
+			tasklet_hi_schedule(&bh->bh);
+		else
+			tasklet_schedule(&bh->bh);
+	}
 	bh->running = false;
 	spin_unlock_irq(&bh->lock);
 }
@@ -1845,7 +1851,7 @@ static void usb_giveback_urb_bh(unsigned long param)
 void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
 {
 	struct giveback_urb_bh *bh;
-	bool running, high_prio_bh;
+	bool running;
 
 	/* pass status to tasklet via unlinked */
 	if (likely(!urb->unlinked))
@@ -1856,13 +1862,10 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
 		return;
 	}
 
-	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe)) {
+	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe))
 		bh = &hcd->high_prio_bh;
-		high_prio_bh = true;
-	} else {
+	else
 		bh = &hcd->low_prio_bh;
-		high_prio_bh = false;
-	}
 
 	spin_lock(&bh->lock);
 	list_add_tail(&urb->urb_list, &bh->head);
@@ -1871,7 +1874,7 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
 
 	if (running)
 		;
-	else if (high_prio_bh)
+	else if (bh->high_prio)
 		tasklet_hi_schedule(&bh->bh);
 	else
 		tasklet_schedule(&bh->bh);
@@ -2880,6 +2883,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 
 	/* initialize tasklets */
 	init_giveback_urb_bh(&hcd->high_prio_bh);
+	hcd->high_prio_bh.high_prio = true;
 	init_giveback_urb_bh(&hcd->low_prio_bh);
 
 	/* enable irqs just before we start the controller,
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ccc47594064f..68762501e963 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2886,7 +2886,6 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	}
 
 	evt->count = 0;
-	evt->flags &= ~DWC3_EVENT_PENDING;
 	ret = IRQ_HANDLED;
 
 	/* Unmask interrupt */
@@ -2894,6 +2893,9 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	reg &= ~DWC3_GEVNTSIZ_INTMASK;
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
 
+	/* Keep the clearing of DWC3_EVENT_PENDING at the end */
+	evt->flags &= ~DWC3_EVENT_PENDING;
+
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index b2fc97dbda45..f4d4b7c3eacb 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -365,6 +365,7 @@ ep_io (struct ep_data *epdata, void *buf, unsigned len)
 				spin_unlock_irq (&epdata->dev->lock);
 
 				DBG (epdata->dev, "endpoint gone\n");
+				wait_for_completion(&done);
 				epdata->status = -ENODEV;
 			}
 		}
diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 710793161795..498a44ae2b92 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -3034,6 +3034,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	}
 
 	udc->isp1301_i2c_client = isp1301_get_client(isp1301_node);
+	of_node_put(isp1301_node);
 	if (!udc->isp1301_i2c_client) {
 		retval = -EPROBE_DEFER;
 		goto phy_fail;
diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
index 4f87a5c61b08..d22a70363fbf 100644
--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -168,6 +168,7 @@ static int ohci_hcd_ppc_of_probe(struct platform_device *op)
 				release_mem_region(res.start, 0x4);
 		} else
 			pr_debug("%s: cannot get ehci offset from fdt\n", __FILE__);
+		of_node_put(np);
 	}
 
 	irq_dispose_mapping(irq);
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 5c4fa4fcb1e8..d818aed9043d 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1018,6 +1018,9 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, CHETCO_SEASMART_DISPLAY_PID) },
 	{ USB_DEVICE(FTDI_VID, CHETCO_SEASMART_LITE_PID) },
 	{ USB_DEVICE(FTDI_VID, CHETCO_SEASMART_ANALOG_PID) },
+	/* Belimo Automation devices */
+	{ USB_DEVICE(FTDI_VID, BELIMO_ZTH_PID) },
+	{ USB_DEVICE(FTDI_VID, BELIMO_ZIP_PID) },
 	/* ICP DAS I-756xU devices */
 	{ USB_DEVICE(ICPDAS_VID, ICPDAS_I7560U_PID) },
 	{ USB_DEVICE(ICPDAS_VID, ICPDAS_I7561U_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 006e92d26bab..e2f0bb716a5f 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1567,6 +1567,12 @@
 #define CHETCO_SEASMART_LITE_PID	0xA5AE /* SeaSmart Lite USB Adapter */
 #define CHETCO_SEASMART_ANALOG_PID	0xA5AF /* SeaSmart Analog Adapter */
 
+/*
+ * Belimo Automation
+ */
+#define BELIMO_ZTH_PID			0x8050
+#define BELIMO_ZIP_PID			0xC811
+
 /*
  * Unjo AB
  */
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index e98532feb0cc..8e49eb68896a 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -172,6 +172,7 @@ static const struct usb_device_id edgeport_2port_id_table[] = {
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_8S) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416B) },
+	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_E5805A) },
 	{ }
 };
 
@@ -210,6 +211,7 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_8S) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416B) },
+	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_E5805A) },
 	{ }
 };
 
diff --git a/drivers/usb/serial/io_usbvend.h b/drivers/usb/serial/io_usbvend.h
index 6f6a856bc37c..a470262dcf48 100644
--- a/drivers/usb/serial/io_usbvend.h
+++ b/drivers/usb/serial/io_usbvend.h
@@ -215,6 +215,7 @@
 //
 // Definitions for other product IDs
 #define ION_DEVICE_ID_MT4X56USB			0x1403	// OEM device
+#define ION_DEVICE_ID_E5805A			0x1A01  // OEM device (rebranded Edgeport/4)
 
 
 #define	GENERATION_ID_FROM_USB_PRODUCT_ID(ProductId)				\
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 5b198d881a40..f54ab5706cd1 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -430,6 +430,8 @@ static void option_instat_callback(struct urb *urb);
 #define CINTERION_PRODUCT_CLS8			0x00b0
 #define CINTERION_PRODUCT_MV31_MBIM		0x00b3
 #define CINTERION_PRODUCT_MV31_RMNET		0x00b7
+#define CINTERION_PRODUCT_MV31_2_MBIM		0x00b8
+#define CINTERION_PRODUCT_MV31_2_RMNET		0x00b9
 #define CINTERION_PRODUCT_MV32_WA		0x00f1
 #define CINTERION_PRODUCT_MV32_WB		0x00f2
 
@@ -1251,6 +1253,7 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1231, 0xff),	/* Telit LE910Cx (RNDIS) */
 	  .driver_info = NCTRL(2) | RSVD(3) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x1250, 0xff, 0x00, 0x00) },	/* Telit LE910Cx (rmnet) */
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x1260),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x1261),
@@ -1953,6 +1956,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3)},
 	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_RMNET, 0xff),
 	  .driver_info = RSVD(0)},
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_2_MBIM, 0xff),
+	  .driver_info = RSVD(3)},
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_2_RMNET, 0xff),
+	  .driver_info = RSVD(0)},
 	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WA, 0xff),
 	  .driver_info = RSVD(3)},
 	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WB, 0xff),
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 881fc3a55edc..5798965f42b5 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1793,6 +1793,7 @@ struct vfio_info_cap_header *vfio_info_cap_add(struct vfio_info_cap *caps,
 	buf = krealloc(caps->buf, caps->size + size, GFP_KERNEL);
 	if (!buf) {
 		kfree(caps->buf);
+		caps->buf = NULL;
 		caps->size = 0;
 		return ERR_PTR(-ENOMEM);
 	}
diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index 7bc5f6056c77..4147a9534179 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -399,7 +399,7 @@ static int i740fb_decode_var(const struct fb_var_screeninfo *var,
 	u32 xres, right, hslen, left, xtotal;
 	u32 yres, lower, vslen, upper, ytotal;
 	u32 vxres, xoffset, vyres, yoffset;
-	u32 bpp, base, dacspeed24, mem;
+	u32 bpp, base, dacspeed24, mem, freq;
 	u8 r7;
 	int i;
 
@@ -641,7 +641,12 @@ static int i740fb_decode_var(const struct fb_var_screeninfo *var,
 	par->atc[VGA_ATC_OVERSCAN] = 0;
 
 	/* Calculate VCLK that most closely matches the requested dot clock */
-	i740_calc_vclk((((u32)1e9) / var->pixclock) * (u32)(1e3), par);
+	freq = (((u32)1e9) / var->pixclock) * (u32)(1e3);
+	if (freq < I740_RFREQ_FIX) {
+		fb_dbg(info, "invalid pixclock\n");
+		freq = I740_RFREQ_FIX;
+	}
+	i740_calc_vclk(freq, par);
 
 	/* Since we program the clocks ourselves, always use VCLK2. */
 	par->misc |= 0x0C;
diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 1a4070f719c2..9b32b9fc44a5 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -614,6 +614,11 @@ static int pm2fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		return -EINVAL;
 	}
 
+	if (!var->pixclock) {
+		DPRINTK("pixclock is zero\n");
+		return -EINVAL;
+	}
+
 	if (PICOS2KHZ(var->pixclock) > PM2_MAX_PIXCLOCK) {
 		DPRINTK("pixclock too high (%ldKHz)\n",
 			PICOS2KHZ(var->pixclock));
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 50840984fbfa..413f6af4d132 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -66,6 +66,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
@@ -489,6 +490,28 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.bus_name	= vm_bus_name,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int virtio_mmio_freeze(struct device *dev)
+{
+	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+	return virtio_device_freeze(&vm_dev->vdev);
+}
+
+static int virtio_mmio_restore(struct device *dev)
+{
+	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+	if (vm_dev->version == 1)
+		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
+
+	return virtio_device_restore(&vm_dev->vdev);
+}
+
+static const struct dev_pm_ops virtio_mmio_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(virtio_mmio_freeze, virtio_mmio_restore)
+};
+#endif
 
 
 /* Platform device */
@@ -630,6 +653,7 @@ static int vm_cmdline_set(const char *device,
 	if (!vm_cmdline_parent_registered) {
 		err = device_register(&vm_cmdline_parent);
 		if (err) {
+			put_device(&vm_cmdline_parent);
 			pr_err("Failed to register parent device!\n");
 			return err;
 		}
@@ -729,6 +753,9 @@ static struct platform_driver virtio_mmio_driver = {
 		.name	= "virtio-mmio",
 		.of_match_table	= virtio_mmio_match,
 		.acpi_match_table = ACPI_PTR(virtio_mmio_acpi_match),
+#ifdef CONFIG_PM_SLEEP
+		.pm	= &virtio_mmio_pm_ops,
+#endif
 	},
 };
 
diff --git a/drivers/xen/features.c b/drivers/xen/features.c
index d7d34fdfc993..f466f776604f 100644
--- a/drivers/xen/features.c
+++ b/drivers/xen/features.c
@@ -28,6 +28,6 @@ void xen_setup_features(void)
 		if (HYPERVISOR_xen_version(XENVER_get_features, &fi) < 0)
 			break;
 		for (j = 0; j < 32; j++)
-			xen_features[i * 32 + j] = !!(fi.submap & 1<<j);
+			xen_features[i * 32 + j] = !!(fi.submap & 1U << j);
 	}
 }
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 69d59102ff1b..a6585854a85f 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -57,6 +57,7 @@ MODULE_PARM_DESC(limit, "Maximum number of grants that may be mapped by "
 
 static atomic_t pages_mapped = ATOMIC_INIT(0);
 
+/* True in PV mode, false otherwise */
 static int use_ptemod;
 #define populate_freeable_maps use_ptemod
 
@@ -92,11 +93,16 @@ struct grant_map {
 	struct gnttab_unmap_grant_ref *unmap_ops;
 	struct gnttab_map_grant_ref   *kmap_ops;
 	struct gnttab_unmap_grant_ref *kunmap_ops;
+	bool *being_removed;
 	struct page **pages;
 	unsigned long pages_vm_start;
+	/* Number of live grants */
+	atomic_t live_grants;
+	/* Needed to avoid allocation in unmap_grant_pages */
+	struct gntab_unmap_queue_data unmap_data;
 };
 
-static int unmap_grant_pages(struct grant_map *map, int offset, int pages);
+static void unmap_grant_pages(struct grant_map *map, int offset, int pages);
 
 /* ------------------------------------------------------------------ */
 
@@ -127,6 +133,7 @@ static void gntdev_free_map(struct grant_map *map)
 	kfree(map->unmap_ops);
 	kfree(map->kmap_ops);
 	kfree(map->kunmap_ops);
+	kfree(map->being_removed);
 	kfree(map);
 }
 
@@ -145,12 +152,15 @@ static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count)
 	add->kmap_ops  = kcalloc(count, sizeof(add->kmap_ops[0]), GFP_KERNEL);
 	add->kunmap_ops = kcalloc(count, sizeof(add->kunmap_ops[0]), GFP_KERNEL);
 	add->pages     = kcalloc(count, sizeof(add->pages[0]), GFP_KERNEL);
+	add->being_removed =
+		kcalloc(count, sizeof(add->being_removed[0]), GFP_KERNEL);
 	if (NULL == add->grants    ||
 	    NULL == add->map_ops   ||
 	    NULL == add->unmap_ops ||
 	    NULL == add->kmap_ops  ||
 	    NULL == add->kunmap_ops ||
-	    NULL == add->pages)
+	    NULL == add->pages     ||
+	    NULL == add->being_removed)
 		goto err;
 
 	if (gnttab_alloc_pages(count, add->pages))
@@ -215,6 +225,34 @@ static void gntdev_put_map(struct gntdev_priv *priv, struct grant_map *map)
 		return;
 
 	atomic_sub(map->count, &pages_mapped);
+	if (map->pages && !use_ptemod) {
+		/*
+		 * Increment the reference count.  This ensures that the
+		 * subsequent call to unmap_grant_pages() will not wind up
+		 * re-entering itself.  It *can* wind up calling
+		 * gntdev_put_map() recursively, but such calls will be with a
+		 * reference count greater than 1, so they will return before
+		 * this code is reached.  The recursion depth is thus limited to
+		 * 1.
+		 */
+		atomic_set(&map->users, 1);
+
+		/*
+		 * Unmap the grants.  This may or may not be asynchronous, so it
+		 * is possible that the reference count is 1 on return, but it
+		 * could also be greater than 1.
+		 */
+		unmap_grant_pages(map, 0, map->count);
+
+		/* Check if the memory now needs to be freed */
+		if (!atomic_dec_and_test(&map->users))
+			return;
+
+		/*
+		 * All pages have been returned to the hypervisor, so free the
+		 * map.
+		 */
+	}
 
 	if (map->notify.flags & UNMAP_NOTIFY_SEND_EVENT) {
 		notify_remote_via_evtchn(map->notify.event);
@@ -272,6 +310,7 @@ static int set_grant_ptes_as_special(pte_t *pte, pgtable_t token,
 
 static int map_grant_pages(struct grant_map *map)
 {
+	size_t alloced = 0;
 	int i, err = 0;
 
 	if (!use_ptemod) {
@@ -320,85 +359,108 @@ static int map_grant_pages(struct grant_map *map)
 			map->pages, map->count);
 
 	for (i = 0; i < map->count; i++) {
-		if (map->map_ops[i].status == GNTST_okay)
+		if (map->map_ops[i].status == GNTST_okay) {
 			map->unmap_ops[i].handle = map->map_ops[i].handle;
-		else if (!err)
+			if (!use_ptemod)
+				alloced++;
+		} else if (!err)
 			err = -EINVAL;
 
 		if (map->flags & GNTMAP_device_map)
 			map->unmap_ops[i].dev_bus_addr = map->map_ops[i].dev_bus_addr;
 
 		if (use_ptemod) {
-			if (map->kmap_ops[i].status == GNTST_okay)
+			if (map->kmap_ops[i].status == GNTST_okay) {
+				if (map->map_ops[i].status == GNTST_okay)
+					alloced++;
 				map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
-			else if (!err)
+			} else if (!err)
 				err = -EINVAL;
 		}
 	}
+	atomic_add(alloced, &map->live_grants);
 	return err;
 }
 
-static int __unmap_grant_pages(struct grant_map *map, int offset, int pages)
+static void __unmap_grant_pages_done(int result,
+		struct gntab_unmap_queue_data *data)
 {
-	int i, err = 0;
-	struct gntab_unmap_queue_data unmap_data;
+	unsigned int i;
+	struct grant_map *map = data->data;
+	unsigned int offset = data->unmap_ops - map->unmap_ops;
+
+	for (i = 0; i < data->count; i++) {
+		WARN_ON(map->unmap_ops[offset+i].status &&
+			map->unmap_ops[offset+i].handle != -1);
+		pr_debug("unmap handle=%d st=%d\n",
+			map->unmap_ops[offset+i].handle,
+			map->unmap_ops[offset+i].status);
+		map->unmap_ops[offset+i].handle = -1;
+	}
+	/*
+	 * Decrease the live-grant counter.  This must happen after the loop to
+	 * prevent premature reuse of the grants by gnttab_mmap().
+	 */
+	atomic_sub(data->count, &map->live_grants);
 
+	/* Release reference taken by unmap_grant_pages */
+	gntdev_put_map(NULL, map);
+}
+
+static void __unmap_grant_pages(struct grant_map *map, int offset, int pages)
+{
 	if (map->notify.flags & UNMAP_NOTIFY_CLEAR_BYTE) {
 		int pgno = (map->notify.addr >> PAGE_SHIFT);
+
 		if (pgno >= offset && pgno < offset + pages) {
 			/* No need for kmap, pages are in lowmem */
 			uint8_t *tmp = pfn_to_kaddr(page_to_pfn(map->pages[pgno]));
+
 			tmp[map->notify.addr & (PAGE_SIZE-1)] = 0;
 			map->notify.flags &= ~UNMAP_NOTIFY_CLEAR_BYTE;
 		}
 	}
 
-	unmap_data.unmap_ops = map->unmap_ops + offset;
-	unmap_data.kunmap_ops = use_ptemod ? map->kunmap_ops + offset : NULL;
-	unmap_data.pages = map->pages + offset;
-	unmap_data.count = pages;
+	map->unmap_data.unmap_ops = map->unmap_ops + offset;
+	map->unmap_data.kunmap_ops = use_ptemod ? map->kunmap_ops + offset : NULL;
+	map->unmap_data.pages = map->pages + offset;
+	map->unmap_data.count = pages;
+	map->unmap_data.done = __unmap_grant_pages_done;
+	map->unmap_data.data = map;
+	atomic_inc(&map->users); /* to keep map alive during async call below */
 
-	err = gnttab_unmap_refs_sync(&unmap_data);
-	if (err)
-		return err;
-
-	for (i = 0; i < pages; i++) {
-		if (map->unmap_ops[offset+i].status)
-			err = -EINVAL;
-		pr_debug("unmap handle=%d st=%d\n",
-			map->unmap_ops[offset+i].handle,
-			map->unmap_ops[offset+i].status);
-		map->unmap_ops[offset+i].handle = -1;
-	}
-	return err;
+	gnttab_unmap_refs_async(&map->unmap_data);
 }
 
-static int unmap_grant_pages(struct grant_map *map, int offset, int pages)
+static void unmap_grant_pages(struct grant_map *map, int offset, int pages)
 {
-	int range, err = 0;
+	int range;
+
+	if (atomic_read(&map->live_grants) == 0)
+		return; /* Nothing to do */
 
 	pr_debug("unmap %d+%d [%d+%d]\n", map->index, map->count, offset, pages);
 
 	/* It is possible the requested range will have a "hole" where we
 	 * already unmapped some of the grants. Only unmap valid ranges.
 	 */
-	while (pages && !err) {
-		while (pages && map->unmap_ops[offset].handle == -1) {
+	while (pages) {
+		while (pages && map->being_removed[offset]) {
 			offset++;
 			pages--;
 		}
 		range = 0;
 		while (range < pages) {
-			if (map->unmap_ops[offset+range].handle == -1)
+			if (map->being_removed[offset + range])
 				break;
+			map->being_removed[offset + range] = true;
 			range++;
 		}
-		err = __unmap_grant_pages(map, offset, range);
+		if (range)
+			__unmap_grant_pages(map, offset, range);
 		offset += range;
 		pages -= range;
 	}
-
-	return err;
 }
 
 /* ------------------------------------------------------------------ */
@@ -454,7 +516,6 @@ static void unmap_if_in_range(struct grant_map *map,
 			      unsigned long start, unsigned long end)
 {
 	unsigned long mstart, mend;
-	int err;
 
 	if (!map->vma)
 		return;
@@ -468,10 +529,9 @@ static void unmap_if_in_range(struct grant_map *map,
 			map->index, map->count,
 			map->vma->vm_start, map->vma->vm_end,
 			start, end, mstart, mend);
-	err = unmap_grant_pages(map,
+	unmap_grant_pages(map,
 				(mstart - map->vma->vm_start) >> PAGE_SHIFT,
 				(mend - mstart) >> PAGE_SHIFT);
-	WARN_ON(err);
 }
 
 static void mn_invl_range_start(struct mmu_notifier *mn,
@@ -503,7 +563,6 @@ static void mn_release(struct mmu_notifier *mn,
 {
 	struct gntdev_priv *priv = container_of(mn, struct gntdev_priv, mn);
 	struct grant_map *map;
-	int err;
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry(map, &priv->maps, next) {
@@ -512,8 +571,7 @@ static void mn_release(struct mmu_notifier *mn,
 		pr_debug("map %d+%d (%lx %lx)\n",
 				map->index, map->count,
 				map->vma->vm_start, map->vma->vm_end);
-		err = unmap_grant_pages(map, /* offset */ 0, map->count);
-		WARN_ON(err);
+		unmap_grant_pages(map, /* offset */ 0, map->count);
 	}
 	list_for_each_entry(map, &priv->freeable_maps, next) {
 		if (!map->vma)
@@ -521,8 +579,7 @@ static void mn_release(struct mmu_notifier *mn,
 		pr_debug("map %d+%d (%lx %lx)\n",
 				map->index, map->count,
 				map->vma->vm_start, map->vma->vm_end);
-		err = unmap_grant_pages(map, /* offset */ 0, map->count);
-		WARN_ON(err);
+		unmap_grant_pages(map, /* offset */ 0, map->count);
 	}
 	mutex_unlock(&priv->lock);
 }
@@ -1012,6 +1069,10 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 		goto unlock_out;
 	}
 
+	if (atomic_read(&map->live_grants)) {
+		err = -EAGAIN;
+		goto unlock_out;
+	}
 	atomic_inc(&map->users);
 
 	vma->vm_ops = &gntdev_vmops;
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 07f6ba6ccaa7..f9fc618e77f3 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -122,7 +122,7 @@ static ssize_t xenbus_file_read(struct file *filp,
 {
 	struct xenbus_file_priv *u = filp->private_data;
 	struct read_buffer *rb;
-	unsigned i;
+	ssize_t i;
 	int ret;
 
 	mutex_lock(&u->reply_mutex);
@@ -142,7 +142,7 @@ static ssize_t xenbus_file_read(struct file *filp,
 	rb = list_entry(u->read_buffers.next, struct read_buffer, list);
 	i = 0;
 	while (i < len) {
-		unsigned sz = min((unsigned)len - i, rb->len - rb->cons);
+		size_t sz = min_t(size_t, len - i, rb->len - rb->cons);
 
 		ret = copy_to_user(ubuf + i, &rb->msg[rb->cons], sz);
 
diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index e7df65d32c91..136345b45b29 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -262,4 +262,3 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(xen_xlate_map_ballooned_pages);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 425bc1a2b8c1..77a97195ef35 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -656,14 +656,10 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 		if (stat->st_result_mask & P9_STATS_NLINK)
 			set_nlink(inode, stat->st_nlink);
 		if (stat->st_result_mask & P9_STATS_MODE) {
-			inode->i_mode = stat->st_mode;
-			if ((S_ISBLK(inode->i_mode)) ||
-						(S_ISCHR(inode->i_mode)))
-				init_special_inode(inode, inode->i_mode,
-								inode->i_rdev);
+			mode = stat->st_mode & S_IALLUGO;
+			mode |= inode->i_mode & ~S_IALLUGO;
+			inode->i_mode = mode;
 		}
-		if (stat->st_result_mask & P9_STATS_RDEV)
-			inode->i_rdev = new_decode_dev(stat->st_rdev);
 		if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE) &&
 		    stat->st_result_mask & P9_STATS_SIZE)
 			v9fs_i_size_write(inode, stat->st_size);
diff --git a/fs/attr.c b/fs/attr.c
index c902b3d53508..509cccc37742 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -111,6 +111,8 @@ EXPORT_SYMBOL(setattr_prepare);
  */
 int inode_newsize_ok(const struct inode *inode, loff_t offset)
 {
+	if (offset < 0)
+		return -EINVAL;
 	if (inode->i_size < offset) {
 		unsigned long limit;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 46ecb7405af1..b83e96f51a5f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2774,6 +2774,20 @@ int open_ctree(struct super_block *sb,
 		err = -EINVAL;
 		goto fail_alloc;
 	}
+	/*
+	 * We have unsupported RO compat features, although RO mounted, we
+	 * should not cause any metadata write, including log replay.
+	 * Or we could screw up whatever the new feature requires.
+	 */
+	if (unlikely(features && btrfs_super_log_root(disk_super) &&
+		     !btrfs_test_opt(fs_info, NOLOGREPLAY))) {
+		btrfs_err(fs_info,
+"cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
+			  features);
+		err = -EINVAL;
+		goto fail_alloc;
+	}
+
 
 	max_active = fs_info->thread_pool_size;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 312c050d0dbd..9ddf48ae8022 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1074,7 +1074,9 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	extref = btrfs_lookup_inode_extref(NULL, root, path, name, namelen,
 					   inode_objectid, parent_objectid, 0,
 					   0);
-	if (!IS_ERR_OR_NULL(extref)) {
+	if (IS_ERR(extref)) {
+		return PTR_ERR(extref);
+	} else if (extref) {
 		u32 item_size;
 		u32 cur_offset = 0;
 		unsigned long base;
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index fccbf5567e78..783214344ac1 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -375,6 +375,9 @@ static int btrfs_xattr_handler_get(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, void *buffer, size_t size)
 {
+	if (btrfs_root_readonly(BTRFS_I(inode)->root))
+		return -EROFS;
+
 	name = xattr_full_name(handler, name);
 	return __btrfs_getxattr(inode, name, buffer, size);
 }
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3ca319e6c979..3a7087a8f623 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -40,6 +40,9 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	struct ext4_inode *raw_inode;
 	int free, min_offs;
 
+	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
+		return 0;
+
 	min_offs = EXT4_SB(inode->i_sb)->s_inode_size -
 			EXT4_GOOD_OLD_INODE_SIZE -
 			EXT4_I(inode)->i_extra_isize -
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 754b33828853..b32fc7e45ba1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1659,7 +1659,14 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 		ext4_lblk_t start, last;
 		start = index << (PAGE_SHIFT - inode->i_blkbits);
 		last = end << (PAGE_SHIFT - inode->i_blkbits);
+
+		/*
+		 * avoid racing with extent status tree scans made by
+		 * ext4_insert_delayed_block()
+		 */
+		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_es_remove_extent(inode, start, last - start + 1);
+		up_write(&EXT4_I(inode)->i_data_sem);
 	}
 
 	pagevec_init(&pvec, 0);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 2a7fb2cf19b8..f39b65601233 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3142,6 +3142,15 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	size = size >> bsbits;
 	start = start_off >> bsbits;
 
+	/*
+	 * For tiny groups (smaller than 8MB) the chosen allocation
+	 * alignment may be larger than group size. Make sure the
+	 * alignment does not move allocation to a different group which
+	 * makes mballoc fail assertions later.
+	 */
+	start = max(start, rounddown(ac->ac_o_ex.fe_logical,
+			(ext4_lblk_t)EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
+
 	/* don't cover already allocated blocks in selected range */
 	if (ar->pleft && start <= ar->lleft) {
 		size -= ar->lleft + 1 - start;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 159d259e5e5e..1281181215aa 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -51,6 +51,7 @@ static struct buffer_head *ext4_append(handle_t *handle,
 					struct inode *inode,
 					ext4_lblk_t *block)
 {
+	struct ext4_map_blocks map;
 	struct buffer_head *bh;
 	int err;
 
@@ -60,6 +61,21 @@ static struct buffer_head *ext4_append(handle_t *handle,
 		return ERR_PTR(-ENOSPC);
 
 	*block = inode->i_size >> inode->i_sb->s_blocksize_bits;
+	map.m_lblk = *block;
+	map.m_len = 1;
+
+	/*
+	 * We're appending new directory block. Make sure the block is not
+	 * allocated yet, otherwise we will end up corrupting the
+	 * directory.
+	 */
+	err = ext4_map_blocks(NULL, inode, &map, 0);
+	if (err < 0)
+		return ERR_PTR(err);
+	if (err) {
+		EXT4_ERROR_INODE(inode, "Logical block already allocated");
+		return ERR_PTR(-EFSCORRUPTED);
+	}
 
 	bh = ext4_bread(handle, inode, *block, EXT4_GET_BLOCKS_CREATE);
 	if (IS_ERR(bh))
@@ -1726,7 +1742,8 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 			struct dx_hash_info *hinfo)
 {
 	unsigned blocksize = dir->i_sb->s_blocksize;
-	unsigned count, continued;
+	unsigned continued;
+	int count;
 	struct buffer_head *bh2;
 	ext4_lblk_t newblock;
 	u32 hash2;
@@ -2776,11 +2793,8 @@ bool ext4_empty_dir(struct inode *inode)
 		de = (struct ext4_dir_entry_2 *) (bh->b_data +
 					(offset & (sb->s_blocksize - 1)));
 		if (ext4_check_dir_entry(inode, NULL, de, bh,
-					 bh->b_data, bh->b_size, offset)) {
-			offset = (offset | (sb->s_blocksize - 1)) + 1;
-			continue;
-		}
-		if (le32_to_cpu(de->inode)) {
+					 bh->b_data, bh->b_size, offset) ||
+		    le32_to_cpu(de->inode)) {
 			brelse(bh);
 			return false;
 		}
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 51fa706707a3..e4f02572f69d 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -51,6 +51,16 @@ int ext4_resize_begin(struct super_block *sb)
 	if (!capable(CAP_SYS_RESOURCE))
 		return -EPERM;
 
+	/*
+	 * If the reserved GDT blocks is non-zero, the resize_inode feature
+	 * should always be set.
+	 */
+	if (EXT4_SB(sb)->s_es->s_reserved_gdt_blocks &&
+	    !ext4_has_feature_resize_inode(sb)) {
+		ext4_error(sb, "resize_inode disabled but reserved GDT blocks non-zero");
+		return -EFSCORRUPTED;
+	}
+
 	/*
 	 * If we are not using the primary superblock/GDT copy don't resize,
          * because the user tools have no way of handling this.  Probably a
@@ -1436,6 +1446,7 @@ static void ext4_update_super(struct super_block *sb,
 	 * Update the fs overhead information
 	 */
 	ext4_calculate_overhead(sb);
+	es->s_overhead_clusters = cpu_to_le32(sbi->s_overhead);
 
 	if (test_opt(sb, DEBUG))
 		printk(KERN_DEBUG "EXT4-fs: added group %u:"
@@ -1930,6 +1941,16 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	}
 	brelse(bh);
 
+	/*
+	 * For bigalloc, trim the requested size to the nearest cluster
+	 * boundary to avoid creating an unusable filesystem. We do this
+	 * silently, instead of returning an error, to avoid breaking
+	 * callers that blindly resize the filesystem to the full size of
+	 * the underlying block device.
+	 */
+	if (ext4_has_feature_bigalloc(sb))
+		n_blocks_count &= ~((1 << EXT4_CLUSTER_BITS(sb)) - 1);
+
 retry:
 	o_blocks_count = ext4_blocks_count(es);
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index ec9beaa69abb..6b14ecb382df 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1053,8 +1053,9 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	struct ext4_inode *raw_inode;
 	int error;
 
-	if (EXT4_I(inode)->i_extra_isize == 0)
+	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
 		return 0;
+
 	raw_inode = ext4_raw_inode(&is->iloc);
 	header = IHDR(inode, raw_inode);
 	is->s.base = is->s.first = IFIRST(header);
@@ -1107,8 +1108,9 @@ static int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 	struct ext4_xattr_search *s = &is->s;
 	int error;
 
-	if (EXT4_I(inode)->i_extra_isize == 0)
+	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
 		return -ENOSPC;
+
 	error = ext4_xattr_set_entry(i, s, inode);
 	if (error)
 		return error;
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 099c8b670ef5..bbe569142985 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -76,6 +76,19 @@ struct ext4_xattr_entry {
 
 #define EXT4_ZERO_XATTR_VALUE ((void *)-1)
 
+/*
+ * If we want to add an xattr to the inode, we should make sure that
+ * i_extra_isize is not 0 and that the inode size is not less than
+ * EXT4_GOOD_OLD_INODE_SIZE + extra_isize + pad.
+ *   EXT4_GOOD_OLD_INODE_SIZE   extra_isize header   entry   pad  data
+ * |--------------------------|------------|------|---------|---|-------|
+ */
+#define EXT4_INODE_HAS_XATTR_SPACE(inode)				\
+	((EXT4_I(inode)->i_extra_isize != 0) &&				\
+	 (EXT4_GOOD_OLD_INODE_SIZE + EXT4_I(inode)->i_extra_isize +	\
+	  sizeof(struct ext4_xattr_ibody_header) + EXT4_XATTR_PAD <=	\
+	  EXT4_INODE_SIZE((inode)->i_sb)))
+
 struct ext4_xattr_info {
 	int name_index;
 	const char *name;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 585c52dbb2e3..13cf7c260a83 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -992,7 +992,17 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
 
 	while (count) {
 		if (cs->write && cs->pipebufs && page) {
-			return fuse_ref_page(cs, page, offset, count);
+			/*
+			 * Can't control lifetime of pipe buffers, so always
+			 * copy user pages.
+			 */
+			if (cs->req->user_pages) {
+				err = fuse_copy_fill(cs);
+				if (err)
+					return err;
+			} else {
+				return fuse_ref_page(cs, page, offset, count);
+			}
 		} else if (!cs->len) {
 			if (cs->move_pages && page &&
 			    offset == 0 && count == PAGE_SIZE) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8aef8e56eb1b..aa4f0d632bed 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1319,6 +1319,7 @@ static int fuse_get_user_pages(struct fuse_req *req, struct iov_iter *ii,
 			(PAGE_SIZE - ret) & (PAGE_SIZE - 1);
 	}
 
+	req->user_pages = true;
 	if (write)
 		req->in.argpages = 1;
 	else
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7e4b0e298bc7..6104534ddb7e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -310,6 +310,8 @@ struct fuse_req {
 	/** refcount */
 	atomic_t count;
 
+	bool user_pages;
+
 	/** Unique ID for the interrupt request */
 	u64 intr_unique;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 77b8f0f26407..205ee5d3f4d5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -173,6 +173,12 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	inode->i_uid     = make_kuid(&init_user_ns, attr->uid);
 	inode->i_gid     = make_kgid(&init_user_ns, attr->gid);
 	inode->i_blocks  = attr->blocks;
+
+	/* Sanitize nsecs */
+	attr->atimensec = min_t(u32, attr->atimensec, NSEC_PER_SEC - 1);
+	attr->mtimensec = min_t(u32, attr->mtimensec, NSEC_PER_SEC - 1);
+	attr->ctimensec = min_t(u32, attr->ctimensec, NSEC_PER_SEC - 1);
+
 	inode->i_atime.tv_sec   = attr->atime;
 	inode->i_atime.tv_nsec  = attr->atimensec;
 	/* mtime from server may be stale due to local buffered write */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index cd268ce8c770..7c3b1b40ce9c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8229,6 +8229,9 @@ static int nfs41_reclaim_complete_handle_errors(struct rpc_task *task, struct nf
 		rpc_delay(task, NFS4_POLL_RETRY_MAX);
 		/* fall through */
 	case -NFS4ERR_RETRY_UNCACHED_REP:
+	case -EACCES:
+		dprintk("%s: failed to reclaim complete error %d for server %s, retrying\n",
+			__func__, task->tk_status, clp->cl_hostname);
 		return -EAGAIN;
 	case -NFS4ERR_BADSESSION:
 	case -NFS4ERR_DEADSESSION:
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index f19cded49b29..317d22f84492 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1753,6 +1753,12 @@ pnfs_update_layout(struct inode *ino,
 			/* Fallthrough */
 		case -EAGAIN:
 			break;
+		case -ENODATA:
+			/* The server returned NFS4ERR_LAYOUTUNAVAILABLE */
+			pnfs_layout_set_fail_bit(
+				lo, pnfs_iomode_to_fail_bit(iomode));
+			lseg = NULL;
+			goto out_put_layout_hdr;
 		default:
 			if (!nfs_error_is_fatal(PTR_ERR(lseg))) {
 				pnfs_layout_clear_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 33f8c8fc96e8..a89704271428 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -212,6 +212,9 @@ static inline int nilfs_acl_chmod(struct inode *inode)
 
 static inline int nilfs_init_acl(struct inode *inode, struct inode *dir)
 {
+	if (S_ISLNK(inode->i_mode))
+		return 0;
+
 	inode->i_mode &= ~current_umask();
 	return 0;
 }
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 44a39a099b54..62b49197e5f6 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -606,8 +606,12 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
 		a = (ATTR_RECORD*)((u8*)ctx->attr +
 				le32_to_cpu(ctx->attr->length));
 	for (;;	a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
-		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > (u8*)ctx->mrec +
-				le32_to_cpu(ctx->mrec->bytes_allocated))
+		u8 *mrec_end = (u8 *)ctx->mrec +
+		               le32_to_cpu(ctx->mrec->bytes_allocated);
+		u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
+			       a->name_length * sizeof(ntfschar);
+		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
+		    name_end > mrec_end)
 			break;
 		ctx->attr = a;
 		if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 186d153db454..5759e3c2c008 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1676,7 +1676,8 @@ const struct inode_operations proc_pid_link_inode_operations = {
 
 /* building an inode */
 
-struct inode *proc_pid_make_inode(struct super_block * sb, struct task_struct *task)
+struct inode *proc_pid_make_inode(struct super_block * sb,
+				  struct task_struct *task, umode_t mode)
 {
 	struct inode * inode;
 	struct proc_inode *ei;
@@ -1690,6 +1691,7 @@ struct inode *proc_pid_make_inode(struct super_block * sb, struct task_struct *t
 
 	/* Common stuff */
 	ei = PROC_I(inode);
+	inode->i_mode = mode;
 	inode->i_ino = get_next_ino();
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	inode->i_op = &proc_def_inode_operations;
@@ -2041,7 +2043,9 @@ proc_map_files_instantiate(struct inode *dir, struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFLNK |
+				    ((mode & FMODE_READ ) ? S_IRUSR : 0) |
+				    ((mode & FMODE_WRITE) ? S_IWUSR : 0));
 	if (!inode)
 		return -ENOENT;
 
@@ -2050,12 +2054,6 @@ proc_map_files_instantiate(struct inode *dir, struct dentry *dentry,
 
 	inode->i_op = &proc_map_files_link_inode_operations;
 	inode->i_size = 64;
-	inode->i_mode = S_IFLNK;
-
-	if (mode & FMODE_READ)
-		inode->i_mode |= S_IRUSR;
-	if (mode & FMODE_WRITE)
-		inode->i_mode |= S_IWUSR;
 
 	d_set_d_op(dentry, &tid_map_files_dentry_operations);
 	d_add(dentry, inode);
@@ -2409,12 +2407,11 @@ static int proc_pident_instantiate(struct inode *dir,
 	struct inode *inode;
 	struct proc_inode *ei;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, p->mode);
 	if (!inode)
 		goto out;
 
 	ei = PROC_I(inode);
-	inode->i_mode = p->mode;
 	if (S_ISDIR(inode->i_mode))
 		set_nlink(inode, 2);	/* Use getattr to fix if necessary */
 	if (p->iop)
@@ -3109,11 +3106,10 @@ static int proc_pid_instantiate(struct inode *dir,
 {
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		goto out;
 
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_flags|=S_IMMUTABLE;
@@ -3404,11 +3400,10 @@ static int proc_task_instantiate(struct inode *dir,
 	struct dentry *dentry, struct task_struct *task, const void *ptr)
 {
 	struct inode *inode;
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
 
 	if (!inode)
 		goto out;
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
 	inode->i_op = &proc_tid_base_inode_operations;
 	inode->i_fop = &proc_tid_base_operations;
 	inode->i_flags|=S_IMMUTABLE;
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index d21dafef3102..4274f83bf100 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -183,14 +183,13 @@ proc_fd_instantiate(struct inode *dir, struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFLNK);
 	if (!inode)
 		goto out;
 
 	ei = PROC_I(inode);
 	ei->fd = fd;
 
-	inode->i_mode = S_IFLNK;
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
 
@@ -322,14 +321,13 @@ proc_fdinfo_instantiate(struct inode *dir, struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFREG | S_IRUSR);
 	if (!inode)
 		goto out;
 
 	ei = PROC_I(inode);
 	ei->fd = fd;
 
-	inode->i_mode = S_IFREG | S_IRUSR;
 	inode->i_fop = &proc_fdinfo_file_operations;
 
 	d_set_d_op(dentry, &tid_fd_dentry_operations);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index c0bdeceaaeb6..5bc057be6fa3 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -163,7 +163,7 @@ extern int proc_pid_statm(struct seq_file *, struct pid_namespace *,
 extern const struct dentry_operations pid_dentry_operations;
 extern int pid_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 extern int proc_setattr(struct dentry *, struct iattr *);
-extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *);
+extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *, umode_t);
 extern int pid_revalidate(struct dentry *, unsigned int);
 extern int pid_delete_dentry(const struct dentry *);
 extern int proc_pid_readdir(struct file *, struct dir_context *);
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 51b8b0a8ad91..766f0c637ad1 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -92,12 +92,11 @@ static int proc_ns_instantiate(struct inode *dir,
 	struct inode *inode;
 	struct proc_inode *ei;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFLNK | S_IRWXUGO);
 	if (!inode)
 		goto out;
 
 	ei = PROC_I(inode);
-	inode->i_mode = S_IFLNK|S_IRWXUGO;
 	inode->i_op = &proc_ns_link_inode_operations;
 	ei->ns_ops = ns_ops;
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index c5f2f1e3cc4b..48d62da62226 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2973,7 +2973,6 @@ xfs_rename(
 	 * appropriately.
 	 */
 	if (flags & RENAME_WHITEOUT) {
-		ASSERT(!(flags & (RENAME_NOREPLACE | RENAME_EXCHANGE)));
 		error = xfs_rename_alloc_whiteout(target_dp, &wip);
 		if (error)
 			return error;
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 4df64a1fc09e..09e9fd061ac0 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -87,7 +87,7 @@ static inline bool memory_contains(void *begin, void *end, void *virt,
 /**
  * memory_intersects - checks if the region occupied by an object intersects
  *                     with another memory region
- * @begin: virtual address of the beginning of the memory regien
+ * @begin: virtual address of the beginning of the memory region
  * @end: virtual address of the end of the memory region
  * @virt: virtual address of the memory object
  * @size: size of the memory object
@@ -100,7 +100,10 @@ static inline bool memory_intersects(void *begin, void *end, void *virt,
 {
 	void *vend = virt + size;
 
-	return (virt >= begin && virt < end) || (vend >= begin && vend < end);
+	if (virt < end && vend > begin)
+		return true;
+
+	return false;
 }
 
 /**
diff --git a/include/crypto/blake2s.h b/include/crypto/blake2s.h
new file mode 100644
index 000000000000..d439496fa6ba
--- /dev/null
+++ b/include/crypto/blake2s.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _CRYPTO_BLAKE2S_H
+#define _CRYPTO_BLAKE2S_H
+
+#include <linux/bug.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+enum blake2s_lengths {
+	BLAKE2S_BLOCK_SIZE = 64,
+	BLAKE2S_HASH_SIZE = 32,
+	BLAKE2S_KEY_SIZE = 32,
+
+	BLAKE2S_128_HASH_SIZE = 16,
+	BLAKE2S_160_HASH_SIZE = 20,
+	BLAKE2S_224_HASH_SIZE = 28,
+	BLAKE2S_256_HASH_SIZE = 32,
+};
+
+struct blake2s_state {
+	u32 h[8];
+	u32 t[2];
+	u32 f[2];
+	u8 buf[BLAKE2S_BLOCK_SIZE];
+	unsigned int buflen;
+	unsigned int outlen;
+};
+
+enum blake2s_iv {
+	BLAKE2S_IV0 = 0x6A09E667UL,
+	BLAKE2S_IV1 = 0xBB67AE85UL,
+	BLAKE2S_IV2 = 0x3C6EF372UL,
+	BLAKE2S_IV3 = 0xA54FF53AUL,
+	BLAKE2S_IV4 = 0x510E527FUL,
+	BLAKE2S_IV5 = 0x9B05688CUL,
+	BLAKE2S_IV6 = 0x1F83D9ABUL,
+	BLAKE2S_IV7 = 0x5BE0CD19UL,
+};
+
+void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen);
+void blake2s_final(struct blake2s_state *state, u8 *out);
+
+static inline void blake2s_init_param(struct blake2s_state *state,
+				      const u32 param)
+{
+	*state = (struct blake2s_state){{
+		BLAKE2S_IV0 ^ param,
+		BLAKE2S_IV1,
+		BLAKE2S_IV2,
+		BLAKE2S_IV3,
+		BLAKE2S_IV4,
+		BLAKE2S_IV5,
+		BLAKE2S_IV6,
+		BLAKE2S_IV7,
+	}};
+}
+
+static inline void blake2s_init(struct blake2s_state *state,
+				const size_t outlen)
+{
+	blake2s_init_param(state, 0x01010000 | outlen);
+	state->outlen = outlen;
+}
+
+static inline void blake2s_init_key(struct blake2s_state *state,
+				    const size_t outlen, const void *key,
+				    const size_t keylen)
+{
+	WARN_ON(IS_ENABLED(DEBUG) && (!outlen || outlen > BLAKE2S_HASH_SIZE ||
+		!key || !keylen || keylen > BLAKE2S_KEY_SIZE));
+
+	blake2s_init_param(state, 0x01010000 | keylen << 8 | outlen);
+	memcpy(state->buf, key, keylen);
+	state->buflen = BLAKE2S_BLOCK_SIZE;
+	state->outlen = outlen;
+}
+
+static inline void blake2s(u8 *out, const u8 *in, const u8 *key,
+			   const size_t outlen, const size_t inlen,
+			   const size_t keylen)
+{
+	struct blake2s_state state;
+
+	WARN_ON(IS_ENABLED(DEBUG) && ((!in && inlen > 0) || !out || !outlen ||
+		outlen > BLAKE2S_HASH_SIZE || keylen > BLAKE2S_KEY_SIZE ||
+		(!key && keylen)));
+
+	if (keylen)
+		blake2s_init_key(&state, outlen, key, keylen);
+	else
+		blake2s_init(&state, outlen);
+
+	blake2s_update(&state, in, inlen);
+	blake2s_final(&state, out);
+}
+
+#endif /* _CRYPTO_BLAKE2S_H */
diff --git a/include/crypto/chacha20.h b/include/crypto/chacha20.h
index 20d20f681a72..0b8deb5e8291 100644
--- a/include/crypto/chacha20.h
+++ b/include/crypto/chacha20.h
@@ -16,11 +16,26 @@ struct chacha20_ctx {
 	u32 key[8];
 };
 
-void chacha20_block(u32 *state, void *stream);
+void chacha20_block(u32 *state, u8 *stream);
 void crypto_chacha20_init(u32 *state, struct chacha20_ctx *ctx, u8 *iv);
 int crypto_chacha20_setkey(struct crypto_tfm *tfm, const u8 *key,
 			   unsigned int keysize);
 int crypto_chacha20_crypt(struct blkcipher_desc *desc, struct scatterlist *dst,
 			  struct scatterlist *src, unsigned int nbytes);
 
+enum chacha_constants { /* expand 32-byte k */
+	CHACHA_CONSTANT_EXPA = 0x61707865U,
+	CHACHA_CONSTANT_ND_3 = 0x3320646eU,
+	CHACHA_CONSTANT_2_BY = 0x79622d32U,
+	CHACHA_CONSTANT_TE_K = 0x6b206574U
+};
+
+static inline void chacha_init_consts(u32 *state)
+{
+	state[0]  = CHACHA_CONSTANT_EXPA;
+	state[1]  = CHACHA_CONSTANT_ND_3;
+	state[2]  = CHACHA_CONSTANT_2_BY;
+	state[3]  = CHACHA_CONSTANT_TE_K;
+}
+
 #endif
diff --git a/include/crypto/drbg.h b/include/crypto/drbg.h
index 22f884c97387..19b44179bb7c 100644
--- a/include/crypto/drbg.h
+++ b/include/crypto/drbg.h
@@ -105,6 +105,12 @@ struct drbg_test_data {
 	struct drbg_string *testentropy; /* TEST PARAMETER: test entropy */
 };
 
+enum drbg_seed_state {
+	DRBG_SEED_STATE_UNSEEDED,
+	DRBG_SEED_STATE_PARTIAL, /* Seeded with !rng_is_initialized() */
+	DRBG_SEED_STATE_FULL,
+};
+
 struct drbg_state {
 	struct mutex drbg_mutex;	/* lock around DRBG */
 	unsigned char *V;	/* internal state 10.1.1.1 1a) */
@@ -129,14 +135,14 @@ struct drbg_state {
 	struct completion ctr_completion;	/* CTR mode async handler */
 	int ctr_async_err;			/* CTR mode async error */
 
-	bool seeded;		/* DRBG fully seeded? */
+	enum drbg_seed_state seeded;		/* DRBG fully seeded? */
 	bool pr;		/* Prediction resistance enabled? */
-	struct work_struct seed_work;	/* asynchronous seeding support */
+	bool fips_primed;	/* Continuous test primed? */
+	unsigned char *prev;	/* FIPS 140-2 continuous test value */
 	struct crypto_rng *jent;
 	const struct drbg_state_ops *d_ops;
 	const struct drbg_core *core;
 	struct drbg_string test_data;
-	struct random_ready_callback random_ready;
 };
 
 static inline __u8 drbg_statelen(struct drbg_state *drbg)
@@ -184,11 +190,7 @@ static inline size_t drbg_max_addtl(struct drbg_state *drbg)
 static inline size_t drbg_max_requests(struct drbg_state *drbg)
 {
 	/* SP800-90A requires 2**48 maximum requests before reseeding */
-#if (__BITS_PER_LONG == 32)
-	return SIZE_MAX;
-#else
-	return (1UL<<48);
-#endif
+	return (1<<20);
 }
 
 /*
diff --git a/include/crypto/internal/blake2s.h b/include/crypto/internal/blake2s.h
new file mode 100644
index 000000000000..3ba066845b69
--- /dev/null
+++ b/include/crypto/internal/blake2s.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+
+#ifndef _CRYPTO_INTERNAL_BLAKE2S_H
+#define _CRYPTO_INTERNAL_BLAKE2S_H
+
+#include <crypto/blake2s.h>
+
+void blake2s_compress_generic(struct blake2s_state *state,const u8 *block,
+			      size_t nblocks, const u32 inc);
+
+void blake2s_compress_arch(struct blake2s_state *state,const u8 *block,
+			   size_t nblocks, const u32 inc);
+
+static inline void blake2s_set_lastblock(struct blake2s_state *state)
+{
+	state->f[0] = -1;
+}
+
+#endif /* _CRYPTO_INTERNAL_BLAKE2S_H */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fe520d40597f..7a1e6d3d0fd9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -246,6 +246,8 @@ struct bpf_prog *bpf_prog_get_type(u32 ufd, enum bpf_prog_type type);
 struct bpf_prog *bpf_prog_add(struct bpf_prog *prog, int i);
 struct bpf_prog *bpf_prog_inc(struct bpf_prog *prog);
 void bpf_prog_put(struct bpf_prog *prog);
+int __bpf_prog_charge(struct user_struct *user, u32 pages);
+void __bpf_prog_uncharge(struct user_struct *user, u32 pages);
 
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 struct bpf_map *__bpf_map_get(struct fd f);
@@ -328,6 +330,15 @@ static inline struct bpf_prog *bpf_prog_inc(struct bpf_prog *prog)
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline int __bpf_prog_charge(struct user_struct *user, u32 pages)
+{
+	return 0;
+}
+
+static inline void __bpf_prog_uncharge(struct user_struct *user, u32 pages)
+{
+}
+
 static inline bool unprivileged_ebpf_enabled(void)
 {
 	return false;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 0744157a97ca..404d5e71394a 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -155,7 +155,6 @@ static __always_inline int test_clear_buffer_##name(struct buffer_head *bh) \
  * of the form "mark_buffer_foo()".  These are higher-level functions which
  * do something in addition to setting a b_state bit.
  */
-BUFFER_FNS(Uptodate, uptodate)
 BUFFER_FNS(Dirty, dirty)
 TAS_BUFFER_FNS(Dirty, dirty)
 BUFFER_FNS(Lock, locked)
@@ -173,6 +172,30 @@ BUFFER_FNS(Meta, meta)
 BUFFER_FNS(Prio, prio)
 BUFFER_FNS(Defer_Completion, defer_completion)
 
+static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
+{
+	/*
+	 * make it consistent with folio_mark_uptodate
+	 * pairs with smp_load_acquire in buffer_uptodate
+	 */
+	smp_mb__before_atomic();
+	set_bit(BH_Uptodate, &bh->b_state);
+}
+
+static __always_inline void clear_buffer_uptodate(struct buffer_head *bh)
+{
+	clear_bit(BH_Uptodate, &bh->b_state);
+}
+
+static __always_inline int buffer_uptodate(const struct buffer_head *bh)
+{
+	/*
+	 * make it consistent with folio_test_uptodate
+	 * pairs with smp_mb__before_atomic in set_buffer_uptodate
+	 */
+	return (smp_load_acquire(&bh->b_state) & (1UL << BH_Uptodate)) != 0;
+}
+
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
 /* If we *know* page->private refers to buffer_heads */
diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/generic.h
index 89f67c1c3160..9cf01d7bb7c0 100644
--- a/include/linux/byteorder/generic.h
+++ b/include/linux/byteorder/generic.h
@@ -155,6 +155,23 @@ static inline void le64_add_cpu(__le64 *var, u64 val)
 	*var = cpu_to_le64(le64_to_cpu(*var) + val);
 }
 
+/* XXX: this stuff can be optimized */
+static inline void le32_to_cpu_array(u32 *buf, unsigned int words)
+{
+	while (words--) {
+		__le32_to_cpus(buf);
+		buf++;
+	}
+}
+
+static inline void cpu_to_le32_array(u32 *buf, unsigned int words)
+{
+	while (words--) {
+		__cpu_to_le32s(buf);
+		buf++;
+	}
+}
+
 static inline void be16_add_cpu(__be16 *var, u16 val)
 {
 	*var = cpu_to_be16(be16_to_cpu(*var) + val);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 1ab0273560ae..8160ad1885dc 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -29,6 +29,7 @@ enum cpuhp_state {
 	CPUHP_ACPI_CPUDRV_DEAD,
 	CPUHP_S390_PFAULT_DEAD,
 	CPUHP_BLK_MQ_DEAD,
+	CPUHP_RANDOM_PREPARE,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
@@ -119,6 +120,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_CCN_ONLINE,
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
+	CPUHP_AP_RANDOM_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_NOTIFY_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
diff --git a/include/linux/hw_random.h b/include/linux/hw_random.h
index 34a0dc18f327..48e28f7844fe 100644
--- a/include/linux/hw_random.h
+++ b/include/linux/hw_random.h
@@ -60,7 +60,5 @@ extern int devm_hwrng_register(struct device *dev, struct hwrng *rng);
 /** Unregister a Hardware Random Number Generator driver. */
 extern void hwrng_unregister(struct hwrng *rng);
 extern void devm_hwrng_unregister(struct device *dve, struct hwrng *rng);
-/** Feed random bits into the pool. */
-extern void add_hwgenerator_randomness(const char *buffer, size_t count, size_t entropy);
 
 #endif /* LINUX_HWRANDOM_H_ */
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 529da7ef55e3..bb5547a83daf 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -67,7 +67,6 @@ struct irq_desc {
 	unsigned int		irqs_unhandled;
 	atomic_t		threads_handled;
 	int			threads_handled_last;
-	u64			random_ip;
 	raw_spinlock_t		lock;
 	struct cpumask		*percpu_enabled;
 	const struct cpumask	*percpu_affinity;
diff --git a/include/linux/kd.h b/include/linux/kd.h
deleted file mode 100644
index 25bd17fad239..000000000000
--- a/include/linux/kd.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _LINUX_KD_H
-#define _LINUX_KD_H
-
-#include <uapi/linux/kd.h>
-
-#define KD_FONT_FLAG_OLD		0x80000000	/* Invoked via old interface [compat] */
-#endif /* _LINUX_KD_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 406c33dcae13..565be657098b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -148,6 +148,28 @@ struct kexec_file_ops {
 	kexec_verify_sig_t *verify_sig;
 #endif
 };
+
+#ifndef arch_kexec_apply_relocations_add
+/* Apply relocations of type RELA */
+static inline int
+arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
+				 Elf_Shdr *sechdrs, unsigned int relsec)
+{
+	pr_err("RELA relocation unsupported.\n");
+	return -ENOEXEC;
+}
+#endif
+
+#ifndef arch_kexec_apply_relocations
+/* Apply relocations of type REL */
+static inline int
+arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
+			     unsigned int relsec)
+{
+	pr_err("REL relocation unsupported.\n");
+	return -ENOEXEC;
+}
+#endif
 #endif
 
 struct kimage {
@@ -320,10 +342,6 @@ void * __weak arch_kexec_kernel_image_load(struct kimage *image);
 int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
 int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 					unsigned long buf_len);
-int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
-					Elf_Shdr *sechdrs, unsigned int relsec);
-int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
-					unsigned int relsec);
 void arch_kexec_protect_crashkres(void);
 void arch_kexec_unprotect_crashkres(void);
 
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 0c3ff5b23f6a..70af9a177197 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -22,6 +22,8 @@ struct local_irq_lock {
 	unsigned long		flags;
 };
 
+#define INIT_LOCAL_LOCK(lvar)			{ .lock = __SPIN_LOCK_UNLOCKED((lvar).lock.lock) }
+
 #define DEFINE_LOCAL_IRQ_LOCK(lvar)					\
 	DEFINE_PER_CPU(struct local_irq_lock, lvar) = {			\
 		.lock = __SPIN_LOCK_UNLOCKED((lvar).lock) }
@@ -256,6 +258,9 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 #else /* PREEMPT_RT_BASE */
 
+struct local_irq_lock { };
+#define INIT_LOCAL_LOCK(lvar)			{ }
+
 #define DEFINE_LOCAL_IRQ_LOCK(lvar)		__typeof__(const int) lvar
 #define DECLARE_LOCAL_IRQ_LOCK(lvar)		extern __typeof__(const int) lvar
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 53ac461f342b..491385a8a69d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -666,11 +666,6 @@
  *	@sig contains the signal value.
  *	@secid contains the sid of the process where the signal originated
  *	Return 0 if permission is granted.
- * @task_wait:
- *	Check permission before allowing a process to reap a child process @p
- *	and collect its status information.
- *	@p contains the task_struct for process.
- *	Return 0 if permission is granted.
  * @task_prctl:
  *	Check permission before performing a process control operation on the
  *	current process.
@@ -1507,7 +1502,6 @@ union security_list_options {
 	int (*task_movememory)(struct task_struct *p);
 	int (*task_kill)(struct task_struct *p, struct siginfo *info,
 				int sig, u32 secid);
-	int (*task_wait)(struct task_struct *p);
 	int (*task_prctl)(int option, unsigned long arg2, unsigned long arg3,
 				unsigned long arg4, unsigned long arg5);
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
@@ -1768,7 +1762,6 @@ struct security_hook_heads {
 	struct list_head task_getscheduler;
 	struct list_head task_movememory;
 	struct list_head task_kill;
-	struct list_head task_wait;
 	struct list_head task_prctl;
 	struct list_head task_to_inode;
 	struct list_head ipc_permission;
diff --git a/include/linux/mfd/rtsx_usb.h b/include/linux/mfd/rtsx_usb.h
index c446e4fd6b5c..09b08ff08830 100644
--- a/include/linux/mfd/rtsx_usb.h
+++ b/include/linux/mfd/rtsx_usb.h
@@ -65,8 +65,6 @@ struct rtsx_ucr {
 	struct usb_device	*pusb_dev;
 	struct usb_interface	*pusb_intf;
 	struct usb_sg_request	current_sg;
-	unsigned char		*iobuf;
-	dma_addr_t		iobuf_dma;
 
 	struct timer_list	sg_timer;
 	struct mutex		dev_mutex;
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 722698a43d79..659f58617b9e 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -31,6 +31,7 @@
 #define SGI_MMTIMER		153
 #define STORE_QUEUE_MINOR	155	/* unused */
 #define I2O_MINOR		166
+#define HWRNG_MINOR		183
 #define MICROCODE_MINOR		184
 #define VFIO_MINOR		196
 #define TUN_MINOR		200
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 81ee5d0b2642..ebfe5b771153 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2059,6 +2059,8 @@ extern int install_special_mapping(struct mm_struct *mm,
 				   unsigned long addr, unsigned long len,
 				   unsigned long flags, struct page **pages);
 
+unsigned long randomize_page(unsigned long start, unsigned long range);
+
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 
 extern unsigned long mmap_region(struct file *file, unsigned long addr,
diff --git a/include/linux/net.h b/include/linux/net.h
index 54270c4707cf..455aa9c1247c 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -274,6 +274,8 @@ do {									\
 
 #define net_get_random_once(buf, nbytes)			\
 	get_random_once((buf), (nbytes))
+#define net_get_random_once_wait(buf, nbytes)			\
+	get_random_once_wait((buf), (nbytes))
 
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
 		   size_t num, size_t len);
diff --git a/include/linux/once.h b/include/linux/once.h
index 285f12cb40e6..9c98aaa87cbc 100644
--- a/include/linux/once.h
+++ b/include/linux/once.h
@@ -53,5 +53,7 @@ void __do_once_done(bool *done, struct static_key *once_key,
 
 #define get_random_once(buf, nbytes)					     \
 	DO_ONCE(get_random_bytes, (buf), (nbytes))
+#define get_random_once_wait(buf, nbytes)                                    \
+	DO_ONCE(get_random_bytes_wait, (buf), (nbytes))                      \
 
 #endif /* _LINUX_ONCE_H */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index bba5604f3a03..8ad5e5b6f9df 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -55,6 +55,8 @@
 #define PCI_CLASS_BRIDGE_EISA		0x0602
 #define PCI_CLASS_BRIDGE_MC		0x0603
 #define PCI_CLASS_BRIDGE_PCI		0x0604
+#define PCI_CLASS_BRIDGE_PCI_NORMAL		0x060400
+#define PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE	0x060401
 #define PCI_CLASS_BRIDGE_PCMCIA		0x0605
 #define PCI_CLASS_BRIDGE_NUBUS		0x0606
 #define PCI_CLASS_BRIDGE_CARDBUS	0x0607
diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index e20339c78a84..709e8e69fb39 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/percpu.h>
+#include <linux/siphash.h>
 
 u32 prandom_u32(void);
 void prandom_bytes(void *buf, size_t nbytes);
@@ -21,15 +22,10 @@ void prandom_reseed_late(void);
  * The core SipHash round function.  Each line can be executed in
  * parallel given enough CPU resources.
  */
-#define PRND_SIPROUND(v0, v1, v2, v3) ( \
-	v0 += v1, v1 = rol64(v1, 13),  v2 += v3, v3 = rol64(v3, 16), \
-	v1 ^= v0, v0 = rol64(v0, 32),  v3 ^= v2,                     \
-	v0 += v3, v3 = rol64(v3, 21),  v2 += v1, v1 = rol64(v1, 17), \
-	v3 ^= v0,                      v1 ^= v2, v2 = rol64(v2, 32)  \
-)
+#define PRND_SIPROUND(v0, v1, v2, v3) SIPHASH_PERMUTATION(v0, v1, v2, v3)
 
-#define PRND_K0 (0x736f6d6570736575 ^ 0x6c7967656e657261)
-#define PRND_K1 (0x646f72616e646f6d ^ 0x7465646279746573)
+#define PRND_K0 (SIPHASH_CONST_0 ^ SIPHASH_CONST_2)
+#define PRND_K1 (SIPHASH_CONST_1 ^ SIPHASH_CONST_3)
 
 #elif BITS_PER_LONG == 32
 /*
@@ -37,14 +33,9 @@ void prandom_reseed_late(void);
  * This is weaker, but 32-bit machines are not used for high-traffic
  * applications, so there is less output for an attacker to analyze.
  */
-#define PRND_SIPROUND(v0, v1, v2, v3) ( \
-	v0 += v1, v1 = rol32(v1,  5),  v2 += v3, v3 = rol32(v3,  8), \
-	v1 ^= v0, v0 = rol32(v0, 16),  v3 ^= v2,                     \
-	v0 += v3, v3 = rol32(v3,  7),  v2 += v1, v1 = rol32(v1, 13), \
-	v3 ^= v0,                      v1 ^= v2, v2 = rol32(v2, 16)  \
-)
-#define PRND_K0 0x6c796765
-#define PRND_K1 0x74656462
+#define PRND_SIPROUND(v0, v1, v2, v3) HSIPHASH_PERMUTATION(v0, v1, v2, v3)
+#define PRND_K0 (HSIPHASH_CONST_0 ^ HSIPHASH_CONST_2)
+#define PRND_K1 (HSIPHASH_CONST_1 ^ HSIPHASH_CONST_3)
 
 #else
 #error Unsupported BITS_PER_LONG
diff --git a/include/linux/random.h b/include/linux/random.h
index a50fcce24354..291b493fd2e7 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -1,50 +1,78 @@
-/*
- * include/linux/random.h
- *
- * Include file for the random number generator.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
+
 #ifndef _LINUX_RANDOM_H
 #define _LINUX_RANDOM_H
 
+#include <linux/bug.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/once.h>
 
 #include <uapi/linux/random.h>
 
-struct random_ready_callback {
-	struct list_head list;
-	void (*func)(struct random_ready_callback *rdy);
-	struct module *owner;
-};
+struct notifier_block;
 
-extern void add_device_randomness(const void *, unsigned int);
+void add_device_randomness(const void *buf, size_t len);
+void __init add_bootloader_randomness(const void *buf, size_t len);
+void add_input_randomness(unsigned int type, unsigned int code,
+			  unsigned int value) __latent_entropy;
+void add_interrupt_randomness(int irq) __latent_entropy;
+void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
 
-#if defined(CONFIG_GCC_PLUGIN_LATENT_ENTROPY) && !defined(__CHECKER__)
+#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 static inline void add_latent_entropy(void)
 {
-	add_device_randomness((const void *)&latent_entropy,
-			      sizeof(latent_entropy));
+	add_device_randomness((const void *)&latent_entropy, sizeof(latent_entropy));
 }
 #else
-static inline void add_latent_entropy(void) {}
+static inline void add_latent_entropy(void) { }
 #endif
 
-extern void add_input_randomness(unsigned int type, unsigned int code,
-				 unsigned int value) __latent_entropy;
-extern void add_interrupt_randomness(int irq, int irq_flags, __u64 ip) __latent_entropy;
+void get_random_bytes(void *buf, size_t len);
+size_t __must_check get_random_bytes_arch(void *buf, size_t len);
+u32 get_random_u32(void);
+u64 get_random_u64(void);
+static inline unsigned int get_random_int(void)
+{
+	return get_random_u32();
+}
+static inline unsigned long get_random_long(void)
+{
+#if BITS_PER_LONG == 64
+	return get_random_u64();
+#else
+	return get_random_u32();
+#endif
+}
 
-extern void get_random_bytes(void *buf, int nbytes);
-extern int add_random_ready_callback(struct random_ready_callback *rdy);
-extern void del_random_ready_callback(struct random_ready_callback *rdy);
-extern void get_random_bytes_arch(void *buf, int nbytes);
+int __init random_init(const char *command_line);
+bool rng_is_initialized(void);
+int wait_for_random_bytes(void);
+int register_random_ready_notifier(struct notifier_block *nb);
+int unregister_random_ready_notifier(struct notifier_block *nb);
 
-#ifndef MODULE
-extern const struct file_operations random_fops, urandom_fops;
-#endif
+/* Calls wait_for_random_bytes() and then calls get_random_bytes(buf, nbytes).
+ * Returns the result of the call to wait_for_random_bytes. */
+static inline int get_random_bytes_wait(void *buf, size_t nbytes)
+{
+	int ret = wait_for_random_bytes();
+	get_random_bytes(buf, nbytes);
+	return ret;
+}
 
-unsigned int get_random_int(void);
-unsigned long get_random_long(void);
-unsigned long randomize_page(unsigned long start, unsigned long range);
+#define declare_get_random_var_wait(name, ret_type) \
+	static inline int get_random_ ## name ## _wait(ret_type *out) { \
+		int ret = wait_for_random_bytes(); \
+		if (unlikely(ret)) \
+			return ret; \
+		*out = get_random_ ## name(); \
+		return 0; \
+	}
+declare_get_random_var_wait(u32, u32)
+declare_get_random_var_wait(u64, u32)
+declare_get_random_var_wait(int, unsigned int)
+declare_get_random_var_wait(long, unsigned long)
+#undef declare_get_random_var
 
 /*
  * This is designed to be standalone for just prandom
@@ -56,30 +84,39 @@ unsigned long randomize_page(unsigned long start, unsigned long range);
 #ifdef CONFIG_ARCH_RANDOM
 # include <asm/archrandom.h>
 #else
-static inline bool arch_get_random_long(unsigned long *v)
-{
-	return 0;
-}
-static inline bool arch_get_random_int(unsigned int *v)
-{
-	return 0;
-}
-static inline bool arch_has_random(void)
-{
-	return 0;
-}
-static inline bool arch_get_random_seed_long(unsigned long *v)
-{
-	return 0;
-}
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_long(unsigned long *v) { return false; }
+static inline bool __must_check arch_get_random_int(unsigned int *v) { return false; }
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v) { return false; }
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v) { return false; }
+#endif
+
+/*
+ * Called from the boot CPU during startup; not valid to call once
+ * secondary CPUs are up and preemption is possible.
+ */
+#ifndef arch_get_random_seed_long_early
+static inline bool __init arch_get_random_seed_long_early(unsigned long *v)
 {
-	return 0;
+	WARN_ON(system_state != SYSTEM_BOOTING);
+	return arch_get_random_seed_long(v);
 }
-static inline bool arch_has_random_seed(void)
+#endif
+
+#ifndef arch_get_random_long_early
+static inline bool __init arch_get_random_long_early(unsigned long *v)
 {
-	return 0;
+	WARN_ON(system_state != SYSTEM_BOOTING);
+	return arch_get_random_long(v);
 }
 #endif
 
+#ifdef CONFIG_SMP
+int random_prepare_cpu(unsigned int cpu);
+int random_online_cpu(unsigned int cpu);
+#endif
+
+#ifndef MODULE
+extern const struct file_operations random_fops, urandom_fops;
+#endif
+
 #endif /* _LINUX_RANDOM_H */
diff --git a/include/linux/ratelimit.h b/include/linux/ratelimit.h
index 57c9e0622a38..7ce241cb51a1 100644
--- a/include/linux/ratelimit.h
+++ b/include/linux/ratelimit.h
@@ -22,12 +22,16 @@ struct ratelimit_state {
 	unsigned long	flags;
 };
 
-#define RATELIMIT_STATE_INIT(name, interval_init, burst_init) {		\
-		.lock		= __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
-		.interval	= interval_init,			\
-		.burst		= burst_init,				\
+#define RATELIMIT_STATE_INIT_FLAGS(name, interval_init, burst_init, flags_init) { \
+		.lock		= __RAW_SPIN_LOCK_UNLOCKED(name.lock),		  \
+		.interval	= interval_init,				  \
+		.burst		= burst_init,					  \
+		.flags		= flags_init,					  \
 	}
 
+#define RATELIMIT_STATE_INIT(name, interval_init, burst_init) \
+	RATELIMIT_STATE_INIT_FLAGS(name, interval_init, burst_init, 0)
+
 #define RATELIMIT_STATE_INIT_DISABLED					\
 	RATELIMIT_STATE_INIT(ratelimit_state, 0, DEFAULT_RATELIMIT_BURST)
 
diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
new file mode 100644
index 000000000000..12a9d1ad01cc
--- /dev/null
+++ b/include/linux/rcuwait.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RCUWAIT_H_
+#define _LINUX_RCUWAIT_H_
+
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+
+/*
+ * rcuwait provides a way of blocking and waking up a single
+ * task in an rcu-safe manner.
+ *
+ * The only time @task is non-nil is when a user is blocked (or
+ * checking if it needs to) on a condition, and reset as soon as we
+ * know that the condition has succeeded and are awoken.
+ */
+struct rcuwait {
+	struct task_struct __rcu *task;
+};
+
+#define __RCUWAIT_INITIALIZER(name)		\
+	{ .task = NULL, }
+
+static inline void rcuwait_init(struct rcuwait *w)
+{
+	w->task = NULL;
+}
+
+/*
+ * Note: this provides no serialization and, just as with waitqueues,
+ * requires care to estimate as to whether or not the wait is active.
+ */
+static inline int rcuwait_active(struct rcuwait *w)
+{
+	return !!rcu_access_pointer(w->task);
+}
+
+extern int rcuwait_wake_up(struct rcuwait *w);
+
+/*
+ * The caller is responsible for locking around rcuwait_wait_event(),
+ * and [prepare_to/finish]_rcuwait() such that writes to @task are
+ * properly serialized.
+ */
+
+static inline void prepare_to_rcuwait(struct rcuwait *w)
+{
+	rcu_assign_pointer(w->task, current);
+}
+
+extern void finish_rcuwait(struct rcuwait *w);
+
+#define rcuwait_wait_event(w, condition, state)				\
+({									\
+	int __ret = 0;							\
+	prepare_to_rcuwait(w);						\
+	for (;;) {							\
+		/*							\
+		 * Implicit barrier (A) pairs with (B) in		\
+		 * rcuwait_wake_up().					\
+		 */							\
+		set_current_state(state);				\
+		if (condition)						\
+			break;						\
+									\
+		if (signal_pending_state(state, current)) {		\
+			__ret = -EINTR;					\
+			break;						\
+		}							\
+									\
+		schedule();						\
+	}								\
+	finish_rcuwait(w);						\
+	__ret;								\
+})
+
+#endif /* _LINUX_RCUWAIT_H_ */
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b46bb5620a76..9dc3617a5bfc 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -37,12 +37,15 @@ struct anon_vma {
 	atomic_t refcount;
 
 	/*
-	 * Count of child anon_vmas and VMAs which points to this anon_vma.
+	 * Count of child anon_vmas. Equals to the count of all anon_vmas that
+	 * have ->parent pointing to this one, including itself.
 	 *
 	 * This counter is used for making decision about reusing anon_vma
 	 * instead of forking new one. See comments in function anon_vma_clone.
 	 */
-	unsigned degree;
+	unsigned long num_children;
+	/* Count of VMAs whose ->anon_vma pointer points to this object. */
+	unsigned long num_active_vmas;
 
 	struct anon_vma *parent;	/* Parent of this anon_vma */
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 2f5d282bd3ec..472822a1e02b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -332,7 +332,6 @@ int security_task_getscheduler(struct task_struct *p);
 int security_task_movememory(struct task_struct *p);
 int security_task_kill(struct task_struct *p, struct siginfo *info,
 			int sig, u32 secid);
-int security_task_wait(struct task_struct *p);
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
@@ -980,11 +979,6 @@ static inline int security_task_kill(struct task_struct *p,
 	return 0;
 }
 
-static inline int security_task_wait(struct task_struct *p)
-{
-	return 0;
-}
-
 static inline int security_task_prctl(int option, unsigned long arg2,
 				      unsigned long arg3,
 				      unsigned long arg4,
diff --git a/include/linux/siphash.h b/include/linux/siphash.h
index 0cda61855d90..0bb5ecd507be 100644
--- a/include/linux/siphash.h
+++ b/include/linux/siphash.h
@@ -136,4 +136,32 @@ static inline u32 hsiphash(const void *data, size_t len,
 	return ___hsiphash_aligned(data, len, key);
 }
 
+/*
+ * These macros expose the raw SipHash and HalfSipHash permutations.
+ * Do not use them directly! If you think you have a use for them,
+ * be sure to CC the maintainer of this file explaining why.
+ */
+
+#define SIPHASH_PERMUTATION(a, b, c, d) ( \
+	(a) += (b), (b) = rol64((b), 13), (b) ^= (a), (a) = rol64((a), 32), \
+	(c) += (d), (d) = rol64((d), 16), (d) ^= (c), \
+	(a) += (d), (d) = rol64((d), 21), (d) ^= (a), \
+	(c) += (b), (b) = rol64((b), 17), (b) ^= (c), (c) = rol64((c), 32))
+
+#define SIPHASH_CONST_0 0x736f6d6570736575ULL
+#define SIPHASH_CONST_1 0x646f72616e646f6dULL
+#define SIPHASH_CONST_2 0x6c7967656e657261ULL
+#define SIPHASH_CONST_3 0x7465646279746573ULL
+
+#define HSIPHASH_PERMUTATION(a, b, c, d) ( \
+	(a) += (b), (b) = rol32((b), 5), (b) ^= (a), (a) = rol32((a), 16), \
+	(c) += (d), (d) = rol32((d), 8), (d) ^= (c), \
+	(a) += (d), (d) = rol32((d), 7), (d) ^= (a), \
+	(c) += (b), (b) = rol32((b), 13), (b) ^= (c), (c) = rol32((c), 16))
+
+#define HSIPHASH_CONST_0 0U
+#define HSIPHASH_CONST_1 0U
+#define HSIPHASH_CONST_2 0x6c796765U
+#define HSIPHASH_CONST_3 0x74656462U
+
 #endif /* _LINUX_SIPHASH_H */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a8bfaa061f3e..efc329fb8541 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -976,6 +976,7 @@ static inline struct sk_buff *alloc_skb_head(gfp_t priority)
 struct sk_buff *skb_morph(struct sk_buff *dst, struct sk_buff *src);
 int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask);
 struct sk_buff *skb_clone(struct sk_buff *skb, gfp_t priority);
+void skb_copy_header(struct sk_buff *new, const struct sk_buff *old);
 struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t priority);
 struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
 				   gfp_t gfp_mask, bool fclone);
diff --git a/include/linux/swab.h b/include/linux/swab.h
index 9ad3c60f6cae..f66e6f8bf049 100644
--- a/include/linux/swab.h
+++ b/include/linux/swab.h
@@ -6,6 +6,7 @@
 # define swab16 __swab16
 # define swab32 __swab32
 # define swab64 __swab64
+# define swab __swab
 # define swahw32 __swahw32
 # define swahb32 __swahb32
 # define swab16p __swab16p
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 39c25dbebfe8..c7616cfb48d2 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -62,6 +62,8 @@
 #include <linux/types.h>
 #include <linux/param.h>
 
+unsigned long random_get_entropy_fallback(void);
+
 #include <asm/timex.h>
 
 #ifndef random_get_entropy
@@ -74,8 +76,14 @@
  *
  * By default we use get_cycles() for this purpose, but individual
  * architectures may override this in their asm/timex.h header file.
+ * If a given arch does not have get_cycles(), then we fallback to
+ * using random_get_entropy_fallback().
  */
-#define random_get_entropy()	get_cycles()
+#ifdef get_cycles
+#define random_get_entropy()	((unsigned long)get_cycles())
+#else
+#define random_get_entropy()	random_get_entropy_fallback()
+#endif
 #endif
 
 /*
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index d43837f2ce3a..67ccce8be5fb 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -11,7 +11,6 @@ extern int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 extern int tty_prepare_flip_string(struct tty_port *port,
 		unsigned char **chars, size_t size);
 extern void tty_flip_buffer_push(struct tty_port *port);
-void tty_schedule_flip(struct tty_port *port);
 int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag);
 
 static inline int tty_insert_flip_char(struct tty_port *port,
@@ -39,4 +38,7 @@ static inline int tty_insert_flip_string(struct tty_port *port,
 extern void tty_buffer_lock_exclusive(struct tty_port *port);
 extern void tty_buffer_unlock_exclusive(struct tty_port *port);
 
+int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
+		const unsigned char *chars, size_t cnt);
+
 #endif /* _LINUX_TTY_FLIP_H */
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 492034126876..684fef8e3e59 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -65,6 +65,7 @@
 
 struct giveback_urb_bh {
 	bool running;
+	bool high_prio;
 	spinlock_t lock;
 	struct list_head  head;
 	struct tasklet_struct bh;
diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index 2d095fc60204..c77fb14868b7 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -23,6 +23,7 @@
  * not including trailing NUL.
  */
 #define	UUID_STRING_LEN		36
+#define	UUID_SIZE		16
 
 static inline int uuid_le_cmp(const uuid_le u1, const uuid_le u2)
 {
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 8e880f7f67b2..b95c511139b9 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -359,6 +359,8 @@ extern struct workqueue_struct *system_freezable_wq;
 extern struct workqueue_struct *system_power_efficient_wq;
 extern struct workqueue_struct *system_freezable_power_efficient_wq;
 
+extern bool wq_online;
+
 extern struct workqueue_struct *
 __alloc_workqueue_key(const char *fmt, unsigned int flags, int max_active,
 	struct lock_class_key *key, const char *lock_name, ...) __printf(1, 6);
@@ -598,7 +600,7 @@ static inline bool schedule_delayed_work(struct delayed_work *dwork,
  */
 static inline bool keventd_up(void)
 {
-	return system_wq != NULL;
+	return wq_online;
 }
 
 #ifndef CONFIG_SMP
@@ -635,4 +637,7 @@ int workqueue_online_cpu(unsigned int cpu);
 int workqueue_offline_cpu(unsigned int cpu);
 #endif
 
+int __init workqueue_init_early(void);
+int __init workqueue_init(void);
+
 #endif
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9c50d458ee83..d9e9f86e6107 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -798,6 +798,7 @@ enum {
 };
 
 void l2cap_chan_hold(struct l2cap_chan *c);
+struct l2cap_chan *l2cap_chan_hold_unless_zero(struct l2cap_chan *c);
 void l2cap_chan_put(struct l2cap_chan *c);
 
 static inline void l2cap_chan_lock(struct l2cap_chan *chan)
diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 2fbeb1313c0f..e522187cb693 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -39,7 +39,7 @@ extern unsigned int sysctl_net_busy_poll __read_mostly;
 
 static inline bool net_busy_loop_on(void)
 {
-	return sysctl_net_busy_poll;
+	return READ_ONCE(sysctl_net_busy_poll);
 }
 
 static inline u64 busy_loop_us_clock(void)
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index fc445e7ccadf..c3cf2021bb3b 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -382,7 +382,7 @@ static inline void sk_rcv_saddr_set(struct sock *sk, __be32 addr)
 }
 
 int __inet_hash_connect(struct inet_timewait_death_row *death_row,
-			struct sock *sk, u32 port_offset,
+			struct sock *sk, u64 port_offset,
 			int (*check_established)(struct inet_timewait_death_row *,
 						 struct sock *, __u16,
 						 struct inet_timewait_sock **));
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 6213a90a8cec..f5dbee53fb85 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -113,7 +113,8 @@ static inline struct inet_request_sock *inet_rsk(const struct request_sock *sk)
 
 static inline u32 inet_request_mark(const struct sock *sk, struct sk_buff *skb)
 {
-	if (!sk->sk_mark && sock_net(sk)->ipv4.sysctl_tcp_fwmark_accept)
+	if (!sk->sk_mark &&
+	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_fwmark_accept))
 		return skb->mark;
 
 	return sk->sk_mark;
diff --git a/include/net/ip.h b/include/net/ip.h
index c762fd047ef4..f0e13a256582 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -283,7 +283,7 @@ void ipfrag_init(void);
 void ip_static_sysctl_init(void);
 
 #define IP4_REPLY_MARK(net, mark) \
-	((net)->ipv4.sysctl_fwmark_reflect ? (mark) : 0)
+	(READ_ONCE((net)->ipv4.sysctl_fwmark_reflect) ? (mark) : 0)
 
 static inline bool ip_is_fragment(const struct iphdr *iph)
 {
diff --git a/include/net/secure_seq.h b/include/net/secure_seq.h
index 3f36d45b714a..542a80c05107 100644
--- a/include/net/secure_seq.h
+++ b/include/net/secure_seq.h
@@ -3,8 +3,8 @@
 
 #include <linux/types.h>
 
-u32 secure_ipv4_port_ephemeral(__be32 saddr, __be32 daddr, __be16 dport);
-u32 secure_ipv6_port_ephemeral(const __be32 *saddr, const __be32 *daddr,
+u64 secure_ipv4_port_ephemeral(__be32 saddr, __be32 daddr, __be16 dport);
+u64 secure_ipv6_port_ephemeral(const __be32 *saddr, const __be32 *daddr,
 			       __be16 dport);
 __u32 secure_tcp_sequence_number(__be32 saddr, __be32 daddr,
 				 __be16 sport, __be16 dport);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 97df2f6fcbd7..164dc4f04d0f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1788,7 +1788,7 @@ void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
 static inline u32 tcp_notsent_lowat(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
-	return tp->notsent_lowat ?: net->ipv4.sysctl_tcp_notsent_lowat;
+	return tp->notsent_lowat ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
 }
 
 static inline bool tcp_stream_memory_free(const struct sock *sk)
diff --git a/include/sound/core.h b/include/sound/core.h
index 31079ea5e484..d5d0e5e53920 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -457,4 +457,12 @@ snd_pci_quirk_lookup_id(u16 vendor, u16 device,
 }
 #endif
 
+/* async signal helpers */
+struct snd_fasync;
+
+int snd_fasync_helper(int fd, struct file *file, int on,
+		      struct snd_fasync **fasyncp);
+void snd_kill_fasync(struct snd_fasync *fasync, int signal, int poll);
+void snd_fasync_free(struct snd_fasync *fasync);
+
 #endif /* __SOUND_CORE_H */
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index 2fbbf990e4b3..330f40c9ffa8 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -248,6 +248,7 @@ DECLARE_EVENT_CLASS(ata_qc_complete_template,
 		__entry->hob_feature	= qc->result_tf.hob_feature;
 		__entry->nsect		= qc->result_tf.nsect;
 		__entry->hob_nsect	= qc->result_tf.hob_nsect;
+		__entry->flags		= qc->flags;
 	),
 
 	TP_printk("ata_port=%u ata_dev=%u tag=%d flags=%s status=%s " \
diff --git a/include/trace/events/random.h b/include/trace/events/random.h
deleted file mode 100644
index 4684de344c5d..000000000000
--- a/include/trace/events/random.h
+++ /dev/null
@@ -1,315 +0,0 @@
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM random
-
-#if !defined(_TRACE_RANDOM_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_RANDOM_H
-
-#include <linux/writeback.h>
-#include <linux/tracepoint.h>
-
-TRACE_EVENT(add_device_randomness,
-	TP_PROTO(int bytes, unsigned long IP),
-
-	TP_ARGS(bytes, IP),
-
-	TP_STRUCT__entry(
-		__field(	  int,	bytes			)
-		__field(unsigned long,	IP			)
-	),
-
-	TP_fast_assign(
-		__entry->bytes		= bytes;
-		__entry->IP		= IP;
-	),
-
-	TP_printk("bytes %d caller %pS",
-		__entry->bytes, (void *)__entry->IP)
-);
-
-DECLARE_EVENT_CLASS(random__mix_pool_bytes,
-	TP_PROTO(const char *pool_name, int bytes, unsigned long IP),
-
-	TP_ARGS(pool_name, bytes, IP),
-
-	TP_STRUCT__entry(
-		__field( const char *,	pool_name		)
-		__field(	  int,	bytes			)
-		__field(unsigned long,	IP			)
-	),
-
-	TP_fast_assign(
-		__entry->pool_name	= pool_name;
-		__entry->bytes		= bytes;
-		__entry->IP		= IP;
-	),
-
-	TP_printk("%s pool: bytes %d caller %pS",
-		  __entry->pool_name, __entry->bytes, (void *)__entry->IP)
-);
-
-DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes,
-	TP_PROTO(const char *pool_name, int bytes, unsigned long IP),
-
-	TP_ARGS(pool_name, bytes, IP)
-);
-
-DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
-	TP_PROTO(const char *pool_name, int bytes, unsigned long IP),
-
-	TP_ARGS(pool_name, bytes, IP)
-);
-
-TRACE_EVENT(credit_entropy_bits,
-	TP_PROTO(const char *pool_name, int bits, int entropy_count,
-		 int entropy_total, unsigned long IP),
-
-	TP_ARGS(pool_name, bits, entropy_count, entropy_total, IP),
-
-	TP_STRUCT__entry(
-		__field( const char *,	pool_name		)
-		__field(	  int,	bits			)
-		__field(	  int,	entropy_count		)
-		__field(	  int,	entropy_total		)
-		__field(unsigned long,	IP			)
-	),
-
-	TP_fast_assign(
-		__entry->pool_name	= pool_name;
-		__entry->bits		= bits;
-		__entry->entropy_count	= entropy_count;
-		__entry->entropy_total	= entropy_total;
-		__entry->IP		= IP;
-	),
-
-	TP_printk("%s pool: bits %d entropy_count %d entropy_total %d "
-		  "caller %pS", __entry->pool_name, __entry->bits,
-		  __entry->entropy_count, __entry->entropy_total,
-		  (void *)__entry->IP)
-);
-
-TRACE_EVENT(push_to_pool,
-	TP_PROTO(const char *pool_name, int pool_bits, int input_bits),
-
-	TP_ARGS(pool_name, pool_bits, input_bits),
-
-	TP_STRUCT__entry(
-		__field( const char *,	pool_name		)
-		__field(	  int,	pool_bits		)
-		__field(	  int,	input_bits		)
-	),
-
-	TP_fast_assign(
-		__entry->pool_name	= pool_name;
-		__entry->pool_bits	= pool_bits;
-		__entry->input_bits	= input_bits;
-	),
-
-	TP_printk("%s: pool_bits %d input_pool_bits %d",
-		  __entry->pool_name, __entry->pool_bits,
-		  __entry->input_bits)
-);
-
-TRACE_EVENT(debit_entropy,
-	TP_PROTO(const char *pool_name, int debit_bits),
-
-	TP_ARGS(pool_name, debit_bits),
-
-	TP_STRUCT__entry(
-		__field( const char *,	pool_name		)
-		__field(	  int,	debit_bits		)
-	),
-
-	TP_fast_assign(
-		__entry->pool_name	= pool_name;
-		__entry->debit_bits	= debit_bits;
-	),
-
-	TP_printk("%s: debit_bits %d", __entry->pool_name,
-		  __entry->debit_bits)
-);
-
-TRACE_EVENT(add_input_randomness,
-	TP_PROTO(int input_bits),
-
-	TP_ARGS(input_bits),
-
-	TP_STRUCT__entry(
-		__field(	  int,	input_bits		)
-	),
-
-	TP_fast_assign(
-		__entry->input_bits	= input_bits;
-	),
-
-	TP_printk("input_pool_bits %d", __entry->input_bits)
-);
-
-TRACE_EVENT(add_disk_randomness,
-	TP_PROTO(dev_t dev, int input_bits),
-
-	TP_ARGS(dev, input_bits),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,	dev			)
-		__field(	  int,	input_bits		)
-	),
-
-	TP_fast_assign(
-		__entry->dev		= dev;
-		__entry->input_bits	= input_bits;
-	),
-
-	TP_printk("dev %d,%d input_pool_bits %d", MAJOR(__entry->dev),
-		  MINOR(__entry->dev), __entry->input_bits)
-);
-
-TRACE_EVENT(xfer_secondary_pool,
-	TP_PROTO(const char *pool_name, int xfer_bits, int request_bits,
-		 int pool_entropy, int input_entropy),
-
-	TP_ARGS(pool_name, xfer_bits, request_bits, pool_entropy,
-		input_entropy),
-
-	TP_STRUCT__entry(
-		__field( const char *,	pool_name		)
-		__field(	  int,	xfer_bits		)
-		__field(	  int,	request_bits		)
-		__field(	  int,	pool_entropy		)
-		__field(	  int,	input_entropy		)
-	),
-
-	TP_fast_assign(
-		__entry->pool_name	= pool_name;
-		__entry->xfer_bits	= xfer_bits;
-		__entry->request_bits	= request_bits;
-		__entry->pool_entropy	= pool_entropy;
-		__entry->input_entropy	= input_entropy;
-	),
-
-	TP_printk("pool %s xfer_bits %d request_bits %d pool_entropy %d "
-		  "input_entropy %d", __entry->pool_name, __entry->xfer_bits,
-		  __entry->request_bits, __entry->pool_entropy,
-		  __entry->input_entropy)
-);
-
-DECLARE_EVENT_CLASS(random__get_random_bytes,
-	TP_PROTO(int nbytes, unsigned long IP),
-
-	TP_ARGS(nbytes, IP),
-
-	TP_STRUCT__entry(
-		__field(	  int,	nbytes			)
-		__field(unsigned long,	IP			)
-	),
-
-	TP_fast_assign(
-		__entry->nbytes		= nbytes;
-		__entry->IP		= IP;
-	),
-
-	TP_printk("nbytes %d caller %pS", __entry->nbytes, (void *)__entry->IP)
-);
-
-DEFINE_EVENT(random__get_random_bytes, get_random_bytes,
-	TP_PROTO(int nbytes, unsigned long IP),
-
-	TP_ARGS(nbytes, IP)
-);
-
-DEFINE_EVENT(random__get_random_bytes, get_random_bytes_arch,
-	TP_PROTO(int nbytes, unsigned long IP),
-
-	TP_ARGS(nbytes, IP)
-);
-
-DECLARE_EVENT_CLASS(random__extract_entropy,
-	TP_PROTO(const char *pool_name, int nbytes, int entropy_count,
-		 unsigned long IP),
-
-	TP_ARGS(pool_name, nbytes, entropy_count, IP),
-
-	TP_STRUCT__entry(
-		__field( const char *,	pool_name		)
-		__field(	  int,	nbytes			)
-		__field(	  int,	entropy_count		)
-		__field(unsigned long,	IP			)
-	),
-
-	TP_fast_assign(
-		__entry->pool_name	= pool_name;
-		__entry->nbytes		= nbytes;
-		__entry->entropy_count	= entropy_count;
-		__entry->IP		= IP;
-	),
-
-	TP_printk("%s pool: nbytes %d entropy_count %d caller %pS",
-		  __entry->pool_name, __entry->nbytes, __entry->entropy_count,
-		  (void *)__entry->IP)
-);
-
-
-DEFINE_EVENT(random__extract_entropy, extract_entropy,
-	TP_PROTO(const char *pool_name, int nbytes, int entropy_count,
-		 unsigned long IP),
-
-	TP_ARGS(pool_name, nbytes, entropy_count, IP)
-);
-
-DEFINE_EVENT(random__extract_entropy, extract_entropy_user,
-	TP_PROTO(const char *pool_name, int nbytes, int entropy_count,
-		 unsigned long IP),
-
-	TP_ARGS(pool_name, nbytes, entropy_count, IP)
-);
-
-TRACE_EVENT(random_read,
-	TP_PROTO(int got_bits, int need_bits, int pool_left, int input_left),
-
-	TP_ARGS(got_bits, need_bits, pool_left, input_left),
-
-	TP_STRUCT__entry(
-		__field(	  int,	got_bits		)
-		__field(	  int,	need_bits		)
-		__field(	  int,	pool_left		)
-		__field(	  int,	input_left		)
-	),
-
-	TP_fast_assign(
-		__entry->got_bits	= got_bits;
-		__entry->need_bits	= need_bits;
-		__entry->pool_left	= pool_left;
-		__entry->input_left	= input_left;
-	),
-
-	TP_printk("got_bits %d still_needed_bits %d "
-		  "blocking_pool_entropy_left %d input_entropy_left %d",
-		  __entry->got_bits, __entry->got_bits, __entry->pool_left,
-		  __entry->input_left)
-);
-
-TRACE_EVENT(urandom_read,
-	TP_PROTO(int got_bits, int pool_left, int input_left),
-
-	TP_ARGS(got_bits, pool_left, input_left),
-
-	TP_STRUCT__entry(
-		__field(	  int,	got_bits		)
-		__field(	  int,	pool_left		)
-		__field(	  int,	input_left		)
-	),
-
-	TP_fast_assign(
-		__entry->got_bits	= got_bits;
-		__entry->pool_left	= pool_left;
-		__entry->input_left	= input_left;
-	),
-
-	TP_printk("got_bits %d nonblocking_pool_entropy_left %d "
-		  "input_entropy_left %d", __entry->got_bits,
-		  __entry->pool_left, __entry->input_left)
-);
-
-#endif /* _TRACE_RANDOM_H */
-
-/* This part must be outside protection */
-#include <trace/define_trace.h>
diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index 779abb91df81..4b322fb23972 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -37,7 +37,7 @@ TRACE_EVENT(sock_exceed_buf_limit,
 
 	TP_STRUCT__entry(
 		__array(char, name, 32)
-		__field(long *, sysctl_mem)
+		__array(long, sysctl_mem, 3)
 		__field(long, allocated)
 		__field(int, sysctl_rmem)
 		__field(int, rmem_alloc)
@@ -45,7 +45,9 @@ TRACE_EVENT(sock_exceed_buf_limit,
 
 	TP_fast_assign(
 		strncpy(__entry->name, prot->name, 32);
-		__entry->sysctl_mem = prot->sysctl_mem;
+		__entry->sysctl_mem[0] = READ_ONCE(prot->sysctl_mem[0]);
+		__entry->sysctl_mem[1] = READ_ONCE(prot->sysctl_mem[1]);
+		__entry->sysctl_mem[2] = READ_ONCE(prot->sysctl_mem[2]);
 		__entry->allocated = allocated;
 		__entry->sysctl_rmem = prot->sysctl_rmem[0];
 		__entry->rmem_alloc = atomic_read(&sk->sk_rmem_alloc);
diff --git a/include/trace/events/spmi.h b/include/trace/events/spmi.h
index 62f005ef4c7e..7c24b99cf43b 100644
--- a/include/trace/events/spmi.h
+++ b/include/trace/events/spmi.h
@@ -20,15 +20,15 @@ TRACE_EVENT(spmi_write_begin,
 		__field		( u8,         sid       )
 		__field		( u16,        addr      )
 		__field		( u8,         len       )
-		__dynamic_array	( u8,   buf,  len + 1   )
+		__dynamic_array	( u8,   buf,  len       )
 	),
 
 	TP_fast_assign(
 		__entry->opcode = opcode;
 		__entry->sid    = sid;
 		__entry->addr   = addr;
-		__entry->len    = len + 1;
-		memcpy(__get_dynamic_array(buf), buf, len + 1);
+		__entry->len    = len;
+		memcpy(__get_dynamic_array(buf), buf, len);
 	),
 
 	TP_printk("opc=%d sid=%02d addr=0x%04x len=%d buf=0x[%*phD]",
@@ -91,7 +91,7 @@ TRACE_EVENT(spmi_read_end,
 		__field		( u16,        addr      )
 		__field		( int,        ret       )
 		__field		( u8,         len       )
-		__dynamic_array	( u8,   buf,  len + 1   )
+		__dynamic_array	( u8,   buf,  len       )
 	),
 
 	TP_fast_assign(
@@ -99,8 +99,8 @@ TRACE_EVENT(spmi_read_end,
 		__entry->sid    = sid;
 		__entry->addr   = addr;
 		__entry->ret    = ret;
-		__entry->len    = len + 1;
-		memcpy(__get_dynamic_array(buf), buf, len + 1);
+		__entry->len    = len;
+		memcpy(__get_dynamic_array(buf), buf, len);
 	),
 
 	TP_printk("opc=%d sid=%02d addr=0x%04x ret=%d len=%02d buf=0x[%*phD]",
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index b455b0d86f26..b01d118750ab 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -47,9 +47,11 @@ struct rand_pool_info {
  * Flags for getrandom(2)
  *
  * GRND_NONBLOCK	Don't block and return EAGAIN instead
- * GRND_RANDOM		Use the /dev/random pool instead of /dev/urandom
+ * GRND_RANDOM		No effect
+ * GRND_INSECURE	Return non-cryptographic random bytes
  */
 #define GRND_NONBLOCK	0x0001
 #define GRND_RANDOM	0x0002
+#define GRND_INSECURE	0x0004
 
 #endif /* _UAPI_LINUX_RANDOM_H */
diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 8f3a8f606fd9..51502eabdb05 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -3,6 +3,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <asm/bitsperlong.h>
 #include <asm/swab.h>
 
 /*
@@ -131,6 +132,15 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
 	__fswab64(x))
 #endif
 
+static __always_inline unsigned long __swab(const unsigned long y)
+{
+#if __BITS_PER_LONG == 64
+	return __swab64(y);
+#else /* __BITS_PER_LONG == 32 */
+	return __swab32(y);
+#endif
+}
+
 /**
  * __swahw32 - return a word-swapped 32-bit value
  * @x: value to wordswap
diff --git a/include/video/of_display_timing.h b/include/video/of_display_timing.h
index ea755b5616d8..cb3f3b2e7ccf 100644
--- a/include/video/of_display_timing.h
+++ b/include/video/of_display_timing.h
@@ -9,6 +9,8 @@
 #ifndef __LINUX_OF_DISPLAY_TIMING_H
 #define __LINUX_OF_DISPLAY_TIMING_H
 
+#include <linux/errno.h>
+
 struct device_node;
 struct display_timing;
 struct display_timings;
diff --git a/init/main.c b/init/main.c
index 89957e9e358a..f646c887e1ce 100644
--- a/init/main.c
+++ b/init/main.c
@@ -487,20 +487,15 @@ asmlinkage __visible void __init start_kernel(void)
 	smp_setup_processor_id();
 	debug_objects_early_init();
 
-	/*
-	 * Set up the the initial canary ASAP:
-	 */
-	boot_init_stack_canary();
-
 	cgroup_init_early();
 
 	local_irq_disable();
 	early_boot_irqs_disabled = true;
 
-/*
- * Interrupts are still disabled. Do necessary setups, then
- * enable them
- */
+	/*
+	 * Interrupts are still disabled. Do necessary setups, then
+	 * enable them.
+	 */
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
@@ -554,6 +549,14 @@ asmlinkage __visible void __init start_kernel(void)
 		 "Interrupts were enabled *very* early, fixing it\n"))
 		local_irq_disable();
 	idr_init_cache();
+
+	/*
+	 * Allow workqueue creation and work item queueing/cancelling
+	 * early.  Work item execution depends on kthreads and starts after
+	 * workqueue_init().
+	 */
+	workqueue_init_early();
+
 	rcu_init();
 
 	/* trace_printk() and trace points may be used after this */
@@ -571,6 +574,17 @@ asmlinkage __visible void __init start_kernel(void)
 	softirq_init();
 	timekeeping_init();
 	time_init();
+
+	/*
+	 * For best initial stack canary entropy, prepare it after:
+	 * - setup_arch() for any UEFI RNG entropy and boot cmdline access
+	 * - timekeeping_init() for ktime entropy used in random_init()
+	 * - time_init() for making random_get_entropy() work on some platforms
+	 * - random_init() to initialize the RNG from from early entropy sources
+	 */
+	random_init(command_line);
+	boot_init_stack_canary();
+
 	sched_clock_postinit();
 	printk_nmi_init();
 	perf_event_init();
@@ -1012,6 +1026,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	smp_prepare_cpus(setup_max_cpus);
 
+	workqueue_init();
+
 	do_pre_smp_initcalls();
 	lockup_detector_init();
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ce69c0276c0..5aeadf79e05e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -60,11 +60,13 @@ void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, uns
 {
 	u8 *ptr = NULL;
 
-	if (k >= SKF_NET_OFF)
+	if (k >= SKF_NET_OFF) {
 		ptr = skb_network_header(skb) + k - SKF_NET_OFF;
-	else if (k >= SKF_LL_OFF)
+	} else if (k >= SKF_LL_OFF) {
+		if (unlikely(!skb_mac_header_was_set(skb)))
+			return NULL;
 		ptr = skb_mac_header(skb) + k - SKF_LL_OFF;
-
+	}
 	if (ptr >= skb->head && ptr + size <= skb_tail_pointer(skb))
 		return ptr;
 
@@ -105,19 +107,29 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO |
 			  gfp_extra_flags;
 	struct bpf_prog *fp;
+	u32 pages, delta;
+	int ret;
 
 	BUG_ON(fp_old == NULL);
 
 	size = round_up(size, PAGE_SIZE);
-	if (size <= fp_old->pages * PAGE_SIZE)
+	pages = size / PAGE_SIZE;
+	if (pages <= fp_old->pages)
 		return fp_old;
 
+	delta = pages - fp_old->pages;
+	ret = __bpf_prog_charge(fp_old->aux->user, delta);
+	if (ret)
+		return NULL;
+
 	fp = __vmalloc(size, gfp_flags, PAGE_KERNEL);
-	if (fp != NULL) {
+	if (fp == NULL) {
+		__bpf_prog_uncharge(fp_old->aux->user, delta);
+	} else {
 		kmemcheck_annotate_bitfield(fp, meta);
 
 		memcpy(fp, fp_old, fp_old->pages * PAGE_SIZE);
-		fp->pages = size / PAGE_SIZE;
+		fp->pages = pages;
 		fp->aux->prog = fp;
 
 		/* We keep fp->aux from fp_old around in the new
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e30ad1be6841..e0d4e210b1a1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -581,19 +581,39 @@ static void free_used_maps(struct bpf_prog_aux *aux)
 	kfree(aux->used_maps);
 }
 
+int __bpf_prog_charge(struct user_struct *user, u32 pages)
+{
+	unsigned long memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	unsigned long user_bufs;
+
+	if (user) {
+		user_bufs = atomic_long_add_return(pages, &user->locked_vm);
+		if (user_bufs > memlock_limit) {
+			atomic_long_sub(pages, &user->locked_vm);
+			return -EPERM;
+		}
+	}
+
+	return 0;
+}
+
+void __bpf_prog_uncharge(struct user_struct *user, u32 pages)
+{
+	if (user)
+		atomic_long_sub(pages, &user->locked_vm);
+}
+
 static int bpf_prog_charge_memlock(struct bpf_prog *prog)
 {
 	struct user_struct *user = get_current_user();
-	unsigned long memlock_limit;
-
-	memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	int ret;
 
-	atomic_long_add(prog->pages, &user->locked_vm);
-	if (atomic_long_read(&user->locked_vm) > memlock_limit) {
-		atomic_long_sub(prog->pages, &user->locked_vm);
+	ret = __bpf_prog_charge(user, prog->pages);
+	if (ret) {
 		free_uid(user);
-		return -EPERM;
+		return ret;
 	}
+
 	prog->aux->user = user;
 	return 0;
 }
@@ -602,7 +622,7 @@ static void bpf_prog_uncharge_memlock(struct bpf_prog *prog)
 {
 	struct user_struct *user = prog->aux->user;
 
-	atomic_long_sub(prog->pages, &user->locked_vm);
+	__bpf_prog_uncharge(user, prog->pages);
 	free_uid(user);
 }
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index a1ad95b429ab..fa9f62db94c6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -26,6 +26,7 @@
 #include <linux/smpboot.h>
 #include <linux/relay.h>
 #include <linux/slab.h>
+#include <linux/random.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1728,6 +1729,11 @@ static struct cpuhp_step cpuhp_bp_states[] = {
 		.startup.single		= perf_event_init_cpu,
 		.teardown.single	= perf_event_exit_cpu,
 	},
+	[CPUHP_RANDOM_PREPARE] = {
+		.name			= "random:prepare",
+		.startup.single		= random_prepare_cpu,
+		.teardown.single	= NULL,
+	},
 	[CPUHP_WORKQUEUE_PREP] = {
 		.name			= "workqueue:prepare",
 		.startup.single		= workqueue_prepare_cpu,
@@ -1853,6 +1859,11 @@ static struct cpuhp_step cpuhp_ap_states[] = {
 		.startup.single		= workqueue_online_cpu,
 		.teardown.single	= workqueue_offline_cpu,
 	},
+	[CPUHP_AP_RANDOM_ONLINE] = {
+		.name			= "random:online",
+		.startup.single		= random_online_cpu,
+		.teardown.single	= NULL,
+	},
 	[CPUHP_AP_RCUTREE_ONLINE] = {
 		.name			= "RCU/tree:online",
 		.startup.single		= rcutree_online_cpu,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5abfbeffabb5..eb336091c49c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5292,10 +5292,10 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 		if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
 			/*
-			 * Raced against perf_mmap_close() through
-			 * perf_event_set_output(). Try again, hope for better
-			 * luck.
+			 * Raced against perf_mmap_close(); remove the
+			 * event and try again.
 			 */
+			ring_buffer_attach(event, NULL);
 			mutex_unlock(&event->mmap_mutex);
 			goto again;
 		}
@@ -9544,14 +9544,25 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	goto out;
 }
 
+static void mutex_lock_double(struct mutex *a, struct mutex *b)
+{
+	if (b < a)
+		swap(a, b);
+
+	mutex_lock(a);
+	mutex_lock_nested(b, SINGLE_DEPTH_NESTING);
+}
+
 static int
 perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 {
 	struct ring_buffer *rb = NULL;
 	int ret = -EINVAL;
 
-	if (!output_event)
+	if (!output_event) {
+		mutex_lock(&event->mmap_mutex);
 		goto set;
+	}
 
 	/* don't allow circular references */
 	if (event == output_event)
@@ -9589,8 +9600,15 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 	    event->pmu != output_event->pmu)
 		goto out;
 
+	/*
+	 * Hold both mmap_mutex to serialize against perf_mmap_close().  Since
+	 * output_event is already on rb->event_list, and the list iteration
+	 * restarts after every removal, it is guaranteed this new event is
+	 * observed *OR* if output_event is already removed, it's guaranteed we
+	 * observe !rb->mmap_count.
+	 */
+	mutex_lock_double(&event->mmap_mutex, &output_event->mmap_mutex);
 set:
-	mutex_lock(&event->mmap_mutex);
 	/* Can't redirect output if we've got an active mmap() */
 	if (atomic_read(&event->mmap_count))
 		goto unlock;
@@ -9600,6 +9618,12 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 		rb = ring_buffer_get(output_event);
 		if (!rb)
 			goto unlock;
+
+		/* did we race against perf_mmap_close() */
+		if (!atomic_read(&rb->mmap_count)) {
+			ring_buffer_put(rb);
+			goto unlock;
+		}
 	}
 
 	ring_buffer_attach(event, rb);
@@ -9607,20 +9631,13 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 	ret = 0;
 unlock:
 	mutex_unlock(&event->mmap_mutex);
+	if (output_event)
+		mutex_unlock(&output_event->mmap_mutex);
 
 out:
 	return ret;
 }
 
-static void mutex_lock_double(struct mutex *a, struct mutex *b)
-{
-	if (b < a)
-		swap(a, b);
-
-	mutex_lock(a);
-	mutex_lock_nested(b, SINGLE_DEPTH_NESTING);
-}
-
 static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 {
 	bool nmi_safe = false;
diff --git a/kernel/exit.c b/kernel/exit.c
index 89e38e5929a9..2d75344636cb 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -14,7 +14,6 @@
 #include <linux/tty.h>
 #include <linux/iocontext.h>
 #include <linux/key.h>
-#include <linux/security.h>
 #include <linux/cpu.h>
 #include <linux/acct.h>
 #include <linux/tsacct_kern.h>
@@ -54,6 +53,7 @@
 #include <linux/writeback.h>
 #include <linux/shm.h>
 #include <linux/kcov.h>
+#include <linux/rcuwait.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -286,6 +286,35 @@ struct task_struct *try_get_task_struct(struct task_struct **ptask)
 	return task;
 }
 
+int rcuwait_wake_up(struct rcuwait *w)
+{
+	int ret = 0;
+	struct task_struct *task;
+
+	rcu_read_lock();
+
+	/*
+	 * Order condition vs @task, such that everything prior to the load
+	 * of @task is visible. This is the condition as to why the user called
+	 * rcuwait_wake() in the first place. Pairs with set_current_state()
+	 * barrier (A) in rcuwait_wait_event().
+	 *
+	 *    WAIT                WAKE
+	 *    [S] tsk = current   [S] cond = true
+	 *        MB (A)              MB (B)
+	 *    [L] cond            [L] tsk
+	 */
+	smp_mb(); /* (B) */
+
+	task = rcu_dereference(w->task);
+	if (task)
+		ret = wake_up_process(task);
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rcuwait_wake_up);
+
 /*
  * Determine if a process group is "orphaned", according to the POSIX
  * definition in 2.2.2.52.  Orphaned process groups are not to be affected
@@ -1342,7 +1371,7 @@ static int wait_task_continued(struct wait_opts *wo, struct task_struct *p)
  * Returns nonzero for a final return, when we have unlocked tasklist_lock.
  * Returns zero if the search for a child should continue;
  * then ->notask_error is 0 if @p is an eligible child,
- * or another error from security_task_wait(), or still -ECHILD.
+ * or still -ECHILD.
  */
 static int wait_consider_task(struct wait_opts *wo, int ptrace,
 				struct task_struct *p)
@@ -1362,20 +1391,6 @@ static int wait_consider_task(struct wait_opts *wo, int ptrace,
 	if (!ret)
 		return ret;
 
-	ret = security_task_wait(p);
-	if (unlikely(ret < 0)) {
-		/*
-		 * If we have not yet seen any eligible child,
-		 * then let this error code replace -ECHILD.
-		 * A permission error will give the user a clue
-		 * to look for security policy problems, rather
-		 * than for mysterious wait bugs.
-		 */
-		if (wo->notask_error)
-			wo->notask_error = ret;
-		return 0;
-	}
-
 	if (unlikely(exit_state == EXIT_TRACE)) {
 		/*
 		 * ptrace == 0 means we are the natural parent. In this case
@@ -1468,7 +1483,7 @@ static int wait_consider_task(struct wait_opts *wo, int ptrace,
  * Returns nonzero for a final return, when we have unlocked tasklist_lock.
  * Returns zero if the search for a child should continue; then
  * ->notask_error is 0 if there were any eligible children,
- * or another error from security_task_wait(), or still -ECHILD.
+ * or still -ECHILD.
  */
 static int do_wait_thread(struct wait_opts *wo, struct task_struct *tsk)
 {
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index f87aa8fdcc51..374c45fbe3db 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -181,16 +181,10 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
 {
 	irqreturn_t retval;
 	unsigned int flags = 0;
-	struct pt_regs *regs = get_irq_regs();
-	u64 ip = regs ? instruction_pointer(regs) : 0;
 
 	retval = __handle_irq_event_percpu(desc, &flags);
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	desc->random_ip = ip;
-#else
-	add_interrupt_randomness(desc->irq_data.irq, flags, ip);
-#endif
+	add_interrupt_randomness(desc->irq_data.irq);
 
 	if (!noirqdebug)
 		note_interrupt(desc, retval);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f18b89016e5f..00473cf72db2 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1035,12 +1035,6 @@ static int irq_thread(void *data)
 		if (action_ret == IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-		migrate_disable();
-		add_interrupt_randomness(action->irq, 0,
-				 desc->random_ip ^ (unsigned long) action);
-		migrate_enable();
-#endif
 		wake_threads_waitq(desc);
 	}
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2edaed6803ff..eb775e699836 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -59,24 +59,6 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 }
 #endif
 
-/* Apply relocations of type RELA */
-int __weak
-arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
-				 unsigned int relsec)
-{
-	pr_err("RELA relocation unsupported.\n");
-	return -ENOEXEC;
-}
-
-/* Apply relocations of type REL */
-int __weak
-arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
-			     unsigned int relsec)
-{
-	pr_err("REL relocation unsupported.\n");
-	return -ENOEXEC;
-}
-
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index fb2357d0dbc8..63509602e932 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1616,12 +1616,14 @@ static struct kprobe *__disable_kprobe(struct kprobe *p)
 		/* Try to disarm and disable this/parent probe */
 		if (p == orig_p || aggr_kprobe_disabled(orig_p)) {
 			/*
-			 * If kprobes_all_disarmed is set, orig_p
-			 * should have already been disarmed, so
-			 * skip unneed disarming process.
+			 * Don't be lazy here.  Even if 'kprobes_all_disarmed'
+			 * is false, 'orig_p' might not have been armed yet.
+			 * Note arm_all_kprobes() __tries__ to arm all kprobes
+			 * on the best effort basis.
 			 */
-			if (!kprobes_all_disarmed)
+			if (!kprobes_all_disarmed && !kprobe_disabled(orig_p))
 				disarm_kprobe(orig_p, true);
+
 			orig_p->flags |= KPROBE_FLAG_DISABLED;
 		}
 	}
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index ee02e1e1b3e5..c4ffd7ead78e 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -49,6 +49,7 @@
 #include <linux/moduleparam.h>
 #include <linux/kthread.h>
 #include <linux/tick.h>
+#include <linux/rcuwait.h>
 
 #define CREATE_TRACE_POINTS
 
@@ -372,6 +373,13 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 }
 EXPORT_SYMBOL_GPL(__wait_rcu_gp);
 
+void finish_rcuwait(struct rcuwait *w)
+{
+	rcu_assign_pointer(w->task, NULL);
+	__set_current_state(TASK_RUNNING);
+}
+EXPORT_SYMBOL_GPL(finish_rcuwait);
+
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 void init_rcu_head(struct rcu_head *head)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index 50ac51cb6cb1..7253845b5797 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1743,12 +1743,12 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	bool autoreap = false;
 	cputime_t utime, stime;
 
-	BUG_ON(sig == -1);
+	WARN_ON_ONCE(sig == -1);
 
- 	/* do_notify_parent_cldstop should have been called instead.  */
- 	BUG_ON(task_is_stopped_or_traced(tsk));
+	/* do_notify_parent_cldstop should have been called instead.  */
+	WARN_ON_ONCE(task_is_stopped_or_traced(tsk));
 
-	BUG_ON(!tsk->ptrace &&
+	WARN_ON_ONCE(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
 	if (sig != SIGCHLD) {
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6fb2316f212c..00add1899fd1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -19,6 +19,7 @@
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
+#include <linux/timex.h>
 #include <linux/tick.h>
 #include <linux/stop_machine.h>
 #include <linux/pvclock_gtod.h>
@@ -2269,6 +2270,21 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 	return base;
 }
 
+/**
+ * random_get_entropy_fallback - Returns the raw clock source value,
+ * used by random.c for platforms with no valid random_get_entropy().
+ */
+unsigned long random_get_entropy_fallback(void)
+{
+	struct tk_read_base *tkr = &tk_core.timekeeper.tkr_mono;
+	struct clocksource *clock = READ_ONCE(tkr->clock);
+
+	if (unlikely(timekeeping_suspended || !clock))
+		return 0;
+	return clock->read(clock);
+}
+EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
+
 /**
  * do_adjtimex() - Accessor function to NTP __do_adjtimex function
  */
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index af9d338103a9..401917af2abc 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1179,9 +1179,9 @@ EXPORT_SYMBOL_GPL(add_timer_on);
 static void wait_for_running_timer(struct timer_list *timer)
 {
 	struct timer_base *base;
-	u32 tf = timer->flags;
+	u32 tf = READ_ONCE(timer->flags);
 
-	if (tf & TIMER_MIGRATING)
+	if (tf & (TIMER_MIGRATING | TIMER_IRQSAFE))
 		return;
 
 	base = get_timer_base(tf);
@@ -1312,6 +1312,13 @@ int del_timer_sync(struct timer_list *timer)
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		might_sleep();
+
 	for (;;) {
 		int ret = try_to_del_timer_sync(timer);
 		if (ret >= 0)
@@ -1381,8 +1388,7 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 		fn = timer->function;
 		data = timer->data;
 
-		if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
-		    timer->flags & TIMER_IRQSAFE) {
+		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, data);
 			base->running_timer = NULL;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 06841602025e..7ffb9f122555 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2737,6 +2737,16 @@ static int ftrace_startup(struct ftrace_ops *ops, int command)
 
 	ftrace_startup_enable(command);
 
+	/*
+	 * If ftrace is in an undefined state, we just remove ops from list
+	 * to prevent the NULL pointer, instead of totally rolling it back and
+	 * free trampoline, because those actions could cause further damage.
+	 */
+	if (unlikely(ftrace_disabled)) {
+		__unregister_ftrace_function(ops);
+		return -ENODEV;
+	}
+
 	ops->flags &= ~FTRACE_OPS_FL_ADDING;
 
 	return 0;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6fcf9ecfc1f1..5677417f449f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -48,10 +48,9 @@
 #include <linux/nodemask.h>
 #include <linux/moduleparam.h>
 #include <linux/uaccess.h>
-#include <linux/locallock.h>
-#include <linux/delay.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
+#include <linux/rcuwait.h>
 
 #include "workqueue_internal.h"
 
@@ -126,11 +125,6 @@ enum {
  *    cpu or grabbing pool->lock is enough for read access.  If
  *    POOL_DISASSOCIATED is set, it's identical to L.
  *
- *    On RT we need the extra protection via rt_lock_idle_list() for
- *    the list manipulations against read access from
- *    wq_worker_sleeping(). All other places are nicely serialized via
- *    pool->lock.
- *
  * A: pool->attach_mutex protected.
  *
  * PL: wq_pool_mutex protected.
@@ -152,7 +146,7 @@ enum {
 /* struct worker is defined in workqueue_internal.h */
 
 struct worker_pool {
-	spinlock_t		lock;		/* the pool lock */
+	raw_spinlock_t		lock;		/* the pool lock */
 	int			cpu;		/* I: the associated cpu */
 	int			node;		/* I: the associated node ID */
 	int			id;		/* I: pool ID */
@@ -299,14 +293,17 @@ module_param_named(disable_numa, wq_disable_numa, bool, 0444);
 static bool wq_power_efficient = IS_ENABLED(CONFIG_WQ_POWER_EFFICIENT_DEFAULT);
 module_param_named(power_efficient, wq_power_efficient, bool, 0444);
 
+bool wq_online;				/* can kworkers be created yet? */
+
 static bool wq_numa_enabled;		/* unbound NUMA affinity enabled */
 
 /* buf for wq_update_unbound_numa_attrs(), protected by CPU hotplug exclusion */
 static struct workqueue_attrs *wq_update_unbound_numa_attrs_buf;
 
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
-static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
-static DECLARE_WAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go away */
+static DEFINE_RAW_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
+/* wait for manager to go away */
+static struct rcuwait manager_wait = __RCUWAIT_INITIALIZER(manager_wait);
 
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
@@ -358,8 +355,6 @@ EXPORT_SYMBOL_GPL(system_power_efficient_wq);
 struct workqueue_struct *system_freezable_power_efficient_wq __read_mostly;
 EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
 
-static DEFINE_LOCAL_IRQ_LOCK(pendingb_lock);
-
 static int worker_thread(void *__worker);
 static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 
@@ -436,31 +431,6 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
 		else
 
-#ifdef CONFIG_PREEMPT_RT_BASE
-static inline void rt_lock_idle_list(struct worker_pool *pool)
-{
-	preempt_disable();
-}
-static inline void rt_unlock_idle_list(struct worker_pool *pool)
-{
-	preempt_enable();
-}
-static inline void sched_lock_idle_list(struct worker_pool *pool) { }
-static inline void sched_unlock_idle_list(struct worker_pool *pool) { }
-#else
-static inline void rt_lock_idle_list(struct worker_pool *pool) { }
-static inline void rt_unlock_idle_list(struct worker_pool *pool) { }
-static inline void sched_lock_idle_list(struct worker_pool *pool)
-{
-	spin_lock_irq(&pool->lock);
-}
-static inline void sched_unlock_idle_list(struct worker_pool *pool)
-{
-	spin_unlock_irq(&pool->lock);
-}
-#endif
-
-
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
 
 static struct debug_obj_descr work_debug_descr;
@@ -863,20 +833,14 @@ static struct worker *first_idle_worker(struct worker_pool *pool)
  * Wake up the first idle worker of @pool.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void wake_up_worker(struct worker_pool *pool)
 {
-	struct worker *worker;
-
-	rt_lock_idle_list(pool);
-
-	worker = first_idle_worker(pool);
+	struct worker *worker = first_idle_worker(pool);
 
 	if (likely(worker))
 		wake_up_process(worker->task);
-
-	rt_unlock_idle_list(pool);
 }
 
 /**
@@ -905,7 +869,7 @@ void wq_worker_running(struct task_struct *task)
  */
 void wq_worker_sleeping(struct task_struct *task)
 {
-	struct worker *worker = kthread_data(task);
+	struct worker *next, *worker = kthread_data(task);
 	struct worker_pool *pool;
 
 	/*
@@ -922,18 +886,26 @@ void wq_worker_sleeping(struct task_struct *task)
 		return;
 
 	worker->sleeping = 1;
+	raw_spin_lock_irq(&pool->lock);
 
 	/*
 	 * The counterpart of the following dec_and_test, implied mb,
 	 * worklist not empty test sequence is in insert_work().
 	 * Please read comment there.
+	 *
+	 * NOT_RUNNING is clear.  This means that we're bound to and
+	 * running on the local cpu w/ rq lock held and preemption
+	 * disabled, which in turn means that none else could be
+	 * manipulating idle_list, so dereferencing idle_list without pool
+	 * lock is safe.
 	 */
 	if (atomic_dec_and_test(&pool->nr_running) &&
 	    !list_empty(&pool->worklist)) {
-		sched_lock_idle_list(pool);
-		wake_up_worker(pool);
-		sched_unlock_idle_list(pool);
+		next = first_idle_worker(pool);
+		if (next)
+			wake_up_process(next->task);
 	}
+	raw_spin_unlock_irq(&pool->lock);
 }
 
 /**
@@ -944,7 +916,7 @@ void wq_worker_sleeping(struct task_struct *task)
  * Set @flags in @worker->flags and adjust nr_running accordingly.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock)
+ * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_set_flags(struct worker *worker, unsigned int flags)
 {
@@ -969,7 +941,7 @@ static inline void worker_set_flags(struct worker *worker, unsigned int flags)
  * Clear @flags in @worker->flags and adjust nr_running accordingly.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock)
+ * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
 {
@@ -1017,7 +989,7 @@ static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
  * actually occurs, it should be easy to locate the culprit work function.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  *
  * Return:
  * Pointer to worker which is executing @work if found, %NULL
@@ -1052,7 +1024,7 @@ static struct worker *find_worker_executing_work(struct worker_pool *pool,
  * nested inside outer list_for_each_entry_safe().
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void move_linked_works(struct work_struct *work, struct list_head *head,
 			      struct work_struct **nextp)
@@ -1130,11 +1102,9 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 		 * As both pwqs and pools are RCU protected, the
 		 * following lock operations are safe.
 		 */
-		rcu_read_lock();
-		local_spin_lock_irq(pendingb_lock, &pwq->pool->lock);
+		raw_spin_lock_irq(&pwq->pool->lock);
 		put_pwq(pwq);
-		local_spin_unlock_irq(pendingb_lock, &pwq->pool->lock);
-		rcu_read_unlock();
+		raw_spin_unlock_irq(&pwq->pool->lock);
 	}
 }
 
@@ -1167,7 +1137,7 @@ static void pwq_activate_first_delayed(struct pool_workqueue *pwq)
  * decrement nr_in_flight of its pwq and handle workqueue flushing.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
 {
@@ -1238,7 +1208,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 	struct worker_pool *pool;
 	struct pool_workqueue *pwq;
 
-	local_lock_irqsave(pendingb_lock, *flags);
+	local_irq_save(*flags);
 
 	/* try to steal the timer if it exists */
 	if (is_dwork) {
@@ -1266,7 +1236,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 	if (!pool)
 		goto fail;
 
-	spin_lock(&pool->lock);
+	raw_spin_lock(&pool->lock);
 	/*
 	 * work->data is guaranteed to point to pwq only while the work
 	 * item is queued on pwq->wq, and both updating work->data to point
@@ -1295,17 +1265,17 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		/* work->data points to pwq iff queued, point to pool */
 		set_work_pool_and_keep_pending(work, pool->id);
 
-		spin_unlock(&pool->lock);
+		raw_spin_unlock(&pool->lock);
 		rcu_read_unlock();
 		return 1;
 	}
-	spin_unlock(&pool->lock);
+	raw_spin_unlock(&pool->lock);
 fail:
 	rcu_read_unlock();
-	local_unlock_irqrestore(pendingb_lock, *flags);
+	local_irq_restore(*flags);
 	if (work_is_canceling(work))
 		return -ENOENT;
-	cpu_chill();
+	cpu_relax();
 	return -EAGAIN;
 }
 
@@ -1320,7 +1290,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
  * work_struct flags.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
 			struct list_head *head, unsigned int extra_flags)
@@ -1407,7 +1377,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 * queued or lose PENDING.  Grabbing PENDING and queueing should
 	 * happen with IRQ disabled.
 	 */
-	WARN_ON_ONCE_NONRT(!irqs_disabled());
+	WARN_ON_ONCE(!irqs_disabled());
 
 
 	/* if draining, only works from the same workqueue are allowed */
@@ -1436,7 +1406,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	if (last_pool && last_pool != pwq->pool) {
 		struct worker *worker;
 
-		spin_lock(&last_pool->lock);
+		raw_spin_lock(&last_pool->lock);
 
 		worker = find_worker_executing_work(last_pool, work);
 
@@ -1444,11 +1414,11 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 			pwq = worker->current_pwq;
 		} else {
 			/* meh... not running there, queue here */
-			spin_unlock(&last_pool->lock);
-			spin_lock(&pwq->pool->lock);
+			raw_spin_unlock(&last_pool->lock);
+			raw_spin_lock(&pwq->pool->lock);
 		}
 	} else {
-		spin_lock(&pwq->pool->lock);
+		raw_spin_lock(&pwq->pool->lock);
 	}
 
 	/*
@@ -1461,7 +1431,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 */
 	if (unlikely(!pwq->refcnt)) {
 		if (wq->flags & WQ_UNBOUND) {
-			spin_unlock(&pwq->pool->lock);
+			raw_spin_unlock(&pwq->pool->lock);
 			cpu_relax();
 			goto retry;
 		}
@@ -1494,7 +1464,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	insert_work(pwq, work, worklist, work_flags);
 
 out:
-	spin_unlock(&pwq->pool->lock);
+	raw_spin_unlock(&pwq->pool->lock);
 	rcu_read_unlock();
 }
 
@@ -1515,14 +1485,14 @@ bool queue_work_on(int cpu, struct workqueue_struct *wq,
 	bool ret = false;
 	unsigned long flags;
 
-	local_lock_irqsave(pendingb_lock,flags);
+	local_irq_save(flags);
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		__queue_work(cpu, wq, work);
 		ret = true;
 	}
 
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
 	return ret;
 }
 EXPORT_SYMBOL(queue_work_on);
@@ -1590,14 +1560,14 @@ bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 	unsigned long flags;
 
 	/* read the comment in __queue_work() */
-	local_lock_irqsave(pendingb_lock, flags);
+	local_irq_save(flags);
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		__queue_delayed_work(cpu, wq, dwork, delay);
 		ret = true;
 	}
 
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
 	return ret;
 }
 EXPORT_SYMBOL(queue_delayed_work_on);
@@ -1632,7 +1602,7 @@ bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
 
 	if (likely(ret >= 0)) {
 		__queue_delayed_work(cpu, wq, dwork, delay);
-		local_unlock_irqrestore(pendingb_lock, flags);
+		local_irq_restore(flags);
 	}
 
 	/* -ENOENT from try_to_grab_pending() becomes %true */
@@ -1648,7 +1618,7 @@ EXPORT_SYMBOL_GPL(mod_delayed_work_on);
  * necessary.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void worker_enter_idle(struct worker *worker)
 {
@@ -1665,9 +1635,7 @@ static void worker_enter_idle(struct worker *worker)
 	worker->last_active = jiffies;
 
 	/* idle_list is LIFO */
-	rt_lock_idle_list(pool);
 	list_add(&worker->entry, &pool->idle_list);
-	rt_unlock_idle_list(pool);
 
 	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
@@ -1690,7 +1658,7 @@ static void worker_enter_idle(struct worker *worker)
  * @worker is leaving idle state.  Update stats.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void worker_leave_idle(struct worker *worker)
 {
@@ -1700,9 +1668,7 @@ static void worker_leave_idle(struct worker *worker)
 		return;
 	worker_clr_flags(worker, WORKER_IDLE);
 	pool->nr_idle--;
-	rt_lock_idle_list(pool);
 	list_del_init(&worker->entry);
-	rt_unlock_idle_list(pool);
 }
 
 static struct worker *alloc_worker(int node)
@@ -1828,11 +1794,11 @@ static struct worker *create_worker(struct worker_pool *pool)
 	worker_attach_to_pool(worker, pool);
 
 	/* start the newly created worker */
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	worker->pool->nr_workers++;
 	worker_enter_idle(worker);
 	wake_up_process(worker->task);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	return worker;
 
@@ -1851,7 +1817,7 @@ static struct worker *create_worker(struct worker_pool *pool)
  * be idle.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void destroy_worker(struct worker *worker)
 {
@@ -1868,9 +1834,7 @@ static void destroy_worker(struct worker *worker)
 	pool->nr_workers--;
 	pool->nr_idle--;
 
-	rt_lock_idle_list(pool);
 	list_del_init(&worker->entry);
-	rt_unlock_idle_list(pool);
 	worker->flags |= WORKER_DIE;
 	wake_up_process(worker->task);
 }
@@ -1879,7 +1843,7 @@ static void idle_worker_timeout(unsigned long __pool)
 {
 	struct worker_pool *pool = (void *)__pool;
 
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 
 	while (too_many_workers(pool)) {
 		struct worker *worker;
@@ -1897,7 +1861,7 @@ static void idle_worker_timeout(unsigned long __pool)
 		destroy_worker(worker);
 	}
 
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 }
 
 static void send_mayday(struct work_struct *work)
@@ -1928,8 +1892,8 @@ static void pool_mayday_timeout(unsigned long __pool)
 	struct worker_pool *pool = (void *)__pool;
 	struct work_struct *work;
 
-	spin_lock_irq(&pool->lock);
-	spin_lock(&wq_mayday_lock);		/* for wq->maydays */
+	raw_spin_lock_irq(&pool->lock);
+	raw_spin_lock(&wq_mayday_lock);		/* for wq->maydays */
 
 	if (need_to_create_worker(pool)) {
 		/*
@@ -1942,8 +1906,8 @@ static void pool_mayday_timeout(unsigned long __pool)
 			send_mayday(work);
 	}
 
-	spin_unlock(&wq_mayday_lock);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock(&wq_mayday_lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INTERVAL);
 }
@@ -1962,7 +1926,7 @@ static void pool_mayday_timeout(unsigned long __pool)
  * may_start_working() %true.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.  Called only from
  * manager.
  */
@@ -1971,7 +1935,7 @@ __releases(&pool->lock)
 __acquires(&pool->lock)
 {
 restart:
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	/* if we don't make progress in MAYDAY_INITIAL_TIMEOUT, call for help */
 	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INITIAL_TIMEOUT);
@@ -1987,7 +1951,7 @@ __acquires(&pool->lock)
 	}
 
 	del_timer_sync(&pool->mayday_timer);
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	/*
 	 * This is necessary even after a new worker was just successfully
 	 * created as @pool->lock was dropped and the new worker might have
@@ -2010,7 +1974,7 @@ __acquires(&pool->lock)
  * and may_start_working() is true.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.
  *
  * Return:
@@ -2033,7 +1997,7 @@ static bool manage_workers(struct worker *worker)
 
 	pool->manager = NULL;
 	pool->flags &= ~POOL_MANAGER_ACTIVE;
-	wake_up(&wq_manager_wait);
+	rcuwait_wake_up(&manager_wait);
 	return true;
 }
 
@@ -2049,7 +2013,7 @@ static bool manage_workers(struct worker *worker)
  * call this function to process a work.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which is released and regrabbed.
+ * raw_spin_lock_irq(pool->lock) which is released and regrabbed.
  */
 static void process_one_work(struct worker *worker, struct work_struct *work)
 __releases(&pool->lock)
@@ -2125,7 +2089,7 @@ __acquires(&pool->lock)
 	 */
 	set_work_pool_and_clear_pending(work, pool->id);
 
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	lock_map_acquire_read(&pwq->wq->lockdep_map);
 	lock_map_acquire(&lockdep_map);
@@ -2158,7 +2122,7 @@ __acquires(&pool->lock)
 	 */
 	cond_resched_rcu_qs();
 
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 
 	/* clear cpu intensive status */
 	if (unlikely(cpu_intensive))
@@ -2182,7 +2146,7 @@ __acquires(&pool->lock)
  * fetches a work from the top and executes it.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.
  */
 static void process_scheduled_works(struct worker *worker)
@@ -2214,11 +2178,11 @@ static int worker_thread(void *__worker)
 	/* tell the scheduler that this is a workqueue worker */
 	worker->task->flags |= PF_WQ_WORKER;
 woke_up:
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 
 	/* am I supposed to die? */
 	if (unlikely(worker->flags & WORKER_DIE)) {
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 		WARN_ON_ONCE(!list_empty(&worker->entry));
 		worker->task->flags &= ~PF_WQ_WORKER;
 
@@ -2284,7 +2248,7 @@ static int worker_thread(void *__worker)
 	 */
 	worker_enter_idle(worker);
 	__set_current_state(TASK_INTERRUPTIBLE);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 	schedule();
 	goto woke_up;
 }
@@ -2338,7 +2302,7 @@ static int rescuer_thread(void *__rescuer)
 	should_stop = kthread_should_stop();
 
 	/* see whether any pwq is asking for help */
-	spin_lock_irq(&wq_mayday_lock);
+	raw_spin_lock_irq(&wq_mayday_lock);
 
 	while (!list_empty(&wq->maydays)) {
 		struct pool_workqueue *pwq = list_first_entry(&wq->maydays,
@@ -2350,11 +2314,11 @@ static int rescuer_thread(void *__rescuer)
 		__set_current_state(TASK_RUNNING);
 		list_del_init(&pwq->mayday_node);
 
-		spin_unlock_irq(&wq_mayday_lock);
+		raw_spin_unlock_irq(&wq_mayday_lock);
 
 		worker_attach_to_pool(rescuer, pool);
 
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
 		rescuer->pool = pool;
 
 		/*
@@ -2384,7 +2348,7 @@ static int rescuer_thread(void *__rescuer)
 			 * incur MAYDAY_INTERVAL delay inbetween.
 			 */
 			if (need_to_create_worker(pool)) {
-				spin_lock(&wq_mayday_lock);
+				raw_spin_lock(&wq_mayday_lock);
 				/*
 				 * Queue iff we aren't racing destruction
 				 * and somebody else hasn't queued it already.
@@ -2393,7 +2357,7 @@ static int rescuer_thread(void *__rescuer)
 					get_pwq(pwq);
 					list_add_tail(&pwq->mayday_node, &wq->maydays);
 				}
-				spin_unlock(&wq_mayday_lock);
+				raw_spin_unlock(&wq_mayday_lock);
 			}
 		}
 
@@ -2412,14 +2376,14 @@ static int rescuer_thread(void *__rescuer)
 			wake_up_worker(pool);
 
 		rescuer->pool = NULL;
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 
 		worker_detach_from_pool(rescuer, pool);
 
-		spin_lock_irq(&wq_mayday_lock);
+		raw_spin_lock_irq(&wq_mayday_lock);
 	}
 
-	spin_unlock_irq(&wq_mayday_lock);
+	raw_spin_unlock_irq(&wq_mayday_lock);
 
 	if (should_stop) {
 		__set_current_state(TASK_RUNNING);
@@ -2499,7 +2463,7 @@ static void wq_barrier_func(struct work_struct *work)
  * underneath us, so we can't reliably determine pwq from @target.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void insert_wq_barrier(struct pool_workqueue *pwq,
 			      struct wq_barrier *barr,
@@ -2584,7 +2548,7 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 	for_each_pwq(pwq, wq) {
 		struct worker_pool *pool = pwq->pool;
 
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
 
 		if (flush_color >= 0) {
 			WARN_ON_ONCE(pwq->flush_color != -1);
@@ -2601,7 +2565,7 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 			pwq->work_color = work_color;
 		}
 
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 	}
 
 	if (flush_color >= 0 && atomic_dec_and_test(&wq->nr_pwqs_to_flush))
@@ -2626,6 +2590,9 @@ void flush_workqueue(struct workqueue_struct *wq)
 	};
 	int next_color;
 
+	if (WARN_ON(!wq_online))
+		return;
+
 	lock_map_acquire(&wq->lockdep_map);
 	lock_map_release(&wq->lockdep_map);
 
@@ -2798,9 +2765,9 @@ void drain_workqueue(struct workqueue_struct *wq)
 	for_each_pwq(pwq, wq) {
 		bool drained;
 
-		spin_lock_irq(&pwq->pool->lock);
+		raw_spin_lock_irq(&pwq->pool->lock);
 		drained = !pwq->nr_active && list_empty(&pwq->delayed_works);
-		spin_unlock_irq(&pwq->pool->lock);
+		raw_spin_unlock_irq(&pwq->pool->lock);
 
 		if (drained)
 			continue;
@@ -2835,7 +2802,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
 		return false;
 	}
 
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	/* see the comment in try_to_grab_pending() with the same code */
 	pwq = get_work_pwq(work);
 	if (pwq) {
@@ -2851,7 +2818,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
 	check_flush_dependency(pwq->wq, work);
 
 	insert_wq_barrier(pwq, barr, work, worker);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	/*
 	 * If @max_active is 1 or rescuer is in use, flushing another work
@@ -2867,7 +2834,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
 	rcu_read_unlock();
 	return true;
 already_gone:
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 	rcu_read_unlock();
 	return false;
 }
@@ -2887,6 +2854,9 @@ bool flush_work(struct work_struct *work)
 {
 	struct wq_barrier barr;
 
+	if (WARN_ON(!wq_online))
+		return false;
+
 	lock_map_acquire(&work->lockdep_map);
 	lock_map_release(&work->lockdep_map);
 
@@ -2955,9 +2925,15 @@ static bool __cancel_work_timer(struct work_struct *work, bool is_dwork)
 
 	/* tell other tasks trying to grab @work to back off */
 	mark_work_canceling(work);
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
+
+	/*
+	 * This allows canceling during early boot.  We know that @work
+	 * isn't executing.
+	 */
+	if (wq_online)
+		flush_work(work);
 
-	flush_work(work);
 	clear_work_data(work);
 
 	/*
@@ -3010,10 +2986,10 @@ EXPORT_SYMBOL_GPL(cancel_work_sync);
  */
 bool flush_delayed_work(struct delayed_work *dwork)
 {
-	local_lock_irq(pendingb_lock);
+	local_irq_disable();
 	if (del_timer_sync(&dwork->timer))
 		__queue_work(dwork->cpu, dwork->wq, &dwork->work);
-	local_unlock_irq(pendingb_lock);
+	local_irq_enable();
 	return flush_work(&dwork->work);
 }
 EXPORT_SYMBOL(flush_delayed_work);
@@ -3031,7 +3007,7 @@ static bool __cancel_work(struct work_struct *work, bool is_dwork)
 		return false;
 
 	set_work_pool_and_clear_pending(work, get_work_pool_id(work));
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
 	return ret;
 }
 
@@ -3230,7 +3206,7 @@ static bool wqattrs_equal(const struct workqueue_attrs *a,
  */
 static int init_worker_pool(struct worker_pool *pool)
 {
-	spin_lock_init(&pool->lock);
+	raw_spin_lock_init(&pool->lock);
 	pool->id = -1;
 	pool->cpu = -1;
 	pool->node = NUMA_NO_NODE;
@@ -3284,6 +3260,18 @@ static void rcu_free_pool(struct rcu_head *rcu)
 	kfree(pool);
 }
 
+/* This returns with the lock held on success (pool manager is inactive). */
+static bool wq_manager_inactive(struct worker_pool *pool)
+{
+	raw_spin_lock_irq(&pool->lock);
+
+	if (pool->flags & POOL_MANAGER_ACTIVE) {
+		raw_spin_unlock_irq(&pool->lock);
+		return false;
+	}
+	return true;
+}
+
 /**
  * put_unbound_pool - put a worker_pool
  * @pool: worker_pool to put
@@ -3319,16 +3307,17 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * Become the manager and destroy all workers.  This prevents
 	 * @pool's workers from blocking on attach_mutex.  We're the last
 	 * manager and @pool gets freed with the flag set.
+	 * Because of how wq_manager_inactive() works, we will hold the
+	 * spinlock after a successful wait.
 	 */
-	spin_lock_irq(&pool->lock);
-	wait_event_lock_irq(wq_manager_wait,
-			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
+	rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
+			   TASK_UNINTERRUPTIBLE);
 	pool->flags |= POOL_MANAGER_ACTIVE;
 
 	while ((worker = first_idle_worker(pool)))
 		destroy_worker(worker);
 	WARN_ON(pool->nr_workers || pool->nr_idle);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	mutex_lock(&pool->attach_mutex);
 	if (!list_empty(&pool->workers))
@@ -3407,7 +3396,7 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 		goto fail;
 
 	/* create and start the initial worker */
-	if (!create_worker(pool))
+	if (wq_online && !create_worker(pool))
 		goto fail;
 
 	/* install */
@@ -3478,6 +3467,7 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 {
 	struct workqueue_struct *wq = pwq->wq;
 	bool freezable = wq->flags & WQ_FREEZABLE;
+	unsigned long flags;
 
 	/* for @wq->saved_max_active */
 	lockdep_assert_held(&wq->mutex);
@@ -3486,7 +3476,8 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 	if (!freezable && pwq->max_active == wq->saved_max_active)
 		return;
 
-	spin_lock_irq(&pwq->pool->lock);
+	/* this function can be called during early boot w/ irq disabled */
+	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
 
 	/*
 	 * During [un]freezing, the caller is responsible for ensuring that
@@ -3516,7 +3507,7 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 		pwq->max_active = 0;
 	}
 
-	spin_unlock_irq(&pwq->pool->lock);
+	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 }
 
 /* initialize newly alloced @pwq which is associated with @wq and @pool */
@@ -3908,9 +3899,9 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 
 use_dfl_pwq:
 	mutex_lock(&wq->mutex);
-	spin_lock_irq(&wq->dfl_pwq->pool->lock);
+	raw_spin_lock_irq(&wq->dfl_pwq->pool->lock);
 	get_pwq(wq->dfl_pwq);
-	spin_unlock_irq(&wq->dfl_pwq->pool->lock);
+	raw_spin_unlock_irq(&wq->dfl_pwq->pool->lock);
 	old_pwq = numa_pwq_tbl_install(wq, node, wq->dfl_pwq);
 out_unlock:
 	mutex_unlock(&wq->mutex);
@@ -4106,9 +4097,9 @@ void destroy_workqueue(struct workqueue_struct *wq)
 		struct worker *rescuer = wq->rescuer;
 
 		/* this prevents new queueing */
-		spin_lock_irq(&wq_mayday_lock);
+		raw_spin_lock_irq(&wq_mayday_lock);
 		wq->rescuer = NULL;
-		spin_unlock_irq(&wq_mayday_lock);
+		raw_spin_unlock_irq(&wq_mayday_lock);
 
 		/* rescuer will empty maydays list before exiting */
 		kthread_stop(rescuer->task);
@@ -4301,10 +4292,10 @@ unsigned int work_busy(struct work_struct *work)
 	rcu_read_lock();
 	pool = get_work_pool(work);
 	if (pool) {
-		spin_lock_irqsave(&pool->lock, flags);
+		raw_spin_lock_irqsave(&pool->lock, flags);
 		if (find_worker_executing_work(pool, work))
 			ret |= WORK_BUSY_RUNNING;
-		spin_unlock_irqrestore(&pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pool->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -4516,10 +4507,10 @@ void show_workqueue_state(void)
 		pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
 
 		for_each_pwq(pwq, wq) {
-			spin_lock_irqsave(&pwq->pool->lock, flags);
+			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
 			if (pwq->nr_active || !list_empty(&pwq->delayed_works))
 				show_pwq(pwq);
-			spin_unlock_irqrestore(&pwq->pool->lock, flags);
+			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 			/*
 			 * We could be printing a lot from atomic context, e.g.
 			 * sysrq-t -> show_workqueue_state(). Avoid triggering
@@ -4533,7 +4524,7 @@ void show_workqueue_state(void)
 		struct worker *worker;
 		bool first = true;
 
-		spin_lock_irqsave(&pool->lock, flags);
+		raw_spin_lock_irqsave(&pool->lock, flags);
 		if (pool->nr_workers == pool->nr_idle)
 			goto next_pool;
 
@@ -4552,7 +4543,7 @@ void show_workqueue_state(void)
 		}
 		pr_cont("\n");
 	next_pool:
-		spin_unlock_irqrestore(&pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pool->lock, flags);
 		/*
 		 * We could be printing a lot from atomic context, e.g.
 		 * sysrq-t -> show_workqueue_state(). Avoid triggering
@@ -4587,7 +4578,7 @@ static void wq_unbind_fn(struct work_struct *work)
 
 	for_each_cpu_worker_pool(pool, cpu) {
 		mutex_lock(&pool->attach_mutex);
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
 
 		/*
 		 * We've blocked all attach/detach operations. Make all workers
@@ -4601,7 +4592,7 @@ static void wq_unbind_fn(struct work_struct *work)
 
 		pool->flags |= POOL_DISASSOCIATED;
 
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 		mutex_unlock(&pool->attach_mutex);
 
 		/*
@@ -4627,9 +4618,9 @@ static void wq_unbind_fn(struct work_struct *work)
 		 * worker blocking could lead to lengthy stalls.  Kick off
 		 * unbound chain execution of currently pending work items.
 		 */
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
 		wake_up_worker(pool);
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 	}
 }
 
@@ -4656,7 +4647,7 @@ static void rebind_workers(struct worker_pool *pool)
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
 						  pool->attrs->cpumask) < 0);
 
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 
 	/*
 	 * XXX: CPU hotplug notifiers are weird and can call DOWN_FAILED
@@ -4664,7 +4655,7 @@ static void rebind_workers(struct worker_pool *pool)
 	 * being reworked and this can go away in time.
 	 */
 	if (!(pool->flags & POOL_DISASSOCIATED)) {
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 		return;
 	}
 
@@ -4705,7 +4696,7 @@ static void rebind_workers(struct worker_pool *pool)
 		ACCESS_ONCE(worker->flags) = worker_flags;
 	}
 
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 }
 
 /**
@@ -5593,7 +5584,17 @@ static void __init wq_numa_init(void)
 	wq_numa_enabled = true;
 }
 
-static int __init init_workqueues(void)
+/**
+ * workqueue_init_early - early init for workqueue subsystem
+ *
+ * This is the first half of two-staged workqueue subsystem initialization
+ * and invoked as soon as the bare basics - memory allocation, cpumasks and
+ * idr are up.  It sets up all the data structures and system workqueues
+ * and allows early boot code to create workqueues and queue/cancel work
+ * items.  Actual work item execution starts only after kthreads can be
+ * created and scheduled right before early initcalls.
+ */
+int __init workqueue_init_early(void)
 {
 	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
 	int i, cpu;
@@ -5626,16 +5627,6 @@ static int __init init_workqueues(void)
 		}
 	}
 
-	/* create the initial worker */
-	for_each_online_cpu(cpu) {
-		struct worker_pool *pool;
-
-		for_each_cpu_worker_pool(pool, cpu) {
-			pool->flags &= ~POOL_DISASSOCIATED;
-			BUG_ON(!create_worker(pool));
-		}
-	}
-
 	/* create default unbound and ordered wq attrs */
 	for (i = 0; i < NR_STD_WORKER_POOLS; i++) {
 		struct workqueue_attrs *attrs;
@@ -5672,8 +5663,36 @@ static int __init init_workqueues(void)
 	       !system_power_efficient_wq ||
 	       !system_freezable_power_efficient_wq);
 
+	return 0;
+}
+
+/**
+ * workqueue_init - bring workqueue subsystem fully online
+ *
+ * This is the latter half of two-staged workqueue subsystem initialization
+ * and invoked as soon as kthreads can be created and scheduled.
+ * Workqueues have been created and work items queued on them, but there
+ * are no kworkers executing the work items yet.  Populate the worker pools
+ * with the initial workers and enable future kworker creations.
+ */
+int __init workqueue_init(void)
+{
+	struct worker_pool *pool;
+	int cpu, bkt;
+
+	/* create the initial workers */
+	for_each_online_cpu(cpu) {
+		for_each_cpu_worker_pool(pool, cpu) {
+			pool->flags &= ~POOL_DISASSOCIATED;
+			BUG_ON(!create_worker(pool));
+		}
+	}
+
+	hash_for_each(unbound_pool_hash, bkt, pool, hash_node)
+		BUG_ON(!create_worker(pool));
+
+	wq_online = true;
 	wq_watchdog_init();
 
 	return 0;
 }
-early_initcall(init_workqueues);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e7addfcd302f..95be8e1b12f6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1177,6 +1177,33 @@ config STACKTRACE
 	  It is also used by various kernel debugging features that require
 	  stack trace generation.
 
+config WARN_ALL_UNSEEDED_RANDOM
+	bool "Warn for all uses of unseeded randomness"
+	default n
+	help
+	  Some parts of the kernel contain bugs relating to their use of
+	  cryptographically secure random numbers before it's actually possible
+	  to generate those numbers securely. This setting ensures that these
+	  flaws don't go unnoticed, by enabling a message, should this ever
+	  occur. This will allow people with obscure setups to know when things
+	  are going wrong, so that they might contact developers about fixing
+	  it.
+
+	  Unfortunately, on some models of some architectures getting
+	  a fully seeded CRNG is extremely difficult, and so this can
+	  result in dmesg getting spammed for a surprisingly long
+	  time.  This is really bad from a security perspective, and
+	  so architecture maintainers really need to do what they can
+	  to get the CRNG seeded sooner after the system is booted.
+	  However, since users cannot do anything actionable to
+	  address this, by default this option is disabled.
+
+	  Say Y here if you want to receive warnings for all uses of
+	  unseeded randomness.  This will be of use primarily for
+	  those developers interersted in improving the security of
+	  Linux kernels running on their architecture (or
+	  subarchitecture).
+
 config DEBUG_KOBJECT
 	bool "kobject debugging"
 	depends on DEBUG_KERNEL
diff --git a/lib/Makefile b/lib/Makefile
index 7a55c5205281..775d6ef6d2ef 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -234,3 +234,5 @@ KASAN_SANITIZE_ubsan.o := n
 CFLAGS_ubsan.o := $(call cc-option, -fno-stack-protector) $(DISABLE_STACKLEAK_PLUGIN)
 
 obj-$(CONFIG_SBITMAP) += sbitmap.o
+
+obj-y += crypto/
diff --git a/lib/chacha20.c b/lib/chacha20.c
index 250ceed9ec9a..5f6c222e939a 100644
--- a/lib/chacha20.c
+++ b/lib/chacha20.c
@@ -21,9 +21,9 @@ static inline u32 rotl32(u32 v, u8 n)
 	return (v << n) | (v >> (sizeof(v) * 8 - n));
 }
 
-extern void chacha20_block(u32 *state, void *stream)
+void chacha20_block(u32 *state, u8 *stream)
 {
-	u32 x[16], *out = stream;
+	u32 x[16];
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(x); i++)
@@ -72,7 +72,7 @@ extern void chacha20_block(u32 *state, void *stream)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(x); i++)
-		out[i] = cpu_to_le32(x[i] + state[i]);
+		put_unaligned_le32(x[i] + state[i], &stream[i * sizeof(u32)]);
 
 	state[12]++;
 }
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
new file mode 100644
index 000000000000..d0bca68618f0
--- /dev/null
+++ b/lib/crypto/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += libblake2s.o
+libblake2s-y += blake2s.o blake2s-generic.o
+ifneq ($(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS),y)
+libblake2s-y += blake2s-selftest.o
+endif
diff --git a/lib/crypto/blake2s-generic.c b/lib/crypto/blake2s-generic.c
new file mode 100644
index 000000000000..04ff8df24513
--- /dev/null
+++ b/lib/crypto/blake2s-generic.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ *
+ * This is an implementation of the BLAKE2s hash and PRF functions.
+ *
+ * Information: https://blake2.net/
+ *
+ */
+
+#include <crypto/internal/blake2s.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/bug.h>
+#include <asm/unaligned.h>
+
+static const u8 blake2s_sigma[10][16] = {
+	{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
+	{ 14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3 },
+	{ 11, 8, 12, 0, 5, 2, 15, 13, 10, 14, 3, 6, 7, 1, 9, 4 },
+	{ 7, 9, 3, 1, 13, 12, 11, 14, 2, 6, 5, 10, 4, 0, 15, 8 },
+	{ 9, 0, 5, 7, 2, 4, 10, 15, 14, 1, 11, 12, 6, 8, 3, 13 },
+	{ 2, 12, 6, 10, 0, 11, 8, 3, 4, 13, 7, 5, 15, 14, 1, 9 },
+	{ 12, 5, 1, 15, 14, 13, 4, 10, 0, 7, 6, 3, 9, 2, 8, 11 },
+	{ 13, 11, 7, 14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10 },
+	{ 6, 15, 14, 9, 11, 3, 0, 8, 12, 2, 13, 7, 1, 4, 10, 5 },
+	{ 10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0 },
+};
+
+static inline void blake2s_increment_counter(struct blake2s_state *state,
+					     const u32 inc)
+{
+	state->t[0] += inc;
+	state->t[1] += (state->t[0] < inc);
+}
+
+void blake2s_compress_generic(struct blake2s_state *state,const u8 *block,
+			      size_t nblocks, const u32 inc)
+{
+	u32 m[16];
+	u32 v[16];
+	int i;
+
+	WARN_ON(IS_ENABLED(DEBUG) &&
+		(nblocks > 1 && inc != BLAKE2S_BLOCK_SIZE));
+
+	while (nblocks > 0) {
+		blake2s_increment_counter(state, inc);
+		memcpy(m, block, BLAKE2S_BLOCK_SIZE);
+		le32_to_cpu_array(m, ARRAY_SIZE(m));
+		memcpy(v, state->h, 32);
+		v[ 8] = BLAKE2S_IV0;
+		v[ 9] = BLAKE2S_IV1;
+		v[10] = BLAKE2S_IV2;
+		v[11] = BLAKE2S_IV3;
+		v[12] = BLAKE2S_IV4 ^ state->t[0];
+		v[13] = BLAKE2S_IV5 ^ state->t[1];
+		v[14] = BLAKE2S_IV6 ^ state->f[0];
+		v[15] = BLAKE2S_IV7 ^ state->f[1];
+
+#define G(r, i, a, b, c, d) do { \
+	a += b + m[blake2s_sigma[r][2 * i + 0]]; \
+	d = ror32(d ^ a, 16); \
+	c += d; \
+	b = ror32(b ^ c, 12); \
+	a += b + m[blake2s_sigma[r][2 * i + 1]]; \
+	d = ror32(d ^ a, 8); \
+	c += d; \
+	b = ror32(b ^ c, 7); \
+} while (0)
+
+#define ROUND(r) do { \
+	G(r, 0, v[0], v[ 4], v[ 8], v[12]); \
+	G(r, 1, v[1], v[ 5], v[ 9], v[13]); \
+	G(r, 2, v[2], v[ 6], v[10], v[14]); \
+	G(r, 3, v[3], v[ 7], v[11], v[15]); \
+	G(r, 4, v[0], v[ 5], v[10], v[15]); \
+	G(r, 5, v[1], v[ 6], v[11], v[12]); \
+	G(r, 6, v[2], v[ 7], v[ 8], v[13]); \
+	G(r, 7, v[3], v[ 4], v[ 9], v[14]); \
+} while (0)
+		ROUND(0);
+		ROUND(1);
+		ROUND(2);
+		ROUND(3);
+		ROUND(4);
+		ROUND(5);
+		ROUND(6);
+		ROUND(7);
+		ROUND(8);
+		ROUND(9);
+
+#undef G
+#undef ROUND
+
+		for (i = 0; i < 8; ++i)
+			state->h[i] ^= v[i] ^ v[i + 8];
+
+		block += BLAKE2S_BLOCK_SIZE;
+		--nblocks;
+	}
+}
+
+EXPORT_SYMBOL(blake2s_compress_generic);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("BLAKE2s hash function");
+MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
diff --git a/lib/crypto/blake2s-selftest.c b/lib/crypto/blake2s-selftest.c
new file mode 100644
index 000000000000..7a9edc96dddd
--- /dev/null
+++ b/lib/crypto/blake2s-selftest.c
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <crypto/blake2s.h>
+#include <linux/string.h>
+
+/*
+ * blake2s_testvecs[] generated with the program below (using libb2-dev and
+ * libssl-dev [OpenSSL])
+ *
+ * #include <blake2.h>
+ * #include <stdint.h>
+ * #include <stdio.h>
+ *
+ * #include <openssl/evp.h>
+ *
+ * #define BLAKE2S_TESTVEC_COUNT	256
+ *
+ * static void print_vec(const uint8_t vec[], int len)
+ * {
+ *	int i;
+ *
+ *	printf("  { ");
+ *	for (i = 0; i < len; i++) {
+ *		if (i && (i % 12) == 0)
+ *			printf("\n    ");
+ *		printf("0x%02x, ", vec[i]);
+ *	}
+ *	printf("},\n");
+ * }
+ *
+ * int main(void)
+ * {
+ *	uint8_t key[BLAKE2S_KEYBYTES];
+ *	uint8_t buf[BLAKE2S_TESTVEC_COUNT];
+ *	uint8_t hash[BLAKE2S_OUTBYTES];
+ *	int i, j;
+ *
+ *	key[0] = key[1] = 1;
+ *	for (i = 2; i < BLAKE2S_KEYBYTES; ++i)
+ *		key[i] = key[i - 2] + key[i - 1];
+ *
+ *	for (i = 0; i < BLAKE2S_TESTVEC_COUNT; ++i)
+ *		buf[i] = (uint8_t)i;
+ *
+ *	printf("static const u8 blake2s_testvecs[][BLAKE2S_HASH_SIZE] __initconst = {\n");
+ *
+ *	for (i = 0; i < BLAKE2S_TESTVEC_COUNT; ++i) {
+ *		int outlen = 1 + i % BLAKE2S_OUTBYTES;
+ *		int keylen = (13 * i) % (BLAKE2S_KEYBYTES + 1);
+ *
+ *		blake2s(hash, buf, key + BLAKE2S_KEYBYTES - keylen, outlen, i,
+ *			keylen);
+ *		print_vec(hash, outlen);
+ *	}
+ *	printf("};\n\n");
+ *
+ *	return 0;
+ *}
+ */
+static const u8 blake2s_testvecs[][BLAKE2S_HASH_SIZE] __initconst = {
+  { 0xa1, },
+  { 0x7c, 0x89, },
+  { 0x74, 0x0e, 0xd4, },
+  { 0x47, 0x0c, 0x21, 0x15, },
+  { 0x18, 0xd6, 0x9c, 0xa6, 0xc4, },
+  { 0x13, 0x5d, 0x16, 0x63, 0x2e, 0xf9, },
+  { 0x2c, 0xb5, 0x04, 0xb7, 0x99, 0xe2, 0x73, },
+  { 0x9a, 0x0f, 0xd2, 0x39, 0xd6, 0x68, 0x1b, 0x92, },
+  { 0xc8, 0xde, 0x7a, 0xea, 0x2f, 0xf4, 0xd2, 0xe3, 0x2b, },
+  { 0x5b, 0xf9, 0x43, 0x52, 0x0c, 0x12, 0xba, 0xb5, 0x93, 0x9f, },
+  { 0xc6, 0x2c, 0x4e, 0x80, 0xfc, 0x32, 0x5b, 0x33, 0xb8, 0xb8, 0x0a, },
+  { 0xa7, 0x5c, 0xfd, 0x3a, 0xcc, 0xbf, 0x90, 0xca, 0xb7, 0x97, 0xde, 0xd8, },
+  { 0x66, 0xca, 0x3c, 0xc4, 0x19, 0xef, 0x92, 0x66, 0x3f, 0x21, 0x8f, 0xda,
+    0xb7, },
+  { 0xba, 0xe5, 0xbb, 0x30, 0x25, 0x94, 0x6d, 0xc3, 0x89, 0x09, 0xc4, 0x25,
+    0x52, 0x3e, },
+  { 0xa2, 0xef, 0x0e, 0x52, 0x0b, 0x5f, 0xa2, 0x01, 0x6d, 0x0a, 0x25, 0xbc,
+    0x57, 0xe2, 0x27, },
+  { 0x4f, 0xe0, 0xf9, 0x52, 0x12, 0xda, 0x84, 0xb7, 0xab, 0xae, 0xb0, 0xa6,
+    0x47, 0x2a, 0xc7, 0xf5, },
+  { 0x56, 0xe7, 0xa8, 0x1c, 0x4c, 0xca, 0xed, 0x90, 0x31, 0xec, 0x87, 0x43,
+    0xe7, 0x72, 0x08, 0xec, 0xbe, },
+  { 0x7e, 0xdf, 0x80, 0x1c, 0x93, 0x33, 0xfd, 0x53, 0x44, 0xba, 0xfd, 0x96,
+    0xe1, 0xbb, 0xb5, 0x65, 0xa5, 0x00, },
+  { 0xec, 0x6b, 0xed, 0xf7, 0x7b, 0x62, 0x1d, 0x7d, 0xf4, 0x82, 0xf3, 0x1e,
+    0x18, 0xff, 0x2b, 0xc4, 0x06, 0x20, 0x2a, },
+  { 0x74, 0x98, 0xd7, 0x68, 0x63, 0xed, 0x87, 0xe4, 0x5d, 0x8d, 0x9e, 0x1d,
+    0xfd, 0x2a, 0xbb, 0x86, 0xac, 0xe9, 0x2a, 0x89, },
+  { 0x89, 0xc3, 0x88, 0xce, 0x2b, 0x33, 0x1e, 0x10, 0xd1, 0x37, 0x20, 0x86,
+    0x28, 0x43, 0x70, 0xd9, 0xfb, 0x96, 0xd9, 0xb5, 0xd3, },
+  { 0xcb, 0x56, 0x74, 0x41, 0x8d, 0x80, 0x01, 0x9a, 0x6b, 0x38, 0xe1, 0x41,
+    0xad, 0x9c, 0x62, 0x74, 0xce, 0x35, 0xd5, 0x6c, 0x89, 0x6e, },
+  { 0x79, 0xaf, 0x94, 0x59, 0x99, 0x26, 0xe1, 0xc9, 0x34, 0xfe, 0x7c, 0x22,
+    0xf7, 0x43, 0xd7, 0x65, 0xd4, 0x48, 0x18, 0xac, 0x3d, 0xfd, 0x93, },
+  { 0x85, 0x0d, 0xff, 0xb8, 0x3e, 0x87, 0x41, 0xb0, 0x95, 0xd3, 0x3d, 0x00,
+    0x47, 0x55, 0x9e, 0xd2, 0x69, 0xea, 0xbf, 0xe9, 0x7a, 0x2d, 0x61, 0x45, },
+  { 0x03, 0xe0, 0x85, 0xec, 0x54, 0xb5, 0x16, 0x53, 0xa8, 0xc4, 0x71, 0xe9,
+    0x6a, 0xe7, 0xcb, 0xc4, 0x15, 0x02, 0xfc, 0x34, 0xa4, 0xa4, 0x28, 0x13,
+    0xd1, },
+  { 0xe3, 0x34, 0x4b, 0xe1, 0xd0, 0x4b, 0x55, 0x61, 0x8f, 0xc0, 0x24, 0x05,
+    0xe6, 0xe0, 0x3d, 0x70, 0x24, 0x4d, 0xda, 0xb8, 0x91, 0x05, 0x29, 0x07,
+    0x01, 0x3e, },
+  { 0x61, 0xff, 0x01, 0x72, 0xb1, 0x4d, 0xf6, 0xfe, 0xd1, 0xd1, 0x08, 0x74,
+    0xe6, 0x91, 0x44, 0xeb, 0x61, 0xda, 0x40, 0xaf, 0xfc, 0x8c, 0x91, 0x6b,
+    0xec, 0x13, 0xed, },
+  { 0xd4, 0x40, 0xd2, 0xa0, 0x7f, 0xc1, 0x58, 0x0c, 0x85, 0xa0, 0x86, 0xc7,
+    0x86, 0xb9, 0x61, 0xc9, 0xea, 0x19, 0x86, 0x1f, 0xab, 0x07, 0xce, 0x37,
+    0x72, 0x67, 0x09, 0xfc, },
+  { 0x9e, 0xf8, 0x18, 0x67, 0x93, 0x10, 0x9b, 0x39, 0x75, 0xe8, 0x8b, 0x38,
+    0x82, 0x7d, 0xb8, 0xb7, 0xa5, 0xaf, 0xe6, 0x6a, 0x22, 0x5e, 0x1f, 0x9c,
+    0x95, 0x29, 0x19, 0xf2, 0x4b, },
+  { 0xc8, 0x62, 0x25, 0xf5, 0x98, 0xc9, 0xea, 0xe5, 0x29, 0x3a, 0xd3, 0x22,
+    0xeb, 0xeb, 0x07, 0x7c, 0x15, 0x07, 0xee, 0x15, 0x61, 0xbb, 0x05, 0x30,
+    0x99, 0x7f, 0x11, 0xf6, 0x0a, 0x1d, },
+  { 0x68, 0x70, 0xf7, 0x90, 0xa1, 0x8b, 0x1f, 0x0f, 0xbb, 0xce, 0xd2, 0x0e,
+    0x33, 0x1f, 0x7f, 0xa9, 0x78, 0xa8, 0xa6, 0x81, 0x66, 0xab, 0x8d, 0xcd,
+    0x58, 0x55, 0x3a, 0x0b, 0x7a, 0xdb, 0xb5, },
+  { 0xdd, 0x35, 0xd2, 0xb4, 0xf6, 0xc7, 0xea, 0xab, 0x64, 0x24, 0x4e, 0xfe,
+    0xe5, 0x3d, 0x4e, 0x95, 0x8b, 0x6d, 0x6c, 0xbc, 0xb0, 0xf8, 0x88, 0x61,
+    0x09, 0xb7, 0x78, 0xa3, 0x31, 0xfe, 0xd9, 0x2f, },
+  { 0x0a, },
+  { 0x6e, 0xd4, },
+  { 0x64, 0xe9, 0xd1, },
+  { 0x30, 0xdd, 0x71, 0xef, },
+  { 0x11, 0xb5, 0x0c, 0x87, 0xc9, },
+  { 0x06, 0x1c, 0x6d, 0x04, 0x82, 0xd0, },
+  { 0x5c, 0x42, 0x0b, 0xee, 0xc5, 0x9c, 0xb2, },
+  { 0xe8, 0x29, 0xd6, 0xb4, 0x5d, 0xf7, 0x2b, 0x93, },
+  { 0x18, 0xca, 0x27, 0x72, 0x43, 0x39, 0x16, 0xbc, 0x6a, },
+  { 0x39, 0x8f, 0xfd, 0x64, 0xf5, 0x57, 0x23, 0xb0, 0x45, 0xf8, },
+  { 0xbb, 0x3a, 0x78, 0x6b, 0x02, 0x1d, 0x0b, 0x16, 0xe3, 0xb2, 0x9a, },
+  { 0xb8, 0xb4, 0x0b, 0xe5, 0xd4, 0x1d, 0x0d, 0x85, 0x49, 0x91, 0x35, 0xfa, },
+  { 0x6d, 0x48, 0x2a, 0x0c, 0x42, 0x08, 0xbd, 0xa9, 0x78, 0x6f, 0x18, 0xaf,
+    0xe2, },
+  { 0x10, 0x45, 0xd4, 0x58, 0x88, 0xec, 0x4e, 0x1e, 0xf6, 0x14, 0x92, 0x64,
+    0x7e, 0xb0, },
+  { 0x8b, 0x0b, 0x95, 0xee, 0x92, 0xc6, 0x3b, 0x91, 0xf1, 0x1e, 0xeb, 0x51,
+    0x98, 0x0a, 0x8d, },
+  { 0xa3, 0x50, 0x4d, 0xa5, 0x1d, 0x03, 0x68, 0xe9, 0x57, 0x78, 0xd6, 0x04,
+    0xf1, 0xc3, 0x94, 0xd8, },
+  { 0xb8, 0x66, 0x6e, 0xdd, 0x46, 0x15, 0xae, 0x3d, 0x83, 0x7e, 0xcf, 0xe7,
+    0x2c, 0xe8, 0x8f, 0xc7, 0x34, },
+  { 0x2e, 0xc0, 0x1f, 0x29, 0xea, 0xf6, 0xb9, 0xe2, 0xc2, 0x93, 0xeb, 0x41,
+    0x0d, 0xf0, 0x0a, 0x13, 0x0e, 0xa2, },
+  { 0x71, 0xb8, 0x33, 0xa9, 0x1b, 0xac, 0xf1, 0xb5, 0x42, 0x8f, 0x5e, 0x81,
+    0x34, 0x43, 0xb7, 0xa4, 0x18, 0x5c, 0x47, },
+  { 0xda, 0x45, 0xb8, 0x2e, 0x82, 0x1e, 0xc0, 0x59, 0x77, 0x9d, 0xfa, 0xb4,
+    0x1c, 0x5e, 0xa0, 0x2b, 0x33, 0x96, 0x5a, 0x58, },
+  { 0xe3, 0x09, 0x05, 0xa9, 0xeb, 0x48, 0x13, 0xad, 0x71, 0x88, 0x81, 0x9a,
+    0x3e, 0x2c, 0xe1, 0x23, 0x99, 0x13, 0x35, 0x9f, 0xb5, },
+  { 0xb7, 0x86, 0x2d, 0x16, 0xe1, 0x04, 0x00, 0x47, 0x47, 0x61, 0x31, 0xfb,
+    0x14, 0xac, 0xd8, 0xe9, 0xe3, 0x49, 0xbd, 0xf7, 0x9c, 0x3f, },
+  { 0x7f, 0xd9, 0x95, 0xa8, 0xa7, 0xa0, 0xcc, 0xba, 0xef, 0xb1, 0x0a, 0xa9,
+    0x21, 0x62, 0x08, 0x0f, 0x1b, 0xff, 0x7b, 0x9d, 0xae, 0xb2, 0x95, },
+  { 0x85, 0x99, 0xea, 0x33, 0xe0, 0x56, 0xff, 0x13, 0xc6, 0x61, 0x8c, 0xf9,
+    0x57, 0x05, 0x03, 0x11, 0xf9, 0xfb, 0x3a, 0xf7, 0xce, 0xbb, 0x52, 0x30, },
+  { 0xb2, 0x72, 0x9c, 0xf8, 0x77, 0x4e, 0x8f, 0x6b, 0x01, 0x6c, 0xff, 0x4e,
+    0x4f, 0x02, 0xd2, 0xbc, 0xeb, 0x51, 0x28, 0x99, 0x50, 0xab, 0xc4, 0x42,
+    0xe3, },
+  { 0x8b, 0x0a, 0xb5, 0x90, 0x8f, 0xf5, 0x7b, 0xdd, 0xba, 0x47, 0x37, 0xc9,
+    0x2a, 0xd5, 0x4b, 0x25, 0x08, 0x8b, 0x02, 0x17, 0xa7, 0x9e, 0x6b, 0x6e,
+    0xe3, 0x90, },
+  { 0x90, 0xdd, 0xf7, 0x75, 0xa7, 0xa3, 0x99, 0x5e, 0x5b, 0x7d, 0x75, 0xc3,
+    0x39, 0x6b, 0xa0, 0xe2, 0x44, 0x53, 0xb1, 0x9e, 0xc8, 0xf1, 0x77, 0x10,
+    0x58, 0x06, 0x9a, },
+  { 0x99, 0x52, 0xf0, 0x49, 0xa8, 0x8c, 0xec, 0xa6, 0x97, 0x32, 0x13, 0xb5,
+    0xf7, 0xa3, 0x8e, 0xfb, 0x4b, 0x59, 0x31, 0x3d, 0x01, 0x59, 0x98, 0x5d,
+    0x53, 0x03, 0x1a, 0x39, },
+  { 0x9f, 0xe0, 0xc2, 0xe5, 0x5d, 0x93, 0xd6, 0x9b, 0x47, 0x8f, 0x9b, 0xe0,
+    0x26, 0x35, 0x84, 0x20, 0x1d, 0xc5, 0x53, 0x10, 0x0f, 0x22, 0xb9, 0xb5,
+    0xd4, 0x36, 0xb1, 0xac, 0x73, },
+  { 0x30, 0x32, 0x20, 0x3b, 0x10, 0x28, 0xec, 0x1f, 0x4f, 0x9b, 0x47, 0x59,
+    0xeb, 0x7b, 0xee, 0x45, 0xfb, 0x0c, 0x49, 0xd8, 0x3d, 0x69, 0xbd, 0x90,
+    0x2c, 0xf0, 0x9e, 0x8d, 0xbf, 0xd5, },
+  { 0x2a, 0x37, 0x73, 0x7f, 0xf9, 0x96, 0x19, 0xaa, 0x25, 0xd8, 0x13, 0x28,
+    0x01, 0x29, 0x89, 0xdf, 0x6e, 0x0c, 0x9b, 0x43, 0x44, 0x51, 0xe9, 0x75,
+    0x26, 0x0c, 0xb7, 0x87, 0x66, 0x0b, 0x5f, },
+  { 0x23, 0xdf, 0x96, 0x68, 0x91, 0x86, 0xd0, 0x93, 0x55, 0x33, 0x24, 0xf6,
+    0xba, 0x08, 0x75, 0x5b, 0x59, 0x11, 0x69, 0xb8, 0xb9, 0xe5, 0x2c, 0x77,
+    0x02, 0xf6, 0x47, 0xee, 0x81, 0xdd, 0xb9, 0x06, },
+  { 0x9d, },
+  { 0x9d, 0x7d, },
+  { 0xfd, 0xc3, 0xda, },
+  { 0xe8, 0x82, 0xcd, 0x21, },
+  { 0xc3, 0x1d, 0x42, 0x4c, 0x74, },
+  { 0xe9, 0xda, 0xf1, 0xa2, 0xe5, 0x7c, },
+  { 0x52, 0xb8, 0x6f, 0x81, 0x5c, 0x3a, 0x4c, },
+  { 0x5b, 0x39, 0x26, 0xfc, 0x92, 0x5e, 0xe0, 0x49, },
+  { 0x59, 0xe4, 0x7c, 0x93, 0x1c, 0xf9, 0x28, 0x93, 0xde, },
+  { 0xde, 0xdf, 0xb2, 0x43, 0x61, 0x0b, 0x86, 0x16, 0x4c, 0x2e, },
+  { 0x14, 0x8f, 0x75, 0x51, 0xaf, 0xb9, 0xee, 0x51, 0x5a, 0xae, 0x23, },
+  { 0x43, 0x5f, 0x50, 0xd5, 0x70, 0xb0, 0x5b, 0x87, 0xf5, 0xd9, 0xb3, 0x6d, },
+  { 0x66, 0x0a, 0x64, 0x93, 0x79, 0x71, 0x94, 0x40, 0xb7, 0x68, 0x2d, 0xd3,
+    0x63, },
+  { 0x15, 0x00, 0xc4, 0x0c, 0x7d, 0x1b, 0x10, 0xa9, 0x73, 0x1b, 0x90, 0x6f,
+    0xe6, 0xa9, },
+  { 0x34, 0x75, 0xf3, 0x86, 0x8f, 0x56, 0xcf, 0x2a, 0x0a, 0xf2, 0x62, 0x0a,
+    0xf6, 0x0e, 0x20, },
+  { 0xb1, 0xde, 0xc9, 0xf5, 0xdb, 0xf3, 0x2f, 0x4c, 0xd6, 0x41, 0x7d, 0x39,
+    0x18, 0x3e, 0xc7, 0xc3, },
+  { 0xc5, 0x89, 0xb2, 0xf8, 0xb8, 0xc0, 0xa3, 0xb9, 0x3b, 0x10, 0x6d, 0x7c,
+    0x92, 0xfc, 0x7f, 0x34, 0x41, },
+  { 0xc4, 0xd8, 0xef, 0xba, 0xef, 0xd2, 0xaa, 0xc5, 0x6c, 0x8e, 0x3e, 0xbb,
+    0x12, 0xfc, 0x0f, 0x72, 0xbf, 0x0f, },
+  { 0xdd, 0x91, 0xd1, 0x15, 0x9e, 0x7d, 0xf8, 0xc1, 0xb9, 0x14, 0x63, 0x96,
+    0xb5, 0xcb, 0x83, 0x1d, 0x35, 0x1c, 0xec, },
+  { 0xa9, 0xf8, 0x52, 0xc9, 0x67, 0x76, 0x2b, 0xad, 0xfb, 0xd8, 0x3a, 0xa6,
+    0x74, 0x02, 0xae, 0xb8, 0x25, 0x2c, 0x63, 0x49, },
+  { 0x77, 0x1f, 0x66, 0x70, 0xfd, 0x50, 0x29, 0xaa, 0xeb, 0xdc, 0xee, 0xba,
+    0x75, 0x98, 0xdc, 0x93, 0x12, 0x3f, 0xdc, 0x7c, 0x38, },
+  { 0xe2, 0xe1, 0x89, 0x5c, 0x37, 0x38, 0x6a, 0xa3, 0x40, 0xac, 0x3f, 0xb0,
+    0xca, 0xfc, 0xa7, 0xf3, 0xea, 0xf9, 0x0f, 0x5d, 0x8e, 0x39, },
+  { 0x0f, 0x67, 0xc8, 0x38, 0x01, 0xb1, 0xb7, 0xb8, 0xa2, 0xe7, 0x0a, 0x6d,
+    0xd2, 0x63, 0x69, 0x9e, 0xcc, 0xf0, 0xf2, 0xbe, 0x9b, 0x98, 0xdd, },
+  { 0x13, 0xe1, 0x36, 0x30, 0xfe, 0xc6, 0x01, 0x8a, 0xa1, 0x63, 0x96, 0x59,
+    0xc2, 0xa9, 0x68, 0x3f, 0x58, 0xd4, 0x19, 0x0c, 0x40, 0xf3, 0xde, 0x02, },
+  { 0xa3, 0x9e, 0xce, 0xda, 0x42, 0xee, 0x8c, 0x6c, 0x5a, 0x7d, 0xdc, 0x89,
+    0x02, 0x77, 0xdd, 0xe7, 0x95, 0xbb, 0xff, 0x0d, 0xa4, 0xb5, 0x38, 0x1e,
+    0xaf, },
+  { 0x9a, 0xf6, 0xb5, 0x9a, 0x4f, 0xa9, 0x4f, 0x2c, 0x35, 0x3c, 0x24, 0xdc,
+    0x97, 0x6f, 0xd9, 0xa1, 0x7d, 0x1a, 0x85, 0x0b, 0xf5, 0xda, 0x2e, 0xe7,
+    0xb1, 0x1d, },
+  { 0x84, 0x1e, 0x8e, 0x3d, 0x45, 0xa5, 0xf2, 0x27, 0xf3, 0x31, 0xfe, 0xb9,
+    0xfb, 0xc5, 0x45, 0x99, 0x99, 0xdd, 0x93, 0x43, 0x02, 0xee, 0x58, 0xaf,
+    0xee, 0x6a, 0xbe, },
+  { 0x07, 0x2f, 0xc0, 0xa2, 0x04, 0xc4, 0xab, 0x7c, 0x26, 0xbb, 0xa8, 0xd8,
+    0xe3, 0x1c, 0x75, 0x15, 0x64, 0x5d, 0x02, 0x6a, 0xf0, 0x86, 0xe9, 0xcd,
+    0x5c, 0xef, 0xa3, 0x25, },
+  { 0x2f, 0x3b, 0x1f, 0xb5, 0x91, 0x8f, 0x86, 0xe0, 0xdc, 0x31, 0x48, 0xb6,
+    0xa1, 0x8c, 0xfd, 0x75, 0xbb, 0x7d, 0x3d, 0xc1, 0xf0, 0x10, 0x9a, 0xd8,
+    0x4b, 0x0e, 0xe3, 0x94, 0x9f, },
+  { 0x29, 0xbb, 0x8f, 0x6c, 0xd1, 0xf2, 0xb6, 0xaf, 0xe5, 0xe3, 0x2d, 0xdc,
+    0x6f, 0xa4, 0x53, 0x88, 0xd8, 0xcf, 0x4d, 0x45, 0x42, 0x62, 0xdb, 0xdf,
+    0xf8, 0x45, 0xc2, 0x13, 0xec, 0x35, },
+  { 0x06, 0x3c, 0xe3, 0x2c, 0x15, 0xc6, 0x43, 0x03, 0x81, 0xfb, 0x08, 0x76,
+    0x33, 0xcb, 0x02, 0xc1, 0xba, 0x33, 0xe5, 0xe0, 0xd1, 0x92, 0xa8, 0x46,
+    0x28, 0x3f, 0x3e, 0x9d, 0x2c, 0x44, 0x54, },
+  { 0xea, 0xbb, 0x96, 0xf8, 0xd1, 0x8b, 0x04, 0x11, 0x40, 0x78, 0x42, 0x02,
+    0x19, 0xd1, 0xbc, 0x65, 0x92, 0xd3, 0xc3, 0xd6, 0xd9, 0x19, 0xe7, 0xc3,
+    0x40, 0x97, 0xbd, 0xd4, 0xed, 0xfa, 0x5e, 0x28, },
+  { 0x02, },
+  { 0x52, 0xa8, },
+  { 0x38, 0x25, 0x0d, },
+  { 0xe3, 0x04, 0xd4, 0x92, },
+  { 0x97, 0xdb, 0xf7, 0x81, 0xca, },
+  { 0x8a, 0x56, 0x9d, 0x62, 0x56, 0xcc, },
+  { 0xa1, 0x8e, 0x3c, 0x72, 0x8f, 0x63, 0x03, },
+  { 0xf7, 0xf3, 0x39, 0x09, 0x0a, 0xa1, 0xbb, 0x23, },
+  { 0x6b, 0x03, 0xc0, 0xe9, 0xd9, 0x83, 0x05, 0x22, 0x01, },
+  { 0x1b, 0x4b, 0xf5, 0xd6, 0x4f, 0x05, 0x75, 0x91, 0x4c, 0x7f, },
+  { 0x4c, 0x8c, 0x25, 0x20, 0x21, 0xcb, 0xc2, 0x4b, 0x3a, 0x5b, 0x8d, },
+  { 0x56, 0xe2, 0x77, 0xa0, 0xb6, 0x9f, 0x81, 0xec, 0x83, 0x75, 0xc4, 0xf9, },
+  { 0x71, 0x70, 0x0f, 0xad, 0x4d, 0x35, 0x81, 0x9d, 0x88, 0x69, 0xf9, 0xaa,
+    0xd3, },
+  { 0x50, 0x6e, 0x86, 0x6e, 0x43, 0xc0, 0xc2, 0x44, 0xc2, 0xe2, 0xa0, 0x1c,
+    0xb7, 0x9a, },
+  { 0xe4, 0x7e, 0x72, 0xc6, 0x12, 0x8e, 0x7c, 0xfc, 0xbd, 0xe2, 0x08, 0x31,
+    0x3d, 0x47, 0x3d, },
+  { 0x08, 0x97, 0x5b, 0x80, 0xae, 0xc4, 0x1d, 0x50, 0x77, 0xdf, 0x1f, 0xd0,
+    0x24, 0xf0, 0x17, 0xc0, },
+  { 0x01, 0xb6, 0x29, 0xf4, 0xaf, 0x78, 0x5f, 0xb6, 0x91, 0xdd, 0x76, 0x76,
+    0xd2, 0xfd, 0x0c, 0x47, 0x40, },
+  { 0xa1, 0xd8, 0x09, 0x97, 0x7a, 0xa6, 0xc8, 0x94, 0xf6, 0x91, 0x7b, 0xae,
+    0x2b, 0x9f, 0x0d, 0x83, 0x48, 0xf7, },
+  { 0x12, 0xd5, 0x53, 0x7d, 0x9a, 0xb0, 0xbe, 0xd9, 0xed, 0xe9, 0x9e, 0xee,
+    0x61, 0x5b, 0x42, 0xf2, 0xc0, 0x73, 0xc0, },
+  { 0xd5, 0x77, 0xd6, 0x5c, 0x6e, 0xa5, 0x69, 0x2b, 0x3b, 0x8c, 0xd6, 0x7d,
+    0x1d, 0xbe, 0x2c, 0xa1, 0x02, 0x21, 0xcd, 0x29, },
+  { 0xa4, 0x98, 0x80, 0xca, 0x22, 0xcf, 0x6a, 0xab, 0x5e, 0x40, 0x0d, 0x61,
+    0x08, 0x21, 0xef, 0xc0, 0x6c, 0x52, 0xb4, 0xb0, 0x53, },
+  { 0xbf, 0xaf, 0x8f, 0x3b, 0x7a, 0x97, 0x33, 0xe5, 0xca, 0x07, 0x37, 0xfd,
+    0x15, 0xdf, 0xce, 0x26, 0x2a, 0xb1, 0xa7, 0x0b, 0xb3, 0xac, },
+  { 0x16, 0x22, 0xe1, 0xbc, 0x99, 0x4e, 0x01, 0xf0, 0xfa, 0xff, 0x8f, 0xa5,
+    0x0c, 0x61, 0xb0, 0xad, 0xcc, 0xb1, 0xe1, 0x21, 0x46, 0xfa, 0x2e, },
+  { 0x11, 0x5b, 0x0b, 0x2b, 0xe6, 0x14, 0xc1, 0xd5, 0x4d, 0x71, 0x5e, 0x17,
+    0xea, 0x23, 0xdd, 0x6c, 0xbd, 0x1d, 0xbe, 0x12, 0x1b, 0xee, 0x4c, 0x1a, },
+  { 0x40, 0x88, 0x22, 0xf3, 0x20, 0x6c, 0xed, 0xe1, 0x36, 0x34, 0x62, 0x2c,
+    0x98, 0x83, 0x52, 0xe2, 0x25, 0xee, 0xe9, 0xf5, 0xe1, 0x17, 0xf0, 0x5c,
+    0xae, },
+  { 0xc3, 0x76, 0x37, 0xde, 0x95, 0x8c, 0xca, 0x2b, 0x0c, 0x23, 0xe7, 0xb5,
+    0x38, 0x70, 0x61, 0xcc, 0xff, 0xd3, 0x95, 0x7b, 0xf3, 0xff, 0x1f, 0x9d,
+    0x59, 0x00, },
+  { 0x0c, 0x19, 0x52, 0x05, 0x22, 0x53, 0xcb, 0x48, 0xd7, 0x10, 0x0e, 0x7e,
+    0x14, 0x69, 0xb5, 0xa2, 0x92, 0x43, 0xa3, 0x9e, 0x4b, 0x8f, 0x51, 0x2c,
+    0x5a, 0x2c, 0x3b, },
+  { 0xe1, 0x9d, 0x70, 0x70, 0x28, 0xec, 0x86, 0x40, 0x55, 0x33, 0x56, 0xda,
+    0x88, 0xca, 0xee, 0xc8, 0x6a, 0x20, 0xb1, 0xe5, 0x3d, 0x57, 0xf8, 0x3c,
+    0x10, 0x07, 0x2a, 0xc4, },
+  { 0x0b, 0xae, 0xf1, 0xc4, 0x79, 0xee, 0x1b, 0x3d, 0x27, 0x35, 0x8d, 0x14,
+    0xd6, 0xae, 0x4e, 0x3c, 0xe9, 0x53, 0x50, 0xb5, 0xcc, 0x0c, 0xf7, 0xdf,
+    0xee, 0xa1, 0x74, 0xd6, 0x71, },
+  { 0xe6, 0xa4, 0xf4, 0x99, 0x98, 0xb9, 0x80, 0xea, 0x96, 0x7f, 0x4f, 0x33,
+    0xcf, 0x74, 0x25, 0x6f, 0x17, 0x6c, 0xbf, 0xf5, 0x5c, 0x38, 0xd0, 0xff,
+    0x96, 0xcb, 0x13, 0xf9, 0xdf, 0xfd, },
+  { 0xbe, 0x92, 0xeb, 0xba, 0x44, 0x2c, 0x24, 0x74, 0xd4, 0x03, 0x27, 0x3c,
+    0x5d, 0x5b, 0x03, 0x30, 0x87, 0x63, 0x69, 0xe0, 0xb8, 0x94, 0xf4, 0x44,
+    0x7e, 0xad, 0xcd, 0x20, 0x12, 0x16, 0x79, },
+  { 0x30, 0xf1, 0xc4, 0x8e, 0x05, 0x90, 0x2a, 0x97, 0x63, 0x94, 0x46, 0xff,
+    0xce, 0xd8, 0x67, 0xa7, 0xac, 0x33, 0x8c, 0x95, 0xb7, 0xcd, 0xa3, 0x23,
+    0x98, 0x9d, 0x76, 0x6c, 0x9d, 0xa8, 0xd6, 0x8a, },
+  { 0xbe, },
+  { 0x17, 0x6c, },
+  { 0x1a, 0x42, 0x4f, },
+  { 0xba, 0xaf, 0xb7, 0x65, },
+  { 0xc2, 0x63, 0x43, 0x6a, 0xea, },
+  { 0xe4, 0x4d, 0xad, 0xf2, 0x0b, 0x02, },
+  { 0x04, 0xc7, 0xc4, 0x7f, 0xa9, 0x2b, 0xce, },
+  { 0x66, 0xf6, 0x67, 0xcb, 0x03, 0x53, 0xc8, 0xf1, },
+  { 0x56, 0xa3, 0x60, 0x78, 0xc9, 0x5f, 0x70, 0x1b, 0x5e, },
+  { 0x99, 0xff, 0x81, 0x7c, 0x13, 0x3c, 0x29, 0x79, 0x4b, 0x65, },
+  { 0x51, 0x10, 0x50, 0x93, 0x01, 0x93, 0xb7, 0x01, 0xc9, 0x18, 0xb7, },
+  { 0x8e, 0x3c, 0x42, 0x1e, 0x5e, 0x7d, 0xc1, 0x50, 0x70, 0x1f, 0x00, 0x98, },
+  { 0x5f, 0xd9, 0x9b, 0xc8, 0xd7, 0xb2, 0x72, 0x62, 0x1a, 0x1e, 0xba, 0x92,
+    0xe9, },
+  { 0x70, 0x2b, 0xba, 0xfe, 0xad, 0x5d, 0x96, 0x3f, 0x27, 0xc2, 0x41, 0x6d,
+    0xc4, 0xb3, },
+  { 0xae, 0xe0, 0xd5, 0xd4, 0xc7, 0xae, 0x15, 0x5e, 0xdc, 0xdd, 0x33, 0x60,
+    0xd7, 0xd3, 0x5e, },
+  { 0x79, 0x8e, 0xbc, 0x9e, 0x20, 0xb9, 0x19, 0x4b, 0x63, 0x80, 0xf3, 0x16,
+    0xaf, 0x39, 0xbd, 0x92, },
+  { 0xc2, 0x0e, 0x85, 0xa0, 0x0b, 0x9a, 0xb0, 0xec, 0xde, 0x38, 0xd3, 0x10,
+    0xd9, 0xa7, 0x66, 0x27, 0xcf, },
+  { 0x0e, 0x3b, 0x75, 0x80, 0x67, 0x14, 0x0c, 0x02, 0x90, 0xd6, 0xb3, 0x02,
+    0x81, 0xf6, 0xa6, 0x87, 0xce, 0x58, },
+  { 0x79, 0xb5, 0xe9, 0x5d, 0x52, 0x4d, 0xf7, 0x59, 0xf4, 0x2e, 0x27, 0xdd,
+    0xb3, 0xed, 0x57, 0x5b, 0x82, 0xea, 0x6f, },
+  { 0xa2, 0x97, 0xf5, 0x80, 0x02, 0x3d, 0xde, 0xa3, 0xf9, 0xf6, 0xab, 0xe3,
+    0x57, 0x63, 0x7b, 0x9b, 0x10, 0x42, 0x6f, 0xf2, },
+  { 0x12, 0x7a, 0xfc, 0xb7, 0x67, 0x06, 0x0c, 0x78, 0x1a, 0xfe, 0x88, 0x4f,
+    0xc6, 0xac, 0x52, 0x96, 0x64, 0x28, 0x97, 0x84, 0x06, },
+  { 0xc5, 0x04, 0x44, 0x6b, 0xb2, 0xa5, 0xa4, 0x66, 0xe1, 0x76, 0xa2, 0x51,
+    0xf9, 0x59, 0x69, 0x97, 0x56, 0x0b, 0xbf, 0x50, 0xb3, 0x34, },
+  { 0x21, 0x32, 0x6b, 0x42, 0xb5, 0xed, 0x71, 0x8d, 0xf7, 0x5a, 0x35, 0xe3,
+    0x90, 0xe2, 0xee, 0xaa, 0x89, 0xf6, 0xc9, 0x9c, 0x4d, 0x73, 0xf4, },
+  { 0x4c, 0xa6, 0x09, 0xf4, 0x48, 0xe7, 0x46, 0xbc, 0x49, 0xfc, 0xe5, 0xda,
+    0xd1, 0x87, 0x13, 0x17, 0x4c, 0x59, 0x71, 0x26, 0x5b, 0x2c, 0x42, 0xb7, },
+  { 0x13, 0x63, 0xf3, 0x40, 0x02, 0xe5, 0xa3, 0x3a, 0x5e, 0x8e, 0xf8, 0xb6,
+    0x8a, 0x49, 0x60, 0x76, 0x34, 0x72, 0x94, 0x73, 0xf6, 0xd9, 0x21, 0x6a,
+    0x26, },
+  { 0xdf, 0x75, 0x16, 0x10, 0x1b, 0x5e, 0x81, 0xc3, 0xc8, 0xde, 0x34, 0x24,
+    0xb0, 0x98, 0xeb, 0x1b, 0x8f, 0xa1, 0x9b, 0x05, 0xee, 0xa5, 0xe9, 0x35,
+    0xf4, 0x1d, },
+  { 0xcd, 0x21, 0x93, 0x6e, 0x5b, 0xa0, 0x26, 0x2b, 0x21, 0x0e, 0xa0, 0xb9,
+    0x1c, 0xb5, 0xbb, 0xb8, 0xf8, 0x1e, 0xff, 0x5c, 0xa8, 0xf9, 0x39, 0x46,
+    0x4e, 0x29, 0x26, },
+  { 0x73, 0x7f, 0x0e, 0x3b, 0x0b, 0x5c, 0xf9, 0x60, 0xaa, 0x88, 0xa1, 0x09,
+    0xb1, 0x5d, 0x38, 0x7b, 0x86, 0x8f, 0x13, 0x7a, 0x8d, 0x72, 0x7a, 0x98,
+    0x1a, 0x5b, 0xff, 0xc9, },
+  { 0xd3, 0x3c, 0x61, 0x71, 0x44, 0x7e, 0x31, 0x74, 0x98, 0x9d, 0x9a, 0xd2,
+    0x27, 0xf3, 0x46, 0x43, 0x42, 0x51, 0xd0, 0x5f, 0xe9, 0x1c, 0x5c, 0x69,
+    0xbf, 0xf6, 0xbe, 0x3c, 0x40, },
+  { 0x31, 0x99, 0x31, 0x9f, 0xaa, 0x43, 0x2e, 0x77, 0x3e, 0x74, 0x26, 0x31,
+    0x5e, 0x61, 0xf1, 0x87, 0xe2, 0xeb, 0x9b, 0xcd, 0xd0, 0x3a, 0xee, 0x20,
+    0x7e, 0x10, 0x0a, 0x0b, 0x7e, 0xfa, },
+  { 0xa4, 0x27, 0x80, 0x67, 0x81, 0x2a, 0xa7, 0x62, 0xf7, 0x6e, 0xda, 0xd4,
+    0x5c, 0x39, 0x74, 0xad, 0x7e, 0xbe, 0xad, 0xa5, 0x84, 0x7f, 0xa9, 0x30,
+    0x5d, 0xdb, 0xe2, 0x05, 0x43, 0xf7, 0x1b, },
+  { 0x0b, 0x37, 0xd8, 0x02, 0xe1, 0x83, 0xd6, 0x80, 0xf2, 0x35, 0xc2, 0xb0,
+    0x37, 0xef, 0xef, 0x5e, 0x43, 0x93, 0xf0, 0x49, 0x45, 0x0a, 0xef, 0xb5,
+    0x76, 0x70, 0x12, 0x44, 0xc4, 0xdb, 0xf5, 0x7a, },
+  { 0x1f, },
+  { 0x82, 0x60, },
+  { 0xcc, 0xe3, 0x08, },
+  { 0x56, 0x17, 0xe4, 0x59, },
+  { 0xe2, 0xd7, 0x9e, 0xc4, 0x4c, },
+  { 0xb2, 0xad, 0xd3, 0x78, 0x58, 0x5a, },
+  { 0xce, 0x43, 0xb4, 0x02, 0x96, 0xab, 0x3c, },
+  { 0xe6, 0x05, 0x1a, 0x73, 0x22, 0x32, 0xbb, 0x77, },
+  { 0x23, 0xe7, 0xda, 0xfe, 0x2c, 0xef, 0x8c, 0x22, 0xec, },
+  { 0xe9, 0x8e, 0x55, 0x38, 0xd1, 0xd7, 0x35, 0x23, 0x98, 0xc7, },
+  { 0xb5, 0x81, 0x1a, 0xe5, 0xb5, 0xa5, 0xd9, 0x4d, 0xca, 0x41, 0xe7, },
+  { 0x41, 0x16, 0x16, 0x95, 0x8d, 0x9e, 0x0c, 0xea, 0x8c, 0x71, 0x9a, 0xc1, },
+  { 0x7c, 0x33, 0xc0, 0xa4, 0x00, 0x62, 0xea, 0x60, 0x67, 0xe4, 0x20, 0xbc,
+    0x5b, },
+  { 0xdb, 0xb1, 0xdc, 0xfd, 0x08, 0xc0, 0xde, 0x82, 0xd1, 0xde, 0x38, 0xc0,
+    0x90, 0x48, },
+  { 0x37, 0x18, 0x2e, 0x0d, 0x61, 0xaa, 0x61, 0xd7, 0x86, 0x20, 0x16, 0x60,
+    0x04, 0xd9, 0xd5, },
+  { 0xb0, 0xcf, 0x2c, 0x4c, 0x5e, 0x5b, 0x4f, 0x2a, 0x23, 0x25, 0x58, 0x47,
+    0xe5, 0x31, 0x06, 0x70, },
+  { 0x91, 0xa0, 0xa3, 0x86, 0x4e, 0xe0, 0x72, 0x38, 0x06, 0x67, 0x59, 0x5c,
+    0x70, 0x25, 0xdb, 0x33, 0x27, },
+  { 0x44, 0x58, 0x66, 0xb8, 0x58, 0xc7, 0x13, 0xed, 0x4c, 0xc0, 0xf4, 0x9a,
+    0x1e, 0x67, 0x75, 0x33, 0xb6, 0xb8, },
+  { 0x7f, 0x98, 0x4a, 0x8e, 0x50, 0xa2, 0x5c, 0xcd, 0x59, 0xde, 0x72, 0xb3,
+    0x9d, 0xc3, 0x09, 0x8a, 0xab, 0x56, 0xf1, },
+  { 0x80, 0x96, 0x49, 0x1a, 0x59, 0xa2, 0xc5, 0xd5, 0xa7, 0x20, 0x8a, 0xb7,
+    0x27, 0x62, 0x84, 0x43, 0xc6, 0xe1, 0x1b, 0x5d, },
+  { 0x6b, 0xb7, 0x2b, 0x26, 0x62, 0x14, 0x70, 0x19, 0x3d, 0x4d, 0xac, 0xac,
+    0x63, 0x58, 0x5e, 0x94, 0xb5, 0xb7, 0xe8, 0xe8, 0xa2, },
+  { 0x20, 0xa8, 0xc0, 0xfd, 0x63, 0x3d, 0x6e, 0x98, 0xcf, 0x0c, 0x49, 0x98,
+    0xe4, 0x5a, 0xfe, 0x8c, 0xaa, 0x70, 0x82, 0x1c, 0x7b, 0x74, },
+  { 0xc8, 0xe8, 0xdd, 0xdf, 0x69, 0x30, 0x01, 0xc2, 0x0f, 0x7e, 0x2f, 0x11,
+    0xcc, 0x3e, 0x17, 0xa5, 0x69, 0x40, 0x3f, 0x0e, 0x79, 0x7f, 0xcf, },
+  { 0xdb, 0x61, 0xc0, 0xe2, 0x2e, 0x49, 0x07, 0x31, 0x1d, 0x91, 0x42, 0x8a,
+    0xfc, 0x5e, 0xd3, 0xf8, 0x56, 0x1f, 0x2b, 0x73, 0xfd, 0x9f, 0xb2, 0x8e, },
+  { 0x0c, 0x89, 0x55, 0x0c, 0x1f, 0x59, 0x2c, 0x9d, 0x1b, 0x29, 0x1d, 0x41,
+    0x1d, 0xe6, 0x47, 0x8f, 0x8c, 0x2b, 0xea, 0x8f, 0xf0, 0xff, 0x21, 0x70,
+    0x88, },
+  { 0x12, 0x18, 0x95, 0xa6, 0x59, 0xb1, 0x31, 0x24, 0x45, 0x67, 0x55, 0xa4,
+    0x1a, 0x2d, 0x48, 0x67, 0x1b, 0x43, 0x88, 0x2d, 0x8e, 0xa0, 0x70, 0xb3,
+    0xc6, 0xbb, },
+  { 0xe7, 0xb1, 0x1d, 0xb2, 0x76, 0x4d, 0x68, 0x68, 0x68, 0x23, 0x02, 0x55,
+    0x3a, 0xe2, 0xe5, 0xd5, 0x4b, 0x43, 0xf9, 0x34, 0x77, 0x5c, 0xa1, 0xf5,
+    0x55, 0xfd, 0x4f, },
+  { 0x8c, 0x87, 0x5a, 0x08, 0x3a, 0x73, 0xad, 0x61, 0xe1, 0xe7, 0x99, 0x7e,
+    0xf0, 0x5d, 0xe9, 0x5d, 0x16, 0x43, 0x80, 0x2f, 0xd0, 0x66, 0x34, 0xe2,
+    0x42, 0x64, 0x3b, 0x1a, },
+  { 0x39, 0xc1, 0x99, 0xcf, 0x22, 0xbf, 0x16, 0x8f, 0x9f, 0x80, 0x7f, 0x95,
+    0x0a, 0x05, 0x67, 0x27, 0xe7, 0x15, 0xdf, 0x9d, 0xb2, 0xfe, 0x1c, 0xb5,
+    0x1d, 0x60, 0x8f, 0x8a, 0x1d, },
+  { 0x9b, 0x6e, 0x08, 0x09, 0x06, 0x73, 0xab, 0x68, 0x02, 0x62, 0x1a, 0xe4,
+    0xd4, 0xdf, 0xc7, 0x02, 0x4c, 0x6a, 0x5f, 0xfd, 0x23, 0xac, 0xae, 0x6d,
+    0x43, 0xa4, 0x7a, 0x50, 0x60, 0x3c, },
+  { 0x1d, 0xb4, 0xc6, 0xe1, 0xb1, 0x4b, 0xe3, 0xf2, 0xe2, 0x1a, 0x73, 0x1b,
+    0xa0, 0x92, 0xa7, 0xf5, 0xff, 0x8f, 0x8b, 0x5d, 0xdf, 0xa8, 0x04, 0xb3,
+    0xb0, 0xf7, 0xcc, 0x12, 0xfa, 0x35, 0x46, },
+  { 0x49, 0x45, 0x97, 0x11, 0x0f, 0x1c, 0x60, 0x8e, 0xe8, 0x47, 0x30, 0xcf,
+    0x60, 0xa8, 0x71, 0xc5, 0x1b, 0xe9, 0x39, 0x4d, 0x49, 0xb6, 0x12, 0x1f,
+    0x24, 0xab, 0x37, 0xff, 0x83, 0xc2, 0xe1, 0x3a, },
+  { 0x60, },
+  { 0x24, 0x26, },
+  { 0x47, 0xeb, 0xc9, },
+  { 0x4a, 0xd0, 0xbc, 0xf0, },
+  { 0x8e, 0x2b, 0xc9, 0x85, 0x3c, },
+  { 0xa2, 0x07, 0x15, 0xb8, 0x12, 0x74, },
+  { 0x0f, 0xdb, 0x5b, 0x33, 0x69, 0xfe, 0x4b, },
+  { 0xa2, 0x86, 0x54, 0xf4, 0xfd, 0xb2, 0xd4, 0xe6, },
+  { 0xbb, 0x84, 0x78, 0x49, 0x27, 0x8e, 0x61, 0xda, 0x60, },
+  { 0x04, 0xc3, 0xcd, 0xaa, 0x8f, 0xa7, 0x03, 0xc9, 0xf9, 0xb6, },
+  { 0xf8, 0x27, 0x1d, 0x61, 0xdc, 0x21, 0x42, 0xdd, 0xad, 0x92, 0x40, },
+  { 0x12, 0x87, 0xdf, 0xc2, 0x41, 0x45, 0x5a, 0x36, 0x48, 0x5b, 0x51, 0x2b, },
+  { 0xbb, 0x37, 0x5d, 0x1f, 0xf1, 0x68, 0x7a, 0xc4, 0xa5, 0xd2, 0xa4, 0x91,
+    0x8d, },
+  { 0x5b, 0x27, 0xd1, 0x04, 0x54, 0x52, 0x9f, 0xa3, 0x47, 0x86, 0x33, 0x33,
+    0xbf, 0xa0, },
+  { 0xcf, 0x04, 0xea, 0xf8, 0x03, 0x2a, 0x43, 0xff, 0xa6, 0x68, 0x21, 0x4c,
+    0xd5, 0x4b, 0xed, },
+  { 0xaf, 0xb8, 0xbc, 0x63, 0x0f, 0x18, 0x4d, 0xe2, 0x7a, 0xdd, 0x46, 0x44,
+    0xc8, 0x24, 0x0a, 0xb7, },
+  { 0x3e, 0xdc, 0x36, 0xe4, 0x89, 0xb1, 0xfa, 0xc6, 0x40, 0x93, 0x2e, 0x75,
+    0xb2, 0x15, 0xd1, 0xb1, 0x10, },
+  { 0x6c, 0xd8, 0x20, 0x3b, 0x82, 0x79, 0xf9, 0xc8, 0xbc, 0x9d, 0xe0, 0x35,
+    0xbe, 0x1b, 0x49, 0x1a, 0xbc, 0x3a, },
+  { 0x78, 0x65, 0x2c, 0xbe, 0x35, 0x67, 0xdc, 0x78, 0xd4, 0x41, 0xf6, 0xc9,
+    0xde, 0xde, 0x1f, 0x18, 0x13, 0x31, 0x11, },
+  { 0x8a, 0x7f, 0xb1, 0x33, 0x8f, 0x0c, 0x3c, 0x0a, 0x06, 0x61, 0xf0, 0x47,
+    0x29, 0x1b, 0x29, 0xbc, 0x1c, 0x47, 0xef, 0x7a, },
+  { 0x65, 0x91, 0xf1, 0xe6, 0xb3, 0x96, 0xd3, 0x8c, 0xc2, 0x4a, 0x59, 0x35,
+    0x72, 0x8e, 0x0b, 0x9a, 0x87, 0xca, 0x34, 0x7b, 0x63, },
+  { 0x5f, 0x08, 0x87, 0x80, 0x56, 0x25, 0x89, 0x77, 0x61, 0x8c, 0x64, 0xa1,
+    0x59, 0x6d, 0x59, 0x62, 0xe8, 0x4a, 0xc8, 0x58, 0x99, 0xd1, },
+  { 0x23, 0x87, 0x1d, 0xed, 0x6f, 0xf2, 0x91, 0x90, 0xe2, 0xfe, 0x43, 0x21,
+    0xaf, 0x97, 0xc6, 0xbc, 0xd7, 0x15, 0xc7, 0x2d, 0x08, 0x77, 0x91, },
+  { 0x90, 0x47, 0x9a, 0x9e, 0x3a, 0xdf, 0xf3, 0xc9, 0x4c, 0x1e, 0xa7, 0xd4,
+    0x6a, 0x32, 0x90, 0xfe, 0xb7, 0xb6, 0x7b, 0xfa, 0x96, 0x61, 0xfb, 0xa4, },
+  { 0xb1, 0x67, 0x60, 0x45, 0xb0, 0x96, 0xc5, 0x15, 0x9f, 0x4d, 0x26, 0xd7,
+    0x9d, 0xf1, 0xf5, 0x6d, 0x21, 0x00, 0x94, 0x31, 0x64, 0x94, 0xd3, 0xa7,
+    0xd3, },
+  { 0x02, 0x3e, 0xaf, 0xf3, 0x79, 0x73, 0xa5, 0xf5, 0xcc, 0x7a, 0x7f, 0xfb,
+    0x79, 0x2b, 0x85, 0x8c, 0x88, 0x72, 0x06, 0xbe, 0xfe, 0xaf, 0xc1, 0x16,
+    0xa6, 0xd6, },
+  { 0x2a, 0xb0, 0x1a, 0xe5, 0xaa, 0x6e, 0xb3, 0xae, 0x53, 0x85, 0x33, 0x80,
+    0x75, 0xae, 0x30, 0xe6, 0xb8, 0x72, 0x42, 0xf6, 0x25, 0x4f, 0x38, 0x88,
+    0x55, 0xd1, 0xa9, },
+  { 0x90, 0xd8, 0x0c, 0xc0, 0x93, 0x4b, 0x4f, 0x9e, 0x65, 0x6c, 0xa1, 0x54,
+    0xa6, 0xf6, 0x6e, 0xca, 0xd2, 0xbb, 0x7e, 0x6a, 0x1c, 0xd3, 0xce, 0x46,
+    0xef, 0xb0, 0x00, 0x8d, },
+  { 0xed, 0x9c, 0x49, 0xcd, 0xc2, 0xde, 0x38, 0x0e, 0xe9, 0x98, 0x6c, 0xc8,
+    0x90, 0x9e, 0x3c, 0xd4, 0xd3, 0xeb, 0x88, 0x32, 0xc7, 0x28, 0xe3, 0x94,
+    0x1c, 0x9f, 0x8b, 0xf3, 0xcb, },
+  { 0xac, 0xe7, 0x92, 0x16, 0xb4, 0x14, 0xa0, 0xe4, 0x04, 0x79, 0xa2, 0xf4,
+    0x31, 0xe6, 0x0c, 0x26, 0xdc, 0xbf, 0x2f, 0x69, 0x1b, 0x55, 0x94, 0x67,
+    0xda, 0x0c, 0xd7, 0x32, 0x1f, 0xef, },
+  { 0x68, 0x63, 0x85, 0x57, 0x95, 0x9e, 0x42, 0x27, 0x41, 0x43, 0x42, 0x02,
+    0xa5, 0x78, 0xa7, 0xc6, 0x43, 0xc1, 0x6a, 0xba, 0x70, 0x80, 0xcd, 0x04,
+    0xb6, 0x78, 0x76, 0x29, 0xf3, 0xe8, 0xa0, },
+  { 0xe6, 0xac, 0x8d, 0x9d, 0xf0, 0xc0, 0xf7, 0xf7, 0xe3, 0x3e, 0x4e, 0x28,
+    0x0f, 0x59, 0xb2, 0x67, 0x9e, 0x84, 0x34, 0x42, 0x96, 0x30, 0x2b, 0xca,
+    0x49, 0xb6, 0xc5, 0x9a, 0x84, 0x59, 0xa7, 0x81, },
+  { 0x7e, },
+  { 0x1e, 0x21, },
+  { 0x26, 0xd3, 0xdd, },
+  { 0x2c, 0xd4, 0xb3, 0x3d, },
+  { 0x86, 0x7b, 0x76, 0x3c, 0xf0, },
+  { 0x12, 0xc3, 0x70, 0x1d, 0x55, 0x18, },
+  { 0x96, 0xc2, 0xbd, 0x61, 0x55, 0xf4, 0x24, },
+  { 0x20, 0x51, 0xf7, 0x86, 0x58, 0x8f, 0x07, 0x2a, },
+  { 0x93, 0x15, 0xa8, 0x1d, 0xda, 0x97, 0xee, 0x0e, 0x6c, },
+  { 0x39, 0x93, 0xdf, 0xd5, 0x0e, 0xca, 0xdc, 0x7a, 0x92, 0xce, },
+  { 0x60, 0xd5, 0xfd, 0xf5, 0x1b, 0x26, 0x82, 0x26, 0x73, 0x02, 0xbc, },
+  { 0x98, 0xf2, 0x34, 0xe1, 0xf5, 0xfb, 0x00, 0xac, 0x10, 0x4a, 0x38, 0x9f, },
+  { 0xda, 0x3a, 0x92, 0x8a, 0xd0, 0xcd, 0x12, 0xcd, 0x15, 0xbb, 0xab, 0x77,
+    0x66, },
+  { 0xa2, 0x92, 0x1a, 0xe5, 0xca, 0x0c, 0x30, 0x75, 0xeb, 0xaf, 0x00, 0x31,
+    0x55, 0x66, },
+  { 0x06, 0xea, 0xfd, 0x3e, 0x86, 0x38, 0x62, 0x4e, 0xa9, 0x12, 0xa4, 0x12,
+    0x43, 0xbf, 0xa1, },
+  { 0xe4, 0x71, 0x7b, 0x94, 0xdb, 0xa0, 0xd2, 0xff, 0x9b, 0xeb, 0xad, 0x8e,
+    0x95, 0x8a, 0xc5, 0xed, },
+  { 0x25, 0x5a, 0x77, 0x71, 0x41, 0x0e, 0x7a, 0xe9, 0xed, 0x0c, 0x10, 0xef,
+    0xf6, 0x2b, 0x3a, 0xba, 0x60, },
+  { 0xee, 0xe2, 0xa3, 0x67, 0x64, 0x1d, 0xc6, 0x04, 0xc4, 0xe1, 0x68, 0xd2,
+    0x6e, 0xd2, 0x91, 0x75, 0x53, 0x07, },
+  { 0xe0, 0xf6, 0x4d, 0x8f, 0x68, 0xfc, 0x06, 0x7e, 0x18, 0x79, 0x7f, 0x2b,
+    0x6d, 0xef, 0x46, 0x7f, 0xab, 0xb2, 0xad, },
+  { 0x3d, 0x35, 0x88, 0x9f, 0x2e, 0xcf, 0x96, 0x45, 0x07, 0x60, 0x71, 0x94,
+    0x00, 0x8d, 0xbf, 0xf4, 0xef, 0x46, 0x2e, 0x3c, },
+  { 0x43, 0xcf, 0x98, 0xf7, 0x2d, 0xf4, 0x17, 0xe7, 0x8c, 0x05, 0x2d, 0x9b,
+    0x24, 0xfb, 0x4d, 0xea, 0x4a, 0xec, 0x01, 0x25, 0x29, },
+  { 0x8e, 0x73, 0x9a, 0x78, 0x11, 0xfe, 0x48, 0xa0, 0x3b, 0x1a, 0x26, 0xdf,
+    0x25, 0xe9, 0x59, 0x1c, 0x70, 0x07, 0x9f, 0xdc, 0xa0, 0xa6, },
+  { 0xe8, 0x47, 0x71, 0xc7, 0x3e, 0xdf, 0xb5, 0x13, 0xb9, 0x85, 0x13, 0xa8,
+    0x54, 0x47, 0x6e, 0x59, 0x96, 0x09, 0x13, 0x5f, 0x82, 0x16, 0x0b, },
+  { 0xfb, 0xc0, 0x8c, 0x03, 0x21, 0xb3, 0xc4, 0xb5, 0x43, 0x32, 0x6c, 0xea,
+    0x7f, 0xa8, 0x43, 0x91, 0xe8, 0x4e, 0x3f, 0xbf, 0x45, 0x58, 0x6a, 0xa3, },
+  { 0x55, 0xf8, 0xf3, 0x00, 0x76, 0x09, 0xef, 0x69, 0x5d, 0xd2, 0x8a, 0xf2,
+    0x65, 0xc3, 0xcb, 0x9b, 0x43, 0xfd, 0xb1, 0x7e, 0x7f, 0xa1, 0x94, 0xb0,
+    0xd7, },
+  { 0xaa, 0x13, 0xc1, 0x51, 0x40, 0x6d, 0x8d, 0x4c, 0x0a, 0x95, 0x64, 0x7b,
+    0xd1, 0x96, 0xb6, 0x56, 0xb4, 0x5b, 0xcf, 0xd6, 0xd9, 0x15, 0x97, 0xdd,
+    0xb6, 0xef, },
+  { 0xaf, 0xb7, 0x36, 0xb0, 0x04, 0xdb, 0xd7, 0x9c, 0x9a, 0x44, 0xc4, 0xf6,
+    0x1f, 0x12, 0x21, 0x2d, 0x59, 0x30, 0x54, 0xab, 0x27, 0x61, 0xa3, 0x57,
+    0xef, 0xf8, 0x53, },
+  { 0x97, 0x34, 0x45, 0x3e, 0xce, 0x7c, 0x35, 0xa2, 0xda, 0x9f, 0x4b, 0x46,
+    0x6c, 0x11, 0x67, 0xff, 0x2f, 0x76, 0x58, 0x15, 0x71, 0xfa, 0x44, 0x89,
+    0x89, 0xfd, 0xf7, 0x99, },
+  { 0x1f, 0xb1, 0x62, 0xeb, 0x83, 0xc5, 0x9c, 0x89, 0xf9, 0x2c, 0xd2, 0x03,
+    0x61, 0xbc, 0xbb, 0xa5, 0x74, 0x0e, 0x9b, 0x7e, 0x82, 0x3e, 0x70, 0x0a,
+    0xa9, 0x8f, 0x2b, 0x59, 0xfb, },
+  { 0xf8, 0xca, 0x5e, 0x3a, 0x4f, 0x9e, 0x10, 0x69, 0x10, 0xd5, 0x4c, 0xeb,
+    0x1a, 0x0f, 0x3c, 0x6a, 0x98, 0xf5, 0xb0, 0x97, 0x5b, 0x37, 0x2f, 0x0d,
+    0xbd, 0x42, 0x4b, 0x69, 0xa1, 0x82, },
+  { 0x12, 0x8c, 0x6d, 0x52, 0x08, 0xef, 0x74, 0xb2, 0xe6, 0xaa, 0xd3, 0xb0,
+    0x26, 0xb0, 0xd9, 0x94, 0xb6, 0x11, 0x45, 0x0e, 0x36, 0x71, 0x14, 0x2d,
+    0x41, 0x8c, 0x21, 0x53, 0x31, 0xe9, 0x68, },
+  { 0xee, 0xea, 0x0d, 0x89, 0x47, 0x7e, 0x72, 0xd1, 0xd8, 0xce, 0x58, 0x4c,
+    0x94, 0x1f, 0x0d, 0x51, 0x08, 0xa3, 0xb6, 0x3d, 0xe7, 0x82, 0x46, 0x92,
+    0xd6, 0x98, 0x6b, 0x07, 0x10, 0x65, 0x52, 0x65, },
+};
+
+bool __init blake2s_selftest(void)
+{
+	u8 key[BLAKE2S_KEY_SIZE];
+	u8 buf[ARRAY_SIZE(blake2s_testvecs)];
+	u8 hash[BLAKE2S_HASH_SIZE];
+	struct blake2s_state state;
+	bool success = true;
+	int i, l;
+
+	key[0] = key[1] = 1;
+	for (i = 2; i < sizeof(key); ++i)
+		key[i] = key[i - 2] + key[i - 1];
+
+	for (i = 0; i < sizeof(buf); ++i)
+		buf[i] = (u8)i;
+
+	for (i = l = 0; i < ARRAY_SIZE(blake2s_testvecs); l = (l + 37) % ++i) {
+		int outlen = 1 + i % BLAKE2S_HASH_SIZE;
+		int keylen = (13 * i) % (BLAKE2S_KEY_SIZE + 1);
+
+		blake2s(hash, buf, key + BLAKE2S_KEY_SIZE - keylen, outlen, i,
+			keylen);
+		if (memcmp(hash, blake2s_testvecs[i], outlen)) {
+			pr_err("blake2s self-test %d: FAIL\n", i + 1);
+			success = false;
+		}
+
+		if (!keylen)
+			blake2s_init(&state, outlen);
+		else
+			blake2s_init_key(&state, outlen,
+					 key + BLAKE2S_KEY_SIZE - keylen,
+					 keylen);
+
+		blake2s_update(&state, buf, l);
+		blake2s_update(&state, buf + l, i - l);
+		blake2s_final(&state, hash);
+		if (memcmp(hash, blake2s_testvecs[i], outlen)) {
+			pr_err("blake2s init/update/final self-test %d: FAIL\n",
+			       i + 1);
+			success = false;
+		}
+	}
+
+	return success;
+}
diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
new file mode 100644
index 000000000000..536fce87555b
--- /dev/null
+++ b/lib/crypto/blake2s.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ *
+ * This is an implementation of the BLAKE2s hash and PRF functions.
+ *
+ * Information: https://blake2.net/
+ *
+ */
+
+#include <crypto/internal/blake2s.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/bug.h>
+#include <asm/unaligned.h>
+
+bool blake2s_selftest(void);
+
+void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen)
+{
+	const size_t fill = BLAKE2S_BLOCK_SIZE - state->buflen;
+
+	if (unlikely(!inlen))
+		return;
+	if (inlen > fill) {
+		memcpy(state->buf + state->buflen, in, fill);
+		blake2s_compress_generic(state, state->buf, 1,
+					 BLAKE2S_BLOCK_SIZE);
+		state->buflen = 0;
+		in += fill;
+		inlen -= fill;
+	}
+	if (inlen > BLAKE2S_BLOCK_SIZE) {
+		const size_t nblocks = DIV_ROUND_UP(inlen, BLAKE2S_BLOCK_SIZE);
+		/* Hash one less (full) block than strictly possible */
+		blake2s_compress_generic(state, in, nblocks - 1,
+					 BLAKE2S_BLOCK_SIZE);
+		in += BLAKE2S_BLOCK_SIZE * (nblocks - 1);
+		inlen -= BLAKE2S_BLOCK_SIZE * (nblocks - 1);
+	}
+	memcpy(state->buf + state->buflen, in, inlen);
+	state->buflen += inlen;
+}
+EXPORT_SYMBOL(blake2s_update);
+
+void blake2s_final(struct blake2s_state *state, u8 *out)
+{
+	WARN_ON(IS_ENABLED(DEBUG) && !out);
+	blake2s_set_lastblock(state);
+	memset(state->buf + state->buflen, 0,
+	       BLAKE2S_BLOCK_SIZE - state->buflen); /* Padding */
+	blake2s_compress_generic(state, state->buf, 1, state->buflen);
+	cpu_to_le32_array(state->h, ARRAY_SIZE(state->h));
+	memcpy(out, state->h, state->outlen);
+	memzero_explicit(state, sizeof(*state));
+}
+EXPORT_SYMBOL(blake2s_final);
+
+static int __init mod_init(void)
+{
+	if (!IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS) &&
+	    WARN_ON(!blake2s_selftest()))
+		return -ENODEV;
+	return 0;
+}
+
+static void __exit mod_exit(void)
+{
+}
+
+module_init(mod_init);
+module_exit(mod_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("BLAKE2s hash function");
+MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 18072ea9c20e..479d0a9cf69f 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -133,18 +133,6 @@ EXPORT_SYMBOL(find_last_bit);
 
 #ifdef __BIG_ENDIAN
 
-/* include/linux/byteorder does not support "unsigned long" type */
-static inline unsigned long ext2_swab(const unsigned long y)
-{
-#if BITS_PER_LONG == 64
-	return (unsigned long) __swab64((u64) y);
-#elif BITS_PER_LONG == 32
-	return (unsigned long) __swab32((u32) y);
-#else
-#error BITS_PER_LONG not defined
-#endif
-}
-
 #if !defined(find_next_bit_le) || !defined(find_next_zero_bit_le)
 static unsigned long _find_next_bit_le(const unsigned long *addr,
 		unsigned long nbits, unsigned long start, unsigned long invert)
@@ -157,7 +145,7 @@ static unsigned long _find_next_bit_le(const unsigned long *addr,
 	tmp = addr[start / BITS_PER_LONG] ^ invert;
 
 	/* Handle 1st word. */
-	tmp &= ext2_swab(BITMAP_FIRST_WORD_MASK(start));
+	tmp &= swab(BITMAP_FIRST_WORD_MASK(start));
 	start = round_down(start, BITS_PER_LONG);
 
 	while (!tmp) {
@@ -168,7 +156,7 @@ static unsigned long _find_next_bit_le(const unsigned long *addr,
 		tmp = addr[start / BITS_PER_LONG] ^ invert;
 	}
 
-	return min(start + __ffs(ext2_swab(tmp)), nbits);
+	return min(start + __ffs(swab(tmp)), nbits);
 }
 #endif
 
diff --git a/lib/idr.c b/lib/idr.c
index 9decbe914595..581f6ac74b03 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -1155,7 +1155,9 @@ void ida_simple_remove(struct ida *ida, unsigned int id)
 {
 	unsigned long flags;
 
-	BUG_ON((int)id < 0);
+	if ((int)id < 0)
+		return;
+
 	spin_lock_irqsave(&simple_ida_lock, flags);
 	ida_remove(ida, id);
 	spin_unlock_irqrestore(&simple_ida_lock, flags);
diff --git a/lib/random32.c b/lib/random32.c
index 3c5b67b69cba..7e630025cbc3 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -37,6 +37,9 @@
 #include <linux/jiffies.h>
 #include <linux/random.h>
 #include <linux/sched.h>
+#include <linux/bitops.h>
+#include <linux/slab.h>
+#include <linux/notifier.h>
 #include <asm/unaligned.h>
 
 /**
@@ -543,9 +546,11 @@ static void prandom_reseed(unsigned long dontcare)
  * To avoid worrying about whether it's safe to delay that interrupt
  * long enough to seed all CPUs, just schedule an immediate timer event.
  */
-static void prandom_timer_start(struct random_ready_callback *unused)
+static int prandom_timer_start(struct notifier_block *nb,
+			       unsigned long action, void *data)
 {
 	mod_timer(&seed_timer, jiffies);
+	return 0;
 }
 
 /*
@@ -554,13 +559,13 @@ static void prandom_timer_start(struct random_ready_callback *unused)
  */
 static int __init prandom_init_late(void)
 {
-	static struct random_ready_callback random_ready = {
-		.func = prandom_timer_start
+	static struct notifier_block random_ready = {
+		.notifier_call = prandom_timer_start
 	};
-	int ret = add_random_ready_callback(&random_ready);
+	int ret = register_random_ready_notifier(&random_ready);
 
 	if (ret == -EALREADY) {
-		prandom_timer_start(&random_ready);
+		prandom_timer_start(&random_ready, 0, NULL);
 		ret = 0;
 	}
 	return ret;
diff --git a/lib/ratelimit.c b/lib/ratelimit.c
index d01f47135239..b805702de84d 100644
--- a/lib/ratelimit.c
+++ b/lib/ratelimit.c
@@ -27,10 +27,16 @@
  */
 int ___ratelimit(struct ratelimit_state *rs, const char *func)
 {
+	/* Paired with WRITE_ONCE() in .proc_handler().
+	 * Changing two values seperately could be inconsistent
+	 * and some message could be lost.  (See: net_ratelimit_state).
+	 */
+	int interval = READ_ONCE(rs->interval);
+	int burst = READ_ONCE(rs->burst);
 	unsigned long flags;
 	int ret;
 
-	if (!rs->interval)
+	if (!interval)
 		return 1;
 
 	/*
@@ -45,7 +51,7 @@ int ___ratelimit(struct ratelimit_state *rs, const char *func)
 	if (!rs->begin)
 		rs->begin = jiffies;
 
-	if (time_is_before_jiffies(rs->begin + rs->interval)) {
+	if (time_is_before_jiffies(rs->begin + interval)) {
 		if (rs->missed) {
 			if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
 				printk_deferred(KERN_WARNING
@@ -57,7 +63,7 @@ int ___ratelimit(struct ratelimit_state *rs, const char *func)
 		rs->begin   = jiffies;
 		rs->printed = 0;
 	}
-	if (rs->burst && rs->burst > rs->printed) {
+	if (burst && burst > rs->printed) {
 		rs->printed++;
 		ret = 1;
 	} else {
diff --git a/lib/sha1.c b/lib/sha1.c
index 5a56dfd7b99d..8aa4ee352ad5 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/bitops.h>
 #include <linux/cryptohash.h>
+#include <linux/string.h>
 #include <asm/unaligned.h>
 
 /*
@@ -54,7 +55,8 @@
 #define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
 	__u32 TEMP = input(t); setW(t, TEMP); \
 	E += TEMP + rol32(A,5) + (fn) + (constant); \
-	B = ror32(B, 2); } while (0)
+	B = ror32(B, 2); \
+	TEMP = E; E = D; D = C; C = B; B = A; A = TEMP; } while (0)
 
 #define T_0_15(t, A, B, C, D, E)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
 #define T_16_19(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
@@ -81,6 +83,7 @@
 void sha_transform(__u32 *digest, const char *data, __u32 *array)
 {
 	__u32 A, B, C, D, E;
+	unsigned int i = 0;
 
 	A = digest[0];
 	B = digest[1];
@@ -89,94 +92,24 @@ void sha_transform(__u32 *digest, const char *data, __u32 *array)
 	E = digest[4];
 
 	/* Round 1 - iterations 0-16 take their input from 'data' */
-	T_0_15( 0, A, B, C, D, E);
-	T_0_15( 1, E, A, B, C, D);
-	T_0_15( 2, D, E, A, B, C);
-	T_0_15( 3, C, D, E, A, B);
-	T_0_15( 4, B, C, D, E, A);
-	T_0_15( 5, A, B, C, D, E);
-	T_0_15( 6, E, A, B, C, D);
-	T_0_15( 7, D, E, A, B, C);
-	T_0_15( 8, C, D, E, A, B);
-	T_0_15( 9, B, C, D, E, A);
-	T_0_15(10, A, B, C, D, E);
-	T_0_15(11, E, A, B, C, D);
-	T_0_15(12, D, E, A, B, C);
-	T_0_15(13, C, D, E, A, B);
-	T_0_15(14, B, C, D, E, A);
-	T_0_15(15, A, B, C, D, E);
+	for (; i < 16; ++i)
+		T_0_15(i, A, B, C, D, E);
 
 	/* Round 1 - tail. Input from 512-bit mixing array */
-	T_16_19(16, E, A, B, C, D);
-	T_16_19(17, D, E, A, B, C);
-	T_16_19(18, C, D, E, A, B);
-	T_16_19(19, B, C, D, E, A);
+	for (; i < 20; ++i)
+		T_16_19(i, A, B, C, D, E);
 
 	/* Round 2 */
-	T_20_39(20, A, B, C, D, E);
-	T_20_39(21, E, A, B, C, D);
-	T_20_39(22, D, E, A, B, C);
-	T_20_39(23, C, D, E, A, B);
-	T_20_39(24, B, C, D, E, A);
-	T_20_39(25, A, B, C, D, E);
-	T_20_39(26, E, A, B, C, D);
-	T_20_39(27, D, E, A, B, C);
-	T_20_39(28, C, D, E, A, B);
-	T_20_39(29, B, C, D, E, A);
-	T_20_39(30, A, B, C, D, E);
-	T_20_39(31, E, A, B, C, D);
-	T_20_39(32, D, E, A, B, C);
-	T_20_39(33, C, D, E, A, B);
-	T_20_39(34, B, C, D, E, A);
-	T_20_39(35, A, B, C, D, E);
-	T_20_39(36, E, A, B, C, D);
-	T_20_39(37, D, E, A, B, C);
-	T_20_39(38, C, D, E, A, B);
-	T_20_39(39, B, C, D, E, A);
+	for (; i < 40; ++i)
+		T_20_39(i, A, B, C, D, E);
 
 	/* Round 3 */
-	T_40_59(40, A, B, C, D, E);
-	T_40_59(41, E, A, B, C, D);
-	T_40_59(42, D, E, A, B, C);
-	T_40_59(43, C, D, E, A, B);
-	T_40_59(44, B, C, D, E, A);
-	T_40_59(45, A, B, C, D, E);
-	T_40_59(46, E, A, B, C, D);
-	T_40_59(47, D, E, A, B, C);
-	T_40_59(48, C, D, E, A, B);
-	T_40_59(49, B, C, D, E, A);
-	T_40_59(50, A, B, C, D, E);
-	T_40_59(51, E, A, B, C, D);
-	T_40_59(52, D, E, A, B, C);
-	T_40_59(53, C, D, E, A, B);
-	T_40_59(54, B, C, D, E, A);
-	T_40_59(55, A, B, C, D, E);
-	T_40_59(56, E, A, B, C, D);
-	T_40_59(57, D, E, A, B, C);
-	T_40_59(58, C, D, E, A, B);
-	T_40_59(59, B, C, D, E, A);
+	for (; i < 60; ++i)
+		T_40_59(i, A, B, C, D, E);
 
 	/* Round 4 */
-	T_60_79(60, A, B, C, D, E);
-	T_60_79(61, E, A, B, C, D);
-	T_60_79(62, D, E, A, B, C);
-	T_60_79(63, C, D, E, A, B);
-	T_60_79(64, B, C, D, E, A);
-	T_60_79(65, A, B, C, D, E);
-	T_60_79(66, E, A, B, C, D);
-	T_60_79(67, D, E, A, B, C);
-	T_60_79(68, C, D, E, A, B);
-	T_60_79(69, B, C, D, E, A);
-	T_60_79(70, A, B, C, D, E);
-	T_60_79(71, E, A, B, C, D);
-	T_60_79(72, D, E, A, B, C);
-	T_60_79(73, C, D, E, A, B);
-	T_60_79(74, B, C, D, E, A);
-	T_60_79(75, A, B, C, D, E);
-	T_60_79(76, E, A, B, C, D);
-	T_60_79(77, D, E, A, B, C);
-	T_60_79(78, C, D, E, A, B);
-	T_60_79(79, B, C, D, E, A);
+	for (; i < 80; ++i)
+		T_60_79(i, A, B, C, D, E);
 
 	digest[0] += A;
 	digest[1] += B;
diff --git a/lib/siphash.c b/lib/siphash.c
index e632ee40aac1..5b34b5c83988 100644
--- a/lib/siphash.c
+++ b/lib/siphash.c
@@ -18,19 +18,13 @@
 #include <asm/word-at-a-time.h>
 #endif
 
-#define SIPROUND \
-	do { \
-	v0 += v1; v1 = rol64(v1, 13); v1 ^= v0; v0 = rol64(v0, 32); \
-	v2 += v3; v3 = rol64(v3, 16); v3 ^= v2; \
-	v0 += v3; v3 = rol64(v3, 21); v3 ^= v0; \
-	v2 += v1; v1 = rol64(v1, 17); v1 ^= v2; v2 = rol64(v2, 32); \
-	} while (0)
+#define SIPROUND SIPHASH_PERMUTATION(v0, v1, v2, v3)
 
 #define PREAMBLE(len) \
-	u64 v0 = 0x736f6d6570736575ULL; \
-	u64 v1 = 0x646f72616e646f6dULL; \
-	u64 v2 = 0x6c7967656e657261ULL; \
-	u64 v3 = 0x7465646279746573ULL; \
+	u64 v0 = SIPHASH_CONST_0; \
+	u64 v1 = SIPHASH_CONST_1; \
+	u64 v2 = SIPHASH_CONST_2; \
+	u64 v3 = SIPHASH_CONST_3; \
 	u64 b = ((u64)(len)) << 56; \
 	v3 ^= key->key[1]; \
 	v2 ^= key->key[0]; \
@@ -389,19 +383,13 @@ u32 hsiphash_4u32(const u32 first, const u32 second, const u32 third,
 }
 EXPORT_SYMBOL(hsiphash_4u32);
 #else
-#define HSIPROUND \
-	do { \
-	v0 += v1; v1 = rol32(v1, 5); v1 ^= v0; v0 = rol32(v0, 16); \
-	v2 += v3; v3 = rol32(v3, 8); v3 ^= v2; \
-	v0 += v3; v3 = rol32(v3, 7); v3 ^= v0; \
-	v2 += v1; v1 = rol32(v1, 13); v1 ^= v2; v2 = rol32(v2, 16); \
-	} while (0)
+#define HSIPROUND HSIPHASH_PERMUTATION(v0, v1, v2, v3)
 
 #define HPREAMBLE(len) \
-	u32 v0 = 0; \
-	u32 v1 = 0; \
-	u32 v2 = 0x6c796765U; \
-	u32 v3 = 0x74656462U; \
+	u32 v0 = HSIPHASH_CONST_0; \
+	u32 v1 = HSIPHASH_CONST_1; \
+	u32 v2 = HSIPHASH_CONST_2; \
+	u32 v3 = HSIPHASH_CONST_3; \
 	u32 b = ((u32)(len)) << 24; \
 	v3 ^= key->key[1]; \
 	v2 ^= key->key[0]; \
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 74b5b8862198..aad34b1c77e2 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -532,9 +532,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	 */
 	for (i = 0; i < nslots; i++)
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+	/*
+	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
+	 * to the tlb buffer, if we knew for sure the device will
+	 * overwirte the entire current content. But we don't. Thus
+	 * unconditional bounce may prevent leaking swiotlb content (i.e.
+	 * kernel memory) to user-space.
+	 */
+	if (orig_addr)
 		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
-
 	return tlb_addr;
 }
 EXPORT_SYMBOL_GPL(swiotlb_tbl_map_single);
diff --git a/localversion-rt b/localversion-rt
index d30c7d5647e6..7cbd4fa29217 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt195
+-rt197
diff --git a/mm/memory.c b/mm/memory.c
index 1b31cdce936e..36d46e19df96 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2891,10 +2891,15 @@ static int __do_fault(struct fault_env *fe, pgoff_t pgoff,
 	}
 
 	if (unlikely(PageHWPoison(vmf.page))) {
-		if (ret & VM_FAULT_LOCKED)
+		int poisonret = VM_FAULT_HWPOISON;
+		if (ret & VM_FAULT_LOCKED) {
+			/* Retry if a clean page was removed from the cache. */
+			if (invalidate_inode_page(vmf.page))
+				poisonret = 0;
 			unlock_page(vmf.page);
+		}
 		put_page(vmf.page);
-		return VM_FAULT_HWPOISON;
+		return poisonret;
 	}
 
 	if (unlikely(!(ret & VM_FAULT_LOCKED)))
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6059f85546fe..2990a05777bd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -396,7 +396,7 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
 static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask,
 				enum mpol_rebind_step step)
 {
-	if (!pol)
+	if (!pol || pol->mode == MPOL_LOCAL)
 		return;
 	if (!mpol_store_user_nodemask(pol) && step == MPOL_REBIND_ONCE &&
 	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
diff --git a/mm/mmap.c b/mm/mmap.c
index 18bd38ac1531..a696c17ba9b0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1593,8 +1593,12 @@ int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
 	    pgprot_val(vm_pgprot_modify(vm_page_prot, vm_flags)))
 		return 0;
 
-	/* Do we need to track softdirty? */
-	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) && !(vm_flags & VM_SOFTDIRTY))
+	/*
+	 * Do we need to track softdirty? hugetlb does not support softdirty
+	 * tracking yet.
+	 */
+	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) && !(vm_flags & VM_SOFTDIRTY) &&
+	    !is_vm_hugetlb_page(vma))
 		return 1;
 
 	/* Specialty mapping? */
@@ -2525,6 +2529,18 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_gather_mmu(&tlb, mm, start, end);
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, vma, start, end);
+
+	/*
+	 * Ensure we have no stale TLB entries by the time this mapping is
+	 * removed from the rmap.
+	 * Note that we don't have to worry about nested flushes here because
+	 * we're holding the mm semaphore for removing the mapping - so any
+	 * concurrent flush in this region has to be coming through the rmap,
+	 * and we synchronize against that using the rmap lock.
+	 */
+	if ((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) != 0)
+		tlb_flush_mmu(&tlb);
+
 	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb, start, end);
diff --git a/mm/rmap.c b/mm/rmap.c
index 0a5310b76ec8..76064d964918 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -78,7 +78,8 @@ static inline struct anon_vma *anon_vma_alloc(void)
 	anon_vma = kmem_cache_alloc(anon_vma_cachep, GFP_KERNEL);
 	if (anon_vma) {
 		atomic_set(&anon_vma->refcount, 1);
-		anon_vma->degree = 1;	/* Reference for first vma */
+		anon_vma->num_children = 0;
+		anon_vma->num_active_vmas = 0;
 		anon_vma->parent = anon_vma;
 		/*
 		 * Initialise the anon_vma root to point to itself. If called
@@ -187,6 +188,7 @@ int anon_vma_prepare(struct vm_area_struct *vma)
 			anon_vma = anon_vma_alloc();
 			if (unlikely(!anon_vma))
 				goto out_enomem_free_avc;
+			anon_vma->num_children++; /* self-parent link for new root */
 			allocated = anon_vma;
 		}
 
@@ -196,8 +198,7 @@ int anon_vma_prepare(struct vm_area_struct *vma)
 		if (likely(!vma->anon_vma)) {
 			vma->anon_vma = anon_vma;
 			anon_vma_chain_link(vma, avc, anon_vma);
-			/* vma reference or self-parent link for new root */
-			anon_vma->degree++;
+			anon_vma->num_active_vmas++;
 			allocated = NULL;
 			avc = NULL;
 		}
@@ -276,19 +277,19 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 		anon_vma_chain_link(dst, avc, anon_vma);
 
 		/*
-		 * Reuse existing anon_vma if its degree lower than two,
-		 * that means it has no vma and only one anon_vma child.
+		 * Reuse existing anon_vma if it has no vma and only one
+		 * anon_vma child.
 		 *
-		 * Do not chose parent anon_vma, otherwise first child
-		 * will always reuse it. Root anon_vma is never reused:
+		 * Root anon_vma is never reused:
 		 * it has self-parent reference and at least one child.
 		 */
-		if (!dst->anon_vma && anon_vma != src->anon_vma &&
-				anon_vma->degree < 2)
+		if (!dst->anon_vma &&
+		    anon_vma->num_children < 2 &&
+		    anon_vma->num_active_vmas == 0)
 			dst->anon_vma = anon_vma;
 	}
 	if (dst->anon_vma)
-		dst->anon_vma->degree++;
+		dst->anon_vma->num_active_vmas++;
 	unlock_anon_vma_root(root);
 	return 0;
 
@@ -338,6 +339,7 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	anon_vma = anon_vma_alloc();
 	if (!anon_vma)
 		goto out_error;
+	anon_vma->num_active_vmas++;
 	avc = anon_vma_chain_alloc(GFP_KERNEL);
 	if (!avc)
 		goto out_error_free_anon_vma;
@@ -358,7 +360,7 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	vma->anon_vma = anon_vma;
 	anon_vma_lock_write(anon_vma);
 	anon_vma_chain_link(vma, avc, anon_vma);
-	anon_vma->parent->degree++;
+	anon_vma->parent->num_children++;
 	anon_vma_unlock_write(anon_vma);
 
 	return 0;
@@ -390,7 +392,7 @@ void unlink_anon_vmas(struct vm_area_struct *vma)
 		 * to free them outside the lock.
 		 */
 		if (RB_EMPTY_ROOT(&anon_vma->rb_root)) {
-			anon_vma->parent->degree--;
+			anon_vma->parent->num_children--;
 			continue;
 		}
 
@@ -398,7 +400,7 @@ void unlink_anon_vmas(struct vm_area_struct *vma)
 		anon_vma_chain_free(avc);
 	}
 	if (vma->anon_vma)
-		vma->anon_vma->degree--;
+		vma->anon_vma->num_active_vmas--;
 	unlock_anon_vma_root(root);
 
 	/*
@@ -409,7 +411,8 @@ void unlink_anon_vmas(struct vm_area_struct *vma)
 	list_for_each_entry_safe(avc, next, &vma->anon_vma_chain, same_vma) {
 		struct anon_vma *anon_vma = avc->anon_vma;
 
-		VM_WARN_ON(anon_vma->degree);
+		VM_WARN_ON(anon_vma->num_children);
+		VM_WARN_ON(anon_vma->num_active_vmas);
 		put_anon_vma(anon_vma);
 
 		list_del(&avc->same_vma);
diff --git a/mm/slub.c b/mm/slub.c
index f848c57f670b..41f42cb315f7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2609,6 +2609,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			deactivate_slab(s, page, c->freelist);
 			c->page = NULL;
 			c->freelist = NULL;
+			c->tid = next_tid(c->tid);
 			goto new_slab;
 		}
 	}
@@ -2622,6 +2623,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		deactivate_slab(s, page, c->freelist);
 		c->page = NULL;
 		c->freelist = NULL;
+		c->tid = next_tid(c->tid);
 		goto new_slab;
 	}
 
@@ -2634,6 +2636,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	if (!freelist) {
 		c->page = NULL;
+		c->tid = next_tid(c->tid);
 		stat(s, DEACTIVATE_BYPASS);
 		goto new_slab;
 	}
@@ -2665,6 +2668,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		c->partial = page->next;
 		stat(s, CPU_PARTIAL_ALLOC);
 		c->freelist = NULL;
+		c->tid = next_tid(c->tid);
 		goto redo;
 	}
 
@@ -2687,6 +2691,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	deactivate_slab(s, page, get_freepointer(s, freelist));
 	c->page = NULL;
 	c->freelist = NULL;
+	c->tid = next_tid(c->tid);
 	goto out;
 }
 
diff --git a/mm/util.c b/mm/util.c
index 07f467206186..0559a1feec02 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -11,6 +11,7 @@
 #include <linux/mman.h>
 #include <linux/hugetlb.h>
 #include <linux/vmalloc.h>
+#include <linux/random.h>
 
 #include <asm/sections.h>
 #include <asm/uaccess.h>
@@ -261,6 +262,38 @@ int vma_is_stack_for_current(struct vm_area_struct *vma)
 	return (vma->vm_start <= KSTK_ESP(t) && vma->vm_end >= KSTK_ESP(t));
 }
 
+/**
+ * randomize_page - Generate a random, page aligned address
+ * @start:	The smallest acceptable address the caller will take.
+ * @range:	The size of the area, starting at @start, within which the
+ *		random address must fall.
+ *
+ * If @start + @range would overflow, @range is capped.
+ *
+ * NOTE: Historical use of randomize_range, which this replaces, presumed that
+ * @start was already page aligned.  We now align it regardless.
+ *
+ * Return: A page aligned address within [start, start + range).  On error,
+ * @start is returned.
+ */
+unsigned long randomize_page(unsigned long start, unsigned long range)
+{
+	if (!PAGE_ALIGNED(start)) {
+		range -= PAGE_ALIGN(start) - start;
+		start = PAGE_ALIGN(start);
+	}
+
+	if (start > ULONG_MAX - range)
+		range = ULONG_MAX - start;
+
+	range >>= PAGE_SHIFT;
+
+	if (range == 0)
+		return start;
+
+	return start + (get_random_long() % range << PAGE_SHIFT);
+}
+
 #if defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
diff --git a/net/9p/client.c b/net/9p/client.c
index f1517ca8aba3..237ba7e21771 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -891,7 +891,7 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 	unsigned long flags;
 
 	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
-	fid = kmalloc(sizeof(struct p9_fid), GFP_KERNEL);
+	fid = kzalloc(sizeof(struct p9_fid), GFP_KERNEL);
 	if (!fid)
 		return ERR_PTR(-ENOMEM);
 
@@ -902,11 +902,9 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 	}
 	fid->fid = ret;
 
-	memset(&fid->qid, 0, sizeof(struct p9_qid));
 	fid->mode = -1;
 	fid->uid = current_fsuid();
 	fid->clnt = clnt;
-	fid->rdir = NULL;
 	spin_lock_irqsave(&clnt->lock, flags);
 	list_add(&fid->flist, &clnt->fidlist);
 	spin_unlock_irqrestore(&clnt->lock, flags);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 204b6ebd2a24..474c12d4f8ba 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -113,7 +113,8 @@ static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 }
 
 /* Find channel with given SCID.
- * Returns locked channel. */
+ * Returns a reference locked channel.
+ */
 static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 						 u16 cid)
 {
@@ -121,15 +122,19 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 
 	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_scid(conn, cid);
-	if (c)
-		l2cap_chan_lock(c);
+	if (c) {
+		/* Only lock if chan reference is not 0 */
+		c = l2cap_chan_hold_unless_zero(c);
+		if (c)
+			l2cap_chan_lock(c);
+	}
 	mutex_unlock(&conn->chan_lock);
 
 	return c;
 }
 
 /* Find channel with given DCID.
- * Returns locked channel.
+ * Returns a reference locked channel.
  */
 static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 						 u16 cid)
@@ -138,8 +143,12 @@ static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 
 	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_dcid(conn, cid);
-	if (c)
-		l2cap_chan_lock(c);
+	if (c) {
+		/* Only lock if chan reference is not 0 */
+		c = l2cap_chan_hold_unless_zero(c);
+		if (c)
+			l2cap_chan_lock(c);
+	}
 	mutex_unlock(&conn->chan_lock);
 
 	return c;
@@ -164,8 +173,12 @@ static struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 
 	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_ident(conn, ident);
-	if (c)
-		l2cap_chan_lock(c);
+	if (c) {
+		/* Only lock if chan reference is not 0 */
+		c = l2cap_chan_hold_unless_zero(c);
+		if (c)
+			l2cap_chan_lock(c);
+	}
 	mutex_unlock(&conn->chan_lock);
 
 	return c;
@@ -491,6 +504,16 @@ void l2cap_chan_hold(struct l2cap_chan *c)
 	kref_get(&c->kref);
 }
 
+struct l2cap_chan *l2cap_chan_hold_unless_zero(struct l2cap_chan *c)
+{
+	BT_DBG("chan %p orig refcnt %u", c, kref_read(&c->kref));
+
+	if (!kref_get_unless_zero(&c->kref))
+		return NULL;
+
+	return c;
+}
+
 void l2cap_chan_put(struct l2cap_chan *c)
 {
 	BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->kref.refcount));
@@ -1781,11 +1804,11 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 						   bdaddr_t *dst,
 						   u8 link_type)
 {
-	struct l2cap_chan *c, *c1 = NULL;
+	struct l2cap_chan *c, *tmp, *c1 = NULL;
 
 	read_lock(&chan_list_lock);
 
-	list_for_each_entry(c, &chan_list, global_l) {
+	list_for_each_entry_safe(c, tmp, &chan_list, global_l) {
 		if (state && c->state != state)
 			continue;
 
@@ -1803,7 +1826,9 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 			src_match = !bacmp(&c->src, src);
 			dst_match = !bacmp(&c->dst, dst);
 			if (src_match && dst_match) {
-				l2cap_chan_hold(c);
+				if (!l2cap_chan_hold_unless_zero(c))
+					continue;
+
 				read_unlock(&chan_list_lock);
 				return c;
 			}
@@ -1818,7 +1843,7 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 	}
 
 	if (c1)
-		l2cap_chan_hold(c1);
+		c1 = l2cap_chan_hold_unless_zero(c1);
 
 	read_unlock(&chan_list_lock);
 
@@ -4194,6 +4219,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 
 unlock:
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 	return err;
 }
 
@@ -4306,6 +4332,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 
 done:
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 	return err;
 }
 
@@ -5034,6 +5061,7 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 	l2cap_send_move_chan_rsp(chan, result);
 
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return 0;
 }
@@ -5126,6 +5154,7 @@ static void l2cap_move_continue(struct l2cap_conn *conn, u16 icid, u16 result)
 	}
 
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 }
 
 static void l2cap_move_fail(struct l2cap_conn *conn, u8 ident, u16 icid,
@@ -5155,6 +5184,7 @@ static void l2cap_move_fail(struct l2cap_conn *conn, u8 ident, u16 icid,
 	l2cap_send_move_chan_cfm(chan, L2CAP_MC_UNCONFIRMED);
 
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 }
 
 static int l2cap_move_channel_rsp(struct l2cap_conn *conn,
@@ -5218,6 +5248,7 @@ static int l2cap_move_channel_confirm(struct l2cap_conn *conn,
 	l2cap_send_move_chan_cfm_rsp(conn, cmd->ident, icid);
 
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return 0;
 }
@@ -5253,6 +5284,7 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
 	}
 
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return 0;
 }
@@ -5625,12 +5657,11 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 	if (credits > max_credits) {
 		BT_ERR("LE credits overflow");
 		l2cap_send_disconn_req(chan, ECONNRESET);
-		l2cap_chan_unlock(chan);
 
 		/* Return 0 so that we don't trigger an unnecessary
 		 * command reject packet.
 		 */
-		return 0;
+		goto unlock;
 	}
 
 	chan->tx_credits += credits;
@@ -5643,7 +5674,9 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 	if (chan->tx_credits)
 		chan->ops->resume(chan);
 
+unlock:
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return 0;
 }
@@ -6941,6 +6974,7 @@ static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 
 done:
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 }
 
 static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
@@ -7345,7 +7379,7 @@ static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
 		if (src_type != c->src_type)
 			continue;
 
-		l2cap_chan_hold(c);
+		c = l2cap_chan_hold_unless_zero(c);
 		read_unlock(&chan_list_lock);
 		return c;
 	}
diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
index fd3ce461fbe6..ed05b8277aa4 100644
--- a/net/core/secure_seq.c
+++ b/net/core/secure_seq.c
@@ -62,7 +62,7 @@ __u32 secure_tcpv6_sequence_number(const __be32 *saddr, const __be32 *daddr,
 }
 EXPORT_SYMBOL(secure_tcpv6_sequence_number);
 
-u32 secure_ipv6_port_ephemeral(const __be32 *saddr, const __be32 *daddr,
+u64 secure_ipv6_port_ephemeral(const __be32 *saddr, const __be32 *daddr,
 			       __be16 dport)
 {
 	u32 secret[MD5_MESSAGE_BYTES / 4];
@@ -102,7 +102,7 @@ __u32 secure_tcp_sequence_number(__be32 saddr, __be32 daddr,
 	return seq_scale(hash[0]);
 }
 
-u32 secure_ipv4_port_ephemeral(__be32 saddr, __be32 daddr, __be16 dport)
+u64 secure_ipv4_port_ephemeral(__be32 saddr, __be32 daddr, __be16 dport)
 {
 	u32 hash[MD5_DIGEST_WORDS];
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9b7d01857ac4..4b43d7e2f617 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1086,7 +1086,7 @@ static void skb_headers_offset_update(struct sk_buff *skb, int off)
 	skb->inner_mac_header += off;
 }
 
-static void copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
+void skb_copy_header(struct sk_buff *new, const struct sk_buff *old)
 {
 	__copy_skb_header(new, old);
 
@@ -1094,6 +1094,7 @@ static void copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 	skb_shinfo(new)->gso_segs = skb_shinfo(old)->gso_segs;
 	skb_shinfo(new)->gso_type = skb_shinfo(old)->gso_type;
 }
+EXPORT_SYMBOL(skb_copy_header);
 
 static inline int skb_alloc_rx_flag(const struct sk_buff *skb)
 {
@@ -1137,7 +1138,7 @@ struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t gfp_mask)
 	if (skb_copy_bits(skb, -headerlen, n->head, headerlen + skb->len))
 		BUG();
 
-	copy_skb_header(n, skb);
+	skb_copy_header(n, skb);
 	return n;
 }
 EXPORT_SYMBOL(skb_copy);
@@ -1200,7 +1201,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
 		skb_clone_fraglist(n);
 	}
 
-	copy_skb_header(n, skb);
+	skb_copy_header(n, skb);
 out:
 	return n;
 }
@@ -1371,7 +1372,7 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 			  skb->len + head_copy_len))
 		BUG();
 
-	copy_skb_header(n, skb);
+	skb_copy_header(n, skb);
 
 	skb_headers_offset_update(n, newheadroom - oldheadroom);
 
@@ -3919,7 +3920,7 @@ static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
 {
 	bool ret;
 
-	if (likely(sysctl_tstamp_allow_data || tsonly))
+	if (likely(READ_ONCE(sysctl_tstamp_allow_data) || tsonly))
 		return true;
 
 	read_lock_bh(&sk->sk_callback_lock);
diff --git a/net/core/sock.c b/net/core/sock.c
index 415be3c2490d..e53be212394a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2508,7 +2508,7 @@ void sock_init_data(struct socket *sock, struct sock *sk)
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	sk->sk_napi_id		=	0;
-	sk->sk_ll_usec		=	sysctl_net_busy_read;
+	sk->sk_ll_usec		=	READ_ONCE(sysctl_net_busy_read);
 #endif
 
 	sk->sk_max_pacing_rate = ~0U;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 8f2fb14fd4f7..970a498c1166 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1122,7 +1122,7 @@ static int inet_sk_reselect_saddr(struct sock *sk)
 	if (new_saddr == old_saddr)
 		return 0;
 
-	if (sock_net(sk)->ipv4.sysctl_ip_dynaddr > 1) {
+	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_ip_dynaddr) > 1) {
 		pr_info("%s(): shifting inet->saddr from %pI4 to %pI4\n",
 			__func__, &old_saddr, &new_saddr);
 	}
@@ -1177,7 +1177,7 @@ int inet_sk_rebuild_header(struct sock *sk)
 		 * Other protocols have to map its equivalent state to TCP_SYN_SENT.
 		 * DCCP maps its DCCP_REQUESTING state to TCP_SYN_SENT. -acme
 		 */
-		if (!sock_net(sk)->ipv4.sysctl_ip_dynaddr ||
+		if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_ip_dynaddr) ||
 		    sk->sk_state != TCP_SYN_SENT ||
 		    (sk->sk_userlocks & SOCK_BINDADDR_LOCK) ||
 		    (err = inet_sk_reselect_saddr(sk)) != 0)
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index b7dc20a65b64..0bf7196d5d40 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -254,7 +254,7 @@ static int cipso_v4_cache_check(const unsigned char *key,
 	struct cipso_v4_map_cache_entry *prev_entry = NULL;
 	u32 hash;
 
-	if (!cipso_v4_cache_enabled)
+	if (!READ_ONCE(cipso_v4_cache_enabled))
 		return -ENOENT;
 
 	hash = cipso_v4_map_cache_hash(key, key_len);
@@ -311,13 +311,14 @@ static int cipso_v4_cache_check(const unsigned char *key,
 int cipso_v4_cache_add(const unsigned char *cipso_ptr,
 		       const struct netlbl_lsm_secattr *secattr)
 {
+	int bkt_size = READ_ONCE(cipso_v4_cache_bucketsize);
 	int ret_val = -EPERM;
 	u32 bkt;
 	struct cipso_v4_map_cache_entry *entry = NULL;
 	struct cipso_v4_map_cache_entry *old_entry = NULL;
 	u32 cipso_ptr_len;
 
-	if (!cipso_v4_cache_enabled || cipso_v4_cache_bucketsize <= 0)
+	if (!READ_ONCE(cipso_v4_cache_enabled) || bkt_size <= 0)
 		return 0;
 
 	cipso_ptr_len = cipso_ptr[1];
@@ -337,7 +338,7 @@ int cipso_v4_cache_add(const unsigned char *cipso_ptr,
 
 	bkt = entry->hash & (CIPSO_V4_CACHE_BUCKETS - 1);
 	spin_lock_bh(&cipso_v4_cache[bkt].lock);
-	if (cipso_v4_cache[bkt].size < cipso_v4_cache_bucketsize) {
+	if (cipso_v4_cache[bkt].size < bkt_size) {
 		list_add(&entry->list, &cipso_v4_cache[bkt].list);
 		cipso_v4_cache[bkt].size += 1;
 	} else {
@@ -1214,7 +1215,8 @@ static int cipso_v4_gentag_rbm(const struct cipso_v4_doi *doi_def,
 		/* This will send packets using the "optimized" format when
 		 * possible as specified in  section 3.4.2.6 of the
 		 * CIPSO draft. */
-		if (cipso_v4_rbm_optfmt && ret_val > 0 && ret_val <= 10)
+		if (READ_ONCE(cipso_v4_rbm_optfmt) && ret_val > 0 &&
+		    ret_val <= 10)
 			tag_len = 14;
 		else
 			tag_len = 4 + ret_val;
@@ -1617,7 +1619,7 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
 			 * all the CIPSO validations here but it doesn't
 			 * really specify _exactly_ what we need to validate
 			 * ... so, just make it a sysctl tunable. */
-			if (cipso_v4_rbm_strictvalid) {
+			if (READ_ONCE(cipso_v4_rbm_strictvalid)) {
 				if (cipso_v4_map_lvl_valid(doi_def,
 							   tag[3]) < 0) {
 					err_offset = opt_iter + 3;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e7200bd22f59..05718e56aaaa 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -279,11 +279,12 @@ bool icmp_global_allow(void)
 	spin_lock(&icmp_global.lock);
 	delta = min_t(u32, now - icmp_global.stamp, HZ);
 	if (delta >= HZ / 50) {
-		incr = sysctl_icmp_msgs_per_sec * delta / HZ ;
+		incr = READ_ONCE(sysctl_icmp_msgs_per_sec) * delta / HZ;
 		if (incr)
 			WRITE_ONCE(icmp_global.stamp, now);
 	}
-	credit = min_t(u32, icmp_global.credit + incr, sysctl_icmp_msgs_burst);
+	credit = min_t(u32, icmp_global.credit + incr,
+		       READ_ONCE(sysctl_icmp_msgs_burst));
 	if (credit) {
 		/* We want to use a credit of one in average, but need to randomize
 		 * it for security reasons.
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 75f961425639..3c09bee931b7 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -474,7 +474,8 @@ static struct sk_buff *add_grec(struct sk_buff *skb, struct ip_mc_list *pmc,
 
 	if (pmc->multiaddr == IGMP_ALL_HOSTS)
 		return skb;
-	if (ipv4_is_local_multicast(pmc->multiaddr) && !net->ipv4.sysctl_igmp_llm_reports)
+	if (ipv4_is_local_multicast(pmc->multiaddr) &&
+	    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
 		return skb;
 
 	mtu = READ_ONCE(dev->mtu);
@@ -600,7 +601,7 @@ static int igmpv3_send_report(struct in_device *in_dev, struct ip_mc_list *pmc)
 			if (pmc->multiaddr == IGMP_ALL_HOSTS)
 				continue;
 			if (ipv4_is_local_multicast(pmc->multiaddr) &&
-			     !net->ipv4.sysctl_igmp_llm_reports)
+			    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
 				continue;
 			spin_lock_bh(&pmc->lock);
 			if (pmc->sfcount[MCAST_EXCLUDE])
@@ -743,7 +744,8 @@ static int igmp_send_report(struct in_device *in_dev, struct ip_mc_list *pmc,
 	if (type == IGMPV3_HOST_MEMBERSHIP_REPORT)
 		return igmpv3_send_report(in_dev, pmc);
 
-	if (ipv4_is_local_multicast(group) && !net->ipv4.sysctl_igmp_llm_reports)
+	if (ipv4_is_local_multicast(group) &&
+	    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
 		return 0;
 
 	if (type == IGMP_HOST_LEAVE_MESSAGE)
@@ -921,7 +923,8 @@ static bool igmp_heard_report(struct in_device *in_dev, __be32 group)
 
 	if (group == IGMP_ALL_HOSTS)
 		return false;
-	if (ipv4_is_local_multicast(group) && !net->ipv4.sysctl_igmp_llm_reports)
+	if (ipv4_is_local_multicast(group) &&
+	    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
 		return false;
 
 	rcu_read_lock();
@@ -1031,7 +1034,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		if (im->multiaddr == IGMP_ALL_HOSTS)
 			continue;
 		if (ipv4_is_local_multicast(im->multiaddr) &&
-		    !net->ipv4.sysctl_igmp_llm_reports)
+		    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
 			continue;
 		spin_lock_bh(&im->lock);
 		if (im->tm_running)
@@ -1272,7 +1275,8 @@ static void igmp_group_dropped(struct ip_mc_list *im)
 #ifdef CONFIG_IP_MULTICAST
 	if (im->multiaddr == IGMP_ALL_HOSTS)
 		return;
-	if (ipv4_is_local_multicast(im->multiaddr) && !net->ipv4.sysctl_igmp_llm_reports)
+	if (ipv4_is_local_multicast(im->multiaddr) &&
+	    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
 		return;
 
 	reporter = im->reporter;
@@ -1309,7 +1313,8 @@ static void igmp_group_added(struct ip_mc_list *im)
 #ifdef CONFIG_IP_MULTICAST
 	if (im->multiaddr == IGMP_ALL_HOSTS)
 		return;
-	if (ipv4_is_local_multicast(im->multiaddr) && !net->ipv4.sysctl_igmp_llm_reports)
+	if (ipv4_is_local_multicast(im->multiaddr) &&
+	    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
 		return;
 
 	if (in_dev->dead)
@@ -1621,7 +1626,7 @@ static void ip_mc_rejoin_groups(struct in_device *in_dev)
 		if (im->multiaddr == IGMP_ALL_HOSTS)
 			continue;
 		if (ipv4_is_local_multicast(im->multiaddr) &&
-		    !net->ipv4.sysctl_igmp_llm_reports)
+		    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
 			continue;
 
 		/* a failover is happening and switches
@@ -2166,7 +2171,7 @@ int ip_mc_join_group(struct sock *sk, struct ip_mreqn *imr)
 		count++;
 	}
 	err = -ENOBUFS;
-	if (count >= net->ipv4.sysctl_igmp_max_memberships)
+	if (count >= READ_ONCE(net->ipv4.sysctl_igmp_max_memberships))
 		goto done;
 	iml = sock_kmalloc(sk, sizeof(*iml), GFP_KERNEL);
 	if (!iml)
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 887633870763..db47e1c407d9 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -382,7 +382,7 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 	return -EADDRNOTAVAIL;
 }
 
-static u32 inet_sk_port_offset(const struct sock *sk)
+static u64 inet_sk_port_offset(const struct sock *sk)
 {
 	const struct inet_sock *inet = inet_sk(sk);
 
@@ -537,8 +537,21 @@ void inet_unhash(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(inet_unhash);
 
+/* RFC 6056 3.3.4.  Algorithm 4: Double-Hash Port Selection Algorithm
+ * Note that we use 32bit integers (vs RFC 'short integers')
+ * because 2^16 is not a multiple of num_ephemeral and this
+ * property might be used by clever attacker.
+ * RFC claims using TABLE_LENGTH=10 buckets gives an improvement, though
+ * attacks were since demonstrated, thus we use 65536 instead to really
+ * give more isolation and privacy, at the expense of 256kB of kernel
+ * memory.
+ */
+#define INET_TABLE_PERTURB_SHIFT 16
+#define INET_TABLE_PERTURB_SIZE (1 << INET_TABLE_PERTURB_SHIFT)
+static u32 *table_perturb;
+
 int __inet_hash_connect(struct inet_timewait_death_row *death_row,
-		struct sock *sk, u32 port_offset,
+		struct sock *sk, u64 port_offset,
 		int (*check_established)(struct inet_timewait_death_row *,
 			struct sock *, __u16, struct inet_timewait_sock **))
 {
@@ -550,7 +563,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	struct inet_bind_bucket *tb;
 	u32 remaining, offset;
 	int ret, i, low, high;
-	static u32 hint;
+	u32 index;
 
 	if (port) {
 		head = &hinfo->bhash[inet_bhashfn(net, port,
@@ -575,7 +588,13 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	if (likely(remaining > 1))
 		remaining &= ~1U;
 
-	offset = (hint + port_offset) % remaining;
+	net_get_random_once(table_perturb,
+			    INET_TABLE_PERTURB_SIZE * sizeof(*table_perturb));
+	index = port_offset & (INET_TABLE_PERTURB_SIZE - 1);
+
+	offset = READ_ONCE(table_perturb[index]) + (port_offset >> 32);
+	offset %= remaining;
+
 	/* In first pass we try ports of @low parity.
 	 * inet_csk_get_port() does the opposite choice.
 	 */
@@ -628,7 +647,13 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	return -EADDRNOTAVAIL;
 
 ok:
-	hint += i + 2;
+	/* Here we want to add a little bit of randomness to the next source
+	 * port that will be chosen. We use a max() with a random here so that
+	 * on low contention the randomness is maximal and on high contention
+	 * it may be inexistent.
+	 */
+	i = max_t(int, i, (prandom_u32() & 7) * 2);
+	WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + i + 2);
 
 	/* Head lock still held and bh's disabled */
 	inet_bind_hash(sk, tb, port);
@@ -651,7 +676,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 int inet_hash_connect(struct inet_timewait_death_row *death_row,
 		      struct sock *sk)
 {
-	u32 port_offset = 0;
+	u64 port_offset = 0;
 
 	if (!inet_sk(sk)->inet_num)
 		port_offset = inet_sk_port_offset(sk);
@@ -669,6 +694,15 @@ void inet_hashinfo_init(struct inet_hashinfo *h)
 		INIT_HLIST_NULLS_HEAD(&h->listening_hash[i].nulls_head,
 				      i + LISTENING_NULLS_BASE);
 	}
+
+	if (h != &tcp_hashinfo)
+		return;
+
+	/* this one is used for source ports of outgoing connections */
+	table_perturb = kmalloc_array(INET_TABLE_PERTURB_SIZE,
+				      sizeof(*table_perturb), GFP_KERNEL);
+	if (!table_perturb)
+		panic("TCP: failed to alloc table_perturb");
 }
 EXPORT_SYMBOL_GPL(inet_hashinfo_init);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e0009cd69da7..49061c3fc218 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2005,7 +2005,7 @@ static int tcp_mtu_probe(struct sock *sk)
 	 * probing process by not resetting search range to its orignal.
 	 */
 	if (probe_size > tcp_mtu_to_mss(sk, icsk->icsk_mtup.search_high) ||
-		interval < net->ipv4.sysctl_tcp_probe_threshold) {
+	    interval < READ_ONCE(net->ipv4.sysctl_tcp_probe_threshold)) {
 		/* Check whether enough time has elaplased for
 		 * another round of probing.
 		 */
@@ -2986,11 +2986,12 @@ void tcp_xmit_retransmit_queue(struct sock *sk)
  */
 void sk_forced_mem_schedule(struct sock *sk, int size)
 {
-	int amt;
+	int delta, amt;
 
-	if (size <= sk->sk_forward_alloc)
+	delta = size - sk->sk_forward_alloc;
+	if (delta <= 0)
 		return;
-	amt = sk_mem_pages(size);
+	amt = sk_mem_pages(delta);
 	sk->sk_forward_alloc += amt * SK_MEM_QUANTUM;
 	sk_memory_allocated_add(sk, amt);
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index d47cab6d7c6d..8223ac61a9fd 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -242,7 +242,7 @@ static int __inet6_check_established(struct inet_timewait_death_row *death_row,
 	return -EADDRNOTAVAIL;
 }
 
-static u32 inet6_sk_port_offset(const struct sock *sk)
+static u64 inet6_sk_port_offset(const struct sock *sk)
 {
 	const struct inet_sock *inet = inet_sk(sk);
 
@@ -254,7 +254,7 @@ static u32 inet6_sk_port_offset(const struct sock *sk)
 int inet6_hash_connect(struct inet_timewait_death_row *death_row,
 		       struct sock *sk)
 {
-	u32 port_offset = 0;
+	u64 port_offset = 0;
 
 	if (!inet_sk(sk)->inet_num)
 		port_offset = inet6_sk_port_offset(sk);
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index e209ae19fe78..298ac357a132 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -26,6 +26,11 @@
 #include <net/transp_v6.h>
 #include <net/ping.h>
 
+static void ping_v6_destroy(struct sock *sk)
+{
+	inet6_destroy_sock(sk);
+}
+
 /* Compatibility glue so we can support IPv6 when it's compiled as a module */
 static int dummy_ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len,
 				 int *addr_len)
@@ -179,6 +184,7 @@ struct proto pingv6_prot = {
 	.owner =	THIS_MODULE,
 	.init =		ping_init_sock,
 	.close =	ping_close,
+	.destroy =	ping_v6_destroy,
 	.connect =	ip6_datagram_connect_v6_only,
 	.disconnect =	__udp_disconnect,
 	.setsockopt =	ipv6_setsockopt,
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 07e545fd2a3d..560aedccfa1a 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -308,9 +308,7 @@ static int ipip6_tunnel_get_prl(struct ip_tunnel *t,
 		kcalloc(cmax, sizeof(*kp), GFP_KERNEL) :
 		NULL;
 
-	rcu_read_lock();
-
-	ca = t->prl_count < cmax ? t->prl_count : cmax;
+	ca = min(t->prl_count, cmax);
 
 	if (!kp) {
 		/* We don't try hard to allocate much memory for
@@ -325,7 +323,7 @@ static int ipip6_tunnel_get_prl(struct ip_tunnel *t,
 		}
 	}
 
-	c = 0;
+	rcu_read_lock();
 	for_each_prl_rcu(t->prl) {
 		if (c >= cmax)
 			break;
@@ -337,7 +335,7 @@ static int ipip6_tunnel_get_prl(struct ip_tunnel *t,
 		if (kprl.addr != htonl(INADDR_ANY))
 			break;
 	}
-out:
+
 	rcu_read_unlock();
 
 	len = sizeof(*kp) * c;
@@ -346,7 +344,7 @@ static int ipip6_tunnel_get_prl(struct ip_tunnel *t,
 		ret = -EFAULT;
 
 	kfree(kp);
-
+out:
 	return ret;
 }
 
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 0737fc7b7ebd..88d4a3a02ab7 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1724,9 +1724,12 @@ static int pfkey_register(struct sock *sk, struct sk_buff *skb, const struct sad
 		pfk->registered |= (1<<hdr->sadb_msg_satype);
 	}
 
+	mutex_lock(&pfkey_mutex);
 	xfrm_probe_algs();
 
 	supp_skb = compose_sadb_supported(hdr, GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&pfkey_mutex);
+
 	if (!supp_skb) {
 		if (hdr->sadb_msg_satype != SADB_SATYPE_UNSPEC)
 			pfk->registered &= ~(1<<hdr->sadb_msg_satype);
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 76ef758db112..e412020029df 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -518,14 +518,15 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	struct ipcm6_cookie ipc6;
 	int addr_len = msg->msg_namelen;
 	int transhdrlen = 4; /* zero session-id */
-	int ulen = len + transhdrlen;
+	int ulen;
 	int err;
 
 	/* Rough check on arithmetic overflow,
 	   better check is made in ip6_append_data().
 	 */
-	if (len > INT_MAX)
+	if (len > INT_MAX - transhdrlen)
 		return -EMSGSIZE;
+	ulen = len + transhdrlen;
 
 	/* Mirror BSD error message compatibility */
 	if (msg->msg_flags & MSG_OOB)
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 979fa868a4f1..4673f6f48942 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -435,20 +435,28 @@ static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
  * Session (and tunnel control) socket create/destroy.
  *****************************************************************************/
 
+static void pppol2tp_put_sk(struct rcu_head *head)
+{
+	struct pppol2tp_session *ps;
+
+	ps = container_of(head, typeof(*ps), rcu);
+	sock_put(ps->__sk);
+}
+
 /* Called by l2tp_core when a session socket is being closed.
  */
 static void pppol2tp_session_close(struct l2tp_session *session)
 {
-	struct sock *sk;
-
-	BUG_ON(session->magic != L2TP_SESSION_MAGIC);
+	struct pppol2tp_session *ps;
 
-	sk = pppol2tp_session_get_sock(session);
-	if (sk) {
-		if (sk->sk_socket)
-			inet_shutdown(sk->sk_socket, SEND_SHUTDOWN);
-		sock_put(sk);
-	}
+	ps = l2tp_session_priv(session);
+	mutex_lock(&ps->sk_lock);
+	ps->__sk = rcu_dereference_protected(ps->sk,
+					     lockdep_is_held(&ps->sk_lock));
+	RCU_INIT_POINTER(ps->sk, NULL);
+	if (ps->__sk)
+		call_rcu(&ps->rcu, pppol2tp_put_sk);
+	mutex_unlock(&ps->sk_lock);
 }
 
 /* Really kill the session socket. (Called from sock_put() if
@@ -468,14 +476,6 @@ static void pppol2tp_session_destruct(struct sock *sk)
 	}
 }
 
-static void pppol2tp_put_sk(struct rcu_head *head)
-{
-	struct pppol2tp_session *ps;
-
-	ps = container_of(head, typeof(*ps), rcu);
-	sock_put(ps->__sk);
-}
-
 /* Called when the PPPoX socket (session) is closed.
  */
 static int pppol2tp_release(struct socket *sock)
@@ -499,26 +499,17 @@ static int pppol2tp_release(struct socket *sock)
 	sock_orphan(sk);
 	sock->sk = NULL;
 
+	/* If the socket is associated with a session,
+	 * l2tp_session_delete will call pppol2tp_session_close which
+	 * will drop the session's ref on the socket.
+	 */
 	session = pppol2tp_sock_to_session(sk);
-
-	if (session != NULL) {
-		struct pppol2tp_session *ps;
-
+	if (session) {
 		l2tp_session_delete(session);
-
-		ps = l2tp_session_priv(session);
-		mutex_lock(&ps->sk_lock);
-		ps->__sk = rcu_dereference_protected(ps->sk,
-						     lockdep_is_held(&ps->sk_lock));
-		RCU_INIT_POINTER(ps->sk, NULL);
-		mutex_unlock(&ps->sk_lock);
-		call_rcu(&ps->rcu, pppol2tp_put_sk);
-
-		/* Rely on the sock_put() call at the end of the function for
-		 * dropping the reference held by pppol2tp_sock_to_session().
-		 * The last reference will be dropped by pppol2tp_put_sk().
-		 */
+		/* drop the ref obtained by pppol2tp_sock_to_session */
+		sock_put(sk);
 	}
+
 	release_sock(sk);
 
 	/* This will delete the session context via
@@ -827,6 +818,7 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 
 out_no_ppp:
 	/* This is how we get the session context from the socket. */
+	sock_hold(sk);
 	sk->sk_user_data = session;
 	rcu_assign_pointer(ps->sk, sk);
 	mutex_unlock(&ps->sk_lock);
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index dacd2d34a790..f7cc20641b09 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -96,7 +96,6 @@ config NF_CONNTRACK_ZONES
 
 config NF_CONNTRACK_PROCFS
 	bool "Supply CT list in procfs (OBSOLETE)"
-	default y
 	depends on PROC_FS
 	---help---
 	This option enables for the list of known conntrack entries
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0aad9b8466aa..4a4dae992936 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -119,6 +119,7 @@ static struct nft_trans *nft_trans_alloc(struct nft_ctx *ctx, int msg_type,
 	if (trans == NULL)
 		return NULL;
 
+	INIT_LIST_HEAD(&trans->list);
 	trans->msg_type = msg_type;
 	trans->ctx	= *ctx;
 
@@ -2514,7 +2515,7 @@ static int nf_tables_set_alloc_name(struct nft_ctx *ctx, struct nft_set *set,
 		list_for_each_entry(i, &ctx->table->sets, list) {
 			int tmp;
 
-			if (!nft_is_active_next(ctx->net, set))
+			if (!nft_is_active_next(ctx->net, i))
 				continue;
 			if (!sscanf(i->name, name, &tmp))
 				continue;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 66814a9d030c..80715b495d7c 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -807,11 +807,16 @@ nfqnl_enqueue_packet(struct nf_queue_entry *entry, unsigned int queuenum)
 }
 
 static int
-nfqnl_mangle(void *data, int data_len, struct nf_queue_entry *e, int diff)
+nfqnl_mangle(void *data, unsigned int data_len, struct nf_queue_entry *e, int diff)
 {
 	struct sk_buff *nskb;
 
 	if (diff < 0) {
+		unsigned int min_len = skb_transport_offset(e->skb);
+
+		if (data_len < min_len)
+			return -EINVAL;
+
 		if (pskb_trim(e->skb, data_len))
 			return -ENOMEM;
 	} else if (diff > 0) {
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index f73d47b3ffb7..82bcd14fbcb3 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -287,6 +287,7 @@ nft_payload_select_ops(const struct nft_ctx *ctx,
 {
 	enum nft_payload_bases base;
 	unsigned int offset, len;
+	int err;
 
 	if (tb[NFTA_PAYLOAD_BASE] == NULL ||
 	    tb[NFTA_PAYLOAD_OFFSET] == NULL ||
@@ -312,8 +313,13 @@ nft_payload_select_ops(const struct nft_ctx *ctx,
 	if (tb[NFTA_PAYLOAD_DREG] == NULL)
 		return ERR_PTR(-EINVAL);
 
-	offset = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_OFFSET]));
-	len    = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_LEN]));
+	err = nft_parse_u32_check(tb[NFTA_PAYLOAD_OFFSET], U8_MAX, &offset);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	err = nft_parse_u32_check(tb[NFTA_PAYLOAD_LEN], U8_MAX, &len);
+	if (err < 0)
+		return ERR_PTR(err);
 
 	if (len <= 4 && is_power_of_2(len) && IS_ALIGNED(offset, len) &&
 	    base != NFT_PAYLOAD_LL_HEADER)
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index a3dface3e6e6..8a4159684641 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -121,6 +121,7 @@ static bool nft_hash_update(struct nft_set *set, const u32 *key,
 	/* Another cpu may race to insert the element with the same key */
 	if (prev) {
 		nft_set_elem_destroy(set, he, true);
+		atomic_dec(&set->nelems);
 		he = prev;
 	}
 
@@ -130,6 +131,7 @@ static bool nft_hash_update(struct nft_set *set, const u32 *key,
 
 err2:
 	nft_set_elem_destroy(set, he, true);
+	atomic_dec(&set->nelems);
 err1:
 	return false;
 }
diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index 606a11f681d2..1c927112ff09 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -356,6 +356,7 @@ static int acquire_refill(struct rds_connection *conn)
 static void release_refill(struct rds_connection *conn)
 {
 	clear_bit(RDS_RECV_REFILL, &conn->c_flags);
+	smp_mb__after_atomic();
 
 	/* We don't use wait_on_bit()/wake_up_bit() because our waking is in a
 	 * hot path and finding waiters is very rare.  We don't want to walk
diff --git a/net/rose/rose_loopback.c b/net/rose/rose_loopback.c
index 0f371e50d9c4..e6526c8ecacc 100644
--- a/net/rose/rose_loopback.c
+++ b/net/rose/rose_loopback.c
@@ -99,7 +99,8 @@ static void rose_loopback_timer(unsigned long param)
 		}
 
 		if (frametype == ROSE_CALL_REQUEST) {
-			if (!rose_loopback_neigh->dev) {
+			if (!rose_loopback_neigh->dev &&
+			    !rose_loopback_neigh->loopback) {
 				kfree_skb(skb);
 				continue;
 			}
diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index 9f704a7f2a28..34e7e2ab78fe 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -230,8 +230,8 @@ static void rose_remove_neigh(struct rose_neigh *rose_neigh)
 {
 	struct rose_neigh *s;
 
-	rose_stop_ftimer(rose_neigh);
-	rose_stop_t0timer(rose_neigh);
+	del_timer_sync(&rose_neigh->ftimer);
+	del_timer_sync(&rose_neigh->t0timer);
 
 	skb_queue_purge(&rose_neigh->queue);
 
diff --git a/net/rose/rose_timer.c b/net/rose/rose_timer.c
index bc5469d6d9cb..a7b344896936 100644
--- a/net/rose/rose_timer.c
+++ b/net/rose/rose_timer.c
@@ -34,95 +34,95 @@ static void rose_idletimer_expiry(unsigned long);
 
 void rose_start_heartbeat(struct sock *sk)
 {
-	del_timer(&sk->sk_timer);
+	sk_stop_timer(sk, &sk->sk_timer);
 
 	sk->sk_timer.data     = (unsigned long)sk;
 	sk->sk_timer.function = &rose_heartbeat_expiry;
 	sk->sk_timer.expires  = jiffies + 5 * HZ;
 
-	add_timer(&sk->sk_timer);
+	sk_reset_timer(sk, &sk->sk_timer, sk->sk_timer.expires);
 }
 
 void rose_start_t1timer(struct sock *sk)
 {
 	struct rose_sock *rose = rose_sk(sk);
 
-	del_timer(&rose->timer);
+	sk_stop_timer(sk, &rose->timer);
 
 	rose->timer.data     = (unsigned long)sk;
 	rose->timer.function = &rose_timer_expiry;
 	rose->timer.expires  = jiffies + rose->t1;
 
-	add_timer(&rose->timer);
+	sk_reset_timer(sk, &rose->timer, rose->timer.expires);
 }
 
 void rose_start_t2timer(struct sock *sk)
 {
 	struct rose_sock *rose = rose_sk(sk);
 
-	del_timer(&rose->timer);
+	sk_stop_timer(sk, &rose->timer);
 
 	rose->timer.data     = (unsigned long)sk;
 	rose->timer.function = &rose_timer_expiry;
 	rose->timer.expires  = jiffies + rose->t2;
 
-	add_timer(&rose->timer);
+	sk_reset_timer(sk, &rose->timer, rose->timer.expires);
 }
 
 void rose_start_t3timer(struct sock *sk)
 {
 	struct rose_sock *rose = rose_sk(sk);
 
-	del_timer(&rose->timer);
+	sk_stop_timer(sk, &rose->timer);
 
 	rose->timer.data     = (unsigned long)sk;
 	rose->timer.function = &rose_timer_expiry;
 	rose->timer.expires  = jiffies + rose->t3;
 
-	add_timer(&rose->timer);
+	sk_reset_timer(sk, &rose->timer, rose->timer.expires);
 }
 
 void rose_start_hbtimer(struct sock *sk)
 {
 	struct rose_sock *rose = rose_sk(sk);
 
-	del_timer(&rose->timer);
+	sk_stop_timer(sk, &rose->timer);
 
 	rose->timer.data     = (unsigned long)sk;
 	rose->timer.function = &rose_timer_expiry;
 	rose->timer.expires  = jiffies + rose->hb;
 
-	add_timer(&rose->timer);
+	sk_reset_timer(sk, &rose->timer, rose->timer.expires);
 }
 
 void rose_start_idletimer(struct sock *sk)
 {
 	struct rose_sock *rose = rose_sk(sk);
 
-	del_timer(&rose->idletimer);
+	sk_stop_timer(sk, &rose->timer);
 
 	if (rose->idle > 0) {
 		rose->idletimer.data     = (unsigned long)sk;
 		rose->idletimer.function = &rose_idletimer_expiry;
 		rose->idletimer.expires  = jiffies + rose->idle;
 
-		add_timer(&rose->idletimer);
+		sk_reset_timer(sk, &rose->idletimer, rose->idletimer.expires);
 	}
 }
 
 void rose_stop_heartbeat(struct sock *sk)
 {
-	del_timer(&sk->sk_timer);
+	sk_stop_timer(sk, &sk->sk_timer);
 }
 
 void rose_stop_timer(struct sock *sk)
 {
-	del_timer(&rose_sk(sk)->timer);
+	sk_stop_timer(sk, &rose_sk(sk)->timer);
 }
 
 void rose_stop_idletimer(struct sock *sk)
 {
-	del_timer(&rose_sk(sk)->idletimer);
+	sk_stop_timer(sk, &rose_sk(sk)->idletimer);
 }
 
 static void rose_heartbeat_expiry(unsigned long param)
@@ -139,6 +139,7 @@ static void rose_heartbeat_expiry(unsigned long param)
 		    (sk->sk_state == TCP_LISTEN && sock_flag(sk, SOCK_DEAD))) {
 			bh_unlock_sock(sk);
 			rose_destroy_socket(sk);
+			sock_put(sk);
 			return;
 		}
 		break;
@@ -161,6 +162,7 @@ static void rose_heartbeat_expiry(unsigned long param)
 
 	rose_start_heartbeat(sk);
 	bh_unlock_sock(sk);
+	sock_put(sk);
 }
 
 static void rose_timer_expiry(unsigned long param)
@@ -190,6 +192,7 @@ static void rose_timer_expiry(unsigned long param)
 		break;
 	}
 	bh_unlock_sock(sk);
+	sock_put(sk);
 }
 
 static void rose_idletimer_expiry(unsigned long param)
@@ -213,4 +216,5 @@ static void rose_idletimer_expiry(unsigned long param)
 		sock_set_flag(sk, SOCK_DEAD);
 	}
 	bh_unlock_sock(sk);
+	sock_put(sk);
 }
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index f20373588a99..ce732ce9f9c9 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -427,6 +427,9 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 			goto errout;
 	}
 
+	if (!nhandle)
+		return -EINVAL;
+
 	h1 = to_hash(nhandle);
 	b = rtnl_dereference(head->table[h1]);
 	if (!b) {
@@ -486,6 +489,9 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	int err;
 	bool new = true;
 
+	if (!handle)
+		return -EINVAL;
+
 	if (opt == NULL)
 		return handle ? -EINVAL : 0;
 
@@ -534,7 +540,7 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	rcu_assign_pointer(f->next, f1);
 	rcu_assign_pointer(*fp, f);
 
-	if (fold && fold->handle && f->handle != fold->handle) {
+	if (fold) {
 		th = to_hash(fold->handle);
 		h = from_hash(fold->handle >> 16);
 		b = rtnl_dereference(head->table[th]);
diff --git a/net/socket.c b/net/socket.c
index ab64ae80ca2c..6f1abcba0e36 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1403,7 +1403,7 @@ SYSCALL_DEFINE2(listen, int, fd, int, backlog)
 
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (sock) {
-		somaxconn = sock_net(sock->sk)->core.sysctl_somaxconn;
+		somaxconn = READ_ONCE(sock_net(sock->sk)->core.sysctl_somaxconn);
 		if ((unsigned int)backlog > somaxconn)
 			backlog = somaxconn;
 
diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index ac701c28f44f..a441dd119533 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -69,6 +69,17 @@ static void xprt_free_allocation(struct rpc_rqst *req)
 	kfree(req);
 }
 
+static void xprt_bc_reinit_xdr_buf(struct xdr_buf *buf)
+{
+	buf->head[0].iov_len = PAGE_SIZE;
+	buf->tail[0].iov_len = 0;
+	buf->pages = NULL;
+	buf->page_len = 0;
+	buf->flags = 0;
+	buf->len = 0;
+	buf->buflen = PAGE_SIZE;
+}
+
 static int xprt_alloc_xdr_buf(struct xdr_buf *buf, gfp_t gfp_flags)
 {
 	struct page *page;
@@ -291,6 +302,9 @@ void xprt_free_bc_rqst(struct rpc_rqst *req)
 	 */
 	spin_lock_bh(&xprt->bc_pa_lock);
 	if (xprt_need_to_requeue(xprt)) {
+		xprt_bc_reinit_xdr_buf(&req->rq_snd_buf);
+		xprt_bc_reinit_xdr_buf(&req->rq_rcv_buf);
+		req->rq_rcv_buf.len = PAGE_SIZE;
 		list_add_tail(&req->rq_bc_pa_list, &xprt->bc_pa_list);
 		xprt->bc_alloc_count++;
 		req = NULL;
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 06b4b76edd9d..e0b217f3aae9 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -544,7 +544,7 @@ static __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 	 */
 	xdr->p = (void *)p + frag2bytes;
 	space_left = xdr->buf->buflen - xdr->buf->len;
-	if (space_left - nbytes >= PAGE_SIZE)
+	if (space_left - frag1bytes >= PAGE_SIZE)
 		xdr->end = (void *)p + PAGE_SIZE;
 	else
 		xdr->end = (void *)p + space_left - frag1bytes;
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 0287734f126f..aec0113a88b0 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -75,7 +75,7 @@ static unsigned int rpcrdma_max_call_header_size(unsigned int maxsegs)
 
 	/* Maximum Read list size */
 	maxsegs += 2;	/* segment for head and tail buffers */
-	size = maxsegs * sizeof(struct rpcrdma_read_chunk);
+	size += maxsegs * sizeof(struct rpcrdma_read_chunk);
 
 	/* Minimal Read chunk size */
 	size += sizeof(__be32);	/* segment count */
@@ -101,7 +101,7 @@ static unsigned int rpcrdma_max_reply_header_size(unsigned int maxsegs)
 
 	/* Maximum Write list size */
 	maxsegs += 2;	/* segment for head and tail buffers */
-	size = sizeof(__be32);		/* segment count */
+	size += sizeof(__be32);		/* segment count */
 	size += maxsegs * sizeof(struct rpcrdma_segment);
 	size += sizeof(__be32);	/* list discriminator */
 
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9f39276e5d4e..1b3516368057 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -341,6 +341,7 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
 	sock->state = state;
 	sock_init_data(sock, sk);
 	if (tipc_sk_insert(tsk)) {
+		sk_free(sk);
 		pr_warn("Socket create failed; port number exhausted\n");
 		return -EINVAL;
 	}
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 46ff984da6f4..08f8dc436448 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1205,7 +1205,14 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
 			 * timeout fires.
 			 */
 			sock_hold(sk);
-			schedule_delayed_work(&vsk->connect_work, timeout);
+
+			/* If the timeout function is already scheduled,
+			 * reschedule it, then ungrab the socket refcount to
+			 * keep it balanced.
+			 */
+			if (mod_delayed_work(system_wq, &vsk->connect_work,
+					     timeout))
+				sock_put(sk);
 
 			/* Skip ahead to preserve error code set above. */
 			goto out_wait;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 9179b47e8b61..ae90a273475c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1819,8 +1819,10 @@ static int xfrm_expand_policies(const struct flowi *fl, u16 family,
 		*num_xfrms = 0;
 		return 0;
 	}
-	if (IS_ERR(pols[0]))
+	if (IS_ERR(pols[0])) {
+		*num_pols = 0;
 		return PTR_ERR(pols[0]);
+	}
 
 	*num_xfrms = pols[0]->xfrm_nr;
 
@@ -1834,6 +1836,7 @@ static int xfrm_expand_policies(const struct flowi *fl, u16 family,
 		if (pols[1]) {
 			if (IS_ERR(pols[1])) {
 				xfrm_pols_put(pols, *num_pols);
+				*num_pols = 0;
 				return PTR_ERR(pols[1]);
 			}
 			(*num_pols)++;
@@ -2535,6 +2538,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		if (pols[1]) {
 			if (IS_ERR(pols[1])) {
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLERROR);
+				xfrm_pol_put(pols[0]);
 				return 0;
 			}
 			pols[1]->curlft.use_time = get_seconds();
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 8cb7971b3f25..43b93e32ed58 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -50,8 +50,7 @@ obj := $(KBUILD_EXTMOD)
 src := $(obj)
 
 # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
-include $(if $(wildcard $(KBUILD_EXTMOD)/Kbuild), \
-             $(KBUILD_EXTMOD)/Kbuild, $(KBUILD_EXTMOD)/Makefile)
+include $(if $(wildcard $(src)/Kbuild), $(src)/Kbuild, $(src)/Makefile)
 endif
 
 include scripts/Makefile.lib
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c5f3267aa08a..e29d4006ed66 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1060,7 +1060,7 @@ static const struct sectioncheck sectioncheck[] = {
 },
 /* Do not export init/exit functions or data */
 {
-	.fromsec = { "__ksymtab*", NULL },
+	.fromsec = { "___ksymtab*", NULL },
 	.bad_tosec = { INIT_SECTIONS, EXIT_SECTIONS, NULL },
 	.mismatch = EXPORT_TO_INIT_EXIT,
 	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
diff --git a/security/security.c b/security/security.c
index 9a13d72a6446..5171c3cd1d30 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1032,11 +1032,6 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
 	return call_int_hook(task_kill, 0, p, info, sig, secid);
 }
 
-int security_task_wait(struct task_struct *p)
-{
-	return call_int_hook(task_wait, 0, p);
-}
-
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			 unsigned long arg4, unsigned long arg5)
 {
@@ -1776,7 +1771,6 @@ struct security_hook_heads security_hook_heads = {
 	.task_movememory =
 		LIST_HEAD_INIT(security_hook_heads.task_movememory),
 	.task_kill =	LIST_HEAD_INIT(security_hook_heads.task_kill),
-	.task_wait =	LIST_HEAD_INIT(security_hook_heads.task_wait),
 	.task_prctl =	LIST_HEAD_INIT(security_hook_heads.task_prctl),
 	.task_to_inode =
 		LIST_HEAD_INIT(security_hook_heads.task_to_inode),
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index eb9e2b4e81d9..ac2381eec27f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -231,12 +231,13 @@ static int inode_alloc_security(struct inode *inode)
 	if (!isec)
 		return -ENOMEM;
 
-	mutex_init(&isec->lock);
+	spin_lock_init(&isec->lock);
 	INIT_LIST_HEAD(&isec->list);
 	isec->inode = inode;
 	isec->sid = SECINITSID_UNLABELED;
 	isec->sclass = SECCLASS_FILE;
 	isec->task_sid = sid;
+	isec->initialized = LABEL_INVALID;
 	inode->i_security = isec;
 
 	return 0;
@@ -247,7 +248,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 /*
  * Try reloading inode security labels that have been marked as invalid.  The
  * @may_sleep parameter indicates when sleeping and thus reloading labels is
- * allowed; when set to false, returns ERR_PTR(-ECHILD) when the label is
+ * allowed; when set to false, returns -ECHILD when the label is
  * invalid.  The @opt_dentry parameter should be set to a dentry of the inode;
  * when no dentry is available, set it to NULL instead.
  */
@@ -1386,7 +1387,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 {
 	struct superblock_security_struct *sbsec = NULL;
 	struct inode_security_struct *isec = inode->i_security;
-	u32 sid;
+	u32 task_sid, sid = 0;
+	u16 sclass;
 	struct dentry *dentry;
 #define INITCONTEXTLEN 255
 	char *context = NULL;
@@ -1394,12 +1396,15 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	int rc = 0;
 
 	if (isec->initialized == LABEL_INITIALIZED)
-		goto out;
+		return 0;
 
-	mutex_lock(&isec->lock);
+	spin_lock(&isec->lock);
 	if (isec->initialized == LABEL_INITIALIZED)
 		goto out_unlock;
 
+	if (isec->sclass == SECCLASS_FILE)
+		isec->sclass = inode_mode_to_security_class(inode->i_mode);
+
 	sbsec = inode->i_sb->s_security;
 	if (!(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
@@ -1412,12 +1417,18 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		goto out_unlock;
 	}
 
+	sclass = isec->sclass;
+	task_sid = isec->task_sid;
+	sid = isec->sid;
+	isec->initialized = LABEL_PENDING;
+	spin_unlock(&isec->lock);
+
 	switch (sbsec->behavior) {
 	case SECURITY_FS_USE_NATIVE:
 		break;
 	case SECURITY_FS_USE_XATTR:
 		if (!(inode->i_opflags & IOP_XATTR)) {
-			isec->sid = sbsec->def_sid;
+			sid = sbsec->def_sid;
 			break;
 		}
 		/* Need a dentry, since the xattr API requires one.
@@ -1439,7 +1450,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			 * inode_doinit with a dentry, before these inodes could
 			 * be used again by userspace.
 			 */
-			goto out_unlock;
+			goto out_invalid;
 		}
 
 		len = INITCONTEXTLEN;
@@ -1447,7 +1458,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		if (!context) {
 			rc = -ENOMEM;
 			dput(dentry);
-			goto out_unlock;
+			goto out;
 		}
 		context[len] = '\0';
 		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
@@ -1458,14 +1469,14 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);
 			if (rc < 0) {
 				dput(dentry);
-				goto out_unlock;
+				goto out;
 			}
 			len = rc;
 			context = kmalloc(len+1, GFP_NOFS);
 			if (!context) {
 				rc = -ENOMEM;
 				dput(dentry);
-				goto out_unlock;
+				goto out;
 			}
 			context[len] = '\0';
 			rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
@@ -1477,7 +1488,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 				       "%d for dev=%s ino=%ld\n", __func__,
 				       -rc, inode->i_sb->s_id, inode->i_ino);
 				kfree(context);
-				goto out_unlock;
+				goto out;
 			}
 			/* Map ENODATA to the default file SID */
 			sid = sbsec->def_sid;
@@ -1507,29 +1518,25 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			}
 		}
 		kfree(context);
-		isec->sid = sid;
 		break;
 	case SECURITY_FS_USE_TASK:
-		isec->sid = isec->task_sid;
+		sid = task_sid;
 		break;
 	case SECURITY_FS_USE_TRANS:
 		/* Default to the fs SID. */
-		isec->sid = sbsec->sid;
+		sid = sbsec->sid;
 
 		/* Try to obtain a transition SID. */
-		isec->sclass = inode_mode_to_security_class(inode->i_mode);
-		rc = security_transition_sid(isec->task_sid, sbsec->sid,
-					     isec->sclass, NULL, &sid);
+		rc = security_transition_sid(task_sid, sid, sclass, NULL, &sid);
 		if (rc)
-			goto out_unlock;
-		isec->sid = sid;
+			goto out;
 		break;
 	case SECURITY_FS_USE_MNTPOINT:
-		isec->sid = sbsec->mntpoint_sid;
+		sid = sbsec->mntpoint_sid;
 		break;
 	default:
 		/* Default to the fs superblock SID. */
-		isec->sid = sbsec->sid;
+		sid = sbsec->sid;
 
 		if ((sbsec->flags & SE_SBGENFS) && !S_ISLNK(inode->i_mode)) {
 			/* We must have a dentry to determine the label on
@@ -1552,26 +1559,39 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			 * could be used again by userspace.
 			 */
 			if (!dentry)
-				goto out_unlock;
-			isec->sclass = inode_mode_to_security_class(inode->i_mode);
-			rc = selinux_genfs_get_sid(dentry, isec->sclass,
+				goto out_invalid;
+			rc = selinux_genfs_get_sid(dentry, sclass,
 						   sbsec->flags, &sid);
 			dput(dentry);
 			if (rc)
-				goto out_unlock;
-			isec->sid = sid;
+				goto out;
 		}
 		break;
 	}
 
-	isec->initialized = LABEL_INITIALIZED;
+out:
+	spin_lock(&isec->lock);
+	if (isec->initialized == LABEL_PENDING) {
+		if (rc) {
+			isec->initialized = LABEL_INVALID;
+			goto out_unlock;
+		}
+		isec->initialized = LABEL_INITIALIZED;
+		isec->sid = sid;
+	}
 
 out_unlock:
-	mutex_unlock(&isec->lock);
-out:
-	if (isec->sclass == SECCLASS_FILE)
-		isec->sclass = inode_mode_to_security_class(inode->i_mode);
+	spin_unlock(&isec->lock);
 	return rc;
+
+out_invalid:
+	spin_lock(&isec->lock);
+	if (isec->initialized == LABEL_PENDING) {
+		isec->initialized = LABEL_INVALID;
+		isec->sid = sid;
+	}
+	spin_unlock(&isec->lock);
+	return 0;
 }
 
 /* Convert a Linux signal to an access vector. */
@@ -3200,9 +3220,11 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 	}
 
 	isec = backing_inode_security(dentry);
+	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
 	isec->initialized = LABEL_INITIALIZED;
+	spin_unlock(&isec->lock);
 
 	return;
 }
@@ -3299,9 +3321,11 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	if (rc)
 		return rc;
 
+	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
 	isec->initialized = LABEL_INITIALIZED;
+	spin_unlock(&isec->lock);
 	return 0;
 }
 
@@ -3951,19 +3975,17 @@ static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
 	return rc;
 }
 
-static int selinux_task_wait(struct task_struct *p)
-{
-	return task_has_perm(p, current, PROCESS__SIGCHLD);
-}
-
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
 	struct inode_security_struct *isec = inode->i_security;
 	u32 sid = task_sid(p);
 
+	spin_lock(&isec->lock);
+	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = sid;
 	isec->initialized = LABEL_INITIALIZED;
+	spin_unlock(&isec->lock);
 }
 
 /* Returns error only if unable to parse addresses */
@@ -4282,24 +4304,24 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	const struct task_security_struct *tsec = current_security();
 	struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
 	struct sk_security_struct *sksec;
+	u16 sclass = socket_type_to_security_class(family, type, protocol);
+	u32 sid = SECINITSID_KERNEL;
 	int err = 0;
 
-	isec->sclass = socket_type_to_security_class(family, type, protocol);
-
-	if (kern)
-		isec->sid = SECINITSID_KERNEL;
-	else {
-		err = socket_sockcreate_sid(tsec, isec->sclass, &(isec->sid));
+	if (!kern) {
+		err = socket_sockcreate_sid(tsec, sclass, &sid);
 		if (err)
 			return err;
 	}
 
+	isec->sclass = sclass;
+	isec->sid = sid;
 	isec->initialized = LABEL_INITIALIZED;
 
 	if (sock->sk) {
 		sksec = sock->sk->sk_security;
-		sksec->sid = isec->sid;
-		sksec->sclass = isec->sclass;
+		sksec->sclass = sclass;
+		sksec->sid = sid;
 		err = selinux_netlbl_socket_post_create(sock->sk, family);
 	}
 
@@ -4483,16 +4505,22 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 	int err;
 	struct inode_security_struct *isec;
 	struct inode_security_struct *newisec;
+	u16 sclass;
+	u32 sid;
 
 	err = sock_has_perm(current, sock->sk, SOCKET__ACCEPT);
 	if (err)
 		return err;
 
-	newisec = inode_security_novalidate(SOCK_INODE(newsock));
-
 	isec = inode_security_novalidate(SOCK_INODE(sock));
-	newisec->sclass = isec->sclass;
-	newisec->sid = isec->sid;
+	spin_lock(&isec->lock);
+	sclass = isec->sclass;
+	sid = isec->sid;
+	spin_unlock(&isec->lock);
+
+	newisec = inode_security_novalidate(SOCK_INODE(newsock));
+	newisec->sclass = sclass;
+	newisec->sid = sid;
 	newisec->initialized = LABEL_INITIALIZED;
 
 	return 0;
@@ -6015,9 +6043,9 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
 {
 	struct inode_security_struct *isec = inode->i_security;
 
-	mutex_lock(&isec->lock);
+	spin_lock(&isec->lock);
 	isec->initialized = LABEL_INVALID;
-	mutex_unlock(&isec->lock);
+	spin_unlock(&isec->lock);
 }
 
 /*
@@ -6220,7 +6248,6 @@ static struct security_hook_list selinux_hooks[] = {
 	LSM_HOOK_INIT(task_getscheduler, selinux_task_getscheduler),
 	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
 	LSM_HOOK_INIT(task_kill, selinux_task_kill),
-	LSM_HOOK_INIT(task_wait, selinux_task_wait),
 	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index c21e135460a5..e8dab0f02c72 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -39,7 +39,8 @@ struct task_security_struct {
 
 enum label_initialized {
 	LABEL_INVALID,		/* invalid or not initialized */
-	LABEL_INITIALIZED	/* initialized */
+	LABEL_INITIALIZED,	/* initialized */
+	LABEL_PENDING
 };
 
 struct inode_security_struct {
@@ -52,7 +53,7 @@ struct inode_security_struct {
 	u32 sid;		/* SID of this object */
 	u16 sclass;		/* security class of this object */
 	unsigned char initialized;	/* initialization flag */
-	struct mutex lock;
+	spinlock_t lock;
 };
 
 struct file_security_struct {
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ef1226c1c3ad..a033306d14ee 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1301,7 +1301,7 @@ static int sel_make_bools(void)
 			goto out;
 
 		isec->sid = sid;
-		isec->initialized = 1;
+		isec->initialized = LABEL_INITIALIZED;
 		inode->i_fop = &sel_bool_ops;
 		inode->i_ino = i|SEL_BOOL_INO_OFFSET;
 		d_add(dentry, inode);
@@ -1835,7 +1835,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	isec = (struct inode_security_struct *)inode->i_security;
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
-	isec->initialized = 1;
+	isec->initialized = LABEL_INITIALIZED;
 
 	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, MKDEV(MEM_MAJOR, 3));
 	d_add(dentry, inode);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 84ed47195cdd..f01b69ead47e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2276,25 +2276,6 @@ static int smack_task_kill(struct task_struct *p, struct siginfo *info,
 	return rc;
 }
 
-/**
- * smack_task_wait - Smack access check for waiting
- * @p: task to wait for
- *
- * Returns 0
- */
-static int smack_task_wait(struct task_struct *p)
-{
-	/*
-	 * Allow the operation to succeed.
-	 * Zombies are bad.
-	 * In userless environments (e.g. phones) programs
-	 * get marked with SMACK64EXEC and even if the parent
-	 * and child shouldn't be talking the parent still
-	 * may expect to know when the child exits.
-	 */
-	return 0;
-}
-
 /**
  * smack_task_to_inode - copy task smack into the inode blob
  * @p: task to copy from
@@ -4686,7 +4667,6 @@ static struct security_hook_list smack_hooks[] = {
 	LSM_HOOK_INIT(task_getscheduler, smack_task_getscheduler),
 	LSM_HOOK_INIT(task_movememory, smack_task_movememory),
 	LSM_HOOK_INIT(task_kill, smack_task_kill),
-	LSM_HOOK_INIT(task_wait, smack_task_wait),
 	LSM_HOOK_INIT(task_to_inode, smack_task_to_inode),
 
 	LSM_HOOK_INIT(ipc_permission, smack_ipc_permission),
diff --git a/sound/core/info.c b/sound/core/info.c
index 8a6fa8fd0aab..b6ec13ccf60c 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -127,9 +127,9 @@ static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
 	entry = data->entry;
 	mutex_lock(&entry->access);
 	if (entry->c.ops->llseek) {
-		offset = entry->c.ops->llseek(entry,
-					      data->file_private_data,
-					      file, offset, orig);
+		ret = entry->c.ops->llseek(entry,
+					   data->file_private_data,
+					   file, offset, orig);
 		goto out;
 	}
 
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 78ffe445d775..a67fbcabfa67 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -177,6 +177,7 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 	if (WARN_ON(!dmab))
 		return -ENXIO;
 
+	size = PAGE_ALIGN(size);
 	dmab->dev.type = type;
 	dmab->dev.dev = device;
 	dmab->bytes = 0;
diff --git a/sound/core/misc.c b/sound/core/misc.c
index f2e8226c88fb..efe26b8ca57f 100644
--- a/sound/core/misc.c
+++ b/sound/core/misc.c
@@ -25,6 +25,7 @@
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/fs.h>
 #include <sound/core.h>
 
 #ifdef CONFIG_SND_DEBUG
@@ -153,3 +154,96 @@ snd_pci_quirk_lookup(struct pci_dev *pci, const struct snd_pci_quirk *list)
 }
 EXPORT_SYMBOL(snd_pci_quirk_lookup);
 #endif
+
+/*
+ * Deferred async signal helpers
+ *
+ * Below are a few helper functions to wrap the async signal handling
+ * in the deferred work.  The main purpose is to avoid the messy deadlock
+ * around tasklist_lock and co at the kill_fasync() invocation.
+ * fasync_helper() and kill_fasync() are replaced with snd_fasync_helper()
+ * and snd_kill_fasync(), respectively.  In addition, snd_fasync_free() has
+ * to be called at releasing the relevant file object.
+ */
+struct snd_fasync {
+	struct fasync_struct *fasync;
+	int signal;
+	int poll;
+	int on;
+	struct list_head list;
+};
+
+static DEFINE_SPINLOCK(snd_fasync_lock);
+static LIST_HEAD(snd_fasync_list);
+
+static void snd_fasync_work_fn(struct work_struct *work)
+{
+	struct snd_fasync *fasync;
+
+	spin_lock_irq(&snd_fasync_lock);
+	while (!list_empty(&snd_fasync_list)) {
+		fasync = list_first_entry(&snd_fasync_list, struct snd_fasync, list);
+		list_del_init(&fasync->list);
+		spin_unlock_irq(&snd_fasync_lock);
+		if (fasync->on)
+			kill_fasync(&fasync->fasync, fasync->signal, fasync->poll);
+		spin_lock_irq(&snd_fasync_lock);
+	}
+	spin_unlock_irq(&snd_fasync_lock);
+}
+
+static DECLARE_WORK(snd_fasync_work, snd_fasync_work_fn);
+
+int snd_fasync_helper(int fd, struct file *file, int on,
+		      struct snd_fasync **fasyncp)
+{
+	struct snd_fasync *fasync = NULL;
+
+	if (on) {
+		fasync = kzalloc(sizeof(*fasync), GFP_KERNEL);
+		if (!fasync)
+			return -ENOMEM;
+		INIT_LIST_HEAD(&fasync->list);
+	}
+
+	spin_lock_irq(&snd_fasync_lock);
+	if (*fasyncp) {
+		kfree(fasync);
+		fasync = *fasyncp;
+	} else {
+		if (!fasync) {
+			spin_unlock_irq(&snd_fasync_lock);
+			return 0;
+		}
+		*fasyncp = fasync;
+	}
+	fasync->on = on;
+	spin_unlock_irq(&snd_fasync_lock);
+	return fasync_helper(fd, file, on, &fasync->fasync);
+}
+EXPORT_SYMBOL_GPL(snd_fasync_helper);
+
+void snd_kill_fasync(struct snd_fasync *fasync, int signal, int poll)
+{
+	unsigned long flags;
+
+	if (!fasync || !fasync->on)
+		return;
+	spin_lock_irqsave(&snd_fasync_lock, flags);
+	fasync->signal = signal;
+	fasync->poll = poll;
+	list_move(&fasync->list, &snd_fasync_list);
+	schedule_work(&snd_fasync_work);
+	spin_unlock_irqrestore(&snd_fasync_lock, flags);
+}
+EXPORT_SYMBOL_GPL(snd_kill_fasync);
+
+void snd_fasync_free(struct snd_fasync *fasync)
+{
+	if (!fasync)
+		return;
+	fasync->on = 0;
+	flush_work(&snd_fasync_work);
+	kfree(fasync);
+}
+EXPORT_SYMBOL_GPL(snd_fasync_free);
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 596ba572d6c4..1f5f05e76e59 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -74,7 +74,7 @@ struct snd_timer_user {
 	unsigned int filter;
 	struct timespec tstamp;		/* trigger tstamp */
 	wait_queue_head_t qchange_sleep;
-	struct fasync_struct *fasync;
+	struct snd_fasync *fasync;
 	struct mutex ioctl_lock;
 };
 
@@ -1293,7 +1293,7 @@ static void snd_timer_user_interrupt(struct snd_timer_instance *timeri,
 	}
       __wake:
 	spin_unlock(&tu->qlock);
-	kill_fasync(&tu->fasync, SIGIO, POLL_IN);
+	snd_kill_fasync(tu->fasync, SIGIO, POLL_IN);
 	wake_up(&tu->qchange_sleep);
 }
 
@@ -1330,7 +1330,7 @@ static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
 	spin_lock_irqsave(&tu->qlock, flags);
 	snd_timer_user_append_to_tqueue(tu, &r1);
 	spin_unlock_irqrestore(&tu->qlock, flags);
-	kill_fasync(&tu->fasync, SIGIO, POLL_IN);
+	snd_kill_fasync(tu->fasync, SIGIO, POLL_IN);
 	wake_up(&tu->qchange_sleep);
 }
 
@@ -1397,7 +1397,7 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 	spin_unlock(&tu->qlock);
 	if (append == 0)
 		return;
-	kill_fasync(&tu->fasync, SIGIO, POLL_IN);
+	snd_kill_fasync(tu->fasync, SIGIO, POLL_IN);
 	wake_up(&tu->qchange_sleep);
 }
 
@@ -1439,6 +1439,7 @@ static int snd_timer_user_release(struct inode *inode, struct file *file)
 		if (tu->timeri)
 			snd_timer_close(tu->timeri);
 		mutex_unlock(&tu->ioctl_lock);
+		snd_fasync_free(tu->fasync);
 		kfree(tu->queue);
 		kfree(tu->tqueue);
 		kfree(tu);
@@ -2026,7 +2027,7 @@ static int snd_timer_user_fasync(int fd, struct file * file, int on)
 	struct snd_timer_user *tu;
 
 	tu = file->private_data;
-	return fasync_helper(fd, file, on, &tu->fasync);
+	return snd_fasync_helper(fd, file, on, &tu->fasync);
 }
 
 static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index d6e079f4ec09..351cb1fbb48d 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -409,6 +409,7 @@ static const struct snd_pci_quirk cs420x_fixup_tbl[] = {
 
 	/* codec SSID */
 	SND_PCI_QUIRK(0x106b, 0x0600, "iMac 14,1", CS420X_IMAC27_122),
+	SND_PCI_QUIRK(0x106b, 0x0900, "iMac 12,1", CS420X_IMAC27_122),
 	SND_PCI_QUIRK(0x106b, 0x1c00, "MacBookPro 8,1", CS420X_MBP81),
 	SND_PCI_QUIRK(0x106b, 0x2000, "iMac 12,2", CS420X_IMAC27_122),
 	SND_PCI_QUIRK(0x106b, 0x2800, "MacBookPro 10,1", CS420X_MBP101),
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5a3dd06ff105..49e300255505 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -238,6 +238,7 @@ enum {
 	CXT_PINCFG_LEMOTE_A1205,
 	CXT_PINCFG_COMPAQ_CQ60,
 	CXT_FIXUP_STEREO_DMIC,
+	CXT_PINCFG_LENOVO_NOTEBOOK,
 	CXT_FIXUP_INC_MIC_BOOST,
 	CXT_FIXUP_HEADPHONE_MIC_PIN,
 	CXT_FIXUP_HEADPHONE_MIC,
@@ -698,6 +699,14 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_stereo_dmic,
 	},
+	[CXT_PINCFG_LENOVO_NOTEBOOK] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x05d71030 },
+			{ }
+		},
+		.chain_id = CXT_FIXUP_STEREO_DMIC,
+	},
 	[CXT_FIXUP_INC_MIC_BOOST] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt5066_increase_mic_boost,
@@ -860,7 +869,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3905, "Lenovo G50-30", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x390b, "Lenovo G50-80", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
-	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_PINCFG_LENOVO_NOTEBOOK),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo G50-70", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 58f03b0bb4c4..8c7166f8b295 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5709,6 +5709,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
+	SND_PCI_QUIRK(0x1028, 0x053c, "Dell Latitude E5430", ALC292_FIXUP_DELL_E7X),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
 	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell Latitude E6440", ALC292_FIXUP_DELL_E7X),
 	SND_PCI_QUIRK(0x1028, 0x05be, "Dell Latitude E6540", ALC292_FIXUP_DELL_E7X),
diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 0d9c4a57301b..47f2439fd7b0 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -141,7 +141,9 @@ static DECLARE_TLV_DB_SCALE(mic_tlv, 1600, 100, 0);
 
 static DECLARE_TLV_DB_SCALE(pga_tlv, -600, 50, 0);
 
-static DECLARE_TLV_DB_SCALE(mix_tlv, -50, 50, 0);
+static DECLARE_TLV_DB_SCALE(pass_tlv, -6000, 50, 0);
+
+static DECLARE_TLV_DB_SCALE(mix_tlv, -5150, 50, 0);
 
 static DECLARE_TLV_DB_SCALE(beep_tlv, -56, 200, 0);
 
@@ -355,7 +357,7 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
 			      CS42L52_SPKB_VOL, 0, 0x40, 0xC0, hl_tlv),
 
 	SOC_DOUBLE_R_SX_TLV("Bypass Volume", CS42L52_PASSTHRUA_VOL,
-			      CS42L52_PASSTHRUB_VOL, 0, 0x88, 0x90, pga_tlv),
+			      CS42L52_PASSTHRUB_VOL, 0, 0x88, 0x90, pass_tlv),
 
 	SOC_DOUBLE("Bypass Mute", CS42L52_MISC_CTL, 4, 5, 1, 0),
 
@@ -368,7 +370,7 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
 			      CS42L52_ADCB_VOL, 0, 0xA0, 0x78, ipd_tlv),
 	SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
 			     CS42L52_ADCA_MIXER_VOL, CS42L52_ADCB_MIXER_VOL,
-				0, 0x19, 0x7F, ipd_tlv),
+				0, 0x19, 0x7F, mix_tlv),
 
 	SOC_DOUBLE("ADC Switch", CS42L52_ADC_MISC_CTL, 0, 1, 1, 0),
 
diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index a2535a7eb4bb..f9f8a9112ff8 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -405,9 +405,9 @@ static const struct snd_kcontrol_new cs42l56_snd_controls[] = {
 	SOC_DOUBLE("ADC Boost Switch", CS42L56_GAIN_BIAS_CTL, 3, 2, 1, 1),
 
 	SOC_DOUBLE_R_SX_TLV("Headphone Volume", CS42L56_HPA_VOLUME,
-			      CS42L56_HPB_VOLUME, 0, 0x84, 0x48, hl_tlv),
+			      CS42L56_HPB_VOLUME, 0, 0x44, 0x48, hl_tlv),
 	SOC_DOUBLE_R_SX_TLV("LineOut Volume", CS42L56_LOA_VOLUME,
-			      CS42L56_LOB_VOLUME, 0, 0x84, 0x48, hl_tlv),
+			      CS42L56_LOB_VOLUME, 0, 0x44, 0x48, hl_tlv),
 
 	SOC_SINGLE_TLV("Bass Shelving Volume", CS42L56_TONE_CTL,
 			0, 0x00, 1, tone_tlv),
diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index cb47fb595ff4..5a16020423fe 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -351,22 +351,22 @@ static const struct snd_kcontrol_new cs53l30_snd_controls[] = {
 	SOC_ENUM("ADC2 NG Delay", adc2_ng_delay_enum),
 
 	SOC_SINGLE_SX_TLV("ADC1A PGA Volume",
-		    CS53L30_ADC1A_AFE_CTL, 0, 0x34, 0x18, pga_tlv),
+		    CS53L30_ADC1A_AFE_CTL, 0, 0x34, 0x24, pga_tlv),
 	SOC_SINGLE_SX_TLV("ADC1B PGA Volume",
-		    CS53L30_ADC1B_AFE_CTL, 0, 0x34, 0x18, pga_tlv),
+		    CS53L30_ADC1B_AFE_CTL, 0, 0x34, 0x24, pga_tlv),
 	SOC_SINGLE_SX_TLV("ADC2A PGA Volume",
-		    CS53L30_ADC2A_AFE_CTL, 0, 0x34, 0x18, pga_tlv),
+		    CS53L30_ADC2A_AFE_CTL, 0, 0x34, 0x24, pga_tlv),
 	SOC_SINGLE_SX_TLV("ADC2B PGA Volume",
-		    CS53L30_ADC2B_AFE_CTL, 0, 0x34, 0x18, pga_tlv),
+		    CS53L30_ADC2B_AFE_CTL, 0, 0x34, 0x24, pga_tlv),
 
 	SOC_SINGLE_SX_TLV("ADC1A Digital Volume",
-		    CS53L30_ADC1A_DIG_VOL, 0, 0xA0, 0x0C, dig_tlv),
+		    CS53L30_ADC1A_DIG_VOL, 0, 0xA0, 0x6C, dig_tlv),
 	SOC_SINGLE_SX_TLV("ADC1B Digital Volume",
-		    CS53L30_ADC1B_DIG_VOL, 0, 0xA0, 0x0C, dig_tlv),
+		    CS53L30_ADC1B_DIG_VOL, 0, 0xA0, 0x6C, dig_tlv),
 	SOC_SINGLE_SX_TLV("ADC2A Digital Volume",
-		    CS53L30_ADC2A_DIG_VOL, 0, 0xA0, 0x0C, dig_tlv),
+		    CS53L30_ADC2A_DIG_VOL, 0, 0xA0, 0x6C, dig_tlv),
 	SOC_SINGLE_SX_TLV("ADC2B Digital Volume",
-		    CS53L30_ADC2B_DIG_VOL, 0, 0xA0, 0x0C, dig_tlv),
+		    CS53L30_ADC2B_DIG_VOL, 0, 0xA0, 0x6C, dig_tlv),
 };
 
 static const struct snd_soc_dapm_widget cs53l30_dapm_widgets[] = {
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 06bae3b23fce..2b0342bcede4 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -404,6 +404,7 @@ static int wm5110_put_dre(struct snd_kcontrol *kcontrol,
 	unsigned int rnew = (!!ucontrol->value.integer.value[1]) << mc->rshift;
 	unsigned int lold, rold;
 	unsigned int lena, rena;
+	bool change = false;
 	int ret;
 
 	snd_soc_dapm_mutex_lock(dapm);
@@ -431,8 +432,8 @@ static int wm5110_put_dre(struct snd_kcontrol *kcontrol,
 		goto err;
 	}
 
-	ret = regmap_update_bits(arizona->regmap, ARIZONA_DRE_ENABLE,
-				 mask, lnew | rnew);
+	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_DRE_ENABLE,
+				       mask, lnew | rnew, &change);
 	if (ret) {
 		dev_err(arizona->dev, "Failed to set DRE: %d\n", ret);
 		goto err;
@@ -445,6 +446,9 @@ static int wm5110_put_dre(struct snd_kcontrol *kcontrol,
 	if (!rnew && rold)
 		wm5110_clear_pga_volume(arizona, mc->rshift);
 
+	if (change)
+		ret = 1;
+
 err:
 	snd_soc_dapm_mutex_unlock(dapm);
 
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 0e8008d38161..d46881f96c16 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3861,6 +3861,7 @@ static int wm8962_runtime_suspend(struct device *dev)
 #endif
 
 static const struct dev_pm_ops wm8962_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(wm8962_runtime_suspend, wm8962_runtime_resume, NULL)
 };
 
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 90ba5521c189..4fda8c24be29 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -535,7 +535,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 	if (mc->platform_max && tmp > mc->platform_max)
 		return -EINVAL;
-	if (tmp > mc->max - mc->min + 1)
+	if (tmp > mc->max - mc->min)
 		return -EINVAL;
 
 	if (invert)
@@ -556,7 +556,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 			return -EINVAL;
 		if (mc->platform_max && tmp > mc->platform_max)
 			return -EINVAL;
-		if (tmp > mc->max - mc->min + 1)
+		if (tmp > mc->max - mc->min)
 			return -EINVAL;
 
 		if (invert)
diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index d060dddcc52d..379bdf26e985 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -350,7 +350,8 @@ static int bcd2000_init_midi(struct bcd2000 *bcd2k)
 static void bcd2000_free_usb_related_resources(struct bcd2000 *bcd2k,
 						struct usb_interface *interface)
 {
-	/* usb_kill_urb not necessary, urb is aborted automatically */
+	usb_kill_urb(bcd2k->midi_out_urb);
+	usb_kill_urb(bcd2k->midi_in_urb);
 
 	usb_free_urb(bcd2k->midi_out_urb);
 	usb_free_urb(bcd2k->midi_in_urb);
