Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28489722021
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjFEHwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjFEHwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FD3E6E;
        Mon,  5 Jun 2023 00:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6666262100;
        Mon,  5 Jun 2023 07:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B54C4339B;
        Mon,  5 Jun 2023 07:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685951528;
        bh=IE6CCuYCdu/16PvfP1EOtR3niTVnG/CNy9InWdTk4D0=;
        h=From:To:Cc:Subject:Date:From;
        b=VMpPJlBensLJno239C1jVC14eXsvKiXfcYQQNvrKDza1kjQ/reoDI3Iv66az+yC8N
         JZ/ZByI+/VGOSnhzl9gWujkCGzTgx3o8mev8+cfBbOCZTcKxTFHCjgWbFn7j2CCCu7
         NkGMz/evbIXWIxUWg0xIxyEYTMLwA86VdaZSc8Zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.115
Date:   Mon,  5 Jun 2023 09:52:00 +0200
Message-ID: <2023060557-operator-dwindling-0719@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

I'm announcing the release of the 5.15.115 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/networking/bonding.rst                        |   11 
 Makefile                                                    |    2 
 drivers/android/binder.c                                    |   26 +
 drivers/android/binder_alloc.c                              |   64 +---
 drivers/android/binder_alloc.h                              |    2 
 drivers/android/binder_alloc_selftest.c                     |    2 
 drivers/irqchip/irq-mips-gic.c                              |   65 ++--
 drivers/net/bonding/bond_main.c                             |   17 -
 drivers/net/bonding/bond_netlink.c                          |   22 +
 drivers/net/bonding/bond_options.c                          |   36 ++
 drivers/net/bonding/bond_procfs.c                           |    2 
 drivers/net/bonding/bond_sysfs.c                            |   13 
 drivers/net/dsa/mt7530.c                                    |  124 +++++---
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c             |   19 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c             |   19 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c        |   81 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h        |    3 
 drivers/net/phy/mscc/mscc.h                                 |    1 
 drivers/net/phy/mscc/mscc_main.c                            |   54 +--
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c |   49 ++-
 drivers/power/supply/bq24190_charger.c                      |   13 
 drivers/power/supply/bq27xxx_battery.c                      |  171 ++++++------
 drivers/power/supply/power_supply_core.c                    |   57 ++--
 include/linux/power/bq27xxx_battery.h                       |    3 
 include/linux/power_supply.h                                |    5 
 include/net/bond_options.h                                  |    1 
 include/net/bonding.h                                       |    3 
 include/net/dsa.h                                           |   28 +
 include/net/ip.h                                            |    2 
 include/net/page_pool.h                                     |   18 -
 include/net/xdp.h                                           |    3 
 include/uapi/linux/if_link.h                                |    1 
 include/uapi/linux/in.h                                     |    2 
 kernel/bpf/hashtab.c                                        |    6 
 net/bluetooth/hci_sock.c                                    |   28 +
 net/core/page_pool.c                                        |   34 ++
 net/core/xdp.c                                              |   93 ++++--
 net/ipv4/ip_sockglue.c                                      |   12 
 net/ipv4/raw.c                                              |    5 
 net/ipv6/raw.c                                              |    3 
 net/netfilter/nf_conntrack_netlink.c                        |    8 
 tools/include/uapi/linux/if_link.h                          |    1 
 44 files changed, 725 insertions(+), 388 deletions(-)

Anton Protopopov (1):
      bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps

Arınç ÜNAL (1):
      net: dsa: mt7530: fix network connectivity with multiple CPU ports

Carlos Llamas (5):
      binder: fix UAF caused by faulty buffer cleanup
      Revert "binder_alloc: add missing mmap_lock calls when using the VMA"
      Revert "android: binder: stop saving a pointer to the VMA"
      binder: add lockless binder_alloc_(set|get)_vma()
      binder: fix UAF of alloc->vma in race with munmap()

Daniel Golle (1):
      net: dsa: mt7530: split-off common parts from mt7531_setup

David Epping (1):
      net: phy: mscc: enable VSC8501/2 RGMII RX clock

Frank Wunderlich (1):
      net: dsa: mt7530: rework mt753[01]_setup

Greg Kroah-Hartman (1):
      Linux 5.15.115

Hangbin Liu (2):
      Bonding: add arp_missed_max option
      bonding: fix send_peer_notif overflow

Hans de Goede (5):
      power: supply: bq27xxx: Move bq27xxx_battery_update() down
      power: supply: bq27xxx: Ensure power_supply_changed() is called on current sign changes
      power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize
      power: supply: core: Refactor power_supply_set_input_current_limit_from_supplier()
      power: supply: bq24190: Call power_supply_changed() after updating input current

Jiaxun Yang (2):
      irqchip/mips-gic: Use raw spinlock for gic_lock
      irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routable

Marc Zyngier (1):
      irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()

Mark Bloch (1):
      net/mlx5: devcom only supports 2 ports

Nicolas Dichtel (1):
      ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Paul Blakey (1):
      netfilter: ctnetlink: Support offloaded conntrack entry deletion

Qingfang DENG (1):
      net: page_pool: use in_softirq() instead

Rahul Rameshbabu (1):
      net/mlx5e: Fix SQ wake logic in ptp napi_poll context

Ruihan Li (1):
      bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Sebastian Andrzej Siewior (1):
      xdp: xdp_mem_allocator can be NULL in trace_mem_connect().

Shay Drory (1):
      net/mlx5: Devcom, serialize devcom registration

Sicelo A. Mhlongo (1):
      power: supply: bq27xxx: expose battery data when CI=1

Srinivas Pandruvada (1):
      platform/x86: ISST: PUNIT device mapping with Sub-NUMA clustering

Steve Wahl (1):
      platform/x86: ISST: Remove 8 socket limit

Toke Høiland-Jørgensen (1):
      xdp: Allow registering memory model without rxq reference

Vlad Buslov (1):
      net/mlx5e: Fix deadlock in tc route query code

Vladimir Oltean (1):
      net: dsa: introduce helpers for iterating through ports using dp

Yunsheng Lin (1):
      page_pool: fix inconsistency for page_pool_ring_[un]lock()

