Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5AE72C000
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjFLKsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjFLKsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E0A49C5;
        Mon, 12 Jun 2023 03:33:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5582A623E1;
        Mon, 12 Jun 2023 10:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C497C433D2;
        Mon, 12 Jun 2023 10:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565991;
        bh=eJ24hOEaCmyoBhRNnM4VQP5Yjld7Lzx8mLbSnqUwerw=;
        h=From:To:Cc:Subject:Date:From;
        b=s+AwYnnjcHKWzu3aJPgMkH7jhc4IEpKZ48WVvWgrOWvljCmDb7bDN+dtuqILIT+L5
         zGH1uEV5xu4l2a9pYvnbzbixCTG20fU5o633Q5QJO+7Ah9VbKFyyeNoVPyrODxiDLe
         EwkCxKIPvFzgkHEKX2/J9feSKVEoqK06XGds9MjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.10 00/68] 5.10.184-rc1 review
Date:   Mon, 12 Jun 2023 12:25:52 +0200
Message-ID: <20230612101658.437327280@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.184-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.184-rc1
X-KernelTest-Deadline: 2023-06-14T10:17+00:00
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

This is the start of the stable review cycle for the 5.10.184 release.
There are 68 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.184-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.184-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE"

Zixuan Fu <r33s3n6@gmail.com>
    btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()

Josef Bacik <josef@toxicpanda.com>
    btrfs: check return value of btrfs_commit_transaction in relocation

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/atomic: Don't pollute crtc_state->mode_blob with error pointers

Rui Wang <wangrui@loongson.cn>
    MIPS: locking/atomic: Fix atomic{_64,}_sub_if_positive

Darrick J. Wong <djwong@kernel.org>
    xfs: verify buffer contents when we skip log replay

Eric Dumazet <edumazet@google.com>
    tcp: fix tcp_min_tso_segs sysctl

Theodore Ts'o <tytso@mit.edu>
    ext4: only check dquot_initialize_needed() when debugging

Theodore Ts'o <tytso@mit.edu>
    Revert "ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled"

Shannon Nelson <shannon.nelson@amd.com>
    vhost: support PACKED when setting-getting vring_base

Ruan Jinjie <ruanjinjie@huawei.com>
    riscv: fix kprobe __user string arg print fault issue

Randy Dunlap <rdunlap@infradead.org>
    eeprom: at24: also select REGMAP

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    i2c: sprd: Delete i2c adapter in .remove's error path

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: codecs: wsa881x: do not set can_multi_write flag

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    staging: vc04_services: fix gcc-13 build warning

Ruihan Li <lrh2000@pku.edu.cn>
    usb: usbfs: Use consistent mmap functions

Ruihan Li <lrh2000@pku.edu.cn>
    usb: usbfs: Enforce page requirements for mmap

Martin Hundebøll <martin@geanix.com>
    pinctrl: meson-axg: add missing GPIOA_18 gpio group

Ilya Dryomov <idryomov@gmail.com>
    rbd: get snapshot context after exclusive lock is ensured to be held

Ilya Dryomov <idryomov@gmail.com>
    rbd: move RBD_OBJ_FLAG_COPYUP_ENABLED flag setting

Rijo Thomas <Rijo-john.Thomas@amd.com>
    tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: hci_qca: fix debugfs registration

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk

Jan Höppner <hoeppner@linux.ibm.com>
    s390/dasd: Use correct lock while counting channel queue length

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
    bnxt_en: Implement .set_port / .unset_port UDP tunnel callbacks

Somnath Kotur <somnath.kotur@broadcom.com>
    bnxt_en: Query default VLAN before VNIC setup on a VF

Sreekanth Reddy <sreekanth.reddy@broadcom.com>
    bnxt_en: Don't issue AP reset during ethtool's reset operation

Ben Hutchings <ben@decadent.org.uk>
    lib: cpu_rmap: Fix potential use-after-free in irq_cpu_rmap_release()

Jiri Olsa <jolsa@kernel.org>
    bpf: Add extra path pointer check to d_path helper

Hangyu Hua <hbh25y@gmail.com>
    net: sched: fix possible refcount leak in tc_chain_tmplt_add()

Eric Dumazet <edumazet@google.com>
    net: sched: move rtm_tca_policy declaration to include file

Eric Dumazet <edumazet@google.com>
    rfs: annotate lockless accesses to RFS sock flow table

Eric Dumazet <edumazet@google.com>
    rfs: annotate lockless accesses to sk->sk_rxhash

Kuniyuki Iwashima <kuniyu@amazon.com>
    ipv6: rpl: Fix Route of Death.

Kuniyuki Iwashima <kuniyu@amazon.com>
    netfilter: ipset: Add schedule point in call_ad().

Tijs Van Buggenhout <tijs.van.buggenhout@axsguard.com>
    netfilter: conntrack: fix NULL pointer dereference in nf_confirm_cthelper

Manish Chopra <manishc@marvell.com>
    qed/qede: Fix scheduling while atomic

Sungwoo Kim <iam@sung-woo.kim>
    Bluetooth: L2CAP: Add missing checks for invalid DCID

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Fix l2cap_disconnect_req deadlock

Eric Dumazet <edumazet@google.com>
    net/sched: fq_pie: ensure reasonable TCA_FQ_PIE_QUANTUM values

Wen Gu <guwen@linux.alibaba.com>
    net/smc: Avoid to access invalid RMBs' MRs in SMCRv1 ADD LINK CONT

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    net: dsa: lan9303: allow vid != 0 in port_fdb_{add|del} methods

Qingfang DENG <qingfang.deng@siflower.com.cn>
    neighbour: fix unaligned access to pneigh_entry

Lorenzo Bianconi <lorenzo@kernel.org>
    wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll

David Howells <dhowells@redhat.com>
    afs: Fix setting of mtime when creating a file/dir/symlink

Stephan Gerhold <stephan@gerhold.net>
    spi: qup: Request DMA before enabling clocks

Stefan Wahren <stefan.wahren@i2se.com>
    staging: vchiq_core: drop vchiq_status from vchiq_initialise

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    i40e: fix build warning in ice_fltr_add_mac_to_list()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    i40e: fix build warnings in i40e_alloc.h

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    i40iw: fix build warning in i40iw_manage_apbvt()

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    block/blk-iocost (gcc13): keep large values in a new enum

Arnd Bergmann <arnd@arndb.de>
    blk-iocost: avoid 64-bit division in ioc_timer_fn

Qilin Tan <qilin.tan@mediatek.com>
    f2fs: fix iostat lock protection

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    bonding (gcc13): synchronize bond_{a,t}lb_xmit() types

Christoph Hellwig <hch@lst.de>
    remove the sx8 block driver

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    sfc (gcc13): synchronize ef100_enqueue_skb()'s return type

Kees Cook <keescook@chromium.org>
    gcc-plugins: Reorganize gimple includes for GCC 13

Arnd Bergmann <arnd@arndb.de>
    ata: ahci: fix enum constants for gcc-13


-------------

Diffstat:

 Makefile                                           |    4 +-
 arch/mips/include/asm/atomic.h                     |    2 +-
 arch/riscv/Kconfig                                 |    1 +
 block/blk-iocost.c                                 |   10 +-
 drivers/ata/ahci.h                                 |  241 +--
 drivers/block/Kconfig                              |    9 -
 drivers/block/Makefile                             |    2 -
 drivers/block/rbd.c                                |   62 +-
 drivers/block/sx8.c                                | 1586 --------------------
 drivers/bluetooth/hci_qca.c                        |    6 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   11 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |   14 +-
 drivers/i2c/busses/i2c-sprd.c                      |    8 +-
 drivers/infiniband/hw/i40iw/i40iw.h                |    5 +-
 drivers/input/joystick/xpad.c                      |    1 -
 drivers/input/mouse/elantech.c                     |    9 +-
 drivers/misc/eeprom/Kconfig                        |    1 +
 drivers/net/dsa/lan9303-core.c                     |    4 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   28 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_alloc.h       |   17 +-
 drivers/net/ethernet/intel/ice/ice_fltr.c          |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |    2 +-
 drivers/net/ethernet/qlogic/qede/qede.h            |    4 +
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   24 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c       |   34 +-
 drivers/net/ethernet/sfc/ef100_tx.c                |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |    3 +
 drivers/pinctrl/meson/pinctrl-meson-axg.c          |    1 +
 drivers/s390/block/dasd_ioctl.c                    |    4 +-
 drivers/spi/spi-qup.c                              |   37 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |    6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |    5 +
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   24 +-
 drivers/tee/amdtee/amdtee_if.h                     |   10 +-
 drivers/tee/amdtee/call.c                          |   28 +-
 drivers/usb/core/buffer.c                          |   41 +
 drivers/usb/core/devio.c                           |   20 +-
 drivers/vhost/vhost.c                              |   18 +-
 drivers/vhost/vhost.h                              |    8 +-
 fs/afs/dir.c                                       |    3 +
 fs/btrfs/relocation.c                              |   14 +-
 fs/ceph/caps.c                                     |    6 +
 fs/ceph/snap.c                                     |    4 +-
 fs/ext4/super.c                                    |    6 +-
 fs/ext4/xattr.c                                    |    6 +-
 fs/f2fs/sysfs.c                                    |    4 +-
 fs/xfs/xfs_buf_item_recover.c                      |   10 +
 include/linux/netdevice.h                          |    7 +-
 include/linux/usb/hcd.h                            |    5 +
 include/net/bond_alb.h                             |    4 +-
 include/net/neighbour.h                            |    2 +-
 include/net/pkt_sched.h                            |    2 +
 include/net/rpl.h                                  |    3 -
 include/net/sock.h                                 |   18 +-
 kernel/trace/bpf_trace.c                           |   12 +-
 lib/cpu_rmap.c                                     |    2 +-
 net/batman-adv/distributed-arp-table.c             |    2 +-
 net/bluetooth/hci_core.c                           |    8 +-
 net/bluetooth/l2cap_core.c                         |   13 +
 net/can/j1939/main.c                               |   24 +-
 net/can/j1939/socket.c                             |    5 +
 net/core/dev.c                                     |    6 +-
 net/ipv4/sysctl_net_ipv4.c                         |    2 -
 net/ipv6/exthdrs.c                                 |   29 +-
 net/netfilter/ipset/ip_set_core.c                  |    8 +
 net/netfilter/nf_conntrack_core.c                  |    3 +
 net/sched/cls_api.c                                |    3 +-
 net/sched/sch_fq_pie.c                             |    8 +-
 net/smc/smc_llc.c                                  |    4 +-
 scripts/gcc-plugins/gcc-common.h                   |    9 +-
 sound/pci/hda/patch_realtek.c                      |    2 +
 sound/soc/codecs/wsa881x.c                         |    1 -
 73 files changed, 602 insertions(+), 1930 deletions(-)


