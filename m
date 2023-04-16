Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C876E3B5B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDPTBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDPTBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:01:43 -0400
Received: from qs51p00im-qukt01071902.me.com (qs51p00im-qukt01071902.me.com [17.57.155.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE98D1BCA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681671298; bh=172UbA2HK1ZDKX3WV0R95NgDfbLml7OVlKVz4FbUmTM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=SSeCKZRozPDWw6u0RPzwY/l6Yf2KSJ8QD1lFgBgp1V7IZGU4JNJ7YnBoQKlZe56is
         +v9tzJ7Meu8mpifV2comWqHvSsosYli9EPqjVrdG/qsIw/1mHXiNj5jh0XxkaRMMJx
         n7zqJrG3Nx67PCe+CPYP5waDc1woWYeA8lDiIhC/D4/8ANmZz5NFjRxt8w34IFToNV
         c+ztDHP8lFmmx6Oc4IYRdes5DH5wIU4Vw/WiKn7U49AMXi+KpYA6WD7/gqQMgWVnV2
         mLv+xwUE3pklR3s0I+oYLlt92Z1nE2GGuevXmKGHsIGajvb9ngu6eiVSIh0CKK+Lts
         9pJRuf8/V0hQQ==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01071902.me.com (Postfix) with ESMTPSA id 34C065EC0539;
        Sun, 16 Apr 2023 18:54:58 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alain Volmat <avolmat@me.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: arm: remove stih415/stih416 related entries
Date:   Sun, 16 Apr 2023 20:53:48 +0200
Message-Id: <20230416185349.18156-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -qQ1b1e97ux5mrrU1wlaXenp_07_NNEZ
X-Proofpoint-GUID: -qQ1b1e97ux5mrrU1wlaXenp_07_NNEZ
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=966 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304160179
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ST's STiH415 and STiH416 platforms support have been removed since
a long time already.  This commit updates the sti related documentation
overview to remove related entries and update the sti part to add
STiH407/STiH410 and STiH418 platforms which are still actively
supported.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
Patch once sent as part of serie: https://lore.kernel.org/all/20230209091659.1409-2-avolmat@me.com/
Sending it individually.

 Documentation/arm/index.rst                |  2 --
 Documentation/arm/sti/overview.rst         | 10 +++-------
 Documentation/arm/sti/stih415-overview.rst | 14 --------------
 Documentation/arm/sti/stih416-overview.rst | 13 -------------
 4 files changed, 3 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/arm/sti/stih415-overview.rst
 delete mode 100644 Documentation/arm/sti/stih416-overview.rst

diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index ae42fe886f0d..8890ec4314c2 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -69,11 +69,9 @@ SoC-specific documents
 
    spear/overview
 
-   sti/stih416-overview
    sti/stih407-overview
    sti/stih418-overview
    sti/overview
-   sti/stih415-overview
 
    vfp/release-notes
 
diff --git a/Documentation/arm/sti/overview.rst b/Documentation/arm/sti/overview.rst
index 70743617a74f..ae16aced800f 100644
--- a/Documentation/arm/sti/overview.rst
+++ b/Documentation/arm/sti/overview.rst
@@ -7,22 +7,18 @@ Introduction
 
   The ST Microelectronics Multimedia and Application Processors range of
   CortexA9 System-on-Chip are supported by the 'STi' platform of
-  ARM Linux. Currently STiH415, STiH416 SOCs are supported with both
-  B2000 and B2020 Reference boards.
+  ARM Linux. Currently STiH407, STiH410 and STiH418 are supported.
 
 
 configuration
 -------------
 
-  A generic configuration is provided for both STiH415/416, and can be used as the
-  default by::
-
-	make stih41x_defconfig
+  The configuration for the STi platform is supported via the multi_v7_defconfig.
 
 Layout
 ------
 
-  All the files for multiple machine families (STiH415, STiH416, and STiG125)
+  All the files for multiple machine families (STiH407, STiH410, and STiH418)
   are located in the platform code contained in arch/arm/mach-sti
 
   There is a generic board board-dt.c in the mach folder which support
diff --git a/Documentation/arm/sti/stih415-overview.rst b/Documentation/arm/sti/stih415-overview.rst
deleted file mode 100644
index b67452d610c4..000000000000
--- a/Documentation/arm/sti/stih415-overview.rst
+++ /dev/null
@@ -1,14 +0,0 @@
-================
-STiH415 Overview
-================
-
-Introduction
-------------
-
-    The STiH415 is the next generation of HD, AVC set-top box processors
-    for satellite, cable, terrestrial and IP-STB markets.
-
-    Features:
-
-    - ARM Cortex-A9 1.0 GHz, dual-core CPU
-    - SATA2x2,USB 2.0x3, PCIe, Gbit Ethernet MACx2
diff --git a/Documentation/arm/sti/stih416-overview.rst b/Documentation/arm/sti/stih416-overview.rst
deleted file mode 100644
index 93f17d74d8db..000000000000
--- a/Documentation/arm/sti/stih416-overview.rst
+++ /dev/null
@@ -1,13 +0,0 @@
-================
-STiH416 Overview
-================
-
-Introduction
-------------
-
-    The STiH416 is the next generation of HD, AVC set-top box processors
-    for satellite, cable, terrestrial and IP-STB markets.
-
-    Features
-    - ARM Cortex-A9 1.2 GHz dual core CPU
-    - SATA2x2,USB 2.0x3, PCIe, Gbit Ethernet MACx2
-- 
2.34.1

