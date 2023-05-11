Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B806D6FF4AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbjEKOjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbjEKOhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2FA10E70;
        Thu, 11 May 2023 07:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A582B64E41;
        Thu, 11 May 2023 14:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48234C433D2;
        Thu, 11 May 2023 14:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683815837;
        bh=9hUT5bOfVwCe31cUlkvLObCmyojhepe23jgRBzQ8aK4=;
        h=From:To:Cc:Subject:Date:From;
        b=wRLaR/rXVe4roNrEocjDOpTzLBAS++aOVUevJcsGD2aUzhbeg4qAdWJLgyQE+KPAy
         ZU1fMWIEqPsHwimRqzEHlwVed8v49nrw5ILQPWOrhkGebi2Hh3CDGWPaPGYtZn6UV0
         yxa/P44EYS2r6OZqdevp0LLm/yyCLVtoHTkOrE4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.28
Date:   Thu, 11 May 2023 23:36:51 +0900
Message-Id: <2023051151-slick-turbojet-115e@gregkh>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.28 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/block/inline-encryption.rst                                            |   12 
 Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml                     |    1 
 Makefile                                                                             |    4 
 arch/arm/boot/dts/omap3-gta04.dtsi                                                   |   16 
 arch/arm/boot/dts/qcom-apq8064.dtsi                                                  |    2 
 arch/arm/boot/dts/qcom-ipq4019.dtsi                                                  |    4 
 arch/arm/boot/dts/qcom-ipq8064.dtsi                                                  |   12 
 arch/arm/boot/dts/qcom-sdx55.dtsi                                                    |   78 
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi                                             |   30 
 arch/arm64/boot/dts/apple/t8103-j274.dts                                             |   10 
 arch/arm64/boot/dts/apple/t8103-j293.dts                                             |   15 
 arch/arm64/boot/dts/apple/t8103-j313.dts                                             |   15 
 arch/arm64/boot/dts/apple/t8103-j456.dts                                             |   10 
 arch/arm64/boot/dts/apple/t8103-j457.dts                                             |   11 
 arch/arm64/boot/dts/apple/t8103.dtsi                                                 |    4 
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts                       |   10 
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi                                     |    4 
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi                                     |    2 
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts                                          |    3 
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                                                |    6 
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                                                |   12 
 arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi                                    |    5 
 arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dts                           |   11 
 arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi                             |    3 
 arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi                           |    3 
 arch/arm64/boot/dts/qcom/msm8994.dtsi                                                |    5 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                                                |   12 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                                                |    4 
 arch/arm64/boot/dts/qcom/pmi8994.dtsi                                                |    2 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts                   |    2 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                                                 |    2 
 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                                                 |   13 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                                 |   14 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                                 |    6 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                                 |    8 
 arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts                           |    3 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                                 |   12 
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi                                            |    3 
 arch/arm64/boot/dts/renesas/r8a77990.dtsi                                            |    3 
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi                                           |  304 +-
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi                                          |   12 
 arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts                                   |    2 
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi                                           |   19 
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi                                           |   19 
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                                             |    4 
 arch/arm64/boot/dts/ti/k3-am625.dtsi                                                 |    2 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                              |    5 
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi                                                |    2 
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                                            |    1 
 arch/arm64/crypto/aes-neonbs-core.S                                                  |    9 
 arch/arm64/include/asm/debug-monitors.h                                              |    1 
 arch/arm64/include/asm/kvm_host.h                                                    |    4 
 arch/arm64/include/asm/scs.h                                                         |    7 
 arch/arm64/kernel/debug-monitors.c                                                   |    5 
 arch/arm64/kernel/entry.S                                                            |   16 
 arch/arm64/kernel/head.S                                                             |    2 
 arch/arm64/kernel/kgdb.c                                                             |    2 
 arch/arm64/kvm/arm.c                                                                 |   53 
 arch/arm64/kvm/guest.c                                                               |    2 
 arch/arm64/kvm/hypercalls.c                                                          |    4 
 arch/arm64/kvm/pmu-emul.c                                                            |   23 
 arch/arm64/kvm/psci.c                                                                |   28 
 arch/arm64/kvm/reset.c                                                               |   15 
 arch/arm64/kvm/vgic/vgic-debug.c                                                     |    8 
 arch/arm64/kvm/vgic/vgic-init.c                                                      |   36 
 arch/arm64/kvm/vgic/vgic-its.c                                                       |   33 
 arch/arm64/kvm/vgic/vgic-kvm-device.c                                                |   47 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                                   |    4 
 arch/arm64/kvm/vgic/vgic-mmio.c                                                      |   12 
 arch/arm64/kvm/vgic/vgic-v4.c                                                        |   11 
 arch/arm64/kvm/vgic/vgic.c                                                           |   12 
 arch/ia64/kernel/salinfo.c                                                           |    2 
 arch/ia64/mm/contig.c                                                                |    2 
 arch/ia64/mm/hugetlbpage.c                                                           |    2 
 arch/mips/fw/lib/cmdline.c                                                           |    2 
 arch/openrisc/kernel/entry.S                                                         |    6 
 arch/parisc/kernel/pacache.S                                                         |    2 
 arch/parisc/kernel/real2.S                                                           |    5 
 arch/powerpc/boot/Makefile                                                           |    2 
 arch/powerpc/include/asm/reg.h                                                       |    5 
 arch/powerpc/kernel/rtas.c                                                           |    2 
 arch/powerpc/perf/mpc7450-pmu.c                                                      |    6 
 arch/powerpc/platforms/512x/clock-commonclk.c                                        |    2 
 arch/powerpc/platforms/embedded6xx/flipper-pic.c                                     |    2 
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c                                        |    2 
 arch/powerpc/platforms/embedded6xx/wii.c                                             |    4 
 arch/powerpc/sysdev/tsi108_pci.c                                                     |    5 
 arch/riscv/include/asm/sbi.h                                                         |    2 
 arch/riscv/kernel/cpu_ops.c                                                          |    2 
 arch/riscv/kernel/sbi.c                                                              |   17 
 arch/riscv/kvm/main.c                                                                |    2 
 arch/riscv/kvm/mmu.c                                                                 |   25 
 arch/riscv/mm/init.c                                                                 |    6 
 arch/riscv/mm/ptdump.c                                                               |   24 
 arch/sh/kernel/cpu/sh4/sq.c                                                          |    2 
 arch/x86/include/asm/intel-family.h                                                  |    2 
 arch/x86/kernel/apic/apic.c                                                          |    5 
 arch/x86/kernel/apic/io_apic.c                                                       |   14 
 arch/x86/kernel/cpu/mce/amd.c                                                        |   14 
 arch/x86/kernel/cpu/mshyperv.c                                                       |   12 
 arch/x86/kvm/vmx/vmx.c                                                               |   15 
 block/blk-crypto-internal.h                                                          |   37 
 block/blk-crypto-profile.c                                                           |   47 
 block/blk-crypto.c                                                                   |   95 
 block/blk-iocost.c                                                                   |   10 
 block/blk-merge.c                                                                    |    2 
 block/blk-mq.c                                                                       |   17 
 block/blk-stat.c                                                                     |    4 
 crypto/algapi.c                                                                      |    4 
 crypto/drbg.c                                                                        |    2 
 drivers/acpi/bus.c                                                                   |    1 
 drivers/acpi/power.c                                                                 |   19 
 drivers/acpi/processor_pdc.c                                                         |   11 
 drivers/acpi/video_detect.c                                                          |   14 
 drivers/acpi/viot.c                                                                  |    5 
 drivers/base/cacheinfo.c                                                             |    5 
 drivers/base/cpu.c                                                                   |    3 
 drivers/block/drbd/drbd_receiver.c                                                   |    2 
 drivers/bluetooth/btsdio.c                                                           |    1 
 drivers/bus/mhi/host/boot.c                                                          |   16 
 drivers/bus/mhi/host/init.c                                                          |   12 
 drivers/bus/mhi/host/main.c                                                          |    2 
 drivers/char/ipmi/Kconfig                                                            |    3 
 drivers/char/ipmi/ipmi_ssif.c                                                        |    8 
 drivers/char/tpm/tpm-chip.c                                                          |    3 
 drivers/char/tpm/tpm_tis_core.c                                                      |  131 -
 drivers/char/tpm/tpm_tis_core.h                                                      |    2 
 drivers/clk/at91/clk-sam9x60-pll.c                                                   |    2 
 drivers/clk/clk-conf.c                                                               |   12 
 drivers/clk/imx/clk-fracn-gppll.c                                                    |   22 
 drivers/clk/imx/clk-imx8ulp.c                                                        |    4 
 drivers/clk/mediatek/clk-mt2701-aud.c                                                |   40 
 drivers/clk/mediatek/clk-mt2701-bdp.c                                                |   20 
 drivers/clk/mediatek/clk-mt2701-eth.c                                                |   10 
 drivers/clk/mediatek/clk-mt2701-g3d.c                                                |   10 
 drivers/clk/mediatek/clk-mt2701-hif.c                                                |   10 
 drivers/clk/mediatek/clk-mt2701-img.c                                                |   10 
 drivers/clk/mediatek/clk-mt2701-mm.c                                                 |   20 
 drivers/clk/mediatek/clk-mt2701-vdec.c                                               |   20 
 drivers/clk/mediatek/clk-mt2701.c                                                    |   40 
 drivers/clk/mediatek/clk-mt2712-bdp.c                                                |   10 
 drivers/clk/mediatek/clk-mt2712-img.c                                                |   10 
 drivers/clk/mediatek/clk-mt2712-jpgdec.c                                             |   10 
 drivers/clk/mediatek/clk-mt2712-mfg.c                                                |   10 
 drivers/clk/mediatek/clk-mt2712-mm.c                                                 |   34 
 drivers/clk/mediatek/clk-mt2712-vdec.c                                               |   20 
 drivers/clk/mediatek/clk-mt2712-venc.c                                               |   10 
 drivers/clk/mediatek/clk-mt2712.c                                                    |   78 
 drivers/clk/mediatek/clk-mt6765-audio.c                                              |   20 
 drivers/clk/mediatek/clk-mt6765-cam.c                                                |   10 
 drivers/clk/mediatek/clk-mt6765-img.c                                                |   10 
 drivers/clk/mediatek/clk-mt6765-mipi0a.c                                             |   10 
 drivers/clk/mediatek/clk-mt6765-mm.c                                                 |   10 
 drivers/clk/mediatek/clk-mt6765-vcodec.c                                             |   10 
 drivers/clk/mediatek/clk-mt6765.c                                                    |   80 
 drivers/clk/mediatek/clk-mt6797-img.c                                                |   10 
 drivers/clk/mediatek/clk-mt6797-mm.c                                                 |   20 
 drivers/clk/mediatek/clk-mt6797-vdec.c                                               |   20 
 drivers/clk/mediatek/clk-mt6797-venc.c                                               |   10 
 drivers/clk/mediatek/clk-mt6797.c                                                    |   42 
 drivers/clk/mediatek/clk-mt7622-aud.c                                                |   40 
 drivers/clk/mediatek/clk-mt7622-eth.c                                                |   20 
 drivers/clk/mediatek/clk-mt7622-hif.c                                                |   20 
 drivers/clk/mediatek/clk-mt7622.c                                                    |   90 
 drivers/clk/mediatek/clk-mt7629-eth.c                                                |   20 
 drivers/clk/mediatek/clk-mt7629-hif.c                                                |   20 
 drivers/clk/mediatek/clk-mt7629.c                                                    |   40 
 drivers/clk/mediatek/clk-mt7986-eth.c                                                |   24 
 drivers/clk/mediatek/clk-mt7986-infracfg.c                                           |   24 
 drivers/clk/mediatek/clk-mt8135.c                                                    |   44 
 drivers/clk/mediatek/clk-mt8167-aud.c                                                |   11 
 drivers/clk/mediatek/clk-mt8167-img.c                                                |   10 
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c                                             |   10 
 drivers/clk/mediatek/clk-mt8167-mm.c                                                 |   22 
 drivers/clk/mediatek/clk-mt8167-vdec.c                                               |   20 
 drivers/clk/mediatek/clk-mt8173-mm.c                                                 |   22 
 drivers/clk/mediatek/clk-mt8516-aud.c                                                |   10 
 drivers/clk/mediatek/clk-mt8516.c                                                    |   60 
 drivers/clk/microchip/clk-mpfs.c                                                     |    3 
 drivers/clk/qcom/dispcc-qcm2290.c                                                    |    9 
 drivers/clk/qcom/gcc-qcm2290.c                                                       |    3 
 drivers/clk/qcom/gcc-sm6115.c                                                        |   50 
 drivers/clk/qcom/gcc-sm8350.c                                                        |   47 
 drivers/clk/qcom/lpassaudiocc-sc7280.c                                               |    2 
 drivers/clk/qcom/lpasscc-sc7280.c                                                    |   16 
 drivers/clk/rockchip/clk-rk3399.c                                                    |    2 
 drivers/clocksource/timer-davinci.c                                                  |   30 
 drivers/cpufreq/cpufreq.c                                                            |    2 
 drivers/cpufreq/mediatek-cpufreq.c                                                   |   98 
 drivers/cpufreq/qcom-cpufreq-hw.c                                                    |   14 
 drivers/cpuidle/cpuidle-riscv-sbi.c                                                  |    2 
 drivers/crypto/Kconfig                                                               |    1 
 drivers/crypto/caam/ctrl.c                                                           |    6 
 drivers/crypto/ccp/sp-pci.c                                                          |    2 
 drivers/crypto/inside-secure/safexcel.c                                              |   37 
 drivers/crypto/qat/qat_common/adf_accel_devices.h                                    |    1 
 drivers/crypto/qat/qat_common/adf_common_drv.h                                       |    3 
 drivers/crypto/qat/qat_common/adf_dev_mgr.c                                          |    2 
 drivers/crypto/qat/qat_common/adf_init.c                                             |   64 
 drivers/crypto/qat/qat_common/adf_sysfs.c                                            |   23 
 drivers/cxl/core/hdm.c                                                               |   15 
 drivers/dma/at_xdmac.c                                                               |    5 
 drivers/dma/dw-edma/dw-edma-core.c                                                   |   27 
 drivers/dma/mv_xor_v2.c                                                              |    2 
 drivers/dma/qcom/gpi.c                                                               |    1 
 drivers/edac/skx_base.c                                                              |    4 
 drivers/firmware/arm_scmi/driver.c                                                   |    2 
 drivers/firmware/qcom_scm.c                                                          |    3 
 drivers/firmware/stratix10-svc.c                                                     |    4 
 drivers/fpga/fpga-bridge.c                                                           |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                           |   21 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                                    |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c                                |    3 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h                  |    4 
 drivers/gpu/drm/amd/display/dc/dce60/Makefile                                        |    2 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c                                |   16 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h                                |    3 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c                                |    2 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c                              |   77 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h                              |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c                                 |    2 
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c                            |   35 
 drivers/gpu/drm/amd/display/modules/power/power_helpers.h                            |    3 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                            |   40 
 drivers/gpu/drm/bridge/adv7511/adv7533.c                                             |   25 
 drivers/gpu/drm/drm_probe_helper.c                                                   |    5 
 drivers/gpu/drm/i915/display/intel_display.c                                         |    2 
 drivers/gpu/drm/lima/lima_drv.c                                                      |    6 
 drivers/gpu/drm/mediatek/mtk_dp.c                                                    |   15 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                                |    8 
 drivers/gpu/drm/msm/adreno/adreno_device.c                                           |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                                          |    2 
 drivers/gpu/drm/panel/panel-novatek-nt35950.c                                        |   10 
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c                                            |    4 
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                                          |    3 
 drivers/gpu/drm/ttm/ttm_pool.c                                                       |  161 +
 drivers/gpu/drm/vgem/vgem_fence.c                                                    |    1 
 drivers/gpu/host1x/context.c                                                         |   24 
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                                               |    9 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c                                        |    2 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c                                        |   11 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c                                   |   10 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h                                   |    8 
 drivers/hte/hte-tegra194-test.c                                                      |    1 
 drivers/hte/hte-tegra194.c                                                           |    2 
 drivers/hwmon/adt7475.c                                                              |    6 
 drivers/hwmon/k10temp.c                                                              |    4 
 drivers/hwmon/pmbus/fsp-3y.c                                                         |    1 
 drivers/hwtracing/coresight/coresight-etm-perf.c                                     |    1 
 drivers/i2c/busses/i2c-cadence.c                                                     |    6 
 drivers/i2c/busses/i2c-omap.c                                                        |    2 
 drivers/i2c/busses/i2c-xiic.c                                                        |    4 
 drivers/iio/adc/palmas_gpadc.c                                                       |    2 
 drivers/iio/addac/stx104.c                                                           |   12 
 drivers/iio/light/max44009.c                                                         |   13 
 drivers/infiniband/core/cm.c                                                         |    3 
 drivers/infiniband/hw/erdma/erdma_hw.h                                               |    4 
 drivers/infiniband/hw/erdma/erdma_verbs.c                                            |   17 
 drivers/infiniband/hw/hfi1/ipoib_tx.c                                                |    6 
 drivers/infiniband/hw/hfi1/mmu_rb.c                                                  |   73 
 drivers/infiniband/hw/hfi1/mmu_rb.h                                                  |    8 
 drivers/infiniband/hw/hfi1/sdma.c                                                    |   21 
 drivers/infiniband/hw/hfi1/sdma.h                                                    |   16 
 drivers/infiniband/hw/hfi1/sdma_txreq.h                                              |    1 
 drivers/infiniband/hw/hfi1/trace_mmu.h                                               |    4 
 drivers/infiniband/hw/hfi1/user_sdma.c                                               |  600 +++--
 drivers/infiniband/hw/hfi1/user_sdma.h                                               |    5 
 drivers/infiniband/hw/hfi1/verbs.c                                                   |    4 
 drivers/infiniband/hw/hfi1/vnic_sdma.c                                               |    1 
 drivers/infiniband/hw/mlx4/qp.c                                                      |    8 
 drivers/infiniband/hw/mlx5/devx.c                                                    |   31 
 drivers/infiniband/hw/mlx5/qp.c                                                      |    2 
 drivers/infiniband/hw/mlx5/umr.c                                                     |    6 
 drivers/infiniband/sw/rdmavt/qp.c                                                    |    2 
 drivers/infiniband/sw/siw/siw_main.c                                                 |    3 
 drivers/infiniband/sw/siw/siw_qp_tx.c                                                |    2 
 drivers/infiniband/ulp/isert/ib_isert.c                                              |    4 
 drivers/infiniband/ulp/srpt/ib_srpt.c                                                |   23 
 drivers/input/touchscreen/raspberrypi-ts.c                                           |    3 
 drivers/interconnect/qcom/icc-rpm.c                                                  |    7 
 drivers/interconnect/qcom/icc-rpm.h                                                  |    1 
 drivers/interconnect/qcom/msm8996.c                                                  |    1 
 drivers/iommu/amd/amd_iommu_types.h                                                  |    4 
 drivers/iommu/amd/iommu.c                                                            |    6 
 drivers/iommu/iommu.c                                                                |    9 
 drivers/iommu/mtk_iommu.c                                                            |    8 
 drivers/leds/Kconfig                                                                 |    2 
 drivers/leds/leds-tca6507.c                                                          |    5 
 drivers/macintosh/Kconfig                                                            |    1 
 drivers/macintosh/windfarm_smu_sat.c                                                 |    1 
 drivers/mailbox/mailbox-mpfs.c                                                       |   12 
 drivers/mailbox/zynqmp-ipi-mailbox.c                                                 |    6 
 drivers/md/dm-clone-target.c                                                         |    1 
 drivers/md/dm-flakey.c                                                               |    4 
 drivers/md/dm-integrity.c                                                            |    8 
 drivers/md/dm-ioctl.c                                                                |   12 
 drivers/md/dm-table.c                                                                |   19 
 drivers/md/dm-verity-target.c                                                        |    2 
 drivers/md/raid10.c                                                                  |   96 
 drivers/md/raid5.c                                                                   |   45 
 drivers/media/i2c/hi846.c                                                            |   11 
 drivers/media/i2c/max9286.c                                                          |    1 
 drivers/media/i2c/ov8856.c                                                           |   40 
 drivers/media/pci/dm1105/dm1105.c                                                    |    1 
 drivers/media/pci/saa7134/saa7134-ts.c                                               |    1 
 drivers/media/pci/saa7134/saa7134-vbi.c                                              |    1 
 drivers/media/pci/saa7134/saa7134-video.c                                            |    1 
 drivers/media/platform/amphion/vdec.c                                                |   32 
 drivers/media/platform/amphion/vpu_codec.h                                           |    3 
 drivers/media/platform/amphion/vpu_malone.c                                          |    4 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c                                  |    8 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c                                 |   10 
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c                              |   24 
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c                          |    3 
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c                           |    8 
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c                     |   12 
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c                    |   14 
 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c                 |    2 
 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c                    |    2 
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c                              |   95 
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h                              |   12 
 drivers/media/platform/qcom/venus/vdec.c                                             |   16 
 drivers/media/platform/renesas/rcar_fdp1.c                                           |   11 
 drivers/media/platform/st/sti/bdisp/bdisp-v4l2.c                                     |    2 
 drivers/media/rc/gpio-ir-recv.c                                                      |    2 
 drivers/media/v4l2-core/v4l2-async.c                                                 |   13 
 drivers/mfd/arizona-spi.c                                                            |    1 
 drivers/mfd/ocelot-spi.c                                                             |    1 
 drivers/mfd/tqmx86.c                                                                 |   52 
 drivers/misc/vmw_vmci/vmci_host.c                                                    |    8 
 drivers/mmc/host/sdhci-of-esdhc.c                                                    |   24 
 drivers/mtd/mtdcore.c                                                                |   23 
 drivers/mtd/spi-nor/core.c                                                           |    4 
 drivers/mtd/ubi/eba.c                                                                |   19 
 drivers/net/dsa/qca/qca8k-8xxx.c                                                     |    1 
 drivers/net/ethernet/amd/nmclan_cs.c                                                 |    2 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                                       |    3 
 drivers/net/ethernet/intel/i40e/i40e.h                                               |    6 
 drivers/net/ethernet/intel/i40e/i40e_adminq.c                                        |   68 
 drivers/net/ethernet/intel/i40e/i40e_alloc.h                                         |   22 
 drivers/net/ethernet/intel/i40e/i40e_client.c                                        |   12 
 drivers/net/ethernet/intel/i40e/i40e_common.c                                        | 1034 ++++------
 drivers/net/ethernet/intel/i40e/i40e_dcb.c                                           |   60 
 drivers/net/ethernet/intel/i40e/i40e_dcb.h                                           |   28 
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c                                        |   16 
 drivers/net/ethernet/intel/i40e/i40e_ddp.c                                           |   14 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                                       |    8 
 drivers/net/ethernet/intel/i40e/i40e_diag.c                                          |   12 
 drivers/net/ethernet/intel/i40e/i40e_diag.h                                          |    4 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                                       |   65 
 drivers/net/ethernet/intel/i40e/i40e_hmc.c                                           |   56 
 drivers/net/ethernet/intel/i40e/i40e_hmc.h                                           |   46 
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c                                       |   94 
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h                                       |   34 
 drivers/net/ethernet/intel/i40e/i40e_main.c                                          |  404 +--
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                                           |  252 +-
 drivers/net/ethernet/intel/i40e/i40e_osdep.h                                         |    1 
 drivers/net/ethernet/intel/i40e/i40e_prototype.h                                     |  677 +++---
 drivers/net/ethernet/intel/i40e/i40e_status.h                                        |   35 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                                   |   94 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                                     |   23 
 drivers/net/ethernet/mellanox/mlx5/core/dev.c                                        |    4 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c                                    |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c                             |   11 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.h                             |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c                               |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c                                      |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                                    |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c                               |   12 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c                           |    4 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c                                   |    8 
 drivers/net/ethernet/mellanox/mlx5/core/health.c                                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                                       |   16 
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h                                  |    6 
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c                              |    2 
 drivers/net/ethernet/sfc/ef100_tx.c                                                  |    3 
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c                                       |  197 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                                    |   12 
 drivers/net/ethernet/sun/sunhme.c                                                    |    2 
 drivers/net/pcs/pcs-xpcs.c                                                           |   13 
 drivers/net/phy/sfp.c                                                                |    4 
 drivers/net/wireguard/timers.c                                                       |    8 
 drivers/net/wireless/ath/ath11k/ahb.c                                                |   14 
 drivers/net/wireless/ath/ath11k/dbring.c                                             |   12 
 drivers/net/wireless/ath/ath11k/mac.h                                                |    2 
 drivers/net/wireless/ath/ath11k/mhi.c                                                |    2 
 drivers/net/wireless/ath/ath11k/peer.c                                               |    5 
 drivers/net/wireless/ath/ath5k/ahb.c                                                 |   10 
 drivers/net/wireless/ath/ath5k/eeprom.c                                              |    2 
 drivers/net/wireless/ath/ath6kl/bmi.c                                                |    2 
 drivers/net/wireless/ath/ath6kl/htc_pipe.c                                           |    4 
 drivers/net/wireless/ath/ath9k/hif_usb.c                                             |   19 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c                          |   14 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                                          |    8 
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c                                      |    4 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c                                     |    6 
 drivers/net/wireless/intel/iwlwifi/iwl-debug.c                                       |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                                          |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c                                     |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c                                          |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                                        |    5 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                                        |    1 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                                      |   12 
 drivers/net/wireless/mediatek/mt76/dma.c                                             |    2 
 drivers/net/wireless/mediatek/mt76/mt76.h                                            |    9 
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                                      |    5 
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                                      |   13 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c                                 |    3 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                                 |   13 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                                     |    5 
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c                                      |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c                                      |   40 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                                      |   20 
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c                                      |    9 
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c                                      |    2 
 drivers/net/wireless/mediatek/mt76/tx.c                                              |    4 
 drivers/net/wireless/mediatek/mt76/util.c                                            |   10 
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c                                       |    1 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c                               |    1 
 drivers/net/wireless/realtek/rtlwifi/debug.c                                         |   12 
 drivers/net/wireless/realtek/rtw88/mac.c                                             |    8 
 drivers/net/wireless/realtek/rtw89/core.c                                            |   10 
 drivers/net/wireless/realtek/rtw89/pci.c                                             |   19 
 drivers/net/wwan/t7xx/Makefile                                                       |    2 
 drivers/nvme/host/core.c                                                             |    5 
 drivers/nvme/host/trace.h                                                            |   15 
 drivers/nvme/target/admin-cmd.c                                                      |   45 
 drivers/nvme/target/fcloop.c                                                         |   48 
 drivers/nvme/target/nvmet.h                                                          |    2 
 drivers/nvme/target/zns.c                                                            |   18 
 drivers/of/device.c                                                                  |    7 
 drivers/pci/controller/dwc/Kconfig                                                   |    1 
 drivers/pci/controller/dwc/pci-imx6.c                                                |    7 
 drivers/pci/controller/dwc/pcie-qcom.c                                               |    8 
 drivers/pci/hotplug/pciehp_pci.c                                                     |   15 
 drivers/pci/pcie/edr.c                                                               |    1 
 drivers/pci/quirks.c                                                                 |   13 
 drivers/perf/arm-cmn.c                                                               |   59 
 drivers/perf/riscv_pmu_sbi.c                                                         |    2 
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c                                             |    2 
 drivers/phy/tegra/xusb.c                                                             |    2 
 drivers/phy/ti/phy-j721e-wiz.c                                                       |   11 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                                                |   19 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                                             |   14 
 drivers/pinctrl/ralink/pinctrl-mt7620.c                                              |    1 
 drivers/pinctrl/ralink/pinctrl-mt7621.c                                              |    1 
 drivers/pinctrl/ralink/pinctrl-rt2880.c                                              |    1 
 drivers/pinctrl/ralink/pinctrl-rt305x.c                                              |    1 
 drivers/pinctrl/ralink/pinctrl-rt3883.c                                              |    1 
 drivers/pinctrl/renesas/pfc-r8a779a0.c                                               |    8 
 drivers/pinctrl/renesas/pfc-r8a779f0.c                                               |    2 
 drivers/pinctrl/renesas/pfc-r8a779g0.c                                               |  990 ++++-----
 drivers/platform/chrome/cros_typec_switch.c                                          |    1 
 drivers/platform/x86/amd/Kconfig                                                     |    2 
 drivers/platform/x86/amd/pmc.c                                                       |  157 -
 drivers/platform/x86/amd/pmf/Kconfig                                                 |    1 
 drivers/platform/x86/amd/pmf/core.c                                                  |   22 
 drivers/platform/x86/thinkpad_acpi.c                                                 |    8 
 drivers/power/supply/generic-adc-battery.c                                           |    3 
 drivers/power/supply/rk817_charger.c                                                 |   33 
 drivers/pwm/pwm-meson.c                                                              |    6 
 drivers/pwm/pwm-mtk-disp.c                                                           |   34 
 drivers/regulator/core.c                                                             |  100 
 drivers/regulator/stm32-pwr.c                                                        |    7 
 drivers/rpmsg/qcom_glink_native.c                                                    |   10 
 drivers/rtc/rtc-meson-vrtc.c                                                         |    4 
 drivers/rtc/rtc-omap.c                                                               |    1 
 drivers/rtc/rtc-ti-k3.c                                                              |    3 
 drivers/s390/block/dasd.c                                                            |    2 
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c                                               |    6 
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                                               |    6 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                               |    6 
 drivers/scsi/libsas/sas_ata.c                                                        |   18 
 drivers/scsi/lpfc/lpfc_init.c                                                        |   10 
 drivers/scsi/megaraid.c                                                              |    1 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                                      |    2 
 drivers/soc/bcm/brcmstb/biuctrl.c                                                    |    4 
 drivers/soc/renesas/renesas-soc.c                                                    |    5 
 drivers/soc/ti/pm33xx.c                                                              |    5 
 drivers/soundwire/cadence_master.c                                                   |   30 
 drivers/soundwire/cadence_master.h                                                   |    6 
 drivers/soundwire/intel.c                                                            |   99 
 drivers/soundwire/qcom.c                                                             |    2 
 drivers/spi/atmel-quadspi.c                                                          |   30 
 drivers/spi/spi-cadence-quadspi.c                                                    |   32 
 drivers/spi/spi-fsl-spi.c                                                            |   12 
 drivers/spi/spi-imx.c                                                                |   12 
 drivers/spi/spi-qup.c                                                                |   22 
 drivers/spmi/spmi.c                                                                  |    3 
 drivers/staging/iio/resolver/ad2s1210.c                                              |    2 
 drivers/staging/media/deprecated/saa7146/av7110/av7110_av.c                          |    4 
 drivers/staging/media/rkvdec/rkvdec.c                                                |    2 
 drivers/staging/media/sunxi/cedrus/cedrus.c                                          |    1 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                                         |    1 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                                            |    8 
 drivers/target/iscsi/iscsi_target.c                                                  |   36 
 drivers/target/iscsi/iscsi_target_login.c                                            |    7 
 drivers/target/target_core_device.c                                                  |    1 
 drivers/target/target_core_internal.h                                                |    1 
 drivers/target/target_core_tmr.c                                                     |   26 
 drivers/target/target_core_tpg.c                                                     |    2 
 drivers/target/target_core_transport.c                                               |  199 +
 drivers/target/target_core_xcopy.c                                                   |  120 -
 drivers/target/target_core_xcopy.h                                                   |    2 
 drivers/thermal/mtk_thermal.c                                                        |   14 
 drivers/thunderbolt/tb.h                                                             |    2 
 drivers/tty/serial/8250/8250.h                                                       |   12 
 drivers/tty/serial/8250/8250_bcm7271.c                                               |   18 
 drivers/tty/serial/8250/8250_port.c                                                  |   11 
 drivers/tty/serial/fsl_lpuart.c                                                      |    2 
 drivers/tty/serial/max310x.c                                                         |   17 
 drivers/tty/serial/serial_core.c                                                     |    4 
 drivers/tty/serial/stm32-usart.c                                                     |    5 
 drivers/tty/tty.h                                                                    |    2 
 drivers/tty/tty_io.c                                                                 |    4 
 drivers/tty/tty_ioctl.c                                                              |   45 
 drivers/usb/chipidea/core.c                                                          |    2 
 drivers/usb/dwc3/core.c                                                              |   15 
 drivers/usb/dwc3/gadget.c                                                            |   60 
 drivers/usb/gadget/function/f_tcm.c                                                  |    4 
 drivers/usb/gadget/udc/core.c                                                        |  151 +
 drivers/usb/gadget/udc/renesas_usb3.c                                                |    1 
 drivers/usb/gadget/udc/tegra-xudc.c                                                  |    2 
 drivers/usb/host/xhci-debugfs.c                                                      |    1 
 drivers/usb/host/xhci-rcar.c                                                         |    3 
 drivers/usb/mtu3/mtu3_qmu.c                                                          |    5 
 drivers/vhost/vdpa.c                                                                 |    8 
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c                                                |    2 
 drivers/virt/coco/sev-guest/sev-guest.c                                              |   27 
 drivers/virtio/virtio_ring.c                                                         |   22 
 drivers/xen/pcpu.c                                                                   |   20 
 fs/Makefile                                                                          |    3 
 fs/afs/dir.c                                                                         |    4 
 fs/afs/inode.c                                                                       |   10 
 fs/btrfs/ioctl.c                                                                     |    5 
 fs/ceph/caps.c                                                                       |    2 
 fs/ceph/debugfs.c                                                                    |   18 
 fs/ceph/mds_client.c                                                                 |   72 
 fs/ceph/mds_client.h                                                                 |    3 
 fs/ceph/super.h                                                                      |    2 
 fs/cifs/cifs_debug.c                                                                 |    7 
 fs/cifs/cifs_debug.h                                                                 |   12 
 fs/cifs/connect.c                                                                    |   10 
 fs/cifs/file.c                                                                       |   16 
 fs/cifs/misc.c                                                                       |    8 
 fs/cifs/sess.c                                                                       |    7 
 fs/cifs/smb2pdu.c                                                                    |   15 
 fs/crypto/inline_crypt.c                                                             |   14 
 fs/erofs/internal.h                                                                  |    3 
 fs/erofs/super.c                                                                     |   22 
 fs/erofs/zmap.c                                                                      |    4 
 fs/ext4/extents.c                                                                    |    3 
 fs/ext4/inode.c                                                                      |    3 
 fs/f2fs/compress.c                                                                   |   13 
 fs/f2fs/data.c                                                                       |    5 
 fs/f2fs/f2fs.h                                                                       |    1 
 fs/f2fs/file.c                                                                       |   21 
 fs/f2fs/gc.c                                                                         |    2 
 fs/f2fs/segment.c                                                                    |   73 
 fs/f2fs/segment.h                                                                    |    3 
 fs/f2fs/super.c                                                                      |    2 
 fs/f2fs/sysfs.c                                                                      |    4 
 fs/jbd2/transaction.c                                                                |    3 
 fs/ksmbd/auth.c                                                                      |   19 
 fs/ksmbd/mgmt/tree_connect.c                                                         |   10 
 fs/ksmbd/mgmt/tree_connect.h                                                         |    3 
 fs/ksmbd/server.c                                                                    |    1 
 fs/ksmbd/smb2pdu.c                                                                   |   21 
 fs/nfs/nfs4state.c                                                                   |    4 
 fs/nilfs2/bmap.c                                                                     |   16 
 fs/nilfs2/segment.c                                                                  |    5 
 fs/ntfs3/fslog.c                                                                     |    6 
 fs/ntfs3/index.c                                                                     |    8 
 fs/ntfs3/inode.c                                                                     |    2 
 fs/ntfs3/ntfs_fs.h                                                                   |    1 
 fs/pstore/pmsg.c                                                                     |    7 
 fs/reiserfs/xattr_security.c                                                         |    8 
 fs/ubifs/dir.c                                                                       |    7 
 fs/ubifs/tnc.c                                                                       |  142 -
 fs/xfs/libxfs/xfs_sb.c                                                               |   11 
 include/asm-generic/io.h                                                             |    4 
 include/drm/i915_pciids.h                                                            |    1 
 include/linux/blk-crypto-profile.h                                                   |   12 
 include/linux/blk-crypto.h                                                           |   15 
 include/linux/mailbox/zynqmp-ipi-message.h                                           |    2 
 include/linux/mlx5/mlx5_ifc.h                                                        |    3 
 include/linux/netfilter/nfnetlink.h                                                  |    1 
 include/linux/posix-timers.h                                                         |   17 
 include/linux/sunrpc/sched.h                                                         |    3 
 include/linux/tick.h                                                                 |    2 
 include/linux/vt_buffer.h                                                            |    2 
 include/net/bond_alb.h                                                               |    4 
 include/net/netfilter/nf_conntrack_core.h                                            |    6 
 include/net/netfilter/nf_tables.h                                                    |    1 
 include/net/scm.h                                                                    |   13 
 include/net/xsk_buff_pool.h                                                          |    9 
 include/scsi/sas_ata.h                                                               |    6 
 include/sound/acp62_chip_offset_byte.h                                               |  444 ----
 include/sound/acp63_chip_offset_byte.h                                               |  444 ++++
 include/target/iscsi/iscsi_target_core.h                                             |    1 
 include/target/target_core_base.h                                                    |   14 
 include/target/target_core_fabric.h                                                  |   15 
 include/trace/events/qrtr.h                                                          |   33 
 include/trace/events/timer.h                                                         |    3 
 include/trace/stages/stage5_get_offsets.h                                            |   21 
 include/uapi/linux/btrfs.h                                                           |    1 
 include/uapi/linux/const.h                                                           |    2 
 include/xen/xen.h                                                                    |   11 
 io_uring/rsrc.c                                                                      |    2 
 kernel/bpf/btf.c                                                                     |   16 
 kernel/bpf/cgroup.c                                                                  |    9 
 kernel/bpf/verifier.c                                                                |   32 
 kernel/dma/swiotlb.c                                                                 |   16 
 kernel/events/core.c                                                                 |    4 
 kernel/kcsan/core.c                                                                  |   17 
 kernel/kheaders.c                                                                    |   10 
 kernel/power/hibernate.c                                                             |   15 
 kernel/power/power.h                                                                 |    1 
 kernel/power/swap.c                                                                  |    8 
 kernel/rcu/tree.c                                                                    |    1 
 kernel/relay.c                                                                       |    3 
 kernel/sched/deadline.c                                                              |    1 
 kernel/sched/fair.c                                                                  |    2 
 kernel/sched/rt.c                                                                    |    4 
 kernel/time/posix-cpu-timers.c                                                       |   81 
 kernel/time/posix-timers.c                                                           |    4 
 kernel/time/tick-common.c                                                            |   12 
 kernel/time/tick-sched.c                                                             |   16 
 kernel/time/timekeeping.c                                                            |    4 
 kernel/trace/ring_buffer.c                                                           |   20 
 kernel/trace/trace.c                                                                 |    2 
 kernel/trace/trace_events_user.c                                                     |    3 
 kernel/workqueue.c                                                                   |   10 
 lib/debugobjects.c                                                                   |  146 -
 lib/kunit/debugfs.c                                                                  |   16 
 lib/kunit/executor.c                                                                 |    6 
 lib/kunit/test.c                                                                     |   28 
 mm/kasan/hw_tags.c                                                                   |    4 
 mm/mempolicy.c                                                                       |    4 
 mm/vmscan.c                                                                          |   10 
 net/8021q/vlan_dev.c                                                                 |    2 
 net/core/skbuff.c                                                                    |    3 
 net/dccp/ipv6.c                                                                      |    1 
 net/ipv4/ip_output.c                                                                 |   16 
 net/ipv6/ip6_input.c                                                                 |   14 
 net/ipv6/raw.c                                                                       |    5 
 net/ipv6/tcp_ipv6.c                                                                  |    2 
 net/ipv6/udp.c                                                                       |    2 
 net/netfilter/nf_conntrack_bpf.c                                                     |    1 
 net/netfilter/nf_conntrack_core.c                                                    |    1 
 net/netfilter/nf_conntrack_netlink.c                                                 |   16 
 net/netfilter/nf_tables_api.c                                                        |   20 
 net/netfilter/nfnetlink.c                                                            |    2 
 net/netfilter/nft_dynset.c                                                           |    2 
 net/netfilter/nft_lookup.c                                                           |    2 
 net/netfilter/nft_objref.c                                                           |    2 
 net/netlink/af_netlink.c                                                             |   75 
 net/packet/af_packet.c                                                               |   30 
 net/packet/diag.c                                                                    |    4 
 net/packet/internal.h                                                                |   26 
 net/sched/sch_fq.c                                                                   |    6 
 net/sunrpc/clnt.c                                                                    |    3 
 net/sunrpc/sched.c                                                                   |    1 
 net/xdp/xsk_queue.h                                                                  |    1 
 scripts/gdb/linux/clk.py                                                             |    2 
 scripts/gdb/linux/constants.py.in                                                    |    2 
 scripts/gdb/linux/genpd.py                                                           |    4 
 scripts/gdb/linux/timerlist.py                                                       |    4 
 scripts/gdb/linux/utils.py                                                           |    5 
 scripts/gdb/vmlinux-gdb.py                                                           |    5 
 security/integrity/ima/Kconfig                                                       |    2 
 security/selinux/Makefile                                                            |    4 
 sound/pci/hda/patch_realtek.c                                                        |    5 
 sound/soc/amd/Kconfig                                                                |    4 
 sound/soc/amd/ps/acp62.h                                                             |   98 
 sound/soc/amd/ps/acp63.h                                                             |   98 
 sound/soc/amd/ps/pci-ps.c                                                            |  130 -
 sound/soc/amd/ps/ps-mach.c                                                           |   30 
 sound/soc/amd/ps/ps-pdm-dma.c                                                        |  188 -
 sound/soc/amd/yc/acp6x-mach.c                                                        |    7 
 sound/soc/codecs/cs35l41.c                                                           |   34 
 sound/soc/codecs/da7213.c                                                            |    6 
 sound/soc/codecs/es8316.c                                                            |   14 
 sound/soc/fsl/fsl_mqs.c                                                              |   15 
 sound/soc/intel/boards/bytcr_rt5640.c                                                |   12 
 sound/soc/intel/boards/sof_sdw.c                                                     |   11 
 sound/soc/intel/common/soc-acpi-intel-adl-match.c                                    |   20 
 sound/soc/soc-compress.c                                                             |    3 
 sound/soc/soc-pcm.c                                                                  |    4 
 sound/usb/quirks-table.h                                                             |   58 
 tools/arch/x86/kcpuid/cpuid.csv                                                      |    4 
 tools/bpf/bpftool/json_writer.c                                                      |    3 
 tools/bpf/bpftool/xlated_dumper.c                                                    |    7 
 tools/lib/bpf/gen_loader.c                                                           |   10 
 tools/objtool/check.c                                                                |   11 
 tools/perf/util/auxtrace.c                                                           |    5 
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c                                  |    2 
 tools/testing/selftests/bpf/network_helpers.c                                        |    2 
 tools/testing/selftests/bpf/prog_tests/align.c                                       |    4 
 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c                            |    8 
 tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c                   |    1 
 tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c                         |    3 
 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c                     |   15 
 tools/testing/selftests/bpf/test_xsk.sh                                              |    1 
 tools/testing/selftests/bpf/testing_helpers.c                                        |   20 
 tools/testing/selftests/bpf/testing_helpers.h                                        |    2 
 tools/testing/selftests/bpf/xskxceiver.c                                             |   19 
 tools/testing/selftests/bpf/xskxceiver.h                                             |    1 
 tools/testing/selftests/mount_setattr/mount_setattr_test.c                           |    1 
 tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_marked_sample_test.c |    4 
 tools/testing/selftests/resctrl/cache.c                                              |    4 
 tools/testing/selftests/resctrl/cat_test.c                                           |    2 
 tools/testing/selftests/resctrl/cmt_test.c                                           |    2 
 tools/testing/selftests/resctrl/fill_buf.c                                           |    2 
 tools/testing/selftests/resctrl/mba_test.c                                           |    9 
 tools/testing/selftests/resctrl/mbm_test.c                                           |    2 
 tools/testing/selftests/resctrl/resctrl.h                                            |    2 
 tools/testing/selftests/resctrl/resctrl_val.c                                        |   21 
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json                           |   22 
 tools/testing/selftests/user_events/ftrace_test.c                                    |    5 
 724 files changed, 8428 insertions(+), 7117 deletions(-)

Adam Ford (1):
      drm/bridge: adv7533: Fix adv7533_mode_valid for adv7533 and adv7535

Adam Skladowski (1):
      drm: msm: adreno: Disable preemption on Adreno 510

Aditya Kumar Singh (1):
      wifi: ath11k: fix deinitialization of firmware resources

Adrian Hunter (2):
      perf auxtrace: Fix address filter entire kernel size
      perf intel-pt: Fix CYC timestamps after standalone CBR

Albert Huang (1):
      virtio_ring: don't update event idx on get_buf

Alex Hung (1):
      drm/amd/display: fix a divided-by-zero error

Alex Williamson (1):
      PCI/PM: Extend D3hot delay for NVIDIA HDA controllers

Alexander Mikhalitsyn (1):
      scm: fix MSG_CTRUNC setting condition for SO_PASSSEC

Alexandre Ghiti (1):
      riscv: Fix ptdump when KASAN is enabled

Alexandre Torgue (1):
      ARM: dts: stm32: fix spi1 pin assignment on stm32mp15

Alexei Starovoitov (2):
      libbpf: Fix ld_imm64 copy logic for ksym in light skeleton.
      bpf: Fix race between btf_put and btf_idr walk.

Alexey V. Vissarionov (1):
      wifi: ath6kl: minor fix for allocation size

Anastasia Kovaleva (1):
      scsi: target: core: Change the way target_xcopy_do_work() sets restiction on max I/O

Andrew Jones (1):
      RISC-V: Align SBI probe implementation with spec

Andrii Nakryiko (2):
      bpf: take into account liveness when propagating precision
      bpf: fix precision propagation verbose logging

AngeloGioacchino Del Regno (8):
      cpufreq: mediatek: Raise proc and sram max voltage for MT7622/7623
      arm64: dts: mediatek: mt8192-asurada: Fix voltage constraint for Vgpu
      clk: mediatek: mt2712: Add error handling to clk_mt2712_apmixed_probe()
      clk: mediatek: Consistently use GATE_MTK() macro
      clk: mediatek: mt7622: Properly use CLK_IS_CRITICAL flag
      clk: mediatek: mt8135: Properly use CLK_IS_CRITICAL flag
      pwm: mtk-disp: Disable shadow registers before setting backlight values
      pwm: mtk-disp: Configure double buffering before reading in .get_state()

Anh Tuan Phan (1):
      selftests mount: Fix mount_setattr_test builds failed

Ard Biesheuvel (2):
      arm64: Always load shadow stack pointer directly from the task struct
      arm64: Stash shadow stack pointer in the task struct on interrupt

Armin Wolf (1):
      wifi: rt2x00: Fix memory leak when handling surveys

Arnd Bergmann (2):
      hte: tegra: fix 'struct of_device_id' build error
      blk-iocost: avoid 64-bit division in ioc_timer_fn

Arınç ÜNAL (1):
      pinctrl: ralink: reintroduce ralink,rt2880-pinmux compatible string

Avihai Horon (1):
      RDMA/mlx5: Check pcie_relaxed_ordering_enabled() in UMR

Avraham Stern (2):
      wifi: iwlwifi: trans: don't trigger d3 interrupt twice
      wifi: iwlwifi: mvm: don't set CHECKSUM_COMPLETE for unsupported protocols

Aya Levin (1):
      net/mlx5e: Nullify table pointer when failing to create

Ayala Beker (1):
      wifi: iwlwifi: mvm: don't drop unencrypted MCAST frames

Babu Moger (1):
      hwmon: (k10temp) Check range scale when CUR_TEMP register is read-write

Badhri Jagan Sridharan (2):
      usb: gadget: udc: core: Invoke usb_gadget_connect only when started
      usb: gadget: udc: core: Prevent redundant calls to pullup

Bart Van Assche (1):
      blk-crypto: Add a missing include directive

Basavaraj Natikar (7):
      HID: amd_sfh: Correct the structure fields
      HID: amd_sfh: Correct the sensor enable and disable command
      HID: amd_sfh: Fix illuminance value
      HID: amd_sfh: Add support for shutdown operation
      HID: amd_sfh: Correct the stop all command
      HID: amd_sfh: Increase sensor command timeout for SFH1.1
      HID: amd_sfh: Handle "no sensors" enabled for SFH1.1

Beau Belgrave (1):
      tracing/user_events: Ensure write index cannot be negative

Benjamin Asbach (1):
      platform/x86: thinkpad_acpi: Add missing T14s Gen1 type to s2idle quirk list

Bharath SM (2):
      SMB3: Add missing locks to protect deferred close file list
      SMB3: Close deferred file handles in case of handle lease break

Bhavya Kapoor (1):
      arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel property

Bitterblue Smith (1):
      wifi: rtl8xxxu: RTL8192EU always needs full init

Bjorn Andersson (2):
      cpufreq: qcom-cpufreq-hw: Revert adding cpufreq qos
      rpmsg: glink: Propagate TX failures in intentless mode as well

Caleb Harper (1):
      ALSA: hda/realtek: support HP Pavilion Aero 13-be0xxx Mute LED

Chao Yu (3):
      f2fs: fix to avoid use-after-free for cached IPU bio
      f2fs: fix to check return value of f2fs_do_truncate_blocks()
      f2fs: fix to check return value of inc_valid_block_count()

Charles Keepax (1):
      mfd: arizona-spi: Add missing MODULE_DEVICE_TABLE

Chen Yu (2):
      PM: hibernate: Turn snapshot_test into global variable
      PM: hibernate: Do not get block device exclusively in test_resume mode

Chen Zhongjin (1):
      fs/ntfs3: Fix memory leak if ntfs_read_mft failed

Chen-Yu Tsai (1):
      drm/mediatek: dp: Only trigger DRM HPD events if bridge is attached

Cheng Xu (1):
      RDMA/erdma: Use fixed hardware page size

Chengming Zhou (1):
      blk-stat: fix QUEUE_FLAG_STATS clear

Chris Mi (2):
      net/mlx5: E-switch, Create per vport table based on devlink encap mode
      net/mlx5: E-switch, Don't destroy indirect table in split rule

Chris Morgan (1):
      power: supply: rk817: Fix low SOC bugs

Chris Packham (1):
      hwmon: (adt7475) Use device_property APIs when configuring polarity

Christian König (1):
      drm/ttm: optimize pool allocations a bit v2

Christian Marangi (1):
      wifi: ath11k: fix SAC bug on peer addition with sta band migration

Christoph Böhmwalder (1):
      drbd: correctly submit flush bio on barrier

Christoph Hellwig (4):
      blk-crypto: don't use struct request_queue for public interfaces
      blk-crypto: add a blk_crypto_config_supported_natively helper
      blk-crypto: move internal only declarations to blk-crypto-internal.h
      blk-mq: don't plug for head insertions in blk_execute_rq_nowait

Christophe JAILLET (3):
      crypto: caam - Clear some memory in instantiate_rng
      fbdev: mmp: Fix deferred clk handling in mmphw_probe()
      dmaengine: mv_xor_v2: Fix an error code.

Christophe Leroy (2):
      spi: fsl-spi: Fix CPM/QE mode Litte Endian
      powerpc/perf: Properly detect mpc7450 family

Chunfeng Yun (1):
      usb: mtu3: fix kernel panic at qmu transfer done irq handler

Cindy Lu (1):
      vhost_vdpa: fix unmap process in no-batch mode

Claudiu Beznea (2):
      clk: at91: clk-sam9x60-pll: fix return value check
      dmaengine: at_xdmac: do not enable all cyclic channels

Clément Léger (1):
      clk: add missing of_node_put() in "assigned-clocks" property parsing

Colin Foster (1):
      mfd: ocelot-spi: Fix unsupported bulk read

Conor Dooley (2):
      mailbox: mpfs: switch to txdone_poll
      clk: microchip: fix potential UAF in auxdev release callback

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

Dan Carpenter (7):
      media: av7110: prevent underflow in write_ts_to_decoder()
      drm: rcar-du: Fix a NULL vs IS_ERR() bug
      wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()
      net: dpaa: Fix uninitialized variable in dpaa_stop()
      firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
      RDMA/mlx4: Prevent shift wrapping in set_user_sq_size()
      hte: tegra-194: Fix off by one in tegra_hte_map_to_line_id()

Dan Williams (1):
      cxl/hdm: Fail upon detecting 0-sized decoders

Daniel Baluta (1):
      ASoC: soc-compress: Inherit atomicity from DAI link for Compress FE

Daniel Borkmann (2):
      bpf: Fix __reg_bound_offset 64->32 var_off subreg propagation
      bpf, sockmap: Revert buggy deadlock fix in the sockhash and sockmap

Daniel Gabay (2):
      wifi: iwlwifi: yoyo: skip dump correctly on hw error
      wifi: iwlwifi: yoyo: Fix possible division by zero

Daniel Golle (1):
      net: sfp: add quirk enabling 2500Base-x for HG MXPD-483II

Daniel Miess (1):
      drm/amd/display: limit timing for single dimm memory

Daniil Dulov (1):
      RDMA/siw: Fix potential page_array out of range access

Danila Chernetsov (1):
      scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS

Dave Chinner (1):
      xfs: don't consider future format versions valid

David Howells (1):
      afs: Fix getattr to report server i_size on dirs, not local size

David Matlack (1):
      KVM: RISC-V: Retry fault if vma_lookup() results become invalid

Davide Caratti (1):
      net/sched: sch_fq: fix integer overflow of "credit"

Deren Wu (1):
      wifi: mt76: add flexible polling wait-interval support

Devarsh Thakkar (1):
      arm64: dts: ti: k3-am62a7-sk: Fix DDR size to full 4GB

Dhruva Gole (3):
      spi: cadence-quadspi: fix suspend-resume implementations
      spi: cadence-quadspi: use macro DEFINE_SIMPLE_DEV_PM_OPS
      rtc: k3: handle errors while enabling wake irq

Dionna Glaze (1):
      virt/coco/sev-guest: Double-buffer messages

Dmitry Baryshkov (4):
      phy: qcom-qmp-pcie: sc8180x PCIe PHY has 2 lanes
      clk: qcom: gcc-sm8350: fix PCIe PIPE clocks handling
      clk: qcom: dispcc-qcm2290: get rid of test clock
      dma: gpi: remove spurious unlock in gpi_ch_init

Dom Cobley (1):
      drm/probe-helper: Cancel previous job before starting new one

Doug Berger (2):
      serial: 8250_bcm7271: Fix arbitration handling
      swiotlb: relocate PageHighMem test away from rmem_swiotlb_setup

Douglas Anderson (7):
      regulator: core: Shorten off-on-delay-us for always-on/boot-on by time since booted
      regulator: core: Consistently set mutex_owner when using ww_mutex_lock_slow()
      regulator: core: Avoid lockdep reports when resolving supplies
      arm64: dts: sc7180: Rename qspi data12 as data23
      arm64: dts: sc7280: Rename qspi data12 as data23
      wifi: ath11k: Use platform_get_irq() to get the interrupt
      wifi: ath5k: Use platform_get_irq() to get the interrupt

Duy Nguyen (1):
      ASoC: da7213.c: add missing pm_runtime_disable()

Emmanuel Grumbach (1):
      wifi: iwlwifi: make the loop for card preparation effective

Eric Biggers (4):
      blk-mq: release crypto keyslot before reporting I/O complete
      blk-crypto: make blk_crypto_evict_key() return void
      blk-crypto: make blk_crypto_evict_key() more robust
      crypto: arm64/aes-neonbs - fix crash with CFI enabled

Eric Dumazet (3):
      net/packet: annotate accesses to po->xmit
      net/packet: convert po->origdev to an atomic flag
      net/packet: convert po->auxdata to an atomic flag

Eugene Huang (2):
      ASOC: Intel: sof_sdw: add quirk for Intel 'Rooks County' NUC M15
      ASoC: Intel: soc-acpi: add table for Intel 'Rooks County' NUC M15

Fedor Pchelkin (2):
      wifi: ath9k: hif_usb: fix memory leak of remain_skbs
      wifi: ath6kl: reduce WARN to dev_dbg() in callback

Felix Fietkau (1):
      wifi: mt76: add missing locking to protect against concurrent rx/status calls

Feng Zhou (1):
      bpf/btf: Fix is_int_ptr()

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

Ge-org Brohammer (1):
      ASoC: amd: yc: Add DMI entries to support Victus by HP Laptop 16-e1xxx (8A22)

Geert Uytterhoeven (6):
      arm64: dts: renesas: r8a77990: Remove bogus voltages from OPP table
      arm64: dts: renesas: r8a774c0: Remove bogus voltages from OPP table
      timekeeping: Fix references to nonexistent ktime_get_fast_ns()
      pinctrl: renesas: r8a779g0: Fix Group 4/5 pin functions
      pinctrl: renesas: r8a779g0: Fix Group 6/7 pin functions
      pinctrl: renesas: r8a779g0: Fix ERROROUTC function names

Gencen Gan (1):
      net: amd: Fix link leak when verifying config failed

Georgii Kruglov (1):
      mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data

Geraldo Nascimento (1):
      ALSA: usb-audio: Add quirk for Pioneer DDJ-800

Greg Kroah-Hartman (1):
      Linux 6.1.28

Gregory Greenman (1):
      wifi: iwlwifi: fix duplicate entry in iwl_dev_info_table

H. Nikolaus Schaller (3):
      ARM: dts: gta04: fix excess dma channel usage
      PCI: imx6: Install the fault handler only on compatible match
      leds: tca6507: Fix error handling of using fwnode_property_read_string

Hai Pham (1):
      pinctrl: renesas: r8a779a0: Remove incorrect AVB[01] pinmux configuration

Hamza Mahfooz (1):
      drm/amd/display: fix PSR-SU/DSC interoperability support

Hans Verkuil (1):
      pinctrl-bcm2835.c: fix race condition when setting gpio dir

Hans de Goede (5):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Acer Iconia One 7 B1-750
      ACPI: video: Remove acpi_backlight=video quirk for Lenovo ThinkPad W530
      drivers: staging: rtl8723bs: Fix locking in _rtw_join_timeout_handler()
      drivers: staging: rtl8723bs: Fix locking in rtw_scan_timeout_handler()
      ACPI: PM: Do not turn of unused power resources on the Toshiba Click Mini

Harshit Mogalapalli (1):
      drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()

Heiner Kallweit (2):
      pwm: meson: Fix axg ao mux parents
      pwm: meson: Fix g12a ao clk81 name

Helge Deller (2):
      parisc: Fix argument pointer in real64_call_asm()
      parisc: Ensure page alignment in flush functions

Herbert Xu (1):
      crypto: drbg - Only fail when jent is unavailable in FIPS mode

Hugh Dickins (1):
      ia64: fix an addr to taddr in huge_pte_offset()

Igor Artemiev (1):
      drm/amd/display: Fix potential null dereference

Ilkka Koskinen (1):
      perf/arm-cmn: Move overlapping wp_combine field

Ilpo Järvinen (6):
      tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH
      serial: 8250: Fix serial8250_tx_empty() race with DMA Tx
      selftests/resctrl: Return NULL if malloc_and_init_memory() did not alloc mem
      selftests/resctrl: Move ->setup() call outside of test specific branches
      selftests/resctrl: Allow ->setup() to return errors
      selftests/resctrl: Check for return value after write_schemata()

Jaegeuk Kim (2):
      f2fs: apply zone capacity to all zone type
      f2fs: fix scheduling while atomic in decompression path

Jan Kara (3):
      jdb2: Don't refuse invalidation of already invalidated buffers
      mm: do not reclaim private data from pinned page
      md/raid5: Improve performance for sequential IO

Jan Kundrát (1):
      serial: max310x: fix IO data corruption in batched operations

Jan Sokolowski (3):
      i40e: Remove unused i40e status codes
      i40e: Remove string printing for i40e_status
      i40e: use int for i40e_status

Janne Grunau (1):
      arm64: dts: apple: t8103: Disable unused PCIe ports

Jarkko Sakkinen (1):
      tpm: Add !tpm_amd_is_rng_defective() to the hwrng_unregister() call site

Javier Martinez Canillas (1):
      media: venus: dec: Fix capture formats enumeration order

Jean-Philippe Brucker (1):
      ACPI: VIOT: Initialize the correct IOMMU fwspec

Jeffrey Hugo (3):
      bus: mhi: host: Remove duplicate ee check for syserr
      bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state
      bus: mhi: host: Range check CHDBOFF and ERDBOFF

Jerry Snitselaar (1):
      iommu/amd: Set page size bitmap during V2 domain allocation

Jia-Wei Chang (3):
      cpufreq: mediatek: fix passing zero to 'PTR_ERR'
      cpufreq: mediatek: fix KP caused by handler usage after regulator_put/clk_put
      cpufreq: mediatek: raise proc/sram max voltage for MT8516

Jiasheng Jiang (3):
      media: bdisp: Add missing check for create_workqueue
      media: platform: mtk-mdp3: Add missing check and free for ida_alloc
      fs/ntfs3: Add check for kmemdup

Jiaxun Yang (1):
      MIPS: fw: Allow firmware to pass a empty env

Jiefeng Li (1):
      wifi: mt76: mt7921: fix missing unwind goto in `mt7921u_probe`

Jingbo Xu (2):
      erofs: initialize packed inode after root inode is assigned
      erofs: fix potential overflow calculating xattr_isize

Jiri Pirko (2):
      net/mlx5: Remove "recovery" arg from mlx5_load_one() function
      net/mlx5: Suspend auxiliary devices only in case of PCI device suspend

Jiri Slaby (SUSE) (8):
      net: wwan: t7xx: do not compile with -Werror
      wireguard: timers: cast enum limits members to int in prints
      thunderbolt: Use correct type in tb_port_is_clx_enabled() prototype
      bonding (gcc13): synchronize bond_{a,t}lb_xmit() types
      wifi: ath11k: synchronize ath11k_mac_he_gi_to_nl80211_he_gi()'s return type
      block/blk-iocost (gcc13): keep large values in a new enum
      sfc (gcc13): synchronize ef100_enqueue_skb()'s return type
      drm/amd/display (gcc13): fix enum mismatch

Jishnu Prakash (1):
      spmi: Add a check for remove callback when removing a SPMI driver

Joe Damato (2):
      ixgbe: Allow flow hash to be set via ethtool
      ixgbe: Enable setting RSS table to default values

Joel Fernandes (Google) (1):
      tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem

Johan Hovold (6):
      USB: dwc3: fix runtime pm imbalance on probe errors
      USB: dwc3: fix runtime pm imbalance on unbind
      xhci: fix debugfs register accesses while suspended
      serial: fix TIOCSRS485 locking
      drm/msm/adreno: drop bogus pm_runtime_set_active()
      interconnect: qcom: rpm: drop bogus pm domain attach

Johannes Berg (4):
      ring-buffer: Sync IRQ works before buffer destruction
      wifi: iwlwifi: debug: fix crash in __iwl_err()
      wifi: iwlwifi: mvm: check firmware response size
      wifi: iwlwifi: fw: fix memory leak in debugfs

John Garry (1):
      scsi: libsas: Add sas_ata_device_link_abort()

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

Josh Triplett (1):
      PCI: kirin: Select REGMAP_MMIO

Kai-Heng Feng (1):
      ALSA: hda/realtek: Fix mute and micmute LEDs for an HP laptop

Kajol Jain (1):
      selftests/powerpc/pmu: Fix sample field check in the mmcra_thresh_marked_sample_test

Kal Conley (4):
      selftests: xsk: Use correct UMEM size in testapp_invalid_desc
      selftests: xsk: Disable IPv6 on VETH1
      selftests: xsk: Deflakify STATS_RX_DROPPED test
      xsk: Fix unaligned descriptor validation

Kalle Valo (1):
      wifi: ath11k: reduce the MHI timeout to 20s

Kang Chen (3):
      wifi: mt76: handle failure of vzalloc in mt7615_coredump_work
      IB/hifi1: add a null check of kzalloc_node in hfi1_ipoib_txreq_init
      thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe

Kees Cook (1):
      kheaders: Use array declaration instead of char

Kefeng Wang (1):
      fs: fix sysctls.c built

Keith Busch (1):
      nvme: fix async event trace event

Kevin Brodsky (1):
      uapi/linux/const.h: prefer ISO-friendly __typeof__

Kishon Vijay Abraham I (1):
      iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration in IRTE

Konrad Dybcio (7):
      ARM: dts: qcom-apq8064: Fix opp table child name
      arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name
      drm/panel: novatek-nt35950: Improve error handling
      drm/panel: novatek-nt35950: Only unregister DSI1 if it exists
      clk: qcom: gcc-qcm2290: Fix up gcc_sdcc2_apps_clk_src
      clk: qcom: gcc-sm6115: Mark RCGs shared where applicable
      clk: qcom: dispcc-qcm2290: Remove inexistent DSI1PHY clk

Krzysztof Kozlowski (13):
      soundwire: qcom: correct setting ignore bit on v1.5.1
      pinctrl: qcom: lpass-lpi: set output value before enabling output
      ASoC: dt-bindings: qcom,lpass-rx-macro: correct minItems for clocks
      arm64: dts: qcom: sc7280: fix EUD port properties
      arm64: dts: qcom: sm8350-microsoft-surface: fix USB dual-role mode property
      arm64: dts: qcom: sc7280-herobrine-villager: correct trackpad supply
      arm64: dts: qcom: sc7180-trogdor-lazor: correct trackpad supply
      arm64: dts: qcom: sc7180-trogdor-pazquel: correct trackpad supply
      arm64: dts: qcom: msm8994-kitakami: drop unit address from PMI8994 regulator
      arm64: dts: qcom: msm8994-msft-lumia-octagon: drop unit address from PMI8994 regulator
      arm64: dts: qcom: apq8096-db820c: drop unit address from PMI8994 regulator
      iio: light: max44009: add missing OF device matching
      rtc: omap: include header for omap_rtc_power_off_program prototype

Kuniyuki Iwashima (2):
      netlink: Use copy_to_user() for optval in netlink_getsockopt().
      tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.

Kuppuswamy Sathyanarayanan (1):
      PCI/EDR: Clear Device Status after EDR error recovery

Lad Prabhakar (4):
      arm64: dts: renesas: r9a07g044: Update IRQ numbers for SSI channels
      arm64: dts: renesas: r9a07g054: Update IRQ numbers for SSI channels
      arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() macro to specify interrupt property
      arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI channels

Lars-Peter Clausen (2):
      i2c: cadence: cdns_i2c_master_xfer(): Fix runtime PM leak on error path
      i2c: xiic: xiic_xfer(): Fix runtime PM leak on error path

Laurent Pinchart (1):
      media: max9286: Free control handler

Lee Jones (1):
      drm/amd/display/dc/dce60/Makefile: Fix previous attempt to silence known override-init warnings

Li Lingfeng (1):
      dm: don't lock fs when the map is NULL in process of resume

Li Nan (2):
      md/raid10: fix task hung in raid10d
      md/raid10: fix null-ptr-deref in raid10_sync_request

Li Yang (1):
      soc: renesas: renesas-soc: Release 'chipid' from ioremap()

Liang He (2):
      platform/chrome: cros_typec_switch: Add missing fwnode_handle_put()
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

Lorenz Brun (1):
      wifi: mt76: mt7915: expose device tree match table

Lorenzo Stoakes (1):
      mm/mempolicy: correctly update prev when policy is equal on mbind

Lucas Tanure (1):
      ASoC: cs35l41: Only disable internal boost

Luis Gerhorst (2):
      tools: bpftool: Remove invalid \' json escape
      bpf: Remove misleading spec_v1 check on var-offset stack read

Lukas Wunner (1):
      PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock

Madhu Koriginja (1):
      netfilter: keep conntrack reference until IPsecv6 policy checks are done

Manivannan Sadhasivam (13):
      PCI: qcom: Fix the incorrect register usage in v2.7.0 config
      arm64: dts: qcom: sdm845: Fix the PCI I/O port range
      arm64: dts: qcom: msm8998: Fix the PCI I/O port range
      arm64: dts: qcom: sc7280: Fix the PCI I/O port range
      arm64: dts: qcom: ipq8074: Fix the PCI I/O port range
      arm64: dts: qcom: ipq6018: Fix the PCI I/O port range
      arm64: dts: qcom: msm8996: Fix the PCI I/O port range
      arm64: dts: qcom: sm8250: Fix the PCI I/O port range
      arm64: dts: qcom: sm8150: Fix the PCI I/O port range
      arm64: dts: qcom: sm8450: Fix the PCI I/O port range
      ARM: dts: qcom: ipq4019: Fix the PCI I/O port range
      ARM: dts: qcom: ipq8064: Fix the PCI I/O port range
      ARM: dts: qcom: sdx55: Fix the unit address of PCIe EP node

Marc Dionne (2):
      afs: Fix updating of i_size with dv jump from server
      afs: Avoid endless loop if file is larger than expected

Marco Elver (1):
      kcsan: Avoid READ_ONCE() in read_instrumented_memory()

Marco Pagani (1):
      fpga: bridge: fix kernel-doc parameter description

Marek Vasut (1):
      serial: stm32: Re-assert RTS/DE GPIO in RS485 mode only if more data are transmitted

Mario Limonciello (6):
      wifi: mt76: mt7921e: Set memory space enable in PCI_COMMAND if unset
      crypto: ccp - Don't initialize CCP for PSP 0x1649
      platform/x86/amd: pmc: Don't try to read SMU version on Picasso
      platform/x86/amd: pmc: Hide SMU version and program attributes for Picasso
      platform/x86/amd: pmc: Don't dump data after resume from s0i3 on picasso
      platform/x86/amd: pmc: Move idlemask check into `amd_pmc_idlemask_read`

Mark Asselstine (1):
      ALSA: hda/realtek: Add quirk for ASUS UM3402YAR using CS35L41

Mark Bloch (1):
      RDMA/mlx5: Fix flow counter query via DEVX

Mark Rutland (1):
      kasan: hw_tags: avoid invalid virt_to_page()

Mark Zhang (2):
      RDMA/cm: Trace icm_send_rej event before the cm state is reset
      RDMA/mlx5: Use correct device num_ports when modify DC

Martin Blumenstingl (3):
      wifi: rtw88: mac: Return the original error from rtw_pwr_seq_parser()
      wifi: rtw88: mac: Return the original error from rtw_mac_power_switch()
      rtc: meson-vrtc: Use ktime_get_real_ts64() to get the current time

Martin KaFai Lau (1):
      selftests/bpf: Fix a fd leak in an error path in network_helpers.c

Matt Roper (1):
      drm/i915/dg2: Drop one PCI ID

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
      swiotlb: fix debugfs reporting of reserved memory pools

Michael Walle (3):
      mtd: core: provide unique name for nvmem device, take two
      mtd: core: fix nvmem error reporting
      mtd: core: fix error path for nvmem provider

Michał Krawczyk (1):
      media: venus: dec: Fix handling of the start cmd

Mike Christie (7):
      scsi: target: Move sess cmd counter to new struct
      scsi: target: Move cmd counter allocation
      scsi: target: Pass in cmd counter to use during cmd setup
      scsi: target: iscsit: isert: Alloc per conn cmd counter
      scsi: target: iscsit: Stop/wait on cmds during conn close
      scsi: target: Fix multiple LUN_RESET handling
      scsi: target: iscsit: Fix TAS handling during conn cleanup

Mike Snitzer (3):
      dm clone: call kmem_cache_destroy() in dm_clone_init() error path
      dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path
      dm ioctl: fix nested locking in table_clear() to remove deadlock concern

Mikulas Patocka (1):
      dm flakey: fix a crash with invalid table line

Ming Lei (1):
      nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage"

Ming Qian (1):
      media: amphion: decoder implement display delay enable

Ming Yen Hsieh (1):
      wifi: mt76: fix 6GHz high channel not be scanned

Miquel Raynal (1):
      of: Fix modalias string generation

Mohammad Rafi Shaik (1):
      clk: qcom: lpassaudiocc-sc7280: Add required gdsc power domain clks in lpass_cc_sc7280_desc

Moshe Shemesh (2):
      Revert "net/mlx5: Remove "recovery" arg from mlx5_load_one() function"
      net/mlx5: Use recovery timeout on sync reset flow

Moudy Ho (1):
      media: platform: mtk-mdp3: fix potential frame size overflow in mdp_try_fmt_mplane()

Mukesh Ojha (1):
      firmware: qcom_scm: Clear download bit during reboot

Muralidhara M K (1):
      x86/MCE/AMD: Use an u64 for bank_map

Mårten Lindahl (2):
      ubifs: Free memory for tmpfile name
      ubifs: Fix memory leak in do_rename

Namjae Jeon (6):
      ksmbd: fix racy issue under cocurrent smb2 tree disconnect
      ksmbd: call rcu_barrier() in ksmbd_server_exit()
      ksmbd: fix NULL pointer dereference in smb2_get_info_filesystem()
      ksmbd: fix memleak in session setup
      ksmbd: not allow guest user on multichannel
      ksmbd: fix deadlock in ksmbd_find_crypto_ctx()

Nasir Osman (1):
      drm/amd/display: Remove stutter only configurations

Natalia Petrova (1):
      RDMA/rdmavt: Delete unnecessary NULL check

Nathan Lynch (1):
      powerpc/rtas: use memmove for potentially overlapping buffer copy

Neil Armstrong (1):
      arm64: dts: qcom: sm8450: fix pcie1 gpios properties name

Nicholas Piggin (1):
      powerpc/boot: Fix boot wrapper code generation with CONFIG_POWER10_CPU

Nitin Yadav (1):
      arm64: dts: ti: k3-am62-main: Fix GPIO numbers in DT

Nuno Sá (1):
      staging: iio: resolver: ads1210: fix config mode

Oliver Upton (5):
      KVM: arm64: Avoid vcpu->mutex v. kvm->lock inversion in CPU_ON
      KVM: arm64: Avoid lock inversion when setting the VM register width
      KVM: arm64: Use config_lock to protect data ordered against KVM_RUN
      KVM: arm64: Use config_lock to protect vgic state
      KVM: arm64: vgic: Don't acquire its_lock before config_lock

Ondrej Mosnacek (2):
      tracing: Fix permissions for the buffer_percent file
      selinux: fix Makefile dependencies of flask.h

Orlando Chamberlain (1):
      drm/amdgpu: register a vga_switcheroo client for MacBooks with apple-gmux

P Praneesh (1):
      wifi: ath11k: fix writing to unintended memory region

Pablo Neira Ayuso (2):
      netfilter: conntrack: restore IPS_CONFIRMED out of nf_conntrack_hash_check_insert()
      netfilter: nf_tables: deactivate anonymous set from preparation phase

Patrick Kelsey (2):
      IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order
      IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec user SDMA requests

Patrik Dahlström (1):
      iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Paul Moore (1):
      selinux: ensure av_permissions.h is built when needed

Paulo Alcantara (2):
      cifs: fix potential use-after-free bugs in TCP_Server_Info::hostname
      cifs: protect session status check in smb2_reconnect()

Pavel Begunkov (1):
      io_uring/rsrc: use nospec'ed indexes

Peng Fan (3):
      clk: imx: fracn-gppll: fix the rate table
      clk: imx: fracn-gppll: disable hardware select control
      clk: imx: imx8ulp: Fix XBAR_DIVBUS and AD_SLOW clock parents

Peng Liu (1):
      scripts/gdb: fix lx-timerlist for Python3

Petr Mladek (1):
      workqueue: Fix hung time report of worker pools

Petr Vorel (2):
      arm64: dts: qcom: msm8994-angler: Fix cont_splash_mem mapping
      arm64: dts: qcom: msm8994-angler: removed clash with smem_region

Philipp Hortmann (1):
      staging: rtl8192e: Fix W_DISABLE# does not work after stop/start

Phong Hoang (1):
      pinctrl: renesas: r8a779f0: Fix tsn1_avtp_pps pin group

Pierre Gondois (1):
      cacheinfo: Check sib_leaf in cache_leaves_are_shared()

Pierre-Louis Bossart (2):
      soundwire: cadence: rename sdw_cdns_dai_dma_data as sdw_cdns_dai_runtime
      soundwire: intel: don't save hw_params for use in prepare

Pin-yen Lin (1):
      media: mediatek: vcodec: Use 4K frame size when supported by stateful decoder

Ping-Ke Shih (1):
      wifi: rtw89: fix potential race condition between napi_init and napi_enable

Prashanth K (1):
      usb: dwc3: gadget: Change condition for processing suspend event

Qilin Tan (1):
      f2fs: fix iostat lock protection

Qinrun Dai (1):
      clocksource/drivers/davinci: Fix memory leak in davinci_timer_register when init fails

Qiuxu Zhuo (1):
      EDAC/skx: Fix overflows on the DRAM row address mapping arrays

Qu Wenruo (1):
      btrfs: scrub: reject unsupported scrub flags

Quan Zhou (3):
      wifi: mt76: mt7921e: fix probe timeout after reboot
      wifi: mt76: mt7921e: improve reliability of dma reset
      wifi: mt76: mt7921e: stop chip reset worker in unregister hook

Quentin Monnet (1):
      bpftool: Fix bug for long instructions in program CFG dumps

Quentin Schulz (1):
      clk: rockchip: rk3399: allow clk_cifout to force clk_cifout_src to reparent

Rae Moar (2):
      kunit: improve KTAP compliance of KUnit test output
      kunit: fix bug in the order of lines in debugfs logs

Rafael J. Wysocki (1):
      ACPI: bus: Ensure that notify handlers are not running after removal

Rafał Miłecki (3):
      arm64: dts: broadcom: bcmbca: bcm4908: fix NAND interrupt name
      arm64: dts: broadcom: bcmbca: bcm4908: fix LED nodenames
      arm64: dts: broadcom: bcmbca: bcm4908: fix procmon nodename

Randy Dunlap (10):
      IMA: allow/fix UML builds
      ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead of depending on it
      linux/vt_buffer.h: allow either builtin or modular for macros
      ia64: mm/contig: fix section mismatch warning/error
      ia64: salinfo: placate defined-but-not-used warning
      powerpc/mpc512x: fix resource printk format warning
      powerpc/wii: fix resource printk format warnings
      powerpc/sysdev/tsi108: fix resource printk format warnings
      macintosh: via-pmu-led: requires ATA to be set
      leds: TI_LMU_COMMON: select REGMAP instead of depending on it

Ranjan Kumar (1):
      scsi: mpi3mr: Handle soft reset in progress fault code (0xF002)

Reid Tonking (1):
      i2c: omap: Fix standard mode false ACK readings

Ricardo Ribalda (1):
      media: ov8856: Do not check for for module version

Rob Clark (1):
      drm/rockchip: Drop unbalanced obj unref

Roberto Sassu (1):
      reiserfs: Add security prefix to xattr name in reiserfs_security_write()

Robin Murphy (1):
      perf/arm-cmn: Fix port detection for CMN-700

Roger Pau Monne (1):
      ACPI: processor: Fix evaluating _PDC method when running as Xen dom0

Roi Dayan (1):
      net/mlx5e: Fix error flow in representor failing to add vport rx rule

Russell King (Oracle) (2):
      net: pcs: xpcs: remove double-read of link state when using AN
      net: dsa: qca8k: remove assignment of an_enabled in pcs_get_state()

Ryder Lee (1):
      wifi: mt76: connac: fix txd multicast rate setting

Ryusuke Konishi (2):
      nilfs2: do not write dirty data after degenerating to read-only
      nilfs2: fix infinite loop in nilfs_mdt_get_block()

Sakari Ailus (1):
      media: v4l: async: Return async sub-devices to subnotifier list

Sanjay Chandrashekara (1):
      cpufreq: use correct unit when verify cur freq

Saravanan Vajravel (1):
      RDMA/srpt: Add a check for valid 'mad_agent' pointer

Saurabh Sengar (1):
      x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

Schspa Shi (1):
      sched/rt: Fix bad task migration for rt tasks

Sean Anderson (1):
      net: sunhme: Fix uninitialized return code

Sean Christopherson (1):
      KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not intercepted

Sean Wang (1):
      mt76: mt7921: fix kernel panic by accessing unallocated eeprom.data

Sebastian Andrzej Siewior (1):
      tick/common: Align tick period with the HZ tick.

Sebastian Reichel (3):
      net: ethernet: stmmac: dwmac-rk: rework optional clock handling
      net: ethernet: stmmac: dwmac-rk: fix optional phy regulator handling
      power: supply: generic-adc-battery: fix unit scaling

Shashank Gupta (1):
      crypto: qat - fix concurrency issue when device state changes

Shengjiu Wang (1):
      ASoC: soc-pcm: fix hw->formats cleared by soc_pcm_hw_init() for dpcm

Shenwei Wang (1):
      tty: serial: fsl_lpuart: adjust buffer length to the intended size

Shuchang Li (1):
      scsi: lpfc: Fix ioremap issues in lpfc_sli4_pci_mem_setup()

Shunsuke Mie (2):
      dmaengine: dw-edma: Fix to change for continuous transfer
      dmaengine: dw-edma: Fix to enable to issue dma request on DMA processing

Shyam Sundar S K (3):
      platform/x86/amd/pmf: Move out of BIOS SMN pair for driver probe
      platform/x86/amd: pmc: Utilize SMN index 0 for driver probe
      platform/x86/amd: pmc: Move out of BIOS SMN pair for STB init

Siddharth Vadapalli (1):
      phy: ti: j721e-wiz: Fix unreachable code in wiz_mode_select()

Simon Horman (1):
      net: qrtr: correct types of trace event parameters

Song Liu (2):
      selftests/bpf: Use read_perf_max_sample_freq() in perf_event_stackmap
      selftests/bpf: Fix leaked bpf_link in get_stackid_cannot_attach

Song Shuai (1):
      riscv: mm: remove redundant parameter of create_fdt_early_page_table

Srinivasa Rao Mandadapu (1):
      clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration

Stafford Horne (1):
      openrisc: Properly store r31 to pt_regs on unhandled exceptions

Stanislav Fomichev (1):
      bpf: Don't EFAULT for getsockopt with optval=NULL

Stefan Haberland (1):
      s390/dasd: fix hanging blockdevice after request requeue

Steven Rostedt (Google) (1):
      tracing: Error if a trace event has an array for a __field()

Suman Anna (1):
      crypto: sa2ul - Select CRYPTO_DES

Sumit Garg (1):
      arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

Suzuki K Poulose (1):
      coresight: etm_pmu: Set the module field

Syed Saba Kareem (1):
      ASoC: amd: ps: update the acp clock source.

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

Tim Huang (1):
      drm/amd/pm: re-enable the gfx imu when smu resume

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

Tudor Ambarus (1):
      mtd: spi-nor: core: Update flash's current address mode when changing address mode

Tze-nan Wu (1):
      ring-buffer: Ensure proper resetting of atomic variables in ring_buffer_reset_online_cpus

Tzung-Bi Shih (1):
      netfilter: conntrack: fix wrong ct->timeout value

Uros Bizjak (1):
      x86/apic: Fix atomic update of offset in reserve_eilvt_offset()

Uwe Kleine-König (4):
      spi: atmel-quadspi: Don't leak clk enable count in pm resume
      spi: atmel-quadspi: Free resources even if runtime resume failed in .remove()
      spi: imx: Don't skip cleanup in remove's error path
      spi: qup: Don't skip cleanup in remove's error path

Vadim Fedorenko (1):
      vlan: partially enable SIOCSHWTSTAMP in container

Vignesh Raghavendra (2):
      arm64: dts: ti: k3-am625: Correct L2 cache size to 512KB
      arm64: dts: ti: k3-am62a7: Correct L2 cache size to 512KB

Ville Syrjälä (1):
      drm/i915: Make intel_get_crtc_new_encoder() less oopsy

Vincent Guittot (1):
      arm64: dts: qcom: sdm845: correct dynamic power coefficients

Vinod Polimera (1):
      drm/msm/disp/dpu: check for crtc enable rather than crtc active to release shared resources

Vitaly Rodionov (1):
      ALSA: hda/realtek: Add quirk for ThinkPad P1 Gen 6

Vlad Buslov (1):
      net/mlx5e: Don't clone flow post action attributes second time

Vladimir Oltean (1):
      asm-generic/io.h: suppress endianness warnings for readq() and writeq()

Wang YanQing (1):
      ubi: Fix return value overwrite issue in try_write_vid_and_data()

Wei Chen (3):
      media: hi846: Fix memleak in hi846_init_controls()
      wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_rfreg()
      wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_reg()

Wesley Cheng (1):
      usb: dwc3: gadget: Stall and restart EP0 if host is unresponsive

William Breathitt Gray (2):
      iio: addac: stx104: Fix race condition when converting analog-to-digital
      iio: addac: stx104: Fix race condition for stx104_write_raw()

Wolfram Sang (1):
      usb: host: xhci-rcar: remove leftover quirk handling

Xin Liu (1):
      bpf, sockmap: fix deadlocks in the sockhash and sockmap

Xingui Yang (2):
      scsi: hisi_sas: Handle NCQ error when IPTT is valid
      scsi: libsas: Grab the ATA port lock in sas_ata_device_link_abort()

Xinlei Lee (1):
      drm/mediatek: dp: Change the aux retries times when receiving AUX_DEFER

Xiubo Li (1):
      ceph: fix potential use-after-free bug when trimming caps

YAN SHI (1):
      regulator: stm32-pwr: fix of_iomap leak

Yan Wang (1):
      net: stmmac:fix system hang when setting up tag_8021q VLAN for DSA ports

Yang Jihong (1):
      perf/core: Fix hardlockup failure caused by perf throttle

Yang Yingliang (2):
      gpu: host1x: Fix potential double free if IOMMU is disabled
      gpu: host1x: Fix memory leak of device names

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

Yong Wu (1):
      iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN

Yonggil Song (1):
      f2fs: fix uninitialized skipped_gc_rwsem

Yu Kuai (4):
      md/raid10: fix leak of 'r10bio->remaining' for recovery
      md/raid10: fix memleak for 'conf->bio_split'
      md/raid10: fix memleak of md thread
      md/raid10: don't call bio_start_io_acct twice for bio which experienced read error

Yu Songping (1):
      swsmu/amdgpu_smu: Fix the wrong if-condition

Yunfei Dong (11):
      media: mediatek: vcodec: Make MM21 the default capture format
      media: mediatek: vcodec: Force capture queue format to MM21
      media: mediatek: vcodec: add params to record lat and core lat_buf count
      media: mediatek: vcodec: using each instance lat_buf count replace core ready list
      media: mediatek: vcodec: move lat_buf to the top of core list
      media: mediatek: vcodec: add core decode done event
      media: mediatek: vcodec: remove unused lat_buf
      media: mediatek: vcodec: making sure queue_work successfully
      media: mediatek: vcodec: change lat thread decode error condition
      media: mediatek: vcodec: fix decoder disable pm crash
      media: mediatek: vcodec: add remove function for decoder platform driver

Zeng Heng (1):
      fs/ntfs3: Fix slab-out-of-bounds read in hdr_delete_de()

Zhang Yuchen (1):
      ipmi: fix SSIF not responding under certain cond.

Zhang Zhengming (1):
      relayfs: fix out-of-bounds access in relay_file_read

ZhangPeng (1):
      fs/ntfs3: Fix OOB read in indx_insert_into_buffer

Zhaoyang Li (1):
      soc: bcm: brcmstb: biuctrl: fix of_iomap leak

Zheng Wang (5):
      media: cedrus: fix use after free bug in cedrus_remove due to race condition
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

syed saba kareem (1):
      ASoC: amd: fix ACP version typo mistake

