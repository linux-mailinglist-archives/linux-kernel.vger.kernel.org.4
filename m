Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7CC71A059
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjFAOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjFAOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:35:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F76E47;
        Thu,  1 Jun 2023 07:35:19 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351Cc2uA016304;
        Thu, 1 Jun 2023 14:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=xQUJpPts7jZprKfhK07cobMdrCQZKNrrkg5iwAckLj8=;
 b=KsTXc53gch7f7SWb5FLKayQVdUaKYhmtR1jUVWNNT2rKRY+H91nUx97YDnh2OJl+Qdpf
 XA3U+RMf9Sd0VYE38fVNNUxWTSVhmqZ0h1hr9IsaATofWipHaeQnNzTcsSfJqdeIWPDd
 +1GKqYfN1/v+oKjFtgJkc4q0xPoz6GK9zQ6OgBqfp7+pFg+Fj78kiUYcZrQoIgoknu6w
 OLy4clDmN+WiyPIUyYRTyiUkLuqfkOyxF+0d7V8XO9c8G9oCxIaTGzHwgyQ/9bPJqQi4
 PIhBP9YG22f66HzFKEUAV7Z6SJhjdGStSDLleSluqu6fQnjUumbEDM/+TAOR4YQ2zWqe TA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugr89q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 14:35:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351EZE09011114
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 14:35:14 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 07:35:08 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/5] dt-bindings: clock: qcom: Add SM8550 camera clock controller
Date:   Thu, 1 Jun 2023 20:04:26 +0530
Message-ID: <20230601143430.5595-2-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601143430.5595-1-quic_jkona@quicinc.com>
References: <20230601143430.5595-1-quic_jkona@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m01xu3o5pGCa7FognufNZ3M-jcwtyzAi
X-Proofpoint-ORIG-GUID: m01xu3o5pGCa7FognufNZ3M-jcwtyzAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010129
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the camera clock controller on
Qualcomm SM8550 platform.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since V2:
 - No changes
Changes since V1:
 - Removed new YAML file and reused SM8450 CAMCC YAML file for SM8550

 .../bindings/clock/qcom,sm8450-camcc.yaml     |   8 +-
 include/dt-bindings/clock/qcom,sm8550-camcc.h | 187 ++++++++++++++++++
 2 files changed, 193 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index 87ae74166807..8dbc9004202f 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -13,11 +13,15 @@ description: |
   Qualcomm camera clock control module provides the clocks, resets and power
   domains on SM8450.
 
-  See also:: include/dt-bindings/clock/qcom,sm8450-camcc.h
+  See also::
+    include/dt-bindings/clock/qcom,sm8450-camcc.h
+    include/dt-bindings/clock/qcom,sm8550-camcc.h
 
 properties:
   compatible:
-    const: qcom,sm8450-camcc
+    enum:
+      - qcom,sm8450-camcc
+      - qcom,sm8550-camcc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,sm8550-camcc.h b/include/dt-bindings/clock/qcom,sm8550-camcc.h
new file mode 100644
index 000000000000..a2a256691c2b
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8550-camcc.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAM_CC_SM8550_H
+#define _DT_BINDINGS_CLK_QCOM_CAM_CC_SM8550_H
+
+/* CAM_CC clocks */
+#define CAM_CC_BPS_AHB_CLK					0
+#define CAM_CC_BPS_CLK						1
+#define CAM_CC_BPS_CLK_SRC					2
+#define CAM_CC_BPS_FAST_AHB_CLK					3
+#define CAM_CC_CAMNOC_AXI_CLK					4
+#define CAM_CC_CAMNOC_AXI_CLK_SRC				5
+#define CAM_CC_CAMNOC_DCD_XO_CLK				6
+#define CAM_CC_CAMNOC_XO_CLK					7
+#define CAM_CC_CCI_0_CLK					8
+#define CAM_CC_CCI_0_CLK_SRC					9
+#define CAM_CC_CCI_1_CLK					10
+#define CAM_CC_CCI_1_CLK_SRC					11
+#define CAM_CC_CCI_2_CLK					12
+#define CAM_CC_CCI_2_CLK_SRC					13
+#define CAM_CC_CORE_AHB_CLK					14
+#define CAM_CC_CPAS_AHB_CLK					15
+#define CAM_CC_CPAS_BPS_CLK					16
+#define CAM_CC_CPAS_CRE_CLK					17
+#define CAM_CC_CPAS_FAST_AHB_CLK				18
+#define CAM_CC_CPAS_IFE_0_CLK					19
+#define CAM_CC_CPAS_IFE_1_CLK					20
+#define CAM_CC_CPAS_IFE_2_CLK					21
+#define CAM_CC_CPAS_IFE_LITE_CLK				22
+#define CAM_CC_CPAS_IPE_NPS_CLK					23
+#define CAM_CC_CPAS_SBI_CLK					24
+#define CAM_CC_CPAS_SFE_0_CLK					25
+#define CAM_CC_CPAS_SFE_1_CLK					26
+#define CAM_CC_CPHY_RX_CLK_SRC					27
+#define CAM_CC_CRE_AHB_CLK					28
+#define CAM_CC_CRE_CLK						29
+#define CAM_CC_CRE_CLK_SRC					30
+#define CAM_CC_CSI0PHYTIMER_CLK					31
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC				32
+#define CAM_CC_CSI1PHYTIMER_CLK					33
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC				34
+#define CAM_CC_CSI2PHYTIMER_CLK					35
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC				36
+#define CAM_CC_CSI3PHYTIMER_CLK					37
+#define CAM_CC_CSI3PHYTIMER_CLK_SRC				38
+#define CAM_CC_CSI4PHYTIMER_CLK					39
+#define CAM_CC_CSI4PHYTIMER_CLK_SRC				40
+#define CAM_CC_CSI5PHYTIMER_CLK					41
+#define CAM_CC_CSI5PHYTIMER_CLK_SRC				42
+#define CAM_CC_CSI6PHYTIMER_CLK					43
+#define CAM_CC_CSI6PHYTIMER_CLK_SRC				44
+#define CAM_CC_CSI7PHYTIMER_CLK					45
+#define CAM_CC_CSI7PHYTIMER_CLK_SRC				46
+#define CAM_CC_CSID_CLK						47
+#define CAM_CC_CSID_CLK_SRC					48
+#define CAM_CC_CSID_CSIPHY_RX_CLK				49
+#define CAM_CC_CSIPHY0_CLK					50
+#define CAM_CC_CSIPHY1_CLK					51
+#define CAM_CC_CSIPHY2_CLK					52
+#define CAM_CC_CSIPHY3_CLK					53
+#define CAM_CC_CSIPHY4_CLK					54
+#define CAM_CC_CSIPHY5_CLK					55
+#define CAM_CC_CSIPHY6_CLK					56
+#define CAM_CC_CSIPHY7_CLK					57
+#define CAM_CC_DRV_AHB_CLK					58
+#define CAM_CC_DRV_XO_CLK					59
+#define CAM_CC_FAST_AHB_CLK_SRC					60
+#define CAM_CC_GDSC_CLK						61
+#define CAM_CC_ICP_AHB_CLK					62
+#define CAM_CC_ICP_CLK						63
+#define CAM_CC_ICP_CLK_SRC					64
+#define CAM_CC_IFE_0_CLK					65
+#define CAM_CC_IFE_0_CLK_SRC					66
+#define CAM_CC_IFE_0_DSP_CLK					67
+#define CAM_CC_IFE_0_DSP_CLK_SRC				68
+#define CAM_CC_IFE_0_FAST_AHB_CLK				69
+#define CAM_CC_IFE_1_CLK					70
+#define CAM_CC_IFE_1_CLK_SRC					71
+#define CAM_CC_IFE_1_DSP_CLK					72
+#define CAM_CC_IFE_1_DSP_CLK_SRC				73
+#define CAM_CC_IFE_1_FAST_AHB_CLK				74
+#define CAM_CC_IFE_2_CLK					75
+#define CAM_CC_IFE_2_CLK_SRC					76
+#define CAM_CC_IFE_2_DSP_CLK					77
+#define CAM_CC_IFE_2_DSP_CLK_SRC				78
+#define CAM_CC_IFE_2_FAST_AHB_CLK				79
+#define CAM_CC_IFE_LITE_AHB_CLK					80
+#define CAM_CC_IFE_LITE_CLK					81
+#define CAM_CC_IFE_LITE_CLK_SRC					82
+#define CAM_CC_IFE_LITE_CPHY_RX_CLK				83
+#define CAM_CC_IFE_LITE_CSID_CLK				84
+#define CAM_CC_IFE_LITE_CSID_CLK_SRC				85
+#define CAM_CC_IPE_NPS_AHB_CLK					86
+#define CAM_CC_IPE_NPS_CLK					87
+#define CAM_CC_IPE_NPS_CLK_SRC					88
+#define CAM_CC_IPE_NPS_FAST_AHB_CLK				89
+#define CAM_CC_IPE_PPS_CLK					90
+#define CAM_CC_IPE_PPS_FAST_AHB_CLK				91
+#define CAM_CC_JPEG_1_CLK					92
+#define CAM_CC_JPEG_CLK						93
+#define CAM_CC_JPEG_CLK_SRC					94
+#define CAM_CC_MCLK0_CLK					95
+#define CAM_CC_MCLK0_CLK_SRC					96
+#define CAM_CC_MCLK1_CLK					97
+#define CAM_CC_MCLK1_CLK_SRC					98
+#define CAM_CC_MCLK2_CLK					99
+#define CAM_CC_MCLK2_CLK_SRC					100
+#define CAM_CC_MCLK3_CLK					101
+#define CAM_CC_MCLK3_CLK_SRC					102
+#define CAM_CC_MCLK4_CLK					103
+#define CAM_CC_MCLK4_CLK_SRC					104
+#define CAM_CC_MCLK5_CLK					105
+#define CAM_CC_MCLK5_CLK_SRC					106
+#define CAM_CC_MCLK6_CLK					107
+#define CAM_CC_MCLK6_CLK_SRC					108
+#define CAM_CC_MCLK7_CLK					109
+#define CAM_CC_MCLK7_CLK_SRC					110
+#define CAM_CC_PLL0						111
+#define CAM_CC_PLL0_OUT_EVEN					112
+#define CAM_CC_PLL0_OUT_ODD					113
+#define CAM_CC_PLL1						114
+#define CAM_CC_PLL1_OUT_EVEN					115
+#define CAM_CC_PLL2						116
+#define CAM_CC_PLL3						117
+#define CAM_CC_PLL3_OUT_EVEN					118
+#define CAM_CC_PLL4						119
+#define CAM_CC_PLL4_OUT_EVEN					120
+#define CAM_CC_PLL5						121
+#define CAM_CC_PLL5_OUT_EVEN					122
+#define CAM_CC_PLL6						123
+#define CAM_CC_PLL6_OUT_EVEN					124
+#define CAM_CC_PLL7						125
+#define CAM_CC_PLL7_OUT_EVEN					126
+#define CAM_CC_PLL8						127
+#define CAM_CC_PLL8_OUT_EVEN					128
+#define CAM_CC_PLL9						129
+#define CAM_CC_PLL9_OUT_EVEN					130
+#define CAM_CC_PLL10						131
+#define CAM_CC_PLL10_OUT_EVEN					132
+#define CAM_CC_PLL11						133
+#define CAM_CC_PLL11_OUT_EVEN					134
+#define CAM_CC_PLL12						135
+#define CAM_CC_PLL12_OUT_EVEN					136
+#define CAM_CC_QDSS_DEBUG_CLK					137
+#define CAM_CC_QDSS_DEBUG_CLK_SRC				138
+#define CAM_CC_QDSS_DEBUG_XO_CLK				139
+#define CAM_CC_SBI_CLK						140
+#define CAM_CC_SBI_FAST_AHB_CLK					141
+#define CAM_CC_SFE_0_CLK					142
+#define CAM_CC_SFE_0_CLK_SRC					143
+#define CAM_CC_SFE_0_FAST_AHB_CLK				144
+#define CAM_CC_SFE_1_CLK					145
+#define CAM_CC_SFE_1_CLK_SRC					146
+#define CAM_CC_SFE_1_FAST_AHB_CLK				147
+#define CAM_CC_SLEEP_CLK					148
+#define CAM_CC_SLEEP_CLK_SRC					149
+#define CAM_CC_SLOW_AHB_CLK_SRC					150
+#define CAM_CC_XO_CLK_SRC					151
+
+/* CAM_CC power domains */
+#define CAM_CC_BPS_GDSC						0
+#define CAM_CC_IFE_0_GDSC					1
+#define CAM_CC_IFE_1_GDSC					2
+#define CAM_CC_IFE_2_GDSC					3
+#define CAM_CC_IPE_0_GDSC					4
+#define CAM_CC_SBI_GDSC						5
+#define CAM_CC_SFE_0_GDSC					6
+#define CAM_CC_SFE_1_GDSC					7
+#define CAM_CC_TITAN_TOP_GDSC					8
+
+/* CAM_CC resets */
+#define CAM_CC_BPS_BCR						0
+#define CAM_CC_DRV_BCR						1
+#define CAM_CC_ICP_BCR						2
+#define CAM_CC_IFE_0_BCR					3
+#define CAM_CC_IFE_1_BCR					4
+#define CAM_CC_IFE_2_BCR					5
+#define CAM_CC_IPE_0_BCR					6
+#define CAM_CC_QDSS_DEBUG_BCR					7
+#define CAM_CC_SBI_BCR						8
+#define CAM_CC_SFE_0_BCR					9
+#define CAM_CC_SFE_1_BCR					10
+
+#endif
-- 
2.40.1

