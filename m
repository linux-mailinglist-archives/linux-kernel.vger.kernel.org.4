Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC4F7386E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjFUO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjFUOZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:25:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D119A3;
        Wed, 21 Jun 2023 07:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82E666155A;
        Wed, 21 Jun 2023 14:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68192C433C0;
        Wed, 21 Jun 2023 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687357546;
        bh=/jYbQAueatx7DPeArXzN862f4p3vBHFshZ/vWHxKZeo=;
        h=From:To:Cc:Subject:Date:From;
        b=iTu+mFtdGEmX/Y0WhaBpW8FvHszTaS54w+J7HCvkLmA7tDv5+pCrFP+ALhD+Gtm1D
         D0K89a3pPLt45Z/udqaZolyrPvP2irPKC5KQZTgrjrDds8mfCUoxIij+kAuQ4MVpZm
         pcDlXq+bhe8X4UhBUyjucOdAJs4XXCAkfQ24rFvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.3.9
Date:   Wed, 21 Jun 2023 16:25:39 +0200
Message-ID: <2023062139-snowiness-handprint-ba7c@gregkh>
X-Mailer: git-send-email 2.41.0
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

I'm announcing the release of the 6.3.9 kernel.

All users of the 6.3 kernel series must upgrade.

The updated 6.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.3.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts                     |    1 
 arch/arm64/boot/dts/arm/foundation-v8.dtsi                  |    1 
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts                  |    1 
 arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts        |    1 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                        |   11 
 arch/loongarch/kernel/perf_event.c                          |    6 
 arch/loongarch/kernel/unaligned.c                           |    2 
 arch/mips/Kconfig                                           |    1 
 arch/mips/alchemy/common/dbdma.c                            |   27 -
 arch/mips/kernel/cpu-probe.c                                |    5 
 arch/mips/kernel/setup.c                                    |    9 
 arch/nios2/boot/dts/10m50_devboard.dts                      |    2 
 arch/nios2/boot/dts/3c120_devboard.dts                      |    2 
 arch/parisc/include/asm/assembly.h                          |    4 
 arch/parisc/kernel/pci-dma.c                                |   18 
 arch/powerpc/purgatory/Makefile                             |    5 
 arch/riscv/purgatory/Makefile                               |    5 
 arch/x86/kernel/head_64.S                                   |   18 
 arch/x86/purgatory/Makefile                                 |    5 
 block/blk-cgroup.c                                          |   40 +
 drivers/block/xen-blkfront.c                                |    3 
 drivers/char/agp/parisc-agp.c                               |   15 
 drivers/clk/pxa/clk-pxa3xx.c                                |    2 
 drivers/edac/qcom_edac.c                                    |  122 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                     |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                     |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                    |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                    |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c                |   60 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h                |   15 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                      |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                       |  105 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                       |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |    8 
 drivers/gpu/drm/amd/display/dc/link/link_detection.c        |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c        |   33 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                       |    4 
 drivers/gpu/drm/drm_panel_orientation_quirks.c              |    2 
 drivers/gpu/drm/nouveau/nouveau_acpi.c                      |    3 
 drivers/gpu/drm/nouveau/nouveau_connector.c                 |    7 
 drivers/gpu/drm/nouveau/nouveau_drm.c                       |   14 
 drivers/infiniband/core/cma.c                               |    4 
 drivers/infiniband/core/uverbs_cmd.c                        |    7 
 drivers/infiniband/core/uverbs_main.c                       |   12 
 drivers/infiniband/hw/bnxt_re/bnxt_re.h                     |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                    |    7 
 drivers/infiniband/hw/bnxt_re/main.c                        |    2 
 drivers/infiniband/hw/mlx5/fs.c                             |  276 +++++++++++-
 drivers/infiniband/hw/mlx5/fs.h                             |   16 
 drivers/infiniband/hw/mlx5/main.c                           |    3 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                        |   14 
 drivers/infiniband/hw/mlx5/qp.c                             |    3 
 drivers/infiniband/sw/rxe/rxe_cq.c                          |    4 
 drivers/infiniband/sw/rxe/rxe_net.c                         |    6 
 drivers/infiniband/sw/rxe/rxe_qp.c                          |    7 
 drivers/infiniband/sw/rxe/rxe_resp.c                        |    3 
 drivers/infiniband/ulp/isert/ib_isert.c                     |   16 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                      |   55 +-
 drivers/infiniband/ulp/rtrs/rtrs.c                          |    4 
 drivers/irqchip/irq-gic-common.c                            |   10 
 drivers/irqchip/irq-gic-common.h                            |    1 
 drivers/irqchip/irq-gic-v3.c                                |   20 
 drivers/irqchip/irq-meson-gpio.c                            |    2 
 drivers/md/dm-ioctl.c                                       |    5 
 drivers/md/dm-thin-metadata.c                               |   20 
 drivers/md/dm-thin.c                                        |    3 
 drivers/md/dm.c                                             |    4 
 drivers/media/dvb-core/dvb_frontend.c                       |   53 --
 drivers/net/dsa/ocelot/felix_vsc9959.c                      |    2 
 drivers/net/ethernet/freescale/enetc/enetc_qos.c            |    4 
 drivers/net/ethernet/intel/iavf/iavf.h                      |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c                 |   15 
 drivers/net/ethernet/intel/iavf/iavf_register.h             |    2 
 drivers/net/ethernet/intel/ice/ice_gnss.c                   |   50 --
 drivers/net/ethernet/intel/ice/ice_gnss.h                   |    3 
 drivers/net/ethernet/intel/ice/ice_main.c                   |   20 
 drivers/net/ethernet/intel/igb/igb_ethtool.c                |    3 
 drivers/net/ethernet/intel/igb/igb_main.c                   |    8 
 drivers/net/ethernet/intel/igc/igc_main.c                   |   12 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c         |    7 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c         |    7 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c    |   29 -
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h         |   12 
 drivers/net/ethernet/renesas/rswitch.c                      |   36 -
 drivers/net/ethernet/sfc/efx_channels.c                     |    2 
 drivers/net/ethernet/sfc/efx_devlink.c                      |   95 +---
 drivers/net/ethernet/sfc/siena/efx_channels.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c           |    9 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                    |    2 
 drivers/net/ipvlan/ipvlan_l3s.c                             |    4 
 drivers/net/macsec.c                                        |   12 
 drivers/net/phy/phylink.c                                   |   41 +
 drivers/net/usb/qmi_wwan.c                                  |    2 
 drivers/net/wan/lapbether.c                                 |    3 
 drivers/nvme/host/pci.c                                     |    2 
 drivers/of/overlay.c                                        |    1 
 drivers/pci/quirks.c                                        |    9 
 drivers/platform/x86/asus-nb-wmi.c                          |    2 
 drivers/power/supply/ab8500_btemp.c                         |    6 
 drivers/power/supply/ab8500_fg.c                            |    6 
 drivers/power/supply/bq27xxx_battery.c                      |    6 
 drivers/power/supply/power_supply_core.c                    |    8 
 drivers/power/supply/power_supply_sysfs.c                   |    3 
 drivers/power/supply/sc27xx_fuel_gauge.c                    |    9 
 drivers/regulator/core.c                                    |    4 
 drivers/regulator/qcom-rpmh-regulator.c                     |   85 +++
 drivers/s390/net/ism_drv.c                                  |    8 
 drivers/soc/qcom/llcc-qcom.c                                |   72 +--
 drivers/spi/spi-cadence-quadspi.c                           |    7 
 drivers/spi/spi-fsl-dspi.c                                  |   15 
 drivers/target/target_core_transport.c                      |    2 
 drivers/thunderbolt/dma_test.c                              |    8 
 drivers/thunderbolt/nhi.c                                   |   11 
 drivers/thunderbolt/tb.c                                    |   17 
 drivers/thunderbolt/tunnel.c                                |    2 
 drivers/tty/serial/fsl_lpuart.c                             |    2 
 drivers/tty/serial/lantiq.c                                 |    1 
 drivers/usb/dwc3/core.c                                     |    5 
 drivers/usb/dwc3/dwc3-qcom.c                                |   11 
 drivers/usb/dwc3/gadget.c                                   |    1 
 drivers/usb/gadget/udc/core.c                               |  180 +++++--
 drivers/usb/gadget/udc/renesas_usb3.c                       |    4 
 drivers/usb/serial/option.c                                 |   16 
 drivers/usb/typec/pd.c                                      |    2 
 drivers/usb/typec/ucsi/ucsi.c                               |   11 
 fs/afs/vl_probe.c                                           |    4 
 fs/btrfs/block-group.c                                      |   14 
 fs/btrfs/disk-io.c                                          |   19 
 fs/btrfs/file-item.c                                        |    4 
 fs/btrfs/inode.c                                            |   20 
 fs/btrfs/scrub.c                                            |    9 
 fs/btrfs/super.c                                            |    6 
 fs/cifs/file.c                                              |    8 
 fs/erofs/Kconfig                                            |    1 
 fs/erofs/zdata.c                                            |    2 
 fs/eventpoll.c                                              |    6 
 fs/ext4/balloc.c                                            |   20 
 fs/ksmbd/connection.c                                       |    5 
 fs/ksmbd/smb_common.c                                       |   14 
 fs/nilfs2/btnode.c                                          |   12 
 fs/nilfs2/sufile.c                                          |    9 
 fs/nilfs2/the_nilfs.c                                       |   43 +
 fs/ocfs2/file.c                                             |    8 
 fs/ocfs2/super.c                                            |    6 
 fs/userfaultfd.c                                            |    5 
 include/linux/mlx5/driver.h                                 |   12 
 include/linux/soc/qcom/llcc-qcom.h                          |   12 
 include/media/dvb_frontend.h                                |    6 
 include/net/neighbour.h                                     |    2 
 include/net/netfilter/nf_flow_table.h                       |    2 
 include/net/netfilter/nf_tables.h                           |    4 
 include/net/sch_generic.h                                   |    8 
 include/rdma/ib_addr.h                                      |   23 -
 include/sound/soc-acpi.h                                    |    1 
 include/sound/soc-dpcm.h                                    |    4 
 include/uapi/linux/ethtool_netlink.h                        |    2 
 io_uring/net.c                                              |    8 
 io_uring/sqpoll.c                                           |    6 
 kernel/bpf/cgroup.c                                         |   38 -
 kernel/bpf/cgroup_iter.c                                    |    4 
 kernel/bpf/local_storage.c                                  |    4 
 kernel/cgroup/cgroup-v1.c                                   |   20 
 kernel/cgroup/cgroup.c                                      |   77 +--
 kernel/kexec_file.c                                         |   14 
 mm/damon/core.c                                             |    2 
 mm/gup_test.c                                               |    1 
 mm/zswap.c                                                  |   11 
 net/core/neighbour.c                                        |   31 -
 net/ipv6/ping.c                                             |    3 
 net/mac80211/cfg.c                                          |    9 
 net/mac80211/ieee80211_i.h                                  |    2 
 net/mac80211/link.c                                         |    4 
 net/mac80211/mlme.c                                         |    5 
 net/mac80211/util.c                                         |    4 
 net/netfilter/nf_flow_table_core.c                          |   13 
 net/netfilter/nf_flow_table_ip.c                            |    4 
 net/netfilter/nf_tables_api.c                               |   59 ++
 net/netfilter/nfnetlink.c                                   |    3 
 net/netfilter/nft_set_pipapo.c                              |   55 +-
 net/sched/act_ct.c                                          |    9 
 net/sched/act_pedit.c                                       |   45 +
 net/sched/cls_api.c                                         |   12 
 net/sched/cls_u32.c                                         |   18 
 net/sched/sch_api.c                                         |   44 +
 net/sched/sch_generic.c                                     |   14 
 net/sched/sch_taprio.c                                      |    3 
 net/sctp/sm_statefuns.c                                     |    2 
 net/tipc/bearer.c                                           |    4 
 net/wireless/rdev-ops.h                                     |    6 
 net/wireless/reg.c                                          |    7 
 sound/pci/hda/patch_realtek.c                               |    1 
 sound/soc/codecs/cs35l41-lib.c                              |    6 
 sound/soc/dwc/dwc-i2s.c                                     |   41 -
 sound/soc/intel/avs/avs.h                                   |    4 
 sound/soc/intel/avs/board_selection.c                       |    2 
 sound/soc/intel/avs/dsp.c                                   |    4 
 sound/soc/intel/avs/path.h                                  |    2 
 sound/soc/intel/avs/pcm.c                                   |   23 -
 sound/soc/intel/avs/probes.c                                |    2 
 sound/soc/soc-pcm.c                                         |   20 
 sound/usb/pcm.c                                             |    4 
 sound/usb/quirks.c                                          |    2 
 tools/gpio/lsgpio.c                                         |    2 
 tools/testing/selftests/gpio/gpio-sim.sh                    |    3 
 tools/testing/selftests/net/forwarding/hw_stats_l3.sh       |   11 
 tools/testing/selftests/ptp/testptp.c                       |    6 
 tools/testing/selftests/tc-testing/config                   |    1 
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json |    4 
 tools/testing/selftests/tc-testing/tdc.sh                   |    1 
 211 files changed, 2102 insertions(+), 939 deletions(-)

Abel Vesa (1):
      regulator: qcom-rpmh: Fix regulators for PM8550

Ahmed Zaki (1):
      iavf: remove mask from iavf_irq_enable_queues()

Alejandro Lucero (1):
      sfc: fix devlink info error handling

Aleksandr Loktionov (1):
      igb: fix nvm.ops.read() error handling

Alex Deucher (1):
      drm/amdgpu: add missing radeon secondary PCI ID

Alex Maftei (1):
      selftests/ptp: Fix timestamp printf format for PTP_SYS_OFFSET

Alexandru Sorodoc (1):
      platform/x86: asus-wmi: Ignore WMI events with codes 0x7B, 0xC0

Amadeusz Sławiński (2):
      ASoC: Intel: avs: Fix avs_path_module::instance_id size
      ASoC: Intel: avs: Add missing checks on FE startup

Arnd Bergmann (1):
      clk: pxa: fix NULL pointer dereference in pxa3xx_clk_update_accr

Arunpravin Paneer Selvam (1):
      Revert "drm/amdgpu: remove TOPDOWN flags when allocating VRAM in large bar system"

Badhri Jagan Sridharan (2):
      usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
      usb: gadget: udc: core: Prevent soft_connect_store() race

Bartosz Golaszewski (1):
      regulator: qcom-rpmh: add support for pmm8654au regulators

Ben Hutchings (1):
      parisc: Delete redundant register definitions in <asm/assembly.h>

Benjamin Berg (3):
      wifi: cfg80211: fix link del callback to call correct handler
      wifi: mac80211: take lock before setting vif links
      wifi: mac80211: fragment per STA profile correctly

Benjamin Segall (1):
      epoll: ep_autoremove_wake_function should use list_del_init_careful

Bernhard Seibold (1):
      serial: lantiq: add missing interrupt ack

Biju Das (1):
      usb: gadget: udc: renesas_usb3: Fix RZ/V2M {modprobe,bind} error

Bob Pearson (4):
      RDMA/rxe: Fix packet length checks
      RDMA/rxe: Fix ref count error in check_rkey()
      RDMA/rxe: Fix rxe_cq_post
      scsi: target: core: Fix error path in target_setup_session()

Cezary Rojewski (1):
      ASoC: Intel: avs: Account for UID of ACPI device

Chris Mason (2):
      btrfs: properly enable async discard when switching from RO->RW
      btrfs: can_nocow_file_extent should pass down args->strict from callers

Christian Marangi (1):
      net: ethernet: stmicro: stmmac: fix possible memory leak in __stmmac_open

Christoph Hellwig (1):
      btrfs: fix iomap_begin length for nocow writes

Dan Carpenter (3):
      wifi: cfg80211: fix double lock bug in reg_wdev_chan_valid()
      sctp: fix an error code in sctp_sf_eat_auth()
      net: ethernet: ti: am65-cpsw: Call of_node_put() on error path

Danielle Ratson (1):
      selftests: forwarding: hw_stats_l3: Set addrgenmode in a separate step

Dave Airlie (1):
      nouveau: fix client work fence deletion race

David Howells (1):
      afs: Fix vlserver probe RTT handling

Douglas Anderson (1):
      irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware issues

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Add a quirk for Compaq N14JP6

Edward Srouji (1):
      RDMA/uverbs: Restrict usage of privileged QKEYs

Elson Roy Serrao (1):
      usb: dwc3: gadget: Reset num TRBs before giving back the request

Eric Dumazet (1):
      net: lapbether: only support ethernet devices

Fabio M. De Francesco (1):
      ext4: drop the call to ext4_error() from ext4_get_group_info()

Fedor Pchelkin (1):
      net: macsec: fix double free of percpu stats

Gao Xiang (1):
      erofs: use HIPRI by default if per-cpu kthreads are enabled

Greg Kroah-Hartman (1):
      Linux 6.3.9

Guillaume Nault (1):
      ping6: Fix send to link-local addresses with VRF.

Haibo Li (1):
      mm/gup_test: fix ioctl fail for compat task

Hangbin Liu (1):
      ipvlan: fix bound dev checking for IPv6 l3s mode

Hans de Goede (3):
      power: supply: ab8500: Fix external_power_changed race
      power: supply: sc27xx: Fix external_power_changed race
      power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()

Heikki Krogerus (1):
      usb: typec: ucsi: Fix command cancellation

Helge Deller (2):
      parisc: Improve cache flushing for PCXL in arch_sync_dma_for_cpu()
      parisc: Flush gatt writes and adjust gatt mask in parisc_agp_mask_memory()

Hersen Wu (1):
      drm/amd/display: edp do not add non-edid timings

Huacai Chen (1):
      LoongArch: Fix perf event id calculation

Immad Mir (1):
      LoongArch: Fix debugfs_create_dir() error checking

Jakub Buchocki (1):
      ice: Fix ice module unload

Jakub Kicinski (1):
      net: ethtool: correct MAX attribute value for stats

Janne Grunau (1):
      nios2: dts: Fix tse_mac "max-frame-size" property

Jens Axboe (1):
      io_uring/net: save msghdr->msg_control for retries

Jerry Meng (1):
      USB: serial: option: add Quectel EM061KGL series

Jiadong Zhu (4):
      drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled
      drm/amdgpu: Program gds backup address as zero if no gds allocated
      drm/amdgpu: Implement gfx9 patch functions for resubmission
      drm/amdgpu: Modify indirect buffer packages for resubmission

Jiasheng Jiang (2):
      spi: cadence-quadspi: Add missing check for dma_set_mask
      octeon_ep: Add missing check for ioremap

Johan Hovold (2):
      USB: dwc3: qcom: fix NULL-deref on suspend
      USB: dwc3: fix use-after-free on core driver unbind

Johannes Berg (2):
      wifi: cfg80211: fix locking in regulatory disconnect
      wifi: mac80211: fix link activation settings order

Johannes Thumshirn (1):
      btrfs: handle memory allocation failure in btrfs_csum_one_bio

John Sperbeck (1):
      cgroup: always put cset in cgroup_css_set_put_fork

Julian Ruess (1):
      s390/ism: Fix trying to free already-freed IRQ by repeated ism_dev_exit()

Kamal Heib (1):
      RDMA/bnxt_re: Fix reporting active_{speed,width} attributes

Kamalesh Babulal (1):
      cgroup: bpf: use cgroup_lock()/cgroup_unlock() wrappers

Kamil Maziarz (1):
      ice: Fix XDP memory leak when NIC is brought up and down

Kefeng Wang (1):
      mm/damon/core: fix divide error in damon_nr_accesses_to_accesses_bp()

Kenneth Feng (1):
      drm/amd/pm: workaround for compute workload type on some skus

Konrad Dybcio (1):
      arm64: dts: qcom: sm8550: Use the correct LLCC register scheme

Krzysztof Kozlowski (3):
      ARM: dts: vexpress: add missing cache properties
      arm64: dts: arm: add missing cache properties
      irqchip/meson-gpio: Mark OF related data as maybe unused

Kunihiko Hayashi (1):
      of: overlay: Fix missing of_node_put() in error case of init_overlay_changeset()

Lee Jones (1):
      net/sched: cls_u32: Fix reference counter leak leading to overflow

Leon Romanovsky (1):
      neighbour: delete neigh_lookup_nodev as not used

Li Lingfeng (2):
      dm thin metadata: check fail_io before using data_sm
      dm: don't lock fs when the map is NULL during suspend or resume

Li Zhijian (2):
      RDMA/rtrs: Fix the last iu->buf leak in err path
      RDMA/rtrs: Fix rxe_dealloc_pd warning

Lin Ma (1):
      net: tipc: resize nlattr array to correct size

Liviu Dudau (1):
      mips: Move initrd_start check after initrd address sanitisation.

Lukasz Tyl (1):
      ALSA: usb-audio: Add quirk flag for HEM devices to enable native DSD playback

Luís Henriques (2):
      ocfs2: fix use-after-free when unmounting read-only filesystem
      ocfs2: check new file size on fallocate call

Maher Sanalla (1):
      RDMA/mlx5: Initiate dropless RQ for RAW Ethernet functions

Manivannan Sadhasivam (2):
      qcom: llcc/edac: Fix the base address used for accessing LLCC banks
      EDAC/qcom: Get rid of hardcoded register offsets

Manuel Lauss (3):
      MIPS: unhide PATA_PLATFORM
      MIPS: Restore Au1300 support
      MIPS: Alchemy: fix dbdma2

Marc Zyngier (1):
      irqchip/gic: Correctly validate OF quirk descriptors

Marek Vasut (1):
      power: supply: Ratelimit no data debug output

Mario Limonciello (3):
      power: supply: Fix logic checking if system is running from battery
      drm/amd: Make sure image is written to trigger VBIOS image update flow
      drm/amd: Tighten permissions on VBIOS flashing attributes

Mark Bloch (2):
      RDMA/mlx5: Create an indirect flow table for steering anchor
      RDMA/mlx5: Fix affinity assignment

Mark Zhang (1):
      RDMA/cma: Always set static rate to 0 for RoCE

Mauro Carvalho Chehab (1):
      Revert "media: dvb-core: Fix use-after-free on race condition at dvb_frontend"

Max Tottenham (1):
      net/sched: act_pedit: Parse L3 Header for L4 offset

Maxim Kochetkov (1):
      ASoC: dwc: move DMA init to snd_soc_dai_driver probe()

Maxime Chevallier (2):
      net: phylink: report correct max speed for QUSGMII
      net: phylink: use a dedicated helper to parse usgmii control word

Maya Matuszczyk (1):
      drm: panel-orientation-quirks: Change Air's quirk to support Air Plus

Michal Schmidt (1):
      ice: do not busy-wait to read GNSS data

Mika Westerberg (5):
      PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports
      thunderbolt: Increase DisplayPort Connection Manager handshake timeout
      thunderbolt: Do not touch CL state configuration during discovery
      thunderbolt: dma_test: Use correct value for absent rings when creating paths
      thunderbolt: Mask ring interrupt on Intel hardware as well

Mike Snitzer (1):
      dm thin: fix issue_discard to pass GFP_NOIO to __blkdev_issue_discard

Milo Spadacini (1):
      tools: gpio: fix debounce_period_us output of lsgpio

Ming Lei (1):
      blk-cgroup: Flush stats before releasing blkcg_gq

Mirsad Todorovac (1):
      selftests: gpio: gpio-sim: Fix BUG: test FAILED due to recent change

Muhammad Husaini Zulkifli (1):
      igc: Clean the TX buffer and TX descriptor ring

Namjae Jeon (1):
      ksmbd: validate smb request protocol id

Natalia Petrova (2):
      drm/nouveau/dp: check for NULL nv_connector->native_mode
      drm/nouveau: add nv_encoder pointer check for NULL

Nhat Pham (1):
      zswap: do not shrink if cgroup may not zswap

Nithin Dabilpuram (1):
      octeontx2-af: fix lbk link credits on cn10k

Osama Muhammad (1):
      regulator: Fix error checking for debugfs_create_dir

Pablo Neira Ayuso (3):
      netfilter: nf_tables: integrate pipapo into commit protocol
      netfilter: nfnetlink: skip error delivery on batch in case of ENOMEM
      netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE

Paul Blakey (1):
      net/sched: act_ct: Fix promotion of offloaded unreplied tuple

Pavan Holla (1):
      usb: typec: Fix fast_role_swap_current show function

Pedro Tammela (1):
      net/sched: act_pedit: remove extra check for key type

Peichen Huang (1):
      drm/amd/display: limit DPIA link rate to HBR3

Peilin Ye (2):
      net/sched: Refactor qdisc_graft() for ingress and clsact Qdiscs
      net/sched: qdisc_destroy() old ingress and clsact Qdiscs before grafting

Peter Xu (1):
      mm/uffd: fix vma operation where start addr cuts part of vma

Qi Zheng (1):
      cgroup: fix missing cpus_read_{lock,unlock}() in cgroup_transfer_tasks()

Qu Wenruo (3):
      btrfs: scrub: try harder to mark RAID56 block groups read-only
      btrfs: subpage: fix a crash in metadata repair path
      btrfs: do not ASSERT() on duplicated global roots

Ranjani Sridharan (1):
      ASoC: soc-pcm: test if a BE can be prepared

Ratchanan Srirattanamet (1):
      drm/nouveau: don't detect DSM for non-NVIDIA device

Ratheesh Kannoth (1):
      octeontx2-af: Fix promiscuous mode

Ricardo Ribalda (4):
      kexec: support purgatories with .text.hot sections
      x86/purgatory: remove PGO flags
      riscv/purgatory: remove PGO flags
      powerpc/purgatory: remove PGO flags

Robert Hodaszi (1):
      tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A

Ross Lagerwall (1):
      xen/blkfront: Only check REQ_FUA for writes

Ryusuke Konishi (3):
      nilfs2: fix incomplete buffer cleanup in nilfs_btnode_abort_change_key()
      nilfs2: fix possible out-of-bounds segment allocation in resize ioctl
      nilfs2: reject devices with insufficient block count

Saravanan Vajravel (3):
      IB/isert: Fix dead lock in ib_isert
      IB/isert: Fix possible list corruption in CMA handler
      IB/isert: Fix incorrect release of isert connection

Satha Rao (1):
      octeontx2-af: fixed resource availability check

Simon Horman (1):
      ice: Don't dereference NULL in ice_gnss_read error path

Sonny Jiang (1):
      drm/amdgpu: vcn_4_0 set instance 0 init sched score to 1

Stefan Binding (1):
      ASoC: cs35l41: Fix default regmap values for some registers

Steve French (1):
      cifs: fix lease break oops in xfstest generic/098

Su Hui (1):
      drm/bridge: ti-sn65dsi86: Avoid possible buffer overflow

Sukrut Bellary (1):
      drm:amd:amdgpu: Fix missing buffer object unlock in failure path

Takashi Iwai (1):
      ALSA: usb-audio: Fix broken resume due to UAC3 power state

Tatsuki Sugiura (1):
      NVMe: Add MAXIO 1602 to bogus nid list.

Tom Lendacky (1):
      x86/head/64: Switch to KERNEL_CS as soon as new GDT is installed

Vinicius Costa Gomes (1):
      igc: Fix possible system crash when loading module

Vlad Buslov (4):
      selftests/tc-testing: Fix Error: Specified qdisc kind is unknown.
      selftests/tc-testing: Fix Error: failed to find target LOG
      selftests/tc-testing: Fix SFB db test
      net/sched: cls_api: Fix lockup on flushing explicitly created chain

Vladimir Oltean (2):
      spi: fsl-dspi: avoid SCK glitches with continuous transfers
      net: dsa: felix: fix taprio guard band overflow at 10Mbps with jumbo frames

Wei Fang (1):
      net: enetc: correct the indexes of highest and 2nd highest TCs

Wenwen Chen (1):
      io_uring: unlock sqd->lock before sq thread release CPU

Wes Huang (1):
      net: usb: qmi_wwan: add support for Compal RXM-G1

Yishai Hadas (1):
      IB/uverbs: Fix to consider event queue closing also upon non-blocking mode

Yoshihiro Shimoda (1):
      net: renesas: rswitch: Fix timestamp feature after all descriptors are used

Yuezhen Luan (1):
      igb: Fix extts capture value format for 82580/i354/i350

Zhengchao Shao (1):
      net/sched: taprio: fix slab-out-of-bounds Read in taprio_dequeue_from_txq

Zhu Yanjun (1):
      RDMA/rxe: Fix the use-before-initialization error of resp_pkts

Íñigo Huguet (1):
      sfc: fix XDP queues mode with legacy IRQ

