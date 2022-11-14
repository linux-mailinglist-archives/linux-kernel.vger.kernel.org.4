Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B466288D4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiKNTD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNTDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:03:24 -0500
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE1CF14;
        Mon, 14 Nov 2022 11:03:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7C29E2FE8;
        Mon, 14 Nov 2022 20:03:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1668452598; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=RjxAd0MgBEhd0sL2TUmwIKMx51G8GuXJVqiXT18nAGg=;
        b=JjHQTFQssQyKpJKVzRBu7Jik6KtpMYfQ0mM7qRVA+uJAjjr/raaMppboEIM6IIyT9fgszm
        sYRZRWsJVQKb/CBJeMkYBBehkHrqt2VGpS6bmhEzHEAS8r3S1GAukC99IrPsCnnV+vQdaw
        FzQMV+U56DxhtTwp62/W/Dw2BAHLPqAcXsxB6UCe8aKz1f4rGgsx0d8dif76OCViHWdxzq
        4dr9u9iy7bKujUoVCf3dpi1fliCoy58ycTCGk6EntXOj3HFkNB+Ak7h8exvaKnHYfcIjCR
        JrDfJ2kycAtyHzp+GD6iEgIFrzmkYCbvSYDw5sVsl6Nw8F7l5+xSKhy3s6X9Fw==
Date:   Mon, 14 Nov 2022 20:03:13 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: [ANNOUNCE] 4.19.261-rt116
Message-ID: <166845241635.12044.11510831858945534704@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_ABUSE_SURBL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.261-rt116 stable release.

This is just an update to the latest stable release. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: edd6d572bf0f165405ed98d1b5ed3f191a9fb33b

Or to build 4.19.261-rt116 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.261.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.261-rt116.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.255-rt114:
---

Adrian Hunter (1):
      perf kcore_copy: Do not check /proc/modules is unchanged

Al Viro (6):
      nios2: page fault et.al. are *not* restartable syscalls...
      nios2: don't leave NULLs in sys_call_table[]
      nios2: traced syscall does need to check the syscall number
      nios2: fix syscall restart checks
      nios2: restarts apply only to the first sigframe we build...
      nios2: add force_successful_syscall_return()

Alan Brady (1):
      i40e: Fix to stop tx_timeout recovery if GLOBR fails

Alan Stern (2):
      USB: core: Prevent nested device-reset calls
      USB: core: Fix RST error in hub.c

Alexander Gordeev (1):
      s390/zcore: fix race when reading from hardware system area

Alexander Lobakin (2):
      ia64, processor: fix -Wincompatible-pointer-types in ia64_get_irr()
      x86/olpc: fix 'logical not is only applied to the left hand side'

Alexander Shishkin (3):
      intel_th: pci: Add Raptor Lake-S CPU support
      intel_th: pci: Add Raptor Lake-S PCH support
      intel_th: pci: Add Meteor Lake-P support

Alexander Stein (4):
      ARM: dts: imx6ul: add missing properties for sram
      ARM: dts: imx6ul: change operating-points to uint32-matrix
      ARM: dts: imx6ul: fix lcdif node compatible
      ARM: dts: imx6ul: fix qspi node compatible

Alexander Sverdlin (1):
      MIPS: OCTEON: irq: Fix octeon_irq_force_ciu_mapping()

Alexey Kodanev (2):
      drm/radeon: fix potential buffer overflow in ni_set_mc_special_registers()
      wifi: iwlegacy: 4965: fix potential off-by-one overflow in il4965_rs_fill_link_cmd()

Alistair Popple (1):
      mm/migrate_device.c: flush TLB while holding PTL

Allen Ballway (1):
      ALSA: hda/cirrus - support for iMac 12,1 model

Amadeusz Sławiński (1):
      ALSA: info: Fix llseek return value when using callback

Ammar Faizi (1):
      wifi: wil6210: debugfs: fix uninitialized variable use in `wil_write_file_wmi()`

Andrew Donnellan (1):
      gcc-plugins: Undefine LATENT_ENTROPY_PLUGIN when plugin disabled for a file

Andy Shevchenko (1):
      platform/x86: pmc_atom: Fix SLP_TYPx bitfield mask

AngeloGioacchino Del Regno (1):
      media: platform: mtk-mdp: Fix mdp_ipi_comm structure alignment

Anquan Wu (1):
      libbpf: Fix the name of a reused map

Ard Biesheuvel (1):
      efi: libstub: check Shim mode using MokSBStateRT

Armin Wolf (1):
      hwmon: (gpio-fan) Fix array out of bounds access

Arnaldo Carvalho de Melo (1):
      genelf: Use HAVE_LIBCRYPTO_SUPPORT, not the never defined HAVE_LIBCRYPTO

Artem Borisov (1):
      HID: alps: Declare U1_UNICORN_LEGACY support

Baokun Li (4):
      ext4: add EXT4_INODE_HAS_XATTR_SPACE macro in xattr.h
      ext4: fix use-after-free in ext4_xattr_set_entry
      ext4: correct max_inline_xattr_value_size computing
      ext4: correct the misjudgment in ext4_iget_extra_inode

Bart Van Assche (1):
      nvmet: fix a use-after-free

Basavaraj Natikar (1):
      pinctrl: amd: Don't save/restore interrupt status and wake status bits

Benjamin Poirier (1):
      net: team: Unsync device addresses on ndo_stop

Bernard Pidoux (1):
      rose: check NULL rose_loopback_neigh->loopback

Bo-Chen Chen (1):
      drm/mediatek: dpi: Remove output format of YUV

Brett Creeley (1):
      iavf: Fix cached head and tail value for iavf_get_tx_pending

Brian Foster (1):
      s390: fix double free of GS and RI CBs on fork() failure

Brian Norris (3):
      drm/rockchip: vop: Don't crash for invalid duplicate_state()
      tracefs: Only clobber mode/uid/gid on remount if asked
      Revert "drm: bridge: analogix/dp: add panel prepare/unprepare in suspend/resume time"

Callum Osmotherly (1):
      ALSA: hda/realtek: Enable 4-speaker output Dell Precision 5530 laptop

Candice Li (1):
      drm/amdgpu: Check num_gfx_rings for gfx v9_0 rb setup.

Carl Yin(殷张成) (1):
      USB: serial: option: add Quectel BG95 0x0203 composition

Carlos Llamas (1):
      binder: fix UAF of ref->proc caused by race condition

Celeste Liu (1):
      riscv: mmap with PROT_WRITE but no PROT_READ is invalid

Chaitanya Kulkarni (1):
      nvme: add new line after variable declatation

Chao Yu (2):
      f2fs: fix to avoid use f2fs_bug_on() in f2fs_new_node_page()
      mm/slub: fix to return errno if kmalloc() fails

Chen Zhongjin (3):
      profiling: fix shift too large makes kernel panic
      kprobes: Forbid probing on trampoline and BPF code areas
      x86/unwind/orc: Unwind ftrace trampolines with correct ORC entry

Chen-Yu Tsai (2):
      clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops
      clk: core: Fix runtime PM sequence in clk_core_unprepare()

ChenXiaoSong (1):
      ntfs: fix BUG_ON in ntfs_lookup_inode_by_name()

Chris Mi (1):
      RDMA/mlx5: Set local port to one when accessing counters

Christian A. Ehrhardt (1):
      kprobes: Prohibit probes in gate area

Christophe JAILLET (8):
      wifi: p54: Fix an error handling path in p54spi_probe()
      misc: rtsx: Fix an error handling path in rtsx_pci_probe()
      memstick/ms_block: Fix some incorrect memory allocation
      memstick/ms_block: Fix a memory leak
      ASoC: qcom: q6dsp: Fix an off-by-one in q6adm_alloc_copp()
      mmc: pxamci: Fix another error handling path in pxamci_probe()
      mmc: pxamci: Fix an error handling path in pxamci_probe()
      cxl: Fix a memory leak in an error handling path

Christophe Leroy (3):
      powerpc/32: Do not allow selection of e5500 or e6500 CPUs on PPC32
      powerpc/mm: Split dump_pagelinuxtables flag_array table
      powerpc/ptdump: Fix display of RW pages on FSL_BOOK3E

Colin Ian King (1):
      drm/i915/reg: Fix spelling mistake "Unsupport" -> "Unsupported"

Cong Wang (1):
      kcm: fix strp_init() order and cleanup

Csókás Bence (1):
      fec: Fix timer capture timing in `fec_ptp_enable_pps()`

Damien Le Moal (1):
      ata: libata-eh: Add missing command name

Dan Carpenter (10):
      wifi: rtlwifi: fix error codes in rtl_debugfs_set_write_h2c()
      wifi: wil6210: debugfs: fix info leak in wil_write_file_wmi()
      platform/olpc: Fix uninitialized data in debugfs write
      null_blk: fix ida error handling in null_add_dev()
      kfifo: fix kfifo_to_user() return type
      NTB: ntb_tool: uninitialized heap data in tool_fn_write()
      xen/xenbus: fix return type in xenbus_file_read()
      wifi: cfg80211: debugfs: fix return type in ht40allow_map_read()
      staging: rtl8712: fix use after free bugs
      tipc: fix shift wrapping bug in map_get()

Daniel Bristot de Oliveira (1):
      sched/deadline: Unthrottle PI boosted threads while enqueuing

Daniel Starke (6):
      tty: n_gsm: fix non flow control frames during mux flow off
      tty: n_gsm: fix packet re-transmission without open control channel
      tty: n_gsm: fix race condition in gsmld_write()
      tty: n_gsm: fix wrong T1 retry count handling
      tty: n_gsm: fix DM command
      tty: n_gsm: fix missing corner cases in gsmld_poll()

Daniel Wagner (4):
      Merge tag 'v4.19.257' into v4.19-rt
      Linux 4.19.257-rt115
      Merge tag 'v4.19.261' into v4.19-rt
      Linux 4.19.261-rt116

Dave Stevenson (1):
      drm/vc4: dsi: Correct DSI divider calculations

David Collins (1):
      spmi: trace: fix stack-out-of-bound access in SPMI tracing functions

David Hildenbrand (1):
      mm/hugetlb: fix hugetlb not supporting softdirty tracking

David Howells (2):
      vfs: Check the truncate maximum size in inode_newsize_ok()
      rxrpc: Fix local destruction being repeated

David Leadbeater (2):
      netfilter: nf_conntrack_irc: Fix forged IP logic
      netfilter: nf_conntrack_irc: Tighten matching on DCC message

David Lebrun (1):
      ipv6: sr: fix out-of-bounds read when setting HMAC data.

Denis V. Lunev (1):
      neigh: fix possible DoS due to net iface start/stop loop

Dongliang Mu (1):
      media: pvrusb2: fix memory leak in pvr_probe

Dongxiang Ke (1):
      ALSA: usb-audio: Fix an out-of-bounds bug in __snd_usb_parse_audio_interface()

Douglas Anderson (1):
      drm/msm/dsi: Fix number of regulators for msm8996_dsi_cfg

Duoming Zhou (4):
      mtd: sm_ftl: Fix deadlock caused by cancel_work_sync in sm_release
      staging: rtl8192u: Fix sleep in atomic context bug in dm_fsync_timer_callback
      atm: idt77252: fix use-after-free bugs caused by tst_timer
      ethernet: rocker: fix sleep in atomic context bug in neigh_timer_handler

Enguerrand de Ribaucourt (2):
      net: dp83822: disable false carrier interrupt
      net: dp83822: disable rx error interrupt

Eric Dumazet (3):
      net: rose: fix netdev reference changes
      tcp: fix over estimation in sk_forced_mem_schedule()
      tcp: annotate data-race around challenge_timestamp

Eric Farman (1):
      vfio/ccw: Do not change FSM state in subchannel event

Eric Whitney (1):
      ext4: fix extent status tree race in writeback error recovery path

Eugen Hristev (1):
      mmc: sdhci-of-at91: fix set_uhs_signaling rewriting of MC1R

Fabio Estevam (1):
      arm64: dts: rockchip: Remove 'enable-active-low' from rk3399-puma

Felipe Balbi (2):
      usb: dwc3: pci: Add Support for Intel Elkhart Lake Devices
      usb: dwc3: pci: add support for TigerLake Devices

Filipe Manana (1):
      btrfs: fix lost error handling when looking up extended ref on log replay

Florian Fainelli (2):
      tools/thermal: Fix possible path truncations
      clk: iproc: Do not rely on node name for correct PLL setup

Florian Westphal (3):
      netfilter: nf_tables: fix null deref due to zeroed list head
      netfilter: ebtables: reject blobs that don't provide all entry points
      netfilter: ebtables: fix memory leak when blob is malformed

Francis Laniel (1):
      arm64: Do not forget syscall when starting a new thread.

Frank Wunderlich (1):
      net: usb: qmi_wwan: Add new usb-id for Dell branded EM7455

Fudong Wang (1):
      drm/amd/display: clear optc underflow before turn off odm clock

Gaosheng Cui (1):
      audit: fix potential double free on error path from fsnotify_add_inode_mark

Geert Uytterhoeven (1):
      netfilter: conntrack: NF_CONNTRACK_PROCFS should no longer default to y

Gerald Schaefer (2):
      s390/mm: do not trigger write fault when vma does not allow VM_WRITE
      s390/hugetlb: fix prepare_hugepage_range() check for 2 GB hugepages

Goldwyn Rodrigues (1):
      btrfs: check if root is readonly while setting security xattr

Greg Kroah-Hartman (8):
      Linux 4.19.256
      Linux 4.19.257
      debugfs: add debugfs_lookup_and_remove()
      Linux 4.19.258
      Linux 4.19.259
      mvpp2: no need to check return value of debugfs_create functions
      Linux 4.19.260
      Linux 4.19.261

Greg Tulli (1):
      Input: iforce - add support for Boeder Force Feedback Wheel

Guenter Roeck (1):
      lib/list_debug.c: Detect uninitialized lists

Guoqing Jiang (1):
      md: call __md_stop_writes in md_stop

Hangyu Hua (3):
      drm: bridge: sii8620: fix possible off-by-one
      wifi: libertas: Fix possible refcount leak in if_usb_probe()
      dccp: put dccp_qpolicy_full() and dccp_qpolicy_push() in the same lock

Hans de Goede (2):
      ACPI: EC: Remove duplicate ThinkPad X1 Carbon 6th entry from DMI quirks
      platform/x86: acer-wmi: Acer Aspire One AOD270/Packard Bell Dot keymap fixes

Harsh Modi (1):
      netfilter: br_netfilter: Drop dst references before setting.

Harshit Mogalapalli (1):
      HID: cp2112: prevent a buffer overflow in cp2112_xfer()

Hector Martin (1):
      locking/atomic: Make test_and_*_bit() ordered on failure

Heikki Krogerus (3):
      usb: dwc3: pci: add support for the Intel Tiger Lake PCH -H variant
      usb: dwc3: pci: add support for the Intel Jasper Lake
      usb: dwc3: pci: add support for the Intel Alder Lake-S

Heiner Kallweit (1):
      usb: dwc2: fix wrong order of phy_power_on and phy_init

Helge Deller (5):
      fbcon: Fix boundary checks for fbcon=vc:n1-n2 parameters
      parisc: Fix device names in /proc/iomem
      parisc: Fix exception handler for fldw and fstw instructions
      vt: Clear selection before changing the font
      parisc: Add runtime check to prevent PA2.0 kernels on PA1.x machines

Herbert Xu (1):
      af_key: Do not call xfrm_probe_algs in parallel

Hongling Zeng (3):
      uas: add no-uas quirk for Hiksemi usb_disk
      usb-storage: Add Hiksemi USB3-FW to IGNORE_UAS
      uas: ignore UAS for Thinkplus chips

Hsin-Yi Wang (1):
      arm64: map FDT as RW for early_init_dt_scan()

Hu Xiaoying (1):
      usb: storage: Add ASUS <0x0b05:0x1932> to IGNORE_UAS

Huacai Chen (1):
      MIPS: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Hui Su (1):
      kernel/sched: Remove dl_boosted flag comment

Hyunwoo Kim (2):
      efi: capsule-loader: Fix use-after-free in efi_capsule_write
      video: fbdev: pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write

Igor Ryzhov (1):
      netfilter: nf_conntrack_sip: fix ct_sip_walk_headers

Ilpo Järvinen (3):
      serial: 8250_dw: Store LSR into lsr_saved_flags in dw8250_tx_wait_empty()
      serial: Create uart_xmit_advance()
      serial: tegra: Use uart_xmit_advance(), fixes icount.tx accounting

Isaac J. Manjarres (1):
      driver core: Don't probe devices after bus_type.match() probe deferral

Ivan Vecera (1):
      i40e: Fix kernel crash during module removal

Jacob Keller (1):
      ixgbe: stop resetting SYSTIME in ixgbe_ptp_start_cyclecounter

Jakub Kicinski (2):
      netdevsim: Avoid allocation warnings triggered from user space
      Revert "sch_cake: Return __NET_XMIT_STOLEN when consuming enqueued skb"

Jamal Hadi Salim (1):
      net_sched: cls_route: disallow handle of 0

Jan Kara (2):
      ext2: Add more validity checks for inode counts
      ext4: make directory inode spreading reflect flexbg size

Jann Horn (3):
      mm: Force TLB flush for PFNMAP mappings before unlink_file_vma()
      mm/rmap: Fix anon_vma->degree ambiguity leading to double-reuse
      mm: Fix TLB flush for not-first PFNMAP mappings in unmap_region()

Jason A. Donenfeld (1):
      fs: check FMODE_LSEEK to control internal pipe splicing

Jason Wang (1):
      HID: ishtp-hid-clientHID: ishtp-hid-client: Fix comment typo

Jens Wiklander (1):
      tee: add overflow check in register_shm_helper()

Jeongik Cha (1):
      wifi: mac80211_hwsim: fix race condition in pending packet

Jiachen Zhang (1):
      ovl: drop WARN_ON() dentry is NULL in ovl_encode_fh()

Jianglei Nie (1):
      RDMA/hfi1: fix potential memory leak in setup_base_ctxt()

Jiasheng Jiang (3):
      drm: bridge: adv7511: Add check for mipi_dsi_driver_register
      Bluetooth: hci_intel: Add check for platform_driver_register
      ASoC: codecs: da7210: add check for i2c_add_driver

Jing Leng (1):
      kbuild: Fix include path in scripts/Makefile.modpost

Johan Hovold (7):
      x86/pmem: Fix platform-device leak in error path
      USB: serial: fix tty-port initialized comments
      USB: serial: cp210x: add Decagon UCA device id
      usb: dwc3: fix PHY disable sequence
      USB: serial: ch341: fix lost character on LCR updates
      USB: serial: ch341: fix disabled rx timer on older devices
      usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup

Johannes Berg (2):
      wifi: mac80211_hwsim: add back erroneously removed cast
      wifi: mac80211_hwsim: use 32-bit skb cookie

John Johansen (4):
      apparmor: fix quiet_denied for file rules
      apparmor: fix absroot causing audited secids to begin with =
      apparmor: Fix failed mount permission check error message
      apparmor: fix overlapping attachment computation

Jonathan Toppins (1):
      bonding: 802.3ad: fix no transmission of LACPDUs

Jose Alonso (1):
      Revert "net: usb: ax88179_178a needs FLAG_SEND_ZLP"

Josh Poimboeuf (2):
      scripts/faddr2line: Fix vmlinux detection on arm64
      s390: fix nospec table alignments

Jozef Martiniak (1):
      gadgetfs: ep_io - wait until IRQ finishes

Juergen Gross (1):
      s390/hypfs: avoid error message under KVM

Juri Lelli (1):
      sched/deadline: Fix priority inheritance with multiple scheduling classes

Kai Vehmanen (1):
      ALSA: hda: add Intel 5 Series / 3400 PCI DID

Kai-Heng Feng (1):
      tg3: Disable tg3 device on system reboot to avoid triggering AER

Karthik Alapati (1):
      HID: hidraw: fix memory leak in hidraw_release()

Kiselev, Oleg (1):
      ext4: avoid resizing to a partial cluster size

Krishna Kurapati (1):
      usb: gadget: mass_storage: Fix cdrom data transfers on MAC-OS

Krzysztof Kozlowski (3):
      ARM: dts: ast2500-evb: fix board compatible
      ARM: dts: qcom: pm8841: add required thermal-sensor-cells
      ath10k: do not enforce interrupt trigger type

Kuniyuki Iwashima (10):
      net: Fix data-races around weight_p and dev_weight_[rt]x_bias.
      net: Fix data-races around netdev_tstamp_prequeue.
      ratelimit: Fix data-races in ___ratelimit().
      net: Fix a data-race around sysctl_tstamp_allow_data.
      net: Fix a data-race around sysctl_net_busy_poll.
      net: Fix a data-race around sysctl_net_busy_read.
      net: Fix a data-race around netdev_budget.
      net: Fix a data-race around netdev_budget_usecs.
      net: Fix a data-race around sysctl_somaxconn.
      kprobes: don't call disarm_kprobe() for disabled kprobes

Lars-Peter Clausen (1):
      i2c: cadence: Support PEC for SMBus block read

Laurent Dufour (1):
      watchdog: export lockup_detector_reconfigure

Lee Jones (1):
      HID: steam: Prevent NULL pointer dereference in steam_{recv,send}_report

Leo Li (1):
      drm/amdgpu: Check BO's requested pinning domains against its preferred_domains

Letu Ren (1):
      fbdev: fb_pm2fb: Avoid potential divide by zero error

Li Lingfeng (1):
      ext4: recover csum seed of tmp_inode after migrating to extents

Li Qiong (2):
      parisc: ccio-dma: Handle kmalloc failure in ccio_init_resources()
      ieee802154: cc2520: add rc code in cc2520_tx()

Liang He (16):
      ARM: OMAP2+: display: Fix refcount leak bug
      regulator: of: Fix refcount leak bug in of_get_regulation_constraints()
      mediatek: mt76: mac80211: Fix missing of_node_put() in mt76_led_init()
      i2c: mux-gpmux: Add of_node_put() when breaking out of loop
      gpio: gpiolib-of: Fix refcount bugs in of_mm_gpiochip_add_data()
      mmc: cavium-octeon: Add of_node_put() when breaking out of loop
      mmc: cavium-thunderx: Add of_node_put() when breaking out of loop
      iommu/arm-smmu: qcom_iommu: Add of_node_put() when breaking out of loop
      video: fbdev: amba-clcd: Fix refcount leak bugs
      drm/meson: Fix refcount bugs in meson_vpu_has_available_connectors()
      usb: host: ohci-ppc-of: Fix refcount leak bug
      usb: renesas: Fix refcount leak bug
      tty: serial: Fix refcount leak bug in ucc_uart.c
      mips: cavium-octeon: Fix missing of_node_put() in octeon2_usb_clocks_start
      soc: brcmstb: pm-arm: Fix refcount leak and __iomem leak bugs
      of: mdio: Add of_node_put() when breaking out of for_each_xx

Lieven Hey (1):
      perf jit: Include program header in ELF files

Lin Ma (2):
      igb: Add lock to avoid data race
      ieee802154/adf7242: defer destroy_workqueue call

Linus Torvalds (1):
      fs: only do a memory barrier for the first set_buffer_uptodate()

Linus Walleij (1):
      ARM: dts: integrator: Tag PCI host with device_type

Lu Wei (1):
      ipvlan: Fix out-of-bound bugs caused by unset skb->mac_header

Lucas Stach (1):
      sched/deadline: Fix stale throttling on de-/boosted tasks

Luiz Augusto von Dentz (2):
      Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
      Bluetooth: L2CAP: Fix build errors in some archs

Lukas Czerner (1):
      ext4: make sure ext4_append() always allocates new block

Lukas Wunner (1):
      usbnet: Fix linkwatch use-after-free on disconnect

Maciej S. Szmigiero (1):
      KVM: SVM: Don't BUG if userspace injects an interrupt with GIF=0

Maciej Żenczykowski (1):
      net: ipvtap - add __init/__exit annotations to module init/exit funcs

Mahesh Rajashekhara (1):
      scsi: smartpqi: Fix DMA direction for RAID requests

Manyi Li (1):
      ACPI: PM: save NVS memory for Lenovo G40-45

Marc Kleine-Budde (2):
      can: ems_usb: fix clang's -Wunaligned-access warning
      can: gs_usb: gs_can_open(): fix race dev->can.state condition

Marco Pagani (1):
      fpga: altera-pr-ip: fix unsigned comparison with less than zero

Markus Mayer (1):
      thermal/tools/tmon: Include pthread and time headers in tmon.h

Mathias Nyman (2):
      Revert "xhci: turn off port power in shutdown"
      xhci: Add grace period after xHC start to prevent premature runtime suspend.

Matthias May (1):
      geneve: do not use RT_TOS for IPv6 flowlabel

Maurizio Lombardi (1):
      mm: prevent page_frag_alloc() from corrupting the memory

Maxim Mikityanskiy (2):
      net/mlx5e: Fix the value of MLX5E_MAX_RQ_NUM_MTTS
      bpf: Fix the off-by-two error in range markings

Mel Gorman (1):
      mm/page_alloc: fix race condition between build_all_zonelists and page allocation

Meng Tang (1):
      ALSA: hda/conexant: Add quirk for LENOVO 20149 Notebook model

Miaohe Lin (1):
      mm/mmap.c: fix missing call to vm_unacct_memory in mmap_region

Miaoqian Lin (17):
      meson-mx-socinfo: Fix refcount leak in meson_mx_socinfo_init
      ARM: bcm: Fix refcount leak in bcm_kona_smc_init
      ARM: OMAP2+: Fix refcount leak in omap3xxx_prm_late_init
      cpufreq: zynq: Fix refcount leak in zynq_get_revision
      mtd: maps: Fix refcount leak in of_flash_probe_versatile
      mtd: maps: Fix refcount leak in ap_flash_init
      usb: host: Fix refcount leak in ehci_hcd_ppc_of_probe
      usb: ohci-nxp: Fix refcount leak in ohci_hcd_nxp_probe
      mmc: sdhci-of-esdhc: Fix refcount leak in esdhc_signal_voltage_switch
      ASoC: mediatek: mt8173: Fix refcount leak in mt8173_rt5650_rt5676_dev_probe
      ASoC: mt6797-mt6351: Fix refcount leak in mt6797_mt6351_dev_probe
      ASoC: mediatek: mt8173-rt5650: Fix refcount leak in mt8173_rt5650_dev_probe
      rpmsg: qcom_smd: Fix refcount leak in qcom_smd_parse_edge
      powerpc/spufs: Fix refcount leak in spufs_init_isolated_loader
      powerpc/xive: Fix refcount leak in xive_get_max_prio
      powerpc/cell/axon_msi: Fix refcount leak in setup_msi_msg_address
      pinctrl: nomadik: Fix refcount leak in nmk_pinctrl_dt_subnode_to_map

Michael Ellerman (3):
      powerpc/powernv: Avoid crashing if rng is NULL
      powerpc/pci: Fix PHB numbering when using opal-phbid
      powerpc/pci: Fix get_phb_number() locking

Michael Kelley (1):
      nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for nvme devices

Michael Walle (1):
      soc: fsl: guts: machine variable might be unset

Michal Jaron (2):
      i40e: Fix VF set max MTU size
      i40e: Fix set max_tx_rate when it is lower than 1 Mbps

Mika Westerberg (1):
      thunderbolt: Use the actual buffer in tb_async_error()

Mike Snitzer (1):
      dm: return early from dm_pr_call() if DM device is suspended

Miklos Szeredi (1):
      fuse: limit nsec

Mikulas Patocka (6):
      add barriers to buffer_uptodate and set_buffer_uptodate
      md-raid10: fix KASAN warning
      dm raid: fix address sanitizer warning in raid_resume
      dm raid: fix address sanitizer warning in raid_status
      dm writecache: set a default MAX_WRITEBACK_JOBS
      rds: add missing barrier to release_refill

Miquel Raynal (1):
      net: mac802154: Fix a condition in the receive path

Mohan Kumar (1):
      ALSA: hda/tegra: set depop delay for tegra

Narendra Hadke (1):
      serial: mvebu-uart: uart2 error bits clearing

Nathan Chancellor (1):
      MIPS: tlbex: Explicitly compare _PAGE_NO_EXEC against 0

Nathan Huckleberry (1):
      drm/rockchip: Fix return type of cdn_dp_connector_mode_valid

Neal Cardwell (1):
      tcp: fix early ETIMEDOUT after spurious non-SACK RTO

NeilBrown (1):
      SUNRPC: use _bh spinlocking on ->transport_lock

Nick Desaulniers (2):
      Makefile: link with -z noexecstack --no-warn-rwx-segments
      x86: link vdso and boot with -z noexecstack --no-warn-rwx-segments

Nicolas Saenz Julienne (1):
      nohz/full, sched/rt: Fix missed tick-reenabling bug in dequeue_task_rt()

Niek Nooijens (1):
      USB: serial: ftdi_sio: add Omron CS1W-CIF31 device id

Niels Dossche (1):
      media: hdpvr: fix error value returns in hdpvr_read

Nikita Travkin (1):
      pinctrl: qcom: msm8916: Allow CAMSS GP clocks to be muxed

Niklas Cassel (1):
      libata: add ATA_HORKAGE_NOLPM for Pioneer BDR-207M and BDR-205

Ovidiu Panait (1):
      bpf: Verifer, adjust_scalar_min_max_vals to always call update_reg_bounds()

Pablo Neira Ayuso (5):
      netfilter: nf_tables: really skip inactive sets when allocating name
      netfilter: nft_payload: report ERANGE for too long offset and length
      netfilter: nft_payload: do not truncate csum_offset and csum_type
      netfilter: nft_osf: restrict osf to ipv4, ipv6 and inet families
      netfilter: nft_tunnel: restrict it to netdev family

Pablo Sun (1):
      usb: typec: altmodes/displayport: correct pin assignment for UFP receptacles

Pali Rohár (4):
      PCI: Add defines for normal and subtractive PCI bridges
      powerpc/fsl-pci: Fix Class Code of PCIe Root Port
      powerpc/pci: Prefer PCI domain assignment via DT 'linux,pci-domain' and alias
      gpio: mpc8xxx: Fix support for IRQ_TYPE_LEVEL_LOW flow_type in mpc85xx

Pascal Terjan (1):
      vboxguest: Do not use devm for irq

Pattara Teerapong (1):
      ALSA: aloop: Fix random zeros in capture data when using jiffies timer

Pavan Chebbi (1):
      PCI: Add ACS quirk for Broadcom BCM5750x NICs

Pavel Skripkin (1):
      ath9k: fix use-after-free in ath9k_hif_usb_rx_cb

Pawan Gupta (1):
      x86/bugs: Add "unknown" reporting for MMIO Stale Data

Peilin Ye (3):
      vsock: Fix memory leak in vsock_connect()
      vsock: Set socket state back to SS_UNCONNECTED in vsock_connect_timeout()
      usbnet: Fix memory leak in usbnet_disconnect()

Peter Robinson (1):
      Input: rk805-pwrkey - fix module autoloading

Peter Zijlstra (1):
      x86/nospec: Fix i386 RSB stuffing

Pierre-Louis Bossart (1):
      soundwire: bus_type: fix remove and shutdown support

Ping Cheng (1):
      HID: wacom: Don't register pad_input for touch switch

Qu Huang (1):
      drm/amdgpu: mmVM_L2_CNTL3 register not initialized correctly

Qu Wenruo (3):
      btrfs: reject log replay if there is unsupported RO compat flag
      btrfs: only write the sectors in the vertical stripe which has data stripes
      btrfs: raid56: don't trust any cached sector in __raid56_parity_recover()

Quanyang Wang (1):
      asm-generic: sections: refactor memory_intersects

Rafael J. Wysocki (2):
      thermal: sysfs: Fix cooling_device_stats_setup() error code path
      ACPI: CPPC: Do not prevent CPPC from working in the future

Ralph Siemsen (1):
      clk: renesas: r9a06g032: Fix UART clkgrp bitsel

Randy Dunlap (3):
      usb: gadget: udc: amd5536 depends on HAS_DMA
      kernel/sys_ni: add compat entry for fadvise64_64
      MIPS: lantiq: export clk_get_io() for lantiq_wdt.ko

Raymond Tan (1):
      usb: dwc3: pci: Allow Elkhart Lake to utilize DSM method for PM functionality

Rob Clark (2):
      drm/msm/mdp5: Fix global state lock backoff
      drm/msm/rd: Fix FIFO-full deadlock

Robert Marko (4):
      arm64: dts: qcom: ipq8074: fix NAND node name
      clk: qcom: ipq8074: fix NSS port frequency tables
      clk: qcom: ipq8074: set BRANCH_HALT_DELAY flag for UBI clocks
      clk: qcom: ipq8074: dont disable gcc_sleep_clk_src

Roberto Sassu (1):
      tools build: Switch to new openssl API for test-libcrypto

Russell King (Oracle) (1):
      ARM: findbit: fix overflowing offset

Rustam Subkhankulov (2):
      wifi: p54: add missing parentheses in p54_flush()
      video: fbdev: sis: fix typos in SiS_GetModeID()

Sai Prakash Ranjan (1):
      irqchip/tegra: Fix overflow implicit truncation warnings

Sakari Ailus (1):
      ACPI: property: Return type of acpi_add_nondev_subnodes() should be bool

Sam Protsenko (1):
      iommu/exynos: Handle failed IOMMU device registration properly

Samuel Holland (4):
      soc: sunxi: sram: Actually claim SRAM regions
      soc: sunxi: sram: Prevent the driver from being unbound
      soc: sunxi: sram: Fix probe function ordering issues
      soc: sunxi: sram: Fix debugfs info for A64 SRAM C

Saurabh Sengar (1):
      scsi: storvsc: Remove WQ_MEM_RECLAIM from storvsc_error_wq

Schspa Shi (1):
      vfio: Clear the caps->buf to NULL after free

Sean Anderson (1):
      net: sunhme: Fix packet reception for len < RX_COPY_THRESHOLD

Sean Christopherson (3):
      KVM: x86: Mark TSS busy during LTR emulation _after_ all fault checks
      KVM: x86: Set error code to segment selector on LLDT/LTR non-canonical #GP
      KVM: Add infrastructure and macro to mark VM as bugged

Sergei Antonov (1):
      mmc: moxart: fix 4-bit bus width and remove 8-bit bus width

Sergey Shtylyov (1):
      of: fdt: fix off-by-one error in unflatten_dt_nodes()

Shenwei Wang (1):
      serial: fsl_lpuart: RS485 RTS polariy is inverse

Siddh Raman Pant (4):
      x86/numa: Use cpumask_available instead of hardcoded NULL check
      loop: Check for overflow while configuring loop
      wifi: mac80211: Don't finalize CSA in IBSS mode if state is disconnected
      wifi: mac80211: Fix UAF in ieee80211_scan_rx()

Sireesh Kodali (2):
      arm64: dts: qcom: msm8916: Fix typo in pronto remoteproc node
      remoteproc: qcom: wcnss: Fix handling of IRQs

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV32-WA/WB RmNet mode

Sreekanth Reddy (1):
      scsi: mpt3sas: Fix use-after-free warning

Stanislav Fomichev (1):
      selftests/bpf: Fix test_align verifier log patterns

Stanislaw Gruszka (1):
      wifi: iwlegacy: 4965: corrected fix for potential off-by-one overflow in il4965_rs_fill_link_cmd()

Stefan Haberland (1):
      s390/dasd: fix Oops in dasd_alias_get_start_dev due to missing pavgroup

Stefan Metzmacher (1):
      cifs: don't send down the destination address to sendmsg for a SOCK_STREAM

Steffen Maier (1):
      scsi: zfcp: Fix missing auto port scan and thus missing target ports

Stephen Boyd (1):
      Revert "clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops"

Steve French (1):
      smb3: check xattr value length earlier

Steven Rostedt (Google) (2):
      tracing: Have filter accept "common_cpu" to be consistent
      tracing/probes: Have kprobes and uprobes use $COMM too

Stuart Menefy (1):
      drm/meson: Correct OSD1 global alpha value

Sudeep Holla (2):
      firmware: arm_scpi: Ensure scpi_info is not assigned if the probe fails
      arm64: cacheinfo: Fix incorrect assignment of signed error value to unsigned fw_level

Takashi Iwai (7):
      ALSA: core: Add async signal helpers
      ALSA: timer: Use deferred fasync helper
      ALSA: seq: oss: Fix data-race for max_midi_devs access
      ALSA: seq: Fix data-race at module auto-loading
      ASoC: nau8824: Fix semaphore unbalance at error paths
      ALSA: hda/sigmatel: Keep power up while beep is enabled
      ALSA: hda/sigmatel: Fix unused variable warning for beep power change

Tasos Sahanidis (1):
      ALSA: emu10k1: Fix out of bounds access in snd_emu10k1_pcm_channel_alloc()

Tetsuo Handa (3):
      tty: vt: initialize unicode screen buffer
      PM: hibernate: defer device probing when resuming from hibernation
      workqueue: don't skip lockdep work dependency in cancel_work_sync()

Thadeu Lima de Souza Cascardo (2):
      netfilter: nf_tables: do not allow SET_ID to refer to another table
      net_sched: cls_route: remove from list when handle is 0

Theodore Ts'o (1):
      ext4: update s_overhead_clusters in the superblock during an on-line resize

Thierry GUIBERT (1):
      USB: cdc-acm: Add Icom PMR F3400 support (0c26:0020)

Timur Tabi (1):
      drm/nouveau: fix another off-by-one in nvbios_addr

Toke Høiland-Jørgensen (3):
      sch_cake: Return __NET_XMIT_STOLEN when consuming enqueued skb
      sch_sfb: Don't assume the skb is still around after enqueueing to child
      sch_sfb: Also store skb len before calling child enqueue

Tom Rix (1):
      apparmor: fix aa_label_asxprint return check

Tony Battersby (1):
      scsi: sg: Allow waiting for commands to complete on removed device

Trond Myklebust (3):
      NFSv4: Fix races in the legacy idmapper upcall
      NFSv4/pnfs: Fix a use-after-free bug in open
      SUNRPC: Reinitialise the backchannel request buffers before reuse

Tyler Hicks (4):
      net/9p: Initialize the iounit field during fid creation
      ima: Have the LSM free its audit rule
      ima: Free the entire rule when deleting a list of rules
      ima: Free the entire rule if it fails to parse

Uwe Kleine-König (3):
      mtd: st_spi_fsm: Add a clk_disable_unprepare() in .probe()'s error path
      mfd: t7l66xb: Drop platform disable callback
      dmaengine: sprd: Cleanup in .remove() after pm_runtime_get_sync() failed

Vincent Mailhol (10):
      can: pch_can: do not report txerr and rxerr during bus-off
      can: rcar_can: do not report txerr and rxerr during bus-off
      can: sja1000: do not report txerr and rxerr during bus-off
      can: hi311x: do not report txerr and rxerr during bus-off
      can: sun4i_can: do not report txerr and rxerr during bus-off
      can: kvaser_usb_hydra: do not report txerr and rxerr during bus-off
      can: kvaser_usb_leaf: do not report txerr and rxerr during bus-off
      can: usb_8dev: do not report txerr and rxerr during bus-off
      can: error: specify the values of data[5..7] of CAN error frames
      can: pch_can: pch_can_error(): initialize errc before using it

Vitaly Kuznetsov (3):
      KVM: x86: Check lapic_in_kernel() before attempting to set a SynIC irq
      KVM: x86: Avoid theoretical NULL pointer dereference in kvm_irq_delivery_to_apic_fast()
      Drivers: hv: Never allocate anything besides framebuffer from framebuffer memory region

Wang Yufen (1):
      selftests: Fix the if conditions of in test_extra_filter()

Weitao Wang (1):
      USB: HCD: Fix URB giveback issue in tasklet function

Wentao_Liang (1):
      drivers:md:fix a potential use-after-free bug

Witold Lipieta (1):
      usb-storage: Add ignore-residue quirk for NXP PN7462AU

Wolfram Sang (2):
      selftests: timers: valid-adjtimex: build fix for newer toolchains
      selftests: timers: clocksource-switch: fix passing errors from child

Xianting Tian (1):
      RISC-V: Add fast call path of crash_kexec()

Xiaolei Wang (1):
      regulator: pfuze100: Fix the global-out-of-bounds access in pfuze100_regulator_probe()

Xin Xiong (2):
      apparmor: fix reference count leak in aa_pivotroot()
      xfrm: fix refcount leak in __xfrm_policy_check()

Xinlei Lee (1):
      drm/mediatek: Add pull-down MIPI operation in mtk_dsi_poweroff function

Xiu Jianfeng (2):
      selinux: Add boundary check in put_entry()
      apparmor: Fix memleak in aa_simple_write_to_buffer()

Xu Wang (1):
      i2c: Fix a potential use after free

Yacan Liu (1):
      net/smc: Remove redundant refcount increase

Yan Xinyu (1):
      USB: serial: option: add support for OPPO R11 diag port

Yang Jihong (1):
      ftrace: Fix NULL pointer dereference in is_ftrace_trampoline when ftrace is dead

Yang Ling (1):
      MIPS: loongson32: ls1c: Fix hang during startup

Yang Xu (1):
      fs: Add missing umask strip in vfs_tmpfile

Yang Yingliang (5):
      bus: hisi_lpc: fix missing platform_device_put() in hisi_lpc_acpi_probe()
      net: neigh: don't call kfree_skb() under spin_lock_irqsave()
      fbdev: chipsfb: Add missing pci_disable_device() in chipsfb_pci_init()
      parisc: ccio-dma: Add missing iounmap in error path in ccio_probe()
      Input: melfas_mip4 - fix return value check in mip4_probe()

Yao Wang1 (1):
      drm/amd/display: Limit user regamma to a valid value

Ye Bin (1):
      ext4: avoid remove directory when directory is corrupted

Yee Lee (1):
      Revert "mm: kmemleak: take a full lowmem check in kmemleak_*_phys()"

Yonglin Tan (1):
      USB: serial: option: add Quectel EM060K modem

Yonglong Li (1):
      tcp: make retransmitted SKB fit into the send window

Youling Tang (1):
      mksysmap: Fix the mismatch of 'L0' symbols in System.map

Yu Zhe (1):
      perf/arm_pmu_platform: fix tests for platform_get_irq() failure

Zhang Xianwei (1):
      NFSv4.1: RECLAIM_COMPLETE must handle EACCES

Zhengchao Shao (1):
      crypto: hisilicon - Kunpeng916 crypto driver don't sleep when in softirq

Zhenneng Li (1):
      drm/radeon: add a force flush to delay work when radeon

Zheyu Ma (8):
      ALSA: bcd2000: Fix a UAF bug on the error path of probing
      iio: light: isl29028: Fix the warning in isl29028_remove()
      media: tw686x: Register the irq at the end of probe
      video: fbdev: arkfb: Fix a divide-by-zero bug in ark_set_pixclock()
      video: fbdev: vt8623fb: Check the size of screen before memset_io()
      video: fbdev: arkfb: Check the size of screen before memset_io()
      video: fbdev: s3fb: Check the size of screen before memset_io()
      video: fbdev: i740fb: Check the argument of i740_calc_vclk()

Zhihao Cheng (1):
      jbd2: fix assertion 'jh->b_frozen_data == NULL' failure when journal aborted

Zhouyi Zhou (1):
      powerpc/64: Init jump labels before parse_early_param()

Zhu Yanjun (1):
      RDMA/rxe: Fix error unwind in rxe_create_qp()

haibinzhang (张海斌) (1):
      arm64: fix oops in concurrently setting insn_emulation sysctls

huhai (1):
      ACPI: LPSS: Fix missing check in register_device_clock()

jerry meng (1):
      USB: serial: option: add Quectel RM520N

jerry.meng (1):
      net: usb: qmi_wwan: add Quectel RM520N

sunliming (1):
      drm/msm/dsi: fix the inconsistent indenting

zain wang (1):
      arm64: dts: rockchip: Set RK3399-Gru PCLK_EDP to 24 MHz
