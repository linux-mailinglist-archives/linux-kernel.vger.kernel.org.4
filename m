Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DEC6A3A37
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjB0Eut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjB0Euo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:50:44 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF551C323;
        Sun, 26 Feb 2023 20:50:43 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E817332008FE;
        Sun, 26 Feb 2023 23:50:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 26 Feb 2023 23:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677473441; x=
        1677559841; bh=vtIMV4W6tstxNELIu2t+ski4dnTlQV2rwz1WM/2Zye4=; b=B
        xP0kaiGxFEV1mAr2WCnL6luE+9r+NPxvR5tiowHbCFV70jCTPW/lyShi39amRWv0
        OWxSLelT+XucI9NpwJ5WtwE3po73Rj0FIzP+9Dx1FXVqBmJnICaNIdrFzKqBBJtA
        mVECS/rn0YBUMHd1ZC6Qjw2OPFvJqKRmEesqL66FSsadJJCrjb9+69F/ClhGVrvK
        GB/En3VCRJXojnJF7eCJ5vXQ1btA6DZNwLW3ArlYeBLyNM4xD1LF/qbEVeeRkm/w
        xswvFarNlpC6keG6hqzmTVj1bCCTBDzVSRUI3qCWgcK92J3VuvwTED6Ma3X5iZeg
        WOaqAvPmt+uTB7Uz4U3pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677473441; x=1677559841; bh=vtIMV4W6tstxN
        ELIu2t+ski4dnTlQV2rwz1WM/2Zye4=; b=L1WdS56SdGJLS3+uGLnBsuEPpbIXQ
        vpezfgxqtV0p9ENQitrjLUXcfE+bfVv/cwkmNqsz5jft+F9TqDUXl6V2oTJA0aeu
        /ENWXLDkrOkJbB4GB+9tMs/cW3GUil64DY3q/JyBWM0MY6LXWFk143EFYIj7cJe8
        v+MWI51UVWbZ7/SUd+sAPGv5Ie/vUNCmCQiBt/AvUTE0OY94bf+ADhDCuH/bDYXd
        s3LOlDmm1KE8pPlTSL6h5FSnPOefSvmgJCD4zr1DjIWPLdVJviF7IjWMiyfL/T+d
        kT7p0Mfy3vCP8tw3u0BOoU6MJFy5XCoNPNGlsQ+IDRrecnB0iJQ30PQvw==
X-ME-Sender: <xms:oTb8Y6Zz9C6SWViFoK9QBi3noq1FEXqbqGZbB6mjwqoJQn8AY2rKUw>
    <xme:oTb8Y9Z9-nbi3Ln-pAYXY_24TEiWjCSwAFsZL88toj7pQSdXiowgO_U4kmdQE1h9a
    xt4b8As0YI1lRhVCVI>
X-ME-Received: <xmr:oTb8Y08wXkJTLFAYwRMzNEckwJWfnpdKQo2EoPsEKq8w8MnZAXmv3WG0PzPN3wHX0Dwff1wL2uTt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekte
    elvdelveevueeujeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:oTb8Y8r3ODH-glhyGaW6ZJgmMe-Bx9ylAO1HkcY6LabNrixe6_TFVA>
    <xmx:oTb8Y1rBXPrPU9a5iGAkUw7qiizBEH7-g-1D4iewa4BXuTXqD7cluA>
    <xmx:oTb8Y6TLE7tI4QOleM9AxjYgWGtziOCh-ZruhVi91kGLW4bKqTKzTw>
    <xmx:oTb8Y24YVQ5QV8Gbcbg0FHojFi_befkx0wFqiqrERX0eODsOnBwQ7A>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Feb 2023 23:50:36 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, linux-imx@nxp.com
Cc:     linux@armlinux.org.uk, arnd@arndb.de, alistair23@gmail.com,
        kernel@pengutronix.de, festevam@gmail.com,
        jernej.skrabec@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 1/3] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Date:   Mon, 27 Feb 2023 14:50:21 +1000
Message-Id: <20230227045023.560319-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227045023.560319-1-alistair@alistair23.me>
References: <20230227045023.560319-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the cyttsp5 touchscreen controller for the reMarkable 2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 97 +++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 8b2f11e85e05..288fc8611117 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "imx7d.dtsi"
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	model = "reMarkable 2.0";
@@ -69,6 +70,17 @@ reg_digitizer: regulator-digitizer {
 		startup-delay-us = <100000>; /* 100 ms */
 	};
 
+	reg_touch: regulator-touch {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_3V3_TOUCH";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch_reg>;
+		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -106,6 +118,68 @@ wacom_digitizer: digitizer@9 {
 	};
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	touchscreen@24 {
+		compatible = "cypress,tt21000";
+		reg = <0x24>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&reg_touch>;
+		touchscreen-size-x = <880>;
+		touchscreen-size-y = <1280>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button@0 {
+			reg = <0>;
+			linux,keycodes = <KEY_HOMEPAGE>;
+		};
+
+		button@1 {
+			reg = <1>;
+			linux,keycodes = <KEY_MENU>;
+		};
+
+		button@2 {
+			reg = <2>;
+			linux,keycodes = <KEY_BACK>;
+		};
+
+		button@3 {
+			reg = <3>;
+			linux,keycodes = <KEY_SEARCH>;
+		};
+
+		button@4 {
+			reg = <4>;
+			linux,keycodes = <KEY_VOLUMEDOWN>;
+		};
+
+		button@5 {
+			reg = <5>;
+			linux,keycodes = <KEY_VOLUMEUP>;
+		};
+
+		button@6 {
+			reg = <6>;
+			linux,keycodes = <KEY_CAMERA>;
+		};
+
+		button@7 {
+			reg = <7>;
+			linux,keycodes = <KEY_POWER>;
+		};
+	};
+};
+
 &i2c4 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default", "sleep";
@@ -232,6 +306,15 @@ MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11	0x00000014
 		>;
 	};
 
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+			/* CYTTSP interrupt */
+			MX7D_PAD_GPIO1_IO14__GPIO1_IO14		0x54
+			/* CYTTSP reset */
+			MX7D_PAD_GPIO1_IO13__GPIO1_IO13		0x04
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
@@ -239,6 +322,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
+			MX7D_PAD_I2C3_SCL__I2C3_SCL		0x4000007f
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
@@ -246,6 +336,13 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_touch_reg: touchreggrp {
+		fsl,pins = <
+			/* TOUCH_PWR_EN */
+			MX7D_PAD_GPIO1_IO11__GPIO1_IO11		0x14
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.39.1

