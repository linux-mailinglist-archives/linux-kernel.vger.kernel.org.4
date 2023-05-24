Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C275770FC95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjEXRVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjEXRVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16020194;
        Wed, 24 May 2023 10:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1F563E28;
        Wed, 24 May 2023 17:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45133C433EF;
        Wed, 24 May 2023 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684948843;
        bh=L35BxFH8hi/G+s56x9kHny6XtgCMBLCUWROn9+x+Hqk=;
        h=From:To:Cc:Subject:Date:From;
        b=tai7zM7OQP4WJKO5/dLLpCzczPHA8jHu2FxXU/QYwgJLOnwnsq/w/3S1OVtg30STY
         rp2zunI6GVTYpk0rexjsq1qVzt8a44wg3BY35umb9s5CE+wRSvhfMp/UUlalQgMl63
         pLPGVhBAa2e0jmX4Npbl8CzzPyfa4ugPUzjfulE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.3.4
Date:   Wed, 24 May 2023 18:20:25 +0100
Message-Id: <2023052425-carrot-cardinal-7ae0@gregkh>
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

I'm announcing the release of the 6.3.4 kernel.

All users of the 6.3 kernel series must upgrade.

The updated 6.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.3.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.rst                                 |    2 
 Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml              |    2 
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml |   12 
 Makefile                                                               |    2 
 arch/arm/include/asm/assembler.h                                       |   13 
 arch/arm/mach-sa1100/jornada720_ssp.c                                  |    5 
 arch/arm/vfp/entry.S                                                   |   16 
 arch/arm/vfp/vfphw.S                                                   |   16 
 arch/arm/vfp/vfpmodule.c                                               |   27 
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi                      |    1 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                                  |    3 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts                     |    2 
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts                      |   11 
 arch/arm64/include/asm/kvm_pgtable.h                                   |    1 
 arch/arm64/kernel/mte.c                                                |    7 
 arch/arm64/kvm/hyp/pgtable.c                                           |   32 
 arch/arm64/mm/copypage.c                                               |    5 
 arch/parisc/include/asm/pdc.h                                          |    1 
 arch/parisc/kernel/firmware.c                                          |   27 
 arch/powerpc/kernel/dma-iommu.c                                        |    4 
 arch/powerpc/kernel/iommu.c                                            |   11 
 arch/powerpc/kernel/legacy_serial.c                                    |    8 
 arch/powerpc/mm/book3s64/radix_pgtable.c                               |    4 
 arch/powerpc/net/bpf_jit_comp.c                                        |    2 
 arch/powerpc/platforms/44x/iss4xx.c                                    |    2 
 arch/powerpc/platforms/44x/ppc476.c                                    |    2 
 arch/powerpc/platforms/cell/spu_manage.c                               |    2 
 arch/powerpc/platforms/powermac/pic.c                                  |    3 
 arch/powerpc/platforms/powernv/opal-lpc.c                              |    2 
 arch/powerpc/platforms/pseries/hotplug-cpu.c                           |    2 
 arch/powerpc/platforms/pseries/iommu.c                                 |   13 
 arch/powerpc/platforms/pseries/vio.c                                   |    2 
 arch/powerpc/sysdev/mpic_msgr.c                                        |    2 
 arch/riscv/kernel/image-vars.h                                         |    2 
 arch/riscv/kernel/probes/Makefile                                      |    2 
 arch/s390/crypto/chacha-glue.c                                         |    2 
 arch/s390/kernel/Makefile                                              |    1 
 arch/x86/kernel/Makefile                                               |    1 
 block/bfq-iosched.c                                                    |    2 
 crypto/jitterentropy-kcapi.c                                           |   51 
 crypto/jitterentropy.c                                                 |  144 --
 crypto/jitterentropy.h                                                 |    1 
 drivers/accel/habanalabs/common/device.c                               |    9 
 drivers/accel/habanalabs/common/habanalabs.h                           |    1 
 drivers/accel/habanalabs/common/habanalabs_drv.c                       |    1 
 drivers/accel/habanalabs/common/memory_mgr.c                           |   13 
 drivers/accel/ivpu/ivpu_drv.c                                          |    4 
 drivers/acpi/acpi_apd.c                                                |    2 
 drivers/acpi/acpica/dbnames.c                                          |    3 
 drivers/acpi/acpica/dswstate.c                                         |   11 
 drivers/acpi/ec.c                                                      |    1 
 drivers/acpi/video_detect.c                                            |   35 
 drivers/base/regmap/regcache.c                                         |    6 
 drivers/block/nbd.c                                                    |    6 
 drivers/block/null_blk/main.c                                          |    5 
 drivers/bluetooth/btbcm.c                                              |   47 
 drivers/bluetooth/btintel.c                                            |    5 
 drivers/bluetooth/btrtl.c                                              |  138 +-
 drivers/bluetooth/btrtl.h                                              |    5 
 drivers/bluetooth/btusb.c                                              |    6 
 drivers/bluetooth/hci_h5.c                                             |    4 
 drivers/char/tpm/tpm_tis.c                                             |   16 
 drivers/clk/rockchip/clk-rk3588.c                                      |   42 
 drivers/clk/tegra/clk-tegra20.c                                        |   28 
 drivers/firmware/arm_sdei.c                                            |   37 
 drivers/firmware/smccc/smccc.c                                         |   26 
 drivers/firmware/smccc/soc_id.c                                        |   28 
 drivers/firmware/sysfb_simplefb.c                                      |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                                |   26 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                 |    8 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                 |   36 
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c                                 |   21 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                                  |   51 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                                 |    5 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c                                 |    2 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                                 |    2 
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c                                 |   55 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                   |   10 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                     |    7 
 drivers/gpu/drm/amd/display/dc/core/dc.c                               |   47 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                           |    3 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c                     |    5 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c                     |    3 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c                     |    2 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c                     |    2 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c          |   43 
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c         |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c         |  300 ++--
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c                 |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c       |  300 ++--
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c         |    2 
 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h         |    6 
 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h        |   11 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                              |   18 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c                        |   20 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                   |    1 
 drivers/gpu/drm/drm_displayid.c                                        |   17 
 drivers/gpu/drm/drm_fb_helper.c                                        |   16 
 drivers/gpu/drm/drm_mipi_dsi.c                                         |    2 
 drivers/gpu/drm/exynos/exynos_drm_g2d.h                                |    4 
 drivers/gpu/drm/i915/Kconfig                                           |   12 
 drivers/gpu/drm/i915/display/intel_atomic_plane.c                      |    4 
 drivers/gpu/drm/i915/display/intel_dp.c                                |    5 
 drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c                         |    7 
 drivers/gpu/drm/i915/i915_pci.c                                        |    6 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h                 |  202 +++
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h                 |  177 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c                         |  671 ++--------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h                         |   21 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c                      |   23 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c                            |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c                            |   18 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h                            |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c                              |    1 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h                               |    3 
 drivers/gpu/drm/msm/dp/dp_audio.c                                      |   12 
 drivers/gpu/drm/msm/dp/dp_audio.h                                      |    2 
 drivers/gpu/drm/msm/dp/dp_aux.c                                        |   80 -
 drivers/gpu/drm/msm/dp/dp_catalog.c                                    |    2 
 drivers/gpu/drm/msm/dp/dp_catalog.h                                    |    2 
 drivers/gpu/drm/msm/dp/dp_display.c                                    |    1 
 drivers/gpu/drm/msm/msm_gem_submit.c                                   |   25 
 drivers/gpu/drm/nouveau/include/nvif/if0012.h                          |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h                        |    3 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c                       |    2 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                            |    1 
 drivers/gpu/drm/scheduler/sched_main.c                                 |    2 
 drivers/gpu/drm/tegra/sor.c                                            |    2 
 drivers/hid/hid-apple.c                                                |   19 
 drivers/hid/hid-ids.h                                                  |    1 
 drivers/hid/hid-input.c                                                |    2 
 drivers/hid/hid-logitech-hidpp.c                                       |   53 
 drivers/hid/wacom_wac.c                                                |   33 
 drivers/hwmon/nzxt-smart2.c                                            |    3 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                                |   11 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c                         |   57 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c                           |   18 
 drivers/infiniband/core/user_mad.c                                     |   23 
 drivers/infiniband/hw/mlx5/mr.c                                        |    6 
 drivers/input/joystick/xpad.c                                          |    5 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                            |   19 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                             |   26 
 drivers/iommu/sprd-iommu.c                                             |   29 
 drivers/irqchip/Kconfig                                                |    1 
 drivers/irqchip/irq-gic-v3.c                                           |  115 +
 drivers/mcb/mcb-pci.c                                                  |   27 
 drivers/md/md.c                                                        |   18 
 drivers/media/pci/cx23885/cx23885-core.c                               |    4 
 drivers/media/pci/cx23885/cx23885-video.c                              |   13 
 drivers/media/pci/intel/ipu3/cio2-bridge.c                             |   15 
 drivers/media/pci/intel/ipu3/cio2-bridge.h                             |    3 
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c                     |    2 
 drivers/media/pci/tw68/tw68-video.c                                    |   16 
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c                |    7 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                         |    5 
 drivers/media/platform/renesas/vsp1/vsp1_drm.c                         |   18 
 drivers/media/platform/renesas/vsp1/vsp1_entity.c                      |   11 
 drivers/media/platform/samsung/exynos4-is/fimc-capture.c               |    7 
 drivers/media/platform/ti/am437x/am437x-vpfe.c                         |   15 
 drivers/media/platform/ti/cal/cal-video.c                              |    8 
 drivers/media/usb/dvb-usb/cxusb-analog.c                               |   14 
 drivers/media/usb/pvrusb2/Kconfig                                      |    3 
 drivers/memstick/host/r592.c                                           |    2 
 drivers/message/fusion/mptlan.c                                        |    2 
 drivers/mfd/dln2.c                                                     |    1 
 drivers/mfd/intel-lpss-pci.c                                           |   15 
 drivers/mfd/intel_soc_pmic_chtwc.c                                     |   14 
 drivers/misc/lkdtm/stackleak.c                                         |    6 
 drivers/net/bonding/bond_netlink.c                                     |    7 
 drivers/net/bonding/bond_options.c                                     |    8 
 drivers/net/can/dev/skb.c                                              |    3 
 drivers/net/can/kvaser_pciefd.c                                        |   51 
 drivers/net/dsa/mv88e6xxx/port.h                                       |    2 
 drivers/net/dsa/rzn1_a5psw.c                                           |   83 -
 drivers/net/dsa/rzn1_a5psw.h                                           |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                      |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                         |    9 
 drivers/net/ethernet/freescale/fec_main.c                              |   16 
 drivers/net/ethernet/google/gve/gve_main.c                             |   13 
 drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c       |   25 
 drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h       |    8 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c                     |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h                     |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                |   15 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c                  |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h                  |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c              |    5 
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                        |    5 
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c                           |    5 
 drivers/net/ethernet/intel/ice/ice_lib.c                               |    5 
 drivers/net/ethernet/intel/ice/ice_sriov.c                             |    8 
 drivers/net/ethernet/intel/ice/ice_txrx.c                              |    8 
 drivers/net/ethernet/intel/ice/ice_txrx.h                              |    9 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                            |   19 
 drivers/net/ethernet/intel/ice/ice_vf_lib.h                            |    1 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                          |    1 
 drivers/net/ethernet/intel/igb/e1000_mac.c                             |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c                    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c                    |    2 
 drivers/net/ethernet/mscc/vsc7514_regs.c                               |   18 
 drivers/net/ethernet/netronome/nfp/nic/main.h                          |    2 
 drivers/net/ethernet/pasemi/pasemi_mac.c                               |    2 
 drivers/net/ethernet/sfc/ef100_netdev.c                                |    4 
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h                           |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                      |    5 
 drivers/net/ethernet/sun/cassini.c                                     |    2 
 drivers/net/ipvlan/ipvlan_core.c                                       |    6 
 drivers/net/mdio/mdio-mvusb.c                                          |   11 
 drivers/net/pcs/pcs-xpcs.c                                             |    2 
 drivers/net/phy/bcm-phy-lib.h                                          |    5 
 drivers/net/phy/bcm7xxx.c                                              |    2 
 drivers/net/phy/dp83867.c                                              |   22 
 drivers/net/tap.c                                                      |    4 
 drivers/net/tun.c                                                      |   15 
 drivers/net/virtio_net.c                                               |   61 
 drivers/net/wireless/ath/ath.h                                         |   12 
 drivers/net/wireless/ath/ath11k/dp.c                                   |    4 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                |   17 
 drivers/net/wireless/ath/ath11k/peer.h                                 |    1 
 drivers/net/wireless/ath/ath12k/dp_rx.c                                |    3 
 drivers/net/wireless/ath/ath12k/pci.c                                  |   47 
 drivers/net/wireless/ath/ath12k/pci.h                                  |    6 
 drivers/net/wireless/ath/ath12k/qmi.c                                  |    4 
 drivers/net/wireless/ath/key.c                                         |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c              |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c            |   13 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c                |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c                |   51 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c                 |   11 
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h          |    2 
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c                           |    5 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                           |    2 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                            |   19 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                            |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                      |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c                           |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                          |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                            |   37 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                          |    4 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                        |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h                  |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c                   |    3 
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c                        |    3 
 drivers/net/wireless/realtek/rtw88/mac80211.c                          |    2 
 drivers/net/wireless/realtek/rtw88/main.c                              |   15 
 drivers/net/wireless/realtek/rtw88/main.h                              |    3 
 drivers/net/wireless/realtek/rtw88/usb.c                               |    3 
 drivers/net/wireless/realtek/rtw88/usb.h                               |    2 
 drivers/net/wwan/iosm/iosm_ipc_imem.c                                  |   27 
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.c                              |   12 
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.h                              |    6 
 drivers/parisc/power.c                                                 |   16 
 drivers/phy/st/phy-miphy28lp.c                                         |   42 
 drivers/pinctrl/pinctrl-at91.c                                         |   23 
 drivers/platform/x86/amd/pmc.c                                         |    1 
 drivers/platform/x86/intel/vsec.c                                      |   69 -
 drivers/platform/x86/intel/vsec.h                                      |    9 
 drivers/platform/x86/x86-android-tablets.c                             |  101 +
 drivers/power/supply/axp288_charger.c                                  |   15 
 drivers/remoteproc/imx_dsp_rproc.c                                     |  187 ++
 drivers/remoteproc/stm32_rproc.c                                       |    8 
 drivers/s390/block/dasd_eckd.c                                         |   33 
 drivers/s390/cio/device.c                                              |    2 
 drivers/s390/cio/qdio.h                                                |    2 
 drivers/scsi/hisi_sas/hisi_sas.h                                       |    3 
 drivers/scsi/hisi_sas/hisi_sas_main.c                                  |   25 
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c                                 |    2 
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                                 |    2 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                 |    4 
 drivers/scsi/lpfc/lpfc_debugfs.c                                       |    7 
 drivers/scsi/lpfc/lpfc_els.c                                           |   24 
 drivers/scsi/scsi_lib.c                                                |    3 
 drivers/scsi/storvsc_drv.c                                             |    8 
 drivers/soundwire/bus.c                                                |   15 
 drivers/soundwire/dmi-quirks.c                                         |   25 
 drivers/soundwire/qcom.c                                               |    3 
 drivers/spi/spi-imx.c                                                  |   24 
 drivers/spi/spi-intel-pci.c                                            |    1 
 drivers/staging/axis-fifo/axis-fifo.c                                  |   28 
 drivers/staging/media/imx/imx-media-capture.c                          |   12 
 drivers/staging/media/imx/imx-media-utils.c                            |    8 
 drivers/staging/media/omap4iss/iss_video.c                             |    6 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                           |    6 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h                           |    5 
 drivers/target/iscsi/iscsi_target.c                                    |    6 
 drivers/thunderbolt/nhi.c                                              |   29 
 drivers/thunderbolt/nhi_regs.h                                         |    2 
 drivers/tty/serial/8250/8250_bcm7271.c                                 |    7 
 drivers/tty/serial/8250/8250_core.c                                    |    1 
 drivers/tty/serial/8250/8250_exar.c                                    |   17 
 drivers/tty/serial/8250/8250_pci.c                                     |    5 
 drivers/tty/serial/arc_uart.c                                          |    7 
 drivers/tty/serial/qcom_geni_serial.c                                  |    9 
 drivers/tty/vt/vc_screen.c                                             |   11 
 drivers/ufs/core/ufshcd.c                                              |   10 
 drivers/ufs/host/ufshcd-pci.c                                          |    1 
 drivers/usb/class/usbtmc.c                                             |    2 
 drivers/usb/dwc3/debugfs.c                                             |  109 +
 drivers/usb/dwc3/gadget.c                                              |   67 
 drivers/usb/gadget/function/u_ether.c                                  |    3 
 drivers/usb/gadget/udc/core.c                                          |  151 --
 drivers/usb/host/uhci-pci.c                                            |   10 
 drivers/usb/host/xhci-mem.c                                            |    9 
 drivers/usb/host/xhci-pci.c                                            |   12 
 drivers/usb/host/xhci-ring.c                                           |   29 
 drivers/usb/host/xhci.h                                                |    2 
 drivers/usb/storage/scsiglue.c                                         |   28 
 drivers/usb/typec/altmodes/displayport.c                               |    4 
 drivers/usb/typec/tcpm/tcpm.c                                          |   16 
 drivers/usb/typec/ucsi/ucsi_acpi.c                                     |   44 
 drivers/video/fbdev/arcfb.c                                            |   15 
 fs/ceph/snap.c                                                         |   13 
 fs/cifs/cifsglob.h                                                     |    4 
 fs/cifs/connect.c                                                      |    8 
 fs/cifs/file.c                                                         |   26 
 fs/cifs/smb1ops.c                                                      |    9 
 fs/cifs/smb2ops.c                                                      |    7 
 fs/ext2/ext2.h                                                         |    1 
 fs/ext2/super.c                                                        |    7 
 fs/ext4/balloc.c                                                       |   18 
 fs/ext4/ext4.h                                                         |   15 
 fs/ext4/ialloc.c                                                       |   12 
 fs/ext4/mballoc.c                                                      |  131 +
 fs/ext4/mmp.c                                                          |    9 
 fs/ext4/super.c                                                        |   24 
 fs/f2fs/checkpoint.c                                                   |   22 
 fs/f2fs/data.c                                                         |    7 
 fs/f2fs/extent_cache.c                                                 |   22 
 fs/f2fs/f2fs.h                                                         |    5 
 fs/f2fs/gc.c                                                           |   10 
 fs/f2fs/gc.h                                                           |    2 
 fs/f2fs/segment.h                                                      |   39 
 fs/f2fs/super.c                                                        |    2 
 fs/gfs2/glops.c                                                        |    3 
 fs/hfsplus/inode.c                                                     |   28 
 fs/ksmbd/connection.c                                                  |    3 
 fs/ksmbd/oplock.c                                                      |    5 
 fs/ksmbd/oplock.h                                                      |    2 
 fs/ksmbd/smb2misc.c                                                    |    5 
 fs/ksmbd/smb2pdu.c                                                     |   19 
 fs/nilfs2/inode.c                                                      |   18 
 fs/ntfs3/frecord.c                                                     |    5 
 fs/ntfs3/fsntfs.c                                                      |    1 
 fs/ntfs3/index.c                                                       |   11 
 fs/ntfs3/inode.c                                                       |    6 
 fs/ntfs3/record.c                                                      |    9 
 fs/open.c                                                              |   18 
 fs/statfs.c                                                            |    4 
 include/drm/display/drm_dp.h                                           |    4 
 include/linux/arm-smccc.h                                              |   18 
 include/linux/cpuhotplug.h                                             |    1 
 include/linux/dim.h                                                    |    3 
 include/linux/if_vlan.h                                                |   17 
 include/linux/netdevice.h                                              |    1 
 include/linux/sched/task_stack.h                                       |    2 
 include/linux/sunrpc/svc_rdma.h                                        |    2 
 include/linux/sunrpc/svc_xprt.h                                        |    2 
 include/net/bluetooth/hci.h                                            |   15 
 include/net/bonding.h                                                  |    2 
 include/net/ip_vs.h                                                    |    6 
 include/net/pkt_sched.h                                                |    2 
 include/net/sock.h                                                     |    2 
 include/uapi/asm-generic/fcntl.h                                       |    1 
 kernel/bpf/bpf_local_storage.c                                         |   16 
 kernel/bpf/verifier.c                                                  |    4 
 kernel/events/core.c                                                   |   14 
 kernel/rcu/refscale.c                                                  |    2 
 kernel/rcu/tree_exp.h                                                  |    6 
 kernel/time/tick-broadcast.c                                           |  120 +
 kernel/trace/rethook.c                                                 |    4 
 lib/cpu_rmap.c                                                         |    5 
 lib/dim/dim.c                                                          |    5 
 lib/dim/net_dim.c                                                      |    3 
 lib/dim/rdma_dim.c                                                     |    3 
 lib/maple_tree.c                                                       |   12 
 mm/zswap.c                                                             |   16 
 net/8021q/vlan_dev.c                                                   |    4 
 net/bluetooth/hci_event.c                                              |    9 
 net/bluetooth/hci_sync.c                                               |    6 
 net/bluetooth/l2cap_core.c                                             |    1 
 net/bridge/br_forward.c                                                |    2 
 net/bridge/br_private_tunnel.h                                         |    8 
 net/can/isotp.c                                                        |    2 
 net/can/j1939/socket.c                                                 |    2 
 net/core/datagram.c                                                    |   15 
 net/core/dev.c                                                         |    4 
 net/core/skbuff.c                                                      |    4 
 net/core/stream.c                                                      |   12 
 net/devlink/core.c                                                     |   16 
 net/devlink/devl_internal.h                                            |    1 
 net/devlink/leftover.c                                                 |    5 
 net/ipv4/af_inet.c                                                     |    2 
 net/ipv4/tcp.c                                                         |   14 
 net/ipv4/tcp_bpf.c                                                     |    2 
 net/ipv4/tcp_input.c                                                   |    4 
 net/ipv4/tcp_ipv4.c                                                    |    5 
 net/ipv6/ip6_gre.c                                                     |   13 
 net/key/af_key.c                                                       |   12 
 net/llc/af_llc.c                                                       |    8 
 net/mac80211/cfg.c                                                     |    7 
 net/mac80211/trace.h                                                   |    2 
 net/mac80211/tx.c                                                      |    5 
 net/netfilter/core.c                                                   |    6 
 net/netfilter/ipvs/ip_vs_sync.c                                        |    2 
 net/netfilter/nf_conntrack_standalone.c                                |    3 
 net/netfilter/nf_tables_api.c                                          |    4 
 net/netfilter/nft_chain_filter.c                                       |    9 
 net/netfilter/nft_set_rbtree.c                                         |   20 
 net/netlink/af_netlink.c                                               |    8 
 net/nsh/nsh.c                                                          |    8 
 net/packet/af_packet.c                                                 |    6 
 net/sched/sch_mqprio.c                                                 |    5 
 net/sched/sch_taprio.c                                                 |   12 
 net/smc/smc_close.c                                                    |    4 
 net/smc/smc_rx.c                                                       |    4 
 net/smc/smc_tx.c                                                       |    4 
 net/socket.c                                                           |    2 
 net/sunrpc/svc.c                                                       |   19 
 net/sunrpc/svc_xprt.c                                                  |   24 
 net/sunrpc/svcsock.c                                                   |   30 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                                |   11 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                               |    2 
 net/tipc/bearer.c                                                      |   17 
 net/tipc/bearer.h                                                      |    3 
 net/tipc/link.c                                                        |    9 
 net/tipc/socket.c                                                      |    4 
 net/tipc/udp_media.c                                                   |    5 
 net/tls/tls_main.c                                                     |    3 
 net/unix/af_unix.c                                                     |   22 
 net/vmw_vsock/af_vsock.c                                               |    2 
 net/wireless/scan.c                                                    |    6 
 net/xfrm/xfrm_device.c                                                 |    2 
 net/xfrm/xfrm_interface_core.c                                         |   54 
 net/xfrm/xfrm_policy.c                                                 |    9 
 net/xfrm/xfrm_user.c                                                   |   15 
 samples/bpf/hbm.c                                                      |    1 
 scripts/recordmcount.c                                                 |    6 
 sound/firewire/digi00x/digi00x-stream.c                                |    4 
 sound/pci/hda/hda_generic.c                                            |    7 
 sound/pci/hda/hda_intel.c                                              |    3 
 sound/pci/hda/patch_hdmi.c                                             |    5 
 sound/pci/hda/patch_realtek.c                                          |   14 
 sound/soc/amd/Kconfig                                                  |    2 
 sound/soc/amd/ps/acp63.h                                               |    2 
 sound/soc/amd/ps/pci-ps.c                                              |    8 
 sound/soc/amd/yc/acp6x-mach.c                                          |   21 
 sound/soc/amd/yc/acp6x.h                                               |    3 
 sound/soc/amd/yc/pci-acp6x.c                                           |    8 
 sound/soc/fsl/fsl_micfil.c                                             |   14 
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c                             |    6 
 sound/soc/mediatek/mt8186/mt8186-afe-clk.h                             |    1 
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c                             |    4 
 sound/soc/mediatek/mt8186/mt8186-audsys-clk.c                          |   46 
 sound/soc/mediatek/mt8186/mt8186-audsys-clk.h                          |    1 
 sound/soc/sof/ipc3-topology.c                                          |    7 
 sound/soc/sof/topology.c                                               |    4 
 sound/usb/format.c                                                     |    1 
 tools/include/uapi/asm-generic/fcntl.h                                 |    1 
 tools/perf/builtin-script.c                                            |    7 
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c                |   31 
 tools/testing/selftests/cgroup/test_memcontrol.c                       |   15 
 tools/testing/selftests/kvm/lib/x86_64/processor.c                     |    1 
 tools/testing/selftests/net/fib_nexthops.sh                            |    2 
 tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh                 |   17 
 virt/kvm/kvm_main.c                                                    |   16 
 466 files changed, 5173 insertions(+), 2478 deletions(-)

Abdun Nihaal (1):
      fs/ntfs3: Fix NULL dereference in ni_write_inode

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Add support for Intel Lunar Lake

Ahmed Zaki (2):
      ice: Fix stats after PF reset
      iavf: send VLAN offloading caps once after VFR

Ai Chao (1):
      ALSA: hda/realtek: Add a quirk for HP EliteDesk 805

Alain Volmat (1):
      phy: st: miphy28lp: use _poll_timeout functions for waits

Alan Stern (1):
      USB: usbtmc: Fix direction for 0-length ioctl control messages

Aleksandr Loktionov (1):
      igb: fix bit_shift to be in [1..8] range

Aleksandr Mezin (1):
      hwmon: (nzxt-smart2) add another USB ID

Alex Deucher (2):
      drm/amdgpu/gmc11: implement get_vbios_fb_size()
      drm/amdgpu/gfx11: update gpu_clock_counter logic

Alex Henrie (2):
      HID: apple: Set the tilde quirk flag on the Geyser 4 and later
      HID: apple: Set the tilde quirk flag on the Geyser 3

Alexander Stein (1):
      regmap: cache: Return error in cache sync operations for REGCACHE_NONE

Alexandre Ghiti (1):
      riscv: Fix EFI stub usage of KASAN instrumented strcmp function

Alexis Lothoré (1):
      net: dsa: rzn1-a5psw: fix STP states handling

Alon Giladi (2):
      wifi: iwlwifi: fix OEM's name in the ppag approved list
      wifi: iwlwifi: mvm: fix OEM's name in the tas approved list

Andrea Mayer (2):
      selftests: seg6: disable DAD on IPv6 router cfg for srv6_end_dt4_l3vpn_test
      selftets: seg6: disable rp_filter by default in srv6_end_dt4_l3vpn_test

Andreas Gruenbacher (1):
      gfs2: Fix inode height consistency check

Andrew Davis (1):
      serial: 8250_exar: Add support for USR298x PCI Modems

Andy Shevchenko (2):
      xhci: mem: Carefully calculate size for memory allocations
      pinctrl: at91: use devm_kasprintf() to avoid potential leaks (part 2)

Ard Biesheuvel (2):
      ARM: 9294/2: vfp: Fix broken softirq handling with instrumentation enabled
      ARM: 9297/1: vfp: avoid unbalanced stack on 'success' return path

Armin Wolf (1):
      ACPI: EC: Fix oops when removing custom query handlers

Arnaud Pouliquen (1):
      remoteproc: stm32_rproc: Add mutex protection for workqueue

Arnd Bergmann (4):
      clk: tegra20: fix gcc-7 constant overflow warning
      media: pvrusb2: fix DVB_CORE dependency
      drm/exynos: fix g2d_open/close helper function definitions
      bridge: always declare tunnel functions

Avihai Horon (1):
      RDMA/mlx5: Remove pcie_relaxed_ordering_enabled() check for RO write

Ayush Gupta (2):
      drm/amd/display: populate subvp cmd info only for the top pipe
      drm/amd/display: fixed dcn30+ underflow issue

Badhri Jagan Sridharan (1):
      usb: typec: altmodes/displayport: fix pin_assignment_show

Baishan Jiang (1):
      ASoC: amd: yc: Add ThinkBook 14 G5+ ARP to quirks list for acp6x

Bas Nieuwenhuizen (1):
      drm/amdgpu/gfx10: Disable gfxoff before disabling powergating.

Bastien Nocera (2):
      HID: logitech-hidpp: Don't use the USB serial for USB devices
      HID: logitech-hidpp: Reconcile USB and Unifying serials

Benjamin Poirier (1):
      net: selftests: Fix optstring

Bharath SM (2):
      SMB3: Close all deferred handles of inode in case of handle lease break
      SMB3: drop reference to cfile before sending oplock break

Bingbu Cao (1):
      media: ipu3-cio2: support multiple sensors and VCMs with same HID

Cem Kaya (1):
      ASoC: amd: Add Dell G15 5525 to quirks list

Chaitanya Kulkarni (1):
      null_blk: Always check queue mode setting from configfs

Chao Yu (2):
      f2fs: fix to drop all dirty pages during umount() if cp_error is set
      f2fs: fix to check readonly condition correctly

Chethan T N (1):
      Bluetooth: btintel: Add LE States quirk support

Chih-Yen Chang (3):
      ksmbd: allocate one more byte for implied bcc[0]
      ksmbd: fix wrong UserName check in session_user
      ksmbd: fix global-out-of-bounds in smb2_find_context_vals

Christian Brauner (1):
      open: return EINVAL for O_DIRECTORY | O_CREAT

Christophe JAILLET (3):
      net: mdio: mvusb: Fix an error handling path in mvusb_mdio_probe()
      wifi: mac80211: Fix puncturing bitmap handling in __ieee80211_csa_finalize()
      cassini: Fix a memory leak in the error handling path of cas_init_one()

Chuck Lever (2):
      SUNRPC: Fix encoding of accepted but unsuccessful RPC replies
      SUNRPC: Fix trace_svc_register() call site

Chunyan Zhang (1):
      iommu/sprd: Release dma buffer to avoid memory leak

Clément Léger (2):
      net: dsa: rzn1-a5psw: enable management frames for CPU port
      net: dsa: rzn1-a5psw: disable learning for standalone ports

Colin Foster (1):
      net: mscc: ocelot: fix stat counter register values

Colin Ian King (1):
      block, bfq: Fix division by zero error on zero wsum

Dan Carpenter (1):
      ALSA: firewire-digi00x: prevent potential use after free

Daniel Gabay (1):
      wifi: iwlwifi: pcie: fix possible NULL pointer dereference

David E. Box (1):
      platform/x86/intel: vsec: Explicitly enable capabilities

Dawid Wesierski (1):
      ice: Fix ice VF reset during iavf initialization

Dmitry Baryshkov (4):
      drm/msm/dpu: populate SmartDMA features in hw catalog
      drm/msm/dpu: drop smart_dma_rev from dpu_caps
      drm/msm/dpu: move UBWC/memory configuration to separate struct
      drm/msm/dpu: split SM8550 catalog entry to the separate file

Dmitry Bogdanov (1):
      scsi: target: iscsit: Free cmds before session free

Domenico Cerasuolo (1):
      mm: fix zswap writeback race condition

Dong Chenchen (1):
      net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment()

Dongliang Mu (1):
      wifi: rtw88: fix memory leak in rtw_usb_probe()

Doug Berger (2):
      serial: 8250_bcm7271: balance clk_enable calls
      serial: 8250_bcm7271: fix leak in `brcmuart_probe`

Douglas Anderson (2):
      drm/msm/dp: Clean up handling of DP AUX interrupts
      ASoC: mediatek: mt8186: Fix use-after-free in driver remove path

Duoming Zhou (1):
      media: netup_unidvb: fix use-after-free at del_timer()

Edward Lo (3):
      fs/ntfs3: Enhance the attribute size check
      fs/ntfs3: Validate MFT flags before replaying logs
      fs/ntfs3: Add length check in indx_get_root

Eli Cohen (1):
      lib: cpu_rmap: Avoid use after free on rmap->obj array entries

Eric Dumazet (9):
      net: skb_partial_csum_set() fix against transport header magic value
      netlink: annotate accesses to nlk->cb_running
      net: annotate sk->sk_err write from do_recvmmsg()
      net: deal with most data-races in sk_wait_event()
      net: add vlan_get_protocol_and_depth() helper
      tcp: add annotations around sk->sk_shutdown accesses
      net: datagram: fix data-races in datagram_poll()
      tcp: fix possible sk_priority leak in tcp_v4_send_reset()
      vlan: fix a potential uninit-value in vlan_dev_hard_start_xmit()

Eugene Huang (1):
      soundwire: dmi-quirks: add remapping for Intel 'Rooks County' NUC M15

Evan Quan (1):
      drm/amd/pm: fix possible power mode mismatch between driver and PMFW

Feng Jiang (1):
      platform/x86/amd: pmc: Fix memory leak in amd_pmc_stb_debugfs_open_v2()

Feng Liu (1):
      virtio_net: Fix error unwinding of XDP initialization

Florian Fainelli (3):
      net: phy: bcm7xx: Correct read from expansion register
      net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()
      net: bcmgenet: Restore phy_stop() depending upon suspend/close

Florian Westphal (4):
      netfilter: nf_tables: always release netdev hooks from notifier
      netfilter: conntrack: fix possible bug_on with enable_hooks=1
      netfilter: nf_tables: fix nft_trans type confusion
      netfilter: nft_set_rbtree: fix null deref on element insertion

Francesco Dolcini (2):
      Revert "usb: gadget: udc: core: Prevent redundant calls to pullup"
      Revert "usb: gadget: udc: core: Invoke usb_gadget_connect only when started"

Frank Wang (1):
      usb: typec: tcpm: fix multiple times discover svids error

Fred Oh (1):
      ALSA: hda: LNL: add HD Audio PCI ID

Gabe Teeger (1):
      drm/amd/display: Enable HostVM based on rIOMMU active

Gaurav Batra (2):
      powerpc/iommu: DMA address offset is incorrectly calculated with 2MB TCEs
      powerpc/iommu: Incorrect DDW Table is referenced for SR-IOV device

George Kennedy (1):
      vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF

Greg Kroah-Hartman (1):
      Linux 6.3.4

Grygorii Strashko (1):
      net: phy: dp83867: add w/a for packet errors seen with short cables

Guilherme G. Piccoli (2):
      parisc: Replace regular spinlock with spin_trylock on panic path
      drm/amdgpu/gfx11: Adjust gfxoff before powergating on gfx11 as well

Gustav Johansson (1):
      ksmbd: smb2: Allow messages padded to 8byte boundary

Gustavo A. R. Silva (1):
      RDMA/core: Fix multiple -Warray-bounds warnings

Hangbin Liu (1):
      bonding: fix send_peer_notif overflow

Hans de Goede (7):
      platform/x86: x86-android-tablets: Add Acer Iconia One 7 B1-750 data
      ACPI: video: Remove desktops without backlight DMI quirks
      wifi: iwlwifi: dvm: Fix memcpy: detected field-spanning write backtrace
      Bluetooth: hci_bcm: Fall back to getting bdaddr from EFI if not set
      power: supply: axp288_charger: Use alt usb-id extcon on some x86 android tablets
      mfd: intel_soc_pmic_chtwc: Add Lenovo Yoga Book X90F to intel_cht_wc_models
      wifi: brcmfmac: Check for probe() id argument being NULL

Hao Zeng (2):
      samples/bpf: Fix fout leak in hbm's run_bpf_prog
      recordmcount: Fix memory leaks in the uwrite function

Hari Bathini (1):
      powerpc/bpf: populate extable entries only during the last pass

Harshitha Prem (1):
      wifi: ath11k: Ignore frags from uninitialized peer in dp.

Hector Martin (3):
      wifi: brcmfmac: pcie: Provide a buffer of random bytes to the device
      wifi: brcmfmac: cfg80211: Pass the PMK in binary instead of hex
      wifi: brcmfmac: pcie: Add IDs/properties for BCM4387

Heiko Carstens (2):
      s390/crypto: use vector instructions only if available for ChaCha20
      s390/qdio: fix do_sqbs() inline assembly constraint

Huayu Chen (1):
      nfp: fix NFP_NET_MAX_DSCP definition error

Hyunwoo Kim (1):
      wifi: iwlwifi: pcie: Fix integer overflow in iwl_write_to_user_buf

Ido Schimmel (1):
      devlink: Fix crash with CONFIG_NET_NS=n

Ilan Peer (1):
      wifi: cfg80211: Drop entries with invalid BSSIDs in RNR

Ilya Leoshkevich (1):
      statfs: enforce statfs[64] structure initialization

Iuliana Prodan (1):
      remoteproc: imx_dsp_rproc: Add custom memory copy implementation for i.MX DSP Cores

Ivan Orlov (2):
      selftests: cgroup: Add 'malloc' failures checks in test_memcontrol
      KVM: selftests: Add 'malloc' failure check in vcpu_save_state

Jack Xiao (1):
      drm/amd/amdgpu: introduce gc_*_mes_2.bin v2

Jaegeuk Kim (1):
      f2fs: relax sanity check if checkpoint is corrupted

Jan Kara (1):
      ext2: Check block size validity during mount

Jan Sokolowski (1):
      ice: Fix undersized tx_flags variable

Jani Nikula (3):
      drm/dsc: fix DP_DSC_MAX_BPP_DELTA_* macro values
      drm/i915: taint kernel when force probing unsupported devices
      drm/displayid: add displayid_get_header() and check bounds better

Jarkko Nikula (1):
      mfd: intel-lpss: Add Intel Meteor Lake PCH-S LPSS PCI IDs

Jason Gerecke (1):
      HID: wacom: generic: Set battery quirk only when we see battery data

Jeremy Soller (1):
      ALSA: hda/realtek: Add quirk for Clevo L140AU

Jerry Snitselaar (1):
      tpm/tpm_tis: Disable interrupts for more Lenovo devices

Jia-Ju Bai (1):
      fs/ntfs3: Fix a possible null-pointer dereference in ni_clear()

Jianhua Lu (1):
      dt-bindings: display/msm: dsi-controller-main: Document qcom, master-dsi and qcom, sync-dual-dsi

Jie Wang (2):
      net: hns3: fix output information incomplete for dumping tx queue info with debugfs
      net: hns3: fix reset delay time to avoid configuration timeout

Jijie Shao (2):
      net: hns3: fix sending pfc frames after reset issue
      net: hns3: fix reset timeout when enable full VF

Jimmy Assarsson (6):
      can: kvaser_pciefd: Set CAN_STATE_STOPPED in kvaser_pciefd_stop()
      can: kvaser_pciefd: Call request_irq() before enabling interrupts
      can: kvaser_pciefd: Empty SRB buffer in probe
      can: kvaser_pciefd: Clear listen-only bit if not explicitly requested
      can: kvaser_pciefd: Do not send EFLUSH command on TFD interrupt
      can: kvaser_pciefd: Disable interrupts in probe error path

Jiri Pirko (1):
      devlink: change per-devlink netdev notifier to static one

Johannes Berg (6):
      wifi: iwlwifi: mvm: fix ptk_pn memory leak
      wifi: iwlwifi: fix iwl_mvm_max_amsdu_size() for MLO
      wifi: mac80211: fix min center freq offset tracing
      wifi: iwlwifi: mvm: fix cancel_delayed_work_sync() deadlock
      wifi: iwlwifi: fw: fix DBGI dump
      wifi: iwlwifi: mvm: don't trust firmware n_channels

John Harrison (1):
      drm/i915/guc: Don't capture Gen8 regs on Xe devices

Josh Poimboeuf (2):
      sched: Fix KCSAN noinstr violation
      lkdtm/stackleak: Fix noinstr violation

Justin Tee (2):
      scsi: lpfc: Prevent lpfc_debugfs_lockstat_write() buffer overflow
      scsi: lpfc: Correct used_rpi count when devloss tmo fires with no recovery

Kai-Heng Feng (1):
      ALSA: hda/realtek: Fix mute and micmute LEDs for yet another HP laptop

Kang Chen (1):
      ACPI: processor: Check for null return of devm_kzalloc() in fch_misc_setup()

Karol Wachowski (1):
      accel/ivpu: Remove D3hot delay for Meteorlake

Ke Zhang (1):
      serial: arc_uart: fix of_iomap leak in `arc_serial_probe`

Kees Cook (3):
      drm/nouveau/disp: More DP_RECEIVER_CAP_SIZE array fixes
      media: imx-jpeg: Bounds check sizeimage access
      wifi: ath: Silence memcpy run-time false positive warning

Kemeng Shi (2):
      ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set
      ext4: set goal start correctly in ext4_mb_normalize_request

Keoseong Park (1):
      scsi: ufs: core: Fix I/O hang that occurs when BKOPS fails in W-LUN suspend

Kevin Groeneveld (1):
      spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3

Khadija Kamran (1):
      staging: axis-fifo: initialize timeouts in init only

Konrad Dybcio (5):
      arm64: dts: qcom: msm8996: Add missing DWC3 quirks
      arm64: dts: qcom: sdm845-polaris: Drop inexistent properties
      arm64: dts: qcom: sm6115-j606f: Add ramoops node
      drm/msm/dpu: Allow variable SSPP_BLK size
      drm/msm/dpu: Allow variable INTF_BLK size

Konrad Gräfe (1):
      usb: gadget: u_ether: Fix host MAC address case

Krzysztof Kozlowski (2):
      soundwire: qcom: gracefully handle too many ports in DT
      serial: qcom-geni: fix enabling deactivated interrupt

Kumar Kartikeya Dwivedi (1):
      bpf: Annotate data races in bpf_local_storage

Kuniyuki Iwashima (4):
      net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().
      af_unix: Fix a data race of sk->sk_receive_queue->qlen.
      af_unix: Fix data races around sk->sk_shutdown.
      tun: Fix memory leak for detached NAPI queue.

Larry Finger (1):
      wifi: rtw88: Fix memory leak in rtw88_usb

Laurent Pinchart (1):
      media: Prefer designated initializers over memset for subdev pad ops

Leon Romanovsky (2):
      xfrm: release all offloaded policy memory
      xfrm: Fix leak of dev tracker

Li Ma (1):
      drm/amdgpu: reserve the old gc_11_0_*_mes.bin

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: discard samples during filters settling time

Luke D. Jones (1):
      ALSA: hda/realtek: Add quirk for 2nd ASUS GU603

M Chetan Kumar (1):
      net: wwan: iosm: fix NULL pointer dereference when removing device

Manivannan Sadhasivam (1):
      iommu/arm-smmu-qcom: Limit the SMR groups to 128

Marco Migliore (1):
      net: dsa: mv88e6xxx: Fix mv88e6393x EPC write command offset

Marek Vasut (1):
      net: stmmac: Initialize MAC_ONEUS_TIC_COUNTER register

Marijn Suijten (5):
      drm/msm/dpu: Assign missing writeback log_mask
      drm/msm/dpu: Move non-MDP_TOP INTF_INTR offsets out of hwio header
      drm/msm/dpu: Reindent REV_7xxx interrupt masks with tabs
      drm/msm/dpu: Fix PP_BLK_DIPHER -> DITHER typo
      drm/msm/dpu: Remove duplicate register defines from INTF

Mario Limonciello (3):
      drm/amd: Fix an out of bounds error in BIOS parser
      xhci-pci: Only run d3cold avoidance quirk for s2idle
      thunderbolt: Clear registers properly when auto clear isn't in use

Martin Willi (1):
      Revert "Fix XFRM-I support for nested ESP tunnels"

Mathias Nyman (1):
      xhci: Fix incorrect tracking of free space on transfer rings

Mathieu Poirier (1):
      remoteproc: imx_dsp_rproc: Fix kernel test robot sparse warning

Max Chou (2):
      Bluetooth: btrtl: check for NULL in btrtl_set_quirks()
      Bluetooth: btrtl: Add the support for RTL8851B

Maxim Korotkov (1):
      bnxt: avoid overflow in bnxt_get_nvram_directory()

Maxime Bizon (1):
      usb-storage: fix deadlock when a scsi command timeouts more than once

Meng Tang (1):
      Bluetooth: btusb: Add new PID/VID 04ca:3801 for MT7663

Michael Ellerman (1):
      powerpc/64s/radix: Fix soft dirty tracking

Michael Kelley (1):
      scsi: storvsc: Don't pass unused PFNs to Hyper-V host

Michael Lee (1):
      wifi: mac80211: Abort running color change when stopping the AP

Michal Luczaj (1):
      KVM: Fix vcpu_array[0] races

Michal Simek (1):
      dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries

Mika Westerberg (1):
      spi: intel-pci: Add support for Meteor Lake-S SPI serial flash

Min Li (1):
      Bluetooth: L2CAP: fix "bad unlock balance" in l2cap_disconnect_rsp

Mirsad Goran Todorovac (1):
      wifi: mac80211: fortify the spinlock against deadlock by interrupt

Mukesh Sisodiya (1):
      wifi: iwlwifi: add a new PCI device ID for BZ device

Mukul Joshi (1):
      drm/amdgpu: Enable IH retry CAM on GFX9

Nagarajan Maran (1):
      wifi: ath11k: Fix SKB corruption in REO destination ring

Nathan Chancellor (1):
      net: pasemi: Fix return type of pasemi_mac_start_tx()

NeilBrown (2):
      SUNRPC: double free xprt_ctxt while still in use
      SUNRPC: always free ctxt when freeing deferred request

Nick Child (2):
      net: Catch invalid index in XPS mapping
      netdev: Enforce index cap in netdev_get_tx_queue

Nikhil Mahale (1):
      ALSA: hda: Add NVIDIA codec IDs a3 through a7 to patch table

Nikita Zhandarovich (1):
      drm/i915/dp: prevent potential div-by-zero

Nur Hussein (1):
      drm/tegra: Avoid potential 32-bit integer overflow

Ojaswin Mujoo (1):
      ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()

Oliver Hartkopp (3):
      can: dev: fix missing CAN XL support in can_put_echo_skb()
      can: j1939: recvmsg(): allow MSG_CMSG_COMPAT flag
      can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag

Oliver Upton (1):
      KVM: arm64: Infer the PA offset from IPA in stage-2 map walker

Paul E. McKenney (1):
      refscale: Move shutdown from wait_event() to wait_event_idle()

Paul Hsieh (2):
      drm/amd/display: Correct DML calculation to align HW formula
      drm/amd/display: Correct DML calculation to follow HW SPEC

Peng Zhang (1):
      maple_tree: make maple state reusable after mas_empty_area()

Peter Collingbourne (2):
      arm64: Also reset KASAN tag if page is not PG_mte_tagged
      arm64: mte: Do not set PG_mte_tagged if tags were not initialized

Peter Ujfalusi (1):
      ASoC: SOF: ipc3-topology: Make sure that only one cmd is sent in dai_config

Philipp Hortmann (1):
      staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE

Pierre Asselin (1):
      firmware/sysfb: Fix VESA format selection

Pierre Gondois (1):
      firmware: arm_sdei: Fix sleep from invalid context BUG

Pieter Jansen van Vuuren (1):
      sfc: disable RXFCS and RXALL features by default

Ping-Ke Shih (2):
      wifi: rtw88: use work to update rate to avoid RCU warning
      wifi: rtw88: correct qsel_to_ep[] type as int

Prajna Sariputra (1):
      ASoC: amd: yc: Add DMI entries to support HP OMEN 16-n0xxx (8A42)

Qiang Ning (1):
      mfd: dln2: Fix memory leak in dln2_probe()

Rajat Soni (1):
      wifi: ath12k: fix memory leak in ath12k_qmi_driver_event_work()

Ramya Gnanasekar (2):
      wifi: ath12k: Handle lock during peer_id find
      wifi: ath12k: PCI ops for wakeup/release MHI

Randy Dunlap (1):
      ARM: 9296/1: HP Jornada 7XX: fix kernel-doc warnings

Ranjani Sridharan (1):
      ASoC: SOF: topology: Fix logic for copying tuples

Raul Cheleguini (2):
      Bluetooth: Improve support for Actions Semi ATS2851 based devices
      Bluetooth: Add new quirk for broken set random RPA timeout for ATS2851

Reese Russell (1):
      wifi: mt76: mt7921: add Netgear AXE3000 (A8000) support

Richard Fitzgerald (1):
      soundwire: bus: Fix unbalanced pm_runtime_put() causing usage count underflow

Rob Clark (2):
      drm/msm: Fix submit error-path leaks
      iommu/arm-smmu-qcom: Fix missing adreno_smmu's

Rob Herring (1):
      powerpc: Use of_property_present() for testing DT property presence

Rodrigo Siqueira (1):
      drm/amd/display: Use DC_LOG_DC in the trasform pixel function

Rodríguez Barbarin, José Javier (1):
      mcb-pci: Reallocate memory region to avoid memory overlapping

Roger Quadros (1):
      usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()

Roy Novich (1):
      linux/dim: Do nothing if no time delta between samples

Ryan C. Underwood (1):
      ALSA: hda/realtek: Apply HP B&O top speaker profile to Pavilion 15

Ryder Lee (1):
      wifi: mt76: connac: fix stats->tx_bytes calculation

Ryusuke Konishi (1):
      nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()

Sabrina Dubroca (1):
      xfrm: don't check the default policy if the policy allows the packet

Samson Tam (2):
      drm/amd/display: enable DPG when disabling plane for phantom pipe
      drm/amd/display: reallocate DET for dual displays with high pixel rate ratio

Samuel Čavoj (1):
      usb: typec: ucsi: acpi: add quirk for ASUS Zenbook UM325

Sandipan Das (1):
      perf script: Skip aggregation for stat events

Saravana Kannan (1):
      drm/mipi-dsi: Set the fwnode for mipi_dsi_device

Sebastian Krzyszkowiak (1):
      arm64: dts: imx8mq-librem5: Remove dis_u3_susphy_quirk from usb_dwc3_0

Sebastian Reichel (1):
      clk: rockchip: rk3588: make gate linked clocks critical

Shanker Donthineni (1):
      irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4

Shengjiu Wang (1):
      ASoC: fsl_micfil: Fix error handler with pm_runtime_enable

Shenwei Wang (1):
      net: fec: remove the xdp_return_frame when lack of tx BDs

Simon Horman (1):
      ipvs: Update width of source for ip_vs_sync_conn_options

Srinivas Kandagatla (1):
      drm/msm/dp: unregister audio driver during unbind

Stanislav Lisovskiy (1):
      drm/i915: Fix NULL ptr deref by checking new_crtc_state

Stefan Haberland (1):
      s390/dasd: fix command reject error on ESE devices

Stephan Müller (1):
      crypto: jitter - permanent and intermittent health errors

Steve French (1):
      cifs: missing lock when updating session status

Sui Jingfeng (1):
      drm/fbdev-generic: prohibit potential out-of-bounds access

Syed Saba Kareem (1):
      ASoC: amd: Add check for acp config flags

Takashi Iwai (2):
      ALSA: usb-audio: Add a sample rate workaround for Line6 Pod Go
      ALSA: hda: Fix Oops by 9.1 surround channel names

Tamir Duberstein (1):
      ACPICA: Avoid undefined behavior: applying zero offset to null pointer

Tetsuo Handa (1):
      fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()

Theodore Ts'o (3):
      ext4: reflect error codes from ext4_multi_mount_protect() to its callers
      ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled
      ext4: allow ext4_get_group_info() to fail

Thomas Gleixner (1):
      tick/broadcast: Make broadcast device replacement work correctly

Tobias Brunner (2):
      xfrm: Reject optional tunnel/BEET mode templates in outbound policies
      af_key: Reject optional tunnel/BEET mode templates in outbound policies

Toby Chen (1):
      drm/rockchip: dw_hdmi: cleanup drm encoder during unbind

Tom Rix (1):
      media: pvrusb2: VIDEO_PVRUSB2 depends on DVB_CORE to use dvb_* symbols

Tomas Krcka (1):
      iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any

Tomer Tayar (1):
      accel/habanalabs: postpone mem_mgr IDR destruction to hpriv_release()

Tong Liu01 (1):
      drm/amdgpu: refine get gpu clock counter method

Tony Lindgren (1):
      serial: 8250: Reinit port->pm on port specific driver unbind

Udipto Goswami (1):
      usb: dwc3: debugfs: Resume dwc3 before accessing registers

Uwe Kleine-König (1):
      net: fec: Better handle pm_runtime_get() failing in .remove()

Vasily Khoruzhick (2):
      Bluetooth: Add new quirk for broken local ext features page 2
      Bluetooth: btrtl: add support for the RTL8723CS

Vicki Pfau (1):
      Input: xpad - add constants for GIP interface numbers

Vineeth Vijayan (1):
      s390/cio: include subchannels without devices also for evaluation

Vitaliy Tomin (1):
      serial: Add support for Advantech PCI-1611U card

Vitaly Prosyak (1):
      drm/sched: Check scheduler work queue before calling timeout handling

Vitaly Rodionov (1):
      ALSA: hda/realtek: Add quirk for HP EliteBook G10 laptops

Vladimir Oltean (2):
      net/sched: pass netlink extack to mqprio and taprio offload
      net: pcs: xpcs: fix C73 AN not getting enabled

Wei Chen (1):
      media: mediatek: vcodec: Fix potential array out-of-bounds in decoder queue_setup

Weitao Wang (1):
      USB: UHCI: adjust zhaoxin UHCI controllers OverCurrent bit value

Wenchao Hao (1):
      scsi: Revert "scsi: core: Do not increase scsi_device's iorequest_cnt if dispatch failed"

Wyes Karny (1):
      cpupower: Make TSC read per CPU for Mperf monitor

Xin Long (4):
      erspan: get the proto with the md version for collect_md
      tipc: add tipc_bearer_min_mtu to calculate min mtu
      tipc: do not update mtu if msg_max is too small in mtu negotiation
      tipc: check the bearer min mtu properly when setting it by netlink

Xingui Yang (1):
      scsi: hisi_sas: Grab sas_dev lock when traversing the members of sas_dev.list

Xiubo Li (1):
      ceph: force updating the msg pointer in non-split case

Yafang (1):
      bpf: Add preempt_count_{sub,add} into btf id deny list

Yang Jihong (1):
      perf/core: Fix perf_sample_data not properly initialized for different swevents in perf_tp_event()

Ye Bin (1):
      fs/ntfs3: Fix NULL pointer dereference in 'ni_write_inode'

Yonggil Song (1):
      f2fs: Fix system crash due to lack of free space in LFS

Yu Kuai (1):
      md: fix soft lockup in status_resync

Ze Gao (2):
      rethook: use preempt_{disable, enable}_notrace in rethook_trampoline_handler
      rethook, fprobe: do not trace rethook related functions

Zheng Wang (2):
      memstick: r592: Fix UAF bug in r592_remove due to race condition
      scsi: message: mptlan: Fix use after free bug in mptlan_remove() due to race condition

Zhong Jinghua (1):
      nbd: fix incomplete validation of ioctl arg

Zhuang Shengen (1):
      vsock: avoid to close connected socket after the timeout

Ziwei Xiao (1):
      gve: Remove the code of clearing PBA bit

Zongjie Li (1):
      fbdev: arcfb: Fix error handling in arcfb_probe()

Zqiang (1):
      rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access

harperchen (2):
      media: cx23885: Fix a null-ptr-deref bug in buffer_prepare() and buffer_finish()
      media: pci: tw68: Fix null-ptr-deref bug in buf prepare and finish

lyndonli (1):
      drm/amdgpu: Fix sdma v4 sw fini error

t.feng (1):
      ipvlan:Fix out-of-bounds caused by unclear skb->cb

void0red (1):
      ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects

weiliang1503 (1):
      HID: Ignore battery for ELAN touchscreen on ROG Flow X13 GV301RA

