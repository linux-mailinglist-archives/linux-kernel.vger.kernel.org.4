Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A11B62A1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKOTXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKOTXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:23:36 -0500
Received: from mail.nearlyone.de (unknown [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578382704;
        Tue, 15 Nov 2022 11:23:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FF35E2DD6;
        Tue, 15 Nov 2022 20:23:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1668540206; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=UKc81oejH6jSyQp/4k2e5IVxri52yurz5iRZMEU5ovk=;
        b=OXtFbI2Wg7qXyNZ8MpbkJO/UA6RtRzQPCQs8uZbYzqArxT4ldAiQAGYeA3CCxCDMLwGC3L
        szoE9o7Bp/F0UvZjNWZ3u35TckV6Z7Xn0z6jnvuWoUmf5OF4YkIm3eHhXztRswvBYU+rPT
        h/iyj60SwkVx5FhoUn2122gQekzT+pyP9RdyUV53Ky/VO/jppbW6xcVb9P+FT1PYKVY+Vz
        EEqm0uUSKuptYJhxWZnlnm0P6PitNh7pJuFztPk8DIIwBd9LNQMPY1OSb+ivnPcub/L/M0
        H0bW7nSv/LzefsWPS3/Pu4ypOTyUy8MiBP3TwaYuLcZZ1sZDIeUS29+uR84jVA==
Date:   Tue, 15 Nov 2022 20:23:23 +0100
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
Subject: [ANNOUNCE] 4.19.265-rt117
Message-ID: <166854006259.24541.4596790484383932698@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.265-rt117 stable release.

No RT specific changes. Just updating to the latest stable version.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 1d1fc2230e99c617cc811a66e23eb6f52a937d11

Or to build 4.19.265-rt117 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.265.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.265-rt117.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.261-rt116:
---

Aaron Conole (1):
      openvswitch: switch from WARN to pr_warn

Adrian Hunter (2):
      perf intel-pt: Fix segfault in intel_pt_print_info() with uClibc
      perf auxtrace: Fix address filter symbol name match for modules

Albert Briscoe (1):
      usb: gadget: function: fix dangling pnp_string in f_printer.c

Alexander Aring (3):
      fs: dlm: fix race between test_bit() and queue_work()
      fs: dlm: handle -EBUSY first in lock arg validation
      net: ieee802154: return -EINVAL for unknown addr type

Alexander Coffin (1):
      wifi: brcmfmac: fix use-after-free bug in brcmf_netdev_start_xmit()

Alexander Potapenko (1):
      tipc: fix an information leak in tipc_topsrv_kern_subscr

Alexander Stein (7):
      ARM: dts: imx6q: add missing properties for sram
      ARM: dts: imx6dl: add missing properties for sram
      ARM: dts: imx6qp: add missing properties for sram
      ARM: dts: imx6sl: add missing properties for sram
      ARM: dts: imx6sll: add missing properties for sram
      ARM: dts: imx6sx: add missing properties for sram
      ata: ahci-imx: Fix MODULE_ALIAS

Alvin Šipraga (1):
      drm: bridge: adv7511: fix CEC power down control register offset

Andreas Pape (1):
      ALSA: dmaengine: increment buffer pointer atomically

Andrew Bresticker (1):
      riscv: Allow PROT_WRITE-only mmap()

Andrew Gaul (1):
      r8152: Rate limit overflow messages

Andri Yngvason (1):
      HID: multitouch: Add memory barriers

Anna Schumaker (1):
      NFSD: Return nfserr_serverfault if splice_ok but buf->pages have data

Anssi Hannula (5):
      can: kvaser_usb: Fix use of uninitialized completion
      can: kvaser_usb_leaf: Fix overread with an invalid command
      can: kvaser_usb_leaf: Fix TX queue out of sync after restart
      can: kvaser_usb_leaf: Fix CAN state after restart
      can: kvaser_usb: Fix possible completions during init_completion

Ard Biesheuvel (2):
      efi: libstub: drop pointless get_memory_map() call
      efi: random: reduce seed size to 32 bytes

Arvid Norlander (1):
      ACPI: video: Add Toshiba Satellite/Portege Z830 quirk

Aurelien Jarno (1):
      riscv: fix build with binutils 2.38

Baokun Li (1):
      ext4: fix null-ptr-deref in ext4_write_info

Biju Das (1):
      can: rcar_canfd: rcar_canfd_handle_global_receive(): fix IRQ storm on global FIFO receive

Bitterblue Smith (2):
      wifi: rtl8xxxu: Fix skb misuse in TX queue selection
      wifi: rtl8xxxu: gen2: Fix mistake in path B IQ calibration

Borislav Petkov (1):
      x86/microcode/AMD: Apply the patch early on every logical thread

Brian Norris (1):
      mmc: core: Terminate infinite loop in SD-UHS voltage switch

Bryan O'Donoghue (1):
      media: venus: dec: Handle the case where find_format fails

Callum Osmotherly (1):
      ALSA: hda/realtek: remove ALC289_FIXUP_DUAL_SPK for Dell 5530

Cameron Gutman (1):
      Input: xpad - fix wireless 360 controller breaking after suspend

ChanWoo Lee (1):
      mmc: core: Replace with already defined values for readability

Chao Qin (1):
      powercap: intel_rapl: fix UBSAN shift-out-of-bounds issue

Chen Zhongjin (3):
      x86/unwind/orc: Fix unreliable stack dump with gcov
      net: dsa: Fix possible memory leaks in dsa_loop_init()
      net, neigh: Fix null-ptr-deref in neigh_table_clear()

Chen-Yu Tsai (1):
      media: v4l2-mem2mem: Apply DST_QUEUE_OFF_BASE on MMAP buffers across ioctls

Christian A. Ehrhardt (1):
      kernfs: fix use-after-free in __kernfs_remove

Christophe JAILLET (7):
      spi: mt7621: Fix an error message in mt7621_spi_probe()
      mmc: au1xmmc: Fix an error handling path in au1xmmc_probe()
      mmc: wmt-sdmmc: Fix an error handling path in wmt_mci_probe()
      mfd: intel_soc_pmic: Fix an error handling path in intel_soc_pmic_i2c_probe()
      mfd: fsl-imx25: Fix an error handling path in mx25_tsadc_setup_irq()
      mfd: lp8788: Fix an error handling path in lp8788_probe()
      mfd: lp8788: Fix an error handling path in lp8788_irq_init() and lp8788_irq_init()

Claudiu Beznea (2):
      iio: adc: at91-sama5d2_adc: fix AT91_SAMA5D2_MR_TRACKTIM_MAX
      iio: adc: at91-sama5d2_adc: check return status for pressure and touch

Cristian Marussi (1):
      firmware: arm_scmi: Add SCMI PM driver remove routine

Dan Carpenter (6):
      wifi: rtl8xxxu: tighten bounds checking in rtl8xxxu_read_efuse()
      drivers: serial: jsm: fix some leaks in probe
      iommu/omap: Fix buffer overflow in debugfs
      crypto: cavium - prevent integer overflow loading firmware
      RDMA/qedr: clean up work queue on failure in qedr_alloc_resources()
      net: sched: Fix use after free in red_enqueue()

Daniel Golle (4):
      wifi: rt2x00: don't run Rt5592 IQ calibration on MT7620
      wifi: rt2x00: set correct TX_SW_CFG1 MAC register for MT7620
      wifi: rt2x00: set SoC wmac clock register
      wifi: rt2x00: correctly set BBP register 86 for MT7620

Daniel Wagner (2):
      Merge tag 'v4.19.265' into v4.19-rt
      Linux 4.19.265-rt117

Dave Jiang (1):
      dmaengine: ioat: stop mod_timer from resurrecting deleted timer in __cleanup()

David Collins (1):
      spmi: pmic-arb: correct duplicate APID to PPID mapping logic

David Gow (1):
      drm/amd/display: fix overflow on MIN_I64 definition

David Sterba (1):
      btrfs: fix type of parameter generation in btrfs_get_dentry

Dmitry Baryshkov (1):
      drm/msm/dpu: index dpu_kms->hw_vbif using vbif_idx

Dmitry Torokhov (2):
      ARM: dts: exynos: correct s5k6a3 reset polarity on Midas family
      ARM: dts: exynos: fix polarity of VBUS GPIO of Origen

Dokyung Song (1):
      wifi: brcmfmac: Fix potential buffer overflow in brcmf_fweh_event_worker()

Dongliang Mu (4):
      fs: fix UAF/GPF bug in nilfs_mdt_destroy
      phy: qualcomm: call clk_disable_unprepare in the error handling
      usb: idmouse: fix an uninit-value in idmouse_open
      can: mscan: mpc5xxx: mpc5xxx_can_probe(): add missing put_clock() in error path

Duoming Zhou (1):
      mISDN: fix use-after-free bugs in l1oip timer handlers

Eric Dumazet (5):
      once: add DO_ONCE_SLOW() for sleepable contexts
      tcp: annotate data-race around tcp_md5sig_pool_populated
      inet: fully convert sk->sk_rx_dst to RCU rules
      kcm: annotate data-races around kcm->rx_psock
      kcm: annotate data-races around kcm->rx_wait

Eric Ren (1):
      KVM: arm64: vgic: Fix exit condition in scan_its_table()

Filipe Manana (5):
      btrfs: fix race between quota enable and quota rescan ioctl
      btrfs: fix processing of delayed data refs during backref walking
      btrfs: fix processing of delayed tree block refs during backref walking
      btrfs: fix inode list leak during backref walking at resolve_indirect_refs()
      btrfs: fix ulist leaks in error paths of qgroup self tests

Frank Wunderlich (1):
      USB: serial: qcserial: add new usb-id for Dell branded EM7455

Gaosheng Cui (2):
      net: mdio: fix undefined behavior in bit shift for __mdiobus_register
      capabilities: fix potential memleak on error path from vfs_getxattr_alloc()

Gaurav Kohli (1):
      hv_netvsc: Fix race between VF offering and VF association message from host

Geert Uytterhoeven (1):
      ARM: Drop CMDLINE_* dependency on ATAGS

Greg Kroah-Hartman (6):
      selinux: use "grep -E" instead of "egrep"
      Linux 4.19.262
      once: fix section mismatch on clang builds
      Linux 4.19.263
      Linux 4.19.264
      Linux 4.19.265

Guilherme G. Piccoli (1):
      firmware: google: Test spinlock on panic path to avoid lockups

Haibo Chen (1):
      ARM: dts: imx7d-sdb: config the max pressure for tsc2046

Haimin Zhang (1):
      net/ieee802154: fix uninit value bug in dgram_sendmsg

Hannu Hartikainen (1):
      USB: add RESET_RESUME quirk for NVIDIA Jetson devices in RCM

Hans Verkuil (7):
      media: vivid: s_fbuf: add more sanity checks
      media: vivid: dev->bitmap_cap wasn't freed in all cases
      media: v4l2-dv-timings: add sanity checks for blanking values
      media: videodev2.h: V4L2_DV_BT_BLANKING_HEIGHT should check 'interlaced'
      media: s5p_cec: limit msg.len to CEC_MAX_MSG_SIZE
      media: cros-ec-cec: limit msg.len to CEC_MAX_MSG_SIZE
      media: dvb-frontends/drxk: initialize err to 0

Hans de Goede (3):
      platform/x86: msi-laptop: Fix old-ec check for backlight registering
      platform/x86: msi-laptop: Fix resource cleanup
      platform/x86: msi-laptop: Change DMI match / alias strings to fix module autoloading

Hari Chandrakanthan (1):
      wifi: mac80211: allow bw change during channel switch in mesh

Heiko Carstens (1):
      s390/futex: add missing EX_TABLE entry to __futex_atomic_op()

Helge Deller (4):
      parisc: fbdev/stifb: Align graphics memory size to 4MB
      parisc: Make 8250_gsc driver dependend on CONFIG_PARISC
      parisc: Export iosapic_serial_irq() symbol for serial port driver
      parisc: Avoid printing the hardware path twice

Hu Weiwen (1):
      ceph: don't truncate file in atomic_open

Huacai Chen (1):
      UM: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Hyong Youb Kim (1):
      net/mlx5e: Do not increment ESN when updating IPsec ESN state

Hyunwoo Kim (3):
      fbdev: smscufx: Fix use-after-free in ufx_ops_open()
      HID: roccat: Fix use-after-free in roccat_read()
      fbdev: smscufx: Fix several use-after-free bugs

Jack Wang (2):
      HSI: omap_ssi_port: Fix dma_map_sg error check
      mailbox: bcm-ferxrm-mailbox: Fix error check for dma_map_sg

James Morse (1):
      arm64: errata: Remove AES hwcap for COMPAT tasks

Jan Beulich (1):
      Xen/gntdev: don't ignore kernel unmapping error

Jan Kara (1):
      ext4: avoid crash when inline data creation follows DIO write

Jason A. Donenfeld (6):
      random: clamp credited irq bits to maximum mixed
      random: restore O_NONBLOCK support
      random: avoid reading two cache lines on irq randomness
      random: use expired timer rather than wq for mixing fast pool
      ALSA: au88x0: use explicitly signed char
      ipvs: use explicitly signed chars

Javier Martinez Canillas (2):
      drm: Use size_t type for len variable in drm_copy_field()
      drm: Prevent drm_copy_field() to attempt copying a NULL pointer

Jean-Francois Le Fillatre (2):
      usb: add quirks for Lenovo OneLink+ Dock
      r8152: add PID for the Lenovo OneLink+ Dock

Jens Glathe (1):
      usb: xhci: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a V0.96 controller

Jerry Lee 李修賢 (1):
      ext4: continue to expand file system when the target size doesn't reach

Jerry Snitselaar (1):
      iommu/vt-d: Clean up si_domain in the init_dmars() error path

Jianglei Nie (2):
      bnx2x: fix potential memory leak in bnx2x_tpa_stop()
      usb: host: xhci: Fix potential memory leak in xhci_alloc_stream_info()

Jiasheng Jiang (2):
      fsi: core: Check error number after calling ida_simple_get
      mfd: sm501: Add check for platform_driver_register()

Jim Cromie (2):
      dyndbg: fix module.dyndbg handling
      dyndbg: let query-modname override actual module name

Jim Mattson (1):
      KVM: x86: Mask off reserved bits in CPUID.80000008H

Jinke Han (1):
      ext4: place buffer head allocation before handle start

Johan Hovold (3):
      USB: serial: ftdi_sio: fix 300 bps rate for SIO
      drm/msm/dsi: fix memory corruption with too many bridges
      drm/msm/hdmi: fix memory corruption with too many bridges

Johannes Berg (1):
      wifi: mac80211_hwsim: avoid mac80211 warning on bad rate

John Veness (1):
      ALSA: usb-audio: Add quirks for MacroSilicon MS2100/MS2106 devices

Jonathan Cameron (1):
      iio: ABI: Fix wrong format of differential capacitance channel ABI.

Joseph Qi (2):
      ocfs2: clear dinode links count in case of error
      ocfs2: fix BUG when iput after ocfs2_mknod fails

José Expósito (1):
      HID: magicmouse: Do not set BTN_MOUSE on double report

Junichi Uekawa (1):
      vhost/vsock: Use kvmalloc/kvfree for larger packets.

Justin Chen (1):
      usb: bdc: change state when port disconnected

Kai-Heng Feng (1):
      ata: ahci: Match EM_MAX_SLOTS with SATA_PMP_MAX_PORTS

Kees Cook (2):
      sh: machvec: Use char[] for section boundaries
      MIPS: BCM47XX: Cast memcmp() of function to (void *)

Keith Busch (1):
      nvme: copy firmware_rev on each init

Khalid Masum (1):
      xfrm: Update ipcomp_scratches with NULL when freed

Krzysztof Kozlowski (1):
      rpmsg: qcom: glink: replace strncpy() with strscpy_pad()

Kuniyuki Iwashima (1):
      tcp/udp: Make early_demux back namespacified.

Lalith Rajendran (1):
      ext4: make ext4_lazyinit_thread freezable

Lam Thai (1):
      bpftool: Fix a wrong type cast in btf_dumper_int

Lee Jones (1):
      bpf: Ensure correct locking around vulnerable function find_vpid()

Letu Ren (2):
      scsi: qedf: Fix a UAF bug in __qedf_probe()
      scsi: 3w-9xxx: Avoid disabling device if failing to enable it

Li Qiang (1):
      kprobe: reverse kp->flags when arm_kprobe failed

Liang He (9):
      ASoC: eureka-tlv320: Hold reference returned from of_find_xxx API
      memory: of: Fix refcount leak bug in of_get_ddr_timings()
      soc: qcom: smsm: Fix refcount leak bugs in qcom_smsm_probe()
      soc: qcom: smem_state: Add refcounting for the 'state->of_node'
      clk: oxnas: Hold reference returned by of_get_parent()
      clk: berlin: Add of_node_put() for of_get_parent()
      media: exynos4-is: fimc-is: Add of_node_put() when breaking out of loop
      powerpc/sysdev/fsl_msi: Add missing of_node_put()
      powerpc/pci_dn: Add missing of_node_put()

Linus Torvalds (1):
      scsi: stex: Properly zero out the passthrough command structure

Linus Walleij (1):
      regulator: qcom_rpm: Fix circular deferral regression

Liu Jian (1):
      net: If sock is dead don't access sock's sk_wq in sk_stream_wait_memory

Logan Gunthorpe (2):
      md/raid5: Ensure stripe_fill happens on non-read IO with journal
      md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d

Lorenz Bauer (1):
      bpf: btf: fix truncated last_member_type_id in btf_struct_resolve

Luiz Augusto von Dentz (3):
      Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
      Bluetooth: L2CAP: Fix user-after-free
      Bluetooth: L2CAP: Fix attempting to access uninitialized memory

Lukas Straub (2):
      um: Cleanup syscall_handler_t cast in syscalls_32.h
      um: Cleanup compiler warning in arch/x86/um/tls_32.c

M. Vefa Bicakci (1):
      xen/gntdev: Prevent leaking grants

Maciej W. Rozycki (1):
      PCI: Sanitise firmware BAR assignments behind a PCI-PCI bridge

Marek Behún (1):
      ARM: dts: turris-omnia: Fix mpp26 pin name and comment

Mario Limonciello (2):
      xhci: Don't show warning for reinit on known broken suspend
      PM: hibernate: Allow hybrid sleep to work with s2idle

Mark Tomlinson (1):
      tipc: Fix recognition of trial period

Martin Liska (1):
      gcov: support GCC 12.1 and newer compilers

Martin Tůma (1):
      i2c: xiic: Add platform module alias

Masahiro Yamada (1):
      linux/bits.h: make BIT(), GENMASK(), and friends available in assembly

Mateusz Kwiatkowski (1):
      drm/vc4: vec: Fix timings for VEC modes

Mathias Nyman (1):
      xhci: Remove device endpoints from bandwidth list when freeing the device

Matthew Ma (1):
      mmc: core: Fix kernel panic when remove non-standard SDIO card

Matti Vaittinen (1):
      tools: iio: iio_utils: fix digit calculation

Maxim Levitsky (3):
      KVM: x86: emulator: em_sysexit should update ctxt->mode
      KVM: x86: emulator: introduce emulator_recalc_and_set_mode
      KVM: x86: emulator: update the emulation mode after CR0 write

Maxim Mikityanskiy (1):
      Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu

Maxime Ripard (2):
      drm/mipi-dsi: Detach devices when removing the host
      clk: bcm2835: Make peripheral PLLC critical

Maya Matuszczyk (1):
      drm: panel-orientation-quirks: Add quirk for Anbernic Win600

Miaoqian Lin (6):
      clk: tegra: Fix refcount leak in tegra210_clock_init
      clk: tegra: Fix refcount leak in tegra114_clock_init
      clk: tegra20: Fix refcount leak in tegra20_clock_init
      HSI: omap_ssi: Fix refcount leak in ssi_probe
      media: xilinx: vipp: Fix refcount leak in xvip_graph_dma_init
      clk: ti: dra7-atl: Fix reference leak in of_dra7_atl_clk_probe

Michael Hennerich (1):
      iio: dac: ad5593r: Fix i2c read protocol requirements

Michael Walle (2):
      ARM: dts: kirkwood: lsxl: fix serial line
      ARM: dts: kirkwood: lsxl: remove first ethernet port

Michal Luczaj (1):
      KVM: x86/emulator: Fix handing of POP SS to correctly set interruptibility

Mike Pattrick (2):
      openvswitch: Fix double reporting of drops in dropwatch
      openvswitch: Fix overreporting of drops in dropwatch

Miquel Raynal (1):
      mac802154: Fix LQI recording

Nam Cao (2):
      staging: vt6655: fix some erroneous memory clean-up loops
      staging: vt6655: fix potential memory leak

Nathan Chancellor (1):
      powerpc/math_emu/efp: Include module.h

Nathan Huckleberry (1):
      drm/msm: Fix return type of mdp4_lvds_connector_mode_valid

Neal Cardwell (2):
      tcp: fix tcp_cwnd_validate() to not forget is_cwnd_limited
      tcp: fix indefinite deferral of RTO with SACK reneging

Nicholas Piggin (1):
      powerpc/64s: Fix GENERIC_CPU build flags for PPC970 / G5

Nick Desaulniers (1):
      Makefile.debug: re-enable debug info for .S files

Niklas Cassel (4):
      ata: fix ata_id_sense_reporting_enabled() and ata_id_has_sense_reporting()
      ata: fix ata_id_has_devslp()
      ata: fix ata_id_has_ncq_autosense()
      ata: fix ata_id_has_dipm()

Nuno Sá (1):
      iio: inkern: only release the device node when done with it

Pali Rohár (2):
      serial: 8250: Fix restoring termios speed after suspend
      powerpc: Fix SPE Power ISA properties for e500v1 platforms

Pavel Rojtberg (1):
      Input: xpad - add supported devices as contributed on github

Phil Sutter (1):
      netfilter: nft_fib: Fix for rpath check with VRF devices

Rafael J. Wysocki (1):
      thermal: intel_powerclamp: Use first online CPU as control_cpu

Raju Rangoju (2):
      amd-xgbe: fix the SFP compliance codes check for DAC cables
      amd-xgbe: add the bit rate quirk for Molex cables

Randy Dunlap (1):
      arc: iounmap() arg is volatile

Rik van Riel (2):
      livepatch: fix race between fork and KLP transition
      mm,hugetlb: take hugetlb_lock before decrementing h->resv_huge_pages

Robin Guo (1):
      usb: musb: Fix musb_gadget.c rxstate overflow bug

Robin Murphy (1):
      iommu/iova: Fix module config properly

Russell King (1):
      ARM: fix function graph tracer and unwinder dependencies

Russell King (Oracle) (1):
      net: mvpp2: fix mvpp2 debugfs leak

Rustam Subkhankulov (1):
      platform/chrome: fix double-free in chromeos_laptop_prepare()

Ryusuke Konishi (4):
      nilfs2: fix NULL pointer dereference at nilfs_bmap_lookup_at_level()
      nilfs2: fix leak of nilfs_root in case of writer thread creation failure
      nilfs2: replace WARN_ONs by nilfs_error for checkpoint acquisition failure
      nilfs2: fix use-after-free bug of struct nilfs_root

Sami Tolvanen (1):
      Makefile.extrawarn: Move -Wcast-function-type-strict to W=1

Samuel Bailey (1):
      HID: saitek: add madcatz variant of MMO7 mouse device ID

Sasha Levin (1):
      Revert "fs: check FMODE_LSEEK to control internal pipe splicing"

Saurabh Sengar (1):
      md: Replace snprintf with scnprintf

Sean Christopherson (1):
      KVM: nVMX: Unconditionally purge queued/injected events on nested "exit"

Serge Semin (1):
      ata: libahci_platform: Sanity check the DT child nodes number

Sergei Antonov (1):
      ARM: dts: fix Moxa SDIO 'compatible', remove 'sdhci' misnomer

Sergey Shtylyov (1):
      ata: pata_legacy: fix pdc20230_set_piomode()

Seth Jenkins (1):
      mm: /proc/pid/smaps_rollup: fix no vma's null-deref

Shang XiaoJing (2):
      nfc: s3fwrn5: Fix potential memory leak in s3fwrn5_nci_send()
      nfc: nfcmrvl: Fix potential memory leak in nfcmrvl_i2c_nci_send()

Shigeru Yoshida (1):
      nbd: Fix hung when signal interrupts nbd_start_device_ioctl()

Shreeya Patel (1):
      iio: light: tsl2583: Fix module unloading

Shuah Khan (1):
      docs: update mediator information in CoC docs

Shubhrajyoti Datta (1):
      tty: xilinx_uartps: Fix the ignore_status

Slawomir Laba (2):
      i40e: Fix ethtool rx-flow-hash setting for X722
      i40e: Fix flow-type by setting GL_HASH_INSET registers

Srinivas Pandruvada (1):
      thermal: intel_powerclamp: Use get_cpu() instead of smp_processor_id() to avoid crash

Stefan Wahren (1):
      clk: bcm2835: fix bcm2835_clock_rate_from_divisor declaration

Steven Rostedt (Google) (4):
      ring-buffer: Allow splice to read previous partially read pages
      ring-buffer: Check pending waiters when doing wake ups as well
      ring-buffer: Fix race between reset page and reading page
      ALSA: Use del_timer_sync() before freeing timer

Sudeep Holla (1):
      PM: domains: Fix handling of unavailable/disabled idle states

Swati Agarwal (2):
      dmaengine: xilinx_dma: cleanup for fetching xlnx,num-fstores property
      dmaengine: xilinx_dma: Report error in case of dma_set_mask_and_coherent API failure

Sylwester Dziedziuch (1):
      i40e: Fix VF hang when reset is triggered on another VF

Tadeusz Struk (1):
      usb: mon: make mmapped memory read only

Takashi Iwai (6):
      ALSA: hda: Fix position reporting on Poulsbo
      ALSA: oss: Fix potential deadlock at unregistration
      ALSA: rawmidi: Drop register_mutex in snd_rawmidi_free()
      ALSA: usb-audio: Fix potential memory leaks
      ALSA: usb-audio: Fix NULL dererence at error path
      ALSA: aoa: Fix I2S device accounting

Tetsuo Handa (4):
      net: rds: don't hold sock lock when cancelling work from rds_tcp_reset_callbacks()
      wifi: ath9k: avoid uninit memory read in ath9k_htc_rx_msg()
      Bluetooth: L2CAP: initialize delayed works at l2cap_chan_create()
      net/ieee802154: don't warn zero-sized raw_sendmsg()

Thinh Nguyen (2):
      usb: dwc3: gadget: Stop processing more requests on IMI
      usb: dwc3: gadget: Don't set IMI for no_interrupt

Tony Luck (1):
      ACPI: extlog: Handle multiple records

Trond Myklebust (2):
      NFSv4.1: Handle RECLAIM_COMPLETE trunking errors
      NFSv4.1: We must always send RECLAIM_COMPLETE after a reboot

Tudor Ambarus (1):
      mtd: rawnand: atmel: Unmap streaming DMA mappings

Vincent Whitchurch (1):
      spi: s3c64xx: Fix large transfers with DMA

Vitaly Kuznetsov (1):
      x86/hyperv: Fix 'struct hv_enlightened_vmcs' definition

Wei Yongjun (2):
      power: supply: adp5061: fix out-of-bounds read in adp5061_get_chg_type()
      net: ieee802154: fix error return code in dgram_bind()

Wen Gong (1):
      wifi: ath10k: add peer map clean up for peer delete in ath10k_sta_state()

Werner Sembach (1):
      ACPI: video: Force backlight native for more TongFang devices

William Dean (1):
      mtd: devices: docg3: check the return value of devm_ioremap() in the probe

Wright Feng (1):
      wifi: brcmfmac: fix invalid address access when enabling SCAN log level

Xiaobo Liu (1):
      net/atm: fix proc_mpc_write incorrect return value

Xin Long (2):
      sctp: handle the error returned from sctp_auth_asoc_init_active_key
      tipc: fix a null-ptr-deref in tipc_topsrv_accept

Xu Qiang (2):
      spi: qup: add missing clk_disable_unprepare on error in spi_qup_resume()
      spi: qup: add missing clk_disable_unprepare on error in spi_qup_pm_resume_runtime()

Yang Yingliang (8):
      net: hns: fix possible memory leak in hnae_ae_register()
      ALSA: ac97: fix possible memory leak in snd_ac97_dev_register()
      net: netsec: fix error handling in netsec_register_mdio()
      net: ksz884x: fix missing pci_disable_device() on error in pcidev_init()
      ALSA: aoa: i2sbus: fix possible memory leak in i2sbus_add_dev()
      net: ehea: fix possible memory leak in ehea_register_port()
      mISDN: fix possible memory leak in mISDN_register_device()
      isdn: mISDN: netjet: fix wrong check of device registration

Ye Bin (1):
      ext4: fix warning in 'ext4_da_release_space'

Yu Kuai (1):
      block, bfq: protect 'bfqd->queued' by 'bfqd->lock'

Zhang Changzhong (2):
      net: lantiq_etop: don't free skb when returning NETDEV_TX_BUSY
      net: fec: fix improper use of NETDEV_TX_BUSY

Zhang Qilong (6):
      spi/omap100k:Fix PM disable depth imbalance in omap1_spi100k_probe
      ASoC: wm8997: Fix PM disable depth imbalance in wm8997_probe
      ASoC: wm5110: Fix PM disable depth imbalance in wm5110_probe
      ASoC: wm5102: Fix PM disable depth imbalance in wm5102_probe
      f2fs: fix race condition on setting FI_NO_EXTENT flag
      rose: Fix NULL pointer dereference in rose_send_frame()

Zhang Rui (1):
      hwmon/coretemp: Handle large core ID value

Zhang Xiaoxu (1):
      nfs4: Fix kmemleak when allocate slot failed

Zheng Yejian (2):
      ftrace: Properly unset FTRACE_HASH_FL_MOD
      tracing/histogram: Update document for KEYS_MAX size

Zheng Yongjun (2):
      net: fs_enet: Fix wrong check in do_pd_setup
      powerpc/powernv: add missing of_node_put() in opal_export_attrs()

Zhengchao Shao (6):
      net: sched: cake: fix null pointer access issue when cake_init() fails
      net: fix UAF issue in nfqnl_nf_hook_drop() when ops_init() failed
      ipvs: fix WARNING in __ip_vs_cleanup_batch()
      ipvs: fix WARNING in ip_vs_app_net_cleanup()
      Bluetooth: L2CAP: fix use-after-free in l2cap_conn_del()
      ipv6: fix WARNING in ip6_route_net_exit_late()

Zheyu Ma (2):
      drm/bridge: megachips: Fix a null pointer dereference bug
      media: cx88: Fix a null-ptr-deref bug in buffer_prepare()

Zhihao Cheng (1):
      quota: Check next/prev free block number after reading from quota file

Zhu Yanjun (2):
      RDMA/rxe: Fix "kernel NULL pointer dereference" error
      RDMA/rxe: Fix the error caused by qp->sk

Ziyang Xuan (2):
      can: bcm: check the result of can_send() in bcm_can_tx()
      net: tun: fix bugs for oversize packet when napi frags enabled

hongao (1):
      drm/amdgpu: fix initial connector audio value

sunghwan jung (1):
      Revert "usb: storage: Add quirk for Samsung Fit flash"
---
Documentation/ABI/testing/sysfs-bus-iio            |   2 +-
 Documentation/arm64/silicon-errata.txt             |   2 +
 .../devicetree/bindings/dma/moxa,moxart-dma.txt    |   4 +-
 .../process/code-of-conduct-interpretation.rst     |   2 +-
 Documentation/trace/histogram.rst                  |   2 +-
 Makefile                                           |   6 +-
 arch/arc/include/asm/io.h                          |   2 +-
 arch/arc/mm/ioremap.c                              |   2 +-
 arch/arm/Kconfig                                   |   3 +-
 arch/arm/Kconfig.debug                             |   6 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts      |   4 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi            |   2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |   2 +-
 arch/arm/boot/dts/imx6dl.dtsi                      |   3 +
 arch/arm/boot/dts/imx6q.dtsi                       |   3 +
 arch/arm/boot/dts/imx6qp.dtsi                      |   6 ++
 arch/arm/boot/dts/imx6sl.dtsi                      |   3 +
 arch/arm/boot/dts/imx6sll.dtsi                     |   3 +
 arch/arm/boot/dts/imx6sx.dtsi                      |   6 ++
 arch/arm/boot/dts/imx7d-sdb.dts                    |   7 +-
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |  16 +---
 arch/arm/boot/dts/moxart-uc7112lx.dts              |   2 +-
 arch/arm/boot/dts/moxart.dtsi                      |   4 +-
 arch/arm64/Kconfig                                 |  16 ++++
 arch/arm64/include/asm/cpucaps.h                   |   3 +-
 arch/arm64/kernel/cpu_errata.c                     |  17 ++++
 arch/arm64/kernel/cpufeature.c                     |  13 ++-
 arch/mips/bcm47xx/prom.c                           |   4 +-
 arch/parisc/include/asm/hardware.h                 |  12 +--
 arch/parisc/kernel/drivers.c                       |  14 ++-
 arch/powerpc/Makefile                              |   2 +-
 arch/powerpc/boot/dts/fsl/e500v1_power_isa.dtsi    |  51 ++++++++++
 arch/powerpc/boot/dts/fsl/mpc8540ads.dts           |   2 +-
 arch/powerpc/boot/dts/fsl/mpc8541cds.dts           |   2 +-
 arch/powerpc/boot/dts/fsl/mpc8555cds.dts           |   2 +-
 arch/powerpc/boot/dts/fsl/mpc8560ads.dts           |   2 +-
 arch/powerpc/kernel/pci_dn.c                       |   1 +
 arch/powerpc/math-emu/math_efp.c                   |   1 +
 arch/powerpc/platforms/powernv/opal.c              |   1 +
 arch/powerpc/sysdev/fsl_msi.c                      |   2 +
 arch/riscv/Makefile                                |  11 ++-
 arch/riscv/kernel/sys_riscv.c                      |   3 -
 arch/s390/include/asm/futex.h                      |   3 +-
 arch/sh/include/asm/sections.h                     |   2 +-
 arch/sh/kernel/machvec.c                           |  10 +-
 arch/um/kernel/um_arch.c                           |   2 +-
 arch/x86/include/asm/hyperv-tlfs.h                 |   4 +-
 arch/x86/kernel/cpu/microcode/amd.c                |  16 +++-
 arch/x86/kernel/unwind_orc.c                       |   2 +-
 arch/x86/kvm/cpuid.c                               |   1 +
 arch/x86/kvm/emulate.c                             | 104 +++++++++++++++------
 arch/x86/kvm/vmx.c                                 |  19 ++--
 arch/x86/um/shared/sysdep/syscalls_32.h            |   5 +-
 arch/x86/um/tls_32.c                               |   6 --
 block/bfq-iosched.c                                |   4 +-
 drivers/acpi/acpi_extlog.c                         |  33 ++++---
 drivers/acpi/acpi_video.c                          |  16 ++++
 drivers/acpi/video_detect.c                        |  64 +++++++++++++
 drivers/ata/ahci.h                                 |   2 +-
 drivers/ata/ahci_imx.c                             |   2 +-
 drivers/ata/libahci_platform.c                     |  14 ++-
 drivers/ata/pata_legacy.c                          |   5 +-
 drivers/base/power/domain.c                        |   4 +
 drivers/block/nbd.c                                |   6 +-
 drivers/char/mem.c                                 |   4 +-
 drivers/char/random.c                              |  25 +++--
 drivers/clk/bcm/clk-bcm2835.c                      |   8 +-
 drivers/clk/berlin/bg2.c                           |   5 +-
 drivers/clk/berlin/bg2q.c                          |   6 +-
 drivers/clk/clk-oxnas.c                            |   6 +-
 drivers/clk/tegra/clk-tegra114.c                   |   1 +
 drivers/clk/tegra/clk-tegra20.c                    |   1 +
 drivers/clk/tegra/clk-tegra210.c                   |   1 +
 drivers/clk/ti/clk-dra7-atl.c                      |   9 +-
 drivers/crypto/cavium/cpt/cptpf_main.c             |   6 +-
 drivers/dma/ioat/dma.c                             |   6 +-
 drivers/dma/xilinx/xilinx_dma.c                    |   8 +-
 drivers/firmware/arm_scmi/scmi_pm_domain.c         |  20 ++++
 drivers/firmware/efi/efi.c                         |   2 +-
 drivers/firmware/efi/libstub/fdt.c                 |   8 --
 drivers/firmware/google/gsmi.c                     |   9 ++
 drivers/fsi/fsi-core.c                             |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   7 +-
 drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c    |   6 +-
 drivers/gpu/drm/bridge/adv7511/adv7511.h           |   5 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_cec.c       |   4 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |   4 +-
 drivers/gpu/drm/drm_ioctl.c                        |   8 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   1 +
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   6 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  12 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           |  29 +++---
 .../gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c    |   5 +-
 drivers/gpu/drm/msm/dsi/dsi.c                      |   6 ++
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |   5 +
 drivers/gpu/drm/vc4/vc4_vec.c                      |   4 +-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-magicmouse.c                       |   2 +-
 drivers/hid/hid-multitouch.c                       |   8 +-
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/hid/hid-roccat.c                           |   4 +
 drivers/hid/hid-saitek.c                           |   2 +
 drivers/hsi/controllers/omap_ssi_core.c            |   1 +
 drivers/hsi/controllers/omap_ssi_port.c            |   8 +-
 drivers/hwmon/coretemp.c                           |  56 ++++++++---
 drivers/i2c/busses/i2c-xiic.c                      |   1 +
 drivers/iio/adc/at91-sama5d2_adc.c                 |  10 +-
 drivers/iio/dac/ad5593r.c                          |  46 +++++----
 drivers/iio/inkern.c                               |   6 +-
 drivers/iio/light/tsl2583.c                        |   2 +-
 drivers/infiniband/hw/qedr/main.c                  |   9 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |  10 +-
 drivers/input/joystick/xpad.c                      |  20 +++-
 drivers/iommu/intel-iommu.c                        |   5 +
 drivers/iommu/omap-iommu-debug.c                   |   6 +-
 drivers/isdn/hardware/mISDN/netjet.c               |   2 +-
 drivers/isdn/mISDN/core.c                          |   5 +-
 drivers/isdn/mISDN/l1oip.h                         |   1 +
 drivers/isdn/mISDN/l1oip_core.c                    |  13 +--
 drivers/mailbox/bcm-flexrm-mailbox.c               |   8 +-
 drivers/md/raid0.c                                 |   4 +-
 drivers/md/raid5.c                                 |  14 ++-
 drivers/media/dvb-frontends/drxk_hard.c            |   2 +-
 drivers/media/pci/cx88/cx88-vbi.c                  |   9 +-
 drivers/media/pci/cx88/cx88-video.c                |  43 ++++-----
 drivers/media/platform/cros-ec-cec/cros-ec-cec.c   |   2 +
 drivers/media/platform/exynos4-is/fimc-is.c        |   1 +
 drivers/media/platform/qcom/venus/vdec.c           |   2 +
 drivers/media/platform/s5p-cec/s5p_cec.c           |   2 +
 drivers/media/platform/vivid/vivid-core.c          |  22 +++++
 drivers/media/platform/vivid/vivid-core.h          |   2 +
 drivers/media/platform/vivid/vivid-vid-cap.c       |  27 ++++--
 drivers/media/platform/xilinx/xilinx-vipp.c        |   9 +-
 drivers/media/v4l2-core/v4l2-dv-timings.c          |  14 +++
 drivers/media/v4l2-core/v4l2-mem2mem.c             |  62 ++++++++----
 drivers/memory/of_memory.c                         |   1 +
 drivers/mfd/fsl-imx25-tsadc.c                      |  32 +++++--
 drivers/mfd/intel_soc_pmic_core.c                  |   1 +
 drivers/mfd/lp8788-irq.c                           |   3 +
 drivers/mfd/lp8788.c                               |  12 ++-
 drivers/mfd/sm501.c                                |   7 +-
 drivers/mmc/core/sd.c                              |   3 +-
 drivers/mmc/core/sdio_bus.c                        |   3 +-
 drivers/mmc/host/au1xmmc.c                         |   3 +-
 drivers/mmc/host/wmt-sdmmc.c                       |   5 +-
 drivers/mtd/devices/docg3.c                        |   7 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c       |   1 +
 drivers/net/can/mscan/mpc5xxx_can.c                |   8 +-
 drivers/net/can/rcar/rcar_canfd.c                  |   6 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |   2 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   3 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |   6 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |  83 +++++++++++++++-
 drivers/net/dsa/dsa_loop.c                         |  25 +++--
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |  17 +++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   1 +
 drivers/net/ethernet/freescale/fec_main.c          |   4 +-
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c   |   2 +-
 drivers/net/ethernet/hisilicon/hns/hnae.c          |   4 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c          |   1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 100 ++++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   4 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  43 ++++++---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   1 +
 drivers/net/ethernet/lantiq_etop.c                 |   1 -
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |   1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c |  10 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  13 ++-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   3 -
 drivers/net/ethernet/micrel/ksz884x.c              |   2 +-
 drivers/net/ethernet/socionext/netsec.c            |   2 +
 drivers/net/hyperv/hyperv_net.h                    |   3 +
 drivers/net/hyperv/netvsc.c                        |   4 +
 drivers/net/hyperv/netvsc_drv.c                    |  20 ++++
 drivers/net/phy/mdio_bus.c                         |   2 +-
 drivers/net/tun.c                                  |   3 +-
 drivers/net/usb/cdc_ether.c                        |   7 ++
 drivers/net/usb/r8152.c                            |   5 +-
 drivers/net/wireless/ath/ath10k/mac.c              |  54 ++++++-----
 drivers/net/wireless/ath/ath9k/htc_hst.c           |  43 ++++++---
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |   4 +
 .../net/wireless/broadcom/brcm80211/brcmfmac/pno.c |  12 +--
 drivers/net/wireless/mac80211_hwsim.c              |   2 +
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |  31 +++++-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |  21 +++--
 drivers/nfc/nfcmrvl/i2c.c                          |   7 +-
 drivers/nfc/s3fwrn5/core.c                         |   8 +-
 drivers/nvme/host/core.c                           |   3 +-
 drivers/parisc/iosapic.c                           |   1 +
 drivers/pci/setup-res.c                            |  11 +++
 drivers/phy/qualcomm/phy-qcom-usb-hsic.c           |   6 +-
 drivers/platform/chrome/chromeos_laptop.c          |  24 ++---
 drivers/platform/x86/msi-laptop.c                  |  14 +--
 drivers/power/supply/adp5061.c                     |   6 +-
 drivers/powercap/intel_rapl.c                      |   3 +
 drivers/regulator/qcom_rpm-regulator.c             |  24 ++---
 drivers/rpmsg/qcom_glink_native.c                  |   2 +-
 drivers/rpmsg/qcom_smd.c                           |   4 +-
 drivers/scsi/3w-9xxx.c                             |   2 +-
 drivers/scsi/qedf/qedf_main.c                      |   5 -
 drivers/scsi/stex.c                                |  17 ++--
 drivers/soc/qcom/smem_state.c                      |   3 +-
 drivers/soc/qcom/smsm.c                            |  20 ++--
 drivers/spi/spi-omap-100k.c                        |   1 +
 drivers/spi/spi-qup.c                              |  21 ++++-
 drivers/spi/spi-s3c64xx.c                          |   9 ++
 drivers/spmi/spmi-pmic-arb.c                       |  13 +--
 drivers/staging/mt7621-spi/spi-mt7621.c            |   8 +-
 drivers/staging/vt6655/device_main.c               |   8 +-
 drivers/thermal/intel_powerclamp.c                 |   4 +-
 drivers/tty/serial/8250/8250_port.c                |   7 +-
 drivers/tty/serial/8250/Kconfig                    |   2 +-
 drivers/tty/serial/jsm/jsm_driver.c                |   3 +-
 drivers/tty/serial/xilinx_uartps.c                 |   2 +
 drivers/usb/core/quirks.c                          |  13 +++
 drivers/usb/dwc3/gadget.c                          |   8 +-
 drivers/usb/gadget/function/f_printer.c            |  12 +--
 drivers/usb/gadget/udc/bdc/bdc_udc.c               |   1 +
 drivers/usb/host/xhci-mem.c                        |  27 ++++--
 drivers/usb/host/xhci-pci.c                        |   8 +-
 drivers/usb/host/xhci.c                            |   3 +-
 drivers/usb/misc/idmouse.c                         |   8 +-
 drivers/usb/mon/mon_bin.c                          |   5 +
 drivers/usb/musb/musb_gadget.c                     |   3 +
 drivers/usb/serial/ftdi_sio.c                      |   3 +-
 drivers/usb/serial/qcserial.c                      |   1 +
 drivers/usb/storage/unusual_devs.h                 |   6 --
 drivers/vhost/vsock.c                              |   2 +-
 drivers/video/fbdev/smscufx.c                      |  69 ++++++++------
 drivers/video/fbdev/stifb.c                        |   2 +-
 drivers/xen/gntdev.c                               |  30 +++++-
 fs/btrfs/backref.c                                 |  82 +++++++++-------
 fs/btrfs/export.c                                  |   2 +-
 fs/btrfs/export.h                                  |   2 +-
 fs/btrfs/qgroup.c                                  |  15 +++
 fs/btrfs/tests/qgroup-tests.c                      |  20 +++-
 fs/ceph/file.c                                     |  10 +-
 fs/dlm/ast.c                                       |   6 +-
 fs/dlm/lock.c                                      |  16 ++--
 fs/ext4/file.c                                     |   6 ++
 fs/ext4/inode.c                                    |   7 ++
 fs/ext4/migrate.c                                  |   3 +-
 fs/ext4/resize.c                                   |   2 +-
 fs/ext4/super.c                                    |   3 +-
 fs/f2fs/extent_cache.c                             |   3 +-
 fs/inode.c                                         |   7 +-
 fs/kernfs/dir.c                                    |   5 +-
 fs/nfs/nfs4client.c                                |   1 +
 fs/nfs/nfs4state.c                                 |   2 +
 fs/nfsd/nfs4xdr.c                                  |   2 +-
 fs/nilfs2/inode.c                                  |  20 +++-
 fs/nilfs2/segment.c                                |  21 +++--
 fs/ocfs2/namei.c                                   |  23 +++--
 fs/proc/task_mmu.c                                 |   2 +-
 fs/quota/quota_tree.c                              |  38 ++++++++
 fs/splice.c                                        |  10 +-
 include/linux/ata.h                                |  39 ++++----
 include/linux/bits.h                               |  17 ++--
 include/linux/dynamic_debug.h                      |   2 +-
 include/linux/efi.h                                |   2 +-
 include/linux/iova.h                               |   2 +-
 include/linux/once.h                               |  28 ++++++
 include/linux/tcp.h                                |   2 +-
 include/net/ieee802154_netdev.h                    |  43 +++++++++
 include/net/protocol.h                             |   4 -
 include/net/sock.h                                 |   2 +-
 include/net/tcp.h                                  |   7 +-
 include/net/udp.h                                  |   1 +
 include/scsi/scsi_cmnd.h                           |   2 +-
 include/uapi/linux/videodev2.h                     |   3 +-
 kernel/bpf/btf.c                                   |   2 +-
 kernel/bpf/syscall.c                               |   2 +
 kernel/gcov/gcc_4_7.c                              |  18 +++-
 kernel/kprobes.c                                   |   5 +-
 kernel/livepatch/transition.c                      |  18 +++-
 kernel/power/hibernate.c                           |   2 +-
 kernel/trace/ftrace.c                              |   8 +-
 kernel/trace/ring_buffer.c                         |  46 ++++++++-
 lib/dynamic_debug.c                                |  11 ++-
 lib/once.c                                         |  30 ++++++
 localversion-rt                                    |   2 +-
 mm/hugetlb.c                                       |   2 +-
 net/atm/mpoa_proc.c                                |   3 +-
 net/bluetooth/hci_sysfs.c                          |   3 +
 net/bluetooth/l2cap_core.c                         |  69 +++++++++++---
 net/can/bcm.c                                      |   7 +-
 net/core/neighbour.c                               |   2 +-
 net/core/net_namespace.c                           |   7 ++
 net/core/stream.c                                  |   3 +-
 net/ieee802154/socket.c                            |  50 ++++++----
 net/ipv4/af_inet.c                                 |  16 +---
 net/ipv4/inet_hashtables.c                         |   4 +-
 net/ipv4/ip_input.c                                |  32 ++++---
 net/ipv4/netfilter/nft_fib_ipv4.c                  |   3 +
 net/ipv4/sysctl_net_ipv4.c                         |  59 +-----------
 net/ipv4/tcp.c                                     |  19 ++--
 net/ipv4/tcp_input.c                               |   5 +-
 net/ipv4/tcp_ipv4.c                                |  11 ++-
 net/ipv4/tcp_output.c                              |  19 ++--
 net/ipv4/udp.c                                     |   6 +-
 net/ipv6/ip6_input.c                               |  23 +++--
 net/ipv6/netfilter/nft_fib_ipv6.c                  |   6 +-
 net/ipv6/route.c                                   |  14 ++-
 net/ipv6/tcp_ipv6.c                                |  20 ++--
 net/ipv6/udp.c                                     |  13 +--
 net/kcm/kcmsock.c                                  |  23 +++--
 net/mac80211/cfg.c                                 |   3 -
 net/mac802154/rx.c                                 |   5 +-
 net/netfilter/ipvs/ip_vs_app.c                     |  10 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |  30 ++++--
 net/openvswitch/datapath.c                         |  21 +++--
 net/rds/tcp.c                                      |   2 +-
 net/rose/rose_link.c                               |   3 +
 net/sched/sch_cake.c                               |   4 +
 net/sched/sch_red.c                                |   4 +-
 net/sctp/auth.c                                    |  18 +++-
 net/tipc/discover.c                                |   2 +-
 net/tipc/topsrv.c                                  |  18 +++-
 net/vmw_vsock/virtio_transport_common.c            |   2 +-
 net/xfrm/xfrm_ipcomp.c                             |   1 +
 scripts/Makefile.extrawarn                         |   1 +
 scripts/selinux/install_policy.sh                  |   2 +-
 security/commoncap.c                               |   6 +-
 sound/aoa/soundbus/i2sbus/core.c                   |   7 +-
 sound/core/pcm_dmaengine.c                         |   8 +-
 sound/core/rawmidi.c                               |   2 -
 sound/core/sound_oss.c                             |  13 ++-
 sound/pci/ac97/ac97_codec.c                        |   1 +
 sound/pci/au88x0/au88x0.h                          |   6 +-
 sound/pci/au88x0/au88x0_core.c                     |   2 +-
 sound/pci/hda/hda_intel.c                          |   3 +-
 sound/pci/hda/patch_realtek.c                      |   1 -
 sound/soc/codecs/wm5102.c                          |   6 +-
 sound/soc/codecs/wm5110.c                          |   6 +-
 sound/soc/codecs/wm8997.c                          |   6 +-
 sound/soc/fsl/eukrea-tlv320.c                      |   8 +-
 sound/synth/emux/emux.c                            |   7 +-
 sound/usb/endpoint.c                               |   6 +-
 sound/usb/quirks-table.h                           |  58 ++++++++++++
 sound/usb/quirks.c                                 |   1 +
 tools/bpf/bpftool/btf_dumper.c                     |   2 +-
 tools/iio/iio_utils.c                              |   4 +
 tools/perf/util/auxtrace.c                         |  10 +-
 tools/perf/util/intel-pt.c                         |   9 +-
 virt/kvm/arm/vgic/vgic-its.c                       |   5 +-
 346 files changed, 2571 insertions(+), 1077 deletions(-)
