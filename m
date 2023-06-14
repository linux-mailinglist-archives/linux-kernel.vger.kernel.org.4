Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B9B72F966
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbjFNJjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244146AbjFNJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C76212B;
        Wed, 14 Jun 2023 02:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9801E63FCA;
        Wed, 14 Jun 2023 09:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0998C433C9;
        Wed, 14 Jun 2023 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686735505;
        bh=Xpo69Svrhz2XguQI+NNskrk8b8XJhcfddVFDtsikhbc=;
        h=From:To:Cc:Subject:Date:From;
        b=LwxPynHD545OVUbiqKCr9DfkYOyXQV4WaH3S3tz+6FUQbB34J11+XHm0VrY1UM1PN
         KXbuZLNm2rDRu9ewSBN72jA9gvz89R2sPjnsEAdQmp2Jkg3Dj0kYoSbD6uBBTdn/5L
         uSsinhs+AbA70PWU1L8dVv8IvUd7QYsfZ3kyhLFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.247
Date:   Wed, 14 Jun 2023 11:38:11 +0200
Message-ID: <2023061412-sketch-scarf-c272@gregkh>
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

I'm announcing the release of the 5.4.247 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                     |    2 
 block/blk-iocost.c                           |   10 ++-
 drivers/block/rbd.c                          |   73 ++++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vi.c              |   11 +++-
 drivers/gpu/drm/drm_atomic_uapi.c            |   14 ++---
 drivers/i2c/busses/i2c-sprd.c                |    8 +-
 drivers/infiniband/hw/i40iw/i40iw.h          |    5 -
 drivers/input/joystick/xpad.c                |    1 
 drivers/input/mouse/elantech.c               |    9 +--
 drivers/misc/eeprom/Kconfig                  |    1 
 drivers/mtd/nand/spi/macronix.c              |   16 +++++
 drivers/net/dsa/lan9303-core.c               |    4 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c    |    3 +
 drivers/net/ethernet/intel/i40e/i40e_alloc.h |   17 ++----
 drivers/pinctrl/meson/pinctrl-meson-axg.c    |    1 
 drivers/spi/spi-qup.c                        |   37 ++++++-------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |    6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |    5 +
 drivers/usb/core/buffer.c                    |   41 +++++++++++++++
 drivers/usb/core/devio.c                     |   20 +++++--
 fs/btrfs/relocation.c                        |   14 +++--
 fs/ceph/caps.c                               |    6 ++
 fs/ceph/snap.c                               |    4 +
 fs/cifs/connect.c                            |   15 ++---
 fs/ext4/xattr.c                              |    6 +-
 include/linux/netdevice.h                    |    7 +-
 include/linux/usb/hcd.h                      |    5 +
 include/net/bond_alb.h                       |    4 -
 include/net/neighbour.h                      |    2 
 include/net/pkt_sched.h                      |    2 
 include/net/sock.h                           |   18 ++++--
 lib/cpu_rmap.c                               |    2 
 net/batman-adv/distributed-arp-table.c       |    2 
 net/bluetooth/hci_core.c                     |    8 +-
 net/bluetooth/l2cap_core.c                   |   13 ++++
 net/can/j1939/main.c                         |   24 ++++----
 net/can/j1939/socket.c                       |    5 +
 net/core/dev.c                               |    6 +-
 net/netfilter/ipset/ip_set_core.c            |    8 ++
 net/netfilter/nf_conntrack_core.c            |    3 +
 net/sched/cls_api.c                          |    3 -
 sound/pci/hda/patch_realtek.c                |    2 
 42 files changed, 304 insertions(+), 139 deletions(-)

Ai Chao (1):
      ALSA: hda/realtek: Add a quirk for HP Slim Desktop S01

Alexander Sverdlin (1):
      net: dsa: lan9303: allow vid != 0 in port_fdb_{add|del} methods

Arnd Bergmann (1):
      blk-iocost: avoid 64-bit division in ioc_timer_fn

Ben Hutchings (1):
      lib: cpu_rmap: Fix potential use-after-free in irq_cpu_rmap_release()

Chia-I Wu (1):
      drm/amdgpu: fix xclk freq on CHIP_STONEY

Dmitry Torokhov (1):
      Input: psmouse - fix OOB access in Elantech protocol

Eric Dumazet (3):
      rfs: annotate lockless accesses to sk->sk_rxhash
      rfs: annotate lockless accesses to RFS sock flow table
      net: sched: move rtm_tca_policy declaration to include file

Fedor Pchelkin (2):
      can: j1939: change j1939_netdev_lock type to mutex
      can: j1939: avoid possible use-after-free when j1939_can_rx_register fails

Greg Kroah-Hartman (4):
      i40iw: fix build warning in i40iw_manage_apbvt()
      i40e: fix build warnings in i40e_alloc.h
      Revert "staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE"
      Linux 5.4.247

Gustavo A. R. Silva (1):
      neighbour: Replace zero-length array with flexible-array member

Hangyu Hua (1):
      net: sched: fix possible refcount leak in tc_chain_tmplt_add()

Ilya Dryomov (2):
      rbd: move RBD_OBJ_FLAG_COPYUP_ENABLED flag setting
      rbd: get snapshot context after exclusive lock is ensured to be held

Ismael Ferreras Morezuelas (1):
      Input: xpad - delete a Razer DeathAdder mouse VID/PID entry

Jiri Slaby (SUSE) (2):
      block/blk-iocost (gcc13): keep large values in a new enum
      bonding (gcc13): synchronize bond_{a,t}lb_xmit() types

Josef Bacik (1):
      btrfs: check return value of btrfs_commit_transaction in relocation

Kuniyuki Iwashima (1):
      netfilter: ipset: Add schedule point in call_ad().

Luiz Augusto von Dentz (1):
      Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk

Martin Hundebøll (1):
      pinctrl: meson-axg: add missing GPIOA_18 gpio group

Oleksij Rempel (1):
      can: j1939: j1939_sk_send_loop_abort(): improved error queue handling in J1939 Socket

Paulo Alcantara (2):
      cifs: get rid of unused parameter in reconn_setup_dfs_targets()
      cifs: handle empty list of targets in cifs_reconnect()

Qingfang DENG (1):
      neighbour: fix unaligned access to pneigh_entry

Randy Dunlap (1):
      eeprom: at24: also select REGMAP

RenHai (1):
      ALSA: hda/realtek: Add Lenovo P3 Tower platform

Ruihan Li (2):
      usb: usbfs: Enforce page requirements for mmap
      usb: usbfs: Use consistent mmap functions

Somnath Kotur (1):
      bnxt_en: Query default VLAN before VNIC setup on a VF

Stephan Gerhold (1):
      spi: qup: Request DMA before enabling clocks

Sungwoo Kim (1):
      Bluetooth: L2CAP: Add missing checks for invalid DCID

Theodore Ts'o (1):
      ext4: only check dquot_initialize_needed() when debugging

Tijs Van Buggenhout (1):
      netfilter: conntrack: fix NULL pointer dereference in nf_confirm_cthelper

Uwe Kleine-König (1):
      i2c: sprd: Delete i2c adapter in .remove's error path

Ville Syrjälä (1):
      drm/atomic: Don't pollute crtc_state->mode_blob with error pointers

Vladislav Efanov (1):
      batman-adv: Broken sync while rescheduling delayed work

Xiubo Li (1):
      ceph: fix use-after-free bug for inodes when flushing capsnaps

Ying Hsu (1):
      Bluetooth: Fix l2cap_disconnect_req deadlock

YouChing Lin (1):
      mtd: spinand: macronix: Add support for MX35LFxGE4AD

Zixuan Fu (1):
      btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()

