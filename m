Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50077632D14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiKUTjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKUTjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:39:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C7AFCE4;
        Mon, 21 Nov 2022 11:39:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 868B6B815D5;
        Mon, 21 Nov 2022 19:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E430CC433D6;
        Mon, 21 Nov 2022 19:39:38 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.79-rt54
Date:   Mon, 21 Nov 2022 00:49:23 -0000
Message-ID: <166899176391.293670.6029334078792426266@puck.lan>
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
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.79-rt54 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: e73aaf859af25a2d456366a8ab20ec0b0f209707

Or to build 5.15.79-rt54 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.79.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.79-rt54.patch.xz


Enjoy!
Clark

Changes from v5.15.76-rt53:
---

Aaron Conole (1):
      openvswitch: switch from WARN to pr_warn

Aaron Lewis (1):
      KVM: x86: Protect the unused bits in MSR exiting flags

Adrian Hunter (1):
      perf auxtrace: Fix address filter symbol name match for modules

Alex Barba (1):
      bnxt_en: fix potentially incorrect return value for ndo_rx_flow_steer

Alex Sierra (1):
      drm/amdkfd: avoid recursive lock in migrations back to RAM

Alexander Graf (2):
      KVM: x86: Copy filter arg outside kvm_vm_ioctl_set_msr_filter()
      KVM: x86: Add compat handler for KVM_X86_SET_MSR_FILTER

Alexander Potapenko (1):
      ipv6: addrlabel: fix infoleak when sending struct ifaddrlblmsg to network

Alexander Stein (1):
      media: v4l2: Fix v4l2_i2c_subdev_set_name function documentation

Anders Roxell (1):
      marvell: octeontx2: build error: unknown type name 'u64'

Ankit Nautiyal (1):
      drm/i915/dp: Reset frl trained flag before restarting FRL training

Anssi Hannula (1):
      can: kvaser_usb: Fix possible completions during init_completion

Antoine Tenart (2):
      net: phy: mscc: macsec: clear encryption keys when freeing a flow
      net: atlantic: macsec: clear encryption keys from the stack

Ard Biesheuvel (3):
      efi: random: reduce seed size to 32 bytes
      efi: random: Use 'ACPI reclaim' memory for random seed
      arm64: efi: Fix handling of misaligned runtime regions and drop warning

Arend van Spriel (1):
      wifi: cfg80211: fix memory leak in query_regdb_file()

Ashish Kalra (1):
      ACPI: APEI: Fix integer overflow in ghes_estatus_pool_init()

Athira Rajeev (1):
      perf stat: Fix printing os->prefix in CSV metrics output

Aya Levin (1):
      net/mlx5e: Extend SKB room check to include PTP-SQ

Baolin Wang (1):
      mm/hugetlb: fix races when looking up a CONT-PTE/PMD size hugetlb page

Benjamin Coddington (2):
      NFSv4: Fix free of uninitialized nfs4_label on referral lookup.
      NFSv4.2: Fixup CLONE dest file size for zero-length count

Bernd Edlinger (1):
      exec: Copy oldsighand->action under spin-lock

Biju Das (2):
      can: rcar_canfd: fix channel specific IRQ handling for RZ/G2L
      can: rcar_canfd: rcar_canfd_handle_global_receive(): fix IRQ storm on global FIFO receive

Borislav Petkov (1):
      x86/cpu: Restore AMD's DE_CFG MSR after resume

Brian Norris (8):
      mmc: sdhci_am654: 'select', not 'depends' REGMAP_MMIO
      drm/rockchip: dsi: Clean up 'usage_mode' when failing to attach
      drm/rockchip: dsi: Force synchronous probe
      mmc: cqhci: Provide helper for resetting both SDHCI and CQHCI
      mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for CQHCI
      mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
      mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
      mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI

Chen Zhongjin (7):
      x86/unwind/orc: Fix unreliable stack dump with gcov
      net: dsa: Fix possible memory leaks in dsa_loop_init()
      RDMA/core: Fix null-ptr-deref in ib_core_cleanup()
      net/smc: Fix possible leaked pernet namespace in smc_init()
      net, neigh: Fix null-ptr-deref in neigh_table_clear()
      block: Fix possible memory leak for rq_wb on add_disk failure
      i2c: piix4: Fix adapter not be removed in piix4_remove()

Christian A. Ehrhardt (1):
      kernfs: fix use-after-free in __kernfs_remove

Christian Löhle (1):
      mmc: block: Remove error check of hw_reset on reset

Christophe JAILLET (1):
      dmaengine: mv_xor_v2: Fix a resource leak in mv_xor_v2_remove()

Chuang Wang (1):
      net: macvlan: fix memory leaks of macvlan_common_newlink

Clark Williams (2):
      Merge tag 'v5.15.79' into v5.15-rt
      'Linux 5.15.79-rt54'

Colin Ian King (1):
      net: broadcom: bcm4908enet: remove redundant variable bytes

Cong Wang (1):
      bpf, sock_map: Move cancel_work_sync() out of sock lock

Conor Dooley (1):
      riscv: fix reserved memory setup

Cosmin Tanislav (1):
      iio: temperature: ltc2983: allocate iio channels once

Cristian Marussi (4):
      firmware: arm_scmi: Suppress the driver's bind attributes
      firmware: arm_scmi: Make Rx chan_setup fail on memory errors
      firmware: arm_scmi: Fix devres allocation device in virtio transport
      arm64: dts: juno: Add thermal critical trip points

D Scott Phillips (1):
      arm64: Add AMPERE1 to the Spectre-BHB affected list

Dan Carpenter (4):
      media: atomisp: prevent integer overflow in sh_css_set_black_frame()
      RDMA/qedr: clean up work queue on failure in qedr_alloc_resources()
      net: sched: Fix use after free in red_enqueue()
      phy: stm32: fix an error code in probe

Dan Vacura (1):
      usb: gadget: uvc: fix sg handling in error case

Daniel Thompson (1):
      drm/msm/hdmi: Remove spurious IRQF_ONESHOT flag

Danijel Slivka (1):
      drm/amdgpu: set vm_update_mode=0 as default for Sienna Cichlid in SRIOV case

David Sterba (1):
      btrfs: fix type of parameter generation in btrfs_get_dentry

Dean Luick (1):
      IB/hfi1: Correctly move list in sc_disable()

Dexuan Cui (1):
      vsock: fix possible infinite sleep in vsock_connectible_wait_data()

Dokyung Song (1):
      wifi: brcmfmac: Fix potential buffer overflow in brcmf_fweh_event_worker()

Dongliang Mu (2):
      can: mscan: mpc5xxx: mpc5xxx_can_probe(): add missing put_clock() in error path
      can: mcp251x: mcp251x_can_probe(): add missing unregister_candev() in error path

Donglin Peng (1):
      perf tools: Add the include/perf/ directory to .gitignore

Doug Brown (1):
      dmaengine: pxa_dma: use platform_get_irq_optional

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Add Positivo C6300 model quirk

Emanuele Giuseppe Esposito (1):
      KVM: VMX: fully disable SGX if SECONDARY_EXEC_ENCLS_EXITING unavailable

Eric Biggers (2):
      fscrypt: stop using keyrings subsystem for fscrypt_master_key
      fscrypt: fix keyring memory leak on mount failure

Eric Dumazet (7):
      kcm: annotate data-races around kcm->rx_psock
      kcm: annotate data-races around kcm->rx_wait
      tcp: minor optimization in tcp_add_backlog()
      ipv6: ensure sane device mtu in tunnels
      net: do not sense pfmemalloc status in skb_append_pagefrags()
      kcm: do not sense pfmemalloc status in kcm_sendpage()
      net: tun: call napi_schedule_prep() to ensure we own a napi

Evan Quan (1):
      ALSA: hda/hdmi - enable runtime pm for more AMD display audio

Filipe Manana (4):
      btrfs: fix inode list leak during backref walking at resolve_indirect_refs()
      btrfs: fix inode list leak during backref walking at find_parent_nodes()
      btrfs: fix ulist leaks in error paths of qgroup self tests
      btrfs: fix lost file sync on direct IO write with nowait and dsync iocb

Florian Fainelli (1):
      net: bcmsysport: Indicate MAC is in charge of PHY PM

Gaosheng Cui (3):
      net: mdio: fix undefined behavior in bit shift for __mdiobus_register
      capabilities: fix potential memleak on error path from vfs_getxattr_alloc()
      capabilities: fix undefined behavior in bit shift for CAP_TO_MASK

Gavin Shan (1):
      KVM: selftests: Fix number of pages for memory slot in memslot_modification_stress_test

Geetha sowjanya (1):
      octeontx2-pf: Use hardware register for CQE count

Greg Kroah-Hartman (3):
      Linux 5.15.77
      Linux 5.15.78
      Linux 5.15.79

Guchun Chen (1):
      drm/amdgpu: disable BACO on special BEIGE_GOBY card

HW He (2):
      net: wwan: iosm: fix memory leak in ipc_wwan_dellink
      net: wwan: mhi: fix memory leak in mhi_mbim_dellink

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: use the correct host caps for MMC_CAP_8_BIT_DATA

Hangyu Hua (1):
      media: meson: vdec: fix possible refcount leak in vdec_probe()

Hannu Hartikainen (1):
      USB: add RESET_RESUME quirk for NVIDIA Jetson devices in RCM

Hans Verkuil (8):
      media: vivid: s_fbuf: add more sanity checks
      media: vivid: dev->bitmap_cap wasn't freed in all cases
      media: v4l2-dv-timings: add sanity checks for blanking values
      media: videodev2.h: V4L2_DV_BT_BLANKING_HEIGHT should check 'interlaced'
      media: vivid: set num_in/outputs to 0 if not supported
      media: s5p_cec: limit msg.len to CEC_MAX_MSG_SIZE
      media: cros-ec-cec: limit msg.len to CEC_MAX_MSG_SIZE
      media: dvb-frontends/drxk: initialize err to 0

Hawkins Jiawei (1):
      Bluetooth: L2CAP: Fix memory leak in vhci_write

Heiko Carstens (3):
      s390/futex: add missing EX_TABLE entry to __futex_atomic_op()
      s390/pci: add missing EX_TABLE entries to __pcistg_mio_inuser()/__pcilg_mio_inuser()
      s390/uaccess: add missing EX_TABLE entries to __clear_user()

Helge Deller (5):
      video/fbdev/stifb: Implement the stifb_fillrect() function
      fbdev: stifb: Fall back to cfb_fillrect() on 32-bit HCRX cards
      parisc: Make 8250_gsc driver dependend on CONFIG_PARISC
      parisc: Export iosapic_serial_irq() symbol for serial port driver
      parisc: Avoid printing the hardware path twice

Howard Hsu (1):
      wifi: mac80211: Set TWT Information Frame Disabled bit as 1

Hyong Youb Kim (1):
      net/mlx5e: Do not increment ESN when updating IPsec ESN state

Hyunwoo Kim (1):
      fbdev: smscufx: Fix several use-after-free bugs

Håkon Bugge (1):
      RDMA/cma: Use output interface for net_dev check

Ioana Ciornei (3):
      arm64: dts: lx2160a: specify clock frequencies for the MDIO controllers
      arm64: dts: ls1088a: specify clock frequencies for the MDIO controllers
      arm64: dts: ls208xa: specify clock frequencies for the MDIO controllers

Jakub Kicinski (1):
      net-memcg: avoid stalls when under memory pressure

James Clark (1):
      coresight: cti: Fix hang in cti_disable_hw()

James Smart (9):
      Revert "scsi: lpfc: Resolve some cleanup issues following SLI path refactoring"
      Revert "scsi: lpfc: Fix element offset in __lpfc_sli_release_iocbq_s4()"
      Revert "scsi: lpfc: Fix locking for lpfc_sli_iocbq_lookup()"
      Revert "scsi: lpfc: SLI path split: Refactor SCSI paths"
      Revert "scsi: lpfc: SLI path split: Refactor fast and slow paths to native SLI4"
      Revert "scsi: lpfc: SLI path split: Refactor lpfc_iocbq"
      scsi: lpfc: Adjust bytes received vales during cmf timer interval
      scsi: lpfc: Adjust CMF total bytes and rxmonitor
      scsi: lpfc: Rework MIB Rx Monitor debug info logic

Jason A. Donenfeld (3):
      ALSA: au88x0: use explicitly signed char
      ALSA: rme9652: use explicitly signed char
      ipvs: use explicitly signed chars

Jeff Vanhoof (1):
      usb: gadget: uvc: fix sg handling during video encode

Jens Glathe (1):
      usb: xhci: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a V0.96 controller

Jerry Snitselaar (1):
      efi/tpm: Pass correct address to memblock_reserve

Jiaxun Yang (1):
      MIPS: jump_label: Fix compat branch range check

Jim Mattson (5):
      KVM: x86: Mask off reserved bits in CPUID.80000006H
      KVM: x86: Mask off reserved bits in CPUID.8000001AH
      KVM: x86: Mask off reserved bits in CPUID.80000008H
      KVM: x86: Mask off reserved bits in CPUID.80000001H
      KVM: x86: Mask off reserved bits in CPUID.8000001FH

Jiri Benc (1):
      net: gso: fix panic on frag_list with mixed head alloc types

Jiri Olsa (1):
      x86/syscall: Include asm/ptrace.h in syscall_wrapper header

Jisheng Zhang (2):
      riscv: process: fix kernel info leakage
      riscv: vdso: fix build with llvm

Johan Hovold (4):
      drm/msm/dsi: fix memory corruption with too many bridges
      drm/msm/hdmi: fix memory corruption with too many bridges
      drm/msm/dp: fix IRQ lifetime
      drm/msm/hdmi: fix IRQ lifetime

Johannes Berg (1):
      wifi: cfg80211: silence a sparse RCU warning

Johannes Thumshirn (1):
      btrfs: zoned: initialize device's zone info for seeding

John Fastabend (1):
      bpf: Fix sockmap calling sleepable function in teardown path

John Thomson (1):
      phy: ralink: mt7621-pci: add sentinel to quirks table

Jorge Lopez (1):
      platform/x86: hp_wmi: Fix rfkill causing soft blocked wifi

Josef Bacik (1):
      btrfs: fix tree mod log mishandling of reallocated nodes

Jozsef Kadlecsik (1):
      netfilter: ipset: enforce documented limit to prevent allocating huge memory

Juergen Borleis (1):
      net: fec: limit register access on i.MX6UL

Jussi Laako (1):
      ALSA: usb-audio: Add DSD support for Accuphase DAC-60

Justin Chen (1):
      usb: bdc: change state when port disconnected

Kajol Jain (1):
      perf vendor events power10: Fix hv-24x7 metric events

Kan Liang (3):
      perf/x86/intel: Fix pebs event constraints for ICL
      perf/x86/intel: Add Cooper Lake stepping to isolation_ucodes[]
      perf/x86/intel: Fix pebs event constraints for SPR

Kees Cook (1):
      bpf, verifier: Fix memory leak in array reallocation for stack state

Krzysztof Kozlowski (1):
      hwspinlock: qcom: correct MMIO max register for newer SoCs

Kumar Kartikeya Dwivedi (1):
      bpf: Add helper macro bpf_for_each_reg_in_vstate

Kunihiko Hayashi (1):
      net: ethernet: ave: Fix MAC to be in charge of PHY PM

Kuniyuki Iwashima (3):
      tcp/udp: Fix memory leak in ipv6_renew_options().
      af_unix: Fix memory leaks of the whole sk due to OOB skb.
      tcp/udp: Make early_demux back namespacified.

Laurent Pinchart (4):
      media: rkisp1: Don't pass the quantization to rkisp1_csm_config()
      media: rkisp1: Initialize color space on resizer sink and source pads
      media: rkisp1: Use correct macro for gradient registers
      media: rkisp1: Zero v4l2_subdev_format fields in when validating links

Li Huafei (1):
      ftrace: Fix use-after-free for dynamic ftrace_ops

Li Qiang (1):
      kprobe: reverse kp->flags when arm_kprobe failed

Li Zetao (1):
      fs/binfmt_elf: Fix memory leak in load_elf_binary()

Lin Shengwang (1):
      sched/core: Fix comparison in sched_group_cookie_match()

Lino Sanfilippo (1):
      serial: core: move RS485 configuration tasks from drivers into core

Linus Torvalds (1):
      cert host tools: Stop complaining about deprecated OpenSSL functions

Linus Walleij (1):
      mtd: parsers: bcm47xxpart: Fix halfblock reads

Liu Peibao (1):
      stmmac: dwmac-loongson: fix invalid mdio_node

Liu Shixin (1):
      btrfs: fix match incorrectly in dev_args_match_device

Lu Wei (2):
      tcp: fix a signed-integer-overflow bug in tcp_add_backlog()
      tcp: prohibit TCP_REPAIR_OPTIONS if data was already sent

Luiz Augusto von Dentz (2):
      Bluetooth: L2CAP: Fix accepting connection request for invalid SPSM
      Bluetooth: L2CAP: Fix attempting to access uninitialized memory

Lukas Wunner (2):
      serial: Deassert Transmit Enable on probe in driver-specific way
      serial: ar933x: Deassert Transmit Enable on ->rs485_config()

Luís Henriques (1):
      ext4: fix BUG_ON() when directory entry has invalid rec_len

M Chetan Kumar (1):
      net: wwan: iosm: fix memory leak in ipc_pcie_read_bios_cfg

Manish Rangankar (1):
      scsi: qla2xxx: Use transport-defined speed mask for supported_speeds

Mario Limonciello (2):
      xhci-pci: Set runtime PM as default policy on all xHC 1.2 or later devices
      PM: hibernate: Allow hybrid sleep to work with s2idle

Mark Rutland (1):
      arm64: entry: avoid kprobe recursion

Martin Tůma (1):
      i2c: xiic: Add platform module alias

Mathias Nyman (2):
      xhci: Add quirk to reset host back to default state at shutdown
      xhci: Remove device endpoints from bandwidth list when freeing the device

Matthew Auld (1):
      drm/i915/dmabuf: fix sg_table handling in map_dma_buf

Matthew Ma (1):
      mmc: core: Fix kernel panic when remove non-standard SDIO card

Matthew Wilcox (Oracle) (1):
      ext4,f2fs: fix readahead of verity data

Matti Vaittinen (2):
      tools: iio: iio_utils: fix digit calculation
      iio: adxl372: Fix unsafe buffer attributes

Maxim Levitsky (5):
      perf/x86/intel/lbr: Use setup_clear_cpu_cap() instead of clear_cpu_cap()
      KVM: x86: emulator: em_sysexit should update ctxt->mode
      KVM: x86: emulator: introduce emulator_recalc_and_set_mode
      KVM: x86: emulator: update the emulation mode after rsm
      KVM: x86: emulator: update the emulation mode after CR0 write

Maxim Mikityanskiy (1):
      Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu

Michael Chan (1):
      bnxt_en: Fix possible crash in bnxt_hwrm_set_coal()

Mika Westerberg (1):
      thunderbolt: Tear down existing tunnels when resuming from hibernate

Miklos Szeredi (2):
      fuse: add file_modified() to fallocate
      fuse: fix readdir cache race

Miquel Raynal (1):
      mac802154: Fix LQI recording

Nathan Chancellor (1):
      vmlinux.lds.h: Fix placement of '.data..decrypted' section

Nathan Huckleberry (1):
      drm/msm: Fix return type of mdp4_lvds_connector_mode_valid

Neal Cardwell (1):
      tcp: fix indefinite deferral of RTO with SACK reneging

Nick Child (1):
      ibmvnic: Free rwi on reset success

Nico Boehr (1):
      KVM: s390: pv: don't allow userspace to set the clock under PV

Nicolas Dichtel (1):
      nh: fix scope used to find saddr when adding non gw nh

Oliver Hartkopp (1):
      can: j1939: j1939_send_one(): fix missing CAN header initialization

Pablo Neira Ayuso (2):
      netfilter: nf_tables: netlink notifier might race to release objects
      netfilter: nf_tables: release flow rule object from commit path

Pankaj Gupta (1):
      mm/memremap.c: map FS_DAX device memory as decrypted

Patrick Thompson (1):
      mmc: sdhci-pci-core: Disable ES for ASUS BIOS on Jasper Lake

Pavel Kozlov (1):
      ARC: mm: fix leakage of memory allocated for PTE

Peng Fan (1):
      arm64: dts: imx8: correct clock order

Peter Oberparleiter (2):
      s390/boot: add secure boot trailer
      s390/cio: fix out-of-bounds access on cio_ignore free

Peter Xu (1):
      mm/shmem: use page_mapping() to detect page cache for uffd continue

Peter Zijlstra (1):
      perf: Fix missing SIGTRAPs

Philip Yang (2):
      drm/amdkfd: handle CPU fault on COW mapping
      drm/amdkfd: Migrate in CPU page fault use current mm

Prike Liang (1):
      drm/amdgpu: disallow gfxoff until GC IP blocks complete s2idle resume

Pu Lehui (1):
      bpftool: Fix NULL pointer dereference when pin {PROG, MAP, LINK} without FILE

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Read all MSRs on the target CPU
      cpufreq: intel_pstate: hybrid: Use known scaling factor for P-cores

Rafael Mendonca (1):
      drm/amdkfd: Fix memory leak in kfd_mem_dmamap_userptr()

Rafał Miłecki (2):
      net: broadcom: bcm4908_enet: update TX stats after actual transmission
      mtd: parsers: bcm47xxpart: print correct offset on read error

Raju Rangoju (2):
      amd-xgbe: fix the SFP compliance codes check for DAC cables
      amd-xgbe: add the bit rate quirk for Molex cables

Randy Dunlap (1):
      arc: iounmap() arg is volatile

Rasmus Villemoes (2):
      tools/nolibc/string: Fix memcmp() implementation
      net: stmmac: dwmac-meson8b: fix meson8b_devm_clk_prepare_enable()

Ratheesh Kannoth (1):
      octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]

Roderick Colenbrander (1):
      HID: playstation: add initial DualSense Edge controller support

Roi Dayan (1):
      net/mlx5e: E-Switch, Fix comparing termination table instance

Ronnie Sahlberg (1):
      cifs: fix regression in very old smb1 mounts

Roy Novich (2):
      net/mlx5: Update fw fatal reporter state on PCI handlers successful recover
      net/mlx5: Allow async trigger completion execution on single CPU systems

Ryan Roberts (1):
      KVM: arm64: Fix bad dereference on MTE-enabled systems

Ryusuke Konishi (2):
      nilfs2: fix deadlock in nilfs_count_free_blocks()
      nilfs2: fix use-after-free bug of ns_writer on remount

Sabrina Dubroca (4):
      macsec: delete new rxsc when offload fails
      macsec: fix secy->n_rx_sc accounting
      macsec: fix detection of RXSCs when toggling offloading
      macsec: clear encryption keys from the stack after setting up offload

Saeed Mahameed (1):
      net/mlx5: Print more info on pci error handlers

Sakari Ailus (1):
      media: v4l: subdev: Fail graciously when getting try data for NULL state

Samuel Bailey (1):
      HID: saitek: add madcatz variant of MMO7 mouse device ID

Sanjay R Mehta (1):
      thunderbolt: Add DP OUT resource when DP tunnel is discovered

Sascha Hauer (1):
      mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on 8bit bus

Scott Mayhew (1):
      NFSv4: Add an fattr allocation to _nfs4_discover_trunking()

Sean Anderson (1):
      net: fman: Unregister ethernet device on removal

Sean Christopherson (2):
      KVM: x86: Trace re-injected exceptions
      KVM: x86: Treat #DBs from the emulator as fault-like (code and DR7.GD=1)

SeongJae Park (1):
      mm/damon/dbgfs: check if rm_contexts input is for a real context

Sergey Shtylyov (1):
      ata: pata_legacy: fix pdc20230_set_piomode()

Sergiu Moga (1):
      net: macb: Specify PHY PM management done by MAC

Shang XiaoJing (7):
      nfc: virtual_ncidev: Fix memory leak in virtual_nci_send()
      perf vendor events arm64: Fix incorrect Hisi hip08 L3 metrics
      nfc: fdp: Fix potential memory leak in fdp_nci_send()
      nfc: nxp-nci: Fix potential memory leak in nxp_nci_send()
      nfc: s3fwrn5: Fix potential memory leak in s3fwrn5_nci_send()
      nfc: nfcmrvl: Fix potential memory leak in nfcmrvl_i2c_nci_send()
      tracing: kprobe: Fix memory leak in test_gen_kprobe/kretprobe_cmd()

Shigeru Yoshida (1):
      netfilter: Cleanup nft_net->module_list from nf_tables_exit_net()

Shin'ichiro Kawasaki (1):
      ata: libata-scsi: fix SYNCHRONIZE CACHE (16) command failure

Shirish S (1):
      drm/amd/display: explicitly disable psr_feature_enable appropriately

Shreeya Patel (1):
      iio: light: tsl2583: Fix module unloading

Siarhei Volkau (1):
      pinctrl: Ingenic: JZ4755 bug fixes

Slawomir Laba (2):
      i40e: Fix ethtool rx-flow-hash setting for X722
      i40e: Fix flow-type by setting GL_HASH_INSET registers

Soenke Huster (1):
      Bluetooth: virtio_bt: Use skb_put to set length

Srinivas Kandagatla (2):
      soundwire: qcom: reinit broadcast completion
      soundwire: qcom: check for outanding writes before doing a read

Srinivasa Rao Mandadapu (2):
      ASoC: qcom: lpass-cpu: mark HDMI TX registers as volatile
      ASoC: qcom: lpass-cpu: Mark HDMI TX parity register as volatile

Steven Rostedt (Google) (2):
      ALSA: Use del_timer_sync() before freeing timer
      ring-buffer: Check for NULL cpu_buffer in ring_buffer_wake_waiters()

Sudeep Holla (1):
      PM: domains: Fix handling of unavailable/disabled idle states

Sumit Garg (1):
      tee: Fix tee_shm_register() for kernel TEE drivers

Suresh Devarakonda (1):
      net/mlx5: Fix crash during sync firmware reset

Sylwester Dziedziuch (1):
      i40e: Fix VF hang when reset is triggered on another VF

Takashi Iwai (4):
      ALSA: usb-audio: Add quirks for M-Audio Fast Track C400/600
      ALSA: aoa: Fix I2S device accounting
      ALSA: usb-audio: Yet more regression for for the delayed card registration
      ALSA: usb-audio: Add quirk entry for M-Audio Micro

Tan, Tee Min (1):
      stmmac: intel: Update PCH PTP clock rate from 200MHz to 204.8MHz

Taniya Das (1):
      clk: qcom: Update the force mem core bit for GPU clocks

Tariq Toukan (1):
      net/mlx5: Fix possible use-after-free in async command interface

Thinh Nguyen (2):
      usb: dwc3: gadget: Stop processing more requests on IMI
      usb: dwc3: gadget: Don't set IMI for no_interrupt

Tim Harvey (1):
      ARM: dts: imx6qdl-gw59{10,13}: fix user pushbutton GPIO offset

Tony O'Brien (1):
      mtd: rawnand: marvell: Use correct logic for nand-keep-config

Trond Myklebust (3):
      NFSv4: Fix a potential state reclaim deadlock
      NFSv4.1: Handle RECLAIM_COMPLETE trunking errors
      NFSv4.1: We must always send RECLAIM_COMPLETE after a reboot

Tudor Ambarus (15):
      dmaengine: at_hdmac: Fix at_lli struct definition
      dmaengine: at_hdmac: Don't start transactions at tx_submit level
      dmaengine: at_hdmac: Start transfer for cyclic channels in issue_pending
      dmaengine: at_hdmac: Fix premature completion of desc in issue_pending
      dmaengine: at_hdmac: Do not call the complete callback on device_terminate_all
      dmaengine: at_hdmac: Protect atchan->status with the channel lock
      dmaengine: at_hdmac: Fix concurrency problems by removing atc_complete_all()
      dmaengine: at_hdmac: Fix concurrency over descriptor
      dmaengine: at_hdmac: Free the memset buf without holding the chan lock
      dmaengine: at_hdmac: Fix concurrency over the active list
      dmaengine: at_hdmac: Fix descriptor handling when issuing it to hardware
      dmaengine: at_hdmac: Fix completion of unissued descriptor in case of errors
      dmaengine: at_hdmac: Don't allow CPU to reorder channel enable
      dmaengine: at_hdmac: Fix impossible condition
      dmaengine: at_hdmac: Check return code of dma_async_device_register

Uday Shankar (1):
      scsi: core: Restrict legal sdev_state transitions via sysfs

Ville Syrjälä (2):
      drm/i915/sdvo: Filter out invalid outputs more sensibly
      drm/i915/sdvo: Setup DDC fully before output init

Vineeth Vijayan (1):
      s390/cio: derive cdev information only for IO-subchannels

Vlad Buslov (1):
      net/mlx5: Bridge, verify LAG state when adding bond to bridge

Vladimir Oltean (2):
      net: enetc: survive memory pressure without crashing
      net: dsa: fall back to default tagger if we can't load the one from DT

Wang Yufen (3):
      bpf, sockmap: Fix the sk->sk_forward_alloc warning of sk_stream_kill_queues
      bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues
      net: tun: Fix memory leaks of napi_get_frags

Wei Yongjun (2):
      net: ieee802154: fix error return code in dgram_bind()
      mctp: Fix an error handling path in mctp_init()

Wen Gong (1):
      wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()

Wenpeng Liang (1):
      RDMA/hns: Use hr_reg_xxx() instead of remaining roce_set_xxx()

William Breathitt Gray (1):
      counter: microchip-tcb-capture: Handle Signal1 read and Synapse

Wong Vee Khee (1):
      stmmac: intel: Enable 2.5Gbps for Intel AlderLake-S

Xian Wang (1):
      ALSA: hda/ca0132: add quirk for EVGA Z390 DARK

Xin Long (3):
      ethtool: eeprom: fix null-deref on genl_info in dump
      tipc: fix a null-ptr-deref in tipc_topsrv_accept
      tipc: fix the msg->req tlv len check in tipc_nl_compat_name_table_dump_header

Xinhao Liu (1):
      RDMA/hns: Remove magic number

Yang Li (1):
      drm/amdkfd: Fix NULL pointer dereference in svm_migrate_to_ram()

Yang Yingliang (14):
      can: j1939: transport: j1939_session_skb_drop_old(): spin_unlock_irqrestore() before kfree_skb()
      mtd: rawnand: intel: Add missing of_node_put() in ebu_nand_probe()
      ALSA: ac97: fix possible memory leak in snd_ac97_dev_register()
      net: netsec: fix error handling in netsec_register_mdio()
      net: ksz884x: fix missing pci_disable_device() on error in pcidev_init()
      ALSA: aoa: i2sbus: fix possible memory leak in i2sbus_add_dev()
      net: ehea: fix possible memory leak in ehea_register_port()
      mISDN: fix possible memory leak in mISDN_register_device()
      isdn: mISDN: netjet: fix wrong check of device registration
      HID: hyperv: fix possible memory leak in mousevsc_probe()
      dmaengine: ti: k3-udma-glue: fix memory leak when register device fail
      stmmac: dwmac-loongson: fix missing pci_disable_msi() while module exiting
      stmmac: dwmac-loongson: fix missing pci_disable_device() in loongson_dwmac_probe()
      stmmac: dwmac-loongson: fix missing of_node_put() while module exiting

Yangyang Li (1):
      RDMA/hns: Disable local invalidate operation

Ye Bin (2):
      ext4: fix warning in 'ext4_da_release_space'
      ALSA: hda: fix potential memleak in 'add_widget_node'

Youlin Li (1):
      bpf: Fix wrong reg type conversion in release_reference()

Yu Kuai (2):
      scsi: sd: Revert "scsi: sd: Remove a local variable"
      block, bfq: protect 'bfqd->queued' by 'bfqd->lock'

Yuan Can (1):
      drm/vc4: Fix missing platform_unregister_drivers() call in vc4_drm_register()

YueHaibing (1):
      net: broadcom: Fix BCMGENET Kconfig

Zhang Changzhong (2):
      net: lantiq_etop: don't free skb when returning NETDEV_TX_BUSY
      net: fec: fix improper use of NETDEV_TX_BUSY

Zhang Qilong (1):
      rose: Fix NULL pointer dereference in rose_send_frame()

Zhang Xiaoxu (3):
      SUNRPC: Fix null-ptr-deref when xps sysfs alloc failed
      nfs4: Fix kmemleak when allocate slot failed
      btrfs: selftests: fix wrong error check in btrfs_free_dummy_root()

ZhangPeng (1):
      udf: Fix a slab-out-of-bounds write bug in udf_find_entry()

Zheng Yejian (1):
      tracing/histogram: Update document for KEYS_MAX size

Zhengchao Shao (23):
      net: hinic: fix incorrect assignment issue in hinic_set_interrupt_cfg()
      net: hinic: fix memory leak when reading function table
      net: hinic: fix the issue of CMDQ memory leaks
      net: hinic: fix the issue of double release MBOX callback of VF
      net: fix UAF issue in nfqnl_nf_hook_drop() when ops_init() failed
      netdevsim: remove dir in nsim_dev_debugfs_init() when creating ports dir failed
      ipvs: fix WARNING in __ip_vs_cleanup_batch()
      ipvs: fix WARNING in ip_vs_app_net_cleanup()
      Bluetooth: L2CAP: fix use-after-free in l2cap_conn_del()
      ipv6: fix WARNING in ip6_route_net_exit_late()
      net: lapbether: fix issue of dev reference count leakage in lapbeth_device_event()
      hamradio: fix issue of dev reference count leakage in bpq_device_event()
      can: af_can: fix NULL pointer dereference in can_rx_register()
      net: lapbether: fix issue of invalid opcode in lapbeth_open()
      drivers: net: xgene: disable napi when register irq failed in xgene_enet_open()
      net: marvell: prestera: fix memory leak in prestera_rxtx_switch_init()
      net: nixge: disable napi when enable interrupts failed in nixge_open()
      net: cpsw: disable napi in cpsw_ndo_open()
      net: cxgb3_main: disable napi when bind qsets failed in cxgb_up()
      cxgb4vf: shut down the adapter when t4vf_update_port_info() failed in cxgb4vf_open()
      ethernet: s2io: disable napi when start nic failed in s2io_card_up()
      net: mv643xx_eth: disable napi when init rxq or txq failed in mv643xx_eth_open()
      ethernet: tundra: free irq when alloc ring failed in tsi108_open()

Ziyang Xuan (2):
      net: tun: fix bugs for oversize packet when napi frags enabled
      netfilter: nfnetlink: fix potential dead lock in nfnetlink_rcv_msg()

Íñigo Huguet (1):
      atlantic: fix deadlock at aq_nic_stop
---
Documentation/trace/histogram.rst                  |    2 +-
 Documentation/virt/kvm/devices/vm.rst              |    3 +
 Makefile                                           |    2 +-
 arch/arc/include/asm/io.h                          |    2 +-
 arch/arc/include/asm/pgtable-levels.h              |    2 +-
 arch/arc/mm/ioremap.c                              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi              |    2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   14 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |    6 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |    6 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |    6 +
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |   18 +-
 arch/arm64/include/asm/cputype.h                   |    4 +
 arch/arm64/kernel/efi.c                            |   52 +-
 arch/arm64/kernel/entry-common.c                   |    3 +-
 arch/arm64/kernel/proton-pack.c                    |    6 +
 arch/arm64/kvm/hyp/exception.c                     |    3 +-
 arch/mips/kernel/jump_label.c                      |    2 +-
 arch/parisc/include/asm/hardware.h                 |   12 +-
 arch/parisc/kernel/drivers.c                       |   14 +-
 arch/riscv/kernel/process.c                        |    2 +
 arch/riscv/kernel/setup.c                          |    1 +
 arch/riscv/kernel/vdso/Makefile                    |    2 +-
 arch/riscv/mm/init.c                               |    1 -
 arch/s390/boot/compressed/vmlinux.lds.S            |   13 +-
 arch/s390/include/asm/futex.h                      |    3 +-
 arch/s390/kvm/kvm-s390.c                           |   26 +-
 arch/s390/kvm/kvm-s390.h                           |    1 -
 arch/s390/lib/uaccess.c                            |    6 +-
 arch/s390/pci/pci_mmio.c                           |    8 +-
 arch/x86/events/intel/core.c                       |    1 +
 arch/x86/events/intel/ds.c                         |   18 +-
 arch/x86/events/intel/lbr.c                        |    2 +-
 arch/x86/include/asm/msr-index.h                   |    8 +-
 arch/x86/include/asm/syscall_wrapper.h             |    2 +-
 arch/x86/kernel/cpu/amd.c                          |    6 +-
 arch/x86/kernel/cpu/hygon.c                        |    4 +-
 arch/x86/kernel/unwind_orc.c                       |    2 +-
 arch/x86/kvm/cpuid.c                               |   11 +-
 arch/x86/kvm/emulate.c                             |  104 +-
 arch/x86/kvm/svm/svm.c                             |   10 +-
 arch/x86/kvm/trace.h                               |   12 +-
 arch/x86/kvm/vmx/vmx.c                             |    5 +
 arch/x86/kvm/x86.c                                 |  136 ++-
 arch/x86/power/cpu.c                               |    1 +
 block/bfq-iosched.c                                |    4 +-
 block/genhd.c                                      |    1 +
 drivers/acpi/apei/ghes.c                           |    2 +-
 drivers/ata/libata-scsi.c                          |    3 +
 drivers/ata/pata_legacy.c                          |    5 +-
 drivers/base/power/domain.c                        |    4 +
 drivers/bluetooth/virtio_bt.c                      |    2 +-
 drivers/clk/qcom/gcc-sc7280.c                      |    1 +
 drivers/clk/qcom/gpucc-sc7280.c                    |    1 +
 drivers/counter/microchip-tcb-capture.c            |   18 +-
 drivers/cpufreq/intel_pstate.c                     |  133 +--
 drivers/dma/at_hdmac.c                             |  153 ++-
 drivers/dma/at_hdmac_regs.h                        |   10 +-
 drivers/dma/mv_xor_v2.c                            |    1 +
 drivers/dma/pxa_dma.c                              |    4 +-
 drivers/dma/ti/k3-udma-glue.c                      |    3 +
 drivers/firmware/arm_scmi/driver.c                 |    9 +-
 drivers/firmware/arm_scmi/virtio.c                 |    6 +-
 drivers/firmware/efi/efi.c                         |    2 +-
 drivers/firmware/efi/libstub/random.c              |    7 +-
 drivers/firmware/efi/tpm.c                         |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   16 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |   49 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |    2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |    8 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |    4 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |    2 +
 drivers/gpu/drm/i915/display/intel_sdvo.c          |   58 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |    4 +-
 .../gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c    |    5 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |    2 +-
 drivers/gpu/drm/msm/dsi/dsi.c                      |    6 +
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |    9 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |   22 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |    7 +-
 drivers/hid/hid-hyperv.c                           |    2 +-
 drivers/hid/hid-ids.h                              |    2 +
 drivers/hid/hid-playstation.c                      |    5 +-
 drivers/hid/hid-quirks.c                           |    1 +
 drivers/hid/hid-saitek.c                           |    2 +
 drivers/hwspinlock/qcom_hwspinlock.c               |    2 +-
 drivers/hwtracing/coresight/coresight-cti-core.c   |    5 -
 drivers/i2c/busses/i2c-piix4.c                     |    1 +
 drivers/i2c/busses/i2c-xiic.c                      |    1 +
 drivers/iio/accel/adxl372.c                        |   23 +-
 drivers/iio/light/tsl2583.c                        |    2 +-
 drivers/iio/temperature/ltc2983.c                  |   13 +-
 drivers/infiniband/core/cma.c                      |    2 +-
 drivers/infiniband/core/device.c                   |   10 +-
 drivers/infiniband/core/nldev.c                    |    2 +-
 drivers/infiniband/hw/hfi1/pio.c                   |    3 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  266 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |  166 ++-
 drivers/infiniband/hw/qedr/main.c                  |    9 +-
 drivers/isdn/hardware/mISDN/netjet.c               |    2 +-
 drivers/isdn/mISDN/core.c                          |    5 +-
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c   |    2 +
 drivers/media/cec/platform/s5p/s5p_cec.c           |    2 +
 drivers/media/dvb-frontends/drxk_hard.c            |    2 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c      |    7 +-
 .../media/platform/rockchip/rkisp1/rkisp1-params.c |   14 +-
 .../media/platform/rockchip/rkisp1/rkisp1-regs.h   |    2 +-
 .../platform/rockchip/rkisp1/rkisp1-resizer.c      |    4 +
 drivers/media/test-drivers/vivid/vivid-core.c      |   38 +-
 drivers/media/test-drivers/vivid/vivid-core.h      |    2 +
 drivers/media/test-drivers/vivid/vivid-vid-cap.c   |   27 +-
 drivers/media/v4l2-core/v4l2-dv-timings.c          |   14 +
 drivers/mmc/core/block.c                           |   44 +-
 drivers/mmc/core/sdio_bus.c                        |    3 +-
 drivers/mmc/host/Kconfig                           |    3 +-
 drivers/mmc/host/sdhci-cqhci.h                     |   24 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   17 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |    3 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   14 +-
 drivers/mmc/host/sdhci-tegra.c                     |    3 +-
 drivers/mmc/host/sdhci_am654.c                     |    7 +-
 drivers/mtd/nand/raw/intel-nand-controller.c       |   19 +-
 drivers/mtd/nand/raw/marvell_nand.c                |    2 +-
 drivers/mtd/parsers/bcm47xxpart.c                  |    4 +-
 drivers/net/can/mscan/mpc5xxx_can.c                |    8 +-
 drivers/net/can/rcar/rcar_canfd.c                  |   24 +-
 drivers/net/can/spi/mcp251x.c                      |    5 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |    4 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |    4 +-
 drivers/net/dsa/dsa_loop.c                         |   25 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |   17 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |    4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_macsec.c |   98 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h    |    2 +
 .../ethernet/aquantia/atlantic/macsec/macsec_api.c |   18 +-
 drivers/net/ethernet/broadcom/Kconfig              |    2 +-
 drivers/net/ethernet/broadcom/bcm4908_enet.c       |   10 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |    3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |    2 +-
 drivers/net/ethernet/cadence/macb_main.c           |    1 +
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |    1 +
 .../net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c    |    2 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |    5 +
 drivers/net/ethernet/freescale/fec_main.c          |   50 +-
 drivers/net/ethernet/freescale/fman/mac.c          |    9 +
 drivers/net/ethernet/huawei/hinic/hinic_debugfs.c  |   18 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c  |    2 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c   |    2 +-
 drivers/net/ethernet/huawei/hinic/hinic_sriov.c    |    1 -
 drivers/net/ethernet/ibm/ehea/ehea_main.c          |    1 +
 drivers/net/ethernet/ibm/ibmvnic.c                 |   16 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  100 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |    4 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   43 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |    1 +
 drivers/net/ethernet/lantiq_etop.c                 |    1 -
 drivers/net/ethernet/marvell/mv643xx_eth.c         |    1 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |    1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  135 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_struct.h   |   57 ++
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   69 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |    5 +
 .../net/ethernet/marvell/prestera/prestera_rxtx.c  |    7 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   21 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h   |    9 +
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    |   31 +
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h  |    6 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |    3 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    6 +
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c  |   14 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   55 +-
 drivers/net/ethernet/micrel/ksz884x.c              |    2 +-
 drivers/net/ethernet/neterion/s2io.c               |   29 +-
 drivers/net/ethernet/ni/nixge.c                    |    1 +
 drivers/net/ethernet/socionext/netsec.c            |    2 +
 drivers/net/ethernet/socionext/sni_ave.c           |    6 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   14 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   46 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |    8 +-
 drivers/net/ethernet/ti/cpsw.c                     |    2 +
 drivers/net/ethernet/tundra/tsi108_eth.c           |    5 +-
 drivers/net/hamradio/bpqether.c                    |    2 +-
 drivers/net/macsec.c                               |   23 +-
 drivers/net/macvlan.c                              |    4 +-
 drivers/net/netdevsim/dev.c                        |   11 +-
 drivers/net/phy/mdio_bus.c                         |    2 +-
 drivers/net/phy/mscc/mscc_macsec.c                 |    1 +
 drivers/net/tun.c                                  |   21 +-
 drivers/net/wan/lapbether.c                        |    3 +-
 drivers/net/wireless/ath/ath11k/reg.c              |    6 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |    4 +
 drivers/net/wwan/iosm/iosm_ipc_pcie.c              |   11 +-
 drivers/net/wwan/iosm/iosm_ipc_wwan.c              |    1 +
 drivers/net/wwan/mhi_wwan_mbim.c                   |    1 +
 drivers/nfc/fdp/fdp.c                              |   10 +-
 drivers/nfc/nfcmrvl/i2c.c                          |    7 +-
 drivers/nfc/nxp-nci/core.c                         |    7 +-
 drivers/nfc/s3fwrn5/core.c                         |    8 +-
 drivers/nfc/virtual_ncidev.c                       |    3 +
 drivers/parisc/iosapic.c                           |    1 +
 drivers/phy/ralink/phy-mt7621-pci.c                |    3 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |    2 +
 drivers/pinctrl/pinctrl-ingenic.c                  |    4 +-
 drivers/platform/x86/hp-wmi.c                      |   12 +-
 drivers/s390/cio/css.c                             |    3 +-
 drivers/scsi/lpfc/lpfc.h                           |   55 +-
 drivers/scsi/lpfc/lpfc_bsg.c                       |   50 +-
 drivers/scsi/lpfc/lpfc_crtn.h                      |   11 +-
 drivers/scsi/lpfc/lpfc_ct.c                        |    8 +-
 drivers/scsi/lpfc/lpfc_debugfs.c                   |   57 +-
 drivers/scsi/lpfc/lpfc_debugfs.h                   |    2 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  139 +--
 drivers/scsi/lpfc/lpfc_hw4.h                       |    7 -
 drivers/scsi/lpfc/lpfc_init.c                      |  114 +--
 drivers/scsi/lpfc/lpfc_mem.c                       |    9 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |    4 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |   34 +-
 drivers/scsi/lpfc/lpfc_nvme.h                      |    6 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                     |   83 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |  441 ++++----
 drivers/scsi/lpfc/lpfc_sli.c                       | 1066 ++++++++++++--------
 drivers/scsi/lpfc/lpfc_sli.h                       |   26 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |   28 +-
 drivers/scsi/scsi_sysfs.c                          |    8 +
 drivers/scsi/sd.c                                  |    3 +-
 drivers/soundwire/qcom.c                           |    9 +
 drivers/staging/media/atomisp/pci/sh_css_params.c  |    4 +-
 drivers/staging/media/meson/vdec/vdec.c            |    2 +
 drivers/tee/tee_core.c                             |    3 +
 drivers/tee/tee_shm.c                              |    3 -
 drivers/thunderbolt/path.c                         |   42 +-
 drivers/thunderbolt/tb.c                           |   96 +-
 drivers/thunderbolt/tb.h                           |    5 +-
 drivers/thunderbolt/tunnel.c                       |   27 +-
 drivers/thunderbolt/tunnel.h                       |    9 +-
 drivers/tty/serial/8250/8250_omap.c                |    3 +
 drivers/tty/serial/8250/8250_pci.c                 |    9 +-
 drivers/tty/serial/8250/8250_port.c                |   12 +-
 drivers/tty/serial/8250/Kconfig                    |    2 +-
 drivers/tty/serial/ar933x_uart.c                   |    5 +
 drivers/tty/serial/fsl_lpuart.c                    |    8 +-
 drivers/tty/serial/imx.c                           |    8 +-
 drivers/tty/serial/serial_core.c                   |   61 +-
 drivers/usb/core/quirks.c                          |    9 +
 drivers/usb/dwc3/gadget.c                          |    8 +-
 drivers/usb/gadget/function/uvc_queue.c            |    8 +-
 drivers/usb/gadget/function/uvc_video.c            |   22 +-
 drivers/usb/gadget/udc/bdc/bdc_udc.c               |    1 +
 drivers/usb/host/xhci-mem.c                        |   20 +-
 drivers/usb/host/xhci-pci.c                        |   44 +-
 drivers/usb/host/xhci.c                            |   10 +-
 drivers/usb/host/xhci.h                            |    1 +
 drivers/video/fbdev/smscufx.c                      |   55 +-
 drivers/video/fbdev/stifb.c                        |   46 +-
 fs/binfmt_elf.c                                    |    3 +-
 fs/btrfs/backref.c                                 |   54 +-
 fs/btrfs/disk-io.c                                 |    4 +-
 fs/btrfs/export.c                                  |    2 +-
 fs/btrfs/export.h                                  |    2 +-
 fs/btrfs/extent-tree.c                             |   25 +-
 fs/btrfs/file.c                                    |   39 +-
 fs/btrfs/tests/btrfs-tests.c                       |    2 +-
 fs/btrfs/tests/qgroup-tests.c                      |   20 +-
 fs/btrfs/volumes.c                                 |   27 +-
 fs/btrfs/volumes.h                                 |    2 +-
 fs/cifs/connect.c                                  |   11 +-
 fs/crypto/fscrypt_private.h                        |   71 +-
 fs/crypto/hooks.c                                  |   10 +-
 fs/crypto/keyring.c                                |  491 ++++-----
 fs/crypto/keysetup.c                               |   81 +-
 fs/crypto/policy.c                                 |    8 +-
 fs/exec.c                                          |    4 +-
 fs/ext4/migrate.c                                  |    3 +-
 fs/ext4/namei.c                                    |   10 +-
 fs/ext4/verity.c                                   |    3 +-
 fs/f2fs/verity.c                                   |    3 +-
 fs/fuse/file.c                                     |    4 +
 fs/fuse/readdir.c                                  |   10 +-
 fs/kernfs/dir.c                                    |    5 +-
 fs/nfs/delegation.c                                |   36 +-
 fs/nfs/nfs42proc.c                                 |    3 +
 fs/nfs/nfs4client.c                                |    1 +
 fs/nfs/nfs4namespace.c                             |    9 +-
 fs/nfs/nfs4proc.c                                  |   34 +-
 fs/nfs/nfs4state.c                                 |   11 +-
 fs/nfs/nfs4xdr.c                                   |    4 +-
 fs/nilfs2/segment.c                                |   15 +-
 fs/nilfs2/super.c                                  |    2 -
 fs/nilfs2/the_nilfs.c                              |    2 -
 fs/super.c                                         |    3 +-
 fs/udf/namei.c                                     |    2 +-
 include/acpi/ghes.h                                |    2 +-
 include/asm-generic/vmlinux.lds.h                  |    2 +-
 include/linux/bpf.h                                |    1 +
 include/linux/bpf_verifier.h                       |   21 +
 include/linux/efi.h                                |    2 +-
 include/linux/fs.h                                 |    2 +-
 include/linux/fscrypt.h                            |    4 +-
 include/linux/hugetlb.h                            |    8 +-
 include/linux/mlx5/driver.h                        |    2 +-
 include/linux/nfs_xdr.h                            |    2 +-
 include/linux/perf_event.h                         |   19 +-
 include/linux/skmsg.h                              |    3 +-
 include/linux/soc/marvell/octeontx2/asm.h          |   15 +
 include/media/v4l2-common.h                        |    3 +-
 include/media/v4l2-subdev.h                        |    6 +
 include/net/protocol.h                             |    4 -
 include/net/sock.h                                 |    2 +-
 include/net/tcp.h                                  |    2 +-
 include/net/udp.h                                  |    2 +-
 include/uapi/linux/capability.h                    |    2 +-
 include/uapi/linux/videodev2.h                     |    3 +-
 kernel/bpf/verifier.c                              |  148 +--
 kernel/events/core.c                               |  153 ++-
 kernel/events/ring_buffer.c                        |    2 +-
 kernel/kprobes.c                                   |    5 +-
 kernel/power/hibernate.c                           |    2 +-
 kernel/sched/sched.h                               |   18 +-
 kernel/trace/ftrace.c                              |   16 +-
 kernel/trace/kprobe_event_gen_test.c               |   18 +-
 kernel/trace/ring_buffer.c                         |   11 +
 localversion-rt                                    |    2 +-
 mm/damon/dbgfs.c                                   |    7 +
 mm/gup.c                                           |   14 +-
 mm/hugetlb.c                                       |   27 +-
 mm/memremap.c                                      |    1 +
 mm/userfaultfd.c                                   |    2 +-
 net/bluetooth/l2cap_core.c                         |   84 +-
 net/can/af_can.c                                   |    2 +-
 net/can/j1939/main.c                               |    3 +
 net/can/j1939/transport.c                          |    4 +-
 net/core/neighbour.c                               |    2 +-
 net/core/net_namespace.c                           |    7 +
 net/core/skbuff.c                                  |   38 +-
 net/core/skmsg.c                                   |    8 +-
 net/core/sock_map.c                                |   28 +-
 net/dsa/dsa2.c                                     |   13 +-
 net/ethtool/eeprom.c                               |    2 +-
 net/ieee802154/socket.c                            |    4 +-
 net/ipv4/af_inet.c                                 |   14 +-
 net/ipv4/ip_input.c                                |   37 +-
 net/ipv4/nexthop.c                                 |    2 +-
 net/ipv4/sysctl_net_ipv4.c                         |   59 +-
 net/ipv4/tcp.c                                     |    2 +-
 net/ipv4/tcp_bpf.c                                 |    9 +-
 net/ipv4/tcp_input.c                               |    3 +-
 net/ipv4/tcp_ipv4.c                                |    7 +-
 net/ipv6/addrlabel.c                               |    1 +
 net/ipv6/ip6_gre.c                                 |   12 +-
 net/ipv6/ip6_input.c                               |   23 +-
 net/ipv6/ip6_tunnel.c                              |   11 +-
 net/ipv6/ipv6_sockglue.c                           |    7 +
 net/ipv6/route.c                                   |   14 +-
 net/ipv6/sit.c                                     |    8 +-
 net/ipv6/tcp_ipv6.c                                |    9 +-
 net/ipv6/udp.c                                     |    9 +-
 net/kcm/kcmsock.c                                  |   25 +-
 net/mac80211/s1g.c                                 |    3 +
 net/mac802154/rx.c                                 |    5 +-
 net/mctp/af_mctp.c                                 |    4 +-
 net/mctp/route.c                                   |    2 +-
 net/netfilter/ipset/ip_set_hash_gen.h              |   30 +-
 net/netfilter/ipvs/ip_vs_app.c                     |   10 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |   30 +-
 net/netfilter/nf_tables_api.c                      |   11 +-
 net/netfilter/nfnetlink.c                          |    1 +
 net/openvswitch/datapath.c                         |    3 +-
 net/rose/rose_link.c                               |    3 +
 net/sched/sch_red.c                                |    4 +-
 net/smc/af_smc.c                                   |    6 +-
 net/sunrpc/sysfs.c                                 |   12 +-
 net/tipc/netlink_compat.c                          |    2 +-
 net/tipc/topsrv.c                                  |   16 +-
 net/unix/af_unix.c                                 |   13 +-
 net/vmw_vsock/af_vsock.c                           |    5 +-
 net/wireless/reg.c                                 |   12 +-
 net/wireless/scan.c                                |    4 +-
 scripts/extract-cert.c                             |    7 +
 scripts/sign-file.c                                |    7 +
 security/commoncap.c                               |    6 +-
 sound/aoa/soundbus/i2sbus/core.c                   |    7 +-
 sound/hda/hdac_sysfs.c                             |    4 +-
 sound/pci/ac97/ac97_codec.c                        |    1 +
 sound/pci/au88x0/au88x0.h                          |    6 +-
 sound/pci/au88x0/au88x0_core.c                     |    2 +-
 sound/pci/hda/hda_intel.c                          |    3 +
 sound/pci/hda/patch_ca0132.c                       |    1 +
 sound/pci/hda/patch_realtek.c                      |    1 +
 sound/pci/rme9652/hdsp.c                           |   26 +-
 sound/pci/rme9652/rme9652.c                        |   22 +-
 sound/soc/qcom/lpass-cpu.c                         |   10 +
 sound/synth/emux/emux.c                            |    7 +-
 sound/usb/card.c                                   |   29 +-
 sound/usb/implicit.c                               |    2 +
 sound/usb/quirks-table.h                           |    4 +
 sound/usb/quirks.c                                 |    1 +
 tools/arch/x86/include/asm/msr-index.h             |    8 +-
 tools/bpf/bpftool/common.c                         |    3 +
 tools/iio/iio_utils.c                              |    4 +
 tools/include/nolibc/nolibc.h                      |    4 +-
 tools/perf/.gitignore                              |    1 +
 .../arch/arm64/hisilicon/hip08/metrics.json        |    6 +-
 .../arch/powerpc/power10/nest_metrics.json         |   72 +-
 tools/perf/util/auxtrace.c                         |   10 +-
 tools/perf/util/stat-display.c                     |    2 +-
 .../kvm/memslot_modification_stress_test.c         |    2 +-
 415 files changed, 4984 insertions(+), 3225 deletions(-)
---
