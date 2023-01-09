Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA529662240
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjAIJ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjAIJ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:58:30 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7889FDB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:56:10 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:c32c:cc7a:25f1:127a])
        by albert.telenet-ops.be with bizsmtp
        id 6Zw8290082RK3VH06Zw8Gg; Mon, 09 Jan 2023 10:56:08 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pEosw-001KR6-2i;
        Mon, 09 Jan 2023 10:56:08 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pEo4n-00DZ9x-Eb;
        Mon, 09 Jan 2023 10:04:17 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.2-rc3
Date:   Mon,  9 Jan 2023 10:04:16 +0100
Message-Id: <6c4589bc56ffba0f923a7361262397f6c32a3dc1.1673255008.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Enable modular build of CD/DVD media packet writing support (revived
    in commit 4b83e99ee7092df3 ("Revert "pktcdvd: remove driver."")).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be combined with "m68k: defconfig: Update defconfigs for v6.2-rc1".
---
 arch/m68k/configs/amiga_defconfig    | 1 +
 arch/m68k/configs/apollo_defconfig   | 1 +
 arch/m68k/configs/atari_defconfig    | 1 +
 arch/m68k/configs/bvme6000_defconfig | 1 +
 arch/m68k/configs/hp300_defconfig    | 1 +
 arch/m68k/configs/mac_defconfig      | 1 +
 arch/m68k/configs/multi_defconfig    | 2 ++
 arch/m68k/configs/mvme147_defconfig  | 1 +
 arch/m68k/configs/mvme16x_defconfig  | 1 +
 arch/m68k/configs/q40_defconfig      | 1 +
 arch/m68k/configs/sun3_defconfig     | 1 +
 arch/m68k/configs/sun3x_defconfig    | 1 +
 12 files changed, 13 insertions(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index eaee93393fadfaed..ec2d792015a4bdd0 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -312,6 +312,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index b600370853be75e5..061a07824dc29502 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -302,6 +302,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index d1b7ad44535579eb..79c49647e4818b7a 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -313,6 +313,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 14c2c602c452d6db..0d5832cb3e10b9ce 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -299,6 +299,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 3bf51c3ac62d7514..c246c3538839beb5 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -301,6 +301,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index c839c27eeb6efade..98d2d0599e5a8f2c 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -304,6 +304,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index a78031c43e63606c..b2d5ec6ba625c7b2 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -314,6 +314,7 @@ CONFIG_AF_KCM=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
+CONFIG_PCCARD=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
@@ -333,6 +334,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 241358f64d8f4a0c..d3420c642992b2e7 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -298,6 +298,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 3382fe16d7f31b11..e294b0b67695069c 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -299,6 +299,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 6137020556c8346e..764a94b089362003 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -303,6 +303,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 087505407a0b3e08..d4eeddac6bb8de48 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -296,6 +296,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index a0e0fa8fbd504295..ca359b8806830d56 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -296,6 +296,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
-- 
2.34.1

