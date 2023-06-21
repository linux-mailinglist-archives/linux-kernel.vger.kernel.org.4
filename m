Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9ED737A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjFUEik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjFUEi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:38:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A311BE7;
        Tue, 20 Jun 2023 21:38:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L4EcY8029397;
        Wed, 21 Jun 2023 04:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VeBeWqSJ2jfK3LRUzlDHhHPNBuAIxCr8ie58n3VA3nY=;
 b=W9BNNO0PnniYdOwZzvVV11bgalV+TnTpD+xwYR5S9vNWbJRytQzaYOUftBx2wtXS2o8+
 z1HCQaFFOONYNpN7hT/DmoULim4UKyeUdn/AM9eUFuMhg0N8Fyj2DPK88kDJmHNKuhVN
 A66Tp17VmfVTpQAWiAtPD3JEV/Zt5bQazmLKTfcVs5GlCrDQBtZBPy+bFZk1NV8Kzfy+
 LkArJwbuA0t7veLOvau383ZiYL/Gp9poU/PWq25PWeAoe6cx0iqUP55UtOoNyQz75RwH
 EndGhvhvb2L9WMmLClcHayUYL+2ATp7sP/h2MhXz2WRdZOGdhd4lKcZoObGXA25gHe+Y aQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb7sutmja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 04:37:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35L4bcJn008209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 04:37:38 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 20 Jun 2023 21:37:32 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v9 08/10] arm64: dts: qcom: sc8280xp: Add multiport controller node for SC8280
Date:   Wed, 21 Jun 2023 10:06:26 +0530
Message-ID: <20230621043628.21485-9-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230621043628.21485-1-quic_kriskura@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3Ud-K4Hu5AJOqnMKg0gxobp57r3kY7zv
X-Proofpoint-ORIG-GUID: 3Ud-K4Hu5AJOqnMKg0gxobp57r3kY7zv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_03,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306210039
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 77 ++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 8fa9fbfe5d00..0dfa350ea3b3 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3013,6 +3013,83 @@ system-cache-controller@9200000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
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
+					      <&pdc 129 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 128 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 131 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 130 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 133 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 132 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "dp1_hs_phy_irq", "dm1_hs_phy_irq",
+					  "dp2_hs_phy_irq", "dm2_hs_phy_irq",
+					  "dp3_hs_phy_irq", "dm3_hs_phy_irq",
+					  "dp4_hs_phy_irq", "dm4_hs_phy_irq",
+					  "ss1_phy_irq", "ss2_phy_irq",
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
+			interconnects = <&aggre1_noc MASTER_USB3_MP 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_MP 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			wakeup-source;
+
+			status = "disabled";
+
+			usb_2_dwc3: usb@a400000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a400000 0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x800 0x0>;
+				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
+				       <&usb_2_hsphy1>, <&usb_2_qmpphy1>,
+				       <&usb_2_hsphy2>,
+				       <&usb_2_hsphy3>;
+				phy-names = "usb2-port0", "usb3-port0",
+					    "usb2-port1", "usb3-port1",
+					    "usb2-port2",
+					    "usb2-port3";
+			};
+		};
+
 		usb_0: usb@a6f8800 {
 			compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
-- 
2.40.0

