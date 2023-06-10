Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA00972AEC0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjFJUlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjFJUlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:41:05 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D75E3A95;
        Sat, 10 Jun 2023 13:41:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 63B4D32002FB;
        Sat, 10 Jun 2023 16:41:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 10 Jun 2023 16:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1686429660; x=1686516060; bh=tkhWvOlsbY
        MyYMCWf0V3VF+4w52gXb91yX2wRN70iV0=; b=Lh/og//xp/BCWCig7r4f2A8SUF
        3oarkTM30JMoLkzLi0xdKUUMJQ9KDDuZZ38ZrwY55FU/1d/kZ4i44GPb2LDf5XKO
        q0YFjjoLoFZ5eOa1U/bMhHdBEXjPdsetVPNzkv3h2SdrDBclUsqQNUk/ozRpCkVg
        fUU3a05AhzC87RgtuRWJJRnX5RMSBwFBadBbIRwxDWWs20xgbfETGTa487+7+c4u
        lG4L6+ZwfW1sQC0v09gJfz962OIDZWjnUcHygReTt0MMFNVd7KdQD1hQSCN1EzR2
        Mu8Bzdmfq7u8SPi37xpSAYUVhlqr6HmNmAQvC7rwG3QiN27F2o2lh6ur3Q0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1686429660; x=
        1686516060; bh=tkhWvOlsbYMyYMCWf0V3VF+4w52gXb91yX2wRN70iV0=; b=J
        nX9TWIoRt1Ec8P0vvvS+PPT1A30VmkPvpi61/EUuGHHRCUwU0Pd8wtmePd9PepF0
        W+VEwi+aB4nIgGQosPaz9tLnM/huWPoiDHuFORHAX+jnU2cwH4Z57JSkN+fu8qzV
        Q04OOp5k7nOdONfuk+X/TwB31DnqyluTSEIEjnauFz0ID3vD0U64DhFfotPRWUog
        9p+GZM5ZgP9WdjLKvEdeHqUK7mx0S8ISiwB0aTSAamPTHH/GeOL4zLmT6ZkzjvVO
        vh8HP/ffbcTAS10FLO1GojIncdaRRNnAXpVwoUBgN6DqwAnMVc0qQ7mDwFilHtlx
        gmDTB8dInguobLCDLIXBg==
X-ME-Sender: <xms:29-EZGsYz9No_XyLkMofGl6B5ewGQh6ZCzpmt7TMGZDJWckMln2tQw>
    <xme:29-EZLejt9NxFKY7xFcvB7P9DH_jLIpbOJfk28o5zIkjGnf29H3STmyBOmbB6u01o
    IrDxmpM3FJsPO8>
X-ME-Received: <xmr:29-EZBx3W7jwwq-sjOxKn-aB1YV_WUNPZn_uF5LuB90aqQ7n-JTx-KvFBVZ1GRzom2VsUmsfjMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedutddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:29-EZBNLqAZnHWpmVPFflh2UkefJa3h04gzxXPFBZhRZIl6XjmqTIw>
    <xmx:29-EZG_N4vQvghnYaJPrBQUhgkZOq_S9FKWLLD_k1NBBVAPj_Thn0A>
    <xmx:29-EZJXOXS5_lt2Nh1CSm3y0wI6B5URjnJHw8ZU95cOh5nyooeaYBQ>
    <xmx:3N-EZJgfLbLEXEohkNOtnLaN0dqwS0dfpF7Sxk4Aw3SyHj-pTxvpNg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jun 2023 16:40:58 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3 2/4] vsscanf(): Integer overflow is a conversion failure
Date:   Sat, 10 Jun 2023 16:40:42 -0400
Message-Id: <20230610204044.3653-3-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610204044.3653-1-demi@invisiblethingslab.com>
References: <20230610204044.3653-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sscanf() and friends currently ignore integer overflow, but this is a
bad idea.  It is much better to detect integer overflow errors and
consider this a conversion failure.

This implements Linus's suggestion of using '!' to treat integer
overflow as wrapping.  It does _not_ allow wrapping of unsigned
conversions by default, though, as in at least some cases accepting
negative numbers is _not_ intended.

Suggested-By: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 lib/vsprintf.c | 90 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 21 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 40f560959b169b4c4ac6154d658cfe76cfd0c5a6..9e53355c35b1d6260631868228ede1d178fe3325 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -59,7 +59,7 @@
 bool no_hash_pointers __ro_after_init;
 EXPORT_SYMBOL_GPL(no_hash_pointers);
 
-static noinline unsigned long long simple_strntoull(const char *startp, size_t max_chars, char **endp, unsigned int base)
+static noinline unsigned long long simple_strntoull(const char *startp, size_t max_chars, char **endp, unsigned int base, bool *overflow)
 {
 	const char *cp;
 	unsigned long long result = 0ULL;
@@ -70,11 +70,13 @@ static noinline unsigned long long simple_strntoull(const char *startp, size_t m
 	prefix_chars = cp - startp;
 	if (prefix_chars < max_chars) {
 		rv = _parse_integer_limit(cp, base, &result, max_chars - prefix_chars);
-		/* FIXME */
+		*overflow = !!(rv & KSTRTOX_OVERFLOW);
 		cp += (rv & ~KSTRTOX_OVERFLOW);
 	} else {
 		/* Field too short for prefix + digit, skip over without converting */
 		cp = startp + max_chars;
+		/* Treat this as a conversion failure */
+		*overflow = true;
 	}
 
 	if (endp)
@@ -94,7 +96,9 @@ static noinline unsigned long long simple_strntoull(const char *startp, size_t m
 noinline
 unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
 {
-	return simple_strntoull(cp, INT_MAX, endp, base);
+	bool _placeholder;
+
+	return simple_strntoull(cp, INT_MAX, endp, base, &_placeholder);
 }
 EXPORT_SYMBOL(simple_strtoull);
 
@@ -130,18 +134,22 @@ long simple_strtol(const char *cp, char **endp, unsigned int base)
 EXPORT_SYMBOL(simple_strtol);
 
 static long long simple_strntoll(const char *cp, size_t max_chars, char **endp,
-				 unsigned int base)
+				 unsigned int base, bool *overflow)
 {
+	unsigned long long minand;
+	bool negate;
+
 	/*
 	 * simple_strntoull() safely handles receiving max_chars==0 in the
 	 * case cp[0] == '-' && max_chars == 1.
 	 * If max_chars == 0 we can drop through and pass it to simple_strntoull()
 	 * and the content of *cp is irrelevant.
 	 */
-	if (*cp == '-' && max_chars > 0)
-		return -simple_strntoull(cp + 1, max_chars - 1, endp, base);
-
-	return simple_strntoull(cp, max_chars, endp, base);
+	negate = *cp == '-' && max_chars > 0;
+	minand = simple_strntoull(cp + negate, max_chars - negate, endp, base, overflow);
+	if (minand > (unsigned long long)LONG_MAX + negate)
+		*overflow = true;
+	return negate ? -minand : minand;
 }
 
 /**
@@ -154,7 +162,9 @@ static long long simple_strntoll(const char *cp, size_t max_chars, char **endp,
  */
 long long simple_strtoll(const char *cp, char **endp, unsigned int base)
 {
-	return simple_strntoll(cp, INT_MAX, endp, base);
+	bool _placeholder;
+
+	return simple_strntoll(cp, INT_MAX, endp, base, &_placeholder);
 }
 EXPORT_SYMBOL(simple_strtoll);
 
@@ -3441,7 +3451,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		unsigned long long u;
 	} val;
 	s16 field_width;
-	bool is_sign;
+	bool is_sign, overflow, allow_overflow;
 
 	while (*fmt) {
 		/* skip any white space in format */
@@ -3464,6 +3474,9 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			break;
 		++fmt;
 
+		allow_overflow = *fmt == '!';
+		fmt += (int)allow_overflow;
+
 		/* skip this conversion.
 		 * advance both strings to next white space
 		 */
@@ -3649,45 +3662,80 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		if (is_sign)
 			val.s = simple_strntoll(str,
 						field_width >= 0 ? field_width : INT_MAX,
-						&next, base);
+						&next, base, &overflow);
 		else
 			val.u = simple_strntoull(str,
 						 field_width >= 0 ? field_width : INT_MAX,
-						 &next, base);
+						 &next, base, &overflow);
+		if (unlikely(overflow) && !allow_overflow)
+			break;
 
 		switch (qualifier) {
 		case 'H':	/* that's 'hh' in format */
-			if (is_sign)
+			if (is_sign) {
+				if (unlikely(val.s < SCHAR_MIN || val.s > SCHAR_MAX) &&
+				    !allow_overflow)
+					return num;
 				*va_arg(args, signed char *) = val.s;
-			else
+			} else {
+				if (unlikely(val.u > UCHAR_MAX) && !allow_overflow)
+					return num;
 				*va_arg(args, unsigned char *) = val.u;
+			}
 			break;
 		case 'h':
-			if (is_sign)
+			if (is_sign) {
+				if (unlikely(val.s < SHRT_MIN || val.s > SHRT_MAX) &&
+				    !allow_overflow)
+					return num;
 				*va_arg(args, short *) = val.s;
-			else
+			} else {
+				if (unlikely(val.u > USHRT_MAX) && !allow_overflow)
+					return num;
 				*va_arg(args, unsigned short *) = val.u;
+			}
 			break;
 		case 'l':
-			if (is_sign)
+			if (is_sign) {
+				if (unlikely(val.s < LONG_MIN || val.s > LONG_MAX) &&
+				    !allow_overflow)
+					return num;
 				*va_arg(args, long *) = val.s;
-			else
+			} else {
+				if (unlikely(val.u > ULONG_MAX) && !allow_overflow)
+					return num;
 				*va_arg(args, unsigned long *) = val.u;
+			}
 			break;
 		case 'L':
+			/* No overflow check needed */
 			if (is_sign)
 				*va_arg(args, long long *) = val.s;
 			else
 				*va_arg(args, unsigned long long *) = val.u;
 			break;
 		case 'z':
-			*va_arg(args, size_t *) = val.u;
+			if (is_sign) {
+				if (unlikely(val.s < SSIZE_MIN || val.s > SSIZE_MAX))
+					return num;
+				*va_arg(args, ssize_t *) = val.s;
+			} else {
+				if (unlikely(val.u > SIZE_MAX) && !allow_overflow)
+					return num;
+				*va_arg(args, size_t *) = val.u;
+			}
 			break;
 		default:
-			if (is_sign)
+			if (is_sign) {
+				if (unlikely(val.s < INT_MIN || val.s > INT_MAX) &&
+				    !allow_overflow)
+					return num;
 				*va_arg(args, int *) = val.s;
-			else
+			} else {
+				if (unlikely(val.u > UINT_MAX) && !allow_overflow)
+					return num;
 				*va_arg(args, unsigned int *) = val.u;
+			}
 			break;
 		}
 		num++;
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

