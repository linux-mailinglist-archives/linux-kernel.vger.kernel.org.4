Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A967068DFCE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjBGSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjBGSUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:20:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE5E402ED;
        Tue,  7 Feb 2023 10:19:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B42B0B8198A;
        Tue,  7 Feb 2023 18:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9FAC433EF;
        Tue,  7 Feb 2023 18:18:44 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.92-rt57
Date:   Tue, 07 Feb 2023 18:17:23 -0000
Message-ID: <167579384349.320921.8525587205861388690@puck.lan>
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
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.92-rt57 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 81306b3f60062aa8e09151a5d317543af96a8adb

Or to build 5.15.92-rt57 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.92.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.92-rt57.patch.xz


Enjoy!
Clark

Changes from v5.15.86-rt56:
---

Aaron Thompson (1):
      mm: Always release pages to the buddy allocator in memblock_free_late().

Abel Vesa (1):
      misc: fastrpc: Don't remove map on creater_process and device_release

Adam Ford (1):
      arm64: dts: imx8mm-beacon: Fix ecspi2 pinmux

Adam Vodopjan (1):
      ata: ahci: Fix PCS quirk application for suspend

Adham Faris (1):
      net/mlx5e: Fix hw mtu initializing at XDP SQ allocation

Aditya Garg (2):
      hfsplus: fix bug causing custom uid and gid being unable to be assigned with mount
      efi: Add iMac Pro 2017 to uefi skip cert quirk

Adrian Chan (1):
      ALSA: hda/hdmi: Add a HP device 0x8715 to force connect list

Adrian Freund (1):
      ACPI: resource: do IRQ override on Lenovo 14ALC7

Adrian Hunter (1):
      perf auxtrace: Fix address filter duplicate symbol selection

Aidan MacDonald (1):
      ASoC: jz4740-i2s: Handle independent FIFO flush bits

Alan Stern (1):
      USB: gadgetfs: Fix race between mounting and unmounting

Alex Deucher (4):
      drm/amdgpu: handle polaris10/11 overlap asics (v2)
      drm/amdgpu: make display pinning more flexible (v2)
      drm/amdgpu: drop experimental flag on aldebaran
      Revert "drm/amdgpu: make display pinning more flexible (v2)"

Alexander Antonov (2):
      perf/x86/intel/uncore: Disable I/O stacks to PMU mapping on ICX-D
      perf/x86/intel/uncore: Clear attr_update properly

Alexander Aring (2):
      fs: dlm: fix sock release if listen fails
      fs: dlm: retry accept() until -EAGAIN or error returns

Alexander Egorenkov (1):
      s390/kexec: fix ipl report address for kdump

Alexander Gordeev (1):
      s390: expicitly align _edata and _end symbols on page boundary

Alexander Potapenko (2):
      fs: ext4: initialize fsdata in pagecache_write()
      affs: initialize fsdata in affs_truncate()

Alexander Stein (1):
      usb: host: ehci-fsl: Fix module alias

Alexander Sverdlin (1):
      mtd: spi-nor: Check for zero erase size in spi_nor_find_best_erase_type()

Alexander Usyskin (1):
      mei: me: add meteor lake point M DID

Alexander Wetzel (1):
      wifi: mac80211: sdata can be NULL during AMPDU start

Alexey V. Vissarionov (1):
      scsi: hpsa: Fix allocation size for scsi_host_alloc()

Ali Mirghasemi (1):
      USB: serial: option: add Quectel EC200U modem

Alon Zahavi (1):
      fs/ntfs3: Fix attr_punch_hole() null pointer derenference

Alviro Iskandar Setiawan (1):
      io_uring: Clean up a false-positive warning from GCC 9.3.0

Ammar Faizi (3):
      tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber list
      tools/nolibc: x86-64: Use `mov $60,%eax` instead of `mov $60,%rax`
      tools/nolibc: Remove .global _start from the entry point code

Andre Przywara (1):
      r8152: add vendor/device ID pair for Microsoft Devkit

Andrew Halaney (1):
      net: stmmac: enable all safety features by default

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP ProBook

Andy Shevchenko (1):
      pinctrl/rockchip: Use temporary variable for struct device

Angela Czubak (1):
      octeontx2-af: Fix LMAC config in cgx_lmac_rx_tx_enable

Angus Chen (1):
      virtio_pci: modify ENOENT to EINVAL

Archie Pusaka (1):
      Bluetooth: hci_sync: cancel cmd_timer if hci_open failed

Ard Biesheuvel (5):
      efi: random: combine bootloader provided RNG seed with RNG protocol output
      efi: tpm: Avoid READ_ONCE() for accessing the event log
      ACPI: PRM: Check whether EFI runtime is available
      arm64: efi: Execute runtime services from a dedicated stack
      efi: rt-wrapper: Add missing include

Arend van Spriel (1):
      wifi: brcmfmac: fix regression for Broadcom PCIe wifi devices

Arnd Bergmann (5):
      hfs/hfsplus: use WARN_ON for sanity check
      fbdev: omapfb: avoid stack overflow warning
      staging: vchiq_arm: fix enum vchiq_status return types
      drm/panfrost: fix GENERIC_ATOMIC64 dependency
      drm/i915/selftest: fix intel_selftest_modify_policy argument types

Artem Egorkine (2):
      ALSA: line6: correct midi status byte when receiving data from podxt
      ALSA: line6: fix stack overflow in line6_midi_transmit

Ashish Mhetre (1):
      memory: tegra: Remove clients SID override programming

Ashok Raj (1):
      x86/microcode/intel: Do not retry microcode reloading on the APs

Baokun Li (9):
      ext4: add inode table check in __ext4_get_inode_loc to aovid possible infinite loop
      ext4: fix use-after-free in ext4_orphan_cleanup
      ext4: add EXT4_IGET_BAD flag to prevent unexpected bad inode
      ext4: add helper to check quota inums
      ext4: fix bug_on in __es_tree_search caused by bad quota inode
      ext4: fix bug_on in __es_tree_search caused by bad boot loader inode
      ext4: fix corruption when online resizing a 1K bigalloc fs
      ext4: correct inconsistent error msg in nojournal mode
      ext4: fix bad checksum after online resize

Bart Van Assche (1):
      scsi: ufs: Stop using the clock scaling lock in the error handler

Bartosz Golaszewski (1):
      spi: spidev: remove debug messages that access spidev->spi without locking

Ben Dooks (2):
      riscv: uaccess: fix type of 0 variable on error in get_user()
      riscv: dts: sifive: fu740: fix size of pcie 32bit memory

Biju Das (2):
      ravb: Fix "failed to switch device to config mode" message during unbind
      ravb: Rename "no_ptp_cfg_active" and "ptp_cfg_active" variables

Bixuan Cui (1):
      jbd2: use the correct print format

Björn Töpel (1):
      riscv, kprobes: Stricter c.jr/c.jalr decoding

Boris Burkov (1):
      btrfs: fix resolving backrefs for inline extent followed by prealloc

Borislav Petkov (1):
      x86/mce: Get rid of msr_ops

Brian Norris (1):
      ASoC: qcom: lpass-cpu: Fix fallback SD line index handling

Bryan O'Donoghue (4):
      dt-bindings: msm: dsi-controller-main: Fix operating-points-v2 constraint
      dt-bindings: msm: dsi-controller-main: Fix power-domain constraint
      dt-bindings: msm: dsi-controller-main: Fix description of core clock
      dt-bindings: msm: dsi-phy-28nm: Add missing qcom, dsi-phy-regulator-ldo-mode

Caleb Connolly (1):
      net: ipa: disable ipa interrupt during suspend

Carlo Caione (1):
      drm/meson: Reduce the FIFO lines held when AFBC is not used

Chancel Liu (1):
      ASoC: fsl_micfil: Correct the number of steps on SX controls

Chen Zhongjin (1):
      driver core: Fix test_async_probe_init saves device in wrong array

ChiYuan Huang (2):
      mfd: mt6360: Add bounds checking in Regmap read/write call-backs
      usb: typec: tcpm: Fix altmode re-registration causes sysfs create fail

Chris Chiu (2):
      ALSA: hda/realtek: Apply dual codec fixup for Dell Latitude laptops
      ALSA: hda - Enable headset mic on another Dell laptop with ALC3254

Chris Mi (1):
      net/mlx5e: Always clear dest encap in neigh-update-del

Chris Morgan (2):
      i2c: mv64xxx: Remove shutdown method from driver
      i2c: mv64xxx: Add atomic_xfer method to driver

Chris Wilson (2):
      drm/i915/gt: Reset twice
      perf/x86/rapl: Treat Tigerlake like Icelake

Christian Brauner (1):
      pnode: terminate at peers of source

Christoph Hellwig (5):
      nvme: fix the NVME_CMD_EFFECTS_CSE_MASK definition
      nvmet: don't defer passthrough commands with trivial effects to the workqueue
      nvmet: use NVME_CMD_EFFECTS_CSUPP instead of open coding it
      nvme: also return I/O command effects from nvme_command_effects
      block: fix and cleanup bio_check_ro

Christophe JAILLET (2):
      iommu/mediatek-v1: Fix an error handling path in mtk_iommu_v1_probe()
      PM: AVS: qcom-cpr: Fix an error handling path in cpr_probe()

Christophe Leroy (1):
      objtool: Fix SEGFAULT

Christopher S Hall (1):
      igc: Fix PPS delta between two synchronized end-points

Chuck Lever (1):
      SUNRPC: Don't leak netobj memory when gss_read_proxy_verf() fails

Chun-Tse Shao (1):
      kbuild: Allow kernel installation packaging to override pkg-config

Chunhao Lin (1):
      r8169: move rtl_wol_enable_rx() and rtl_prepare_power_down()

Clark Williams (4):
      Merge tag 'v5.15.88' into v5.15-rt
      Merge tag 'v5.15.90' into v5.15-rt
      Merge tag 'v5.15.92' into v5.15-rt
      'Linux 5.15.92-rt57'

Claudiu Beznea (1):
      ARM: dts: at91: sam9x60: fix the ddr clock for sam9x60

Clement Lecigne (1):
      ALSA: pcm: Move rwsem lock inside snd_ctl_elem_read to prevent UAF

Colin Ian King (1):
      perf/x86/amd: fix potential integer overflow on shift of a int

Cong Wang (2):
      l2tp: convert l2tp_tunnel_list to idr
      l2tp: close all race conditions in l2tp_tunnel_register()

Corentin Labbe (1):
      crypto: n2 - add missing hash statesize

Cristian Marussi (3):
      firmware: arm_scmi: Harden shared memory access in fetch_response
      firmware: arm_scmi: Harden shared memory access in fetch_notification
      firmware: arm_scmi: Clear stale xfer->hdr.status

Damien Le Moal (4):
      block: mq-deadline: Do not break sequential write streams to zoned HDDs
      block: mq-deadline: Fix dd_finish_request() for zoned devices
      zonefs: Detect append writes at invalid locations
      block: mq-deadline: Rename deadline_is_seq_writes()

Dan Carpenter (5):
      fs/ntfs3: Delete duplicate condition in ntfs_read_mft()
      ipmi: fix use after free in _ipmi_destroy_user()
      drm/i915: unpin on error in intel_vgpu_shadow_mm_pin()
      thermal/core: fix error code in __thermal_cooling_device_register()
      gpio: mxc: Unlock on error path in mxc_flip_edge()

Daniel Lezcano (2):
      thermal/core: Remove duplicate information when an error occurs
      thermal/core: Rename 'trips' to 'num_trips'

Daniel Scally (1):
      usb: gadget: g_webcam: Send color matching descriptor per frame

Daniil Tatianin (3):
      qlcnic: prevent ->dcb use-after-free on qlcnic_dcb_enable() failure
      drivers/net/bonding/bond_3ad: return when there's no aggregator
      net/ethtool/ioctl: return -EOPNOTSUPP if we have no phy stats

Dario Binacchi (1):
      ARM: imx: add missing of_node_put()

Dave Hansen (1):
      ACPI: processor idle: Practically limit "Dummy wait" workaround to old Intel systems

David Arinzon (7):
      net: ena: Fix toeplitz initial hash value
      net: ena: Don't register memory info on XDP exchange
      net: ena: Account for the number of processed bytes in XDP
      net: ena: Use bitmask to indicate packet redirection
      net: ena: Fix rx_copybreak value update
      net: ena: Set default value for RX interrupt moderation
      net: ena: Update NUMA TPH hint register upon NUMA node update

David Christensen (1):
      net/tg3: resolve deadlock in tg3_reset_task() during EEH

David Howells (1):
      cifs: Fix oops due to uncleared server->smbd_conn in reconnect

David Morley (1):
      tcp: fix rate_app_limited to default to 1

Dean Luick (5):
      IB/hfi1: Reject a zero-length user expected buffer
      IB/hfi1: Reserve user expected TIDs
      IB/hfi1: Fix expected receive setup error exit issues
      IB/hfi1: Immediately remove invalid memory from hardware
      IB/hfi1: Remove user expected buffer invalidate race

Deepak Sharma (1):
      x86: ACPI: cstate: Optimize C3 entry on AMD CPUs

Denis Nikitin (1):
      KVM: arm64: nvhe: Fix build with profile optimization

Deren Wu (1):
      mmc: vub300: fix warning - do not call blocking ops when !TASK_RUNNING

Ding Hui (1):
      efi: fix userspace infinite retry read efivars after EFI runtime services page fault

Dmitry Torokhov (1):
      Revert "Input: synaptics - switch touchpad on HP Laptop 15-da3001TU to RMI mode"

Dongliang Mu (1):
      fs: reiserfs: remove useless new_opts in reiserfs_remount

Dragos Tatulea (1):
      net/mlx5e: IPoIB, Don't allow CQE compression to be turned on by default

Drew Davenport (1):
      drm/i915/display: Check source height is > 0

Duke Xin(辛安文) (5):
      USB: serial: option: add Quectel EM05-G (GR) modem
      USB: serial: option: add Quectel EM05-G (CS) modem
      USB: serial: option: add Quectel EM05-G (RS) modem
      USB: serial: option: add Quectel EM05CN (SG) modem
      USB: serial: option: add Quectel EM05CN modem

Dylan Yudaken (4):
      io_uring: fix async accept on O_NONBLOCK sockets
      io_uring: remove duplicated calls to io_kiocb_ppos
      io_uring: update kiocb->ki_pos at execution time
      io_uring: do not recalculate ppos unnecessarily

Edward Lo (7):
      fs/ntfs3: Validate data run offset
      fs/ntfs3: Add null pointer check to attr_load_runs_vcn
      fs/ntfs3: Add null pointer check for inode operations
      fs/ntfs3: Validate attribute name offset
      fs/ntfs3: Validate buffer length while parsing index
      fs/ntfs3: Validate resident attribute name
      fs/ntfs3: Validate index root when initialize NTFS security

Eliav Farber (1):
      EDAC/device: Fix period calculation in edac_device_reset_delay_period()

Emanuele Ghidoli (1):
      ASoC: wm8904: fix wrong outputs volume after power reactivation

Enzo Matsumiya (1):
      cifs: do not include page data when checking signature

Eric Biggers (12):
      ext4: fix leaking uninitialized memory in fast-commit journal
      ext4: remove unused enum EXT4_FC_COMMIT_FAILED
      ext4: use ext4_debug() instead of jbd_debug()
      ext4: introduce EXT4_FC_TAG_BASE_LEN helper
      ext4: factor out ext4_fc_get_tl()
      ext4: fix potential out of bound read in ext4_fc_replay_scan()
      ext4: disable fast-commit of encrypted dir operations
      ext4: don't set up encryption key during jbd2 transaction
      ext4: add missing validation of fast-commit record lengths
      ext4: fix unaligned memory access in ext4_fc_reserve_space()
      ext4: fix off-by-one errors in fast-commit block filling
      ext4: don't allow journal inode to have encrypt flag

Eric Dumazet (11):
      net/af_packet: make sure to pull mac header
      Revert "wifi: mac80211: fix memory leak in ieee80211_if_add()"
      net/sched: sch_taprio: fix possible use-after-free
      l2tp: prevent lockdep issue in l2tp_tunnel_register()
      netlink: prevent potential spectre v1 gadgets
      netlink: annotate data races around nlk->portid
      netlink: annotate data races around dst_portid and dst_group
      netlink: annotate data races around sk_state
      ipv4: prevent potential spectre v1 gadget in ip_metrics_convert()
      ipv4: prevent potential spectre v1 gadget in fib_metrics_match()
      net/sched: sch_taprio: do not schedule in taprio_reset()

Eric Pilmore (1):
      ptdma: pt_core_execute_cmd() should use spinlock

Eric W. Biederman (2):
      exit: Add and use make_task_dead.
      objtool: Add a missing comma to avoid string concatenation

Eric Whitney (1):
      ext4: fix delayed allocation bug in ext4_clu_mapped for bigalloc + inline

Erik Schumacher (1):
      ACPI: resource: do IRQ override on XMG Core 15

Esina Ekaterina (1):
      net: wan: Add checks for NULL for utdm in undo_uhdlc_init and unmap_si_regs

Fabio Estevam (4):
      arm64: dts: imx8mp-phycore-som: Remove invalid PMIC property
      ARM: dts: imx6ul-pico-dwarf: Use 'clock-frequency'
      ARM: dts: imx7d-pico: Use 'clock-frequency'
      ARM: dts: imx6qdl-gw560x: Remove incorrect 'uart-has-rtscts'

Ferry Toth (2):
      usb: ulpi: defer ulpi_register on ulpi_read_id timeout
      Revert "usb: ulpi: defer ulpi_register on ulpi_read_id timeout"

Filipe Manana (2):
      btrfs: do not abort transaction on failure to write log tree when syncing log
      btrfs: fix race between quota rescan and disable leading to NULL pointer deref

Flavio Suligoi (1):
      usb: core: hub: disable autosuspend for TI TUSB8041

Florian Westphal (1):
      mptcp: mark ops structures as ro_after_init

Florian-Ewald Mueller (1):
      md/bitmap: Fix bitmap chunk size overflow issues

Frederick Lawler (1):
      net: sched: disallow noqueue for qdisc classes

Gaosheng Cui (4):
      ext4: fix undefined behavior in bit shift for ext4_check_flag_values
      tty: fix possible null-ptr-defer in spk_ttyio_release
      memory: atmel-sdramc: Fix missing clk_disable_unprepare in atmel_ramc_probe()
      memory: mvebu-devbus: Fix missing clk_disable_unprepare in mvebu_devbus_probe()

Gavin Li (1):
      net/mlx5e: Don't support encap rules with gbp option

Gavrilov Ilia (1):
      netfilter: ipset: Fix overflow before widen in the bitmap_ip_create() function.

Geert Uytterhoeven (4):
      phy: phy-can-transceiver: Skip warning if no "max-bitrate"
      ARM: dts: imx: Fix pca9547 i2c-mux node name
      ARM: dts: vf610: Fix pca9548 i2c-mux node names
      arm64: dts: freescale: Fix pca954x i2c-mux node names

Geetha sowjanya (2):
      octeontx2-pf: Fix lmtst ID used in aura free
      octeontx2-pf: Avoid use of GFP_KERNEL in atomic context

Gergely Risko (1):
      ipv6: fix reachability confirmation with proxy_ndp

Giulio Benetti (1):
      ARM: 9280/1: mm: fix warning on phys_addr_t to void pointer assignment

Greg Kroah-Hartman (8):
      Linux 5.15.87
      Linux 5.15.88
      Linux 5.15.89
      prlimit: do_prlimit needs to have a speculation check
      USB: misc: iowarrior: fix up header size for USB_DEVICE_ID_CODEMERCS_IOW100
      Linux 5.15.90
      Linux 5.15.91
      Linux 5.15.92

Guchun Chen (1):
      drm/amdgpu: disable runtime pm on several sienna cichlid cards(v2)

Guo Ren (1):
      riscv: stacktrace: Fixup ftrace_graph_ret_addr retp argument

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting

Haiyang Zhang (1):
      net: mana: Fix IRQ name - add PCI and queue number

Hamza Mahfooz (1):
      drm/amd/display: fix issues with driver unload

Hangbin Liu (1):
      net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO

Hanjun Guo (3):
      tpm: acpi: Call acpi_put_table() to fix memory leak
      tpm: tpm_crb: Add the missed acpi_put_table() to fix memory leak
      tpm: tpm_tis: Add the missed acpi_put_table() to fix memory leak

Hans de Goede (6):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Advantech MICA-071 tablet
      platform/x86: dell-privacy: Only register SW_CAMERA_LENS_COVER if present
      platform/x86: dell-privacy: Fix SW_CAMERA_LENS_COVER reporting
      platform/x86: ideapad-laptop: Add Legion 5 15ARH05 DMI id to set_fn_lock_led_list[]
      platform/x86: sony-laptop: Don't turn off 0x153 keyboard backlight during probe
      platform/x86: asus-nb-wmi: Add alternate mapping for KEY_SCREENLOCK

Hao Chen (1):
      net: hns3: refactor hns3_nic_reuse_page()

Hao Sun (2):
      selftests/bpf: check null propagation only neither reg is PTR_TO_BTF_ID
      bpf: Skip task with pid=1 in send_signal_common()

Harsh Jain (1):
      drm/amdgpu: complete gfxoff allow signal during suspend without delay

Harshit Mogalapalli (2):
      io_uring: Fix unsigned 'res' comparison with zero in io_fixup_rw_res()
      vduse: Validate vq_num in vduse_validate_config()

Hawkins Jiawei (2):
      fs/ntfs3: Fix slab-out-of-bounds read in run_unpack
      net: sched: fix memory leak in tcindex_set_parms

Heiko Carstens (3):
      s390/cpum_sf: add READ_ONCE() semantics to compare and swap loops
      s390/percpu: add READ_ONCE() to arch_this_cpu_to_op_simple()
      KVM: s390: interrupt: use READ_ONCE() before cmpxchg()

Heiner Kallweit (4):
      dt-bindings: phy: g12a-usb2-phy: fix compatible string documentation
      dt-bindings: phy: g12a-usb3-pcie-phy: fix compatible string documentation
      net: mdio: validate parameter addr in mdiobus_get_phy()
      net: stmmac: fix invalid call to mdiobus_get_phy()

Helge Deller (1):
      parisc: Align parisc MADV_XXX constants with all other architectures

Hendrik Borghorst (1):
      KVM: x86/vmx: Do not skip segment attributes if unusable bit is set

Herbert Xu (1):
      ipv6: raw: Deduct extension header length in rawv6_push_pending_frames

Horatiu Vultur (1):
      net: sparx5: Fix reading of the MAC address

Huaxin Lu (1):
      ima: Fix a potential NULL pointer access in ima_restore_measurement_list

Hugh Dickins (1):
      mm/khugepaged: fix collapse_pte_mapped_thp() to allow anon_vma

Hui Tang (1):
      reset: uniphier-glue: Fix possible null-ptr-deref

Hui Wang (2):
      net: usb: cdc_ether: add support for Thales Cinterion PLS62-W modem
      dmaengine: imx-sdma: Fix a possible memory leak in sdma_transfer_init

Ian Abbott (2):
      rtc: ds1347: fix value written to century register
      comedi: adv_pci1760: Fix PWM instruction handling

Ian Rogers (1):
      perf build: Properly guard libbpf includes

Ido Schimmel (1):
      net/sched: act_mpls: Fix warning during failed attribute validation

Ilpo Järvinen (1):
      serial: pch_uart: Pass correct sg to dma_unmap_sg()

Isaac J. Manjarres (1):
      driver core: Fix bus_type.match() error handling in __driver_attach()

Ivo Borisov Shopov (1):
      tools: gpio: fix -c option of gpio-event-mon

Jaegeuk Kim (2):
      f2fs: allow to read node block after shutdown
      f2fs: let's avoid panic if extent_tree is not created

Jakub Kicinski (1):
      bpf: pull before calling skb_postpull_rcsum()

Jakub Sitnicki (2):
      l2tp: Serialize access to sk_user_data with sk_callback_lock
      l2tp: Don't sleep and disable BH under writer-side sk_callback_lock

Jamal Hadi Salim (2):
      net: sched: atm: dont intepret cls results when asked to drop
      net: sched: cbq: dont intepret cls results when asked to drop

James Houghton (1):
      hugetlb: unshare some PMDs when splitting VMAs

Jan Kara (7):
      ext4: avoid BUG_ON when creating xattrs
      ext4: initialize quota before expanding inode in setproject ioctl
      ext4: avoid unaccounted block allocation when expanding inode
      mbcache: automatically delete entries from cache on freeing
      ext4: fix deadlock due to mbcache entry corruption
      udf: Fix extension of the last extent in the file
      mbcache: Avoid nesting of cache->c_list_lock under bit locks

Jann Horn (1):
      exit: Put an upper limit on how often we can oops

Jaroslav Kysela (1):
      ALSA: control-led: use strscpy in set_led_id()

Jason A. Donenfeld (2):
      media: stv0288: use explicitly signed char
      ARM: ux500: do not directly dereference __iomem

Jason Wang (1):
      virtio-net: correctly enable callback during start_xmit

Jason Xing (1):
      tcp: avoid the lookup process failing to get sk in ehash table

Jason Yan (1):
      ext4: goto right label 'failed_mount3a'

Jayesh Choudhary (1):
      dmaengine: ti: k3-udma: Do conditional decrement of UDMA_CHAN_RT_PEER_BCNT_REG

Jeff Layton (3):
      nfsd: shut down the NFSv4 state objects before the filecache
      filelock: new helper: vfs_inode_has_locks
      nfsd: fix handling of readdir in v4root vs. mount upcall timeout

Jens Axboe (19):
      ARM: renumber bits related to _TIF_WORK_MASK
      io_uring: check for valid register opcode earlier
      block: don't allow splitting of a REQ_NOWAIT bio
      io_uring/io-wq: free worker if task_work creation is canceled
      io_uring/io-wq: only free worker if it was allocated for creation
      block: handle bio_split_to_limits() NULL return
      io_uring: don't gate task_work run on TIF_NOTIFY_SIGNAL
      eventpoll: add EPOLL_URING_WAKE poll wakeup flag
      eventfd: provide a eventfd_signal_mask() helper
      io_uring: pass in EPOLL_URING_WAKE for eventfd signaling and wakeups
      io_uring: ensure recv and recvmsg handle MSG_WAITALL correctly
      io_uring: add flag for disabling provided buffer recycling
      io_uring: support MSG_WAITALL for IORING_OP_SEND(MSG)
      io_uring: allow re-poll if we made progress
      io_uring: ensure that cached task references are always put on exit
      io_uring/rw: defer fsnotify calls to task context
      io_uring: io_kiocb_update_pos() should not touch file for non -1 offset
      io_uring/rw: ensure kiocb_end_write() is always called
      io_uring/rw: remove leftover debug statement

Jeremy Kerr (2):
      net: mctp: mark socks as dead on unhash, prevent re-add
      net: mctp: purge receive queues on sk destruction

Jeremy Szu (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for a HP platform

Jerome Brunet (1):
      net: mdio-mux-meson-g12a: force internal PHY off on mux switch

Jian Shen (2):
      net: hns3: fix miss L3E checking for rx packet
      net: hns3: fix VF promisc mode not update when mac table full

Jiasheng Jiang (1):
      HID: intel_ish-hid: Add check for ishtp_dma_tx_map

Jie Wang (2):
      net: hns3: add interrupts re-initialization while doing VF FLR
      net: hns3: fix return value check bug of rx copybreak

Jiguang Xiao (1):
      net: amd-xgbe: add missed tasklet_kill

Jimmy Hu (1):
      usb: xhci: Check endpoint is valid before dereferencing it

Jinrong Liang (1):
      selftests: kvm: Fix a compile error in selftests/kvm/rseq_test.c

Jiri Kosina (1):
      HID: revert CHERRY_MOUSE_000C quirk

Jiri Pirko (1):
      net/mlx5: Add forgotten cleanup calls into mlx5_init_once() error path

Jiri Slaby (SUSE) (2):
      ACPI: resource: do IRQ override on LENOVO IdeaPad
      RDMA/srp: Move large values to a new enum for gcc13

Jisoo Jang (1):
      net: nfc: Fix use-after-free in local_cleanup()

Jocelyn Falempe (1):
      drm/mgag200: Fix PLL setup for G200_SE_A rev >=4

Johan Hovold (3):
      phy: qcom-qmp-combo: fix sc8180x reset
      efi: fix NULL-deref in init error path
      scsi: ufs: core: Fix devfreq deadlocks

Johnny S. Lee (1):
      net: dsa: mv88e6xxx: depend on PTP conditionally

Jonas Karlman (2):
      pinctrl: rockchip: fix reading pull type on rk3568
      pinctrl: rockchip: fix mux route data for rk3568

Jonathan Corbet (1):
      docs: Fix the docs build with Sphinx 6.0

Joshua Ashton (2):
      drm/amd/display: Calculate output_color_space after pixel encoding adjustment
      drm/amd/display: Fix COLOR_SPACE_YCBCR2020_TYPE matrix

José Expósito (1):
      HID: multitouch: fix Asus ExpertBook P2 P2451FA trackpoint

Jozsef Kadlecsik (2):
      netfilter: ipset: fix hash:net,port,net hang with /0 subnet
      netfilter: ipset: Rework long task execution when adding/deleting entries

Juhyung Park (1):
      usb-storage: apply IGNORE_UAS only for HIKSEMI MD202 on RTL9210

Kajol Jain (1):
      powerpc/imc-pmu: Fix use of mutex in IRQs disabled section

Kan Liang (2):
      perf/x86/msr: Add Emerald Rapids
      perf/x86/intel/uncore: Add Emerald Rapids

Kant Fan (1):
      PM/devfreq: governor: Add a private governor_data for governor

Kees Cook (9):
      firmware: coreboot: Check size of table entry and use flex-array
      panic: Separate sysctl logic from CONFIG_SMP
      exit: Expose "oops_count" to sysfs
      exit: Allow oops_limit to be disabled
      panic: Consolidate open-coded panic_on_warn checks
      panic: Introduce warn_limit
      panic: Expose "warn_count" to sysfs
      docs: Fix path paste-o for /sys/kernel/warn_count
      exit: Use READ_ONCE() for all oops/warn limit reads

Keita Suzuki (1):
      media: dvb-core: Fix double free in dvb_register_device()

Keith Busch (4):
      nvme-pci: fix mempool alloc size
      nvme-pci: fix page size checks
      nvme-pci: fix timeout request state check
      nvme: fix passthrough csi check

Kevin Hao (3):
      octeontx2-pf: Fix the use of GFP_KERNEL in atomic context on rt
      cpufreq: Move to_gov_attr_set() to cpufreq.h
      cpufreq: governor: Use kobject release() method to free dbs_data

Khazhismel Kumykov (1):
      gsmi: fix null-deref in gsmi_get_variable

Kim Phillips (1):
      iommu/amd: Fix ivrs_acpihid cmdline parsing code

Klaus Jensen (1):
      nvme-pci: fix doorbell buffer value endianness

Koba Ko (1):
      dmaengine: Fix double increment of client_count in dma_chan_get()

Konrad Dybcio (7):
      drm/msm/adreno: Make adreno quirks not overwrite each other
      dt-bindings: msm/dsi: Don't require vdds-supply on 10nm PHY
      dt-bindings: msm/dsi: Don't require vcca-supply on 14nm PHY
      arm64: dts: qcom: msm8992: Don't use sfpb mutex
      arm64: dts: qcom: msm8992-libra: Add CPU regulators
      arm64: dts: qcom: msm8992-libra: Fix the memory map
      cpufreq: Add SM6375 to cpufreq-dt-platdev blocklist

Krzysztof Kozlowski (5):
      arm64: dts: qcom: sdm845-db845c: correct SPI2 pins drive strength
      arm64: dts: qcom: sdm850-lenovo-yoga-c630: correct I2C12 pins drive strength
      Bluetooth: hci_qca: Fix driver shutdown on closed serdev
      tty: serial: qcom-geni-serial: fix slab-out-of-bounds on RX FIFO buffer
      arm64: dts: imx8mq-thor96: fix no-mmc property for SDHCI

Kuniyuki Iwashima (1):
      netrom: Fix use-after-free of a listening socket.

Kuogee Hsieh (1):
      drm/msm/dp: do not complete dp_aux_cmd_fifo_tx() if irq is not for aux transfer

Kurt Kanzenbach (1):
      net: stmmac: Fix queue statistics reading

Kyle Huey (6):
      x86/fpu: Take task_struct* in copy_sigframe_from_user_to_xstate()
      x86/fpu: Add a pkru argument to copy_uabi_from_kernel_to_xstate().
      x86/fpu: Add a pkru argument to copy_uabi_to_xstate()
      x86/fpu: Allow PKRU to be (once again) written by ptrace.
      x86/fpu: Emulate XRSTOR's behavior if the xfeatures PKRU bit is not set
      selftests/vm/pkeys: Add a regression test for setting PKRU through ptrace

Lareine Khawaly (1):
      i2c: designware: use casting of u64 in clock multiplication to avoid overflow

Liao Chang (1):
      riscv/kprobe: Fix instruction simulation of JALR

Lino Sanfilippo (1):
      serial: amba-pl011: fix high priority character transmission in rs486 mode

Linus Torvalds (2):
      hfs/hfsplus: avoid WARN_ON() for sanity check, use proper error handling
      treewide: fix up files incorrectly marked executable

Liu Shixin (1):
      dmaengine: xilinx_dma: call of_node_put() when breaking out of for_each_child_of_node()

Luca Ceresoli (2):
      staging: media: tegra-video: fix chan->mipi value on error
      staging: media: tegra-video: fix device_node use after free

Luca Stefani (1):
      pstore: Properly assign mem_type property

Luis Gerhorst (1):
      bpf: Fix pointer-leak due to insufficient speculative store bypass mitigation

Luka Guzenko (1):
      ALSA: hda/realtek: Enable mute/micmute LEDs on HP Spectre x360 13-aw0xxx

Luo Meng (5):
      dm thin: resume even if in FAIL mode
      dm thin: Fix UAF in run_timer_softirq()
      dm integrity: Fix UAF in dm_integrity_dtr()
      dm clone: Fix UAF in clone_dtr()
      dm cache: Fix UAF in destroy()

Luís Henriques (2):
      ext4: remove trailing newline from ext4_msg() message
      ext4: fix error code return to user-space in ext4_get_branch()

Maciej Żenczykowski (1):
      usb: gadget: f_ncm: fix potential NULL ptr deref in ncm_bitrate()

Manivannan Sadhasivam (3):
      soc: qcom: Select REMAP_MMIO for LLCC driver
      EDAC/device: Respect any driver-supplied workqueue polling value
      EDAC/qcom: Do not pass llcc_driv_data as edac_device_ctl_info's pvt_info

Maor Dickman (1):
      net/mlx5: E-switch, Fix setting of reserved fields on MODIFY_SCHEDULING_ELEMENT

Maor Gottlieb (1):
      RDMA/mlx5: Fix validation of max_rd_atomic caps for DC

Marc Zyngier (2):
      KVM: arm64: Fix S1PTW handling on RO memslots
      KVM: arm64: GICv4.1: Fix race with doorbell on VPE activation/deactivation

Marcelo Ricardo Leitner (1):
      sctp: fail if no bound addresses can be used for a given scope

Marco Elver (1):
      kcsan: Instrument memcpy/memset/memmove with newer Clang

Marek Vasut (2):
      gpio: mxc: Protect GPIO irqchip RMW with bgpio spinlock
      gpio: mxc: Always set GPIOs used as interrupt source to INPUT mode

Maria Yu (1):
      remoteproc: core: Do pm_relax when in RPROC_OFFLINE state

Mario Limonciello (3):
      crypto: ccp - Add support for TEE for PCI ID 0x14CA
      Revert "ACPI: PM: Add support for upcoming AMD uPEP HID AMDI007"
      pinctrl: amd: Add dynamic debugging for active GPIOs

Marios Makassikis (1):
      ksmbd: do not sign response to session request for guest login

Mark Brown (2):
      ASoC: fsl_ssi: Rename AC'97 streams to avoid collisions with AC'97 CODEC
      ASoC: fsl-asoc-card: Fix naming of AC'97 CODEC widgets

Mark Rutland (3):
      arm64: atomics: format whitespace consistently
      arm64: atomics: remove LL/SC trampolines
      arm64: cmpxchg_double*: hazard against entire exchange variable

Masahiro Yamada (1):
      tomoyo: fix broken dependency on *.conf.default

Masami Hiramatsu (Google) (5):
      x86/kprobes: Fix kprobes instruction boudary check with CONFIG_RETHUNK
      x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK
      tracing: Fix complicated dependency of CONFIG_TRACER_MAX_TRACE
      perf probe: Use dwarf_attr_integrate as generic DWARF attr accessor
      perf probe: Fix to get the DW_AT_decl_file and DW_AT_call_file as unsinged data

Mateusz Guzik (1):
      lockref: stop doing cpu_relax in the cmpxchg loop

Mathias Nyman (5):
      xhci: Fix null pointer dereference when host dies
      xhci: Add update_hub_device override for PCI xHCI hosts
      xhci: Add a flag to disable USB3 lpm on a xhci root port level.
      usb: acpi: add helper to check port lpm capability using acpi _DSM
      xhci: Detect lpm incapable xHC USB3 roothub ports from ACPI tables

Matthew Auld (3):
      drm/i915/migrate: don't check the scratch page
      drm/i915/migrate: fix offset calculation
      drm/i915/migrate: fix length calculation

Matthieu Baerts (3):
      mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
      mptcp: dedicated request sock for subflow in v6
      mptcp: use proper req destructor for IPv6

Max Filippov (1):
      kcsan: test: don't put the expect array on the stack

Maxim Levitsky (1):
      KVM: SVM: fix tsc scaling cache logic

Maximilian Luz (3):
      ipu3-imgu: Fix NULL pointer dereference in imgu_subdev_set_selection()
      platform/surface: aggregator: Ignore command messages not intended for us
      platform/surface: aggregator: Add missing call to ssam_request_sync_free()

Miaoqian Lin (7):
      usb: dwc3: qcom: Fix memory leak in dwc3_qcom_interconnect_init
      nfc: Fix potential resource leaks
      net: phy: xgmiitorgmii: Fix refcount leak in xgmiitorgmii_probe
      gpio: sifive: Fix refcount leak in sifive_gpio_probe
      perf tools: Fix resources leak in perf_data__open_dir()
      soc: imx8m: Fix incorrect check for of_clk_get_by_name()
      EDAC/highbank: Fix memory leak in highbank_mc_probe()

Michael Adler (1):
      USB: serial: cp210x: add SCALANCE LPE-9000 device id

Michael Klein (1):
      platform/x86: touchscreen_dmi: Add info for the CSL Panther Tab HD

Michael S. Tsirkin (1):
      PCI: Fix pci_device_is_present() for VFs by checking PF

Michael Walle (1):
      wifi: wilc1000: sdio: fix module autoloading

Mickaël Salaün (1):
      selftests: Use optional USERCFLAGS and USERLDFLAGS

Mika Westerberg (1):
      thunderbolt: Use correct function to calculate maximum USB3 link rate

Mike Snitzer (2):
      dm cache: Fix ABBA deadlock between shrink_slab and dm_cache_metadata_abort
      dm cache: set needs_check flag after aborting metadata

Mikko Kovanen (1):
      drm/i915/dsi: fix VBT send packet port selection for dual link DSI

Miklos Szeredi (1):
      ovl: fail on invalid uid/gid mapping at copy up

Mikulas Patocka (2):
      md: fix a crash in mempool_free
      x86/asm: Fix an assembler warning with current binutils

Miles Chen (1):
      cpufreq: armada-37xx: stop using 0 as NULL pointer

Minsuk Kang (1):
      nfc: pn533: Wait for out_urb's completion in pn533_usb_send_frame()

Mirsad Goran Todorovac (1):
      af_unix: selftest: Fix the size of the parameter to connect()

Mohan Kumar (1):
      dmaengine: tegra210-adma: fix global intr clear

Moshe Shemesh (1):
      net/mlx5: E-Switch, properly handle ingress tagged packets on VST

Muhammad Usama Anjum (1):
      selftests: set the BUILD variable to absolute path

NARIBAYASHI Akira (1):
      mm, compaction: fix fast_isolate_around() to stay within boundaries

Namhyung Kim (2):
      perf/core: Call LSM hook after copying perf_event_attr
      perf stat: Fix handling of --for-each-cgroup with --bpf-counters to match non BPF mode

Namjae Jeon (5):
      ksmbd: fix infinite loop in ksmbd_conn_handler_loop()
      ksmbd: add smbd max io size parameter
      ksmbd: add max connections parameter
      ksmbd: downgrade ndr version error message to debug
      ksmbd: limit pdu length size according to connection status

Naohiro Aota (1):
      btrfs: fix trace event name typo for FLUSH_DELAYED_REFS

Natalia Petrova (1):
      trace_events_hist: add check for return value of 'create_hist_field'

Nathan Chancellor (3):
      hexagon: Fix function name in die()
      h8300: Fix build errors from do_exit() to make_task_dead() transition
      csky: Fix function name in csky_alignment() and die()

Nathan Lynch (2):
      powerpc/rtas: avoid device tree lookups in rtas_os_term()
      powerpc/rtas: avoid scheduling in rtas_os_term()

Nick Desaulniers (1):
      ARM: 9256/1: NWFPE: avoid compiler-generated __aeabi_uldivmod

Niklas Schnelle (1):
      s390/debug: add _ASM_S390_ prefix to header guard

Nikolay Borisov (1):
      btrfs: move missing device handling in a dedicate function

Nirmoy Das (1):
      drm/i915: Remove unused variable

Noor Azura Ahmad Tarmizi (1):
      net: stmmac: add aux timestamps fifo clearance wait

Ola Jeppsson (1):
      misc: fastrpc: Fix use-after-free race condition for maps

Olga Kornievskaia (1):
      pNFS/filelayout: Fix coalescing test for single DS

Pablo Neira Ayuso (7):
      netfilter: nf_tables: consolidate set description
      netfilter: nf_tables: add function to create set stateful expressions
      netfilter: nf_tables: perform type checking for existing sets
      netfilter: nf_tables: honor set timeout and garbage collection updates
      netfilter: nft_payload: incorrect arithmetics when fetching VLAN header bits
      netfilter: nft_set_rbtree: Switch to node list walk for overlap detection
      netfilter: nft_set_rbtree: skip elements in transaction from garbage collection

Paolo Abeni (3):
      net/ulp: prevent ULP without clone op from entering the LISTEN status
      net/ulp: use consistent error code when blocking ULP
      net: fix UaF in netns ops registration error path

Paolo Bonzini (2):
      Documentation: KVM: add API issues section
      KVM: x86: Do not return host topology information from KVM_GET_SUPPORTED_CPUID

Patrick Thompson (1):
      drm: Add orientation quirk for Lenovo ideapad D330-10IGL

Paul E. McKenney (1):
      rcu-tasks: Simplify trc_read_check_handler() atomic operations

Paul Menzel (1):
      fbdev: matroxfb: G200eW: Increase max memory from 1 MB to 16 MB

Paul Moore (1):
      bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD

Paulo Alcantara (4):
      cifs: fix oops during encryption
      cifs: fix confusing debug message
      cifs: fix potential deadlock in cache_refresh_path()
      cifs: fix return of uninitialized rc in dfs_cache_update_tgthint()

Pavel Begunkov (4):
      io_uring: fix CQ waiting timeout handling
      io_uring: lock overflowing for IOPOLL
      io_uring: improve send/recv error handling
      io_uring: fix double poll leak on repolling

Pavel Machek (1):
      f2fs: should put a page when checking the summary info

Pawel Laszczak (1):
      usb: cdns3: remove fetched trb from cache before dequeuing

Peng Li (1):
      net: hns3: extract macro to simplify ring stats update code

Peter Harliman Liem (1):
      dmaengine: lgm: Move DT parsing after initialization

Peter Newman (1):
      x86/resctrl: Fix task CLOSID/RMID update race

Peter Wang (1):
      scsi: ufs: core: WLUN suspend SSU/enter hibern8 fail recovery

Peter Zijlstra (1):
      x86/boot: Avoid using Intel mnemonics in AT&T syntax asm

Petr Pavlu (1):
      module: Don't wait for GOING modules

Philipp Jungkamp (1):
      ALSA: patch_realtek: Fix Dell Inspiron Plus 16

Philipp Zabel (2):
      drm/imx: ipuv3-plane: Fix overlay plane width
      reset: uniphier-glue: Use reset_control_bulk API

Pierre-Louis Bossart (3):
      soundwire: dmi-quirks: add quirk variant for LAPBC710 NUC15
      ASoC: Intel/SOF: use set_stream() instead of set_tdm_slots() for HDAudio
      ASoC/SoundWire: dai: expand 'stream' concept beyond SoundWire

Pietro Borrello (3):
      HID: check empty report_list in hid_validate_values()
      HID: check empty report_list in bigben_probe()
      HID: betop: check shape of output reports

Prashant Malani (2):
      usb: typec: altmodes/displayport: Add pin assignment helper
      usb: typec: altmodes/displayport: Fix pin assignment calculation

Qiang Yu (1):
      bus: mhi: host: Fix race between channel preparation and M0 event

Qiujun Huang (1):
      pstore/zone: Use GFP_ATOMIC to allocate zone buffer

Qu Wenruo (3):
      btrfs: check superblock to ensure the fs was not modified at thaw time
      btrfs: make thaw time super block check to also verify checksum
      btrfs: always report error in run_one_delayed_ref()

Rafael J. Wysocki (1):
      thermal: intel: int340x: Add locking to int340x_thermal_get_trip_type()

Rahul Rameshbabu (2):
      net/mlx5: Fix ptp max frequency adjustment range
      sch_htb: Avoid grafting on htb_destroy_class_offload when destroying htb

Raju Rangoju (2):
      amd-xgbe: TX Flow Ctrl Registers are h/w ver dependent
      amd-xgbe: Delay AN timeout during KR training

Rakesh Sankaranarayanan (1):
      net: dsa: microchip: ksz9477: port map correction in ALU table entry register

Randy Dunlap (3):
      phy: ti: fix Kconfig warning and operator precedence
      net: mlx5: eliminate anonymous module_init & module_exit
      ia64: make IA64_MCA_RECOVERY bool instead of tristate

Rasmus Villemoes (1):
      serial: fixup backport of "serial: Deassert Transmit Enable on probe in driver-specific way"

Reinette Chatre (2):
      dmaengine: idxd: Let probe fail when workqueue cannot be enabled
      selftests: Provide local define of __cpuid_count()

Ricardo Cañuelo (1):
      tools/virtio: initialize spinlocks in vring_test.c

Ricardo Ribalda (2):
      regulator: da9211: Use irq handler when ready
      xhci-pci: set the dma max_seg_size

Rob Clark (1):
      drm/virtio: Fix GEM handle creation UAF

Rob Herring (1):
      of/kexec: Fix reading 32-bit "linux,initrd-{start,end}" values

Robert Hancock (1):
      net: macb: fix PTP TX timestamp failure due to packet padding

Roderick Colenbrander (1):
      HID: playstation: sanity check DualSense calibration data.

Rodrigo Branco (1):
      x86/bugs: Flush IBP in ib_prctl_set()

Roger Pau Monne (1):
      hvc/xen: lock console list traversal

Roi Dayan (2):
      net/mlx5e: TC, Refactor mlx5e_tc_add_flow_mod_hdr() to get flow attr
      net/mlx5e: Set action fwd flag when parsing tc action goto

Ronak Doshi (1):
      vmxnet3: correctly report csum_level for encapsulated packet

Rong Chen (1):
      extcon: usbc-tusb320: fix kernel-doc warning

Ryusuke Konishi (1):
      nilfs2: fix general protection fault in nilfs_btree_insert()

Samuel Holland (1):
      mmc: sunxi-mmc: Fix clock refcount imbalance during unbind

Sasa Dragic (1):
      drm/i915: re-disable RC6p on Sandy Bridge

Sascha Hauer (1):
      PCI/sysfs: Fix double free in error path

Sasha Levin (6):
      Revert "selftests/bpf: Add test for unstable CT lookup API"
      phy: qcom-qmp-combo: fix out-of-bounds clock access
      btrfs: replace strncpy() with strscpy()
      btrfs: fix an error handling path in btrfs_defrag_leaves()
      drm/amd: Delay removal of the firmware framebuffer
      Revert "selftests/bpf: check null propagation only neither reg is PTR_TO_BTF_ID"

Schspa Shi (1):
      gpio: use raw spinlock for gpio chip shadowed data

Sean Christopherson (3):
      KVM: VMX: Resume guest immediately when injecting #GP on ECREATE
      KVM: nVMX: Inject #GP, not #UD, if "generic" VMXON CR0/CR4 check fails
      KVM: nVMX: Properly expose ENABLE_USR_WAIT_PAUSE control to L1

Sebastian Reichel (1):
      pinctrl/rockchip: add error handling for pull/drive register getters

Sergey Matyukevich (1):
      riscv: mm: notify remote harts about mmu cache updates

Sergio Paracuellos (1):
      staging: mt7621-dts: change some node hex addresses to lower case

Shang XiaoJing (2):
      parisc: led: Fix potential null-ptr-deref in start_task()
      phy: rockchip-inno-usb2: Fix missing clk_disable_unprepare() in rockchip_usb2phy_power_on()

Shawn Bohrer (1):
      veth: Fix race with AF_XDP exposing old or uninitialized descriptors

Shawn.Shao (1):
      Add exception protection processing for vd in axi_chan_handle_err function

Shay Drory (2):
      net/mlx5: Avoid recovery in probe flows
      RDMA/mlx5: Fix mlx5_ib_get_hw_stats when used for device

Shigeru Yoshida (1):
      fs/ntfs3: Fix memory leak on ntfs_fill_super() error path

Shin'ichiro Kawasaki (1):
      scsi: mpi3mr: Refer CONFIG_SCSI_MPI3MR in Makefile

Shuah Khan (2):
      tools: fix ARRAY_SIZE defines in tools and selftests hdrs
      selftests/vm: remove ARRAY_SIZE define from individual tests

Siddh Raman Pant (1):
      erofs/zmap.c: Fix incorrect offset calculation

Simon Ser (1):
      drm/connector: send hotplug uevent on connector cleanup

Smitha T Murthy (3):
      media: s5p-mfc: Fix to handle reference queue during finishing
      media: s5p-mfc: Clear workbit to handle error condition
      media: s5p-mfc: Fix in register read and write for H264

Soenke Huster (1):
      Bluetooth: fix null ptr deref on hci_sync_conn_complete_evt

Sreekanth Reddy (1):
      scsi: mpt3sas: Remove scsi_dma_map() error messages

Srinivas Pandruvada (2):
      thermal: int340x: Add missing attribute for data rate base
      thermal: intel: int340x: Protect trip temperature from concurrent updates

Sriram Yagnaraman (2):
      netfilter: conntrack: fix vtag checks for ABORT/SHUTDOWN_COMPLETE
      netfilter: conntrack: unify established states for SCTP paths

Stefan Metzmacher (1):
      io_uring/net: fix fast_iov assignment in io_setup_async_msg()

Stefano Garzarella (3):
      vringh: fix range used in iotlb_translate()
      vhost: fix range used in translate_desc()
      vdpa_sim: fix vringh initialization in vdpasim_queue_ready()

Stephan Gerhold (1):
      soc: qcom: apr: Make qcom,protection-domain optional again

Steve French (1):
      cifs: fix missing display of three mount options

Steven Price (1):
      drm/panfrost: Fix GEM handle creation ref-counting

Steven Rostedt (2):
      kest.pl: Fix grub2 menu handling for rebooting
      ktest.pl minconfig: Unset configs instead of just removing them

Steven Rostedt (Google) (6):
      ftrace/x86: Add back ftrace_expected for ftrace bug reports
      tracing: Fix race where eprobes can be called before the event
      tracing/probes: Handle system names with hyphens
      tracing: Use alignof__(struct {type b;}) instead of offsetof()
      tracing: Make sure trace_printk() can output as soon as it can be used
      ftrace/scripts: Update the instructions for ftrace-bisect.sh

Sumit Gupta (1):
      cpufreq: Add Tegra234 to cpufreq-dt-platdev blocklist

Szymon Heidrich (3):
      usb: rndis_host: Secure rndis_query check against int overflow
      wifi: rndis_wlan: Prevent buffer overflow in rndis_query_oid
      net: usb: sr9700: Handle negative len

Takashi Iwai (4):
      media: dvb-core: Fix UAF due to refcount races at releasing
      x86/kexec: Fix double-free of elf header buffer
      ALSA: usb-audio: Make sure to stop endpoints before closing EPs
      ALSA: usb-audio: Relax hw constraints for implicit fb sync

Tamim Khan (1):
      ACPI: resource: Skip IRQ override on Asus Vivobook K3402ZA/K3502ZA

Terry Junge (1):
      HID: plantronics: Additional PIDs for double volume key presses quirk

Tetsuo Handa (3):
      fs/ntfs3: Use __GFP_NOWARN allocation at wnd_init()
      fs/ntfs3: Use __GFP_NOWARN allocation at ntfs_fill_super()
      fs/ntfs3: don't hold ni_lock when calling truncate_setsize()

Thomas Gleixner (1):
      x86/i8259: Mark legacy PIC interrupts with IRQ_LEVEL

Thomas Zimmermann (1):
      drm/i915: Allow switching away via vga-switcheroo if uninitialized

Tiezhu Yang (3):
      panic: unset panic_on_warn inside panic()
      ubsan: no need to unset panic_on_warn in ubsan_epilogue()
      kasan: no need to unset panic_on_warn in end_report()

Tim Harvey (1):
      arm64: dts: imx8mm-venice-gw7901: fix USB2 controller OC polarity

Tobias Schramm (1):
      serial: atmel: fix incorrect baudrate setup

Tung Nguyen (1):
      tipc: fix unexpected link reset due to discovery messages

Udipto Goswami (2):
      usb: gadget: f_fs: Prevent race during ffs_ep0_queue_wait
      usb: gadget: f_fs: Ensure ep0req is dequeued before free_request

Viresh Kumar (2):
      thermal: Validate new state in cur_state_store()
      thermal: core: call put_device() only after device_register() fails

Vladimir Oltean (1):
      net: enetc: avoid deadlock in enetc_tx_onestep_tstamp()

Volker Lendecke (1):
      cifs: Fix uninitialized memory read for smb311 posix symlink create

Waiman Long (1):
      sched/core: Fix use-after-free bug in dup_user_cpus_ptr()

Wang Weiyang (1):
      device_cgroup: Roll back to original exceptions after copy failure

Wang Yufen (1):
      binfmt: Fix error return code in load_elf_fdpic_binary()

Wenchao Chen (1):
      mmc: sdhci-sprd: Disable CLK_AUTO when the clock is less than 400K

Wenchao Hao (1):
      scsi: iscsi: Fix multiple iSCSI session unbind events sent to userspace

Willem de Bruijn (1):
      selftests/net: toeplitz: fix race on tpacket_v3 block close

William Liu (1):
      ksmbd: check nt_len to be at least CIFS_ENCPWD_SIZE in ksmbd_decode_ntlmssp_auth_blob

Willy Tarreau (7):
      tools/nolibc: use pselect6 on RISCV
      tools/nolibc/std: move the standard type definitions to std.h
      tools/nolibc/types: split syscall-specific definitions into their own files
      tools/nolibc/arch: split arch-specific code into individual files
      tools/nolibc/arch: mark the _start symbol as weak
      tools/nolibc: restore mips branch ordering in the _start block
      tools/nolibc: fix the O_* fcntl/open macro definitions for riscv

Xiaoming Ni (1):
      sysctl: add a new register_sysctl_init() interface

Xingyuan Mo (1):
      NFSD: fix use-after-free in nfsd4_ssc_setup_dul()

Xiubo Li (1):
      ceph: switch to vfs_inode_has_locks() to fix file lock bug

Yan Zhai (1):
      net: fix NULL pointer in skb_segment_list

Yang Jihong (1):
      tracing: Fix infinite loop in tracing_read_pipe on overflowed print_trace_line

Yang Yingliang (5):
      ixgbe: fix pci device refcount leak
      net/mlx5: fix missing mutex_unlock in mlx5_fw_fatal_reporter_err_work()
      device property: fix of node refcount leak in fwnode_graph_get_next_endpoint()
      w1: fix deadloop in __w1_remove_master_device()
      w1: fix WARNING after calling w1_process()

Yanjun Zhang (1):
      nvme: fix multipath crash caused by flush request when blktrace is enabled

Yazen Ghannam (1):
      x86/MCE/AMD: Clear DFR errors found in THR handler

Ye Bin (6):
      ext4: fix reserved cluster accounting in __es_remove_extent()
      ext4: fix uninititialized value in 'ext4_evict_inode'
      ext4: init quota for 'old.inode' in 'ext4_rename'
      ext4: fix kernel BUG in 'ext4_write_inline_data_end()'
      ext4: fix inode leak in ext4_xattr_inode_create() on an error path
      ext4: allocate extended attribute value in vmalloc area

Yihang Li (1):
      scsi: hisi_sas: Set a port invalid only if there are no devices attached when refreshing port id

Yin Xiujiang (1):
      fs/ntfs3: Fix slab-out-of-bounds in r_page

Ying Hsu (1):
      Bluetooth: Fix possible deadlock in rfcomm_sk_state_change

YingChi Long (1):
      x86/fpu: Use _Alignof to avoid undefined behavior in TYPE_ALIGN

Yonatan Nachum (1):
      RDMA/core: Fix ib block iterator counter overflow

Yongqiang Liu (1):
      cpufreq: Init completion before kobject_init_and_add()

Yoshihiro Shimoda (2):
      net: ravb: Fix lack of register setting after system resumed for Gen3
      net: ravb: Fix possible hang if RIS2_QFF1 happen

Yu Kuai (2):
      block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq
      blk-cgroup: fix missing pd_online_fn() while activating policy

Yuan Can (2):
      drm/ingenic: Fix missing platform_driver_unregister() call in ingenic_drm_init()
      vhost/vsock: Fix error handling in vhost_vsock_init()

Yuchi Yang (1):
      ALSA: hda/realtek - Turn on power early

Yunfei Wang (1):
      iommu/iova: Fix alloc iova overflows issue

Zack Rusin (1):
      drm/vmwgfx: Validate the box size for the snooped cursor

Zhang Tianci (1):
      ovl: Use ovl mounter's fsuid and fsgid in ovl_link()

Zhang Yi (2):
      ext4: silence the warning when evicting inode with dioread_nolock
      ext4: check and assert if marking an no_delete evicting inode dirty

Zhang Yuchen (1):
      ipmi: fix long wait in unload when IPMI disconnect

Zheng Yejian (3):
      tracing/hist: Fix out-of-bound write on 'action_data.var_ref_idx'
      tracing/hist: Fix wrong return value in parse_action_params()
      tracing: Fix issue of missing one synthetic field

Zhengchao Shao (1):
      caif: fix memory leak in cfctrl_linkup_request()

Zhenyu Wang (2):
      drm/i915/gvt: fix gvt debugfs destroy
      drm/i915/gvt: fix vgpu debugfs clean in remove

Zhihao Cheng (2):
      dm thin: Fix ABBA deadlock between shrink_slab and dm_pool_abort_metadata
      dm thin: Use last transaction's pmd->root when commit failed

edward lo (2):
      fs/ntfs3: Validate BOOT record_size
      fs/ntfs3: Add overflow check for attribute size

hongao (1):
      drm/amd/display: Fix set scaling doesn's work

minoura makoto (1):
      SUNRPC: ensure the matching upcall is in-flight upon downcall

ruanjinjie (1):
      vdpa_sim: fix possible memory leak in vdpasim_net_init() and vdpasim_blk_init()

tangmeng (1):
      kernel/panic: move panic sysctls to its own file

void0red (1):
      btrfs: fix extent map use-after-free when handling missing device in read_one_chunk
---
Documentation/ABI/testing/sysfs-kernel-oops_count  |    6 +
 Documentation/ABI/testing/sysfs-kernel-warn_count  |    6 +
 Documentation/admin-guide/sysctl/kernel.rst        |   19 +
 .../bindings/display/msm/dsi-controller-main.yaml  |    4 +-
 .../bindings/display/msm/dsi-phy-10nm.yaml         |    1 -
 .../bindings/display/msm/dsi-phy-14nm.yaml         |    1 -
 .../bindings/display/msm/dsi-phy-28nm.yaml         |    4 +
 ...2a-usb2-phy.yaml => amlogic,g12a-usb2-phy.yaml} |    8 +-
 ...ie-phy.yaml => amlogic,g12a-usb3-pcie-phy.yaml} |    6 +-
 Documentation/sphinx/load_config.py                |    6 +-
 Documentation/virt/kvm/api.rst                     |   60 +
 Makefile                                           |    5 +-
 arch/alpha/kernel/traps.c                          |    6 +-
 arch/alpha/mm/fault.c                              |    2 +-
 arch/arm/boot/dts/imx53-ppd.dts                    |    2 +-
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi              |    1 -
 arch/arm/boot/dts/imx6ul-pico-dwarf.dts            |    2 +-
 arch/arm/boot/dts/imx7d-pico-dwarf.dts             |    4 +-
 arch/arm/boot/dts/imx7d-pico-nymph.dts             |    4 +-
 arch/arm/boot/dts/sam9x60.dtsi                     |    2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          |    2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |    2 +-
 arch/arm/include/asm/thread_info.h                 |   13 +-
 arch/arm/kernel/traps.c                            |    2 +-
 arch/arm/mach-imx/cpu-imx25.c                      |    1 +
 arch/arm/mach-imx/cpu-imx27.c                      |    1 +
 arch/arm/mach-imx/cpu-imx31.c                      |    1 +
 arch/arm/mach-imx/cpu-imx35.c                      |    1 +
 arch/arm/mach-imx/cpu-imx5.c                       |    1 +
 arch/arm/mm/fault.c                                |    2 +-
 arch/arm/mm/nommu.c                                |    2 +-
 arch/arm/nwfpe/Makefile                            |    6 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  |    2 +-
 .../arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi |    2 +-
 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |    2 +-
 .../dts/freescale/imx8mm-beacon-baseboard.dtsi     |    4 +-
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts      |    2 +-
 .../boot/dts/freescale/imx8mm-venice-gw7901.dts    |    1 +
 .../boot/dts/freescale/imx8mp-phycore-som.dtsi     |   10 -
 arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts  |    4 +-
 arch/arm64/boot/dts/freescale/imx8mq-thor96.dts    |    4 +-
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      |    2 +-
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts  |   90 +-
 arch/arm64/boot/dts/qcom/msm8992.dtsi              |    4 -
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |    5 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |    6 +-
 arch/arm64/include/asm/atomic_ll_sc.h              |  114 +-
 arch/arm64/include/asm/atomic_lse.h                |   16 +-
 arch/arm64/include/asm/efi.h                       |    3 +
 arch/arm64/include/asm/kvm_emulate.h               |   22 +-
 arch/arm64/kernel/efi-rt-wrapper.S                 |   14 +-
 arch/arm64/kernel/efi.c                            |   27 +
 arch/arm64/kernel/traps.c                          |    2 +-
 arch/arm64/kvm/hyp/nvhe/Makefile                   |    4 +
 arch/arm64/kvm/vgic/vgic-v3.c                      |   25 +-
 arch/arm64/kvm/vgic/vgic-v4.c                      |    8 +-
 arch/arm64/kvm/vgic/vgic.h                         |    1 +
 arch/arm64/mm/fault.c                              |    2 +-
 arch/csky/abiv1/alignment.c                        |    2 +-
 arch/csky/kernel/traps.c                           |    2 +-
 arch/csky/mm/fault.c                               |    2 +-
 arch/h8300/kernel/traps.c                          |    3 +-
 arch/h8300/mm/fault.c                              |    2 +-
 arch/hexagon/kernel/traps.c                        |    2 +-
 arch/ia64/Kconfig                                  |    2 +-
 arch/ia64/kernel/mca_drv.c                         |    2 +-
 arch/ia64/kernel/traps.c                           |    2 +-
 arch/ia64/mm/fault.c                               |    2 +-
 arch/m68k/kernel/traps.c                           |    2 +-
 arch/m68k/mm/fault.c                               |    2 +-
 arch/microblaze/kernel/exceptions.c                |    4 +-
 arch/mips/kernel/traps.c                           |    2 +-
 arch/nds32/kernel/fpu.c                            |    2 +-
 arch/nds32/kernel/traps.c                          |    8 +-
 arch/nios2/kernel/traps.c                          |    4 +-
 arch/openrisc/kernel/traps.c                       |    2 +-
 arch/parisc/include/uapi/asm/mman.h                |   27 +-
 arch/parisc/kernel/sys_parisc.c                    |   27 +
 arch/parisc/kernel/syscalls/syscall.tbl            |    2 +-
 arch/parisc/kernel/traps.c                         |    2 +-
 arch/powerpc/include/asm/imc-pmu.h                 |    2 +-
 arch/powerpc/kernel/rtas.c                         |   20 +-
 arch/powerpc/kernel/traps.c                        |    8 +-
 arch/powerpc/perf/imc-pmu.c                        |  136 +-
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi         |    2 +-
 arch/riscv/include/asm/mmu.h                       |    2 +
 arch/riscv/include/asm/pgtable.h                   |    2 +-
 arch/riscv/include/asm/tlbflush.h                  |   18 +
 arch/riscv/include/asm/uaccess.h                   |    2 +-
 arch/riscv/kernel/probes/simulate-insn.c           |    4 +-
 arch/riscv/kernel/probes/simulate-insn.h           |    4 +-
 arch/riscv/kernel/stacktrace.c                     |    2 +-
 arch/riscv/kernel/traps.c                          |    2 +-
 arch/riscv/mm/context.c                            |   10 +
 arch/riscv/mm/fault.c                              |    2 +-
 arch/riscv/mm/tlbflush.c                           |   28 +-
 arch/s390/include/asm/cpu_mf.h                     |   31 +-
 arch/s390/include/asm/debug.h                      |    6 +-
 arch/s390/include/asm/percpu.h                     |    2 +-
 arch/s390/kernel/dumpstack.c                       |    2 +-
 arch/s390/kernel/machine_kexec_file.c              |    5 +-
 arch/s390/kernel/nmi.c                             |    2 +-
 arch/s390/kernel/perf_cpum_sf.c                    |  101 +-
 arch/s390/kernel/vmlinux.lds.S                     |    2 +
 arch/s390/kvm/interrupt.c                          |   12 +-
 arch/sh/kernel/traps.c                             |    2 +-
 arch/sparc/kernel/traps_32.c                       |    4 +-
 arch/sparc/kernel/traps_64.c                       |    4 +-
 arch/x86/boot/bioscall.S                           |    4 +-
 arch/x86/entry/entry_32.S                          |    6 +-
 arch/x86/entry/entry_64.S                          |    6 +-
 arch/x86/events/amd/core.c                         |    2 +-
 arch/x86/events/intel/uncore.c                     |    1 +
 arch/x86/events/intel/uncore.h                     |    1 +
 arch/x86/events/intel/uncore_snbep.c               |   22 +-
 arch/x86/events/msr.c                              |    1 +
 arch/x86/events/rapl.c                             |    2 +
 arch/x86/include/asm/fpu/xstate.h                  |    4 +-
 arch/x86/kernel/acpi/cstate.c                      |   15 +
 arch/x86/kernel/cpu/bugs.c                         |    2 +
 arch/x86/kernel/cpu/mce/amd.c                      |   37 +-
 arch/x86/kernel/cpu/mce/core.c                     |   95 +-
 arch/x86/kernel/cpu/mce/internal.h                 |   12 +-
 arch/x86/kernel/cpu/microcode/intel.c              |    8 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c             |   12 +-
 arch/x86/kernel/crash.c                            |    4 +-
 arch/x86/kernel/dumpstack.c                        |    4 +-
 arch/x86/kernel/fpu/init.c                         |    7 +-
 arch/x86/kernel/fpu/regset.c                       |    2 +-
 arch/x86/kernel/fpu/signal.c                       |    2 +-
 arch/x86/kernel/fpu/xstate.c                       |   41 +-
 arch/x86/kernel/ftrace.c                           |    2 +
 arch/x86/kernel/i8259.c                            |    1 +
 arch/x86/kernel/irqinit.c                          |    4 +-
 arch/x86/kernel/kprobes/core.c                     |   10 +-
 arch/x86/kernel/kprobes/opt.c                      |   28 +-
 arch/x86/kvm/cpuid.c                               |   32 +-
 arch/x86/kvm/svm/svm.c                             |   34 +-
 arch/x86/kvm/svm/svm.h                             |    1 +
 arch/x86/kvm/vmx/nested.c                          |   47 +-
 arch/x86/kvm/vmx/sgx.c                             |    4 +-
 arch/x86/kvm/vmx/vmx.c                             |   21 +-
 arch/x86/lib/iomap_copy_64.S                       |    2 +-
 arch/xtensa/kernel/traps.c                         |    2 +-
 block/bfq-iosched.c                                |    2 +-
 block/blk-cgroup.c                                 |    4 +
 block/blk-core.c                                   |    8 +-
 block/blk-merge.c                                  |   14 +-
 block/blk-mq.c                                     |    2 +
 block/mq-deadline.c                                |   84 +-
 drivers/accessibility/speakup/spk_ttyio.c          |    3 +
 drivers/acpi/prmt.c                                |   10 +
 drivers/acpi/processor_idle.c                      |   23 +-
 drivers/acpi/resource.c                            |   78 +-
 drivers/acpi/x86/s2idle.c                          |   10 +-
 drivers/ata/ahci.c                                 |   32 +-
 drivers/base/dd.c                                  |    6 +-
 drivers/base/property.c                            |   18 +-
 drivers/base/test/test_async_driver_probe.c        |    2 +-
 drivers/block/drbd/drbd_req.c                      |    2 +
 drivers/block/pktcdvd.c                            |    2 +
 drivers/block/ps3vram.c                            |    2 +
 drivers/block/rsxx/dev.c                           |    2 +
 drivers/bluetooth/hci_qca.c                        |    7 +
 drivers/bus/mhi/core/pm.c                          |    3 +-
 drivers/char/ipmi/ipmi_msghandler.c                |    4 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |   27 +-
 drivers/char/tpm/eventlog/acpi.c                   |   12 +-
 drivers/char/tpm/tpm_crb.c                         |   29 +-
 drivers/char/tpm/tpm_tis.c                         |    9 +-
 drivers/comedi/drivers/adv_pci1760.c               |    2 +-
 drivers/cpufreq/armada-37xx-cpufreq.c              |    2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |    2 +
 drivers/cpufreq/cpufreq.c                          |    2 +-
 drivers/cpufreq/cpufreq_governor.c                 |   20 +-
 drivers/cpufreq/cpufreq_governor.h                 |    1 +
 drivers/cpufreq/cpufreq_governor_attr_set.c        |    5 -
 drivers/crypto/ccp/sp-pci.c                        |   11 +-
 drivers/crypto/n2_core.c                           |    6 +
 drivers/devfreq/devfreq.c                          |    6 +-
 drivers/devfreq/governor_userspace.c               |   12 +-
 drivers/dma/dmaengine.c                            |    7 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |    6 +
 drivers/dma/idxd/device.c                          |    3 +-
 drivers/dma/imx-sdma.c                             |    4 +-
 drivers/dma/lgm/lgm-dma.c                          |   10 +-
 drivers/dma/ptdma/ptdma-dev.c                      |    7 +-
 drivers/dma/ptdma/ptdma.h                          |    2 +-
 drivers/dma/tegra210-adma.c                        |    2 +-
 drivers/dma/ti/k3-udma.c                           |    5 +-
 drivers/dma/xilinx/xilinx_dma.c                    |    4 +-
 drivers/edac/edac_device.c                         |   30 +-
 drivers/edac/edac_module.h                         |    2 +-
 drivers/edac/highbank_mc_edac.c                    |    7 +-
 drivers/edac/qcom_edac.c                           |    5 +-
 drivers/extcon/extcon-usbc-tusb320.c               |    2 +-
 drivers/firmware/arm_scmi/driver.c                 |    2 +
 drivers/firmware/arm_scmi/shmem.c                  |    9 +-
 drivers/firmware/efi/efi.c                         |   13 +-
 drivers/firmware/efi/libstub/efistub.h             |    2 +
 drivers/firmware/efi/libstub/random.c              |   42 +-
 drivers/firmware/efi/runtime-wrappers.c            |    1 +
 drivers/firmware/google/coreboot_table.c           |    9 +-
 drivers/firmware/google/coreboot_table.h           |    1 +
 drivers/firmware/google/gsmi.c                     |    7 +-
 drivers/gpio/gpio-amdpt.c                          |   10 +-
 drivers/gpio/gpio-brcmstb.c                        |   12 +-
 drivers/gpio/gpio-cadence.c                        |   12 +-
 drivers/gpio/gpio-dwapb.c                          |   36 +-
 drivers/gpio/gpio-grgpio.c                         |   30 +-
 drivers/gpio/gpio-hlwd.c                           |   18 +-
 drivers/gpio/gpio-idt3243x.c                       |   12 +-
 drivers/gpio/gpio-ixp4xx.c                         |    4 +-
 drivers/gpio/gpio-loongson1.c                      |    8 +-
 drivers/gpio/gpio-menz127.c                        |    8 +-
 drivers/gpio/gpio-mlxbf2.c                         |    6 +-
 drivers/gpio/gpio-mmio.c                           |   22 +-
 drivers/gpio/gpio-mxc.c                            |   16 +-
 drivers/gpio/gpio-sifive.c                         |   13 +-
 drivers/gpio/gpio-tb10x.c                          |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   14 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   12 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    1 -
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |    4 +-
 drivers/gpu/drm/drm_connector.c                    |    3 +
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |    6 +
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c       |    4 +-
 drivers/gpu/drm/i915/display/skl_universal_plane.c |    2 +-
 drivers/gpu/drm/i915/gt/intel_migrate.c            |    8 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |   34 +-
 drivers/gpu/drm/i915/gvt/debugfs.c                 |   17 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |    1 +
 drivers/gpu/drm/i915/i915_drv.c                    |    5 +-
 drivers/gpu/drm/i915/i915_pci.c                    |    3 +-
 drivers/gpu/drm/i915/i915_switcheroo.c             |    6 +-
 .../drm/i915/selftests/intel_scheduler_helpers.c   |    3 +-
 drivers/gpu/drm/imx/ipuv3-plane.c                  |   14 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |    6 +-
 drivers/gpu/drm/meson/meson_viu.c                  |    5 +-
 drivers/gpu/drm/mgag200/mgag200_pll.c              |    3 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   10 +-
 drivers/gpu/drm/msm/dp/dp_aux.c                    |    4 +
 drivers/gpu/drm/panfrost/Kconfig                   |    3 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |   27 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c            |   16 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h            |    5 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |   19 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |    3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h          |    0
 drivers/hid/hid-betopff.c                          |   17 +-
 drivers/hid/hid-bigbenff.c                         |    5 +
 drivers/hid/hid-core.c                             |    4 +-
 drivers/hid/hid-ids.h                              |    4 +-
 drivers/hid/hid-multitouch.c                       |    4 +
 drivers/hid/hid-plantronics.c                      |    9 +
 drivers/hid/hid-playstation.c                      |   32 +
 drivers/hid/hid-quirks.c                           |    1 -
 drivers/hid/intel-ish-hid/ishtp/dma-if.c           |   10 +
 drivers/i2c/busses/i2c-designware-common.c         |    9 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |   61 +-
 drivers/infiniband/core/verbs.c                    |    7 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c          |  200 ++-
 drivers/infiniband/hw/hfi1/user_exp_rcv.h          |    3 +
 drivers/infiniband/hw/mlx5/counters.c              |    6 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   49 +-
 drivers/infiniband/ulp/srp/ib_srp.h                |    8 +-
 drivers/input/mouse/synaptics.c                    |    1 -
 drivers/iommu/amd/init.c                           |    7 +
 drivers/iommu/iova.c                               |    4 +-
 drivers/iommu/mtk_iommu_v1.c                       |    4 +-
 drivers/md/dm-cache-metadata.c                     |   54 +-
 drivers/md/dm-cache-target.c                       |   11 +-
 drivers/md/dm-clone-target.c                       |    1 +
 drivers/md/dm-integrity.c                          |    2 +
 drivers/md/dm-thin-metadata.c                      |   60 +-
 drivers/md/dm-thin.c                               |   18 +-
 drivers/md/md-bitmap.c                             |   20 +-
 drivers/md/md.c                                    |   11 +-
 drivers/media/dvb-core/dmxdev.c                    |    8 +
 drivers/media/dvb-core/dvbdev.c                    |    1 +
 drivers/media/dvb-frontends/stv0288.c              |    5 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c      |    4 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c       |   12 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c    |   14 +-
 drivers/memory/atmel-sdramc.c                      |    6 +-
 drivers/memory/mvebu-devbus.c                      |    3 +-
 drivers/memory/tegra/tegra186.c                    |   36 -
 drivers/mfd/mt6360-core.c                          |   14 +-
 drivers/misc/fastrpc.c                             |   26 +-
 drivers/misc/mei/hw-me-regs.h                      |    2 +
 drivers/misc/mei/pci-me.c                          |    2 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   22 +-
 drivers/mmc/host/sdhci-sprd.c                      |   16 +-
 drivers/mmc/host/sunxi-mmc.c                       |    8 +-
 drivers/mmc/host/vub300.c                          |    2 +
 drivers/mtd/spi-nor/core.c                         |    2 +
 drivers/net/bonding/bond_3ad.c                     |    1 +
 drivers/net/dsa/microchip/ksz9477.c                |    4 +-
 drivers/net/dsa/mv88e6xxx/Kconfig                  |    4 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |   29 +-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |    6 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   83 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |   17 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |   23 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |    3 +
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c           |    4 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |   28 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |    2 +
 drivers/net/ethernet/broadcom/tg3.c                |    8 +-
 drivers/net/ethernet/cadence/macb_main.c           |    9 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |    4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  178 +--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |    7 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   75 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |    3 +-
 drivers/net/ethernet/intel/igc/igc_defines.h       |    2 +
 drivers/net/ethernet/intel/igc/igc_ptp.c           |   10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       |   14 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    4 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |    1 -
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   19 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |    2 +
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   11 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c  |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   55 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h    |    4 +-
 .../mellanox/mlx5/core/esw/acl/egress_lgcy.c       |    7 +-
 .../mellanox/mlx5/core/esw/acl/ingress_lgcy.c      |   33 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |   18 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   30 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |    7 +
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |    4 +
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   10 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |    2 +-
 drivers/net/ethernet/microsoft/mana/gdma.h         |    3 +
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |    9 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c  |    8 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.h    |   10 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |    8 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   44 +-
 drivers/net/ethernet/renesas/ravb.h                |    4 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   38 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       |   14 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |    8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    5 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |    5 +-
 drivers/net/ipa/ipa_interrupt.c                    |   10 +
 drivers/net/ipa/ipa_interrupt.h                    |   16 +
 drivers/net/ipa/ipa_power.c                        |   17 +
 drivers/net/mdio/mdio-mux-meson-g12a.c             |   23 +-
 drivers/net/phy/mdio_bus.c                         |    7 +-
 drivers/net/phy/xilinx_gmii2rgmii.c                |    1 +
 drivers/net/usb/cdc_ether.c                        |    6 +
 drivers/net/usb/r8152.c                            |    1 +
 drivers/net/usb/rndis_host.c                       |    3 +-
 drivers/net/usb/sr9700.c                           |    2 +-
 drivers/net/veth.c                                 |    5 +-
 drivers/net/virtio_net.c                           |    6 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |    8 +
 drivers/net/wan/fsl_ucc_hdlc.c                     |    6 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |    2 +-
 drivers/net/wireless/microchip/wilc1000/sdio.c     |    1 +
 drivers/net/wireless/rndis_wlan.c                  |   19 +-
 drivers/nfc/pn533/usb.c                            |   44 +-
 drivers/nvme/host/core.c                           |   32 +-
 drivers/nvme/host/multipath.c                      |    2 +
 drivers/nvme/host/nvme.h                           |    2 +-
 drivers/nvme/host/pci.c                            |   39 +-
 drivers/nvme/target/admin-cmd.c                    |   35 +-
 drivers/nvme/target/passthru.c                     |   11 +-
 drivers/of/kexec.c                                 |   10 +-
 drivers/parisc/led.c                               |    3 +
 drivers/pci/pci-sysfs.c                            |   13 +-
 drivers/pci/pci.c                                  |    2 +
 drivers/phy/phy-can-transceiver.c                  |    5 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |    8 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |    4 +-
 drivers/phy/ti/Kconfig                             |    4 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |    8 +-
 drivers/pinctrl/pinctrl-amd.c                      |   10 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |  315 +++--
 drivers/pinctrl/pinctrl-rockchip.h                 |    4 +-
 drivers/platform/surface/aggregator/controller.c   |    4 +-
 .../surface/aggregator/ssh_request_layer.c         |   14 +
 drivers/platform/x86/asus-nb-wmi.c                 |    1 +
 drivers/platform/x86/dell/dell-wmi-privacy.c       |   41 +-
 drivers/platform/x86/ideapad-laptop.c              |    6 +
 drivers/platform/x86/sony-laptop.c                 |   21 +-
 drivers/platform/x86/touchscreen_dmi.c             |   25 +
 drivers/regulator/da9211-regulator.c               |   11 +-
 drivers/remoteproc/remoteproc_core.c               |    9 +-
 drivers/reset/reset-uniphier-glue.c                |   37 +-
 drivers/rtc/rtc-ds1347.c                           |    2 +-
 drivers/s390/block/dcssblk.c                       |    2 +
 drivers/scsi/hisi_sas/hisi_sas_main.c              |    2 +-
 drivers/scsi/hpsa.c                                |    2 +-
 drivers/scsi/mpi3mr/Makefile                       |    2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   18 +-
 drivers/scsi/scsi_transport_iscsi.c                |   50 +-
 drivers/scsi/ufs/ufshcd.c                          |   64 +-
 drivers/scsi/ufs/ufshcd.h                          |    2 +
 drivers/soc/imx/soc-imx8m.c                        |    4 +-
 drivers/soc/qcom/Kconfig                           |    1 +
 drivers/soc/qcom/apr.c                             |    3 +-
 drivers/soc/qcom/cpr.c                             |    6 +-
 drivers/soc/ux500/ux500-soc-id.c                   |   10 +-
 drivers/soundwire/dmi-quirks.c                     |    8 +
 drivers/soundwire/intel.c                          |    8 +-
 drivers/soundwire/qcom.c                           |    8 +-
 drivers/soundwire/stream.c                         |    4 +-
 drivers/spi/spidev.c                               |    2 -
 drivers/staging/media/ipu3/ipu3-v4l2.c             |   57 +-
 drivers/staging/media/tegra-video/csi.c            |    4 +-
 drivers/staging/media/tegra-video/csi.h            |    2 +-
 drivers/staging/mt7621-dts/mt7621.dtsi             |   12 +-
 .../include/linux/raspberrypi/vchiq.h              |    2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |    4 +-
 drivers/thermal/gov_fair_share.c                   |   10 +-
 drivers/thermal/gov_power_allocator.c              |    4 +-
 .../intel/int340x_thermal/int340x_thermal_zone.c   |   28 +-
 .../intel/int340x_thermal/int340x_thermal_zone.h   |    1 +
 .../intel/int340x_thermal/processor_thermal_rfim.c |    4 +
 drivers/thermal/tegra/tegra30-tsensor.c            |    2 +-
 drivers/thermal/thermal_core.c                     |   53 +-
 drivers/thermal/thermal_helpers.c                  |    4 +-
 drivers/thermal/thermal_netlink.c                  |    2 +-
 drivers/thermal/thermal_sysfs.c                    |   33 +-
 drivers/thunderbolt/tunnel.c                       |    2 +-
 drivers/tty/hvc/hvc_xen.c                          |   46 +-
 drivers/tty/serial/amba-pl011.c                    |    8 +-
 drivers/tty/serial/atmel_serial.c                  |    8 +-
 drivers/tty/serial/fsl_lpuart.c                    |    2 +-
 drivers/tty/serial/pch_uart.c                      |    2 +-
 drivers/tty/serial/qcom_geni_serial.c              |   18 +-
 drivers/tty/serial/serial_core.c                   |    3 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |   12 +
 drivers/usb/core/hub.c                             |   13 +
 drivers/usb/core/usb-acpi.c                        |   65 +
 drivers/usb/dwc3/dwc3-qcom.c                       |   13 +-
 drivers/usb/gadget/function/f_fs.c                 |    7 +
 drivers/usb/gadget/function/f_ncm.c                |    4 +-
 drivers/usb/gadget/legacy/inode.c                  |   28 +-
 drivers/usb/gadget/legacy/webcam.c                 |    3 +
 drivers/usb/host/ehci-fsl.c                        |    2 +-
 drivers/usb/host/xhci-pci.c                        |   45 +
 drivers/usb/host/xhci-ring.c                       |    5 +-
 drivers/usb/host/xhci.c                            |   18 +-
 drivers/usb/host/xhci.h                            |    5 +
 drivers/usb/misc/iowarrior.c                       |    2 +-
 drivers/usb/serial/cp210x.c                        |    1 +
 drivers/usb/serial/option.c                        |   17 +
 drivers/usb/storage/uas-detect.h                   |   13 +
 drivers/usb/storage/unusual_uas.h                  |    7 -
 drivers/usb/typec/altmodes/displayport.c           |   22 +-
 drivers/usb/typec/tcpm/tcpm.c                      |    7 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |    3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c               |    4 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c               |    4 +-
 drivers/vdpa/vdpa_user/vduse_dev.c                 |    3 +
 drivers/vhost/vhost.c                              |    4 +-
 drivers/vhost/vringh.c                             |    5 +-
 drivers/vhost/vsock.c                              |    9 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |    4 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c         |   28 +-
 drivers/virtio/virtio_pci_modern.c                 |    2 +-
 drivers/w1/w1.c                                    |    6 +-
 drivers/w1/w1_int.c                                |    5 +-
 fs/affs/file.c                                     |    2 +-
 fs/binfmt_elf_fdpic.c                              |    5 +-
 fs/btrfs/backref.c                                 |    4 +
 fs/btrfs/disk-io.c                                 |   44 +-
 fs/btrfs/disk-io.h                                 |    6 +-
 fs/btrfs/extent-tree.c                             |    7 +-
 fs/btrfs/ioctl.c                                   |    9 +-
 fs/btrfs/qgroup.c                                  |   25 +-
 fs/btrfs/rcu-string.h                              |    6 +-
 fs/btrfs/super.c                                   |   76 ++
 fs/btrfs/tree-defrag.c                             |    6 +-
 fs/btrfs/tree-log.c                                |    2 -
 fs/btrfs/volumes.c                                 |   43 +-
 fs/ceph/caps.c                                     |    2 +-
 fs/ceph/locks.c                                    |    4 -
 fs/ceph/super.h                                    |    1 -
 fs/cifs/cifsfs.c                                   |    8 +-
 fs/cifs/cifsglob.h                                 |   69 +
 fs/cifs/cifsproto.h                                |    4 +-
 fs/cifs/connect.c                                  |    4 +-
 fs/cifs/dfs_cache.c                                |   48 +-
 fs/cifs/link.c                                     |    1 +
 fs/cifs/misc.c                                     |    4 +-
 fs/cifs/smb2ops.c                                  |  143 +--
 fs/cifs/smb2pdu.c                                  |   15 +-
 fs/cifs/smbdirect.c                                |    1 +
 fs/dlm/lowcomms.c                                  |    9 +-
 fs/erofs/zmap.c                                    |   10 +-
 fs/eventfd.c                                       |   37 +-
 fs/eventpoll.c                                     |   18 +-
 fs/ext4/balloc.c                                   |    2 +-
 fs/ext4/ext4.h                                     |    9 +-
 fs/ext4/ext4_jbd2.c                                |    3 +-
 fs/ext4/extents.c                                  |    8 +
 fs/ext4/extents_status.c                           |    3 +-
 fs/ext4/fast_commit.c                              |  285 +++--
 fs/ext4/fast_commit.h                              |    7 +-
 fs/ext4/indirect.c                                 |   13 +-
 fs/ext4/inode.c                                    |   50 +-
 fs/ext4/ioctl.c                                    |   13 +-
 fs/ext4/namei.c                                    |   47 +-
 fs/ext4/orphan.c                                   |   26 +-
 fs/ext4/resize.c                                   |   10 +-
 fs/ext4/super.c                                    |   52 +-
 fs/ext4/verity.c                                   |    2 +-
 fs/ext4/xattr.c                                    |   19 +-
 fs/f2fs/extent_cache.c                             |    3 +-
 fs/f2fs/gc.c                                       |    1 +
 fs/f2fs/node.c                                     |    3 +-
 fs/hfs/inode.c                                     |   13 +-
 fs/hfsplus/hfsplus_fs.h                            |    2 +
 fs/hfsplus/inode.c                                 |   16 +-
 fs/hfsplus/options.c                               |    4 +
 fs/ksmbd/auth.c                                    |    3 +-
 fs/ksmbd/connection.c                              |   24 +-
 fs/ksmbd/ksmbd_netlink.h                           |    4 +-
 fs/ksmbd/ndr.c                                     |    8 +-
 fs/ksmbd/server.h                                  |    1 +
 fs/ksmbd/smb2pdu.c                                 |    2 +
 fs/ksmbd/smb2pdu.h                                 |    5 +-
 fs/ksmbd/transport_ipc.c                           |    6 +
 fs/ksmbd/transport_rdma.c                          |    8 +-
 fs/ksmbd/transport_rdma.h                          |    6 +
 fs/ksmbd/transport_tcp.c                           |   22 +-
 fs/locks.c                                         |   23 +
 fs/mbcache.c                                       |  121 +-
 fs/nfs/filelayout/filelayout.c                     |    8 +
 fs/nfsd/nfs4proc.c                                 |    1 +
 fs/nfsd/nfs4xdr.c                                  |   11 +
 fs/nfsd/nfssvc.c                                   |    2 +-
 fs/nilfs2/btree.c                                  |   15 +-
 fs/ntfs3/attrib.c                                  |   20 +-
 fs/ntfs3/attrlist.c                                |    5 +
 fs/ntfs3/bitmap.c                                  |    2 +-
 fs/ntfs3/file.c                                    |    4 +-
 fs/ntfs3/frecord.c                                 |   14 +
 fs/ntfs3/fslog.c                                   |   35 +-
 fs/ntfs3/fsntfs.c                                  |   10 +-
 fs/ntfs3/index.c                                   |    6 +
 fs/ntfs3/inode.c                                   |    9 +
 fs/ntfs3/record.c                                  |   10 +
 fs/ntfs3/super.c                                   |    9 +-
 fs/overlayfs/copy_up.c                             |    4 +
 fs/overlayfs/dir.c                                 |   46 +-
 fs/pnode.c                                         |    2 +-
 fs/proc/proc_sysctl.c                              |   33 +
 fs/pstore/ram.c                                    |    2 +-
 fs/pstore/zone.c                                   |    2 +-
 fs/quota/dquot.c                                   |    2 +
 fs/reiserfs/super.c                                |    6 -
 fs/udf/inode.c                                     |    2 +-
 fs/zonefs/super.c                                  |   22 +
 include/linux/cpufreq.h                            |    5 +
 include/linux/devfreq.h                            |    7 +-
 include/linux/efi.h                                |    2 -
 include/linux/eventfd.h                            |    7 +
 include/linux/fs.h                                 |    6 +
 include/linux/gpio/driver.h                        |    2 +-
 include/linux/mbcache.h                            |   33 +-
 include/linux/mlx5/device.h                        |    5 +
 include/linux/mlx5/mlx5_ifc.h                      |    3 +-
 include/linux/netfilter/ipset/ip_set.h             |    2 +-
 include/linux/nvme.h                               |    3 +-
 include/linux/panic.h                              |    7 +-
 include/linux/sched/task.h                         |    1 +
 include/linux/sunrpc/rpc_pipe_fs.h                 |    5 +
 include/linux/sysctl.h                             |    3 +
 include/linux/thermal.h                            |    5 +-
 include/linux/tpm_eventlog.h                       |    4 +-
 include/linux/usb.h                                |    3 +
 include/net/mptcp.h                                |   12 +-
 include/net/netfilter/nf_tables.h                  |   25 +-
 include/net/sch_generic.h                          |    7 +
 include/net/sock.h                                 |    2 +-
 include/scsi/scsi_transport_iscsi.h                |    9 +
 include/sound/soc-dai.h                            |   32 +-
 include/trace/events/btrfs.h                       |    2 +-
 include/trace/events/ext4.h                        |    7 +-
 include/trace/events/jbd2.h                        |   44 +-
 include/trace/trace_events.h                       |    2 +-
 include/uapi/linux/eventpoll.h                     |    6 +
 include/uapi/linux/netfilter/nf_conntrack_sctp.h   |    2 +-
 include/uapi/linux/netfilter/nfnetlink_cttimeout.h |    2 +-
 io_uring/io-wq.c                                   |    8 +-
 io_uring/io_uring.c                                |  279 +++-
 kernel/bpf/offload.c                               |    3 -
 kernel/bpf/syscall.c                               |    6 +-
 kernel/bpf/verifier.c                              |    4 +-
 kernel/events/core.c                               |    6 +-
 kernel/exit.c                                      |   72 ++
 kernel/kcsan/core.c                                |   50 +
 kernel/kcsan/kcsan_test.c                          |    7 +-
 kernel/kcsan/report.c                              |    3 +-
 kernel/module.c                                    |   26 +-
 kernel/panic.c                                     |   89 +-
 kernel/rcu/tasks.h                                 |   20 +-
 kernel/sched/core.c                                |   40 +-
 kernel/sys.c                                       |    2 +
 kernel/sysctl.c                                    |   11 -
 kernel/trace/Kconfig                               |    2 +
 kernel/trace/bpf_trace.c                           |    3 +
 kernel/trace/trace.c                               |   40 +-
 kernel/trace/trace.h                               |   28 +-
 kernel/trace/trace_eprobe.c                        |    3 +
 kernel/trace/trace_events_hist.c                   |   13 +-
 kernel/trace/trace_events_synth.c                  |    2 +-
 kernel/trace/trace_output.c                        |    3 +-
 kernel/trace/trace_probe.c                         |    2 +-
 lib/lockref.c                                      |    1 -
 lib/nlattr.c                                       |    3 +
 lib/ubsan.c                                        |   11 +-
 localversion-rt                                    |    2 +-
 mm/compaction.c                                    |   18 +-
 mm/hugetlb.c                                       |   44 +-
 mm/kasan/report.c                                  |   12 +-
 mm/kfence/report.c                                 |    3 +-
 mm/khugepaged.c                                    |   14 +-
 mm/memblock.c                                      |    8 +-
 net/bluetooth/hci_core.c                           |    1 +
 net/bluetooth/hci_event.c                          |   13 +
 net/bluetooth/rfcomm/sock.c                        |    7 +-
 net/caif/cfctrl.c                                  |    6 +-
 net/core/filter.c                                  |    7 +-
 net/core/net_namespace.c                           |    2 +-
 net/core/skbuff.c                                  |    5 +-
 net/ethtool/ioctl.c                                |    3 +-
 net/ipv4/fib_semantics.c                           |    2 +
 net/ipv4/inet_connection_sock.c                    |   16 +-
 net/ipv4/inet_hashtables.c                         |   17 +-
 net/ipv4/inet_timewait_sock.c                      |    8 +-
 net/ipv4/metrics.c                                 |    2 +
 net/ipv4/syncookies.c                              |    7 +-
 net/ipv4/tcp.c                                     |    2 +
 net/ipv4/tcp_ulp.c                                 |    4 +
 net/ipv6/ip6_output.c                              |   15 +-
 net/ipv6/raw.c                                     |    4 +
 net/l2tp/l2tp_core.c                               |  116 +-
 net/mac80211/agg-tx.c                              |    6 +-
 net/mac80211/driver-ops.c                          |    3 +
 net/mac80211/iface.c                               |    1 -
 net/mctp/af_mctp.c                                 |    7 +
 net/mctp/route.c                                   |    6 +
 net/mptcp/subflow.c                                |   76 +-
 net/netfilter/ipset/ip_set_bitmap_ip.c             |    4 +-
 net/netfilter/ipset/ip_set_core.c                  |    7 +-
 net/netfilter/ipset/ip_set_hash_ip.c               |   14 +-
 net/netfilter/ipset/ip_set_hash_ipmark.c           |   13 +-
 net/netfilter/ipset/ip_set_hash_ipport.c           |   13 +-
 net/netfilter/ipset/ip_set_hash_ipportip.c         |   13 +-
 net/netfilter/ipset/ip_set_hash_ipportnet.c        |   13 +-
 net/netfilter/ipset/ip_set_hash_net.c              |   17 +-
 net/netfilter/ipset/ip_set_hash_netiface.c         |   15 +-
 net/netfilter/ipset/ip_set_hash_netnet.c           |   23 +-
 net/netfilter/ipset/ip_set_hash_netport.c          |   19 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c       |   40 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |  118 +-
 net/netfilter/nf_conntrack_standalone.c            |    8 -
 net/netfilter/nf_tables_api.c                      |  261 ++--
 net/netfilter/nft_payload.c                        |    2 +-
 net/netfilter/nft_set_rbtree.c                     |  332 +++--
 net/netlink/af_netlink.c                           |   38 +-
 net/netrom/nr_timer.c                              |    1 +
 net/nfc/llcp_core.c                                |    1 +
 net/nfc/netlink.c                                  |   52 +-
 net/packet/af_packet.c                             |   20 +-
 net/sched/act_mpls.c                               |    8 +-
 net/sched/cls_tcindex.c                            |   12 +-
 net/sched/sch_api.c                                |    5 +
 net/sched/sch_atm.c                                |    5 +-
 net/sched/sch_cbq.c                                |    4 +-
 net/sched/sch_htb.c                                |   27 +-
 net/sched/sch_taprio.c                             |    2 +
 net/sctp/bind_addr.c                               |    6 +
 net/sunrpc/auth_gss/auth_gss.c                     |   19 +-
 net/sunrpc/auth_gss/svcauth_gss.c                  |    9 +-
 net/tipc/node.c                                    |   12 +-
 scripts/Makefile                                   |    4 +-
 scripts/dtc/Makefile                               |    6 +-
 scripts/kconfig/gconf-cfg.sh                       |   12 +-
 scripts/kconfig/mconf-cfg.sh                       |   16 +-
 scripts/kconfig/nconf-cfg.sh                       |   16 +-
 scripts/kconfig/qconf-cfg.sh                       |   14 +-
 scripts/tracing/ftrace-bisect.sh                   |   34 +-
 security/device_cgroup.c                           |   33 +-
 security/integrity/ima/ima_template.c              |    5 +-
 security/integrity/platform_certs/load_uefi.c      |    1 +
 security/tomoyo/Makefile                           |    2 +-
 sound/core/control.c                               |   24 +-
 sound/core/control_led.c                           |    5 +-
 sound/pci/hda/patch_hdmi.c                         |    1 +
 sound/pci/hda/patch_realtek.c                      |  107 +-
 sound/soc/codecs/hdac_hda.c                        |   22 +-
 sound/soc/codecs/max98373-sdw.c                    |    2 +-
 sound/soc/codecs/rt1308-sdw.c                      |    2 +-
 sound/soc/codecs/rt1316-sdw.c                      |    2 +-
 sound/soc/codecs/rt5682-sdw.c                      |    2 +-
 sound/soc/codecs/rt700.c                           |    2 +-
 sound/soc/codecs/rt711-sdca.c                      |    2 +-
 sound/soc/codecs/rt711.c                           |    2 +-
 sound/soc/codecs/rt715-sdca.c                      |    2 +-
 sound/soc/codecs/rt715.c                           |    2 +-
 sound/soc/codecs/sdw-mockup.c                      |    2 +-
 sound/soc/codecs/wcd938x.c                         |    2 +-
 sound/soc/codecs/wm8904.c                          |    7 +
 sound/soc/codecs/wsa881x.c                         |    2 +-
 sound/soc/fsl/fsl-asoc-card.c                      |    8 +-
 sound/soc/fsl/fsl_micfil.c                         |   16 +-
 sound/soc/fsl/fsl_ssi.c                            |    4 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |   15 +
 sound/soc/intel/boards/sof_sdw.c                   |    6 +-
 sound/soc/intel/skylake/skl-pcm.c                  |    7 +-
 sound/soc/jz4740/jz4740-i2s.c                      |   39 +-
 sound/soc/qcom/lpass-cpu.c                         |    5 +-
 sound/soc/qcom/sdm845.c                            |    4 +-
 sound/soc/qcom/sm8250.c                            |    4 +-
 sound/soc/sof/intel/hda-dai.c                      |    7 +-
 sound/usb/line6/driver.c                           |    3 +-
 sound/usb/line6/midi.c                             |    6 +-
 sound/usb/line6/midibuf.c                          |   25 +-
 sound/usb/line6/midibuf.h                          |    5 +-
 sound/usb/line6/pod.c                              |    3 +-
 sound/usb/pcm.c                                    |   11 +-
 tools/arch/parisc/include/uapi/asm/mman.h          |   12 +-
 tools/gpio/gpio-event-mon.c                        |    1 +
 tools/include/linux/kernel.h                       |    2 +
 tools/include/nolibc/arch-aarch64.h                |  199 +++
 tools/include/nolibc/arch-arm.h                    |  204 +++
 tools/include/nolibc/arch-i386.h                   |  196 +++
 tools/include/nolibc/arch-mips.h                   |  217 ++++
 tools/include/nolibc/arch-riscv.h                  |  204 +++
 tools/include/nolibc/arch-x86_64.h                 |  215 ++++
 tools/include/nolibc/arch.h                        |   32 +
 tools/include/nolibc/nolibc.h                      | 1331 +-------------------
 tools/include/nolibc/std.h                         |   49 +
 tools/include/nolibc/types.h                       |  133 ++
 tools/objtool/Makefile                             |    4 +-
 tools/objtool/check.c                              |    5 +-
 tools/perf/bench/bench.h                           |   12 -
 tools/perf/builtin-trace.c                         |    2 +
 tools/perf/util/auxtrace.c                         |    2 +-
 tools/perf/util/bpf_counter.h                      |    6 +
 tools/perf/util/cgroup.c                           |   23 +-
 tools/perf/util/data.c                             |    2 +
 tools/perf/util/dwarf-aux.c                        |   23 +-
 tools/testing/ktest/ktest.pl                       |   23 +-
 tools/testing/selftests/Makefile                   |   26 +-
 tools/testing/selftests/bpf/config                 |    4 -
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |   48 -
 tools/testing/selftests/bpf/progs/test_bpf_nf.c    |  109 --
 tools/testing/selftests/kselftest.h                |   19 +
 tools/testing/selftests/kselftest_harness.h        |    2 +
 tools/testing/selftests/kvm/rseq_test.c            |    2 +-
 tools/testing/selftests/lib.mk                     |    5 +
 .../testing/selftests/net/af_unix/test_unix_oob.c  |    2 +-
 tools/testing/selftests/net/toeplitz.c             |   12 +-
 tools/testing/selftests/vm/mremap_test.c           |    1 -
 tools/testing/selftests/vm/pkey-helpers.h          |    3 +-
 tools/testing/selftests/vm/pkey-x86.h              |   12 +
 tools/testing/selftests/vm/protection_keys.c       |  131 +-
 tools/testing/selftests/vm/va_128TBswitch.c        |    2 +-
 tools/virtio/vringh_test.c                         |    2 +
 780 files changed, 8947 insertions(+), 5245 deletions(-)
---
