Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C10706828
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjEQMbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjEQMbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940996EB9;
        Wed, 17 May 2023 05:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09BD26469F;
        Wed, 17 May 2023 12:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DFEC433D2;
        Wed, 17 May 2023 12:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684326660;
        bh=0OzA6NG2PFaqEkQJBDc/DbDec8aCFSiOhnfTwVJXY4A=;
        h=From:To:Cc:Subject:Date:From;
        b=Mo3NtJPxerH4gNC55GFW+9e8guISiWxks65TvFYRxG2op4lZvV4BJ6azkBOWesi49
         PI7pTETLVJrLojdhQLrRRI/nMdTwDMSQ+qjEmi/BHHv+wyzfSse82JV4IX6d5TaosG
         B4FF54fDcsECan5+CelXTDB86/nutGXA1Pam8ddU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.3.3
Date:   Wed, 17 May 2023 14:30:56 +0200
Message-Id: <2023051756-earwig-fanning-64cf@gregkh>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.3.3 kernel.

All users of the 6.3 kernel series must upgrade.

The updated 6.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.3.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/perf/riscv,pmu.yaml                 |    1 
 Makefile                                                              |    2 
 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts                     |    2 
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts                     |    4 
 arch/arm/boot/dts/exynos4412-itop-elite.dts                           |    2 
 arch/arm/boot/dts/s5pv210.dtsi                                        |    2 
 arch/arm64/kernel/cpu-reset.S                                         |    2 
 arch/arm64/kernel/head.S                                              |    4 
 arch/arm64/kernel/sleep.S                                             |    2 
 arch/arm64/mm/proc.S                                                  |    6 
 arch/parisc/include/asm/pgtable.h                                     |    8 
 arch/riscv/kernel/Makefile                                            |    1 
 arch/riscv/mm/pageattr.c                                              |    8 
 arch/s390/boot/vmem.c                                                 |   27 
 arch/s390/include/asm/pgtable.h                                       |    2 
 arch/s390/kernel/uv.c                                                 |   32 
 arch/s390/kvm/pv.c                                                    |    5 
 arch/s390/mm/gmap.c                                                   |    7 
 arch/s390/mm/pageattr.c                                               |    2 
 arch/sh/Kconfig.debug                                                 |    2 
 arch/sh/kernel/head_32.S                                              |    6 
 arch/sh/kernel/nmi_debug.c                                            |    4 
 arch/sh/kernel/setup.c                                                |    4 
 arch/sh/math-emu/sfp-util.h                                           |    4 
 arch/x86/events/core.c                                                |    6 
 arch/x86/kernel/amd_nb.c                                              |    2 
 arch/x86/kvm/kvm_cache_regs.h                                         |    2 
 arch/x86/kvm/mmu.h                                                    |   26 
 arch/x86/kvm/mmu/mmu.c                                                |   46 
 arch/x86/kvm/mmu/paging_tmpl.h                                        |    2 
 arch/x86/kvm/pmu.c                                                    |    4 
 arch/x86/kvm/vmx/nested.c                                             |    4 
 arch/x86/kvm/vmx/vmx.c                                                |    6 
 arch/x86/kvm/vmx/vmx.h                                                |   18 
 arch/x86/kvm/x86.c                                                    |   12 
 arch/x86/lib/clear_page_64.S                                          |    2 
 arch/x86/lib/retpoline.S                                              |    4 
 block/blk-cgroup.c                                                    |    3 
 crypto/algapi.c                                                       |    3 
 crypto/crypto_engine.c                                                |    6 
 drivers/block/ublk_drv.c                                              |   31 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c                   |    2 
 drivers/crypto/ccp/psp-dev.c                                          |    6 
 drivers/edac/qcom_edac.c                                              |   50 
 drivers/firewire/net.c                                                |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                            |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                               |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c                             |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                |   46 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                 |    3 
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c                                |    1 
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c                                |    1 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                                 |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                |    1 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                                |    8 
 drivers/gpu/drm/amd/amdgpu/soc21.c                                    |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                     |   27 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c             |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c           |   17 
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c                      |    4 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c          |    5 
 drivers/gpu/drm/amd/display/dc/core/dc.c                              |  156 --
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c                 |   87 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                     |    3 
 drivers/gpu/drm/amd/display/dc/dc.h                                   |  554 +++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                          |  107 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                          |   14 
 drivers/gpu/drm/amd/display/dc/dc_types.h                             |  111 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c                         |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h                         |    5 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c           |    2 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c             |   18 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                    |    8 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c       |    1 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c                    |    2 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c                     |   13 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c      |    1 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |    2 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c                   |   23 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c                  |   10 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h                  |    2 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c                   |    1 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c               |    1 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hpo_dp_link_encoder.c      |    1 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c                    |    3 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c                 |   12 
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c               |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c                  |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c                  |   18 
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c        |    1 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c        |    1 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c                |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c      |    1 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c        |    6 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h        |    1 
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c                |   24 
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h                          |   25 
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h                     |   14 
 drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h                  |   52 
 drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h                |    1 
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h             |    4 
 drivers/gpu/drm/amd/display/dc/inc/link.h                             |    1 
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c         |   17 
 drivers/gpu/drm/amd/display/dc/link/link_detection.c                  |   99 +
 drivers/gpu/drm/amd/display/dc/link/link_factory.c                    |    9 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c          |    1 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c       |    1 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c |    1 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c                     |    3 
 drivers/gpu/drm/amd/display/include/link_service_types.h              |   26 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                                   |   25 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                              |    1 
 drivers/gpu/drm/i915/display/icl_dsi.c                                |    2 
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c                          |   11 
 drivers/gpu/drm/i915/display/intel_dsi_vbt.h                          |    1 
 drivers/gpu/drm/i915/display/skl_scaler.c                             |   17 
 drivers/gpu/drm/i915/display/vlv_dsi.c                                |   22 
 drivers/gpu/drm/i915/gt/intel_gt_regs.h                               |    4 
 drivers/gpu/drm/i915/gt/intel_workarounds.c                           |   33 
 drivers/gpu/drm/i915/gt/uc/intel_uc.c                                 |   42 
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c                              |  132 +-
 drivers/gpu/drm/i915/i915_pci.c                                       |    2 
 drivers/gpu/drm/i915/i915_reg.h                                       |    4 
 drivers/gpu/drm/i915/i915_reg_defs.h                                  |   29 
 drivers/gpu/drm/msm/adreno/adreno_device.c                            |   16 
 drivers/gpu/drm/msm/msm_drv.c                                         |   52 
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c                      |    2 
 drivers/hid/wacom_wac.c                                               |   38 
 drivers/hid/wacom_wac.h                                               |    1 
 drivers/i2c/busses/i2c-gxp.c                                          |    2 
 drivers/i2c/busses/i2c-tegra.c                                        |   40 
 drivers/infiniband/sw/rxe/rxe.c                                       |    8 
 drivers/infiniband/sw/rxe/rxe.h                                       |   45 
 drivers/infiniband/sw/rxe/rxe_cq.c                                    |    6 
 drivers/infiniband/sw/rxe/rxe_icrc.c                                  |    4 
 drivers/infiniband/sw/rxe/rxe_mmap.c                                  |    6 
 drivers/infiniband/sw/rxe/rxe_net.c                                   |    4 
 drivers/infiniband/sw/rxe/rxe_qp.c                                    |   16 
 drivers/infiniband/sw/rxe/rxe_srq.c                                   |    6 
 drivers/infiniband/sw/rxe/rxe_verbs.c                                 |    2 
 drivers/irqchip/irq-loongson-eiointc.c                                |   32 
 drivers/irqchip/irq-loongson-pch-pic.c                                |    6 
 drivers/mtd/spi-nor/core.c                                            |    6 
 drivers/mtd/spi-nor/core.h                                            |    4 
 drivers/mtd/spi-nor/debugfs.c                                         |    2 
 drivers/mtd/spi-nor/spansion.c                                        |   20 
 drivers/net/dsa/mt7530.c                                              |  113 +-
 drivers/net/dsa/mv88e6xxx/chip.c                                      |    1 
 drivers/net/ethernet/freescale/enetc/enetc_qos.c                      |    2 
 drivers/net/ethernet/freescale/fec_main.c                             |   13 
 drivers/net/ethernet/intel/ice/ice_tc_lib.c                           |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c                          |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                         |    6 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                       |    8 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c                      |    5 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h                      |   19 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                       |  110 -
 drivers/net/ethernet/marvell/octeontx2/af/mcs.h                       |   26 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_cnf10kb.c               |   63 +
 drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h                   |    6 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c                |   37 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                       |   49 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                       |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                   |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c                 |   13 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c               |    5 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c                |   26 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h                |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c              |  125 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h              |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c             |   48 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h              |    6 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                  |   14 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                  |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c                  |    2 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                           |  106 -
 drivers/net/ethernet/mediatek/mtk_eth_soc.h                           |    1 
 drivers/net/ethernet/pensando/ionic/ionic_devlink.c                   |    2 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c                   |    2 
 drivers/net/ethernet/sfc/mcdi_port_common.c                           |   11 
 drivers/net/usb/r8152.c                                               |   85 +
 drivers/net/virtio_net.c                                              |    2 
 drivers/platform/x86/hp/hp-wmi.c                                      |    1 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c |    6 
 drivers/platform/x86/thinkpad_acpi.c                                  |   24 
 drivers/platform/x86/touchscreen_dmi.c                                |   41 
 drivers/remoteproc/imx_dsp_rproc.c                                    |   12 
 drivers/remoteproc/imx_rproc.c                                        |    7 
 drivers/remoteproc/rcar_rproc.c                                       |    9 
 drivers/remoteproc/st_remoteproc.c                                    |    5 
 drivers/remoteproc/stm32_rproc.c                                      |    6 
 drivers/scsi/qedi/qedi_main.c                                         |    3 
 drivers/soc/qcom/llcc-qcom.c                                          |   15 
 drivers/spi/spi-fsl-cpm.c                                             |   23 
 drivers/spi/spi-fsl-spi.c                                             |   49 
 drivers/ufs/core/ufs-mcq.c                                            |    6 
 drivers/usb/dwc3/gadget.c                                             |   59 -
 drivers/watchdog/dw_wdt.c                                             |    7 
 fs/afs/afs.h                                                          |    4 
 fs/afs/internal.h                                                     |    2 
 fs/afs/rxrpc.c                                                        |    8 
 fs/btrfs/backref.c                                                    |   19 
 fs/btrfs/backref.h                                                    |    6 
 fs/btrfs/block-rsv.c                                                  |    3 
 fs/btrfs/ctree.c                                                      |   32 
 fs/btrfs/disk-io.c                                                    |   25 
 fs/btrfs/file-item.c                                                  |    5 
 fs/btrfs/free-space-cache.c                                           |    7 
 fs/btrfs/free-space-tree.c                                            |   50 
 fs/btrfs/free-space-tree.h                                            |    3 
 fs/btrfs/inode.c                                                      |    3 
 fs/btrfs/ioctl.c                                                      |    4 
 fs/btrfs/print-tree.c                                                 |    6 
 fs/btrfs/relocation.c                                                 |    2 
 fs/btrfs/super.c                                                      |    6 
 fs/btrfs/zoned.c                                                      |   17 
 fs/cifs/cifsfs.c                                                      |   16 
 fs/cifs/connect.c                                                     |    7 
 fs/cifs/smb2ops.c                                                     |    2 
 fs/ext4/balloc.c                                                      |   25 
 fs/ext4/ext4.h                                                        |   24 
 fs/ext4/extents_status.c                                              |   30 
 fs/ext4/hash.c                                                        |    6 
 fs/ext4/inline.c                                                      |   17 
 fs/ext4/inode.c                                                       |   20 
 fs/ext4/mballoc.c                                                     |    6 
 fs/ext4/migrate.c                                                     |   11 
 fs/ext4/mmp.c                                                         |   30 
 fs/ext4/namei.c                                                       |   53 
 fs/ext4/super.c                                                       |   19 
 fs/ext4/xattr.c                                                       |    5 
 fs/f2fs/extent_cache.c                                                |  241 +---
 fs/f2fs/f2fs.h                                                        |   38 
 fs/f2fs/gc.c                                                          |  139 +-
 fs/f2fs/gc.h                                                          |   14 
 fs/f2fs/namei.c                                                       |   16 
 fs/f2fs/segment.c                                                     |  251 ++--
 fs/fs-writeback.c                                                     |    2 
 fs/notify/inotify/inotify_fsnotify.c                                  |   11 
 fs/ntfs3/bitmap.c                                                     |    3 
 fs/ntfs3/frecord.c                                                    |    2 
 fs/ntfs3/fsntfs.c                                                     |    6 
 fs/ntfs3/namei.c                                                      |   10 
 fs/ntfs3/ntfs.h                                                       |    3 
 fs/proc/proc_sysctl.c                                                 |   42 
 include/drm/display/drm_dp.h                                          |    1 
 include/drm/display/drm_dp_helper.h                                   |    5 
 include/linux/i2c.h                                                   |    4 
 include/linux/pci_ids.h                                               |    1 
 include/net/af_rxrpc.h                                                |   21 
 include/net/netfilter/nf_tables.h                                     |    6 
 kernel/locking/rwsem.c                                                |    8 
 net/core/skbuff.c                                                     |   20 
 net/ethtool/ioctl.c                                                   |    2 
 net/ipv6/sit.c                                                        |    8 
 net/ipv6/tcp_ipv6.c                                                   |    2 
 net/ncsi/ncsi-aen.c                                                   |    1 
 net/netfilter/nf_tables_api.c                                         |  282 +++--
 net/netfilter/nft_ct_fast.c                                           |   14 
 net/packet/af_packet.c                                                |    2 
 net/rxrpc/af_rxrpc.c                                                  |    3 
 net/rxrpc/ar-internal.h                                               |    1 
 net/rxrpc/call_object.c                                               |    9 
 net/rxrpc/sendmsg.c                                                   |   22 
 net/sched/act_mirred.c                                                |    2 
 net/sched/cls_api.c                                                   |    1 
 net/sched/cls_flower.c                                                |    9 
 sound/soc/intel/common/soc-acpi-intel-byt-match.c                     |    2 
 sound/usb/caiaq/input.c                                               |    1 
 tools/perf/Build                                                      |    2 
 tools/perf/Makefile.perf                                              |    7 
 tools/perf/builtin-ftrace.c                                           |    6 
 tools/perf/builtin-record.c                                           |    2 
 tools/perf/builtin-script.c                                           |    2 
 tools/perf/builtin-stat.c                                             |    4 
 tools/perf/pmu-events/arch/powerpc/power9/other.json                  |    4 
 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json               |    2 
 tools/perf/pmu-events/arch/s390/cf_z16/extended.json                  |   10 
 tools/perf/pmu-events/empty-pmu-events.c                              |    6 
 tools/perf/scripts/Build                                              |    4 
 tools/perf/scripts/python/Perf-Trace-Util/Build                       |    2 
 tools/perf/scripts/python/Perf-Trace-Util/Context.c                   |    4 
 tools/perf/scripts/python/intel-pt-events.py                          |    2 
 tools/perf/tests/attr/base-record                                     |    2 
 tools/perf/tests/attr/base-stat                                       |    2 
 tools/perf/tests/attr/system-wide-dummy                               |    2 
 tools/perf/tests/make                                                 |    5 
 tools/perf/tests/shell/record_offcpu.sh                               |    2 
 tools/perf/util/Build                                                 |    2 
 tools/perf/util/bpf_skel/lock_contention.bpf.c                        |    8 
 tools/perf/util/cs-etm.c                                              |   30 
 tools/perf/util/evsel.h                                               |    5 
 tools/perf/util/pmu.c                                                 |    2 
 tools/perf/util/scripting-engines/Build                               |    2 
 tools/perf/util/scripting-engines/trace-event-python.c                |   75 -
 tools/perf/util/sort.c                                                |   10 
 tools/perf/util/symbol-elf.c                                          |   12 
 tools/perf/util/trace-event-scripting.c                               |    9 
 tools/perf/util/tracepoint.c                                          |    1 
 tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh               |   10 
 tools/testing/selftests/netfilter/Makefile                            |    7 
 302 files changed, 3852 insertions(+), 1924 deletions(-)

Adrian Hunter (3):
      perf script: Fix Python support when no libtraceevent
      perf symbols: Fix use-after-free in get_plt_got_name()
      perf symbols: Fix unaligned access in get_x86_64_plt_disp()

Akhil R (1):
      i2c: tegra: Fix PEC support for SMBUS block read

Alice Chao (1):
      scsi: ufs: core: mcq: Fix &hwq->cq_lock deadlock issue

Alvin Lee (1):
      drm/amd/display: Enforce 60us prefetch for 200Mhz DCFCLK modes

Anastasia Belova (1):
      btrfs: print-tree: parent bytenr must be aligned to sector size

Andrea Mayer (1):
      selftests: srv6: make srv6_end_dt46_l3vpn_test more robust

Andrey Avdeev (1):
      platform/x86: touchscreen_dmi: Add info for the Dexp Ursus KX210i

Andy Moreton (1):
      sfc: Fix module EEPROM reporting for QSFP modules

Angelo Dureghello (1):
      net: dsa: mv88e6xxx: add mv88e6321 rsvd2cpu

Antoine Tenart (1):
      net: ipv6: fix skb hash for some RST packets

Arnaldo Carvalho de Melo (1):
      perf pmu: zfree() expects a pointer to a pointer to zero it after freeing its contents

Arnd Bergmann (1):
      i2c: gxp: fix build failure without CONFIG_I2C_SLAVE

Arınç ÜNAL (2):
      net: dsa: mt7530: fix corrupt frames using trgmii on 40 MHz XTAL MT7621
      net: dsa: mt7530: fix network connectivity with multiple CPU ports

Aurabindo Pillai (4):
      drm/amd/display: Fixes for dcn32_clk_mgr implementation
      drm/amd/display: Do not clear GPINT register when releasing DMUB from reset
      drm/amd/display: Update bounding box values for DCN321
      drm/amd/display: Fix hang when skipping modeset

Baokun Li (1):
      ext4: check iomap type only if ext4_iomap_begin() does not fail

Bob Pearson (2):
      RDMA/rxe: Change rxe_dbg to rxe_dbg_dev
      RDMA/rxe: Extend dbg log messages to err and info

Boris Burkov (1):
      btrfs: fix encoded write i_size corruption with no-holes

Borislav Petkov (AMD) (1):
      x86/retbleed: Fix return thunk alignment

Chaitanya Kumar Borah (1):
      drm/i915/color: Fix typo for Plane CSC indexes

Chia-I Wu (1):
      drm/amdgpu: add a missing lock for AMDGPU_SCHED

Christoph Hellwig (1):
      btrfs: zero the buffer before marking it dirty in btrfs_redirty_list_add

Christophe JAILLET (2):
      watchdog: dw_wdt: Fix the error handling path of dw_wdt_drv_probe()
      crypto: sun8i-ss - Fix a test in sun8i_ss_setup_ivs()

Christophe Leroy (2):
      spi: fsl-spi: Re-organise transfer bits_per_word adaptation
      spi: fsl-cpm: Use 16 bit mode for large transfers with even size

Claudio Imbrenda (2):
      KVM: s390: pv: fix asynchronous teardown for small VMs
      KVM: s390: fix race in gmap_make_secure()

Cong Wang (1):
      sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()

Conor Dooley (1):
      dt-bindings: perf: riscv,pmu: fix property dependencies

Cosmo Chou (1):
      net/ncsi: clear Tx enable mode when handling a Config required AEN

Cruise Hung (1):
      drm/amd/display: Reset OUTBOX0 r/w pointer on DMUB reset

Daniel Golle (1):
      net: dsa: mt7530: split-off common parts from mt7531_setup

David Howells (4):
      rxrpc: Fix potential data race in rxrpc_wait_to_be_connected()
      rxrpc: Fix hard call timeout units
      rxrpc: Make it so that a waiting process can be aborted
      rxrpc: Fix timeout of a call that hasn't yet been granted a channel

Dmitrii Dolgov (1):
      perf stat: Separate bperf from bpf_profiler

Eric Dumazet (1):
      tcp: fix skb_copy_ubufs() vs BIG TCP

Fae (1):
      platform/x86: hp-wmi: add micmute to hp_wmi_keymap struct

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: drop generic vlan rx offload, only use DSA untagging

Filipe Manana (3):
      btrfs: fix btrfs_prev_leaf() to not return the same key twice
      btrfs: fix space cache inconsistency after error loading it from disk
      btrfs: fix backref walking not returning all inode refs

Florian Westphal (1):
      netfilter: nf_tables: fix ct untracked match breakage

Francesco Dolcini (1):
      drm/bridge: lt8912b: Fix DSI Video Mode

Geetha sowjanya (4):
      octeonxt2-af: mcs: Fix per port bypass config
      octeontx2-af: mcs: Config parser to skip 8B header
      octeontx2-af: mcs: Fix MCS block interrupt
      octeontx2-af: Secure APR table update with the lock

Greg Kroah-Hartman (1):
      Linux 6.3.3

Guchun Chen (5):
      drm/amdgpu: drop redundant sched job cleanup when cs is aborted
      drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling legacy gfx ras
      drm/amd/pm: parse pp_handle under appropriate conditions
      drm/amdgpu: disable sdma ecc irq only when sdma RAS is enabled in suspend
      drm/amd/pm: avoid potential UBSAN issue on legacy asics

Guo Ren (1):
      riscv: compat_syscall_table: Fixup compile warning

Hamza Mahfooz (2):
      drm/amd/display: fix flickering caused by S/G mode
      drm/amdgpu: fix an amdgpu_irq_put() issue in gmc_v9_0_hw_fini()

Hans de Goede (3):
      ASoC: Intel: soc-acpi-byt: Fix "WM510205" match no longer working
      platform/x86: touchscreen_dmi: Add upside-down quirk for GDIX1002 ts on the Juno Tablet
      drm/i915/dsi: Use unconditional msleep() instead of intel_dsi_msleep()

Haridhar Kalvala (1):
      drm/i915/mtl: Add Wa_14017856879

Hariprasad Kelam (1):
      octeontx2-af: Add validation for lmac type

Hayes Wang (4):
      r8152: fix flow control issue of RTL8156A
      r8152: fix the poor throughput for 2.5G devices
      r8152: move setting r8153b_rx_agg_chg_indicate()
      r8152: fix the autosuspend doesn't work

Heiko Carstens (2):
      s390/mm: rename POPULATE_ONE2ONE to POPULATE_DIRECT
      s390/mm: fix direct map accounting

Helge Deller (1):
      parisc: Fix encoding of swp_entry due to added SWP_EXCLUSIVE flag

Hersen Wu (2):
      drm/amd/display: Return error code on DSC atomic check failure
      drm/amd/display: fix access hdcp_workqueue assert

Horatio Zhang (3):
      drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v10_0_hw_fini
      drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v11_0_hw_fini
      drm/amdgpu: drop gfx_v11_0_cp_ecc_error_irq_funcs

Ian Rogers (3):
      perf lock contention: Fix compiler builtin detection
      perf build: Support python/perf.so testing
      perf test: Fix "PMU event table sanity" for NO_JEVENTS=1

Ido Schimmel (1):
      ethtool: Fix uninitialized number of lanes

Ivan Vecera (1):
      net/sched: flower: Fix wrong handle assignment during filter change

Jaegeuk Kim (5):
      f2fs: factor out victim_entry usage from general rb_tree use
      f2fs: factor out discard_cmd usage from general rb_tree use
      f2fs: remove entire rb_entry sharing
      f2fs: fix null pointer panic in tracepoint in __replace_atomic_write_block
      f2fs: fix potential corruption when moving a directory

James Clark (1):
      perf cs-etm: Fix timeless decode mode detection

James Cowgill (1):
      drm/panel: otm8009a: Set backlight parent to panel device

Jan Kara (4):
      inotify: Avoid reporting event with invalid wd
      ext4: fix data races when using cached status extents
      ext4: avoid deadlock in fs reclaim with page writeback
      ext4: fix lockdep warning when enabling MMP

Jani Nikula (1):
      drm/dsc: fix drm_edp_dsc_sink_output_bpp() DPCD high byte usage

Jeremi Piotrowski (1):
      crypto: ccp - Clear PSP interrupt status register before calling handler

Jeremy Sowden (1):
      selftests: netfilter: fix libmnl pkg-config usage

Jianmin Lv (5):
      irqchip/loongson-pch-pic: Fix pch_pic_acpi_init calling
      irqchip/loongson-pch-pic: Fix registration of syscore_ops
      irqchip/loongson-eiointc: Fix returned value on parsing MADT
      irqchip/loongson-eiointc: Fix incorrect use of acpi_get_vec_parent
      irqchip/loongson-eiointc: Fix registration of syscore_ops

Johan Hovold (8):
      USB: dwc3: gadget: drop dead hibernation code
      drm/msm/adreno: fix runtime PM imbalance at gpu load
      drm/msm: fix NULL-deref on snapshot tear down
      drm/msm: fix NULL-deref on irq uninstall
      drm/msm: fix drm device leak on bind errors
      drm/msm: fix vram leak on bind errors
      drm/msm: fix missing wq allocation error handling
      drm/msm: fix workqueue leak on bind errors

John Harrison (2):
      drm/i915/guc: More debug print updates - UC firmware
      drm/i915/guc: Actually return an error if GuC version range check fails

John Hickey (1):
      ixgbe: Fix panic during XDP_TX with > 64 CPUs

John Stultz (1):
      locking/rwsem: Add __always_inline annotation to __down_read_common() and inlined callers

Josef Bacik (1):
      btrfs: don't free qgroup space unless specified

Kajol Jain (1):
      perf vendor events power9: Remove UTF-8 characters from JSON files

Kan Liang (1):
      perf record: Fix "read LOST count failed" msg with sample read

Konrad Dybcio (1):
      drm/msm/adreno: adreno_gpu: Use suspend() instead of idle() on load error

Konstantin Komarov (1):
      fs/ntfs3: Refactoring of various minor issues

Krzysztof Kozlowski (2):
      ARM: dts: exynos: fix WM8960 clock name in Itop Elite
      ARM: dts: s5pv210: correct MIPI CSIS clock name

Kuniyuki Iwashima (1):
      af_packet: Don't send zero-byte data in packet_sendmsg_spkt().

Leo Chen (2):
      drm/amd/display: Change default Z8 watermark values
      drm/amd/display: Lowering min Z8 residency time

Lin.Cao (1):
      drm/amdgpu: Fix vram recover doesn't work after whole GPU reset (v2)

Linus Torvalds (1):
      x86: fix clear_user_rep_good() exception handling annotation

Lionel Landwerlin (1):
      drm/i915: disable sampler indirect state in bindless heap

Lucas De Marchi (1):
      drm/i915: Add _PICK_EVEN_2RANGES()

Luis Chamberlain (3):
      proc_sysctl: update docs for __register_sysctl_table()
      proc_sysctl: enhance documentation
      sysctl: clarify register_sysctl_init() base directory order

Manivannan Sadhasivam (2):
      qcom: llcc/edac: Support polling mode for ECC handling
      soc: qcom: llcc: Do not create EDAC platform device on SDM845

Mario Limonciello (1):
      x86/amd_nb: Add PCI ID for family 19h model 78h

Mark Pearson (2):
      platform/x86: thinkpad_acpi: Fix platform profiles on T490
      platform/x86: thinkpad_acpi: Add profile force ability

Markus Elfring (1):
      perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Mathias Krause (3):
      KVM: x86: Do not unload MMU roots when only toggling CR0.WP with TDP enabled
      KVM: x86: Make use of kvm_read_cr*_bits() when testing bits
      KVM: VMX: Make CR0.WP a guest owned bit

Mathieu Poirier (5):
      remoteproc: stm32: Call of_node_put() on iteration error
      remoteproc: st: Call of_node_put() on iteration error
      remoteproc: imx_dsp_rproc: Call of_node_put() on iteration error
      remoteproc: imx_rproc: Call of_node_put() on iteration error
      remoteproc: rcar_rproc: Call of_node_put() on iteration error

Maxim Korotkov (1):
      writeback: fix call of incorrect macro

Michal Swiatkowski (1):
      ice: block LAN in case of VF to VF offload

Ming Lei (1):
      ublk: add timeout handler

Miquel Raynal (1):
      mtd: spi-nor: Add a RWW flag

Namhyung Kim (2):
      perf hist: Improve srcfile sort key performance (really)
      perf/x86: Fix missing sample size update on AMD BRS

Naohiro Aota (3):
      btrfs: zoned: fix wrong use of bitops API in btrfs_ensure_empty_zones
      btrfs: zoned: zone finish data relocation BG with last IO
      btrfs: zoned: fix full zone super block reading on ZNS

Neeraj Upadhyay (1):
      arm64: Fix label placement in record_mmu_state()

Nicholas Kazlauskas (4):
      drm/amd/display: Add NULL plane_state check for cursor disable logic
      drm/amd/display: Fix 4to1 MPC black screen with DPP RCO
      drm/amd/display: Add minimum Z8 residency debug option
      drm/amd/display: Update minimum stutter residency for DCN314 Z8

Olivier Bacon (1):
      crypto: engine - fix crypto_queue backlog handling

Pablo Neira Ayuso (4):
      netfilter: nf_tables: extended netlink error reporting for netdevice
      netfilter: nf_tables: rename function to destroy hook list
      netfilter: nf_tables: support for adding new devices to an existing netdev chain
      netfilter: nf_tables: hit ENOENT on unexisting chain/flowtable update with missing attributes

Paolo Bonzini (1):
      KVM: x86/mmu: Avoid indirect call for get_cr3

Patrice Duroux (1):
      perf tests record_offcpu.sh: Fix redirection of stderr to stdin

Pawel Witek (1):
      cifs: fix pcchunk length type in smb2_copychunk_range

Ping Cheng (2):
      HID: wacom: Set a default resolution for older tablets
      HID: wacom: insert timestamp to packed Bluetooth (BT) events

Qu Wenruo (2):
      btrfs: properly reject clear_cache and v1 cache for block-group-tree
      btrfs: make clear_cache mount option to rebuild FST without disabling it

Radhakrishna Sripada (2):
      drm/i915/mtl: Add the missing CPU transcoder mask in intel_device_info
      drm/i915/mtl: Add workarounds Wa_14017066071 and Wa_14017654203

Randy Dunlap (4):
      sh: math-emu: fix macro redefined warning
      sh: mcount.S: fix build error when PRINTK is not enabled
      sh: init: use OF_EARLY_FLATTREE for early init
      sh: nmi_debug: fix return value of __setup handler

Ratheesh Kannoth (6):
      octeontx2-af: Fix start and end bit for scan config
      octeontx2-af: Fix depth of cam and mem table.
      octeontx2-pf: Increase the size of dmac filter flows
      octeontx2-af: Update/Fix NPC field hash extract feature
      octeontx2-af: Fix issues with NPC field hash extract
      octeontx2-af: Skip PFs if not enabled

Robin Chen (1):
      drm/amd/display: hpd rx irq not working with eDP interface

Rodrigo Siqueira (1):
      drm/amd/display: Add missing WA and MCLK validation

Roman Lozko (1):
      perf scripts intel-pt-events.py: Fix IPC output for Python 2

Ruliang Lin (1):
      ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`

Saleemkhan Jamadar (1):
      drm/amdgpu/jpeg: Remove harvest checking for JPEG3

Samson Tam (1):
      drm/amd/display: filter out invalid bits in pipe_fuses

Sean Christopherson (1):
      KVM: x86/mmu: Refresh CR0.WP prior to checking for emulated permission faults

Shannon Nelson (2):
      ionic: remove noise from ethtool rxnfc error msg
      ionic: catch failure from devlink_alloc

Shenwei Wang (1):
      net: fec: correct the counting of XDP sent frames

Sia Jee Heng (1):
      RISC-V: mm: Enable huge page support to kernel_page_present() function

Srinivas Pandruvada (1):
      platform/x86/intel-uncore-freq: Return error on write frequency

Steve French (3):
      cifs: release leases for deferred close handles when freezing
      smb3: fix problem remounting a share after shutdown
      SMB3: force unmount was failing to close deferred close files

Subbaraya Sundeep (8):
      octeontx2-af: mcs: Write TCAM_DATA and TCAM_MASK registers at once
      octeontx2-pf: mcs: Fix NULL pointer dereferences
      octeontx2-pf: mcs: Match macsec ethertype along with DMAC
      octeontx2-pf: mcs: Clear stats before freeing resource
      octeontx2-pf: mcs: Fix shared counters logic
      octeontx2-pf: mcs: Do not reset PN while updating secy
      octeontx2-pf: Disable packet I/O for graceful exit
      octeontx2-vf: Detach LF resources on probe cleanup

Suman Ghosh (1):
      octeontx2-af: Update correct mask to filter IPv4 fragments

Takahiro Kuwano (2):
      mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s28hx SEMPER flash
      mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s25hx SEMPER flash

Takashi Sakamoto (1):
      firewire: net: fix unexpected release of object for asynchronous request packet

Tao Su (1):
      block: Skip destroyed blkg when restart in blkg_destroy_all()

Theodore Ts'o (7):
      ext4: improve error recovery code paths in __ext4_remount()
      ext4: improve error handling from ext4_dirhash()
      ext4: fix deadlock when converting an inline directory in nojournal mode
      ext4: add bounds checking in get_max_inline_xattr_value_size()
      ext4: bail out of ext4_xattr_ibody_get() fails for any reason
      ext4: remove a BUG_ON in ext4_mb_release_group_pa()
      ext4: fix invalid free tracking in ext4_xattr_move_to_block()

Thomas Richter (2):
      perf test: Fix wrong size expectation for 'Setup struct perf_event_attr'
      perf vendor events s390: Remove UTF-8 characters from JSON file

Tudor Ambarus (1):
      ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Victor Nogueira (1):
      net/sched: act_mirred: Add carrier check

Ville Syrjälä (1):
      drm/i915: Check pipe source size when using skl+ scalers

Vlad Buslov (4):
      net/sched: cls_api: remove block_cb from driver_list before freeing
      net/sched: flower: fix filter idr initialization
      net/sched: flower: fix error handler on replace
      Revert "net/sched: flower: Fix wrong handle assignment during filter change"

Wei Fang (1):
      net: enetc: check the index of the SFI rather than the handle

Wenjing Liu (1):
      drm/amd/display: merge dc_link.h into dc.h and dc_types.h

Wenliang Wang (1):
      virtio_net: suppress cpu stall when free_unused_bufs

Wesley Cheng (1):
      usb: dwc3: gadget: Execute gadget stop after halting the controller

Yang Jihong (3):
      perf ftrace: Make system wide the default target for latency subcommand
      perf symbols: Fix return incorrect build_id size in elf_read_build_id()
      perf tracepoint: Fix memory leak in is_valid_tracepoint()

Ye Bin (1):
      ext4: fix WARNING in mb_find_extent

Yifan Zhang (1):
      drm/amdgpu: change gfx 11.0.4 external_id range

Zev Weiss (2):
      ARM: dts: aspeed: asrock: Correct firmware flash SPI clocks
      ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED

ZhangPeng (1):
      fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()

Zheng Wang (1):
      scsi: qedi: Fix use after free bug in qedi_remove()

ndesaulniers@google.com (1):
      arm64: kernel: remove SHF_WRITE|SHF_EXECINSTR from .idmap.text

xiaoshoukui (1):
      btrfs: fix assertion of exclop condition when starting balance

