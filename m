Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02196C7A75
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjCXI4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjCXIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:55:43 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E62241C9;
        Fri, 24 Mar 2023 01:55:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32O8tU0Q077432;
        Fri, 24 Mar 2023 03:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679648130;
        bh=lV+HXvD7QcdmJmzElwDez7tC33GDs2nZ7rVEaoUKP70=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rEgB8SWp+aFINKlmfVUHmWKgA/0BfvP9p7VQ/gbNX/LthGHZgi7nDJg3pkR+1FK+I
         Vop71CBOhZzWs3crIxsiH06SUtRiDgQ4Nfj2APjbxZzLflXaXzcjWtLfIWUAVEx3ze
         jm1BSLy8uJ9kMv6SRJRui8X8+soO+4sGB7zy1HF4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32O8tUoo063786
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Mar 2023 03:55:30 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Mar 2023 03:55:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Mar 2023 03:55:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32O8tTCe035786;
        Fri, 24 Mar 2023 03:55:29 -0500
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
Subject: [PATCH v7 6/6] arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A
Date:   Fri, 24 Mar 2023 14:25:20 +0530
Message-ID: <20230313-mcasp_upstream-v7-6-88168d0df9b8@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230313-mcasp_upstream-v7-0-88168d0df9b8@ti.com>
References: <20230313-mcasp_upstream-v7-0-88168d0df9b8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3461; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=GBSLCEn9irDxaEIQSwlX3uqzJq0b8qmTn/M8uqYMMDI=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkHWSKFS06xQ9UaZeV7f0LdY3MzfuIEB82Gvje1
 6BM2FXaht6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZB1kigAKCRBD3pH5JJpx
 RZRCEADSrdnFI2KyybklEeVMcD8m4EdkL2h1zIVm2VxpRhlkkYkXJ6nAB5d0mnU8hV9RhNJ5o1a
 tFQ2KXMldmUew8RgQLf17byuL6crN0qQ9cT4qUTm2w7Fo0V1cTEXmc+UbB/5K6/rZARajnc2GhV
 HmGPGm0KbHu5hzkXh/5ZZgCr9XPsQPut8dFcV0xWgP93mvhTIIHp9LrU9Y3hgfQ1v6MpcHJnUx6
 sOjDDCLADiDqtaQFc7lxfNS7Cu4T17z0LppiYx05VqXIfyT6KATSWHOEVHST6dxR9JCamV5Z7jx
 3zT8tV6t1lKPiycXOysNuTNBY6hZ1S3B4/TgL/CAsluUZzkwG9G7M4AgrJa90cvYDjnMvhi4UA+
 zIcXw3hhXqYvn3Ap2077RHn3SRYudS0mHSBPICVuSo9Wut5xRlZX+xgY+t0Elk5OX3AxYHP0YJV
 cJq2m3QYD71kQG41zYciNR1TJ6AE7FxhM+I4UKPt3Kdg9RU3V2XIP5PutlbQ934so+n6GWCevwZ
 yCHpEP610xZCNm/KXz8m2VsNLQFmgN+Tm9DFDNQL42MNiXpQs2y9clEfY2WP+/mIahOm7Nq4FdK
 WRVy1MGwde9tgYSIQytjZao93X8KPDiPTBtjV3qn5+f8SDv0idJfWkadvuw9JziAywORXq5e2hY
 cpfb8dsWEYIUoDA==
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

