Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5B972AD92
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjFJRIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjFJRH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:07:59 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BA92D6B;
        Sat, 10 Jun 2023 10:07:55 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3EF1D5C00AE;
        Sat, 10 Jun 2023 13:07:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 10 Jun 2023 13:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1686416875; x=1686503275; bh=8eCukIyMRl
        PPOWu7IrDDF4KRgmkrU2LAmPtn5ch9l/I=; b=sF6GlBzD0nalUis8HFxJ3GFoYu
        gp+/Voe64YSImHxWoYfbtgZChLaIa7+FAYDlVxfz7H9rQIJ5vYe5goVMRIkDJAMf
        IeR2/YitBAnj5mCplVVl/dufVvzn/hMb0ABYocMM7dWNR3tt/BFGBpqaiNyH3KGa
        938BIPNs94Ed2MVIs6vGkO6W4Aj3bsYG6u929WNwE/4DZbn73jBLdWqrhDyL+ZCs
        nll8n+XW/1pu0282EOXzEWafOxfY3o8ugsj0bmLFs11hpye5A3aVBI1exSac35Hd
        XNy494NkqZgCszYznZM9f0jfCOx/U3lwtxZzbGR31sHUPpfAIwriOCH2z4Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1686416875; x=
        1686503275; bh=8eCukIyMRlPPOWu7IrDDF4KRgmkrU2LAmPtn5ch9l/I=; b=d
        jpvP026T0gIsybsGRhDk99ORaDSPuO8dv7THoAFHxG8qTYa3fjXcEydBOD6OtG5i
        FEjLYSb5hfOoCVC+8okODx92aJqA026O6/Mah1svtwUiGLrKOg1mUTz9+lgczzXA
        AEWStALrn5Hy/SJ+hdeI+4g0m2W5Fb8PWZ97kkdm9MDYiyA3xd/mDGZE4/pH5CLR
        OLLtmg/zd3DkLVS5tsReDXUmY0chozZP2oxFMFqMgeRyyo1edAfKngzAClf0jaRH
        /EIkRvWD0L7Q6geLcQEqOMVOOS08YeC0TwU1NLzYErfohHlvYfyF5Qpk6wIG41gf
        c42OjsILj0VRI+xIciVBw==
X-ME-Sender: <xms:662EZBFSaM3CCrGIbwu8bHBXO-GAtgBj6C3jyhTERHvwy_eG7gjEyQ>
    <xme:662EZGVTyNzBI1Fgdfw8VRlNaHm3LvUY9MsDChj_x-FOR0pCeCUgTymYFKxL9AS8v
    zxUSt1dtMqZW9k>
X-ME-Received: <xmr:662EZDKYtGr5X7WEDWZKYGn4MdQOouhVrhrUKqcFpUcEuleZKGkwzUuKYsrUXObQPDHPLFOUZKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedutddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:662EZHElnZ7fl_HySx6DjTZ-gV2_m1QSkr9FlB1a-SVlG_AJZ8oBnA>
    <xmx:662EZHU7_Haf7I7NIJ-_Y5WhJ1MesTwqIdkPFZJHBEhZTsUymRsdNA>
    <xmx:662EZCMLkw1bJ4G7fss06U5buK8gfM7KJMf8WH60lbeqzpDKvw2iKQ>
    <xmx:662EZGbPRBw8qARpspAj5_v3vCHhwVdg8eNb6ewk2exJoQFPnhVx4A>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jun 2023 13:07:53 -0400 (EDT)
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
Subject: [PATCH v2 1/3] vsscanf(): Integer overflow is a conversion failure
Date:   Sat, 10 Jun 2023 13:07:41 -0400
Message-Id: <20230610170743.2510-2-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610170743.2510-1-demi@invisiblethingslab.com>
References: <20230610170743.2510-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 .../hive_isp_css_include/platform_support.h   |  1 -
 include/linux/limits.h                        |  1 +
 include/linux/mfd/wl1273-core.h               |  3 -
 include/vdso/limits.h                         |  3 +
 lib/vsprintf.c                                | 82 ++++++++++++++-----
 5 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
index 0cdef4a5e8b1bed9884133f1a0b9d853d59d43a4..e29b96d8bebf14839f6dd48fdc6c0f8b029ef31d 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
@@ -27,7 +27,6 @@
 
 #define UINT16_MAX USHRT_MAX
 #define UINT32_MAX UINT_MAX
-#define UCHAR_MAX  (255)
 
 #define CSS_ALIGN(d, a) d __attribute__((aligned(a)))
 
diff --git a/include/linux/limits.h b/include/linux/limits.h
index f6bcc936901071f496e3e85bb6e1d93905b12e32..8f7fd85b41fb46e6992d9e5912da00424119227a 100644
--- a/include/linux/limits.h
+++ b/include/linux/limits.h
@@ -8,6 +8,7 @@
 
 #define SIZE_MAX	(~(size_t)0)
 #define SSIZE_MAX	((ssize_t)(SIZE_MAX >> 1))
+#define SSIZE_MIN	(-SSIZE_MAX - 1)
 #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
 
 #define U8_MAX		((u8)~0U)
diff --git a/include/linux/mfd/wl1273-core.h b/include/linux/mfd/wl1273-core.h
index c28cf76d5c31ee1c94a9319a2e2d318bf00283a6..b81a229135ed9f756c749122a8341816031c8311 100644
--- a/include/linux/mfd/wl1273-core.h
+++ b/include/linux/mfd/wl1273-core.h
@@ -204,9 +204,6 @@
 				 WL1273_IS2_TRI_OPT | \
 				 WL1273_IS2_RATE_48K)
 
-#define SCHAR_MIN (-128)
-#define SCHAR_MAX 127
-
 #define WL1273_FR_EVENT			BIT(0)
 #define WL1273_BL_EVENT			BIT(1)
 #define WL1273_RDS_EVENT		BIT(2)
diff --git a/include/vdso/limits.h b/include/vdso/limits.h
index 0197888ad0e00b2f853d3f25ffa764f61cca7385..0cad0a2490e5efc194d874025eb3e3b846a5c7b4 100644
--- a/include/vdso/limits.h
+++ b/include/vdso/limits.h
@@ -2,6 +2,9 @@
 #ifndef __VDSO_LIMITS_H
 #define __VDSO_LIMITS_H
 
+#define UCHAR_MAX	((unsigned char)~0U)
+#define SCHAR_MAX	((signed char)(UCHAR_MAX >> 1))
+#define SCHAR_MIN	((signed char)(-SCHAR_MAX - 1))
 #define USHRT_MAX	((unsigned short)~0U)
 #define SHRT_MAX	((short)(USHRT_MAX >> 1))
 #define SHRT_MIN	((short)(-SHRT_MAX - 1))
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 40f560959b169b4c4ac6154d658cfe76cfd0c5a6..8caccdcda0a2b470cda70c9b3837de37207eb512 100644
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
@@ -71,6 +71,8 @@ static noinline unsigned long long simple_strntoull(const char *startp, size_t m
 	if (prefix_chars < max_chars) {
 		rv = _parse_integer_limit(cp, base, &result, max_chars - prefix_chars);
 		/* FIXME */
+		if (overflow)
+			*overflow = !!(rv & KSTRTOX_OVERFLOW);
 		cp += (rv & ~KSTRTOX_OVERFLOW);
 	} else {
 		/* Field too short for prefix + digit, skip over without converting */
@@ -94,7 +96,7 @@ static noinline unsigned long long simple_strntoull(const char *startp, size_t m
 noinline
 unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
 {
-	return simple_strntoull(cp, INT_MAX, endp, base);
+	return simple_strntoull(cp, INT_MAX, endp, base, NULL);
 }
 EXPORT_SYMBOL(simple_strtoull);
 
@@ -130,18 +132,22 @@ long simple_strtol(const char *cp, char **endp, unsigned int base)
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
@@ -3441,7 +3447,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		unsigned long long u;
 	} val;
 	s16 field_width;
-	bool is_sign;
+	bool is_sign, overflow, allow_overflow;
 
 	while (*fmt) {
 		/* skip any white space in format */
@@ -3464,6 +3470,9 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			break;
 		++fmt;
 
+		allow_overflow = *fmt == '!';
+		fmt += (int)allow_overflow;
+
 		/* skip this conversion.
 		 * advance both strings to next white space
 		 */
@@ -3649,45 +3658,80 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
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
+		if (unlikely(overflow && !allow_overflow))
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

