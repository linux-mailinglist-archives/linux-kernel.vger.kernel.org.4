Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB11572F971
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbjFNJkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244138AbjFNJi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977C51981;
        Wed, 14 Jun 2023 02:38:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBAAE63FC8;
        Wed, 14 Jun 2023 09:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED4CC433C0;
        Wed, 14 Jun 2023 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686735512;
        bh=6lBicW8pFw12gEexYKG6HtRHNkQWeyb9jQFS3ZoiU7U=;
        h=From:To:Cc:Subject:Date:From;
        b=JEruRNLHZTfnTV/dnJ124A6be8db7N5t1yNL0FHQDZPUJNNJzwdORVadOegPRiv+/
         9Fk5VENb5X+GZBghqbDuZ7M5wDfUANvV+jwmIOAQBfw88glAsfFuPq+3Qzymbj0nt2
         Qx6tFVa8Ww7j/ty3DAVznx45N8AI7Z/lufsPW0bI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.184
Date:   Wed, 14 Jun 2023 11:38:17 +0200
Message-ID: <2023061417-denote-onboard-aca1@gregkh>
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

I'm announcing the release of the 5.10.184 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                      |    2 
 arch/mips/include/asm/atomic.h                                |    2 
 arch/riscv/Kconfig                                            |    1 
 block/blk-iocost.c                                            |   10 
 drivers/ata/ahci.h                                            |  245 -
 drivers/block/Kconfig                                         |    9 
 drivers/block/Makefile                                        |    2 
 drivers/block/rbd.c                                           |   62 
 drivers/block/sx8.c                                           | 1586 ----------
 drivers/bluetooth/hci_qca.c                                   |    6 
 drivers/gpu/drm/amd/amdgpu/vi.c                               |   11 
 drivers/gpu/drm/drm_atomic_uapi.c                             |   14 
 drivers/i2c/busses/i2c-sprd.c                                 |    8 
 drivers/infiniband/hw/i40iw/i40iw.h                           |    5 
 drivers/input/joystick/xpad.c                                 |    1 
 drivers/input/mouse/elantech.c                                |    9 
 drivers/misc/eeprom/Kconfig                                   |    1 
 drivers/net/dsa/lan9303-core.c                                |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                     |   28 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c             |    2 
 drivers/net/ethernet/intel/i40e/i40e_alloc.h                  |   17 
 drivers/net/ethernet/intel/ice/ice_fltr.c                     |    2 
 drivers/net/ethernet/qlogic/qed/qed_l2.c                      |    2 
 drivers/net/ethernet/qlogic/qede/qede.h                       |    4 
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c               |   24 
 drivers/net/ethernet/qlogic/qede/qede_main.c                  |   34 
 drivers/net/ethernet/sfc/ef100_tx.c                           |    3 
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c               |    3 
 drivers/pinctrl/meson/pinctrl-meson-axg.c                     |    1 
 drivers/s390/block/dasd_ioctl.c                               |    4 
 drivers/spi/spi-qup.c                                         |   37 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                  |    6 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h                  |    5 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c |   24 
 drivers/tee/amdtee/amdtee_if.h                                |   10 
 drivers/tee/amdtee/call.c                                     |   30 
 drivers/usb/core/buffer.c                                     |   41 
 drivers/usb/core/devio.c                                      |   20 
 drivers/vhost/vhost.c                                         |   18 
 drivers/vhost/vhost.h                                         |    8 
 fs/afs/dir.c                                                  |    3 
 fs/btrfs/relocation.c                                         |   14 
 fs/ceph/caps.c                                                |    6 
 fs/ceph/snap.c                                                |    4 
 fs/ext4/super.c                                               |    6 
 fs/ext4/xattr.c                                               |    6 
 fs/f2fs/sysfs.c                                               |    4 
 fs/xfs/xfs_buf_item_recover.c                                 |   10 
 include/linux/netdevice.h                                     |    7 
 include/linux/usb/hcd.h                                       |    5 
 include/net/bond_alb.h                                        |    4 
 include/net/neighbour.h                                       |    2 
 include/net/pkt_sched.h                                       |    2 
 include/net/rpl.h                                             |    3 
 include/net/sock.h                                            |   18 
 kernel/trace/bpf_trace.c                                      |   12 
 lib/cpu_rmap.c                                                |    2 
 net/batman-adv/distributed-arp-table.c                        |    2 
 net/bluetooth/hci_core.c                                      |    8 
 net/bluetooth/l2cap_core.c                                    |   13 
 net/can/j1939/main.c                                          |   24 
 net/can/j1939/socket.c                                        |    5 
 net/core/dev.c                                                |    6 
 net/ipv4/sysctl_net_ipv4.c                                    |    2 
 net/ipv6/exthdrs.c                                            |   29 
 net/netfilter/ipset/ip_set_core.c                             |    8 
 net/netfilter/nf_conntrack_core.c                             |    3 
 net/sched/cls_api.c                                           |    3 
 net/sched/sch_fq_pie.c                                        |    8 
 net/smc/smc_llc.c                                             |    4 
 scripts/gcc-plugins/gcc-common.h                              |    9 
 sound/pci/hda/patch_realtek.c                                 |    2 
 sound/soc/codecs/wsa881x.c                                    |    1 
 73 files changed, 604 insertions(+), 1932 deletions(-)

Ai Chao (1):
      ALSA: hda/realtek: Add a quirk for HP Slim Desktop S01

Alexander Sverdlin (1):
      net: dsa: lan9303: allow vid != 0 in port_fdb_{add|del} methods

Arnd Bergmann (2):
      ata: ahci: fix enum constants for gcc-13
      blk-iocost: avoid 64-bit division in ioc_timer_fn

Ben Hutchings (1):
      lib: cpu_rmap: Fix potential use-after-free in irq_cpu_rmap_release()

Chia-I Wu (1):
      drm/amdgpu: fix xclk freq on CHIP_STONEY

Christoph Hellwig (1):
      remove the sx8 block driver

Darrick J. Wong (1):
      xfs: verify buffer contents when we skip log replay

David Howells (1):
      afs: Fix setting of mtime when creating a file/dir/symlink

Dmitry Torokhov (1):
      Input: psmouse - fix OOB access in Elantech protocol

Eric Dumazet (5):
      net/sched: fq_pie: ensure reasonable TCA_FQ_PIE_QUANTUM values
      rfs: annotate lockless accesses to sk->sk_rxhash
      rfs: annotate lockless accesses to RFS sock flow table
      net: sched: move rtm_tca_policy declaration to include file
      tcp: fix tcp_min_tso_segs sysctl

Fedor Pchelkin (2):
      can: j1939: change j1939_netdev_lock type to mutex
      can: j1939: avoid possible use-after-free when j1939_can_rx_register fails

Greg Kroah-Hartman (6):
      i40iw: fix build warning in i40iw_manage_apbvt()
      i40e: fix build warnings in i40e_alloc.h
      i40e: fix build warning in ice_fltr_add_mac_to_list()
      staging: vc04_services: fix gcc-13 build warning
      Revert "staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE"
      Linux 5.10.184

Hangyu Hua (1):
      net: sched: fix possible refcount leak in tc_chain_tmplt_add()

Ilya Dryomov (2):
      rbd: move RBD_OBJ_FLAG_COPYUP_ENABLED flag setting
      rbd: get snapshot context after exclusive lock is ensured to be held

Ismael Ferreras Morezuelas (1):
      Input: xpad - delete a Razer DeathAdder mouse VID/PID entry

Jan Höppner (1):
      s390/dasd: Use correct lock while counting channel queue length

Jiri Olsa (1):
      bpf: Add extra path pointer check to d_path helper

Jiri Slaby (SUSE) (3):
      sfc (gcc13): synchronize ef100_enqueue_skb()'s return type
      bonding (gcc13): synchronize bond_{a,t}lb_xmit() types
      block/blk-iocost (gcc13): keep large values in a new enum

Johan Hovold (1):
      Bluetooth: hci_qca: fix debugfs registration

Josef Bacik (1):
      btrfs: check return value of btrfs_commit_transaction in relocation

Kees Cook (1):
      gcc-plugins: Reorganize gimple includes for GCC 13

Kuniyuki Iwashima (2):
      netfilter: ipset: Add schedule point in call_ad().
      ipv6: rpl: Fix Route of Death.

Lorenzo Bianconi (1):
      wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll

Luiz Augusto von Dentz (1):
      Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk

Manish Chopra (1):
      qed/qede: Fix scheduling while atomic

Martin Hundebøll (1):
      pinctrl: meson-axg: add missing GPIOA_18 gpio group

Oleksij Rempel (1):
      can: j1939: j1939_sk_send_loop_abort(): improved error queue handling in J1939 Socket

Qilin Tan (1):
      f2fs: fix iostat lock protection

Qingfang DENG (1):
      neighbour: fix unaligned access to pneigh_entry

Randy Dunlap (1):
      eeprom: at24: also select REGMAP

RenHai (1):
      ALSA: hda/realtek: Add Lenovo P3 Tower platform

Rijo Thomas (1):
      tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'

Ruan Jinjie (1):
      riscv: fix kprobe __user string arg print fault issue

Rui Wang (1):
      MIPS: locking/atomic: Fix atomic{_64,}_sub_if_positive

Ruihan Li (2):
      usb: usbfs: Enforce page requirements for mmap
      usb: usbfs: Use consistent mmap functions

Shannon Nelson (1):
      vhost: support PACKED when setting-getting vring_base

Somnath Kotur (2):
      bnxt_en: Query default VLAN before VNIC setup on a VF
      bnxt_en: Implement .set_port / .unset_port UDP tunnel callbacks

Sreekanth Reddy (1):
      bnxt_en: Don't issue AP reset during ethtool's reset operation

Srinivas Kandagatla (1):
      ASoC: codecs: wsa881x: do not set can_multi_write flag

Stefan Wahren (1):
      staging: vchiq_core: drop vchiq_status from vchiq_initialise

Stephan Gerhold (1):
      spi: qup: Request DMA before enabling clocks

Sungwoo Kim (1):
      Bluetooth: L2CAP: Add missing checks for invalid DCID

Theodore Ts'o (2):
      Revert "ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled"
      ext4: only check dquot_initialize_needed() when debugging

Tijs Van Buggenhout (1):
      netfilter: conntrack: fix NULL pointer dereference in nf_confirm_cthelper

Uwe Kleine-König (1):
      i2c: sprd: Delete i2c adapter in .remove's error path

Ville Syrjälä (1):
      drm/atomic: Don't pollute crtc_state->mode_blob with error pointers

Vladislav Efanov (1):
      batman-adv: Broken sync while rescheduling delayed work

Wen Gu (1):
      net/smc: Avoid to access invalid RMBs' MRs in SMCRv1 ADD LINK CONT

Xiubo Li (1):
      ceph: fix use-after-free bug for inodes when flushing capsnaps

Ying Hsu (1):
      Bluetooth: Fix l2cap_disconnect_req deadlock

Zixuan Fu (1):
      btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()

