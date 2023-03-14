Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5486B8FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCNK0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjCNKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:14 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD97173ADE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:24:47 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4y3RsszMqHjx;
        Tue, 14 Mar 2023 11:24:34 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4x72XDz2MRh;
        Tue, 14 Mar 2023 11:24:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789474;
        bh=IhnvIMbVFoOPFBSGeTNsTYN1/UNZ+m4+0iZvLb6cAiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmmEseyPmyBRZo3xy+KeBMDl/upb2KnWVMtUhQNjVBdpOaifwF+jSwgjLoaw/KLn1
         xi4cIBxXRaJpvGNoCVRV9W2epY5ZJT4pKb5n1+fmlLwW5lorpPwtybzPVgvGs3WgvG
         9CUA0wzvXmzGa6CdcFX9cp9E9O/W/PUhWiMfYPSg=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/23] arm64: dts: colibri-imx8x: Add iris carrier board
Date:   Tue, 14 Mar 2023 11:24:08 +0100
Message-Id: <20230314102410.424773-23-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
References: <20230314102410.424773-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v1)

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

