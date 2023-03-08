Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A286B07C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjCHNBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjCHNAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:00:41 -0500
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42828960AC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:00:02 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgQ157qzMrSjr;
        Wed,  8 Mar 2023 13:53:22 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgP4JgKzMsjnP;
        Wed,  8 Mar 2023 13:53:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678280002;
        bh=2FdGXXkjb6i5rEbQ4Rwlc+2/P4vkTUU4G1yrn44tFXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wALnRfzUaQSSqxwHjRl5ePpySHVy+BeOrSZWe7guXWwKMCOKe9UIdRmb9WB6wXOeD
         vzNpB2zaIPhgEfDdPxkJHadhzpj92daBBPcD+QKxUzM8op7qkniMEzA5MRo8E8K9UW
         YaQg4Ftio32pHD8P3o7DJBWzILS1QsCh2Y+GhSFs=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 25/25] arm64: dts: colibri-imx8x: Add iris v2 carrier board
Date:   Wed,  8 Mar 2023 13:52:59 +0100
Message-Id: <20230308125300.58244-26-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add the Toradex Iris V2 Carrier Board for Colibri iMX8X, small form-factor
production ready board.

Additional details available at:
https://www.toradex.com/products/carrier-boards/iris-carrier-board

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../dts/freescale/imx8qxp-colibri-iris-v2.dts | 16 +++++++
 .../dts/freescale/imx8x-colibri-iris-v2.dtsi  | 45 +++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris-v2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8x-colibri-iris-v2.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 48bb0fe4a616..2eb746f6a2c2 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -132,6 +132,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-aster.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris-v2.dts b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris-v2.dts
new file mode 100644
index 000000000000..cca33213fa9b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris-v2.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2021 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8qxp-colibri.dtsi"
+#include "imx8x-colibri-iris-v2.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX8QXP on Colibri Iris V2 Board";
+	compatible = "toradex,colibri-imx8x-iris-v2",
+		     "toradex,colibri-imx8x",
+		     "fsl,imx8qxp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris-v2.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris-v2.dtsi
new file mode 100644
index 000000000000..98202a437040
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris-v2.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2021 Toradex
+ */
+
+#include "imx8x-colibri-iris.dtsi"
+
+/ {
+	reg_3v3_vmmc: regulator-3v3-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_3v3_vmmc>;
+		enable-active-high;
+		gpio = <&lsio_gpio0 31 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3v3_vmmc";
+		startup-delay-us = <100>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds_converter &pinctrl_gpio_iris>;
+
+	pinctrl_enable_3v3_vmmc: enable_3v3_vmmc {
+		fsl,pins = <IMX8QXP_SAI1_RXFS_LSIO_GPIO0_IO31	0x20>;	/* SODIMM 100 */
+	};
+
+	pinctrl_lvds_converter: lcd-lvds {
+		fsl,pins = <IMX8QXP_FLEXCAN1_TX_LSIO_GPIO1_IO18		0x20>,	/* SODIMM  55 */
+			   /* 6B/8B mode. Select LOW - 8B mode (24bit) */
+			   <IMX8QXP_FLEXCAN1_RX_LSIO_GPIO1_IO17		0x20>,	/* SODIMM  63 */
+			   <IMX8QXP_QSPI0B_SCLK_LSIO_GPIO3_IO17		0x20>,	/* SODIMM  95 */
+			   <IMX8QXP_QSPI0B_DATA0_LSIO_GPIO3_IO18	0x20>;	/* SODIMM  99 */
+	};
+};
+
+/* Colibri SD/MMC Card */
+&usdhc2 {
+	cap-power-off-card;
+	/delete-property/ no-1-8-v;
+	vmmc-supply = <&reg_3v3_vmmc>;
+	status = "okay";
+};
-- 
2.39.2

