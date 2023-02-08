Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B87268E6CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjBHDqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjBHDql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:46:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714359F3;
        Tue,  7 Feb 2023 19:46:40 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3183C6W1030942;
        Wed, 8 Feb 2023 03:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Hy/wT/mz7m3gInSibiHuzR9ukijBDP4B6Hr72JsVwNo=;
 b=IM1eb7i6A91OgarMOFHlcLIMVTZOQ9j8vy/NklKGnhQ7CGY8vTNVvL9sxRTnny1ug69f
 pH957A+5dI9fyAMSxBJUaaFGV9SeeahhzLbRkVs6q52usnB+vVEBex1xqw+DgOgW6Nr7
 I0eHyYKfXmdlQtWr+UDinS4uiZUShESXedcxYHJ1uzUip0b4yJRSjpczvlG9kBm1FriO
 AvK/hHYFxXGWeXhykGzojKuhP89qOVZ+26Jav1/FTbJqfZJ/UIswN9gkoxrNgPtg/O8j
 YnOKnxEkY8wC1sgFkVOjGFK8M3o4jHh6lTFHsrTtGe2KTHJ/j/+dQFaRUonALVmCLB+6 DQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nke4h3a1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 03:46:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3183kRRH017868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 03:46:27 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 19:46:26 -0800
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
Subject: [PATCH 3/4] arm64: dts: qcom: sc8280xp-x13s: Enable external display
Date:   Tue, 7 Feb 2023 19:46:19 -0800
Message-ID: <20230208034620.2048744-4-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230208034620.2048744-1-quic_bjorande@quicinc.com>
References: <20230208034620.2048744-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yKvBmZkUi_PfTwH2NkCGy0xtZI1jR2BA
X-Proofpoint-ORIG-GUID: yKvBmZkUi_PfTwH2NkCGy0xtZI1jR2BA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_15,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080032
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
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 191 +++++++++++++++++-
 1 file changed, 189 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 9f1456fde932..4ef15edd6c0f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -77,6 +77,77 @@ switch-lid {
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
 
@@ -238,6 +309,46 @@ map1 {
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
@@ -377,6 +488,36 @@ &mdss0 {
 	status = "okay";
 };
 
+&mdss0_dp0 {
+	status = "okay";
+
+	data-lanes = <0 1>;
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
+	status = "okay";
+
+	data-lanes = <0 1>;
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
 
@@ -871,8 +1012,13 @@ &usb_0 {
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
@@ -895,8 +1041,13 @@ &usb_1 {
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
@@ -1147,6 +1298,42 @@ reset-n-pins {
 		};
 	};
 
+	usb0_sbu_default: usb0-sbu-state {
+		oe-n-pins {
+			pins = "gpio101";
+			function = "gpio";
+		};
+
+		sel-pins {
+			pins = "gpio164";
+			function = "gpio";
+		};
+
+		mode-pins {
+			pins = "gpio167";
+			function = "gpio";
+			output-high;
+		};
+	};
+
+	usb1_sbu_default: usb1-sbu-state {
+		oe-n-pins {
+			pins = "gpio48";
+			function = "gpio";
+		};
+
+		sel-pins {
+			pins = "gpio47";
+			function = "gpio";
+		};
+
+		mode-pins {
+			pins = "gpio50";
+			function = "gpio";
+			output-high;
+		};
+	};
+
 	wcd_default: wcd-default-state {
 		reset-pins {
 			pins = "gpio106";
-- 
2.39.1

