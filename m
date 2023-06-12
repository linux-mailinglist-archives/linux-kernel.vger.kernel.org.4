Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF772D440
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbjFLWPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbjFLWPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:15:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D703510CE;
        Mon, 12 Jun 2023 15:15:06 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CLjuDH000406;
        Mon, 12 Jun 2023 22:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=MMS1rsNZP/EUanvoEfjtx82k7OtBqZ0B4ITqiaCOBp8=;
 b=XoRExxUkHEQnyRc7lngVdlKtKBuoX5dISPaPZgJ2/eYVcQ2BwMvXj15/P1oQS3OARN6V
 L2yuwcttHxIBbhwLHkJKyw2q+1I/vxUllyj8oJVROhv+83kzGEChjFLq75R8lUvBOKPs
 sK51+U4kKJr9aLPj2vYGJ84BqGhA8g3X8L4CPNqC3goeBBeHbDaDb5OTb/EQLsOzZyR+
 7NG45j6BE2nl7TMCA/up8lFbBWn9IchD7SSQ3hij2Qnu+G1nMgHppjZyw5aTElPcSU8V
 F8QYjel1W4YA8eztAInoSU1AhAlK7kLvc6G88nAaHDXjRfm0XUjUhH0jM7y26/AJA/eI pQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r60jysf5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:15:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CMF2Eu023293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:15:02 GMT
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
Subject: [PATCH 2/3] arm64: dts: qcom: sc8180x-primus: Wire up USB Type-C
Date:   Mon, 12 Jun 2023 15:14:55 -0700
Message-ID: <20230612221456.1887533-3-quic_bjorande@quicinc.com>
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
X-Proofpoint-GUID: Qi_SgoxApLY-9nVdRE-XrSspLHKXLbZ7
X-Proofpoint-ORIG-GUID: Qi_SgoxApLY-9nVdRE-XrSspLHKXLbZ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120191
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up pmic_glink and the various components of USB Type-C to get
battery status, orientation switching of SuperSpeed USB, as well as
support for external display on the SC8180X Primus reference device.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts | 196 ++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index fc038474cb71..1716fe788f74 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -50,6 +50,84 @@ lid-switch {
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
@@ -143,6 +221,44 @@ vreg_s4a_1p8: pm8150-s4 {
 
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
@@ -363,6 +479,24 @@ &mdss {
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
 
@@ -496,6 +630,8 @@ &usb_prim_qmpphy {
 	vdda-phy-supply = <&vreg_l3c_1p2>;
 	vdda-pll-supply = <&vreg_l5e_0p88>;
 
+	orientation-switch;
+
 	status = "okay";
 };
 
@@ -507,6 +643,18 @@ &usb_prim_dwc3 {
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
@@ -519,9 +667,23 @@ &usb_sec_qmpphy {
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
@@ -635,6 +797,40 @@ wake-n-pins {
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
 	tp_int_active_state: tp-int-active-state {
 		tp-int-pins {
 			pins = "gpio24";
-- 
2.25.1

