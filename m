Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5929A6B07B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjCHNBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjCHNAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:00:30 -0500
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111E8C3E1F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:52 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgN66xfzMrNXf;
        Wed,  8 Mar 2023 13:53:20 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgN28lXzMslsc;
        Wed,  8 Mar 2023 13:53:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678280000;
        bh=DDNWlmW2AJ5CjJZddxWuD3LXeySSKI53LrqW8PL/pYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3yw1kgjt3Kf22VaqJ5BGXmMfr9Ktu9BBY5LKDiwMPVK9BZfvbuvDMCK3RQ01neL4
         w6Uicudpzyst6m47uxSPsWx7OL9dNQxBZt2+ishhRpfa3AR39j6opzsyGNrASGeC7y
         Sz8X0bZQzY1pltOn0gip62NgBH20cr07xnBWpsgY=
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
Subject: [PATCH v1 23/25] arm64: dts: colibri-imx8x: Add aster carrier board
Date:   Wed,  8 Mar 2023 13:52:57 +0100
Message-Id: <20230308125300.58244-24-dev@pschenker.ch>
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

Add the Toradex Aster Carrier Board for Colibri iMX8X, small form-factor
with header compatible with Arduino Uno and Raspberry Pi (RPi) maker
boards.

Additional details available at:
https://www.toradex.com/products/carrier-boards/aster-carrier-board

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

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

