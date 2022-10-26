Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20A460E007
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiJZLun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiJZLuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:50:18 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DDE69F43;
        Wed, 26 Oct 2022 04:50:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D57123200920;
        Wed, 26 Oct 2022 07:50:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 26 Oct 2022 07:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666785015; x=
        1666871415; bh=1JPk0MpObCRGBh/PsXpo7zlYyOMqvhTBfteOa6rLuqs=; b=j
        DHHl0rP08l5hV/1B4EVS6p45n/+GQvGNG68mmx8hSDE171K4dxchgvlffkiLAW6A
        GtlgsX7MuZqnS4bqtONP5455PVs3avCcWWXep4idX4dT7MBMBLL+K+bQYmJjbSoT
        D2M0tu6lI+80RD+FT9bj66TWV+16QvF+eWmk3SJXzVSZE34PGDe57vANPrPq9BDu
        acBym+wxgQYIXMDmva2Jq9pOrvA7nRGF0cHYN8ZpwLj5bNuvrW0aoh0pkQpR8V45
        0LOL9ZP6kTkTHe9FkCJ+R5NDWhlFteF7WqRxIiG2/Rh10HFVd1GIJxvvxKyj5DJE
        qnOi2mbEzOMAsCH1ZWatg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666785015; x=1666871415; bh=1JPk0MpObCRGB
        h/PsXpo7zlYyOMqvhTBfteOa6rLuqs=; b=UtTrie9ZUM2X3VisTWV0pnVUQRPGm
        plFc044JhPC9UER0vioKS4w37iJcal52jU2M+wZc5XFPm1Qk0/nI6z32alVQw3Vx
        3c+shG0Xo7mR/dtmfH3Qg/j+rwBXubM9t/5HGWMgHdCDgmT/sacQca/21y359/T3
        7o80TorwMg3aHQqY+IEmclwJyjXdCep+G+e7ahKlt9W678+4T1Yggh1zFJ527WIR
        sXedCpfbJza8iTxsFklOJP6VvUsvSy6IJ7fEQ6wVEcqGjNHylUbsEwFMdl3hzHDi
        Rmk7YaeRk4o39hNJ1+yHCNf5iY+cQ9ofAMdyW8tE/jmYOBL1pUj9myzOA==
X-ME-Sender: <xms:9x5ZYyKAD7HAGbW_4Jp74xm6098OSTVmsNBD4EfHlwapc_2rKaJIyA>
    <xme:9x5ZY6I2BjQ2DGRShM2UVBwq4b-N__bzwfGH5jnNmgFgl-BpnJsOmZnqrs90aUzfO
    XLIVinxCcXtgHlVOHU>
X-ME-Received: <xmr:9x5ZYysnc4wt75FzhC9vzvNOw1kuUA3DL3BoOwhnPXd4lylcxN2TlyK0f0Cmy-nuFnRoYkeNBpsp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:9x5ZY3a7v-xrToc2nQX6ajFmQyogGRe0PPzIhyiMaqnG0PdpwEfx9w>
    <xmx:9x5ZY5aZGnE9-dqijdJXxmvGyaMdCNNGr1_F2KZYplmpH8obunVoMQ>
    <xmx:9x5ZYzDFfjlG8ghKBP2EwmwA60STNsZM5Dj3WYIJJ--Es8knD6KUsA>
    <xmx:9x5ZY9RQnIq8m2FbAUy9W8rUAtncbJ_-S32iZZE4atSqAzWWj-N5iw>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 07:50:05 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        rydberg@bitmath.org, alistair23@gmail.com, s.hauer@pengutronix.de,
        andreas@kemnade.info, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 4/4] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Date:   Wed, 26 Oct 2022 21:49:08 +1000
Message-Id: <20221026114908.191472-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221026114908.191472-1-alistair@alistair23.me>
References: <20221026114908.191472-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the cyttsp5 touchscreen controller for the reMarkable 2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 100 ++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index a2a91bfdd98e..fea480af8e48 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "imx7d.dtsi"
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	model = "reMarkable 2.0";
@@ -47,6 +48,18 @@ reg_digitizer: regulator-digitizer {
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
@@ -84,6 +97,70 @@ wacom_digitizer: digitizer@9 {
 	};
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	tsc@24 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		compatible = "cypress,tt21000";
+		reg = <0x24>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&reg_touch>;
+		touchscreen-size-x = <880>;
+		touchscreen-size-y = <1280>;
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
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -177,6 +254,15 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
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
@@ -184,6 +270,20 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
+			MX7D_PAD_I2C3_SCL__I2C3_SCL		0x4000007f
+		>;
+	};
+
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
2.37.3

