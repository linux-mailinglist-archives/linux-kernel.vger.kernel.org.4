Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168B168FC88
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjBIBPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjBIBPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:15:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4312112;
        Wed,  8 Feb 2023 17:15:00 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318NtCrE002600;
        Thu, 9 Feb 2023 01:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Gefn7U10FjXoZFMeGM4wlvJm5FR6Qk3g5g9TG7UvIb0=;
 b=RVHm4rGDVYnOyEECoC31eIx9F3cR5TV0LjSb2dQvIXJ18T9QzLBtNrpMBCQQo7igrjqh
 E5LXZWj94iwlUU/8/KYts8uXDB46hekL5m4SVtzyELceLBSk9rTo+/s8cSmjgxwdCxM1
 +u0cWtGrso7gPY/hWcknLd/HIWQaXPADV58tBKBMA2MAKAHzaaI5owBo1+YxQtschcsM
 Ctn3Z02gYnAs3T32Ih1P2Er7W0oqKhAQ9+ryl32Nb0+AMbCU36q2Ew5qsbEwKPkNGn+W
 HkkTkBAT293BHIocSw8uMAI6xBioktD2gCUmm7PcARqINjWuk9dlii6v1m8+cz0V+Zeq ag== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm7u8abdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 01:14:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3191Ei1Z015201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 01:14:46 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 8 Feb 2023 17:14:44 -0800
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
Subject: [PATCH v2 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink
Date:   Wed, 8 Feb 2023 17:13:23 -0800
Message-ID: <20230209011325.2603663-3-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209011325.2603663-1-quic_bjorande@quicinc.com>
References: <20230209011325.2603663-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ePCZzepJxsWrxPVqeyfTMrXFuTLOUcGr
X-Proofpoint-ORIG-GUID: ePCZzepJxsWrxPVqeyfTMrXFuTLOUcGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090010
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v1:
- Fixed style and property sort issues
- Moved dwc3/port to sc8280xp.dtsi, override remote-endpoint here
- Added pinconf properties to SBU control pins

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 200 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi    |   9 +
 2 files changed, 207 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 3f116a879e22..d2276b28b5db 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -36,6 +36,78 @@ chosen {
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
+					pmic_glink_con0_hs: endpoint {
+						remote-endpoint = <&usb_0_role_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					pmic_glink_con0_ss: endpoint {
+						remote-endpoint = <&mdss0_dp0_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
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
+					pmic_glink_con1_hs: endpoint {
+						remote-endpoint = <&usb_1_role_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					pmic_glink_con1_ss: endpoint {
+						remote-endpoint = <&mdss0_dp1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
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
 
@@ -139,6 +211,46 @@ linux,cma {
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
@@ -262,6 +374,34 @@ &mdss0 {
 	status = "okay";
 };
 
+&mdss0_dp0 {
+	data-lanes = <0 1>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
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
@@ -480,7 +620,6 @@ &usb_0 {
 };
 
 &usb_0_dwc3 {
-	/* TODO: Define USB-C connector properly */
 	dr_mode = "host";
 };
 
@@ -499,12 +638,15 @@ &usb_0_qmpphy {
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
 
@@ -523,6 +665,10 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&usb_1_role_switch {
+	remote-endpoint = <&pmic_glink_con1_hs>;
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
@@ -709,4 +855,54 @@ reset-n-pins {
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
index fcd393444f47..0495361fc0fd 100644
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
 
@@ -3095,6 +3100,10 @@ usb_1_dwc3: usb@a800000 {
 				iommus = <&apps_smmu 0x860 0x0>;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
+				port {
+					usb_1_role_switch: endpoint {
+					};
+				};
 			};
 		};
 
-- 
2.25.1

