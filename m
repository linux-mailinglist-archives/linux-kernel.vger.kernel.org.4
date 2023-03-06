Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5C06ABFD3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjCFMsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCFMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:48:45 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9D52597B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:48:42 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:b745:671d:a946:57fa])
        by xavier.telenet-ops.be with bizsmtp
        id V0og2900Q4LuvSS010ogci; Mon, 06 Mar 2023 13:48:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZAG8-00B5IY-4r;
        Mon, 06 Mar 2023 13:48:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZAGe-005B35-4g;
        Mon, 06 Mar 2023 13:48:40 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.3-rc1
Date:   Mon,  6 Mar 2023 13:48:37 +0100
Message-Id: <2b6d1357f4cb7e23bb2c7a7d39c4486e77e138ad.1678106848.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Drop CONFIG_IP_NF_TARGET_CLUSTERIP=m (removed in commit
    9db5d918e2c07fa0 ("netfilter: ip_tables: remove clusterip target")),
  - Enable modular build of the Kerberos V mechanism for Secure RPC
    (auto-builtin since commit dfe9a123451a6e73 ("SUNRPC: Enable
    rpcsec_gss_krb5.ko to be built without CRYPTO_DES")),
  - Enable modular build of the new Dhrystone benchmark test.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v6.4 branch.

 arch/m68k/configs/amiga_defconfig    | 3 ++-
 arch/m68k/configs/apollo_defconfig   | 3 ++-
 arch/m68k/configs/atari_defconfig    | 3 ++-
 arch/m68k/configs/bvme6000_defconfig | 3 ++-
 arch/m68k/configs/hp300_defconfig    | 3 ++-
 arch/m68k/configs/mac_defconfig      | 3 ++-
 arch/m68k/configs/multi_defconfig    | 3 ++-
 arch/m68k/configs/mvme147_defconfig  | 3 ++-
 arch/m68k/configs/mvme16x_defconfig  | 3 ++-
 arch/m68k/configs/q40_defconfig      | 3 ++-
 arch/m68k/configs/sun3_defconfig     | 3 ++-
 arch/m68k/configs/sun3x_defconfig    | 3 ++-
 12 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index ec2d792015a4bdd0..b26469a65bc11ed4 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -214,7 +214,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -495,6 +494,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -621,6 +621,7 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 061a07824dc29502..944a49a129bedab0 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -210,7 +210,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -452,6 +451,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -577,6 +577,7 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 79c49647e4818b7a..f3790c45cac722af 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -217,7 +217,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -483,6 +482,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -609,6 +609,7 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 0d5832cb3e10b9ce..23b7805309bd4407 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -207,7 +207,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -444,6 +443,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -569,6 +569,7 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index c246c3538839beb5..5605ab5c3dcfc25f 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -209,7 +209,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -454,6 +453,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -579,6 +579,7 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 98d2d0599e5a8f2c..d0d1f9c33756d795 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -208,7 +208,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -474,6 +473,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -600,6 +600,7 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index b2d5ec6ba625c7b2..2ff3fdb524f11b15 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -228,7 +228,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -561,6 +560,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -687,6 +687,7 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index d3420c642992b2e7..e6f5ae526d089339 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -206,7 +206,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -443,6 +442,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -568,6 +568,7 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index e294b0b67695069c..f2d4dff4787aade7 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -207,7 +207,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -444,6 +443,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -569,6 +569,7 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 764a94b089362003..907eedecd040262c 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -208,7 +208,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -461,6 +460,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -587,6 +587,7 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index d4eeddac6bb8de48..9e3d47008f218675 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -204,7 +204,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -443,6 +442,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -567,6 +567,7 @@ CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index ca359b8806830d56..f6540078cb4beb48 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -204,7 +204,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -442,6 +441,7 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
+CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
@@ -567,6 +567,7 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
+CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_DIV64=m
 CONFIG_REED_SOLOMON_TEST=m
-- 
2.34.1

