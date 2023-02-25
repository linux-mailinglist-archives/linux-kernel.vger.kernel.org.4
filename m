Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC7E6A295A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBYLhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBYLhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:37:46 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9E91ADD4;
        Sat, 25 Feb 2023 03:37:40 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B5C8B5C00D9;
        Sat, 25 Feb 2023 06:37:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 25 Feb 2023 06:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677325059; x=
        1677411459; bh=zkvV/kpDqN4+vBBfkJ0Ok8hgd7iTj23LvSc8K7773zw=; b=Z
        eH7oKy9+ShD8vxserOKRKXTCiUTgsyLFOB281r3ywyQkEN76EcnO2jgxEVNC1eG1
        EzNHEB2QWh8EK5DECiW1mReQErPc6tF14X1lDiv6duO/3brx4uAMAeDAtCoVd6CU
        WlZvSzbwqN/M3DKQ4s+ZbjjrIpho6Cai/h2pYclIif4ydPuGeUuF0BUof54m49Vd
        87XmCDrtC0/RBdm0bQrVTND6c+6RPJE6jRokBUH+xXrHezdG8jB4kpGn1X6nKIw8
        N7oiTTE4JFP2dHvo9QM9vkgr1yq/TbmBUNnjL/r4j5C8G19vTYsety16BJW96avu
        25+AJGCiwV6nVvqQV5uJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677325059; x=1677411459; bh=zkvV/kpDqN4+v
        BBfkJ0Ok8hgd7iTj23LvSc8K7773zw=; b=Yqcaq9THMQ+kxSGsXTEvY6xN1Cvak
        x+QpIgP9uiJRmT1k5RBf3eOdieeipU7A3TKAlBqu2uPhXJHWbZi85bBS5vAAn9wT
        DrfCs/GtWBgpvtTT+KkLHAWMTZ+7GEEdAzm1Tb9bA/yVjnWSGelJYKo5rBqTumMs
        Vd0sFMFeBPAZaSbXf6KnSIrbQGUA3IJb43CgzioSHMglqk2hyUluvPnNjN0NF4TS
        EYb6NStqDwRGIIqD/8BFrcW9OZRdgLcF+3C6TjgFsrJch5f2Ph9YVfxm62RGfWqS
        SQ1eY836Bk+OEyltT64e5Rf6YaBGkwKFJ1WxJGOILdr8Ut84nT/q/KAhg==
X-ME-Sender: <xms:A_P5Y26ThTVxCkUpGs__CE9qODpw0wxv79-JawaqBGei86liOIyEKg>
    <xme:A_P5Y_61smEgbeq5Jn3OZzDbVO89F5OTFHqPde5L8wVN_XJ8swTRIkuCcVjdHU21T
    7JwGTv2jRQLhxeIIhA>
X-ME-Received: <xmr:A_P5Y1cJIirRhfZnu7z-fhGnujmpQ5zNONy0aPR3-TOZkL5ad4CVHH_-75unEo-5I7Qy3tzuXK8b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekte
    elvdelveevueeujeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:A_P5YzKQ-dfrEsD05CQfPZAxyrZlgcop5h0yV4_ErO_dVYSDDWf9_Q>
    <xmx:A_P5Y6IVK7MQgBteai8CnNBN0Z2D0ZeBAV_o5PprmGJCNar77ukA6w>
    <xmx:A_P5Y0xeBu3sf6GWsxT4Es_b5WCN4FuHFmQoVrN2W5Xe5oxALfIIMw>
    <xmx:A_P5Y1ZZScSJWl3KbIe6jw_Fq6A18f8ifkQcfF1dDPpLEAHt33ZG6w>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Feb 2023 06:37:34 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     arnd@arndb.de, alistair23@gmail.com, kernel@pengutronix.de,
        jernej.skrabec@gmail.com, linux@armlinux.org.uk,
        festevam@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 3/3] ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815
Date:   Sat, 25 Feb 2023 21:37:12 +1000
Message-Id: <20230225113712.340612-4-alistair@alistair23.me>
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

Add support for the rohm,bd71815 power controller controller for the
reMarkable 2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 158 ++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 288fc8611117..9ecb733545cc 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -91,6 +91,10 @@ wifi_pwrseq: wifi_pwrseq {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&buck1_reg>;
+};
+
 &clks {
 	assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
 			  <&clks IMX7D_CLKO2_ROOT_DIV>;
@@ -118,6 +122,147 @@ wacom_digitizer: digitizer@9 {
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
+		#gpio-cells = <1>;
+
+		regulators {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			buck1_reg: regulator@0 {
+				reg = <0>;
+				regulator-compatible = "buck1";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <1250>;
+			};
+
+			buck2_reg: regulator@1 {
+				reg = <1>;
+				regulator-compatible = "buck2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <1250>;
+			};
+
+			buck3_reg: regulator@2 {
+				reg = <2>;
+				regulator-compatible = "buck3";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <2700000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck4_reg: regulator@3 {
+				reg = <3>;
+				regulator-compatible = "buck4";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5_reg: regulator@4 {
+				reg = <4>;
+				regulator-compatible = "buck5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: regulator@5 {
+				reg = <5>;
+				regulator-compatible = "ldo1";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2_reg: regulator@6 {
+				reg = <6>;
+				regulator-compatible = "ldo2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: regulator@7 {
+				reg = <7>;
+				regulator-compatible = "ldo3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: regulator@8 {
+				reg = <8>;
+				regulator-compatible = "ldo4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5_reg: regulator@9 {
+				reg = <9>;
+				regulator-compatible = "ldo5";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			dvref_reg: regulator@a {
+				reg = <0xa>;
+				regulator-compatible = "ldodvref";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			lpsr_reg: regulator@b {
+				reg = <0xb>;
+				regulator-compatible = "ldolpsr";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			wled_reg: regulator@c {
+				reg = <0xc>;
+				regulator-compatible = "wled";
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
@@ -292,6 +437,12 @@ MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x00000034 /* WACOM INT */
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
@@ -322,6 +473,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
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

