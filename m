Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703FA6C7A71
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjCXIzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjCXIzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:55:36 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DE926846;
        Fri, 24 Mar 2023 01:55:34 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32O8tPXI128171;
        Fri, 24 Mar 2023 03:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679648125;
        bh=WWOP4aRIWd/jh8+ZcCgCIjPJAKEXKhQ2HMU/ipW9sjU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J9srIS5Dx5pVUVTK+J27fPa3wMuhto3BHBqcJMqu/mQSNCF8W2elJdUV5chSW6lk4
         /UEohCfmFRuJrt8gs7k6fJ/OKd2NlOF5CzO0C7ZnYVfLTOYsp97HwvD3L0ZvIot/q0
         4Lyy3jp73EhoFXcwpawCEGpdlhS4ecSBI7LG2aZg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32O8tPYc008999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Mar 2023 03:55:25 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Mar 2023 03:55:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Mar 2023 03:55:25 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32O8tOqN027180;
        Fri, 24 Mar 2023 03:55:24 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v7 3/6] arm64: dts: ti: k3-am625-sk: Enable audio on AM62 SK
Date:   Fri, 24 Mar 2023 14:25:17 +0530
Message-ID: <20230313-mcasp_upstream-v7-3-88168d0df9b8@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230313-mcasp_upstream-v7-0-88168d0df9b8@ti.com>
References: <20230313-mcasp_upstream-v7-0-88168d0df9b8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3645; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=Jfmq2hTI5D+agV3PMHzp8o/deZ6uvAoCjMXmJAjsZhQ=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkHWSHFTX+mW2B7VKg/e7oIxXrIEI7SFRgnv2D3
 +i9Px1XNnWJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZB1khwAKCRBD3pH5JJpx
 Re1ZEADBwCQ4iMrl9T+GNzWHza6hw1RyKTPISP7a4S9CQn2a3kgdSeb/pWt5r7+vYHEwQoAaPRU
 ybwy0LFz+VTdZzjCeAaaEt7mZkcavLZ8YU6LFFU/pLigaxUpkVnNt9RYE4owFpZGIQcF7ecASGQ
 vy/RAVntP9uTNN7mCtf0g026DHCeWVGHHaMYSxTlOOWSEV3nBF2LKJNgpBhYyMLt6i382VcsDs/
 Wr3R/ZtIo85/nL0AwmFxe0WTG7BBkTAgKdYdWu7YxNxdhSCp4/UkJtLOESoVFLaYllE2n9Irwqu
 5NYiLOoKtFJ999TVc1d+Try+GDs9hr6UUyWejMC9lKuHreaFV/a24A3+ClYcSQ88kc4rDdL7iib
 O9N4cubSKQ/hgWxDZdsgKfyAhzJ0iJgHyVWpA84AwBni+oTSVjwTalUlzW6ETvSd4w6R1f6RJxr
 E2NnZkJhr+9HRsedBYpss9vcEGHOO5QSEZVVwCANqWTKzdrmfiQGHF6XOQxZvOlBwy92+K1aYHb
 44lZf/4PusNBIR6flkNqoUXB5lO6V14AHwrx1l4AE6Iin4uNlpxYSy2S+TlAt4zj4jcsogrja3z
 zBXNEXLglsLE78IYYmOQ4d6C9tUhu/gu++SR18icAOqGFk2dFoMmJjZYF6VU5Nb/eiQW2nwpf6v
 AyYMubys5UcH/VA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
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

Link: https://www.ti.com/lit/zip/sprr448 [1]
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 88 ++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 6bc7d63cf52f..2727a3c81e93 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -141,6 +141,52 @@ vdd_sd_dv: regulator-4 {
 			 <3300000 0x1>;
 	};
 
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
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -292,6 +338,15 @@ main_usb1_pins_default: main-usb1-pins-default {
 			AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */
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
@@ -349,6 +404,19 @@ exp1: gpio@22 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
 	};
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
+		DVDD-supply = <&vcc_1v8>;
+	};
 };
 
 &sdhci0 {
@@ -406,6 +474,26 @@ cpsw3g_phy1: ethernet-phy@1 {
 	};
 };
 
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
+
 &mailbox0_cluster0 {
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 0>;

-- 
2.40.0

