Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E546740CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjF1Jb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:31:28 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:47546 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjF1JZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:25:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B69561281;
        Wed, 28 Jun 2023 09:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E66FC433C0;
        Wed, 28 Jun 2023 09:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687944334;
        bh=xoQhhXbVAXWWJ1qMR37IQk8uTkpx15NRNuc1mGJLkYM=;
        h=From:To:Cc:Subject:Date:From;
        b=w9pMXU5SrK53stXlLpwDGnitlgggEVOrqb9Eacrq9kDxaKmw8BJ4qmUTYRFcVKqUw
         1cEl6Wtu2jCfceap2FCcHZdXaXImQ5NdpGvTn2+cgeT/C4Oc63TVC2+tY6Np8KD4JA
         hgwWujsHsOIzCe08M9J2gVFYjOuX8JmYhZqaERK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.288
Date:   Wed, 28 Jun 2023 11:25:28 +0200
Message-ID: <2023062828-devouring-discolor-8814@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.19.288 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                    |    2 
 arch/arm64/include/asm/sysreg.h             |    6 
 arch/x86/kernel/apic/x2apic_phys.c          |    5 
 arch/x86/purgatory/Makefile                 |    5 
 drivers/char/ipmi/ipmi_msghandler.c         |  278 ++++++++++++++--------------
 drivers/char/ipmi/ipmi_si_intf.c            |    2 
 drivers/char/ipmi/ipmi_ssif.c               |    2 
 drivers/gpu/drm/exynos/exynos_drm_g2d.c     |    2 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c    |    2 
 drivers/gpu/drm/radeon/radeon_gem.c         |    4 
 drivers/hid/wacom_sys.c                     |    7 
 drivers/hv/channel_mgmt.c                   |   18 +
 drivers/i2c/busses/i2c-imx-lpi2c.c          |    4 
 drivers/media/cec/cec-adap.c                |    3 
 drivers/mmc/host/mtk-sd.c                   |    2 
 drivers/mmc/host/mvsdio.c                   |    8 
 drivers/mmc/host/omap.c                     |    2 
 drivers/mmc/host/omap_hsmmc.c               |    6 
 drivers/mmc/host/sdhci-acpi.c               |    2 
 drivers/mmc/host/usdhi6rol0.c               |    6 
 drivers/net/ethernet/emulex/benet/be_main.c |    4 
 drivers/net/ethernet/qualcomm/qca_spi.c     |    3 
 drivers/net/ieee802154/mac802154_hwsim.c    |    6 
 drivers/nfc/nfcsim.c                        |    4 
 drivers/pci/controller/pci-hyperv.c         |   18 +
 drivers/s390/cio/device.c                   |    5 
 drivers/target/iscsi/iscsi_target_nego.c    |    4 
 drivers/tty/serial/lantiq.c                 |   74 ++++---
 drivers/usb/gadget/udc/amd5536udc_pci.c     |    3 
 fs/nilfs2/page.c                            |   10 -
 fs/nilfs2/segbuf.c                          |    6 
 fs/nilfs2/segment.c                         |    7 
 fs/nilfs2/super.c                           |   23 ++
 fs/nilfs2/the_nilfs.c                       |   44 ++++
 include/linux/ipmi_smi.h                    |   17 -
 include/linux/rcupdate.h                    |   18 +
 kernel/cgroup/cgroup.c                      |   20 +-
 net/ipv4/esp4_offload.c                     |    3 
 net/ipv6/esp6_offload.c                     |    3 
 net/netfilter/nf_tables_api.c               |    7 
 net/netfilter/nfnetlink_osf.c               |    1 
 net/netfilter/xt_osf.c                      |    1 
 net/sched/sch_netem.c                       |    8 
 sound/soc/codecs/nau8824.c                  |   24 ++
 44 files changed, 452 insertions(+), 227 deletions(-)

Bernhard Seibold (1):
      serial: lantiq: add missing interrupt ack

Chen Aotian (1):
      ieee802154: hwsim: Fix possible memory leaks

Clark Wang (1):
      i2c: imx-lpi2c: fix type char overflow issue when calculating the clock cycle

Corey Minyard (1):
      ipmi: Make the smi watcher be disabled immediately when not needed

Dan Carpenter (1):
      usb: gadget: udc: fix NULL dereference in remove()

Denis Arefev (1):
      HID: wacom: Add error check to wacom_parse_and_register()

Dexuan Cui (1):
      PCI: hv: Fix a race condition bug in hv_pci_query_relations()

Dheeraj Kumar Srivastava (1):
      x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys

Edson Juliano Drosdeck (1):
      ASoC: nau8824: Add quirk to active-high jack-detect

Eric Dumazet (1):
      sch_netem: acquire qdisc lock in netem_change()

Greg Kroah-Hartman (1):
      Linux 4.19.288

Hans Verkuil (1):
      media: cec: core: don't set last_initiator if tx in progress

Hauke Mehrtens (1):
      serial: lantiq: Do not swap register read/writes

Inki Dae (1):
      drm/exynos: vidi: fix a wrong error return

Marc Zyngier (1):
      arm64: Add missing Set/Way CMO encodings

Maurizio Lombardi (1):
      scsi: target: iscsi: Prevent login threads from racing between each other

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

Sergey Shtylyov (6):
      mmc: mtk-sd: fix deferred probing
      mmc: mvsdio: fix deferred probing
      mmc: omap: fix deferred probing
      mmc: omap_hsmmc: fix deferred probing
      mmc: sdhci-acpi: fix deferred probing
      mmc: usdhi60rol0: fix deferred probing

Songjun Wu (2):
      serial: lantiq: Change ltq_w32_mask to asc_update_bits
      serial: lantiq: Use readl/writel instead of ltq_r32/ltq_w32

Stefan Wahren (1):
      net: qca_spi: Avoid high load if QCA7000 is not available

Tony Camuso (1):
      ipmi: move message error checking to avoid deadlock

Vineeth Vijayan (1):
      s390/cio: unregister device when the only path is gone

Xiu Jianfeng (1):
      cgroup: Do not corrupt task iteration when rebinding subsystem

Yangtao Li (1):
      mmc: mvsdio: convert to devm_platform_ioremap_resource

