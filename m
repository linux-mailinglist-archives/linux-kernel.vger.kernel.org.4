Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5041B72A894
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjFJC7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjFJC7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:59:42 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259830D6;
        Fri,  9 Jun 2023 19:59:41 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E1B05C01A3;
        Fri,  9 Jun 2023 22:59:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 09 Jun 2023 22:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1686365981; x=1686452381; bh=9jx1BPUbfc
        VgExhjQbchVzVzEh8/1tbELFoG8PhPivY=; b=KzDj4AYYzePpimX6H5wkYZwkks
        NHGbQDu8jIRMdcSSSgF3b3PCmK7D2vOotKxA1DfVlTP2e08oG9cNjOaC0kyc2A/A
        Woeqakefd0epg23qLeX6igy3kxTwzSX6HLFhahqzHc+vqvIKm4sAeWi9aoNSXRR6
        wCI5HfGLfst2I2vTH2hIA7ZxZ26JHuWYOCEEPQPqUdH0cH2Rrtx60UFtXGXkXHdo
        oHHe5NzrKGAz0eOgRzDoxWrkDYMlWiOGDPj/JZbnnXGfaI+2MtyHouaGMcEBMaZV
        jdSrar5Q0z3nIwuLL3W3Xx2b6XH6XjVb12K0C8yZS0BhFD3XVFZWGvJ79QUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1686365981; x=
        1686452381; bh=9jx1BPUbfcVgExhjQbchVzVzEh8/1tbELFoG8PhPivY=; b=Z
        vSpafDBLwDL8H2CTo8lfIfv0lBZ6g4SdgNNNWgwt9+71cFO74vFRkfX5OQ0eun+2
        V9U7u1FWaanTOidIYHn+FaDRXl+fpQTdsWaByWb8JDChI4RHKW0Er7WreEW70XSH
        F7ovWDNSgioIcLiDVSE1DlAfe687KvI/kOFQUYI5cJrhQ5FVuqQj+0k+MXIqK2ZF
        5YIcEJ5iqfquW6njaZXeLisvjATivHd3InKEgpO6av2xMmSPYJ9xVUx7M/y8yarE
        v1ZhBTL4ViFGSyXf3rk89tTMCKeP0BpWjJ6L5NGJkGZn6HsrPPsYg/Mr1c8kHU06
        REVYBioVQJyWfzr6tnZjw==
X-ME-Sender: <xms:HeeDZCWV0SKnRdsuGWRSsQMu7GQI7-ysiwNLiOBZM6ZFaFT_yJ_T2Q>
    <xme:HeeDZOnaTfv3AHrYlBdxpogXCqqlsJqyy25XXUF2UfuKje_bn9deU29hJr9wPX0EB
    viI8zxkNbo_YBo>
X-ME-Received: <xmr:HeeDZGbj_8bj6jZVBSKrCmevOYHC1UJpIHY58wEQ9MBMYdxsNSeAl9zIqtq3BmXQA5BjzkBP0Jo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtledgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:HeeDZJXiLPzcMxSY0hCAKbUMNmyUBS1fv5Tgj-Haa8sn4r-ZxG8NqQ>
    <xmx:HeeDZMkbTgZg6NoNqlMUgE_TtOweBaMzwJZpqmojC0wcAPklBlaoFg>
    <xmx:HeeDZOcGa0h3eIXBrgz7fX0jy5-BY_bRbkTS_mVGglLhXOxaRr0I7A>
    <xmx:HeeDZLd3CRf4yDDakzxMu1xjRA1REUtQS01YtYNIVyK3lLSe2ZslAA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jun 2023 22:59:40 -0400 (EDT)
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
Subject: [PATCH 4/4] Strict XenStore entry parsing
Date:   Fri,  9 Jun 2023 22:57:59 -0400
Message-Id: <20230610025759.1813-4-demi@invisiblethingslab.com>
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

This uses the newly-introduced strict version of sscanf().

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/xen/xenbus/xenbus_xs.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 12e02eb01f5991b31db451cc57037205359b347f..88e94269c9221d16d1a97e59399058e870675729 100644
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
-	ret = vsscanf(val, fmt, ap);
+	ret = vsscanf_strict(val, fmt, ap);
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
+			if (sscanf_strict(p, fmt, result) <= 0)
 				ret = -EINVAL;
 			kfree(p);
 		} else
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

