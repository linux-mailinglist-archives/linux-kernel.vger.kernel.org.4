Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F1265ED45
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjAENjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjAENih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:38:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228D0BE23;
        Thu,  5 Jan 2023 05:38:36 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305CrsQ8013298;
        Thu, 5 Jan 2023 13:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UMY1yybq5bWij2q6XE/f0Et/sBi5ZxuUOZoVUtT9o5U=;
 b=RhP1ke4R9PVA1az7G5dcdJXo51oLuWGVAGFiMg4LwKCqbT1a3nir0btBPEMikLMB48oj
 TloZ6wpyfKfCKPcKN91T0QAGWD7qk+OL1rjAqPJb5l/znrU8TlN3pcpSDvNkjSM9eI19
 vTIiC1rDP1cosxGL3b/SeeuzhAd3XPvRAJyDEro4QTBW5Fm71dN2HZEXBfEUocqvPkGS
 FLvnUFwU2DA9Gg3EWwfyh+1ENHy80aLEUbzmKkBC/l1O/xKz3YjhpVqBuuzwVC3nbFQt
 hjnP3S+uiJVaaKSXzsiXCbOiQG8XlzNFuY+EFBI1eBPB4L84NcP+1BaoMt9IqZA4tc1n fw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mwj4hhdmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 13:38:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 305DcV00021943
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 13:38:31 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 5 Jan 2023 05:38:26 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <konrad.dybcio@linaro.org>, <mka@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2 4/8] arm64: dts: qcom: sc7280: audioreach: Update VA/RX/TX macro clock nodes
Date:   Thu, 5 Jan 2023 19:07:51 +0530
Message-ID: <1672925875-2107-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1672925875-2107-1-git-send-email-quic_srivasam@quicinc.com>
References: <1672925875-2107-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2thfnT_bgPgweWfERPv-9V622ceSf7wY
X-Proofpoint-ORIG-GUID: 2thfnT_bgPgweWfERPv-9V622ceSf7wY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050107
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
 .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
index e1fe56c..8c55753 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
@@ -8,6 +8,10 @@
 
 #include <dt-bindings/sound/qcom,q6afe.h>
 
+/delete-node/ &lpass_rx_macro;
+/delete-node/ &lpass_tx_macro;
+/delete-node/ &lpass_va_macro;
+
 /{
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
 	sound: sound {
@@ -107,3 +111,61 @@
 		};
 	};
 };
+
+&soc {
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
+
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
+};
-- 
2.7.4

