Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140FA6D000A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjC3JpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjC3JpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:45:02 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EE7EFA;
        Thu, 30 Mar 2023 02:45:00 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32U9ip1Z012217;
        Thu, 30 Mar 2023 04:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680169491;
        bh=BcDIjJzjHM+N/vIcwapsyTbufzOIObtBASc/eP3RZoY=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=IDEjAYfbYtctMKxgMjw1gonoHtbT1gywv0S2qG5QhWh5pSMn3hSZMt/OLDYDvQG7R
         CKCGfi+TJD3xDGF3WVLFAjQH3BSkl6p9T+mLGjga9oXH5Rf3t+u3brv7tKzq7lE0In
         Jw30VnlJIQYoduKJh0OKujFLpjNM23nz8CmDD7zU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32U9ipGo126016
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 04:44:51 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 04:44:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 04:44:51 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32U9iowg107066;
        Thu, 30 Mar 2023 04:44:50 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Thu, 30 Mar 2023 15:14:06 +0530
Subject: [PATCH v10 2/3] arm64: dts: ti: Enable audio on SK-AM62(-LP)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v10-2-94332149657a@ti.com>
References: <20230313-mcasp_upstream-v10-0-94332149657a@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v10-0-94332149657a@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4664; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=Q+DrbQqKkVZKHL1+fZFKT0R9RrX4odqVY5iWfqn0blo=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBkJVoFQYr/KMFWODnOKxTQqqXaZy4jFItaKnytD
 B3AAeOhIM2JAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCVaBQAKCRBD3pH5JJpx
 RVsnEACdlmJvCBpAwnyV89JQID2dDiFOgEw05vrdFFk5D51Mm4a/kkfuXcFlox/gBIN9yHRWNPq
 VJGytbdxT3f0FbvuMqPQ199FqBi508QZqJZJwj2+rN4LOAN4TwC3i7GeMaEOVdAm8Z4etwWMTy+
 weo5+Fyb11Qx3lv+feKbngwkmxnVdGlBGhK2LLHQAxaXMOgerXuZXM+T0H7GLt43X7g26kDV6ai
 ID1gUQR/Z9y9w7m9Oub24J9ytPcHrnWVbVQxmeWGcM4oIsT8vvPYSg+igwRYMFM3c2Pv0C21Vfq
 k+iNBYnOBe3DKM9geF9hch9Z/vG1dT7KWi+EhOt8CoPsVrwgF3ZjBIHmD2hz5VwJ1rQ/U1NtM77
 YU0eUGsPttdrpfMdsHAI+EE1q3Z71T5DCAy87+MqTDRhV+v4ema1UVdV6aTHbYsIbv/qSodBIr1
 gyWlu+b7dwSFqfi+cy94S63c9aCfhfTmYnuw56Q2d+7v+84J8wEtziJZ51P/1c7tMSksi4Jk9sC
 K6P+CtJ6LxE+p+LIWf7E2RZ3jH2Eg7qcsyaSJSugIin1b9QcTA+205XInXc0lIL37MuBoI7Ecao
 Z9FrcQeL/CebKEKP7WqqHtEQVRSS/zBcF1tjkqQQelBapWy269NvrTxADjSOTMa4RQfK1Nx9qDp
 hXMoOEL/SMtxpDA==
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
(McASP1) under use from SK-AM62 E2 [1] onwards and update pinmux.

Keep all audio related nodes in the common dtsi as they are exactly the
same between SK-AM62 and SK-AM62-LP [2].

Link: https://www.ti.com/lit/zip/sprr448 [1]
Link: https://www.ti.com/lit/zip/sprr471 [2]
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts       |  4 ++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts         | 15 +++++
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 76 ++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index b2ca19e3042e..4b94f7a86316 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -225,3 +225,7 @@ ldo4_reg: ldo4 {
 		};
 	};
 };
+
+&tlv320aic3106 {
+	DVDD-supply = <&buck2_reg>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index cdc0858dd1b2..2a1adda9bff6 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -87,6 +87,17 @@ vdd_sd_dv: regulator-4 {
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
 	};
+
+	vcc_1v8: regulator-5 {
+		/* output of TPS6282518DMQ */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3_sys>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &main_pmx0 {
@@ -256,3 +267,7 @@ partition@3fc0000 {
 		};
 	};
 };
+
+&tlv320aic3106 {
+	DVDD-supply = <&vcc_1v8>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 54318a07d50c..e197ea5fa448 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -81,6 +81,41 @@ led-0 {
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
+		simple-audio-card,name = "AM62x-SKEVM";
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
@@ -175,6 +210,15 @@ main_usb1_pins_default: main-usb1-pins-default {
 			AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18/E16) USB1_DRVVBUS */
 		>;
 	};
+
+	main_mcasp1_pins_default: main-mcasp1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x090, PIN_INPUT, 2) /* (M24) GPMC0_BE0N_CLE.MCASP1_ACLKX */
+			AM62X_IOPAD(0x098, PIN_INPUT, 2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62X_IOPAD(0x08c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEN.MCASP1_AXR0 */
+			AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23) GPMC0_ADVN_ALE.MCASP1_AXR2 */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -205,6 +249,18 @@ &main_i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
+
+	tlv320aic3106: audio-codec@1b {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x1b>;
+		ai3x-micbias-vg = <1>;	/* 2.0V */
+
+		/* Regulators */
+		AVDD-supply = <&vcc_3v3_sys>;
+		IOVDD-supply = <&vcc_3v3_sys>;
+		DRVDD-supply = <&vcc_3v3_sys>;
+	};
 };
 
 &sdhci0 {
@@ -272,3 +328,23 @@ &usb1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usb1_pins_default>;
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
2.34.1

