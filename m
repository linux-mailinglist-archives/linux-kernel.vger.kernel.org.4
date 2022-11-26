Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C50863981A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKZTNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKZTN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:13:28 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB6DBF76;
        Sat, 26 Nov 2022 11:13:27 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AA3E85C00A3;
        Sat, 26 Nov 2022 14:13:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 26 Nov 2022 14:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669490006; x=
        1669576406; bh=dmPnymUtjq/JHP8L1TCfy8BtIL4oJAbNtHMY/IeTwdw=; b=a
        mvj/CoTPCviawXVgMgySfk4OBs5KTfm9fF6sD27zkQIhN3lThhRu/Fn55aL1svol
        sFgUSfa1IgYauU+52RCXscLqWAP6adFc9VAjXgQk0xqT/cJ9X+3OWlzv+y6xVzCA
        CQLboK2TE48/Z1BILY/w6klY9Sxwk2Iwwq9mJd8psTmq0HvoHCfz/wtMVlLZ8RJF
        d0dhkI8bOONIBNSX7GIc7Q3aoe7Wv9bIYgD+cpKCSbP0Av3rdt7Refy60ADSdDsB
        FjJRtDoMBy4CQaB7fPZPsINZxvW8jwuEgfm5sUx2BrpewXQUv3WLuLD91QyGlQCf
        P4UlRqTScpAYHgNOQKEKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669490006; x=
        1669576406; bh=dmPnymUtjq/JHP8L1TCfy8BtIL4oJAbNtHMY/IeTwdw=; b=J
        MpUEw86nYlFuZ9yysjlKrxt3m37pvg92ERJXqn07PesK21U85Q3sZwrV0voeyOdc
        9y5wLt1zeCAgQNVbqdqfsXaar0ABZZ3z/70N/Qw9CQle7CojD7HGIuRMBozu886p
        WRx6O6rzrWFXPtiMUsvIlw9BJd6DbZNRce2mPXV5sf0o+dZl/NM6sh8ZK2gUrwxN
        csgA1evU9CP8TvB0ZT1tMhIYoboXk8JljMSKQnc1iOjZSDSzKcTvK8Pjehr3EBsW
        Gzjl2ar0IY7jgUe8yqXk5zrng09CKFsJaHmQHfWam0Gz2FG0JkOD1xtbXzuXX1g6
        01A0q4al+Ldwpa5Ogqvzw==
X-ME-Sender: <xms:VmWCYzAaFjuZAAM7CG2zl15U9JoMghOHPWabMvhUFAvfOPBb9bE1ag>
    <xme:VmWCY5hiJhD-vfKlRH9ee1HnlUkXwwhTg8rSsRSWUX22hoXe8UsWcrA7FE0k7-9RU
    S8YzRE9lg4LxilYdg>
X-ME-Received: <xmr:VmWCY-nibAgrY4e9TO_poHH7mIDJP-kpwhUHCoPb2Be0MK4TnOB46YpGzo4IbJ5Dy3cEHmdS03zVlFdAEpOeBxSsWzhhWKwTtu9I20fyq8zR_JlAwsUvQatxIUMuJZCmXZT_VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieejgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeefueevueeffeelheelhfelgeelgffgieekffevteefveejueei
    teeugfefieehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:VmWCY1xf6evuPWoLiy71HA3yQ2T9V-EwH_EzAP_ogKHLyDmaLtcJOA>
    <xmx:VmWCY4QGHguvfZX-Cv7qLMS_vWrkPfZ43PuizfSo-XfX7ID0lIn9cQ>
    <xmx:VmWCY4b6ObCgAdFSl9U8A5Zos__lKIHyEWcIKrxsN9zRT6AQi0Tdng>
    <xmx:VmWCY_LtTvFfjz1JlrPfB2c9rTta14sbNLZcT7cxGw8InInNIsz7Yw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 14:13:25 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        =?UTF-8?q?Andr=C3=A1s=20Szemz=C5=91?= <szemzo.andras@gmail.com>
Subject: [PATCH 4/5] clk: sunxi-ng: d1: Mark cpux clock as critical
Date:   Sat, 26 Nov 2022 13:13:18 -0600
Message-Id: <20221126191319.6404-5-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221126191319.6404-1-samuel@sholland.org>
References: <20221126191319.6404-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: András Szemző <szemzo.andras@gmail.com>

Some SoCs in the D1 family feature ARM CPUs instead of a RISC-V CPU.
In that case, the CPUs are driven from the 'cpux' clock, so it needs
to be marked as critical.

Signed-off-by: András Szemző <szemzo.andras@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi-ng/ccu-sun20i-d1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
index 8ef3cdeb7962..c5a7df93602c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
@@ -240,7 +240,7 @@ static const struct clk_parent_data cpux_parents[] = {
 	{ .hw = &pll_periph0_800M_clk.common.hw },
 };
 static SUNXI_CCU_MUX_DATA(cpux_clk, "cpux", cpux_parents,
-			  0x500, 24, 3, CLK_SET_RATE_PARENT);
+			  0x500, 24, 3, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
 
 static const struct clk_hw *cpux_hws[] = { &cpux_clk.common.hw };
 static SUNXI_CCU_M_HWS(cpux_axi_clk, "cpux-axi",
-- 
2.37.4

