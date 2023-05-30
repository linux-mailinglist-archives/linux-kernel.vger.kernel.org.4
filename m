Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E7C715DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjE3Lvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjE3Lvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B22B0;
        Tue, 30 May 2023 04:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90E6B62E5E;
        Tue, 30 May 2023 11:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864BFC4339B;
        Tue, 30 May 2023 11:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685447509;
        bh=3sA34RshXB1Z+LVJGO7WtjiiJs7QcDqwKMraYK2O3n8=;
        h=From:To:Cc:Subject:Date:From;
        b=UwMMFvMNLlDSbJSiJym35aAzK3txt49nb5tC0Irxl3yarVhndcqXuff+ebjHZikcZ
         azMqTGKvkFY4H81oatOoE23y2MWaWNBPlRJjkvYEHGs8plB2PRI/AMf+ud5aaW04+T
         j5ohz6FMJK4cTJ/OSJ24Sd92KabPRVDnm0rXgPR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.316
Date:   Tue, 30 May 2023 12:51:45 +0100
Message-Id: <2023053045-overpower-tux-a39f@gregkh>
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

I'm announcing the release of the 4.14.316 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/m68k/kernel/signal.c                                   |   14 
 arch/parisc/kernel/process.c                                |   11 
 arch/x86/include/asm/intel-family.h                         |    5 
 arch/x86/kernel/dumpstack.c                                 |    7 
 arch/x86/mm/init.c                                          |   25 +
 drivers/acpi/acpica/dbnames.c                               |    3 
 drivers/acpi/acpica/dswstate.c                              |   11 
 drivers/acpi/ec.c                                           |    1 
 drivers/base/regmap/regcache.c                              |    6 
 drivers/clk/tegra/clk-tegra20.c                             |   28 -
 drivers/gpu/drm/tegra/sor.c                                 |    2 
 drivers/hid/hid-logitech-hidpp.c                            |   53 ++
 drivers/hid/wacom_wac.c                                     |   33 -
 drivers/input/joystick/xpad.c                               |    5 
 drivers/mcb/mcb-pci.c                                       |   27 +
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c          |    2 
 drivers/media/radio/radio-shark.c                           |   10 
 drivers/media/radio/radio-shark2.c                          |   10 
 drivers/memstick/host/r592.c                                |    2 
 drivers/message/fusion/mptlan.c                             |    2 
 drivers/mfd/dln2.c                                          |    1 
 drivers/net/ethernet/3com/3c589_cs.c                        |   11 
 drivers/net/ethernet/freescale/fec_main.c                   |   13 
 drivers/net/ethernet/intel/igb/e1000_mac.c                  |    4 
 drivers/net/ethernet/nvidia/forcedeth.c                     |    1 
 drivers/net/ethernet/pasemi/pasemi_mac.c                    |    2 
 drivers/net/ethernet/sun/cassini.c                          |    2 
 drivers/net/ipvlan/ipvlan_core.c                            |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |   13 
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c                |    5 
 drivers/phy/st/phy-miphy28lp.c                              |   42 --
 drivers/power/supply/bq27xxx_battery.c                      |   41 +-
 drivers/power/supply/bq27xxx_battery_i2c.c                  |    3 
 drivers/power/supply/power_supply_leds.c                    |    5 
 drivers/power/supply/sbs-charger.c                          |    2 
 drivers/spi/spi-fsl-cpm.c                                   |   23 +
 drivers/spi/spi-fsl-spi.c                                   |   65 ++-
 drivers/spi/spi-imx.c                                       |   24 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                |    6 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h                |    5 
 drivers/tty/serial/8250/8250_core.c                         |    1 
 drivers/tty/serial/8250/8250_pci.c                          |    5 
 drivers/usb/core/usb.c                                      |   76 ++++
 drivers/usb/misc/sisusbvga/sisusb.c                         |   14 
 drivers/usb/storage/scsiglue.c                              |   28 +
 drivers/xen/pvcalls-back.c                                  |    9 
 fs/ceph/snap.c                                              |   13 
 fs/ext2/ext2.h                                              |    1 
 fs/ext2/super.c                                             |    7 
 fs/ext4/mballoc.c                                           |   65 ++-
 fs/gfs2/glops.c                                             |    3 
 fs/hfsplus/inode.c                                          |   28 +
 fs/nilfs2/inode.c                                           |   18 
 fs/statfs.c                                                 |    4 
 include/linux/power/bq27xxx_battery.h                       |    1 
 include/linux/sched/task_stack.h                            |    2 
 include/linux/usb.h                                         |    5 
 include/net/netfilter/nf_tables.h                           |   17 
 include/net/netfilter/nf_tables_core.h                      |   14 
 include/net/netfilter/nft_fib.h                             |    2 
 include/net/netfilter/nft_masq.h                            |    4 
 include/net/netfilter/nft_meta.h                            |    4 
 include/net/netfilter/nft_redir.h                           |    4 
 include/net/sock.h                                          |    2 
 include/uapi/linux/netfilter/nf_tables.h                    |    2 
 lib/cpu_rmap.c                                              |    5 
 net/8021q/vlan_dev.c                                        |    4 
 net/bluetooth/l2cap_core.c                                  |    1 
 net/bridge/netfilter/nft_meta_bridge.c                      |    5 
 net/core/dev.c                                              |    2 
 net/core/skbuff.c                                           |    4 
 net/ipv4/netfilter/nft_dup_ipv4.c                           |   18 
 net/ipv6/exthdrs_core.c                                     |    2 
 net/ipv6/netfilter/nft_dup_ipv6.c                           |   18 
 net/key/af_key.c                                            |   12 
 net/netfilter/nf_tables_api.c                               |  220 ++++++++----
 net/netfilter/nft_bitwise.c                                 |   14 
 net/netfilter/nft_byteorder.c                               |   14 
 net/netfilter/nft_cmp.c                                     |    8 
 net/netfilter/nft_ct.c                                      |   12 
 net/netfilter/nft_dup_netdev.c                              |    6 
 net/netfilter/nft_dynset.c                                  |   16 
 net/netfilter/nft_exthdr.c                                  |   14 
 net/netfilter/nft_fib.c                                     |    5 
 net/netfilter/nft_fwd_netdev.c                              |    6 
 net/netfilter/nft_hash.c                                    |   25 -
 net/netfilter/nft_immediate.c                               |    8 
 net/netfilter/nft_lookup.c                                  |   14 
 net/netfilter/nft_masq.c                                    |   14 
 net/netfilter/nft_meta.c                                    |    8 
 net/netfilter/nft_nat.c                                     |   35 -
 net/netfilter/nft_numgen.c                                  |   15 
 net/netfilter/nft_objref.c                                  |   25 +
 net/netfilter/nft_payload.c                                 |   10 
 net/netfilter/nft_queue.c                                   |   12 
 net/netfilter/nft_range.c                                   |    6 
 net/netfilter/nft_redir.c                                   |   14 
 net/netfilter/nft_rt.c                                      |    7 
 net/netlink/af_netlink.c                                    |    8 
 net/nsh/nsh.c                                               |    8 
 net/socket.c                                                |    2 
 net/unix/af_unix.c                                          |    2 
 net/vmw_vsock/af_vsock.c                                    |    2 
 scripts/recordmcount.c                                      |    6 
 sound/pci/hda/hda_generic.c                                 |    7 
 sound/pci/hda/patch_hdmi.c                                  |    5 
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c     |   31 -
 tools/testing/selftests/memfd/fuse_test.c                   |    1 
 109 files changed, 999 insertions(+), 514 deletions(-)

Alain Volmat (1):
      phy: st: miphy28lp: use _poll_timeout functions for waits

Alan Stern (3):
      USB: core: Add routines for endpoint checks in old drivers
      USB: sisusbvga: Add endpoint checks
      media: radio-shark: Add endpoint checks

Aleksandr Loktionov (1):
      igb: fix bit_shift to be in [1..8] range

Alexander Stein (1):
      regmap: cache: Return error in cache sync operations for REGCACHE_NONE

Andreas Gruenbacher (1):
      gfs2: Fix inode height consistency check

Armin Wolf (1):
      ACPI: EC: Fix oops when removing custom query handlers

Arnd Bergmann (1):
      clk: tegra20: fix gcc-7 constant overflow warning

Bastien Nocera (2):
      HID: logitech-hidpp: Don't use the USB serial for USB devices
      HID: logitech-hidpp: Reconcile USB and Unifying serials

Christophe JAILLET (3):
      cassini: Fix a memory leak in the error handling path of cas_init_one()
      forcedeth: Fix an error handling path in nv_probe()
      3c589_cs: Fix an error handling path in tc589_probe()

Christophe Leroy (2):
      spi: fsl-spi: Re-organise transfer bits_per_word adaptation
      spi: fsl-cpm: Use 16 bit mode for large transfers with even size

Daisuke Nojiri (1):
      power: supply: sbs-charger: Fix INHIBITED bit for Status reg

Dan Carpenter (1):
      xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()

Dave Hansen (1):
      x86/mm: Avoid incomplete Global INVLPG flushes

Dong Chenchen (1):
      net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment()

Duoming Zhou (1):
      media: netup_unidvb: fix use-after-free at del_timer()

Eli Cohen (1):
      lib: cpu_rmap: Avoid use after free on rmap->obj array entries

Eric Dumazet (3):
      netlink: annotate accesses to nlk->cb_running
      net: annotate sk->sk_err write from do_recvmmsg()
      vlan: fix a potential uninit-value in vlan_dev_hard_start_xmit()

Finn Thain (1):
      m68k: Move signal frame following exception on 68020/030

Florian Westphal (1):
      netfilter: nf_tables: fix register ordering

Gavrilov Ilia (1):
      ipv6: Fix out-of-bounds access in ipv6_find_tlv()

Greg Kroah-Hartman (1):
      Linux 4.14.316

Hans de Goede (5):
      wifi: iwlwifi: dvm: Fix memcpy: detected field-spanning write backtrace
      power: supply: leds: Fix blink to LED on transition
      power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
      power: supply: bq27xxx: Fix I2C IRQ race on remove
      power: supply: bq27xxx: Fix poll_interval handling and races on remove

Hao Zeng (1):
      recordmcount: Fix memory leaks in the uwrite function

Hardik Garg (1):
      selftests/memfd: Fix unknown type name build failure

Hector Martin (1):
      wifi: brcmfmac: cfg80211: Pass the PMK in binary instead of hex

Helge Deller (1):
      parisc: Allow to reboot machine after system halt

Ilya Leoshkevich (1):
      statfs: enforce statfs[64] structure initialization

Jan Kara (1):
      ext2: Check block size validity during mount

Jason Gerecke (1):
      HID: wacom: generic: Set battery quirk only when we see battery data

Josh Poimboeuf (1):
      sched: Fix KCSAN noinstr violation

Kemeng Shi (1):
      ext4: set goal start correctly in ext4_mb_normalize_request

Kevin Groeneveld (1):
      spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3

Kuniyuki Iwashima (2):
      net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().
      af_unix: Fix a data race of sk->sk_receive_queue->qlen.

Maxime Bizon (1):
      usb-storage: fix deadlock when a scsi command timeouts more than once

Min Li (1):
      Bluetooth: L2CAP: fix "bad unlock balance" in l2cap_disconnect_rsp

Nathan Chancellor (1):
      net: pasemi: Fix return type of pasemi_mac_start_tx()

Nick Child (1):
      net: Catch invalid index in XPS mapping

Nikhil Mahale (1):
      ALSA: hda: Add NVIDIA codec IDs a3 through a7 to patch table

Nur Hussein (1):
      drm/tegra: Avoid potential 32-bit integer overflow

Ojaswin Mujoo (1):
      ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()

Pablo Neira Ayuso (11):
      netfilter: nf_tables: bogus EBUSY in helper removal from transaction
      netfilter: nftables: add nft_parse_register_load() and use it
      netfilter: nftables: add nft_parse_register_store() and use it
      netfilter: nftables: statify nft_parse_register()
      netfilter: nf_tables: validate registers coming from userspace.
      netfilter: nf_tables: add nft_setelem_parse_key()
      netfilter: nf_tables: allow up to 64 bytes in the set element data area
      netfilter: nf_tables: stricter validation of element data
      netfilter: nft_dynset: do not reject set updates with NFT_SET_EVAL
      netfilter: nf_tables: do not allow RULE_ID to refer to another chain
      netfilter: nf_tables: do not allow SET_ID to refer to another table

Philipp Hortmann (1):
      staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE

Pratyush Yadav (1):
      net: fix skb leak in __skb_tstamp_tx()

Qiang Ning (1):
      mfd: dln2: Fix memory leak in dln2_probe()

Rasmus Villemoes (1):
      spi: spi-fsl-spi: automatically adapt bits-per-word in cpu mode

Rodríguez Barbarin, José Javier (1):
      mcb-pci: Reallocate memory region to avoid memory overlapping

Ryusuke Konishi (1):
      nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()

Takashi Iwai (1):
      ALSA: hda: Fix Oops by 9.1 surround channel names

Tamir Duberstein (1):
      ACPICA: Avoid undefined behavior: applying zero offset to null pointer

Tetsuo Handa (1):
      fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()

Tobias Brunner (1):
      af_key: Reject optional tunnel/BEET mode templates in outbound policies

Tony Lindgren (1):
      serial: 8250: Reinit port->pm on port specific driver unbind

Uwe Kleine-König (1):
      net: fec: Better handle pm_runtime_get() failing in .remove()

Vernon Lovejoy (1):
      x86/show_trace_log_lvl: Ensure stack pointer is aligned, again

Vicki Pfau (1):
      Input: xpad - add constants for GIP interface numbers

Vitaliy Tomin (1):
      serial: Add support for Advantech PCI-1611U card

Wyes Karny (1):
      cpupower: Make TSC read per CPU for Mperf monitor

Xiubo Li (1):
      ceph: force updating the msg pointer in non-split case

Zheng Wang (2):
      memstick: r592: Fix UAF bug in r592_remove due to race condition
      scsi: message: mptlan: Fix use after free bug in mptlan_remove() due to race condition

Zhuang Shengen (1):
      vsock: avoid to close connected socket after the timeout

t.feng (1):
      ipvlan:Fix out-of-bounds caused by unclear skb->cb

void0red (1):
      ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects

