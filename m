Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D5264F505
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLPX2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLPX2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:28:35 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5CE22521;
        Fri, 16 Dec 2022 15:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671233313; x=1702769313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eYY+lRrMLBE2PL2DnsW+qWfSgDcDJDj5wp7Ot96xCJE=;
  b=FF/FP13nySL69SefRKIhxPybJA+SiFO8t2HoWQpB29CkycS31TCrKkaK
   VuYgjqi2P8AhU+h6LB6T9VO9s0aQpJmEek5Xye8Uv3LaZ34nhiP4rPAHp
   +dJmuLQtvX1nuQedmbiM3qPc9SWiLwanyxUFsIhAmrlmPB9Soy3aRY8bE
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Dec 2022 15:28:33 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 15:28:07 -0800
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 15:28:06 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v5 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Date:   Fri, 16 Dec 2022 15:27:53 -0800
Message-ID: <20221216232753.6671-3-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221216232753.6671-1-quic_molvera@quicinc.com>
References: <20221216232753.6671-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DTs for Qualcomm IDP platforms using the QDU1000 and QRU1000
SoCs.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 arch/arm64/boot/dts/qcom/Makefile        |   2 +
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 453 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts | 453 +++++++++++++++++++++++
 3 files changed, 908 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 3e79496292e7..4d06a6ff5194 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -56,8 +56,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
new file mode 100644
index 000000000000..9e9fd4b8023e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "qdu1000.dtsi"
+#include "pm8150.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. QDU1000 IDP";
+	compatible = "qcom,qdu1000-idp", "qcom,qdu1000";
+	chassis-type = "embedded";
+
+	aliases {
+		serial0 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	clocks {
+		xo_board: xo-board-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <19200000>;
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
+	};
+
+	ppvar_sys: ppvar-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&ppvar_sys>;
+	};
+};
+
+&apps_rsc {
+	regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
+		vdd-l2-l10-supply = <&vph_pwr>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s5a_2p0>;
+		vdd-l6-l9-supply = <&vreg_s6a_0p9>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s4a_1p8>;
+		vdd-l13-l16-l17-supply = <&vph_pwr>;
+
+		vreg_s2a_0p5: smps2 {
+			regulator-name = "vreg_s2a_0p5";
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <570000>;
+		};
+
+		vreg_s3a_1p05: smps3 {
+			regulator-name = "vreg_s3a_1p05";
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <1170000>;
+		};
+
+		vreg_s4a_1p8: smps4 {
+			regulator-name = "vreg_s4a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_s5a_2p0: smps5 {
+			regulator-name = "vreg_s5a_2p0";
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_s6a_0p9: smps6 {
+			regulator-name = "vreg_s6a_0p9";
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vreg_s7a_1p2: smps7 {
+			regulator-name = "vreg_s7a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vreg_s8a_1p3: smps8 {
+			regulator-name = "vreg_s8a_1p3";
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l1a_0p91: ldo1 {
+			regulator-name = "vreg_l1a_0p91";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l2a_2p3: ldo2 {
+			regulator-name = "vreg_l2a_2p3";
+			regulator-min-microvolt = <2970000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l3a_1p2: ldo3 {
+			regulator-name = "vreg_l3a_1p2";
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1260000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l5a_0p8: ldo5 {
+			regulator-name = "vreg_l5a_0p8";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l6a_0p91: ldo6 {
+			regulator-name = "vreg_l6a_0p91";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-name = "vreg_l7a_1p8";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+
+		};
+
+		vreg_l8a_0p91: ldo8 {
+			regulator-name = "vreg_l8a_0p91";
+			regulator-min-microvolt = <888000>;
+			regulator-max-microvolt = <925000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l9a_0p91: ldo9 {
+			regulator-name = "vreg_l9a_0p91";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l10a_2p95: ldo10 {
+			regulator-name = "vreg_l10a_2p95";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l11a_0p91: ldo11 {
+			regulator-name = "vreg_l11a_0p91";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-name = "vreg_l12a_1p8";
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-name = "vreg_l14a_1p8";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l15a_1p8: ldo15 {
+			regulator-name = "vreg_l15a_1p8";
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l16a_1p8: ldo16 {
+			regulator-name = "vreg_l16a_1p8";
+			regulator-min-microvolt = <1710000>;
+			regulator-max-microvolt = <1890000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l17a_3p3: ldo17 {
+			regulator-name = "vreg_l17a_3p3";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l18a_1p2: ldo18 {
+			regulator-name = "vreg_l18a_1p2";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+	};
+};
+
+&qup_i2c1_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c2_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c3_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c4_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c5_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c6_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c9_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c10_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c11_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c12_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c13_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c14_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c15_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_spi1_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi1_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi2_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi2_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi3_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi3_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi4_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi4_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi5_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi5_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi6_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi6_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi9_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi9_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi10_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi10_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi11_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi11_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi12_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi12_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi13_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi13_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi14_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi14_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi15_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi15_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_uart7_rx {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_uart7_tx {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
new file mode 100644
index 000000000000..2cc893ae4d10
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "qru1000.dtsi"
+#include "pm8150.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. QRU1000 IDP";
+	compatible = "qcom,qru1000-idp", "qcom,qru1000";
+	chassis-type = "embedded";
+
+	aliases {
+		serial0 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	clocks {
+		xo_board: xo-board-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <19200000>;
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
+	};
+
+	ppvar_sys: ppvar-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&ppvar_sys>;
+	};
+};
+
+&apps_rsc {
+	regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
+		vdd-l2-l10-supply = <&vph_pwr>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s5a_2p0>;
+		vdd-l6-l9-supply = <&vreg_s6a_0p9>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s4a_1p8>;
+		vdd-l13-l16-l17-supply = <&vph_pwr>;
+
+		vreg_s2a_0p5: smps2 {
+			regulator-name = "vreg_s2a_0p5";
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <570000>;
+		};
+
+		vreg_s3a_1p05: smps3 {
+			regulator-name = "vreg_s3a_1p05";
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <1170000>;
+		};
+
+		vreg_s4a_1p8: smps4 {
+			regulator-name = "vreg_s4a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_s5a_2p0: smps5 {
+			regulator-name = "vreg_s5a_2p0";
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_s6a_0p9: smps6 {
+			regulator-name = "vreg_s6a_0p9";
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vreg_s7a_1p2: smps7 {
+			regulator-name = "vreg_s7a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vreg_s8a_1p3: smps8 {
+			regulator-name = "vreg_s8a_1p3";
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l1a_0p91: ldo1 {
+			regulator-name = "vreg_l1a_0p91";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l2a_2p3: ldo2 {
+			regulator-name = "vreg_l2a_2p3";
+			regulator-min-microvolt = <2970000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l3a_1p2: ldo3 {
+			regulator-name = "vreg_l3a_1p2";
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1260000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l5a_0p8: ldo5 {
+			regulator-name = "vreg_l5a_0p8";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l6a_0p91: ldo6 {
+			regulator-name = "vreg_l6a_0p91";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-name = "vreg_l7a_1p8";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+
+		};
+
+		vreg_l8a_0p91: ldo8 {
+			regulator-name = "vreg_l8a_0p91";
+			regulator-min-microvolt = <888000>;
+			regulator-max-microvolt = <925000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l9a_0p91: ldo9 {
+			regulator-name = "vreg_l9a_0p91";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l10a_2p95: ldo10 {
+			regulator-name = "vreg_l10a_2p95";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l11a_0p91: ldo11 {
+			regulator-name = "vreg_l11a_0p91";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-name = "vreg_l12a_1p8";
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-name = "vreg_l14a_1p8";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l15a_1p8: ldo15 {
+			regulator-name = "vreg_l15a_1p8";
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l16a_1p8: ldo16 {
+			regulator-name = "vreg_l16a_1p8";
+			regulator-min-microvolt = <1710000>;
+			regulator-max-microvolt = <1890000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l17a_3p3: ldo17 {
+			regulator-name = "vreg_l17a_3p3";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l18a_1p2: ldo18 {
+			regulator-name = "vreg_l18a_1p2";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+	};
+};
+
+&qup_i2c1_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c2_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c3_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c4_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c5_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c6_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c9_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c10_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c11_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c12_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c13_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c14_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_i2c15_data_clk {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_spi1_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi1_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi2_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi2_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi3_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi3_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi4_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi4_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi5_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi5_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi6_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi6_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi9_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi9_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi10_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi10_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi11_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi11_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi12_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi12_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi13_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi13_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi14_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi14_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi15_cs {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_spi15_data_clk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&qup_uart7_rx {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_uart7_tx {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
-- 
2.38.1

