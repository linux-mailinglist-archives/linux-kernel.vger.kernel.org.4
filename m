Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB78715DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjE3LwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjE3LwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685D2100;
        Tue, 30 May 2023 04:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFB5162E89;
        Tue, 30 May 2023 11:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCE3C433D2;
        Tue, 30 May 2023 11:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685447518;
        bh=lftMEFsHZBGYzpM539nXV9UaWM+HBPLpcTJEwzqm9TI=;
        h=From:To:Cc:Subject:Date:From;
        b=Xz/cOTkL+kXUUDoWaukCEUXxReXW2iODoO6Gfym370Tri3r95ZZvJj+Hw1/7zzIZz
         DX7Z1Iuz3ftGDddNynhTnwF6EsqeQR39djk9myyw/mLSno6kUCdveMVCAXjWWdBjPk
         1MJwip0OGqx0gWHFj1rm2JHmSwqZuMlzRJRlAi5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.284
Date:   Tue, 30 May 2023 12:51:51 +0100
Message-Id: <2023053051-entity-commend-d844@gregkh>
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

I'm announcing the release of the 4.19.284 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/m68k/kernel/signal.c                                   |   14 
 arch/parisc/include/asm/cacheflush.h                        |    5 
 arch/parisc/kernel/cache.c                                  |    5 
 arch/parisc/kernel/process.c                                |   11 
 arch/x86/include/asm/intel-family.h                         |    5 
 arch/x86/kernel/dumpstack.c                                 |    7 
 arch/x86/mm/init.c                                          |   25 
 drivers/acpi/acpica/dbnames.c                               |    3 
 drivers/acpi/acpica/dswstate.c                              |   11 
 drivers/acpi/ec.c                                           |    1 
 drivers/base/platform.c                                     |   20 
 drivers/base/regmap/regcache.c                              |    6 
 drivers/char/tpm/tpm_tis.c                                  |   16 
 drivers/clk/tegra/clk-tegra20.c                             |   28 -
 drivers/firmware/arm_sdei.c                                 |   37 -
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c          |    5 
 drivers/gpu/drm/exynos/exynos_drm_g2d.h                     |    4 
 drivers/gpu/drm/tegra/sor.c                                 |    2 
 drivers/hid/hid-logitech-hidpp.c                            |   53 +
 drivers/hid/wacom.h                                         |    3 
 drivers/hid/wacom_sys.c                                     |    2 
 drivers/hid/wacom_wac.c                                     |   72 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c             |    2 
 drivers/input/joystick/xpad.c                               |    5 
 drivers/mcb/mcb-pci.c                                       |   27 -
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c          |    2 
 drivers/media/radio/radio-shark.c                           |   10 
 drivers/media/radio/radio-shark2.c                          |   10 
 drivers/memstick/host/r592.c                                |    2 
 drivers/message/fusion/mptlan.c                             |    2 
 drivers/mfd/dln2.c                                          |    1 
 drivers/net/ethernet/3com/3c589_cs.c                        |   11 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c              |    9 
 drivers/net/ethernet/freescale/fec_main.c                   |   13 
 drivers/net/ethernet/intel/igb/e1000_mac.c                  |    4 
 drivers/net/ethernet/nvidia/forcedeth.c                     |    1 
 drivers/net/ethernet/pasemi/pasemi_mac.c                    |    2 
 drivers/net/ethernet/sun/cassini.c                          |    2 
 drivers/net/ipvlan/ipvlan_core.c                            |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |   13 
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c                |    5 
 drivers/phy/st/phy-miphy28lp.c                              |   42 -
 drivers/power/supply/bq27xxx_battery.c                      |   41 -
 drivers/power/supply/bq27xxx_battery_i2c.c                  |    3 
 drivers/power/supply/power_supply_leds.c                    |    5 
 drivers/power/supply/sbs-charger.c                          |    2 
 drivers/s390/cio/qdio.h                                     |   25 
 drivers/s390/cio/qdio_main.c                                |   62 +-
 drivers/spi/spi-fsl-cpm.c                                   |   23 
 drivers/spi/spi-fsl-spi.c                                   |   65 +-
 drivers/spi/spi-imx.c                                       |   24 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                |    6 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h                |    5 
 drivers/tty/serial/8250/8250_core.c                         |    1 
 drivers/tty/serial/8250/8250_pci.c                          |    5 
 drivers/tty/serial/arc_uart.c                               |    7 
 drivers/tty/vt/vc_screen.c                                  |   57 +-
 drivers/usb/core/usb.c                                      |   76 ++
 drivers/usb/gadget/function/u_ether.c                       |   39 -
 drivers/usb/misc/sisusbvga/sisusb.c                         |   14 
 drivers/usb/storage/scsiglue.c                              |   28 -
 drivers/usb/typec/altmodes/displayport.c                    |    4 
 drivers/usb/typec/tcpm.c                                    |   16 
 drivers/xen/pvcalls-back.c                                  |    9 
 fs/btrfs/disk-io.c                                          |    9 
 fs/btrfs/free-space-cache.c                                 |    7 
 fs/btrfs/inode.c                                            |   12 
 fs/ceph/snap.c                                              |   13 
 fs/ext2/ext2.h                                              |    1 
 fs/ext2/super.c                                             |    7 
 fs/ext4/mballoc.c                                           |   65 +-
 fs/f2fs/checkpoint.c                                        |   12 
 fs/f2fs/data.c                                              |    3 
 fs/gfs2/glops.c                                             |    3 
 fs/hfsplus/inode.c                                          |   28 -
 fs/nilfs2/inode.c                                           |   18 
 fs/statfs.c                                                 |    4 
 include/linux/cpuhotplug.h                                  |    1 
 include/linux/platform_device.h                             |    3 
 include/linux/power/bq27xxx_battery.h                       |    1 
 include/linux/sched/task_stack.h                            |    2 
 include/linux/string_helpers.h                              |   15 
 include/linux/usb.h                                         |    5 
 include/net/ip6_tunnel.h                                    |    2 
 include/net/ip_tunnels.h                                    |    2 
 include/net/netfilter/nf_tables.h                           |   15 
 include/net/netfilter/nf_tables_core.h                      |    9 
 include/net/netfilter/nft_fib.h                             |    2 
 include/net/netfilter/nft_masq.h                            |    4 
 include/net/netfilter/nft_redir.h                           |    4 
 include/net/sock.h                                          |   22 
 include/net/tcp.h                                           |    9 
 include/uapi/sound/skl-tplg-interface.h                     |    3 
 kernel/bpf/verifier.c                                       |    2 
 lib/cpu_rmap.c                                              |    5 
 net/8021q/vlan_dev.c                                        |    4 
 net/bluetooth/l2cap_core.c                                  |    1 
 net/core/datagram.c                                         |   15 
 net/core/dev.c                                              |    2 
 net/core/skbuff.c                                           |    4 
 net/core/stream.c                                           |    2 
 net/ipv4/af_inet.c                                          |    2 
 net/ipv4/ip_gre.c                                           |    6 
 net/ipv4/netfilter/nft_dup_ipv4.c                           |   18 
 net/ipv4/tcp.c                                              |   27 -
 net/ipv4/tcp_input.c                                        |    4 
 net/ipv4/udplite.c                                          |    2 
 net/ipv6/exthdrs_core.c                                     |    2 
 net/ipv6/ip6_gre.c                                          |   36 -
 net/ipv6/netfilter/nft_dup_ipv6.c                           |   18 
 net/ipv6/udplite.c                                          |    2 
 net/key/af_key.c                                            |   12 
 net/netfilter/nf_tables_api.c                               |  228 +++++---
 net/netfilter/nft_bitwise.c                                 |   14 
 net/netfilter/nft_byteorder.c                               |   14 
 net/netfilter/nft_cmp.c                                     |    8 
 net/netfilter/nft_ct.c                                      |   12 
 net/netfilter/nft_dup_netdev.c                              |    6 
 net/netfilter/nft_dynset.c                                  |   12 
 net/netfilter/nft_exthdr.c                                  |   14 
 net/netfilter/nft_fib.c                                     |    5 
 net/netfilter/nft_fwd_netdev.c                              |   18 
 net/netfilter/nft_hash.c                                    |   25 
 net/netfilter/nft_immediate.c                               |    6 
 net/netfilter/nft_lookup.c                                  |   14 
 net/netfilter/nft_masq.c                                    |   14 
 net/netfilter/nft_meta.c                                    |   12 
 net/netfilter/nft_nat.c                                     |   35 -
 net/netfilter/nft_numgen.c                                  |   15 
 net/netfilter/nft_objref.c                                  |    6 
 net/netfilter/nft_osf.c                                     |    8 
 net/netfilter/nft_payload.c                                 |   10 
 net/netfilter/nft_queue.c                                   |   12 
 net/netfilter/nft_range.c                                   |    6 
 net/netfilter/nft_redir.c                                   |   14 
 net/netfilter/nft_rt.c                                      |    7 
 net/netfilter/nft_socket.c                                  |    7 
 net/netfilter/nft_tproxy.c                                  |   14 
 net/netfilter/nft_tunnel.c                                  |    8 
 net/netlink/af_netlink.c                                    |    8 
 net/nsh/nsh.c                                               |    8 
 net/socket.c                                                |    2 
 net/unix/af_unix.c                                          |   22 
 net/vmw_vsock/af_vsock.c                                    |    2 
 scripts/recordmcount.c                                      |    6 
 sound/pci/hda/hda_generic.c                                 |    7 
 sound/pci/hda/patch_ca0132.c                                |    1 
 sound/pci/hda/patch_hdmi.c                                  |    5 
 sound/pci/hda/patch_realtek.c                               |  324 +++++++++---
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c     |   31 -
 tools/testing/selftests/memfd/fuse_test.c                   |    1 
 152 files changed, 1633 insertions(+), 796 deletions(-)

Adam Stylinski (1):
      ALSA: hda/ca0132: add quirk for EVGA X299 DARK

Ai Chao (1):
      ALSA: hda/realtek: Add a quirk for HP EliteDesk 805

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

Arnd Bergmann (2):
      clk: tegra20: fix gcc-7 constant overflow warning
      drm/exynos: fix g2d_open/close helper function definitions

Badhri Jagan Sridharan (1):
      usb: typec: altmodes/displayport: fix pin_assignment_show

Bartosz Golaszewski (2):
      drivers: provide devm_platform_ioremap_resource()
      drivers: depend on HAS_IOMEM for devm_platform_ioremap_resource()

Bastien Nocera (2):
      HID: logitech-hidpp: Don't use the USB serial for USB devices
      HID: logitech-hidpp: Reconcile USB and Unifying serials

Cezary Rojewski (1):
      ASoC: Intel: Skylake: Fix declaration of enum skl_ch_cfg

Chao Yu (1):
      f2fs: fix to drop all dirty pages during umount() if cp_error is set

Christophe JAILLET (3):
      cassini: Fix a memory leak in the error handling path of cas_init_one()
      forcedeth: Fix an error handling path in nv_probe()
      3c589_cs: Fix an error handling path in tc589_probe()

Christophe Leroy (2):
      spi: fsl-spi: Re-organise transfer bits_per_word adaptation
      spi: fsl-cpm: Use 16 bit mode for large transfers with even size

Daisuke Nojiri (1):
      power: supply: sbs-charger: Fix INHIBITED bit for Status reg

Dan Carpenter (2):
      coresight: Fix signedness bug in tmc_etr_buf_insert_barrier_packet()
      xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()

Dave Hansen (1):
      x86/mm: Avoid incomplete Global INVLPG flushes

Dong Chenchen (1):
      net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment()

Duoming Zhou (1):
      media: netup_unidvb: fix use-after-free at del_timer()

Eli Cohen (1):
      lib: cpu_rmap: Avoid use after free on rmap->obj array entries

Eric Dumazet (6):
      netlink: annotate accesses to nlk->cb_running
      net: annotate sk->sk_err write from do_recvmmsg()
      tcp: reduce POLLOUT events caused by TCP_NOTSENT_LOWAT
      tcp: add annotations around sk->sk_shutdown accesses
      net: datagram: fix data-races in datagram_poll()
      vlan: fix a potential uninit-value in vlan_dev_hard_start_xmit()

Filipe Manana (1):
      btrfs: fix space cache inconsistency after error loading it from disk

Finn Thain (1):
      m68k: Move signal frame following exception on 68020/030

Florian Fainelli (2):
      net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()
      net: bcmgenet: Restore phy_stop() depending upon suspend/close

Frank Wang (1):
      usb: typec: tcpm: fix multiple times discover svids error

Gavrilov Ilia (1):
      ipv6: Fix out-of-bounds access in ipv6_find_tlv()

George Kennedy (1):
      vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF

Greg Kroah-Hartman (1):
      Linux 4.19.284

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

Heiko Carstens (2):
      s390/qdio: get rid of register asm
      s390/qdio: fix do_sqbs() inline assembly constraint

Helge Deller (2):
      parisc: Allow to reboot machine after system halt
      parisc: Fix flush_dcache_page() for usage from irq context

Hui Wang (1):
      ALSA: hda/realtek: Fix the mic type detection issue for ASUS G551JW

Ilya Leoshkevich (1):
      statfs: enforce statfs[64] structure initialization

Jan Kara (1):
      ext2: Check block size validity during mount

Jason Gerecke (2):
      HID: wacom: generic: Set battery quirk only when we see battery data
      HID: wacom: Force pen out of prox if no events have been received in a while

Jeremy Szu (1):
      ALSA: hda/realtek - The front Mic on a HP machine doesn't work

Jerry Snitselaar (1):
      tpm/tpm_tis: Disable interrupts for more Lenovo devices

Jian-Hong Pan (2):
      ALSA: hda/realtek - Enable headset mic of Acer X2660G with ALC662
      ALSA: hda/realtek - Enable the headset of Acer N50-600 with ALC662

Jiri Slaby (1):
      vc_screen: rewrite vcs_size to accept vc, not inode

Jon Hunter (1):
      usb: gadget: u_ether: Convert prints to device prints

Josef Bacik (1):
      btrfs: use nofs when cleaning up aborted transactions

Josh Poimboeuf (1):
      sched: Fix KCSAN noinstr violation

Kailang Yang (4):
      ALSA: hda/realtek - Add Headset Mic supported for HP cPC
      ALSA: hda/realtek - Add headset Mic support for Lenovo ALC897 platform
      ALSA: hda/realtek - ALC897 headset MIC no sound
      ALSA: hda/realtek - Fixed one of HP ALC671 platform Headset Mic supported

Ke Zhang (1):
      serial: arc_uart: fix of_iomap leak in `arc_serial_probe`

Kemeng Shi (1):
      ext4: set goal start correctly in ext4_mb_normalize_request

Kevin Groeneveld (1):
      spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3

Konrad Gräfe (1):
      usb: gadget: u_ether: Fix host MAC address case

Kuniyuki Iwashima (4):
      net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().
      af_unix: Fix a data race of sk->sk_receive_queue->qlen.
      af_unix: Fix data races around sk->sk_shutdown.
      udplite: Fix NULL pointer dereference in __sk_mem_raise_allocated().

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

Nikolay Borisov (1):
      btrfs: replace calls to btrfs_find_free_ino with btrfs_find_free_objectid

Nur Hussein (1):
      drm/tegra: Avoid potential 32-bit integer overflow

Ojaswin Mujoo (1):
      ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()

Pablo Neira Ayuso (9):
      netfilter: nftables: add nft_parse_register_load() and use it
      netfilter: nftables: add nft_parse_register_store() and use it
      netfilter: nftables: statify nft_parse_register()
      netfilter: nf_tables: validate registers coming from userspace.
      netfilter: nf_tables: add nft_setelem_parse_key()
      netfilter: nf_tables: allow up to 64 bytes in the set element data area
      netfilter: nf_tables: stricter validation of element data
      netfilter: nf_tables: validate NFTA_SET_ELEM_OBJREF based on NFT_SET_OBJECT flag
      netfilter: nf_tables: do not allow RULE_ID to refer to another chain

Paolo Abeni (1):
      tcp: factor out __tcp_close() helper

Peilin Ye (3):
      ip6_gre: Fix skb_under_panic in __gre6_xmit()
      ip6_gre: Make o_seqno start from 0 in native mode
      ip_gre, ip6_gre: Fix race condition on o_seqno in collect_md mode

Philipp Hortmann (1):
      staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE

Pierre Gondois (1):
      firmware: arm_sdei: Fix sleep from invalid context BUG

Pratyush Yadav (1):
      net: fix skb leak in __skb_tstamp_tx()

Qiang Ning (1):
      mfd: dln2: Fix memory leak in dln2_probe()

Rasmus Villemoes (1):
      spi: spi-fsl-spi: automatically adapt bits-per-word in cpu mode

Rodrigo Siqueira (1):
      drm/amd/display: Use DC_LOG_DC in the trasform pixel function

Rodríguez Barbarin, José Javier (1):
      mcb-pci: Reallocate memory region to avoid memory overlapping

Ryusuke Konishi (1):
      nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()

Sergey Bostandzhyan (1):
      Add Acer Aspire Ethos 8951G model quirk

Soheil Hassas Yeganeh (1):
      tcp: return EPOLLOUT from tcp_poll only when notsent_bytes is half the limit

Takashi Iwai (3):
      ALSA: hda: Fix Oops by 9.1 surround channel names
      ALSA: hda/realtek - More constifications
      ALSA: hda/realtek - Fix inverted bass GPIO pin on Acer 8951G

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

Vadim Pasternak (1):
      lib/string_helpers: Introduce string_upper() and string_lower() helpers

Vernon Lovejoy (1):
      x86/show_trace_log_lvl: Ensure stack pointer is aligned, again

Vicki Pfau (1):
      Input: xpad - add constants for GIP interface numbers

Vitaliy Tomin (1):
      serial: Add support for Advantech PCI-1611U card

Will Deacon (1):
      bpf: Fix mask generation for 32-bit narrow loads of 64-bit fields

Wyes Karny (1):
      cpupower: Make TSC read per CPU for Mperf monitor

Xin Long (1):
      erspan: get the proto with the md version for collect_md

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

