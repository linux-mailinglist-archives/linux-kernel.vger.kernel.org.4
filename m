Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C674D461
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjGJLTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjGJLTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:19:05 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A24E5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:19:01 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f087:2614:ec9d:569f])
        by baptiste.telenet-ops.be with bizsmtp
        id KPJy2A00L1w4dBK01PJydw; Mon, 10 Jul 2023 13:18:58 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qIouq-0010yr-Qd;
        Mon, 10 Jul 2023 13:18:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qIouw-00BJ4a-Jz;
        Mon, 10 Jul 2023 13:18:58 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.5-rc1
Date:   Mon, 10 Jul 2023 13:18:57 +0200
Message-Id: <274736e1cf7ab863fe84400611c300cb5a25b8c8.1688985387.git.geert@linux-m68k.org>
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

  - Drop CONFIG_CRYPTO_SHA3=m (auto-enabled since commit
    bb897c55042e9330 ("crypto: jitter - replace LFSR with SHA3-256")),
  - Enable modular build of the Maple Tree test, which can now be
    enabled when debugging is disabled.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v6.6 branch.
---
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
 arch/m68k/configs/sun3_defconfig     | 2 +-
 arch/m68k/configs/sun3x_defconfig    | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 4383ed85106335fd..6deb8faa564bc667 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -591,7 +591,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -635,6 +634,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index ec0f9c9f9562147b..802c161827f4ceba 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -548,7 +548,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -591,6 +590,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 4b86bb6498ed4bbb..4212c365e93d1899 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -579,7 +579,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -623,6 +622,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 496fb6a415eaf7da..b13552caa6b39864 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -540,7 +540,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -583,6 +582,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 4add7ab9973b1497..f88356c45440c825 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -550,7 +550,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -593,6 +592,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 5845f1f71fd11cd2..7c2ebb616fbad24e 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -570,7 +570,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -614,6 +613,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index bbb251bab81addfe..d3b272910b38e712 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -656,7 +656,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -700,6 +699,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 4f9cfc70c66dbe43..4529bc4b843ca0dd 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -539,7 +539,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -582,6 +581,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 67c42b4822f02688..30824032e4d58abe 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -540,7 +540,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -583,6 +582,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 85f19515200bee21..3911211410eda118 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -557,7 +557,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -601,6 +600,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index b1b15acb5d5fb3db..991730c50957eb2f 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -538,7 +538,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -580,6 +579,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 91d66c0f5ab6c484..e80d7509ab1d28b6 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -538,7 +538,6 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -581,6 +580,7 @@ CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
+CONFIG_TEST_MAPLE_TREE=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
-- 
2.34.1

