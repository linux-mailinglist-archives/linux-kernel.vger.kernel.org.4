Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F56A2956
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBYLhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjBYLh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:37:29 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E862199FC;
        Sat, 25 Feb 2023 03:37:28 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EAE455C00A5;
        Sat, 25 Feb 2023 06:37:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 25 Feb 2023 06:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677325047; x=
        1677411447; bh=vtIMV4W6tstxNELIu2t+ski4dnTlQV2rwz1WM/2Zye4=; b=E
        neSNQb9aAUHsw/Z28hNa05XTePobskYAJCbGUTsyQgYxix2x2IShvqKIQl12szHu
        +ndaBkWrwZpAo9F8bw0uuu4BKk9ScK/fMkz9F6z73XRE5hPDiceRPqWDwdJxzMlY
        teI5Zq+XKI0KFy+CLud8rO5tRh5OGMONO5a5ww6KL/E8Jigp5Crhb86wpAJNpxGE
        eO2BmTHPaZLmL4KaEYupzVWKRQgIGlwEBQUojEUWLRC0XthbHX9IJVZ1UWP8C7Ke
        X5TqfDOfclT9sPQ4UnEhf6JuTaLai54GLU2hedZwRO+ml3I+m9CBhG46GsFTRcfT
        HjrpAGHT4sqLdszsJaRQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677325047; x=1677411447; bh=vtIMV4W6tstxN
        ELIu2t+ski4dnTlQV2rwz1WM/2Zye4=; b=MIG37OO3I/Sk1ANppsIAKUQZLw+Uz
        iHk0MXOd7w6ekSh2F2IzDmK5uHsMdtefrk/1lR57FMVV4NlNe+/iOJ8E32etP8iy
        OShSppUBv3RGp+RWiu/CpQcrtXEBm7ivpzwNNfgWiv81p+rzIM6bGfmXUsRx78wo
        5wCmUuP7939d5NHQuha8HCY4XxV5zy+aAXm4ZLgrCpHZKKKJHHcDnHkA/bIdQAk0
        0iSG66Bs14JElP+dWjh2sE68TuZ413VItw36yTiJ96eRV7blTb7Tl9foR+fXwWHO
        oZ6C2AEm7uGW4puDu4QTPxf8mSyU9PDAo0fnCDpqM1BdDwNqOf3LGdMQA==
X-ME-Sender: <xms:9_L5Y3WNdA3QpJD9Ua4TAMVn7jQzd7qzwu2isderr_zKYXRjYle3hA>
    <xme:9_L5Y_l0iZcQwrcGVUVwRSKQJLQV9Y6oY2Yf31xOkZjw4xWqkHft8smdp8IlGUH9b
    O9bFyD5wAEB6h_GUFw>
X-ME-Received: <xmr:9_L5Yzbcir92TIy9JklvP6awJfQ5qOzgfWYuesu0NyFzUAXs4EujfQf34Dbm3HeBH0HRYUVfgVTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekte
    elvdelveevueeujeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:9_L5YyWzo2o25bLoNPKenA-5rnqdMqQZQGnF2SwDNYzCO4ysTPrFnw>
    <xmx:9_L5YxlJBvNNc_BUl_ZPNypBEKAkui3YoQ7P3CZH-0upXcmR-zsAyA>
    <xmx:9_L5Y_cxTLHJcOBityRKiD_vwtybkTC9k_BIelmwebVPAqOKEeHiaQ>
    <xmx:9_L5YznnSyqpZK1Hwly4nwUoycwmRIGMMFA1RhapCeSZ4X_l5BzYIA>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Feb 2023 06:37:22 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     arnd@arndb.de, alistair23@gmail.com, kernel@pengutronix.de,
        jernej.skrabec@gmail.com, linux@armlinux.org.uk,
        festevam@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 1/3] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Date:   Sat, 25 Feb 2023 21:37:10 +1000
Message-Id: <20230225113712.340612-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230225113712.340612-1-alistair@alistair23.me>
References: <20230225113712.340612-1-alistair@alistair23.me>
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

