Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC3659250
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiL2Vx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiL2VxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:53:25 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBAE1572B;
        Thu, 29 Dec 2022 13:53:25 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 26EAE32005B5;
        Thu, 29 Dec 2022 16:53:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Dec 2022 16:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672350801; x=1672437201; bh=GmZbFK5G8r3n4tr/8fciPGSNC
        kBT0fjFOydO/VsJtnM=; b=1IFGGQlnjZZHd4CGC3hCJ/2dUcS0HJG0PDg1NIZG3
        UpZNmfRv32+SeQ+hbVeZmNPh1fc0dITzfjsVIQlE6ScS8vdThM+s75geDG2dJvGe
        LDRAlVfFfGOAZCp5i89RqF0XP4nXTkzklJ1h/IgEWnUZe5ZFomK5hTu799nWHpph
        2gzlepUSfOORM439h5lCWz8Mc2SipRF0le86uxx2elSSuGCoNkx+MjU0MOXYmnbL
        tK1qMMXu2Cjt/tUPAMj0eC/lJJvIF9oUEYrc1ucfK4ylBJULuv3fOTVdDIkEEZ4S
        dP2C+pBI0T3HTg3TOmS66i7h5OS8c8W6G90ep8nMG04LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672350801; x=1672437201; bh=GmZbFK5G8r3n4tr/8fciPGSNCkBT0fjFOyd
        O/VsJtnM=; b=R4wlBjyS0eWG+v3T4OhIn4vIlyaoUbEWwqlbOG33EBFN+Q4+YQv
        +BDS6KbSPelxjKCdteUT8WQD8a6fhWY4BeZB2zbH8YZkZMwJoTz61jMC3wfNbGC6
        WFxDotjrZTYPZCf0bJ/aAA0/RjlDjWKLZsDSpq5LQoYiW6l8yoAf67lfTZjkRuA/
        9GkQc9JhIV8CndXrP6HFynx+nfum6VLyPhZ60RUwjRzphAlMqo0BcpfoAmvY6Bxr
        7Cb47dInTzKci0Z1JvWTqtHXWYdFDJ0YpIG7/Ik9t4JI3lQt2mpPNeTCUG9tgX5o
        8zfe0F4fm+LvjvJtOVdcwpJDCFnjFxSbAJw==
X-ME-Sender: <xms:UAyuYwkSDzvjMoZmemhcUzxxEdW4nYvOtjGHz_GBURF3JYLeKaWBMA>
    <xme:UAyuY_3f4GULYIw1le2TsFp8uXavGn2Dt8D6m9S6DkwHEHAnS7T2jhZQHIqyIq5mE
    2HLLyeGACJa7wOF6A>
X-ME-Received: <xmr:UAyuY-oEmUR3p4MNEZTd7lajrXQZH2zi3byGKZNEbjZEXLdLu8WO8ykWNKaATTMHNlWjDlfheVk4MdDHzfqJPkerO08nwGZBTVD3-XNj6iKgStGFVIK37eLduXnpFKZ5HF44eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeehffethedtteffgfefteetjedvfeelueevudffgfeutdejvdehledv
    vdffhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:UAyuY8m_LGg3ws12hCkqHzVTtf-bgQySISiOAUNoflsOMmkZ8Aij_A>
    <xmx:UAyuY-0C7OZ8kVxhFYd_lHPBZ7IiE12h1lK7SLmhfc8Eqoq1DKwR8w>
    <xmx:UAyuYzvJgBaC7pVUVwSRiprpPcGfev2cGF8pL8orO_AAlYsEfHhuEg>
    <xmx:UQyuY3lj5vDw6tTSDkhmGwJUMVELCLAe_a9tMdI5op1QXVAbQ3LA3Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 16:53:20 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] rtc: sun6i: Always export the internal oscillator
Date:   Thu, 29 Dec 2022 15:53:19 -0600
Message-Id: <20221229215319.14145-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On all variants of the hardware, the internal oscillator is one possible
parent for the AR100 clock. It needs to be exported so we can model that
relationship correctly in the devicetree.

Fixes: c56afc1844d6 ("rtc: sun6i: Expose internal oscillator through device tree")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
This patch should be applied before [1] so this patch can be backported.
[1]: https://lore.kernel.org/linux-rtc/20221229184011.62925-2-samuel@sholland.org/

 drivers/rtc/rtc-sun6i.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index ed5516089e9a..7038f47d77ff 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -136,7 +136,6 @@ struct sun6i_rtc_clk_data {
 	unsigned int fixed_prescaler : 16;
 	unsigned int has_prescaler : 1;
 	unsigned int has_out_clk : 1;
-	unsigned int export_iosc : 1;
 	unsigned int has_losc_en : 1;
 	unsigned int has_auto_swt : 1;
 };
@@ -271,10 +270,8 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	/* Yes, I know, this is ugly. */
 	sun6i_rtc = rtc;
 
-	/* Only read IOSC name from device tree if it is exported */
-	if (rtc->data->export_iosc)
-		of_property_read_string_index(node, "clock-output-names", 2,
-					      &iosc_name);
+	of_property_read_string_index(node, "clock-output-names", 2,
+				      &iosc_name);
 
 	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
 								iosc_name,
@@ -315,13 +312,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		goto err_register;
 	}
 
-	clk_data->num = 2;
+	clk_data->num = 3;
 	clk_data->hws[0] = &rtc->hw;
 	clk_data->hws[1] = __clk_get_hw(rtc->ext_losc);
-	if (rtc->data->export_iosc) {
-		clk_data->hws[2] = rtc->int_osc;
-		clk_data->num = 3;
-	}
+	clk_data->hws[2] = rtc->int_osc;
 	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	return;
 
@@ -361,7 +355,6 @@ static const struct sun6i_rtc_clk_data sun8i_h3_rtc_data = {
 	.fixed_prescaler = 32,
 	.has_prescaler = 1,
 	.has_out_clk = 1,
-	.export_iosc = 1,
 };
 
 static void __init sun8i_h3_rtc_clk_init(struct device_node *node)
@@ -379,7 +372,6 @@ static const struct sun6i_rtc_clk_data sun50i_h6_rtc_data = {
 	.fixed_prescaler = 32,
 	.has_prescaler = 1,
 	.has_out_clk = 1,
-	.export_iosc = 1,
 	.has_losc_en = 1,
 	.has_auto_swt = 1,
 };
-- 
2.37.4

