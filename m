Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E6470FDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbjEXSTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjEXSSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:18:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FABD3;
        Wed, 24 May 2023 11:18:42 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OGmTQ7020330;
        Wed, 24 May 2023 18:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=tqtj9i3NWuoP0ZhTrK231s7H/H531Ij05MBeACceohc=;
 b=VsNLN2ijj12sca1pqnR5NVP9BRmJBP166pgZ93v+mkxjiC7C8HJpPdZGzwuwf4Me8IW7
 cvxMhSNa96pSM55GQmmOjpq22G+DKcajGnqjb/LrjemgpDAyNz9wsFa6ng6h59o1nNwt
 fA9piu9Aa+4czsp6hQH4YfxY57HXKCtqwrWiMSjliD8zot9CSE1/JnVQYBSHk0wpN5/M
 MSEB5bEjk069Tx4+rE41drmEh2NPGoDAq8H4uQKMnK6ev8JNH7U+3N21+FCUGlTkxKKj
 Arcjpsn0EhQHyHdUJ+t8Kq0LBlU10+JNbHIZdEYNcpwPpzF8GVMh9BQzHRtCASWISVhL 2A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsf881d0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 18:18:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34OIIcDQ017324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 18:18:38 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 24 May 2023 11:18:33 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>
Subject: [PATCH V2 1/3] dt-bindings: clock: qcom: Add SM8550 graphics clock controller
Date:   Wed, 24 May 2023 23:47:58 +0530
Message-ID: <20230524181800.28717-2-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524181800.28717-1-quic_jkona@quicinc.com>
References: <20230524181800.28717-1-quic_jkona@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oRvcDwK-3JPH6RPc4BUoBvgiKVsL2XgL
X-Proofpoint-GUID: oRvcDwK-3JPH6RPc4BUoBvgiKVsL2XgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_13,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240151
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the graphics clock controller on
Qualcomm SM8550 platform.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
Changes since V1:
 - Removed new YAML file and reused SM8450 GPUCC YAML file for SM8550

 .../bindings/clock/qcom,sm8450-gpucc.yaml     |  2 +
 include/dt-bindings/clock/qcom,sm8550-gpucc.h | 48 +++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-gpucc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
index ad913b2daf0c..2320be920a5f 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
@@ -15,12 +15,14 @@ description: |
 
   See also::
     include/dt-bindings/clock/qcom,sm8450-gpucc.h
+    include/dt-bindings/clock/qcom,sm8550-gpucc.h
     include/dt-bindings/reset/qcom,sm8450-gpucc.h
 
 properties:
   compatible:
     enum:
       - qcom,sm8450-gpucc
+      - qcom,sm8550-gpucc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,sm8550-gpucc.h b/include/dt-bindings/clock/qcom,sm8550-gpucc.h
new file mode 100644
index 000000000000..a6760547a3ab
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8550-gpucc.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8550_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8550_H
+
+/* GPU_CC clocks */
+#define GPU_CC_AHB_CLK						0
+#define GPU_CC_CRC_AHB_CLK					1
+#define GPU_CC_CX_FF_CLK					2
+#define GPU_CC_CX_GMU_CLK					3
+#define GPU_CC_CXO_AON_CLK					4
+#define GPU_CC_CXO_CLK						5
+#define GPU_CC_DEMET_CLK					6
+#define GPU_CC_DEMET_DIV_CLK_SRC				7
+#define GPU_CC_FF_CLK_SRC					8
+#define GPU_CC_FREQ_MEASURE_CLK					9
+#define GPU_CC_GMU_CLK_SRC					10
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK				11
+#define GPU_CC_HUB_AON_CLK					12
+#define GPU_CC_HUB_CLK_SRC					13
+#define GPU_CC_HUB_CX_INT_CLK					14
+#define GPU_CC_MEMNOC_GFX_CLK					15
+#define GPU_CC_MND1X_0_GFX3D_CLK				16
+#define GPU_CC_MND1X_1_GFX3D_CLK				17
+#define GPU_CC_PLL0						18
+#define GPU_CC_PLL1						19
+#define GPU_CC_SLEEP_CLK					20
+#define GPU_CC_XO_CLK_SRC					21
+#define GPU_CC_XO_DIV_CLK_SRC					22
+
+/* GPU_CC power domains */
+#define GPU_CC_CX_GDSC						0
+#define GPU_CC_GX_GDSC						1
+
+/* GPU_CC resets */
+#define GPUCC_GPU_CC_ACD_BCR					0
+#define GPUCC_GPU_CC_CX_BCR					1
+#define GPUCC_GPU_CC_FAST_HUB_BCR				2
+#define GPUCC_GPU_CC_FF_BCR					3
+#define GPUCC_GPU_CC_GFX3D_AON_BCR				4
+#define GPUCC_GPU_CC_GMU_BCR					5
+#define GPUCC_GPU_CC_GX_BCR					6
+#define GPUCC_GPU_CC_XO_BCR					7
+
+#endif
-- 
2.40.1

