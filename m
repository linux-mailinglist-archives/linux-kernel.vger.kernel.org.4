Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8041707699
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjEQXwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEQXwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:52:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942393AA2;
        Wed, 17 May 2023 16:52:28 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HNhWdd023511;
        Wed, 17 May 2023 23:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=+YfXMZOV+Di1dlo3VxyeoiX3A94aQPiUQSHo2yDIK1o=;
 b=hq4P+GemjSVPvJVIRYwVEXDbNdjYR8UMWv5oPOF9K6uE/CZpO6FXLPuFaiEmicMKnrb7
 RoJc7vUp2rkRaJ9STCVqK5d81xxP1kpVquUJagYjHsNU2OkylsjRPxAEztdrdWkb4372
 +3U6JZ5EVA5MNF+ePCM3CfVJZ+YVGzW01G5ynQFDOYGRoeSV6EpbcM32cHOCliL9DByZ
 XPd9tOEIm2qLfVUMpMjhkHJcBwP9clh9JVFTweu0ESvQxtzc+njNYNkevojyNKzv0/re
 rB7LTjSrSJz/q70XqYx6KoKxHp0Kfmnuh6sKE63wb0Fz/j7XxaLXwYbutr93gLtADnkF 3g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn73ur5qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 23:52:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HNqNwE017108
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 23:52:23 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 16:52:23 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: qcom: sc8280xp: Add SDC2 and enable on CRD
Date:   Wed, 17 May 2023 16:52:17 -0700
Message-ID: <20230517235217.1728548-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2OdYG0yZOb-JJrhr1-9Vyoe2mZ9n49aM
X-Proofpoint-GUID: 2OdYG0yZOb-JJrhr1-9Vyoe2mZ9n49aM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CRD has Micro SD slot, introduce the necessary DeviceTree nodes for
enabling this.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- Order of pinctr-N and pinctrl-names
- Reset GCC_SDCC2_BCR and not sdc4

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 81 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi    | 43 ++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 5b25d54b9591..ff9cebbccfcb 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -308,6 +308,13 @@ vreg_l1c: ldo1 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l6c: ldo6 {
+			regulator-name = "vreg_l6c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l7c: ldo7 {
 			regulator-name = "vreg_l7c";
 			regulator-min-microvolt = <2504000>;
@@ -318,6 +325,13 @@ vreg_l7c: ldo7 {
 						   RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l9c: ldo9 {
+			regulator-name = "vreg_l9c";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l13c: ldo13 {
 			regulator-name = "vreg_l13c";
 			regulator-min-microvolt = <3072000>;
@@ -600,6 +614,19 @@ &remoteproc_nsp0 {
 	status = "okay";
 };
 
+&sdc2 {
+	pinctrl-0 = <&sdc2_default_state>;
+	pinctrl-1 = <&sdc2_sleep_state>;
+	pinctrl-names = "default", "sleep";
+
+	vmmc-supply = <&vreg_l9c>;
+	vqmmc-supply = <&vreg_l6c>;
+
+	cd-gpios = <&tlmm 131 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
 &uart17 {
 	compatible = "qcom,geni-debug-uart";
 
@@ -842,6 +869,60 @@ wake-n-pins {
 		};
 	};
 
+	sdc2_default_state: sdc2-default-state {
+		clk-pins {
+			pins = "sdc2_clk";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		cmd-pins {
+			pins = "sdc2_cmd";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		data-pins {
+			pins = "sdc2_data";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		card-detect-pins {
+			pins = "gpio131";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	sdc2_sleep_state: sdc2-sleep-state {
+		clk-pins {
+			pins = "sdc2_clk";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		cmd-pins {
+			pins = "sdc2_cmd";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		data-pins {
+			pins = "sdc2_data";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		card-detect-pins {
+			pins = "gpio131";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
 	tpad_default: tpad-default-state {
 		int-n-pins {
 			pins = "gpio182";
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 8fa9fbfe5d00..3711f109aeaf 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2815,6 +2815,49 @@ data-pins {
 			};
 		};
 
+		sdc2: mmc@8804000 {
+			compatible = "qcom,sc8280xp-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC2_BCR>;
+			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
+			interconnect-names = "sdhc-ddr","cpu-sdhc";
+			iommus = <&apps_smmu 0x4e0 0x0>;
+			power-domains = <&rpmhpd SC8280XP_CX>;
+			operating-points-v2 = <&sdc2_opp_table>;
+			bus-width = <4>;
+			dma-coherent;
+
+			status = "disabled";
+
+			sdc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1800000 400000>;
+					opp-avg-kBps = <100000 0>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+					opp-peak-kBps = <5400000 1600000>;
+					opp-avg-kBps = <200000 0>;
+				};
+			};
+		};
+
 		usb_0_qmpphy: phy@88eb000 {
 			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
 			reg = <0 0x088eb000 0 0x4000>;
-- 
2.25.1

