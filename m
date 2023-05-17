Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16B70676D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjEQMCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjEQMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:01:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DF17DB2;
        Wed, 17 May 2023 05:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52EC164634;
        Wed, 17 May 2023 12:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11283C433D2;
        Wed, 17 May 2023 12:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324835;
        bh=y+o32tbfls45T/5QLUrIVgqMhzSPoyS6PxSimMYSHgo=;
        h=From:To:Cc:Subject:Date:From;
        b=if85BtYO5Ov4HiQjhUALD275YGlcm1c6xNyADY3F1dKRUrXSzyU6H2W3Q6MRL6eKF
         yPLbi8k17zBemaKzm/98KjwnuvBbhMlRnXCs9Ub9lGFV50kFTJXoJ7CyPnxq0CstjN
         wR7Bu+PURPWH6GrLzSI/0OpNOucbPm7dr/p6peAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.180
Date:   Wed, 17 May 2023 14:00:28 +0200
Message-Id: <2023051728-headless-footing-9418@gregkh>
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

I'm announcing the release of the 5.10.180 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/arm/boot/dts/exynos4412-itop-elite.dts                 |    2 
 arch/arm/boot/dts/omap3-gta04.dtsi                          |   16 
 arch/arm/boot/dts/qcom-ipq4019.dtsi                         |    4 
 arch/arm/boot/dts/qcom-ipq8064.dtsi                         |   12 
 arch/arm/boot/dts/s5pv210.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                       |   12 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                       |   12 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                       |    4 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                        |   30 
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi                   |    3 
 arch/arm64/boot/dts/renesas/r8a77990.dtsi                   |    3 
 arch/arm64/include/asm/debug-monitors.h                     |    1 
 arch/arm64/include/asm/scs.h                                |    7 
 arch/arm64/kernel/debug-monitors.c                          |    5 
 arch/arm64/kernel/entry.S                                   |   12 
 arch/arm64/kernel/head.S                                    |    2 
 arch/arm64/kernel/kgdb.c                                    |    2 
 arch/arm64/kvm/psci.c                                       |    2 
 arch/ia64/kernel/salinfo.c                                  |    2 
 arch/ia64/mm/contig.c                                       |    2 
 arch/ia64/mm/hugetlbpage.c                                  |    2 
 arch/mips/fw/lib/cmdline.c                                  |    2 
 arch/openrisc/kernel/entry.S                                |    6 
 arch/parisc/kernel/real2.S                                  |    5 
 arch/powerpc/kernel/rtas.c                                  |    2 
 arch/powerpc/platforms/512x/clock-commonclk.c               |    2 
 arch/powerpc/platforms/embedded6xx/flipper-pic.c            |    2 
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c               |    2 
 arch/powerpc/platforms/embedded6xx/wii.c                    |    4 
 arch/powerpc/sysdev/tsi108_pci.c                            |    5 
 arch/sh/Kconfig.debug                                       |    2 
 arch/sh/kernel/cpu/sh4/sq.c                                 |    2 
 arch/sh/kernel/head_32.S                                    |    6 
 arch/sh/kernel/nmi_debug.c                                  |    4 
 arch/sh/kernel/setup.c                                      |    4 
 arch/sh/math-emu/sfp-util.h                                 |    4 
 arch/x86/include/asm/kvm_host.h                             |    5 
 arch/x86/kernel/apic/apic.c                                 |    5 
 arch/x86/kernel/apic/io_apic.c                              |   14 
 arch/x86/kernel/cpu/mce/amd.c                               |   14 
 arch/x86/kernel/fpu/core.c                                  |   67 -
 arch/x86/kvm/hyperv.c                                       |   15 
 arch/x86/kvm/svm/svm.c                                      |    2 
 arch/x86/kvm/vmx/vmx.c                                      |   16 
 arch/x86/kvm/x86.c                                          |  164 ++-
 block/blk-core.c                                            |    7 
 block/blk-crypto-internal.h                                 |   25 
 block/blk-crypto.c                                          |   69 -
 block/blk-merge.c                                           |    2 
 block/blk-mq.c                                              |    2 
 block/keyslot-manager.c                                     |   43 
 crypto/algapi.c                                             |    4 
 crypto/drbg.c                                               |   16 
 drivers/acpi/processor_pdc.c                                |   11 
 drivers/base/cpu.c                                          |    3 
 drivers/base/dd.c                                           |    7 
 drivers/block/drbd/drbd_receiver.c                          |    2 
 drivers/bluetooth/btsdio.c                                  |    1 
 drivers/char/ipmi/Kconfig                                   |    3 
 drivers/char/ipmi/ipmi_ssif.c                               |    8 
 drivers/char/tpm/tpm_tis_core.c                             |  131 +-
 drivers/char/tpm/tpm_tis_core.h                             |    2 
 drivers/clk/at91/clk-sam9x60-pll.c                          |    2 
 drivers/clk/clk-conf.c                                      |   12 
 drivers/clk/rockchip/clk-rk3399.c                           |    2 
 drivers/clocksource/timer-davinci.c                         |   30 
 drivers/counter/104-quad-8.c                                |   28 
 drivers/crypto/Kconfig                                      |    1 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c         |    2 
 drivers/crypto/caam/ctrl.c                                  |    6 
 drivers/crypto/ccp/psp-dev.c                                |    6 
 drivers/crypto/inside-secure/safexcel.c                     |   37 
 drivers/dma/at_xdmac.c                                      |    5 
 drivers/dma/dw-edma/dw-edma-core.c                          |   27 
 drivers/dma/mv_xor_v2.c                                     |    2 
 drivers/edac/skx_base.c                                     |    4 
 drivers/firmware/qcom_scm.c                                 |    3 
 drivers/firmware/raspberrypi.c                              |   29 
 drivers/firmware/stratix10-svc.c                            |    4 
 drivers/fpga/fpga-bridge.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c                   |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                       |    3 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                       |    1 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                      |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |    5 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           |    3 
 drivers/gpu/drm/bridge/adv7511/adv7533.c                    |   25 
 drivers/gpu/drm/drm_fb_helper.c                             |    3 
 drivers/gpu/drm/drm_probe_helper.c                          |    5 
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c               |    4 
 drivers/gpu/drm/exynos/exynos_drm_dsi.c                     |    7 
 drivers/gpu/drm/i915/display/intel_display.c                |    2 
 drivers/gpu/drm/lima/lima_drv.c                             |    6 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                       |    8 
 drivers/gpu/drm/msm/adreno/adreno_device.c                  |    7 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                     |    1 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                 |    2 
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c            |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                 |    3 
 drivers/gpu/drm/vgem/vgem_fence.c                           |    1 
 drivers/hid/wacom_wac.c                                     |   38 
 drivers/hid/wacom_wac.h                                     |    1 
 drivers/hwmon/adt7475.c                                     |    6 
 drivers/hwmon/k10temp.c                                     |    4 
 drivers/hwtracing/coresight/coresight-etm-perf.c            |    1 
 drivers/i2c/busses/i2c-cadence.c                            |    6 
 drivers/i2c/busses/i2c-omap.c                               |    2 
 drivers/iio/adc/palmas_gpadc.c                              |    2 
 drivers/iio/light/max44009.c                                |   13 
 drivers/infiniband/core/cm.c                                |    3 
 drivers/infiniband/hw/hfi1/ipoib_tx.c                       |   19 
 drivers/infiniband/hw/hfi1/mmu_rb.c                         |   73 -
 drivers/infiniband/hw/hfi1/mmu_rb.h                         |    8 
 drivers/infiniband/hw/hfi1/sdma.c                           |   21 
 drivers/infiniband/hw/hfi1/sdma.h                           |   16 
 drivers/infiniband/hw/hfi1/sdma_txreq.h                     |    1 
 drivers/infiniband/hw/hfi1/trace_mmu.h                      |    4 
 drivers/infiniband/hw/hfi1/trace_tx.h                       |  179 +++
 drivers/infiniband/hw/hfi1/user_sdma.c                      |  612 +++++++-----
 drivers/infiniband/hw/hfi1/user_sdma.h                      |    6 
 drivers/infiniband/hw/hfi1/verbs.c                          |    4 
 drivers/infiniband/hw/hfi1/vnic_sdma.c                      |    1 
 drivers/infiniband/hw/mlx4/qp.c                             |    8 
 drivers/infiniband/hw/mlx5/devx.c                           |   31 
 drivers/infiniband/hw/mlx5/qp.c                             |    2 
 drivers/infiniband/sw/rdmavt/qp.c                           |    2 
 drivers/infiniband/sw/siw/siw_main.c                        |    3 
 drivers/infiniband/sw/siw/siw_qp_tx.c                       |    2 
 drivers/infiniband/ulp/isert/ib_isert.c                     |    4 
 drivers/infiniband/ulp/srpt/ib_srpt.c                       |   23 
 drivers/input/touchscreen/raspberrypi-ts.c                  |    3 
 drivers/iommu/amd/amd_iommu_types.h                         |    4 
 drivers/leds/Kconfig                                        |    2 
 drivers/leds/leds-tca6507.c                                 |    5 
 drivers/macintosh/Kconfig                                   |    1 
 drivers/macintosh/windfarm_smu_sat.c                        |    1 
 drivers/mailbox/zynqmp-ipi-mailbox.c                        |   19 
 drivers/md/dm-clone-target.c                                |    1 
 drivers/md/dm-flakey.c                                      |    4 
 drivers/md/dm-integrity.c                                   |    8 
 drivers/md/dm-ioctl.c                                       |    7 
 drivers/md/dm-verity-target.c                               |   17 
 drivers/md/raid10.c                                         |   74 -
 drivers/media/i2c/max9286.c                                 |    1 
 drivers/media/pci/dm1105/dm1105.c                           |    1 
 drivers/media/pci/saa7134/saa7134-ts.c                      |    1 
 drivers/media/pci/saa7134/saa7134-vbi.c                     |    1 
 drivers/media/pci/saa7134/saa7134-video.c                   |    1 
 drivers/media/platform/qcom/venus/core.h                    |    6 
 drivers/media/platform/qcom/venus/helpers.c                 |    6 
 drivers/media/platform/qcom/venus/vdec.c                    |  120 +-
 drivers/media/platform/rcar_fdp1.c                          |   50 
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c               |    2 
 drivers/media/rc/gpio-ir-recv.c                             |    2 
 drivers/mfd/tqmx86.c                                        |   76 -
 drivers/misc/vmw_vmci/vmci_host.c                           |    8 
 drivers/mmc/host/sdhci-of-esdhc.c                           |   24 
 drivers/mtd/ubi/eba.c                                       |   19 
 drivers/net/dsa/mt7530.c                                    |    4 
 drivers/net/dsa/mv88e6xxx/chip.c                            |    1 
 drivers/net/ethernet/amd/nmclan_cs.c                        |    2 
 drivers/net/ethernet/freescale/enetc/enetc_qos.c            |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c            |   23 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c        |   11 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c        |    2 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c         |    2 
 drivers/net/ethernet/sfc/mcdi_port_common.c                 |   11 
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c              |   14 
 drivers/net/virtio_net.c                                    |   43 
 drivers/net/wireguard/timers.c                              |    8 
 drivers/net/wireless/ath/ath5k/eeprom.c                     |    2 
 drivers/net/wireless/ath/ath6kl/bmi.c                       |    2 
 drivers/net/wireless/ath/ath6kl/htc_pipe.c                  |    4 
 drivers/net/wireless/ath/ath9k/hif_usb.c                    |   19 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    5 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                 |    4 
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c             |    4 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c            |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c            |   10 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c             |    3 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c      |    1 
 drivers/net/wireless/realtek/rtlwifi/debug.c                |   12 
 drivers/net/wireless/realtek/rtw88/mac.c                    |    8 
 drivers/nvme/host/core.c                                    |   34 
 drivers/nvme/host/trace.h                                   |   15 
 drivers/nvme/target/fcloop.c                                |   48 
 drivers/of/device.c                                         |    7 
 drivers/pci/controller/dwc/pci-imx6.c                       |    7 
 drivers/pci/controller/dwc/pcie-qcom.c                      |    8 
 drivers/pci/hotplug/pciehp_pci.c                            |   15 
 drivers/pci/pcie/edr.c                                      |    1 
 drivers/phy/tegra/xusb.c                                    |    2 
 drivers/platform/x86/touchscreen_dmi.c                      |   41 
 drivers/power/supply/generic-adc-battery.c                  |    3 
 drivers/pwm/pwm-meson.c                                     |    6 
 drivers/pwm/pwm-mtk-disp.c                                  |   94 -
 drivers/regulator/core.c                                    |   93 +
 drivers/regulator/stm32-pwr.c                               |    7 
 drivers/remoteproc/st_remoteproc.c                          |    5 
 drivers/remoteproc/stm32_rproc.c                            |    6 
 drivers/rtc/rtc-meson-vrtc.c                                |    4 
 drivers/rtc/rtc-omap.c                                      |    1 
 drivers/s390/block/dasd.c                                   |    2 
 drivers/scsi/lpfc/lpfc_init.c                               |   10 
 drivers/scsi/megaraid.c                                     |    1 
 drivers/scsi/qedi/qedi_main.c                               |    3 
 drivers/soc/ti/pm33xx.c                                     |   22 
 drivers/spi/spi-cadence-quadspi.c                           |   19 
 drivers/spi/spi-fsl-spi.c                                   |   12 
 drivers/spi/spi-imx.c                                       |   14 
 drivers/spi/spi-qup.c                                       |   22 
 drivers/spmi/spmi.c                                         |    3 
 drivers/staging/iio/resolver/ad2s1210.c                     |    2 
 drivers/staging/media/rkvdec/rkvdec.c                       |    2 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                |    1 
 drivers/target/iscsi/iscsi_target.c                         |   16 
 drivers/target/target_core_device.c                         |   17 
 drivers/target/target_core_sbc.c                            |    2 
 drivers/target/target_core_tmr.c                            |  192 ++-
 drivers/target/target_core_transport.c                      |   59 -
 drivers/target/tcm_fc/tfc_cmd.c                             |    2 
 drivers/thermal/mtk_thermal.c                               |   14 
 drivers/tty/n_gsm.c                                         |    1 
 drivers/tty/n_hdlc.c                                        |    1 
 drivers/tty/n_tty.c                                         |    1 
 drivers/tty/pty.c                                           |    1 
 drivers/tty/serial/8250/8250.h                              |   12 
 drivers/tty/serial/8250/8250_port.c                         |   16 
 drivers/tty/serial/fsl_lpuart.c                             |    2 
 drivers/tty/tty.h                                           |  117 ++
 drivers/tty/tty_audit.c                                     |    1 
 drivers/tty/tty_baudrate.c                                  |    1 
 drivers/tty/tty_buffer.c                                    |    2 
 drivers/tty/tty_io.c                                        |    5 
 drivers/tty/tty_ioctl.c                                     |   46 
 drivers/tty/tty_jobctrl.c                                   |    1 
 drivers/tty/tty_ldisc.c                                     |    1 
 drivers/tty/tty_mutex.c                                     |    1 
 drivers/tty/tty_port.c                                      |    1 
 drivers/usb/chipidea/core.c                                 |    2 
 drivers/usb/dwc3/core.c                                     |   15 
 drivers/usb/dwc3/gadget.c                                   |   11 
 drivers/usb/gadget/udc/renesas_usb3.c                       |    1 
 drivers/usb/gadget/udc/tegra-xudc.c                         |    2 
 drivers/usb/host/xhci-debugfs.c                             |    1 
 drivers/usb/host/xhci-rcar.c                                |    3 
 drivers/usb/mtu3/mtu3_qmu.c                                 |    5 
 drivers/usb/serial/option.c                                 |    6 
 drivers/watchdog/dw_wdt.c                                   |    7 
 drivers/xen/pcpu.c                                          |   20 
 fs/afs/inode.c                                              |    1 
 fs/btrfs/block-rsv.c                                        |    3 
 fs/btrfs/ctree.c                                            |   32 
 fs/btrfs/ioctl.c                                            |    5 
 fs/btrfs/print-tree.c                                       |    6 
 fs/cifs/smb2ops.c                                           |    2 
 fs/erofs/internal.h                                         |    2 
 fs/erofs/zmap.c                                             |    4 
 fs/ext4/acl.c                                               |    2 
 fs/ext4/balloc.c                                            |   25 
 fs/ext4/extents.c                                           |    5 
 fs/ext4/extents_status.c                                    |   30 
 fs/ext4/file.c                                              |    4 
 fs/ext4/inline.c                                            |   17 
 fs/ext4/inode.c                                             |    9 
 fs/ext4/ioctl.c                                             |    8 
 fs/ext4/mballoc.c                                           |    6 
 fs/ext4/super.c                                             |   19 
 fs/ext4/xattr.c                                             |    5 
 fs/f2fs/compress.c                                          |    6 
 fs/f2fs/data.c                                              |    5 
 fs/f2fs/f2fs.h                                              |    2 
 fs/f2fs/file.c                                              |   15 
 fs/f2fs/namei.c                                             |   16 
 fs/f2fs/segment.c                                           |   76 -
 fs/f2fs/segment.h                                           |    6 
 fs/f2fs/super.c                                             |   33 
 fs/fs-writeback.c                                           |   19 
 fs/jbd2/journal.c                                           |    2 
 fs/jbd2/transaction.c                                       |    3 
 fs/nfs/nfs4state.c                                          |    4 
 fs/nilfs2/bmap.c                                            |   16 
 fs/nilfs2/segment.c                                         |    5 
 fs/notify/inotify/inotify_fsnotify.c                        |   11 
 fs/pstore/pmsg.c                                            |    7 
 fs/reiserfs/xattr_security.c                                |    8 
 fs/ubifs/dir.c                                              |    1 
 fs/ubifs/tnc.c                                              |  142 +-
 include/asm-generic/io.h                                    |    4 
 include/linux/blk-crypto.h                                  |    4 
 include/linux/mailbox/zynqmp-ipi-message.h                  |    2 
 include/linux/mlx5/mlx5_ifc.h                               |    3 
 include/linux/netfilter/nfnetlink.h                         |    1 
 include/linux/nvme.h                                        |    4 
 include/linux/posix-timers.h                                |   17 
 include/linux/printk.h                                      |   19 
 include/linux/sunrpc/sched.h                                |    3 
 include/linux/tick.h                                        |    2 
 include/linux/tty.h                                         |   97 -
 include/linux/vt_buffer.h                                   |    2 
 include/linux/workqueue.h                                   |    4 
 include/net/netfilter/nf_tables.h                           |    1 
 include/net/scm.h                                           |   13 
 include/net/xsk_buff_pool.h                                 |    9 
 include/soc/bcm2835/raspberrypi-firmware.h                  |    8 
 include/target/target_core_base.h                           |   16 
 include/trace/events/qrtr.h                                 |   33 
 include/trace/events/timer.h                                |    3 
 include/uapi/linux/btrfs.h                                  |    1 
 include/uapi/linux/const.h                                  |    2 
 include/xen/xen.h                                           |   11 
 kernel/bpf/cgroup.c                                         |    9 
 kernel/bpf/verifier.c                                       |   26 
 kernel/events/core.c                                        |    4 
 kernel/fork.c                                               |   17 
 kernel/kheaders.c                                           |   10 
 kernel/rcu/tree.c                                           |    1 
 kernel/relay.c                                              |    3 
 kernel/time/posix-cpu-timers.c                              |   81 +
 kernel/time/posix-timers.c                                  |    4 
 kernel/time/tick-broadcast.c                                |    2 
 kernel/time/tick-common.c                                   |   20 
 kernel/time/tick-internal.h                                 |    1 
 kernel/time/tick-sched.c                                    |  102 +-
 kernel/trace/ring_buffer.c                                  |   20 
 kernel/workqueue.c                                          |   67 -
 lib/debugobjects.c                                          |  141 +-
 mm/backing-dev.c                                            |   11 
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
 net/netlink/af_netlink.c                                    |   75 -
 net/packet/af_packet.c                                      |   32 
 net/packet/diag.c                                           |    4 
 net/packet/internal.h                                       |   26 
 net/rxrpc/sendmsg.c                                         |    2 
 net/sched/act_mirred.c                                      |    2 
 net/sched/cls_api.c                                         |    1 
 net/sched/sch_fq.c                                          |    6 
 net/sunrpc/clnt.c                                           |    3 
 net/sunrpc/sched.c                                          |    1 
 net/xdp/xsk_queue.h                                         |    1 
 scripts/gdb/linux/clk.py                                    |    2 
 scripts/gdb/linux/genpd.py                                  |    4 
 scripts/gdb/linux/timerlist.py                              |    4 
 scripts/gdb/linux/utils.py                                  |    5 
 security/selinux/Makefile                                   |    4 
 sound/oss/dmasound/dmasound.h                               |    6 
 sound/oss/dmasound/dmasound_core.c                          |   26 
 sound/soc/codecs/es8316.c                                   |   17 
 sound/soc/fsl/fsl_mqs.c                                     |   15 
 sound/soc/intel/boards/bytcr_rt5640.c                       |   12 
 sound/usb/caiaq/input.c                                     |    1 
 tools/bpf/bpftool/json_writer.c                             |    3 
 tools/bpf/bpftool/xlated_dumper.c                           |    7 
 tools/perf/builtin-sched.c                                  |    2 
 tools/perf/pmu-events/arch/powerpc/power9/other.json        |    4 
 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json     |    2 
 tools/perf/util/auxtrace.c                                  |    5 
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c         |    2 
 tools/perf/util/pmu.c                                       |    2 
 tools/perf/util/sort.c                                      |    3 
 tools/perf/util/symbol-elf.c                                |    2 
 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c   |    8 
 tools/testing/selftests/resctrl/fill_buf.c                  |    2 
 tools/testing/selftests/resctrl/mba_test.c                  |    7 
 376 files changed, 3618 insertions(+), 2093 deletions(-)

Adam Ford (1):
      drm/bridge: adv7533: Fix adv7533_mode_valid for adv7533 and adv7535

Adam Skladowski (1):
      drm: msm: adreno: Disable preemption on Adreno 510

Adrian Hunter (2):
      perf auxtrace: Fix address filter entire kernel size
      perf intel-pt: Fix CYC timestamps after standalone CBR

Akilesh Kailash (1):
      dm verity: skip redundant verity_handle_err() on I/O errors

Alexander Mikhalitsyn (1):
      scm: fix MSG_CTRUNC setting condition for SO_PASSSEC

Alexandre Courbot (1):
      media: venus: preserve DRC state across seeks

Alexey V. Vissarionov (1):
      wifi: ath6kl: minor fix for allocation size

Anastasia Belova (1):
      btrfs: print-tree: parent bytenr must be aligned to sector size

Andrey Avdeev (1):
      platform/x86: touchscreen_dmi: Add info for the Dexp Ursus KX210i

Andrii Nakryiko (2):
      bpf: take into account liveness when propagating precision
      bpf: fix precision propagation verbose logging

Andy Moreton (1):
      sfc: Fix module EEPROM reporting for QSFP modules

Angelo Dureghello (1):
      net: dsa: mv88e6xxx: add mv88e6321 rsvd2cpu

AngeloGioacchino Del Regno (1):
      pwm: mtk-disp: Disable shadow registers before setting backlight values

Ard Biesheuvel (2):
      arm64: Always load shadow stack pointer directly from the task struct
      arm64: Stash shadow stack pointer in the task struct on interrupt

Arnaldo Carvalho de Melo (2):
      perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into sysconf(__SC_THREAD_STACK_MIN_VALUE)
      perf pmu: zfree() expects a pointer to a pointer to zero it after freeing its contents

Arınç ÜNAL (2):
      USB: serial: option: add UNISOC vendor and TOZED LT70C product
      net: dsa: mt7530: fix corrupt frames using trgmii on 40 MHz XTAL MT7621

Aurabindo Pillai (1):
      drm/amd/display: Fix hang when skipping modeset

Babu Moger (1):
      hwmon: (k10temp) Check range scale when CUR_TEMP register is read-write

Baokun Li (2):
      writeback, cgroup: fix null-ptr-deref write in bdi_split_work_to_wbs
      ext4: check iomap type only if ext4_iomap_begin() does not fail

Bitterblue Smith (1):
      wifi: rtl8xxxu: RTL8192EU always needs full init

Cai Huoqing (1):
      media: rcar_fdp1: Make use of the helper function devm_platform_ioremap_resource()

Chao Yu (1):
      f2fs: fix to avoid use-after-free for cached IPU bio

Chia-I Wu (1):
      drm/amdgpu: add a missing lock for AMDGPU_SCHED

Chris Packham (1):
      hwmon: (adt7475) Use device_property APIs when configuring polarity

Christian Marangi (1):
      ARM: dts: qcom: ipq8064: reduce pci IO size to 64K

Christoph Böhmwalder (1):
      drbd: correctly submit flush bio on barrier

Christophe JAILLET (5):
      crypto: caam - Clear some memory in instantiate_rng
      dmaengine: mv_xor_v2: Fix an error code.
      mailbox: zynq: Switch to flexible array to simplify code
      watchdog: dw_wdt: Fix the error handling path of dw_wdt_drv_probe()
      crypto: sun8i-ss - Fix a test in sun8i_ss_setup_ivs()

Christophe Leroy (1):
      spi: fsl-spi: Fix CPM/QE mode Litte Endian

Chunfeng Yun (1):
      usb: mtu3: fix kernel panic at qmu transfer done irq handler

Claudiu Beznea (2):
      clk: at91: clk-sam9x60-pll: fix return value check
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

Dai Ngo (1):
      SUNRPC: remove the maximum number of retries in call_bind_status

Dan Carpenter (4):
      KVM: arm64: Fix buffer overflow in kvm_arm_set_fw_reg()
      wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()
      firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
      RDMA/mlx4: Prevent shift wrapping in set_user_sq_size()

Daniel Borkmann (1):
      bpf, sockmap: Revert buggy deadlock fix in the sockhash and sockmap

Daniel Gabay (1):
      wifi: iwlwifi: yoyo: Fix possible division by zero

Daniel Vetter (1):
      drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var

Daniil Dulov (1):
      RDMA/siw: Fix potential page_array out of range access

Danila Chernetsov (1):
      scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS

David Disseldorp (2):
      scsi: target: Rename struct sense_info to sense_detail
      scsi: target: Rename cmd.bad_sector to cmd.sense_info

David Howells (1):
      rxrpc: Fix hard call timeout units

Davide Caratti (1):
      net/sched: sch_fq: fix integer overflow of "credit"

Dhruva Gole (1):
      spi: cadence-quadspi: fix suspend-resume implementations

Dmitry Baryshkov (1):
      arm64: dts: qcom: sdm845: correct dynamic power coefficients

Dom Cobley (1):
      drm/probe-helper: Cancel previous job before starting new one

Douglas Anderson (2):
      regulator: core: Consistently set mutex_owner when using ww_mutex_lock_slow()
      regulator: core: Avoid lockdep reports when resolving supplies

Emmanuel Grumbach (1):
      wifi: iwlwifi: make the loop for card preparation effective

Eric Biggers (3):
      blk-mq: release crypto keyslot before reporting I/O complete
      blk-crypto: make blk_crypto_evict_key() return void
      blk-crypto: make blk_crypto_evict_key() more robust

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

Fritz Koenig (1):
      media: venus: vdec: Handle DRC after drain

Gao Xiang (1):
      erofs: stop parsing non-compact HEAD index if clusterofs is invalid

Gaosheng Cui (1):
      phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port

Geert Uytterhoeven (2):
      arm64: dts: renesas: r8a77990: Remove bogus voltages from OPP table
      arm64: dts: renesas: r8a774c0: Remove bogus voltages from OPP table

Gencen Gan (1):
      net: amd: Fix link leak when verifying config failed

Georgii Kruglov (1):
      mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data

Greg Kroah-Hartman (6):
      tty: create internal tty.h file
      tty: audit: move some local functions out of tty.h
      tty: move some internal tty lock enums and functions out of tty.h
      tty: move some tty-only functions to drivers/tty/tty.h
      tty: clean include/linux/tty.h up
      Linux 5.10.180

Guchun Chen (2):
      drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling legacy gfx ras
      drm/amdgpu: disable sdma ecc irq only when sdma RAS is enabled in suspend

H. Nikolaus Schaller (3):
      ARM: dts: gta04: fix excess dma channel usage
      PCI: imx6: Install the fault handler only on compatible match
      leds: tca6507: Fix error handling of using fwnode_property_read_string

Hamza Mahfooz (1):
      drm/amdgpu: fix an amdgpu_irq_put() issue in gmc_v9_0_hw_fini()

Hans de Goede (3):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Acer Iconia One 7 B1-750
      ASoC: es8316: Use IRQF_NO_AUTOEN when requesting the IRQ
      platform/x86: touchscreen_dmi: Add upside-down quirk for GDIX1002 ts on the Juno Tablet

Harshad Shirwadkar (1):
      ext4: use ext4_journal_start/stop for fast commit transactions

Harshit Mogalapalli (1):
      drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()

Heiner Kallweit (2):
      pwm: meson: Fix axg ao mux parents
      pwm: meson: Fix g12a ao clk81 name

Helge Deller (1):
      parisc: Fix argument pointer in real64_call_asm()

Herbert Xu (1):
      crypto: drbg - Only fail when jent is unavailable in FIPS mode

Hugh Dickins (1):
      ia64: fix an addr to taddr in huge_pte_offset()

Ilpo Järvinen (4):
      selftests/resctrl: Return NULL if malloc_and_init_memory() did not alloc mem
      selftests/resctrl: Check for return value after write_schemata()
      tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH
      serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

Jaegeuk Kim (3):
      f2fs: enforce single zone capacity
      f2fs: apply zone capacity to all zone type
      f2fs: fix potential corruption when moving a directory

James Cowgill (1):
      drm/panel: otm8009a: Set backlight parent to panel device

Jan Kara (3):
      jdb2: Don't refuse invalidation of already invalidated buffers
      inotify: Avoid reporting event with invalid wd
      ext4: fix data races when using cached status extents

Jeremi Piotrowski (1):
      crypto: ccp - Clear PSP interrupt status register before calling handler

Jiasheng Jiang (1):
      media: bdisp: Add missing check for create_workqueue

Jiaxun Yang (1):
      MIPS: fw: Allow firmware to pass a empty env

Jingbo Xu (1):
      erofs: fix potential overflow calculating xattr_isize

Jiri Slaby (SUSE) (1):
      wireguard: timers: cast enum limits members to int in prints

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

Johannes Berg (3):
      ring-buffer: Sync IRQ works before buffer destruction
      wifi: iwlwifi: mvm: check firmware response size
      wifi: iwlwifi: fw: fix memory leak in debugfs

John Paul Adrian Glaubitz (1):
      sh: sq: Fix incorrect element size for allocating bitmap buffer

John Stultz (1):
      pstore: Revert pmsg_lock back to a normal mutex

Jon Hunter (1):
      usb: gadget: tegra-xudc: Fix crash in vbus_draw

Jonathan McDowell (1):
      crypto: safexcel - Cleanup ring IRQ workqueues on load failure

Josef Bacik (1):
      btrfs: don't free qgroup space unless specified

Kajol Jain (1):
      perf vendor events power9: Remove UTF-8 characters from JSON files

Kal Conley (1):
      xsk: Fix unaligned descriptor validation

Kang Chen (1):
      thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe

Kees Cook (1):
      kheaders: Use array declaration instead of char

Keith Busch (1):
      nvme: fix async event trace event

Kevin Brodsky (1):
      uapi/linux/const.h: prefer ISO-friendly __typeof__

Kishon Vijay Abraham I (1):
      iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration in IRTE

Konrad Dybcio (1):
      arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name

Krzysztof Kozlowski (4):
      iio: light: max44009: add missing OF device matching
      rtc: omap: include header for omap_rtc_power_off_program prototype
      ARM: dts: exynos: fix WM8960 clock name in Itop Elite
      ARM: dts: s5pv210: correct MIPI CSIS clock name

Kuniyuki Iwashima (4):
      seccomp: Move copy_seccomp() to no failure path.
      netlink: Use copy_to_user() for optval in netlink_getsockopt().
      tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.
      af_packet: Don't send zero-byte data in packet_sendmsg_spkt().

Kuppuswamy Sathyanarayanan (1):
      PCI/EDR: Clear Device Status after EDR error recovery

Lai Jiangshan (1):
      workqueue: Rename "delayed" (delayed by active management) to "inactive"

Lars-Peter Clausen (1):
      i2c: cadence: cdns_i2c_master_xfer(): Fix runtime PM leak on error path

Laurent Pinchart (1):
      media: max9286: Free control handler

Li Nan (1):
      md/raid10: fix null-ptr-deref in raid10_sync_request

Liang He (1):
      macintosh/windfarm_smu_sat: Add missing of_node_put()

Liliang Ye (1):
      ASoC: fsl_mqs: move of_node_put() to the correct location

Lino Sanfilippo (6):
      tpm, tpm_tis: Do not skip reset of original interrupt vector
      tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register
      tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
      tpm, tpm_tis: Claim locality before writing interrupt registers
      tpm, tpm: Implement usage counter for locality
      tpm, tpm_tis: Claim locality when interrupts are reenabled on resume

Liu Jian (1):
      Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work"

Luis Gerhorst (2):
      tools: bpftool: Remove invalid \' json escape
      bpf: Remove misleading spec_v1 check on var-offset stack read

Lukas Wunner (1):
      PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock

Manivannan Sadhasivam (7):
      PCI: qcom: Fix the incorrect register usage in v2.7.0 config
      arm64: dts: qcom: sdm845: Fix the PCI I/O port range
      arm64: dts: qcom: msm8998: Fix the PCI I/O port range
      arm64: dts: qcom: ipq8074: Fix the PCI I/O port range
      arm64: dts: qcom: msm8996: Fix the PCI I/O port range
      ARM: dts: qcom: ipq4019: Fix the PCI I/O port range
      ARM: dts: qcom: ipq8064: Fix the PCI I/O port range

Marc Dionne (1):
      afs: Fix updating of i_size with dv jump from server

Marco Pagani (1):
      fpga: bridge: fix kernel-doc parameter description

Mark Bloch (1):
      RDMA/mlx5: Fix flow counter query via DEVX

Mark Zhang (2):
      RDMA/cm: Trace icm_send_rej event before the cm state is reset
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

Matthias Schiffer (5):
      mfd: tqmx86: Do not access I2C_DETECT register through io_base
      mfd: tqmx86: Remove incorrect TQMx90UC board ID
      mfd: tqmx86: Add support for TQMx110EB and TQMxE40x
      mfd: tqmx86: Specify IO port register range more precisely
      mfd: tqmx86: Correct board names for TQMxE39x

Mauro Carvalho Chehab (2):
      media: rcar_fdp1: simplify error check logic at fdp_open()
      media: rcar_fdp1: fix pm_runtime_get_sync() usage count

Maxim Korotkov (1):
      writeback: fix call of incorrect macro

Maíra Canal (1):
      drm/vgem: add missing mutex_destroy

Miaoqian Lin (3):
      soc: ti: pm33xx: Fix refcount leak in am33xx_pm_probe
      media: rcar_fdp1: Fix refcount leak in probe and remove function
      Input: raspberrypi-ts - fix refcount leak in rpi_ts_probe

Michael Kelley (1):
      nvme: handle the persistent internal error AER

Michał Krawczyk (1):
      media: venus: dec: Fix handling of the start cmd

Mike Christie (3):
      scsi: target: Make state_list per CPU
      scsi: target: Fix multiple LUN_RESET handling
      scsi: target: iscsit: Fix TAS handling during conn cleanup

Mike Marciniszyn (2):
      IB/hfi1: Add AIP tx traces
      IB/hfi1: Add additional usdma traces

Mike Snitzer (3):
      dm clone: call kmem_cache_destroy() in dm_clone_init() error path
      dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path
      dm ioctl: fix nested locking in table_clear() to remove deadlock concern

Mikulas Patocka (1):
      dm flakey: fix a crash with invalid table line

Miles Chen (1):
      sound/oss/dmasound: fix 'dmasound_setup' defined but not used

Ming Lei (1):
      nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage"

Minghao Chi (1):
      spi: spi-imx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

Miquel Raynal (1):
      of: Fix modalias string generation

Mukesh Ojha (1):
      firmware: qcom_scm: Clear download bit during reboot

Muralidhara M K (1):
      x86/MCE/AMD: Use an u64 for bank_map

Mårten Lindahl (1):
      ubifs: Free memory for tmpfile name

Natalia Petrova (1):
      RDMA/rdmavt: Delete unnecessary NULL check

Nathan Lynch (1):
      powerpc/rtas: use memmove for potentially overlapping buffer copy

Nicolai Stange (1):
      crypto: drbg - make drbg_prepare_hrng() handle jent instantiation errors

Nicolas Saenz Julienne (2):
      firmware: raspberrypi: Introduce devm_rpi_firmware_get()
      input: raspberrypi-ts: Release firmware handle when not needed

Nuno Sá (1):
      staging: iio: resolver: ads1210: fix config mode

Ondrej Mosnacek (1):
      selinux: fix Makefile dependencies of flask.h

Pablo Neira Ayuso (1):
      netfilter: nf_tables: deactivate anonymous set from preparation phase

Paolo Bonzini (1):
      KVM: x86: do not report a vCPU as preempted outside instruction boundaries

Patrick Kelsey (2):
      IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order
      IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec user SDMA requests

Patrik Dahlström (1):
      iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Paul Moore (1):
      selinux: ensure av_permissions.h is built when needed

Pawel Witek (1):
      cifs: fix pcchunk length type in smb2_copychunk_range

Peng Liu (1):
      scripts/gdb: fix lx-timerlist for Python3

Petr Mladek (1):
      workqueue: Fix hung time report of worker pools

Philipp Hortmann (1):
      staging: rtl8192e: Fix W_DISABLE# does not work after stop/start

Ping Cheng (2):
      HID: wacom: Set a default resolution for older tablets
      HID: wacom: insert timestamp to packed Bluetooth (BT) events

Prashanth K (1):
      usb: dwc3: gadget: Change condition for processing suspend event

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

Randy Dunlap (14):
      sound/oss/dmasound: fix build when drivers are mixed =y/=m
      ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead of depending on it
      linux/vt_buffer.h: allow either builtin or modular for macros
      ia64: mm/contig: fix section mismatch warning/error
      ia64: salinfo: placate defined-but-not-used warning
      powerpc/mpc512x: fix resource printk format warning
      powerpc/wii: fix resource printk format warnings
      powerpc/sysdev/tsi108: fix resource printk format warnings
      macintosh: via-pmu-led: requires ATA to be set
      leds: TI_LMU_COMMON: select REGMAP instead of depending on it
      sh: math-emu: fix macro redefined warning
      sh: mcount.S: fix build error when PRINTK is not enabled
      sh: init: use OF_EARLY_FLATTREE for early init
      sh: nmi_debug: fix return value of __setup handler

Reid Tonking (1):
      i2c: omap: Fix standard mode false ACK readings

Rishabh Bhatnagar (8):
      KVM: x86: Ensure PV TLB flush tracepoint reflects KVM behavior
      KVM: x86: Fix recording of guest steal time / preempted status
      KVM: Fix steal time asm constraints
      KVM: x86: Remove obsolete disabling of page faults in kvm_arch_vcpu_put()
      KVM: x86: do not set st->preempted when going back to user space
      KVM: x86: revalidate steal time cache if MSR value changes
      KVM: x86: do not report preemption if the steal time cache is stale
      KVM: x86: move guest_pv_has out of user_access section

Rob Clark (2):
      drm/rockchip: Drop unbalanced obj unref
      drm/msm/adreno: Defer enabling runpm until hw_init()

Roberto Sassu (1):
      reiserfs: Add security prefix to xattr name in reiserfs_security_write()

Roger Pau Monne (1):
      ACPI: processor: Fix evaluating _PDC method when running as Xen dom0

Ruihan Li (1):
      bluetooth: Perform careful capability checks in hci_sock_ioctl()

Ruliang Lin (1):
      ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`

Ryusuke Konishi (2):
      nilfs2: do not write dirty data after degenerating to read-only
      nilfs2: fix infinite loop in nilfs_mdt_get_block()

Saravanan Vajravel (1):
      RDMA/srpt: Add a check for valid 'mad_agent' pointer

Saurabh Sengar (1):
      x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

Sean Christopherson (1):
      KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not intercepted

Sebastian Andrzej Siewior (1):
      tick/common: Align tick period with the HZ tick.

Sebastian Reichel (2):
      net: ethernet: stmmac: dwmac-rk: fix optional phy regulator handling
      power: supply: generic-adc-battery: fix unit scaling

Shannon Nelson (1):
      ionic: remove noise from ethtool rxnfc error msg

Shenwei Wang (1):
      tty: serial: fsl_lpuart: adjust buffer length to the intended size

Shin'ichiro Kawasaki (1):
      scsi: target: core: Avoid smp_processor_id() in preemptible code

Shuchang Li (1):
      scsi: lpfc: Fix ioremap issues in lpfc_sli4_pci_mem_setup()

Shunsuke Mie (2):
      dmaengine: dw-edma: Fix to change for continuous transfer
      dmaengine: dw-edma: Fix to enable to issue dma request on DMA processing

Simon Horman (1):
      net: qrtr: correct types of trace event parameters

Stafford Horne (1):
      openrisc: Properly store r31 to pt_regs on unhandled exceptions

Stanimir Varbanov (2):
      media: venus: vdec: Fix non reliable setting of LAST flag
      media: venus: vdec: Make decoder return LAST flag for sufficient event

Stanislav Fomichev (1):
      bpf: Don't EFAULT for getsockopt with optval=NULL

Stefan Haberland (1):
      s390/dasd: fix hanging blockdevice after request requeue

Stephen Boyd (1):
      driver core: Don't require dynamic_debug for initcall_debug probe timing

Subbaraya Sundeep (2):
      octeontx2-pf: Disable packet I/O for graceful exit
      octeontx2-vf: Detach LF resources on probe cleanup

Suman Anna (1):
      crypto: sa2ul - Select CRYPTO_DES

Sumit Garg (1):
      arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

Suzuki K Poulose (1):
      coresight: etm_pmu: Set the module field

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

Thomas Gleixner (7):
      x86/fpu: Prevent FPU state corruption
      posix-cpu-timers: Implement the missing timer_wait_running callback
      debugobject: Prevent init race with static objects
      tick/sched: Use tick_next_period for lockless quick check
      tick/sched: Optimize tick_do_update_jiffies64() further
      tick: Get rid of tick_period
      debugobject: Ensure pool refill (again)

Tian Tao (1):
      drm/exynos: move to use request_irq by IRQF_NO_AUTOEN flag

Toke Høiland-Jørgensen (1):
      crypto: api - Demote BUG_ON() in crypto_unregister_alg() to a WARN_ON()

Tom Rix (1):
      wifi: iwlwifi: fw: move memset before early return

Tony Lindgren (1):
      soc: ti: pm33xx: Enable basic PM runtime support for genpd

Trond Myklebust (1):
      NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease

Tudor Ambarus (1):
      ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Tze-nan Wu (1):
      ring-buffer: Ensure proper resetting of atomic variables in ring_buffer_reset_online_cpus

Uros Bizjak (1):
      x86/apic: Fix atomic update of offset in reserve_eilvt_offset()

Uwe Kleine-König (3):
      spi: imx: Don't skip cleanup in remove's error path
      spi: qup: Don't skip cleanup in remove's error path
      pwm: mtk-disp: Don't check the return code of pwmchip_remove()

Vadim Fedorenko (1):
      vlan: partially enable SIOCSHWTSTAMP in container

Victor Nogueira (1):
      net/sched: act_mirred: Add carrier check

Ville Syrjälä (1):
      drm/i915: Make intel_get_crtc_new_encoder() less oopsy

Vincent Guittot (1):
      arm64: dts: qcom: sdm845: correct dynamic power coefficients

Vinod Polimera (1):
      drm/msm/disp/dpu: check for crtc enable rather than crtc active to release shared resources

Vitaly Kuznetsov (1):
      KVM: x86: hyper-v: Avoid calling kvm_make_vcpus_request_mask() with vcpu_mask==NULL

Vlad Buslov (1):
      net/sched: cls_api: remove block_cb from driver_list before freeing

Vladimir Oltean (1):
      asm-generic/io.h: suppress endianness warnings for readq() and writeq()

Wang YanQing (1):
      ubi: Fix return value overwrite issue in try_write_vid_and_data()

Wei Chen (2):
      wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_rfreg()
      wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_reg()

Wei Fang (1):
      net: enetc: check the index of the SFI rather than the handle

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

Yangtao Li (2):
      f2fs: handle dqget error in f2fs_transfer_project_quota()
      f2fs: compress: fix to call f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()

Ye Bin (2):
      ext4: fix use-after-free read in ext4_find_extent for bigalloc + inline
      ext4: fix WARNING in mb_find_extent

Yeongjin Gil (1):
      dm verity: fix error handling for check_at_most_once on FEC

YiFei Zhu (1):
      selftests/bpf: Wait for receive in cg_storage_multi test

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

Zheng Wang (5):
      media: rkvdec: fix use after free bug in rkvdec_remove
      media: dm1105: Fix use after free bug in dm1105_remove due to race condition
      media: saa7134: fix use after free bug in saa7134_finidev due to race condition
      usb: gadget: udc: renesas_usb3: Fix use after free bug in renesas_usb3_remove due to race condition
      scsi: qedi: Fix use after free bug in qedi_remove()

Zheng Yejian (1):
      rcu: Avoid stack overflow due to __rcu_irq_enter_check_tick() being kprobe-ed

Zhihao Cheng (2):
      Revert "ubifs: dirty_cow_znode: Fix memleak in error handling path"
      ubifs: Fix memleak when insert_old_idx() failed

Ziyang Xuan (1):
      ipv4: Fix potential uninit variable access bug in __ip_make_skb()

Zqiang (1):
      rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check

