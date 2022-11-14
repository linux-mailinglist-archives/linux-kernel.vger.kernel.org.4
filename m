Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195AE62748F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiKNCWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbiKNCVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:21:41 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524CD11161;
        Sun, 13 Nov 2022 18:21:35 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D99E7320046E;
        Sun, 13 Nov 2022 21:21:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 13 Nov 2022 21:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668392493; x=1668478893; bh=Ij
        ZjxserGXTvttPKvZ0ovwYSypli2lFE/yrZvqzapxw=; b=qGFkq+xhPS5HTDytAM
        soFfpWfqMMgMmf2YKT4u5PoyI6aaxHQb42nUB00+hXg66W/8bdUjtlZWcIdinqw8
        ZCSi0v8WWWn1dGrPEQ3AJg+BD512iVWLYh/shNB4FXC5rP7VefZKw1ITC+I1bprr
        R2WEIiLvqTIjgD95bWxcmWTm6ScCnfI/kKsvimbCxV7R8iUErqC193X0Pc+zL3Lw
        nonW7dWay5eq0FPObrg3qLOYPW9kEhgedVGO8+FtHdmZjgtVqymA6g1+cTH3sYZ3
        ARVvNnR5jbh1BSURYY/jQMAT6gkSpFWDRIO5IoC1nQOr5/XUAkgi6ZTvL09W1tWc
        gNiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668392493; x=1668478893; bh=IjZjxserGXTvt
        tPKvZ0ovwYSypli2lFE/yrZvqzapxw=; b=ZuHNvXBMtJaEJY+Vh2k2PASdUdLeh
        A9pQJxXGKiM8WQB5XyCySa1y7WX5fb+4ZAQdGAmSSpINUzt4iqvQCo7qWx87l6Vv
        5UBtsvY9OhNxGoQHYfsMkUes4EImPYm3pOypPK51PwUCmqkC1ZEMczsZkjLWHsXm
        ZaXxoa2sGeV6qxB/N5Uttctokq+AEii9IG09fGwSPgFCsnQBUyPWB5n+9Lp6S7Qx
        n4ocMy2lcPD0a3j+eJqg/M++VfgDt3vN2HnrblxggVx/ZOic/fxIiyC5J7AqV70v
        XeSiHDVGKTZhVuJEuzCh4nQTPJwUGD8xIwf3tF3cGsBd+BlekedqTPDHw==
X-ME-Sender: <xms:LaZxY1qXbEvWRVjan2YMXUVAbFwvqEwAfTChog7XYu_GiV8utXPoCQ>
    <xme:LaZxY3ppJYiv4duqIOxbtb01E9ddHTrrnTbS9rxUIwtS2jLOHMoEgenggny8Z2EQ-
    3r2gZltvPmemVLP6g>
X-ME-Received: <xmr:LaZxYyPdiZQkVy9j5XD01BlN6i1w8fFddenOFdpTVHlUqR4uwsdIhnsbnOg8tOpgh5Lryd0vwpB7ukhTmSX8Mox8_MndX5yXjusakwghPk-GmcCDVhjnWelV0Qh6xDZbQh4XCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:LaZxYw4GiJYudbU_Y0TyhtPsh19bEH2ubjiiEW9P3S5byPuBWQfggA>
    <xmx:LaZxY07shkIwhtstXa70bqDZuAHoSJ-4g7PmtU8am_Imlo2P2-4k6w>
    <xmx:LaZxY4hNj4hko1lTllhhuqOxPr4I7UyGVeuCMA6uCb3pf-uYIjfMWw>
    <xmx:LaZxY0y8Jyf6-xHaKH9-yoFEKQfcqm9-5jkf7UaO1dhbHNto5XJd4A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 21:21:32 -0500 (EST)
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
Subject: [PATCH v2 7/8] phy: allwinner: phy-sun6i-mipi-dphy: Add a variant power-on hook
Date:   Sun, 13 Nov 2022 20:21:12 -0600
Message-Id: <20221114022113.31694-8-samuel@sholland.org>
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

The A100 variant uses the same values for the timing registers, and it
uses the same final power-on sequence, but it needs a different analog
register configuration in the middle. Support this by moving the
variant-specific parts to a hook provided by the variant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 59 ++++++++++++---------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index a2afedc399fd..ac144ee0f0a6 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -114,7 +114,10 @@ enum sun6i_dphy_direction {
 	SUN6I_DPHY_DIRECTION_RX,
 };
 
+struct sun6i_dphy;
+
 struct sun6i_dphy_variant {
+	void	(*tx_power_on)(struct sun6i_dphy *dphy);
 	bool	rx_supported;
 };
 
@@ -156,33 +159,10 @@ static int sun6i_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	return 0;
 }
 
-static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
+static void sun6i_a31_mipi_dphy_tx_power_on(struct sun6i_dphy *dphy)
 {
 	u8 lanes_mask = GENMASK(dphy->config.lanes - 1, 0);
 
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_CTL_REG,
-		     SUN6I_DPHY_TX_CTL_HS_TX_CLK_CONT);
-
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME0_REG,
-		     SUN6I_DPHY_TX_TIME0_LP_CLK_DIV(14) |
-		     SUN6I_DPHY_TX_TIME0_HS_PREPARE(6) |
-		     SUN6I_DPHY_TX_TIME0_HS_TRAIL(10));
-
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME1_REG,
-		     SUN6I_DPHY_TX_TIME1_CLK_PREPARE(7) |
-		     SUN6I_DPHY_TX_TIME1_CLK_ZERO(50) |
-		     SUN6I_DPHY_TX_TIME1_CLK_PRE(3) |
-		     SUN6I_DPHY_TX_TIME1_CLK_POST(10));
-
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME2_REG,
-		     SUN6I_DPHY_TX_TIME2_CLK_TRAIL(30));
-
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME3_REG, 0);
-
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME4_REG,
-		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA0(3) |
-		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA1(3));
-
 	regmap_write(dphy->regs, SUN6I_DPHY_ANA0_REG,
 		     SUN6I_DPHY_ANA0_REG_PWS |
 		     SUN6I_DPHY_ANA0_REG_DMPC |
@@ -214,6 +194,36 @@ static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
 		     SUN6I_DPHY_ANA3_EN_LDOC |
 		     SUN6I_DPHY_ANA3_EN_LDOD);
 	udelay(1);
+}
+
+static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
+{
+	u8 lanes_mask = GENMASK(dphy->config.lanes - 1, 0);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_CTL_REG,
+		     SUN6I_DPHY_TX_CTL_HS_TX_CLK_CONT);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME0_REG,
+		     SUN6I_DPHY_TX_TIME0_LP_CLK_DIV(14) |
+		     SUN6I_DPHY_TX_TIME0_HS_PREPARE(6) |
+		     SUN6I_DPHY_TX_TIME0_HS_TRAIL(10));
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME1_REG,
+		     SUN6I_DPHY_TX_TIME1_CLK_PREPARE(7) |
+		     SUN6I_DPHY_TX_TIME1_CLK_ZERO(50) |
+		     SUN6I_DPHY_TX_TIME1_CLK_PRE(3) |
+		     SUN6I_DPHY_TX_TIME1_CLK_POST(10));
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME2_REG,
+		     SUN6I_DPHY_TX_TIME2_CLK_TRAIL(30));
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME3_REG, 0);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME4_REG,
+		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA0(3) |
+		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA1(3));
+
+	dphy->variant->tx_power_on(dphy);
 
 	regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA3_REG,
 			   SUN6I_DPHY_ANA3_EN_VTTC |
@@ -470,6 +480,7 @@ static int sun6i_dphy_probe(struct platform_device *pdev)
 }
 
 static const struct sun6i_dphy_variant sun6i_a31_mipi_dphy_variant = {
+	.tx_power_on	= sun6i_a31_mipi_dphy_tx_power_on,
 	.rx_supported	= true,
 };
 
-- 
2.37.3

