Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F150A63981C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKZTNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKZTN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:13:29 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8202013DC0;
        Sat, 26 Nov 2022 11:13:28 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F00EE5C00C2;
        Sat, 26 Nov 2022 14:13:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 26 Nov 2022 14:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669490007; x=1669576407; bh=y5
        djLeQ/hPY8ak4OuL7Fb/c3s4IkUrbhmjUh9vU8Iao=; b=II7wBM85JhQYWyaxV6
        ASpiOEvIffOUjAnDJiAbN45q03pZS2YyRfcBePaDgXGE3vTd2dL5+sm+Qt9DTqlZ
        ZGmbjlDWjmUxDUW3v6UnvnRcVaHtWcSmKtIPglaCRGStC/mu905uCq8JfFjmP03t
        r3k7d3ol6idc+IEP/475AV+R2XZyvf0yQktDP7d/CZYCYjbo59CwSW6TlQ+oOSOx
        cCxbUC/ziC+Ya9wHUKpm+8DMpClzsb/jeq83aqGzQMKu+3humIuFj73RaqOw/Swe
        8tN6e0VIh5YzOP6hVgH3eaLUL8qfsBxp3lT+Js41q707N9Z0fxBkRdFhGyWeTRCi
        7NWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669490007; x=1669576407; bh=y5djLeQ/hPY8a
        k4OuL7Fb/c3s4IkUrbhmjUh9vU8Iao=; b=FsdV1FgD9jQRX2/99lfl3XUy/0543
        SeQi0BhzkryRO5iHY8VE0n1BGbwnzUo8C5TDWDPhug9gSHqAeeLRERYTtdTcTdE0
        2HM2MoZBa89RMKre0hgUW+rR+Tuo1Cup0G1T9fyI7Wunj88W9rV1l8dgbRJXr+E/
        7Eig7HmrlmFTXA68e4PW3hVLu2dKaTnkqwRjZqN4LSmRwl4gdER2WV732XOIAmNS
        WKQsLZ+Z/fdUa79qG0dyp9/fLEWea8kWT6SbEWrLWs8XoHYxiNj3otr6VuRH/+/C
        YmrZD4fbjk+5x+mzhjR1TuhGy9LPvWTVsbvkml444RPjFj3SpREgUmJJw==
X-ME-Sender: <xms:V2WCY_yjCaAOaLKzS8cbk9irg9Posedxqfp8IZGwLJplVMLeixhmDQ>
    <xme:V2WCY3RWtcnaxcaccJqJ1vXw7OpyirH_F_y8BUShC2srqyXeLvQxcqD_zG01_N84Y
    mgAPncibU9hpjkYlA>
X-ME-Received: <xmr:V2WCY5VfMhCBNIU-VzFC7bqMN3HN-MKYdDdtqP8Ul1gOqIxp1uRSa911lOesjTmZG8G1agC30E6kHrNLjy-Cua-CV2QwwuFcguEgVD83UzcsqFkJcXEsqR7imOi9JhHLRPxZoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieejgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:V2WCY5j8kb8LtAxPgtKQaKBxFqT5E5crgMYr26cedMKG8bNBXbLTgA>
    <xmx:V2WCYxDhfKI90hdskNeusrfBosmS3oBjILV1xYZxCcuO_M979xwooQ>
    <xmx:V2WCYyLQBj3C7QbzzCYUVSdhpzM58dCbU9OabS5Y9IWXbc5rJBF2fg>
    <xmx:V2WCY168ratK2q8KIKSvGPae6IACFhKO-iRW_T7fUuuHKnKkBpsexg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 14:13:26 -0500 (EST)
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
        Fabien Poussin <fabien.poussin@gmail.com>
Subject: [PATCH 5/5] clk: sunxi-ng: d1: Add CAN bus gates and resets
Date:   Sat, 26 Nov 2022 13:13:19 -0600
Message-Id: <20221126191319.6404-6-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221126191319.6404-1-samuel@sholland.org>
References: <20221126191319.6404-1-samuel@sholland.org>
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

From: Fabien Poussin <fabien.poussin@gmail.com>

The D1 CCU contains gates and resets for two CAN buses. While the CAN
bus controllers are only documented for the T113 SoC, the CCU is the
same across all SoC variants.

Signed-off-by: Fabien Poussin <fabien.poussin@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi-ng/ccu-sun20i-d1.c      | 11 +++++++++++
 drivers/clk/sunxi-ng/ccu-sun20i-d1.h      |  2 +-
 include/dt-bindings/clock/sun20i-d1-ccu.h |  2 ++
 include/dt-bindings/reset/sun20i-d1-ccu.h |  2 ++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
index c5a7df93602c..48a8fb2c43b7 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
@@ -469,6 +469,11 @@ static SUNXI_CCU_GATE_HWS(bus_i2c2_clk, "bus-i2c2", apb1_hws,
 static SUNXI_CCU_GATE_HWS(bus_i2c3_clk, "bus-i2c3", apb1_hws,
 			  0x91c, BIT(3), 0);
 
+static SUNXI_CCU_GATE_HWS(bus_can0_clk, "bus-can0", apb1_hws,
+			  0x92c, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_can1_clk, "bus-can1", apb1_hws,
+			  0x92c, BIT(1), 0);
+
 static const struct clk_parent_data spi_parents[] = {
 	{ .fw_name = "hosc" },
 	{ .hw = &pll_periph0_clk.hw },
@@ -997,6 +1002,8 @@ static struct ccu_common *sun20i_d1_ccu_clks[] = {
 	&bus_i2c1_clk.common,
 	&bus_i2c2_clk.common,
 	&bus_i2c3_clk.common,
+	&bus_can0_clk.common,
+	&bus_can1_clk.common,
 	&spi0_clk.common,
 	&spi1_clk.common,
 	&bus_spi0_clk.common,
@@ -1147,6 +1154,8 @@ static struct clk_hw_onecell_data sun20i_d1_hw_clks = {
 		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
 		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
 		[CLK_BUS_I2C3]		= &bus_i2c3_clk.common.hw,
+		[CLK_BUS_CAN0]		= &bus_can0_clk.common.hw,
+		[CLK_BUS_CAN1]		= &bus_can1_clk.common.hw,
 		[CLK_SPI0]		= &spi0_clk.common.hw,
 		[CLK_SPI1]		= &spi1_clk.common.hw,
 		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
@@ -1252,6 +1261,8 @@ static struct ccu_reset_map sun20i_d1_ccu_resets[] = {
 	[RST_BUS_I2C1]		= { 0x91c, BIT(17) },
 	[RST_BUS_I2C2]		= { 0x91c, BIT(18) },
 	[RST_BUS_I2C3]		= { 0x91c, BIT(19) },
+	[RST_BUS_CAN0]		= { 0x92c, BIT(16) },
+	[RST_BUS_CAN1]		= { 0x92c, BIT(17) },
 	[RST_BUS_SPI0]		= { 0x96c, BIT(16) },
 	[RST_BUS_SPI1]		= { 0x96c, BIT(17) },
 	[RST_BUS_EMAC]		= { 0x97c, BIT(16) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1.h b/drivers/clk/sunxi-ng/ccu-sun20i-d1.h
index e303176f0d4e..b14da36e2537 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1.h
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1.h
@@ -10,6 +10,6 @@
 #include <dt-bindings/clock/sun20i-d1-ccu.h>
 #include <dt-bindings/reset/sun20i-d1-ccu.h>
 
-#define CLK_NUMBER		(CLK_FANOUT2 + 1)
+#define CLK_NUMBER		(CLK_BUS_CAN1 + 1)
 
 #endif /* _CCU_SUN20I_D1_H_ */
diff --git a/include/dt-bindings/clock/sun20i-d1-ccu.h b/include/dt-bindings/clock/sun20i-d1-ccu.h
index e3ac53315e1a..e143b9929763 100644
--- a/include/dt-bindings/clock/sun20i-d1-ccu.h
+++ b/include/dt-bindings/clock/sun20i-d1-ccu.h
@@ -152,5 +152,7 @@
 #define CLK_FANOUT0		142
 #define CLK_FANOUT1		143
 #define CLK_FANOUT2		144
+#define CLK_BUS_CAN0		145
+#define CLK_BUS_CAN1		146
 
 #endif /* _DT_BINDINGS_CLK_SUN20I_D1_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun20i-d1-ccu.h b/include/dt-bindings/reset/sun20i-d1-ccu.h
index de9ff5203239..f8001cf50bf1 100644
--- a/include/dt-bindings/reset/sun20i-d1-ccu.h
+++ b/include/dt-bindings/reset/sun20i-d1-ccu.h
@@ -73,5 +73,7 @@
 #define RST_BUS_DSP_CFG		63
 #define RST_BUS_DSP_DBG		64
 #define RST_BUS_RISCV_CFG	65
+#define RST_BUS_CAN0		66
+#define RST_BUS_CAN1		67
 
 #endif /* _DT_BINDINGS_RST_SUN20I_D1_CCU_H_ */
-- 
2.37.4

