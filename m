Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3102072942B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbjFIJF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241036AbjFIJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EF0E62;
        Fri,  9 Jun 2023 02:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37AE764C4D;
        Fri,  9 Jun 2023 09:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACCEC4339B;
        Fri,  9 Jun 2023 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686301530;
        bh=/dfQT0b94bsNW16Q35iPeU8jq3wjhwyToI6OZ+CFfHE=;
        h=From:To:Cc:Subject:Date:From;
        b=FB2536dFfpYbcWNJqcPOMYWJ7KFUubxh/pOFKcG1sKn7Ve3sEuS8meNnGZx1konkr
         AeK6RqnnrCoI9fPAds0dXjl3oPcOW0JTy+UkYD9/kaZXAteW8kgK5cbxIg2UDVrlXn
         tp/FzN0igTujOO9fOpP27/eAF9idk6kfd2YWR2mM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.246
Date:   Fri,  9 Jun 2023 11:05:17 +0200
Message-ID: <2023060917-document-rekindle-125d@gregkh>
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

I'm announcing the release of the 5.4.246 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    6 
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi                   |   82 +
 arch/arm/kernel/unwind.c                                 |   25 
 arch/arm/mach-sa1100/assabet.c                           |    2 
 arch/arm/mm/alignment.c                                  |    2 
 arch/arm64/mm/fault.c                                    |    4 
 arch/ia64/kernel/process.c                               |    2 
 arch/ia64/mm/discontig.c                                 |    2 
 arch/ia64/mm/tlb.c                                       |    2 
 arch/mips/lib/dump_tlb.c                                 |    2 
 arch/mips/mm/init.c                                      |    2 
 arch/mips/mm/tlb-r4k.c                                   |    6 
 arch/powerpc/kvm/book3s_64_mmu_radix.c                   |    2 
 arch/powerpc/platforms/52xx/mpc52xx_pic.c                |    2 
 arch/s390/kernel/smp.c                                   |    2 
 arch/x86/boot/boot.h                                     |   36 
 arch/x86/boot/main.c                                     |    2 
 arch/x86/kernel/quirks.c                                 |   10 
 block/blk-merge.c                                        |    2 
 drivers/acpi/acpi_pad.c                                  |    2 
 drivers/acpi/thermal.c                                   |    2 
 drivers/ata/libata-scsi.c                                |   36 
 drivers/atm/zatm.c                                       |    2 
 drivers/base/regmap/regmap.c                             |    6 
 drivers/block/drbd/drbd_nl.c                             |    6 
 drivers/block/nbd.c                                      |    4 
 drivers/block/rbd.c                                      |    2 
 drivers/clk/clk-gate.c                                   |    2 
 drivers/dma/pl330.c                                      |    8 
 drivers/firewire/ohci.c                                  |   14 
 drivers/gpu/drm/bridge/sil-sii8620.c                     |    2 
 drivers/gpu/drm/drm_edid.c                               |    4 
 drivers/gpu/drm/exynos/exynos_drm_dsi.c                  |    6 
 drivers/gpu/drm/i915/gt/intel_lrc.c                      |    2 
 drivers/gpu/drm/i915/intel_uncore.c                      |    2 
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c          |    4 
 drivers/hid/hid-google-hammer.c                          |    2 
 drivers/hid/hid-ids.h                                    |    1 
 drivers/hid/wacom_wac.c                                  |    2 
 drivers/i2c/busses/i2c-rk3x.c                            |    2 
 drivers/ide/ide-acpi.c                                   |    2 
 drivers/ide/ide-atapi.c                                  |    2 
 drivers/ide/ide-io-std.c                                 |    4 
 drivers/ide/ide-io.c                                     |    8 
 drivers/ide/ide-sysfs.c                                  |    2 
 drivers/ide/umc8672.c                                    |    2 
 drivers/iio/adc/mxs-lradc-adc.c                          |   10 
 drivers/iio/dac/Makefile                                 |    2 
 drivers/iio/dac/mcp4725.c                                |   16 
 drivers/iio/light/vcnl4035.c                             |    3 
 drivers/infiniband/core/uverbs_cmd.c                     |    4 
 drivers/infiniband/hw/bnxt_re/bnxt_re.h                  |   14 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                 |  629 +++++++++------
 drivers/infiniband/hw/bnxt_re/main.c                     |  136 +--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c               |    5 
 drivers/infiniband/hw/cxgb4/cm.c                         |    2 
 drivers/infiniband/hw/cxgb4/cq.c                         |    2 
 drivers/infiniband/hw/efa/efa_verbs.c                    |    2 
 drivers/infiniband/hw/mlx4/qp.c                          |    6 
 drivers/infiniband/hw/mlx5/cq.c                          |    6 
 drivers/infiniband/hw/mlx5/devx.c                        |    2 
 drivers/infiniband/hw/mthca/mthca_qp.c                   |   10 
 drivers/input/serio/serio_raw.c                          |    2 
 drivers/iommu/amd_iommu.c                                |    3 
 drivers/iommu/rockchip-iommu.c                           |   14 
 drivers/mailbox/mailbox-test.c                           |   13 
 drivers/md/dm-io.c                                       |    2 
 drivers/md/dm-ioctl.c                                    |    2 
 drivers/md/dm-snap-persistent.c                          |    2 
 drivers/md/dm-table.c                                    |    2 
 drivers/md/raid5.c                                       |    2 
 drivers/media/dvb-core/dvb_ca_en50221.c                  |   49 +
 drivers/media/dvb-core/dvb_demux.c                       |    4 
 drivers/media/dvb-core/dvb_frontend.c                    |   16 
 drivers/media/dvb-core/dvb_net.c                         |   38 
 drivers/media/dvb-frontends/mn88443x.c                   |    2 
 drivers/media/dvb-frontends/rtl2832.c                    |    2 
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c       |   17 
 drivers/media/platform/rcar-vin/rcar-dma.c               |    1 
 drivers/media/tuners/qt1010.c                            |    4 
 drivers/media/usb/dvb-usb-v2/ce6230.c                    |    8 
 drivers/media/usb/dvb-usb-v2/ec168.c                     |   12 
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c                  |   20 
 drivers/media/usb/dvb-usb/az6027.c                       |   12 
 drivers/media/usb/dvb-usb/digitv.c                       |    4 
 drivers/media/usb/dvb-usb/dw2102.c                       |    2 
 drivers/media/usb/gspca/vicam.c                          |    2 
 drivers/media/usb/ttusb-dec/ttusb_dec.c                  |    3 
 drivers/media/usb/uvc/uvc_video.c                        |    8 
 drivers/memstick/host/jmb38x_ms.c                        |    2 
 drivers/memstick/host/tifm_ms.c                          |    2 
 drivers/misc/fastrpc.c                                   |    7 
 drivers/mmc/host/sdhci.c                                 |    2 
 drivers/mmc/host/vub300.c                                |    3 
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h               |    8 
 drivers/mtd/nand/raw/marvell_nand.c                      |   10 
 drivers/mtd/nand/raw/nand_ecc.c                          |    2 
 drivers/mtd/nand/raw/s3c2410.c                           |    2 
 drivers/mtd/parsers/afs.c                                |    4 
 drivers/mtd/ubi/eba.c                                    |    2 
 drivers/net/can/janz-ican3.c                             |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                         |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                |   12 
 drivers/net/ethernet/broadcom/bnx2.c                     |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h         |    1 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c |    2 
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c      |    4 
 drivers/net/ethernet/neterion/s2io.c                     |    2 
 drivers/net/ethernet/qlogic/qla3xxx.c                    |    2 
 drivers/net/ethernet/sun/cassini.c                       |    6 
 drivers/net/ethernet/sun/niu.c                           |    6 
 drivers/net/usb/qmi_wwan.c                               |    2 
 drivers/net/wan/z85230.c                                 |    2 
 drivers/net/wireless/ath/ath10k/core.c                   |    2 
 drivers/net/wireless/ath/ath6kl/init.c                   |    2 
 drivers/net/wireless/ath/ath9k/init.c                    |    2 
 drivers/net/wireless/broadcom/b43/b43.h                  |    2 
 drivers/net/wireless/broadcom/b43/debugfs.c              |    2 
 drivers/net/wireless/broadcom/b43/dma.c                  |    2 
 drivers/net/wireless/broadcom/b43/lo.c                   |    2 
 drivers/net/wireless/broadcom/b43/phy_n.c                |    2 
 drivers/net/wireless/broadcom/b43/xmit.c                 |   12 
 drivers/net/wireless/broadcom/b43legacy/b43legacy.h      |    2 
 drivers/net/wireless/broadcom/b43legacy/debugfs.c        |    2 
 drivers/net/wireless/broadcom/b43legacy/main.c           |    2 
 drivers/net/wireless/intel/iwlegacy/3945.c               |    2 
 drivers/net/wireless/intel/iwlegacy/4965-mac.c           |    2 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h         |    1 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    |    4 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c      |    4 
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c     |   10 
 drivers/pci/pcie/aer.c                                   |    2 
 drivers/platform/x86/hdaps.c                             |    4 
 drivers/scsi/Kconfig                                     |    2 
 drivers/scsi/dc395x.c                                    |    2 
 drivers/scsi/dpt_i2o.c                                   |  278 ------
 drivers/scsi/dpti.h                                      |    1 
 drivers/scsi/pm8001/pm8001_hwi.c                         |    2 
 drivers/scsi/pm8001/pm80xx_hwi.c                         |    2 
 drivers/scsi/scsi_lib.c                                  |    2 
 drivers/scsi/stex.c                                      |    4 
 drivers/ssb/driver_chipcommon.c                          |    4 
 drivers/tty/cyclades.c                                   |    2 
 drivers/tty/isicom.c                                     |    2 
 drivers/tty/serial/fsl_lpuart.c                          |   44 -
 drivers/usb/gadget/function/f_fs.c                       |    2 
 drivers/usb/musb/cppi_dma.c                              |    2 
 drivers/usb/storage/sddr55.c                             |    4 
 drivers/vhost/net.c                                      |    4 
 drivers/video/fbdev/core/bitblit.c                       |    3 
 drivers/video/fbdev/core/modedb.c                        |    5 
 drivers/video/fbdev/matrox/matroxfb_maven.c              |    6 
 drivers/video/fbdev/pm3fb.c                              |    6 
 drivers/video/fbdev/riva/riva_hw.c                       |    3 
 drivers/video/fbdev/stifb.c                              |    1 
 drivers/virtio/virtio_ring.c                             |    6 
 drivers/watchdog/menz69_wdt.c                            |   16 
 fs/afs/dir.c                                             |    2 
 fs/afs/security.c                                        |    2 
 fs/dlm/netlink.c                                         |    2 
 fs/ext4/ext4.h                                           |    5 
 fs/ext4/inode.c                                          |   34 
 fs/ext4/xattr.c                                          |   41 
 fs/fat/dir.c                                             |    2 
 fs/fuse/control.c                                        |    4 
 fs/fuse/cuse.c                                           |    2 
 fs/fuse/file.c                                           |    2 
 fs/gfs2/aops.c                                           |    2 
 fs/gfs2/bmap.c                                           |    2 
 fs/gfs2/lops.c                                           |    2 
 fs/hfsplus/unicode.c                                     |    2 
 fs/isofs/namei.c                                         |    4 
 fs/jffs2/erase.c                                         |    2 
 fs/nfsd/nfsctl.c                                         |    2 
 fs/ocfs2/alloc.c                                         |    4 
 fs/ocfs2/dir.c                                           |   14 
 fs/ocfs2/dlm/dlmcommon.h                                 |    4 
 fs/ocfs2/extent_map.c                                    |    4 
 fs/ocfs2/namei.c                                         |    2 
 fs/ocfs2/refcounttree.c                                  |    2 
 fs/ocfs2/xattr.c                                         |    2 
 fs/omfs/file.c                                           |    2 
 fs/overlayfs/copy_up.c                                   |    2 
 fs/ubifs/commit.c                                        |    6 
 fs/ubifs/dir.c                                           |    2 
 fs/ubifs/file.c                                          |    4 
 fs/ubifs/journal.c                                       |    4 
 fs/ubifs/lpt.c                                           |    2 
 fs/ubifs/tnc.c                                           |    6 
 fs/ubifs/tnc_misc.c                                      |    4 
 fs/udf/balloc.c                                          |    2 
 fs/xfs/xfs_bmap_util.c                                   |    2 
 include/linux/bitops.h                                   |    1 
 include/media/dvb_net.h                                  |    4 
 include/net/sock.h                                       |    4 
 kernel/async.c                                           |    4 
 kernel/audit.c                                           |    2 
 kernel/dma/debug.c                                       |    2 
 kernel/events/core.c                                     |    2 
 kernel/events/uprobes.c                                  |    2 
 kernel/exit.c                                            |    2 
 kernel/extable.c                                         |    3 
 kernel/futex.c                                           |   12 
 kernel/locking/lockdep.c                                 |   14 
 kernel/trace/ring_buffer.c                               |    2 
 kernel/trace/trace_probe.h                               |    2 
 lib/dynamic_debug.c                                      |    2 
 lib/radix-tree.c                                         |    2 
 lib/test_firmware.c                                      |   19 
 mm/frontswap.c                                           |    2 
 mm/ksm.c                                                 |    2 
 mm/memcontrol.c                                          |    2 
 mm/mempolicy.c                                           |    4 
 mm/percpu.c                                              |    2 
 mm/slub.c                                                |    4 
 mm/swap.c                                                |    4 
 net/atm/resources.c                                      |    2 
 net/core/sock.c                                          |    2 
 net/dccp/options.c                                       |    2 
 net/ipv4/af_inet.c                                       |    2 
 net/ipv4/inet_connection_sock.c                          |    1 
 net/ipv4/netfilter/nf_socket_ipv4.c                      |    6 
 net/ipv4/tcp.c                                           |    9 
 net/ipv6/ip6_flowlabel.c                                 |    2 
 net/ipv6/netfilter/nf_socket_ipv6.c                      |    2 
 net/netfilter/nf_conntrack_ftp.c                         |    2 
 net/netfilter/nf_conntrack_netlink.c                     |    4 
 net/netfilter/nfnetlink_log.c                            |    2 
 net/netfilter/nfnetlink_queue.c                          |    4 
 net/netlink/af_netlink.c                                 |    2 
 net/netrom/nr_subr.c                                     |    7 
 net/packet/af_packet.c                                   |    8 
 net/packet/diag.c                                        |    2 
 net/sched/cls_flow.c                                     |    2 
 net/sched/cls_flower.c                                   |   20 
 net/sched/sch_api.c                                      |   16 
 net/sched/sch_cake.c                                     |    2 
 net/sched/sch_cbq.c                                      |    2 
 net/sched/sch_fq_codel.c                                 |    2 
 net/sched/sch_hfsc.c                                     |    2 
 net/sched/sch_htb.c                                      |    2 
 net/sched/sch_ingress.c                                  |   16 
 net/sched/sch_sfq.c                                      |    2 
 net/sunrpc/xprtsock.c                                    |    4 
 net/tls/tls_sw.c                                         |    2 
 net/xfrm/xfrm_policy.c                                   |   11 
 security/selinux/Makefile                                |    6 
 sound/core/control_compat.c                              |    2 
 sound/core/oss/pcm_plugin.h                              |   16 
 sound/isa/sb/sb16_csp.c                                  |    2 
 sound/soc/codecs/ssm2602.c                               |   15 
 sound/soc/dwc/dwc-i2s.c                                  |    4 
 sound/usb/endpoint.c                                     |    2 
 253 files changed, 1422 insertions(+), 1022 deletions(-)

Adam Borowski (1):
      ACPI: thermal: drop an always true check

Andreas Svensson (1):
      net: dsa: mv88e6xxx: Increase wait after reset deactivation

Andy Shevchenko (1):
      ocfs2/dlm: move BITS_TO_BYTES() to bitops.h for wider use

Arnd Bergmann (5):
      mtd: rawnand: ingenic: fix empty stub helper definitions
      wifi: b43: fix incorrect __packed annotation
      ALSA: oss: avoid missing-prototype warnings
      atm: hide unused procfs functions
      flow_dissector: work around stack frame size warning

Bart Van Assche (1):
      scsi: stex: Fix gcc 13 warnings

Ben Hutchings (2):
      scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)
      scsi: dpt_i2o: Do not process completions with invalid addresses

Benedict Wong (1):
      xfrm: Check if_id in inbound policy/secpath match

Cambda Zhu (1):
      tcp: Return user_mss for TCP_MAXSEG in CLOSE/LISTEN state if user_mss set

Chao Wang (1):
      iommu/rockchip: Fix unwind goto issue

Chris Packham (2):
      mtd: rawnand: marvell: ensure timing values are written
      mtd: rawnand: marvell: don't set the NAND frequency select

Damien Le Moal (1):
      ata: libata-scsi: Use correct device no in ata_find_dev()

Dan Carpenter (1):
      mailbox: mailbox-test: fix a locking issue in mbox_test_message_write()

Dario Binacchi (1):
      ARM: dts: stm32: add pin map for CAN controller on stm32f7

Deren Wu (1):
      mmc: vub300: fix invalid response handling

Devesh Sharma (2):
      RDMA/bnxt_re: Enable SRIOV VF support on Broadcom's 57500 adapter series
      RDMA/bnxt_re: Refactor queue pair creation code

Eric Dumazet (3):
      netrom: fix info-leak in nr_write_internal()
      af_packet: do not use READ_ONCE() in packet_bind()
      tcp: deny tcp_disconnect() when threads are waiting

Frank Li (1):
      iio: light: vcnl4035: fixed chip ID check

Greg Kroah-Hartman (1):
      Linux 5.4.246

Haibo Li (1):
      ARM: 9295/1: unwind:fix unwind abort for uleb128 case

Hangyu Hua (1):
      net/sched: flower: fix possible OOB write in fl_set_geneve_opt()

Helge Deller (3):
      fbdev: modedb: Add 1920x1080 at 60 Hz video mode
      fbdev: stifb: Fix info entry in sti_struct on error path
      fbcon: Fix null-ptr-deref in soft_cursor

Hyunwoo Kim (3):
      media: ttusb-dec: fix memory leak in ttusb_dec_exit_dvb()
      media: dvb-core: Fix use-after-free due on race condition at dvb_net
      media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221

Ivan Orlov (1):
      nbd: Fix debugfs_create_dir error checking

Jakub Kicinski (1):
      wifi: rtlwifi: remove always-true condition pointed out by GCC 12

Jiakai Luo (1):
      iio: adc: mxs-lradc: fix the order of two cleanup operations

Jim Wylder (1):
      regmap: Account for register length when chunking

Joao Martins (1):
      iommu/amd: Don't block updates to GATag if guest mode is on

Johannes Thumshirn (1):
      watchdog: menz069_wdt: fix watchdog initialisation

Kalesh AP (1):
      RDMA/bnxt_re: Fix return value of bnxt_re_process_raw_qp_pkt_rx

Kees Cook (2):
      x86/boot: Wrap literal addresses in absolute_pointer()
      treewide: Remove uninitialized_var() usage

Krzysztof Kozlowski (1):
      media: mn88443x: fix !CONFIG_OF error by drop of_match_ptr from ID table

Kuniyuki Iwashima (1):
      af_packet: Fix data-races of pkt_sk(sk)->num.

Lee Jones (1):
      mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()

Linus Torvalds (2):
      gcc-12: disable '-Wdangling-pointer' warning for now
      drm/edid: fix objtool warning in drm_cvt_modes()

Lukas Bulwahn (1):
      iio: dac: build ad5758 driver when AD5758 is selected

Lyude Paul (1):
      drm/edid: Fix uninitialized variable in drm_cvt_modes()

Marek Vasut (1):
      iio: dac: mcp4725: Fix i2c_master_send() return value handling

Martin Liška (1):
      eth: sun: cassini: remove dead code

Maxim Kochetkov (1):
      ASoC: dwc: limit the number of overrun messages

Min-Hua Chen (1):
      arm64/mm: mark private VM_FAULT_X defines as vm_fault_t

Mirsad Goran Todorovac (1):
      test_firmware: fix the memory leak of the allocated firmware buffer

Nathan Chancellor (2):
      kernel/extable.c: use address-of operator on section symbols
      lib/dynamic_debug.c: use address-of operator on section symbols

Nikita Zhandarovich (1):
      HID: wacom: avoid integer overflow in wacom_intuos_inout()

Niklas Söderlund (1):
      media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNATE

Paul Moore (1):
      selinux: don't use make's grouped targets feature yet

Paweł Anikiel (1):
      ASoC: ssm2602: Add workaround for playback distortions

Pedro Tammela (1):
      net/netlink: fix NETLINK_LIST_MEMBERSHIPS length report

Peilin Ye (4):
      net/sched: sch_ingress: Only create under TC_H_INGRESS
      net/sched: sch_clsact: Only create under TC_H_CLSACT
      net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT) for ingress (clsact) Qdiscs
      net/sched: Prohibit regrafting ingress or clsact Qdiscs

Pietro Borrello (1):
      tracing/probe: trace_probe_primary_from_call(): checked list_first_entry

Ping-Ke Shih (1):
      wifi: rtlwifi: 8192de: correct checking of IQK reload

Raju Rangoju (1):
      amd-xgbe: fix the false linkup in xgbe_phy_status

Randy Dunlap (1):
      dmaengine: pl330: rename _start to prevent build error

Richard Acayan (2):
      misc: fastrpc: return -EPIPE to invocations on device removal
      misc: fastrpc: reject new invocations during device removal

Sebastian Krzyszkowiak (1):
      net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818

Selvin Xavier (1):
      RDMA/bnxt_re: Remove the qp from list only if the qp destroy succeeds

Shay Drory (1):
      net/mlx5: fw_tracer, Fix event handling

Sherry Sun (1):
      tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK

Sung-Chi Li (1):
      HID: google: add jewel USB id

Takashi Iwai (1):
      media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()

Theodore Ts'o (4):
      ext4: add EA_INODE checking to ext4_iget()
      ext4: set lockdep subclass for the ea_inode in ext4_xattr_inode_cache_find()
      ext4: disallow ea_inodes with extended attributes
      ext4: add lockdep annotations for i_data_sem for ea_inode's

Tom Rix (1):
      netfilter: conntrack: define variables exp_nat_nla_policy and any_addr with CONFIG_NF_NAT

Uttkarsh Aggarwal (1):
      usb: gadget: f_fs: Add unbind event before functionfs_unbind

Vladislav Efanov (1):
      udp6: Fix race condition in udp6_sendmsg & connect

Wei Chen (6):
      media: dvb-usb: az6027: fix three null-ptr-deref in az6027_i2c_xfer()
      media: dvb-usb-v2: ec168: fix null-ptr-deref in ec168_i2c_xfer()
      media: dvb-usb-v2: ce6230: fix null-ptr-deref in ce6230_i2c_master_xfer()
      media: dvb-usb: digitv: fix null-ptr-deref in digitv_i2c_xfer()
      media: dvb-usb: dw2102: fix uninit-value in su3000_read_mac_address
      media: netup_unidvb: fix irq init by register it at the end of probe

Wenchao Hao (1):
      scsi: core: Decrease scsi_device's iorequest_cnt if dispatch failed

Yonatan Nachum (1):
      RDMA/efa: Fix unsupported page sizes in device

YongSu Yoo (2):
      media: dvb_demux: fix a bug for the continuity counter
      media: dvb_ca_en50221: fix a size write bug

YueHaibing (1):
      RDMA/bnxt_re: Remove set but not used variable 'dev_attr'

Yun Lu (1):
      wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value

Zhang Shurong (1):
      media: dvb-usb-v2: rtl28xxu: fix null-ptr-deref in rtl28xxu_i2c_xfer

Zhengchao Shao (1):
      net: sched: fix NULL pointer dereference in mq_attach

