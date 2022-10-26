Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACBD60E681
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiJZRat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiJZRao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:30:44 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC288D22D;
        Wed, 26 Oct 2022 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HiYVn9aMwL/cWE4Pz4ri7pgwUgzFfzrAUVxWFAzu0XU=; b=lbgn16i1S9eaojGWW0u6VDtvT6
        wZ9+ttvwf2RdDDlT0lVZa2xUuvLZbKtiIrXT99Wg/lEVBRkcbdJ6ZdoiwIn+OuloJyKayizfL8R/w
        DJyjHEzUevenSvxxpa56SpisTwUO5GUs3GpJmL8z9CrVolq5ZEHoqv9qpfbfeMaaMYv7VQoiGs/6Q
        e4v79x2YsjQeRLjoI7QaHXVp/SSVF3knBAdSz91AjFO5DtbTxY9iDz4Yvr6T0FImlTz1FYGTPfF3q
        db0o9hMIjyGgECPV1x8gZCPfDCzLttLkdPv7aUc0i7R9awbd/ntqBkuCmMWm9wP5be6SpodQ7ZMFg
        DtsG4M4Q==;
Received: from p200300ccff073f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff07:3f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1onkER-00017B-Q5; Wed, 26 Oct 2022 19:30:24 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1onkEQ-004v7B-W7; Wed, 26 Oct 2022 19:30:23 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] arm: dts: imx: e60k02: Add touchscreen
Date:   Wed, 26 Oct 2022 19:30:15 +0200
Message-Id: <20221026173015.1172816-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the touchscreen now, since the driver is available.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
runtime/dtbs_check depends
https://lore.kernel.org/linux-devicetree/20221026114908.191472-1-alistair@alistair23.me/T/#t
 arch/arm/boot/dts/e60k02.dtsi              | 12 +++++++++++-
 arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 14 ++++++++++++++
 arch/arm/boot/dts/imx6sll-kobo-clarahd.dts | 14 ++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
index 935e2359f8df..4f36cc181a52 100644
--- a/arch/arm/boot/dts/e60k02.dtsi
+++ b/arch/arm/boot/dts/e60k02.dtsi
@@ -104,7 +104,17 @@ &i2c2 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	/* TODO: CYTTSP5 touch controller at 0x24 */
+	touchscreen@24 {
+		compatible = "cypress,tt21000";
+		reg = <0x24>;
+		pinctrl-names = "default","sleep";
+		pinctrl-0 = <&pinctrl_cyttsp5_gpio>;
+		pinctrl-1 = <&pinctrl_cyttsp5_gpio_sleep>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&ldo5_reg>;
+	};
 
 	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
 
diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
index e3f1e8d79528..82d9ed91df92 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
@@ -52,6 +52,20 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
+	pinctrl_cyttsp5_gpio: cyttsp5_gpio_grp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_DAT3__GPIO5_IO06                0x17059 /* TP_INT */
+			MX6SL_PAD_SD1_DAT2__GPIO5_IO13                0x10059 /* TP_RST */
+		>;
+	};
+
+	pinctrl_cyttsp5_gpio_sleep: cyttsp5_gpio_grp_sleep {
+		fsl,pins = <
+			MX6SL_PAD_SD1_DAT3__GPIO5_IO06                0x10059 /* TP_INT */
+			MX6SL_PAD_SD1_DAT2__GPIO5_IO13                0x10059 /* TP_RST */
+		>;
+	};
+
 	pinctrl_gpio_keys: gpio-keysgrp {
 		fsl,pins = <
 			MX6SL_PAD_SD1_DAT1__GPIO5_IO08	0x17059	/* PWR_SW */
diff --git a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
index 90b32f5eb529..d743bf4fd8e6 100644
--- a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
+++ b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
@@ -62,6 +62,20 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
+	pinctrl_cyttsp5_gpio: cyttsp5-gpiogrp {
+		fsl,pins = <
+			MX6SLL_PAD_SD1_DATA3__GPIO5_IO06                0x17059 /* TP_INT */
+			MX6SLL_PAD_SD1_DATA2__GPIO5_IO13                0x10059 /* TP_RST */
+		>;
+	};
+
+	pinctrl_cyttsp5_gpio_sleep: cyttsp5-gpiogrp-sleep {
+		fsl,pins = <
+			MX6SLL_PAD_SD1_DATA3__GPIO5_IO06                0x10059 /* TP_INT */
+			MX6SLL_PAD_SD1_DATA2__GPIO5_IO13                0x10059 /* TP_RST */
+		>;
+	};
+
 	pinctrl_gpio_keys: gpio-keysgrp {
 		fsl,pins = <
 			MX6SLL_PAD_SD1_DATA1__GPIO5_IO08	0x17059	/* PWR_SW */
-- 
2.30.2

