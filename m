Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C65619BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKDPmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiKDPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:42:02 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424AF3205D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:42:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FAB55C0075;
        Fri,  4 Nov 2022 11:42:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 04 Nov 2022 11:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667576520; x=1667662920; bh=K/Jy/ap7eS
        35A75a4wuv/qSzMWMS57fbfihQm65uJFk=; b=gSVRsc6gTJel/XjnIYYG6Ppafn
        SRUXo1y/EgGMn6qvDPFrE8QMKvueUOCk2laIrbwLxj45K8OicwINlEhoYgjBeuhb
        HKq4jM582NDRcKsS2KCf8b3y6h0OCAm3fS4iXGl11crEhPx/gC01VJdRlwcSD9Nt
        HFEI1F4wi8IfhRY7Ge0wyyDi4hjZ71xbp/A57aygls/kUiVNUa0jicoDAzwfTOkP
        DrtQXUTEiFCLH7DEuq08XrfwAEGn5BfSYW1Sdq2Mo8/vTwrNXyksCvK40+56Ipf0
        IBikYnxT7FcK/c5R099s6mP0FO5a0Z41qje7sQsrqmvoHK8a4D0qXsxURaZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1667576520; x=1667662920; bh=K/Jy/ap7eS35A75a4wuv/qSzMWMS57fbfih
        Qm65uJFk=; b=BP5OIs+31Q2jEpyxftz4NKi25JYuYkihFe1ohPfu8+sleOuVjIH
        MmxDoqp6nrrQH1lFCNBNGr+GWRC8mJj2PGO2+cr3RrijsjpAIvIkwzSBKJ6iPwSf
        B3+JCKC41Q7PhnhrzFarYKddGJ128SoGMpF0UAx5z4OlbL4QKGHK05X/MJ+aXxAH
        bfMTghDiakCznI9+lF/doUfcwqN4V63LhVp+V0wZAT6u1icyFQWOX/LKK/2Vq9IH
        0wrvUkjHhiG0nrQDsqtWJR9Oc5bKtsluxU0xj/sxnl9NeAmYMEG66ESqLknmT+H8
        3IG7f6LSH8symcWYUlWxxQk0HIn8vw066vQ==
X-ME-Sender: <xms:xjJlY9VPgHsCAk7HOTEUChjFZo0cvjyT-G69b1QzYCzor3EFfFC45A>
    <xme:xjJlY9l3rXNZ4gW-vEh_aognrjgH3VvOBlEbHnWYZ_yBtoP-wFOmMivmINzqisB4b
    aP_0f59dI6b13FeJbc>
X-ME-Received: <xmr:xjJlY5ZV9bucIBKMJVWuCy9BRcc-Oc_NoO84taJzhNHFC-oBc24PNePfy_zBwgTboe9R-09qDk0FZz40f9jYAMTb_PWKgpHGpF_jiAJZqZqbs4vtHaJAM54crTg-0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epleduffeiheeuvedtffevtdeuleeljeduudfgtedtvefhfeffvdfghfejhefgleelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:xjJlYwWhhbEY8jO78OFqqiVNHKS-aQijFGRNM5hfOari0DdmqaVFTg>
    <xmx:xjJlY3nRb6c7lduV4-Nf6QUgtA2YTBWDji1a06gs9zP_-5W_JVRUKw>
    <xmx:xjJlY9eCQUuJ4L8G_1ZevR2oLl-vFOljK7-2E2VvlbczQ_iugIAzkQ>
    <xmx:yDJlY1ZUJRRdudzt3iM67Jtf2PgZgzyycBK26a8YyvJh7GNqgazJHw>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 11:41:56 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: apple: rtkit: Stop casting function pointer signatures
Date:   Fri,  4 Nov 2022 16:41:53 +0100
Message-Id: <20221104154153.79373-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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

Fixes: 9bd1d9a0d8bb ("soc: apple: Add RTKit IPC library")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/apple/rtkit.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index ecc1a818b23d..fa3cda831d2b 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -922,8 +922,10 @@ int apple_rtkit_wake(struct apple_rtkit *rtk)
 }
 EXPORT_SYMBOL_GPL(apple_rtkit_wake);
 
-static void apple_rtkit_free(struct apple_rtkit *rtk)
+static void apple_rtkit_free(void *data)
 {
+	struct apple_rtkit *rtk = data;
+
 	mbox_free_channel(rtk->mbox_chan);
 	destroy_workqueue(rtk->wq);
 
@@ -946,8 +948,7 @@ struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
 	if (IS_ERR(rtk))
 		return rtk;
 
-	ret = devm_add_action_or_reset(dev, (void (*)(void *))apple_rtkit_free,
-				       rtk);
+	ret = devm_add_action_or_reset(dev, apple_rtkit_free, rtk);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.25.1

