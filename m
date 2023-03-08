Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B91A6B07D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjCHNCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjCHNBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:01:13 -0500
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F897C5607
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:00:14 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgP3XHjzMrV3W;
        Wed,  8 Mar 2023 13:53:21 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgN6tZBzMsjnP;
        Wed,  8 Mar 2023 13:53:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678280001;
        bh=IXRDXQwF9OYLgTZZs91AEzYeN/DVARVdUYPlz+bx/KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZPxLyO0o6R8Won044sD4PmF6Vaay5VeWqse/t9J7WrlndOSmeVIRxV/StWI8xHnj
         nlcxpkMh5E2vQ0lPdetTdNJjfXVlOziWI18h4fx7UrIW3S0iYu9KuLqHsiBZX2PR7D
         uEgmnejlVfzA1CTE2/6SW1G3iWyfUngcg8RwU2io=
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
Subject: [PATCH v1 24/25] arm64: dts: colibri-imx8x: Add iris carrier board
Date:   Wed,  8 Mar 2023 13:52:58 +0100
Message-Id: <20230308125300.58244-25-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add the Toradex Iris Carrier Board for Colibri iMX8X, small form-factor
production ready board.

Additional details available at:
https://www.toradex.com/products/carrier-boards/iris-carrier-board

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8qxp-colibri-iris.dts    |  16 +++
 .../dts/freescale/imx8x-colibri-iris.dtsi     | 115 ++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9f49e47589ab..48bb0fe4a616 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -131,6 +131,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qm-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-aster.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris.dts b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris.dts
new file mode 100644
index 000000000000..fed75b5d4a1c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2021 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8qxp-colibri.dtsi"
+#include "imx8x-colibri-iris.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX8QXP on Colibri Iris Board";
+	compatible = "toradex,colibri-imx8x-iris",
+		     "toradex,colibri-imx8x",
+		     "fsl,imx8qxp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
new file mode 100644
index 000000000000..5f30c88855e7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2021 Toradex
+ */
+
+/ {
+	aliases {
+		rtc0 = &rtc_i2c;
+		rtc1 = &rtc;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3.3V";
+	};
+};
+
+&colibri_gpio_keys {
+	status = "okay";
+};
+
+/* Colibri FastEthernet */
+&fec1 {
+	status = "okay";
+};
+
+/* Colibri I2C */
+&i2c1 {
+	status = "okay";
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc_i2c: rtc@68 {
+		compatible = "st,m41t0";
+		reg = <0x68>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_iris>;
+
+	pinctrl_gpio_iris: gpioirisgrp {
+		fsl,pins = <IMX8QXP_QSPI0B_DATA3_LSIO_GPIO3_IO21	0x20>,		/* SODIMM  98 */
+			   <IMX8QXP_USB_SS3_TC1_LSIO_GPIO4_IO04		0x20>,		/* SODIMM 133 */
+			   <IMX8QXP_SAI0_TXD_LSIO_GPIO0_IO25		0x20>,		/* SODIMM 103 */
+			   <IMX8QXP_SAI0_TXFS_LSIO_GPIO0_IO28		0x20>,		/* SODIMM 101 */
+			   <IMX8QXP_SAI0_RXD_LSIO_GPIO0_IO27		0x20>,		/* SODIMM  97 */
+			   <IMX8QXP_ENET0_RGMII_RXC_LSIO_GPIO5_IO03	0x06000020>,	/* SODIMM  85 */
+			   <IMX8QXP_SAI0_TXC_LSIO_GPIO0_IO26		0x20>,		/* SODIMM  79 */
+			   <IMX8QXP_QSPI0A_DATA1_LSIO_GPIO3_IO10	0x06700041>;	/* SODIMM  45 */
+	};
+
+	pinctrl_uart1_forceoff: uart1forceoffgrp {
+		fsl,pins = <IMX8QXP_QSPI0A_SS0_B_LSIO_GPIO3_IO14	0x20>;	/* SODIMM 22 */
+	};
+
+	pinctrl_uart23_forceoff: uart23forceoffgrp {
+		fsl,pins = <IMX8QXP_MIPI_DSI1_GPIO0_01_LSIO_GPIO2_IO00	0x20>; /* SODIMM 23 */
+	};
+};
+
+/* Colibri SPI */
+&lpspi2 {
+	status = "okay";
+};
+
+/* Colibri UART_B */
+&lpuart0 {
+	status = "okay";
+};
+
+/* Colibri UART_C */
+&lpuart2 {
+	status = "okay";
+};
+
+/* Colibri UART_A */
+&lpuart3 {
+	status= "okay";
+};
+
+&lsio_gpio3 {
+	/*
+	 * This turns the LVDS transceiver on. If one wants to turn the
+	 * transceiver off, that property has to be deleted and the gpio handled
+	 * in userspace.
+	 */
+	lvds-tx-on-hog {
+		gpio-hog;
+		gpios = <18 0>;
+		output-high;
+	};
+};
+
+/* Colibri PWM_B */
+&lsio_pwm0 {
+	status = "okay";
+};
+
+/* Colibri PWM_C */
+&lsio_pwm1 {
+	status = "okay";
+};
+
+/* Colibri PWM_D */
+&lsio_pwm2 {
+	status = "okay";
+};
+
+/* Colibri SD/MMC Card */
+&usdhc2 {
+	status = "okay";
+};
-- 
2.39.2

