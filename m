Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFBC7160A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjE3Mzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjE3Mzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C620EA;
        Tue, 30 May 2023 05:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E40E60C96;
        Tue, 30 May 2023 12:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1AEC433EF;
        Tue, 30 May 2023 12:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685451277;
        bh=+Q+Ld7TiT9Lu3Ubu6JHFeQIqc6OrNlIKU2nY6SKJQ8k=;
        h=From:To:Cc:Subject:Date:From;
        b=kHtI8toWke6N/WJ27bXW80gjbRoB2J1Iy7lWk7JLynTDx/gy/pn7O/N9q0V7gHzLW
         hpb+iuH4jjSukS9KkH3up5SEyAWAL+lqD35vgv0pPv8+7kjiGyaG3bnXnsCzVfU6zP
         rr+zUcKT2CGZmgnsW1K571C1Jjzal96AcNWHjZXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.181
Date:   Tue, 30 May 2023 13:54:33 +0100
Message-Id: <2023053033-unsaid-startling-3e98@gregkh>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.10.181 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/usb/cdns,usb3.yaml        |    2 
 Makefile                                                    |    2 
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi                    |    2 
 arch/arm/mach-sa1100/jornada720_ssp.c                       |    5 
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi           |    8 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                       |    3 
 arch/arm64/include/asm/hyp_image.h                          |    3 
 arch/arm64/kernel/image-vars.h                              |   11 
 arch/arm64/kvm/hyp/nvhe/Makefile                            |    4 
 arch/m68k/kernel/signal.c                                   |   14 
 arch/parisc/include/asm/cacheflush.h                        |    5 
 arch/parisc/kernel/cache.c                                  |    5 
 arch/parisc/kernel/process.c                                |   11 
 arch/parisc/kernel/traps.c                                  |    4 
 arch/powerpc/mm/book3s64/radix_pgtable.c                    |    4 
 arch/x86/include/asm/intel-family.h                         |    5 
 arch/x86/kernel/cpu/topology.c                              |    5 
 arch/x86/kernel/dumpstack.c                                 |    7 
 arch/x86/mm/init.c                                          |   25 +
 drivers/acpi/acpica/dbnames.c                               |    3 
 drivers/acpi/acpica/dswstate.c                              |   11 
 drivers/acpi/ec.c                                           |    1 
 drivers/base/core.c                                         |    7 
 drivers/base/regmap/regcache.c                              |    6 
 drivers/block/null_blk/main.c                               |    5 
 drivers/bluetooth/btbcm.c                                   |   47 ++
 drivers/char/tpm/tpm_tis.c                                  |   16 
 drivers/clk/tegra/clk-tegra20.c                             |   28 -
 drivers/firmware/arm_sdei.c                                 |   37 +
 drivers/gpio/gpio-mockup.c                                  |    2 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c          |    7 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c          |    5 
 drivers/gpu/drm/drm_mipi_dsi.c                              |    2 
 drivers/gpu/drm/exynos/exynos_drm_g2d.h                     |    4 
 drivers/gpu/drm/i915/display/intel_dp.c                     |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c                 |    5 
 drivers/gpu/drm/msm/dp/dp_audio.c                           |   12 
 drivers/gpu/drm/msm/dp/dp_audio.h                           |    2 
 drivers/gpu/drm/msm/dp/dp_display.c                         |    1 
 drivers/gpu/drm/tegra/sor.c                                 |    2 
 drivers/hid/hid-logitech-hidpp.c                            |   53 ++
 drivers/hid/wacom.h                                         |    3 
 drivers/hid/wacom_sys.c                                     |    2 
 drivers/hid/wacom_wac.c                                     |   80 ++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c             |    2 
 drivers/infiniband/core/user_mad.c                          |   23 -
 drivers/input/joystick/xpad.c                               |    5 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                 |   19 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                  |   16 
 drivers/mcb/mcb-pci.c                                       |   27 +
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c          |    2 
 drivers/media/radio/radio-shark.c                           |   10 
 drivers/media/radio/radio-shark2.c                          |   10 
 drivers/memstick/host/r592.c                                |    2 
 drivers/message/fusion/mptlan.c                             |    2 
 drivers/mfd/dln2.c                                          |    1 
 drivers/net/bonding/bond_main.c                             |    8 
 drivers/net/can/kvaser_pciefd.c                             |   51 +-
 drivers/net/ethernet/3com/3c589_cs.c                        |   11 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c              |    9 
 drivers/net/ethernet/freescale/fec_main.c                   |   15 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c     |   15 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c       |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h       |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c   |    5 
 drivers/net/ethernet/intel/igb/e1000_mac.c                  |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c           |   16 
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/main.c              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c   |    3 
 drivers/net/ethernet/nvidia/forcedeth.c                     |    1 
 drivers/net/ethernet/pasemi/pasemi_mac.c                    |    2 
 drivers/net/ethernet/sun/cassini.c                          |    2 
 drivers/net/ipvlan/ipvlan_core.c                            |    6 
 drivers/net/mdio/mdio-mvusb.c                               |   11 
 drivers/net/phy/dp83867.c                                   |   22 +
 drivers/net/phy/mscc/mscc_main.c                            |    1 
 drivers/net/tap.c                                           |   10 
 drivers/net/team/team.c                                     |    7 
 drivers/net/usb/cdc_ncm.c                                   |   24 -
 drivers/net/wireless/ath/ath.h                              |   12 
 drivers/net/wireless/ath/ath11k/dp_rx.c                     |    9 
 drivers/net/wireless/ath/key.c                              |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |   13 
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c                |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c                |   10 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c               |    3 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c             |    2 
 drivers/phy/st/phy-miphy28lp.c                              |   42 --
 drivers/power/supply/bq27xxx_battery.c                      |   41 +-
 drivers/power/supply/bq27xxx_battery_i2c.c                  |    3 
 drivers/power/supply/power_supply_leds.c                    |    5 
 drivers/power/supply/sbs-charger.c                          |    2 
 drivers/remoteproc/stm32_rproc.c                            |    8 
 drivers/s390/cio/qdio.h                                     |   25 -
 drivers/s390/cio/qdio_main.c                                |   62 +--
 drivers/scsi/lpfc/lpfc_debugfs.c                            |    7 
 drivers/scsi/storvsc_drv.c                                  |    8 
 drivers/spi/spi-fsl-cpm.c                                   |   23 +
 drivers/spi/spi-fsl-spi.c                                   |   53 +-
 drivers/spi/spi-imx.c                                       |   24 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                |    6 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h                |    5 
 drivers/target/iscsi/iscsi_target.c                         |    6 
 drivers/tty/serial/8250/8250_core.c                         |    1 
 drivers/tty/serial/8250/8250_exar.c                         |   68 ++-
 drivers/tty/serial/8250/8250_pci.c                          |    5 
 drivers/tty/serial/arc_uart.c                               |    7 
 drivers/tty/vt/vc_screen.c                                  |   11 
 drivers/usb/class/usbtmc.c                                  |    2 
 drivers/usb/core/usb.c                                      |   76 +++
 drivers/usb/dwc3/debugfs.c                                  |  109 +++++
 drivers/usb/gadget/function/u_ether.c                       |    3 
 drivers/usb/host/uhci-pci.c                                 |   10 
 drivers/usb/misc/sisusbvga/sisusb.c                         |   14 
 drivers/usb/storage/scsiglue.c                              |   28 +
 drivers/usb/typec/altmodes/displayport.c                    |    4 
 drivers/usb/typec/tcpm/tcpm.c                               |   16 
 drivers/video/fbdev/arcfb.c                                 |   15 
 drivers/video/fbdev/udlfb.c                                 |   13 
 drivers/watchdog/sp5100_tco.c                               |    4 
 drivers/xen/pvcalls-back.c                                  |    9 
 fs/btrfs/disk-io.c                                          |   64 +++
 fs/btrfs/disk-io.h                                          |    2 
 fs/btrfs/free-space-cache.c                                 |    7 
 fs/btrfs/inode-map.c                                        |   55 --
 fs/btrfs/inode-map.h                                        |    3 
 fs/btrfs/inode.c                                            |   12 
 fs/ceph/snap.c                                              |   13 
 fs/ext2/ext2.h                                              |    1 
 fs/ext2/super.c                                             |    7 
 fs/ext4/balloc.c                                            |   18 
 fs/ext4/ext4.h                                              |   25 -
 fs/ext4/ialloc.c                                            |   12 
 fs/ext4/mballoc.c                                           |  238 ++++++++----
 fs/ext4/mmp.c                                               |   39 +
 fs/ext4/super.c                                             |   28 -
 fs/ext4/sysfs.c                                             |    2 
 fs/f2fs/checkpoint.c                                        |   12 
 fs/f2fs/data.c                                              |    3 
 fs/gfs2/glops.c                                             |    3 
 fs/hfsplus/inode.c                                          |   28 +
 fs/nilfs2/inode.c                                           |   18 
 fs/ocfs2/namei.c                                            |    2 
 fs/ocfs2/xattr.c                                            |   30 +
 fs/statfs.c                                                 |    4 
 include/linux/cpuhotplug.h                                  |    1 
 include/linux/device.h                                      |    1 
 include/linux/dim.h                                         |    3 
 include/linux/fs.h                                          |   42 +-
 include/linux/if_team.h                                     |    1 
 include/linux/if_vlan.h                                     |   17 
 include/linux/power/bq27xxx_battery.h                       |    1 
 include/linux/sched/task_stack.h                            |    2 
 include/linux/usb.h                                         |    5 
 include/net/bonding.h                                       |    1 
 include/net/ip_vs.h                                         |    6 
 include/net/netns/ipv4.h                                    |    1 
 include/net/sch_generic.h                                   |    5 
 include/net/sock.h                                          |    2 
 include/net/tcp.h                                           |    1 
 include/net/xfrm.h                                          |    2 
 include/uapi/sound/skl-tplg-interface.h                     |    3 
 kernel/bpf/bpf_local_storage.c                              |   16 
 kernel/bpf/verifier.c                                       |    2 
 kernel/rcu/refscale.c                                       |    2 
 kernel/rcu/tree_exp.h                                       |    6 
 lib/cpu_rmap.c                                              |    5 
 lib/debugobjects.c                                          |    2 
 lib/dim/dim.c                                               |    5 
 lib/dim/net_dim.c                                           |    3 
 lib/dim/rdma_dim.c                                          |    3 
 mm/backing-dev.c                                            |    1 
 net/8021q/vlan_dev.c                                        |    4 
 net/bluetooth/l2cap_core.c                                  |    1 
 net/bridge/br_forward.c                                     |    2 
 net/bridge/br_private_tunnel.h                              |    8 
 net/can/isotp.c                                             |    2 
 net/can/j1939/socket.c                                      |    2 
 net/core/datagram.c                                         |   15 
 net/core/dev.c                                              |    4 
 net/core/skbuff.c                                           |    4 
 net/core/stream.c                                           |   12 
 net/ipv4/af_inet.c                                          |    2 
 net/ipv4/ip_output.c                                        |    2 
 net/ipv4/tcp.c                                              |   23 -
 net/ipv4/tcp_bpf.c                                          |    2 
 net/ipv4/tcp_input.c                                        |    4 
 net/ipv4/tcp_ipv4.c                                         |   68 +--
 net/ipv4/udplite.c                                          |    2 
 net/ipv6/exthdrs_core.c                                     |    2 
 net/ipv6/ip6_gre.c                                          |   13 
 net/ipv6/tcp_ipv6.c                                         |    5 
 net/ipv6/udplite.c                                          |    2 
 net/key/af_key.c                                            |   12 
 net/llc/af_llc.c                                            |    8 
 net/mac80211/trace.h                                        |    2 
 net/netfilter/core.c                                        |    6 
 net/netfilter/ipvs/ip_vs_sync.c                             |    2 
 net/netfilter/nf_conntrack_standalone.c                     |    3 
 net/netfilter/nft_set_rbtree.c                              |   20 -
 net/netlink/af_netlink.c                                    |    8 
 net/nsh/nsh.c                                               |    8 
 net/packet/af_packet.c                                      |    6 
 net/sched/act_mirred.c                                      |   44 +-
 net/smc/smc_close.c                                         |    4 
 net/smc/smc_rx.c                                            |    4 
 net/smc/smc_tx.c                                            |    4 
 net/socket.c                                                |    2 
 net/sunrpc/svc.c                                            |    2 
 net/tipc/bearer.c                                           |   17 
 net/tipc/bearer.h                                           |   13 
 net/tipc/crypto.h                                           |    6 
 net/tipc/link.c                                             |    9 
 net/tipc/name_distr.h                                       |    2 
 net/tipc/name_table.h                                       |    9 
 net/tipc/socket.c                                           |    4 
 net/tipc/subscr.h                                           |   11 
 net/tipc/udp_media.c                                        |    5 
 net/tls/tls_main.c                                          |    3 
 net/unix/af_unix.c                                          |   22 -
 net/vmw_vsock/af_vsock.c                                    |    2 
 net/xfrm/xfrm_interface.c                                   |   54 --
 net/xfrm/xfrm_policy.c                                      |    9 
 samples/bpf/hbm.c                                           |    1 
 scripts/recordmcount.c                                      |    6 
 sound/firewire/digi00x/digi00x-stream.c                     |    4 
 sound/hda/hdac_device.c                                     |    2 
 sound/pci/hda/hda_generic.c                                 |    7 
 sound/pci/hda/patch_ca0132.c                                |    1 
 sound/pci/hda/patch_hdmi.c                                  |    5 
 sound/pci/hda/patch_realtek.c                               |    7 
 sound/usb/format.c                                          |    1 
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c     |   31 -
 tools/testing/selftests/memfd/fuse_test.c                   |    1 
 tools/testing/selftests/net/fib_tests.sh                    |    2 
 tools/testing/selftests/net/forwarding/tc_actions.sh        |   48 ++
 238 files changed, 2059 insertions(+), 904 deletions(-)

Adam Stylinski (1):
      ALSA: hda/ca0132: add quirk for EVGA X299 DARK

Ai Chao (1):
      ALSA: hda/realtek: Add a quirk for HP EliteDesk 805

Alain Volmat (1):
      phy: st: miphy28lp: use _poll_timeout functions for waits

Alan Stern (5):
      USB: usbtmc: Fix direction for 0-length ioctl control messages
      fbdev: udlfb: Fix endpoint check
      USB: core: Add routines for endpoint checks in old drivers
      USB: sisusbvga: Add endpoint checks
      media: radio-shark: Add endpoint checks

Aleksandr Loktionov (1):
      igb: fix bit_shift to be in [1..8] range

Alexander Stein (1):
      regmap: cache: Return error in cache sync operations for REGCACHE_NONE

Andreas Gruenbacher (1):
      gfs2: Fix inode height consistency check

Andrew Davis (1):
      serial: 8250_exar: Add support for USR298x PCI Modems

Andy Shevchenko (1):
      serial: 8250_exar: derive nr_ports from PCI ID for Acces I/O cards

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

Bin Li (1):
      ALSA: hda/realtek: Enable headset onLenovo M70/M90

Cezary Rojewski (1):
      ASoC: Intel: Skylake: Fix declaration of enum skl_ch_cfg

Chaitanya Kulkarni (1):
      null_blk: Always check queue mode setting from configfs

Chao Yu (1):
      f2fs: fix to drop all dirty pages during umount() if cp_error is set

Christophe JAILLET (4):
      net: mdio: mvusb: Fix an error handling path in mvusb_mdio_probe()
      cassini: Fix a memory leak in the error handling path of cas_init_one()
      forcedeth: Fix an error handling path in nv_probe()
      3c589_cs: Fix an error handling path in tc589_probe()

Christophe Leroy (2):
      spi: fsl-spi: Re-organise transfer bits_per_word adaptation
      spi: fsl-cpm: Use 16 bit mode for large transfers with even size

Chuck Lever (1):
      SUNRPC: Fix trace_svc_register() call site

Chunguang Xu (1):
      ext4: remove redundant mb_regenerate_buddy()

Daisuke Nojiri (1):
      power: supply: sbs-charger: Fix INHIBITED bit for Status reg

Dan Carpenter (3):
      ALSA: firewire-digi00x: prevent potential use after free
      coresight: Fix signedness bug in tmc_etr_buf_insert_barrier_packet()
      xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()

Daniel Gabay (1):
      wifi: iwlwifi: pcie: fix possible NULL pointer dereference

Dave Hansen (1):
      x86/mm: Avoid incomplete Global INVLPG flushes

David Epping (1):
      net: phy: mscc: add VSC8502 to MODULE_DEVICE_TABLE

Davide Caratti (2):
      net/sched: act_mirred: better wording on protection against excessive stack growth
      act_mirred: use the backlog for nested calls to mirred ingress

Dmitry Bogdanov (1):
      scsi: target: iscsit: Free cmds before session free

Dong Chenchen (1):
      net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment()

Duoming Zhou (1):
      media: netup_unidvb: fix use-after-free at del_timer()

Eli Cohen (1):
      lib: cpu_rmap: Avoid use after free on rmap->obj array entries

Erez Shitrit (1):
      net/mlx5: DR, Fix crc32 calculation to work on big-endian (BE) CPUs

Eric Dumazet (9):
      netlink: annotate accesses to nlk->cb_running
      net: annotate sk->sk_err write from do_recvmmsg()
      net: deal with most data-races in sk_wait_event()
      net: add vlan_get_protocol_and_depth() helper
      tcp: add annotations around sk->sk_shutdown accesses
      net: datagram: fix data-races in datagram_poll()
      ipv4/tcp: do not use per netns ctl sockets
      tcp: fix possible sk_priority leak in tcp_v4_send_reset()
      vlan: fix a potential uninit-value in vlan_dev_hard_start_xmit()

Filipe Manana (1):
      btrfs: fix space cache inconsistency after error loading it from disk

Finn Thain (1):
      m68k: Move signal frame following exception on 68020/030

Florian Fainelli (2):
      net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()
      net: bcmgenet: Restore phy_stop() depending upon suspend/close

Florian Westphal (2):
      netfilter: conntrack: fix possible bug_on with enable_hooks=1
      netfilter: nft_set_rbtree: fix null deref on element insertion

Frank Li (1):
      dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size type

Frank Wang (1):
      usb: typec: tcpm: fix multiple times discover svids error

Gavrilov Ilia (1):
      ipv6: Fix out-of-bounds access in ipv6_find_tlv()

George Kennedy (1):
      vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF

Greg Kroah-Hartman (1):
      Linux 5.10.181

Greg Thelen (1):
      writeback, cgroup: remove extra percpu_ref_exit()

Gregory Oakes (1):
      watchdog: sp5100_tco: Immediately trigger upon starting.

Grygorii Strashko (1):
      net: phy: dp83867: add w/a for packet errors seen with short cables

Gustavo A. R. Silva (1):
      RDMA/core: Fix multiple -Warray-bounds warnings

Hans de Goede (6):
      wifi: iwlwifi: dvm: Fix memcpy: detected field-spanning write backtrace
      Bluetooth: hci_bcm: Fall back to getting bdaddr from EFI if not set
      power: supply: leds: Fix blink to LED on transition
      power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
      power: supply: bq27xxx: Fix I2C IRQ race on remove
      power: supply: bq27xxx: Fix poll_interval handling and races on remove

Hao Ge (1):
      fs: fix undefined behavior in bit shift for SB_NOUSER

Hao Zeng (2):
      samples/bpf: Fix fout leak in hbm's run_bpf_prog
      recordmcount: Fix memory leaks in the uwrite function

Hardik Garg (1):
      selftests/memfd: Fix unknown type name build failure

Harshad Shirwadkar (2):
      ext4: drop s_mb_bal_lock and convert protected fields to atomic
      ext4: add mballoc stats proc file

Hector Martin (1):
      wifi: brcmfmac: cfg80211: Pass the PMK in binary instead of hex

Heiko Carstens (2):
      s390/qdio: get rid of register asm
      s390/qdio: fix do_sqbs() inline assembly constraint

Helge Deller (3):
      parisc: Handle kgdb breakpoints only in kernel context
      parisc: Allow to reboot machine after system halt
      parisc: Fix flush_dcache_page() for usage from irq context

Hugo Villeneuve (1):
      arm64: dts: imx8mn-var-som: fix PHY detection bug by adding deassert delay

Hyunwoo Kim (1):
      wifi: iwlwifi: pcie: Fix integer overflow in iwl_write_to_user_buf

Ilya Leoshkevich (1):
      statfs: enforce statfs[64] structure initialization

Ioana Ciornei (1):
      driver core: add a helper to setup both the of_node and fwnode of a device

Jakub Kicinski (1):
      net/mlx5e: do as little as possible in napi poll when budget is 0

Jan Kara (2):
      ext4: fix lockdep warning when enabling MMP
      ext2: Check block size validity during mount

Jason Gerecke (2):
      HID: wacom: generic: Set battery quirk only when we see battery data
      HID: wacom: Force pen out of prox if no events have been received in a while

Jeremy Soller (1):
      ALSA: hda/realtek: Add quirk for Clevo L140AU

Jerry Snitselaar (1):
      tpm/tpm_tis: Disable interrupts for more Lenovo devices

Jie Wang (1):
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

Johannes Berg (2):
      wifi: mac80211: fix min center freq offset tracing
      wifi: iwlwifi: mvm: don't trust firmware n_channels

Josef Bacik (1):
      btrfs: use nofs when cleaning up aborted transactions

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

Kevin Groeneveld (1):
      spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3

Konrad Dybcio (1):
      arm64: dts: qcom: msm8996: Add missing DWC3 quirks

Konrad Gräfe (1):
      usb: gadget: u_ether: Fix host MAC address case

Kumar Kartikeya Dwivedi (1):
      bpf: Annotate data races in bpf_local_storage

Kuniyuki Iwashima (4):
      net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().
      af_unix: Fix a data race of sk->sk_receive_queue->qlen.
      af_unix: Fix data races around sk->sk_shutdown.
      udplite: Fix NULL pointer dereference in __sk_mem_raise_allocated().

Luke D. Jones (1):
      ALSA: hda/realtek: Add quirk for 2nd ASUS GU603

Manivannan Sadhasivam (1):
      iommu/arm-smmu-qcom: Limit the SMR groups to 128

Marijn Suijten (1):
      drm/msm/dpu: Remove duplicate register defines from INTF

Mario Limonciello (1):
      drm/amd: Fix an out of bounds error in BIOS parser

Martin Willi (1):
      Revert "Fix XFRM-I support for nested ESP tunnels"

Matthew Howell (1):
      serial: exar: Add support for Sealevel 7xxxC serial cards

Maxime Bizon (1):
      usb-storage: fix deadlock when a scsi command timeouts more than once

Menglong Dong (1):
      net: tap: check vlan with eth_type_vlan() method

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

Nick Child (1):
      net: Catch invalid index in XPS mapping

Nikhil Mahale (1):
      ALSA: hda: Add NVIDIA codec IDs a3 through a7 to patch table

Nikita Zhandarovich (1):
      drm/i915/dp: prevent potential div-by-zero

Nikolay Borisov (2):
      btrfs: move btrfs_find_highest_objectid/btrfs_find_free_objectid to disk-io.c
      btrfs: replace calls to btrfs_find_free_ino with btrfs_find_free_objectid

Nur Hussein (1):
      drm/tegra: Avoid potential 32-bit integer overflow

Ojaswin Mujoo (1):
      ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()

Oliver Hartkopp (2):
      can: j1939: recvmsg(): allow MSG_CMSG_COMPAT flag
      can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag

Olivier Moysan (1):
      ARM: dts: stm32: fix AV96 board SAI2 pin muxing on stm32mp15

Paolo Abeni (1):
      tcp: factor out __tcp_close() helper

Paul E. McKenney (1):
      refscale: Move shutdown from wait_event() to wait_event_idle()

Philipp Hortmann (1):
      staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE

Pierre Gondois (1):
      firmware: arm_sdei: Fix sleep from invalid context BUG

Ping Cheng (2):
      HID: wacom: Add new Intuos Pro Small (PTH-460) device IDs
      HID: wacom: add three styli to wacom_intuos_get_tool_type

Po-Hsu Lin (1):
      selftests: fib_tests: mute cleanup error message

Pratyush Yadav (1):
      net: fix skb leak in __skb_tstamp_tx()

Qiang Ning (1):
      mfd: dln2: Fix memory leak in dln2_probe()

Randy Dunlap (2):
      ARM: 9296/1: HP Jornada 7XX: fix kernel-doc warnings
      net/tipc: fix tipc header files for kernel-doc

Roberto Sassu (1):
      ocfs2: Switch to security_inode_init_security()

Rodrigo Siqueira (1):
      drm/amd/display: Use DC_LOG_DC in the trasform pixel function

Rodríguez Barbarin, José Javier (1):
      mcb-pci: Reallocate memory region to avoid memory overlapping

Roi Dayan (1):
      net/mlx5: Fix error message when failing to allocate device memory

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

Shay Drory (1):
      net/mlx5: Devcom, fix error flow in mlx5_devcom_register_device

Simon Horman (1):
      ipvs: Update width of source for ip_vs_sync_conn_options

Srinivas Kandagatla (1):
      drm/msm/dp: unregister audio driver during unbind

Sunil Goutham (1):
      octeontx2-pf: Fix TSOv6 offload

Taehee Yoo (1):
      net: fix stack overflow when LRO is disabled for virtual interfaces

Takashi Iwai (3):
      ALSA: usb-audio: Add a sample rate workaround for Line6 Pod Go
      ALSA: hda: Fix Oops by 9.1 surround channel names
      ALSA: hda: Fix unhandled register update during auto-suspend period

Tamir Duberstein (1):
      ACPICA: Avoid undefined behavior: applying zero offset to null pointer

Tetsuo Handa (2):
      fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()
      debugobjects: Don't wake up kswapd from fill_pool()

Theodore Ts'o (3):
      ext4: reflect error codes from ext4_multi_mount_protect() to its callers
      ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled
      ext4: allow ext4_get_group_info() to fail

Tobias Brunner (1):
      af_key: Reject optional tunnel/BEET mode templates in outbound policies

Tomas Krcka (1):
      iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any

Tony Lindgren (1):
      serial: 8250: Reinit port->pm on port specific driver unbind

Tudor Ambarus (1):
      net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

Udipto Goswami (1):
      usb: dwc3: debugfs: Resume dwc3 before accessing registers

Uwe Kleine-König (1):
      net: fec: Better handle pm_runtime_get() failing in .remove()

Vernon Lovejoy (1):
      x86/show_trace_log_lvl: Ensure stack pointer is aligned, again

Vicki Pfau (1):
      Input: xpad - add constants for GIP interface numbers

Vitaliy Tomin (1):
      serial: Add support for Advantech PCI-1611U card

Weitao Wang (1):
      USB: UHCI: adjust zhaoxin UHCI controllers OverCurrent bit value

Will Deacon (2):
      KVM: arm64: Link position-independent string routines into .hyp.text
      bpf: Fix mask generation for 32-bit narrow loads of 64-bit fields

Wyes Karny (1):
      cpupower: Make TSC read per CPU for Mperf monitor

Xin Long (4):
      erspan: get the proto with the md version for collect_md
      tipc: add tipc_bearer_min_mtu to calculate min mtu
      tipc: do not update mtu if msg_max is too small in mtu negotiation
      tipc: check the bearer min mtu properly when setting it by netlink

Xiubo Li (1):
      ceph: force updating the msg pointer in non-split case

Zev Weiss (1):
      gpio: mockup: Fix mode of debugfs files

Zhang Rui (1):
      x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platforms

Zheng Wang (2):
      memstick: r592: Fix UAF bug in r592_remove due to race condition
      scsi: message: mptlan: Fix use after free bug in mptlan_remove() due to race condition

Zhuang Shengen (1):
      vsock: avoid to close connected socket after the timeout

Zongjie Li (1):
      fbdev: arcfb: Fix error handling in arcfb_probe()

Zqiang (1):
      rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access

sewookseo (1):
      net: Find dst with sk's xfrm policy not ctl_sk

t.feng (1):
      ipvlan:Fix out-of-bounds caused by unclear skb->cb

void0red (1):
      ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects

wenxu (1):
      net/sched: act_mirred: refactor the handle of xmit

