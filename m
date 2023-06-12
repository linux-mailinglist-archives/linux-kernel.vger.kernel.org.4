Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB5D72BFBA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjFLKqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFLKqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B81FB85;
        Mon, 12 Jun 2023 03:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35582614F0;
        Mon, 12 Jun 2023 10:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D9FC433D2;
        Mon, 12 Jun 2023 10:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565862;
        bh=xXvh6whKzQQkGoNYE/y5QMSe3D5thsx5ACWeKPVpc70=;
        h=From:To:Cc:Subject:Date:From;
        b=fUY2NYY1t7sWgXn3x2ED/sz+xMBIxjRC698c5YMA92L2CmzWd0jNH84Ax767lSzVt
         6ApjQAiOcGyjOphfxmxtmIo9PTV4NUHvX+AzWWv9TS/BAliadc4sEFPREmt0v98USu
         kiFNyYm36o5/llmEgLyzz0DhxTKS13fpiDi/ADfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.4 00/45] 5.4.247-rc1 review
Date:   Mon, 12 Jun 2023 12:25:54 +0200
Message-ID: <20230612101654.644983109@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.247-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.247-rc1
X-KernelTest-Deadline: 2023-06-14T10:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.4.247 release.
There are 45 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.247-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.247-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE"

YouChing Lin <ycllin@mxic.com.tw>
    mtd: spinand: macronix: Add support for MX35LFxGE4AD

Zixuan Fu <r33s3n6@gmail.com>
    btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()

Josef Bacik <josef@toxicpanda.com>
    btrfs: check return value of btrfs_commit_transaction in relocation

Ilya Dryomov <idryomov@gmail.com>
    rbd: get snapshot context after exclusive lock is ensured to be held

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/atomic: Don't pollute crtc_state->mode_blob with error pointers

Paulo Alcantara <pc@cjr.nz>
    cifs: handle empty list of targets in cifs_reconnect()

Paulo Alcantara <pc@cjr.nz>
    cifs: get rid of unused parameter in reconn_setup_dfs_targets()

Theodore Ts'o <tytso@mit.edu>
    ext4: only check dquot_initialize_needed() when debugging

Randy Dunlap <rdunlap@infradead.org>
    eeprom: at24: also select REGMAP

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    i2c: sprd: Delete i2c adapter in .remove's error path

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    bonding (gcc13): synchronize bond_{a,t}lb_xmit() types

Ruihan Li <lrh2000@pku.edu.cn>
    usb: usbfs: Use consistent mmap functions

Ruihan Li <lrh2000@pku.edu.cn>
    usb: usbfs: Enforce page requirements for mmap

Martin Hundebøll <martin@geanix.com>
    pinctrl: meson-axg: add missing GPIOA_18 gpio group

Ilya Dryomov <idryomov@gmail.com>
    rbd: move RBD_OBJ_FLAG_COPYUP_ENABLED flag setting

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk

Xiubo Li <xiubli@redhat.com>
    ceph: fix use-after-free bug for inodes when flushing capsnaps

Fedor Pchelkin <pchelkin@ispras.ru>
    can: j1939: avoid possible use-after-free when j1939_can_rx_register fails

Fedor Pchelkin <pchelkin@ispras.ru>
    can: j1939: change j1939_netdev_lock type to mutex

Oleksij Rempel <linux@rempel-privat.de>
    can: j1939: j1939_sk_send_loop_abort(): improved error queue handling in J1939 Socket

Chia-I Wu <olvaffe@gmail.com>
    drm/amdgpu: fix xclk freq on CHIP_STONEY

RenHai <kean0048@gmail.com>
    ALSA: hda/realtek: Add Lenovo P3 Tower platform

Ai Chao <aichao@kylinos.cn>
    ALSA: hda/realtek: Add a quirk for HP Slim Desktop S01

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: psmouse - fix OOB access in Elantech protocol

Ismael Ferreras Morezuelas <swyterzone@gmail.com>
    Input: xpad - delete a Razer DeathAdder mouse VID/PID entry

Vladislav Efanov <VEfanov@ispras.ru>
    batman-adv: Broken sync while rescheduling delayed work

Somnath Kotur <somnath.kotur@broadcom.com>
    bnxt_en: Query default VLAN before VNIC setup on a VF

Ben Hutchings <ben@decadent.org.uk>
    lib: cpu_rmap: Fix potential use-after-free in irq_cpu_rmap_release()

Hangyu Hua <hbh25y@gmail.com>
    net: sched: fix possible refcount leak in tc_chain_tmplt_add()

Eric Dumazet <edumazet@google.com>
    net: sched: move rtm_tca_policy declaration to include file

Eric Dumazet <edumazet@google.com>
    rfs: annotate lockless accesses to RFS sock flow table

Eric Dumazet <edumazet@google.com>
    rfs: annotate lockless accesses to sk->sk_rxhash

Kuniyuki Iwashima <kuniyu@amazon.com>
    netfilter: ipset: Add schedule point in call_ad().

Tijs Van Buggenhout <tijs.van.buggenhout@axsguard.com>
    netfilter: conntrack: fix NULL pointer dereference in nf_confirm_cthelper

Sungwoo Kim <iam@sung-woo.kim>
    Bluetooth: L2CAP: Add missing checks for invalid DCID

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Fix l2cap_disconnect_req deadlock

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    net: dsa: lan9303: allow vid != 0 in port_fdb_{add|del} methods

Qingfang DENG <qingfang.deng@siflower.com.cn>
    neighbour: fix unaligned access to pneigh_entry

Gustavo A. R. Silva <gustavo@embeddedor.com>
    neighbour: Replace zero-length array with flexible-array member

Stephan Gerhold <stephan@gerhold.net>
    spi: qup: Request DMA before enabling clocks

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    i40e: fix build warnings in i40e_alloc.h

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    i40iw: fix build warning in i40iw_manage_apbvt()

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    block/blk-iocost (gcc13): keep large values in a new enum

Arnd Bergmann <arnd@arndb.de>
    blk-iocost: avoid 64-bit division in ioc_timer_fn


-------------

Diffstat:

 Makefile                                     |  4 +-
 block/blk-iocost.c                           | 10 ++--
 drivers/block/rbd.c                          | 73 +++++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vi.c              | 11 ++++-
 drivers/gpu/drm/drm_atomic_uapi.c            | 14 +++---
 drivers/i2c/busses/i2c-sprd.c                |  8 +--
 drivers/infiniband/hw/i40iw/i40iw.h          |  5 +-
 drivers/input/joystick/xpad.c                |  1 -
 drivers/input/mouse/elantech.c               |  9 ++--
 drivers/misc/eeprom/Kconfig                  |  1 +
 drivers/mtd/nand/spi/macronix.c              | 16 ++++++
 drivers/net/dsa/lan9303-core.c               |  4 --
 drivers/net/ethernet/broadcom/bnxt/bnxt.c    |  3 ++
 drivers/net/ethernet/intel/i40e/i40e_alloc.h | 17 +++----
 drivers/pinctrl/meson/pinctrl-meson-axg.c    |  1 +
 drivers/spi/spi-qup.c                        | 37 +++++++-------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  6 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  5 ++
 drivers/usb/core/buffer.c                    | 41 ++++++++++++++++
 drivers/usb/core/devio.c                     | 20 +++++---
 fs/btrfs/relocation.c                        | 14 ++++--
 fs/ceph/caps.c                               |  6 +++
 fs/ceph/snap.c                               |  4 +-
 fs/cifs/connect.c                            | 15 +++---
 fs/ext4/xattr.c                              |  6 ++-
 include/linux/netdevice.h                    |  7 ++-
 include/linux/usb/hcd.h                      |  5 ++
 include/net/bond_alb.h                       |  4 +-
 include/net/neighbour.h                      |  2 +-
 include/net/pkt_sched.h                      |  2 +
 include/net/sock.h                           | 18 +++++--
 lib/cpu_rmap.c                               |  2 +-
 net/batman-adv/distributed-arp-table.c       |  2 +-
 net/bluetooth/hci_core.c                     |  8 +--
 net/bluetooth/l2cap_core.c                   | 13 +++++
 net/can/j1939/main.c                         | 24 ++++-----
 net/can/j1939/socket.c                       |  5 ++
 net/core/dev.c                               |  6 ++-
 net/netfilter/ipset/ip_set_core.c            |  8 +++
 net/netfilter/nf_conntrack_core.c            |  3 ++
 net/sched/cls_api.c                          |  3 +-
 sound/pci/hda/patch_realtek.c                |  2 +
 42 files changed, 305 insertions(+), 140 deletions(-)


