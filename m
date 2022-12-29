Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6468C659083
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiL2Skd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiL2SkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:40:17 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A730D104;
        Thu, 29 Dec 2022 10:40:17 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2B459320077A;
        Thu, 29 Dec 2022 13:40:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 29 Dec 2022 13:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672339215; x=1672425615; bh=XR
        9sJUSnhveDvOfDAvp56v1RweLMdB53meAwdF02cGM=; b=N0fNr3t6UvfhplTozx
        Rbz/dUEf8E2IIcKlF41KO5XnFrBj6L4MGi5ZJ1mAfMpi6MR+mqJ5dPSh+9kG+BfI
        CA/4AhdUHh66wEM3pxcWyta8ITan+L5tSNReyVXAftD0huvpVqXdt6laDtzzj5gx
        83vwdiqqUN2ZSuMhGHeiRmf2OV6HO1hvPWcBPGTO0r/3J12aNoSdCtBZVNju0eTM
        KGor7cTeV6Z4aEl2NpWaUtCTSyJAjQO98T5DoPrtyEIInyR74HhN72d9fYOVIQy4
        zBng3qD5Nmp+OY65mM1GDScwT7Iyl+7RSqFqIQyDxxHa8Pwb+41kFeYhorkPSkzm
        bh7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672339215; x=1672425615; bh=XR9sJUSnhveDv
        OfDAvp56v1RweLMdB53meAwdF02cGM=; b=SVNBHGKcbZ/cWQTSov09qLPC2vaj8
        lfh04OXhzg90OzEVhjZhmhtIYYAo2aH43w8+LDTIhz3RjQZQV6Hqm1YGwzqbR2Cj
        pswyHAIglD7NWMK0dHorfvKGaxDnD7B14giTCexe+EFYjQHgSZMgYt6840tsM/Wq
        i7f+CQBCzk9ZbhCOH+zHJCDO1h7wwZFU65XgRitp57hrW+9pUR9hjRLBoloG+w3Q
        Uq3OGAh2tWTjRwhZQHQCZQDYtpo9HnQKVY4onivq03ELq05yWcsObpdxOvfmzyYP
        ZOkXgcVNrO6tbYHhBAez91wI1iiyqMsaNekGz4TdtJjJR8QTGF56zZ0XA==
X-ME-Sender: <xms:D9-tY3s1Nfnf30l-cajceMvXLYT3vLEJVSSh9N4a2S_SIvKJP-go4Q>
    <xme:D9-tY4djDikxAL3EmcWo3cM-FVETtlgPjToJmBtWyFcqKEkTG0iVG4FNOVPUX2XdO
    wh-dGHO1Vvb3YBF4Q>
X-ME-Received: <xmr:D9-tY6wCYDLnN-228A6PcfJSrRtZlmDGMaqN0hpKdk9O3MQOmULxlTuvqB8wrJCIW32RKFJu3g6ahiBp5JyAbcOxpi3Pqr1dZtuo-i41z3YWOyBxoSzE9pW7y6ZsoxaW46PGYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:D9-tY2MXu5j4ksFSEX1dTGlaXq9lDikFJRmVKtR7BVAsyLlQ45u1tQ>
    <xmx:D9-tY3-rM8TY1ZS-EdVmmcw0dQlUnWxmsTIxQ24R9YUw8I8GetCmTg>
    <xmx:D9-tY2W7DrLMRZUgCoOqA577crKuTlAyDqOwnPLAVdmo0H6FENlTdA>
    <xmx:D9-tY4PdAzWeNemUnjOM-qrM1XgOJ1X3rHkuaSdAPySATjnqSp1o5Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 13:40:15 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/2] rtc: sun6i: Drop the unused has_out_clk flag
Date:   Thu, 29 Dec 2022 12:40:11 -0600
Message-Id: <20221229184011.62925-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221229184011.62925-1-samuel@sholland.org>
References: <20221229184011.62925-1-samuel@sholland.org>
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

This flag was never used by the driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/rtc/rtc-sun6i.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index a22358a44e32..52049f139474 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -135,7 +135,6 @@ struct sun6i_rtc_clk_data {
 	unsigned long rc_osc_rate;
 	unsigned int fixed_prescaler : 16;
 	unsigned int has_prescaler : 1;
-	unsigned int has_out_clk : 1;
 	unsigned int export_iosc : 1;
 	unsigned int has_losc_en : 1;
 	unsigned int has_auto_swt : 1;
@@ -346,7 +345,6 @@ CLK_OF_DECLARE_DRIVER(sun6i_a31_rtc_clk, "allwinner,sun6i-a31-rtc",
 static const struct sun6i_rtc_clk_data sun8i_a23_rtc_data = {
 	.rc_osc_rate = 667000, /* datasheet says 600 ~ 700 KHz */
 	.has_prescaler = 1,
-	.has_out_clk = 1,
 };
 
 static void __init sun8i_a23_rtc_clk_init(struct device_node *node)
@@ -360,7 +358,6 @@ static const struct sun6i_rtc_clk_data sun8i_h3_rtc_data = {
 	.rc_osc_rate = 16000000,
 	.fixed_prescaler = 32,
 	.has_prescaler = 1,
-	.has_out_clk = 1,
 	.export_iosc = 1,
 };
 
@@ -378,7 +375,6 @@ static const struct sun6i_rtc_clk_data sun50i_h6_rtc_data = {
 	.rc_osc_rate = 16000000,
 	.fixed_prescaler = 32,
 	.has_prescaler = 1,
-	.has_out_clk = 1,
 	.export_iosc = 1,
 	.has_losc_en = 1,
 	.has_auto_swt = 1,
@@ -409,7 +405,6 @@ CLK_OF_DECLARE_DRIVER(sun8i_r40_rtc_clk, "allwinner,sun8i-r40-rtc",
 
 static const struct sun6i_rtc_clk_data sun8i_v3_rtc_data = {
 	.rc_osc_rate = 32000,
-	.has_out_clk = 1,
 };
 
 static void __init sun8i_v3_rtc_clk_init(struct device_node *node)
-- 
2.37.4

