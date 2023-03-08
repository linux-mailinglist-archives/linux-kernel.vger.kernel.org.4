Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2452A6B07C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCHNBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjCHNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:00:37 -0500
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C34C4893
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:58 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgF0tbnzMrQm6;
        Wed,  8 Mar 2023 13:53:13 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgD4NTnzMslsb;
        Wed,  8 Mar 2023 13:53:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279993;
        bh=J0nop1UBINwBylE+z6Slgf4axqyCGkduagG7oE+1FZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quApN3DmUUF8/4U7At3y5jRYXTruwBwCarrNN3Kg1ZglWYrl7n8jZkuelBylv4U+t
         L/9/O0TPbgCMXD1OHqASTE3r8elOgPSA+NO7qFea3XpiViAU/d9s/D1+muRbzQQVWU
         ClkEmWsGrNxdAKwovAjNLchJmWDLFCPMVSM+pjiY=
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
Subject: [PATCH v1 11/25] arm64: dts: colibri-imx8x: Sort fec1 node alphabetically
Date:   Wed,  8 Mar 2023 13:52:45 +0100
Message-Id: <20230308125300.58244-12-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

fec1 seems to be the only one that is not properly sorted
alphabetically. Put it to the location it belongs.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 .../dts/freescale/imx8x-colibri-eval-v3.dtsi  | 10 ++---
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 42 +++++++++----------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index dc0339b35a3c..870375301243 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -26,6 +26,11 @@ key-wakeup {
 	};
 };
 
+/* Colibri FastEthernet */
+&fec1 {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 
@@ -51,11 +56,6 @@ &lpuart3 {
 	status = "okay";
 };
 
-/* Colibri FastEthernet */
-&fec1 {
-	status = "okay";
-};
-
 /* Colibri SD/MMC Card */
 &usdhc2 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index c6aaf6aeab07..31c771c1b788 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -16,6 +16,27 @@ reg_module_3v3: regulator-module-3v3 {
 	};
 };
 
+/* Colibri FastEthernet */
+&fec1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_fec1>;
+	pinctrl-1 = <&pinctrl_fec1_sleep>;
+	fsl,magic-packet;
+	phy-handle = <&ethphy0>;
+	phy-mode = "rmii";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@2 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <2>;
+			max-speed = <100>;
+		};
+	};
+};
+
 /* On-module I2C */
 &i2c0 {
 	#address-cells = <1>;
@@ -70,27 +91,6 @@ &lpuart3 {
 	pinctrl-0 = <&pinctrl_lpuart3>, <&pinctrl_lpuart3_ctrl>;
 };
 
-/* Colibri FastEthernet */
-&fec1 {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_fec1>;
-	pinctrl-1 = <&pinctrl_fec1_sleep>;
-	fsl,magic-packet;
-	phy-handle = <&ethphy0>;
-	phy-mode = "rmii";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@2 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <2>;
-			max-speed = <100>;
-		};
-	};
-};
-
 /* On-module eMMC */
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-- 
2.39.2

