Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4C96CD7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjC2Kb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjC2Kby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:31:54 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C246B3;
        Wed, 29 Mar 2023 03:31:42 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVVvN098585;
        Wed, 29 Mar 2023 05:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680085891;
        bh=lV+HXvD7QcdmJmzElwDez7tC33GDs2nZ7rVEaoUKP70=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=txyvRP2Lsov/pxFOBqyupEWnwbHES7DfwhmSApO/GBd3Ns9ng7AVATZcGWpEeV/TH
         D1Ad1V4gOSpgIzdrEbf5xMN2XVwm9rQR8/faUrgi/UlDq2vPNkdkScQ5tjG4YFYpTO
         X57DCqq7qKEyKJlxuTLiH/hvxV2Ngl+Ff8Fyb2iE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TAVVsN082151
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 05:31:31 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 05:31:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 05:31:30 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVUlX054206;
        Wed, 29 Mar 2023 05:31:30 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 29 Mar 2023 16:01:03 +0530
Subject: [PATCH v9 6/6] arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v9-6-6d937efe4ec4@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3461; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=GBSLCEn9irDxaEIQSwlX3uqzJq0b8qmTn/M8uqYMMDI=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkJBN51iZYomreIyh8x1rFsO0X7NpQeh33ZYLap
 6Rk63VJ0bmJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCQTeQAKCRBD3pH5JJpx
 RfBeD/9VsIfc9VA2vXJwaVfIlNnxo9XQFQPyRE3iKwG7rCffmhm+pYk+fz3rZTwSZFOX3tJoKHE
 4OjTTg7IVExtrxa4Pu9k2H+8RxoWlh6Elgl3yWfVT+Jg7sxuOaaiJaSN8pmERPF3XkIRGyefgKs
 LGga8vWucKDUhwfzAnWqj1mSNQWYwjS0C/ro8e6Newn00GDQzxUpBUtXAayJGwqm0mg3rpv4kI0
 +EOe1Xkt0/0m7CAIlrienqtmbnDXixjwuQqVpVkoA75hgHJwsvLYnJQPW9IPJgLRp4BwKYoHS/U
 LPN9UmnwAILOMy6JoQyZ3+wL0X6IYcchOqQRbYkqRmIPCnR4nOIHwRPQjkKknRj1D5u3O7kKg2d
 DXr+X8xdeHKfWjut5gCOx7U2ZAAlS/YlfvrIGu50CzaQNlWD4FElgojC0lDOGQGN+XGDYUPt2i9
 7VdY84hxHbabrUPIEy9yBH7REryYdqnAiwhCSdqtaFvTJpFvmeMMjyhZrtnmzmqRP63s3Wk+EvW
 pQieDgmsNGjbI90gQ5+SkDAOAGVHA63+rdH+cUaJKn9N6ZGUDo/OGtFzTG/CFzSGme4TAA8U2Uu
 rGxscqkvXnE5GQCTmpw+A/qHWhlH4a6UyoItTEPc7jv1DPxsiVyaqiUAaQseIs/PirqV4uVZ5F7
 9fPWJoeb6OJ2ZXA==
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

