Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2558A72109C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjFCOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFCOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60979CE;
        Sat,  3 Jun 2023 07:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8B3060F9C;
        Sat,  3 Jun 2023 14:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D720EC433D2;
        Sat,  3 Jun 2023 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685803935;
        bh=JCjTcm63FamFuQRUalVRDuxrZE0ntO/Hy0kgWETTGXk=;
        h=From:To:Cc:Subject:Date:From;
        b=ntzEd2NyRisJ9EHqJ5IzHi/wae0QQDeq9+IjOmyw/gR4JuodhFunG0+sJjOW7Xioy
         qn28nHHO1RKCAdLlsrueUAMOsJZH8qdXslo1hbhST24sVMCmTZQauxMGYjuxm3InMp
         UPQjGzd8mYT6z+ZF1/9NnrN8P7V/owqhIP3WZRl0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.15 00/35] 5.15.115-rc3 review
Date:   Sat,  3 Jun 2023 16:37:18 +0200
Message-ID: <20230603143543.855276091@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.115-rc3.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.115-rc3
X-KernelTest-Deadline: 2023-06-05T14:35+00:00
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

This is the start of the stable review cycle for the 5.15.115 release.
There are 35 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 05 Jun 2023 14:35:25 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.115-rc3.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.115-rc3

Paul Blakey <paulb@nvidia.com>
    netfilter: ctnetlink: Support offloaded conntrack entry deletion

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Carlos Llamas <cmllamas@google.com>
    binder: fix UAF of alloc->vma in race with munmap()

Carlos Llamas <cmllamas@google.com>
    binder: add lockless binder_alloc_(set|get)_vma()

Carlos Llamas <cmllamas@google.com>
    Revert "android: binder: stop saving a pointer to the VMA"

Carlos Llamas <cmllamas@google.com>
    Revert "binder_alloc: add missing mmap_lock calls when using the VMA"

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    xdp: xdp_mem_allocator can be NULL in trace_mem_connect().

Jiaxun Yang <jiaxun.yang@flygoat.com>
    irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routable

Yunsheng Lin <linyunsheng@huawei.com>
    page_pool: fix inconsistency for page_pool_ring_[un]lock()

Qingfang DENG <qingfang.deng@siflower.com.cn>
    net: page_pool: use in_softirq() instead

Toke Høiland-Jørgensen <toke@redhat.com>
    xdp: Allow registering memory model without rxq reference

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Fix SQ wake logic in ptp napi_poll context

Jiaxun Yang <jiaxun.yang@flygoat.com>
    irqchip/mips-gic: Use raw spinlock for gic_lock

Marc Zyngier <maz@kernel.org>
    irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()

Carlos Llamas <cmllamas@google.com>
    binder: fix UAF caused by faulty buffer cleanup

Hangbin Liu <liuhangbin@gmail.com>
    bonding: fix send_peer_notif overflow

Hangbin Liu <liuhangbin@gmail.com>
    Bonding: add arp_missed_max option

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix network connectivity with multiple CPU ports

Daniel Golle <daniel@makrotopia.org>
    net: dsa: mt7530: split-off common parts from mt7531_setup

Frank Wunderlich <frank-w@public-files.de>
    net: dsa: mt7530: rework mt753[01]_setup

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: introduce helpers for iterating through ports using dp

David Epping <david.epping@missinglinkelectronics.com>
    net: phy: mscc: enable VSC8501/2 RGMII RX clock

Steve Wahl <steve.wahl@hpe.com>
    platform/x86: ISST: Remove 8 socket limit

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    platform/x86: ISST: PUNIT device mapping with Sub-NUMA clustering

Shay Drory <shayd@nvidia.com>
    net/mlx5: Devcom, serialize devcom registration

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5e: Fix deadlock in tc route query code

Mark Bloch <mbloch@nvidia.com>
    net/mlx5: devcom only supports 2 ports

Anton Protopopov <aspsk@isovalent.com>
    bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq24190: Call power_supply_changed() after updating input current

Hans de Goede <hdegoede@redhat.com>
    power: supply: core: Refactor power_supply_set_input_current_limit_from_supplier()

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Ensure power_supply_changed() is called on current sign changes

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Move bq27xxx_battery_update() down

Sicelo A. Mhlongo <absicsz@gmail.com>
    power: supply: bq27xxx: expose battery data when CI=1


-------------

Diffstat:

 Documentation/networking/bonding.rst               |  11 ++
 Makefile                                           |   4 +-
 drivers/android/binder.c                           |  26 +++-
 drivers/android/binder_alloc.c                     |  64 +++-----
 drivers/android/binder_alloc.h                     |   2 +-
 drivers/android/binder_alloc_selftest.c            |   2 +-
 drivers/irqchip/irq-mips-gic.c                     |  65 +++++---
 drivers/net/bonding/bond_main.c                    |  17 +-
 drivers/net/bonding/bond_netlink.c                 |  22 ++-
 drivers/net/bonding/bond_options.c                 |  36 ++++-
 drivers/net/bonding/bond_procfs.c                  |   2 +
 drivers/net/bonding/bond_sysfs.c                   |  13 ++
 drivers/net/dsa/mt7530.c                           | 124 +++++++++------
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  19 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  19 ++-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |  81 +++++++---
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   3 +
 drivers/net/phy/mscc/mscc.h                        |   1 +
 drivers/net/phy/mscc/mscc_main.c                   |  54 +++----
 .../x86/intel/speed_select_if/isst_if_common.c     |  49 ++++--
 drivers/power/supply/bq24190_charger.c             |  13 +-
 drivers/power/supply/bq27xxx_battery.c             | 171 +++++++++++----------
 drivers/power/supply/power_supply_core.c           |  57 +++----
 include/linux/power/bq27xxx_battery.h              |   3 +
 include/linux/power_supply.h                       |   5 +-
 include/net/bond_options.h                         |   1 +
 include/net/bonding.h                              |   3 +-
 include/net/dsa.h                                  |  28 ++++
 include/net/ip.h                                   |   2 +
 include/net/page_pool.h                            |  18 ---
 include/net/xdp.h                                  |   3 +
 include/uapi/linux/if_link.h                       |   1 +
 include/uapi/linux/in.h                            |   2 +
 kernel/bpf/hashtab.c                               |   6 +-
 net/bluetooth/hci_sock.c                           |  28 ++++
 net/core/page_pool.c                               |  34 +++-
 net/core/xdp.c                                     |  93 +++++++----
 net/ipv4/ip_sockglue.c                             |  12 +-
 net/ipv4/raw.c                                     |   5 +-
 net/ipv6/raw.c                                     |   3 +-
 net/netfilter/nf_conntrack_netlink.c               |   8 -
 tools/include/uapi/linux/if_link.h                 |   1 +
 44 files changed, 726 insertions(+), 389 deletions(-)


