Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9211070677D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjEQMEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjEQMD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:03:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A045902F;
        Wed, 17 May 2023 05:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D80463B63;
        Wed, 17 May 2023 12:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C20C433D2;
        Wed, 17 May 2023 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324862;
        bh=Dr2TGP6dlQa12sGmqpugWyF76obDwZPjAPEjbmlKXyY=;
        h=From:To:Cc:Subject:Date:From;
        b=1xgZSDe/F6QFrWsjJ7Y7f9eMtY36I7L26VgGelcJr2HeXjQU+3gJd5BRG4j6zjXI9
         RE+K2wZx5QGtIw+ZLby5gP7t++u0AGNBsyMAfpqlIzcEp/fmC1J7epTIEpA11zxjqp
         o9lky/oTj1a8LRVOQuY59LxaKdZv7bGBNwrZlH6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.29
Date:   Wed, 17 May 2023 14:00:58 +0200
Message-Id: <2023051758-automaker-childhood-e428@gregkh>
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

I'm announcing the release of the 6.1.29 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                              |    2 
 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts                     |    2 
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts                     |    4 
 arch/arm/boot/dts/exynos4412-itop-elite.dts                           |    2 
 arch/arm/boot/dts/s5pv210.dtsi                                        |    2 
 arch/riscv/errata/sifive/errata.c                                     |    3 
 arch/riscv/errata/thead/errata.c                                      |    8 
 arch/riscv/kernel/Makefile                                            |    1 
 arch/riscv/kernel/cpufeature.c                                        |    6 
 arch/riscv/mm/pageattr.c                                              |    8 
 arch/s390/kernel/uv.c                                                 |   32 
 arch/sh/Kconfig.debug                                                 |    2 
 arch/sh/kernel/head_32.S                                              |    6 
 arch/sh/kernel/nmi_debug.c                                            |    4 
 arch/sh/kernel/setup.c                                                |    4 
 arch/sh/math-emu/sfp-util.h                                           |    4 
 arch/x86/events/intel/lbr.c                                           |    6 
 arch/x86/include/asm/perf_event.h                                     |    6 
 arch/x86/kernel/amd_nb.c                                              |    2 
 arch/x86/kvm/kvm_cache_regs.h                                         |    2 
 arch/x86/kvm/mmu.h                                                    |   26 
 arch/x86/kvm/mmu/mmu.c                                                |   46 
 arch/x86/kvm/mmu/paging_tmpl.h                                        |    2 
 arch/x86/kvm/pmu.c                                                    |    4 
 arch/x86/kvm/svm/svm.c                                                |    2 
 arch/x86/kvm/vmx/capabilities.h                                       |   24 
 arch/x86/kvm/vmx/nested.c                                             |    4 
 arch/x86/kvm/vmx/pmu_intel.c                                          |    2 
 arch/x86/kvm/vmx/vmx.c                                                |   42 
 arch/x86/kvm/vmx/vmx.h                                                |   18 
 arch/x86/kvm/x86.c                                                    |   12 
 arch/x86/kvm/x86.h                                                    |    1 
 arch/x86/lib/clear_page_64.S                                          |    2 
 arch/x86/lib/retpoline.S                                              |    4 
 block/blk-cgroup.c                                                    |    3 
 crypto/algapi.c                                                       |    3 
 crypto/crypto_engine.c                                                |   10 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c                   |    2 
 drivers/crypto/ccp/psp-dev.c                                          |    6 
 drivers/edac/qcom_edac.c                                              |   50 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                            |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                               |   59 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h                               |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c                             |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c                             |   36 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h                             |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                 |    3 
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c                                |    1 
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c                                |    1 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                                 |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                |    1 
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c                                |  111 -
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                                |  102 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                                |    8 
 drivers/gpu/drm/amd/amdgpu/soc21.c                                    |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                     |   28 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c           |    1 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c              |    4 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c            |   12 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c          |    5 
 drivers/gpu/drm/amd/display/dc/core/dc_link.c                         |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                     |    3 
 drivers/gpu/drm/amd/display/dc/dc.h                                   |    5 
 drivers/gpu/drm/amd/display/dc/dc_link.h                              |   14 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c             |   16 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                    |    8 
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c                 |    5 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c                 |   15 
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c               |   14 
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c               |   13 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c                     |   13 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c                 |    4 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c                   |   23 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c                  |   10 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h                  |    2 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c                   |    1 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c               |    6 
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c               |    4 
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c               |    4 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c                    |    1 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c                 |   12 
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c               |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c                  |   21 
 drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c                  |   20 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c                |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c                  |   17 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c        |    5 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h        |    1 
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c                |   24 
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h                          |   25 
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h             |    4 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c                     |    3 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                                   |   25 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                              |    1 
 drivers/gpu/drm/i915/display/icl_dsi.c                                |    2 
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c                          |   11 
 drivers/gpu/drm/i915/display/intel_dsi_vbt.h                          |    1 
 drivers/gpu/drm/i915/display/skl_scaler.c                             |   57 
 drivers/gpu/drm/i915/display/vlv_dsi.c                                |   22 
 drivers/gpu/drm/i915/i915_pci.c                                       |    2 
 drivers/gpu/drm/i915/i915_reg.h                                       |    4 
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c                                 |    3 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                 |   27 
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c                             |    4 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                 |   58 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                           |    3 
 drivers/gpu/drm/msm/adreno/adreno_device.c                            |   16 
 drivers/gpu/drm/msm/msm_drv.c                                         |   53 
 drivers/gpu/drm/msm/msm_drv.h                                         |    8 
 drivers/gpu/drm/msm/msm_gpu.c                                         |   31 
 drivers/gpu/drm/msm/msm_gpu.h                                         |   22 
 drivers/gpu/drm/msm/msm_ringbuffer.h                                  |   28 
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c                      |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                                   |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                                   |   96 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                                   |    5 
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                                   |   53 
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c                                  |   31 
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                                  |   26 
 drivers/hid/wacom_wac.c                                               |   38 
 drivers/hid/wacom_wac.h                                               |    1 
 drivers/i2c/busses/i2c-tegra.c                                        |   40 
 drivers/irqchip/irq-loongarch-cpu.c                                   |   30 
 drivers/irqchip/irq-loongson-eiointc.c                                |   62 
 drivers/irqchip/irq-loongson-pch-pic.c                                |   18 
 drivers/mailbox/zynqmp-ipi-mailbox.c                                  |   13 
 drivers/mtd/spi-nor/core.c                                            |   12 
 drivers/mtd/spi-nor/core.h                                            |    6 
 drivers/mtd/spi-nor/debugfs.c                                         |    2 
 drivers/mtd/spi-nor/issi.c                                            |    1 
 drivers/mtd/spi-nor/spansion.c                                        |   35 
 drivers/net/dsa/mt7530.c                                              |  113 -
 drivers/net/dsa/mv88e6xxx/chip.c                                      |    1 
 drivers/net/ethernet/freescale/enetc/enetc_qos.c                      |    2 
 drivers/net/ethernet/intel/ice/ice_tc_lib.c                           |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c                          |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                         |    6 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c                      |    5 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h                      |   33 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                       |  110 -
 drivers/net/ethernet/marvell/octeontx2/af/mcs.h                       |   26 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_cnf10kb.c               |   63 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h                   |    6 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c                |   37 
 drivers/net/ethernet/marvell/octeontx2/af/npc.h                       |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                       |   49 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                       |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                   |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c                 |   13 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c               |   11 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                   |   22 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c                |  169 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h                |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c              |  125 -
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h              |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c             |   48 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h              |    6 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c               |   27 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                  |   14 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c                  |    2 
 drivers/net/ethernet/pensando/ionic/ionic_devlink.c                   |    2 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c                   |    2 
 drivers/net/ethernet/sfc/mcdi_port_common.c                           |   11 
 drivers/net/usb/r8152.c                                               |   84 
 drivers/net/virtio_net.c                                              |    2 
 drivers/net/wireless/realtek/rtw88/rtw8821c.c                         |    2 
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
 drivers/usb/dwc3/gadget.c                                             |   59 
 drivers/watchdog/dw_wdt.c                                             |    7 
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
 fs/btrfs/super.c                                                      |    6 
 fs/btrfs/zoned.c                                                      |   17 
 fs/cifs/cifsfs.c                                                      |   16 
 fs/cifs/connect.c                                                     |    7 
 fs/cifs/smb2ops.c                                                     |    2 
 fs/ext4/balloc.c                                                      |   25 
 fs/ext4/extents_status.c                                              |   30 
 fs/ext4/hash.c                                                        |    6 
 fs/ext4/inline.c                                                      |   17 
 fs/ext4/inode.c                                                       |    2 
 fs/ext4/mballoc.c                                                     |    6 
 fs/ext4/mmp.c                                                         |   30 
 fs/ext4/namei.c                                                       |   53 
 fs/ext4/super.c                                                       |   19 
 fs/ext4/xattr.c                                                       |    5 
 fs/f2fs/data.c                                                        |   20 
 fs/f2fs/debug.c                                                       |   65 
 fs/f2fs/extent_cache.c                                                |  579 +++--
 fs/f2fs/f2fs.h                                                        |  213 --
 fs/f2fs/file.c                                                        |    8 
 fs/f2fs/gc.c                                                          |  143 -
 fs/f2fs/gc.h                                                          |   14 
 fs/f2fs/inode.c                                                       |   44 
 fs/f2fs/namei.c                                                       |   20 
 fs/f2fs/node.c                                                        |   10 
 fs/f2fs/node.h                                                        |    2 
 fs/f2fs/segment.c                                                     |   11 
 fs/f2fs/shrinker.c                                                    |   19 
 fs/f2fs/super.c                                                       |   12 
 fs/fs-writeback.c                                                     |    2 
 fs/ksmbd/connection.c                                                 |   68 
 fs/ksmbd/connection.h                                                 |   58 
 fs/ksmbd/mgmt/tree_connect.c                                          |    3 
 fs/ksmbd/mgmt/user_session.c                                          |  138 -
 fs/ksmbd/mgmt/user_session.h                                          |    5 
 fs/ksmbd/server.c                                                     |    3 
 fs/ksmbd/smb2pdu.c                                                    |  122 -
 fs/ksmbd/smb2pdu.h                                                    |    2 
 fs/ksmbd/transport_tcp.c                                              |    2 
 fs/notify/inotify/inotify_fsnotify.c                                  |   11 
 fs/ntfs3/bitmap.c                                                     |    3 
 fs/ntfs3/namei.c                                                      |   10 
 fs/ntfs3/ntfs.h                                                       |    3 
 fs/proc/proc_sysctl.c                                                 |   42 
 include/crypto/algapi.h                                               |    7 
 include/drm/display/drm_dp.h                                          |   10 
 include/drm/display/drm_dp_helper.h                                   |    5 
 include/linux/crypto.h                                                |    6 
 include/linux/pci_ids.h                                               |    1 
 include/trace/events/f2fs.h                                           |   62 
 kernel/locking/rwsem.c                                                |    8 
 net/core/skbuff.c                                                     |   20 
 net/ethtool/ioctl.c                                                   |    2 
 net/ipv6/sit.c                                                        |    8 
 net/ipv6/tcp_ipv6.c                                                   |    2 
 net/ncsi/ncsi-aen.c                                                   |    1 
 net/packet/af_packet.c                                                |    2 
 net/rxrpc/sendmsg.c                                                   |    2 
 net/sched/act_mirred.c                                                |    2 
 net/sched/cls_api.c                                                   |    1 
 sound/soc/codecs/Kconfig                                              |    6 
 sound/soc/codecs/Makefile                                             |    2 
 sound/soc/codecs/rt1316-sdw.c                                         |    2 
 sound/soc/codecs/rt1318-sdw.c                                         |  884 ++++++++
 sound/soc/codecs/rt1318-sdw.h                                         |  101 
 sound/soc/codecs/rt711-sdca-sdw.c                                     |    2 
 sound/soc/codecs/rt715-sdca-sdw.c                                     |    2 
 sound/soc/codecs/wcd938x-sdw.c                                        | 1039 +++++++++-
 sound/soc/codecs/wcd938x.c                                            | 1003 ---------
 sound/soc/codecs/wcd938x.h                                            |    1 
 sound/soc/codecs/wsa881x.c                                            |    2 
 sound/soc/codecs/wsa883x.c                                            |    2 
 sound/soc/intel/common/soc-acpi-intel-byt-match.c                     |    2 
 sound/usb/caiaq/input.c                                               |    1 
 tools/perf/builtin-ftrace.c                                           |    6 
 tools/perf/builtin-record.c                                           |    2 
 tools/perf/builtin-stat.c                                             |    4 
 tools/perf/pmu-events/arch/powerpc/power9/other.json                  |    4 
 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json               |    2 
 tools/perf/pmu-events/arch/s390/cf_z16/extended.json                  |   10 
 tools/perf/scripts/python/intel-pt-events.py                          |    2 
 tools/perf/tests/shell/record_offcpu.sh                               |    2 
 tools/perf/util/cs-etm.c                                              |   30 
 tools/perf/util/evsel.h                                               |    5 
 tools/perf/util/pmu.c                                                 |    2 
 tools/perf/util/sort.c                                                |    3 
 tools/perf/util/symbol-elf.c                                          |    2 
 tools/perf/util/tracepoint.c                                          |    1 
 tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh               |   10 
 tools/testing/selftests/netfilter/Makefile                            |    7 
 280 files changed, 5463 insertions(+), 3033 deletions(-)

Akhil R (1):
      i2c: tegra: Fix PEC support for SMBUS block read

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

Animesh Manna (1):
      drm/i915/mtl: update scaler source and destination limits for MTL

Antoine Tenart (1):
      net: ipv6: fix skb hash for some RST packets

Arnaldo Carvalho de Melo (1):
      perf pmu: zfree() expects a pointer to a pointer to zero it after freeing its contents

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

Boris Burkov (1):
      btrfs: fix encoded write i_size corruption with no-holes

Borislav Petkov (AMD) (1):
      x86/retbleed: Fix return thunk alignment

Chaitanya Kumar Borah (1):
      drm/i915/color: Fix typo for Plane CSC indexes

Chao Yu (2):
      f2fs: fix to do sanity check on extent cache correctly
      f2fs: inode: fix to do sanity check on extent cache correctly

Chia-I Wu (1):
      drm/amdgpu: add a missing lock for AMDGPU_SCHED

Christoph Hellwig (1):
      btrfs: zero the buffer before marking it dirty in btrfs_redirty_list_add

Christophe JAILLET (3):
      mailbox: zynq: Switch to flexible array to simplify code
      watchdog: dw_wdt: Fix the error handling path of dw_wdt_drv_probe()
      crypto: sun8i-ss - Fix a test in sun8i_ss_setup_ivs()

Christophe Leroy (2):
      spi: fsl-spi: Re-organise transfer bits_per_word adaptation
      spi: fsl-cpm: Use 16 bit mode for large transfers with even size

Claudio Imbrenda (1):
      KVM: s390: fix race in gmap_make_secure()

Cong Wang (1):
      sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()

Conor Dooley (2):
      RISC-V: take text_mutex during alternative patching
      RISC-V: fix taking the text_mutex twice during sifive errata patching

Cosmo Chou (1):
      net/ncsi: clear Tx enable mode when handling a Config required AEN

Cruise Hung (1):
      drm/amd/display: Reset OUTBOX0 r/w pointer on DMUB reset

Daniel Golle (1):
      net: dsa: mt7530: split-off common parts from mt7531_setup

David Howells (1):
      rxrpc: Fix hard call timeout units

Dawei Li (1):
      ksmbd: Implements sess->ksmbd_chann_list as xarray

Dmitrii Dolgov (1):
      perf stat: Separate bperf from bpf_profiler

Eric Dumazet (1):
      tcp: fix skb_copy_ubufs() vs BIG TCP

Filipe Manana (2):
      btrfs: fix btrfs_prev_leaf() to not return the same key twice
      btrfs: fix space cache inconsistency after error loading it from disk

Francesco Dolcini (1):
      drm/bridge: lt8912b: Fix DSI Video Mode

Geetha sowjanya (4):
      octeonxt2-af: mcs: Fix per port bypass config
      octeontx2-af: mcs: Config parser to skip 8B header
      octeontx2-af: mcs: Fix MCS block interrupt
      octeontx2-af: Secure APR table update with the lock

Graham Sider (1):
      drm/amdgpu: remove deprecated MES version vars

Greg Kroah-Hartman (1):
      Linux 6.1.29

Guchun Chen (4):
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

Hayes Wang (3):
      r8152: fix flow control issue of RTL8156A
      r8152: fix the poor throughput for 2.5G devices
      r8152: move setting r8153b_rx_agg_chg_indicate()

Herbert Xu (2):
      crypto: api - Add scaffolding to change completion function signature
      crypto: engine - Use crypto_request_complete

Hersen Wu (1):
      drm/amd/display: Return error code on DSC atomic check failure

Horatio Zhang (2):
      drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v10_0_hw_fini
      drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v11_0_hw_fini

Huacai Chen (1):
      irqchip/loongarch: Adjust acpi_cascade_irqdomain_init() and sub-routines

Ian Chen (1):
      drm/amd/display: Refactor eDP PSR codes

Ido Schimmel (1):
      ethtool: Fix uninitialized number of lanes

Jaegeuk Kim (8):
      f2fs: fix null pointer panic in tracepoint in __replace_atomic_write_block
      f2fs: fix potential corruption when moving a directory
      f2fs: specify extent cache for read explicitly
      f2fs: move internal functions into extent_cache.c
      f2fs: remove unnecessary __init_extent_tree
      f2fs: refactor extent_cache to support for read and more
      f2fs: allocate the extent_cache by default
      f2fs: factor out victim_entry usage from general rb_tree use

James Clark (1):
      perf cs-etm: Fix timeless decode mode detection

James Cowgill (1):
      drm/panel: otm8009a: Set backlight parent to panel device

Jan Kara (3):
      inotify: Avoid reporting event with invalid wd
      ext4: fix data races when using cached status extents
      ext4: fix lockdep warning when enabling MMP

Jani Nikula (2):
      drm/dsc: fix drm_edp_dsc_sink_output_bpp() DPCD high byte usage
      drm/dsc: fix DP_DSC_MAX_BPP_DELTA_* macro values

Jeremi Piotrowski (1):
      crypto: ccp - Clear PSP interrupt status register before calling handler

Jeremy Sowden (1):
      selftests: netfilter: fix libmnl pkg-config usage

Jianmin Lv (4):
      irqchip/loongson-pch-pic: Fix pch_pic_acpi_init calling
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
      drm/msm: fix workqueue leak on bind errors
      drm/msm: fix missing wq allocation error handling

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

Krzysztof Kozlowski (4):
      ARM: dts: exynos: fix WM8960 clock name in Itop Elite
      ARM: dts: s5pv210: correct MIPI CSIS clock name
      ASoC: codecs: constify static sdw_slave_ops struct
      ASoC: codecs: wcd938x: fix accessing regmap on unattached devices

Kuniyuki Iwashima (1):
      af_packet: Don't send zero-byte data in packet_sendmsg_spkt().

Leo Chen (2):
      drm/amd/display: Lowering min Z8 residency time
      drm/amd/display: Change default Z8 watermark values

Lin.Cao (1):
      drm/amdgpu: Fix vram recover doesn't work after whole GPU reset (v2)

Linus Torvalds (1):
      x86: fix clear_user_rep_good() exception handling annotation

Luis Chamberlain (3):
      proc_sysctl: update docs for __register_sysctl_table()
      proc_sysctl: enhance documentation
      sysctl: clarify register_sysctl_init() base directory order

Manivannan Sadhasivam (2):
      qcom: llcc/edac: Support polling mode for ECC handling
      soc: qcom: llcc: Do not create EDAC platform device on SDM845

Mario Limonciello (4):
      drm/amd: Load MES microcode during early_init
      drm/amd: Add a new helper for loading/validating microcode
      drm/amd: Use `amdgpu_ucode_*` helpers for MES
      x86/amd_nb: Add PCI ID for family 19h model 78h

Mark Pearson (2):
      platform/x86: thinkpad_acpi: Fix platform profiles on T490
      platform/x86: thinkpad_acpi: Add profile force ability

Markus Elfring (1):
      perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Martin Krastev (1):
      drm/vmwgfx: Fix Legacy Display Unit atomic drm support

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

Miquel Raynal (1):
      mtd: spi-nor: Add a RWW flag

Namjae Jeon (4):
      ksmbd: fix racy issue from session setup and logoff
      ksmbd: destroy expired sessions
      ksmbd: block asynchronous requests when making a delay on session setup
      ksmbd: fix racy issue from smb2 close and logoff with multichannel

Naohiro Aota (3):
      btrfs: zoned: fix wrong use of bitops API in btrfs_ensure_empty_zones
      btrfs: zoned: zone finish data relocation BG with last IO
      btrfs: zoned: fix full zone super block reading on ZNS

Nicholas Kazlauskas (9):
      drm/amd/display: Add NULL plane_state check for cursor disable logic
      drm/amd/display: Fix 4to1 MPC black screen with DPP RCO
      drm/amd/display: Add Z8 allow states to z-state support list
      drm/amd/display: Add debug option to skip PSR CRTC disable
      drm/amd/display: Fix Z8 support configurations
      drm/amd/display: Add minimum Z8 residency debug option
      drm/amd/display: Update minimum stutter residency for DCN314 Z8
      drm/amd/display: Update Z8 watermarks for DCN314
      drm/amd/display: Update Z8 SR exit/enter latencies

Olivier Bacon (1):
      crypto: engine - fix crypto_queue backlog handling

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

Radhakrishna Sripada (1):
      drm/i915/mtl: Add the missing CPU transcoder mask in intel_device_info

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

Rob Clark (2):
      drm/msm/adreno: Simplify read64/write64 helpers
      drm/msm: Hangcheck progress detection

Rodrigo Siqueira (2):
      drm/amd/display: Remove FPU guards from the DML folder
      drm/amd/display: Add missing WA and MCLK validation

Roman Lozko (1):
      perf scripts intel-pt-events.py: Fix IPC output for Python 2

Ruliang Lin (1):
      ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`

Ryan Lin (1):
      drm/amd/display: Ext displays with dock can't recognized after resume

Saleemkhan Jamadar (1):
      drm/amdgpu/jpeg: Remove harvest checking for JPEG3

Samson Tam (1):
      drm/amd/display: filter out invalid bits in pipe_fuses

Sascha Hauer (1):
      wifi: rtw88: rtw8821c: Fix rfe_option field width

Sean Christopherson (4):
      perf/x86/core: Zero @lbr instead of returning -1 in x86_perf_get_lbr() stub
      KVM: x86: Track supported PERF_CAPABILITIES in kvm_caps
      KVM: x86/pmu: Disallow legacy LBRs if architectural LBRs are available
      KVM: x86/mmu: Refresh CR0.WP prior to checking for emulated permission faults

Shannon Nelson (2):
      ionic: remove noise from ethtool rxnfc error msg
      ionic: catch failure from devlink_alloc

Shuming Fan (1):
      ASoC: rt1318: Add RT1318 SDCA vendor-specific driver

Sia Jee Heng (1):
      RISC-V: mm: Enable huge page support to kernel_page_present() function

Srinivas Pandruvada (1):
      platform/x86/intel-uncore-freq: Return error on write frequency

Stanislav Lisovskiy (1):
      drm: Add missing DP DSC extended capability definitions.

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

Sudip Mukherjee (1):
      mtd: spi-nor: add SFDP fixups for Quad Page Program

Suman Ghosh (2):
      octeontx2-af: Allow mkex profile without DMAC and add L2M/L2B header extraction support
      octeontx2-pf: Add additional checks while configuring ucast/bcast/mcast rules

Takahiro Kuwano (3):
      mtd: spi-nor: spansion: Remove NO_SFDP_FLAGS from s28hs512t info
      mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s28hx SEMPER flash
      mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s25hx SEMPER flash

Tanmay Shah (1):
      mailbox: zynqmp: Fix counts of child nodes

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

Thomas Richter (1):
      perf vendor events s390: Remove UTF-8 characters from JSON file

Tudor Ambarus (1):
      ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Victor Nogueira (1):
      net/sched: act_mirred: Add carrier check

Ville Syrjälä (1):
      drm/i915: Check pipe source size when using skl+ scalers

Vlad Buslov (1):
      net/sched: cls_api: remove block_cb from driver_list before freeing

Wei Fang (1):
      net: enetc: check the index of the SFI rather than the handle

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

Zack Rusin (1):
      drm/vmwgfx: Remove explicit and broken vblank handling

Zev Weiss (2):
      ARM: dts: aspeed: asrock: Correct firmware flash SPI clocks
      ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED

ZhangPeng (1):
      fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()

Zheng Wang (1):
      scsi: qedi: Fix use after free bug in qedi_remove()

xiaoshoukui (1):
      btrfs: fix assertion of exclop condition when starting balance

