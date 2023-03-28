Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA17C6CC0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjC1NaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjC1N3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:29:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6523A273;
        Tue, 28 Mar 2023 06:29:49 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTdXo005670;
        Tue, 28 Mar 2023 08:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680010179;
        bh=lV+HXvD7QcdmJmzElwDez7tC33GDs2nZ7rVEaoUKP70=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=ix3C9UIaEpSKpamTaQSuPXDSkP30LkpHS2EKK4sBBIBkrlRF3EDUfPb1KbjnT/Xnu
         WmqXxNyxuf4BgYetmGpsKVf0yRbr5kuUaQXbQ4ZTCdNV/y65PhCsnG3b88z+oKQPe1
         4SHa/5cMmD3eNizzECwv+KkONvZcS6cxoUNCbIQI=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SDTdlk007693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 08:29:39 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 08:29:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 08:29:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTcSC122376;
        Tue, 28 Mar 2023 08:29:39 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Tue, 28 Mar 2023 18:59:24 +0530
Subject: [PATCH v8 6/6] arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v8-6-4408134eb2f3@ti.com>
References: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3461; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=GBSLCEn9irDxaEIQSwlX3uqzJq0b8qmTn/M8uqYMMDI=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkIuu6yqEOh1VCnvYA/vYRiDQZ8ZGi9Mkg0/kP5
 Mpk2ICscuOJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCLrugAKCRBD3pH5JJpx
 RR1yD/4/aoKVBEdhxTihzM/wH2D7Br17mIokHUM59qnV8FuNW0npvlHTBkozXmZfe6G7gkSmJUF
 GK9JNGypYr7czzbORRfy9rk4ugwUTc/6GLnv1oy5hEj6+YQ7i2gDsPStMShgnC/S3QP9qc4UGo/
 dYhbMXKq7/WOz9q+MfrxbmSFS9Bz1ue1NDRZzeuLtyhn567M+4Eb/GK2VeGhNbBZCci6Fx9U2t0
 VCuST3HXQJElIyEnbWzi6Rk77MnHX2f0sqPFgimhzJ685QANlDuwXUNMyeZOrF7Ql0jEN+M4YbU
 JnDPvoH3X98SIrDYJf+u9wmDEb9pa8A9lgkNAqVpWvEjjitAT4eZe6Jk9JWkyArPFGeeZdGRIzx
 z+OpvLW04tI7OtQjm4YEPHz2cUqyFU7ZzM8E7gaKFQCV3N0cGSUW138d2VYn8Ryq4MSFfhf9yvB
 gHFaP/cJsXi5bEgxK3sKlhzXVWOoW7rSwS3Ze0whEOWoovE51OeMLIHeffGNJRHCuzOPGpwjO0m
 NGyswSgp/chDo6gwVbKv88PwJN/h1i4/0arXDbx9er8LSr3OV6Bm19f/BzjbzA+fzt+m3nl+lab
 tJb8MJV6HWgU9J2w3f8AaBc0nh1qyz15s9p/FuRwKcRPgEIOIDtpaocZVnnab6vbIHF85z4NwE6
 tf0k/G9e+fvkhsA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for audio codec and sound card, enable the audio serializer
(McASP1) under use and update pinmux.

The codec (TLV320AIC3106) is also supplied with a DVDD 1.8V supply from
the PMIC (TPS6593x) on the SK. [1] As the PMIC driver and devicetree
node is missing, skip describing DVDD for now and manually set the OCMV
voltage.

Link: https://www.ti.com/lit/zip/sprr459 [1]
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 77 +++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 2296d656323c..8d7087e5f9e4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -123,6 +123,41 @@ led-0 {
 			default-state = "off";
 		};
 	};
+
+	tlv320_mclk: clk-0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <12288000>;
+	};
+
+	codec_audio: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "AM62Ax-SKEVM";
+		simple-audio-card,widgets =
+			"Headphone",	"Headphone Jack",
+			"Line",		"Line In",
+			"Microphone",	"Microphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack",	"HPLOUT",
+			"Headphone Jack",	"HPROUT",
+			"LINE1L",		"Line In",
+			"LINE1R",		"Line In",
+			"MIC3R",		"Microphone Jack",
+			"Microphone Jack",	"Mic Bias";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+		};
+
+		sound_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3106>;
+			clocks = <&tlv320_mclk>;
+		};
+	};
 };
 
 &main_pmx0 {
@@ -201,6 +236,15 @@ AM62AX_IOPAD(0x130, PIN_INPUT, 0) /* (AB17) RGMII1_TXC */
 			AM62AX_IOPAD(0x12c, PIN_INPUT, 0) /* (W16) RGMII1_TX_CTL */
 		>;
 	};
+
+	main_mcasp1_pins_default: main-mcasp1-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x090, PIN_INPUT, 2) /* (L19) GPMC0_BE0n_CLE.MCASP1_ACLKX */
+			AM62AX_IOPAD(0x098, PIN_INPUT, 2) /* (R18) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62AX_IOPAD(0x08c, PIN_OUTPUT, 2) /* (K19) GPMC0_WEn.MCASP1_AXR0 */
+			AM62AX_IOPAD(0x084, PIN_INPUT, 2) /* (L18) GPMC0_ADVn_ALE.MCASP1_AXR2 */
+		>;
+	};
 };
 
 &main_i2c0 {
@@ -235,6 +279,19 @@ exp1: gpio@22 {
 				   "MCASP1_FET_SEL", "UART1_FET_SEL",
 				   "PD_I2C_IRQ", "IO_EXP_TEST_LED";
 	};
+
+	tlv320aic3106: audio-codec@1b {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x1b>;
+		ai3x-micbias-vg = <1>;	/* 2.0V */
+		ai3x-ocmv = <1>;	/* 1.5V */
+
+		/* Regulators */
+		AVDD-supply = <&vcc_3v3_sys>;
+		IOVDD-supply = <&vcc_3v3_sys>;
+		DRVDD-supply = <&vcc_3v3_sys>;
+	};
 };
 
 &sdhci1 {
@@ -303,3 +360,23 @@ cpsw3g_phy0: ethernet-phy@0 {
 		ti,min-output-impedance;
 	};
 };
+
+&mcasp1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcasp1_pins_default>;
+
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+	       1 0 2 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};

-- 
2.40.0

