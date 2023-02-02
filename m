Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589E0688816
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjBBULd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjBBUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:11:29 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6461F22038
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:11:26 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4306332004E7;
        Thu,  2 Feb 2023 15:11:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 02 Feb 2023 15:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1675368681; x=1675455081; bh=5QKmTQkR+AFpznKBLVT37Vvp+
        IBJ3iZ2NtViLwNEKHc=; b=CNu2yyPiOK5ARMvRiv433wbRrfbZ/0vH2gtAKDq01
        /17RZdE0vEZXnYU3E6ODqg4+ZCFsoelQtsTUytJ3yC5IUYe6IKVpPf6VszNWLp3w
        bqRSAEOUXoKja7UmBkGJQGKLU2D9929biYEli9LLiDUr6/slacI/Hz8M9KG5VzaR
        +Lb5ofNI2wjRTgEUUSpYbAmFfuFqlzkQYM+328K9CGwPwqT3jdxoh8cecCXLyBzA
        5pUt+qbBLUKDRmcLpsDwD3o/ew/Zccv8n7OA0BPmKuuu2SxA+PtRb/0iH8m1Mu0S
        ewjycKwU2GNqZXOuvQvjHA6aUYrWByPA8TTvqLpD5abkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1675368681; x=1675455081; bh=5QKmTQkR+AFpznKBLVT37Vvp+IBJ3iZ2NtV
        iLwNEKHc=; b=QMh1DkofQc8QtzrJKMDXYayiQgZVgV0xeugJLFMDJUkOAvg0E8h
        9pJe7VDtkP9mVN/21tlHcaCvQmKQS0Ec+0rMW7UeFVJT14XlZqv1lddl9kduIRnw
        5mlHYRN3Q0Id7rBrPfnWv2SHm9MvBoWLjqjDW7dYnC9sQokAHs/mSSig/VSOxyWk
        lL6DvaVPtVBrPZYhPER3wjs9hMirTsxcAzrKnX2GAjGXZ9ZrTIl7CPRl7nxeZdGt
        iaOMpHXd2cLNLLCrPV5I1EsoCuXflEbNCCvZ6G2iHeUcIVytdljKiwdUhJ7uThoO
        eKS9DC/exh+7xFYdKuzaYvMYrYvmp0vsQcg==
X-ME-Sender: <xms:6RjcY0gbaxfue1GTOJgAjQZCS0E559hhPCVMk1YgLPIF5dUrzgOypA>
    <xme:6RjcY9BpcxEYWxAECvZjX975FaWGihplTmbyyA2Hux0kcHv_HXV_Uq5wrIfzSCLwO
    zrvNfiBinSHJUajlZQ>
X-ME-Received: <xmr:6RjcY8FFVQL8YTLFiCaXmUt8H3z5_Ij2g9figT-6Mb1uk4glZiJdu8W86Yp6APN8jrdIgyOm9RJ8SwuwCHqaLM7WTGgf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehvuggr
    rdhioheqnecuggftrfgrthhtvghrnhepieefhfeiieduueffueekhfettdffgeevleekfe
    fftdfhfeektdehgfejueeluddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepvhesvhgurgdrihho
X-ME-Proxy: <xmx:6RjcY1SFyYuIASDtkUpFAhT4m4ibqVjk__7Q-Yo3Cs-Gpgz4xpDt6g>
    <xmx:6RjcYxwBS5Cm5jWEBw-LZdqI4WdDBI0KuI_7ZMu00z1-wXzcDQi95A>
    <xmx:6RjcYz49paEmiqwUcoAb6Fqv-EXI32pOwPBo6iuCUVGrQ4XHtFrw2w>
    <xmx:6RjcYypnRLulI8nv-AC4O3FIs0XFk173Ub852FXZfIzVSh3KCNdxQw>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Feb 2023 15:11:21 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v2] tools/nolibc: Add stdint.h
Date:   Thu,  2 Feb 2023 15:11:01 -0500
Message-Id: <20230202201101.43160-1-v@vda.io>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2, thank you Thomas for the reply. This version hopefully
addresses the comments you made. I also added some rough tests for the
limits.

Add stdint.h and moved the relevant definitions from std.h. Also added
macros for limits and *_least_* types. Adds tests for the integer
limits.
---
 tools/include/nolibc/Makefile                |   4 +-
 tools/include/nolibc/std.h                   |  15 +--
 tools/include/nolibc/stdint.h                |  84 +++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 125 ++++++++++++-------
 4 files changed, 164 insertions(+), 64 deletions(-)
 create mode 100644 tools/include/nolibc/stdint.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index cfd06764b5ae..ec57d3932506 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -25,8 +25,8 @@ endif
 
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
-all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
-             sys.h time.h types.h unistd.h
+all_files := ctype.h errno.h nolibc.h signal.h std.h stdint.h stdio.h stdlib.h \
+             string.h sys.h time.h types.h unistd.h
 
 # install all headers needed to support a bare-metal compiler
 all: headers
diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 1747ae125392..933bc0be7e1c 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -18,20 +18,7 @@
 #define NULL ((void *)0)
 #endif
 
-/* stdint types */
-typedef unsigned char       uint8_t;
-typedef   signed char        int8_t;
-typedef unsigned short     uint16_t;
-typedef   signed short      int16_t;
-typedef unsigned int       uint32_t;
-typedef   signed int        int32_t;
-typedef unsigned long long uint64_t;
-typedef   signed long long  int64_t;
-typedef unsigned long        size_t;
-typedef   signed long       ssize_t;
-typedef unsigned long     uintptr_t;
-typedef   signed long      intptr_t;
-typedef   signed long     ptrdiff_t;
+#include "stdint.h"
 
 /* those are commonly provided by sys/types.h */
 typedef unsigned int          dev_t;
diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
new file mode 100644
index 000000000000..a545cb9f6fe8
--- /dev/null
+++ b/tools/include/nolibc/stdint.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Standard definitions and types for NOLIBC
+ * Copyright (C) 2023 Vincent Dagonneau <v@vda.io>
+ */
+
+#ifndef _NOLIBC_STDINT_H
+#define _NOLIBC_STDINT_H
+
+typedef unsigned char       uint8_t;
+typedef   signed char        int8_t;
+typedef unsigned short     uint16_t;
+typedef   signed short      int16_t;
+typedef unsigned int       uint32_t;
+typedef   signed int        int32_t;
+typedef unsigned long long uint64_t;
+typedef   signed long long  int64_t;
+typedef unsigned long        size_t;
+typedef   signed long       ssize_t;
+typedef unsigned long     uintptr_t;
+typedef   signed long      intptr_t;
+typedef   signed long     ptrdiff_t;
+
+typedef   int8_t       int_least8_t;
+typedef  uint8_t      uint_least8_t;
+typedef  int16_t      int_least16_t;
+typedef uint16_t     uint_least16_t;
+typedef  int32_t      int_least32_t;
+typedef uint32_t     uint_least32_t;
+typedef  int64_t      int_least64_t;
+typedef uint64_t     uint_least64_t;
+
+typedef  int64_t           intmax_t;
+typedef uint64_t          uintmax_t;
+
+/* limits of integral types */
+
+#define        INT8_MIN  (-128)
+#define       INT16_MIN  (-32767-1)
+#define       INT32_MIN  (-2147483647-1)
+#define       INT64_MIN  (-9223372036854775807-1)
+
+#define        INT8_MAX  (127)
+#define       INT16_MAX  (32767)
+#define       INT32_MAX  (2147483647)
+#define       INT64_MAX  (9223372036854775807)
+
+#define       UINT8_MAX  (255)
+#define      UINT16_MAX  (65535)
+#define      UINT32_MAX  (4294967295U)
+#define      UINT64_MAX  (18446744073709551615)
+
+#define  INT_LEAST8_MIN  INT8_MIN
+#define INT_LEAST16_MIN  INT16_MIN
+#define INT_LEAST32_MIN  INT32_MIN
+#define INT_LEAST64_MIN  INT64_MIN
+
+#define  INT_LEAST8_MAX  INT8_MAX
+#define INT_LEAST16_MAX  INT16_MAX
+#define INT_LEAST32_MAX  INT32_MAX
+#define INT_LEAST64_MAX  INT64_MAX
+
+#define  UINT_LEAST8_MAX UINT8_MAX
+#define UINT_LEAST16_MAX UINT16_MAX
+#define UINT_LEAST32_MAX UINT32_MAX
+#define UINT_LEAST64_MAX UINT64_MAX
+
+#define         SIZE_MAX UINT64_MAX
+
+#if __WORDSIZE == 64
+  #define       INTPTR_MIN  INT64_MIN
+  #define       INTPTR_MAX  INT64_MAX
+  #define      UINTPTR_MAX  UINT64_MAX
+  #define      PTRDIFF_MIN  INT64_MIN
+  #define      PTRDIFF_MAX  INT64_MAX
+#else
+  #define       INTPTR_MIN  INT32_MIN
+  #define       INTPTR_MAX  INT32_MAX
+  #define      UINTPTR_MAX  UINT32_MAX
+  #define      PTRDIFF_MIN  INT32_MIN
+  #define      PTRDIFF_MAX  INT32_MAX
+#endif /* __WORDSIZE == 64 */
+
+#endif /* _NOLIBC_STDINT_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index f14f5076fb6d..0c7698d2a4b7 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -130,111 +130,111 @@ static int pad_spc(int llen, int cnt, const char *fmt, ...)
  */
 
 #define EXPECT_ZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_zr(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_zr(expr, llen); } while (0)
 
 static int expect_zr(int expr, int llen)
 {
 	int ret = !(expr == 0);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_NZ(cond, expr, val)			\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_nz(expr, llen; } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_nz(expr, llen; } while (0)
 
 static int expect_nz(int expr, int llen)
 {
 	int ret = !(expr != 0);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_EQ(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_eq(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_eq(expr, llen, val); } while (0)
 
-static int expect_eq(int expr, int llen, int val)
+static int expect_eq(uint64_t expr, int llen, uint64_t val)
 {
 	int ret = !(expr == val);
 
-	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	llen += printf(" = %lld ", expr);
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_NE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ne(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ne(expr, llen, val); } while (0)
 
 static int expect_ne(int expr, int llen, int val)
 {
 	int ret = !(expr != val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_GE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ge(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ge(expr, llen, val); } while (0)
 
 static int expect_ge(int expr, int llen, int val)
 {
 	int ret = !(expr >= val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_GT(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_gt(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_gt(expr, llen, val); } while (0)
 
 static int expect_gt(int expr, int llen, int val)
 {
 	int ret = !(expr > val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_LE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_le(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_le(expr, llen, val); } while (0)
 
 static int expect_le(int expr, int llen, int val)
 {
 	int ret = !(expr <= val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_LT(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_lt(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_lt(expr, llen, val); } while (0)
 
 static int expect_lt(int expr, int llen, int val)
 {
 	int ret = !(expr < val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_SYSZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syszr(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syszr(expr, llen); } while (0)
 
 static int expect_syszr(int expr, int llen)
 {
@@ -243,17 +243,17 @@ static int expect_syszr(int expr, int llen)
 	if (expr) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
 		llen += printf(" = %d ", expr);
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_SYSEQ(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syseq(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syseq(expr, llen, val); } while (0)
 
 static int expect_syseq(int expr, int llen, int val)
 {
@@ -262,17 +262,17 @@ static int expect_syseq(int expr, int llen, int val)
 	if (expr != val) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
 		llen += printf(" = %d ", expr);
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_SYSNE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_sysne(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_sysne(expr, llen, val); } while (0)
 
 static int expect_sysne(int expr, int llen, int val)
 {
@@ -281,17 +281,17 @@ static int expect_sysne(int expr, int llen, int val)
 	if (expr == val) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
 		llen += printf(" = %d ", expr);
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_SYSER(cond, expr, expret, experr)			\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syserr(expr, expret, experr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr(expr, expret, experr, llen); } while (0)
 
 static int expect_syserr(int expr, int expret, int experr, int llen)
 {
@@ -302,16 +302,16 @@ static int expect_syserr(int expr, int expret, int experr, int llen)
 	if (expr != expret || _errno != experr) {
 		ret = 1;
 		llen += printf(" != (%d %s) ", expret, errorname(experr));
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_PTRZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ptrzr(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrzr(expr, llen); } while (0)
 
 static int expect_ptrzr(const void *expr, int llen)
 {
@@ -320,16 +320,16 @@ static int expect_ptrzr(const void *expr, int llen)
 	llen += printf(" = <%p> ", expr);
 	if (expr) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_PTRNZ(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ptrnz(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrnz(expr, llen); } while (0)
 
 static int expect_ptrnz(const void *expr, int llen)
 {
@@ -338,16 +338,16 @@ static int expect_ptrnz(const void *expr, int llen)
 	llen += printf(" = <%p> ", expr);
 	if (!expr) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_STRZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strzr(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strzr(expr, llen); } while (0)
 
 static int expect_strzr(const char *expr, int llen)
 {
@@ -356,16 +356,16 @@ static int expect_strzr(const char *expr, int llen)
 	llen += printf(" = <%s> ", expr);
 	if (expr) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_STRNZ(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strnz(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strnz(expr, llen); } while (0)
 
 static int expect_strnz(const char *expr, int llen)
 {
@@ -374,16 +374,16 @@ static int expect_strnz(const char *expr, int llen)
 	llen += printf(" = <%s> ", expr);
 	if (!expr) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_STREQ(cond, expr, cmp)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_streq(expr, llen, cmp); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_streq(expr, llen, cmp); } while (0)
 
 static int expect_streq(const char *expr, int llen, const char *cmp)
 {
@@ -392,16 +392,16 @@ static int expect_streq(const char *expr, int llen, const char *cmp)
 	llen += printf(" = <%s> ", expr);
 	if (strcmp(expr, cmp) != 0) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_STRNE(cond, expr, cmp)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strne(expr, llen, cmp); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strne(expr, llen, cmp); } while (0)
 
 static int expect_strne(const char *expr, int llen, const char *cmp)
 {
@@ -410,9 +410,9 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 	llen += printf(" = <%s> ", expr);
 	if (strcmp(expr, cmp) == 0) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
@@ -531,6 +531,35 @@ int run_syscall(int min, int max)
 		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
+		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,   (int8_t)   0x7f); break;
+		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,   (int8_t)   0x80); break;
+		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,  (uint8_t)  0xff); break;
+		CASE_TEST(limit_int16_max);         EXPECT_EQ(1, INT16_MAX,  (int16_t)  0x7fff); break;
+		CASE_TEST(limit_int16_min);         EXPECT_EQ(1, INT16_MIN,  (int16_t)  0x8000); break;
+		CASE_TEST(limit_uint16_max);        EXPECT_EQ(1, UINT16_MAX, (uint16_t) 0xffff); break;
+		CASE_TEST(limit_int32_max);         EXPECT_EQ(1, INT32_MAX,  (int32_t)  0x7fffffff); break;
+		CASE_TEST(limit_int32_min);         EXPECT_EQ(1, INT32_MIN,  (int32_t)  0x80000000); break;
+		CASE_TEST(limit_uint32_max);        EXPECT_EQ(1, UINT32_MAX, (uint32_t) 0xffffffff); break;
+		CASE_TEST(limit_int64_max);         EXPECT_EQ(1, INT64_MAX,  (int64_t)  0x7fffffffffffffff); break;
+		CASE_TEST(limit_int64_min);         EXPECT_EQ(1, INT64_MIN,  (int64_t)  0x8000000000000000); break;
+		CASE_TEST(limit_uint64_max);        EXPECT_EQ(1, UINT64_MAX, (uint64_t) 0xffffffffffffffff); break;
+		CASE_TEST(limit_int_least8_max);    EXPECT_EQ(1, INT_LEAST8_MAX,   (int_least8_t)    0x7f); break;
+		CASE_TEST(limit_int_least8_min);    EXPECT_EQ(1, INT_LEAST8_MIN,   (int_least8_t)    0x80); break;
+		CASE_TEST(limit_uint_least8_max);   EXPECT_EQ(1, UINT_LEAST8_MAX,  (uint_least8_t)   0xff); break;
+		CASE_TEST(limit_int_least16_max);   EXPECT_EQ(1, INT_LEAST16_MAX,  (int_least16_t)   0x7fff); break;
+		CASE_TEST(limit_int_least16_min);   EXPECT_EQ(1, INT_LEAST16_MIN,  (int_least16_t)   0x8000); break;
+		CASE_TEST(limit_uint_least16_max);  EXPECT_EQ(1, UINT_LEAST16_MAX, (uint_least16_t)  0xffff); break;
+		CASE_TEST(limit_int_least32_max);   EXPECT_EQ(1, INT_LEAST32_MAX,  (int_least32_t)   0x7fffffff); break;
+		CASE_TEST(limit_int_least32_min);   EXPECT_EQ(1, INT_LEAST32_MIN,  (int_least32_t)   0x80000000); break;
+		CASE_TEST(limit_uint_least32_max);  EXPECT_EQ(1, UINT_LEAST32_MAX, (uint_least32_t)  0xffffffff); break;
+		CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffff); break;
+		CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000); break;
+		CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffff); break;
+		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (void*) 0x8000000000000000); break;
+		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX, (void*) 0x7fffffffffffffff); break;
+		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (void*) 0xffffffffffffffff); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN,  (void*) 0x8000000000000000); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (void*) 0x7fffffffffffffff); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.39.1

