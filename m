Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170DB621CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiKHTQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKHTQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:16:00 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B95E3EA;
        Tue,  8 Nov 2022 11:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S9kcL9L3kIx4P+16IIBvb0i7VOAc8cgMQdqDyHRXBlk=; b=IEYMHHRfG6/Ogsxum4S/1BoTcd
        AmW8M4fFpfDlRMWRBbbVunDQj67S2wbHnSIIjXCil83eT5MncCcb+ubdMo0+ePUHdiS0w42Krqk7W
        8c3O5n95VKlM1PabF7UcmpasamhvmL/p1Ze1JAXCpTYRG+AV2jnBTRPziXXGzv9WSBtgZjGsSDLcS
        oLxRoLIOj/ucZog9mjoGf/pRwepv55lZ1tGIlxFVdtno6mFf95IZnbBgvvepiF6D67RNJAvEY3pYl
        4NK8djEtqC9vrcSbR7iq7GkF6YxzuMa0ebnfxJzlt+stTwnRpoRM2cTkYFs0z+m9R8QtetvQfYTAN
        bB/8YckA==;
Received: from p200300ccff1252001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:5200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1osU4e-0006cz-Jf; Tue, 08 Nov 2022 20:15:52 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1osU4d-007Lo9-9P; Tue, 08 Nov 2022 20:15:51 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alistair@alistair23.me
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3] ARM: dts: imx: e60k02: Add touchscreen
Date:   Tue,  8 Nov 2022 20:15:43 +0100
Message-Id: <20221108191543.1752080-1-andreas@kemnade.info>
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
Changes in v3: no phandles pointing from dtsi to dts
 
Changes in v2: fix pinmux naming

 arch/arm/boot/dts/e60k02.dtsi              |  9 ++++++++-
 arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 12 ++++++++++++
 arch/arm/boot/dts/imx6sll-kobo-clarahd.dts | 12 ++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
index 935e2359f8df..99091db3ab2a 100644
--- a/arch/arm/boot/dts/e60k02.dtsi
+++ b/arch/arm/boot/dts/e60k02.dtsi
@@ -104,7 +104,14 @@ &i2c2 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	/* TODO: CYTTSP5 touch controller at 0x24 */
+	cyttsp5: touchscreen@24 {
+		compatible = "cypress,tt21000";
+		reg = <0x24>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&ldo5_reg>;
+	};
 
 	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
 
diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
index e3f1e8d79528..e98dc302e2e3 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
@@ -26,6 +26,11 @@ / {
 	compatible = "kobo,tolino-shine3", "fsl,imx6sl";
 };
 
+&cyttsp5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cyttsp5_gpio>;
+};
+
 &gpio_keys {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio_keys>;
@@ -52,6 +57,13 @@ &iomuxc {
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
index 90b32f5eb529..6bb80720ea66 100644
--- a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
+++ b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
@@ -36,6 +36,11 @@ &cpu0 {
 	soc-supply = <&dcdc1_reg>;
 };
 
+&cyttsp5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cyttsp5_gpio>;
+};
+
 &gpio_keys {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio_keys>;
@@ -62,6 +67,13 @@ &iomuxc {
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

