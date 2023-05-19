Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E170A1DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjESVhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjESVhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:37:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DC21B4;
        Fri, 19 May 2023 14:37:50 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JLOZvk030022;
        Fri, 19 May 2023 21:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=NmGCKkhb1cdmD8IMLyJ23a6AEiVUhK8sh5CBlUGWNl4=;
 b=F2yaNsuI9AjkQtbwKs+tKNHIv5VEJLr0+6Wnpc6ir0C78QcY3kduybDzyBU91jAXS8Yh
 BPVD9qvENeuQzm8Hd1gb5XId5F4SIFuxvlWIRcur3NaULmjlKIUHYWMGloIgfayk4UUB
 iIv4KV/lU9t2QUShp8KU40c7g1//tgrgrN5AIp/O5Jb3pdkBwmFZru7PwHz0rc5bTZzs
 +/Y8UI9nz18dbHfholbN6rIgjGqE2U7cyW3UtC4f4BRDYAeulhWa4eqzCMLXrknTSRPw
 aMWcmF3b7LS7aha9lTcI26qx1yE1zCLnyZ9n8XMtdgev69PDk+sAEg+McK3d+OeYBY/H Rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp0gkadmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 21:37:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JLbjPw000522
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 21:37:45 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 14:37:40 -0700
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
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
Subject: [PATCH 1/3] dt-bindings: clock: qcom: Add SM8550 graphics clock controller
Date:   Sat, 20 May 2023 03:06:54 +0530
Message-ID: <20230519213656.26089-2-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519213656.26089-1-quic_jkona@quicinc.com>
References: <20230519213656.26089-1-quic_jkona@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Mxiux-7uBihWCvQ-FEp96kgQfZ6MN7EH
X-Proofpoint-ORIG-GUID: Mxiux-7uBihWCvQ-FEp96kgQfZ6MN7EH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305190187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the graphics clock controller on
Qualcomm SM8550 platform.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 .../bindings/clock/qcom,sm8550-gpucc.yaml     | 67 +++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8550-gpucc.h | 48 +++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-gpucc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-gpucc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-gpucc.yaml
new file mode 100644
index 000000000000..241e1911410f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-gpucc.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8550-gpucc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Graphics Clock & Reset Controller on SM8550
+
+maintainers:
+  - Taniya Das <quic_tdas@quicinc.com>
+  - Jagadeesh Kona <quic_jkona@quicinc.com>
+
+description: |
+  Qualcomm graphics clock control module provides the clocks, resets and power
+  domains on Qualcomm SoCs.
+
+  See also::
+    include/dt-bindings/clock/qcom,sm8550-gpucc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8550-gpucc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 main branch source
+      - description: GPLL0 div branch source
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm8550-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@3d90000 {
+      compatible = "qcom,sm8550-gpucc";
+      reg = <0x03d90000 0xa000>;
+      clocks = <&bi_tcxo_div2>,
+               <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+               <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
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

