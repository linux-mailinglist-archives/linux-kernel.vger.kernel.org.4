Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3FE6B7B08
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjCMOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjCMOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:50:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F8835BA;
        Mon, 13 Mar 2023 07:50:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DEngJX044512;
        Mon, 13 Mar 2023 09:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678718983;
        bh=xDr7Pvji9JKHAiVQxH6IsyfNhpqWt97bltmNKB/R4bw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JzdXdUe2vf4qtxVoU555Bx2DX5A+XxzgSrjK/PMt5kfzV7AZGBlZYPdyaq1ycUUb8
         wFl5kIZL2cygp6MuCgwM6ZHpV6EQDXCfsaw5C3hnK8YNRLwXq20WhXXcaHzbBvc+Ze
         xhGMwlu6t1tJkHXVouT6xYU5YjSCajIVJJSl+Un4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DEngA9127726
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 09:49:42 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 09:49:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 09:49:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DEnfeo005291;
        Mon, 13 Mar 2023 09:49:42 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v5 3/6] arm64: dts: ti: k3-am625-sk: Enable audio on AM62 SK
Date:   Mon, 13 Mar 2023 20:19:32 +0530
Message-ID: <20230313-mcasp_upstream-v5-3-d6844707aa8a@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
References: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3509; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=qbZwv830evAh8S1QTh/60C26lc/AuC9RZaa+Vn7mrt8=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkDzbUlhPE4H8JRmYEVz0xHicKnc6BuJOJ89EYR
 tzcKIcBDbSJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZA821AAKCRBD3pH5JJpx
 RVJrD/0UC98f+FkkJoydZOrMdGuvtgZbWHPikkWv+6H8v+6JHTBN23lJbx/F1K2fXu9y9oLqBol
 iCdD89tuZ+3feHqxKsbV33cqvQjU0DATGhEcZDIXqsR39Db2GxoPQ1nyTwJvQEf/XSljCr8OmN7
 ycfu1aO33N3cxySSfUhcM/C+6OC2Lh1xPfPZ6n1X2rfHvHDf1dhWc5a8KF0BqPpkd+7D/qsIcov
 KSwBtzuZB0T49JoJsTbIBazqSTZRAM9UeL5WSwgGxF/gfyTnnljQM2Bqa0pbMroRZ7wc1nFboUX
 AfhR9TzxZ+NHF+sAJFT16ZYOHc52/IQaRuofmZQCVGhwAqAbrkRXqv+BuEMJlXSveKV37gbEiFf
 A7Zbjtaj3sNCCLwA5iIdghwDetbKE6JDsdNaTQewBlh0R+3Hw6lps+zdasKOXlnxTtnDC1kG8j9
 yjmts8oIs3d+6aCrHKgCeQf1uPPSbtZ/MRioOnAxeW0k1TB7K3VaKY6+Syx3YfwbR/NRS3kCtz3
 fqOUMOwsNefhhnEEqrfeTnIk1cJeC1hWMOt/2TKEu/lQYpcYL3ewaZ/Jg1DMbWomOoFKSZYXyIp
 Exe9A8s/S7d1zU/kdrjCzFYrmCEp1o73Z4R6pkIFSlZucHyJzWS/fLtxWaYz6ZFKKixPqzcSyz5
 X6UeFrEV+nDMMpg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for audio codec and sound card, enable the audio serializer
(McASP1) under use and update pinmux.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 88 ++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 6bc7d63cf52f..3199042f3687 100644
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
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "AM62x-SKEVM";
+		simple-audio-card,widgets =
+			"Headphone",	"Headphone Jack",
+			"Line",	"Line In",
+			"Microphone", "Microphone Jack";
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
+			AM62X_IOPAD(0x0090, PIN_INPUT, 2) /* (M24) GPMC0_BE0N_CLE.MCASP1_ACLKX */
+			AM62X_IOPAD(0x0098, PIN_INPUT, 2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62X_IOPAD(0x008c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEN.MCASP1_AXR0 */
+			AM62X_IOPAD(0x0084, PIN_INPUT, 2) /* (L23) GPMC0_ADVN_ALE.MCASP1_AXR2 */
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
2.39.2
