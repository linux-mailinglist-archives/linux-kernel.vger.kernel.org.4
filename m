Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCC2651FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiLTL3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLTL3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:29:45 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F271659E;
        Tue, 20 Dec 2022 03:29:44 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 614633200935;
        Tue, 20 Dec 2022 06:29:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 20 Dec 2022 06:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1671535782; x=
        1671622182; bh=p8sZMSIiDzeWkDbA4eVexgLSYWpIws7O7dxtkYfuzb0=; b=g
        oj0QeOj5ouI4PH+yZCRHV0xtfkcnNQM0IsVc+Y9aO9uJvDmaJvklTCJtL6O1VZvg
        WcLm8KEPnU0bOwjx7JU0FapB6DE9XmIatrRBslmvpZa4V+EYlweBBst0fyGpBgGN
        srnVFFkg5VrIRtB+NKVKb7xsbyb5/nHxPZ2f8l2v927GKPOkGoGyNwzCFy6ev2b1
        E4LDFCIYUezfGi1RZ4Tqa2LOfv+yISrjf55htT3Y+JLcOEsyevAqxuw6SH5fMqsc
        ai5YmxuKr0mf3I3cupGLhlRuRvcRxg4DYyL87Aj5Ku3MDzwja151wj55w+0wHCFy
        dwBbIFzE0GJsD71lkzDDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671535782; x=1671622182; bh=p8sZMSIiDzeWk
        DbA4eVexgLSYWpIws7O7dxtkYfuzb0=; b=f8CvmMSZOP5B8E0Sic8F+dD2XOhiK
        B5YYMWj4j2FzsislXvCE6wEOycInSQQ3/CopWiDQuJHC8EPw+Xss3JqcRpIPzoNY
        6g1qSXhw7dCm8KQA9GW62t7nm7REIJsXQOHgAoL+8ebxrsQ++Ie4xVeHWE4xWpyh
        kks4FEL1vjTGZWonb3Mzi7iHdFbv9oR+mCxDq/O9Sttb+/FrbOkXzGMvJyDHL9lt
        Etkj0Zdb46vLToeaIVIt4XDkpfdKEnfXegiQTp6uRrDLkC/of0ojVcP/m1VoZGzW
        Jb+woWgbgHsYgiyDPasN8eMKK51EfKebX/go92D3ptJnpfuS0iclA8u8w==
X-ME-Sender: <xms:ppyhYx-lhW3Vyr8pwWDIh3N8mqUDsyYKl_nvWz4hC1BbrIvT4ZkPcw>
    <xme:ppyhY1tEyxZIv_8dtX3ftin18z-jVXL-_-kLvZeTR3rQgGNux4KLNrSbcAz1jLLTu
    tWkfTTOdOnAx7Wv3E8>
X-ME-Received: <xmr:ppyhY_A0OjlieQB274GrhbgRf--sFB5o-mCQVv-xF2J71figZJWyXZ5vygd8atZ2uGKQf7kE6ZxN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:ppyhY1eWe9vFeJYo6dPRYjOcdN0OFIS6Sw15XLavGgDV7YAmentJNg>
    <xmx:ppyhY2PxKMP8a59r3PnA_wtFRd05jWvik0hEt3tYpJ0jsZXx3nERXg>
    <xmx:ppyhY3lVeMOQWmME-serfEClSj4Y_SDsBmohnfcvPS3ajXHJoyL_Fw>
    <xmx:ppyhYwtEY1ADyljt1QMNL6_f2nQXYFiO6KqOeuuzBeaKuCT_gtQ0Ig>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Dec 2022 06:29:37 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        s.hauer@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux@armlinux.org.uk, festevam@gmail.com, kernel@pengutronix.de,
        arnd@arndb.de, alistair23@gmail.com, jernej.skrabec@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 1/3] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Date:   Tue, 20 Dec 2022 21:29:25 +1000
Message-Id: <20221220112927.440506-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220112927.440506-1-alistair@alistair23.me>
References: <20221220112927.440506-1-alistair@alistair23.me>
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

