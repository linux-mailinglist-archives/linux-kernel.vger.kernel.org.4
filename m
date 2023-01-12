Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBA3668553
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjALV2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240368AbjALV2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:28:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B437840BC;
        Thu, 12 Jan 2023 13:07:39 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CKf2iT004083;
        Thu, 12 Jan 2023 21:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=GPGi75NJb+/+VvgXGPBXitrxDGnJoDB/pPWklJ8ioas=;
 b=D1n77G/BChxeOnbW7okOfpC4oW1v3r94aaUUu8gp6MC19NnTcWU0Yqn4DtFvj4darOM3
 rD9HTHWwRc8dfIUq/NkZyYdJCccDCFNpNepSr+rN3SBap8Nn431HZf2evtmdpz8rVZCr
 YvcLhiClmiLN3hTuJZzz25WsnV1ytKghDEhj+zCgOcv4iwCP5fghRRiirsMEQa5S5RbO
 /kQT6RpTlPyeFZhYm+BOR+QlPPaqtp2MDkXsV61p+JPhwhNIdBk4zqishUla/jkcn5eQ
 mXUopoB2QMg/0adxHU+2KN8Ps9naK0af9z1QOh549KXEmfRuM2KaNiK/JH/Wzo9BUa4i iA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2jghs110-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 21:07:34 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30CL7XGM002913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 21:07:34 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 13:07:33 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v6 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Date:   Thu, 12 Jan 2023 13:07:22 -0800
Message-ID: <20230112210722.6234-3-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230112210722.6234-1-quic_molvera@quicinc.com>
References: <20230112210722.6234-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yYC7nCBAPoWFMGeXE8_zmvxmwp8c6MMj
X-Proofpoint-ORIG-GUID: yYC7nCBAPoWFMGeXE8_zmvxmwp8c6MMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index e442a81895d0..1e8177cba93a 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -63,8 +63,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
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

