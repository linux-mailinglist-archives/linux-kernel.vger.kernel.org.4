Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3133E6CD7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjC2KcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjC2Kby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:31:54 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB3A421E;
        Wed, 29 Mar 2023 03:31:42 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVQlg098573;
        Wed, 29 Mar 2023 05:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680085886;
        bh=3S3tU/w76kbNj52BhpgOvsYc6Xh0PhtEwqIxgzS86gU=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=hjTi1NQaalKR6Voig8xSZcr69XvnXUCwBYHCiKs4c6zoRoeKhZ17G/KfIj9PTrnVl
         HpwAMKpXez/HbINFqIOkHGJpKcjCAm1+zwWCf4RnBvcyxje8ni3G+Fxznqf3MlsYtz
         KcpUeLy6mtLIHYCbrv/AkFErHOmotOUU8dC3K66A=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TAVQBK082093
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 05:31:26 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 05:31:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 05:31:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVPS7017602;
        Wed, 29 Mar 2023 05:31:26 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 29 Mar 2023 16:01:00 +0530
Subject: [PATCH v9 3/6] arm64: dts: ti: k3-am625-sk: Enable audio on AM62
 SK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v9-3-6d937efe4ec4@ti.com>
References: <20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4614; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=snywC+u2eW5l7GHkT85YHwhh0I6PyjNVV1tmLjqUAx8=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkJBN2SPYJshfhlZNh3JhaXRHv2DTz8XPESTdaw
 TBMmmJjnyGJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCQTdgAKCRBD3pH5JJpx
 RfiLD/9JHUc80cbZvJEmqw/owuNa8UMwK0GicZfDsVyKa0ReKBQFVLZ9gXRFeKbjEXF9pflqxcu
 lvFawON0q3YuJNVXtC8dn/BLGcE0UKmn2jYfJysliUB8rehc/S9PbpF6SaUW1owCp7lZRMP8lPz
 6tQLtsoodeF+6iLYdYYUA0GGkrbIaG1cP2ddWWHh6s4IIq9fzlQqGdsrbHDM0RZr0Nr8Z3H5jXD
 D0P0D4QI+8KPgGH+acQ6agRWP4Qzp5sRTtDGonUPSwSzDeWgiP1hb/wqQTlJ0cri0tOnZ16EX9/
 k2MZcnQaFz5IYLHwmt8jfrMCCzPf8mnzYUuGM962jp/MX1nh16Wkhlf7vStJrJ8EcDkNuJnlpMs
 l2iLuJJhcWeE3ZkNPywG4CAQ5TT7ilAhfS/PtE9W/6dU66bnnT3mU/XnSnq86Wv9DgOkF+fls33
 JCwwjLIIdM1XRMvyyPH5SXOKRfXoWoAas7SIr6UBtRcmoSOaiUMvcUhFer4tq49XWWvmQhI5x4c
 slp8fTgm73tcEkUGTEAaMmvCl9K2yam5dQojyFoyinaB6yUEDFBeKfWxcjM/TOelXdE8KclCdn5
 igwK/mz7+YJgm2oc3ytvCTcyN3XClfiZscTjIgLv0p5AQ5RDU8Fou070BNz8kbE4HrIy6Osjw0q
 W7T48/dscJuo3/w==
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
same between SK-AM62 and SK-AM62-LP.

Link: https://www.ti.com/lit/zip/sprr448 [1]
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
2.40.0

