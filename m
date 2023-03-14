Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BDB6B8FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCNK0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCNKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:13 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6C470401
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:24:46 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4x6J1SzMqQVs;
        Tue, 14 Mar 2023 11:24:33 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4x2kg7z2MSL;
        Tue, 14 Mar 2023 11:24:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789473;
        bh=WiIb9AvUiUqyquXRI5uWbc8955AquS+8qtMHW7WxdAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QiDB0svjHVhBuRe+fVzL1CxrFgz3SKOyVMoWTDE8zd7PQuiL2lR36c3kPKXgaC8Pm
         uLcmLGdRsq/L+tU/ooWjWC6Q4HfXHXAxMzgS03DYc6XIn4FjNPolK2dEN8YenxBBsO
         m/x8KblWpIFmOZXJCSB4Bs28tEedBgsrkkn6ralk=
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
Subject: [PATCH v2 21/23] arm64: dts: colibri-imx8x: Add aster carrier board
Date:   Tue, 14 Mar 2023 11:24:07 +0100
Message-Id: <20230314102410.424773-22-dev@pschenker.ch>
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

Add the Toradex Aster Carrier Board for Colibri iMX8X, small form-factor
with header compatible with Arduino Uno and Raspberry Pi (RPi) maker
boards.

Additional details available at:
https://www.toradex.com/products/carrier-boards/aster-carrier-board

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../dts/freescale/imx8qxp-colibri-aster.dts   | 16 +++++++
 .../dts/freescale/imx8x-colibri-aster.dtsi    | 44 +++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri-aster.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 836dcc501e6f..9f49e47589ab 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -129,6 +129,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-v1.1-ixora-v1.1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-v1.1-ixora-v1.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qm-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-aster.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-aster.dts b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-aster.dts
new file mode 100644
index 000000000000..966ecfb2a17e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-aster.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2021 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8qxp-colibri.dtsi"
+#include "imx8x-colibri-aster.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX8QXP on Aster Board";
+	compatible = "toradex,colibri-imx8x-aster",
+		     "toradex,colibri-imx8x",
+		     "fsl,imx8qxp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
new file mode 100644
index 000000000000..aab655931cde
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2021 Toradex
+ */
+
+&colibri_gpio_keys {
+	status = "okay";
+};
+
+/* Colibri Ethernet */
+&fec1 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog0>;
+};
+
+/* Colibri SPI */
+&lpspi2 {
+	cs-gpios = <&lsio_gpio1 0 GPIO_ACTIVE_LOW>,
+		   <&lsio_gpio5 2 GPIO_ACTIVE_LOW>;
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
+/* Colibri SDCard */
+&usdhc2 {
+	status = "okay";
+};
-- 
2.39.2

