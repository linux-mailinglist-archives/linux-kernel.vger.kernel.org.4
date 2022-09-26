Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4F5E976B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiIZAeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 20:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiIZAeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 20:34:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E2C2CC9E;
        Sun, 25 Sep 2022 17:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2329B808D3;
        Mon, 26 Sep 2022 00:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C953C433D6;
        Mon, 26 Sep 2022 00:32:53 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.70-rt50
Date:   Mon, 26 Sep 2022 00:29:19 -0000
Message-ID: <166415215968.2473801.12697249236170282109@puck.lan>
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

I'm pleased to announce the 5.15.70-rt50 stable release.

In addition to the stable update(s) this release contains the memcg series posted by
David Oberhollenzer (a backport of Sebastian's series for 5.17).

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 6c14e2d09c39f9eded23044df2f6f2313b048351

Or to build 5.15.70-rt50 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.70.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.70-rt50.patch.xz


Enjoy!
Clark

Changes from v5.15.65-rt49:
---

Adrian Hunter (2):
      mmc: core: Fix UHS-I SD 1.8V workaround branch
      mmc: core: Fix inconsistent sd3_bus_mode at UHS-I SD voltage switch failure

Ajay.Kathat@microchip.com (1):
      wifi: wilc1000: fix DMA on stack objects

Alan Stern (2):
      media: mceusb: Use new usb_control_msg_*() routines
      USB: core: Prevent nested device-reset calls

Alex Deucher (2):
      drm/amdgpu: move nbio ih_doorbell_range() into ih code for vega
      drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for vega

Alex Williamson (1):
      vfio/type1: Unpin zero pages

Alexander Gordeev (1):
      s390/boot: fix absolute zero lowcore corruption on boot

Alexander Sverdlin (1):
      MIPS: OCTEON: irq: Fix octeon_irq_force_ciu_mapping()

Alexandru Gagniuc (1):
      hwmon: (tps23861) fix byte order in resistance register

Andrew Halaney (1):
      regulator: core: Clean up on enable failure

Andrey Zhadchenko (1):
      openvswitch: fix memory leak at failed datapath creation

Andy Shevchenko (1):
      platform/x86: pmc_atom: Fix SLP_TYPx bitfield mask

Ard Biesheuvel (1):
      efi: libstub: Disable struct randomization

Armin Wolf (1):
      hwmon: (gpio-fan) Fix array out of bounds access

Arnaldo Carvalho de Melo (1):
      perf machine: Use path__join() to compose a path instead of snprintf(dir, '/', filename)

Arnd Bergmann (1):
      musb: fix USB_MUSB_TUSB6010 dependency

Arun R Murthy (1):
      drm/i915/display: avoid warnings when registering dual panel backlight

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Return ENOTSUPP for power supply prop writes

Bart Van Assche (2):
      scsi: ufs: core: Reduce the power mode change timeout
      nvmet: fix a use-after-free

Ben Hutchings (1):
      tools/include/uapi: Fix <asm/errno.h> for parisc and xtensa

Borislav Petkov (2):
      x86/mm: Force-inline __phys_addr_nodebug()
      task_stack, x86/cea: Force-inline stack helpers

Brian Norris (1):
      tracefs: Only clobber mode/uid/gid on remount if asked

Candice Li (1):
      drm/amdgpu: Check num_gfx_rings for gfx v9_0 rb setup.

Carlos Llamas (3):
      binder: fix UAF of ref->proc caused by race condition
      binder: fix alloc->vma_vm_mm null-ptr dereference
      binder: remove inaccurate mmap_assert_locked()

Casper Andersson (1):
      net: sparx5: fix handling uneven length packets in manual extraction

Chao Gao (1):
      swiotlb: avoid potential left shift overflow

Chen-Yu Tsai (2):
      clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops
      clk: core: Fix runtime PM sequence in clk_core_unprepare()

Chengchang Tang (1):
      RDMA/hns: Fix supported page size

Chengming Gui (1):
      drm/amd/amdgpu: skip ucode loading if ucode_size == 0

Chris Mi (1):
      RDMA/mlx5: Set local port to one when accessing counters

Christian A. Ehrhardt (1):
      kprobes: Prohibit probes in gate area

Christophe JAILLET (1):
      clk: bcm: rpi: Use correct order for the parameters of devm_kcalloc()

Chuanhong Guo (1):
      ACPI: resource: skip IRQ override on AMD Zen platforms

Chunfeng Yun (2):
      usb: xhci-mtk: relax TT periodic bandwidth allocation
      usb: xhci-mtk: fix bandwidth release issue

Clark Williams (2):
      Merge tag 'v5.15.70' into v5.15-rt
      'Linux 5.15.70-rt50'

Claudiu Beznea (10):
      ARM: at91: pm: fix self-refresh for sama7g5
      ARM: at91: pm: fix DDR recalibration when resuming from backup and self-refresh
      ARM: dts: at91: sama5d27_wlsom1: specify proper regulator output ranges
      ARM: dts: at91: sama5d2_icp: specify proper regulator output ranges
      ARM: dts: at91: sama5d27_wlsom1: don't keep ldo2 enabled all the time
      ARM: dts: at91: sama5d2_icp: don't keep vdd_other enabled all the time
      ASoC: mchp-spdiftx: remove references to mchp_i2s_caps
      ARM: at91: ddr: remove CONFIG_SOC_SAMA7 dependency
      ARM: dts: at91: fix low limit for CPU regulator
      ARM: dts: at91: sama7g5ek: specify proper regulator output ranges

Clément Péron (1):
      drm/panfrost: devfreq: set opp to the recommended one to configure regulator

Colin Ian King (2):
      drm/i915/reg: Fix spelling mistake "Unsupport" -> "Unsupported"
      usb: gadget: f_uac2: clean up some inconsistent indenting

Cong Wang (1):
      kcm: fix strp_init() order and cleanup

Dan Carpenter (4):
      wifi: cfg80211: debugfs: fix return type in ht40allow_map_read()
      staging: rtl8712: fix use after free bugs
      xen/grants: prevent integer overflow in gnttab_dma_alloc_pages()
      tipc: fix shift wrapping bug in map_get()

Dave Wysochanski (1):
      NFS: Fix WARN_ON due to unionization of nfs_inode.nrequests

David Howells (6):
      rxrpc: Fix ICMP/ICMP6 error handling
      rxrpc: Fix an insufficiently large sglist in rxkad_verify_packet_2()
      afs: Use the operation issue time instead of the reply time for callbacks
      rxrpc: Fix local destruction being repeated
      rxrpc: Fix calc of resend age
      afs: Return -EAGAIN, not -EREMOTEIO, when a file already locked

David Leadbeater (1):
      netfilter: nf_conntrack_irc: Fix forged IP logic

David Lebrun (1):
      ipv6: sr: fix out-of-bounds read when setting HMAC data.

David Sloan (1):
      md: Flush workqueue md_rdev_misc_wq in md_alloc()

David Thompson (1):
      mlxbf_gige: compute MDIO period based on i1clk

Dennis Maisenbacher (1):
      nvmet: fix mar and mor off-by-one errors

Diego Santa Cruz (1):
      drm/i915/glk: ECS Liva Q2 needs GLK HDMI port timing quirk

Dongxiang Ke (1):
      ALSA: usb-audio: Fix an out-of-bounds bug in __snd_usb_parse_audio_interface()

Douglas Anderson (2):
      drm/msm/dsi: Fix number of regulators for msm8996_dsi_cfg
      drm/msm/dsi: Fix number of regulators for SDM660

Duoming Zhou (1):
      ethernet: rocker: fix sleep in atomic context bug in neigh_timer_handler

Eliav Farber (5):
      hwmon: (mr75203) fix VM sensor allocation when "intel,vm-map" not defined
      hwmon: (mr75203) update pvt->v_num and vm_num to the actual number of used sensors
      hwmon: (mr75203) fix voltage equation for negative source input
      hwmon: (mr75203) fix multi-channel voltage reading
      hwmon: (mr75203) enable polling for all VM channels

Enzo Matsumiya (1):
      cifs: fix small mempool leak in SMB2_negotiate()

Eric Dumazet (2):
      tcp: annotate data-race around challenge_timestamp
      tcp: TX zerocopy should not sense pfmemalloc status

Even Xu (1):
      hid: intel-ish-hid: ishtp: Fix ishtp client sending disordered message

Florian Fainelli (1):
      net: smsc911x: Stop and start PHY during suspend and resume

Florian Westphal (1):
      netfilter: conntrack: work around exceeded receive window

Gao Xiang (1):
      erofs: fix pcluster use-after-free on UP platforms

Gerald Schaefer (1):
      s390/hugetlb: fix prepare_hugepage_range() check for 2 GB hugepages

Greg Kroah-Hartman (9):
      Linux 5.15.66
      kbuild: fix up permissions on scripts/pahole-flags.sh
      Linux 5.15.67
      debugfs: add debugfs_lookup_and_remove()
      sched/debug: fix dentry leak in update_sched_domain_debugfs
      drm/amd/display: fix memory leak when using debugfs_lookup()
      Linux 5.15.68
      Linux 5.15.69
      Linux 5.15.70

Greg Tulli (1):
      Input: iforce - add support for Boeder Force Feedback Wheel

Grzegorz Szymaszek (1):
      staging: r8188eu: add firmware dependency

Guixin Liu (1):
      scsi: megaraid_sas: Fix double kfree()

Haibo Chen (1):
      gpio: pca953x: Add mutex_lock for regcache sync in PM

Hannes Reinecke (1):
      scsi: lpfc: Return DID_TRANSPORT_DISRUPTED instead of DID_REQUEUE

Hans de Goede (1):
      platform/x86: acer-wmi: Acer Aspire One AOD270/Packard Bell Dot keymap fixes

Harsh Modi (1):
      netfilter: br_netfilter: Drop dst references before setting.

Heikki Krogerus (1):
      usb: dwc3: pci: Add support for Intel Raptor Lake

Heiner Kallweit (2):
      usb: dwc2: fix wrong order of phy_power_on and phy_init
      Revert "net: phy: meson-gxl: improve link-up behavior"

Helge Deller (4):
      vt: Clear selection before changing the font
      Revert "parisc: Show error if wrong 32/64-bit compiler is being used"
      parisc: Add runtime check to prevent PA2.0 kernels on PA1.x machines
      parisc: Allow CONFIG_64BIT with ARCH=parisc

Hu Xiaoying (1):
      usb: storage: Add ASUS <0x0b05:0x1932> to IGNORE_UAS

Hyunwoo Kim (2):
      efi: capsule-loader: Fix use-after-free in efi_capsule_write
      video: fbdev: pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write

Ionela Voinescu (1):
      arm64: errata: add detection for AMEVCNTR01 incrementing incorrectly

Isaac J. Manjarres (1):
      driver core: Don't probe devices after bus_type.match() probe deferral

Ivan Vecera (2):
      i40e: Fix kernel crash during module removal
      iavf: Detach device during reset task

Jack Wang (2):
      RDMA/rtrs-clt: Use the right sg_cnt after ib_dma_map_sg
      RDMA/rtrs-srv: Pass the correct number of entries for dma mapped SGL

Jakub Kicinski (2):
      Revert "sch_cake: Return __NET_XMIT_STOLEN when consuming enqueued skb"
      net: wwan: iosm: remove pointless null check

Jani Nikula (1):
      drm/i915/backlight: extract backlight code to a separate file

Jann Horn (1):
      mm: Fix TLB flush for not-first PFNMAP mappings in unmap_region()

Jarrah Gosbell (1):
      Input: goodix - add compatible string for GT1158

Jason Wang (1):
      HID: ishtp-hid-clientHID: ishtp-hid-client: Fix comment typo

Jassi Brar (1):
      arm64: dts: juno: Add missing MHU secure-irq

Jeffy Chen (1):
      drm/gem: Fix GEM handle release errors

Jens Wiklander (1):
      tee: fix compiler warning in tee_shm_register()

Jim Mattson (2):
      KVM: VMX: Heed the 'msr' argument in msr_write_intercepted()
      KVM: x86: Mask off unsupported and unknown bits of IA32_ARCH_CAPABILITIES

Jing Leng (1):
      usb: gadget: f_uac2: fix superspeed transfer

Jiri Olsa (1):
      kbuild: Unify options for BTF generation for vmlinux and modules

Johan Hovold (8):
      misc: fastrpc: fix memory corruption on probe
      misc: fastrpc: fix memory corruption on open
      USB: serial: cp210x: add Decagon UCA device id
      usb: dwc3: fix PHY disable sequence
      usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup
      usb: dwc3: disable USB core PHY management
      USB: serial: ch341: fix lost character on LCR updates
      USB: serial: ch341: fix disabled rx timer on older devices

Johannes Weiner (1):
      mm/memcg: Opencode the inner part of obj_cgroup_uncharge_pages() in drain_obj_stock()

John Sperbeck (1):
      iommu/amd: use full 64-bit value in build_completion_wait()

Josh Poimboeuf (1):
      s390: fix nospec table alignments

João H. Spies (1):
      pinctrl: rockchip: Enhance support for IRQ_TYPE_EDGE_BOTH

Kacper Michajłow (1):
      ALSA: hda/realtek: Add speaker AMP init for Samsung laptops with ALC298

Kai-Heng Feng (1):
      tg3: Disable tg3 device on system reboot to avoid triggering AER

Krishna Kurapati (1):
      usb: gadget: mass_storage: Fix cdrom data transfers on MAC-OS

Krzysztof Kozlowski (2):
      ARM: dts: imx: align SPI NOR node name with dtschema
      dt-bindings: iio: gyroscope: bosch,bmg160: correct number of pins

Kuogee Hsieh (1):
      drm/msm/dp: delete DP_RECOVERED_CLOCK_OUT_EN to fix tps4

Kurt Kanzenbach (1):
      net: dsa: hellcreek: Print warning only once

Li Qiong (2):
      parisc: ccio-dma: Handle kmalloc failure in ccio_init_resources()
      ieee802154: cc2520: add rc code in cc2520_tx()

Liang He (1):
      soc: brcmstb: pm-arm: Fix refcount leak and __iomem leak bugs

Lijo Lazar (1):
      drm/amdgpu: Don't enable LTR if not supported

Lin Ma (1):
      ieee802154/adf7242: defer destroy_workqueue call

Lino Sanfilippo (1):
      serial: atmel: remove redundant assignment in rs485_config

Linus Torvalds (1):
      fs: only do a memory barrier for the first set_buffer_uptodate()

Linus Walleij (1):
      RDMA/siw: Pass a pointer to virt_to_page()

Liu Jian (1):
      skmsg: Fix wrong last sg check in sk_msg_recvmsg()

Lu Baolu (2):
      iommu/vt-d: Correctly calculate sagaw value of IOMMU
      iommu/vt-d: Fix kdump kernels boot failure with scalable mode

Lukasz Luba (1):
      cpufreq: check only freq_table in __resolve_freq()

Marco Felsch (2):
      ARM: dts: imx6qdl-kontron-samx6i: remove duplicated node
      ARM: dts: imx6qdl-kontron-samx6i: fix spi-flash compatible

Marcus Folkesson (2):
      iio: adc: mcp3911: make use of the sign bit
      iio: adc: mcp3911: use correct formula for AD conversion

Marek Vasut (1):
      soc: imx: gpcv2: Assert reset before ungating clock

Mark Brown (1):
      arm64/bti: Disable in kernel BTI when cross section thunks are broken

Martin Rodriguez Reboredo (1):
      kbuild: Add skip_encoding_btf_enum64 option to pahole

Masahiro Yamada (2):
      powerpc: align syscall table for ppc32
      kbuild: disable header exports for UML in a straightforward way

Masami Hiramatsu (Google) (1):
      tracing: Fix to check event_mutex is held while accessing trigger list

Mathew McBride (1):
      soc: fsl: select FSL_GUTS driver for DPIO

Mathias Nyman (2):
      Revert "xhci: turn off port power in shutdown"
      xhci: Add grace period after xHC start to prevent premature runtime suspend.

Matti Vaittinen (1):
      iio: ad7292: Prevent regulator double disable

Maurizio Lombardi (1):
      nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change()

Maximilian Luz (1):
      platform/surface: aggregator_registry: Add support for Surface Laptop Go 2

Mazin Al Haddad (1):
      tty: n_gsm: add sanity check for gsm->receive in gsm_receive_buf()

Michael Guralnik (1):
      RDMA/cma: Fix arguments order in net device validation

Michael Wu (1):
      pinctrl: sunxi: Fix name for A100 R_PIO

Michal Hocko (1):
      mm/memcg: Revert ("mm/memcg: optimize user context object stock access")

Michal Swiatkowski (1):
      ice: use bitmap_free instead of devm_kfree

Mika Westerberg (1):
      thunderbolt: Use the actual buffer in tb_async_error()

Mingwei Zhang (1):
      KVM: SEV: add cache flush to solve SEV cache incoherency issues

Miquel Raynal (1):
      net: mac802154: Fix a condition in the receive path

Mohan Kumar (1):
      ALSA: hda/tegra: Align BDL entry to 4KB boundary

Molly Sophia (2):
      pinctrl: qcom: sc8180x: Fix gpio_wakeirq_map
      pinctrl: qcom: sc8180x: Fix wrong pin numbers

Nathan Chancellor (1):
      ASoC: mchp-spdiftx: Fix clang -Wbitfield-constant-conversion

Neal Cardwell (1):
      tcp: fix early ETIMEDOUT after spurious non-SACK RTO

Neil Armstrong (1):
      drm/bridge: display-connector: implement bus fmts callbacks

Nick Desaulniers (1):
      lockdep: Fix -Wunused-parameter for _THIS_IP_

Nicolas Dichtel (1):
      ip: fix triggering of 'icmp redirect'

Niek Nooijens (1):
      USB: serial: ftdi_sio: add Omron CS1W-CIF31 device id

Ondrej Jirman (1):
      Input: goodix - add support for GT1158

Pablo Neira Ayuso (1):
      netfilter: nf_tables: clean up hook list when offload flags check fails

Pablo Sun (1):
      usb: typec: altmodes/displayport: correct pin assignment for UFP receptacles

Pali Rohár (1):
      gpio: mpc8xxx: Fix support for IRQ_TYPE_LEVEL_LOW flow_type in mpc85xx

Pattara Teerapong (1):
      ALSA: aloop: Fix random zeros in capture data when using jiffies timer

Paul Durrant (1):
      xen-netback: only remove 'hotplug-status' when the vif is actually destroyed

Pavel Begunkov (1):
      net: introduce __skb_fill_page_desc_noacc

Pawel Laszczak (2):
      usb: cdns3: fix issue with rearming ISO OUT endpoint
      usb: cdns3: fix incorrect handling TRB_SMM flag for ISOC transfer

Peter Robinson (1):
      Input: rk805-pwrkey - fix module autoloading

Peter Ujfalusi (1):
      ALSA: hda: intel-nhlt: Correct the handling of fmt_config flexible array

Pierre-Louis Bossart (1):
      ALSA: hda: intel-nhlt: remove use of __func__ in dev_dbg

Przemyslaw Patynowski (2):
      i40e: Refactor tc mqprio checks
      i40e: Fix ADQ rate limiting for PF

Pu Lehui (1):
      bpf, cgroup: Fix kernel BUG in purge_effective_progs

Qu Huang (1):
      drm/amdgpu: mmVM_L2_CNTL3 register not initialized correctly

Rob Clark (1):
      drm/msm/rd: Fix FIFO-full deadlock

Ronnie Sahlberg (1):
      cifs: revalidate mapping when doing direct writes

Sagi Grimberg (2):
      nvme-tcp: fix UAF when detecting digest errors
      nvme-tcp: fix regression that causes sporadic requests to time out

Sasha Levin (1):
      Revert "arm64: kasan: Revert "arm64: mte: reset the page tag in page->flags""

Sebastian Andrzej Siewior (9):
      net: dsa: xrs700x: Use irqsave variant for u64 stats update
      net: Use u64_stats_fetch_begin_irq() for stats fetch.
      mm/memcg: Disable threshold event handlers on PREEMPT_RT
      mm/memcg: Protect per-CPU counter by disabling preemption on PREEMPT_RT where needed.
      mm/memcg: Protect memcg_stock with a local_lock_t
      mm/memcg: Disable migration instead of preemption in drain_all_stock().
      mm/memcg: Add missing counter index which are not update in interrupt.
      mm/memcg: Add a comment regarding the release `obj'.
      mm/memcg: Only perform the debug checks on !PREEMPT_RT

SeongJae Park (3):
      xen-blkback: Advertise feature-persistent as user requested
      xen-blkfront: Advertise feature-persistent as user requested
      xen-blkfront: Cache feature_persistent value before advertisement

Sergey Shtylyov (1):
      of: fdt: fix off-by-one error in unflatten_dt_nodes()

Sergiu Moga (1):
      tty: serial: atmel: Preserve previous USART mode if RS485 disabled

Shenwei Wang (1):
      serial: fsl_lpuart: RS485 RTS polariy is inverse

Sherry Sun (1):
      tty: serial: lpuart: disable flow control while waiting for the transmit engine to complete

Shigeru Yoshida (1):
      fbdev: fbcon: Destroy mutex on freeing struct fb_info

Shin'ichiro Kawasaki (1):
      btrfs: zoned: set pseudo max append zone limit in zone emulation mode

Siddh Raman Pant (2):
      wifi: mac80211: Don't finalize CSA in IBSS mode if state is disconnected
      wifi: mac80211: Fix UAF in ieee80211_scan_rx()

Sindhu-Devale (4):
      RDMA/irdma: Report the correct max cqes from query device
      RDMA/irdma: Return correct WC error for bind operation failure
      RDMA/irdma: Report RNR NAK generation in device caps
      RDMA/irdma: Use s/g array in post send only when its valid

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV32-WA/WB RmNet mode

Soenke Huster (1):
      wifi: mac80211_hwsim: check length for virtio packets

Sreekanth Reddy (1):
      scsi: mpt3sas: Fix use-after-free warning

Srinivas Kandagatla (2):
      soundwire: qcom: fix device status array range
      ASoC: qcom: sm8250: add missing module owner

Stanislaw Gruszka (1):
      wifi: iwlegacy: 4965: corrected fix for potential off-by-one overflow in il4965_rs_fill_link_cmd()

Stefan Metzmacher (2):
      cifs: don't send down the destination address to sendmsg for a SOCK_STREAM
      cifs: always initialize struct msghdr smb_msg completely

Stefan Roesch (1):
      block: blk_queue_enter() / __bio_queue_enter() must return -EAGAIN for nowait

Stefan Wahren (3):
      clk: bcm: rpi: Fix error handling of raspberrypi_fw_get_rate
      clk: bcm: rpi: Prevent out-of-bounds access
      clk: bcm: rpi: Add missing newline

Stephen Boyd (1):
      Revert "clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops"

Steven Price (1):
      mm: pagewalk: Fix race between unmap and page walker

Stuart Menefy (2):
      drm/meson: Correct OSD1 global alpha value
      drm/meson: Fix OSD1 RGB to YCbCr coefficient

Sudeep Holla (1):
      arm64: cacheinfo: Fix incorrect assignment of signed error value to unsigned fw_level

Takashi Iwai (9):
      ALSA: seq: oss: Fix data-race for max_midi_devs access
      ALSA: seq: Fix data-race at module auto-loading
      ALSA: pcm: oss: Fix race at SNDCTL_DSP_SYNC
      ALSA: usb-audio: Split endpoint setups for hw_params and prepare
      ALSA: usb-audio: Inform the delayed registration more properly
      ALSA: usb-audio: Register card again for iface over delayed_register option
      ASoC: nau8824: Fix semaphore unbalance at error paths
      ALSA: hda/sigmatel: Keep power up while beep is enabled
      ALSA: hda/sigmatel: Fix unused variable warning for beep power change

Tasos Sahanidis (1):
      ALSA: emu10k1: Fix out of bounds access in snd_emu10k1_pcm_channel_alloc()

Tejun Heo (2):
      cgroup: Elide write-locking threadgroup_rwsem when updating csses on an empty subtree
      cgroup: Fix threadgroup_rwsem <-> cpus_read_lock() deadlock

Tetsuo Handa (2):
      Input: iforce - wake up after clearing IFORCE_XMIT_RUNNING flag
      cgroup: Add missing cpus_read_lock() to cgroup_attach_task_all()

Thierry GUIBERT (1):
      USB: cdc-acm: Add Icom PMR F3400 support (0c26:0020)

Thierry Reding (1):
      of/device: Fix up of_dma_configure_id() stub

Toke Høiland-Jørgensen (3):
      sch_cake: Return __NET_XMIT_STOLEN when consuming enqueued skb
      sch_sfb: Don't assume the skb is still around after enqueueing to child
      sch_sfb: Also store skb len before calling child enqueue

Tony Battersby (1):
      scsi: qla2xxx: Disable ATIO interrupt coalesce for quad port ISP27XX

Trond Myklebust (4):
      NFS: Further optimisations for 'ls -l'
      NFS: Save some space in the inode
      NFS: Fix another fsync() issue after a server reboot
      NFSv4: Turn off open-by-filehandle and NFS re-export for NFSv4.0

Utkarsh Patel (1):
      usb: typec: intel_pmc_mux: Add new ACPI ID for Meteor Lake IOM device

Ville Syrjälä (2):
      drm/i915: Skip wm/ddb readout for disabled pipes
      drm/i915: Implement WaEdpLinkRateDataReload

Wang Hai (1):
      net/sched: fix netdevice reference leaks in attach_default_qdiscs()

Wei Yongjun (1):
      gpio: mockup: remove gpio debugfs when remove device

Wenpeng Liang (1):
      RDMA/hns: Fix wrong fixed value of qp->rq.wqe_shift

Witold Lipieta (1):
      usb-storage: Add ignore-residue quirk for NXP PN7462AU

Xiaolei Wang (1):
      regulator: pfuze100: Fix the global-out-of-bounds access in pfuze100_regulator_probe()

Yacan Liu (1):
      net/smc: Remove redundant refcount increase

Yan Xinyu (1):
      USB: serial: option: add support for OPPO R11 diag port

Yang Ling (1):
      MIPS: loongson32: ls1c: Fix hang during startup

Yang Yingliang (3):
      fbdev: chipsfb: Add missing pci_disable_device() in chipsfb_pci_init()
      scsi: lpfc: Add missing destroy_workqueue() in error path
      parisc: ccio-dma: Add missing iounmap in error path in ccio_probe()

Yee Lee (1):
      Revert "mm: kmemleak: take a full lowmem check in kmemleak_*_phys()"

YiFei Zhu (1):
      bpf: Restrict bpf_sys_bpf to CAP_PERFMON

YiPeng Chai (1):
      drm/amdgpu: Move psp_xgmi_terminate call from amdgpu_xgmi_remove_device to psp_hw_fini

Yipeng Zou (1):
      tracing: hold caller_addr to hardirq_{enable,disable}_ip

Yishai Hadas (1):
      IB/core: Fix a nested dead lock as part of ODP flow

Yonglin Tan (1):
      USB: serial: option: add Quectel EM060K modem

Youling Tang (1):
      mksysmap: Fix the mismatch of 'L0' symbols in System.map

Yu Zhe (1):
      perf/arm_pmu_platform: fix tests for platform_get_irq() failure

YueHaibing (1):
      drm/tegra: vic: Fix build warning when CONFIG_PM=n

Zhengchao Shao (1):
      net: sched: tbf: don't call qdisc_put() while holding tree lock

Zhengjun Xing (1):
      perf script: Fix Cannot print 'iregs' field for hybrid systems

Zhenneng Li (1):
      drm/radeon: add a force flush to delay work when radeon

Zheyu Ma (1):
      video: fbdev: i740fb: Error out if 'pixclock' equals zero

jerry.meng (1):
      net: usb: qmi_wwan: add Quectel RM520N

lily (1):
      net/core/skbuff: Check the return value of skb_copy_bits()

sewookseo (1):
      net: Find dst with sk's xfrm policy not ctl_sk

sunliming (1):
      drm/msm/dsi: fix the inconsistent indenting

yangx.jy@fujitsu.com (1):
      RDMA/srp: Set scmnd->result only when scmnd is not NULL
---
Documentation/admin-guide/cgroup-v1/memory.rst     |    2 +
 Documentation/arm64/silicon-errata.rst             |    2 +
 .../bindings/iio/gyroscope/bosch,bmg160.yaml       |    2 +
 Documentation/input/joydev/joystick.rst            |    1 +
 Makefile                                           |    8 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi        |   21 +-
 arch/arm/boot/dts/at91-sama5d2_icp.dts             |   21 +-
 arch/arm/boot/dts/at91-sama7g5ek.dts               |   20 +-
 arch/arm/boot/dts/imx28-evk.dts                    |    2 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |    2 +-
 arch/arm/boot/dts/imx28-sps1.dts                   |    2 +-
 arch/arm/boot/dts/imx6dl-rex-basic.dts             |    2 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |    2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |    2 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |    2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |    2 +-
 arch/arm/boot/dts/imx6q-dms-ba16.dts               |    2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |    2 +-
 arch/arm/boot/dts/imx6q-marsboard.dts              |    2 +-
 arch/arm/boot/dts/imx6q-rex-pro.dts                |    2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        |    2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |    2 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       |    2 +-
 arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi      |   14 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |    2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      |    2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |    2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |    2 +-
 arch/arm/boot/dts/imx6sl-evk.dts                   |    2 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |    2 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts              |    4 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                   |    4 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            |    2 +-
 arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi    |    2 +-
 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi    |    2 +-
 .../boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi  |    2 +-
 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi   |    2 +-
 arch/arm/mach-at91/pm.c                            |   36 +-
 arch/arm/mach-at91/pm_suspend.S                    |   24 +-
 arch/arm64/Kconfig                                 |   19 +
 arch/arm64/boot/dts/arm/juno-base.dtsi             |    3 +-
 arch/arm64/kernel/cacheinfo.c                      |    6 +-
 arch/arm64/kernel/cpu_errata.c                     |    9 +
 arch/arm64/kernel/cpufeature.c                     |    5 +-
 arch/arm64/kernel/entry-common.c                   |    8 +-
 arch/arm64/kernel/hibernate.c                      |    5 +
 arch/arm64/kernel/mte.c                            |    9 +
 arch/arm64/kernel/topology.c                       |   32 +-
 arch/arm64/mm/copypage.c                           |    9 +
 arch/arm64/mm/mteswap.c                            |    9 +
 arch/arm64/tools/cpucaps                           |    1 +
 arch/mips/cavium-octeon/octeon-irq.c               |   10 +
 arch/mips/loongson32/ls1c/board.c                  |    1 -
 arch/parisc/Kconfig                                |   12 +-
 arch/parisc/include/asm/bitops.h                   |    8 -
 arch/parisc/kernel/head.S                          |   43 +-
 arch/powerpc/kernel/systbl.S                       |    1 +
 arch/riscv/mm/pageattr.c                           |    4 +-
 arch/s390/include/asm/hugetlb.h                    |    6 +-
 arch/s390/kernel/nmi.c                             |    2 +-
 arch/s390/kernel/setup.c                           |    1 +
 arch/s390/kernel/vmlinux.lds.S                     |    1 +
 arch/x86/include/asm/cpu_entry_area.h              |    2 +-
 arch/x86/include/asm/kvm-x86-ops.h                 |    1 +
 arch/x86/include/asm/kvm_host.h                    |    1 +
 arch/x86/include/asm/page_64.h                     |    2 +-
 arch/x86/kvm/svm/sev.c                             |    8 +
 arch/x86/kvm/svm/svm.c                             |    1 +
 arch/x86/kvm/svm/svm.h                             |    2 +
 arch/x86/kvm/vmx/vmx.c                             |    3 +-
 arch/x86/kvm/x86.c                                 |   30 +-
 arch/x86/kvm/x86.h                                 |    2 +-
 block/blk-core.c                                   |    4 +-
 drivers/acpi/resource.c                            |   10 +
 drivers/android/binder.c                           |   12 +
 drivers/android/binder_alloc.c                     |   11 +-
 drivers/base/dd.c                                  |   10 +
 drivers/block/xen-blkback/common.h                 |    3 +
 drivers/block/xen-blkback/xenbus.c                 |    6 +-
 drivers/block/xen-blkfront.c                       |   20 +-
 drivers/clk/bcm/clk-raspberrypi.c                  |   13 +-
 drivers/clk/clk.c                                  |    3 +-
 drivers/cpufreq/cpufreq.c                          |    2 +-
 drivers/firmware/efi/capsule-loader.c              |   31 +-
 drivers/firmware/efi/libstub/Makefile              |    7 +
 drivers/gpio/gpio-mockup.c                         |    9 +-
 drivers/gpio/gpio-mpc8xxx.c                        |    1 +
 drivers/gpio/gpio-pca953x.c                        |    8 +-
 drivers/gpio/gpio-rockchip.c                       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |    9 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |    9 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |    9 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |    5 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   25 -
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |    4 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |    4 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    2 +-
 drivers/gpu/drm/bridge/display-connector.c         |   86 +
 drivers/gpu/drm/drm_gem.c                          |   17 +-
 drivers/gpu/drm/drm_internal.h                     |    4 +-
 drivers/gpu/drm/drm_prime.c                        |   20 +-
 drivers/gpu/drm/i915/Makefile                      |    1 +
 drivers/gpu/drm/i915/display/g4x_dp.c              |    2 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |    1 +
 drivers/gpu/drm/i915/display/intel_backlight.c     | 1776 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_backlight.h     |   51 +
 drivers/gpu/drm/i915/display/intel_connector.c     |    4 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |    2 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |    1 +
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |    2 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |   22 +
 drivers/gpu/drm/i915/display/intel_lvds.c          |    1 +
 drivers/gpu/drm/i915/display/intel_opregion.c      |    3 +-
 drivers/gpu/drm/i915/display/intel_panel.c         | 1767 +------------------
 drivers/gpu/drm/i915/display/intel_panel.h         |   34 +-
 drivers/gpu/drm/i915/display/intel_quirks.c        |    3 +
 drivers/gpu/drm/i915/display/vlv_dsi.c             |    1 +
 drivers/gpu/drm/i915/gvt/handlers.c                |    2 +-
 drivers/gpu/drm/i915/intel_pm.c                    |    8 +-
 drivers/gpu/drm/meson/meson_plane.c                |    2 +-
 drivers/gpu/drm/meson/meson_viu.c                  |    2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |    2 +-
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |    4 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |    2 +-
 drivers/gpu/drm/msm/msm_rd.c                       |    3 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |   11 +
 drivers/gpu/drm/radeon/radeon_device.c             |    3 +
 drivers/gpu/drm/tegra/vic.c                        |    4 +-
 drivers/hid/intel-ish-hid/ishtp-hid.h              |    2 +-
 drivers/hid/intel-ish-hid/ishtp/client.c           |   68 +-
 drivers/hwmon/gpio-fan.c                           |    3 +
 drivers/hwmon/mr75203.c                            |   72 +-
 drivers/hwmon/tps23861.c                           |   10 +-
 drivers/iio/adc/ad7292.c                           |    4 +-
 drivers/iio/adc/mcp3911.c                          |   19 +-
 drivers/infiniband/core/cma.c                      |    4 +-
 drivers/infiniband/core/umem_odp.c                 |    2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |    2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |    7 +-
 drivers/infiniband/hw/irdma/uk.c                   |    7 +-
 drivers/infiniband/hw/irdma/verbs.c                |    7 +-
 drivers/infiniband/hw/mlx5/mad.c                   |    6 +
 drivers/infiniband/sw/siw/siw_qp_tx.c              |   18 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |    9 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |   14 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |    3 +-
 drivers/input/joystick/iforce/iforce-main.c        |    1 +
 drivers/input/joystick/iforce/iforce-serio.c       |    6 +-
 drivers/input/joystick/iforce/iforce-usb.c         |    8 +-
 drivers/input/joystick/iforce/iforce.h             |    6 +
 drivers/input/misc/rk805-pwrkey.c                  |    1 +
 drivers/input/touchscreen/goodix.c                 |    2 +
 drivers/iommu/amd/iommu.c                          |    3 +-
 drivers/iommu/intel/iommu.c                        |  128 +-
 drivers/md/md.c                                    |    1 +
 drivers/media/rc/mceusb.c                          |   35 +-
 drivers/misc/fastrpc.c                             |   12 +-
 drivers/mmc/core/sd.c                              |   46 +-
 drivers/net/dsa/xrs700x/xrs700x.c                  |    5 +-
 drivers/net/ethernet/broadcom/tg3.c                |    8 +-
 drivers/net/ethernet/cortina/gemini.c              |   24 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c      |   16 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   12 +-
 drivers/net/ethernet/huawei/hinic/hinic_rx.c       |    4 +-
 drivers/net/ethernet/huawei/hinic/hinic_tx.c       |    4 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |   14 +
 drivers/net/ethernet/intel/i40e/i40e_client.c      |    5 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   23 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |    3 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   14 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |    2 +-
 .../net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h  |    4 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_mdio.c |  122 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h |    2 +
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |    2 +
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |    8 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |    8 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c         |    2 +-
 drivers/net/ethernet/smsc/smsc911x.c               |    6 +
 drivers/net/ieee802154/adf7242.c                   |    3 +-
 drivers/net/ieee802154/cc2520.c                    |    1 +
 drivers/net/netdevsim/netdev.c                     |    4 +-
 drivers/net/phy/meson-gxl.c                        |    8 +-
 drivers/net/usb/qmi_wwan.c                         |    1 +
 drivers/net/wireless/intel/iwlegacy/4965-rs.c      |    5 +-
 drivers/net/wireless/mac80211_hwsim.c              |    7 +-
 drivers/net/wireless/microchip/wilc1000/netdev.h   |    1 +
 drivers/net/wireless/microchip/wilc1000/sdio.c     |   39 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   15 +-
 drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c      |   10 -
 drivers/net/xen-netback/xenbus.c                   |    2 +-
 drivers/nvme/host/tcp.c                            |    7 +-
 drivers/nvme/target/core.c                         |    6 +-
 drivers/nvme/target/tcp.c                          |    3 +
 drivers/nvme/target/zns.c                          |   17 +-
 drivers/of/fdt.c                                   |    2 +-
 drivers/parisc/ccio-dma.c                          |   12 +-
 drivers/perf/arm_pmu_platform.c                    |    2 +-
 drivers/pinctrl/qcom/pinctrl-sc8180x.c             |   10 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c      |    2 +-
 .../platform/surface/surface_aggregator_registry.c |    3 +
 drivers/platform/x86/acer-wmi.c                    |    9 +-
 drivers/platform/x86/pmc_atom.c                    |    2 +-
 drivers/regulator/core.c                           |    9 +-
 drivers/regulator/pfuze100-regulator.c             |    2 +-
 drivers/scsi/lpfc/lpfc_init.c                      |    5 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |    4 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |    1 -
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |    2 +-
 drivers/scsi/qla2xxx/qla_target.c                  |   10 +-
 drivers/scsi/ufs/ufshcd.c                          |    9 +-
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                |   50 +-
 drivers/soc/fsl/Kconfig                            |    1 +
 drivers/soc/imx/gpcv2.c                            |    5 +-
 drivers/soundwire/qcom.c                           |    6 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c          |    1 +
 drivers/staging/rtl8712/rtl8712_cmd.c              |   36 -
 drivers/tee/tee_shm.c                              |    1 +
 drivers/thunderbolt/ctl.c                          |    2 +-
 drivers/tty/n_gsm.c                                |    3 +-
 drivers/tty/serial/atmel_serial.c                  |    8 +-
 drivers/tty/serial/fsl_lpuart.c                    |    5 +-
 drivers/tty/vt/vt.c                                |   12 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |    4 +-
 drivers/usb/class/cdc-acm.c                        |    3 +
 drivers/usb/core/hub.c                             |   10 +
 drivers/usb/dwc2/platform.c                        |    8 +-
 drivers/usb/dwc3/core.c                            |   19 +-
 drivers/usb/dwc3/dwc3-pci.c                        |    4 +
 drivers/usb/dwc3/dwc3-qcom.c                       |   14 +-
 drivers/usb/dwc3/host.c                            |   11 +
 drivers/usb/gadget/function/f_uac2.c               |   30 +-
 drivers/usb/gadget/function/storage_common.c       |    6 +-
 drivers/usb/host/xhci-hub.c                        |   13 +-
 drivers/usb/host/xhci-mtk-sch.c                    |   15 +-
 drivers/usb/host/xhci.c                            |   19 +-
 drivers/usb/host/xhci.h                            |    4 +-
 drivers/usb/musb/Kconfig                           |    2 +-
 drivers/usb/serial/ch341.c                         |   16 +-
 drivers/usb/serial/cp210x.c                        |    1 +
 drivers/usb/serial/ftdi_sio.c                      |    2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |    6 +
 drivers/usb/serial/option.c                        |   15 +
 drivers/usb/storage/unusual_devs.h                 |    7 +
 drivers/usb/storage/unusual_uas.h                  |    7 +
 drivers/usb/typec/altmodes/displayport.c           |    4 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |    9 +-
 drivers/usb/typec/tcpm/tcpm.c                      |    7 +
 drivers/vfio/vfio_iommu_type1.c                    |   12 +
 drivers/video/fbdev/chipsfb.c                      |    1 +
 drivers/video/fbdev/core/fbsysfs.c                 |    4 +
 drivers/video/fbdev/i740fb.c                       |    3 +
 drivers/video/fbdev/pxa3xx-gcu.c                   |    2 +-
 drivers/xen/grant-table.c                          |    3 +
 fs/afs/flock.c                                     |    2 +-
 fs/afs/fsclient.c                                  |    2 +-
 fs/afs/internal.h                                  |    3 +-
 fs/afs/misc.c                                      |    1 +
 fs/afs/rxrpc.c                                     |    7 +-
 fs/afs/yfsclient.c                                 |    3 +-
 fs/btrfs/zoned.c                                   |   15 +-
 fs/cifs/connect.c                                  |   11 +-
 fs/cifs/file.c                                     |    3 +
 fs/cifs/smb2pdu.c                                  |   12 +-
 fs/cifs/transport.c                                |    6 +-
 fs/debugfs/inode.c                                 |   22 +
 fs/erofs/internal.h                                |   29 -
 fs/nfs/dir.c                                       |   16 +-
 fs/nfs/file.c                                      |   15 +-
 fs/nfs/inode.c                                     |   27 +-
 fs/nfs/super.c                                     |   27 +-
 fs/nfs/write.c                                     |    6 +-
 fs/tracefs/inode.c                                 |   31 +-
 include/linux/buffer_head.h                        |   11 +
 include/linux/debugfs.h                            |    6 +
 include/linux/intel-iommu.h                        |    9 +-
 include/linux/irqflags.h                           |    4 +-
 include/linux/kvm_host.h                           |    4 +-
 include/linux/nfs_fs.h                             |   52 +-
 include/linux/of_device.h                          |    5 +-
 include/linux/platform_data/x86/pmc_atom.h         |    6 +-
 include/linux/sched/task_stack.h                   |    2 +-
 include/linux/skbuff.h                             |   49 +-
 include/linux/udp.h                                |    1 +
 include/linux/usb.h                                |    2 +
 include/linux/usb/typec_dp.h                       |    5 +
 include/net/udp_tunnel.h                           |    4 +
 include/net/xfrm.h                                 |    2 +
 include/soc/at91/sama7-ddr.h                       |   12 +-
 init/Kconfig                                       |    1 -
 kernel/bpf/cgroup.c                                |    4 +-
 kernel/bpf/syscall.c                               |    2 +-
 kernel/cgroup/cgroup-v1.c                          |    2 +
 kernel/cgroup/cgroup.c                             |   85 +-
 kernel/cgroup/cpuset.c                             |    3 +-
 kernel/dma/swiotlb.c                               |    5 +-
 kernel/entry/common.c                              |    6 +-
 kernel/fork.c                                      |    1 +
 kernel/kprobes.c                                   |    1 +
 kernel/locking/lockdep.c                           |   22 +-
 kernel/sched/debug.c                               |    2 +-
 kernel/sched/idle.c                                |    2 +-
 kernel/trace/trace_events_trigger.c                |    3 +-
 kernel/trace/trace_preemptirq.c                    |    8 +-
 localversion-rt                                    |    2 +-
 mm/kmemleak.c                                      |    8 +-
 mm/memcontrol.c                                    |  232 ++-
 mm/mmap.c                                          |    9 +-
 mm/pagewalk.c                                      |   21 +-
 mm/ptdump.c                                        |    4 +-
 net/bridge/br_netfilter_hooks.c                    |    2 +
 net/bridge/br_netfilter_ipv6.c                     |    1 +
 net/core/datagram.c                                |    2 +-
 net/core/skbuff.c                                  |    5 +-
 net/core/skmsg.c                                   |    4 +-
 net/dsa/tag_hellcreek.c                            |    2 +-
 net/ipv4/fib_frontend.c                            |    4 +-
 net/ipv4/ip_output.c                               |    2 +-
 net/ipv4/tcp.c                                     |    2 +-
 net/ipv4/tcp_input.c                               |   29 +-
 net/ipv4/tcp_ipv4.c                                |    2 +
 net/ipv4/udp.c                                     |    2 +
 net/ipv4/udp_tunnel_core.c                         |    1 +
 net/ipv6/seg6.c                                    |    5 +
 net/ipv6/tcp_ipv6.c                                |    5 +-
 net/ipv6/udp.c                                     |    5 +-
 net/kcm/kcmsock.c                                  |   15 +-
 net/mac80211/ibss.c                                |    4 +
 net/mac80211/scan.c                                |   11 +-
 net/mac80211/sta_info.c                            |    8 +-
 net/mac802154/rx.c                                 |    2 +-
 net/mpls/af_mpls.c                                 |    4 +-
 net/netfilter/nf_conntrack_irc.c                   |    5 +-
 net/netfilter/nf_conntrack_proto_tcp.c             |   31 +
 net/netfilter/nf_tables_api.c                      |    4 +-
 net/openvswitch/datapath.c                         |    4 +-
 net/rxrpc/ar-internal.h                            |    1 +
 net/rxrpc/call_event.c                             |    2 +-
 net/rxrpc/local_object.c                           |    4 +
 net/rxrpc/peer_event.c                             |  293 +++-
 net/rxrpc/rxkad.c                                  |    2 +-
 net/sched/sch_generic.c                            |   31 +-
 net/sched/sch_sfb.c                                |   13 +-
 net/sched/sch_tbf.c                                |    4 +-
 net/smc/af_smc.c                                   |    1 -
 net/tipc/monitor.c                                 |    2 +-
 net/wireless/debugfs.c                             |    3 +-
 scripts/Makefile.modfinal                          |    2 +-
 scripts/link-vmlinux.sh                            |   11 +-
 scripts/mksysmap                                   |    2 +-
 scripts/pahole-flags.sh                            |   24 +
 sound/core/oss/pcm_oss.c                           |    6 +-
 sound/core/seq/oss/seq_oss_midi.c                  |    2 +
 sound/core/seq/seq_clientmgr.c                     |   12 +-
 sound/drivers/aloop.c                              |    7 +-
 sound/hda/intel-nhlt.c                             |   25 +-
 sound/pci/emu10k1/emupcm.c                         |    2 +-
 sound/pci/hda/hda_tegra.c                          |    3 +-
 sound/pci/hda/patch_realtek.c                      |   63 +-
 sound/pci/hda/patch_sigmatel.c                     |   24 +
 sound/soc/atmel/mchp-spdiftx.c                     |   10 +-
 sound/soc/codecs/nau8824.c                         |   17 +-
 sound/soc/qcom/sm8250.c                            |    1 +
 sound/usb/card.c                                   |    2 +-
 sound/usb/endpoint.c                               |   23 +-
 sound/usb/endpoint.h                               |    6 +-
 sound/usb/pcm.c                                    |   14 +-
 sound/usb/quirks.c                                 |    2 +-
 sound/usb/stream.c                                 |    9 +-
 tools/include/uapi/asm/errno.h                     |    4 +-
 tools/perf/builtin-script.c                        |    3 +
 tools/perf/util/machine.c                          |    3 +-
 virt/kvm/kvm_main.c                                |   27 +-
 381 files changed, 4547 insertions(+), 3055 deletions(-)
---
