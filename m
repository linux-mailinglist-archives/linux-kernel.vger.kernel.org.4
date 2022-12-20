Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74774651FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiLTLaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiLTLaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:30:02 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6DE19025;
        Tue, 20 Dec 2022 03:29:59 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7AB6A32001FC;
        Tue, 20 Dec 2022 06:29:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 20 Dec 2022 06:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1671535798; x=
        1671622198; bh=GH62AyLJISEmcTjBHciDga5dnjECW2sy9VV41roQWv0=; b=t
        p0a48y4Y6UYshSG7vSDLEot48wotk0RaWvXvZooFKY6lLzQAk0slevWW5cmlkFfv
        ZfXIKJaW17R8GugGjFbRNBCBcAmTkNyVp1p0k8hXoaJssbx++4L0kCR6MAywYCd1
        2fnYqSZAZnCHQTynrXkj9bLhtKO0INGflSm+AY5Eqa50MzAQTnSPqNgFxsT7xXWw
        2wv9F14M6043W03FQTDlw1fa0xowWBnADOZJ53NDCz5hBJVZEe4pPuBEraQztlzh
        VLXO6y4u9PLJkLVOWoiNSSWTHEVw3kUfjs9aIWn60U8ndG2OLk/M915lmeD1O7wz
        0tn7LYqrHZ8sL9RD3QysA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671535798; x=1671622198; bh=GH62AyLJISEmc
        TjBHciDga5dnjECW2sy9VV41roQWv0=; b=fMuWqlgh4hoGBf12Wfvr8+pXtPwE7
        ij/6KFzaxwY72zWhvcB8EsG06TzuAd4QlRoEFhoL4grNhpWuX/k64hFPr3xU/Ys8
        gpr/9AamqirqmbK50e5mra6Dh06HiSux9K7Ok/qTuoNNt+tQNkiCNhSaYHjrgixk
        rnMVoD1tjSUCoZRh02PiQEvNLPrLtujZnRuvCSQPBoKNRn+32ZrEQWYaKs0amILs
        9MKUZZvc1lZCzakgxhmVOILQ2S6mzX0cBremAyIIYxgZupOt5ScgH5ZP1F5h8hj8
        TMzWUN4otPKIBwA75BI0mmGk8psvbvTNwMqYOPGzQDsp9v/fBP7CE1aCw==
X-ME-Sender: <xms:tZyhYxTNHc5KMZt8H_0a_zoLgbjX3ZUoUQY3Y1q2CPkFSNoO4UHJjw>
    <xme:tZyhY6xlVjc6r4g6yVJQljYtxDrAumC1lHofuH1Rviw1VuWQuuHgSMmkEL1UrWwlv
    qGWHwNBQSvRQCgqtNY>
X-ME-Received: <xmr:tZyhY20qEgmJ9pkphL4Tkdz0QGLXoagGUUqbeVIFGaCaKlpi-1dr2vLdnMs_BACiJf0bkNWNE_Yv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:tZyhY5BqORa9miBJdauQ6lVwjORAnptZLFO3XPATf9otNRhVUvgHLg>
    <xmx:tZyhY6iDM2Vcngq9e2V1M5p_vOSVG9gRRJdssEPr0gxqbOJBWUlcGA>
    <xmx:tZyhY9qa_u5N_iycrWgznCFpZQVMpXtn03tXifBh23BPIXiP1Dfx3A>
    <xmx:tpyhYxTHLA9T2GXkv3ko7Q7QPHIguviTpbcOwdy_wfasCSuZbFWaBA>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Dec 2022 06:29:52 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        s.hauer@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux@armlinux.org.uk, festevam@gmail.com, kernel@pengutronix.de,
        arnd@arndb.de, alistair23@gmail.com, jernej.skrabec@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 3/3] ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815
Date:   Tue, 20 Dec 2022 21:29:27 +1000
Message-Id: <20221220112927.440506-4-alistair@alistair23.me>
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

Add support for the rohm,bd71815 power controller controller for the
reMarkable 2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 159 ++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index a138b292ec6a..4387d30d6180 100644
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
@@ -119,6 +123,148 @@ wacom_digitizer: digitizer@9 {
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
+				regulator-compatible = "dvref";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			lpsr_reg: regulator@b {
+				reg = <0xb>;
+				regulator-compatible = "lpsr";
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
@@ -293,6 +439,12 @@ MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x00000034 /* WACOM INT */
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
@@ -323,6 +475,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
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

