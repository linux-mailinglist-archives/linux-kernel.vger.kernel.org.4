Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640E964DAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLOL54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiLOL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:57:33 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411E22A726;
        Thu, 15 Dec 2022 03:57:29 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A96B93200929;
        Thu, 15 Dec 2022 06:57:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Dec 2022 06:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1671105447; x=
        1671191847; bh=xs+I3mt0XyFW9Uq6BJw0KPPKa2WXad4KJwYkN13Dk4I=; b=J
        bxjOoV5ArcqEER6o0FOUBPEUANkgHnVthnqoxTq3hBXOUqKdCmgRlTxfs/ao/XEt
        G6bXrW3N1OkUmoSIwCwugv5rxv9GTxdjPjgobdHytAWaucQ85LQI0ojzbXLXLtus
        cMWerHc+8kDafRh7OI8CC1HFY7MnTzo94OSJ3t+R4KdDXZCUES3V659qVzK26NKF
        TeOi2M8ygRnRouUuRnZQ3BfKkpgBjU4uiOnzJMCfTnG/w2XthD4lckf5LfsbtcLZ
        CEqZby217y7EUc/jWINvI3Z1TFgFvXf7cvqwdJEV8o1IGq5RWP5wVDqYvQ9VBJhQ
        EcaWuZ299RO25btHdDzeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671105447; x=1671191847; bh=xs+I3mt0XyFW9
        Uq6BJw0KPPKa2WXad4KJwYkN13Dk4I=; b=EWTjsaSujELYbXhUnw1yCrEQIiy9B
        kY9hP5IlVWysolg4LIwHfbOwo28QvH53hDWMoQFZ5huUdJsTjMnwIw3YU856U0QD
        riOPi1CTIWS4ExN0MvKHgr6ARuYc4X5Bh/GGKcxWb+SjvE1yNt+5FqHmECxu2pDX
        3MA+/ohAskhs0nAzuGQzLctbNgmYWNjlkaT7ew9s2y67jzowfs57qEuvDsMuEuHY
        UfW2Jpuugt6iZsQJrkIUCF6D+ySwhOEjed2hsRNfPS5m+cRJvZmY+7jnHPIxAV0M
        k4rJCnJx86STfwnfDD95j7QSrPhfCB4CVeatCgxRnXLbdM7bHv+4SWkfg==
X-ME-Sender: <xms:pwubY3kWTBTmOGLew6RUwNRooaXReFg360_fioaUqfTHCEyTa7lQbQ>
    <xme:pwubY61jGO5jNxPBOwZFXgX_x6mhmzsnfynq2xCZxlHn4ekKdFpK5WDpPYtqa2QCh
    FK_AenuKta6_WGJM8E>
X-ME-Received: <xmr:pwubY9o2zCqeOR4UgEhWDepEuzmfG7drEouEM6J0LThCv4FCll2tCCOfcb6_T_C_qi1eQaRdRVwm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:pwubY_miFpRXb94dwJ50cQW-X_PTBQuVEF39xiyvok1fFJRKNQA-Ww>
    <xmx:pwubY13e3svXCWeGRlnYFgaX99du94wBdhKr5Mo7kljWVTEmLH0vVg>
    <xmx:pwubY-vXTi68z24-9Ls6C9FtWYvOWz3AvRTvdVkmX34ejDncaWFUJw>
    <xmx:pwubY03tBVsQtdaY1ZFPpjrD3nZN55bonw1aqn2G1V2BNoW0NGrA0g>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 06:57:20 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     jernej.skrabec@gmail.com, alistair23@gmail.com, festevam@gmail.com,
        kernel@pengutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 3/3] ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815
Date:   Thu, 15 Dec 2022 21:56:44 +1000
Message-Id: <20221215115644.208486-4-alistair@alistair23.me>
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

Add support for the rohm,bd71815 power controller controller for the
reMarkable 2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 158 ++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index a138b292ec6a..e61ef3bd2eb9 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -92,6 +92,10 @@ wifi_pwrseq: wifi_pwrseq {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&buck1_reg>;
+};
+
 &clks {
 	assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
 			  <&clks IMX7D_CLKO2_ROOT_DIV>;
@@ -119,6 +123,147 @@ wacom_digitizer: digitizer@9 {
 	};
 };
 
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	bd71815: pmic@4b {
+		#clock-cells = <0>;
+
+		compatible = "rohm,bd71815";
+		reg = <0x4b>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_bd71815>;
+		interrupt-parent = <&gpio6>; /* PMIC_INT_B GPIO6_IO16 */
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&clks IMX7D_CLKO2_ROOT_SRC>;
+		clock-output-names = "bd71815-32k-out";
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
+			dvref_reg: regulator@10 {
+				reg = <10>;
+				regulator-compatible = "dvref";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			lpsr_reg: regulator@11 {
+				reg = <11>;
+				regulator-compatible = "lpsr";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			wled_reg: regulator@12 {
+				reg = <12>;
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
@@ -293,6 +438,12 @@ MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x00000034 /* WACOM INT */
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
@@ -323,6 +474,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
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
2.38.1

