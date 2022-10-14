Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BCC5FF44C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJNUI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJNUIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:08:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157D1D3476;
        Fri, 14 Oct 2022 13:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F552B8241A;
        Fri, 14 Oct 2022 20:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAA2C433D6;
        Fri, 14 Oct 2022 20:08:49 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.73-rt52
Date:   Fri, 14 Oct 2022 20:08:05 -0000
Message-ID: <166577808561.525374.10868899271798309070@puck.lan>
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

I'm pleased to announce the 5.15.73-rt52 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 93aa05d95939d41da7c8e94f8fc4d20d0291742c

Or to build 5.15.73-rt52 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.73.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.73-rt52.patch.xz


Enjoy!
Clark

Changes from v5.15.71-rt51:
---

Aidan MacDonald (1):
      clk: ingenic-tcu: Properly enable registers before accessing timers

Alexander Couzens (1):
      net: mt7531: only do PLL once after the reset

Alexander Sergeyev (1):
      ALSA: hda/realtek: fix speakers and micmute on HP 855 G8

Alistair Popple (1):
      mm/migrate_device.c: flush TLB while holding PTL

Angus Chen (1):
      vdpa/ifcvf: fix the calculation of queuepair

Binyi Han (1):
      mm: fix dereferencing possible ERR_PTR

Bokun Zhang (1):
      drm/amdgpu: Add amdgpu suspend-resume code path under SRIOV

Brian Norris (2):
      Revert "drm: bridge: analogix/dp: add panel prepare/unprepare in suspend/resume time"
      mmc: core: Terminate infinite loop in SD-UHS voltage switch

Cai Huoqing (1):
      soc: sunxi_sram: Make use of the helper function devm_platform_ioremap_resource()

ChanWoo Lee (1):
      mmc: core: Replace with already defined values for readability

ChenXiaoSong (1):
      ntfs: fix BUG_ON in ntfs_lookup_inode_by_name()

Chris Wilson (2):
      drm/i915/gt: Restrict forced preemption to the active context
      drm/i915/gem: Really move i915_gem_context.link under ref protection

Clark Williams (2):
      Merge tag 'v5.15.73' into v5.15-rt-next
      'Linux 5.15.73-rt52'

Cristian Marussi (3):
      firmware: arm_scmi: Improve checks in the info_get operations
      firmware: arm_scmi: Harden accesses to the sensor domains
      firmware: arm_scmi: Add SCMI PM driver remove routine

David Gow (1):
      arch: um: Mark the stack non-executable to fix a binutils warning

Dongliang Mu (1):
      fs: fix UAF/GPF bug in nilfs_mdt_destroy

Florian Fainelli (1):
      clk: iproc: Do not rely on node name for correct PLL setup

Francesco Dolcini (1):
      drm/bridge: lt8912b: fix corrupted image output

Frank Wunderlich (1):
      net: usb: qmi_wwan: Add new usb-id for Dell branded EM7455

Greg Kroah-Hartman (3):
      mm/damon/dbgfs: fix memory leak when using debugfs_lookup()
      Linux 5.15.72
      Linux 5.15.73

Haimin Zhang (1):
      net/ieee802154: fix uninit value bug in dgram_sendmsg

Han Xu (1):
      clk: imx: imx6sx: remove the SET_RATE_PARENT flag for QSPI clocks

Hangyu Hua (2):
      media: dvb_vb2: fix possible out of bound access
      net: sched: act_ct: fix possible refcount leak in tcf_ct_init()

Hans Verkuil (1):
      media: v4l2-compat-ioctl32.c: zero buffer passed to v4l2_compat_get_array_args()

Hans de Goede (1):
      wifi: mac80211: fix regression with non-QoS drivers

Heikki Krogerus (1):
      usb: typec: ucsi: Remove incorrect warning

Hongling Zeng (3):
      uas: add no-uas quirk for Hiksemi usb_disk
      usb-storage: Add Hiksemi USB3-FW to IGNORE_UAS
      uas: ignore UAS for Thinkplus chips

Hugo Hu (1):
      drm/amd/display: update gamut remap if plane has changed

Ian Rogers (1):
      perf parse-events: Identify broken modifiers

Jalal Mostafa (1):
      xsk: Inherit need_wakeup flag for shared sockets

Jarkko Sakkinen (1):
      x86/sgx: Do not fail on incomplete sanitization on premature stop of ksgxd

Jaroslav Kysela (1):
      ALSA: hda/hdmi: Fix the converter reuse for the silent stream

Jianglei Nie (1):
      net: atlantic: fix potential memory leak in aq_ndev_close()

Jim Mattson (1):
      KVM: x86: Hide IA32_PLATFORM_DCA_CAP[31:0] from the guest

Johan Hovold (2):
      arm64: dts: qcom: sm8350: fix UFS PHY serdes size
      USB: serial: ftdi_sio: fix 300 bps rate for SIO

Junxiao Chang (1):
      net: stmmac: power up/down serdes in stmmac_open/release

Krzysztof Kozlowski (1):
      rpmsg: qcom: glink: replace strncpy() with strscpy_pad()

Leo Li (1):
      drm/amd/display: Fix double cursor on non-video RGB MPO

Letu Ren (1):
      scsi: qedf: Fix a UAF bug in __qedf_probe()

Linus Walleij (1):
      ARM: dts: integrator: Tag PCI host with device_type

Lukas Straub (2):
      um: Cleanup syscall_handler_t cast in syscalls_32.h
      um: Cleanup compiler warning in arch/x86/um/tls_32.c

Lukas Wunner (1):
      net: phy: Don't WARN for PHY_UP state in mdio_bus_phy_resume()

Marc Kleine-Budde (1):
      can: c_can: don't cache TX messages for C_CAN cores

Mario Limonciello (1):
      thunderbolt: Explicitly reset plug events delay back to USB4 spec value

Martin Povišer (1):
      ASoC: tas2770: Reinit regcache on reset

Maurizio Lombardi (1):
      mm: prevent page_frag_alloc() from corrupting the memory

Maxime Coquelin (1):
      vduse: prevent uninitialized memory accesses

Mel Gorman (1):
      mm/page_alloc: fix race condition between build_all_zonelists and page allocation

Miaohe Lin (1):
      mm/huge_memory: minor cleanup for split_huge_pages_all

Michael Kelley (1):
      nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for nvme devices

Michael Strauss (1):
      drm/amd/display: Assume an LTTPR is always present on fixed_vs links

Minchan Kim (1):
      mm: fix madivse_pageout mishandling on non-LRU page

Ming Lei (1):
      cgroup: cgroup_get_from_id() must check the looked-up kn is a directory

Mohan Kumar (1):
      ALSA: hda: Fix Nvidia dp infoframe

Nadav Amit (1):
      x86/alternative: Fix race in try_get_desc()

Naoya Horiguchi (1):
      mm/huge_memory: use pfn_to_online_page() in split_huge_pages_all()

Nicolas Dufresne (1):
      media: rkvdec: Disable H.264 error detection

Niklas Cassel (1):
      libata: add ATA_HORKAGE_NOLPM for Pioneer BDR-207M and BDR-205

Oleksandr Mazur (1):
      net: marvell: prestera: add support for for Aldrin2

Pali Rohár (1):
      gpio: mvebu: Fix check for pwm support on non-A8K platforms

Peilin Ye (1):
      usbnet: Fix memory leak in usbnet_disconnect()

Peng Wu (1):
      net/mlxbf_gige: Fix an IS_ERR() vs NULL bug in mlxbf_gige_mdio_probe

Philippe Schenker (2):
      drm/bridge: lt8912b: add vsync hsync
      drm/bridge: lt8912b: set hdmi or dvi mode

Rafael Mendonca (1):
      cxgb4: fix missing unlock on ETHOFLD desc collect fail path

Richard Zhu (1):
      reset: imx7: Fix the iMX8MP PCIe PHY PERST support

Romain Naour (1):
      ARM: dts: am5748: keep usb4_tm disabled

Sami Tolvanen (1):
      Makefile.extrawarn: Move -Wcast-function-type-strict to W=1

Samuel Holland (4):
      soc: sunxi: sram: Actually claim SRAM regions
      soc: sunxi: sram: Prevent the driver from being unbound
      soc: sunxi: sram: Fix probe function ordering issues
      soc: sunxi: sram: Fix debugfs info for A64 SRAM C

Sasha Levin (1):
      Revert "clk: ti: Stop using legacy clkctrl names for omap4 and 5"

Sebastian Krzyszkowiak (1):
      Input: snvs_pwrkey - fix SNVS_HPVIDR1 register address

Sergei Antonov (2):
      mmc: moxart: fix 4-bit bus width and remove 8-bit bus width
      ARM: dts: fix Moxa SDIO 'compatible', remove 'sdhci' misnomer

Shakeel Butt (1):
      cgroup: reduce dependency on cgroup_mutex

Shengjiu Wang (1):
      ASoC: imx-card: Fix refcount issue with of_node_put

Shuah Khan (1):
      docs: update mediator information in CoC docs

Shuai Xue (1):
      mm,hwpoison: check mm when killing accessing process

Stefan Roesch (1):
      fs: split off setxattr_copy and do_setxattr function from setxattr

Swati Agarwal (3):
      dmaengine: xilinx_dma: Fix devm_platform_ioremap_resource error handling
      dmaengine: xilinx_dma: cleanup for fetching xlnx,num-fstores property
      dmaengine: xilinx_dma: Report error in case of dma_set_mask_and_coherent API failure

Tadeusz Struk (1):
      usb: mon: make mmapped memory read only

Takashi Iwai (2):
      ALSA: hda: Do disconnect jacks at codec unbind
      ALSA: hda: Fix hang at HD-audio codec unbinding due to refcount saturation

Tamizh Chelvam Raja (1):
      wifi: cfg80211: fix MCS divisor value

Tianyu Lan (1):
      swiotlb: max mapping size takes min align mask into account

Ulf Hansson (1):
      Revert "firmware: arm_scmi: Add clock management to the SCMI power domain"

Vlad Buslov (1):
      net/mlx5: Disable irq when locking lag_lock

Wang Yufen (1):
      selftests: Fix the if conditions of in test_extra_filter()

Wenchao Chen (1):
      mmc: hsq: Fix data stomping during mmc recovery

Yang Shi (2):
      mm: gup: fix the fast GUP race against THP collapse
      powerpc/64s/radix: don't need to broadcast IPI for radix pmd collapse flush

Yang Yingliang (1):
      Input: melfas_mip4 - fix return value check in mip4_probe()

YuTong Chang (1):
      ARM: dts: am33xx: Fix MMCHS0 dma properties

zhikzhai (1):
      drm/amd/display: skip audio setup when audio stream is enabled
---
.../devicetree/bindings/dma/moxa,moxart-dma.txt    |   4 +-
 .../process/code-of-conduct-interpretation.rst     |   2 +-
 Makefile                                           |   2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                   |   3 +-
 arch/arm/boot/dts/am5748.dtsi                      |   4 +
 arch/arm/boot/dts/integratorap.dts                 |   1 +
 arch/arm/boot/dts/moxart-uc7112lx.dts              |   2 +-
 arch/arm/boot/dts/moxart.dtsi                      |   4 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   2 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |   9 -
 arch/um/Makefile                                   |   8 +
 arch/x86/kernel/alternative.c                      |  45 ++---
 arch/x86/kernel/cpu/sgx/main.c                     |  15 +-
 arch/x86/kvm/cpuid.c                               |   2 -
 arch/x86/um/shared/sysdep/syscalls_32.h            |   5 +-
 arch/x86/um/tls_32.c                               |   6 -
 arch/x86/um/vdso/Makefile                          |   2 +-
 drivers/ata/libata-core.c                          |   4 +
 drivers/clk/bcm/clk-iproc-pll.c                    |  12 +-
 drivers/clk/imx/clk-imx6sx.c                       |   4 +-
 drivers/clk/ingenic/tcu.c                          |  15 +-
 drivers/clk/ti/clk-44xx.c                          | 210 ++++++++++-----------
 drivers/clk/ti/clk-54xx.c                          | 160 ++++++++--------
 drivers/clk/ti/clkctrl.c                           |   4 +
 drivers/dma/xilinx/xilinx_dma.c                    |  21 ++-
 drivers/firmware/arm_scmi/clock.c                  |   6 +-
 drivers/firmware/arm_scmi/scmi_pm_domain.c         |  46 ++---
 drivers/firmware/arm_scmi/sensors.c                |  25 ++-
 drivers/gpio/gpio-mvebu.c                          |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  27 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  12 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   8 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   1 +
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  13 --
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |  13 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |   8 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |  15 ++
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |  21 ++-
 drivers/input/keyboard/snvs_pwrkey.c               |   2 +-
 drivers/input/touchscreen/melfas_mip4.c            |   2 +-
 drivers/media/dvb-core/dvb_vb2.c                   |  11 ++
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |   2 +
 drivers/mmc/core/sd.c                              |   3 +-
 drivers/mmc/host/mmc_hsq.c                         |   2 +-
 drivers/mmc/host/moxart-mmc.c                      |  17 +-
 drivers/net/can/c_can/c_can.h                      |  17 +-
 drivers/net/can/c_can/c_can_main.c                 |  11 +-
 drivers/net/dsa/mt7530.c                           |  15 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c   |   3 -
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c     |  28 ++-
 .../net/ethernet/marvell/prestera/prestera_pci.c   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/lag.c      |  55 +++---
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_mdio.c |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  23 ++-
 drivers/net/phy/phy_device.c                       |  10 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/usbnet.c                           |   7 +-
 drivers/nvme/host/core.c                           |   6 +-
 drivers/reset/reset-imx7.c                         |   1 +
 drivers/rpmsg/qcom_glink_native.c                  |   2 +-
 drivers/rpmsg/qcom_smd.c                           |   4 +-
 drivers/scsi/qedf/qedf_main.c                      |   5 -
 drivers/soc/sunxi/sunxi_sram.c                     |  27 ++-
 drivers/staging/media/rkvdec/rkvdec-h264.c         |   4 +-
 drivers/thunderbolt/switch.c                       |   1 +
 drivers/usb/mon/mon_bin.c                          |   5 +
 drivers/usb/serial/ftdi_sio.c                      |   3 +-
 drivers/usb/storage/unusual_uas.h                  |  21 +++
 drivers/usb/typec/ucsi/ucsi.c                      |   2 -
 drivers/vdpa/ifcvf/ifcvf_base.c                    |   4 +-
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   9 +-
 fs/inode.c                                         |   7 +-
 fs/internal.h                                      |  24 +++
 fs/ntfs/super.c                                    |   3 +-
 fs/xattr.c                                         |  84 ++++++---
 include/linux/scmi_protocol.h                      |   4 +-
 include/net/ieee802154_netdev.h                    |  37 ++++
 include/net/xsk_buff_pool.h                        |   2 +-
 kernel/cgroup/cgroup.c                             |  54 +++---
 kernel/dma/swiotlb.c                               |  13 +-
 localversion-rt                                    |   2 +-
 mm/damon/dbgfs.c                                   |  19 +-
 mm/gup.c                                           |  34 +++-
 mm/huge_memory.c                                   |  13 +-
 mm/khugepaged.c                                    |  10 +-
 mm/madvise.c                                       |   7 +-
 mm/memory-failure.c                                |   3 +
 mm/migrate.c                                       |   5 +-
 mm/page_alloc.c                                    |  65 ++++++-
 mm/secretmem.c                                     |   2 +-
 net/ieee802154/socket.c                            |  42 +++--
 net/mac80211/tx.c                                  |   4 +
 net/sched/act_ct.c                                 |   5 +-
 net/wireless/util.c                                |   2 +-
 net/xdp/xsk.c                                      |   4 +-
 net/xdp/xsk_buff_pool.c                            |   5 +-
 scripts/Makefile.extrawarn                         |   1 +
 sound/pci/hda/hda_bind.c                           |   6 +-
 sound/pci/hda/hda_jack.c                           |  11 ++
 sound/pci/hda/hda_jack.h                           |   1 +
 sound/pci/hda/patch_hdmi.c                         |  24 ++-
 sound/pci/hda/patch_realtek.c                      |  12 ++
 sound/soc/codecs/tas2770.c                         |   3 +
 sound/soc/fsl/imx-card.c                           |   4 +
 tools/perf/util/parse-events.y                     |  10 +
 tools/testing/selftests/net/reuseport_bpf.c        |   2 +-
 108 files changed, 1021 insertions(+), 577 deletions(-)
---
