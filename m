Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484EF5EAEBD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiIZRzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiIZRyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:54:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD9CDFA;
        Mon, 26 Sep 2022 10:31:01 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QHUXxU008667;
        Mon, 26 Sep 2022 17:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4mml1tOT7Y67UvnzZjr6Nyf4oPsIuAzSW1FY/DvFo2U=;
 b=WL3jIABIiO9RKtumaxmHeQwMJQQcCXKWUI5+pg9K6Q8i8hszzyK/MAlqYeZv00PTwUVF
 hoeKm5RAEmu8X1txBQZtWRIxCZG2tRA1nQuiXXlC5k05QzGDKkH3OTtENxVwM1VpxNJA
 PYidGBoDiwwp6tRZTZCKR/MJsWFflivv4E4DlFej6Y3bqjj/HTezSTEOSryi2W/Pr/Lj
 ZK9V8xyQcuvonzxXEAn7hnso/GoTEgkm1uboA8tfp9UGaHw7HVPr+1Am4TOCIJ7rnY1N
 TvWdKPf/cb8NK+nfRNBCH3aoQauFPaaTOqbjIk381kj/Eyd7HRCtqVbagxRYqpT55Lq8 Lg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jsq8vmdyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 17:30:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28QHUV1F016819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 17:30:31 GMT
Received: from core-thresher1.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 10:30:31 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GPU binding
Date:   Mon, 26 Sep 2022 10:30:24 -0700
Message-ID: <20220926173025.4747-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926173025.4747-1-quic_bjorande@quicinc.com>
References: <20220926173025.4747-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K6s_8k7S0El45fGRgrXmQgMn9MpaY1RW
X-Proofpoint-ORIG-GUID: K6s_8k7S0El45fGRgrXmQgMn9MpaY1RW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 adultscore=0 mlxscore=0 mlxlogscore=990 spamscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add compatible for the Qualcomm SC8280XP GPU.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- None

 .../devicetree/bindings/clock/qcom,gpucc.yaml |  2 ++
 .../dt-bindings/clock/qcom,gpucc-sc8280xp.h   | 35 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sc8280xp.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index 9ebcb1943b0a..a7d0af1bd9e0 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -17,6 +17,7 @@ description: |
     dt-bindings/clock/qcom,gpucc-sdm845.h
     dt-bindings/clock/qcom,gpucc-sc7180.h
     dt-bindings/clock/qcom,gpucc-sc7280.h
+    dt-bindings/clock/qcom,gpucc-sc8280xp.h
     dt-bindings/clock/qcom,gpucc-sm6350.h
     dt-bindings/clock/qcom,gpucc-sm8150.h
     dt-bindings/clock/qcom,gpucc-sm8250.h
@@ -28,6 +29,7 @@ properties:
       - qcom,sc7180-gpucc
       - qcom,sc7280-gpucc
       - qcom,sc8180x-gpucc
+      - qcom,sc8280xp-gpucc
       - qcom,sm6350-gpucc
       - qcom,sm8150-gpucc
       - qcom,sm8250-gpucc
diff --git a/include/dt-bindings/clock/qcom,gpucc-sc8280xp.h b/include/dt-bindings/clock/qcom,gpucc-sc8280xp.h
new file mode 100644
index 000000000000..bb7da46333b0
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sc8280xp.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SC8280XP_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SC8280XP_H
+
+/* GPU_CC clocks */
+#define GPU_CC_PLL0						0
+#define GPU_CC_PLL1						1
+#define GPU_CC_AHB_CLK						2
+#define GPU_CC_CB_CLK						3
+#define GPU_CC_CRC_AHB_CLK					4
+#define GPU_CC_CX_GMU_CLK					5
+#define GPU_CC_CX_SNOC_DVM_CLK					6
+#define GPU_CC_CXO_AON_CLK					7
+#define GPU_CC_CXO_CLK						8
+#define GPU_CC_FREQ_MEASURE_CLK					9
+#define GPU_CC_GMU_CLK_SRC					10
+#define GPU_CC_GX_GMU_CLK					11
+#define GPU_CC_GX_VSENSE_CLK					12
+#define GPU_CC_HUB_AHB_DIV_CLK_SRC				13
+#define GPU_CC_HUB_AON_CLK					14
+#define GPU_CC_HUB_CLK_SRC					15
+#define GPU_CC_HUB_CX_INT_CLK					16
+#define GPU_CC_HUB_CX_INT_DIV_CLK_SRC				17
+#define GPU_CC_SLEEP_CLK					18
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK				19
+
+/* GPU_CC power domains */
+#define GPU_CC_CX_GDSC				0
+#define GPU_CC_GX_GDSC				1
+
+#endif
-- 
2.17.1

