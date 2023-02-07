Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F15E68DC24
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBGOxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjBGOxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:53:05 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFCCDBEF;
        Tue,  7 Feb 2023 06:53:01 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8F7111BF215;
        Tue,  7 Feb 2023 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675781579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOYznm4VL21EUUk05bJqbcX65FJF0K6wY3GawlNXHF4=;
        b=IjPxO9E22UP1/4uLTTB3HPwn888gzk/MrDrw3HnPudL8Ta5YqIOHSpSa/mRBLWpObP5u+6
        KL1paDBWSdZcYDOgW7BuDfibwluUldZP6Ihcnb3S+N1K63t2H2UFxD6Ren80QDn7v4Qyn0
        pE1e2yVLrMCNV928gQ2ff8ecFGsJTrndzyzI2KtzH5hGMxSkop8O77uz7sm4UMUP5q7VlJ
        Ut2JWpUacySICGKVbNP7XJwQkHUdENmOsqNaUTZTsfqREDatcyajGJQjbVauIAtZtWyHtt
        YIGvxCoCQDQfzWhclufSX6/fHr0g1kc0s3Hr3OvqPWshXB4444vWBrUn4a7ryA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: r9a06g032: add EB board device-tree
Date:   Tue,  7 Feb 2023 15:54:44 +0100
Message-Id: <20230207145444.166950-3-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230207145444.166950-1-clement.leger@bootlin.com>
References: <20230207145444.166950-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EB board (Expansion board) supports both RZ/N1D and RZ-N1S. Since this
configuration targets only the RZ/N1D, it is named r9a06g032-rzn1d400-eb.
It adds support for the 2 additional switch ports (port C and D) that are
available on that board.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts | 92 +++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d08a3c450ce7..8938db01e939 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1123,6 +1123,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7794-alt.dtb \
 	r8a7794-silk.dtb \
 	r9a06g032-rzn1d400-db.dtb \
+	r9a06g032-rzn1d400-eb.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rv1108-elgin-r1.dtb \
diff --git a/arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts b/arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts
new file mode 100644
index 000000000000..e986b6d2fd6f
--- /dev/null
+++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the RZN1D-EB Board
+ *
+ * Copyright (C) 2023 Schneider-Electric
+ *
+ */
+
+#include "r9a06g032-rzn1d400-db.dts"
+
+/ {
+	model = "RZN1D-EB Board";
+	compatible = "renesas,rzn1d400-eb", "renesas,r9a06g032";
+};
+
+&mii_conv2 {
+	renesas,miic-input = <MIIC_SWITCH_PORTD>;
+	status = "okay";
+};
+
+&mii_conv3 {
+	renesas,miic-input = <MIIC_SWITCH_PORTC>;
+	status = "okay";
+};
+
+&pinctrl{
+	pins_eth1: pins_eth1 {
+		pinmux = <RZN1_PINMUX(12, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(13, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(14, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(15, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(16, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(17, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(18, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(19, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(20, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(21, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(22, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(23, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>;
+		drive-strength = <6>;
+		bias-disable;
+	};
+
+	pins_eth2: pins_eth2 {
+		pinmux = <RZN1_PINMUX(24, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(25, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(26, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(27, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(28, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(29, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(30, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(31, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(32, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(33, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(34, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
+			 <RZN1_PINMUX(35, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>;
+		drive-strength = <6>;
+		bias-disable;
+	};
+};
+
+&switch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_eth1>, <&pins_eth2>, <&pins_eth3>, <&pins_eth4>, <&pins_mdio1>;
+
+	mdio {
+		/* CN15 and CN16 switches must be configured in MDIO2 mode */
+		switch0phy1: ethernet-phy@1 {
+			reg = <1>;
+			marvell,reg-init = <3 16 0 0x1010>;
+		};
+
+		switch0phy10: ethernet-phy@10 {
+			reg = <10>;
+			marvell,reg-init = <3 16 0 0x1010>;
+		};
+	};
+};
+
+&switch_port2 {
+	label = "lan2";
+	phy-mode = "rgmii-id";
+	phy-handle = <&switch0phy10>;
+	status = "okay";
+};
+
+&switch_port3 {
+	label = "lan3";
+	phy-mode = "rgmii-id";
+	phy-handle = <&switch0phy1>;
+	status = "okay";
+};
-- 
2.39.0

