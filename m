Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6BF62FDE9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiKRTXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiKRTXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:23:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0794965855;
        Fri, 18 Nov 2022 11:23:03 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIJGGbm025998;
        Fri, 18 Nov 2022 19:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=8tMwp+5QQ52R4yJrsU8rC5HtcJvGpm5eMMHAETMy6Xo=;
 b=JtM+5ik2i6H4gplIOZGNpJDYnzCuoqkOkJwBLhqx/FM+yfSIUb7KKjHTmPGydptlHP/Q
 ijk593lSQ5G7Qmg0LnB/Hux6wxUTVEADwOUfe7zXfNEiaEpsgub+IMlaMsG3M/A3smin
 PdCdFiCN2LennLNPuCEYMMPTf8/tKXfjVAz3KplIvveSGOA0AjK/YRQFT4/+D1v05RXr
 ckEPOTqC76u/nw7uecBr4G3erFy1Tc1alx/8+0of4pjpQGdR6odqBuwwezRAUzQt/roy
 TmKN1MOiLsCQCrw1kBClbWoqELuC0dee0otR8alYvErRjBmdRbo+FD6I7wGUrJOhx3as sQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kx0xrhyrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 19:22:59 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AIJMwX4008561
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 19:22:58 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 18 Nov 2022 11:22:58 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v4 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Date:   Fri, 18 Nov 2022 11:22:41 -0800
Message-ID: <20221118192241.29384-3-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118192241.29384-1-quic_molvera@quicinc.com>
References: <20221118192241.29384-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lVEpqsNutxeTc2c0lB5JyfRJUNFQ6EbS
X-Proofpoint-ORIG-GUID: lVEpqsNutxeTc2c0lB5JyfRJUNFQ6EbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 266 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts | 266 +++++++++++++++++++++++
 3 files changed, 534 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index afe496a93f94..da66d4a0a884 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -53,7 +53,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
new file mode 100644
index 000000000000..5aed483201fa
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
@@ -0,0 +1,266 @@
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
+
+	aliases {
+		serial0 = &uart7;
+	};
+
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			clock-frequency = <19200000>;
+			clock-output-names = "xo_board";
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
+
+		pcie_0_pipe_clk: pcie-0-pipe-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <1000>;
+			clock-output-names = "pcie_0_pipe_clk";
+			#clock-cells = <0>;
+		};
+
+		pcie_0_phy_aux_clk: pcie-0-phy-aux-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <1000>;
+			clock-output-names = "pcie_0_phy_aux_clk";
+			#clock-cells = <0>;
+		};
+
+		usb3_phy_wrapper_pipe_clk: usb3-phy-wrapper-pipe-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <1000>;
+			clock-output-names = "usb3_phy_wrapper_pipe_clk";
+			#clock-cells = <0>;
+		};
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	ppvar_sys: ppvar-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
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
+			regulator-name = "vreg_l8a_0p91";
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
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
new file mode 100644
index 000000000000..42eb0c33e7ba
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
@@ -0,0 +1,266 @@
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
+
+	aliases {
+		serial0 = &uart7;
+	};
+
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			clock-frequency = <19200000>;
+			clock-output-names = "xo_board";
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
+
+		pcie_0_pipe_clk: pcie-0-pipe-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <1000>;
+			clock-output-names = "pcie_0_pipe_clk";
+			#clock-cells = <0>;
+		};
+
+		pcie_0_phy_aux_clk: pcie-0-phy-aux-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <1000>;
+			clock-output-names = "pcie_0_phy_aux_clk";
+			#clock-cells = <0>;
+		};
+
+		usb3_phy_wrapper_pipe_clk: usb3-phy-wrapper-pipe-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <1000>;
+			clock-output-names = "usb3_phy_wrapper_pipe_clk";
+			#clock-cells = <0>;
+		};
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	ppvar_sys: ppvar-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
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
+			regulator-name = "vreg_l8a_0p91";
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
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
-- 
2.38.1

