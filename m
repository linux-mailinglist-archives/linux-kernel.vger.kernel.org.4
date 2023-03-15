Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4020D6BAB89
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjCOJEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjCOJEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:04:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53926EBAB;
        Wed, 15 Mar 2023 02:03:56 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F93mLA127362;
        Wed, 15 Mar 2023 04:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678871028;
        bh=0lYrIScH+yNn1X25mqEMmFmR/i3+JO5JFvUIYx6TOGw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bFeC/h6T4k3ESORquN6FmF3TQIYYJ0YjgJV6va9A34UUnZC076qIabDrsFwaEVuOL
         vbqC3HgOMPVPQp9tZwH+L8RmHIvT5JcAmgy+lHsoWha9WLSNfnmYn2eYNu1Kt+jQen
         7i2+z/cYd161jwxhzRhTH4josOJK65vCLpKK5cbE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F93mOA005980
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 04:03:48 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 04:03:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 04:03:47 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F93kmd055400;
        Wed, 15 Mar 2023 04:03:47 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v6 6/6] arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A
Date:   Wed, 15 Mar 2023 14:33:35 +0530
Message-ID: <20230313-mcasp_upstream-v6-6-77685d7cbeb8@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313-mcasp_upstream-v6-0-77685d7cbeb8@ti.com>
References: <20230313-mcasp_upstream-v6-0-77685d7cbeb8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3410; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=mbTjZi6u12cwf6QVpxp0isgwDzQXw7xYfsdeXS3858g=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkEYdbb4YNVXTXdqXRxfr6iVIS5Yr7OXhefyKZW
 yUWU68llqqJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZBGHWwAKCRBD3pH5JJpx
 Rf2yD/oCcNtGVcH7HJelvXLqlIEa9MM5tHFR8pfJO0HGwghNt0Gt3BfZQbu2OfJpjriYbKCPsNO
 iu0Ar+ZEJd52TxfQ8qFwyMwMjFKWWEx1Ef8m0LKkNyCoEzm4l2Qbpc+IvGFS9oiF6mHEOCdCqMr
 DWveudrQSrvQFBogmHJJ06wil0YDEV69hiqNvNa1iTJBQh2YO1ABdYGcArUXpcWniQmzZXGk6Sr
 FlRAG02u/SCkSR3AoKRQTxICE9mjPIKP1a+gkxBZ5XU2S6W+muuqh6TxSk1HTZsXg4zi3Vf62Is
 Y7CO1GF+d2AqAHXdXY0+x5DRSvunDLwQBBtckvfE/gvUThM/Uhm7y2CP7aZgzqC3vOaliGoDP3o
 mSJ1MjdnBS0r67MZJAYLD7ialbjYqn69zszodkQiqONKIaYDog1C3LFOe4Fo7xBBcn+mP5kD5jd
 7MiVHY6Hig+tPHkgIsoOqKFa48wK6NUXiWutf1oXDXPvJLkHhh3Sx+53sFWds5Xg9RcWD69WR6S
 BjZiJ+ZC1s5WteVwnv3jMQ8AHJEGP9ggxlSwOpqmLuxBvq4ut0CfbU5v7Fy2mzlRJAVoMURmKDr
 FR6ynrrPp7ODy+005aj4Kdf45uYNYSfcczISFD3ER3ZOlnqDT2khOw8Mr1A7vFwYcjCP8EoTBOH
 iHEiXT1YNS7C0dg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for audio codec and sound card, enable the audio serializer
(McASP1) under use and update pinmux.

The codec (TLV320AIC3106) is also supplied with a DVDD 1.8V supply from
the PMIC (TPS6593x) on the SK. As the PMIC driver and devicetree node is
missing, skip describing DVDD for now and manually set the OCMV voltage.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 77 +++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 063e69e45163..2ee894340be1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -122,6 +122,41 @@ led-0 {
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
@@ -200,6 +235,15 @@ AM62AX_IOPAD(0x130, PIN_INPUT, 0) /* (AB17) RGMII1_TXC */
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
@@ -234,6 +278,19 @@ exp1: gpio@22 {
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
@@ -302,3 +359,23 @@ cpsw3g_phy0: ethernet-phy@0 {
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
2.39.2
