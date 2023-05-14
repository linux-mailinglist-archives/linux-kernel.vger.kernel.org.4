Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC23E701BC9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 07:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjENFvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 01:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjENFuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 01:50:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F7273E;
        Sat, 13 May 2023 22:50:27 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34E5oHPi021442;
        Sun, 14 May 2023 05:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=wJ9Vc6ehQfoDKHhoTHMU2B3s0lYNjvU/4yKdkQIX1As=;
 b=VVH1GOatNvi1EVBv0FSqmcag7q7JZ+Ibe4arrEYcYsrnIU3mMhW5uRYKo6O83MzIATcw
 UaZZ223qXQWWew2h4QBxBqi1SJbYSJyvSI5A8kte9jRtjG6lFy0c/G3xsdByEpDxQ0zC
 gVTFT9y0B/sqPdN/Vt7uD1w54D01wbQ1NXJOBMJfg9WXh8OddXCuH+uGder5ggZUVti/
 kRhUf4FmGS9eJn8tjSPh2mMONKd7mWHGBEkHAfATnYhCDboJ3IoAe8Yibx1FVwfyVqao
 mVal2FHGYrMn/+gDrGmNgz8Go3sfZ2tUjHy7bpT4yF0WK1kAFbxQix+FMqh3eG6Kw0I6 jQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj3qw1bme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 05:50:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34E5oG67021303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 05:50:16 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sat, 13 May 2023 22:50:10 -0700
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
        <quic_harshq@quicinc.com>, <ahalaney@redhat.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v8 7/9] arm64: dts: qcom: sc8280xp: Add multiport controller node for SC8280
Date:   Sun, 14 May 2023 11:19:15 +0530
Message-ID: <20230514054917.21318-8-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230514054917.21318-1-quic_kriskura@quicinc.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7dvMPE7PCbSOnTM_N6hG_EOyfBsgC3Ub
X-Proofpoint-GUID: 7dvMPE7PCbSOnTM_N6hG_EOyfBsgC3Ub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305140052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB and DWC3 node for tertiary port of SC8280 along with multiport
IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
platforms.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 8fa9fbfe5d00..50f6a8424537 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3133,6 +3133,72 @@ usb_1_role_switch: endpoint {
 			};
 		};
 
+		usb_2: usb@a4f8800 {
+			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";
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
+					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "dp_hs_phy_irq",
+					  "dm_hs_phy_irq",
+					  "ss_phy_irq",
+					  "pwr_event_1",
+					  "pwr_event_2",
+					  "pwr_event_3",
+					  "pwr_event_4";
+
+			power-domains = <&gcc USB30_MP_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&gcc GCC_USB30_MP_BCR>;
+
+			interconnects = <&aggre1_noc MASTER_USB3_1 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			status = "disabled";
+
+			usb_2_dwc3: usb@a400000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a400000 0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x800 0x0>;
+				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
+					<&usb_2_hsphy1>, <&usb_2_qmpphy1>,
+					<&usb_2_hsphy2>,
+					<&usb_2_hsphy3>;
+				phy-names = "usb2-port0", "usb3-port0",
+						"usb2-port1", "usb3-port1",
+						"usb2-port2",
+						"usb2-port3";
+			};
+		};
+
 		mdss0: display-subsystem@ae00000 {
 			compatible = "qcom,sc8280xp-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;
-- 
2.40.0

