Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5100072D441
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbjFLWPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbjFLWPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:15:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047BC10F2;
        Mon, 12 Jun 2023 15:15:07 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJrWqn018957;
        Mon, 12 Jun 2023 22:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=pGyvwgOlbTLUo+V/Y9nEOaXJa/euEuK6f+dzmjv3IZ8=;
 b=Pp94PJcnhy3iWHX0XFwvsvm7xLHUnN6/KpEcl2Sqmr7uEO5U8BBwDWRKFl6Emiv+d5z4
 2JFYq0uQ5CygKCFpW9KsEnpgXWJxq6r1ZRQ7lRkWtFRzBsPlYd3HWnQP/iCDvwC8dmB6
 D+rLoK/l8QUjEAtDJ5D6hLelfkQqV/U3ZvjGEZbrWCQ8VywO2V47i+hLBVUHRzdpUITa
 P+a8ZxlZoOw5ZjJpbJcYJLw4W1M2qLYFXk5qpppESD+DSuvNRmKRHi/9YcYSHbUakZUQ
 SdZawfccgLwQn1QR7Wt0y15Ih1t3boAbZmW+PxpZ7/W01+14w/pNor9eeyL5R5pq3Ldb DQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r60pesfk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:15:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CMF3pY022238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:15:03 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 15:15:02 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sc8180x-flex5g: Wire up USB Type-C
Date:   Mon, 12 Jun 2023 15:14:56 -0700
Message-ID: <20230612221456.1887533-4-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230612221456.1887533-1-quic_bjorande@quicinc.com>
References: <20230612221456.1887533-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CqIVJeCj7HUS553nE3pthGnz8pCp_Y3h
X-Proofpoint-ORIG-GUID: CqIVJeCj7HUS553nE3pthGnz8pCp_Y3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the SC8180X Primus reference design, add pmic_glink and USB
Type-C wiring for battery manager, external display and orientation
switching.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  | 196 ++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index fe3b366e1435..677cb255fad2 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -45,6 +45,84 @@ lid {
 		};
 	};
 
+	pmic-glink {
+		compatible = "qcom,sc8180x-pmic-glink", "qcom,pmic-glink";
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
+						remote-endpoint = <&usb_prim_role_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_con0_ss: endpoint {
+						remote-endpoint = <&usb_prim_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_con0_sbu: endpoint {
+						remote-endpoint = <&usbprim_sbu_mux>;
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
+						remote-endpoint = <&usb_sec_role_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_con1_ss: endpoint {
+						remote-endpoint = <&usb_sec_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_con1_sbu: endpoint {
+						remote-endpoint = <&usbsec_sbu_mux>;
+					};
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		rmtfs_mem: rmtfs-region@85500000 {
 			compatible = "qcom,rmtfs-mem";
@@ -100,6 +178,44 @@ vreg_s4a_1p8: pm8150-s4-regulator {
 
 		vin-supply = <&vph_pwr>;
 	};
+
+	usbprim-sbu-mux {
+		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
+
+		enable-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+		select-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbprim_sbu_default>;
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			usbprim_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_con0_sbu>;
+			};
+		};
+	};
+
+	usbsec-sbu-mux {
+		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
+
+		enable-gpios = <&tlmm 188 GPIO_ACTIVE_LOW>;
+		select-gpios = <&tlmm 187 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbsec_sbu_default>;
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			usbsec_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_con1_sbu>;
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -283,6 +399,24 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&usb_prim_qmpphy_dp_in>;
+};
+
+&mdss_dp1 {
+	status = "okay";
+};
+
+&mdss_dp1_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&usb_sec_qmpphy_dp_in>;
+};
+
 &mdss_edp {
 	data-lanes = <0 1 2 3>;
 
@@ -419,6 +553,8 @@ &usb_prim_qmpphy {
 	vdda-phy-supply = <&vreg_l3c_1p2>;
 	vdda-pll-supply = <&vreg_l5e_0p88>;
 
+	orientation-switch;
+
 	status = "okay";
 };
 
@@ -430,6 +566,18 @@ &usb_prim_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_prim_qmpphy_dp_in {
+	remote-endpoint = <&mdss_dp0_out>;
+};
+
+&usb_prim_qmpphy_out {
+	remote-endpoint = <&pmic_glink_con0_ss>;
+};
+
+&usb_prim_role_switch {
+	remote-endpoint = <&pmic_glink_con0_hs>;
+};
+
 &usb_sec_hsphy {
 	vdda-pll-supply = <&vreg_l5e_0p88>;
 	vdda18-supply = <&vreg_l12a_1p8>;
@@ -442,9 +590,23 @@ &usb_sec_qmpphy {
 	vdda-phy-supply = <&vreg_l3c_1p2>;
 	vdda-pll-supply = <&vreg_l5e_0p88>;
 
+	orientation-switch;
+
 	status = "okay";
 };
 
+&usb_sec_qmpphy_dp_in {
+	remote-endpoint = <&mdss_dp1_out>;
+};
+
+&usb_sec_qmpphy_out {
+	remote-endpoint = <&pmic_glink_con1_ss>;
+};
+
+&usb_sec_role_switch {
+	remote-endpoint = <&pmic_glink_con1_hs>;
+};
+
 &usb_sec {
 	status = "okay";
 };
@@ -560,6 +722,40 @@ wake-n-pins {
 		};
 	};
 
+	usbprim_sbu_default: usbprim-sbu-state {
+		oe-n-pins {
+			pins = "gpio152";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+			output-high;
+		};
+
+		sel-pins {
+			pins = "gpio100";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+		};
+	};
+
+	usbsec_sbu_default: usbsec-sbu-state {
+		oe-n-pins {
+			pins = "gpio188";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+			output-high;
+		};
+
+		sel-pins {
+			pins = "gpio187";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+		};
+	};
+
 	uart13_state: uart13-state {
 		cts-pins {
 			pins = "gpio43";
-- 
2.25.1

