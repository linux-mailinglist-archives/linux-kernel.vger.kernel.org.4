Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24DA65B048
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjABLKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:10:07 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78235E6E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:10:05 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:513e:34db:6493:4ef7])
        by andre.telenet-ops.be with bizsmtp
        id 3nA22900q2Ef9QR01nA2kY; Mon, 02 Jan 2023 12:10:03 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1pCIhe-001qS0-KY; Mon, 02 Jan 2023 12:10:02 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1pCHui-0019kp-Og; Mon, 02 Jan 2023 11:19:28 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.2-rc1
Date:   Mon,  2 Jan 2023 11:19:26 +0100
Message-Id: <fdd3b827ebc5abea6c295df4121048a6a03b698a.1672654705.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Drop CONFIG_NFT_OBJREF=m (removed in commit d037abc2414b4539
    ("netfilter: nft_objref: make it builtin")),
  - Drop CONFIG_CDROM_PKTCDVD=m (removed in commit f40eb99897af665f
    ("pktcdvd: remove driver.")),
  - Drop CONFIG_TEST_STRSCPY=m (replaced by auto-modular
    CONFIG_STRSCPY_KUNIT_TEST in commit 41eefc46a3a46829 ("string:
    Convert strscpy() self-test to KUnit")),
  - Drop CONFIG_TEST_SIPHASH=m (replaced by auto-modular
    CONFIG_SIPHASH_KUNIT_TEST in commit fb3d88ab354b3b07 ("siphash:
    Convert selftest to KUnit")).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v6.3 branch.

 arch/m68k/configs/amiga_defconfig    | 4 ----
 arch/m68k/configs/apollo_defconfig   | 4 ----
 arch/m68k/configs/atari_defconfig    | 4 ----
 arch/m68k/configs/bvme6000_defconfig | 4 ----
 arch/m68k/configs/hp300_defconfig    | 4 ----
 arch/m68k/configs/mac_defconfig      | 4 ----
 arch/m68k/configs/multi_defconfig    | 4 ----
 arch/m68k/configs/mvme147_defconfig  | 4 ----
 arch/m68k/configs/mvme16x_defconfig  | 4 ----
 arch/m68k/configs/q40_defconfig      | 4 ----
 arch/m68k/configs/sun3_defconfig     | 4 ----
 arch/m68k/configs/sun3x_defconfig    | 4 ----
 12 files changed, 48 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 7b49fe6f7cb305d3..eaee93393fadfaed 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -108,7 +108,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -313,7 +312,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -630,7 +628,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -638,7 +635,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 656a06d97d4c156e..b600370853be75e5 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -104,7 +104,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -303,7 +302,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -586,7 +584,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -594,7 +591,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index d3078eecf4efefed..d1b7ad44535579eb 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -111,7 +111,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -314,7 +313,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -618,7 +616,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -626,7 +623,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 7b86e1277a1a5085..14c2c602c452d6db 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -101,7 +101,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -300,7 +299,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -578,7 +576,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -586,7 +583,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index d0d5c0a9aee60a6e..3bf51c3ac62d7514 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -103,7 +103,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -302,7 +301,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -588,7 +586,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -596,7 +593,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index ac1d0c86b6ff53ee..c839c27eeb6efade 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -102,7 +102,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -305,7 +304,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -609,7 +607,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -617,7 +614,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index c5f7603c98308ed0..a78031c43e63606c 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -122,7 +122,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -334,7 +333,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -695,7 +693,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -703,7 +700,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 26f5b59e3bc02926..241358f64d8f4a0c 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -100,7 +100,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -299,7 +298,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -577,7 +575,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -585,7 +582,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 3045c7f0bde3507f..3382fe16d7f31b11 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -101,7 +101,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -300,7 +299,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -578,7 +576,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -586,7 +583,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index f2a486be651b5412..6137020556c8346e 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -102,7 +102,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -304,7 +303,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -596,7 +594,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -604,7 +601,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 8a7db7be10c03ccc..087505407a0b3e08 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -98,7 +98,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -297,7 +296,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -576,7 +574,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -584,7 +581,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 7ed49ee0b9e011ed..a0e0fa8fbd504295 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -98,7 +98,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -297,7 +296,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
@@ -576,7 +574,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
@@ -584,7 +581,6 @@ CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
 CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_SIPHASH=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-- 
2.25.1

