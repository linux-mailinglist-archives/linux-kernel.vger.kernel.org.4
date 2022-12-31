Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E691B65A817
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiLaXPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiLaXOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:14:41 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DA7C3E;
        Sat, 31 Dec 2022 15:14:39 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5CAEF5C00B3;
        Sat, 31 Dec 2022 18:14:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 31 Dec 2022 18:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672528479; x=1672614879; bh=pg
        xRkLVAeO8dCA2lni0EjX3wjL3SuhpZ2d2IUeSoyX4=; b=uWwnaU0FUJybKnzekx
        7GvVkb3zmMP4lUfD0rIW437xXNPx7wE2O1L6nz/EySfo0VwTMGjqO/ocDYxdNxi8
        oeCP4A9XYFE6Od+lEqwukZawvIsD7h509NdAqQAJctJC0chA+2o6BsojKgXoAash
        afSzVaecBM+sicUFhSaqHB1ewgIOdSXGJaDZyiDiP27vEf0yXAFQ9cJQGDkkXhTz
        srCcKzxomOKUpwbEKgU2L69cbislukLbTXC7+golOfuW9NuDqNBHslubAjDi3leI
        P2A9uMecpGzMJRfK4Pdc46zrrrQu9/VfL5eUkH/RpfCYm5s/sxTvWAi+SsBmMZ8l
        pXIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672528479; x=1672614879; bh=pgxRkLVAeO8dC
        A2lni0EjX3wjL3SuhpZ2d2IUeSoyX4=; b=l/TuFeE4R9matdLE6FArCbqPjLdac
        P6b8eiEbMOTVxvW5InqH9CjNuzr9UzoAHkBRqcCrOPcXvN/NIsa/hYjNkffExMRm
        xdmL0MA022oOvU8WJ0K/q7LiGdW06AbGo+u2+vOsTs5ED39SEpaoJn72PXscQQfa
        ViJeRm2/yj/vDgBbkDgQu0ti062iPfZ8hp9Ri2MlCUcx6Yy7/9qoNSo89ly6itmq
        OFjiGEfCeNGehKlx1t0/lVMv0RrDXUdbzIn8jvvk/wo5OQ1XmXbMNaSUWuoIuIcK
        PWh2RGIICUwSqW6LJ55pPmAmil9No4rV6wCnVJld/EjSNORKN41vAY8Kg==
X-ME-Sender: <xms:X8KwYwxWQ_Y1KxWOhITxlHfDBkj4Ib9nXYl6bVjussY-LVpmIlwtfA>
    <xme:X8KwY0SHAF2XW6O4DkDDGOXH0iTpG1hurMyATF3N6fpaVZ5ET_yPVtc2I_X_UR_3S
    o1xxajGRpDIhmM4cg>
X-ME-Received: <xmr:X8KwYyUI0bTe8GZTuXIS3ZRvb7pl4TlSGIRzErK4tgMwC968K7wovob4JnWYo6xXv3QnhKth-4_nMR2qo4thidrFySqYubRyO--kg-SjvCnOFMNmn_ter1cFMHXS0ID_mhauAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:X8KwY-ghUad1MtJqSqSQ4IiLKhSCXRd2kHBBvOp83BdSpB8nsS5Q-w>
    <xmx:X8KwYyCkJdDpKZLYRLjWbrEvrVSA14fQBoW0deVIa4uRthTYNMCBMQ>
    <xmx:X8KwY_I94v9zX9kps3R65XN5zCRri19Z_kVEbGLJBkqIeOx0eq9KUw>
    <xmx:X8KwY62yi8Uez1pwDpsdEOr1hky3CoSnMhWwAf2iL0XUegc9hp4C6A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:14:38 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 6/6] clk: sunxi-ng: d1: Add CAN bus gates and resets
Date:   Sat, 31 Dec 2022 17:14:29 -0600
Message-Id: <20221231231429.18357-7-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231231429.18357-1-samuel@sholland.org>
References: <20221231231429.18357-1-samuel@sholland.org>
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

From: Fabien Poussin <fabien.poussin@gmail.com>

The D1 CCU contains gates and resets for two CAN buses. While the CAN
bus controllers are only documented for the T113 SoC, the CCU is the
same across all SoC variants.

Signed-off-by: Fabien Poussin <fabien.poussin@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Move dt-bindings header changes to a separate patch

 drivers/clk/sunxi-ng/ccu-sun20i-d1.c | 11 +++++++++++
 drivers/clk/sunxi-ng/ccu-sun20i-d1.h |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

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
-- 
2.37.4

