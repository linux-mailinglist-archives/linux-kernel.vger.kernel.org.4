Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4E8740D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjF1Jbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:31:46 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:47790 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjF1JZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:25:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0676F61298;
        Wed, 28 Jun 2023 09:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1233C433C8;
        Wed, 28 Jun 2023 09:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687944351;
        bh=4c/b6DIAFGGItp9Wf2nYHPY+4qW//McLeRjOudWIZFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ph8WR1s7uX6YGAKKUoQ24XUYTccDVL6+czafKnmNRt0YBnC9p1j69WDQaZZDzlVk1
         RGWkAvXLWvs1rDGPkdMeEnf0qjcbJUXiPCLtlpysuzxzya6vD5ArX3JOFmSn2W/AF5
         Rg2IIeG4BzjnaHxTxqm5Z1pLfVk3l4430j+Q8Tpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.249
Date:   Wed, 28 Jun 2023 11:25:33 +0200
Message-ID: <2023062833-charity-tutu-d5f8@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.4.249 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                           |    2 
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |    2 
 arch/arm/boot/dts/at91sam9261ek.dts                |    2 
 arch/arm/boot/dts/imx7d-pico-hobbit.dts            |    2 
 arch/arm/boot/dts/imx7d-sdb.dts                    |    2 
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |    2 
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |    2 
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |    2 
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |    2 
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |    2 
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |    2 
 arch/arm/boot/dts/omap5-cm-t54.dts                 |    2 
 arch/arm64/include/asm/sysreg.h                    |    6 
 arch/x86/kernel/apic/x2apic_phys.c                 |    5 
 arch/x86/mm/kaslr.c                                |    8 
 arch/x86/purgatory/Makefile                        |    5 
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |    2 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |    2 
 drivers/gpu/drm/radeon/radeon_gem.c                |    4 
 drivers/hid/wacom_sys.c                            |    7 
 drivers/hv/channel_mgmt.c                          |   18 
 drivers/i2c/busses/i2c-imx-lpi2c.c                 |    4 
 drivers/media/cec/cec-adap.c                       |    3 
 drivers/media/dvb-core/dvbdev.c                    |   88 ++
 drivers/mmc/host/meson-gx-mmc.c                    |   10 
 drivers/mmc/host/mtk-sd.c                          |    2 
 drivers/mmc/host/mvsdio.c                          |    8 
 drivers/mmc/host/omap.c                            |    2 
 drivers/mmc/host/omap_hsmmc.c                      |    6 
 drivers/mmc/host/sdhci-acpi.c                      |    2 
 drivers/mmc/host/sh_mmcif.c                        |    2 
 drivers/mmc/host/usdhi6rol0.c                      |    6 
 drivers/net/dsa/mt7530.c                           |    2 
 drivers/net/ethernet/emulex/benet/be_main.c        |    4 
 drivers/net/ethernet/qualcomm/qca_spi.c            |    3 
 drivers/net/ieee802154/mac802154_hwsim.c           |    6 
 drivers/net/phy/dp83867.c                          |    2 
 drivers/nfc/nfcsim.c                               |    4 
 drivers/pci/controller/pci-hyperv.c                |   18 
 drivers/s390/cio/device.c                          |    5 
 drivers/target/iscsi/iscsi_target_nego.c           |    4 
 drivers/usb/gadget/udc/amd5536udc_pci.c            |    3 
 fs/cifs/dfs_cache.c                                |  701 +++++++++++----------
 fs/eventpoll.c                                     |    6 
 fs/nilfs2/page.c                                   |   10 
 fs/nilfs2/segbuf.c                                 |    6 
 fs/nilfs2/segment.c                                |    7 
 fs/nilfs2/super.c                                  |   23 
 fs/nilfs2/the_nilfs.c                              |   44 +
 fs/xfs/xfs_log_recover.c                           |   10 
 include/linux/list.h                               |   20 
 include/linux/rcupdate.h                           |   18 
 include/media/dvbdev.h                             |   15 
 include/net/ip_tunnels.h                           |   12 
 include/trace/events/writeback.h                   |    2 
 kernel/cgroup/cgroup.c                             |   20 
 kernel/sched/wait.c                                |    2 
 kernel/time/tick-common.c                          |   13 
 kernel/time/tick-sched.c                           |   13 
 kernel/trace/trace.c                               |   11 
 kernel/trace/trace.h                               |    1 
 kernel/trace/trace_events.c                        |    2 
 mm/filemap.c                                       |  135 ++--
 mm/page-writeback.c                                |    8 
 net/ipv4/esp4_offload.c                            |    3 
 net/ipv6/esp6_offload.c                            |    3 
 net/netfilter/ipvs/ip_vs_xmit.c                    |    2 
 net/netfilter/nf_tables_api.c                      |    7 
 net/netfilter/nfnetlink_osf.c                      |    1 
 net/netfilter/xt_osf.c                             |    1 
 net/sched/sch_netem.c                              |    8 
 sound/soc/codecs/nau8824.c                         |   24 
 72 files changed, 892 insertions(+), 501 deletions(-)

Arınç ÜNAL (1):
      net: dsa: mt7530: fix trapping frames on non-MT7621 SoC MT7530 switch

Benjamin Segall (1):
      epoll: ep_autoremove_wake_function should use list_del_init_careful

Chen Aotian (1):
      ieee802154: hwsim: Fix possible memory leaks

Clark Wang (1):
      i2c: imx-lpi2c: fix type char overflow issue when calculating the clock cycle

Dan Carpenter (1):
      usb: gadget: udc: fix NULL dereference in remove()

Darrick J. Wong (1):
      xfs: verify buffer contents when we skip log replay

Denis Arefev (1):
      HID: wacom: Add error check to wacom_parse_and_register()

Dexuan Cui (1):
      PCI: hv: Fix a race condition bug in hv_pci_query_relations()

Dheeraj Kumar Srivastava (1):
      x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys

Dinghao Liu (1):
      media: dvbdev: Fix memleak in dvb_register_device

Edson Juliano Drosdeck (1):
      ASoC: nau8824: Add quirk to active-high jack-detect

Eric Dumazet (1):
      sch_netem: acquire qdisc lock in netem_change()

Francesco Dolcini (1):
      Revert "net: phy: dp83867: perform soft reset and retain established link"

Greg Kroah-Hartman (1):
      Linux 5.4.249

Hans Verkuil (1):
      media: cec: core: don't set last_initiator if tx in progress

Hugh Dickins (1):
      mm: fix VM_BUG_ON(PageTail) and BUG_ON(PageWriteback)

Hyunwoo Kim (1):
      media: dvb-core: Fix use-after-free due to race at dvb_register_device()

Inki Dae (1):
      drm/exynos: vidi: fix a wrong error return

Lee Jones (1):
      x86/mm: Avoid using set_pgd() outside of real PGD pages

Linus Torvalds (3):
      mm: rewrite wait_on_page_bit_common() logic
      list: add "list_del_init_careful()" to go with "list_empty_careful()"
      mm: make wait_on_page_writeback() wait for multiple pending writebacks

Linus Walleij (1):
      ARM: dts: Fix erroneous ADS touchscreen polarities

Marc Zyngier (1):
      arm64: Add missing Set/Way CMO encodings

Martin Hundebøll (1):
      mmc: meson-gx: remove redundant mmc_request_done() call from irq context

Matthias May (1):
      ip_tunnels: allow VXLAN/GENEVE to inherit TOS/TTL from VLAN

Maurizio Lombardi (1):
      scsi: target: iscsi: Prevent login threads from racing between each other

Mauro Carvalho Chehab (1):
      media: dvbdev: fix error logic at dvb_register_device()

Michael Kelley (1):
      Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs

Min Li (2):
      drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl
      drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl

Osama Muhammad (1):
      nfcsim.c: Fix error checking for debugfs_create_dir

Pablo Neira Ayuso (2):
      netfilter: nf_tables: disallow element updates of bound anonymous sets
      netfilter: nfnetlink_osf: fix module autoload

Paul E. McKenney (1):
      rcu: Upgrade rcu_swap_protected() to rcu_replace_pointer()

Paulo Alcantara (SUSE) (5):
      cifs: Clean up DFS referral cache
      cifs: Get rid of kstrdup_const()'d paths
      cifs: Introduce helpers for finding TCP connection
      cifs: Merge is_path_valid() into get_normalized_path()
      cifs: Fix potential deadlock when updating vol in cifs_reconnect()

Rafael Aquini (1):
      writeback: fix dereferencing NULL mapping->host on writeback_page_template

Ricardo Ribalda (1):
      x86/purgatory: remove PGO flags

Ross Lagerwall (1):
      be2net: Extend xmit workaround to BE3 chip

Ryusuke Konishi (3):
      nilfs2: reject devices with insufficient block count
      nilfs2: fix buffer corruption due to concurrent device reads
      nilfs2: prevent general protection fault in nilfs_clear_dirty_page()

Sebastian Andrzej Siewior (1):
      xfrm: Linearize the skb after offloading if needed.

Sergey Shtylyov (7):
      mmc: mtk-sd: fix deferred probing
      mmc: mvsdio: fix deferred probing
      mmc: omap: fix deferred probing
      mmc: omap_hsmmc: fix deferred probing
      mmc: sdhci-acpi: fix deferred probing
      mmc: sh_mmcif: fix deferred probing
      mmc: usdhi60rol0: fix deferred probing

Stefan Wahren (1):
      net: qca_spi: Avoid high load if QCA7000 is not available

Steven Rostedt (Google) (1):
      tracing: Add tracing_reset_all_online_cpus_unlocked() function

Terin Stock (1):
      ipvs: align inner_mac_header for encapsulation

Thomas Gleixner (1):
      tick/common: Align tick period during sched_timer setup

Vineeth Vijayan (1):
      s390/cio: unregister device when the only path is gone

Xiu Jianfeng (1):
      cgroup: Do not corrupt task iteration when rebinding subsystem

Yangtao Li (1):
      mmc: mvsdio: convert to devm_platform_ioremap_resource

