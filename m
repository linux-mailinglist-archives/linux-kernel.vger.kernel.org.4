Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0396A3A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjB0EvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjB0EvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:51:08 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3837B1BAFE;
        Sun, 26 Feb 2023 20:50:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A201B320051E;
        Sun, 26 Feb 2023 23:50:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 26 Feb 2023 23:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677473456; x=
        1677559856; bh=TJroo3DveOVWOH9H0vj3EtrJ4rUtjS/zD73NY4F8tF8=; b=f
        fiNJuVc0q9QGnSw3b1GTjixHCboZbzB2J/hD6yBMVm40JAEIiLru2+oRxj7BhC4j
        bFQ/q1MGhL4eWECZ2HTkeKpyeLEhlUFPCTuZ7dgwhzfytcPyUbX+Qdmrg+jbs1ra
        TeAlr6hPaAG2nxMQ+FXHceEOKG46nnwAo+SjKRGm+9ddWz2d+L0khFLNARFCY1/E
        kluRz0AwXrEo1H6Kwa+npnPDpXCKTSJd/mnAjCIaEVaSJUYceJOXINxEiX5dFneB
        jplM+WQieFF7xURdOHSEpP1Vc2D/zyKc2CRMkcUa6CVC2H1yrJLATMILg+jtTCYZ
        V57YSz61IZ5MfX2XA0MxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677473456; x=1677559856; bh=TJroo3DveOVWO
        H9H0vj3EtrJ4rUtjS/zD73NY4F8tF8=; b=VzboF+piuBzq2EtlHZvNT6/0Gldb/
        7QO6EuyrbPppae1XaYj/G5nmXDSrDmZcP/QB5AJj/NvJxiKoOzInQz1jNUr3QbqS
        vgSrJnCQ390TGxYLj6tPxFBB1mr5dmYgZUyvVWTBhnDgnAY96GGWPPSRcdnKXTnn
        oqUT9QIwDiblOoBa6x6XGiUqHgA5ILHlYyPMGI1Z6GYMqeJNOtZ8oI+jlxQ6rKiR
        rENGapubslsDNptYq7FR1CKPJ6DL+rSs2FjT9ND11vVzuNDNIuJq5Wf36F4OHSSm
        Z86ShOl8doF79FXXjen1+Gg/tMd2Nj1MdxQ0bgDB6QJjk/Hw+Ht38z0Ow==
X-ME-Sender: <xms:rzb8Yx1MOfkZFZAsy6dOuXvZPHBHv0gGqD3KkmuHuNhVX88hpsuzbw>
    <xme:rzb8Y4GSeTDsBR23MoHZMUN7LBDm196VFp2psZh8AgHiyfcLQcT_OUtMaEG-4yYvb
    ajHr3PqoHLjnF2zv1U>
X-ME-Received: <xmr:rzb8Yx6fr8FnlrWLrw2ZhGTDCyw9uTXDiaxa81Ts6f2Yg8jKRUt9liRXGhDnh8h11onSyPLrY8Li>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekte
    elvdelveevueeujeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:rzb8Y-0fRzk5lRSCHpOvXObBcW8GgpuQt5Lso5v4XMWR2B2BHxAnJg>
    <xmx:rzb8Y0FKt3ouwjSDfmvXbtu1_4x8ZX2QL_9SXFrAZmrUM2HhCYcQbw>
    <xmx:rzb8Y_-fkz_3KzqZ0Xf1NKlsVpRQYa2H0ynqLLEkhEYDYQpDp4Gpuw>
    <xmx:sDb8YxdQ7Xt2qPkHBlJtU9YbLrGnXmzcNWFwYZzASMMPubTJeYpvAA>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Feb 2023 23:50:50 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, linux-imx@nxp.com
Cc:     linux@armlinux.org.uk, arnd@arndb.de, alistair23@gmail.com,
        kernel@pengutronix.de, festevam@gmail.com,
        jernej.skrabec@gmail.com,
        Alistair Francis <alistair@alistair23.me>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v4 3/3] ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815
Date:   Mon, 27 Feb 2023 14:50:23 +1000
Message-Id: <20230227045023.560319-4-alistair@alistair23.me>
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

Add support for the rohm,bd71815 power controller controller for the
reMarkable 2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 142 ++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 288fc8611117..dc954e4f63e0 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -91,6 +91,10 @@ wifi_pwrseq: wifi_pwrseq {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&buck1>;
+};
+
 &clks {
 	assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
 			  <&clks IMX7D_CLKO2_ROOT_DIV>;
@@ -118,6 +122,131 @@ wacom_digitizer: digitizer@9 {
 	};
 };
 
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	bd71815: pmic@4b {
+		compatible = "rohm,bd71815";
+		reg = <0x4b>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_bd71815>;
+		interrupt-parent = <&gpio6>; /* PMIC_INT_B GPIO6_IO16 */
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+		gpio-controller;
+		clocks = <&clks IMX7D_CLKO2_ROOT_SRC>;
+		clock-output-names = "bd71815-32k-out";
+		#clock-cells = <0>;
+		#gpio-cells = <2>;
+
+		regulators {
+			buck1: buck1 {
+				regulator-name = "buck1";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <1250>;
+			};
+
+			buck2: buck2 {
+				regulator-name = "buck2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <1250>;
+			};
+
+			buck3: buck3 {
+				regulator-name = "buck3";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <2700000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck4: buck4 {
+				regulator-name = "buck4";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: buck5 {
+				regulator-name = "buck5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: ldo1 {
+				regulator-name = "ldo1";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: ldo2 {
+				regulator-name = "ldo2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: ldo3 {
+				regulator-name = "ldo3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: ldo4 {
+				regulator-name = "ldo4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: ldo5 {
+				regulator-name = "ldo5";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo6: ldodvref {
+				regulator-name = "ldodvref";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo7: ldolpsr {
+				regulator-name = "ldolpsr";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			boost: wled {
+				regulator-name = "wled";
+				regulator-min-microamp = <10>;
+				regulator-max-microamp = <25000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
 &i2c3 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -292,6 +421,12 @@ MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x00000034 /* WACOM INT */
 };
 
 &iomuxc {
+	pinctrl_bd71815: bd71815grp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_RX_SYNC__GPIO6_IO16	0x59
+		>;
+	};
+
 	pinctrl_brcm_reg: brcmreggrp {
 		fsl,pins = <
 			/* WIFI_PWR_EN */
@@ -322,6 +457,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
+			MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
-- 
2.39.1

