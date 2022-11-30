Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF5063D41A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiK3LOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiK3LOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:14:33 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F40D220E4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:14:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCC1ABFACA;
        Wed, 30 Nov 2022 12:14:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1669806866; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=FRxluBfEJkiA18fBYeNlbUEW1rTsCtHz9h13qEpVFw8=;
        b=LlhH723wWOsj558CVqc1B1IyaUxWewa/m5COH65zmc1/H2A+JMNguwLJ4kbTWpXRmnTi1M
        e+DpF3svrke1qdoBxwBuCe3iWK5abguQ4e86htmrA5TJHwm5y4XV7IEFZRMFJvQFFsnUXD
        ZKRb8c9qyKIN+iUiKLoJnL+qk4g87tDVkGylRSU12Kvv1aKymZVR1KVlwglXdqwMiSnzll
        /i1YlO/g1IJV3bxBiOnKTL9jXf3XavA6elWUE0cE3XlNUCXQXG1a+Bum0QH3HEUYwC3eo7
        LPQUMFjsYzTFdIcL3saXoSTBgcVmPIJliebB4jB5c2tVcctmTcUal/uxgLCzfQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH] arm64: dts: imx8mm-kontron: Add RTC aliases
Date:   Wed, 30 Nov 2022 12:13:49 +0100
Message-Id: <20221130111357.585560-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add aliases for the RTCs on the board and on the SoC. This ensures that
the primary RTC is always the one on the board that has a buffered supply
and maximum accuracy.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts     | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi | 7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index a079322a3793..dcec57c20399 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -13,6 +13,8 @@ / {
 
 	aliases {
 		ethernet1 = &usbnet;
+		rtc0 = &rx8900;
+		rtc1 = &snvs_rtc;
 	};
 
 	/* fixed crystal dedicated to mcp2515 */
@@ -136,7 +138,7 @@ &i2c4 {
 	pinctrl-0 = <&pinctrl_i2c4>;
 	status = "okay";
 
-	rtc@32 {
+	rx8900: rtc@32 {
 		compatible = "epson,rx8900";
 		reg = <0x32>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 8d10f5b41297..695da2fa7c42 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -10,6 +10,11 @@ / {
 	model = "Kontron OSM-S i.MX8MM (N802X SOM)";
 	compatible = "kontron,imx8mm-osm-s", "fsl,imx8mm";
 
+	aliases {
+		rtc0 = &rv3028;
+		rtc1 = &snvs_rtc;
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		/*
@@ -200,7 +205,7 @@ reg_nvcc_sd: LDO5 {
 		};
 	};
 
-	rtc@52 {
+	rv3028: rtc@52 {
 		compatible = "microcrystal,rv3028";
 		reg = <0x52>;
 		pinctrl-names = "default";
-- 
2.38.1

