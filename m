Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9DC64DAB4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLOL5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLOL5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:57:10 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA1927FD8;
        Thu, 15 Dec 2022 03:57:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 423B0320092B;
        Thu, 15 Dec 2022 06:57:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Dec 2022 06:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1671105427; x=
        1671191827; bh=p8sZMSIiDzeWkDbA4eVexgLSYWpIws7O7dxtkYfuzb0=; b=X
        4N63HrfQR0KUBTQEM4UZvR1bTTQsObTTIUNSTAT+brvdgdGnzlQh8Loqwy9A+Pdo
        G3UqSRHYC6mwNH1djkxqbfXJsi+bL41aY33sQ70qH0OiYVtyfN8gw3662CWb7yJl
        FEYoOS0wYiCEb+OKOTRyc9tWhh3EsYUAiJy+rS2vQ9PGETIhng+wkHZWFEHCetJw
        eg1WGZn7mbkVLb4guaTp42xCUgsg5oX2tu65pmNuSqSbcsKbY4bPVHutnTbsnB29
        VKDw18NvNWI+dLCLu5KID5Lol1i44YUON9KYGxgB/EvhWMzonUxces69OM++Wvo0
        v6BPb11ExAU1GnTMwGcBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671105427; x=1671191827; bh=p8sZMSIiDzeWk
        DbA4eVexgLSYWpIws7O7dxtkYfuzb0=; b=BcZZbyl6mmdpFiLYTNFCmKltNMu6b
        C4i3XWf7cZVJSzdGmcd/cAGa50/TnwCCJJbwCdBLX3FuHmLeIcxwzZRpxNhnl+tn
        XlX5KfBN3jj6xPdBgjlzJztkdxG9fG9SZ4fQXgzkLitHP2H3AQ484MKI1TUDOp/v
        lyWcb9MMx4fIZKMDZ+Dn5mmavSVJ0js9Hh8z7pJTgLr5RbglWSZSTWCI5NUdMvLM
        Xk2zJxa6A1FzKg0hGf3OGvMgLN0RCdsTMXym13iOi+q7jRdYCZzlRVNMoCFbnhno
        fOlyMeG7dexXp45TDqNAeqlHd+3rmrcjdvEDUqb3aLisED9yZCrSc28JA==
X-ME-Sender: <xms:kwubYyRQwybeXElHmNnGAmciiRKqpekn-QUDF6ObqRy54V__tGbGig>
    <xme:kwubY3yTT1wPBodmV01MI83YcgSMkdNNKTvl5OYjbHwbZ9DvtcQnBHJTFhemI91JA
    xB6f_f-tTDkUpkwkpQ>
X-ME-Received: <xmr:kwubY_2LE0KO6JB4lgR5aVgvezyYJxhRJo2xYSK2JvzWhaLdwtmeDyUvy6QX7kDQSiTU_BCWgUu_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:kwubY-BUN2pqHV_aQMGx2wB6Rcr_sVBBBbRRhgIzTVM5RbZMj0jNOw>
    <xmx:kwubY7gnlKorF82E2yrOPhSOGLDzOjGqAaFVMOLZHCWXdIdy-lt_fA>
    <xmx:kwubY6rVSmsSn48vYEc9RGZars828dtIPpgNvAyq9FTz0icQAFDTwg>
    <xmx:kwubY2R6iwe19QezucN1kcAus8J2yhusIEUac6yvr7AYZWS41uhMkQ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 06:57:00 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     jernej.skrabec@gmail.com, alistair23@gmail.com, festevam@gmail.com,
        kernel@pengutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 1/3] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Date:   Thu, 15 Dec 2022 21:56:42 +1000
Message-Id: <20221215115644.208486-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215115644.208486-1-alistair@alistair23.me>
References: <20221215115644.208486-1-alistair@alistair23.me>
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
 arch/arm/boot/dts/imx7d-remarkable2.dts | 98 +++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 8b2f11e85e05..a138b292ec6a 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "imx7d.dtsi"
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	model = "reMarkable 2.0";
@@ -69,6 +70,18 @@ reg_digitizer: regulator-digitizer {
 		startup-delay-us = <100000>; /* 100 ms */
 	};
 
+	reg_touch: regulator-touch {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_3V3_TOUCH";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pinctrl_touch_reg>;
+		pinctrl-1 = <&pinctrl_touch_reg>;
+		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -106,6 +119,68 @@ wacom_digitizer: digitizer@9 {
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
@@ -232,6 +307,15 @@ MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11	0x00000014
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
@@ -239,6 +323,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
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
@@ -246,6 +337,13 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
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
2.38.1

