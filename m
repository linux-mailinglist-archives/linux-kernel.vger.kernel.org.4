Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E304706750
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjEQL7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjEQL7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:59:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986BF3586;
        Wed, 17 May 2023 04:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F7FB61309;
        Wed, 17 May 2023 11:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33538C433D2;
        Wed, 17 May 2023 11:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324783;
        bh=0ONZTZ0bcX9O/YkkpR1ylf7q30ePiv2FvvoUWYiTMr0=;
        h=From:To:Cc:Subject:Date:From;
        b=O9cOMP5xxzGG10IGfoR5yZM5zgIMuxv+mXpKl6bWK5S30duEGqsGtzOsrQIstv3Uc
         p8ByAMVB5TyepNHqXW7lkEMLhz7+psDdKdejsVqbbGl9A+wb1xlPUd3s2GBFd41lrq
         EOkdY2qYCLjFfJS2Y2E2esCXyusNaWEgjjtSfYRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.315
Date:   Wed, 17 May 2023 13:59:39 +0200
Message-Id: <2023051739-machinist-secluding-0747@gregkh>
X-Mailer: git-send-email 2.40.1
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

I'm announcing the release of the 4.14.315 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/arm/boot/dts/exynos4412-itop-elite.dts                 |    2 
 arch/arm/boot/dts/s5pv210.dtsi                              |    2 
 arch/arm64/include/asm/debug-monitors.h                     |    1 
 arch/arm64/kernel/debug-monitors.c                          |    5 
 arch/arm64/kernel/kgdb.c                                    |    2 
 arch/ia64/mm/contig.c                                       |    2 
 arch/mips/fw/lib/cmdline.c                                  |    2 
 arch/parisc/kernel/real2.S                                  |    5 
 arch/powerpc/kernel/rtas.c                                  |    2 
 arch/powerpc/platforms/512x/clock-commonclk.c               |    2 
 arch/powerpc/platforms/embedded6xx/flipper-pic.c            |    2 
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c               |    2 
 arch/powerpc/platforms/embedded6xx/wii.c                    |    4 
 arch/powerpc/sysdev/tsi108_pci.c                            |    5 
 arch/sh/kernel/cpu/sh4/sq.c                                 |    2 
 arch/sh/kernel/nmi_debug.c                                  |    4 
 arch/sh/math-emu/sfp-util.h                                 |    4 
 arch/x86/kernel/apic/apic.c                                 |    5 
 arch/x86/kernel/apic/io_apic.c                              |   14 -
 drivers/block/drbd/drbd_receiver.c                          |    2 
 drivers/bluetooth/btsdio.c                                  |    1 
 drivers/clk/clk-conf.c                                      |   12 -
 drivers/clk/rockchip/clk-rk3399.c                           |    2 
 drivers/dma/at_xdmac.c                                      |    5 
 drivers/gpu/drm/drm_probe_helper.c                          |    5 
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                 |    3 
 drivers/gpu/drm/vgem/vgem_fence.c                           |    1 
 drivers/hid/wacom_wac.c                                     |   12 -
 drivers/i2c/busses/i2c-omap.c                               |    2 
 drivers/iio/adc/palmas_gpadc.c                              |    2 
 drivers/infiniband/hw/hfi1/mmu_rb.c                         |   13 -
 drivers/infiniband/sw/rdmavt/qp.c                           |    2 
 drivers/macintosh/Kconfig                                   |    1 
 drivers/macintosh/windfarm_smu_sat.c                        |    1 
 drivers/md/dm-flakey.c                                      |    4 
 drivers/md/dm-integrity.c                                   |    8 
 drivers/md/dm-ioctl.c                                       |    7 
 drivers/md/raid10.c                                         |   23 +
 drivers/media/pci/dm1105/dm1105.c                           |    1 
 drivers/media/pci/ttpci/av7110_av.c                         |    4 
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c               |    2 
 drivers/mtd/ubi/eba.c                                       |   19 +
 drivers/net/ethernet/amd/nmclan_cs.c                        |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c            |   23 +
 drivers/net/wireless/ath/ath5k/eeprom.c                     |    2 
 drivers/net/wireless/ath/ath6kl/bmi.c                       |    2 
 drivers/net/wireless/ath/ath6kl/htc_pipe.c                  |    4 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c            |   10 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c             |    3 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c      |    1 
 drivers/of/device.c                                         |    7 
 drivers/phy/tegra/xusb.c                                    |    2 
 drivers/power/supply/generic-adc-battery.c                  |    3 
 drivers/s390/block/dasd.c                                   |    2 
 drivers/scsi/megaraid.c                                     |    1 
 drivers/spi/spi-fsl-spi.c                                   |   12 -
 drivers/spmi/spmi.c                                         |    3 
 drivers/staging/iio/resolver/ad2s1210.c                     |    2 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                |    1 
 drivers/target/iscsi/iscsi_target.c                         |   16 -
 drivers/tty/serial/8250/8250.h                              |   12 +
 drivers/tty/serial/8250/8250_port.c                         |   16 +
 drivers/tty/serial/fsl_lpuart.c                             |    2 
 drivers/tty/tty_io.c                                        |    4 
 drivers/tty/tty_ioctl.c                                     |   45 ++-
 drivers/usb/chipidea/core.c                                 |    2 
 drivers/usb/dwc3/core.c                                     |    1 
 drivers/usb/serial/option.c                                 |    6 
 fs/btrfs/ctree.c                                            |   32 ++
 fs/btrfs/ioctl.c                                            |    5 
 fs/btrfs/print-tree.c                                       |    6 
 fs/cifs/smb2ops.c                                           |    2 
 fs/ext4/inline.c                                            |   14 +
 fs/ext4/mballoc.c                                           |    6 
 fs/ext4/super.c                                             |   19 +
 fs/ext4/xattr.c                                             |    5 
 fs/fs-writeback.c                                           |    2 
 fs/nfs/nfs4state.c                                          |    4 
 fs/nilfs2/bmap.c                                            |   16 +
 fs/nilfs2/segment.c                                         |    5 
 fs/pstore/pmsg.c                                            |    7 
 fs/reiserfs/xattr_security.c                                |    8 
 fs/ubifs/dir.c                                              |    1 
 fs/ubifs/tnc.c                                              |    9 
 include/linux/printk.h                                      |   19 +
 include/linux/sunrpc/sched.h                                |    3 
 include/linux/tty.h                                         |    2 
 include/linux/vt_buffer.h                                   |    2 
 include/net/netfilter/nf_tables.h                           |   30 ++
 include/net/scm.h                                           |   13 +
 include/uapi/linux/btrfs.h                                  |    1 
 include/uapi/linux/const.h                                  |    2 
 kernel/events/core.c                                        |    4 
 kernel/trace/ring_buffer.c                                  |    4 
 mm/page_alloc.c                                             |   16 +
 net/8021q/vlan_dev.c                                        |    2 
 net/bluetooth/hci_sock.c                                    |    9 
 net/core/skbuff.c                                           |    3 
 net/ipv4/ip_output.c                                        |   16 +
 net/ipv6/sit.c                                              |    8 
 net/netfilter/nf_tables_api.c                               |  139 ++++++++----
 net/netfilter/nft_dynset.c                                  |   22 +
 net/netfilter/nft_immediate.c                               |    6 
 net/netfilter/nft_lookup.c                                  |   21 +
 net/netfilter/nft_objref.c                                  |   21 +
 net/netfilter/nft_set_hash.c                                |    2 
 net/packet/af_packet.c                                      |   20 -
 net/packet/diag.c                                           |    4 
 net/packet/internal.h                                       |   26 +-
 net/sched/act_mirred.c                                      |    2 
 net/sunrpc/clnt.c                                           |    3 
 net/sunrpc/sched.c                                          |    1 
 security/selinux/Makefile                                   |    4 
 sound/usb/caiaq/input.c                                     |    1 
 tools/perf/bench/bench.h                                    |    4 
 tools/perf/bench/futex-hash.c                               |   12 -
 tools/perf/bench/futex-lock-pi.c                            |   11 
 tools/perf/builtin-sched.c                                  |    2 
 tools/perf/pmu-events/arch/powerpc/power9/other.json        |    4 
 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json     |    2 
 tools/perf/util/auxtrace.c                                  |    5 
 tools/perf/util/sort.c                                      |    3 
 tools/perf/util/symbol-elf.c                                |    2 
 125 files changed, 705 insertions(+), 277 deletions(-)

Adrian Hunter (1):
      perf auxtrace: Fix address filter entire kernel size

Alexander Mikhalitsyn (1):
      scm: fix MSG_CTRUNC setting condition for SO_PASSSEC

Alexey V. Vissarionov (1):
      wifi: ath6kl: minor fix for allocation size

Anastasia Belova (1):
      btrfs: print-tree: parent bytenr must be aligned to sector size

Arnaldo Carvalho de Melo (2):
      perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into sysconf(__SC_THREAD_STACK_MIN_VALUE)
      perf bench: Share some global variables to fix build with gcc 10

Arınç ÜNAL (1):
      USB: serial: option: add UNISOC vendor and TOZED LT70C product

Bitterblue Smith (1):
      wifi: rtl8xxxu: RTL8192EU always needs full init

Christoph Böhmwalder (1):
      drbd: correctly submit flush bio on barrier

Christophe Leroy (1):
      spi: fsl-spi: Fix CPM/QE mode Litte Endian

Claudiu Beznea (1):
      dmaengine: at_xdmac: do not enable all cyclic channels

Clément Léger (1):
      clk: add missing of_node_put() in "assigned-clocks" property parsing

Cong Wang (1):
      sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()

Dai Ngo (1):
      SUNRPC: remove the maximum number of retries in call_bind_status

Dan Carpenter (2):
      media: av7110: prevent underflow in write_ts_to_decoder()
      wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()

Danila Chernetsov (1):
      scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS

Dom Cobley (1):
      drm/probe-helper: Cancel previous job before starting new one

Emmanuel Grumbach (1):
      wifi: iwlwifi: make the loop for card preparation effective

Eric Dumazet (2):
      net/packet: convert po->origdev to an atomic flag
      net/packet: convert po->auxdata to an atomic flag

Fedor Pchelkin (1):
      wifi: ath6kl: reduce WARN to dev_dbg() in callback

Filipe Manana (1):
      btrfs: fix btrfs_prev_leaf() to not return the same key twice

Florian Fainelli (1):
      serial: 8250: Add missing wakeup event reporting

Florian Westphal (1):
      netfilter: nf_tables: split set destruction in deactivate and destroy phase

Gaosheng Cui (1):
      phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port

Gencen Gan (1):
      net: amd: Fix link leak when verifying config failed

Greg Kroah-Hartman (1):
      Linux 4.14.315

Helge Deller (1):
      parisc: Fix argument pointer in real64_call_asm()

Ilpo Järvinen (2):
      tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH
      serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

Jiasheng Jiang (1):
      media: bdisp: Add missing check for create_workqueue

Jiaxun Yang (1):
      MIPS: fw: Allow firmware to pass a empty env

Jishnu Prakash (1):
      spmi: Add a check for remove callback when removing a SPMI driver

Jisoo Jang (1):
      wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

Joe Damato (2):
      ixgbe: Allow flow hash to be set via ethtool
      ixgbe: Enable setting RSS table to default values

Johan Hovold (1):
      USB: dwc3: fix runtime pm imbalance on unbind

Johannes Berg (2):
      ring-buffer: Sync IRQ works before buffer destruction
      wifi: iwlwifi: mvm: check firmware response size

John Paul Adrian Glaubitz (1):
      sh: sq: Fix incorrect element size for allocating bitmap buffer

John Stultz (1):
      pstore: Revert pmsg_lock back to a normal mutex

Kajol Jain (1):
      perf vendor events power9: Remove UTF-8 characters from JSON files

Kevin Brodsky (1):
      uapi/linux/const.h: prefer ISO-friendly __typeof__

Krzysztof Kozlowski (2):
      ARM: dts: exynos: fix WM8960 clock name in Itop Elite
      ARM: dts: s5pv210: correct MIPI CSIS clock name

Kuniyuki Iwashima (2):
      tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.
      af_packet: Don't send zero-byte data in packet_sendmsg_spkt().

Liang He (1):
      macintosh/windfarm_smu_sat: Add missing of_node_put()

Liu Jian (1):
      Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work"

Markus Elfring (1):
      perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Maxim Korotkov (1):
      writeback: fix call of incorrect macro

Maíra Canal (1):
      drm/vgem: add missing mutex_destroy

Mike Christie (1):
      scsi: target: iscsit: Fix TAS handling during conn cleanup

Mike Snitzer (2):
      dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path
      dm ioctl: fix nested locking in table_clear() to remove deadlock concern

Mikulas Patocka (1):
      dm flakey: fix a crash with invalid table line

Miquel Raynal (1):
      of: Fix modalias string generation

Mårten Lindahl (1):
      ubifs: Free memory for tmpfile name

Natalia Petrova (1):
      RDMA/rdmavt: Delete unnecessary NULL check

Nathan Lynch (1):
      powerpc/rtas: use memmove for potentially overlapping buffer copy

Nuno Sá (1):
      staging: iio: resolver: ads1210: fix config mode

Ondrej Mosnacek (1):
      selinux: fix Makefile dependencies of flask.h

Pablo Neira Ayuso (5):
      netfilter: nf_tables: unbind set in rule from commit path
      netfilter: nft_hash: fix nft_hash_deactivate
      netfilter: nf_tables: use-after-free in failing rule with bound set
      netfilter: nf_tables: bogus EBUSY when deleting set after flush
      netfilter: nf_tables: deactivate anonymous set from preparation phase

Patrick Kelsey (1):
      IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order

Patrik Dahlström (1):
      iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Paul Moore (1):
      selinux: ensure av_permissions.h is built when needed

Pawel Witek (1):
      cifs: fix pcchunk length type in smb2_copychunk_range

Philipp Hortmann (1):
      staging: rtl8192e: Fix W_DISABLE# does not work after stop/start

Ping Cheng (1):
      HID: wacom: Set a default resolution for older tablets

Qu Wenruo (1):
      btrfs: scrub: reject unsupported scrub flags

Quentin Schulz (1):
      clk: rockchip: rk3399: allow clk_cifout to force clk_cifout_src to reparent

Randy Dunlap (8):
      linux/vt_buffer.h: allow either builtin or modular for macros
      ia64: mm/contig: fix section mismatch warning/error
      powerpc/mpc512x: fix resource printk format warning
      powerpc/wii: fix resource printk format warnings
      powerpc/sysdev/tsi108: fix resource printk format warnings
      macintosh: via-pmu-led: requires ATA to be set
      sh: math-emu: fix macro redefined warning
      sh: nmi_debug: fix return value of __setup handler

Reid Tonking (1):
      i2c: omap: Fix standard mode false ACK readings

Rob Clark (1):
      drm/rockchip: Drop unbalanced obj unref

Roberto Sassu (1):
      reiserfs: Add security prefix to xattr name in reiserfs_security_write()

Ruihan Li (1):
      bluetooth: Perform careful capability checks in hci_sock_ioctl()

Ruliang Lin (1):
      ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`

Ryusuke Konishi (2):
      nilfs2: do not write dirty data after degenerating to read-only
      nilfs2: fix infinite loop in nilfs_mdt_get_block()

Saurabh Sengar (1):
      x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

Sebastian Reichel (1):
      power: supply: generic-adc-battery: fix unit scaling

Shenwei Wang (1):
      tty: serial: fsl_lpuart: adjust buffer length to the intended size

Stefan Haberland (1):
      s390/dasd: fix hanging blockdevice after request requeue

Sumit Garg (1):
      arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

Tetsuo Handa (2):
      printk: declare printk_deferred_{enter,safe}() in include/linux/printk.h
      mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock

Theodore Ts'o (5):
      ext4: improve error recovery code paths in __ext4_remount()
      ext4: add bounds checking in get_max_inline_xattr_value_size()
      ext4: bail out of ext4_xattr_ibody_get() fails for any reason
      ext4: remove a BUG_ON in ext4_mb_release_group_pa()
      ext4: fix invalid free tracking in ext4_xattr_move_to_block()

Trond Myklebust (1):
      NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease

Tudor Ambarus (1):
      ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Uros Bizjak (1):
      x86/apic: Fix atomic update of offset in reserve_eilvt_offset()

Vadim Fedorenko (1):
      vlan: partially enable SIOCSHWTSTAMP in container

Victor Nogueira (1):
      net/sched: act_mirred: Add carrier check

Wang YanQing (1):
      ubi: Fix return value overwrite issue in try_write_vid_and_data()

Yang Jihong (2):
      perf/core: Fix hardlockup failure caused by perf throttle
      perf symbols: Fix return incorrect build_id size in elf_read_build_id()

Yinhao Hu (1):
      usb: chipidea: fix missing goto in `ci_hdrc_probe`

Yu Kuai (1):
      md/raid10: fix leak of 'r10bio->remaining' for recovery

Zheng Wang (1):
      media: dm1105: Fix use after free bug in dm1105_remove due to race condition

Zhihao Cheng (1):
      Revert "ubifs: dirty_cow_znode: Fix memleak in error handling path"

Ziyang Xuan (1):
      ipv4: Fix potential uninit variable access bug in __ip_make_skb()

