Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808E8627490
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiKNCWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiKNCVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:21:48 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C4FF59C;
        Sun, 13 Nov 2022 18:21:37 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7BBAD3200919;
        Sun, 13 Nov 2022 21:21:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 13 Nov 2022 21:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668392496; x=1668478896; bh=gj
        Txd/OJ3XJY9Y9W7MUwj9LbmBQtUOqoYWx80cWH4tA=; b=dv9RTRgh0sYupDLwTl
        1jiL05KjhZ3cPsZwCHIh8u/HNuoCOyWmMo18j0BF6bLzEmGERmWbt6k0u3aomUnb
        YYHmwjgoAQTjmBnGOr1v840kg52Wf/J0xz36ZHthYM6mrX/HmYhfMqoSbKwDNaaH
        f4karJO+BiVcWoCqaHcigFUgCD/zxZ0YGVvQGxlFWSGatZmUqCahownObk9w/hpN
        p3svfgj8LNucGbXdeM6Zm6FwYZZY9Zub8Q5mWPXRD1jnme8mZTaI0jSWhvy+eHCT
        oK9ljUpR93MJvKzZDu2JT6nv2C94RH+xl06jYYDpA6nsKbS3G4JfQWUuT5x+AqGE
        z9Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668392496; x=1668478896; bh=gjTxd/OJ3XJY9
        Y9W7MUwj9LbmBQtUOqoYWx80cWH4tA=; b=eDe5SHgitCLCmhqOB38VQdkdhxkUL
        td2WQK2rki7jIoZd9+vCH0fjf3CJRMs4AT13upvh67rh6YjYIY9BTG9LsNgJKHq/
        FGuWLAGIvAuLP4xL6+XuinTkaGArlldg22AKwQY4mo8ZZ9ArG8QqYNTUD40D7izc
        Wv2mW+PVvTq/+1ZVl/9HgN/IBdEZGxsE4cqo0xmIuXJOplvfxu7a4Q0rYeWgr/Nm
        bD3kTDb/oI7WwZRbzbZYl7Liy7/SzPFbdlor+vwZNu964j8usJ7dWo0veVAUNgEu
        pn/eEWqnS2/PSlhh9jyeQHi88UJmyEZ19OBMo0Jnw2qt2dNAvlm7rHEsw==
X-ME-Sender: <xms:L6ZxYy70vmvPesL2emIiDveT2AK6pQft1C5gsO_CNewfZuNyR_-m_g>
    <xme:L6ZxY75nDbbXv6MM1NjPa4BFdIgQeGUCYk2yP4ODoy8lFWAIzU7qwUZmsKbkNsX0H
    Hy_3qiiZUxyuHeEqw>
X-ME-Received: <xmr:L6ZxYxc4cu2tE1xgmyTvRcoXE-AW2pwcI6LwrSm4FeVUE2u10X3opvec_YRFocdkTkd0YTuPByfeSRNjnVbLdHi-iiyQ43qeapo1216FdBGlTSqkuLpMyNfe7YKvL51BMdQ3nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:MKZxY_L3HaR6rSkgY7s2-U0OTFig8o0FXzy5KbXmKrvYlhfHLuqPmg>
    <xmx:MKZxY2LC4XhibtHVVqhy2mUynDuocDiYxCDAZkKrY8hpcjSnE2tSdQ>
    <xmx:MKZxYwxsAvwlTlKwvJexvWXDzzZCw4Yf8hJr6EaEtrPrWA9JYpMaVA>
    <xmx:MKZxY4BHqOppT4HEqHzbVnyZInEKPZ3ulJ2izQouUKydiry5fIfnrQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 21:21:35 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 8/8] phy: allwinner: phy-sun6i-mipi-dphy: Add the A100 DPHY variant
Date:   Sun, 13 Nov 2022 20:21:13 -0600
Message-Id: <20221114022113.31694-9-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221114022113.31694-1-samuel@sholland.org>
References: <20221114022113.31694-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A100 features an updated DPHY, which moves PLL control inside the DPHY
register space (previously the PLL was controlled from the CCU). It also
requires a modified analog power-on sequence. This "combo PHY" can also
be used as an LVDS PHY, but that is not yet supported by the driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 143 +++++++++++++++++++-
 1 file changed, 142 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index ac144ee0f0a6..36eab95271b2 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -70,11 +70,19 @@
 
 #define SUN6I_DPHY_ANA0_REG		0x4c
 #define SUN6I_DPHY_ANA0_REG_PWS			BIT(31)
+#define SUN6I_DPHY_ANA0_REG_PWEND		BIT(30)
+#define SUN6I_DPHY_ANA0_REG_PWENC		BIT(29)
 #define SUN6I_DPHY_ANA0_REG_DMPC		BIT(28)
 #define SUN6I_DPHY_ANA0_REG_DMPD(n)		(((n) & 0xf) << 24)
+#define SUN6I_DPHY_ANA0_REG_SRXDT(n)		(((n) & 0xf) << 20)
+#define SUN6I_DPHY_ANA0_REG_SRXCK(n)		(((n) & 0xf) << 16)
+#define SUN6I_DPHY_ANA0_REG_SDIV2		BIT(15)
 #define SUN6I_DPHY_ANA0_REG_SLV(n)		(((n) & 7) << 12)
 #define SUN6I_DPHY_ANA0_REG_DEN(n)		(((n) & 0xf) << 8)
+#define SUN6I_DPHY_ANA0_REG_PLR(n)		(((n) & 0xf) << 4)
 #define SUN6I_DPHY_ANA0_REG_SFB(n)		(((n) & 3) << 2)
+#define SUN6I_DPHY_ANA0_REG_RSD			BIT(1)
+#define SUN6I_DPHY_ANA0_REG_SELSCK		BIT(0)
 
 #define SUN6I_DPHY_ANA1_REG		0x50
 #define SUN6I_DPHY_ANA1_REG_VTTMODE		BIT(31)
@@ -97,8 +105,13 @@
 #define SUN6I_DPHY_ANA3_EN_LDOR			BIT(18)
 
 #define SUN6I_DPHY_ANA4_REG		0x5c
+#define SUN6I_DPHY_ANA4_REG_EN_MIPI		BIT(31)
+#define SUN6I_DPHY_ANA4_REG_EN_COMTEST		BIT(30)
+#define SUN6I_DPHY_ANA4_REG_COMTEST(n)		(((n) & 3) << 28)
+#define SUN6I_DPHY_ANA4_REG_IB(n)		(((n) & 3) << 25)
 #define SUN6I_DPHY_ANA4_REG_DMPLVC		BIT(24)
 #define SUN6I_DPHY_ANA4_REG_DMPLVD(n)		(((n) & 0xf) << 20)
+#define SUN6I_DPHY_ANA4_REG_VTT_SET(n)		(((n) & 0x7) << 17)
 #define SUN6I_DPHY_ANA4_REG_CKDV(n)		(((n) & 0x1f) << 12)
 #define SUN6I_DPHY_ANA4_REG_TMSC(n)		(((n) & 3) << 10)
 #define SUN6I_DPHY_ANA4_REG_TMSD(n)		(((n) & 3) << 8)
@@ -109,6 +122,56 @@
 
 #define SUN6I_DPHY_DBG5_REG		0xf4
 
+#define SUN50I_DPHY_TX_SLEW_REG0	0xf8
+#define SUN50I_DPHY_TX_SLEW_REG1	0xfc
+#define SUN50I_DPHY_TX_SLEW_REG2	0x100
+
+#define SUN50I_DPHY_PLL_REG0		0x104
+#define SUN50I_DPHY_PLL_REG0_CP36_EN		BIT(23)
+#define SUN50I_DPHY_PLL_REG0_LDO_EN		BIT(22)
+#define SUN50I_DPHY_PLL_REG0_EN_LVS		BIT(21)
+#define SUN50I_DPHY_PLL_REG0_PLL_EN		BIT(20)
+#define SUN50I_DPHY_PLL_REG0_P(n)		(((n) & 0xf) << 16)
+#define SUN50I_DPHY_PLL_REG0_N(n)		(((n) & 0xff) << 8)
+#define SUN50I_DPHY_PLL_REG0_NDET		BIT(7)
+#define SUN50I_DPHY_PLL_REG0_TDIV		BIT(6)
+#define SUN50I_DPHY_PLL_REG0_M0(n)		(((n) & 3) << 4)
+#define SUN50I_DPHY_PLL_REG0_M1(n)		((n) & 0xf)
+
+#define SUN50I_DPHY_PLL_REG1		0x108
+#define SUN50I_DPHY_PLL_REG1_UNLOCK_MDSEL(n)	(((n) & 3) << 14)
+#define SUN50I_DPHY_PLL_REG1_LOCKMDSEL		BIT(13)
+#define SUN50I_DPHY_PLL_REG1_LOCKDET_EN		BIT(12)
+#define SUN50I_DPHY_PLL_REG1_VSETA(n)		(((n) & 0x7) << 9)
+#define SUN50I_DPHY_PLL_REG1_VSETD(n)		(((n) & 0x7) << 6)
+#define SUN50I_DPHY_PLL_REG1_LPF_SW		BIT(5)
+#define SUN50I_DPHY_PLL_REG1_ICP_SEL(n)		(((n) & 3) << 3)
+#define SUN50I_DPHY_PLL_REG1_ATEST_SEL(n)	(((n) & 3) << 1)
+#define SUN50I_DPHY_PLL_REG1_TEST_EN		BIT(0)
+
+#define SUN50I_DPHY_PLL_REG2		0x10c
+#define SUN50I_DPHY_PLL_REG2_SDM_EN		BIT(31)
+#define SUN50I_DPHY_PLL_REG2_FF_EN		BIT(30)
+#define SUN50I_DPHY_PLL_REG2_SS_EN		BIT(29)
+#define SUN50I_DPHY_PLL_REG2_SS_FRAC(n)		(((n) & 0x1ff) << 20)
+#define SUN50I_DPHY_PLL_REG2_SS_INT(n)		(((n) & 0xff) << 12)
+#define SUN50I_DPHY_PLL_REG2_FRAC(n)		((n) & 0xfff)
+
+#define SUN50I_COMBO_PHY_REG0		0x110
+#define SUN50I_COMBO_PHY_REG0_EN_TEST_COMBOLDO	BIT(5)
+#define SUN50I_COMBO_PHY_REG0_EN_TEST_0P8	BIT(4)
+#define SUN50I_COMBO_PHY_REG0_EN_MIPI		BIT(3)
+#define SUN50I_COMBO_PHY_REG0_EN_LVDS		BIT(2)
+#define SUN50I_COMBO_PHY_REG0_EN_COMBOLDO	BIT(1)
+#define SUN50I_COMBO_PHY_REG0_EN_CP		BIT(0)
+
+#define SUN50I_COMBO_PHY_REG1		0x114
+#define SUN50I_COMBO_PHY_REG2_REG_VREF1P6(n)	(((n) & 0x7) << 4)
+#define SUN50I_COMBO_PHY_REG2_REG_VREF0P8(n)	((n) & 0x7)
+
+#define SUN50I_COMBO_PHY_REG2		0x118
+#define SUN50I_COMBO_PHY_REG2_HS_STOP_DLY(n)	((n) & 0xff)
+
 enum sun6i_dphy_direction {
 	SUN6I_DPHY_DIRECTION_TX,
 	SUN6I_DPHY_DIRECTION_RX,
@@ -196,6 +259,76 @@ static void sun6i_a31_mipi_dphy_tx_power_on(struct sun6i_dphy *dphy)
 	udelay(1);
 }
 
+static void sun50i_a100_mipi_dphy_tx_power_on(struct sun6i_dphy *dphy)
+{
+	unsigned long mipi_symbol_rate = dphy->config.hs_clk_rate;
+	unsigned int div, n;
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA4_REG,
+		     SUN6I_DPHY_ANA4_REG_IB(2) |
+		     SUN6I_DPHY_ANA4_REG_DMPLVD(4) |
+		     SUN6I_DPHY_ANA4_REG_VTT_SET(3) |
+		     SUN6I_DPHY_ANA4_REG_CKDV(3) |
+		     SUN6I_DPHY_ANA4_REG_TMSD(1) |
+		     SUN6I_DPHY_ANA4_REG_TMSC(1) |
+		     SUN6I_DPHY_ANA4_REG_TXPUSD(2) |
+		     SUN6I_DPHY_ANA4_REG_TXPUSC(3) |
+		     SUN6I_DPHY_ANA4_REG_TXDNSD(2) |
+		     SUN6I_DPHY_ANA4_REG_TXDNSC(3));
+
+	regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA2_REG,
+			   SUN6I_DPHY_ANA2_EN_CK_CPU,
+			   SUN6I_DPHY_ANA2_EN_CK_CPU);
+
+	regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA2_REG,
+			   SUN6I_DPHY_ANA2_REG_ENIB,
+			   SUN6I_DPHY_ANA2_REG_ENIB);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA3_REG,
+		     SUN6I_DPHY_ANA3_EN_LDOR |
+		     SUN6I_DPHY_ANA3_EN_LDOC |
+		     SUN6I_DPHY_ANA3_EN_LDOD);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA0_REG,
+		     SUN6I_DPHY_ANA0_REG_PLR(4) |
+		     SUN6I_DPHY_ANA0_REG_SFB(1));
+
+	regmap_write(dphy->regs, SUN50I_COMBO_PHY_REG0,
+		     SUN50I_COMBO_PHY_REG0_EN_CP);
+
+	/* Choose a divider to limit the VCO frequency to around 2 GHz. */
+	div = 16 >> order_base_2(DIV_ROUND_UP(mipi_symbol_rate, 264000000));
+	n = mipi_symbol_rate * div / 24000000;
+
+	regmap_write(dphy->regs, SUN50I_DPHY_PLL_REG0,
+		     SUN50I_DPHY_PLL_REG0_CP36_EN |
+		     SUN50I_DPHY_PLL_REG0_LDO_EN |
+		     SUN50I_DPHY_PLL_REG0_EN_LVS |
+		     SUN50I_DPHY_PLL_REG0_PLL_EN |
+		     SUN50I_DPHY_PLL_REG0_NDET |
+		     SUN50I_DPHY_PLL_REG0_P((div - 1) % 8) |
+		     SUN50I_DPHY_PLL_REG0_N(n) |
+		     SUN50I_DPHY_PLL_REG0_M0((div - 1) / 8) |
+		     SUN50I_DPHY_PLL_REG0_M1(2));
+
+	/* Disable sigma-delta modulation. */
+	regmap_write(dphy->regs, SUN50I_DPHY_PLL_REG2, 0);
+
+	regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA4_REG,
+			   SUN6I_DPHY_ANA4_REG_EN_MIPI,
+			   SUN6I_DPHY_ANA4_REG_EN_MIPI);
+
+	regmap_update_bits(dphy->regs, SUN50I_COMBO_PHY_REG0,
+			   SUN50I_COMBO_PHY_REG0_EN_MIPI |
+			   SUN50I_COMBO_PHY_REG0_EN_COMBOLDO,
+			   SUN50I_COMBO_PHY_REG0_EN_MIPI |
+			   SUN50I_COMBO_PHY_REG0_EN_COMBOLDO);
+
+	regmap_write(dphy->regs, SUN50I_COMBO_PHY_REG2,
+		     SUN50I_COMBO_PHY_REG2_HS_STOP_DLY(20));
+	udelay(1);
+}
+
 static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
 {
 	u8 lanes_mask = GENMASK(dphy->config.lanes - 1, 0);
@@ -408,7 +541,7 @@ static const struct regmap_config sun6i_dphy_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= SUN6I_DPHY_DBG5_REG,
+	.max_register	= SUN50I_COMBO_PHY_REG2,
 	.name		= "mipi-dphy",
 };
 
@@ -484,11 +617,19 @@ static const struct sun6i_dphy_variant sun6i_a31_mipi_dphy_variant = {
 	.rx_supported	= true,
 };
 
+static const struct sun6i_dphy_variant sun50i_a100_mipi_dphy_variant = {
+	.tx_power_on	= sun50i_a100_mipi_dphy_tx_power_on,
+};
+
 static const struct of_device_id sun6i_dphy_of_table[] = {
 	{
 		.compatible	= "allwinner,sun6i-a31-mipi-dphy",
 		.data		= &sun6i_a31_mipi_dphy_variant,
 	},
+	{
+		.compatible	= "allwinner,sun50i-a100-mipi-dphy",
+		.data		= &sun50i_a100_mipi_dphy_variant,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dphy_of_table);
-- 
2.37.3

