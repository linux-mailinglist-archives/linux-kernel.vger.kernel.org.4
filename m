Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE9F72A890
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjFJC7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjFJC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:59:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A76D30D6;
        Fri,  9 Jun 2023 19:59:36 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E87D25C01A1;
        Fri,  9 Jun 2023 22:59:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 09 Jun 2023 22:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1686365975; x=1686452375; bh=j0YDtre0//
        ptA/N4P+hKQMixT1796glMqb4pGlu2kos=; b=m++JwYZhL4VFQQOGC4U7artSFR
        tHnKhyypdzTNFYqmUHkPIQ88g/YldbEc7fTPaqvBJoa6WmId3+Rcib97/knWOkkF
        Uy0mGW6LAof+uXS8TWAyZ6OyN0F8OZKBLLCxpL0F3xBoQTBCY7u2JrsPdSo9Zkv8
        irJTHJcMLzH6Umq1tlaOxVopNjkYNOA8aeRx/EGtKjceOsuk70VpRPpSLFiKdIo0
        GmsqXpCNHlvcHodK/kthEToV0s94id0LARIheJ4nZOhXuRTq8YyZjznp+cDTldlD
        DUywT0TY+w27GQtMwTTC/ZqtXwAxWg+CUoG52uj2Nw3uaU/u1HZZubj3PfPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1686365975; x=
        1686452375; bh=j0YDtre0//ptA/N4P+hKQMixT1796glMqb4pGlu2kos=; b=p
        M89UBlvVv2Nm/NeszM8jdZ+s549xstoIdFOqnHi6jPL5iTS7vVOfIpQht4W3sEP4
        SNxKU0y3QQnIytP+OAE24bUtVwj79W8dtHusLOTM1QDzzOS/Q07dZqTCHES5dXk9
        f5zAPa+9Rdcsv8rujbNFjwr/9pB8eczGJCEQSgAD3brahOtIJx0mUoxbTHbCKIJP
        xqo3zDLQn741Laou6bQ37ioja+eiXnl7jjk0Ntk6g155jjg5j0IAHGem7n4CkK/2
        /z1/yh5wnCkp0R7w2gllGN7vkke3pjPzznDh20SbSzBILzubdemkqigbZ3RLKDpB
        bDz7kuR9oaGKJFuHtWnew==
X-ME-Sender: <xms:F-eDZNLNsYM2SyNprlFyERV3xvJCiAvSDnfu16teP_aHvAXqerIx_Q>
    <xme:F-eDZJJqLfO45keHfvZ-9jEcivuOeWuM0zlHM0-VS1WchpUZB3LgSzp1uKiFDn3po
    HI8WhnHDbO6c6Y>
X-ME-Received: <xmr:F-eDZFvkDSparN4gCU1etOcV0zZkM7SDzN6Cd7JRi0v2puKbH0Fb3n-o0IF4cjAlxVDmlZfo4uk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:F-eDZOZo2xVuEMVkbuGooXigkLSh2kI9p_R8scC211Y0MPRaFJI75Q>
    <xmx:F-eDZEYS9tJRbBA85wGMpIO0xx28Oc-u2mVssFxsVS0JYjPfX89Tcg>
    <xmx:F-eDZCBIn_RJcCVnCuuYDzuW4tUZODA6j9lDnS951ovkOOzXr2OMaQ>
    <xmx:F-eDZBRiqeHEceFspbo9GZler4iklr04L5cWrcXxQw0aH4kVwrKrGA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jun 2023 22:59:34 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH 2/4] vsscanf(): Return -ERANGE on integer overflow
Date:   Fri,  9 Jun 2023 22:57:57 -0400
Message-Id: <20230610025759.1813-2-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610025759.1813-1-demi@invisiblethingslab.com>
References: <20230610025759.1813-1-demi@invisiblethingslab.com>
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

Userspace sets errno to ERANGE, but the kernel can't do that.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 include/linux/limits.h          |  1 +
 include/linux/mfd/wl1273-core.h |  3 --
 include/vdso/limits.h           |  3 ++
 lib/vsprintf.c                  | 80 ++++++++++++++++++++++++---------
 4 files changed, 63 insertions(+), 24 deletions(-)

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
index a60d348efb276d66ca07fe464883408df7fdab97..9846d2385f5b9e8f3945a5664d81047e97cf10d5 100644
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
 
 static noinline_for_stack
@@ -3427,7 +3433,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		unsigned long long u;
 	} val;
 	s16 field_width;
-	bool is_sign;
+	bool is_sign, overflow;
 
 	while (*fmt) {
 		/* skip any white space in format */
@@ -3635,45 +3641,77 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
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
+		if (unlikely(overflow))
+			return -ERANGE;
 
 		switch (qualifier) {
 		case 'H':	/* that's 'hh' in format */
-			if (is_sign)
+			if (is_sign) {
+				if (unlikely(val.s < SCHAR_MIN || val.s > SCHAR_MAX))
+					return -ERANGE;
 				*va_arg(args, signed char *) = val.s;
-			else
+			} else {
+				if (unlikely(val.u > UCHAR_MAX))
+					return -ERANGE;
 				*va_arg(args, unsigned char *) = val.u;
+			}
 			break;
 		case 'h':
-			if (is_sign)
+			if (is_sign) {
+				if (unlikely(val.s < SHRT_MIN || val.s > SHRT_MAX))
+					return -ERANGE;
 				*va_arg(args, short *) = val.s;
-			else
+			} else {
+				if (unlikely(val.u > USHRT_MAX))
+					return -ERANGE;
 				*va_arg(args, unsigned short *) = val.u;
+			}
 			break;
 		case 'l':
-			if (is_sign)
+			if (is_sign) {
+				if (unlikely(val.s < LONG_MIN || val.s > LONG_MAX))
+					return -ERANGE;
 				*va_arg(args, long *) = val.s;
-			else
+			} else {
+				if (unlikely(val.u > ULONG_MAX))
+					return -ERANGE;
 				*va_arg(args, unsigned long *) = val.u;
+			}
 			break;
 		case 'L':
-			if (is_sign)
+			/* No overflow check needed */
+			if (is_sign) {
 				*va_arg(args, long long *) = val.s;
-			else
+			} else {
 				*va_arg(args, unsigned long long *) = val.u;
+			}
 			break;
 		case 'z':
-			*va_arg(args, size_t *) = val.u;
+			if (is_sign) {
+				if (unlikely(val.s < SSIZE_MIN || val.s > SSIZE_MAX))
+					return -ERANGE;
+				*va_arg(args, ssize_t *) = val.s;
+			} else {
+				if (unlikely(val.u > SIZE_MAX))
+					return -ERANGE;
+				*va_arg(args, size_t *) = val.u;
+			}
 			break;
 		default:
-			if (is_sign)
+			if (is_sign) {
+				if (unlikely(val.s < INT_MIN || val.s > INT_MAX))
+					return -ERANGE;
 				*va_arg(args, int *) = val.s;
-			else
+			} else {
+				if (unlikely(val.u > UINT_MAX))
+					return -ERANGE;
 				*va_arg(args, unsigned int *) = val.u;
+			}
 			break;
 		}
 		num++;
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

