Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31267680042
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjA2Qkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjA2Qkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:40:33 -0500
X-Greylist: delayed 899 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Jan 2023 08:40:28 PST
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBF31027E;
        Sun, 29 Jan 2023 08:40:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EFC0DAEDB;
        Sun, 29 Jan 2023 17:15:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1675008920; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=ULg4B0+3hGXkXDg211u8uuAupAO4CZti21gM7z8BmsU=;
        b=lEUjVbhoE3TjJ1/S0axLMW3Dyl2qdzNhX4MGoQa5Jn1Cl9XR8kJanj9YA3Q4abp4/CYl1B
        FvfzmU0+WMZHCVTuRx05qIcRGRRFjc4PifdNLgbJaca5D5AdxFrJxZUMsWnNtyUrQ7Z/pR
        ZhOqABBz4aKwt3s5RnmUu5Fi1Ehwb09L4T1nVugUu3NitmGbfgN32/5Tol4BjctryjDrGy
        eSlwl9E3ENq43Wyv8P5U0LxoGu3yiVBPqoYRD4ODvCvdekAdLrf1mxbL2dBlKPNOeaDyI1
        SK7N3bgA27FkvUL24JrNLSYk8gbagmzSK32LPrAc4pq3qpg51UPqsqUgcT95VQ==
Date:   Sun, 29 Jan 2023 17:15:15 +0100
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
Subject: [ANNOUNCE] 4.19.271-rt120
Message-ID: <20230129161515.be22dzumur5os27u@beryllium.lan>
essage-ID: <167500875303.6566.15747387335586865344@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.271-rt120 stable release.

This is just an update to latest stable release. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 7cd315d789f463c6cf91941f1e8cf4817a19f879

Or to build 4.19.271-rt120 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.271.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.271-rt120.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.269-rt119:
---

Aakarsh Jain (1):
      media: s5p-mfc: Add variant data for MFC v7 hardware for Exynos 3250 SoC

Adam Vodopjan (1):
      ata: ahci: Fix PCS quirk application for suspend

Aditya Garg (1):
      hfsplus: fix bug causing custom uid and gid being unable to be assigned with mount

Adrian Hunter (1):
      perf auxtrace: Fix address filter duplicate symbol selection

Ahung Cheng (1):
      serial: tegra: avoid reg access when clk disabled

Ajay Kaher (1):
      perf symbol: correction while adjusting symbol

Akinobu Mita (3):
      libfs: add DEFINE_SIMPLE_ATTRIBUTE_SIGNED for signed value
      lib/notifier-error-inject: fix error when writing -errno to debugfs file
      debugfs: fix error when writing negative value to atomic_t debugfs file

Al Viro (1):
      alpha: fix syscall entry in !AUDUT_SYSCALL case

Alexander Stein (1):
      usb: host: ehci-fsl: Fix module alias

Alexey Dobriyan (1):
      proc: fixup uptime selftest

Ali Mirghasemi (1):
      USB: serial: option: add Quectel EC200U modem

Amadeusz Sławiński (1):
      ASoC: codecs: rt298: Add quirk for KBL-R RVP platform

Anastasia Belova (1):
      MIPS: BCM63xx: Add check for NULL for clk in clk_enable

Andy Shevchenko (1):
      fbdev: ssd1307fb: Drop optional dependency

AngeloGioacchino Del Regno (4):
      arm64: dts: mt2712e: Fix unit_address_vs_reg warning for oscillators
      arm64: dts: mt2712e: Fix unit address for pinctrl node
      arm64: dts: mt2712-evb: Fix vproc fixed regulators unit names
      arm64: dts: mediatek: mt6797: Fix 26M oscillator unit name

Anssi Hannula (4):
      can: kvaser_usb_leaf: Set Warning state even without bus errors
      can: kvaser_usb_leaf: Fix improved state not being reported
      can: kvaser_usb_leaf: Fix wrong CAN state after stopping
      can: kvaser_usb_leaf: Fix bogus restart events

Arnd Bergmann (1):
      hfs/hfsplus: use WARN_ON for sanity check

Artem Chernyshev (1):
      net: vmw_vsock: vmci: Check memcpy_from_msg()

Artem Egorkine (2):
      ALSA: line6: correct midi status byte when receiving data from podxt
      ALSA: line6: fix stack overflow in line6_midi_transmit

Ashok Raj (1):
      x86/microcode/intel: Do not retry microcode reloading on the APs

Baisong Zhong (2):
      ALSA: seq: fix undefined behavior in bit shift for SNDRV_SEQ_FILTER_USE_EVENT
      media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()

Baokun Li (7):
      ext4: add inode table check in __ext4_get_inode_loc to aovid possible infinite loop
      ext4: add helper to check quota inums
      ext4: fix bug_on in __es_tree_search caused by bad boot loader inode
      ext4: fix corruption when online resizing a 1K bigalloc fs
      ext4: correct inconsistent error msg in nojournal mode
      ext4: fix bug_on in __es_tree_search caused by bad quota inode
      ext4: fix use-after-free in ext4_orphan_cleanup

Barnabás Pőcze (1):
      timerqueue: Use rb_entry_safe() in timerqueue_getnext()

Ben Dooks (1):
      riscv: uaccess: fix type of 0 variable on error in get_user()

Biju Das (1):
      ravb: Fix "failed to switch device to config mode" message during unbind

Bitterblue Smith (2):
      wifi: rtl8xxxu: Fix reading the vendor of combo chips
      wifi: rtl8xxxu: Add __packed to struct rtl8723bu_c2h

Bruno Thomsen (1):
      USB: serial: cp210x: add Kamstrup RF sniffer PIDs

Cai Xinchen (1):
      rapidio: devices: fix missing put_device in mport_cdev_open

Charles Keepax (1):
      ASoC: ops: Correct bounds check for second channel on SX controls

Chen Jiahao (1):
      drivers: soc: ti: knav_qmss_queue: Mark knav_acc_firmwares as static

Chen Zhongjin (6):
      perf: Fix possible memleak in pmu_dev_alloc()
      fs: sysv: Fix sysv_nblocks() returns wrong value
      media: dvb-core: Fix ignored return value in dvb_register_frontend()
      wifi: cfg80211: Fix not unregister reg_pdev when load_builtin_regdb_keys() fails
      scsi: fcoe: Fix transport not deattached when fcoe_if_init() fails
      vme: Fix error not catched in fake_init()

Chris Chiu (1):
      rtl8xxxu: add enumeration for channel bandwidth

Christian Brauner (1):
      pnode: terminate at peers of source

Christophe JAILLET (4):
      fbdev: uvesafb: Fixes an error handling path in uvesafb_probe()
      powerpc/52xx: Fix a resource leak in an error handling path
      myri10ge: Fix an error handling path in myri10ge_probe()
      iommu/mediatek-v1: Fix an error handling path in mtk_iommu_v1_probe()

Chuck Lever (1):
      SUNRPC: Don't leak netobj memory when gss_read_proxy_verf() fails

Clement Lecigne (1):
      ALSA: pcm: Move rwsem lock inside snd_ctl_elem_read to prevent UAF

Cong Wang (1):
      net_sched: reject TCF_EM_SIMPLE case for complex ematch module

Corentin Labbe (1):
      crypto: n2 - add missing hash statesize

Dan Aloni (1):
      nfsd: under NFSv4.1, fix double svc_xprt_put on rpc_create failure

Dan Carpenter (3):
      bonding: uninitialized variable in bond_miimon_inspect()
      staging: rtl8192u: Fix use after free in ieee80211_rx()
      ipmi: fix use after free in _ipmi_destroy_user()

Daniel Scally (1):
      usb: gadget: g_webcam: Send color matching descriptor per frame

Daniel Wagner (2):
      Merge tag 'v4.19.271' into v4.19-rt
      Linux 4.19.271-rt120

Daniil Tatianin (2):
      qlcnic: prevent ->dcb use-after-free on qlcnic_dcb_enable() failure
      net/ethtool/ioctl: return -EOPNOTSUPP if we have no phy stats

David Howells (2):
      net, proc: Provide PROC_FS=n fallback for proc_create_net_single_write()
      rxrpc: Fix missing unlock in rxrpc_do_sendmsg()

Deren Wu (1):
      mmc: vub300: fix warning - do not call blocking ops when !TASK_RUNNING

Dinh Nguyen (1):
      clk: socfpga: use clk_hw_register for a5/c5

Dmitry Osipenko (2):
      tty: serial: tegra: Activate RX DMA transfer by request
      tty: serial: tegra: Handle RX transfer in PIO mode if DMA wasn't started

Don Brace (1):
      scsi: hpsa: use local workqueues instead of system workqueues

Dongdong Zhang (1):
      f2fs: fix normal discard process

Dongliang Mu (1):
      fs: jfs: fix shift-out-of-bounds in dbAllocAG

Doug Brown (1):
      ARM: mmp: fix timer_read delay

Douglas Anderson (1):
      Input: elants_i2c - properly handle the reset GPIO when power is off

Dragos Tatulea (1):
      IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces

Duke Xin (1):
      USB: serial: option: add Quectel EM05-G modem

Duke Xin(辛安文) (5):
      USB: serial: option: add Quectel EM05-G (GR) modem
      USB: serial: option: add Quectel EM05-G (CS) modem
      USB: serial: option: add Quectel EM05-G (RS) modem
      USB: serial: option: add Quectel EM05CN (SG) modem
      USB: serial: option: add Quectel EM05CN modem

Eelco Chaudron (1):
      openvswitch: Fix flow lookup to use unmasked key

Eliav Farber (1):
      EDAC/device: Fix period calculation in edac_device_reset_delay_period()

Enzo Matsumiya (1):
      cifs: do not include page data when checking signature

Eran Ben Elisha (1):
      net/mlx5: Rename ptp clock info

Eric Biggers (1):
      ext4: don't allow journal inode to have encrypt flag

Eric Dumazet (1):
      net: stream: purge sk_error_queue in sk_stream_kill_queues()

Eric Pilmore (1):
      ntb_netdev: Use dev_kfree_skb_any() in interrupt context

Eric W. Biederman (1):
      binfmt: Move install_exec_creds after setup_new_exec to match binfmt_elf

Eric Whitney (4):
      ext4: generalize extents status tree search functions
      ext4: add new pending reservation mechanism
      ext4: fix reserved cluster accounting at delayed write time
      ext4: fix delayed allocation bug in ext4_clu_mapped for bigalloc + inline

Fedor Pchelkin (3):
      wifi: ath9k: hif_usb: fix memory leak of urbs in ath9k_hif_usb_dealloc_tx_urbs()
      wifi: ath9k: hif_usb: Fix use-after-free in ath9k_hif_usb_reg_in_cb()
      wifi: ath9k: verify the expected usb_endpoints are present

Ferry Toth (3):
      usb: dwc3: core: defer probe on ulpi_read_id timeout
      usb: ulpi: defer ulpi_register on ulpi_read_id timeout
      Revert "usb: ulpi: defer ulpi_register on ulpi_read_id timeout"

Filipe Manana (1):
      btrfs: send: avoid unnecessary backref lookups when finding clone source

Flavio Suligoi (1):
      usb: core: hub: disable autosuspend for TI TUSB8041

Florian-Ewald Mueller (1):
      md/bitmap: Fix bitmap chunk size overflow issues

Frederick Lawler (1):
      net: sched: disallow noqueue for qdisc classes

GUO Zihua (1):
      rtc: mxc_v2: Add missing clk_disable_unprepare()

Gabriel Somlo (1):
      serial: altera_uart: fix locking in polling mode

Gaosheng Cui (7):
      ALSA: mts64: fix possible null-ptr-defer in snd_mts64_interrupt
      apparmor: fix a memleak in multi_transaction_new()
      scsi: snic: Fix possible UAF in snic_tgt_create()
      crypto: img-hash - Fix variable dereferenced before check 'hdev->req'
      staging: vme_user: Fix possible UAF in tsi148_dma_list_add
      rtc: st-lpc: Add missing clk_disable_unprepare in st_rtc_probe()
      ext4: fix undefined behavior in bit shift for ext4_check_flag_values

Gautam Menghani (1):
      media: imon: fix a race condition in send_packet()

Gavrilov Ilia (2):
      relay: fix type mismatch when allocating memory in relay_create_buf()
      netfilter: ipset: Fix overflow before widen in the bitmap_ip_create() function.

Geert Uytterhoeven (1):
      clocksource/drivers/sh_cmt: Make sure channel clock supply is enabled

Greg Kroah-Hartman (8):
      Linux 4.19.270
      prlimit: do_prlimit needs to have a speculation check
      USB: misc: iowarrior: fix up header size for USB_DEVICE_ID_CODEMERCS_IOW100
      Revert "ext4: fix delayed allocation bug in ext4_clu_mapped for bigalloc + inline"
      Revert "ext4: fix reserved cluster accounting at delayed write time"
      Revert "ext4: add new pending reservation mechanism"
      Revert "ext4: generalize extents status tree search functions"
      Linux 4.19.271

Hangbin Liu (1):
      net/tunnel: wait until all sk_user_data reader finish before releasing the sock

Hanjun Guo (3):
      drm/radeon: Add the missed acpi_put_table() to fix memory leak
      tpm: tpm_crb: Add the missed acpi_put_table() to fix memory leak
      tpm: tpm_tis: Add the missed acpi_put_table() to fix memory leak

Hans de Goede (3):
      ASoC: rt5670: Remove unbalanced pm_runtime_put()
      ASoC: Intel: bytcr_rt5640: Add quirk for the Advantech MICA-071 tablet
      platform/x86: sony-laptop: Don't turn off 0x153 keyboard backlight during probe

Harshit Mogalapalli (2):
      xen/privcmd: Fix a possible warning in privcmd_ioctl_mmap_resource()
      scsi: scsi_debug: Fix a warning in resp_write_scat()

Heiko Carstens (1):
      s390/percpu: add READ_ONCE() to arch_this_cpu_to_op_simple()

Heiko Schocher (1):
      can: sja1000: fix size of OCR_MODE_MASK define

Helge Deller (1):
      parisc: Align parisc MADV_XXX constants with all other architectures

Herbert Xu (1):
      ipv6: raw: Deduct extension header length in rawv6_push_pending_frames

Hoi Pok Wu (1):
      fs: jfs: fix shift-out-of-bounds in dbDiscardAG

Huaxin Lu (1):
      ima: Fix a potential NULL pointer access in ima_restore_measurement_list

Hui Tang (2):
      mtd: lpddr2_nvm: Fix possible null-ptr-deref
      i2c: pxa-pci: fix missing pci_disable_device() on error in ce4100_i2c_probe

Ian Abbott (1):
      comedi: adv_pci1760: Fix PWM instruction handling

Ilpo Järvinen (1):
      serial: pch_uart: Pass correct sg to dma_unmap_sg()

Isaac J. Manjarres (1):
      driver core: Fix bus_type.match() error handling in __driver_attach()

Ivaylo Dimitrov (1):
      usb: musb: remove extra check in musb_gadget_vbus_draw

Jaegeuk Kim (1):
      f2fs: let's avoid panic if extent_tree is not created

Jakub Kicinski (1):
      bpf: pull before calling skb_postpull_rcsum()

Jamal Hadi Salim (1):
      net: sched: atm: dont intepret cls results when asked to drop

Jan Kara (17):
      udf: Discard preallocation before extending file with a hole
      udf: Fix preallocation discarding at indirect extent boundary
      udf: Do not bother looking for prealloc extents if i_lenExtents matches i_size
      udf: Fix extending file within last block
      ext4: avoid BUG_ON when creating xattrs
      ext4: initialize quota before expanding inode in setproject ioctl
      ext4: avoid unaccounted block allocation when expanding inode
      mbcache: don't reclaim used entries
      mbcache: add functions to delete entry if unused
      ext4: remove EA inode entry from mbcache on inode eviction
      ext4: unindent codeblock in ext4_xattr_block_set()
      ext4: fix race when reusing xattr blocks
      mbcache: automatically delete entries from cache on freeing
      ext4: fix deadlock due to mbcache entry corruption
      udf: Fix extension of the last extent in the file
      mbcache: Avoid nesting of cache->c_list_lock under bit locks
      quota: Factor out setup of quota inode

Jann Horn (2):
      mm/khugepaged: fix GUP-fast interaction by sending IPI
      mm/khugepaged: invoke MMU notifiers in shmem/file collapse paths

Jason A. Donenfeld (2):
      media: stv0288: use explicitly signed char
      ARM: ux500: do not directly dereference __iomem

Jason Gerecke (1):
      HID: wacom: Ensure bootloader PID is usable in hidraw mode

Jason Yan (1):
      ext4: goto right label 'failed_mount3a'

Jeff Layton (1):
      nfsd: fix handling of readdir in v4root vs. mount upcall timeout

Jerry Ray (1):
      net: lan9303: Fix read error execution path

Jialiang Wang (1):
      nfp: fix use-after-free in area_cache_get()

Jiamei Xie (1):
      serial: amba-pl011: avoid SBSA UART accessing DMACR register

Jiang Li (1):
      md/raid1: stop mdx_raid1 thread when raid1 array run failed

Jiasheng Jiang (3):
      media: coda: Add check for dcoda_iram_alloc
      media: coda: Add check for kmalloc
      usb: storage: Add check for kcalloc

Jiguang Xiao (1):
      net: amd-xgbe: add missed tasklet_kill

Jimmy Assarsson (5):
      can: kvaser_usb: kvaser_usb_leaf: Get capabilities from device
      can: kvaser_usb: kvaser_usb_leaf: Rename {leaf,usbcan}_cmd_error_event to {leaf,usbcan}_cmd_can_error_event
      can: kvaser_usb: kvaser_usb_leaf: Handle CMD_ERROR_EVENT
      can: kvaser_usb: Add struct kvaser_usb_busparams
      can: kvaser_usb: Compare requested bittiming parameters with actual parameters in do_set_{,data}_bittiming

Jimmy Hu (1):
      usb: xhci: Check endpoint is valid before dereferencing it

Jiri Slaby (2):
      tty: serial: clean up stop-tx part in altera_uart_tx_chars()
      tty: serial: altera_uart_{r,t}x_chars() need only uart_port

Jiri Slaby (SUSE) (1):
      RDMA/srp: Move large values to a new enum for gcc13

Johan Hovold (2):
      USB: serial: f81534: fix division by zero on line-speed change
      efi: fix NULL-deref in init error path

John Johansen (2):
      apparmor: fix lockdep warning when removing a namespace
      apparmor: Fix abi check to include v8 abi

John Keeping (2):
      usb: gadget: f_hid: fix f_hidg lifetime vs cdev
      usb: gadget: f_hid: fix refcount leak on error path

John Stultz (3):
      pstore: Switch pmsg_lock to an rt_mutex to avoid priority inversion
      pstore: Make sure CONFIG_PSTORE_PMSG selects CONFIG_RT_MUTEXES
      driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set

Jon Hunter (1):
      serial: tegra: Only print FIFO error message when an error occurs

Jonathan Corbet (1):
      docs: Fix the docs build with Sphinx 6.0

Jonathan Neuschäfer (1):
      spi: Update reference to struct spi_controller

Juergen Gross (1):
      xen/events: only register debug interrupt for 2-level events

Juhyung Park (1):
      usb-storage: apply IGNORE_UAS only for HIKSEMI MD202 on RTL9210

Junlin Yang (1):
      pata_ipx4xx_cf: Fix unsigned comparison with less than zero

Kai Vehmanen (1):
      ALSA: hda/hdmi: fix failures at PCM open on Intel ICL and later

Kajol Jain (1):
      powerpc/hv-gpci: Fix hv_gpci event list

Kartik (1):
      serial: tegra: Read DMA status before terminating

Kees Cook (1):
      igb: Do not free q_vector unless new one was allocated

Keita Suzuki (1):
      media: dvb-core: Fix double free in dvb_register_device()

Khazhismel Kumykov (1):
      gsmi: fix null-deref in gsmi_get_variable

Kim Phillips (1):
      iommu/amd: Fix ivrs_acpihid cmdline parsing code

Kory Maincent (1):
      arm: dts: spear600: Fix clcd interrupt

Krishna Yarlagadda (6):
      serial: tegra: check for FIFO mode enabled status
      serial: tegra: set maximum num of uart ports to 8
      serial: tegra: add support to use 8 bytes trigger
      serial: tegra: add support to adjust baud rate
      serial: tegra: report clk rate errors
      serial: tegra: Add PIO mode support

Kunihiko Hayashi (1):
      mmc: f-sdh30: Add quirks for broken timeout clock capability

Lee Jones (1):
      clk: socfpga: clk-pll: Remove unused variable 'rc'

Li Zetao (3):
      ACPICA: Fix use-after-free in acpi_ut_copy_ipackage_to_ipackage()
      net: farsync: Fix kmemleak when rmmods farsync
      r6040: Fix kmemleak in probe and remove

Li Zhong (1):
      drivers/md/md-bitmap: check the return value of md_bitmap_get_counter()

Liang He (1):
      media: c8sectpfe: Add of_node_put() when breaking out of loop

Libo Chen (1):
      ktest.pl: Fix incorrect reboot for grub2bls

Lin Ma (3):
      media: dvbdev: adopts refcnt to avoid UAF
      media: dvbdev: fix build warning due to comments
      media: dvbdev: fix refcnt bug

Linus Torvalds (1):
      hfs/hfsplus: avoid WARN_ON() for sanity check, use proper error handling

Linus Walleij (1):
      usb: fotg210-udc: Fix ages old endianness issues

Liu Shixin (4):
      media: vivid: fix compose size exceed boundary
      ALSA: asihpi: fix missing pci_disable_device()
      media: saa7164: fix missing pci_disable_device()
      binfmt_misc: fix shift-out-of-bounds in check_special_flags

Luca Weiss (1):
      ARM: dts: qcom: apq8064: fix coresight compatible

Luo Meng (3):
      dm thin: Fix UAF in run_timer_softirq()
      dm cache: Fix UAF in destroy()
      dm thin: resume even if in FAIL mode

Luís Henriques (1):
      ext4: fix error code return to user-space in ext4_get_branch()

Maciej Żenczykowski (1):
      usb: gadget: f_ncm: fix potential NULL ptr deref in ncm_bitrate()

Manivannan Sadhasivam (1):
      soc: qcom: Select REMAP_MMIO for LLCC driver

Maor Gottlieb (2):
      bonding: Export skip slave logic to function
      RDMA/mlx5: Fix validation of max_rd_atomic caps for DC

Marcus Folkesson (1):
      HID: hid-sensor-custom: set fixed size for custom attributes

Marek Szyprowski (1):
      ASoC: wm8994: Fix potential deadlock

Marek Vasut (1):
      wifi: rsi: Fix handling of 802.3 EAPOL frames sent via control port

Mark Brown (1):
      ASoC: ops: Check bounds for second channel in snd_soc_put_volsw_sx()

Mark Rutland (1):
      arm64: cmpxchg_double*: hazard against entire exchange variable

Mark Zhang (1):
      RDMA/nldev: Return "-EAGAIN" if the cm_id isn't from expected port

Masami Hiramatsu (Google) (2):
      perf probe: Use dwarf_attr_integrate as generic DWARF attr accessor
      perf probe: Fix to get the DW_AT_decl_file and DW_AT_call_file as unsinged data

Masayoshi Mizuma (4):
      ktest: Add support for meta characters in GRUB_MENU
      ktest: introduce _get_grub_index
      ktest: cleanup get_grub_index
      ktest: introduce grub2bls REBOOT_TYPE option

Mathias Nyman (2):
      xhci: Fix null pointer dereference when host dies
      xhci: Add a flag to disable USB3 lpm on a xhci root port level.

Matt Redfearn (1):
      include/uapi/linux/swab: Fix potentially missing __always_inline

Maxim Devaev (1):
      usb: gadget: f_hid: optional SETUP/SET_REPORT mode

Mazin Al Haddad (1):
      media: dvb-usb: fix memory leak in dvb_usb_adapter_init()

Miaoqian Lin (4):
      cxl: Fix refcount leak in cxl_calc_capp_routing
      selftests/powerpc: Fix resource leaks
      nfc: Fix potential resource leaks
      net: phy: xgmiitorgmii: Fix refcount leak in xgmiitorgmii_probe

Michael Adler (1):
      USB: serial: cp210x: add SCALANCE LPE-9000 device id

Michael Kelley (1):
      tpm/tpm_crb: Fix error message in __crb_relinquish_locality()

Michael S. Tsirkin (1):
      PCI: Fix pci_device_is_present() for VFs by checking PF

Michael Walle (1):
      wifi: wilc1000: sdio: fix module autoloading

Mickaël Salaün (1):
      selftests: Use optional USERCFLAGS and USERLDFLAGS

Mike Snitzer (2):
      dm cache: Fix ABBA deadlock between shrink_slab and dm_cache_metadata_abort
      dm cache: set needs_check flag after aborting metadata

Mikulas Patocka (1):
      md: fix a crash in mempool_free

Ming Lei (1):
      block: unhash blkdev part inode when the part is deleted

Minsuk Kang (3):
      nfc: pn533: Clear nfc_target before being used
      wifi: brcmfmac: Fix potential shift-out-of-bounds in brcmf_fw_alloc_request()
      nfc: pn533: Wait for out_urb's completion in pn533_usb_send_frame()

Nathan Chancellor (8):
      net: ethernet: ti: Fix return type of netcp_ndo_start_xmit()
      hamradio: baycom_epp: Fix return type of baycom_send_packet()
      drm/amdgpu: Fix type of second parameter in trans_msg() callback
      s390/ctcm: Fix return type of ctc{mp,}m_tx()
      s390/netiucv: Fix return type of netiucv_tx()
      s390/lcs: Fix return type of lcs_start_xmit()
      drm/fsl-dcu: Fix return type of fsl_dcu_drm_connector_mode_valid()
      drm/sti: Fix return type of sti_{dvo,hda,hdmi}_connector_mode_valid()

Nathan Lynch (2):
      powerpc/rtas: avoid device tree lookups in rtas_os_term()
      powerpc/rtas: avoid scheduling in rtas_os_term()

Nicholas Piggin (1):
      powerpc/perf: callchain validate kernel stack pointer bounds

Nick Desaulniers (1):
      ARM: 9256/1: NWFPE: avoid compiler-generated __aeabi_uldivmod

Nuno Sá (1):
      iio: adc: ad_sigma_delta: do not use internal iio_dev lock

Oleg Nesterov (1):
      uprobes/x86: Allow to probe a NOP instruction with 0x66 prefix

Olga Kornievskaia (1):
      pNFS/filelayout: Fix coalescing test for single DS

Ondrej Mosnacek (1):
      fs: don't audit the capability check in simple_xattr_list()

Pali Rohár (8):
      ARM: dts: dove: Fix assigned-addresses for every PCIe Root Port
      ARM: dts: armada-370: Fix assigned-addresses for every PCIe Root Port
      ARM: dts: armada-xp: Fix assigned-addresses for every PCIe Root Port
      ARM: dts: armada-375: Fix assigned-addresses for every PCIe Root Port
      ARM: dts: armada-38x: Fix assigned-addresses for every PCIe Root Port
      ARM: dts: armada-39x: Fix assigned-addresses for every PCIe Root Port
      ARM: dts: turris-omnia: Add ethernet aliases
      ARM: dts: turris-omnia: Add switch port 6 node

Paolo Abeni (1):
      net/ulp: prevent ULP without clone op from entering the LISTEN status

Patrik John (1):
      serial: tegra: Change lower tolerance baud rate limit for tegra20 and tegra30

Paulo Alcantara (1):
      cifs: fix confusing debug message

Peter Newman (1):
      x86/resctrl: Fix task CLOSID/RMID update race

Peter Zijlstra (1):
      x86/boot: Avoid using Intel mnemonics in AT&T syntax asm

Piergiorgio Beruto (1):
      stmmac: fix potential division by 0

Prashant Malani (2):
      usb: typec: altmodes/displayport: Add pin assignment helper
      usb: typec: altmodes/displayport: Fix pin assignment calculation

Rafael J. Wysocki (2):
      PM: runtime: Do not call __rpm_callback() from rpm_idle()
      ACPICA: Fix error code path in acpi_ds_call_control_method()

Rafael Mendonca (3):
      vfio: platform: Do not pass return buffer to ACPI _RST method
      uio: uio_dmem_genirq: Fix missing unlock in irq configuration
      uio: uio_dmem_genirq: Fix deadlock between irq config and handling

Rahul Rameshbabu (1):
      net/mlx5: Fix ptp max frequency adjustment range

Rasmus Villemoes (1):
      net: loopback: use NET_NAME_PREDICTABLE for name_assign_type

Reinette Chatre (1):
      x86/resctrl: Use task_curr() instead of task_struct->on_cpu to prevent unnecessary IPI

Ricardo Ribalda (4):
      pinctrl: meditatek: Startup with the IRQs disabled
      media: i2c: ad5820: Fix error path
      regulator: da9211: Use irq handler when ready
      xhci-pci: set the dma max_seg_size

Rickard x Andersson (1):
      gcov: add support for checksum field

Rob Clark (1):
      drm/virtio: Fix GEM handle creation UAF

Roberto Sassu (1):
      reiserfs: Add missing calls to reiserfs_security_free()

Rodrigo Branco (1):
      x86/bugs: Flush IBP in ib_prctl_set()

Roger Pau Monne (1):
      hvc/xen: lock console list traversal

Rui Zhang (1):
      regulator: core: fix use_count leakage when handling boot-on

Ryusuke Konishi (2):
      nilfs2: fix shift-out-of-bounds/overflow in nilfs_sb2_bad_offset()
      nilfs2: fix general protection fault in nilfs_btree_insert()

Samuel Holland (1):
      mmc: sunxi-mmc: Fix clock refcount imbalance during unbind

Sascha Hauer (1):
      PCI/sysfs: Fix double free in error path

Sasha Levin (1):
      btrfs: replace strncpy() with strscpy()

Schspa Shi (1):
      mrp: introduce active flags to prevent UAF when applicant uninit

Shang XiaoJing (6):
      ocfs2: fix memory leak in ocfs2_stack_glue_init()
      irqchip: gic-pm: Use pm_runtime_resume_and_get() in gic_probe()
      scsi: ipr: Fix WARNING in ipr_init()
      samples: vfio-mdev: Fix missing pci_disable_device() in mdpy_fb_probe()
      fbdev: via: Fix error in via_core_init()
      parisc: led: Fix potential null-ptr-deref in start_task()

Shawn.Shao (1):
      Add exception protection processing for vd in axi_chan_handle_err function

Shigeru Yoshida (3):
      udf: Avoid double brelse() in udf_rename()
      wifi: ar5523: Fix use-after-free on ar5523_cmd() timed out
      media: si470x: Fix use-after-free in si470x_int_in_callback()

Shuqi Zhang (1):
      ext4: use kmemdup() to replace kmalloc + memcpy

Simon Ser (1):
      drm/connector: send hotplug uevent on connector cleanup

Smitha T Murthy (3):
      media: s5p-mfc: Fix to handle reference queue during finishing
      media: s5p-mfc: Clear workbit to handle error condition
      media: s5p-mfc: Fix in register read and write for H264

Stanislav Fomichev (2):
      bpf: make sure skb->len != 0 when redirecting to a tunneling device
      ppp: associate skb with a device at tx

Stefan Eichenberger (1):
      rtc: snvs: Allow a time difference on clock register read

Stephen Boyd (1):
      pstore: Avoid kcore oops by vmap()ing with VM_IOREMAP

Steven Rostedt (2):
      ktest.pl minconfig: Unset configs instead of just removing them
      kest.pl: Fix grub2 menu handling for rebooting

Subash Abhinov Kasiviswanathan (1):
      skbuff: Account for tail adjustment during pull operations

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix u8 overflow

Sven Peter (1):
      usb: typec: Check for ops->exit instead of ops->enter in altmode_exit

Szymon Heidrich (2):
      usb: gadget: uvc: Prevent buffer overflow in setup handler
      usb: rndis_host: Secure rndis_query check against int overflow

Takashi Iwai (1):
      media: dvb-core: Fix UAF due to refcount races at releasing

Terry Junge (1):
      HID: plantronics: Additional PIDs for double volume key presses quirk

Tobias Schramm (1):
      serial: atmel: fix incorrect baudrate setup

Tom Lendacky (2):
      net: amd-xgbe: Fix logic around active and passive cables
      net: amd-xgbe: Check only the minimum speed for active/passive cables

Tony Jones (1):
      perf script python: Remove explicit shebang from tests/attr.c

Tony Nguyen (1):
      igb: Initialize mailbox message for VF reset

Trond Myklebust (3):
      NFSv4.2: Fix a memory stomp in decode_attr_security_label
      NFSv4: Fix a deadlock between nfs4_open_recover_helper() and delegreturn
      NFSv4.x: Fail client initialisation if state manager thread can't run

Ulf Hansson (2):
      cpuidle: dt: Return the correct numbers of parsed idle states
      PM: runtime: Improve path in rpm_idle() when no callback

Uwe Kleine-König (1):
      crypto: ccree - Make cc_debugfs_global_fini() available for module init function

Ville Syrjälä (1):
      drm/sti: Use drm_mode_copy()

Vincent Mailhol (1):
      can: kvaser_usb: do not increase tx statistics when sending error message frames

Vladimir Zapolskiy (1):
      media: camss: Clean up received buffers on failed start of streaming

Volker Lendecke (1):
      cifs: Fix uninitialized memory read for smb311 posix symlink create

Wang Jingjin (2):
      ASoC: rockchip: pdm: Add missing clk_disable_unprepare() in rockchip_pdm_runtime_resume()
      ASoC: rockchip: spdif: Add missing clk_disable_unprepare() in rk_spdif_runtime_resume()

Wang ShaoBo (2):
      drbd: remove call to memset before free device/resource/connection
      SUNRPC: Fix missing release socket in rpc_sockname()

Wang Weiyang (2):
      rapidio: fix possible UAF when kfifo_alloc() fails
      device_cgroup: Roll back to original exceptions after copy failure

Wang Yufen (5):
      pstore/ram: Fix error return code in ramoops_probe()
      wifi: brcmfmac: Fix error return code in brcmf_sdio_download_firmware()
      RDMA/hfi1: Fix error return code in parse_platform_config()
      ASoC: mediatek: mt8173-rt5650-rt5514: fix refcount leak in mt8173_rt5650_rt5514_dev_probe()
      binfmt: Fix error return code in load_elf_fdpic_binary()

Xie Shaowen (1):
      macintosh/macio-adb: check the return value of ioremap()

Xiongfeng Wang (9):
      perf/x86/intel/uncore: Fix reference count leak in hswep_has_limit_sbox()
      cpufreq: amd_freq_sensitivity: Add missing pci_dev_put()
      drm/radeon: Fix PCI device refcount leak in radeon_atrm_get_bios()
      drm/amdgpu: Fix PCI device refcount leak in amdgpu_atrm_get_bios()
      RDMA/hfi: Decrease PCI device reference count in error path
      hwrng: amd - Fix PCI device refcount leak
      hwrng: geode - Fix PCI device refcount leak
      serial: pch: Fix PCI device refcount leak in pch_request_dma()
      fbdev: vermilion: decrease reference count in error path

Xiu Jianfeng (7):
      x86/xen: Fix memory leak in xen_smp_intr_init{_pv}()
      x86/xen: Fix memory leak in xen_init_lock_cpu()
      ima: Fix misuse of dereference of pointer in template_desc_init_fields()
      wifi: ath10k: Fix return value in ath10k_pci_init()
      clk: rockchip: Fix memory leak in rockchip_clk_register_pll()
      clk: samsung: Fix memory leak in _samsung_clk_register_pll()
      clk: st: Fix memory leak in st_of_quadfs_setup()

Yan Lei (1):
      media: dvb-frontends: fix leak of memory fw

Yang Jihong (2):
      blktrace: Fix output non-blktrace event when blk_classic option enabled
      tracing: Fix infinite loop in tracing_read_pipe on overflowed print_trace_line

Yang Yingliang (51):
      MIPS: vpe-mt: fix possible memory leak while module exiting
      MIPS: vpe-cmp: fix possible memory leak while module exiting
      PNP: fix name memory leak in pnp_alloc_dev()
      rapidio: fix possible name leaks when rio_add_device() fails
      rapidio: rio: fix possible name leak in rio_register_mport()
      regulator: core: fix unbalanced of node refcount in regulator_dev_lookup()
      media: solo6x10: fix possible memory leak in solo_sysfs_init()
      regulator: core: fix module refcount leak in set_supply()
      mmc: moxart: fix return value check of mmc_add_host()
      mmc: mxcmmc: fix return value check of mmc_add_host()
      mmc: rtsx_usb_sdmmc: fix return value check of mmc_add_host()
      mmc: toshsd: fix return value check of mmc_add_host()
      mmc: vub300: fix return value check of mmc_add_host()
      mmc: wmt-sdmmc: fix return value check of mmc_add_host()
      mmc: atmel-mci: fix return value check of mmc_add_host()
      mmc: meson-gx: fix return value check of mmc_add_host()
      mmc: via-sdmmc: fix return value check of mmc_add_host()
      mmc: wbsd: fix return value check of mmc_add_host()
      mmc: mmci: fix return value check of mmc_add_host()
      ethernet: s2io: don't call dev_kfree_skb() under spin_lock_irqsave()
      net: apple: mace: don't call dev_kfree_skb() under spin_lock_irqsave()
      net: apple: bmac: don't call dev_kfree_skb() under spin_lock_irqsave()
      net: emaclite: don't call dev_kfree_skb() under spin_lock_irqsave()
      net: ethernet: dnet: don't call dev_kfree_skb() under spin_lock_irqsave()
      hamradio: don't call dev_kfree_skb() under spin_lock_irqsave()
      net: amd: lance: don't call dev_kfree_skb() under spin_lock_irqsave()
      Bluetooth: btusb: don't call kfree_skb() under spin_lock_irqsave()
      Bluetooth: hci_qca: don't call kfree_skb() under spin_lock_irqsave()
      Bluetooth: hci_h5: don't call kfree_skb() under spin_lock_irqsave()
      Bluetooth: hci_bcsp: don't call kfree_skb() under spin_lock_irqsave()
      Bluetooth: hci_core: don't call kfree_skb() under spin_lock_irqsave()
      Bluetooth: RFCOMM: don't call kfree_skb() under spin_lock_irqsave()
      scsi: hpsa: Fix error handling in hpsa_add_sas_host()
      scsi: hpsa: Fix possible memory leak in hpsa_add_sas_device()
      scsi: fcoe: Fix possible name leak when device_register() fails
      drivers: dio: fix possible memory leak in dio_init()
      class: fix possible memory leak in __class_register()
      cxl: fix possible null-ptr-deref in cxl_guest_init_afu|adapter()
      cxl: fix possible null-ptr-deref in cxl_pci_init_afu|adapter()
      mcb: mcb-parse: fix error handing in chameleon_parse_gdd()
      chardev: fix error handling in cdev_device_add()
      fbdev: pm2fb: fix missing pci_disable_device()
      HSI: omap_ssi_core: fix unbalanced pm_runtime_disable()
      HSI: omap_ssi_core: fix possible memory leak in ssi_probe()
      iommu/amd: Fix pci device refcount leak in ppr_notifier()
      macintosh: fix possible memory leak in macio_add_one_device()
      powerpc/xive: add missing iounmap() in error path in xive_spapr_populate_irq_data()
      powerpc/83xx/mpc832x_rdb: call platform_device_put() in error case in of_fsl_spi_probe()
      mISDN: hfcsusb: don't call dev_kfree_skb/kfree_skb() under spin_lock_irqsave()
      mISDN: hfcpci: don't call dev_kfree_skb/kfree_skb() under spin_lock_irqsave()
      mISDN: hfcmulti: don't call dev_kfree_skb/kfree_skb() under spin_lock_irqsave()

Yasushi SHOJI (1):
      can: mcba_usb: Fix termination command argument

Ye Bin (5):
      blk-mq: fix possible memleak when register 'hctx' failed
      ext4: init quota for 'old.inode' in 'ext4_rename'
      ext4: fix inode leak in ext4_xattr_inode_create() on an error path
      ext4: allocate extended attribute value in vmalloc area
      ext4: fix uninititialized value in 'ext4_evict_inode'

YingChi Long (1):
      x86/fpu: Use _Alignof to avoid undefined behavior in TYPE_ALIGN

Yipeng Zou (1):
      selftests/ftrace: event_triggers: wait longer for test_event_enable

Yong Wu (1):
      iommu/mediatek-v1: Add error handle for mtk_iommu_probe

Yongqiang Liu (1):
      net: defxx: Fix missing err handling in dfx_init()

Yu Liao (1):
      platform/x86: mxm-wmi: fix memleak in mxm_wmi_call_mx[ds|mx]()

Yuan Can (7):
      perf: arm_dsu: Fix hotplug callback leak in dsu_pmu_init()
      media: platform: exynos4-is: Fix error handling in fimc_md_init()
      drivers: net: qlcnic: Fix potential memory leak in qlcnic_sriov_init()
      scsi: hpsa: Fix possible memory leak in hpsa_init_one()
      serial: sunsab: Fix error handling in sunsab_init()
      HSI: omap_ssi_core: Fix error handling in ssi_init()
      iommu/fsl_pamu: Fix resource leak in fsl_pamu_probe()

YueHaibing (1):
      staging: rtl8192e: Fix potential use-after-free in rtllib_rx_Monitor()

Zack Rusin (1):
      drm/vmwgfx: Validate the box size for the snooped cursor

Zeng Heng (3):
      ASoC: pxa: fix null-pointer dereference in filter()
      PCI: Check for alloc failure in pci_request_irq()
      power: supply: fix residue sysfs file in error handle route of __power_supply_register()

Zhang Qilong (3):
      soc: ti: smartreflex: Fix PM disable depth imbalance in omap_sr_probe
      eventfd: change int to __u64 in eventfd_signal() ifndef CONFIG_EVENTFD
      ASoC: pcm512x: Fix PM disable depth imbalance in pcm512x_probe

Zhang Tianci (1):
      ovl: Use ovl mounter's fsuid and fsgid in ovl_link()

Zhang Xiaoxu (4):
      mtd: Fix device name leak when register device failed in add_mtd_device()
      RDMA/rxe: Fix NULL-ptr-deref in rxe_qp_do_cleanup() when socket create failed
      orangefs: Fix sysfs not cleanup when dev init failed
      orangefs: Fix kmemleak in orangefs_prepare_debugfs_help_string()

Zhang Yiqun (1):
      crypto: tcrypt - Fix multibuffer skcipher speed test mem leak

Zhang Yuchen (2):
      ipmi: fix memleak when unload ipmi driver
      ipmi: fix long wait in unload when IPMI disconnect

Zhang Zekun (1):
      drm/tegra: Add missing clk_disable_unprepare() in tegra_dc_probe()

ZhangPeng (3):
      hfs: Fix OOB Write in hfs_asc2mac
      pinctrl: pinconf-generic: add missing of_node_put()
      hfs: fix OOB Read in __hfs_brec_find

Zheng Wang (1):
      misc: sgi-gru: fix use-after-free error in gru_set_context_option, gru_fault and gru_handle_user_call_os

Zheng Yejian (2):
      tracing/hist: Fix issue of losting command info in error_log
      acct: fix potential integer overflow in encode_comp_t()

Zheng Yongjun (1):
      mtd: maps: pxa2xx-flash: fix memory leak in probe

Zhengchao Shao (3):
      test_firmware: fix memory leak in test_firmware_init()
      drivers: mcb: fix resource leak in mcb_probe()
      caif: fix memory leak in cfctrl_linkup_request()

Zheyu Ma (1):
      i2c: ismt: Fix an out-of-bounds bug in ismt_access()

Zhihao Cheng (1):
      dm thin: Use last transaction's pmd->root when commit failed

delisun (1):
      serial: pl011: Do not clear RX FIFO & RX interrupt in unthrottle.

minoura makoto (1):
      SUNRPC: ensure the matching upcall is in-flight upon downcall

ruanjinjie (1):
      misc: tifm: fix possible memory leak in tifm_7xx1_switch_media()

zhengliang (1):
      ext4: lost matching-pair of trace in ext4_truncate
