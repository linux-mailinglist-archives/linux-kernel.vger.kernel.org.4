Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8816A7F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCBJ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjCBJ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:56:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D2F3B3DF;
        Thu,  2 Mar 2023 01:56:08 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3229YLnl014893;
        Thu, 2 Mar 2023 09:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=wnrgDLPD1lPj9ElR3wqdcZE8/tN+z68YSfzzt48b0MU=;
 b=EeTWpj1Lzp9P2zYBmUPiwW915qFWrBH1KJBq8JYOPH8oaSHEL7yFplIK2c9ObS/vN9fa
 Vof7nlLDviNc8cIu0ttTPkA+3Mp59IqbV8IJRgz4gxWb0wpEsQIYAw2JJKzYAPlpfQDu
 L6T1sRHjWTBaOUf5vb4qzOSns4ncTNtycf+AyoG/SKpXYDdUQl6uTRa7OZE4VlYnDhVd
 yxQi29bUdAzuQARczMySCuEcfMtlNEO8o38Ga+/uM0lDh8a6S/C3F8OjrDoNa3ejIrJg
 lYTv3e+EBiS10TxUvrJwCLDPRlW0b0Y8SuQkMbjHkPdrE0qzPDXc1rZOBUDsunSeVouR Pw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2ar125uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 09:56:06 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3229u5Mr015424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 09:56:05 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 2 Mar 2023 01:56:02 -0800
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Date:   Thu, 2 Mar 2023 15:25:14 +0530
Message-ID: <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1677749625.git.quic_varada@quicinc.com>
References: <cover.1677749625.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k51sylMbX8DiY7HXUasiw-hl5g6GaB3E
X-Proofpoint-ORIG-GUID: k51sylMbX8DiY7HXUasiw-hl5g6GaB3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_04,2023-03-02_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB phy and controller related nodes

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 92 +++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 2bb4053..319b5bd 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -215,6 +215,98 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		ssphy_0: ssphy@7D000 {
+			compatible = "qcom,ipq9574-qmp-usb3-phy";
+			reg = <0x7D000 0x1C4>;
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB0_AUX_CLK>,
+				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
+			clock-names = "aux", "cfg_ahb";
+
+			resets =  <&gcc GCC_USB0_PHY_BCR>,
+				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
+			reset-names = "phy","common";
+			status = "disabled";
+
+			usb0_ssphy: lane@7D200 {
+				reg = <0x0007D200 0x130>,	/* Tx */
+				      <0x0007D400 0x200>,	/* Rx */
+				      <0x0007D800 0x1F8>,	/* PCS  */
+				      <0x0007D600 0x044>;	/* PCS misc */
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB0_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_usb0_pipe_clk_src";
+			};
+		};
+
+		qusb_phy_0: qusb@7B000 {
+			compatible = "qcom,ipq9574-qusb2-phy";
+			reg = <0x07B000 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
+				<&xo_board_clk>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
+			status = "disabled";
+		};
+
+		usb3: usb3@8A00000 {
+			compatible = "qcom,dwc3";
+			reg = <0x8AF8800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_SNOC_USB_CLK>,
+				<&gcc GCC_ANOC_USB_AXI_CLK>,
+				<&gcc GCC_USB0_MASTER_CLK>,
+				<&gcc GCC_USB0_SLEEP_CLK>,
+				<&gcc GCC_USB0_MOCK_UTMI_CLK>;
+
+			clock-names = "sys_noc_axi",
+				"anoc_axi",
+				"master",
+				"sleep",
+				"mock_utmi";
+
+			assigned-clocks = <&gcc GCC_SNOC_USB_CLK>,
+					  <&gcc GCC_ANOC_USB_AXI_CLK>,
+					  <&gcc GCC_USB0_MASTER_CLK>,
+					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+			assigned-clock-rates = <200000000>,
+					       <200000000>,
+					       <200000000>,
+					       <24000000>;
+
+			resets = <&gcc GCC_USB_BCR>;
+			status = "disabled";
+
+			dwc_0: dwc3@8A00000 {
+				compatible = "snps,dwc3";
+				reg = <0x8A00000 0xcd00>;
+				clock-names = "ref";
+				clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&qusb_phy_0>, <&usb0_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+				tx-fifo-resize;
+				snps,dis_ep_cache_eviction;
+				snps,is-utmi-l1-suspend;
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+				snps,quirk-frame-length-adjustment = <0x0A87F0A0>;
+				dr_mode = "host";
+			};
+		};
+
 		pcie0_phy: phy@84000 {
 			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
 			reg = <0x00084000 0x1bc>; /* Serdes PLL */
-- 
2.7.4

