Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E873D6A50F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjB1CMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjB1CME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:12:04 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617E628D3A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:11:58 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 741C63200938;
        Mon, 27 Feb 2023 21:11:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 27 Feb 2023 21:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677550317; x=
        1677636717; bh=iJA+tbnJpHOZodErxoprnz7vNzQ+DFpW5yiTQIbvqic=; b=w
        hMkyI34yDIvvb8vrnea0YnN48VxxDswiTUiVE7SI0Nc0qnnnDHuZD+VVSc+lnEn/
        B9agUCgk8E6ZoOGM0y4icNwexwOf0NrAU9Ug6bCHrsK4lhlgB+pr8Gh5DQ59gNiu
        CM0Qexefi2ltm8gtu8MXqEmkvBldd3nFjU5FM2JeI6jOrpCQdA70gqjUWDQFhCUg
        0N6v7Ge5Q02sR5eOBGWXjlJgh7ofKgmnDe9co9VH3yH1MXRfpy9GG5OPCifWUBoE
        7fPF67bsjlWwDpL+cU1BSSXwFKrCoSNGY4xnuf4bGRDTrmTC92LKvHS8QnxJNtaD
        BQ2I2qGl9rieXoOA+G/oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677550317; x=
        1677636717; bh=iJA+tbnJpHOZodErxoprnz7vNzQ+DFpW5yiTQIbvqic=; b=S
        /N7qbLp2tqCV6IYDBXnWJpJS8StzzxS84bE2SShiTEPH4r2O7zhGbcGfL4nJ9DpR
        58IJeXf4LBqSNF6Zoom4amaFWqfD1dVpE46t0+VGkfZ97kaRIvp1OLxhlmus/R25
        0M1Z0JPpUQAn5/IZjH9Nbv8tYFtrqNsAR8dUCCJHjtP52HuXCguXguF9RpxVW+Q0
        7EA4XUZ3GLR10GsvbhqbvhDGD40WWLzmqGVlgAYIcYBvDs9BwkmO7wW9GAYZLLXr
        ENqHVJW7A9P1l0d6n+nexzsNFBm5pJdZAWJkV4hcBSmBocOnGAowAMJxeDx4/URF
        Xg3APL3/N9TQTPUfmPFDg==
X-ME-Sender: <xms:7GL9YxSDFjWTxoUdiHP996fEsQ_u9kK6UqSXpNHBG0lyMS28PJNWVQ>
    <xme:7GL9Y6zjv0r0yexfCnfXXOErK2_Ek-4F6cMOmWLeR9lEtlNMpjZ0lNxSfRnL6STNh
    U3WMK3sRTdVEvK0bU8>
X-ME-Received: <xmr:7GL9Y23QMDzQBBL4uvgC-hkWLcavzbZBHY5oSXJWrq8CSVci9dddojeu0IvR4F8qhFhrK-tqfqgf9F3jvnSTB6ELgDmB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeluddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehv
    uggrrdhioheqnecuggftrfgrthhtvghrnhepheehleelhedvteegtdeiteejleeigfelvd
    eigfetueegjeevteevudeivdekhfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepvhesvhgurgdrihho
X-ME-Proxy: <xmx:7GL9Y5AYamulra3WbPow0-LQjuiubBVV2PbE_Vxs2kynwhnVT-h97Q>
    <xmx:7GL9Y6iZQc_6dxA4o5WwKON8FNDjYTx95pxwq4iABbIvxhDd0zp_Ww>
    <xmx:7GL9Y9r4wQb7RTHSAR2_ruUJb8hOEFje0gKf9zxkXW9Nvx7OEaS4Ew>
    <xmx:7WL9Y7vfuptb4C0t3okKO_6MK1gKf12482voChXmNe6nKq6OyArW7w>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 21:11:56 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, thomas@t-8ch.de, Vincent Dagonneau <v@vda.io>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v7 3/4] tools/nolibc: enlarge column width of tests
Date:   Mon, 27 Feb 2023 21:11:35 -0500
Message-Id: <20230228021136.13472-4-v@vda.io>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228021136.13472-1-v@vda.io>
References: <20230228021136.13472-1-v@vda.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This commit enlarges the column width from 40 to 64 characters to make
room for longer tests

Signed-off-by: Vincent Dagonneau <v@vda.io>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
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

