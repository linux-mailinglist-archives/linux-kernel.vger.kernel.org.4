Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA5659084
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiL2Skh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiL2SkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:40:17 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FD5116A;
        Thu, 29 Dec 2022 10:40:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B239432007F1;
        Thu, 29 Dec 2022 13:40:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 29 Dec 2022 13:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672339213; x=1672425613; bh=Ub6/Sg6MtwK7zSZLvDEMExGoi
        kMh9KjbbFTpe8DKeuA=; b=gw+eCMVAO9wS/xum4K/FmCm8RLK+HPddgKot9F+6C
        aXmo+a4J5GbZ/4SQIPdakBOJYRFUnQhvcCA+XVB3SsHzW7NAbSKmotc1ujaD8Y8O
        vODRxqEvuCsmehC/Kuw9s3h+FY5gHJw4Yv7M1xcQvrhv0JgzDaTBQ/n8yOdkv9ih
        snRcMti+ltyPcsj+T1ccNfpLLo9W9MEPcGfts8/Uwt7rK4IKydVggD/NcJ4MRpyw
        hrg9P8FNnY6UQuTZikUJctqGNE+CoVjT+qg2qpg7IVSZ6teE6iotZcmOmwO56qIB
        o7fhNWNkESC72HMpJ/UQPuUiNBu1yaKj2eX60W9W35MNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672339213; x=1672425613; bh=Ub6/Sg6MtwK7zSZLvDEMExGoikMh9KjbbFT
        pe8DKeuA=; b=d0Ax4PSWdXTAOophmW8FbmoPkGdXa0JFRPff+iWnGGT7jU9VIfw
        h8SOWIcNDDSZJU2hvODYDoyQXuCvff9dL3p+Nbi2FKaXqqDFTmcZlkPBJZ2HcSqB
        VejGcWgf7H3NgVKWEDhSA4hnna7Ql7SCrAF1rKyykrC7z55lsegk3KZZ+1EPdRnY
        4e1RCKjRR4ulSAMhOmvBlawaDFBHayMO7BcmhKqo0eqIgzNT4Q22Hzd+E0eUfe1i
        yOh/UuZu7xBn9CoESjRPiboWUdUgF96SZjHM4Uybo+HqxjL4VfUIwqxJBQAAcK6Q
        oQNF34KNhHa8kjFqHBojTrORJbg7NwAKi0A==
X-ME-Sender: <xms:Dd-tY1c6jzUb0hyju4GwDZH1oft3CCyXVijpSqpDl8cv9-oeZaLONA>
    <xme:Dd-tYzMdkP4pG3FMiD8k0KyIYSz4Cunbh8dTw5pJ6NDPWp730s8rAgRDuSeEORT6T
    7hE0zH2Iq6or7o4uQ>
X-ME-Received: <xmr:Dd-tY-iY_PkIGgF9HXiucJrEOXJIwGOTiXLJvE6hoUFdTR_npT4Tu7eX48PQZ1mtF6WL8IwAIQmAsBYQUvP4-S8x39NunvRzLQTRQFdtQfkHc0EHPVviKKWJdq-b0NbC13ugGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Dd-tY-_2sMylYYXdONF5dVioDiH-G7zAxEGZbB-xlJY6MtoNNh9lrw>
    <xmx:Dd-tYxuiy0caaCttUucdX2r-jxGouwl5xMJuVdAysE6NLSz-rYtILA>
    <xmx:Dd-tY9HjIuGchgcq7GWs9miG1a7fPwA8s6O30AdaGVZA5nNiYxosDg>
    <xmx:Dd-tYy9aVxAJWBiIe_B5URbRY-pyuR4RBWvGvJzZY8nMmvk50fNIwA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 13:40:12 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] rtc: sun6i: Prevent an out-of-bounds read
Date:   Thu, 29 Dec 2022 12:40:10 -0600
Message-Id: <20221229184011.62925-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is more than one parent clock in the devicetree, the
driver sets .num_parents to a larger value than the number of array
elements, which causes an out-of-bounds read in the clock framework.

Fix this by coercing the parent count to a Boolean value, like the
driver expects.

Fixes: 3855c2c3e546 ("rtc: sun6i: Expose the 32kHz oscillator")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/rtc/rtc-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index ed5516089e9a..a22358a44e32 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -294,7 +294,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 
 	init.parent_names = parents;
 	/* ... number of clock parents will be 1. */
-	init.num_parents = of_clk_get_parent_count(node) + 1;
+	init.num_parents = !!of_clk_get_parent_count(node) + 1;
 	of_property_read_string_index(node, "clock-output-names", 0,
 				      &init.name);
 
-- 
2.37.4

