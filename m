Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FBA740DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjF1Jxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjF1J00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0548B30C7;
        Wed, 28 Jun 2023 02:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8480461297;
        Wed, 28 Jun 2023 09:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54109C433C0;
        Wed, 28 Jun 2023 09:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687944326;
        bh=MC/0Hid37V8silvu6DDDlDg78Xt9YOT3wKNoU/5xV4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=BUNuc22LslwCeeCBva2mXDffKmgSTc5t9e1CI9cg/5AJ2DHr0kR1M0Qc2ehouuDWS
         DxBkfXw+p+Z8b9eLNi96Oj8nCcJfNA9h2FUg3Y4X1khugmCzB8cSDM+WX1AdbaUtkF
         oKiRJ8ZWbaOl7GiMgpLS9CPXn/HjBXD3jS219QTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.320
Date:   Wed, 28 Jun 2023 11:25:22 +0200
Message-ID: <2023062823-mulch-skeleton-4071@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

I'm announcing the release of the 4.14.320 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                    |    2 -
 arch/arm64/include/asm/sysreg.h             |    6 +++
 arch/x86/kernel/apic/x2apic_phys.c          |    5 ++-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c     |    2 -
 drivers/gpu/drm/exynos/exynos_drm_vidi.c    |    2 -
 drivers/gpu/drm/radeon/radeon_gem.c         |    4 --
 drivers/hid/wacom_sys.c                     |    7 +++-
 drivers/hv/channel_mgmt.c                   |   18 ++++++++++-
 drivers/i2c/busses/i2c-imx-lpi2c.c          |    4 +-
 drivers/mmc/host/mtk-sd.c                   |    2 -
 drivers/mmc/host/omap.c                     |    2 -
 drivers/mmc/host/omap_hsmmc.c               |    6 ++-
 drivers/mmc/host/usdhi6rol0.c               |    6 ++-
 drivers/net/ethernet/emulex/benet/be_main.c |    4 +-
 drivers/net/ethernet/qualcomm/qca_spi.c     |    3 -
 drivers/nfc/nfcsim.c                        |    4 --
 drivers/s390/cio/device.c                   |    5 ++-
 drivers/target/iscsi/iscsi_target_nego.c    |    4 +-
 drivers/tty/serial/lantiq.c                 |    1 
 drivers/usb/gadget/udc/amd5536udc_pci.c     |    3 +
 drivers/video/fbdev/imsttfb.c               |    6 +++
 fs/nilfs2/page.c                            |   10 +++++-
 fs/nilfs2/segbuf.c                          |    6 +++
 fs/nilfs2/segment.c                         |    7 ++++
 fs/nilfs2/super.c                           |   23 ++++++++++++++
 fs/nilfs2/the_nilfs.c                       |   44 +++++++++++++++++++++++++++-
 kernel/cgroup/cgroup.c                      |   20 ++++++++++--
 net/ipv4/esp4_offload.c                     |    3 +
 net/ipv6/esp6_offload.c                     |    3 +
 net/netfilter/nf_tables_api.c               |    7 +++-
 30 files changed, 181 insertions(+), 38 deletions(-)

Bernhard Seibold (1):
      serial: lantiq: add missing interrupt ack

Clark Wang (1):
      i2c: imx-lpi2c: fix type char overflow issue when calculating the clock cycle

Dan Carpenter (1):
      usb: gadget: udc: fix NULL dereference in remove()

Denis Arefev (1):
      HID: wacom: Add error check to wacom_parse_and_register()

Dheeraj Kumar Srivastava (1):
      x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys

Greg Kroah-Hartman (1):
      Linux 4.14.320

Helge Deller (1):
      fbdev: imsttfb: Release framebuffer and dealloc cmap on error path

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

Pablo Neira Ayuso (1):
      netfilter: nf_tables: disallow element updates of bound anonymous sets

Ross Lagerwall (1):
      be2net: Extend xmit workaround to BE3 chip

Ryusuke Konishi (3):
      nilfs2: reject devices with insufficient block count
      nilfs2: fix buffer corruption due to concurrent device reads
      nilfs2: prevent general protection fault in nilfs_clear_dirty_page()

Sebastian Andrzej Siewior (1):
      xfrm: Linearize the skb after offloading if needed.

Sergey Shtylyov (4):
      mmc: mtk-sd: fix deferred probing
      mmc: omap: fix deferred probing
      mmc: omap_hsmmc: fix deferred probing
      mmc: usdhi60rol0: fix deferred probing

Stefan Wahren (1):
      net: qca_spi: Avoid high load if QCA7000 is not available

Vineeth Vijayan (1):
      s390/cio: unregister device when the only path is gone

Xiu Jianfeng (1):
      cgroup: Do not corrupt task iteration when rebinding subsystem

