Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B5F729457
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbjFIJGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbjFIJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DBAF5;
        Fri,  9 Jun 2023 02:05:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5466765522;
        Fri,  9 Jun 2023 09:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F35EC433D2;
        Fri,  9 Jun 2023 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686301539;
        bh=KWcJLY51AnJQcm2JQ8E1hOtv21fB9m4qVcRX6Mvjvbs=;
        h=From:To:Cc:Subject:Date:From;
        b=N7tpVcK4G/z+Ls9TJoCgvMozmLomNF4KU/V7If+itPkJsQkYRJyMfMhrqQikQCAud
         1oKt2TEwCZBSxkNTaus3/iyTCCDMuyvVp+hJfXkoLLMReyjDZbuV+61sXtp3ahhm+a
         s7wgjodGMI1RTL0sJWxT0P/n7wi6C1LeKQtpLdh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.116
Date:   Fri,  9 Jun 2023 11:05:29 +0200
Message-ID: <2023060929-pox-clear-88ec@gregkh>
X-Mailer: git-send-email 2.41.0
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

I'm announcing the release of the 5.15.116 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml |    2 
 Documentation/devicetree/bindings/sound/tas2562.yaml                |    6 
 Documentation/devicetree/bindings/sound/tas2764.yaml                |    6 
 Documentation/devicetree/bindings/sound/tas2770.yaml                |    6 
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml                |    2 
 Makefile                                                            |    2 
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi                              |   82 ++
 arch/arm/configs/multi_v7_defconfig                                 |    1 
 arch/arm/kernel/unwind.c                                            |   25 
 arch/arm64/kernel/vdso.c                                            |    2 
 arch/arm64/mm/fault.c                                               |    4 
 arch/powerpc/platforms/pseries/iommu.c                              |   13 
 arch/riscv/mm/init.c                                                |    2 
 arch/s390/kernel/topology.c                                         |   32 -
 arch/um/drivers/Makefile                                            |    4 
 arch/um/drivers/harddog.h                                           |    9 
 arch/um/drivers/harddog_kern.c                                      |    7 
 arch/um/drivers/harddog_user.c                                      |    1 
 arch/um/drivers/harddog_user_exp.c                                  |    9 
 arch/x86/boot/boot.h                                                |   36 -
 arch/x86/boot/main.c                                                |    2 
 arch/x86/kvm/x86.c                                                  |    3 
 block/blk-iocost.c                                                  |    2 
 block/blk-settings.c                                                |    3 
 crypto/asymmetric_keys/public_key.c                                 |   38 -
 drivers/acpi/resource.c                                             |   12 
 drivers/ata/libata-scsi.c                                           |   34 -
 drivers/base/regmap/regmap.c                                        |    6 
 drivers/block/nbd.c                                                 |    4 
 drivers/block/rnbd/rnbd-proto.h                                     |    2 
 drivers/char/tpm/tpm_tis_core.c                                     |    7 
 drivers/dma/at_xdmac.c                                              |   26 
 drivers/dma/pl330.c                                                 |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                          |   39 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                           |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                              |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c                    |   10 
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c                     |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c                |    5 
 drivers/gpu/drm/ast/ast_main.c                                      |    9 
 drivers/gpu/drm/msm/msm_iommu.c                                     |    7 
 drivers/gpu/drm/rcar-du/Kconfig                                     |   25 
 drivers/hid/hid-google-hammer.c                                     |    2 
 drivers/hid/hid-ids.h                                               |    1 
 drivers/hid/wacom_wac.c                                             |    2 
 drivers/iio/accel/st_accel_core.c                                   |    4 
 drivers/iio/adc/ad7192.c                                            |    8 
 drivers/iio/adc/ad_sigma_delta.c                                    |    4 
 drivers/iio/adc/mxs-lradc-adc.c                                     |   10 
 drivers/iio/dac/Makefile                                            |    2 
 drivers/iio/dac/mcp4725.c                                           |   16 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c                  |   10 
 drivers/iio/light/vcnl4035.c                                        |    3 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                            |    4 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                            |   11 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                           |   12 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                            |    7 
 drivers/infiniband/hw/efa/efa_verbs.c                               |    2 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                          |    8 
 drivers/infiniband/hw/hns/hns_roce_mr.c                             |   43 +
 drivers/infiniband/hw/irdma/hw.c                                    |   31 -
 drivers/infiniband/hw/irdma/utils.c                                 |  150 +++++
 drivers/infiniband/hw/irdma/verbs.c                                 |   66 +-
 drivers/infiniband/hw/irdma/verbs.h                                 |   13 
 drivers/iommu/amd/iommu.c                                           |    5 
 drivers/iommu/rockchip-iommu.c                                      |   14 
 drivers/mailbox/mailbox-test.c                                      |   13 
 drivers/md/raid5.c                                                  |    2 
 drivers/media/dvb-core/dvb_ca_en50221.c                             |   49 +
 drivers/media/dvb-core/dvb_demux.c                                  |    4 
 drivers/media/dvb-core/dvb_frontend.c                               |   16 
 drivers/media/dvb-core/dvb_net.c                                    |   38 +
 drivers/media/dvb-core/dvbdev.c                                     |   84 ++-
 drivers/media/dvb-frontends/mn88443x.c                              |    2 
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c                  |   17 
 drivers/media/platform/rcar-vin/rcar-dma.c                          |    4 
 drivers/media/usb/dvb-usb-v2/ce6230.c                               |    8 
 drivers/media/usb/dvb-usb-v2/ec168.c                                |   12 
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c                             |   20 
 drivers/media/usb/dvb-usb/az6027.c                                  |   12 
 drivers/media/usb/dvb-usb/digitv.c                                  |    4 
 drivers/media/usb/dvb-usb/dw2102.c                                  |    2 
 drivers/media/usb/ttusb-dec/ttusb_dec.c                             |    3 
 drivers/media/usb/uvc/uvc_driver.c                                  |   16 
 drivers/misc/fastrpc.c                                              |    7 
 drivers/mmc/core/pwrseq_sd8787.c                                    |   34 -
 drivers/mmc/host/vub300.c                                           |    3 
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h                          |    8 
 drivers/mtd/nand/raw/marvell_nand.c                                 |   10 
 drivers/net/dsa/mv88e6xxx/chip.c                                    |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                           |   12 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c                 |   11 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                   |   35 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c                      |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c            |   13 
 drivers/net/usb/qmi_wwan.c                                          |    2 
 drivers/net/wireless/ath/ath6kl/htc.h                               |   19 
 drivers/net/wireless/ath/ath6kl/htc_mbox.c                          |   15 
 drivers/net/wireless/broadcom/b43/b43.h                             |    2 
 drivers/net/wireless/broadcom/b43legacy/b43legacy.h                 |    2 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h                    |    1 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c               |    4 
 drivers/nvme/host/hwmon.c                                           |    4 
 drivers/nvme/host/multipath.c                                       |    1 
 drivers/nvme/host/nvme.h                                            |    5 
 drivers/nvme/host/pci.c                                             |    6 
 drivers/platform/x86/intel_scu_pcidrv.c                             |    1 
 drivers/s390/crypto/pkey_api.c                                      |    3 
 drivers/scsi/Kconfig                                                |    2 
 drivers/scsi/dpt_i2o.c                                              |  278 ----------
 drivers/scsi/dpti.h                                                 |    1 
 drivers/scsi/scsi_lib.c                                             |    2 
 drivers/scsi/stex.c                                                 |    4 
 drivers/tty/serial/8250/8250_tegra.c                                |    4 
 drivers/tty/serial/fsl_lpuart.c                                     |   44 -
 drivers/usb/cdns3/cdns3-gadget.c                                    |   60 ++
 drivers/usb/cdns3/cdns3-gadget.h                                    |    9 
 drivers/usb/gadget/function/f_fs.c                                  |    2 
 drivers/video/fbdev/core/bitblit.c                                  |    3 
 drivers/video/fbdev/core/modedb.c                                   |    5 
 drivers/video/fbdev/imsttfb.c                                       |   15 
 drivers/video/fbdev/stifb.c                                         |    1 
 drivers/watchdog/menz69_wdt.c                                       |   16 
 fs/btrfs/ctree.c                                                    |    2 
 fs/btrfs/disk-io.c                                                  |    2 
 fs/ext4/ext4.h                                                      |    5 
 fs/ext4/inode.c                                                     |   34 +
 fs/ext4/super.c                                                     |   24 
 fs/ext4/xattr.c                                                     |   41 -
 fs/gfs2/super.c                                                     |    8 
 fs/ksmbd/smb2pdu.c                                                  |   27 
 include/media/dvb_net.h                                             |    4 
 include/media/dvbdev.h                                              |   15 
 include/net/sock.h                                                  |    4 
 kernel/trace/trace_probe.h                                          |    2 
 lib/test_firmware.c                                                 |   19 
 net/atm/resources.c                                                 |    2 
 net/core/rtnetlink.c                                                |    8 
 net/core/sock.c                                                     |    2 
 net/ipv4/af_inet.c                                                  |    2 
 net/ipv4/inet_connection_sock.c                                     |    1 
 net/ipv4/tcp.c                                                      |    9 
 net/mac80211/chan.c                                                 |    2 
 net/netfilter/nf_conntrack_netlink.c                                |    4 
 net/netlink/af_netlink.c                                            |    2 
 net/netrom/nr_subr.c                                                |    7 
 net/packet/af_packet.c                                              |    8 
 net/packet/diag.c                                                   |    2 
 net/sched/cls_flower.c                                              |    3 
 net/sched/sch_api.c                                                 |   16 
 net/sched/sch_ingress.c                                             |   16 
 net/xfrm/xfrm_policy.c                                              |   11 
 security/selinux/Makefile                                           |    6 
 sound/core/oss/pcm_plugin.h                                         |   16 
 sound/pci/hda/hda_intel.c                                           |   21 
 sound/pci/hda/patch_hdmi.c                                          |   22 
 sound/soc/codecs/ssm2602.c                                          |   15 
 sound/soc/dwc/dwc-i2s.c                                             |    4 
 tools/testing/selftests/net/mptcp/Makefile                          |    2 
 tools/testing/selftests/net/mptcp/diag.sh                           |    4 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh                  |    4 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                     |    4 
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                      |   40 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh                  |    4 
 tools/testing/selftests/net/mptcp/pm_netlink.sh                     |    4 
 tools/testing/selftests/net/mptcp/simult_flows.sh                   |    4 
 167 files changed, 1545 insertions(+), 780 deletions(-)

Alexander Gordeev (1):
      s390/topology: honour nr_cpu_ids when adding CPUs

Alexandre Ghiti (1):
      riscv: Fix unused variable warning when BUILTIN_DTB is set

Andreas Svensson (1):
      net: dsa: mv88e6xxx: Increase wait after reset deactivation

Arnd Bergmann (6):
      mtd: rawnand: ingenic: fix empty stub helper definitions
      wifi: b43: fix incorrect __packed annotation
      ALSA: oss: avoid missing-prototype warnings
      atm: hide unused procfs functions
      drm/rcar: stop using 'imply' for dependencies
      ARM: defconfig: drop CONFIG_DRM_RCAR_LVDS

Bart Van Assche (1):
      scsi: stex: Fix gcc 13 warnings

Bas Nieuwenhuizen (1):
      drm/amdgpu/gfx10: Disable gfxoff before disabling powergating.

Ben Hutchings (2):
      scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)
      scsi: dpt_i2o: Do not process completions with invalid addresses

Benedict Wong (1):
      xfrm: Check if_id in inbound policy/secpath match

Bob Peterson (1):
      gfs2: Don't deref jdesc in evict

Cambda Zhu (1):
      tcp: Return user_mss for TCP_MAXSEG in CLOSE/LISTEN state if user_mss set

Chao Wang (1):
      iommu/rockchip: Fix unwind goto issue

Chengchang Tang (1):
      RDMA/hns: Fix base address table allocation

Chong Li (1):
      drm/amdgpu: release gpu full access after "amdgpu_device_ip_late_init"

Chris Packham (2):
      mtd: rawnand: marvell: ensure timing values are written
      mtd: rawnand: marvell: don't set the NAND frequency select

Christoph Hellwig (1):
      nvme-multipath: don't call blk_mark_disk_dead in nvme_mpath_remove_disk

Christophe JAILLET (1):
      serial: 8250_tegra: Fix an error handling path in tegra_uart_probe()

Damien Le Moal (2):
      ata: libata-scsi: Use correct device no in ata_find_dev()
      block: fix revalidate performance regression

Dan Carpenter (2):
      dmaengine: at_xdmac: fix potential Oops in at_xdmac_prep_interleaved()
      mailbox: mailbox-test: fix a locking issue in mbox_test_message_write()

Daniel Smith (1):
      nvme-pci: Add quirk for Teamgroup MP33 SSD

Dario Binacchi (1):
      ARM: dts: stm32: add pin map for CAN controller on stm32f7

Deren Wu (1):
      mmc: vub300: fix invalid response handling

Dmytro Linkin (1):
      net/mlx5e: Don't attach netdev profile while handling internal error

Eric Dumazet (3):
      netrom: fix info-leak in nr_write_internal()
      af_packet: do not use READ_ONCE() in packet_bind()
      tcp: deny tcp_disconnect() when threads are waiting

Filipe Manana (1):
      btrfs: abort transaction when sibling keys check fails for leaves

Frank Li (3):
      iio: light: vcnl4035: fixed chip ID check
      usb: cdns3: allocate TX FIFO size according to composite EP number
      usb: cdns3: fix NCM gadget RX speed 20x slow than expection at iMX8QM

Gaurav Batra (1):
      powerpc/iommu: Limit number of TCEs to 512 for H_STUFF_TCE hcall

Geert Uytterhoeven (1):
      dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix adi,ad7476 compatible value

Greg Kroah-Hartman (1):
      Linux 5.15.116

Guchun Chen (1):
      drm/amdgpu: skip disabling fence driver src_irqs when device is unplugged

Guoqing Jiang (1):
      block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE

Haibo Li (1):
      ARM: 9295/1: unwind:fix unwind abort for uleb128 case

Hangyu Hua (1):
      net/sched: flower: fix possible OOB write in fl_set_geneve_opt()

Hans de Goede (1):
      iio: accel: st_accel: Fix invalid mount_matrix on devices without ACPI _ONT method

Helge Deller (3):
      fbdev: modedb: Add 1920x1080 at 60 Hz video mode
      fbdev: stifb: Fix info entry in sti_struct on error path
      fbcon: Fix null-ptr-deref in soft_cursor

Holger Dengler (1):
      s390/pkey: zeroize key blobs

Hristo Venev (1):
      nvme-pci: add quirk for missing secondary temperature thresholds

Hyunwoo Kim (4):
      media: ttusb-dec: fix memory leak in ttusb_dec_exit_dvb()
      media: dvb-core: Fix use-after-free due on race condition at dvb_net
      media: dvb-core: Fix use-after-free due to race at dvb_register_device()
      media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221

Ivan Orlov (1):
      nbd: Fix debugfs_create_dir error checking

Jammy Huang (1):
      drm/ast: Fix ARM compatibility

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: fix timestamp reset

Jiakai Luo (1):
      iio: adc: mxs-lradc: fix the order of two cleanup operations

Jim Wylder (1):
      regmap: Account for register length when chunking

Jiri Slaby (SUSE) (1):
      block/blk-iocost (gcc13): keep large values in a new enum

Joao Martins (1):
      iommu/amd: Don't block updates to GATag if guest mode is on

Johannes Berg (2):
      um: harddog: fix modular build
      wifi: mac80211: simplify chanctx allocation

Johannes Thumshirn (1):
      watchdog: menz069_wdt: fix watchdog initialisation

Jon Pan-Doh (1):
      iommu/amd: Fix domain flush size when syncing iotlb

Julian Winkler (1):
      platform/x86: intel_scu_pcidrv: Add back PCI ID for Medfield

Kalesh AP (2):
      RDMA/bnxt_re: Fix a possible memory leak
      RDMA/bnxt_re: Fix return value of bnxt_re_process_raw_qp_pkt_rx

Kees Cook (2):
      x86/boot: Wrap literal addresses in absolute_pointer()
      ath6kl: Use struct_group() to avoid size-mismatched casting

Krzysztof Kozlowski (1):
      media: mn88443x: fix !CONFIG_OF error by drop of_match_ptr from ID table

Kuniyuki Iwashima (1):
      af_packet: Fix data-races of pkt_sk(sk)->num.

Laurent Pinchart (1):
      media: uvcvideo: Don't expose unsupported formats to userspace

Lee Jones (1):
      mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()

Lino Sanfilippo (1):
      tpm, tpm_tis: Request threaded interrupt handler

Linus Walleij (1):
      arm64: vdso: Pass (void *) to virt_to_page()

Lukas Bulwahn (1):
      iio: dac: build ad5758 driver when AD5758 is selected

Marek Vasut (3):
      iio: dac: mcp4725: Fix i2c_master_send() return value handling
      dt-bindings: usb: snps,dwc3: Fix "snps,hsphy_interface" type
      mmc: pwrseq: sd8787: Fix WILC CHIP_EN and RESETN toggling order

Martin Povišer (1):
      ASoC: dt-bindings: Adjust #sound-dai-cells on TI's single-DAI codecs

Masahiro Honda (1):
      iio: adc: ad_sigma_delta: Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag

Matthieu Baerts (6):
      selftests: mptcp: connect: skip if MPTCP is not supported
      selftests: mptcp: pm nl: skip if MPTCP is not supported
      selftests: mptcp: sockopt: skip if MPTCP is not supported
      selftests: mptcp: diag: skip if MPTCP is not supported
      selftests: mptcp: simult flows: skip if MPTCP is not supported
      selftests: mptcp: join: skip if MPTCP is not supported

Maxim Kochetkov (1):
      ASoC: dwc: limit the number of overrun messages

Min-Hua Chen (1):
      arm64/mm: mark private VM_FAULT_X defines as vm_fault_t

Mirsad Goran Todorovac (1):
      test_firmware: fix the memory leak of the allocated firmware buffer

Moshe Shemesh (1):
      net/mlx5: Read embedded cpu after init bit cleared

Mustafa Ismail (4):
      RDMA/irdma: Add SW mechanism to generate completions on error
      RDMA/irdma: Prevent QP use after free
      RDMA/irdma: Fix Local Invalidate fencing
      RDMA/irdma: Do not generate SW completions for NOPs

Namjae Jeon (2):
      ksmbd: fix credit count leakage
      ksmbd: fix incorrect AllocationSize set in smb2_get_info

Nikita Zhandarovich (1):
      HID: wacom: avoid integer overflow in wacom_intuos_inout()

Niklas Söderlund (1):
      media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNATE

Paul Cercueil (1):
      iio: adc: ad7192: Change "shorted" channels to differential

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

Raju Rangoju (1):
      amd-xgbe: fix the false linkup in xgbe_phy_status

Randy Dunlap (1):
      dmaengine: pl330: rename _start to prevent build error

Richard Acayan (2):
      misc: fastrpc: return -EPIPE to invocations on device removal
      misc: fastrpc: reject new invocations during device removal

Rob Clark (1):
      drm/msm: Be more shouty if per-process pgtables aren't working

Roberto Sassu (1):
      KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()

Rubén Gómez (1):
      ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P

Saeed Mahameed (1):
      net/mlx5e: Fix error handling in mlx5e_refresh_tirs

Sagi Grimberg (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE 2048G

Sean Christopherson (1):
      KVM: x86: Account fastpath-only VM-Exits in vCPU stats

Sebastian Krzyszkowiak (1):
      net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the page_size used during the MR creation

Shay Drory (1):
      net/mlx5: fw_tracer, Fix event handling

Sherry Sun (1):
      tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK

Shiraz Saleem (1):
      RDMA/irdma: Fix drain SQ hang with no completion

Sung-Chi Li (1):
      HID: google: add jewel USB id

Takashi Iwai (1):
      media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()

Theodore Ts'o (5):
      ext4: add EA_INODE checking to ext4_iget()
      ext4: set lockdep subclass for the ea_inode in ext4_xattr_inode_cache_find()
      ext4: disallow ea_inodes with extended attributes
      ext4: add lockdep annotations for i_data_sem for ea_inode's
      ext4: enable the lazy init thread when remounting read/write

Thomas Bogendoerfer (1):
      net: mellanox: mlxbf_gige: Fix skb_panic splat under memory pressure

Tim Huang (3):
      drm/amd/pm: reverse mclk and fclk clocks levels for vangogh
      drm/amd/pm: reverse mclk and fclk clocks levels for yellow carp
      drm/amd/pm: reverse mclk and fclk clocks levels for renoir

Tom Rix (1):
      netfilter: conntrack: define variables exp_nat_nla_policy and any_addr with CONFIG_NF_NAT

Tudor Ambarus (1):
      dmaengine: at_xdmac: Move the free desc to the tail of the desc list

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

Xin Long (1):
      rtnetlink: call validate_linkmsg in rtnl_create_link

Yangyang Li (1):
      RDMA/hns: Modify the value of long message loopback slice

Yonatan Nachum (1):
      RDMA/efa: Fix unsupported page sizes in device

YongSu Yoo (2):
      media: dvb_demux: fix a bug for the continuity counter
      media: dvb_ca_en50221: fix a size write bug

Yu Kuai (1):
      md/raid5: fix miscalculation of 'end_sector' in raid5_read_one_chunk()

Yun Lu (1):
      wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value

Zhang Shurong (1):
      media: dvb-usb-v2: rtl28xxu: fix null-ptr-deref in rtl28xxu_i2c_xfer

Zheng Wang (1):
      fbdev: imsttfb: Fix use after free bug in imsttfb_probe

Zhengchao Shao (1):
      net: sched: fix NULL pointer dereference in mq_attach

jasontao (1):
      ALSA: hda: Glenfly: add HD Audio PCI IDs and HDMI Codec Vendor IDs.

lyndonli (1):
      drm/amdgpu: Use the default reset when loading or reloading the driver

pengfuyuan (1):
      btrfs: fix csum_tree_block page iteration to avoid tripping on -Werror=array-bounds

