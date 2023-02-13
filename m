Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA929694CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBMQ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBMQ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:28:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26086DBD9;
        Mon, 13 Feb 2023 08:28:49 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DCBN1X017917;
        Mon, 13 Feb 2023 16:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=y351W8dxSmVJdswtTgSFA55/FWsPm3eKWffOuA8nLKY=;
 b=MGFK49XJlKPkHsMZBXNiBK5EpomwgHCP90iHMhdlvUrfexQPp/6wZThpsKRDTDSrwTes
 urC5FkOUQTpD9t5mcEjpNem3RiEPzV4Zj8/3m9pk1QNbz81IGBZe0n00nbZoJ1AW8ia0
 bdWhRjbm4TjJMhOoBaNS4Rr1M1s8Uk7XTC71epJ50pBvYNtVWSypFhwZCCNh+YOvFrOe
 JgCy5IAXA1BjiOhvvhFzTeCz6glDZMqMMlksFI3syuLNuLfsRSzO8zvBniVOrccqP/xR
 /xm6s6HhbBO/IPHath/pr8s+QROA8GJ6hU5rcEuULB0njtslR5kFXd/nG4MvPObVNhJ9 mA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np342vq9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 16:28:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DGSR0s002806
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 16:28:27 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 08:28:27 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink
Date:   Mon, 13 Feb 2023 08:28:19 -0800
Message-ID: <20230213162821.1253831-3-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213162821.1253831-1-quic_bjorande@quicinc.com>
References: <20230213162821.1253831-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z-fOP9Pip_nupOU1ThN7BN-Cld8-gRd_
X-Proofpoint-ORIG-GUID: z-fOP9Pip_nupOU1ThN7BN-Cld8-gRd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_11,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302130149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

The SC8280XP CRD control over battery management and its two USB Type-C
port using pmic_glink and two GPIO-based SBU muxes.

Enable the two DisplayPort instances, GPIO SBU mux instance and
pmic_glink with the two connectors on the CRD.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v2:
- Added empty line between properties and child nodes.

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 208 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi    |  10 ++
 2 files changed, 216 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 2179c06b4e3b..7778ddd601f0 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -36,6 +36,84 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	pmic-glink {
+		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_con0_hs: endpoint {
+						remote-endpoint = <&usb_0_role_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_con0_ss: endpoint {
+						remote-endpoint = <&mdss0_dp0_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_con0_sbu: endpoint {
+						remote-endpoint = <&usb0_sbu_mux>;
+					};
+				};
+			};
+		};
+
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_con1_hs: endpoint {
+						remote-endpoint = <&usb_1_role_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_con1_ss: endpoint {
+						remote-endpoint = <&mdss0_dp1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_con1_sbu: endpoint {
+						remote-endpoint = <&usb1_sbu_mux>;
+					};
+				};
+			};
+		};
+	};
+
 	vreg_edp_3p3: regulator-edp-3p3 {
 		compatible = "regulator-fixed";
 
@@ -139,6 +217,46 @@ linux,cma {
 			linux,cma-default;
 		};
 	};
+
+	usb0-sbu-mux {
+		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
+
+		enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
+		select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb0_sbu_default>;
+
+		mode-switch;
+		orientation-switch;
+		svid = /bits/ 16 <0xff01>;
+
+		port {
+			usb0_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_con0_sbu>;
+			};
+		};
+	};
+
+	usb1-sbu-mux {
+		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
+
+		enable-gpios = <&tlmm 48 GPIO_ACTIVE_LOW>;
+		select-gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb1_sbu_default>;
+
+		mode-switch;
+		orientation-switch;
+		svid = /bits/ 16 <0xff01>;
+
+		port {
+			usb1_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_con1_sbu>;
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -262,6 +380,36 @@ &mdss0 {
 	status = "okay";
 };
 
+&mdss0_dp0 {
+	data-lanes = <0 1>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			mdss0_dp0_out: endpoint {
+				remote-endpoint = <&pmic_glink_con0_ss>;
+			};
+		};
+	};
+};
+
+&mdss0_dp1 {
+	data-lanes = <0 1>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			mdss0_dp1_out: endpoint {
+				remote-endpoint = <&pmic_glink_con1_ss>;
+			};
+		};
+	};
+};
+
 &mdss0_dp3 {
 	compatible = "qcom,sc8280xp-edp";
 	/delete-property/ #sound-dai-cells;
@@ -480,7 +628,6 @@ &usb_0 {
 };
 
 &usb_0_dwc3 {
-	/* TODO: Define USB-C connector properly */
 	dr_mode = "host";
 };
 
@@ -499,12 +646,15 @@ &usb_0_qmpphy {
 	status = "okay";
 };
 
+&usb_0_role_switch {
+	remote-endpoint = <&pmic_glink_con0_hs>;
+};
+
 &usb_1 {
 	status = "okay";
 };
 
 &usb_1_dwc3 {
-	/* TODO: Define USB-C connector properly */
 	dr_mode = "host";
 };
 
@@ -523,6 +673,10 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&usb_1_role_switch {
+	remote-endpoint = <&pmic_glink_con1_hs>;
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
@@ -709,4 +863,54 @@ reset-n-pins {
 			drive-strength = <16>;
 		};
 	};
+
+	usb0_sbu_default: usb0-sbu-state {
+		oe-n-pins {
+			pins = "gpio101";
+			function = "gpio";
+			bias-disable;
+			drive-strengh = <16>;
+			output-high;
+		};
+
+		sel-pins {
+			pins = "gpio164";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+		};
+
+		mode-pins {
+			pins = "gpio167";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+			output-high;
+		};
+	};
+
+	usb1_sbu_default: usb1-sbu-state {
+		oe-n-pins {
+			pins = "gpio48";
+			function = "gpio";
+			bias-disable;
+			drive-strengh = <16>;
+			output-high;
+		};
+
+		sel-pins {
+			pins = "gpio47";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+		};
+
+		mode-pins {
+			pins = "gpio50";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+			output-high;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 92d5b5e21e50..7897d33f1416 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3040,6 +3040,11 @@ usb_0_dwc3: usb@a600000 {
 				iommus = <&apps_smmu 0x820 0x0>;
 				phys = <&usb_0_hsphy>, <&usb_0_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
+
+				port {
+					usb_0_role_switch: endpoint {
+					};
+				};
 			};
 		};
 
@@ -3095,6 +3100,11 @@ usb_1_dwc3: usb@a800000 {
 				iommus = <&apps_smmu 0x860 0x0>;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
+
+				port {
+					usb_1_role_switch: endpoint {
+					};
+				};
 			};
 		};
 
-- 
2.25.1

