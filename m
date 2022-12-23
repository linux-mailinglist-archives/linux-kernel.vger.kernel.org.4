Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5C6555D4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiLWXAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiLWXAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:00:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A910BB;
        Fri, 23 Dec 2022 15:00:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F188361F7C;
        Fri, 23 Dec 2022 23:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0637EC433F0;
        Fri, 23 Dec 2022 23:00:43 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.85-rt55
Date:   Fri, 23 Dec 2022 22:59:28 -0000
Message-ID: <167183636829.152847.13405480898195673998@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.85-rt55 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 167affb50e57a4e26fea150d28a49ff02ed0947b

Or to build 5.15.85-rt55 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.85.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.85-rt55.patch.xz


Enjoy!
Clark

Changes from v5.15.79-rt54:
---

Aashish Sharma (1):
      tracing: Fix warning on variable 'struct trace_array'

Adrian Hunter (2):
      perf/x86/intel/pt: Fix sampling using single range output
      mmc: sdhci: Fix voltage switch delay

Ai Chao (1):
      ALSA: usb-audio: add quirk to fix Hamedal C20 disconnect issue

Aishwarya Kothari (1):
      drm/panel: simple: set bpc field for logic technologies displays

Akihiko Odaki (2):
      e1000e: Fix TX dispatch condition
      igb: Allocate MSI-X vector when testing

Al Cooper (2):
      mmc: sdhci-brcmstb: Re-organize flags
      mmc: sdhci-brcmstb: Enable Clock Gating to save power

Alban Crequy (1):
      maccess: Fix writing offset in case of fault in strncpy_from_kernel_nofault()

Alejandro Concepción Rodríguez (1):
      iio: light: apds9960: fix wrong register for gesture gain

Aleksandr Miloserdov (1):
      nvmet: fix memory leak in nvmet_subsys_attr_model_store_locked

Alex Deucher (1):
      drm/amdgpu: Partially revert "drm/amdgpu: update drm_display_info correctly when the edid is read"

Alexander Potapenko (2):
      misc/vmw_vmci: fix an infoleak in vmci_host_do_receive_datagram()
      mm: fs: initialize fsdata passed to write_begin/write_end interface

Alexandra Winter (1):
      s390/qeth: fix use-after-free in hsci

Alexandre Belloni (1):
      init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with dash

Alexandre Ghiti (1):
      riscv: Sync efi page table's kernel mappings before switching

Aman Dhoot (1):
      Input: synaptics - switch touchpad on HP Laptop 15-da3001TU to RMI mode

Aminuddin Jamaluddin (1):
      net: phy: marvell: add sleep time after enabling the loopback bit

Amir Goldstein (1):
      vfs: fix copy_file_range() averts filesystem freeze protection

Anand Jain (3):
      btrfs: free btrfs_path before copying fspath to userspace
      btrfs: free btrfs_path before copying subvol info to userspace
      btrfs: free btrfs_path before copying inodes to userspace

Anastasia Belova (3):
      cifs: add check for returning value of SMB2_close_init
      cifs: add check for returning value of SMB2_set_info_init
      HID: hid-lg4ff: Add check for empty lbuf

Andreas Gruenbacher (1):
      gfs2: Switch from strlcpy to strscpy

Andreas Kemnade (2):
      regulator: twl6030: re-add TWL6032_SUBCLASS
      regulator: twl6030: fix get status of twl6032 regulators

Andrew Lunn (1):
      i2c: imx: Only DMA messages with I2C_M_DMA_SAFE flag set

Andrew Price (1):
      gfs2: Check sb_bsize_shift after reading superblock

Andrzej Hajda (1):
      drm/i915: fix TLB invalidation for Gen12 video and compute engines

Andy Shevchenko (1):
      pinctrl: intel: Save and restore pins in "direct IRQ" mode

Ankit Patel (1):
      HID: usbhid: Add ALWAYS_POLL quirk for some mice

Arnav Rawat (1):
      platform/x86: ideapad-laptop: Fix interrupt storm on fn-lock toggle on some Yoga laptops

Artem Chernyshev (3):
      net: dsa: ksz: Check return value
      net: dsa: hellcreek: Check return value
      net: dsa: sja1105: Check return value

Asher Song (1):
      Revert "drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for vega10 properly""

Baisong Zhong (1):
      bpf, test_run: Fix alignment problem in bpf_prog_test_run_skb()

Baokun Li (1):
      ext4: fix use-after-free in ext4_ext_shift_extents

Bart Van Assche (1):
      scsi: scsi_debug: Make the READ CAPACITY response compliant with ZBC

Bartosz Golaszewski (2):
      gpiolib: improve coding style for local variables
      gpiolib: check the 'ngpios' property in core gpiolib code

Bean Huo (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Micron Nitro

Benjamin Block (1):
      scsi: zfcp: Fix double free of FSF request when qdio send fails

Benjamin Coddington (1):
      NFSv4: Retry LOCK on OLD_STATEID during delegation return

Benoît Monin (1):
      USB: serial: option: add Sierra Wireless EM9191

Björn Töpel (1):
      riscv: mm: Proper page permissions after initmem free

Borys Popławski (1):
      x86/sgx: Add overflow check in sgx_validate_offset_length()

Brian King (1):
      scsi: ibmvfc: Avoid path failures during live migration

Brian Norris (2):
      firmware: coreboot: Register bus in module init
      mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI

Bruno Thomsen (1):
      USB: serial: cp210x: add Kamstrup RF sniffer PIDs

Caleb Sander (1):
      nvme: fix SRCU protection of nvme_ns_head list

Carlos Llamas (1):
      binder: validate alloc->mm in ->mmap() handler

Catalin Marinas (1):
      arm64: mte: Avoid setting PG_mte_tagged if no tags cleared or restored

Chancel Liu (1):
      ASoC: wm8962: Wait for updated value of WM8962_CLOCKING1 register

Charles Keepax (2):
      ASoC: cs42l51: Correct PGA Volume minimum value
      ASoC: ops: Correct bounds check for second channel on SX controls

Chen Jun (1):
      Input: i8042 - fix leaking of platform device on module removal

Chen Zhongjin (6):
      ASoC: core: Fix use-after-free in snd_soc_exit()
      ASoC: soc-utils: Remove __exit for snd_soc_util_exit()
      xfrm: Fix ignored return value in xfrm6_init()
      iio: core: Fix entry not deleted when iio_register_sw_trigger_type() fails
      nilfs2: fix nilfs_sufile_mark_dirty() not set segment usage as dirty
      Bluetooth: Fix not cleanup led when bt_init fails

ChenXiaoSong (1):
      btrfs: qgroup: fix sleep from invalid context bug in btrfs_qgroup_inherit()

Chevron Li (1):
      mmc: sdhci-pci-o2micro: fix card detect fail issue caused by CD# debounce timeout

Chris Wilson (1):
      drm/i915/gt: Use i915_vm_put on ppgtt_create error paths

Christian König (1):
      drm/amdgpu: always register an MMU notifier for userptr

Christian Langrock (1):
      xfrm: replay: Fix ESN wrap around for GSO

Christian Löhle (1):
      mmc: core: Fix ambiguous TRIM and DISCARD arg

Christoph Hellwig (3):
      nvme-pci: disable namespace identifiers for the MAXIO MAP1001
      btrfs: zoned: fix missing endianness conversion in sb_write_pointer
      btrfs: use kvcalloc in btrfs_get_dev_zone_info

Chuang Wang (1):
      net: macvlan: Use built-in RCU list checking

Clark Williams (3):
      Merge tag 'v5.15.82' into v5.15-rt
      Merge tag 'v5.15.85' into v5.15-rt
      'Linux 5.15.85-rt55'

Claudio Suarez (1):
      drm/amdgpu: update drm_display_info correctly when the edid is read

Claudiu Beznea (1):
      ARM: at91: pm: avoid soft resetting AC DLL

Colin Ian King (1):
      ASoC: codecs: jz4725b: Fix spelling mistake "Sourc" -> "Source", "Routee" -> "Route"

Cong Wang (1):
      kcm: close race conditions on sk_receive_queue

Conor Dooley (1):
      Revert "clocksource/drivers/riscv: Events are stopped during CPU suspend"

Cristian Marussi (1):
      firmware: arm_scmi: Cleanup the core driver removal callback

D Scott Phillips (1):
      arm64: Fix bit-shifting UB in the MIDR_CPU_MODEL() macro

Damien Le Moal (1):
      zonefs: fix zone report size in __zonefs_io_error()

Dan Carpenter (3):
      drbd: use after free in drbd_create_device()
      net: mvneta: Prevent out of bounds read in mvneta_config_rss()
      net: mvneta: Fix an out of bounds check

Daniel Bristot de Oliveira (1):
      tracing/osnoise: Fix duration type

Daniel Díaz (1):
      selftests/net: Find nettest in current directory

Daniel Xu (1):
      netfilter: conntrack: Fix data-races around ct mark

Daniil Tatianin (1):
      ring_buffer: Do not deactivate non-existant pages

David Ahern (1):
      ipv4: Handle attempt to delete multipath route when fib_info contains an nh reference

David E. Box (1):
      platform/x86/intel/pmt: Sapphire Rapids PMT errata fix

David Howells (4):
      rxrpc: Allow list of in-use local UDP endpoints to be viewed in /proc
      rxrpc: Use refcount_t rather than atomic_t
      rxrpc: Fix race between conn bundle lookup and bundle removal [ZDI-CAN-15975]
      afs: Fix fileserver probe RTT handling

David Sterba (1):
      btrfs: sink iterator parameter to btrfs_ioctl_logical_to_ino

Davide Tronchin (4):
      USB: serial: option: remove old LARA-R6 PID
      USB: serial: option: add u-blox LARA-R6 00B modem
      USB: serial: option: add u-blox LARA-L6 modem
      net: usb: qmi_wwan: add u-blox 0x1342 composition

Dawei Li (2):
      dma-buf: fix racing conflict of dma_heap_add()
      drm/vmwgfx: Fix race issue calling pin_user_pages

Derek Fang (1):
      ASoC: rt1019: Fix the TDM settings

Derek Nguyen (1):
      hwmon: (ltc2947) fix temperature scaling

Detlev Casanova (1):
      ASoC: sgtl5000: Reset the CHIP_CLK_CTRL reg on remove

Diana Wang (1):
      nfp: fill splittable of devlink_port_attrs correctly

Dominik Haller (1):
      ARM: dts: am335x-pcm-953: Define fixed regulators in root node

Dominique Martinet (3):
      9p: trans_fd/p9_conn_cancel: drop client lock earlier
      net/9p: use a dedicated spinlock for trans_fd
      9p/xen: check logical size for buffer size

Douglas Anderson (4):
      arm64: dts: qcom: sa8155p-adp: Specify which LDO modes are allowed
      arm64: dts: qcom: sm8150-xperia-kumano: Specify which LDO modes are allowed
      arm64: dts: qcom: sm8250-xperia-edo: Specify which LDO modes are allowed
      arm64: dts: qcom: sm8350-hdk: Specify which LDO modes are allowed

Duke Xin (1):
      USB: serial: option: add Quectel EM05-G modem

Duoming Zhou (3):
      tty: n_gsm: fix sleep-in-atomic-context bug in gsm_control_send
      usb: chipidea: fix deadlock in ci_otg_del_timer
      qlcnic: fix sleep-in-atomic-context bugs caused by msleep

Emeel Hakim (1):
      macsec: add missing attribute validation for offload

Emil Flink (1):
      ALSA: hda/realtek: fix speakers for Samsung Galaxy Book Pro

Emil Renner Berthing (1):
      riscv: dts: sifive unleashed: Add PWM controlled LEDs

Enrico Sau (1):
      net: usb: qmi_wwan: add Telit 0x103a composition

Eric Dumazet (4):
      macvlan: enforce a consistent minimal mtu
      tcp: cdg: allow tcp_cdg_release() to be called multiple times
      kcm: avoid potential race in kcm_tx_work
      ipv6: avoid use-after-free in ip6_fragment()

Eyal Birger (1):
      xfrm: fix "disable_policy" on ipv4 early demux

FUKAUMI Naoki (1):
      arm64: dts: rockchip: keep I2S1 disabled for GPIO function on ROCK Pi 4 series

Fabio Estevam (1):
      ARM: dts: imx6q-prti6q: Fix ref/tcxo-clock-frequency properties

Felix Fietkau (1):
      netfilter: flowtable_offload: add missing locking

Filipe Manana (2):
      btrfs: remove pointless and double ulist frees in error paths of qgroup tests
      btrfs: send: avoid unaligned encoded writes when attempting to clone range

Francesco Dolcini (1):
      Revert "ARM: dts: imx7: Fix NAND controller size-cells"

Frank Jungclaus (1):
      can: esd_usb: Allow REC and TEC to return to zero

Frieder Schrempf (1):
      spi: spi-imx: Fix spi_bus_clk if requested clock is higher than input clock

GUO Zihua (1):
      9p/fd: Use P9_HDRSZ for header size

Gao Xiang (1):
      erofs: fix order >= MAX_ORDER warning due to crafted negative i_size

Gaosheng Cui (5):
      drm/vc4: kms: Fix IS_ERR() vs NULL check for vc4_kms
      bnxt_en: Remove debugfs when pci_register_driver failed
      audit: fix undefined behavior in bit shift for AUDIT_BIT
      hwmon: (ibmpex) Fix possible UAF when ibmpex_register_bmc() fails
      mmc: mtk-sd: Fix missing clk_disable_unprepare in msdc_of_clock_parse()

Gavin Shan (1):
      mm: migrate: fix THP's mapcount on isolation

Giulio Benetti (1):
      ARM: 9266/1: mm: fix no-MMU ZERO_PAGE() implementation

Gleb Mazovetskiy (1):
      tcp: configurable source port perturb table size

Goh, Wei Sheng (1):
      net: stmmac: Set MAC's flow control register to reflect current settings

Greg Kroah-Hartman (7):
      Linux 5.15.80
      lib/vdso: use "grep -E" instead of "egrep"
      Linux 5.15.81
      Linux 5.15.82
      Linux 5.15.83
      Linux 5.15.84
      Linux 5.15.85

Guangbin Huang (1):
      net: hns3: fix setting incorrect phy link ksettings for firmware in resetting process

Guchun Chen (1):
      drm/amdgpu: disable BACO support on more cards

Guillaume BRUN (1):
      drm: bridge: dw_hdmi: fix preference of RGB modes over YUV420

Guo Ren (1):
      riscv: kexec: Fixup irq controller broken in kexec crash path

Haiyang Zhang (1):
      net: mana: Fix race on per-CQ variable napi work_done

Hangbin Liu (2):
      net: use struct_group to copy ip/ipv6 header addresses
      ip_gre: do not report erspan version on GRE interface

Hans Verkuil (2):
      media: videobuf2-core: take mmap_lock in vb2_get_unmapped_area()
      media: v4l2-dv-timings.c: fix too strict blanking sanity checks

Hans de Goede (9):
      ACPI: scan: Add LATT2021 to acpi_ignore_dep_ids[]
      platform/x86: touchscreen_dmi: Add info for the RCA Cambio W101 v2 2-in-1
      drm: panel-orientation-quirks: Add quirk for Acer Switch V 10 (SW5-017)
      ASoC: Intel: bytcht_es8316: Add quirk for the Nanote UMPC-01
      Input: goodix - try resetting the controller when no config is set
      Input: soc_button_array - add use_low_level_irq module parameter
      Input: soc_button_array - add Acer Switch V 10 to dmi_use_low_level_irq[]
      platform/x86: acer-wmi: Enable SW_TABLET_MODE on Switch V 10 (SW5-017)
      HID: ite: Enable QUIRK_TOUCHPAD_ON_OFF_REPORT on Acer Aspire Switch V 10

Harshit Mogalapalli (1):
      io_uring: Fix a null-ptr-deref in io_tctx_exit_cb()

Hauke Mehrtens (1):
      ca8210: Fix crash by zero initializing data

Hawkins Jiawei (4):
      wifi: wext: use flex array destination for memcpy()
      ntfs: fix use-after-free in ntfs_attr_find()
      ntfs: fix out-of-bounds read in ntfs_attr_find()
      ntfs: check overflow when iterating ATTR_RECORDs

Heiko Carstens (2):
      s390/crashdump: fix TOD programmable field size
      s390/qeth: fix various format strings

Heiko Schocher (1):
      can: sja1000: fix size of OCR_MODE_MASK define

Helge Deller (1):
      parisc: Increase FRAME_WARN to 2048 bytes on parisc

Herbert Xu (1):
      af_key: Fix send_acquire race with pfkey_register

Hou Tao (3):
      bpf, perf: Use subprog name when reporting subprog ksymbol
      libbpf: Handle size overflow for ringbuf mmap
      libbpf: Use page size as max_entries when probing ring buffer map

Hsin-Yi Wang (1):
      drm/bridge: anx7625: Fix edid_read break case in sp_tx_edid_read()

Hugh Dickins (1):
      mm: __isolate_lru_page_prepare() in isolate_migratepages_block()

Hui Tang (1):
      net: mvpp2: fix possible invalid pointer dereference

Ido Schimmel (4):
      bridge: switchdev: Fix memory leaks when changing VLAN protocol
      ipv4: Fix route deletion when nexthop info is not specified
      ipv4: Fix incorrect route flushing when source address is deleted
      ipv4: Fix incorrect route flushing when table ID 0 is used

Ilpo Järvinen (6):
      serial: 8250: Fall back to non-DMA Rx if IIR_RDI occurs
      serial: 8250: Flush DMA Rx on RLSI
      serial: 8250_lpss: Configure DMA also w/o DMA filter
      serial: 8250_lpss: Use 16B DMA burst with Elkhart Lake
      serial: Add rs485_supported to uart_port
      serial: fsl_lpuart: Fill in rs485_supported

Ismael Ferreras Morezuelas (1):
      Bluetooth: btusb: Add debug message for CSR controllers

Ivan Hu (1):
      platform/x86/intel/hid: Add some ACPI device IDs

Ivan Vecera (2):
      iavf: Fix a crash during reset task
      iavf: Do not restart Tx queues after reset task failure

Izabela Bakollari (1):
      aquantia: Do not purge addresses when setting the number of rings

Jaco Coetzee (2):
      nfp: change eeprom length to max length enumerators
      nfp: add port from netdev validation for EEPROM access

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: lower rk3399-puma-haikou SD controller clock frequency

James Houghton (1):
      hugetlbfs: don't delete error page from pagecache

Jan Dabros (1):
      char: tpm: Protect tpm_pm_suspend with locks

Jan Kara (4):
      udf: Discard preallocation before extending file with a hole
      udf: Fix preallocation discarding at indirect extent boundary
      udf: Do not bother looking for prealloc extents if i_lenExtents matches i_size
      udf: Fix extending file within last block

Jann Horn (5):
      ipc/sem: Fix dangling sem_array access in semtimedop race
      fs: use acquire ordering in __fget_light()
      mm/khugepaged: take the right locks for page table retraction
      mm/khugepaged: fix GUP-fast interaction by sending IPI
      mm/khugepaged: invoke MMU notifiers in shmem/file collapse paths

Janusz Krzysztofik (2):
      drm/i915: Fix negative value passed as remaining time
      drm/i915: Never return 0 if not all requests retired

Jason A. Donenfeld (2):
      wifi: airo: do not assign -1 to unsigned char
      MIPS: pic32: treat port as signed integer

Jens Axboe (1):
      io_uring: move to separate directory

Jerry Ray (1):
      dsa: lan9303: Correct stat name

Jialiang Wang (1):
      nfp: fix use-after-free in area_cache_get()

Jiasheng Jiang (3):
      ASoC: max98373: Add checks for devm_kcalloc
      octeontx2-pf: Add check for devm_kcalloc
      can: m_can: Add check for devm_clk_get

Jisheng Zhang (3):
      riscv: vdso: fix section overlapping under some conditions
      riscv: fix race when vmap stack overflow
      net: stmmac: fix "snps,axi-config" node property parsing

Johan Hovold (3):
      Revert "usb: dwc3: disable USB core PHY management"
      USB: serial: f81232: fix division by zero on line-speed change
      USB: serial: f81534: fix division by zero on line-speed change

Johan Jonker (4):
      ARM: dts: rockchip: fix ir-receiver node names
      arm64: dts: rockchip: fix ir-receiver node names
      ARM: dts: rockchip: rk3188: fix lcdc1-rgb24 node name
      ARM: dts: rockchip: disable arm_global_timer on rk3066 and rk3188

Johannes Berg (2):
      wifi: cfg80211: fix buffer overflow in elem comparison
      wifi: cfg80211: don't allow multi-BSSID in S1G

Johannes Weiner (1):
      mm: vmscan: fix extreme overreclaim and swap floods

John Starks (1):
      mm/gup: fix gup_pud_range() for dax

Jonas Jelonek (1):
      wifi: mac80211_hwsim: fix debugfs attribute ps with rc table support

Josef Bacik (1):
      btrfs: free btrfs_path before copying root refs to userspace

José Expósito (1):
      HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk

Jozsef Kadlecsik (1):
      netfilter: ipset: restore allowing 64 clashing elements in hash:net,iface

Juergen Gross (3):
      xen/netback: do some code cleanup
      xen/netback: don't call kfree_skb() with interrupts disabled
      xen/netback: fix build warning

Junxiao Chang (1):
      ASoC: hdac_hda: fix hda pcm buffer overflow issue

Kai-Heng Feng (1):
      platform/x86: hp-wmi: Ignore Smart Experience App event

Kazuki Takiguchi (1):
      KVM: x86/mmu: Fix race condition in direct_page_fault

Kees Cook (2):
      ALSA: seq: Fix function prototype mismatch in snd_seq_expand_var_event
      NFC: nci: Bounds check struct nfc_target arrays

Keith Busch (2):
      nvme: restrict management ioctls to admin
      nvme: ensure subsystem reset is single threaded

Kenneth Lee (1):
      ceph: Use kcalloc for allocating multiple elements

Konrad Dybcio (1):
      regulator: slg51000: Wait after asserting CS pin

Krzysztof Kozlowski (1):
      slimbus: stream: correct presence rate frequencies

Kuniyuki Iwashima (3):
      arm64/syscall: Include asm/ptrace.h in syscall_wrapper header.
      dccp/tcp: Reset saddr on failure after inet6?_hash_connect().
      af_unix: Get user_ns from in_skb in unix_diag_get_exact().

Lars-Peter Clausen (1):
      iio: ms5611: Simplify IO callback parameters

Lee Jones (2):
      drm/amdgpu: temporarily disable broken Clang builds due to blown stack-frame
      Kconfig.debug: provide a little extra FRAME_WARN leeway when KASAN is enabled

Lei Rao (1):
      nvme-pci: clear the prp2 field when not used

Leo Liu (1):
      drm/amdgpu: enable Vangogh VCN indirect sram mode

Leo Savernik (1):
      nvme: add a bogus subsystem NQN quirk for Micron MTFDKBA2T0TFH

Leon Romanovsky (1):
      net: liquidio: simplify if expression

Li Huafei (1):
      kprobes: Skip clearing aggrprobe's post_handler in kprobe-on-ftrace case

Li Jun (1):
      usb: cdns3: host: fix endless superspeed hub port reset

Liao Chang (1):
      MIPS: Loongson64: Add WARN_ON on kexec related kmalloc failed

Like Xu (1):
      KVM: x86/pmu: Do not speculatively query Intel GP PMCs that don't exist yet

Lin Liu (1):
      xen-netfront: Fix NULL sring after live migration

Lin Ma (2):
      nfc/nci: fix race with opening and closing
      io_uring/poll: fix poll_refs race with cancelation

Linus Torvalds (3):
      v4l2: don't fall back to follow_pfn() if pin_user_pages_fast() fails
      proc: avoid integer type confusion in get_proc_long
      proc: proc_skip_spaces() shouldn't think it is working on C strings

Linus Walleij (2):
      USB: bcma: Make GPIO explicitly optional
      bus: ixp4xx: Don't touch bit 7 on IXP42x

Liu Jian (5):
      net: ag71xx: call phylink_disconnect_phy if ag71xx_hw_enable() fail in ag71xx_open()
      net: ethernet: mtk_eth_soc: fix error handling in mtk_open()
      net: sparx5: fix error handling in sparx5_port_open()
      net: hisilicon: Fix potential use-after-free in hisi_femac_rx()
      net: hisilicon: Fix potential use-after-free in hix5hd2_rx()

Liu Shixin (1):
      NFC: nci: fix memory leak in nci_rx_data_packet()

Lorenzo Bianconi (1):
      wifi: mac8021: fix possible oob access in ieee80211_get_rate_duration

Luiz Augusto von Dentz (2):
      Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm
      Bluetooth: Fix crash when replugging CSR fake controllers

Luiz Capitulino (4):
      genirq/msi: Shutdown managed interrupts with unsatifiable affinities
      genirq: Always limit the affinity to online CPUs
      irqchip/gic-v3: Always trust the managed affinity provided by the core code
      genirq: Take the proposed affinity at face value if force==true

Lukas Wunner (2):
      serial: 8250: 8250_omap: Avoid RS485 RTS glitch on ->set_termios()
      serial: stm32: Deassert Transmit Enable on ->rs485_config()

Lyude Paul (2):
      drm/amd/dc/dce120: Fix audio register mapping, stop triggering KASAN
      drm/display/dp_mst: Fix drm_dp_mst_add_affected_dsc_crtcs() return code

M Chetan Kumar (2):
      net: wwan: iosm: fix kernel test robot reported error
      net: wwan: iosm: fix dma_alloc_coherent incompatible pointer type

Maarten Lankhorst (1):
      drm/i915: Create a dummy object for gen6 ppgtt

Maarten Zanders (1):
      ASoC: fsl_asrc fsl_esai fsl_sai: allow CONFIG_PM=N

Maciej W. Rozycki (1):
      parport_pc: Avoid FIFO port location truncation

Manyi Li (1):
      platform/x86: ideapad-laptop: Disable touchpad_switch

Marc Zyngier (1):
      KVM: arm64: pkvm: Fixup boot mode to reflect that the kernel resumes from EL1

Marco Elver (1):
      perf: Improve missing SIGTRAP checking

Marco Felsch (1):
      ASoC: fsl_sai: use local device pointer

Marek Marczykowski-Górecki (1):
      xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too

Marek Szyprowski (1):
      usb: dwc3: exynos: Fix remove() function

Marek Vasut (6):
      spi: stm32: Print summary 'callbacks suppressed' message
      ARM: dts: imx7: Fix NAND controller size-cells
      arm64: dts: imx8mm: Fix NAND controller size-cells
      arm64: dts: imx8mn: Fix NAND controller size-cells
      serial: stm32: Factor out GPIO RTS toggling into separate function
      serial: stm32: Use TC interrupt to deassert GPIO RTS in RS485 mode

Mario Limonciello (1):
      ACPI: x86: Add another system to quirk list for forcing StorageD3Enable

Mark Brown (2):
      ASoC: ops: Fix bounds check for _sx controls
      ASoC: ops: Check bounds for second channel in snd_soc_put_volsw_sx()

Martin Faltesek (3):
      nfc: st-nci: fix incorrect validating logic in EVT_TRANSACTION
      nfc: st-nci: fix memory leaks in EVT_TRANSACTION
      nfc: st-nci: fix incorrect sizing calculations in EVT_TRANSACTION

Martin Povišer (2):
      ASoC: tas2770: Fix set_tdm_slot in case of single slot
      ASoC: tas2764: Fix set_tdm_slot in case of single slot

Masahiro Yamada (1):
      block: move CONFIG_BLOCK guard to top Makefile

Mateusz Jończyk (3):
      rtc: mc146818-lib: extract mc146818_avoid_UIP
      rtc: cmos: avoid UIP when writing alarm time
      rtc: cmos: avoid UIP when reading alarm time

Matthias Schiffer (1):
      serial: 8250_omap: remove wait loop from Errata i202 workaround

Matthieu Baerts (1):
      selftests: mptcp: fix mibit vs mbit mix up

Matti Vaittinen (1):
      tools: iio: iio_generic_buffer: Fix read size

Mauro Lima (1):
      spi: intel: Fix the offset to get the 64K erase opcode

Maxim Korotkov (1):
      pinctrl: single: Fix potential division by zero

Maxim Levitsky (5):
      KVM: x86: nSVM: leave nested mode on vCPU free
      KVM: x86: forcibly leave nested mode on vCPU reset
      KVM: x86: nSVM: harden svm_free_nested against freeing vmcb02 while still in use
      KVM: x86: add kvm_leave_nested
      KVM: x86: remove exit_int_info warning in svm_handle_exit

Maximilian Luz (1):
      platform/surface: aggregator: Do not check for repeated unsequenced packets

Michael Grzeschik (3):
      ARM: dts: at91: sam9g20ek: enable udc vbus gpio pinctrl
      usb: dwc3: gadget: conditionally remove requests
      ARM: at91: rm9200: fix usb device clock id

Michael Kelley (2):
      scsi: storvsc: Fix handling of srb_status and capacity change events
      x86/ioremap: Fix page aligned size calculation in __ioremap_caller()

Michael Margolin (1):
      RDMA/efa: Add EFA 0xefa2 PCI ID

Michael Walle (1):
      net: phy: mxl-gpy: fix version reporting

Michal Jaron (1):
      i40e: Fix not setting default xps_cpus after reset

Mihai Sain (1):
      ARM: dts: at91: sama7g5: fix signal name of pin PB2

Mika Westerberg (2):
      mtd: spi-nor: intel-spi: Disable write protection only if asked
      spi: intel: Use correct mask for flash and protected regions

Miklos Szeredi (1):
      fuse: lock inode unconditionally in fuse_fallocate()

Mikulas Patocka (3):
      dm ioctl: fix misbehavior if list_versions races with module loading
      dm integrity: flush the journal on suspend
      dm integrity: clear the journal on suspend

Minghao Chi (1):
      iavf: remove redundant ret variable

Mitja Spes (2):
      iio: pressure: ms5611: changed hardcoded SPI speed to value limited
      iio: pressure: ms5611: fixed value compensation bug

Mohd Faizal Abdul Rahim (1):
      net: stmmac: ensure tx function is not running in stmmac_xdp_release()

Moshe Shemesh (2):
      net/mlx5: Fix FW tracer timestamp calculation
      net/mlx5: Fix handling of entry refcount when command is not issued to FW

Mukesh Ojha (1):
      gcov: clang: fix the buffer overflow issue

Mushahid Hussain (1):
      speakup: fix a segfault caused by switching consoles

Nam Cao (1):
      i2c: i801: add lis3lv02d's I2C address for Vostro 5568

Nathan Chancellor (2):
      RISC-V: vdso: Do not add missing symbols to version section in linker script
      x86/vdso: Conditionally export __vdso_sgx_enter_enclave()

Nathan Huckleberry (1):
      drm/imx: imx-tve: Fix return type of imx_tve_connector_mode_valid

Nicolas Cavallari (1):
      wifi: mac80211: Fix ack frame idr leak when mesh has no route

Nicolas Dumazet (1):
      usb: add NO_LPM quirk for Realforce 87U Keyboard

Niklas Cassel (1):
      ata: libata-core: do not issue non-internal commands once EH is pending

Nikolay Aleksandrov (2):
      selftests: net: add delete nexthop route warning test
      selftests: net: fix nexthop warning cleanup double ip typo

Nikolay Borisov (1):
      btrfs: move QUOTA_ENABLED check to rescan_should_stop from btrfs_qgroup_rescan_worker

Ninad Malwade (1):
      hwmon: (ina3221) Fix shunt sum critical calculation

Oleksij Rempel (1):
      net: mdiobus: fwnode_mdiobus_register_phy() rework error handling

Oliver Hartkopp (1):
      can: af_can: fix NULL pointer dereference in can_rcv_filter

Olivier Moysan (1):
      ASoC: stm32: dfsdm: manage cb buffers cleanup

Pablo Neira Ayuso (2):
      netfilter: nf_tables: do not set up extensions for end interval
      netfilter: ctnetlink: fix compilation warning after data race fixes in ct mark

Pankaj Raghav (1):
      nvme initialize core quirks before calling nvme_init_subsystem

Paolo Abeni (1):
      selftests: mptcp: more stable simult_flows tests

Paul Gazzillo (1):
      iio: light: rpr0521: add missing Kconfig dependencies

Paulo Alcantara (4):
      cifs: introduce new helper for cifs_reconnect()
      cifs: split out dfs code from cifs_reconnect()
      cifs: support nested dfs links over reconnect
      cifs: fix missed refcounting of ipc tcon

Pavel Begunkov (4):
      io_uring: update res mask in io_poll_check_events
      io_uring: fix tw losing poll events
      io_uring: cmpxchg for poll arm refs release
      io_uring: make poll refs more robust

Pawan Gupta (3):
      x86/tsx: Add a feature bit for TSX control MSR support
      x86/pm: Add enumeration check before spec MSRs save/restore setup
      x86/bugs: Make sure MSR_SPEC_CTRL is updated properly upon resume from S3

Pawel Laszczak (2):
      usb: cdnsp: Fix issue with Clear Feature Halt Endpoint
      usb: cdnsp: fix issue with ZLP - added TD_SIZE = 1

Peter Kosyh (1):
      net/mlx4: Check retval of mlx4_bitmap_init

Peter Zijlstra (1):
      perf: Fix perf_pending_task() UaF

Phil Auld (1):
      hwmon: (coretemp) Check for null before removing sysfs attrs

Phil Turnbull (4):
      wifi: wilc1000: validate pairwise and authentication suite offsets
      wifi: wilc1000: validate length of IEEE80211_P2P_ATTR_OPER_CHANNEL attribute
      wifi: wilc1000: validate length of IEEE80211_P2P_ATTR_CHANNEL_LIST attribute
      wifi: wilc1000: validate number of channels

Pierre-Louis Bossart (1):
      ASoC: Intel: sof_sdw: add quirk variant for LAPBC710 NUC15

Prike Liang (1):
      drm/amdgpu/sdma_v4_0: turn off SDMA ring buffer in the s2idle suspend

Przemyslaw Patynowski (1):
      i40e: Disallow ip4 and ip6 l4_4_bytes

Qiheng Lin (1):
      net: microchip: sparx5: Fix missing destroy_workqueue of mact_queue

Qiqi Zhang (1):
      drm/bridge: ti-sn65dsi86: Fix output polarity setting bug

Qu Wenruo (1):
      btrfs: raid56: properly handle the error when unable to find the missing stripe

Quentin Schulz (1):
      pinctrl: rockchip: list all pins in a possible mux route for PX30

Radu Nicolae Pirea (OSS) (1):
      net: dsa: sja1105: avoid out of bounds access in sja1105_init_l2_policing()

Rajat Khandelwal (1):
      usb: typec: mux: Enter safe mode only when pins need to be reconfigured

Ramesh Errabolu (1):
      drm/amdgpu: Enable Aldebaran devices to report CU Occupancy

Randy Dunlap (1):
      nios2: add FORCE for vmlinuz.gz

Rasmus Villemoes (3):
      net: fec: don't reset irq coalesce settings to defaults on "ip link up"
      net: fec: properly guard irq coalesce setup
      net: loopback: use NET_NAME_PREDICTABLE for name_assign_type

Reinette Chatre (1):
      x86/sgx: Create utility to validate user provided offset and length

Reinhard Speyerer (1):
      USB: serial: option: add Fibocom FM160 0x0111 composition

Reka Norman (1):
      xhci: Apply XHCI_RESET_TO_DEFAULT quirk to ADL-N

Ricardo Cañuelo (2):
      selftests/futex: fix build for clang
      selftests/intel_pstate: fix build for ARCH=x86_64

Ricardo Ribalda (1):
      pinctrl: meditatek: Startup with the IRQs disabled

Richard Fitzgerald (1):
      ASoC: soc-pcm: Don't zero TDM masks in __soc_pcm_open()

Rob Clark (2):
      drm/shmem-helper: Remove errant put in error path
      drm/shmem-helper: Avoid vm_open error paths

Robin Murphy (1):
      gpu: host1x: Avoid trying to use GART on Tegra20

Rodrigo Siqueira (2):
      drm/amd/display: Remove wrong pipe control lock
      drm/amd/display: Add HUBP surface flip interrupt handler

Roger Pau Monné (1):
      platform/x86/intel: pmc: Don't unconditionally attach Intel PMC when virtualized

Roi Dayan (1):
      net/mlx5e: Fix use-after-free when reverting termination table

Ronak Doshi (2):
      vmxnet3: correctly report encapsulated LRO packet
      vmxnet3: use correct intrConf reference when using extended queues

Rongwei Zhang (1):
      MIPS: fix duplicate definitions for exported symbols

Ross Lagerwall (1):
      xen/netback: Ensure protocol headers don't fall in the non-linear area

Roy Novich (1):
      net/mlx5: Do not query pci info while pci disabled

Sabrina Dubroca (1):
      Revert "net: macsec: report real_dev features when HW offloading is enabled"

Samuel Holland (2):
      bus: sunxi-rsb: Remove the shutdown callback
      bus: sunxi-rsb: Support atomic transfers

Saravanan Sekar (2):
      iio: adc: mp2629: fix wrong comparison of channel
      iio: adc: mp2629: fix potential array out of bound access

Sean Nyekjaer (1):
      spi: stm32: fix stm32_spi_prepare_mbr() that halves spi clk for every run

Sebastian Falbesoner (1):
      mmc: sdhci-esdhc-imx: correct CQHCI exit halt state check

Sebastian Reichel (2):
      arm: dts: rockchip: fix node name for hym8563 rtc
      arm: dts: rockchip: remove clock-frequency from rtc

Serge Semin (1):
      block: sed-opal: kmalloc the cmd/resp buffers

Shang XiaoJing (9):
      drm/drv: Fix potential memory leak in drm_dev_init()
      drm: Fix potential null-ptr-deref in drm_vblank_destroy_worker()
      net: microchip: sparx5: Fix potential null-ptr-deref in sparx_stats_init() and sparx5_start()
      tracing: Fix memory leak in test_gen_synth_cmd() and test_empty_synth_event()
      tracing: Fix wild-memory-access in register_synth_event()
      tracing: kprobe: Fix potential null-ptr-deref on trace_event_file in kprobe_event_gen_test_exit()
      tracing: kprobe: Fix potential null-ptr-deref on trace_array in kprobe_event_gen_test_exit()
      ixgbevf: Fix resource leak in ixgbevf_init_module()
      i40e: Fix error handling in i40e_init_module()

Shawn Guo (1):
      serial: imx: Add missing .thaw_noirq hook

Shengjiu Wang (2):
      ASoC: fsl_micfil: explicitly clear software reset bit
      ASoC: fsl_micfil: explicitly clear CHnF flags

Sherry Sun (1):
      tty: serial: fsl_lpuart: don't break the on-going transfer when global reset

Shigeru Yoshida (1):
      net: tun: Fix use-after-free in tun_detach()

Shruthi Sanil (1):
      usb: dwc3: pci: Update PCIe device ID for USB3 controller on CPU sub-system for Raptor Lake

Shuah Khan (1):
      docs: update mediator contact information in CoC doc

Shuming Fan (2):
      ASoC: rt1308-sdw: add the default value of some registers
      ASoC: rt711-sdca: fix the latency time of clock stop prepare state machine transitions

Siarhei Volkau (4):
      ASoC: codecs: jz4725b: add missed Line In power control bit
      ASoC: codecs: jz4725b: fix reported volume for Master ctl
      ASoC: codecs: jz4725b: use right control for Capture Volume
      ASoC: codecs: jz4725b: fix capture selector naming

Simon Rettberg (1):
      drm/display: Don't assume dual mode adaptors support i2c sub-addressing

Sjoerd Simons (1):
      soundwire: intel: Initialize clock stop timeout

Slawomir Laba (1):
      iavf: Fix race condition between iavf_shutdown and iavf_remove

Srikar Dronamraju (1):
      scripts/faddr2line: Fix regression in name resolution on ppc64le

Srinivasa Rao Mandadapu (1):
      ASoC: soc-pcm: Add NULL check in BE reparenting

Stefan Haberland (1):
      s390/dasd: fix no record found for raw_track_access

Stefano Brivio (1):
      netfilter: nft_set_pipapo: Actually validate intervals in fields after the first one

Steven Rostedt (Google) (6):
      tracing/ring-buffer: Have polling block on watermark
      tracing: Fix race where eprobes can be called before the event
      ring-buffer: Include dropped pages in counting dirty patches
      error-injection: Add prompt for function error injection
      tracing: Fix race where histograms can be called before the event
      tracing: Free buffers when a used dynamic event is removed

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix u8 overflow

Svyatoslav Feldsherov (1):
      fs: do not update freeing inode i_io_list

Sylwester Dziedziuch (1):
      i40e: Fix for VF MAC address 0

Szymon Heidrich (1):
      usb: gadget: uvc: Prevent buffer overflow in setup handler

Takashi Iwai (3):
      ALSA: usb-audio: Drop snd_BUG_ON() from snd_usbmidi_output_open()
      ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book Pro 360
      Input: i8042 - apply probe defer to more ASUS ZenBook models

Takashi Sakamoto (1):
      ALSA: dice: fix regression for Lexicon I-ONIX FW810S

Tejun Heo (1):
      memcg: fix possible use-after-free in memcg_write_event_control()

Tetsuo Handa (3):
      Input: iforce - invert valid length check when fetching device IDs
      9p/trans_fd: always use O_NONBLOCK read/write
      fbcon: Use kzalloc() in fbcon_prepare_logo()

Thierry Reding (1):
      i2c: tegra: Allocate DMA memory for DMA engine

Thinh Nguyen (3):
      usb: dwc3: gadget: Return -ESHUTDOWN on ep disable
      usb: dwc3: gadget: Clear ep descriptor last
      usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for End Transfer

Thomas Huth (1):
      KVM: s390: vsie: Fix the initialization of the epoch extension (epdx) field

Thomas Jarosch (1):
      xfrm: Fix oops in __xfrm_state_delete()

Tiago Dias Ferreira (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV7000

Tiezhu Yang (2):
      tools/vm/slabinfo-gnuplot: use "grep -E" instead of "egrep"
      selftests: net: Use "grep -E" instead of "egrep"

Tina Zhang (2):
      iommu/vt-d: Preset Access bit for IOVA in FL non-leaf paging entries
      iommu/vt-d: Set SRE bit only when hardware has SRS cap

Tomislav Novak (1):
      ARM: 9251/1: perf: Fix stacktraces for tracepoint events in THUMB2 kernels

Tony Lindgren (3):
      serial: 8250: omap: Fix missing PM runtime calls for omap8250_set_mctrl()
      serial: 8250: omap: Fix unpaired pm_runtime_put_sync() in omap8250_remove()
      serial: 8250: omap: Flush PM QOS work on remove

Tony Luck (1):
      x86/cpu: Add several Intel server CPU model numbers

Tony Nguyen (1):
      igb: Initialize mailbox message for VF reset

Tsung-hua Lin (1):
      drm/amd/display: No display after resume from WB/CB

Tyler J. Stachecki (1):
      wifi: ath11k: Fix QCN9074 firmware boot on x86

Uwe Kleine-König (3):
      clk: generalize devm_clk_get() a bit
      clk: Provide new devm_clk helpers for prepared and enabled clocks
      clk: Fix pointer casting to prevent oops in devm_clk_release()

Valentina Goncharenko (2):
      net: encx24j600: Add parentheses to fix precedence
      net: encx24j600: Fix invalid logic in reading of MISTAT register

Vishal Verma (2):
      ACPI: HMAT: remove unnecessary variable initialization
      ACPI: HMAT: Fix initiator registration for single-initiator systems

Vishwanath Pai (1):
      netfilter: ipset: regression in ip_set_hash_ip.c

Vitaly Kuznetsov (1):
      x86/hyperv: Restore VP assist page after cpu offlining/onlining

Vladimir Oltean (5):
      net: dsa: make dsa_master_ioctl() see through port_hwtstamp_get() shims
      net: dsa: sja1105: disallow C45 transactions on the BASE-TX MDIO bus
      net: enetc: manage ENETC_F_QBV in priv->active_offloads only when enabled
      net: enetc: cache accesses to &priv->si->hw
      net: enetc: preserve TX ring priority across reconfiguration

Wang Hai (4):
      net: pch_gbe: fix potential memleak in pch_gbe_tx_queue()
      arcnet: fix potential memory leak in com20020_probe()
      e100: Fix possible use after free in e100_xmit_prepare
      net/9p: Fix a potential socket leak in p9_socket_open

Wang ShaoBo (3):
      mISDN: fix misuse of put_device() in mISDN_register_device()
      net: wwan: iosm: use ACPI_FREE() but not kfree() in ipc_pcie_read_bios_cfg()
      Bluetooth: 6LoWPAN: add missing hci_dev_put() in get_l2cap_conn()

Wang Wensheng (2):
      ftrace: Fix the possible incorrect kernel message
      ftrace: Optimize the allocation for mcount entries

Wang Yufen (3):
      bpf: Fix memory leaks in __check_func_call
      tracing: Fix memory leak in tracing_read_pipe()
      gpio/rockchip: fix refcount leak in rockchip_gpiolib_register()

Wei Yongjun (7):
      net: bgmac: Drop free_netdev() from bgmac_enet_remove()
      net: mhi: Fix memory leak in mhi_net_dellink()
      net/x25: Fix skb leak in x25_lapb_receive_frame()
      iio: health: afe4403: Fix oob read in afe4403_read_raw
      iio: health: afe4404: Fix oob read in afe4404_[read|write]_raw
      nvmem: rmem: Fix return value check in rmem_read()
      mac802154: fix missing INIT_LIST_HEAD in ieee802154_if_add()

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix no reset data and command after voltage switch

Wenchao Hao (1):
      ata: libata-scsi: simplify __ata_scsi_queuecmd()

Willem de Bruijn (1):
      packet: do not set TP_STATUS_CSUM_VALID on CHECKSUM_COMPLETE

Xander Li (1):
      nvme-pci: disable write zeroes on various Kingston SSD

Xiaolei Wang (2):
      ASoC: wm8962: Add an event handler for TEMP_HP and TEMP_SPK
      soc: imx8m: Enable OCOTP clock before reading the register

Xin Long (7):
      sctp: remove the unnecessary sinfo_stream check in sctp_prsctp_prune_unsent
      sctp: clear out_curr if all frag chunks of current msg are pruned
      tipc: set con sock in tipc_conn_alloc
      tipc: add an extra conn_get in tipc_conn_alloc
      net: sched: allow act_ct to be built without NF_NAT
      tipc: re-fetch skb cb after tipc_msg_validate
      tipc: call tipc_lxc_xmit without holding node_read_lock

Xiongfeng Wang (7):
      mmc: sdhci-pci: Fix possible memory leak caused by missing pci_dev_put()
      spi: dw-dma: decrease reference count in dw_spi_dma_init_mfld()
      octeontx2-af: Fix reference count issue in rvu_sdp_init()
      platform/x86: asus-wmi: add missing pci_dev_put() in asus_wmi_set_xusb2pr()
      iommu/vt-d: Fix PCI device refcount leak in has_external_pci()
      iommu/vt-d: Fix PCI device refcount leak in dmar_dev_scope_init()
      gpio: amd8111: Fix PCI device reference count leak

Xiu Jianfeng (1):
      ftrace: Fix null pointer dereference in ftrace_add_mod()

Xiubo Li (3):
      ceph: do not update snapshot context when there is no new snapshot
      ceph: avoid putting the realm twice when decoding snaps fails
      ceph: fix NULL pointer dereference for req->r_session

Xu Kuohai (2):
      bpf: Initialize same number of free nodes for each pcpu_freelist
      bpf: Do not copy spin lock field from user in bpf_selem_alloc

Yang Shi (3):
      mm: hwpoison: refactor refcount check handling
      mm: hwpoison: handle non-anonymous THP correctly
      mm: shmem: don't truncate page if memory failure happens

Yang Yingliang (25):
      scsi: scsi_transport_sas: Fix error handling in sas_phy_add()
      siox: fix possible memory leak in siox_device_add()
      ata: libata-transport: fix double ata_host_put() in ata_tport_add()
      ata: libata-transport: fix error handling in ata_tport_add()
      ata: libata-transport: fix error handling in ata_tlink_add()
      ata: libata-transport: fix error handling in ata_tdev_add()
      mISDN: fix possible memory leak in mISDN_dsp_element_register()
      xen/pcpu: fix possible memory leak in register_pcpu()
      iio: adc: at91_adc: fix possible memory leak in at91_adc_allocate_trigger()
      iio: trigger: sysfs: fix possible memory leak in iio_sysfs_trig_init()
      scsi: target: tcm_loop: Fix possible name leak in tcm_loop_setup_hba_bus()
      regulator: core: fix UAF in destroy_regulator()
      tee: optee: fix possible memory leak in optee_register_device()
      octeontx2-af: debugsfs: fix pci device refcount leak
      net: pch_gbe: fix pci device refcount leak while module exiting
      Drivers: hv: vmbus: fix double free in the error path of vmbus_add_channel_work()
      Drivers: hv: vmbus: fix possible memory leak in vmbus_device_register()
      bnx2x: fix pci device refcount leak in bnx2x_vf_is_pcie_pending()
      hwmon: (i5500_temp) fix missing pci_disable_device()
      of: property: decrement node refcount in of_fwnode_get_reference_args()
      net: phy: fix null-ptr-deref while probe() failed
      net: mdiobus: fix unbalanced node reference count
      hwmon: (coretemp) fix pci device refcount leak in nv1a_ram_new()
      net: mdiobus: fix double put fwnode in the error path
      net: plip: don't call kfree_skb/dev_kfree_skb() under spin_lock_irq()

Yann Gautier (1):
      mmc: core: properly select voltage range without power cycle

Yasushi SHOJI (1):
      can: mcba_usb: Fix termination command argument

Ye Bin (1):
      mmc: mmc_test: Fix removal of debugfs file

Yevgeny Kliteynik (1):
      net/mlx5: DR, Rename list field in matcher struct to list_node

Yongqiang Liu (1):
      net: thunderx: Fix missing destroy_workqueue of nicvf_rx_mode_wq

Yoshihiro Shimoda (1):
      net: ethernet: renesas: ravb: Fix promiscuous mode after system resumed

Youlin Li (1):
      selftests/bpf: Add verifier test for release_reference()

Yu Kuai (1):
      block, bfq: fix null pointer dereference in bfq_bio_bfqg()

Yu Liao (1):
      net: thunderx: Fix the ACPI memory leak

Yuan Can (10):
      net: hinic: Fix error handling in hinic_module_init()
      net: ionic: Fix error handling in ionic_init_module()
      net: ena: Fix error handling in ena_init()
      net: thunderbolt: Fix error handling in tbnet_init()
      scsi: scsi_debug: Fix possible UAF in sdebug_add_host_helper()
      fm10k: Fix error handling in fm10k_init_module()
      iavf: Fix error handling in iavf_init_module()
      net: net_netdev: Fix error handling in ntb_netdev_init_module()
      i2c: npcm7xx: Fix error handling in npcm_i2c_init()
      dpaa2-switch: Fix memory leak in dpaa2_switch_acl_entry_add() and dpaa2_switch_acl_entry_remove()

YueHaibing (7):
      macsec: Fix invalid error code set
      tipc: check skb_linearize() return value in tipc_disc_rcv()
      net/mlx5: DR, Fix uninitialized var warning
      net/mlx5: Fix uninitialized variable bug in outlen_write()
      net: hsr: Fix potential use-after-free
      net: broadcom: Add PTP_1588_CLOCK_OPTIONAL dependency for BCMGENET under ARCH_BCM2835
      tipc: Fix potential OOB in tipc_link_proto_rcv()

Yuri Karpov (1):
      net: ethernet: nixge: fix NULL dereference

Zack Rusin (1):
      drm/vmwgfx: Don't use screen objects when SEV is active

Zeng Heng (5):
      pinctrl: devicetree: fix null pointer dereferencing in pinctrl_dt_to_map
      regulator: core: fix kobject release warning and memory leak in regulator_register()
      cifs: fix use-after-free caused by invalid pointer `hostname`
      gpiolib: fix memory leak in gpiochip_setup_dev()
      net: mdio: fix unbalanced fwnode reference count in mdio_device_release()

Zhang Changzhong (8):
      net/qla3xxx: fix potential memleak in ql3xxx_send()
      sfc: fix potential memleak in __ef100_hard_start_xmit()
      can: sja1000_isa: sja1000_isa_probe(): add missing free_sja1000dev()
      can: cc770: cc770_isa_probe(): add missing free_cc770dev()
      can: etas_es58x: es58x_init_netdev(): free netdev when register_candev()
      can: m_can: pci: add missing m_can_class_free_dev() in probe/remove methods
      net: ethernet: ti: am65-cpsw: fix error handling in am65_cpsw_nuss_probe()
      ethernet: aeroflex: fix potential skb leak in greth_init_rings()

Zhang Qilong (4):
      ASoC: wm5102: Revert "ASoC: wm5102: Fix PM disable depth imbalance in wm5102_probe"
      ASoC: wm5110: Revert "ASoC: wm5110: Fix PM disable depth imbalance in wm5110_probe"
      ASoC: wm8997: Revert "ASoC: wm8997: Fix PM disable depth imbalance in wm8997_probe"
      ASoC: mt6660: Keep the pm_runtime enables before component stuff in mt6660_i2c_probe

Zhang Xiaoxu (3):
      cifs: Fix wrong return value checking when GETFLAGS
      cifs: Fix connections leak when tlink setup failed
      Input: raydium_ts_i2c - fix memory leak in raydium_i2c_send()

ZhangPeng (2):
      nilfs2: fix NULL pointer dereference in nilfs_palloc_commit_free_entry()
      HID: core: fix shift-out-of-bounds in hid_report_raw_event

Zhen Lei (1):
      btrfs: sysfs: normalize the error handling branch in btrfs_init_sysfs()

Zheng Bin (1):
      slimbus: qcom-ngd: Fix build error when CONFIG_SLIM_QCOM_NGD_CTRL=y && CONFIG_QCOM_RPROC_COMMON=m

Zheng Yongjun (1):
      ARM: mxs: fix memory leak in mxs_machine_init()

Zhengchao Shao (7):
      net: liquidio: release resources when liquidio driver open failed
      net: caif: fix double disconnect client in chnl_net_open()
      9p/fd: fix issue of list_del corruption in p9_fd_cancel()
      sctp: fix memory leak in sctp_stream_outq_migrate()
      selftests: rtnetlink: correct xfrm policy rule in kci_test_ipsec_offload
      net: dsa: sja1105: fix memory leak in sja1105_setup_devlink_regions()
      net: thunderbolt: fix memory leak in tbnet_open()

Zhichao Liu (1):
      spi: mediatek: Fix DEVAPC Violation at KO Remove

Zhou Guanghui (1):
      scsi: iscsi: Fix possible memory leak when device_register() failed

Ziyang Xuan (3):
      ipv4: Fix error return code in fib_table_insert()
      ieee802154: cc2520: Fix error return code in cc2520_hw_init()
      octeontx2-pf: Fix potential memory leak in otx2_init_tc()

ruanjinjie (1):
      xen/platform-pci: add missing free_irq() in error path

taozhang (1):
      wifi: mac80211: fix memory free error when registering wiphy fail
---
.../process/code-of-conduct-interpretation.rst     |    2 +-
 MAINTAINERS                                        |    7 +-
 Makefile                                           |    6 +-
 arch/arm/boot/dts/am335x-pcm-953.dtsi              |   28 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |    2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |    9 +
 arch/arm/boot/dts/imx6q-prti6q.dts                 |    4 +-
 arch/arm/boot/dts/rk3036-evb.dts                   |    3 +-
 arch/arm/boot/dts/rk3188-radxarock.dts             |    2 +-
 arch/arm/boot/dts/rk3188.dtsi                      |    3 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts           |    2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |    3 +-
 arch/arm/boot/dts/rk3288-miqi.dts                  |    3 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts          |    3 +-
 arch/arm/boot/dts/rk3288-vmarc-som.dtsi            |    1 -
 arch/arm/boot/dts/rk3xxx.dtsi                      |    7 +
 arch/arm/boot/dts/sama7g5-pinfunc.h                |    2 +-
 arch/arm/include/asm/perf_event.h                  |    2 +-
 arch/arm/include/asm/pgtable-nommu.h               |    6 -
 arch/arm/include/asm/pgtable.h                     |   16 +-
 arch/arm/mach-at91/pm_suspend.S                    |    7 +-
 arch/arm/mach-mxs/mach-mxs.c                       |    4 +-
 arch/arm/mm/nommu.c                                |   19 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |    4 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts           |   13 +-
 .../boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi   |    6 +
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |    6 +
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            |   12 +
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts     |    2 +-
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |    1 -
 arch/arm64/include/asm/cputype.h                   |    2 +-
 arch/arm64/include/asm/syscall_wrapper.h           |    2 +-
 arch/arm64/kernel/mte.c                            |    9 +-
 arch/arm64/kvm/arm.c                               |   11 +
 arch/arm64/mm/mteswap.c                            |    7 +-
 arch/mips/include/asm/fw/fw.h                      |    2 +-
 arch/mips/kernel/relocate_kernel.S                 |   15 +-
 arch/mips/loongson64/reset.c                       |   10 +
 arch/mips/pic32/pic32mzda/early_console.c          |   13 +-
 arch/mips/pic32/pic32mzda/init.c                   |    2 +-
 arch/nios2/boot/Makefile                           |    2 +-
 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts |   38 +
 arch/riscv/include/asm/asm.h                       |    1 +
 arch/riscv/include/asm/efi.h                       |    6 +-
 arch/riscv/include/asm/pgalloc.h                   |   11 +-
 arch/riscv/kernel/entry.S                          |   13 +
 arch/riscv/kernel/machine_kexec.c                  |   35 +
 arch/riscv/kernel/setup.c                          |    9 +-
 arch/riscv/kernel/traps.c                          |   18 +
 arch/riscv/kernel/vdso/Makefile                    |    4 +
 arch/riscv/kernel/vdso/vdso.lds.S                  |    2 +
 arch/s390/kernel/crash_dump.c                      |    2 +-
 arch/s390/kvm/vsie.c                               |    4 +-
 arch/x86/entry/vdso/vdso.lds.S                     |    2 +
 arch/x86/events/intel/pt.c                         |    9 +
 arch/x86/hyperv/hv_init.c                          |   54 +-
 arch/x86/include/asm/cpufeatures.h                 |    3 +
 arch/x86/include/asm/intel-family.h                |   11 +-
 arch/x86/include/asm/nospec-branch.h               |    2 +-
 arch/x86/kernel/cpu/bugs.c                         |   21 +-
 arch/x86/kernel/cpu/sgx/ioctl.c                    |   31 +-
 arch/x86/kernel/cpu/tsx.c                          |   38 +-
 arch/x86/kernel/process.c                          |    2 +-
 arch/x86/kvm/mmu/mmu.c                             |   12 +-
 arch/x86/kvm/svm/nested.c                          |    6 +-
 arch/x86/kvm/svm/svm.c                             |   16 +-
 arch/x86/kvm/vmx/nested.c                          |    3 -
 arch/x86/kvm/x86.c                                 |   32 +-
 arch/x86/mm/ioremap.c                              |    8 +-
 arch/x86/power/cpu.c                               |   23 +-
 block/Makefile                                     |    2 +-
 block/bfq-cgroup.c                                 |    4 +
 block/sed-opal.c                                   |   32 +-
 drivers/accessibility/speakup/main.c               |    2 +-
 drivers/acpi/numa/hmat.c                           |   27 +-
 drivers/acpi/scan.c                                |    1 +
 drivers/acpi/x86/utils.c                           |    6 +
 drivers/android/binder_alloc.c                     |    7 +
 drivers/ata/libata-scsi.c                          |   55 +-
 drivers/ata/libata-transport.c                     |   19 +-
 drivers/block/drbd/drbd_main.c                     |    4 +-
 drivers/bluetooth/btusb.c                          |    5 +
 drivers/bus/intel-ixp4xx-eb.c                      |    9 +-
 drivers/bus/sunxi-rsb.c                            |   38 +-
 drivers/char/tpm/tpm-interface.c                   |    5 +-
 drivers/clk/at91/at91rm9200.c                      |    2 +-
 drivers/clk/clk-devres.c                           |   91 +-
 drivers/clocksource/timer-riscv.c                  |    2 +-
 drivers/dma-buf/dma-heap.c                         |   28 +-
 drivers/firmware/arm_scmi/bus.c                    |   11 +
 drivers/firmware/arm_scmi/common.h                 |    1 +
 drivers/firmware/arm_scmi/driver.c                 |   31 +-
 drivers/firmware/google/coreboot_table.c           |   37 +-
 drivers/gpio/gpio-amd8111.c                        |    4 +
 drivers/gpio/gpio-rockchip.c                       |    1 +
 drivers/gpio/gpiolib.c                             |   59 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c   |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |    3 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   24 +-
 drivers/gpu/drm/amd/display/Kconfig                |    7 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   40 +-
 .../drm/amd/display/dc/dce120/dce120_resource.c    |    3 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |    2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c  |    1 +
 .../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c    |   25 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |    4 +
 drivers/gpu/drm/bridge/analogix/anx7625.c          |    4 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |    6 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |    4 +-
 drivers/gpu/drm/drm_dp_dual_mode_helper.c          |   51 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |    2 +-
 drivers/gpu/drm/drm_drv.c                          |    2 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |   18 +-
 drivers/gpu/drm/drm_internal.h                     |    3 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |    6 +
 drivers/gpu/drm/i915/gem/i915_gem_internal.c       |   44 +-
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c               |  137 +-
 drivers/gpu/drm/i915/gt/gen6_ppgtt.h               |    1 -
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |   56 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |   13 +-
 drivers/gpu/drm/i915/gt/intel_gt_requests.c        |    2 +-
 drivers/gpu/drm/i915/gt/intel_gtt.c                |    3 +
 drivers/gpu/drm/i915/i915_drv.h                    |    4 +
 drivers/gpu/drm/imx/imx-tve.c                      |    5 +-
 drivers/gpu/drm/panel/panel-simple.c               |    2 +
 drivers/gpu/drm/tegra/drm.c                        |    4 +
 drivers/gpu/drm/vc4/vc4_kms.c                      |    8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |    6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |    4 +
 drivers/gpu/host1x/dev.c                           |    4 +
 drivers/hid/hid-core.c                             |    3 +
 drivers/hid/hid-ids.h                              |    4 +
 drivers/hid/hid-ite.c                              |    5 +
 drivers/hid/hid-lg4ff.c                            |    6 +
 drivers/hid/hid-quirks.c                           |    3 +
 drivers/hid/hid-uclogic-core.c                     |    1 +
 drivers/hv/channel_mgmt.c                          |    6 +-
 drivers/hv/vmbus_drv.c                             |    1 +
 drivers/hwmon/coretemp.c                           |    9 +-
 drivers/hwmon/i5500_temp.c                         |    2 +-
 drivers/hwmon/ibmpex.c                             |    1 +
 drivers/hwmon/ina3221.c                            |    4 +-
 drivers/hwmon/ltc2947-core.c                       |    2 +-
 drivers/i2c/busses/i2c-i801.c                      |    1 +
 drivers/i2c/busses/i2c-imx.c                       |    6 +-
 drivers/i2c/busses/i2c-npcm7xx.c                   |   11 +-
 drivers/i2c/busses/i2c-tegra.c                     |   16 +-
 drivers/iio/adc/at91_adc.c                         |    4 +-
 drivers/iio/adc/mp2629_adc.c                       |    5 +-
 drivers/iio/health/afe4403.c                       |    5 +-
 drivers/iio/health/afe4404.c                       |   12 +-
 drivers/iio/industrialio-sw-trigger.c              |    6 +-
 drivers/iio/light/Kconfig                          |    2 +
 drivers/iio/light/apds9960.c                       |   12 +-
 drivers/iio/pressure/ms5611.h                      |   18 +-
 drivers/iio/pressure/ms5611_core.c                 |   56 +-
 drivers/iio/pressure/ms5611_i2c.c                  |   11 +-
 drivers/iio/pressure/ms5611_spi.c                  |   19 +-
 drivers/iio/trigger/iio-trig-sysfs.c               |    6 +-
 drivers/infiniband/hw/efa/efa_main.c               |    4 +-
 drivers/input/joystick/iforce/iforce-main.c        |    8 +-
 drivers/input/misc/soc_button_array.c              |   14 +-
 drivers/input/mouse/synaptics.c                    |    1 +
 drivers/input/serio/i8042-x86ia64io.h              |    8 +-
 drivers/input/serio/i8042.c                        |    4 -
 drivers/input/touchscreen/goodix.c                 |   11 +
 drivers/input/touchscreen/raydium_i2c_ts.c         |    4 +-
 drivers/iommu/intel/dmar.c                         |    1 +
 drivers/iommu/intel/iommu.c                        |   12 +-
 drivers/iommu/intel/pasid.c                        |    5 +-
 drivers/irqchip/irq-gic-v3-its.c                   |    2 +-
 drivers/isdn/mISDN/core.c                          |    2 +-
 drivers/isdn/mISDN/dsp_pipeline.c                  |    3 +-
 drivers/md/dm-integrity.c                          |   20 +-
 drivers/md/dm-ioctl.c                              |    4 +-
 drivers/media/common/videobuf2/frame_vector.c      |   53 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |  102 +-
 drivers/media/v4l2-core/v4l2-dv-timings.c          |   20 +-
 drivers/mfd/lpc_ich.c                              |   59 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |    2 +
 drivers/mmc/core/core.c                            |   17 +-
 drivers/mmc/core/mmc_test.c                        |    3 +-
 drivers/mmc/host/mtk-sd.c                          |    6 +-
 drivers/mmc/host/sdhci-brcmstb.c                   |   68 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |    2 +-
 drivers/mmc/host/sdhci-pci-core.c                  |    2 +
 drivers/mmc/host/sdhci-pci-o2micro.c               |    7 +
 drivers/mmc/host/sdhci-sprd.c                      |    4 +-
 drivers/mmc/host/sdhci.c                           |   61 +-
 drivers/mmc/host/sdhci.h                           |    2 +
 drivers/mtd/spi-nor/controllers/intel-spi-pci.c    |   29 +-
 drivers/mtd/spi-nor/controllers/intel-spi.c        |   51 +-
 drivers/net/arcnet/com20020_cs.c                   |   11 +-
 drivers/net/can/cc770/cc770_isa.c                  |   10 +-
 drivers/net/can/m_can/m_can.c                      |    2 +-
 drivers/net/can/m_can/m_can_pci.c                  |    9 +-
 drivers/net/can/sja1000/sja1000_isa.c              |   10 +-
 drivers/net/can/usb/esd_usb2.c                     |    6 +
 drivers/net/can/usb/etas_es58x/es58x_core.c        |    5 +-
 drivers/net/can/usb/mcba_usb.c                     |   10 +-
 drivers/net/dsa/lan9303-core.c                     |    2 +-
 drivers/net/dsa/sja1105/sja1105_devlink.c          |    2 +
 drivers/net/dsa/sja1105/sja1105_main.c             |    2 +-
 drivers/net/dsa/sja1105/sja1105_mdio.c             |    6 +
 drivers/net/ethernet/aeroflex/greth.c              |    1 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |    8 +-
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |    5 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c   |    4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.h   |    2 +
 drivers/net/ethernet/atheros/ag71xx.c              |    3 +-
 drivers/net/ethernet/broadcom/Kconfig              |    3 +-
 drivers/net/ethernet/broadcom/bgmac.c              |    1 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |   12 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   10 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |   34 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |    4 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |    4 +-
 .../ethernet/freescale/dpaa2/dpaa2-switch-flower.c |    4 +
 drivers/net/ethernet/freescale/enetc/enetc.c       |   32 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |   10 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |    6 +-
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |   83 +-
 drivers/net/ethernet/freescale/fec_main.c          |   23 +-
 drivers/net/ethernet/hisilicon/hisi_femac.c        |    2 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      |    2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   10 +-
 drivers/net/ethernet/huawei/hinic/hinic_main.c     |    9 +-
 drivers/net/ethernet/intel/e100.c                  |    5 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    4 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c      |   10 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   12 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   30 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    2 +
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   41 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |    2 +
 drivers/net/ethernet/intel/igb/igb_main.c          |    2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   10 +-
 drivers/net/ethernet/marvell/mvneta.c              |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |    8 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |    3 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |    2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_sdp.c    |    7 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |    7 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |    4 +-
 drivers/net/ethernet/mellanox/mlx4/qp.c            |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   10 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |    2 +-
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c  |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    9 +-
 .../mellanox/mlx5/core/steering/dr_matcher.c       |   26 +-
 .../mellanox/mlx5/core/steering/dr_table.c         |    7 +-
 .../mellanox/mlx5/core/steering/dr_types.h         |    2 +-
 drivers/net/ethernet/microchip/encx24j600-regmap.c |    4 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |    3 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |    6 +
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |   14 +-
 drivers/net/ethernet/microsoft/mana/gdma.h         |    9 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   16 +-
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c   |    2 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |    9 +-
 .../ethernet/netronome/nfp/nfpcore/nfp_cppcore.c   |    3 +-
 drivers/net/ethernet/ni/nixge.c                    |   29 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |    6 +-
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |    8 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |    1 +
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |    4 +-
 drivers/net/ethernet/renesas/ravb_main.c           |    1 +
 drivers/net/ethernet/sfc/ef100_netdev.c            |    1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   15 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    8 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |    2 +-
 drivers/net/ieee802154/ca8210.c                    |    2 +-
 drivers/net/ieee802154/cc2520.c                    |    2 +-
 drivers/net/loopback.c                             |    2 +-
 drivers/net/macsec.c                               |   29 +-
 drivers/net/macvlan.c                              |    6 +-
 drivers/net/mdio/fwnode_mdio.c                     |   27 +-
 drivers/net/mdio/of_mdio.c                         |    3 +-
 drivers/net/mhi_net.c                              |    2 +
 drivers/net/ntb_netdev.c                           |    9 +-
 drivers/net/phy/marvell.c                          |   16 +-
 drivers/net/phy/mdio_device.c                      |    2 +
 drivers/net/phy/mxl-gpy.c                          |   11 +-
 drivers/net/phy/phy_device.c                       |    2 +
 drivers/net/plip/plip.c                            |    4 +-
 drivers/net/thunderbolt.c                          |   20 +-
 drivers/net/tun.c                                  |    4 +-
 drivers/net/usb/qmi_wwan.c                         |    2 +
 drivers/net/vmxnet3/vmxnet3_drv.c                  |   27 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |    2 +-
 drivers/net/wireless/cisco/airo.c                  |   18 +-
 drivers/net/wireless/mac80211_hwsim.c              |    5 +
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   40 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   21 +-
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c         |    3 +-
 drivers/net/wwan/iosm/iosm_ipc_pcie.c              |    2 +-
 drivers/net/wwan/iosm/iosm_ipc_protocol.h          |    2 +-
 drivers/net/xen-netback/common.h                   |   14 +-
 drivers/net/xen-netback/interface.c                |   22 +-
 drivers/net/xen-netback/netback.c                  |  229 ++--
 drivers/net/xen-netback/rx.c                       |   10 +-
 drivers/net/xen-netfront.c                         |    6 +
 drivers/nfc/st-nci/se.c                            |   49 +-
 drivers/nvme/host/core.c                           |   10 +-
 drivers/nvme/host/ioctl.c                          |    6 +
 drivers/nvme/host/multipath.c                      |    3 +
 drivers/nvme/host/nvme.h                           |   16 +-
 drivers/nvme/host/pci.c                            |   20 +
 drivers/nvme/target/configfs.c                     |    7 +-
 drivers/nvmem/rmem.c                               |    4 +-
 drivers/of/property.c                              |    4 +-
 drivers/parport/parport_pc.c                       |    2 +-
 drivers/pinctrl/devicetree.c                       |    2 +
 drivers/pinctrl/intel/pinctrl-intel.c              |   27 +-
 drivers/pinctrl/mediatek/mtk-eint.c                |    9 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |   40 +
 drivers/pinctrl/pinctrl-single.c                   |    2 +-
 .../platform/surface/aggregator/ssh_packet_layer.c |   24 +-
 drivers/platform/x86/acer-wmi.c                    |    9 +
 drivers/platform/x86/asus-wmi.c                    |    2 +
 drivers/platform/x86/hp-wmi.c                      |    3 +
 drivers/platform/x86/ideapad-laptop.c              |   42 +-
 drivers/platform/x86/intel/hid.c                   |    3 +
 drivers/platform/x86/intel/pmc/pltdrv.c            |    9 +
 drivers/platform/x86/intel/pmt/class.c             |   31 +-
 drivers/platform/x86/touchscreen_dmi.c             |   25 +
 drivers/regulator/core.c                           |    8 +-
 drivers/regulator/slg51000-regulator.c             |    2 +
 drivers/regulator/twl6030-regulator.c              |   17 +-
 drivers/rtc/rtc-cmos.c                             |  179 ++-
 drivers/rtc/rtc-mc146818-lib.c                     |   70 +
 drivers/s390/block/dasd_eckd.c                     |    6 +-
 drivers/s390/net/qeth_l2_main.c                    |   16 +-
 drivers/s390/scsi/zfcp_fsf.c                       |    2 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                     |   14 +-
 drivers/scsi/scsi_debug.c                          |   13 +-
 drivers/scsi/scsi_transport_iscsi.c                |   31 +-
 drivers/scsi/scsi_transport_sas.c                  |   13 +-
 drivers/scsi/storvsc_drv.c                         |   69 +-
 drivers/siox/siox-core.c                           |    2 +
 drivers/slimbus/Kconfig                            |    2 +-
 drivers/slimbus/stream.c                           |    8 +-
 drivers/soc/imx/soc-imx8m.c                        |   11 +
 drivers/soundwire/intel.c                          |    1 +
 drivers/spi/spi-dw-dma.c                           |    3 +
 drivers/spi/spi-imx.c                              |    3 +-
 drivers/spi/spi-mt65xx.c                           |    8 +-
 drivers/spi/spi-stm32.c                            |    3 +-
 drivers/target/loopback/tcm_loop.c                 |    3 +-
 drivers/tee/optee/device.c                         |    2 +-
 drivers/tty/n_gsm.c                                |    2 +-
 drivers/tty/serial/8250/8250_core.c                |    1 +
 drivers/tty/serial/8250/8250_lpss.c                |   18 +-
 drivers/tty/serial/8250/8250_omap.c                |   52 +-
 drivers/tty/serial/8250/8250_port.c                |    7 +-
 drivers/tty/serial/fsl_lpuart.c                    |   82 +-
 drivers/tty/serial/imx.c                           |    1 +
 drivers/tty/serial/stm32-usart.c                   |  131 +-
 drivers/tty/serial/stm32-usart.h                   |    1 +
 drivers/usb/cdns3/cdnsp-gadget.c                   |   12 +-
 drivers/usb/cdns3/cdnsp-ring.c                     |   17 +-
 drivers/usb/cdns3/host.c                           |   56 +-
 drivers/usb/chipidea/otg_fsm.c                     |    2 +
 drivers/usb/core/quirks.c                          |    3 +
 drivers/usb/dwc3/dwc3-exynos.c                     |   11 +-
 drivers/usb/dwc3/dwc3-pci.c                        |    2 +-
 drivers/usb/dwc3/gadget.c                          |   25 +-
 drivers/usb/dwc3/host.c                            |   10 -
 drivers/usb/gadget/function/f_uvc.c                |    5 +-
 drivers/usb/host/bcma-hcd.c                        |   10 +-
 drivers/usb/host/xhci-pci.c                        |    4 +-
 drivers/usb/serial/cp210x.c                        |    2 +
 drivers/usb/serial/f81232.c                        |   12 +-
 drivers/usb/serial/f81534.c                        |   12 +-
 drivers/usb/serial/option.c                        |   22 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |   15 +-
 drivers/video/fbdev/core/fbcon.c                   |    2 +-
 drivers/xen/pcpu.c                                 |    2 +-
 drivers/xen/platform-pci.c                         |    7 +-
 drivers/xen/xen-pciback/conf_space_capability.c    |    9 +-
 fs/Makefile                                        |    2 -
 fs/afs/fs_probe.c                                  |    4 +-
 fs/btrfs/backref.c                                 |   25 +-
 fs/btrfs/backref.h                                 |    3 +-
 fs/btrfs/ioctl.c                                   |   45 +-
 fs/btrfs/qgroup.c                                  |   22 +-
 fs/btrfs/raid56.c                                  |    6 +-
 fs/btrfs/send.c                                    |   24 +-
 fs/btrfs/sysfs.c                                   |    7 +-
 fs/btrfs/tests/qgroup-tests.c                      |   16 +-
 fs/btrfs/zoned.c                                   |    9 +-
 fs/buffer.c                                        |    4 +-
 fs/ceph/caps.c                                     |   50 +-
 fs/ceph/snap.c                                     |   31 +-
 fs/cifs/cifs_dfs_ref.c                             |   59 +-
 fs/cifs/cifs_fs_sb.h                               |    5 -
 fs/cifs/cifsglob.h                                 |   24 +-
 fs/cifs/cifsproto.h                                |    5 +-
 fs/cifs/connect.c                                  | 1360 ++++++++++----------
 fs/cifs/dfs_cache.c                                |   44 +-
 fs/cifs/ioctl.c                                    |    4 +-
 fs/cifs/misc.c                                     |   62 +-
 fs/cifs/smb2ops.c                                  |   14 +-
 fs/cifs/smb2pdu.c                                  |    6 +-
 fs/erofs/inode.c                                   |    2 +-
 fs/ext4/extents.c                                  |   18 +-
 fs/file.c                                          |   11 +-
 fs/fs-writeback.c                                  |   30 +-
 fs/fuse/file.c                                     |   37 +-
 fs/gfs2/ops_fstype.c                               |   17 +-
 fs/hugetlbfs/inode.c                               |   13 +-
 fs/ksmbd/vfs.c                                     |    6 +-
 fs/namei.c                                         |    2 +-
 fs/nfs/nfs4proc.c                                  |    6 +-
 fs/nfsd/vfs.c                                      |    4 +-
 fs/nilfs2/dat.c                                    |    7 +
 fs/nilfs2/sufile.c                                 |    8 +
 fs/ntfs/attrib.c                                   |   28 +-
 fs/ntfs/inode.c                                    |    7 +
 fs/read_write.c                                    |   17 +-
 fs/udf/inode.c                                     |   76 +-
 fs/udf/truncate.c                                  |   48 +-
 fs/zonefs/super.c                                  |   37 +-
 include/asm-generic/tlb.h                          |    4 +
 include/linux/can/platform/sja1000.h               |    2 +-
 include/linux/cgroup.h                             |    1 +
 include/linux/clk.h                                |  109 ++
 include/linux/fs.h                                 |    8 +
 include/linux/mc146818rtc.h                        |    3 +
 include/linux/mmc/mmc.h                            |    2 +-
 include/linux/platform_data/x86/intel-spi.h        |    6 +-
 include/linux/ring_buffer.h                        |    2 +-
 include/linux/serial_core.h                        |    1 +
 include/linux/swap.h                               |    1 -
 include/linux/trace.h                              |    4 +-
 include/linux/wireless.h                           |   10 +-
 include/net/ip.h                                   |    2 +-
 include/net/ipv6.h                                 |    2 +-
 include/net/sctp/stream_sched.h                    |    2 +
 include/soc/at91/sama7-ddr.h                       |    5 +-
 include/trace/events/rxrpc.h                       |    2 +-
 include/uapi/linux/audit.h                         |    2 +-
 include/uapi/linux/ip.h                            |    6 +-
 include/uapi/linux/ipv6.h                          |    6 +-
 init/Kconfig                                       |    2 +-
 io_uring/Makefile                                  |    6 +
 {fs => io_uring}/io-wq.c                           |    0
 {fs => io_uring}/io-wq.h                           |    0
 {fs => io_uring}/io_uring.c                        |   63 +-
 ipc/sem.c                                          |    3 +-
 kernel/bpf/bpf_local_storage.c                     |    2 +-
 kernel/bpf/percpu_freelist.c                       |   23 +-
 kernel/bpf/verifier.c                              |   14 +-
 kernel/cgroup/cgroup-internal.h                    |    1 -
 kernel/events/core.c                               |   44 +-
 kernel/gcov/clang.c                                |    2 +
 kernel/irq/manage.c                                |   31 +-
 kernel/irq/msi.c                                   |    7 +
 kernel/kprobes.c                                   |    8 +-
 kernel/sched/core.c                                |    2 +-
 kernel/sysctl.c                                    |   30 +-
 kernel/trace/ftrace.c                              |    5 +-
 kernel/trace/kprobe_event_gen_test.c               |   48 +-
 kernel/trace/ring_buffer.c                         |   71 +-
 kernel/trace/synth_event_gen_test.c                |   16 +-
 kernel/trace/trace.c                               |    3 +-
 kernel/trace/trace_dynevent.c                      |    2 +
 kernel/trace/trace_eprobe.c                        |    3 +
 kernel/trace/trace_events.c                        |   11 +-
 kernel/trace/trace_events_hist.c                   |    3 +
 kernel/trace/trace_events_synth.c                  |    5 +-
 kernel/trace/trace_osnoise.c                       |    6 +-
 lib/Kconfig.debug                                  |   14 +-
 lib/vdso/Makefile                                  |    2 +-
 localversion-rt                                    |    2 +-
 mm/compaction.c                                    |   67 +-
 mm/filemap.c                                       |    2 +-
 mm/gup.c                                           |    2 +-
 mm/hugetlb.c                                       |    4 +
 mm/khugepaged.c                                    |   47 +-
 mm/maccess.c                                       |    2 +-
 mm/memcontrol.c                                    |   15 +-
 mm/memory-failure.c                                |  111 +-
 mm/mmu_gather.c                                    |    4 +-
 mm/shmem.c                                         |   51 +-
 mm/userfaultfd.c                                   |    5 +
 mm/vmscan.c                                        |  111 +-
 net/9p/trans_fd.c                                  |   57 +-
 net/9p/trans_xen.c                                 |    9 +
 net/bluetooth/6lowpan.c                            |    1 +
 net/bluetooth/af_bluetooth.c                       |    4 +-
 net/bluetooth/hci_core.c                           |    3 +-
 net/bluetooth/l2cap_core.c                         |    5 +-
 net/bpf/test_run.c                                 |    1 +
 net/bridge/br_vlan.c                               |   17 +-
 net/caif/chnl_net.c                                |    3 -
 net/can/af_can.c                                   |    4 +-
 net/core/flow_dissector.c                          |    2 +-
 net/dccp/ipv4.c                                    |    2 +
 net/dccp/ipv6.c                                    |    2 +
 net/dsa/dsa_priv.h                                 |    1 +
 net/dsa/master.c                                   |    3 +-
 net/dsa/port.c                                     |   16 +
 net/dsa/tag_hellcreek.c                            |    3 +-
 net/dsa/tag_ksz.c                                  |    3 +-
 net/dsa/tag_sja1105.c                              |    3 +-
 net/hsr/hsr_forward.c                              |    5 +-
 net/ipv4/Kconfig                                   |   10 +
 net/ipv4/esp4_offload.c                            |    3 +
 net/ipv4/fib_frontend.c                            |    3 +
 net/ipv4/fib_semantics.c                           |   11 +-
 net/ipv4/fib_trie.c                                |    4 +-
 net/ipv4/inet_hashtables.c                         |   10 +-
 net/ipv4/ip_gre.c                                  |   48 +-
 net/ipv4/ip_input.c                                |    5 +
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |    4 +-
 net/ipv4/tcp_cdg.c                                 |    2 +
 net/ipv4/tcp_ipv4.c                                |    2 +
 net/ipv6/esp6_offload.c                            |    3 +
 net/ipv6/ip6_output.c                              |    5 +
 net/ipv6/tcp_ipv6.c                                |    2 +
 net/ipv6/xfrm6_policy.c                            |    6 +-
 net/kcm/kcmsock.c                                  |   62 +-
 net/key/af_key.c                                   |   34 +-
 net/mac80211/airtime.c                             |    3 +
 net/mac80211/main.c                                |    8 +-
 net/mac80211/mesh_pathtbl.c                        |    2 +-
 net/mac802154/iface.c                              |    1 +
 net/netfilter/ipset/ip_set_hash_gen.h              |    2 +-
 net/netfilter/ipset/ip_set_hash_ip.c               |    8 +-
 net/netfilter/nf_conntrack_core.c                  |    2 +-
 net/netfilter/nf_conntrack_netlink.c               |   21 +-
 net/netfilter/nf_conntrack_standalone.c            |    2 +-
 net/netfilter/nf_flow_table_offload.c              |    4 +
 net/netfilter/nf_tables_api.c                      |    6 +-
 net/netfilter/nft_ct.c                             |    6 +-
 net/netfilter/nft_set_pipapo.c                     |    5 +-
 net/netfilter/xt_connmark.c                        |   18 +-
 net/nfc/nci/core.c                                 |    2 +-
 net/nfc/nci/data.c                                 |    4 +-
 net/nfc/nci/ntf.c                                  |    6 +
 net/openvswitch/conntrack.c                        |    8 +-
 net/packet/af_packet.c                             |    6 +-
 net/rxrpc/af_rxrpc.c                               |    2 +-
 net/rxrpc/ar-internal.h                            |   24 +-
 net/rxrpc/call_accept.c                            |    4 +-
 net/rxrpc/call_object.c                            |   44 +-
 net/rxrpc/conn_client.c                            |   66 +-
 net/rxrpc/conn_object.c                            |   49 +-
 net/rxrpc/conn_service.c                           |    8 +-
 net/rxrpc/input.c                                  |    4 +-
 net/rxrpc/local_object.c                           |   68 +-
 net/rxrpc/net_ns.c                                 |    5 +-
 net/rxrpc/peer_object.c                            |   40 +-
 net/rxrpc/proc.c                                   |   75 +-
 net/rxrpc/skbuff.c                                 |    1 -
 net/sched/Kconfig                                  |    2 +-
 net/sched/act_connmark.c                           |    4 +-
 net/sched/act_ct.c                                 |    8 +-
 net/sched/act_ctinfo.c                             |    6 +-
 net/sctp/outqueue.c                                |   13 +-
 net/sctp/stream.c                                  |   25 +-
 net/sctp/stream_sched.c                            |    5 +
 net/sctp/stream_sched_prio.c                       |   19 +
 net/sctp/stream_sched_rr.c                         |    5 +
 net/tipc/crypto.c                                  |    3 +
 net/tipc/discover.c                                |    5 +-
 net/tipc/link.c                                    |    4 +-
 net/tipc/node.c                                    |   12 +-
 net/tipc/topsrv.c                                  |   20 +-
 net/unix/diag.c                                    |   20 +-
 net/wireless/scan.c                                |   10 +-
 net/wireless/wext-core.c                           |   17 +-
 net/x25/x25_dev.c                                  |    2 +-
 net/xfrm/xfrm_device.c                             |   15 +-
 net/xfrm/xfrm_replay.c                             |    2 +-
 scripts/faddr2line                                 |    7 +-
 sound/core/seq/seq_memory.c                        |   11 +-
 sound/firewire/dice/dice-stream.c                  |   12 +-
 sound/pci/hda/patch_realtek.c                      |    2 +
 sound/soc/codecs/cs42l51.c                         |    2 +-
 sound/soc/codecs/hdac_hda.h                        |    4 +-
 sound/soc/codecs/jz4725b.c                         |   34 +-
 sound/soc/codecs/max98373-i2c.c                    |    4 +
 sound/soc/codecs/mt6660.c                          |    8 +-
 sound/soc/codecs/rt1019.c                          |   20 +-
 sound/soc/codecs/rt1019.h                          |    6 +
 sound/soc/codecs/rt1308-sdw.h                      |    2 +
 sound/soc/codecs/rt711-sdca-sdw.c                  |    2 +-
 sound/soc/codecs/sgtl5000.c                        |    1 +
 sound/soc/codecs/tas2764.c                         |   19 +-
 sound/soc/codecs/tas2770.c                         |   20 +-
 sound/soc/codecs/wm5102.c                          |    6 +-
 sound/soc/codecs/wm5110.c                          |    6 +-
 sound/soc/codecs/wm8962.c                          |   62 +-
 sound/soc/codecs/wm8997.c                          |    6 +-
 sound/soc/fsl/fsl_asrc.c                           |    2 +-
 sound/soc/fsl/fsl_esai.c                           |    2 +-
 sound/soc/fsl/fsl_micfil.c                         |   19 +
 sound/soc/fsl/fsl_sai.c                            |   55 +-
 sound/soc/intel/boards/bytcht_es8316.c             |    7 +
 sound/soc/intel/boards/sof_sdw.c                   |   11 +
 sound/soc/soc-core.c                               |   17 +-
 sound/soc/soc-ops.c                                |   11 +-
 sound/soc/soc-pcm.c                                |    7 +-
 sound/soc/soc-utils.c                              |    2 +-
 sound/soc/stm/stm32_adfsdm.c                       |   11 +
 sound/usb/endpoint.c                               |    3 +-
 sound/usb/midi.c                                   |    4 +-
 sound/usb/quirks.c                                 |    2 +
 sound/usb/usbaudio.h                               |    3 +
 tools/iio/iio_generic_buffer.c                     |    4 +-
 tools/lib/bpf/libbpf_probes.c                      |    2 +-
 tools/lib/bpf/ringbuf.c                            |   12 +-
 .../testing/selftests/bpf/verifier/ref_tracking.c  |   36 +
 tools/testing/selftests/futex/functional/Makefile  |    6 +-
 tools/testing/selftests/intel_pstate/Makefile      |    6 +-
 tools/testing/selftests/net/fcnal-test.sh          |   11 +-
 tools/testing/selftests/net/fib_nexthops.sh        |   30 +
 tools/testing/selftests/net/fib_tests.sh           |   37 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |   72 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   37 +-
 tools/testing/selftests/net/pmtu.sh                |   10 +-
 tools/testing/selftests/net/rtnetlink.sh           |    2 +-
 tools/testing/selftests/net/toeplitz.sh            |    2 +-
 tools/vm/slabinfo-gnuplot.sh                       |    4 +-
 631 files changed, 6481 insertions(+), 3592 deletions(-)
---
