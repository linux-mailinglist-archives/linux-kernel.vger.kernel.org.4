Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3029F72AEC2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjFJUlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjFJUlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:41:32 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A733C18;
        Sat, 10 Jun 2023 13:41:20 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1EB553200406;
        Sat, 10 Jun 2023 16:41:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 10 Jun 2023 16:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1686429677; x=1686516077; bh=zmp6AIFl9e
        0+GK3wpF6apHM7zkfOYrIi/BxUW3DBWhg=; b=XntlKjsZ5vDs46MOdTHeyZvitC
        BCBFcNS/FcjDeM4XTmVsTCGqKa9sKUIJGJiUpAMewiO6Plsxy3NVeFGBq8NGsvyU
        GmoJkr+GPhlevaRfzm4zjiJ08mvreC9A/De2b9rgogK/ImxMUZ+tJHDfol/yS0JY
        oyJcRP4oaJZsBnoYCeuKke1Vs53z97j0PgY+7WY0pIvTokA4oXghbVBdBd2H7jqA
        SnO5O6nFE6IxWxE82FkqwETAUDKyE7S9s2W+43S2zcLL7M/sYgX/0j4iH7Dn2AJD
        WYgthgHRztCWMpOsWFENQrdViXckE0dd6dTtn2+Yyzlgw/HGxm0feESXHAlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1686429677; x=
        1686516077; bh=zmp6AIFl9e0+GK3wpF6apHM7zkfOYrIi/BxUW3DBWhg=; b=t
        6bzJo1vxBIOrwPu0ry6yxCkK73ctnRvQQkcD14iOjwkykEWG1hVsXieiKE6k5NMo
        MvwbMUrFgySmNmuX99+3TZrYpJsSFglclvPh7wO7WVvxg69vgP3qdKR93ihj/9jB
        jLfH17ITpjrmIWan6f75YlQiAh8RePrGRDAtizZ+dIt0mZy+/jdNG4xoEyfTsM3D
        WlbGRbmJ+mTteuu4hoWczjdPd0U/JTe7vR4PcmqZHg+pKIe+Q824PocdJtNuIXvq
        THe/4dB4TnLuN5+5t/XxTtXSXXsB7rk2uxKJVjqObJYiZyAqQn96tu8km8ynSHYI
        Cg/oDgONfxx1lW5NjptVg==
X-ME-Sender: <xms:7d-EZP6MNBO7tgYs5yer3mUsq8Jly31Tz6UdRBT_SIlG_OUu5obqYA>
    <xme:7d-EZE5YKuqmq08X16L52OcREe1N6wW0Z3h4d_h9OUJC1IOr-fyajb6z8j3F_9Y-q
    wgr2uiK0eB9i3w>
X-ME-Received: <xmr:7d-EZGcFpsIPw6BZtwy2gFpR0wEVSGAV0zIFioJ22u0kw5e_5NWqfJ8nhkgIdBtxG5puB4KLVZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedutddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeekveekveegudffgffgleekudeu
    keetlefgveelhfehuedtfedvgfeklefhtefgfeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    uggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:7d-EZAJDYpvyohwhYVmYIejddYDv4rz2BZMkV-g-ziV7TJ6JDQj4PQ>
    <xmx:7d-EZDIYJi-WvrKwbA1W4dVw7QRcjTnDi7Io3KHqlmbl7_HTi_RZPQ>
    <xmx:7d-EZJzV83cvJ9av1HfcZz90vuNGmhsF9LDtJLWTfX2yMuFVveDaqw>
    <xmx:7d-EZD9o4h5_Df4PuXlad6EA-xyxIZRm3-QZWRRr_QcjtRAW5OJR3A>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jun 2023 16:41:16 -0400 (EDT)
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
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 3/4] vsscanf(): do not skip spaces
Date:   Sat, 10 Jun 2023 16:40:43 -0400
Message-Id: <20230610204044.3653-4-demi@invisiblethingslab.com>
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

Passing spaces before e.g. an integer is usually
not intended.  This was suggested by Christoph in
https://lore.kernel.org/lkml/ZIQrohcizoj4bZWx@infradead.org/.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 lib/vsprintf.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 9e53355c35b1d6260631868228ede1d178fe3325..665f6197f8313d653f67d7886b12c43942e058dd 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3551,8 +3551,6 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			char *s = (char *)va_arg(args, char *);
 			if (field_width == -1)
 				field_width = SHRT_MAX;
-			/* first, skip leading white space in buffer */
-			str = skip_spaces(str);
 
 			/* now copy until next white space */
 			while (*str && !isspace(*str) && field_width--)
@@ -3639,11 +3637,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			return num;
 		}
 
-		/* have some sort of integer conversion.
-		 * first, skip white space in buffer.
-		 */
-		str = skip_spaces(str);
-
+		/* have some sort of integer conversion. */
 		digit = *str;
 		if (is_sign && digit == '-') {
 			if (field_width == 1)
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

