Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D820972AECC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjFJUlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjFJUll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:41:41 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77F33A9E;
        Sat, 10 Jun 2023 13:41:25 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id BC3FA32003F4;
        Sat, 10 Jun 2023 16:41:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 10 Jun 2023 16:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1686429683; x=1686516083; bh=1qqdCLnk8X
        ZZUpiOqZUTKehWt/5RjR4FGu3vEMkB/ek=; b=RNwmi56tXuI4aB88VxWVJYjN5P
        Hw7IIvlioRJaQi72PlbFI1iAp/W+LJONn/SSjyoyfgXBQxQ0KA7W7Mc/KqThl2zb
        af8HmrPGpQtGd5GC+cOL3ZZ1SK6m5ZrWdVG8ihyzvV6gblHO/C7ZBXhAWREuWsck
        P/g4bx+3HxvTx6+/yDS2c5DBMMQFrL8GiOJhY5YudZtIlNTDo5KOoDHvYPEDONHZ
        F88JNfxJWhVbTrlVR/L2/pabGG7mxCdMlpxtpJBG+2Us+QaQYXB33WJPfePwC5GE
        HYQ82LY3dbImVJt0Rzh8ItSiO2PaLZocQKmv0t91vqNopAb+hirVaAjqVSxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1686429683; x=
        1686516083; bh=1qqdCLnk8XZZUpiOqZUTKehWt/5RjR4FGu3vEMkB/ek=; b=e
        1mOAh0xXnK84ZU62LsR9vciVBb905DBIyIteDQ5rBbSwWerkYe1jAZAYBdrFYzWh
        m2vltF2suhspVwl1kvNwOYOEmLgTez3EoBzzaEzy0NDKiAnhO2dG/n16qg+LfJE3
        Ft668WUWrvb/WZI83UP9j76y7XZbSFj6XDjsD02ZW+CmT65nGehwF0TIXGAI/WLs
        BiUNxC5ohQYin08dwphHgImXf+s6laXlgOPZWB5Mzs482WbPW4ilyswaqrDY2cXe
        0IlaI2nVmKDzFENJfYkN6yLiJRrt2qq1DqnduA9nMIAk3AMNfUvmJruejW8eVrds
        /H3018pqeMwbr9tpnAUEg==
X-ME-Sender: <xms:89-EZBPPQkFmBUJ0gud1RkOc0Py4z0fUW1gvJXXzBjiFXmn6AbOyuA>
    <xme:89-EZD9Z93YcxwNqIlKcOwZckhWj8X1jx2Hy_rG0toDjJJkSdQb3I9xeVM0JjQTjY
    9lGnXcE2chdkZE>
X-ME-Received: <xmr:89-EZATy88DDpm9MKdEI1W9JxmKwcqqkF3Z4NZHyMCdNxwT_MriGQAuKT4FAfKcxcGLtU0lRkq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedutddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:89-EZNsP4SvUHS5WfyHzoSSCdPHktbzD9FyQ7NiTa2DGQTBIiPe7NQ>
    <xmx:89-EZJdGOqfqeTrSlvYm1JamcAjElSKmbrsUqeO0EqMf6g_7rgVfjA>
    <xmx:89-EZJ1UVhU4_ZWZ8lg6XfKoI0CenNKCwwVgrp9S8zR28CiGfVU4TQ>
    <xmx:89-EZMWteewgvf_6iu0kUYfW1H0XHyXVVTxFAMDx5YGxnto3YouPzA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jun 2023 16:41:22 -0400 (EDT)
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
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v3 4/4] Reject NUL bytes in xenstore nodes
Date:   Sat, 10 Jun 2023 16:40:44 -0400
Message-Id: <20230610204044.3653-5-demi@invisiblethingslab.com>
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

This rejects bogus xenstore node values that include interior NUL
bytes.  These would be truncated by functions that expect NUL-terminated
strings.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/xen/xenbus/xenbus_xs.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 12e02eb01f5991b31db451cc57037205359b347f..7cb2a22a7698ac40c81add23476594d9f27de8d0 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -569,16 +569,20 @@ int xenbus_scanf(struct xenbus_transaction t,
 		 const char *dir, const char *node, const char *fmt, ...)
 {
 	va_list ap;
-	int ret;
+	int ret = 0;
+	unsigned int len;
 	char *val;
 
-	val = xenbus_read(t, dir, node, NULL);
+	val = xenbus_read(t, dir, node, &len);
 	if (IS_ERR(val))
 		return PTR_ERR(val);
+	if (strlen(val) != len)
+		goto bad;
 
 	va_start(ap, fmt);
 	ret = vsscanf(val, fmt, ap);
 	va_end(ap);
+bad:
 	kfree(val);
 	/* Distinctive errno. */
 	if (ret == 0)
@@ -636,15 +640,18 @@ int xenbus_gather(struct xenbus_transaction t, const char *dir, ...)
 	while (ret == 0 && (name = va_arg(ap, char *)) != NULL) {
 		const char *fmt = va_arg(ap, char *);
 		void *result = va_arg(ap, void *);
+		unsigned len;
 		char *p;
 
-		p = xenbus_read(t, dir, name, NULL);
+		p = xenbus_read(t, dir, name, &len);
 		if (IS_ERR(p)) {
 			ret = PTR_ERR(p);
 			break;
 		}
-		if (fmt) {
-			if (sscanf(p, fmt, result) == 0)
+		if (strlen(p) != len)
+			ret = -EINVAL;
+		else if (fmt) {
+			if (sscanf(p, fmt, result) <= 0)
 				ret = -EINVAL;
 			kfree(p);
 		} else
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

