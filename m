Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B638713C40
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 21:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjE1TNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 15:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjE1TNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 15:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471CEA0;
        Sun, 28 May 2023 12:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE7306158A;
        Sun, 28 May 2023 19:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBE5C433EF;
        Sun, 28 May 2023 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301207;
        bh=CwV+oYP9EnkaPpKwMndtOk7kLFfEjVjZeQob18O4Cgw=;
        h=From:To:Cc:Subject:Date:From;
        b=JEX3Xxy9qX/oBsdaj4VOI5gOasnoA4HZogXf2yc2sp1U7DmZI0oOfCga/arvX8uSw
         O3ADNrbpHo07FnJn7dld2EetfvMwagtoJSIbfqzwIbLWKeWE7gLXBnx2JvqUqG3v9F
         yf4083ynHRRmAI4ZIvl2vwYJ0ZOhw2OZ8kHVn8Ro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 4.14 00/86] 4.14.316-rc1 review
Date:   Sun, 28 May 2023 20:09:34 +0100
Message-Id: <20230528190828.564682883@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.316-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.316-rc1
X-KernelTest-Deadline: 2023-05-30T19:08+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.316 release.
There are 86 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.316-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.316-rc1

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    3c589_cs: Fix an error handling path in tc589_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    forcedeth: Fix an error handling path in nv_probe()

Vernon Lovejoy <vlovejoy@redhat.com>
    x86/show_trace_log_lvl: Ensure stack pointer is aligned, again

Dan Carpenter <dan.carpenter@linaro.org>
    xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()

Daisuke Nojiri <dnojiri@chromium.org>
    power: supply: sbs-charger: Fix INHIBITED bit for Status reg

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Fix poll_interval handling and races on remove

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Fix I2C IRQ race on remove

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition

Hans de Goede <hdegoede@redhat.com>
    power: supply: leds: Fix blink to LED on transition

Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
    ipv6: Fix out-of-bounds access in ipv6_find_tlv()

Pratyush Yadav <ptyadav@amazon.de>
    net: fix skb leak in __skb_tstamp_tx()

Alan Stern <stern@rowland.harvard.edu>
    media: radio-shark: Add endpoint checks

Alan Stern <stern@rowland.harvard.edu>
    USB: sisusbvga: Add endpoint checks

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Add routines for endpoint checks in old drivers

Hardik Garg <hargar@linux.microsoft.com>
    selftests/memfd: Fix unknown type name build failure

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm: Avoid incomplete Global INVLPG flushes

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix register ordering

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: do not allow SET_ID to refer to another table

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: do not allow RULE_ID to refer to another chain

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_dynset: do not reject set updates with NFT_SET_EVAL

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: stricter validation of element data

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: allow up to 64 bytes in the set element data area

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: add nft_setelem_parse_key()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: validate registers coming from userspace.

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nftables: statify nft_parse_register()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nftables: add nft_parse_register_store() and use it

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nftables: add nft_parse_register_load() and use it

Helge Deller <deller@gmx.de>
    parisc: Allow to reboot machine after system halt

Finn Thain <fthain@linux-m68k.org>
    m68k: Move signal frame following exception on 68020/030

Christophe Leroy <christophe.leroy@csgroup.eu>
    spi: fsl-cpm: Use 16 bit mode for large transfers with even size

Christophe Leroy <christophe.leroy@csgroup.eu>
    spi: fsl-spi: Re-organise transfer bits_per_word adaptation

Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    spi: spi-fsl-spi: automatically adapt bits-per-word in cpu mode

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: bogus EBUSY in helper removal from transaction

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()

Xiubo Li <xiubli@redhat.com>
    ceph: force updating the msg pointer in non-split case

Vitaliy Tomin <tomin@iszf.irk.ru>
    serial: Add support for Advantech PCI-1611U card

Ilya Leoshkevich <iii@linux.ibm.com>
    statfs: enforce statfs[64] structure initialization

Nikhil Mahale <nmahale@nvidia.com>
    ALSA: hda: Add NVIDIA codec IDs a3 through a7 to patch table

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Fix Oops by 9.1 surround channel names

Maxime Bizon <mbizon@freebox.fr>
    usb-storage: fix deadlock when a scsi command timeouts more than once

Eric Dumazet <edumazet@google.com>
    vlan: fix a potential uninit-value in vlan_dev_hard_start_xmit()

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    igb: fix bit_shift to be in [1..8] range

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    cassini: Fix a memory leak in the error handling path of cas_init_one()

Dong Chenchen <dongchenchen2@huawei.com>
    net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment()

Duoming Zhou <duoming@zju.edu.cn>
    media: netup_unidvb: fix use-after-free at del_timer()

Zhuang Shengen <zhuangshengen@huawei.com>
    vsock: avoid to close connected socket after the timeout

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    net: fec: Better handle pm_runtime_get() failing in .remove()

Tobias Brunner <tobias@strongswan.org>
    af_key: Reject optional tunnel/BEET mode templates in outbound policies

Wyes Karny <wyes.karny@amd.com>
    cpupower: Make TSC read per CPU for Mperf monitor

Qiang Ning <qning0106@126.com>
    mfd: dln2: Fix memory leak in dln2_probe()

Alain Volmat <avolmat@me.com>
    phy: st: miphy28lp: use _poll_timeout functions for waits

Vicki Pfau <vi@endrift.com>
    Input: xpad - add constants for GIP interface numbers

Arnd Bergmann <arnd@arndb.de>
    clk: tegra20: fix gcc-7 constant overflow warning

Hao Zeng <zenghao@kylinos.cn>
    recordmcount: Fix memory leaks in the uwrite function

Josh Poimboeuf <jpoimboe@kernel.org>
    sched: Fix KCSAN noinstr violation

Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>
    mcb-pci: Reallocate memory region to avoid memory overlapping

Tony Lindgren <tony@atomide.com>
    serial: 8250: Reinit port->pm on port specific driver unbind

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: generic: Set battery quirk only when we see battery data

Kevin Groeneveld <kgroeneveld@lenbrook.com>
    spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3

Bastien Nocera <hadess@hadess.net>
    HID: logitech-hidpp: Reconcile USB and Unifying serials

Bastien Nocera <hadess@hadess.net>
    HID: logitech-hidpp: Don't use the USB serial for USB devices

Philipp Hortmann <philipp.g.hortmann@gmail.com>
    staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE

Min Li <lm0963hack@gmail.com>
    Bluetooth: L2CAP: fix "bad unlock balance" in l2cap_disconnect_rsp

Hans de Goede <hdegoede@redhat.com>
    wifi: iwlwifi: dvm: Fix memcpy: detected field-spanning write backtrace

Chaitanya Kulkarni <kch@nvidia.com>
    null_blk: Always check queue mode setting from configfs

Ojaswin Mujoo <ojaswin@linux.ibm.com>
    ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: set goal start correctly in ext4_mb_normalize_request

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix inode height consistency check

Zheng Wang <zyytlz.wz@163.com>
    scsi: message: mptlan: Fix use after free bug in mptlan_remove() due to race condition

Eli Cohen <elic@nvidia.com>
    lib: cpu_rmap: Avoid use after free on rmap->obj array entries

Nick Child <nnac123@linux.ibm.com>
    net: Catch invalid index in XPS mapping

Nathan Chancellor <nathan@kernel.org>
    net: pasemi: Fix return type of pasemi_mac_start_tx()

Jan Kara <jack@suse.cz>
    ext2: Check block size validity during mount

Hector Martin <marcan@marcan.st>
    wifi: brcmfmac: cfg80211: Pass the PMK in binary instead of hex

void0red <30990023+void0red@users.noreply.github.com>
    ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects

Tamir Duberstein <tamird@google.com>
    ACPICA: Avoid undefined behavior: applying zero offset to null pointer

Nur Hussein <hussein@unixcat.org>
    drm/tegra: Avoid potential 32-bit integer overflow

Armin Wolf <W_Armin@gmx.de>
    ACPI: EC: Fix oops when removing custom query handlers

Zheng Wang <zyytlz.wz@163.com>
    memstick: r592: Fix UAF bug in r592_remove due to race condition

Alexander Stein <alexander.stein@ew.tq-group.com>
    regmap: cache: Return error in cache sync operations for REGCACHE_NONE

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix a data race of sk->sk_receive_queue->qlen.

t.feng <fengtao40@huawei.com>
    ipvlan:Fix out-of-bounds caused by unclear skb->cb

Eric Dumazet <edumazet@google.com>
    net: annotate sk->sk_err write from do_recvmmsg()

Eric Dumazet <edumazet@google.com>
    netlink: annotate accesses to nlk->cb_running

Kuniyuki Iwashima <kuniyu@amazon.com>
    net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/m68k/kernel/signal.c                          |  14 +-
 arch/parisc/kernel/process.c                       |  11 +-
 arch/x86/include/asm/intel-family.h                |   5 +
 arch/x86/kernel/dumpstack.c                        |   7 +-
 arch/x86/mm/init.c                                 |  25 +++
 drivers/acpi/acpica/dbnames.c                      |   3 +
 drivers/acpi/acpica/dswstate.c                     |  11 +-
 drivers/acpi/ec.c                                  |   1 +
 drivers/base/regmap/regcache.c                     |   6 +
 drivers/block/null_blk.c                           |   5 +
 drivers/clk/tegra/clk-tegra20.c                    |  28 +--
 drivers/gpu/drm/tegra/sor.c                        |   2 +-
 drivers/hid/hid-logitech-hidpp.c                   |  53 ++++-
 drivers/hid/wacom_wac.c                            |  33 ++--
 drivers/input/joystick/xpad.c                      |   5 +-
 drivers/mcb/mcb-pci.c                              |  27 ++-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |   2 +-
 drivers/media/radio/radio-shark.c                  |  10 +
 drivers/media/radio/radio-shark2.c                 |  10 +
 drivers/memstick/host/r592.c                       |   2 +-
 drivers/message/fusion/mptlan.c                    |   2 +
 drivers/mfd/dln2.c                                 |   1 +
 drivers/net/ethernet/3com/3c589_cs.c               |  11 +-
 drivers/net/ethernet/freescale/fec_main.c          |  13 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c         |   4 +-
 drivers/net/ethernet/nvidia/forcedeth.c            |   1 +
 drivers/net/ethernet/pasemi/pasemi_mac.c           |   2 +-
 drivers/net/ethernet/sun/cassini.c                 |   2 +
 drivers/net/ipvlan/ipvlan_core.c                   |   6 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  13 +-
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c       |   5 +-
 drivers/phy/st/phy-miphy28lp.c                     |  42 +---
 drivers/power/supply/bq27xxx_battery.c             |  41 ++--
 drivers/power/supply/bq27xxx_battery_i2c.c         |   3 +-
 drivers/power/supply/power_supply_leds.c           |   5 +-
 drivers/power/supply/sbs-charger.c                 |   2 +-
 drivers/spi/spi-fsl-cpm.c                          |  23 +++
 drivers/spi/spi-fsl-spi.c                          |  65 +++---
 drivers/spi/spi-imx.c                              |  24 ++-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |   5 -
 drivers/tty/serial/8250/8250_core.c                |   1 +
 drivers/tty/serial/8250/8250_pci.c                 |   5 +
 drivers/usb/core/usb.c                             |  76 +++++++
 drivers/usb/misc/sisusbvga/sisusb.c                |  14 ++
 drivers/usb/storage/scsiglue.c                     |  28 ++-
 drivers/xen/pvcalls-back.c                         |   9 +-
 fs/ceph/snap.c                                     |  13 ++
 fs/ext2/ext2.h                                     |   1 +
 fs/ext2/super.c                                    |   7 +
 fs/ext4/mballoc.c                                  |  65 +++---
 fs/gfs2/glops.c                                    |   3 +-
 fs/hfsplus/inode.c                                 |  28 ++-
 fs/nilfs2/inode.c                                  |  18 ++
 fs/statfs.c                                        |   4 +-
 include/linux/power/bq27xxx_battery.h              |   1 +
 include/linux/sched/task_stack.h                   |   2 +-
 include/linux/usb.h                                |   5 +
 include/net/netfilter/nf_tables.h                  |  17 +-
 include/net/netfilter/nf_tables_core.h             |  14 +-
 include/net/netfilter/nft_fib.h                    |   2 +-
 include/net/netfilter/nft_masq.h                   |   4 +-
 include/net/netfilter/nft_meta.h                   |   4 +-
 include/net/netfilter/nft_redir.h                  |   4 +-
 include/net/sock.h                                 |   2 +-
 include/uapi/linux/netfilter/nf_tables.h           |   2 +-
 lib/cpu_rmap.c                                     |   5 +-
 net/8021q/vlan_dev.c                               |   4 +-
 net/bluetooth/l2cap_core.c                         |   1 -
 net/bridge/netfilter/nft_meta_bridge.c             |   5 +-
 net/core/dev.c                                     |   2 +
 net/core/skbuff.c                                  |   4 +-
 net/ipv4/netfilter/nft_dup_ipv4.c                  |  18 +-
 net/ipv6/exthdrs_core.c                            |   2 +
 net/ipv6/netfilter/nft_dup_ipv6.c                  |  18 +-
 net/key/af_key.c                                   |  12 +-
 net/netfilter/nf_tables_api.c                      | 220 ++++++++++++++-------
 net/netfilter/nft_bitwise.c                        |  14 +-
 net/netfilter/nft_byteorder.c                      |  14 +-
 net/netfilter/nft_cmp.c                            |   8 +-
 net/netfilter/nft_ct.c                             |  12 +-
 net/netfilter/nft_dup_netdev.c                     |   6 +-
 net/netfilter/nft_dynset.c                         |  16 +-
 net/netfilter/nft_exthdr.c                         |  14 +-
 net/netfilter/nft_fib.c                            |   5 +-
 net/netfilter/nft_fwd_netdev.c                     |   6 +-
 net/netfilter/nft_hash.c                           |  25 ++-
 net/netfilter/nft_immediate.c                      |   8 +-
 net/netfilter/nft_lookup.c                         |  14 +-
 net/netfilter/nft_masq.c                           |  14 +-
 net/netfilter/nft_meta.c                           |   8 +-
 net/netfilter/nft_nat.c                            |  35 ++--
 net/netfilter/nft_numgen.c                         |  15 +-
 net/netfilter/nft_objref.c                         |  25 ++-
 net/netfilter/nft_payload.c                        |  10 +-
 net/netfilter/nft_queue.c                          |  12 +-
 net/netfilter/nft_range.c                          |   6 +-
 net/netfilter/nft_redir.c                          |  14 +-
 net/netfilter/nft_rt.c                             |   7 +-
 net/netlink/af_netlink.c                           |   8 +-
 net/nsh/nsh.c                                      |   8 +-
 net/socket.c                                       |   2 +-
 net/unix/af_unix.c                                 |   2 +-
 net/vmw_vsock/af_vsock.c                           |   2 +-
 scripts/recordmcount.c                             |   6 +-
 sound/pci/hda/hda_generic.c                        |   7 +-
 sound/pci/hda/patch_hdmi.c                         |   5 +
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |  31 ++-
 tools/testing/selftests/memfd/fuse_test.c          |   1 +
 110 files changed, 1005 insertions(+), 515 deletions(-)


