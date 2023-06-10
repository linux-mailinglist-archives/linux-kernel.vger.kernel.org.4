Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373AD72AD98
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjFJRIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjFJRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:08:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16D22D68;
        Sat, 10 Jun 2023 10:08:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 19C3F5C00F9;
        Sat, 10 Jun 2023 13:08:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 10 Jun 2023 13:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1686416881; x=1686503281; bh=TmbhH/0ly3
        pB3JOqGw89diUDufWw9j78goS8q6skCyk=; b=QVjheJeyM7p0c069LT+BuB4f0m
        JHFXKBOKLHyZdGN1dI7Xg2CHRbYbBz016p0MWQb1wJ0m/CkbOIqSGHQirxw9cB5r
        dtEKQIvGtiavzaAPLb7q48jcqNep5y25/EXr7KdUd5hOHtnYROPu4wlzgCv6qedJ
        V/i8hYS4e94/6Xn07dyYOoiU8WRkWNce47fxGLB++trtFUE4vZbDFbZ8TrAXCXqD
        zY7dq5ZsPRGpyARXLEtEeorMF3Kfy8QlNq3KZz4Db6g7l3s0FkhbI6BOM4g2t3sU
        80XR4vln+Xcdb16w6e6yg9r63q43HfFl20Mi9EHQevPpHy+yXEYb9XO2LXRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1686416881; x=
        1686503281; bh=TmbhH/0ly3pB3JOqGw89diUDufWw9j78goS8q6skCyk=; b=H
        5Do6YlaaYtGxcuyqDWouK2yBlL0NP5Q1P/beUidzDtLeqCk6SyG+M/R7ZvvQh+GV
        iBJ1PoRejG08Zr3Z4PG9EM3VFoBUkRr82a1KGgKpA6CnRhnf6sKJOIev99096QfK
        UbjK09Z9bdS4FmAn01FvBycOBgBhe8ilmBauglnwjcEpUpkmcM+mFk9vZORX0Hz2
        /8nvl3DfVH3bTjoHQ55VOJNj5vwNx9XuwCf1el4oW4sG1FTMzUHpCYZfoDpiDk+Z
        b1UtwrYqj7lVkY78zIfJAC6V0P47Y9+DqGP68ZkKbJiGasS7uDFS55edLaOiwtn1
        Kfdj0Hlg5T0+A+XJvKazQ==
X-ME-Sender: <xms:8K2EZBVcnD-uBZYGKxiWqtCRsdoMqEkSsea3_VUIT3DYAgR6IJs83Q>
    <xme:8K2EZBkvoPHydeNvuTnsS0_meXDdJSYXy2HLW-IE_70x-c_uqTGLLtXImjd0qWIUq
    vB84dA5jXJpeKk>
X-ME-Received: <xmr:8K2EZNbb8NttdXxlZpyVAy4In4plhQ5JRsGiZiw8CTXzZMWDIOgjGkqEP1u6_F5sAWZbyk9u8jM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedutddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:8K2EZEVKO40jBTawR2O5FinOiWqtjX6HjQ2WYRIn9UhdhCQBq-g1mg>
    <xmx:8K2EZLlh2PD7KLp9YP_pW7e-HPEjK0To5CcuEm-TUMSgndlBQjrTHQ>
    <xmx:8K2EZBduYPm45AMHGmYGv5vpQtiYW7yvj4qk4zAfejJbLCOAw4xWGg>
    <xmx:8a2EZKdnqYuIxd1XbN5rcAjKu2Szskw0NEOwN8-Nhlbc0DGFcqBq_w>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jun 2023 13:07:59 -0400 (EDT)
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
Subject: [PATCH v2 3/3] Strict XenStore entry parsing
Date:   Sat, 10 Jun 2023 13:07:43 -0400
Message-Id: <20230610170743.2510-4-demi@invisiblethingslab.com>
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

This rejects bogus xenstore node values that include e.g. leading spaces
or overflow the expected integer type.

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

