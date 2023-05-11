Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44696FF499
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbjEKOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbjEKOhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A99311B48;
        Thu, 11 May 2023 07:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFEB364E41;
        Thu, 11 May 2023 14:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58642C433D2;
        Thu, 11 May 2023 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683815811;
        bh=1LE+VgBde8C06rhVkbuWXobh+oZvVB/7TU474cpfKyc=;
        h=From:To:Cc:Subject:Date:From;
        b=TW74bLGUdeHrBeVVY6WZfQjG0+MuzPQN1cC7QlOssqQqHfRdaAAtu+cgGhJ6O6Bvm
         rHxBTgKNgaeoffc92LeqEmFXrkcXKJAmSwyn49b4FtCEngQdXVmH5X0SLchhYx/OIe
         zT3cBCTxUhqzLhILD2boLuT2a0pAf4Y5ybE3xN6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.111
Date:   Thu, 11 May 2023 23:36:42 +0900
Message-Id: <2023051142-washstand-hacking-f1ce@gregkh>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.111 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                |    2 
 arch/arm/boot/dts/omap3-gta04.dtsi                                      |   16 
 arch/arm/boot/dts/qcom-ipq4019.dtsi                                     |    4 
 arch/arm/boot/dts/qcom-ipq8064.dtsi                                     |   12 
 arch/arm64/boot/dts/broadcom/Makefile                                   |    2 
 arch/arm64/boot/dts/broadcom/bcm4908/Makefile                           |    4 
 arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts         |  157 --
 arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts |  182 ---
 arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi                       |   26 
 arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts         |  159 --
 arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi                       |  339 -----
 arch/arm64/boot/dts/broadcom/bcmbca/Makefile                            |   10 
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts          |  157 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts  |  182 +++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4906.dtsi                        |   26 
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts          |  159 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-netgear-raxe500.dts         |   50 
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi                        |  339 +++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4912-asus-gt-ax6000.dts          |   19 
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi                        |  128 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi                       |  128 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi                        |  121 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts                        |   30 
 arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts                       |   30 
 arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts                        |   30 
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                                   |    6 
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                                   |   12 
 arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi                |    3 
 arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi              |    3 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                                   |   12 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                                   |    4 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts      |    2 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                    |   30 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                    |    8 
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi                               |    3 
 arch/arm64/boot/dts/renesas/r8a77990.dtsi                               |    3 
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                               |    1 
 arch/arm64/include/asm/debug-monitors.h                                 |    1 
 arch/arm64/include/asm/scs.h                                            |    7 
 arch/arm64/kernel/debug-monitors.c                                      |    5 
 arch/arm64/kernel/entry.S                                               |   16 
 arch/arm64/kernel/head.S                                                |    2 
 arch/arm64/kernel/kgdb.c                                                |    2 
 arch/ia64/kernel/salinfo.c                                              |    2 
 arch/ia64/mm/contig.c                                                   |    2 
 arch/ia64/mm/hugetlbpage.c                                              |    2 
 arch/mips/fw/lib/cmdline.c                                              |    2 
 arch/openrisc/kernel/entry.S                                            |    6 
 arch/parisc/kernel/real2.S                                              |    5 
 arch/powerpc/kernel/rtas.c                                              |    2 
 arch/powerpc/platforms/512x/clock-commonclk.c                           |    2 
 arch/powerpc/platforms/embedded6xx/flipper-pic.c                        |    2 
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c                           |    2 
 arch/powerpc/platforms/embedded6xx/wii.c                                |    4 
 arch/powerpc/sysdev/tsi108_pci.c                                        |    5 
 arch/riscv/mm/init.c                                                    |    6 
 arch/sh/kernel/cpu/sh4/sq.c                                             |    2 
 arch/x86/include/asm/intel-family.h                                     |    2 
 arch/x86/kernel/apic/apic.c                                             |    5 
 arch/x86/kernel/apic/io_apic.c                                          |   14 
 arch/x86/kernel/cpu/mce/amd.c                                           |   14 
 arch/x86/kernel/cpu/mshyperv.c                                          |   12 
 arch/x86/kvm/vmx/vmx.c                                                  |   15 
 block/blk-core.c                                                        |    7 
 block/blk-crypto-internal.h                                             |   25 
 block/blk-crypto.c                                                      |   69 -
 block/blk-merge.c                                                       |    2 
 block/blk-mq.c                                                          |    2 
 block/keyslot-manager.c                                                 |   43 
 crypto/algapi.c                                                         |    4 
 crypto/drbg.c                                                           |   16 
 drivers/acpi/processor_pdc.c                                            |   11 
 drivers/acpi/viot.c                                                     |    5 
 drivers/base/cpu.c                                                      |    3 
 drivers/base/platform.c                                                 |    4 
 drivers/bluetooth/btsdio.c                                              |    1 
 drivers/char/ipmi/Kconfig                                               |    3 
 drivers/char/ipmi/ipmi_ssif.c                                           |    8 
 drivers/char/tpm/tpm_tis_core.c                                         |  131 +-
 drivers/char/tpm/tpm_tis_core.h                                         |    2 
 drivers/clk/at91/clk-sam9x60-pll.c                                      |    2 
 drivers/clk/clk-conf.c                                                  |   12 
 drivers/clk/qcom/Makefile                                               |    1 
 drivers/clk/qcom/clk-regmap-phy-mux.c                                   |   62 +
 drivers/clk/qcom/clk-regmap-phy-mux.h                                   |   33 
 drivers/clk/qcom/gcc-sm6115.c                                           |   50 
 drivers/clk/qcom/gcc-sm8350.c                                           |   47 
 drivers/clk/rockchip/clk-rk3399.c                                       |    2 
 drivers/clocksource/timer-davinci.c                                     |   30 
 drivers/cpufreq/cpufreq.c                                               |    2 
 drivers/crypto/Kconfig                                                  |    1 
 drivers/crypto/caam/ctrl.c                                              |    6 
 drivers/crypto/inside-secure/safexcel.c                                 |   37 
 drivers/dma/at_xdmac.c                                                  |   33 
 drivers/dma/dw-edma/dw-edma-core.c                                      |   27 
 drivers/dma/mv_xor_v2.c                                                 |    2 
 drivers/dma/qcom/gpi.c                                                  |    1 
 drivers/edac/skx_base.c                                                 |    4 
 drivers/firmware/arm_scmi/driver.c                                      |    2 
 drivers/firmware/qcom_scm.c                                             |    3 
 drivers/firmware/stratix10-svc.c                                        |    4 
 drivers/fpga/fpga-bridge.c                                              |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                       |    3 
 drivers/gpu/drm/amd/display/dc/dce60/Makefile                           |    2 
 drivers/gpu/drm/bridge/adv7511/adv7533.c                                |   25 
 drivers/gpu/drm/drm_probe_helper.c                                      |    5 
 drivers/gpu/drm/i915/display/intel_display.c                            |    2 
 drivers/gpu/drm/lima/lima_drv.c                                         |    6 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                   |    8 
 drivers/gpu/drm/msm/adreno/adreno_device.c                              |    7 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                 |    1 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                             |    2 
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c                               |    4 
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                             |    3 
 drivers/gpu/drm/ttm/ttm_pool.c                                          |  161 +-
 drivers/gpu/drm/vgem/vgem_fence.c                                       |    1 
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                                  |    9 
 drivers/hwmon/adt7475.c                                                 |    6 
 drivers/hwmon/k10temp.c                                                 |    4 
 drivers/hwmon/pmbus/fsp-3y.c                                            |    1 
 drivers/hwtracing/coresight/coresight-etm-perf.c                        |    1 
 drivers/i2c/busses/i2c-cadence.c                                        |    6 
 drivers/i2c/busses/i2c-omap.c                                           |    2 
 drivers/iio/adc/palmas_gpadc.c                                          |    2 
 drivers/iio/light/max44009.c                                            |   13 
 drivers/infiniband/core/cm.c                                            |    3 
 drivers/infiniband/hw/hfi1/ipoib_tx.c                                   |    1 
 drivers/infiniband/hw/hfi1/mmu_rb.c                                     |   73 -
 drivers/infiniband/hw/hfi1/mmu_rb.h                                     |    8 
 drivers/infiniband/hw/hfi1/sdma.c                                       |   21 
 drivers/infiniband/hw/hfi1/sdma.h                                       |   16 
 drivers/infiniband/hw/hfi1/sdma_txreq.h                                 |    1 
 drivers/infiniband/hw/hfi1/trace_mmu.h                                  |    4 
 drivers/infiniband/hw/hfi1/user_sdma.c                                  |  600 ++++++----
 drivers/infiniband/hw/hfi1/user_sdma.h                                  |    5 
 drivers/infiniband/hw/hfi1/verbs.c                                      |    4 
 drivers/infiniband/hw/hfi1/vnic_sdma.c                                  |    1 
 drivers/infiniband/hw/mlx4/qp.c                                         |    8 
 drivers/infiniband/hw/mlx5/devx.c                                       |   31 
 drivers/infiniband/hw/mlx5/qp.c                                         |    2 
 drivers/infiniband/sw/rdmavt/qp.c                                       |    2 
 drivers/infiniband/sw/siw/siw_main.c                                    |    3 
 drivers/infiniband/sw/siw/siw_qp_tx.c                                   |    2 
 drivers/infiniband/ulp/srpt/ib_srpt.c                                   |   23 
 drivers/input/touchscreen/raspberrypi-ts.c                              |    3 
 drivers/iommu/amd/amd_iommu_types.h                                     |    4 
 drivers/leds/Kconfig                                                    |    2 
 drivers/leds/leds-tca6507.c                                             |    5 
 drivers/macintosh/Kconfig                                               |    1 
 drivers/macintosh/windfarm_smu_sat.c                                    |    1 
 drivers/mailbox/mailbox-mpfs.c                                          |   12 
 drivers/mailbox/zynqmp-ipi-mailbox.c                                    |    6 
 drivers/md/dm-clone-target.c                                            |    1 
 drivers/md/dm-flakey.c                                                  |    4 
 drivers/md/dm-integrity.c                                               |    8 
 drivers/md/dm-ioctl.c                                                   |   12 
 drivers/md/dm-table.c                                                   |   19 
 drivers/md/dm-verity-target.c                                           |    2 
 drivers/md/raid1-10.c                                                   |    6 
 drivers/md/raid1.c                                                      |    7 
 drivers/md/raid10.c                                                     |  221 ++-
 drivers/media/i2c/max9286.c                                             |    1 
 drivers/media/pci/dm1105/dm1105.c                                       |    1 
 drivers/media/pci/saa7134/saa7134-ts.c                                  |    1 
 drivers/media/pci/saa7134/saa7134-vbi.c                                 |    1 
 drivers/media/pci/saa7134/saa7134-video.c                               |    1 
 drivers/media/platform/qcom/venus/vdec.c                                |    8 
 drivers/media/platform/rcar_fdp1.c                                      |   28 
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c                           |    2 
 drivers/media/rc/gpio-ir-recv.c                                         |    2 
 drivers/mfd/tqmx86.c                                                    |   52 
 drivers/misc/vmw_vmci/vmci_host.c                                       |    8 
 drivers/mmc/host/sdhci-of-esdhc.c                                       |   24 
 drivers/mtd/mtdcore.c                                                   |   23 
 drivers/mtd/ubi/eba.c                                                   |   19 
 drivers/net/ethernet/amd/nmclan_cs.c                                    |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                        |   23 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c              |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c                          |   14 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                       |   12 
 drivers/net/pcs/pcs-xpcs.c                                              |   13 
 drivers/net/wireguard/timers.c                                          |    8 
 drivers/net/wireless/ath/ath5k/eeprom.c                                 |    2 
 drivers/net/wireless/ath/ath6kl/bmi.c                                   |    2 
 drivers/net/wireless/ath/ath6kl/htc_pipe.c                              |    4 
 drivers/net/wireless/ath/ath9k/hif_usb.c                                |   19 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c             |   14 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                             |    8 
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c                         |    4 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c                        |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                             |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c                        |   10 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                         |    3 
 drivers/net/wireless/mediatek/mt76/dma.c                                |    2 
 drivers/net/wireless/mediatek/mt76/mt76.h                               |    9 
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                         |    5 
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                         |   13 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                    |   13 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                        |    5 
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c                         |   40 
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c                         |    6 
 drivers/net/wireless/mediatek/mt76/tx.c                                 |    4 
 drivers/net/wireless/mediatek/mt76/util.c                               |   10 
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c                          |    1 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c                  |    1 
 drivers/net/wireless/realtek/rtlwifi/debug.c                            |   12 
 drivers/net/wireless/realtek/rtw88/mac.c                                |    8 
 drivers/nvme/host/core.c                                                |   34 
 drivers/nvme/host/trace.h                                               |   15 
 drivers/nvme/target/admin-cmd.c                                         |   51 
 drivers/nvme/target/configfs.c                                          |    3 
 drivers/nvme/target/core.c                                              |    5 
 drivers/nvme/target/fcloop.c                                            |   48 
 drivers/nvme/target/io-cmd-file.c                                       |   17 
 drivers/nvme/target/nvmet.h                                             |    6 
 drivers/nvme/target/zns.c                                               |   16 
 drivers/of/device.c                                                     |    7 
 drivers/pci/controller/dwc/pci-imx6.c                                   |    7 
 drivers/pci/controller/dwc/pcie-qcom.c                                  |    8 
 drivers/pci/hotplug/pciehp_pci.c                                        |   15 
 drivers/pci/pcie/edr.c                                                  |    1 
 drivers/phy/tegra/xusb.c                                                |    2 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                                |   14 
 drivers/pinctrl/renesas/pfc-r8a779a0.c                                  |    8 
 drivers/power/supply/generic-adc-battery.c                              |    3 
 drivers/pwm/pwm-meson.c                                                 |    6 
 drivers/pwm/pwm-mtk-disp.c                                              |   34 
 drivers/regulator/core.c                                                |  100 +
 drivers/regulator/stm32-pwr.c                                           |    7 
 drivers/rtc/rtc-meson-vrtc.c                                            |    4 
 drivers/rtc/rtc-omap.c                                                  |    1 
 drivers/s390/block/dasd.c                                               |    2 
 drivers/scsi/lpfc/lpfc_init.c                                           |   10 
 drivers/scsi/megaraid.c                                                 |    1 
 drivers/soc/ti/pm33xx.c                                                 |    5 
 drivers/soundwire/qcom.c                                                |    2 
 drivers/spi/spi-cadence-quadspi.c                                       |   19 
 drivers/spi/spi-fsl-spi.c                                               |   12 
 drivers/spi/spi-imx.c                                                   |   14 
 drivers/spi/spi-qup.c                                                   |   22 
 drivers/spmi/spmi.c                                                     |    3 
 drivers/staging/iio/resolver/ad2s1210.c                                 |    2 
 drivers/staging/media/av7110/av7110_av.c                                |    4 
 drivers/staging/media/rkvdec/rkvdec.c                                   |    2 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                            |    1 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                               |    8 
 drivers/target/iscsi/iscsi_target.c                                     |   16 
 drivers/target/target_core_device.c                                     |    1 
 drivers/target/target_core_tmr.c                                        |   26 
 drivers/thermal/mtk_thermal.c                                           |   14 
 drivers/tty/serial/8250/8250_bcm7271.c                                  |   18 
 drivers/tty/serial/8250/8250_port.c                                     |    4 
 drivers/tty/serial/fsl_lpuart.c                                         |    2 
 drivers/tty/serial/stm32-usart.c                                        |   26 
 drivers/tty/sysrq.c                                                     |    2 
 drivers/tty/tty.h                                                       |    2 
 drivers/tty/tty_io.c                                                    |    4 
 drivers/tty/tty_ioctl.c                                                 |   45 
 drivers/usb/chipidea/core.c                                             |    2 
 drivers/usb/dwc3/core.c                                                 |   15 
 drivers/usb/dwc3/gadget.c                                               |   11 
 drivers/usb/gadget/udc/renesas_usb3.c                                   |    1 
 drivers/usb/gadget/udc/tegra-xudc.c                                     |    2 
 drivers/usb/host/xhci-debugfs.c                                         |    1 
 drivers/usb/host/xhci-rcar.c                                            |    3 
 drivers/usb/mtu3/mtu3_qmu.c                                             |    5 
 drivers/virtio/virtio_ring.c                                            |   22 
 drivers/xen/pcpu.c                                                      |   20 
 fs/afs/inode.c                                                          |    1 
 fs/btrfs/ioctl.c                                                        |    5 
 fs/cifs/file.c                                                          |   16 
 fs/cifs/misc.c                                                          |    8 
 fs/erofs/internal.h                                                     |    2 
 fs/erofs/zmap.c                                                         |    4 
 fs/ext4/acl.c                                                           |    2 
 fs/ext4/extents.c                                                       |    6 
 fs/ext4/file.c                                                          |    4 
 fs/ext4/inode.c                                                         |   10 
 fs/ext4/ioctl.c                                                         |   10 
 fs/f2fs/compress.c                                                      |    6 
 fs/f2fs/data.c                                                          |    5 
 fs/f2fs/f2fs.h                                                          |    2 
 fs/f2fs/file.c                                                          |   15 
 fs/f2fs/segment.c                                                       |   76 -
 fs/f2fs/segment.h                                                       |    6 
 fs/f2fs/super.c                                                         |   33 
 fs/fs-writeback.c                                                       |   17 
 fs/jbd2/journal.c                                                       |    2 
 fs/jbd2/transaction.c                                                   |    3 
 fs/ksmbd/server.c                                                       |    1 
 fs/ksmbd/smb2pdu.c                                                      |    7 
 fs/nfs/nfs4state.c                                                      |    4 
 fs/nilfs2/bmap.c                                                        |   16 
 fs/nilfs2/segment.c                                                     |    5 
 fs/ntfs3/fslog.c                                                        |    6 
 fs/ntfs3/index.c                                                        |    8 
 fs/ntfs3/inode.c                                                        |    2 
 fs/ntfs3/ntfs_fs.h                                                      |    1 
 fs/pstore/pmsg.c                                                        |    7 
 fs/reiserfs/xattr_security.c                                            |    8 
 fs/ubifs/dir.c                                                          |    1 
 fs/ubifs/tnc.c                                                          |  142 +-
 fs/xfs/libxfs/xfs_sb.c                                                  |   11 
 include/asm-generic/io.h                                                |    4 
 include/linux/blk-crypto.h                                              |    4 
 include/linux/mailbox/zynqmp-ipi-message.h                              |    2 
 include/linux/mlx5/mlx5_ifc.h                                           |    3 
 include/linux/netfilter/nfnetlink.h                                     |    1 
 include/linux/nvme.h                                                    |    4 
 include/linux/platform_device.h                                         |   11 
 include/linux/posix-timers.h                                            |   17 
 include/linux/sched.h                                                   |    6 
 include/linux/sunrpc/sched.h                                            |    3 
 include/linux/tick.h                                                    |    2 
 include/linux/vt_buffer.h                                               |    2 
 include/linux/workqueue.h                                               |    3 
 include/net/netfilter/nf_tables.h                                       |    1 
 include/net/scm.h                                                       |   13 
 include/net/xsk_buff_pool.h                                             |    9 
 include/target/target_core_base.h                                       |    1 
 include/trace/events/qrtr.h                                             |   33 
 include/trace/events/timer.h                                            |    3 
 include/uapi/linux/btrfs.h                                              |    1 
 include/uapi/linux/const.h                                              |    2 
 include/xen/xen.h                                                       |   11 
 kernel/bpf/cgroup.c                                                     |    9 
 kernel/bpf/verifier.c                                                   |   26 
 kernel/events/core.c                                                    |    4 
 kernel/kheaders.c                                                       |   10 
 kernel/power/process.c                                                  |    2 
 kernel/rcu/tree.c                                                       |    1 
 kernel/relay.c                                                          |    3 
 kernel/sched/core.c                                                     |   25 
 kernel/sched/deadline.c                                                 |    5 
 kernel/sched/debug.c                                                    |   93 -
 kernel/sched/fair.c                                                     |   93 -
 kernel/sched/rt.c                                                       |    8 
 kernel/sched/stats.h                                                    |   19 
 kernel/sched/stop_task.c                                                |    4 
 kernel/time/posix-cpu-timers.c                                          |   81 +
 kernel/time/posix-timers.c                                              |    4 
 kernel/time/tick-common.c                                               |   12 
 kernel/time/tick-sched.c                                                |   16 
 kernel/time/timekeeping.c                                               |    4 
 kernel/trace/ring_buffer.c                                              |    4 
 kernel/trace/trace.c                                                    |    2 
 kernel/workqueue.c                                                      |  176 +-
 lib/debugobjects.c                                                      |  146 +-
 mm/backing-dev.c                                                        |   12 
 net/8021q/vlan_dev.c                                                    |    2 
 net/core/skbuff.c                                                       |    3 
 net/ipv4/ip_output.c                                                    |   16 
 net/netfilter/nf_tables_api.c                                           |   20 
 net/netfilter/nfnetlink.c                                               |    2 
 net/netfilter/nft_dynset.c                                              |    2 
 net/netfilter/nft_lookup.c                                              |    2 
 net/netfilter/nft_objref.c                                              |    2 
 net/netlink/af_netlink.c                                                |   75 -
 net/packet/af_packet.c                                                  |   30 
 net/packet/diag.c                                                       |    4 
 net/packet/internal.h                                                   |   26 
 net/sched/sch_fq.c                                                      |    6 
 net/sunrpc/clnt.c                                                       |    3 
 net/sunrpc/sched.c                                                      |    1 
 net/xdp/xsk_queue.h                                                     |    1 
 scripts/gdb/linux/clk.py                                                |    2 
 scripts/gdb/linux/constants.py.in                                       |    2 
 scripts/gdb/linux/genpd.py                                              |    4 
 scripts/gdb/linux/timerlist.py                                          |    4 
 scripts/gdb/linux/utils.py                                              |    5 
 scripts/gdb/vmlinux-gdb.py                                              |    5 
 security/integrity/ima/Kconfig                                          |    2 
 security/selinux/Makefile                                               |    4 
 sound/oss/dmasound/dmasound.h                                           |    6 
 sound/oss/dmasound/dmasound_core.c                                      |   26 
 sound/soc/codecs/es8316.c                                               |   14 
 sound/soc/fsl/fsl_mqs.c                                                 |   15 
 sound/soc/intel/boards/bytcr_rt5640.c                                   |   12 
 sound/soc/intel/boards/sof_sdw.c                                        |   11 
 sound/soc/soc-pcm.c                                                     |    4 
 sound/usb/quirks-table.h                                                |   58 
 tools/arch/x86/kcpuid/cpuid.csv                                         |    4 
 tools/bpf/bpftool/json_writer.c                                         |    3 
 tools/bpf/bpftool/xlated_dumper.c                                       |    7 
 tools/objtool/check.c                                                   |   11 
 tools/perf/util/auxtrace.c                                              |    5 
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c                     |    2 
 tools/testing/selftests/bpf/network_helpers.c                           |    2 
 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c               |    8 
 tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c      |    1 
 tools/testing/selftests/bpf/test_xsk.sh                                 |    1 
 tools/testing/selftests/mount_setattr/mount_setattr_test.c              |    1 
 tools/testing/selftests/resctrl/cache.c                                 |    4 
 tools/testing/selftests/resctrl/cat_test.c                              |    4 
 tools/testing/selftests/resctrl/cmt_test.c                              |    2 
 tools/testing/selftests/resctrl/fill_buf.c                              |    2 
 tools/testing/selftests/resctrl/mba_test.c                              |    9 
 tools/testing/selftests/resctrl/mbm_test.c                              |    2 
 tools/testing/selftests/resctrl/resctrl.h                               |    7 
 tools/testing/selftests/resctrl/resctrl_tests.c                         |   41 
 tools/testing/selftests/resctrl/resctrl_val.c                           |   21 
 tools/testing/selftests/resctrl/resctrlfs.c                             |    2 
 402 files changed, 4727 insertions(+), 2969 deletions(-)

Adam Ford (1):
      drm/bridge: adv7533: Fix adv7533_mode_valid for adv7533 and adv7535

Adam Skladowski (1):
      drm: msm: adreno: Disable preemption on Adreno 510

Adrian Hunter (2):
      perf auxtrace: Fix address filter entire kernel size
      perf intel-pt: Fix CYC timestamps after standalone CBR

Albert Huang (1):
      virtio_ring: don't update event idx on get_buf

Alexander Mikhalitsyn (1):
      scm: fix MSG_CTRUNC setting condition for SO_PASSSEC

Alexey V. Vissarionov (1):
      wifi: ath6kl: minor fix for allocation size

Anand Gore (1):
      ARM64: dts: Add DTS files for bcmbca SoC BCM6858

Andrii Nakryiko (2):
      bpf: take into account liveness when propagating precision
      bpf: fix precision propagation verbose logging

AngeloGioacchino Del Regno (2):
      pwm: mtk-disp: Disable shadow registers before setting backlight values
      pwm: mtk-disp: Configure double buffering before reading in .get_state()

Anh Tuan Phan (1):
      selftests mount: Fix mount_setattr_test builds failed

Ard Biesheuvel (2):
      arm64: Always load shadow stack pointer directly from the task struct
      arm64: Stash shadow stack pointer in the task struct on interrupt

Armin Wolf (1):
      wifi: rt2x00: Fix memory leak when handling surveys

Babu Moger (1):
      hwmon: (k10temp) Check range scale when CUR_TEMP register is read-write

Baokun Li (1):
      writeback, cgroup: fix null-ptr-deref write in bdi_split_work_to_wbs

Basavaraj Natikar (1):
      HID: amd_sfh: Add support for shutdown operation

Bharath SM (2):
      SMB3: Add missing locks to protect deferred close file list
      SMB3: Close deferred file handles in case of handle lease break

Bhavya Kapoor (1):
      arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel property

Bitterblue Smith (1):
      wifi: rtl8xxxu: RTL8192EU always needs full init

Cai Huoqing (1):
      media: rcar_fdp1: Make use of the helper function devm_platform_ioremap_resource()

Chaitanya Kulkarni (1):
      nvmet: use i_size_read() to set size for file-ns

Chao Yu (1):
      f2fs: fix to avoid use-after-free for cached IPU bio

Chen Zhongjin (1):
      fs/ntfs3: Fix memory leak if ntfs_read_mft failed

Chris Mi (1):
      net/mlx5: E-switch, Don't destroy indirect table in split rule

Chris Packham (1):
      hwmon: (adt7475) Use device_property APIs when configuring polarity

Christian König (1):
      drm/ttm: optimize pool allocations a bit v2

Christian Marangi (1):
      ARM: dts: qcom: ipq8064: reduce pci IO size to 64K

Christoph Hellwig (1):
      nvmet: move the call to nvmet_ns_changed out of nvmet_ns_revalidate

Christophe JAILLET (2):
      crypto: caam - Clear some memory in instantiate_rng
      dmaengine: mv_xor_v2: Fix an error code.

Christophe Leroy (1):
      spi: fsl-spi: Fix CPM/QE mode Litte Endian

Chunfeng Yun (1):
      usb: mtu3: fix kernel panic at qmu transfer done irq handler

Claudiu Beznea (2):
      clk: at91: clk-sam9x60-pll: fix return value check
      dmaengine: at_xdmac: do not enable all cyclic channels

Clément Léger (1):
      clk: add missing of_node_put() in "assigned-clocks" property parsing

Conor Dooley (1):
      mailbox: mpfs: switch to txdone_poll

Corey Minyard (1):
      ipmi:ssif: Add send_retries increment

Cristian Ciocaltea (1):
      ASoC: es8316: Handle optional IRQ assignment

Cristian Marussi (1):
      firmware: arm_scmi: Fix xfers allocation on Rx channel

Dae R. Jeong (1):
      vmci_host: fix a race condition in vmci_host_poll() causing GPF

Dai Ngo (1):
      SUNRPC: remove the maximum number of retries in call_bind_status

Damien Le Moal (5):
      nvmet: fix error handling in nvmet_execute_identify_cns_cs_ns()
      nvmet: fix Identify Namespace handling
      nvmet: fix Identify Controller handling
      nvmet: fix Identify Active Namespace ID list handling
      nvmet: fix I/O Command Set specific Identify Controller

Dan Carpenter (5):
      media: av7110: prevent underflow in write_ts_to_decoder()
      drm: rcar-du: Fix a NULL vs IS_ERR() bug
      wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()
      firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
      RDMA/mlx4: Prevent shift wrapping in set_user_sq_size()

Daniel Borkmann (1):
      bpf, sockmap: Revert buggy deadlock fix in the sockhash and sockmap

Daniel Gabay (2):
      wifi: iwlwifi: yoyo: skip dump correctly on hw error
      wifi: iwlwifi: yoyo: Fix possible division by zero

Daniil Dulov (1):
      RDMA/siw: Fix potential page_array out of range access

Danila Chernetsov (1):
      scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS

Dave Chinner (1):
      xfs: don't consider future format versions valid

Davide Caratti (1):
      net/sched: sch_fq: fix integer overflow of "credit"

Deren Wu (1):
      wifi: mt76: add flexible polling wait-interval support

Dhruva Gole (1):
      spi: cadence-quadspi: fix suspend-resume implementations

Dmitry Baryshkov (4):
      arm64: dts: qcom: sdm845: correct dynamic power coefficients
      clk: qcom: regmap: add PHY clock source implementation
      clk: qcom: gcc-sm8350: fix PCIe PIPE clocks handling
      dma: gpi: remove spurious unlock in gpi_ch_init

Dom Cobley (1):
      drm/probe-helper: Cancel previous job before starting new one

Doug Berger (1):
      serial: 8250_bcm7271: Fix arbitration handling

Douglas Anderson (3):
      regulator: core: Shorten off-on-delay-us for always-on/boot-on by time since booted
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

Erwan Le Ray (1):
      serial: stm32: re-introduce an irq flag condition in usart_receive_chars

Eugene Huang (1):
      ASOC: Intel: sof_sdw: add quirk for Intel 'Rooks County' NUC M15

Fedor Pchelkin (2):
      wifi: ath9k: hif_usb: fix memory leak of remain_skbs
      wifi: ath6kl: reduce WARN to dev_dbg() in callback

Felix Fietkau (1):
      wifi: mt76: add missing locking to protect against concurrent rx/status calls

Florian Fainelli (5):
      media: rc: gpio-ir-recv: Fix support for wake-up
      scripts/gdb: bail early if there are no clocks
      scripts/gdb: bail early if there are no generic PD
      scripts/gdb: raise error with reduced debugging information
      serial: 8250: Add missing wakeup event reporting

Florian Westphal (1):
      netfilter: nf_tables: don't write table validation state without mutex

Gao Xiang (1):
      erofs: stop parsing non-compact HEAD index if clusterofs is invalid

Gaosheng Cui (1):
      phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port

Geert Uytterhoeven (3):
      arm64: dts: renesas: r8a77990: Remove bogus voltages from OPP table
      arm64: dts: renesas: r8a774c0: Remove bogus voltages from OPP table
      timekeeping: Fix references to nonexistent ktime_get_fast_ns()

Gencen Gan (1):
      net: amd: Fix link leak when verifying config failed

Georgii Kruglov (1):
      mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data

Geraldo Nascimento (1):
      ALSA: usb-audio: Add quirk for Pioneer DDJ-800

Greg Kroah-Hartman (1):
      Linux 5.15.111

H. Nikolaus Schaller (3):
      ARM: dts: gta04: fix excess dma channel usage
      PCI: imx6: Install the fault handler only on compatible match
      leds: tca6507: Fix error handling of using fwnode_property_read_string

Hai Pham (1):
      pinctrl: renesas: r8a779a0: Remove incorrect AVB[01] pinmux configuration

Hans de Goede (3):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Acer Iconia One 7 B1-750
      drivers: staging: rtl8723bs: Fix locking in _rtw_join_timeout_handler()
      drivers: staging: rtl8723bs: Fix locking in rtw_scan_timeout_handler()

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

Igor Artemiev (1):
      drm/amd/display: Fix potential null dereference

Ilpo Järvinen (5):
      tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH
      selftests/resctrl: Return NULL if malloc_and_init_memory() did not alloc mem
      selftests/resctrl: Move ->setup() call outside of test specific branches
      selftests/resctrl: Allow ->setup() to return errors
      selftests/resctrl: Check for return value after write_schemata()

Imran Khan (1):
      workqueue: Introduce show_one_worker_pool and show_one_workqueue.

Jaegeuk Kim (2):
      f2fs: enforce single zone capacity
      f2fs: apply zone capacity to all zone type

Jan Kara (1):
      jdb2: Don't refuse invalidation of already invalidated buffers

Jean-Philippe Brucker (1):
      ACPI: VIOT: Initialize the correct IOMMU fwspec

Jiasheng Jiang (2):
      media: bdisp: Add missing check for create_workqueue
      fs/ntfs3: Add check for kmemdup

Jiaxun Yang (1):
      MIPS: fw: Allow firmware to pass a empty env

Jingbo Xu (1):
      erofs: fix potential overflow calculating xattr_isize

Jiri Slaby (SUSE) (1):
      wireguard: timers: cast enum limits members to int in prints

Jishnu Prakash (1):
      spmi: Add a check for remove callback when removing a SPMI driver

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

John Keeping (1):
      wifi: brcmfmac: support CQM RSSI notification with older firmware

John Paul Adrian Glaubitz (1):
      sh: sq: Fix incorrect element size for allocating bitmap buffer

John Stultz (1):
      pstore: Revert pmsg_lock back to a normal mutex

Jon Hunter (1):
      usb: gadget: tegra-xudc: Fix crash in vbus_draw

Jonathan McDowell (1):
      crypto: safexcel - Cleanup ring IRQ workqueues on load failure

Josh Poimboeuf (1):
      Revert "objtool: Support addition to set CFA base"

Kal Conley (2):
      selftests: xsk: Disable IPv6 on VETH1
      xsk: Fix unaligned descriptor validation

Kang Chen (2):
      wifi: mt76: handle failure of vzalloc in mt7615_coredump_work
      thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe

Kees Cook (1):
      kheaders: Use array declaration instead of char

Keith Busch (1):
      nvme: fix async event trace event

Kevin Brodsky (1):
      uapi/linux/const.h: prefer ISO-friendly __typeof__

Kishon Vijay Abraham I (1):
      iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration in IRTE

Konrad Dybcio (2):
      arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name
      clk: qcom: gcc-sm6115: Mark RCGs shared where applicable

Krzysztof Kozlowski (7):
      soundwire: qcom: correct setting ignore bit on v1.5.1
      pinctrl: qcom: lpass-lpi: set output value before enabling output
      arm64: dts: qcom: sc7180-trogdor-lazor: correct trackpad supply
      arm64: dts: qcom: msm8994-kitakami: drop unit address from PMI8994 regulator
      arm64: dts: qcom: msm8994-msft-lumia-octagon: drop unit address from PMI8994 regulator
      iio: light: max44009: add missing OF device matching
      rtc: omap: include header for omap_rtc_power_off_program prototype

Kuniyuki Iwashima (2):
      netlink: Use copy_to_user() for optval in netlink_getsockopt().
      tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.

Kuppuswamy Sathyanarayanan (1):
      PCI/EDR: Clear Device Status after EDR error recovery

Lars-Peter Clausen (1):
      i2c: cadence: cdns_i2c_master_xfer(): Fix runtime PM leak on error path

Laurent Pinchart (1):
      media: max9286: Free control handler

Lee Jones (1):
      drm/amd/display/dc/dce60/Makefile: Fix previous attempt to silence known override-init warnings

Li Lingfeng (1):
      dm: don't lock fs when the map is NULL in process of resume

Li Nan (2):
      md/raid10: fix task hung in raid10d
      md/raid10: fix null-ptr-deref in raid10_sync_request

Liang He (1):
      macintosh/windfarm_smu_sat: Add missing of_node_put()

Libo Chen (1):
      sched/fair: Fix inaccurate tally of ttwu_move_affine

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

Manivannan Sadhasivam (9):
      PCI: qcom: Fix the incorrect register usage in v2.7.0 config
      arm64: dts: qcom: sdm845: Fix the PCI I/O port range
      arm64: dts: qcom: msm8998: Fix the PCI I/O port range
      arm64: dts: qcom: ipq8074: Fix the PCI I/O port range
      arm64: dts: qcom: ipq6018: Fix the PCI I/O port range
      arm64: dts: qcom: msm8996: Fix the PCI I/O port range
      arm64: dts: qcom: sm8250: Fix the PCI I/O port range
      ARM: dts: qcom: ipq4019: Fix the PCI I/O port range
      ARM: dts: qcom: ipq8064: Fix the PCI I/O port range

Marc Dionne (1):
      afs: Fix updating of i_size with dv jump from server

Marco Pagani (1):
      fpga: bridge: fix kernel-doc parameter description

Marek Vasut (1):
      serial: stm32: Re-assert RTS/DE GPIO in RS485 mode only if more data are transmitted

Mario Limonciello (1):
      wifi: mt76: mt7921e: Set memory space enable in PCI_COMMAND if unset

Mariusz Tkaczyk (1):
      md: drop queue limitation for RAID1 and RAID10

Mark Bloch (1):
      RDMA/mlx5: Fix flow counter query via DEVX

Mark Zhang (2):
      RDMA/cm: Trace icm_send_rej event before the cm state is reset
      RDMA/mlx5: Use correct device num_ports when modify DC

Martin Blumenstingl (3):
      wifi: rtw88: mac: Return the original error from rtw_pwr_seq_parser()
      wifi: rtw88: mac: Return the original error from rtw_mac_power_switch()
      rtc: meson-vrtc: Use ktime_get_real_ts64() to get the current time

Martin KaFai Lau (1):
      selftests/bpf: Fix a fd leak in an error path in network_helpers.c

Matthias Schiffer (3):
      mfd: tqmx86: Do not access I2C_DETECT register through io_base
      mfd: tqmx86: Specify IO port register range more precisely
      mfd: tqmx86: Correct board names for TQMxE39x

Maíra Canal (1):
      drm/vgem: add missing mutex_destroy

Miaoqian Lin (3):
      soc: ti: pm33xx: Fix refcount leak in am33xx_pm_probe
      media: rcar_fdp1: Fix refcount leak in probe and remove function
      Input: raspberrypi-ts - fix refcount leak in rpi_ts_probe

Michael Kelley (2):
      x86/hyperv: Block root partition functionality in a Confidential VM
      nvme: handle the persistent internal error AER

Michael Walle (3):
      mtd: core: provide unique name for nvmem device, take two
      mtd: core: fix nvmem error reporting
      mtd: core: fix error path for nvmem provider

Michał Krawczyk (1):
      media: venus: dec: Fix handling of the start cmd

Mike Christie (2):
      scsi: target: Fix multiple LUN_RESET handling
      scsi: target: iscsit: Fix TAS handling during conn cleanup

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

Ming Yen Hsieh (1):
      wifi: mt76: fix 6GHz high channel not be scanned

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

Namjae Jeon (3):
      ksmbd: call rcu_barrier() in ksmbd_server_exit()
      ksmbd: fix NULL pointer dereference in smb2_get_info_filesystem()
      ksmbd: fix memleak in session setup

Natalia Petrova (1):
      RDMA/rdmavt: Delete unnecessary NULL check

Nathan Lynch (1):
      powerpc/rtas: use memmove for potentially overlapping buffer copy

Nicolai Stange (1):
      crypto: drbg - make drbg_prepare_hrng() handle jent instantiation errors

Nuno Sá (1):
      staging: iio: resolver: ads1210: fix config mode

Ondrej Mosnacek (2):
      tracing: Fix permissions for the buffer_percent file
      selinux: fix Makefile dependencies of flask.h

Pablo Neira Ayuso (1):
      netfilter: nf_tables: deactivate anonymous set from preparation phase

Patrick Kelsey (2):
      IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order
      IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec user SDMA requests

Patrik Dahlström (1):
      iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Paul Moore (1):
      selinux: ensure av_permissions.h is built when needed

Peng Liu (1):
      scripts/gdb: fix lx-timerlist for Python3

Peter Zijlstra (1):
      sched: Fix DEBUG && !SCHEDSTATS warn

Petr Mladek (1):
      workqueue: Fix hung time report of worker pools

Philipp Hortmann (1):
      staging: rtl8192e: Fix W_DISABLE# does not work after stop/start

Prashanth K (1):
      usb: dwc3: gadget: Change condition for processing suspend event

Qinrun Dai (1):
      clocksource/drivers/davinci: Fix memory leak in davinci_timer_register when init fails

Qiuxu Zhuo (1):
      EDAC/skx: Fix overflows on the DRAM row address mapping arrays

Qu Wenruo (1):
      btrfs: scrub: reject unsupported scrub flags

Quan Zhou (2):
      wifi: mt76: mt7921e: fix probe timeout after reboot
      wifi: mt76: mt7921e: improve reliability of dma reset

Quentin Monnet (1):
      bpftool: Fix bug for long instructions in program CFG dumps

Quentin Schulz (1):
      clk: rockchip: rk3399: allow clk_cifout to force clk_cifout_src to reparent

Rafał Miłecki (4):
      arm64: dts: broadcom: bcm4908: add DT for Netgear RAXE500
      arm64: dts: Add base DTS file for bcmbca device Asus GT-AX6000
      arm64: dts: broadcom: bcmbca: bcm4908: fix NAND interrupt name
      arm64: dts: broadcom: bcmbca: bcm4908: fix procmon nodename

Randy Dunlap (11):
      IMA: allow/fix UML builds
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

Reid Tonking (1):
      i2c: omap: Fix standard mode false ACK readings

Rob Clark (2):
      drm/rockchip: Drop unbalanced obj unref
      drm/msm/adreno: Defer enabling runpm until hw_init()

Roberto Sassu (1):
      reiserfs: Add security prefix to xattr name in reiserfs_security_write()

Roger Pau Monne (1):
      ACPI: processor: Fix evaluating _PDC method when running as Xen dom0

Russell King (Oracle) (1):
      net: pcs: xpcs: remove double-read of link state when using AN

Ryusuke Konishi (2):
      nilfs2: do not write dirty data after degenerating to read-only
      nilfs2: fix infinite loop in nilfs_mdt_get_block()

Sanjay Chandrashekara (1):
      cpufreq: use correct unit when verify cur freq

Saravanan Vajravel (1):
      RDMA/srpt: Add a check for valid 'mad_agent' pointer

Saurabh Sengar (1):
      x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

Schspa Shi (1):
      sched/rt: Fix bad task migration for rt tasks

Sean Christopherson (1):
      KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not intercepted

Sebastian Andrzej Siewior (1):
      tick/common: Align tick period with the HZ tick.

Sebastian Reichel (2):
      net: ethernet: stmmac: dwmac-rk: fix optional phy regulator handling
      power: supply: generic-adc-battery: fix unit scaling

Shaopeng Tan (1):
      selftests/resctrl: Extend CPU vendor detection

Shengjiu Wang (1):
      ASoC: soc-pcm: fix hw->formats cleared by soc_pcm_hw_init() for dpcm

Shenwei Wang (1):
      tty: serial: fsl_lpuart: adjust buffer length to the intended size

Shuchang Li (1):
      scsi: lpfc: Fix ioremap issues in lpfc_sli4_pci_mem_setup()

Shunsuke Mie (2):
      dmaengine: dw-edma: Fix to change for continuous transfer
      dmaengine: dw-edma: Fix to enable to issue dma request on DMA processing

Simon Horman (1):
      net: qrtr: correct types of trace event parameters

Song Liu (1):
      selftests/bpf: Fix leaked bpf_link in get_stackid_cannot_attach

Song Shuai (1):
      riscv: mm: remove redundant parameter of create_fdt_early_page_table

Stafford Horne (1):
      openrisc: Properly store r31 to pt_regs on unhandled exceptions

Stanislav Fomichev (1):
      bpf: Don't EFAULT for getsockopt with optval=NULL

Stefan Haberland (1):
      s390/dasd: fix hanging blockdevice after request requeue

Suman Anna (1):
      crypto: sa2ul - Select CRYPTO_DES

Sumit Garg (1):
      arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

Suzuki K Poulose (1):
      coresight: etm_pmu: Set the module field

Tang Bin (1):
      media: rcar_fdp1: Fix the correct variable assignments

Tanmay Shah (2):
      mailbox: zynqmp: Fix IPI isr handling
      mailbox: zynqmp: Fix typo in IPI documentation

Terry Bowman (1):
      tools/x86/kcpuid: Fix avx512bw and avx512lvl fields in Fn00000007

Tetsuo Handa (1):
      RDMA/siw: Remove namespace check from siw_netdev_event()

Thomas Gleixner (3):
      posix-cpu-timers: Implement the missing timer_wait_running callback
      debugobject: Prevent init race with static objects
      debugobject: Ensure pool refill (again)

Thomas Hellström (1):
      drm/ttm/pool: Fix ttm_pool_alloc error path

Toke Høiland-Jørgensen (1):
      crypto: api - Demote BUG_ON() in crypto_unregister_alg() to a WARN_ON()

Tom Rix (2):
      wifi: iwlwifi: mvm: initialize seq variable
      wifi: iwlwifi: fw: move memset before early return

Tomáš Pecka (1):
      hwmon: (pmbus/fsp-3y) Fix functionality bitmask in FSP-3Y YM-2151E

Tony Luck (1):
      x86/cpu: Add model number for Intel Arrow Lake processor

Trond Myklebust (1):
      NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease

Tudor Ambarus (2):
      dmaengine: at_xdmac: Fix concurrency over chan's completed_cookie
      dmaengine: at_xdmac: Fix race for the tx desc callback

Uros Bizjak (1):
      x86/apic: Fix atomic update of offset in reserve_eilvt_offset()

Uwe Kleine-König (4):
      platform: Provide a remove callback that returns no value
      media: rcar_fdp1: Convert to platform remove callback returning void
      spi: imx: Don't skip cleanup in remove's error path
      spi: qup: Don't skip cleanup in remove's error path

Vadim Fedorenko (1):
      vlan: partially enable SIOCSHWTSTAMP in container

Ville Syrjälä (1):
      drm/i915: Make intel_get_crtc_new_encoder() less oopsy

Vincent Guittot (1):
      arm64: dts: qcom: sdm845: correct dynamic power coefficients - again

Vinod Polimera (1):
      drm/msm/disp/dpu: check for crtc enable rather than crtc active to release shared resources

Vishal Verma (1):
      md: raid10 add nowait support

Vladimir Oltean (1):
      asm-generic/io.h: suppress endianness warnings for readq() and writeq()

Wang YanQing (1):
      ubi: Fix return value overwrite issue in try_write_vid_and_data()

Wei Chen (2):
      wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_rfreg()
      wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_reg()

William Zhang (3):
      arm64: dts: Add DTS files for bcmbca SoC BCM63158
      arm64: dts: Add DTS files for bcmbca SoC BCM4912
      arm64: dts: Move BCM4908 dts to bcmbca folder

Wolfram Sang (1):
      usb: host: xhci-rcar: remove leftover quirk handling

Xin Liu (1):
      bpf, sockmap: fix deadlocks in the sockhash and sockmap

YAN SHI (1):
      regulator: stm32-pwr: fix of_iomap leak

Yafang Shao (2):
      sched/fair: Use __schedstat_set() in set_next_entity()
      sched: Make struct sched_statistics independent of fair sched class

Yan Wang (1):
      net: stmmac:fix system hang when setting up tag_8021q VLAN for DSA ports

Yang Jihong (1):
      perf/core: Fix hardlockup failure caused by perf throttle

Yangtao Li (2):
      f2fs: handle dqget error in f2fs_transfer_project_quota()
      f2fs: compress: fix to call f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()

Ye Bin (1):
      ext4: fix use-after-free read in ext4_find_extent for bigalloc + inline

Yeongjin Gil (1):
      dm verity: fix error handling for check_at_most_once on FEC

YiFei Zhu (1):
      selftests/bpf: Wait for receive in cg_storage_multi test

Yinhao Hu (1):
      usb: chipidea: fix missing goto in `ci_hdrc_probe`

Yu Kuai (5):
      md/raid10: factor out code from wait_barrier() to stop_waiting_barrier()
      md/raid10: fix leak of 'r10bio->remaining' for recovery
      md/raid10: fix memleak for 'conf->bio_split'
      md/raid10: fix memleak of md thread
      md/raid10: don't call bio_start_io_acct twice for bio which experienced read error

Zeng Heng (1):
      fs/ntfs3: Fix slab-out-of-bounds read in hdr_delete_de()

Zhang Yuchen (1):
      ipmi: fix SSIF not responding under certain cond.

Zhang Zhengming (1):
      relayfs: fix out-of-bounds access in relay_file_read

ZhangPeng (1):
      fs/ntfs3: Fix OOB read in indx_insert_into_buffer

Zheng Wang (4):
      media: rkvdec: fix use after free bug in rkvdec_remove
      media: dm1105: Fix use after free bug in dm1105_remove due to race condition
      media: saa7134: fix use after free bug in saa7134_finidev due to race condition
      usb: gadget: udc: renesas_usb3: Fix use after free bug in renesas_usb3_remove due to race condition

Zheng Yejian (1):
      rcu: Avoid stack overflow due to __rcu_irq_enter_check_tick() being kprobe-ed

Zhihao Cheng (3):
      Revert "ubifs: dirty_cow_znode: Fix memleak in error handling path"
      ubifs: Fix memleak when insert_old_idx() failed
      ext4: fix i_disksize exceeding i_size problem in paritally written case

Ziyang Xuan (1):
      ipv4: Fix potential uninit variable access bug in __ip_make_skb()

Zqiang (1):
      rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check

