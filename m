Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B439706765
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjEQMBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjEQMBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B962527D;
        Wed, 17 May 2023 05:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A03B645F9;
        Wed, 17 May 2023 12:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83220C433EF;
        Wed, 17 May 2023 12:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324826;
        bh=6IsAhZFX9pfDCvfduGKGdpKEcM0B1YGydXx4Mb5Sm3c=;
        h=From:To:Cc:Subject:Date:From;
        b=hL6I9ERkDcmqK/3aUhvtAIoh/OoPcGOawaewo33nNqefse81H/GPG9amYLAic5bWi
         fniGqQMUnq/lrk8I3Fe2PWIiaLRcfwfAFqOYGwHG70ofhuICMhFEhdULrYexcZ3n7t
         YCuuj+gUxSvl1uXHzFsaU5yMXRMmdQgtQW4rW1ak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.243
Date:   Wed, 17 May 2023 14:00:22 +0200
Message-Id: <2023051722-harmless-excusably-7a79@gregkh>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.4.243 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/media/uapi/v4l/subdev-formats.rst             |   27 +
 Makefile                                                    |    2 
 arch/arm/boot/dts/exynos4412-itop-elite.dts                 |    2 
 arch/arm/boot/dts/qcom-ipq4019.dtsi                         |    4 
 arch/arm/boot/dts/qcom-ipq8064.dtsi                         |   12 
 arch/arm/boot/dts/s5pv210.dtsi                              |    2 
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi                   |    3 
 arch/arm64/boot/dts/renesas/r8a77990.dtsi                   |    3 
 arch/arm64/include/asm/debug-monitors.h                     |    1 
 arch/arm64/kernel/debug-monitors.c                          |    5 
 arch/arm64/kernel/kgdb.c                                    |    2 
 arch/ia64/kernel/salinfo.c                                  |    2 
 arch/ia64/mm/contig.c                                       |    2 
 arch/mips/fw/lib/cmdline.c                                  |    2 
 arch/openrisc/kernel/entry.S                                |    6 
 arch/parisc/kernel/real2.S                                  |    5 
 arch/powerpc/kernel/rtas.c                                  |    2 
 arch/powerpc/platforms/512x/clock-commonclk.c               |    2 
 arch/powerpc/platforms/embedded6xx/flipper-pic.c            |    2 
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c               |    2 
 arch/powerpc/platforms/embedded6xx/wii.c                    |    4 
 arch/powerpc/sysdev/tsi108_pci.c                            |    5 
 arch/sh/kernel/cpu/sh4/sq.c                                 |    2 
 arch/sh/kernel/head_32.S                                    |    6 
 arch/sh/kernel/nmi_debug.c                                  |    4 
 arch/sh/kernel/setup.c                                      |    4 
 arch/sh/math-emu/sfp-util.h                                 |    4 
 arch/x86/kernel/apic/apic.c                                 |    5 
 arch/x86/kernel/apic/io_apic.c                              |   14 
 arch/x86/kvm/vmx/vmx.c                                      |   15 
 crypto/drbg.c                                               |   16 
 drivers/base/cpu.c                                          |    3 
 drivers/base/power/domain.c                                 |  194 ++++----
 drivers/base/power/domain_governor.c                        |   12 
 drivers/block/drbd/drbd_receiver.c                          |    2 
 drivers/bluetooth/btsdio.c                                  |    1 
 drivers/char/ipmi/ipmi_ssif.c                               |    8 
 drivers/char/tpm/tpm_tis_core.c                             |   29 -
 drivers/clk/clk-conf.c                                      |   12 
 drivers/clk/rockchip/clk-rk3399.c                           |    2 
 drivers/clocksource/timer-davinci.c                         |   48 +-
 drivers/counter/104-quad-8.c                                |   30 -
 drivers/crypto/inside-secure/safexcel.c                     |   50 +-
 drivers/crypto/inside-secure/safexcel.h                     |    3 
 drivers/dma/at_xdmac.c                                      |    5 
 drivers/dma/dw-edma/dw-edma-core.c                          |   27 -
 drivers/dma/mv_xor_v2.c                                     |    2 
 drivers/edac/skx_base.c                                     |    4 
 drivers/firmware/qcom_scm.c                                 |    3 
 drivers/firmware/raspberrypi.c                              |   70 ++
 drivers/firmware/stratix10-svc.c                            |    4 
 drivers/fpga/fpga-bridge.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c                   |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                       |    3 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                       |    1 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                      |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |    5 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           |    3 
 drivers/gpu/drm/drm_fb_helper.c                             |    3 
 drivers/gpu/drm/drm_probe_helper.c                          |    5 
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c               |    4 
 drivers/gpu/drm/exynos/exynos_drm_dsi.c                     |    7 
 drivers/gpu/drm/lima/lima_drv.c                             |    6 
 drivers/gpu/drm/msm/adreno/adreno_device.c                  |    7 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                     |    5 
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c            |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                 |    3 
 drivers/gpu/drm/vgem/vgem_fence.c                           |    1 
 drivers/hid/wacom_wac.c                                     |   38 +
 drivers/hid/wacom_wac.h                                     |    1 
 drivers/i2c/busses/i2c-omap.c                               |    2 
 drivers/iio/adc/palmas_gpadc.c                              |    2 
 drivers/iio/light/max44009.c                                |   13 
 drivers/infiniband/hw/hfi1/mmu_rb.c                         |   13 
 drivers/infiniband/hw/mlx4/qp.c                             |    8 
 drivers/infiniband/hw/mlx5/qp.c                             |    2 
 drivers/infiniband/sw/rdmavt/qp.c                           |    2 
 drivers/infiniband/sw/siw/siw_main.c                        |    3 
 drivers/infiniband/sw/siw/siw_qp_tx.c                       |    2 
 drivers/input/touchscreen/raspberrypi-ts.c                  |    3 
 drivers/leds/Kconfig                                        |    2 
 drivers/macintosh/Kconfig                                   |    1 
 drivers/macintosh/windfarm_smu_sat.c                        |    1 
 drivers/mailbox/zynqmp-ipi-mailbox.c                        |   19 
 drivers/md/dm-clone-target.c                                |    1 
 drivers/md/dm-flakey.c                                      |    4 
 drivers/md/dm-integrity.c                                   |    8 
 drivers/md/dm-ioctl.c                                       |    7 
 drivers/md/dm-verity-target.c                               |   17 
 drivers/md/raid10.c                                         |   96 ++--
 drivers/md/raid5.c                                          |   10 
 drivers/media/pci/dm1105/dm1105.c                           |    1 
 drivers/media/pci/saa7134/saa7134-ts.c                      |    1 
 drivers/media/pci/saa7134/saa7134-vbi.c                     |    1 
 drivers/media/pci/saa7134/saa7134-video.c                   |    1 
 drivers/media/pci/ttpci/av7110_av.c                         |    4 
 drivers/media/platform/rcar_fdp1.c                          |   50 +-
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c               |    2 
 drivers/media/rc/gpio-ir-recv.c                             |    2 
 drivers/misc/vmw_vmci/vmci_host.c                           |    8 
 drivers/mmc/host/sdhci-of-esdhc.c                           |   24 -
 drivers/mtd/spi-nor/cadence-quadspi.c                       |   77 +--
 drivers/mtd/ubi/eba.c                                       |   19 
 drivers/net/dsa/mt7530.c                                    |    4 
 drivers/net/dsa/mv88e6xxx/chip.c                            |    1 
 drivers/net/ethernet/amd/nmclan_cs.c                        |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c            |   23 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c         |    2 
 drivers/net/virtio_net.c                                    |   43 +
 drivers/net/wireless/ath/ath5k/eeprom.c                     |    2 
 drivers/net/wireless/ath/ath6kl/bmi.c                       |    2 
 drivers/net/wireless/ath/ath6kl/htc_pipe.c                  |    4 
 drivers/net/wireless/ath/ath9k/hif_usb.c                    |   19 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c            |   10 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c             |    3 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c      |    1 
 drivers/net/wireless/realtek/rtlwifi/base.c                 |  144 +++---
 drivers/net/wireless/realtek/rtlwifi/cam.c                  |   82 +--
 drivers/net/wireless/realtek/rtlwifi/core.c                 |  259 +++++------
 drivers/net/wireless/realtek/rtlwifi/debug.c                |   16 
 drivers/net/wireless/realtek/rtlwifi/debug.h                |   11 
 drivers/net/wireless/realtek/rtlwifi/efuse.c                |   72 +--
 drivers/net/wireless/realtek/rtlwifi/pci.c                  |  282 ++++++------
 drivers/net/wireless/realtek/rtlwifi/ps.c                   |   98 ++--
 drivers/net/wireless/realtek/rtlwifi/regd.c                 |   18 
 drivers/net/wireless/realtek/rtlwifi/usb.c                  |   18 
 drivers/net/wireless/realtek/rtw88/mac.c                    |    8 
 drivers/nvme/host/core.c                                    |   34 +
 drivers/nvme/host/trace.h                                   |   15 
 drivers/nvme/target/fcloop.c                                |   48 +-
 drivers/of/device.c                                         |    7 
 drivers/pci/controller/dwc/pci-imx6.c                       |    7 
 drivers/pci/hotplug/pciehp.h                                |    3 
 drivers/pci/hotplug/pciehp_core.c                           |    2 
 drivers/pci/hotplug/pciehp_hpc.c                            |   19 
 drivers/pci/hotplug/pciehp_pci.c                            |   15 
 drivers/phy/tegra/xusb.c                                    |    2 
 drivers/platform/x86/touchscreen_dmi.c                      |   24 +
 drivers/power/supply/generic-adc-battery.c                  |    3 
 drivers/pwm/pwm-meson.c                                     |    6 
 drivers/pwm/pwm-mtk-disp.c                                  |   94 +---
 drivers/regulator/core.c                                    |   93 +++
 drivers/regulator/stm32-pwr.c                               |    7 
 drivers/remoteproc/st_remoteproc.c                          |    5 
 drivers/remoteproc/stm32_rproc.c                            |    6 
 drivers/rtc/rtc-meson-vrtc.c                                |    4 
 drivers/rtc/rtc-omap.c                                      |    1 
 drivers/s390/block/dasd.c                                   |    2 
 drivers/scsi/lpfc/lpfc_init.c                               |   10 
 drivers/scsi/megaraid.c                                     |    1 
 drivers/spi/spi-fsl-spi.c                                   |   12 
 drivers/spi/spi-qup.c                                       |   22 
 drivers/spmi/spmi.c                                         |    3 
 drivers/staging/iio/resolver/ad2s1210.c                     |    2 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                |    1 
 drivers/target/iscsi/iscsi_target.c                         |   16 
 drivers/tty/serial/8250/8250.h                              |   12 
 drivers/tty/serial/8250/8250_port.c                         |   16 
 drivers/tty/serial/fsl_lpuart.c                             |    2 
 drivers/tty/tty_io.c                                        |    4 
 drivers/tty/tty_ioctl.c                                     |   45 +
 drivers/usb/chipidea/core.c                                 |    2 
 drivers/usb/dwc3/core.c                                     |   15 
 drivers/usb/gadget/udc/renesas_usb3.c                       |    1 
 drivers/usb/host/xhci-debugfs.c                             |    1 
 drivers/usb/host/xhci-rcar.c                                |    3 
 drivers/usb/mtu3/mtu3_qmu.c                                 |    5 
 drivers/usb/serial/option.c                                 |    6 
 fs/afs/inode.c                                              |    1 
 fs/btrfs/block-rsv.c                                        |    3 
 fs/btrfs/ctree.c                                            |   32 +
 fs/btrfs/ioctl.c                                            |    5 
 fs/btrfs/print-tree.c                                       |    6 
 fs/cifs/smb2ops.c                                           |    2 
 fs/debugfs/file.c                                           |    8 
 fs/erofs/internal.h                                         |    2 
 fs/erofs/zmap.c                                             |    4 
 fs/ext4/balloc.c                                            |   25 +
 fs/ext4/extents.c                                           |    3 
 fs/ext4/extents_status.c                                    |   30 -
 fs/ext4/inline.c                                            |   17 
 fs/ext4/mballoc.c                                           |    6 
 fs/ext4/super.c                                             |   19 
 fs/ext4/xattr.c                                             |    5 
 fs/f2fs/file.c                                              |   15 
 fs/f2fs/namei.c                                             |   16 
 fs/fs-writeback.c                                           |    2 
 fs/nfs/nfs4state.c                                          |    4 
 fs/nilfs2/bmap.c                                            |   16 
 fs/nilfs2/segment.c                                         |    5 
 fs/notify/inotify/inotify_fsnotify.c                        |   11 
 fs/pstore/pmsg.c                                            |    7 
 fs/reiserfs/xattr_security.c                                |    8 
 fs/ubifs/dir.c                                              |    1 
 fs/ubifs/tnc.c                                              |  142 +++---
 include/asm-generic/io.h                                    |    4 
 include/linux/debugfs.h                                     |    1 
 include/linux/interrupt.h                                   |    4 
 include/linux/mailbox/zynqmp-ipi-message.h                  |    2 
 include/linux/netfilter/nfnetlink.h                         |    1 
 include/linux/nvme.h                                        |    4 
 include/linux/pm_domain.h                                   |   12 
 include/linux/printk.h                                      |   19 
 include/linux/sunrpc/sched.h                                |    3 
 include/linux/tick.h                                        |    9 
 include/linux/tty.h                                         |    2 
 include/linux/vt_buffer.h                                   |    2 
 include/net/netfilter/nf_tables.h                           |    1 
 include/net/scm.h                                           |   13 
 include/soc/bcm2835/raspberrypi-firmware.h                  |   10 
 include/trace/events/timer.h                                |    3 
 include/uapi/linux/btrfs.h                                  |    1 
 include/uapi/linux/const.h                                  |    2 
 include/uapi/linux/media-bus-format.h                       |    8 
 kernel/bpf/cgroup.c                                         |    9 
 kernel/events/core.c                                        |    4 
 kernel/irq/manage.c                                         |   11 
 kernel/kheaders.c                                           |   10 
 kernel/relay.c                                              |   18 
 kernel/time/jiffies.c                                       |    7 
 kernel/time/tick-broadcast.c                                |    2 
 kernel/time/tick-common.c                                   |   30 -
 kernel/time/tick-internal.h                                 |    1 
 kernel/time/tick-sched.c                                    |  119 +++--
 kernel/time/timekeeping.c                                   |    6 
 kernel/time/timekeeping.h                                   |    3 
 kernel/trace/ring_buffer.c                                  |    4 
 lib/debugobjects.c                                          |  141 +++---
 mm/page_alloc.c                                             |   16 
 net/8021q/vlan_dev.c                                        |    2 
 net/bluetooth/hci_sock.c                                    |    9 
 net/core/skbuff.c                                           |    3 
 net/ipv4/ip_output.c                                        |   16 
 net/ipv6/sit.c                                              |    8 
 net/ncsi/ncsi-aen.c                                         |    1 
 net/netfilter/nf_tables_api.c                               |   20 
 net/netfilter/nfnetlink.c                                   |    2 
 net/netfilter/nft_dynset.c                                  |    2 
 net/netfilter/nft_lookup.c                                  |    2 
 net/netfilter/nft_objref.c                                  |    2 
 net/netlink/af_netlink.c                                    |   75 ---
 net/packet/af_packet.c                                      |   32 -
 net/packet/diag.c                                           |    4 
 net/packet/internal.h                                       |   26 -
 net/rxrpc/sendmsg.c                                         |    2 
 net/sched/act_mirred.c                                      |    2 
 net/sched/cls_api.c                                         |    1 
 net/sunrpc/clnt.c                                           |    3 
 net/sunrpc/sched.c                                          |    1 
 scripts/gdb/linux/clk.py                                    |    2 
 scripts/gdb/linux/genpd.py                                  |   16 
 scripts/gdb/linux/timerlist.py                              |    4 
 scripts/gdb/linux/utils.py                                  |    5 
 security/selinux/Makefile                                   |    4 
 sound/soc/codecs/es8316.c                                   |   17 
 sound/soc/intel/boards/bytcr_rt5640.c                       |   12 
 sound/usb/caiaq/input.c                                     |    1 
 tools/bpf/bpftool/json_writer.c                             |    3 
 tools/bpf/bpftool/xlated_dumper.c                           |    7 
 tools/perf/builtin-sched.c                                  |    2 
 tools/perf/pmu-events/arch/powerpc/power9/other.json        |    4 
 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json     |    2 
 tools/perf/util/auxtrace.c                                  |    5 
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c         |    2 
 tools/perf/util/sort.c                                      |    3 
 tools/perf/util/symbol-elf.c                                |    2 
 267 files changed, 2495 insertions(+), 1583 deletions(-)

Adrian Hunter (2):
      perf auxtrace: Fix address filter entire kernel size
      perf intel-pt: Fix CYC timestamps after standalone CBR

Akhil P Oommen (1):
      drm/msm/adreno: Fix null ptr access in adreno_gpu_cleanup()

Akilesh Kailash (1):
      dm verity: skip redundant verity_handle_err() on I/O errors

Alexander Mikhalitsyn (1):
      scm: fix MSG_CTRUNC setting condition for SO_PASSSEC

Alexey V. Vissarionov (1):
      wifi: ath6kl: minor fix for allocation size

Anastasia Belova (1):
      btrfs: print-tree: parent bytenr must be aligned to sector size

Andrey Avdeev (1):
      platform/x86: touchscreen_dmi: Add info for the Dexp Ursus KX210i

Angelo Dureghello (1):
      net: dsa: mv88e6xxx: add mv88e6321 rsvd2cpu

AngeloGioacchino Del Regno (1):
      pwm: mtk-disp: Disable shadow registers before setting backlight values

Arnaldo Carvalho de Melo (1):
      perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into sysconf(__SC_THREAD_STACK_MIN_VALUE)

Arınç ÜNAL (2):
      USB: serial: option: add UNISOC vendor and TOZED LT70C product
      net: dsa: mt7530: fix corrupt frames using trgmii on 40 MHz XTAL MT7621

Aurabindo Pillai (1):
      drm/amd/display: Fix hang when skipping modeset

Barry Song (1):
      genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()

Bitterblue Smith (1):
      wifi: rtl8xxxu: RTL8192EU always needs full init

Cai Huoqing (1):
      media: rcar_fdp1: Make use of the helper function devm_platform_ioremap_resource()

Chia-I Wu (1):
      drm/amdgpu: add a missing lock for AMDGPU_SCHED

Christian Marangi (1):
      ARM: dts: qcom: ipq8064: reduce pci IO size to 64K

Christoph Böhmwalder (1):
      drbd: correctly submit flush bio on barrier

Christoph Hellwig (1):
      md: update the optimal I/O size on reshape

Christophe JAILLET (4):
      clocksource/drivers/davinci: Avoid trailing '\n' hidden in pr_fmt()
      clocksource: davinci: axe a pointless __GFP_NOFAIL
      dmaengine: mv_xor_v2: Fix an error code.
      mailbox: zynq: Switch to flexible array to simplify code

Christophe Leroy (1):
      spi: fsl-spi: Fix CPM/QE mode Litte Endian

Chunfeng Yun (1):
      usb: mtu3: fix kernel panic at qmu transfer done irq handler

Claudiu Beznea (1):
      dmaengine: at_xdmac: do not enable all cyclic channels

Clément Léger (1):
      clk: add missing of_node_put() in "assigned-clocks" property parsing

Cong Wang (1):
      sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()

Corey Minyard (1):
      ipmi:ssif: Add send_retries increment

Cosmo Chou (1):
      net/ncsi: clear Tx enable mode when handling a Config required AEN

Cristian Ciocaltea (1):
      ASoC: es8316: Handle optional IRQ assignment

Dae R. Jeong (1):
      vmci_host: fix a race condition in vmci_host_poll() causing GPF

Dafna Hirschfeld (1):
      media: uapi: add MEDIA_BUS_FMT_METADATA_FIXED media bus format.

Dai Ngo (1):
      SUNRPC: remove the maximum number of retries in call_bind_status

Dan Carpenter (4):
      media: av7110: prevent underflow in write_ts_to_decoder()
      wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()
      firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
      RDMA/mlx4: Prevent shift wrapping in set_user_sq_size()

Daniel Borkmann (1):
      bpf, sockmap: Revert buggy deadlock fix in the sockhash and sockmap

Daniel Vetter (1):
      drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var

Daniil Dulov (1):
      RDMA/siw: Fix potential page_array out of range access

Danila Chernetsov (1):
      scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS

David Howells (1):
      rxrpc: Fix hard call timeout units

Dhruva Gole (1):
      spi: cadence-quadspi: fix suspend-resume implementations

Dom Cobley (1):
      drm/probe-helper: Cancel previous job before starting new one

Douglas Anderson (2):
      regulator: core: Consistently set mutex_owner when using ww_mutex_lock_slow()
      regulator: core: Avoid lockdep reports when resolving supplies

Emmanuel Grumbach (1):
      wifi: iwlwifi: make the loop for card preparation effective

Eric Dumazet (3):
      net/packet: annotate accesses to po->xmit
      net/packet: convert po->origdev to an atomic flag
      net/packet: convert po->auxdata to an atomic flag

Fedor Pchelkin (2):
      wifi: ath9k: hif_usb: fix memory leak of remain_skbs
      wifi: ath6kl: reduce WARN to dev_dbg() in callback

Filipe Manana (1):
      btrfs: fix btrfs_prev_leaf() to not return the same key twice

Florian Fainelli (4):
      media: rc: gpio-ir-recv: Fix support for wake-up
      scripts/gdb: bail early if there are no clocks
      scripts/gdb: bail early if there are no generic PD
      serial: 8250: Add missing wakeup event reporting

Florian Westphal (1):
      netfilter: nf_tables: don't write table validation state without mutex

Frederic Weisbecker (1):
      nohz: Add TICK_DEP_BIT_RCU

Gao Xiang (1):
      erofs: stop parsing non-compact HEAD index if clusterofs is invalid

Gaosheng Cui (1):
      phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port

Geert Uytterhoeven (4):
      debugfs: regset32: Add Runtime PM support
      arm64: dts: renesas: r8a77990: Remove bogus voltages from OPP table
      arm64: dts: renesas: r8a774c0: Remove bogus voltages from OPP table
      PM: domains: Restore comment indentation for generic_pm_domain.child_links

Gencen Gan (1):
      net: amd: Fix link leak when verifying config failed

Georgii Kruglov (1):
      mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data

Greg Kroah-Hartman (1):
      Linux 5.4.243

Guchun Chen (2):
      drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling legacy gfx ras
      drm/amdgpu: disable sdma ecc irq only when sdma RAS is enabled in suspend

H. Nikolaus Schaller (1):
      PCI: imx6: Install the fault handler only on compatible match

Hamza Mahfooz (1):
      drm/amdgpu: fix an amdgpu_irq_put() issue in gmc_v9_0_hw_fini()

Hans de Goede (3):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Acer Iconia One 7 B1-750
      ASoC: es8316: Use IRQF_NO_AUTOEN when requesting the IRQ
      PCI: pciehp: Use down_read/write_nested(reset_lock) to fix lockdep errors

Harshit Mogalapalli (1):
      drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()

Heiner Kallweit (2):
      pwm: meson: Fix axg ao mux parents
      pwm: meson: Fix g12a ao clk81 name

Helge Deller (1):
      parisc: Fix argument pointer in real64_call_asm()

Herbert Xu (1):
      crypto: drbg - Only fail when jent is unavailable in FIPS mode

Ilpo Järvinen (2):
      tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH
      serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

Jaegeuk Kim (1):
      f2fs: fix potential corruption when moving a directory

James Cowgill (1):
      drm/panel: otm8009a: Set backlight parent to panel device

Jan Kara (2):
      inotify: Avoid reporting event with invalid wd
      ext4: fix data races when using cached status extents

Jiasheng Jiang (1):
      media: bdisp: Add missing check for create_workqueue

Jiaxun Yang (1):
      MIPS: fw: Allow firmware to pass a empty env

Jingbo Xu (1):
      erofs: fix potential overflow calculating xattr_isize

Jishnu Prakash (1):
      spmi: Add a check for remove callback when removing a SPMI driver

Jisoo Jang (1):
      wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

Jitao Shi (1):
      pwm: mtk-disp: Adjust the clocks to avoid them mismatch

Joe Damato (2):
      ixgbe: Allow flow hash to be set via ethtool
      ixgbe: Enable setting RSS table to default values

Joel Fernandes (Google) (1):
      tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem

Johan Hovold (4):
      USB: dwc3: fix runtime pm imbalance on probe errors
      USB: dwc3: fix runtime pm imbalance on unbind
      xhci: fix debugfs register accesses while suspended
      drm/msm/adreno: drop bogus pm_runtime_set_active()

Johannes Berg (2):
      ring-buffer: Sync IRQ works before buffer destruction
      wifi: iwlwifi: mvm: check firmware response size

John Paul Adrian Glaubitz (1):
      sh: sq: Fix incorrect element size for allocating bitmap buffer

John Stultz (1):
      pstore: Revert pmsg_lock back to a normal mutex

Jonathan Marek (1):
      drm/msm: fix unbalanced pm_runtime_enable in adreno_gpu_{init, cleanup}

Jonathan McDowell (1):
      crypto: safexcel - Cleanup ring IRQ workqueues on load failure

Josef Bacik (1):
      btrfs: don't free qgroup space unless specified

Kajol Jain (1):
      perf vendor events power9: Remove UTF-8 characters from JSON files

Kees Cook (2):
      kheaders: Use array declaration instead of char
      PM: domains: Fix up terminology with parent/child

Keith Busch (1):
      nvme: fix async event trace event

Kevin Brodsky (1):
      uapi/linux/const.h: prefer ISO-friendly __typeof__

Krzysztof Kozlowski (4):
      iio: light: max44009: add missing OF device matching
      rtc: omap: include header for omap_rtc_power_off_program prototype
      ARM: dts: exynos: fix WM8960 clock name in Itop Elite
      ARM: dts: s5pv210: correct MIPI CSIS clock name

Kuniyuki Iwashima (3):
      netlink: Use copy_to_user() for optval in netlink_getsockopt().
      tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.
      af_packet: Don't send zero-byte data in packet_sendmsg_spkt().

Larry Finger (2):
      rtlwifi: Start changing RT_TRACE into rtl_dbg
      rtlwifi: Replace RT_TRACE with rtl_dbg

Li Nan (1):
      md/raid10: fix null-ptr-deref in raid10_sync_request

Liang He (1):
      macintosh/windfarm_smu_sat: Add missing of_node_put()

Lino Sanfilippo (1):
      tpm, tpm_tis: Do not skip reset of original interrupt vector

Liu Jian (1):
      Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work"

Luis Gerhorst (1):
      tools: bpftool: Remove invalid \' json escape

Lukas Wunner (1):
      PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock

Manivannan Sadhasivam (2):
      ARM: dts: qcom: ipq4019: Fix the PCI I/O port range
      ARM: dts: qcom: ipq8064: Fix the PCI I/O port range

Marc Dionne (1):
      afs: Fix updating of i_size with dv jump from server

Marco Pagani (1):
      fpga: bridge: fix kernel-doc parameter description

Mark Zhang (1):
      RDMA/mlx5: Use correct device num_ports when modify DC

Markus Elfring (1):
      perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Martin Blumenstingl (3):
      wifi: rtw88: mac: Return the original error from rtw_pwr_seq_parser()
      wifi: rtw88: mac: Return the original error from rtw_mac_power_switch()
      rtc: meson-vrtc: Use ktime_get_real_ts64() to get the current time

Mathieu Poirier (2):
      remoteproc: stm32: Call of_node_put() on iteration error
      remoteproc: st: Call of_node_put() on iteration error

Mauro Carvalho Chehab (2):
      media: rcar_fdp1: simplify error check logic at fdp_open()
      media: rcar_fdp1: fix pm_runtime_get_sync() usage count

Maxim Korotkov (1):
      writeback: fix call of incorrect macro

Maximilian Luz (1):
      drm/msm: Fix double pm_runtime_disable() call

Maíra Canal (1):
      drm/vgem: add missing mutex_destroy

Miaoqian Lin (2):
      media: rcar_fdp1: Fix refcount leak in probe and remove function
      Input: raspberrypi-ts - fix refcount leak in rpi_ts_probe

Michael Kelley (1):
      nvme: handle the persistent internal error AER

Mike Christie (1):
      scsi: target: iscsit: Fix TAS handling during conn cleanup

Mike Snitzer (3):
      dm clone: call kmem_cache_destroy() in dm_clone_init() error path
      dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path
      dm ioctl: fix nested locking in table_clear() to remove deadlock concern

Mikulas Patocka (1):
      dm flakey: fix a crash with invalid table line

Ming Lei (1):
      nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage"

Miquel Raynal (1):
      of: Fix modalias string generation

Mukesh Ojha (1):
      firmware: qcom_scm: Clear download bit during reboot

Mårten Lindahl (1):
      ubifs: Free memory for tmpfile name

Natalia Petrova (1):
      RDMA/rdmavt: Delete unnecessary NULL check

Nathan Lynch (1):
      powerpc/rtas: use memmove for potentially overlapping buffer copy

Nicolai Stange (1):
      crypto: drbg - make drbg_prepare_hrng() handle jent instantiation errors

Nicolas Saenz Julienne (3):
      firmware: raspberrypi: Keep count of all consumers
      firmware: raspberrypi: Introduce devm_rpi_firmware_get()
      input: raspberrypi-ts: Release firmware handle when not needed

Nuno Sá (1):
      staging: iio: resolver: ads1210: fix config mode

Ondrej Mosnacek (1):
      selinux: fix Makefile dependencies of flask.h

Pablo Neira Ayuso (1):
      netfilter: nf_tables: deactivate anonymous set from preparation phase

Patrick Kelsey (1):
      IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order

Patrik Dahlström (1):
      iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Paul Moore (1):
      selinux: ensure av_permissions.h is built when needed

Pawel Witek (1):
      cifs: fix pcchunk length type in smb2_copychunk_range

Peng Liu (1):
      scripts/gdb: fix lx-timerlist for Python3

Pengcheng Yang (1):
      kernel/relay.c: fix read_pos error when multiple readers

Philipp Hortmann (1):
      staging: rtl8192e: Fix W_DISABLE# does not work after stop/start

Ping Cheng (2):
      HID: wacom: Set a default resolution for older tablets
      HID: wacom: insert timestamp to packed Bluetooth (BT) events

Qinrun Dai (1):
      clocksource/drivers/davinci: Fix memory leak in davinci_timer_register when init fails

Qiuxu Zhuo (1):
      EDAC/skx: Fix overflows on the DRAM row address mapping arrays

Qu Wenruo (1):
      btrfs: scrub: reject unsupported scrub flags

Quentin Monnet (1):
      bpftool: Fix bug for long instructions in program CFG dumps

Quentin Schulz (1):
      clk: rockchip: rk3399: allow clk_cifout to force clk_cifout_src to reparent

Randy Dunlap (11):
      linux/vt_buffer.h: allow either builtin or modular for macros
      ia64: mm/contig: fix section mismatch warning/error
      ia64: salinfo: placate defined-but-not-used warning
      powerpc/mpc512x: fix resource printk format warning
      powerpc/wii: fix resource printk format warnings
      powerpc/sysdev/tsi108: fix resource printk format warnings
      macintosh: via-pmu-led: requires ATA to be set
      leds: TI_LMU_COMMON: select REGMAP instead of depending on it
      sh: math-emu: fix macro redefined warning
      sh: init: use OF_EARLY_FLATTREE for early init
      sh: nmi_debug: fix return value of __setup handler

Reid Tonking (1):
      i2c: omap: Fix standard mode false ACK readings

Rob Clark (2):
      drm/rockchip: Drop unbalanced obj unref
      drm/msm/adreno: Defer enabling runpm until hw_init()

Roberto Sassu (1):
      reiserfs: Add security prefix to xattr name in reiserfs_security_write()

Ruihan Li (1):
      bluetooth: Perform careful capability checks in hci_sock_ioctl()

Ruliang Lin (1):
      ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`

Ryusuke Konishi (2):
      nilfs2: do not write dirty data after degenerating to read-only
      nilfs2: fix infinite loop in nilfs_mdt_get_block()

Saurabh Sengar (1):
      x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

Sean Christopherson (1):
      KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not intercepted

Sebastian Andrzej Siewior (1):
      tick/common: Align tick period with the HZ tick.

Sebastian Reichel (1):
      power: supply: generic-adc-battery: fix unit scaling

Shannon Nelson (1):
      ionic: remove noise from ethtool rxnfc error msg

Shenwei Wang (1):
      tty: serial: fsl_lpuart: adjust buffer length to the intended size

Shuchang Li (1):
      scsi: lpfc: Fix ioremap issues in lpfc_sli4_pci_mem_setup()

Shunsuke Mie (2):
      dmaengine: dw-edma: Fix to change for continuous transfer
      dmaengine: dw-edma: Fix to enable to issue dma request on DMA processing

Stafford Horne (1):
      openrisc: Properly store r31 to pt_regs on unhandled exceptions

Stanislav Fomichev (1):
      bpf: Don't EFAULT for getsockopt with optval=NULL

Stefan Haberland (1):
      s390/dasd: fix hanging blockdevice after request requeue

Sumit Garg (1):
      arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

Sven Auhagen (1):
      crypto: inside-secure - irq balance

Tang Bin (1):
      media: rcar_fdp1: Fix the correct variable assignments

Tanmay Shah (3):
      mailbox: zynqmp: Fix IPI isr handling
      mailbox: zynqmp: Fix typo in IPI documentation
      mailbox: zynqmp: Fix counts of child nodes

Tetsuo Handa (3):
      RDMA/siw: Remove namespace check from siw_netdev_event()
      printk: declare printk_deferred_{enter,safe}() in include/linux/printk.h
      mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock

Theodore Ts'o (6):
      ext4: improve error recovery code paths in __ext4_remount()
      ext4: fix deadlock when converting an inline directory in nojournal mode
      ext4: add bounds checking in get_max_inline_xattr_value_size()
      ext4: bail out of ext4_xattr_ibody_get() fails for any reason
      ext4: remove a BUG_ON in ext4_mb_release_group_pa()
      ext4: fix invalid free tracking in ext4_xattr_move_to_block()

Thomas Gleixner (6):
      debugobject: Prevent init race with static objects
      timekeeping: Split jiffies seqlock
      tick/sched: Use tick_next_period for lockless quick check
      tick/sched: Optimize tick_do_update_jiffies64() further
      tick: Get rid of tick_period
      debugobject: Ensure pool refill (again)

Tian Tao (1):
      drm/exynos: move to use request_irq by IRQF_NO_AUTOEN flag

Trond Myklebust (1):
      NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease

Tudor Ambarus (1):
      ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Uros Bizjak (1):
      x86/apic: Fix atomic update of offset in reserve_eilvt_offset()

Uwe Kleine-König (2):
      spi: qup: Don't skip cleanup in remove's error path
      pwm: mtk-disp: Don't check the return code of pwmchip_remove()

Vadim Fedorenko (1):
      vlan: partially enable SIOCSHWTSTAMP in container

Victor Nogueira (1):
      net/sched: act_mirred: Add carrier check

Vignesh Raghavendra (4):
      mtd: spi-nor: cadence-quadspi: Make driver independent of flash geometry
      mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
      mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on failure
      mtd: spi-nor: cadence-quadspi: Handle probe deferral while requesting DMA channel

Vlad Buslov (1):
      net/sched: cls_api: remove block_cb from driver_list before freeing

Vladimir Oltean (1):
      asm-generic/io.h: suppress endianness warnings for readq() and writeq()

Wang YanQing (1):
      ubi: Fix return value overwrite issue in try_write_vid_and_data()

Wei Chen (2):
      wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_rfreg()
      wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_reg()

Wenliang Wang (1):
      virtio_net: suppress cpu stall when free_unused_bufs

William Breathitt Gray (1):
      counter: 104-quad-8: Fix race condition between FLAG and CNTR reads

Wolfram Sang (1):
      usb: host: xhci-rcar: remove leftover quirk handling

Xin Liu (1):
      bpf, sockmap: fix deadlocks in the sockhash and sockmap

Xuan Zhuo (1):
      virtio_net: split free_unused_bufs()

YAN SHI (1):
      regulator: stm32-pwr: fix of_iomap leak

Yang Jihong (2):
      perf/core: Fix hardlockup failure caused by perf throttle
      perf symbols: Fix return incorrect build_id size in elf_read_build_id()

Yang Yingliang (1):
      firmware: raspberrypi: fix possible memory leak in rpi_firmware_probe()

Yangtao Li (1):
      f2fs: handle dqget error in f2fs_transfer_project_quota()

Ye Bin (2):
      ext4: fix use-after-free read in ext4_find_extent for bigalloc + inline
      ext4: fix WARNING in mb_find_extent

Yeongjin Gil (1):
      dm verity: fix error handling for check_at_most_once on FEC

Yinhao Hu (1):
      usb: chipidea: fix missing goto in `ci_hdrc_probe`

Yu Kuai (3):
      md/raid10: fix leak of 'r10bio->remaining' for recovery
      md/raid10: fix memleak for 'conf->bio_split'
      md/raid10: fix memleak of md thread

Yunfeng Ye (1):
      tick/sched: Reduce seqcount held scope in tick_do_update_jiffies64()

Zhang Yuchen (1):
      ipmi: fix SSIF not responding under certain cond.

Zhang Zhengming (1):
      relayfs: fix out-of-bounds access in relay_file_read

Zheng Wang (3):
      media: dm1105: Fix use after free bug in dm1105_remove due to race condition
      media: saa7134: fix use after free bug in saa7134_finidev due to race condition
      usb: gadget: udc: renesas_usb3: Fix use after free bug in renesas_usb3_remove due to race condition

Zhihao Cheng (2):
      Revert "ubifs: dirty_cow_znode: Fix memleak in error handling path"
      ubifs: Fix memleak when insert_old_idx() failed

Ziyang Xuan (1):
      ipv4: Fix potential uninit variable access bug in __ip_make_skb()

