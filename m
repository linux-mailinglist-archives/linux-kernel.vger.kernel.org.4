Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7267388A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjASMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjASM2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:28:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808CD7495E;
        Thu, 19 Jan 2023 04:28:03 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J9UjeB030239;
        Thu, 19 Jan 2023 12:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qqV5HrPtcHyfAGwEJyOdWbbki4XqJCe7+YjrWyhnoBs=;
 b=W2vvdNHmipeUqSUioxs88SAWlKKX8wdOAHv134BPoltl/MsJH8LxKsI4/qGlefyTURSe
 ZfTA1jtvU4pObyhTLx+ta6t6ldI9uVRfqm86y0yzVeG5h+1+drwQXa1l8ZKDYJPqEHhX
 L4IUx14RrjTWd00P/KQDGW/Vsxj+Rzk1cOtMpQgGMs+1qBg+udrF93//VqHxXaFxMN4o
 IoxaAK3arXwXEeKlyeY2tXllY4JT1uitbksTGhmeOc3X+rYxBk8bVFyFsOVJZsOBpMTv
 sWa7sO3+1ra4pTvbWjo9Oxk66NnfM8VjWa5SI6jrUylVQDUmg0O6SKWuWzQjIARQT9ct eg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6xkth8r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:27:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JCRsMC007259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:27:54 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 04:27:48 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <vkoul@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <quic_rjendra@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mka@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v3 4/7] arm64: dts: qcom: sc7280: Update VA/RX/TX macro clock nodes
Date:   Thu, 19 Jan 2023 17:57:04 +0530
Message-ID: <1674131227-26456-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674131227-26456-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674131227-26456-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BxusQYJqDNQ-S4Mj4BwzR9exszHAPVWt
X-Proofpoint-GUID: BxusQYJqDNQ-S4Mj4BwzR9exszHAPVWt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update VA, RX and TX macro and lpass_tlmm clock properties and
enable them.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
index 81e0f3a..674b01a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
@@ -8,8 +8,67 @@
 
 #include <dt-bindings/sound/qcom,q6afe.h>
 
+/delete-node/ &lpass_rx_macro;
+/delete-node/ &lpass_tx_macro;
+/delete-node/ &lpass_va_macro;
+
 /{
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
+	lpass_rx_macro: codec@3200000 {
+		compatible = "qcom,sc7280-lpass-rx-macro";
+		reg = <0 0x03200000 0 0x1000>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lpass_rx_swr_clk>, <&lpass_rx_swr_data>;
+
+		clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&lpass_va_macro>;
+
+		clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+
+		#clock-cells = <0>;
+		#sound-dai-cells = <1>;
+	};
+
+	lpass_tx_macro: codec@3220000 {
+		compatible = "qcom,sc7280-lpass-tx-macro";
+		reg = <0 0x03220000 0 0x1000>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lpass_tx_swr_clk>, <&lpass_tx_swr_data>;
+
+		clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&lpass_va_macro>;
+
+		clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+
+		#clock-cells = <0>;
+		#sound-dai-cells = <1>;
+	};
+
+	lpass_va_macro: codec@3370000 {
+		compatible = "qcom,sc7280-lpass-va-macro";
+		reg = <0 0x03370000 0 0x1000>;
+
+		pinctrl-0 = <&lpass_dmic01_clk>, <&lpass_dmic01_data>;
+		pinctrl-names = "default";
+
+		clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+
+		clock-names = "mclk", "macro", "dcodec";
+
+		#clock-cells = <0>;
+		#sound-dai-cells = <1>;
+	};
+
 	sound: sound {
 		compatible = "google,sc7280-herobrine";
 		model = "SC7280-AUDIOREACH";
-- 
2.7.4

