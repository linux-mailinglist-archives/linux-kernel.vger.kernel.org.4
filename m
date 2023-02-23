Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336BE6A0061
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjBWBBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjBWBBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:01:47 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3233457CD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:01:19 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1B3AD320096B;
        Wed, 22 Feb 2023 20:00:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 Feb 2023 20:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677114047; x=1677200447; bh=8w
        bNMyZnISCfO1mMbTqlAIpy0KE2iUlCV9dvjVVG0sI=; b=me3VVymSQYGlnUJBl7
        /Q+qD8IIxwu5+niSqwjWfz47yhSNMbLs7zOWa9yALn+r4RbpqJznVajXPtfSLX0E
        TIvYPBxmMWeUkChuNaW2u/GV9zshXBGtCCv2T0GTDPT1cXhQukXjHN9+JYOOvgdO
        NinVw+hvtCPbeF7nVHkSMHCWZ08sdEwSsoWNHdeKzosJqaXldSxX5XfxOxN4rzJ5
        5OE6QeJQqMu4Ci5bZbprD4pQOcxuhz1BuZI1ap73Rfk6KltNMF6f5Uy196B9Fgzk
        y2QB15p0Ox3mVfp9QtBmSIxUUrNooMB/1G6xFE+0KCHw5uuhp8W0Bju5bK37szA7
        kCYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677114047; x=1677200447; bh=8wbNMyZnISCfO
        1mMbTqlAIpy0KE2iUlCV9dvjVVG0sI=; b=FsZ5oRFxbyL3BsWg3SFkiC61nMvnp
        siLHawikSuarCK1s9blBsp1hjflGTwxqSe1A2CczHFYb9lo3oA2Su6b2lYAPFxng
        8ptdSDLAKTQsNVQT/vOqvGdUgn1W0ql1ux/nHZQmVZala/4SmlY4RBSg533wb9UI
        QLaNPTO1K/MOZdhHtI3l+N0YsQ5mOoChyKNJk8w0L4z+m955h15oxGCiEo0XKUMB
        WDw4QRHP1irQ+8R1rdYdUEseTJJQOBXHN/uwdzZQvuhgLxGKCJMb2SAiiCwZvi0k
        se4JufmQsldlbOekYmluVnPwGUaCvfBZeHxlYW+WfnmUtGi5M5qIgtAVA==
X-ME-Sender: <xms:v7r2Y3boNoiNGjOTBFVv7hXjBV9J5AD16qeihLqH7jXcVGkpmN1fzw>
    <xme:v7r2Y2Ya-TxkOuXxBZCerQdXMpWpXibOS7z--QgiUxVFFoNqO1sgv6zyZALCni16D
    mdXsmR8KKLDk_HlD-o>
X-ME-Received: <xmr:v7r2Y585MIXzB2JGteIFH7kIjbMU__uqjCt7RinaBqfJvJO_k9bPBHuVjifc3mfQykb7xBlGaB0jIc7JpNG29sYdNW0Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudektddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeggihhntggvnhhtucffrghgohhnnhgvrghuuceovhesvhgu
    rgdrihhoqeenucggtffrrghtthgvrhhnpedujedtgefgtdelffefjeeggffgiefgjeevve
    dtjefhuddvleeiudetuedtffefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehvsehvuggrrdhioh
X-ME-Proxy: <xmx:v7r2Y9rOxE7jGSRfvzBTxIuvBm_7_mRXYtUpB9rHlu6EEzzBEcv0Gg>
    <xmx:v7r2Yyqz31S8M6JrF3I1Henwi2_e_GbTVt0kwnY4TVvs7mwOathyvw>
    <xmx:v7r2YzSh1TUGu6yqdw_Xj7fynfHPd36kUtJtPpzLoaw25gax01xxDA>
    <xmx:v7r2Y3Abscoit2IOhbrAX_6L2fMM1NptfRBN9i44PLY_LW_B6T2iyA>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 20:00:47 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v6 3/4] tools/nolibc: enlarge column width of tests
Date:   Wed, 22 Feb 2023 20:00:24 -0500
Message-Id: <20230223010025.11092-4-v@vda.io>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223010025.11092-1-v@vda.io>
References: <20230223010025.11092-1-v@vda.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enlarges the column width from 40 to 64 characters to make
room for longer tests

Signed-off-by: Vincent Dagonneau <v@vda.io>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 96 ++++++++++----------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index c4a0c915139c..882140508d56 100644
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
-- 
2.39.2

