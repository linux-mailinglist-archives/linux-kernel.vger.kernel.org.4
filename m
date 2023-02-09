Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5C68FD3A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjBIClb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjBIClM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:41:12 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEC429437
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:41:10 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BD05732005CA;
        Wed,  8 Feb 2023 21:41:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 08 Feb 2023 21:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1675910469; x=1675996869; bh=pz
        j8f5pUZIfMh5mbnrVywTrYp6D6qK4P3rUca7BuPow=; b=XzGk+S3P9l8WTcY9nv
        Gy9IFOEVT9w/n9y0JXGYEHz9nDt5sP+LON+u/95bDBw88edXpMn4CQfGSkF91bsS
        wSo4t3C2bsb4qrpcq4XANuYjoon+UH+yuSXUt0THYlcRFxUNIX9Yx68a4rzQmOms
        dlCAOzB3HBd6TghmyxuB2fKeQJU8kRlwe6D/pT6AhSpHRouB2BA0mXcNwiPWxAS7
        Ax2mlIWwCWasieTXHHIZ5d8FdvEY0LYMvGQAEaQzNYlI45eCLZWKQqsjMvNUyzef
        JTw5S9ICLOoduEtk4R5ry20SpwTf/7eTzAjgjpj0zzg2Ey6q2QDSsXROTk+Jxpq4
        OhSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1675910469; x=1675996869; bh=pzj8f5pUZIfMh
        5mbnrVywTrYp6D6qK4P3rUca7BuPow=; b=j/jNFfp09w/QYSDBIFxSFHTVmHooz
        8RdMIHuc6vBG8o8ZZW6ig0upwhr/sP2PoUBmt8RQi/8OUhKhZ8tlNBdxuCuTWqIY
        GzvT7r+fB1K99KlychIYYHGoxB+iZYlUfxfWrZ60AlSCH8GclXs0RgOvDG6mFDeS
        JQuDAXlICldrkNGOLCI8XYWIbVh2YrBHfpqPZeBgIQWHdSfF0tYVQu7EVD2WBgPg
        RAj2RGAF16L/DQtZ3Y42u3uxOed1tHlVHFj3Jjb8NDABz9LCBqCSqG4t7vSZDh5N
        Ke0ImugKZmXT6o+GoIRKWP10mNvmuLYWo9y7UUw3lIJIRKvh4OezR/dvw==
X-ME-Sender: <xms:RV3kYwnJm8g7vkGTbKvTaNn4ydS_BJbCvTC2otBBT5PadsYF0zHFJA>
    <xme:RV3kY_3KNMuXSu2Ym8gIYmwf1xBXW59xtJZPh-JUJDT44kuXUco_rXlT4q6-x9QDO
    rLJSLxR_CZoFy01STI>
X-ME-Received: <xmr:RV3kY-oTdnJ_iGFuZ-L461EmPrysbKHA6yxryiLD4fyL7sx1t_xA66dcr9iYdBmGxqjF3JNHjcZyBjAHoKvKTCeUY-H9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehv
    uggrrdhioheqnecuggftrfgrthhtvghrnhepudejtdeggfdtlefffeejgefggfeigfejve
    evtdejhfduvdelieduteeutdfffeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepvhesvhgurgdrihho
X-ME-Proxy: <xmx:RV3kY8kixl5vjjbZln8Cg4Xma5nKokpKiv3a2xfZU27s6t7UJj6mdw>
    <xmx:RV3kY-0pLfl1jFW-Lzoj5Kn8ZXOu1Zu1jJOe1AED7-tWVMZaKNswRQ>
    <xmx:RV3kYztkSFls4C3pRh4K1qjMSCaVidhMF5mzGw6K3Xqjz5ZUOY0NjA>
    <xmx:RV3kYz9eiUAkdc6llfq1ZgRC-RWvppNcTbccnZ_Qp1JMjdHiUjkmDg>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Feb 2023 21:41:08 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v4 3/4] tools/nolibc: Enlarging column width of tests
Date:   Wed,  8 Feb 2023 21:40:43 -0500
Message-Id: <20230209024044.13127-4-v@vda.io>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209024044.13127-1-v@vda.io>
References: <20230209024044.13127-1-v@vda.io>
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
---
 tools/testing/selftests/nolibc/nolibc-test.c | 96 ++++++++++----------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index f14f5076fb6d..725ee66d059c 100644
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
2.39.1

