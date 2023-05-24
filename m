Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83E70FC84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjEXRUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEXRUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6C793;
        Wed, 24 May 2023 10:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECEBA63F9E;
        Wed, 24 May 2023 17:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7CEC4339C;
        Wed, 24 May 2023 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684948817;
        bh=UpyPaxks7clea2jmiM2XAR98GFMxm2rny5t6AJU2sPk=;
        h=From:To:Cc:Subject:Date:From;
        b=0mCB70SBbJZeA1rMLXUhRJbBxZoXHQRiyPtJWq1Dh57jW4dcH1MnAoYZZOTgjK4O3
         3j3YJHgytjTAvsEOL80IH3+6sz3zTTk1ZqWwyRg1o/emWHJKDXB9ZhF1dvGT6547Jm
         43TPwT9zKTe1B+lu3jpVS+GcLntqrfGvTJhrgivI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.113
Date:   Wed, 24 May 2023 18:20:13 +0100
Message-Id: <2023052413-zombie-sublevel-14e7@gregkh>
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

I'm announcing the release of the 5.15.113 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml |   12 
 MAINTAINERS                                                            |    4 
 Makefile                                                               |    2 
 arch/arm/mach-sa1100/jornada720_ssp.c                                  |    5 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                                  |    3 
 arch/parisc/include/asm/pdc.h                                          |    1 
 arch/parisc/kernel/firmware.c                                          |   27 
 arch/powerpc/kernel/dma-iommu.c                                        |    4 
 arch/powerpc/mm/book3s64/radix_pgtable.c                               |    4 
 arch/powerpc/platforms/pseries/iommu.c                                 |   13 
 drivers/acpi/acpica/dbnames.c                                          |    3 
 drivers/acpi/acpica/dswstate.c                                         |   11 
 drivers/acpi/ec.c                                                      |    1 
 drivers/base/regmap/regcache.c                                         |    6 
 drivers/block/nbd.c                                                    |    6 
 drivers/block/null_blk/main.c                                          |    5 
 drivers/bluetooth/btbcm.c                                              |   47 
 drivers/bluetooth/btintel.c                                            |    5 
 drivers/char/tpm/tpm_tis.c                                             |   16 
 drivers/clk/tegra/clk-tegra20.c                                        |   28 
 drivers/firmware/arm_sdei.c                                            |   37 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                     |    7 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c                     |    5 
 drivers/gpu/drm/drm_displayid.c                                        |   17 
 drivers/gpu/drm/drm_mipi_dsi.c                                         |    2 
 drivers/gpu/drm/exynos/exynos_drm_g2d.h                                |    4 
 drivers/gpu/drm/i915/display/intel_dp.c                                |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c                      |   11 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h                      |    1 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c                            |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h                               |    3 
 drivers/gpu/drm/msm/dp/dp_audio.c                                      |   12 
 drivers/gpu/drm/msm/dp/dp_audio.h                                      |    2 
 drivers/gpu/drm/msm/dp/dp_aux.c                                        |   80 
 drivers/gpu/drm/msm/dp/dp_catalog.c                                    |    2 
 drivers/gpu/drm/msm/dp/dp_catalog.h                                    |    2 
 drivers/gpu/drm/msm/dp/dp_display.c                                    |    1 
 drivers/gpu/drm/tegra/sor.c                                            |    2 
 drivers/hid/hid-logitech-hidpp.c                                       |   53 
 drivers/hid/wacom.h                                                    |    3 
 drivers/hid/wacom_sys.c                                                |    2 
 drivers/hid/wacom_wac.c                                                |   80 
 drivers/infiniband/core/user_mad.c                                     |   23 
 drivers/input/joystick/xpad.c                                          |    5 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                            |   19 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                             |   16 
 drivers/iommu/sprd-iommu.c                                             |   29 
 drivers/mcb/mcb-pci.c                                                  |   27 
 drivers/media/pci/cx23885/cx23885-core.c                               |    4 
 drivers/media/pci/cx23885/cx23885-video.c                              |   13 
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c                     |    2 
 drivers/media/pci/tw68/tw68-video.c                                    |   16 
 drivers/media/platform/am437x/am437x-vpfe.c                            |   15 
 drivers/media/platform/exynos4-is/fimc-capture.c                       |    7 
 drivers/media/platform/ti-vpe/cal-video.c                              |    8 
 drivers/media/platform/vsp1/vsp1_drm.c                                 |   18 
 drivers/media/platform/vsp1/vsp1_entity.c                              |   11 
 drivers/media/usb/dvb-usb/cxusb-analog.c                               |   14 
 drivers/memstick/host/r592.c                                           |    2 
 drivers/message/fusion/mptlan.c                                        |    2 
 drivers/mfd/dln2.c                                                     |    1 
 drivers/net/can/kvaser_pciefd.c                                        |   51 
 drivers/net/dsa/mv88e6xxx/port.h                                       |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                      |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                         |    9 
 drivers/net/ethernet/freescale/fec_main.c                              |   15 
 drivers/net/ethernet/google/gve/gve_main.c                             |   13 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c                     |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h                     |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                |   15 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c                  |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h                  |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c              |    5 
 drivers/net/ethernet/intel/igb/e1000_mac.c                             |    4 
 drivers/net/ethernet/pasemi/pasemi_mac.c                               |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c                      |   25 
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h                           |    4 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                      |    9 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                           |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c                  |    5 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                       |   12 
 drivers/net/ethernet/sun/cassini.c                                     |    2 
 drivers/net/ipvlan/ipvlan_core.c                                       |    6 
 drivers/net/mdio/mdio-mvusb.c                                          |   11 
 drivers/net/phy/dp83867.c                                              |   22 
 drivers/net/tap.c                                                      |    4 
 drivers/net/virtio_net.c                                               |   61 
 drivers/net/wireless/ath/ath.h                                         |   12 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                |    9 
 drivers/net/wireless/ath/key.c                                         |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c            |   13 
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c                           |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c                           |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                          |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                          |    3 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                        |    2 
 drivers/parisc/power.c                                                 |   16 
 drivers/phy/st/phy-miphy28lp.c                                         |   42 
 drivers/platform/x86/Kconfig                                           |   42 
 drivers/platform/x86/Makefile                                          |    4 
 drivers/platform/x86/hp-wmi.c                                          | 1135 ---------
 drivers/platform/x86/hp/Kconfig                                        |   63 
 drivers/platform/x86/hp/Makefile                                       |   10 
 drivers/platform/x86/hp/hp-wmi.c                                       | 1138 ++++++++++
 drivers/platform/x86/hp/hp_accel.c                                     |  405 +++
 drivers/platform/x86/hp/tc1100-wmi.c                                   |  265 ++
 drivers/platform/x86/hp_accel.c                                        |  405 ---
 drivers/platform/x86/tc1100-wmi.c                                      |  265 --
 drivers/remoteproc/stm32_rproc.c                                       |    8 
 drivers/s390/cio/device.c                                              |    2 
 drivers/s390/cio/qdio.h                                                |    2 
 drivers/scsi/lpfc/lpfc_debugfs.c                                       |    7 
 drivers/scsi/storvsc_drv.c                                             |    8 
 drivers/scsi/ufs/ufshcd-pci.c                                          |    1 
 drivers/scsi/ufs/ufshcd.c                                              |   10 
 drivers/soundwire/qcom.c                                               |    3 
 drivers/spi/spi-imx.c                                                  |   24 
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
 drivers/usb/class/usbtmc.c                                             |    2 
 drivers/usb/dwc3/debugfs.c                                             |  109 
 drivers/usb/gadget/function/u_ether.c                                  |    3 
 drivers/usb/host/uhci-pci.c                                            |   10 
 drivers/usb/host/xhci-pci.c                                            |   12 
 drivers/usb/host/xhci-ring.c                                           |   29 
 drivers/usb/host/xhci.h                                                |    2 
 drivers/usb/storage/scsiglue.c                                         |   28 
 drivers/usb/typec/altmodes/displayport.c                               |    4 
 drivers/usb/typec/tcpm/tcpm.c                                          |   16 
 drivers/video/fbdev/arcfb.c                                            |   15 
 fs/ceph/snap.c                                                         |   13 
 fs/cifs/cifsglob.h                                                     |    4 
 fs/cifs/file.c                                                         |   26 
 fs/cifs/smb1ops.c                                                      |    9 
 fs/cifs/smb2ops.c                                                      |    7 
 fs/ext2/ext2.h                                                         |    1 
 fs/ext2/super.c                                                        |    7 
 fs/ext4/balloc.c                                                       |   18 
 fs/ext4/ext4.h                                                         |   15 
 fs/ext4/ialloc.c                                                       |   12 
 fs/ext4/mballoc.c                                                      |  131 -
 fs/ext4/mmp.c                                                          |   39 
 fs/ext4/super.c                                                        |   28 
 fs/f2fs/checkpoint.c                                                   |   12 
 fs/f2fs/data.c                                                         |    3 
 fs/f2fs/f2fs.h                                                         |    5 
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
 fs/statfs.c                                                            |    4 
 include/linux/cpuhotplug.h                                             |    1 
 include/linux/dim.h                                                    |    3 
 include/linux/if_vlan.h                                                |   17 
 include/linux/sched/task_stack.h                                       |    2 
 include/linux/stmmac.h                                                 |    1 
 include/linux/sunrpc/svc.h                                             |    2 
 include/linux/sunrpc/svc_rdma.h                                        |    2 
 include/linux/sunrpc/svc_xprt.h                                        |    2 
 include/net/ip_vs.h                                                    |    6 
 include/net/sock.h                                                     |    2 
 include/trace/bpf_probe.h                                              |    6 
 include/trace/events/sunrpc.h                                          |   12 
 include/trace/perf.h                                                   |    6 
 include/trace/trace_events.h                                           |   55 
 kernel/bpf/bpf_local_storage.c                                         |   16 
 kernel/bpf/verifier.c                                                  |    4 
 kernel/rcu/refscale.c                                                  |    2 
 kernel/rcu/tree_exp.h                                                  |    6 
 kernel/time/tick-broadcast.c                                           |  120 -
 lib/cpu_rmap.c                                                         |    5 
 lib/dim/dim.c                                                          |    5 
 lib/dim/net_dim.c                                                      |    3 
 lib/dim/rdma_dim.c                                                     |    3 
 net/8021q/vlan_dev.c                                                   |    4 
 net/bluetooth/l2cap_core.c                                             |    1 
 net/bridge/br_forward.c                                                |    2 
 net/bridge/br_private_tunnel.h                                         |    8 
 net/can/isotp.c                                                        |    2 
 net/can/j1939/socket.c                                                 |    2 
 net/core/datagram.c                                                    |   15 
 net/core/dev.c                                                         |    4 
 net/core/stream.c                                                      |   12 
 net/ipv4/af_inet.c                                                     |    2 
 net/ipv4/tcp.c                                                         |   14 
 net/ipv4/tcp_bpf.c                                                     |    2 
 net/ipv4/tcp_input.c                                                   |    4 
 net/ipv4/tcp_ipv4.c                                                    |    5 
 net/ipv6/ip6_gre.c                                                     |   13 
 net/key/af_key.c                                                       |   12 
 net/llc/af_llc.c                                                       |    8 
 net/mac80211/trace.h                                                   |    2 
 net/netfilter/core.c                                                   |    6 
 net/netfilter/ipvs/ip_vs_sync.c                                        |    2 
 net/netfilter/nf_conntrack_standalone.c                                |    3 
 net/netfilter/nf_tables_api.c                                          |    4 
 net/netfilter/nft_chain_filter.c                                       |    9 
 net/netfilter/nft_set_rbtree.c                                         |   20 
 net/netlink/af_netlink.c                                               |    8 
 net/nsh/nsh.c                                                          |    8 
 net/packet/af_packet.c                                                 |    6 
 net/smc/smc_close.c                                                    |    4 
 net/smc/smc_rx.c                                                       |    4 
 net/smc/smc_tx.c                                                       |    4 
 net/socket.c                                                           |    2 
 net/sunrpc/svc.c                                                       |    2 
 net/sunrpc/svc_xprt.c                                                  |   34 
 net/sunrpc/svcsock.c                                                   |   41 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                                |   12 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                               |    2 
 net/tipc/bearer.c                                                      |   17 
 net/tipc/bearer.h                                                      |    3 
 net/tipc/link.c                                                        |    9 
 net/tipc/socket.c                                                      |    4 
 net/tipc/udp_media.c                                                   |    5 
 net/tls/tls_main.c                                                     |    3 
 net/unix/af_unix.c                                                     |   22 
 net/vmw_vsock/af_vsock.c                                               |    2 
 net/xfrm/xfrm_interface.c                                              |   54 
 net/xfrm/xfrm_policy.c                                                 |    9 
 samples/bpf/hbm.c                                                      |    1 
 scripts/recordmcount.c                                                 |    6 
 sound/firewire/digi00x/digi00x-stream.c                                |    4 
 sound/pci/hda/hda_generic.c                                            |    7 
 sound/pci/hda/patch_hdmi.c                                             |    5 
 sound/pci/hda/patch_realtek.c                                          |    5 
 sound/soc/fsl/fsl_micfil.c                                             |   14 
 sound/usb/format.c                                                     |    1 
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c                |   31 
 tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh                 |   17 
 253 files changed, 3829 insertions(+), 2742 deletions(-)

Abdun Nihaal (1):
      fs/ntfs3: Fix NULL dereference in ni_write_inode

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Add support for Intel Lunar Lake

Ai Chao (1):
      ALSA: hda/realtek: Add a quirk for HP EliteDesk 805

Alain Volmat (1):
      phy: st: miphy28lp: use _poll_timeout functions for waits

Alan Stern (1):
      USB: usbtmc: Fix direction for 0-length ioctl control messages

Aleksandr Loktionov (1):
      igb: fix bit_shift to be in [1..8] range

Alexander Stein (1):
      regmap: cache: Return error in cache sync operations for REGCACHE_NONE

Andrea Mayer (2):
      selftests: seg6: disable DAD on IPv6 router cfg for srv6_end_dt4_l3vpn_test
      selftets: seg6: disable rp_filter by default in srv6_end_dt4_l3vpn_test

Andreas Gruenbacher (1):
      gfs2: Fix inode height consistency check

Andrew Davis (1):
      serial: 8250_exar: Add support for USR298x PCI Modems

Armin Wolf (1):
      ACPI: EC: Fix oops when removing custom query handlers

Arnaud Pouliquen (1):
      remoteproc: stm32_rproc: Add mutex protection for workqueue

Arnd Bergmann (3):
      clk: tegra20: fix gcc-7 constant overflow warning
      drm/exynos: fix g2d_open/close helper function definitions
      bridge: always declare tunnel functions

Austin Kim (1):
      ext4: remove an unused variable warning with CONFIG_QUOTA=n

Badhri Jagan Sridharan (1):
      usb: typec: altmodes/displayport: fix pin_assignment_show

Bastien Nocera (2):
      HID: logitech-hidpp: Don't use the USB serial for USB devices
      HID: logitech-hidpp: Reconcile USB and Unifying serials

Bharath SM (2):
      SMB3: Close all deferred handles of inode in case of handle lease break
      SMB3: drop reference to cfile before sending oplock break

Bjorn Andersson (1):
      drm/msm/dpu: Add INTF_5 interrupts

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

Christophe JAILLET (2):
      net: mdio: mvusb: Fix an error handling path in mvusb_mdio_probe()
      cassini: Fix a memory leak in the error handling path of cas_init_one()

Chuck Lever (5):
      tracing: Introduce helpers to safely handle dynamic-sized sockaddrs
      SUNRPC: Clean up svc_deferred_class trace events
      SUNRPC: Remove dead code in svc_tcp_release_rqst()
      SUNRPC: Remove svc_rqst::rq_xprt_hlen
      SUNRPC: Fix trace_svc_register() call site

Chunyan Zhang (1):
      iommu/sprd: Release dma buffer to avoid memory leak

Dan Carpenter (1):
      ALSA: firewire-digi00x: prevent potential use after free

Daniel Gabay (1):
      wifi: iwlwifi: pcie: fix possible NULL pointer dereference

Daniel Houldsworth (1):
      platform/x86: hp-wmi: Support touchpad on/off

Dmitry Bogdanov (1):
      scsi: target: iscsit: Free cmds before session free

Dong Chenchen (1):
      net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment()

Doug Berger (2):
      serial: 8250_bcm7271: balance clk_enable calls
      serial: 8250_bcm7271: fix leak in `brcmuart_probe`

Douglas Anderson (1):
      drm/msm/dp: Clean up handling of DP AUX interrupts

Duoming Zhou (1):
      media: netup_unidvb: fix use-after-free at del_timer()

Edward Lo (3):
      fs/ntfs3: Enhance the attribute size check
      fs/ntfs3: Validate MFT flags before replaying logs
      fs/ntfs3: Add length check in indx_get_root

Eli Cohen (1):
      lib: cpu_rmap: Avoid use after free on rmap->obj array entries

Eric Dumazet (8):
      netlink: annotate accesses to nlk->cb_running
      net: annotate sk->sk_err write from do_recvmmsg()
      net: deal with most data-races in sk_wait_event()
      net: add vlan_get_protocol_and_depth() helper
      tcp: add annotations around sk->sk_shutdown accesses
      net: datagram: fix data-races in datagram_poll()
      tcp: fix possible sk_priority leak in tcp_v4_send_reset()
      vlan: fix a potential uninit-value in vlan_dev_hard_start_xmit()

Fae (1):
      platform/x86: hp-wmi: add micmute to hp_wmi_keymap struct

Feng Liu (1):
      virtio_net: Fix error unwinding of XDP initialization

Florian Fainelli (2):
      net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()
      net: bcmgenet: Restore phy_stop() depending upon suspend/close

Florian Westphal (4):
      netfilter: nf_tables: always release netdev hooks from notifier
      netfilter: conntrack: fix possible bug_on with enable_hooks=1
      netfilter: nf_tables: fix nft_trans type confusion
      netfilter: nft_set_rbtree: fix null deref on element insertion

Frank Wang (1):
      usb: typec: tcpm: fix multiple times discover svids error

Gaurav Batra (1):
      powerpc/iommu: Incorrect DDW Table is referenced for SR-IOV device

George Kennedy (1):
      vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF

Greg Kroah-Hartman (1):
      Linux 5.15.113

Grygorii Strashko (1):
      net: phy: dp83867: add w/a for packet errors seen with short cables

Guilherme G. Piccoli (1):
      parisc: Replace regular spinlock with spin_trylock on panic path

Gustav Johansson (1):
      ksmbd: smb2: Allow messages padded to 8byte boundary

Gustavo A. R. Silva (1):
      RDMA/core: Fix multiple -Warray-bounds warnings

Hans de Goede (2):
      wifi: iwlwifi: dvm: Fix memcpy: detected field-spanning write backtrace
      Bluetooth: hci_bcm: Fall back to getting bdaddr from EFI if not set

Hao Zeng (2):
      samples/bpf: Fix fout leak in hbm's run_bpf_prog
      recordmcount: Fix memory leaks in the uwrite function

Hector Martin (1):
      wifi: brcmfmac: cfg80211: Pass the PMK in binary instead of hex

Heiko Carstens (1):
      s390/qdio: fix do_sqbs() inline assembly constraint

Hyunwoo Kim (1):
      wifi: iwlwifi: pcie: Fix integer overflow in iwl_write_to_user_buf

Ilya Leoshkevich (1):
      statfs: enforce statfs[64] structure initialization

Jan Kara (2):
      ext4: fix lockdep warning when enabling MMP
      ext2: Check block size validity during mount

Jani Nikula (1):
      drm/displayid: add displayid_get_header() and check bounds better

Jason Gerecke (2):
      HID: wacom: generic: Set battery quirk only when we see battery data
      HID: wacom: Force pen out of prox if no events have been received in a while

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

Jijie Shao (1):
      net: hns3: fix sending pfc frames after reset issue

Jimmy Assarsson (6):
      can: kvaser_pciefd: Set CAN_STATE_STOPPED in kvaser_pciefd_stop()
      can: kvaser_pciefd: Call request_irq() before enabling interrupts
      can: kvaser_pciefd: Empty SRB buffer in probe
      can: kvaser_pciefd: Clear listen-only bit if not explicitly requested
      can: kvaser_pciefd: Do not send EFLUSH command on TFD interrupt
      can: kvaser_pciefd: Disable interrupts in probe error path

Johannes Berg (3):
      wifi: mac80211: fix min center freq offset tracing
      wifi: iwlwifi: mvm: fix cancel_delayed_work_sync() deadlock
      wifi: iwlwifi: mvm: don't trust firmware n_channels

Jorge Lopez (1):
      platform/x86: Move existing HP drivers to a new hp subdir

Josh Poimboeuf (1):
      sched: Fix KCSAN noinstr violation

Justin Tee (1):
      scsi: lpfc: Prevent lpfc_debugfs_lockstat_write() buffer overflow

Ke Zhang (1):
      serial: arc_uart: fix of_iomap leak in `arc_serial_probe`

Kees Cook (1):
      wifi: ath: Silence memcpy run-time false positive warning

Kemeng Shi (2):
      ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set
      ext4: set goal start correctly in ext4_mb_normalize_request

Keoseong Park (1):
      scsi: ufs: core: Fix I/O hang that occurs when BKOPS fails in W-LUN suspend

Kevin Groeneveld (1):
      spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3

Konrad Dybcio (1):
      arm64: dts: qcom: msm8996: Add missing DWC3 quirks

Konrad Gräfe (1):
      usb: gadget: u_ether: Fix host MAC address case

Krzysztof Kozlowski (2):
      soundwire: qcom: gracefully handle too many ports in DT
      serial: qcom-geni: fix enabling deactivated interrupt

Kumar Kartikeya Dwivedi (1):
      bpf: Annotate data races in bpf_local_storage

Kuniyuki Iwashima (3):
      net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().
      af_unix: Fix a data race of sk->sk_receive_queue->qlen.
      af_unix: Fix data races around sk->sk_shutdown.

Laurent Pinchart (1):
      media: Prefer designated initializers over memset for subdev pad ops

Luke D. Jones (1):
      ALSA: hda/realtek: Add quirk for 2nd ASUS GU603

Manivannan Sadhasivam (1):
      iommu/arm-smmu-qcom: Limit the SMR groups to 128

Marco Migliore (1):
      net: dsa: mv88e6xxx: Fix mv88e6393x EPC write command offset

Marek Vasut (1):
      net: stmmac: Initialize MAC_ONEUS_TIC_COUNTER register

Marijn Suijten (2):
      drm/msm/dpu: Move non-MDP_TOP INTF_INTR offsets out of hwio header
      drm/msm/dpu: Remove duplicate register defines from INTF

Mario Limonciello (3):
      drm/amd: Fix an out of bounds error in BIOS parser
      xhci-pci: Only run d3cold avoidance quirk for s2idle
      thunderbolt: Clear registers properly when auto clear isn't in use

Martin Willi (1):
      Revert "Fix XFRM-I support for nested ESP tunnels"

Mathias Nyman (1):
      xhci: Fix incorrect tracking of free space on transfer rings

Maxim Korotkov (1):
      bnxt: avoid overflow in bnxt_get_nvram_directory()

Maxime Bizon (1):
      usb-storage: fix deadlock when a scsi command timeouts more than once

Michael Ellerman (1):
      powerpc/64s/radix: Fix soft dirty tracking

Michael Kelley (1):
      scsi: storvsc: Don't pass unused PFNs to Hyper-V host

Min Li (1):
      Bluetooth: L2CAP: fix "bad unlock balance" in l2cap_disconnect_rsp

Nagarajan Maran (1):
      wifi: ath11k: Fix SKB corruption in REO destination ring

Nathan Chancellor (1):
      net: pasemi: Fix return type of pasemi_mac_start_tx()

NeilBrown (2):
      SUNRPC: double free xprt_ctxt while still in use
      SUNRPC: always free ctxt when freeing deferred request

Nick Child (1):
      net: Catch invalid index in XPS mapping

Nikhil Mahale (1):
      ALSA: hda: Add NVIDIA codec IDs a3 through a7 to patch table

Nikita Zhandarovich (1):
      drm/i915/dp: prevent potential div-by-zero

Nur Hussein (1):
      drm/tegra: Avoid potential 32-bit integer overflow

Ojaswin Mujoo (1):
      ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()

Oliver Hartkopp (2):
      can: j1939: recvmsg(): allow MSG_CMSG_COMPAT flag
      can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag

Parav Pandit (1):
      virtio-net: Maintain reverse cleanup order

Paul E. McKenney (1):
      refscale: Move shutdown from wait_event() to wait_event_idle()

Philipp Hortmann (1):
      staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE

Pierre Gondois (1):
      firmware: arm_sdei: Fix sleep from invalid context BUG

Ping Cheng (2):
      HID: wacom: Add new Intuos Pro Small (PTH-460) device IDs
      HID: wacom: add three styli to wacom_intuos_get_tool_type

Qiang Ning (1):
      mfd: dln2: Fix memory leak in dln2_probe()

Randy Dunlap (1):
      ARM: 9296/1: HP Jornada 7XX: fix kernel-doc warnings

Rodrigo Siqueira (1):
      drm/amd/display: Use DC_LOG_DC in the trasform pixel function

Rodríguez Barbarin, José Javier (1):
      mcb-pci: Reallocate memory region to avoid memory overlapping

Roy Novich (1):
      linux/dim: Do nothing if no time delta between samples

Ryan C. Underwood (1):
      ALSA: hda/realtek: Apply HP B&O top speaker profile to Pavilion 15

Ryusuke Konishi (1):
      nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()

Sabrina Dubroca (1):
      xfrm: don't check the default policy if the policy allows the packet

Saravana Kannan (1):
      drm/mipi-dsi: Set the fwnode for mipi_dsi_device

Shengjiu Wang (1):
      ASoC: fsl_micfil: Fix error handler with pm_runtime_enable

Simon Horman (1):
      ipvs: Update width of source for ip_vs_sync_conn_options

Srinivas Kandagatla (1):
      drm/msm/dp: unregister audio driver during unbind

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

Tobias Brunner (1):
      af_key: Reject optional tunnel/BEET mode templates in outbound policies

Tomas Krcka (1):
      iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any

Tony Lindgren (1):
      serial: 8250: Reinit port->pm on port specific driver unbind

Udipto Goswami (1):
      usb: dwc3: debugfs: Resume dwc3 before accessing registers

Uwe Kleine-König (1):
      net: fec: Better handle pm_runtime_get() failing in .remove()

Vicki Pfau (1):
      Input: xpad - add constants for GIP interface numbers

Vineeth Vijayan (1):
      s390/cio: include subchannels without devices also for evaluation

Vitaliy Tomin (1):
      serial: Add support for Advantech PCI-1611U card

Weitao Wang (1):
      USB: UHCI: adjust zhaoxin UHCI controllers OverCurrent bit value

Wong Vee Khee (1):
      net: stmmac: switch to use interrupt for hw crosstimestamping

Wyes Karny (1):
      cpupower: Make TSC read per CPU for Mperf monitor

Xin Long (4):
      erspan: get the proto with the md version for collect_md
      tipc: add tipc_bearer_min_mtu to calculate min mtu
      tipc: do not update mtu if msg_max is too small in mtu negotiation
      tipc: check the bearer min mtu properly when setting it by netlink

Xiubo Li (1):
      ceph: force updating the msg pointer in non-split case

Yafang (1):
      bpf: Add preempt_count_{sub,add} into btf id deny list

Ye Bin (1):
      fs/ntfs3: Fix NULL pointer dereference in 'ni_write_inode'

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

t.feng (1):
      ipvlan:Fix out-of-bounds caused by unclear skb->cb

void0red (1):
      ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects

