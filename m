Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A9C61A29C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiKDUn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiKDUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:43:22 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700CA43AF1;
        Fri,  4 Nov 2022 13:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nnGqb9LOqQYgLcPgmRXAVQSy5zzGJof5WhW0S99FOvg=; b=XDvDONCIZTbpMUmmXq+ko/UtI9
        CmxdhjnntVJJVYTdWdeQiKISVZfOTdgb9CgozbuQgZPKCbKD3eAsPGSAu/wjNcevT42ZH35qLhi49
        qZeSuy0w87x3wmtXmHGUa8/dhzOdhiXu+pUXx2r9euOynAT9PMoYHkJqlD/0viJpUOIHc4kNDWBri
        jIW5+uoEaymYN0yo10KhF58x322AvomoVQE3gyQAcQTO1mFxlWX7kyWc10+1e3m2/5i/GPM/+eIaQ
        4R6LCXrYOYY2VRcEjJj49SoCqUfccNJmNW0kTbT0ngPN2DKZEC4OqTo8qW2xgy1OysadXn+CgYU/w
        Zdhfslew==;
Received: from p200300ccff083a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:3a00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1or3Wu-0004if-Vr; Fri, 04 Nov 2022 21:43:09 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1or3Wq-0067YQ-Qi; Fri, 04 Nov 2022 21:43:04 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alistair@alistair23.me
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] ARM: dts: imx: e60k02: Add touchscreen
Date:   Fri,  4 Nov 2022 21:42:51 +0100
Message-Id: <20221104204251.1458958-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the touchscreen now, since the driver is available.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2: fix pinmux naming

 arch/arm/boot/dts/e60k02.dtsi              | 11 ++++++++++-
 arch/arm/boot/dts/imx6sl-tolino-shine3.dts |  7 +++++++
 arch/arm/boot/dts/imx6sll-kobo-clarahd.dts |  7 +++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
index 935e2359f8df..94944cc21931 100644
--- a/arch/arm/boot/dts/e60k02.dtsi
+++ b/arch/arm/boot/dts/e60k02.dtsi
@@ -104,7 +104,16 @@ &i2c2 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	/* TODO: CYTTSP5 touch controller at 0x24 */
+	touchscreen@24 {
+		compatible = "cypress,tt21000";
+		reg = <0x24>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_cyttsp5_gpio>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&ldo5_reg>;
+	};
 
 	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
 
diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
index e3f1e8d79528..db5d8509935f 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
@@ -52,6 +52,13 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
+	pinctrl_cyttsp5_gpio: cyttsp5-gpiogrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_DAT3__GPIO5_IO06                0x17059 /* TP_INT */
+			MX6SL_PAD_SD1_DAT2__GPIO5_IO13                0x10059 /* TP_RST */
+		>;
+	};
+
 	pinctrl_gpio_keys: gpio-keysgrp {
 		fsl,pins = <
 			MX6SL_PAD_SD1_DAT1__GPIO5_IO08	0x17059	/* PWR_SW */
diff --git a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
index 90b32f5eb529..c7cfe0b70f04 100644
--- a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
+++ b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
@@ -62,6 +62,13 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
+	pinctrl_cyttsp5_gpio: cyttsp5-gpiogrp {
+		fsl,pins = <
+			MX6SLL_PAD_SD1_DATA3__GPIO5_IO06                0x17059 /* TP_INT */
+			MX6SLL_PAD_SD1_DATA2__GPIO5_IO13                0x10059 /* TP_RST */
+		>;
+	};
+
 	pinctrl_gpio_keys: gpio-keysgrp {
 		fsl,pins = <
 			MX6SLL_PAD_SD1_DATA1__GPIO5_IO08	0x17059	/* PWR_SW */
-- 
2.30.2

