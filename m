Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD76A68FC8A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjBIBPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjBIBPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:15:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92D4684;
        Wed,  8 Feb 2023 17:15:01 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318MfDwK027647;
        Thu, 9 Feb 2023 01:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=MrIp1Up8n5Xbu0zttFuFGM8RbbY2L2qvKoa1xIP/6Fg=;
 b=J+7p9Wc/k21f5bkLAl7NRLjMlIUcTzsqjRGw4e4SSNbEhO/PnlEERBw8V/4ApU8ITvg+
 MyyWeqxRGLSuqcIU6Wx5isQk3276sGwBGDVeqn2vEcl27o0WVVeOS17MnW4NG63Jhare
 gzZFBs4UVD9Wp0gUNCdJqAdPdoIfh9DKY05568+6yIFiQB36DdlVZMUq4krtAbAR0+Xa
 wtIesLEZ1dlVLu0QfX+dQgVBwa0sUvvtQgI3Lc+cBvlsJ42FmNy+41qN/WXq9/pl6/YO
 /i625vBskw8dXE18D4fm80dA7Qd8vCOQ7rLf0Zoq0f0twXQ8/BbR2KoIn2ETiuTpMTe/ WA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmg9egwsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 01:14:48 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3191Ekqm032323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 01:14:46 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 8 Feb 2023 17:14:45 -0800
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
Subject: [PATCH v2 3/4] arm64: dts: qcom: sc8280xp-x13s: Enable external display
Date:   Wed, 8 Feb 2023 17:13:24 -0800
Message-ID: <20230209011325.2603663-4-quic_bjorande@quicinc.com>
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
X-Proofpoint-GUID: aW2RFZCPBtbVpvJ43QU-Svn_3hsXgY2u
X-Proofpoint-ORIG-GUID: aW2RFZCPBtbVpvJ43QU-Svn_3hsXgY2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like on the CRD, add the necessary nodes to enable USB Type-C
altmode-based external display on the Lenovo ThinkPad X13s.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- Fixed style and property sort issues
- Moved dwc3/port to sc8280xp.dtsi, override remote-endpoint here
- Added pinconf properties to SBU control pins
- Dropped unused mode-pins

 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 188 +++++++++++++++++-
 1 file changed, 186 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f936b020a71d..923972e54eb1 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -77,6 +77,78 @@ switch-lid {
 		};
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
 
@@ -238,6 +310,46 @@ map1 {
 			};
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
@@ -377,6 +489,34 @@ &mdss0 {
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
 
@@ -871,8 +1011,13 @@ &usb_0 {
 };
 
 &usb_0_dwc3 {
-	/* TODO: Define USB-C connector properly */
 	dr_mode = "host";
+
+	port {
+		usb_0_role_switch: endpoint {
+			remote-endpoint = <&pmic_glink_con0_hs>;
+		};
+	};
 };
 
 &usb_0_hsphy {
@@ -895,8 +1040,13 @@ &usb_1 {
 };
 
 &usb_1_dwc3 {
-	/* TODO: Define USB-C connector properly */
 	dr_mode = "host";
+
+	port {
+		usb_1_role_switch: endpoint {
+			remote-endpoint = <&pmic_glink_con1_hs>;
+		};
+	};
 };
 
 &usb_1_hsphy {
@@ -1147,6 +1297,40 @@ reset-n-pins {
 		};
 	};
 
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
+	};
+
 	wcd_default: wcd-default-state {
 		reset-pins {
 			pins = "gpio106";
-- 
2.25.1

