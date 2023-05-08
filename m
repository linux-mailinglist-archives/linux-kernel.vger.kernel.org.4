Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B8D6FB047
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjEHMj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjEHMjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:39:22 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AD539488
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:39:15 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:6a18:41e7:fcfe:24c0])
        by andre.telenet-ops.be with bizsmtp
        id uCfC2900W2WBekD01CfCj9; Mon, 08 May 2023 14:39:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pw08v-001VqE-Us;
        Mon, 08 May 2023 14:39:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pw092-00Avgn-LR;
        Mon, 08 May 2023 14:39:12 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.4-rc1
Date:   Mon,  8 May 2023 14:39:09 +0200
Message-Id: <5a9bc6058c4fab4b57ba45d778956df8ce7e8688.1683548863.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Enable modular build of the new DMA pool test,
  - Drop CONFIG_PRINT_QUOTA_WARNING=n (auto-disabled since commit
    36d532d713db5797 ("quota: mark PRINT_QUOTA_WARNING as BROKEN")),
  - Drop CONFIG_UNIX=y and CONFIG_INET=y (implied by 9P_FS since commit
    d7385ba137711ea7 ("9p: Remove INET dependency")).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v6.5 branch.

 arch/m68k/configs/amiga_defconfig    | 2 +-
 arch/m68k/configs/apollo_defconfig   | 2 +-
 arch/m68k/configs/atari_defconfig    | 2 +-
 arch/m68k/configs/bvme6000_defconfig | 2 +-
 arch/m68k/configs/hp300_defconfig    | 2 +-
 arch/m68k/configs/mac_defconfig      | 2 +-
 arch/m68k/configs/multi_defconfig    | 2 +-
 arch/m68k/configs/mvme147_defconfig  | 2 +-
 arch/m68k/configs/mvme16x_defconfig  | 2 +-
 arch/m68k/configs/q40_defconfig      | 2 +-
 arch/m68k/configs/sun3_defconfig     | 1 -
 arch/m68k/configs/sun3x_defconfig    | 2 +-
 arch/m68k/configs/virt_defconfig     | 2 --
 13 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index b26469a65bc11ed4..62fdca7efce4dc96 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -43,6 +43,7 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_MISC=m
 CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
+CONFIG_DMAPOOL_TEST=m
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -454,7 +455,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 944a49a129bedab0..5bfbd0444bb51f70 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -39,6 +39,7 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_MISC=m
 CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
+CONFIG_DMAPOOL_TEST=m
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -411,7 +412,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index f3790c45cac722af..8e52bc4a48f1f04f 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -46,6 +46,7 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_MISC=m
 CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
+CONFIG_DMAPOOL_TEST=m
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -442,7 +443,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 23b7805309bd4407..f3336f1774ec48b4 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -36,6 +36,7 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_MISC=m
 CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
+CONFIG_DMAPOOL_TEST=m
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -403,7 +404,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 5605ab5c3dcfc25f..2d1bbac680662884 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -38,6 +38,7 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_MISC=m
 CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
+CONFIG_DMAPOOL_TEST=m
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -413,7 +414,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index d0d1f9c33756d795..b4428dc361027632 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -37,6 +37,7 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_MISC=m
 CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
+CONFIG_DMAPOOL_TEST=m
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -433,7 +434,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 6d04314ce7eafb39..4cd9fa4cb10c8893 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -57,6 +57,7 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_MISC=m
 CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
+CONFIG_DMAPOOL_TEST=m
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -519,7 +520,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index e6f5ae526d089339..7ee9ad50f0ad9d5e 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -35,6 +35,7 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_MISC=m
 CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
+CONFIG_DMAPOOL_TEST=m
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -402,7 +403,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index f2d4dff4787aade7..2488893616dc237f 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -36,6 +36,7 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_MISC=m
 CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
+CONFIG_DMAPOOL_TEST=m
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -403,7 +404,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 907eedecd040262c..ffc676289f878012 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -37,6 +37,7 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_MISC=m
 CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
+CONFIG_DMAPOOL_TEST=m
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -420,7 +421,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 9e3d47008f218675..198179657ce09afc 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -402,7 +402,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index f6540078cb4beb48..85364f6178d440d8 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -33,6 +33,7 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_MISC=m
 CONFIG_SLAB=y
 # CONFIG_COMPACTION is not set
+CONFIG_DMAPOOL_TEST=m
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -401,7 +402,6 @@ CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
diff --git a/arch/m68k/configs/virt_defconfig b/arch/m68k/configs/virt_defconfig
index 0b5a9f1cb7e8c5d8..49e649cc29f7b1e8 100644
--- a/arch/m68k/configs/virt_defconfig
+++ b/arch/m68k/configs/virt_defconfig
@@ -26,8 +26,6 @@ CONFIG_SUN_PARTITION=y
 CONFIG_SYSV68_PARTITION=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-- 
2.34.1

