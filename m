Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68CA66B0CD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjAOLnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjAOLmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:42:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176BA10AA8;
        Sun, 15 Jan 2023 03:42:44 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30FBfXt5003350;
        Sun, 15 Jan 2023 11:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=qPkuLNMWVHRK6gEpWulWA7qnoMAcZ84rwLQjRjM1uyg=;
 b=lqqt5XL8glftliMxOksFT8JwzBlE98x23d4q6vxOPcuha5GxJipRKI49MIp752UlYl+0
 oB8L8DakZpBnh30GZkawtiKvGldGu1Es6YBsSBOAHOHlFCaT8zMZzfnSlJGPDQATqtHa
 ylP93lAyVt9qHOrvPhhIe78yUeAEpUFJoUUPnHuFy9FYHZfi8e5l3Al9UHXLKsSOeAtS
 aUZtOmIDgvHQTdBspzSrWrSSBLTqJpeU/xP27TI4wssnDMgReC0PGEGONHSrFiLVWIBe
 3aFt87XD+a5d2yZYRRuIS96p8QxQYXD/jbFDEFv/gH2gurvZEbk9jCYS3HpBeNMRG2ux xQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3j3nhv3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 11:42:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30FBgVse020083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 11:42:31 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 03:42:25 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC v4 5/5] arm: dts: msm: Add multiport controller node for usb
Date:   Sun, 15 Jan 2023 17:11:46 +0530
Message-ID: <20230115114146.12628-6-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230115114146.12628-1-quic_kriskura@quicinc.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TUbNRbbSkE1QCaJbpvMeV_IpSDiooxC_
X-Proofpoint-ORIG-GUID: TUbNRbbSkE1QCaJbpvMeV_IpSDiooxC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301150089
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB and DWC3 node for teritiary port of SC8280 along
with multiport IRQ's and phy's.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 49 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi   | 60 ++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 84cb6f3eeb56..f9eb854c3444 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -422,6 +422,20 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&usb_2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_en_state>,
+			<&usb3_en_state>,
+			<&usb4_en_state>,
+			<&usb5_en_state>;
+};
+
+&usb_2_dwc3 {
+	dr_mode = "host";
+};
+
 &usb_2_hsphy0 {
 	vdda-pll-supply = <&vreg_l5a>;
 	vdda18-supply = <&vreg_l7g>;
@@ -472,6 +486,41 @@ &xo_board_clk {
 	clock-frequency = <38400000>;
 };
 
+/* PINCTRL */
+&pm8450c_gpios {
+	usb2_en_state: usb2-en-state {
+		pins = "gpio9";
+		function = "normal";
+		output-high;
+		power-source = <0>;
+	};
+};
+
+&pm8450e_gpios {
+	usb3_en_state: usb3-en-state {
+		pins = "gpio5";
+		function = "normal";
+		output-high;
+		power-source = <0>;
+	};
+};
+
+&pm8450g_gpios {
+	usb4_en_state: usb4-en-state {
+		pins = "gpio5";
+		function = "normal";
+		output-high;
+		power-source = <0>;
+	};
+
+	usb5_en_state: usb5-en-state {
+		pins = "gpio9";
+		function = "normal";
+		output-high;
+		power-source = <0>;
+	};
+};
+
 /* PINCTRL */
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 109c9d2b684d..e9866ab5c6e2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1969,6 +1969,66 @@ usb_1_dwc3: usb@a800000 {
 			};
 		};
 
+		usb_2: usb@a4f8800 {
+			compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";
+			reg = <0 0x0a4f8800 0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
+				 <&gcc GCC_USB30_MP_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
+				 <&gcc GCC_USB30_MP_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
+				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi",
+				      "noc_aggr", "noc_aggr_north", "noc_aggr_south", "noc_sys";
+
+			assigned-clocks = <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MP_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
+						<&pdc 126 IRQ_TYPE_EDGE_RISING>,
+						<&pdc 16 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "dp_hs_phy_irq", "dm_hs_phy_irq",
+						"ss_phy_irq";
+
+			power-domains = <&gcc USB30_MP_GDSC>;
+
+			resets = <&gcc GCC_USB30_MP_BCR>;
+
+			interconnects = <&aggre1_noc MASTER_USB3_1 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			required-opps = <&rpmhpd_opp_nom>;
+
+			status = "disabled";
+
+			usb_2_dwc3: usb@a400000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a400000 0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x800 0x0>;
+				num-ports = <4>;
+				num-ss-ports = <2>;
+				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
+					<&usb_2_hsphy1>, <&usb_2_qmpphy1>,
+					<&usb_2_hsphy2>,
+					<&usb_2_hsphy3>;
+				phy-names = "usb2-phy_port0", "usb3-phy_port0",
+						"usb2-phy_port1", "usb3-phy_port1",
+						"usb2-phy_port2",
+						"usb2-phy_port3";
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sc8280xp-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
-- 
2.39.0

