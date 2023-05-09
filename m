Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B319C6FCC99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjEIRW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjEIRWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:22:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E26F1BCB;
        Tue,  9 May 2023 10:22:20 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349GgRVI021878;
        Tue, 9 May 2023 17:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=vqc5MmV0rolU3fZrZWKjnQkqH+vLwJMi05NFywRaTKI=;
 b=X5k6wY7hwflBvatndrQlcmHs8jty62kpJWoVALqwbjaVhuKav0vXlFiuhD8S0VjcZtqJ
 FdQaS3mTuWHMU6hQAPuvyuof6TouwcVchmvnFaaNGB3B1GYHykOerODDFMJLv57JFTF5
 5ByxIdG/BFCthRRPOZTvCEvU46tLvXnHUqoW4iTQiKYi+FBVtbQzt1N7ADihxk2Yg60B
 ts1TF7XogYZZ0thO4LPzdcwkl31nHdWplc0+rD9sqiqOjTIg3Yn7k7BcBHYr7jqHMNoH
 ABQ9O8nPoDyacSkTbaB9OCbGiImNMGAscIdTb2r7QX/pRL2HsHS2tlRxJikGNsakRDfS Jg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77hagfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 17:22:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349HMFvp023805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 17:22:15 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 10:22:11 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_skakitap@quicinc.com>, <quic_jkona@quicinc.com>
Subject: [PATCH V4 1/3] dt-bindings: clock: qcom: Add SM8450 video clock controller
Date:   Tue, 9 May 2023 22:51:46 +0530
Message-ID: <20230509172148.7627-2-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230509172148.7627-1-quic_tdas@quicinc.com>
References: <20230509172148.7627-1-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sOeewO26MDtIwZ3y3J0cV1RYQEZM8Zkq
X-Proofpoint-ORIG-GUID: sOeewO26MDtIwZ3y3J0cV1RYQEZM8Zkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the video clock controller on Qualcomm
SM8450 platform.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since V3:
 - None.

Changes since V2:
 - As per Stephen's comments drop clock-names to match how newer
   qcom clk bindings are being done.
 - Change the header file name as qcom,sm8450-videocc.h to match
   latest upstream header files.

Changes since V1:
 - Change the properties order to keep reg after the compatible
   property.

 .../bindings/clock/qcom,sm8450-videocc.yaml   | 77 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sm8450-videocc.h   | 38 +++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm8450-videocc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
new file mode 100644
index 000000000000..58e59065bb2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8450-videocc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Video Clock & Reset Controller on SM8450
+
+maintainers:
+  - Taniya Das <quic_tdas@quicinc.com>
+
+description: |
+  Qualcomm video clock control module provides the clocks, resets and power
+  domains on SM8450.
+
+  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
+
+properties:
+  compatible:
+    const: qcom,sm8450-videocc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Video AHB clock from GCC
+      - description: Board XO source
+
+  power-domains:
+    maxItems: 1
+    description:
+      MMCX power domain.
+
+  required-opps:
+    maxItems: 1
+    description:
+      A phandle to an OPP node describing required MMCX performance point.
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
+required:
+  - compatible
+  - reg
+  - clocks
+  - power-domains
+  - required-opps
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8450.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    videocc: clock-controller@aaf0000 {
+      compatible = "qcom,sm8450-videocc";
+      reg = <0x0aaf0000 0x10000>;
+      clocks = <&gcc GCC_VIDEO_AHB_CLK>,
+               <&rpmhcc RPMH_CXO_CLK>;
+      power-domains = <&rpmhpd SM8450_MMCX>;
+      required-opps = <&rpmhpd_opp_low_svs>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm8450-videocc.h b/include/dt-bindings/clock/qcom,sm8450-videocc.h
new file mode 100644
index 000000000000..9d795adfe4eb
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8450-videocc.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8450_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8450_H
+
+/* VIDEO_CC clocks */
+#define VIDEO_CC_MVS0_CLK					0
+#define VIDEO_CC_MVS0_CLK_SRC					1
+#define VIDEO_CC_MVS0_DIV_CLK_SRC				2
+#define VIDEO_CC_MVS0C_CLK					3
+#define VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC				4
+#define VIDEO_CC_MVS1_CLK					5
+#define VIDEO_CC_MVS1_CLK_SRC					6
+#define VIDEO_CC_MVS1_DIV_CLK_SRC				7
+#define VIDEO_CC_MVS1C_CLK					8
+#define VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC				9
+#define VIDEO_CC_PLL0						10
+#define VIDEO_CC_PLL1						11
+
+/* VIDEO_CC power domains */
+#define VIDEO_CC_MVS0C_GDSC					0
+#define VIDEO_CC_MVS0_GDSC					1
+#define VIDEO_CC_MVS1C_GDSC					2
+#define VIDEO_CC_MVS1_GDSC					3
+
+/* VIDEO_CC resets */
+#define CVP_VIDEO_CC_INTERFACE_BCR				0
+#define CVP_VIDEO_CC_MVS0_BCR					1
+#define CVP_VIDEO_CC_MVS0C_BCR					2
+#define CVP_VIDEO_CC_MVS1_BCR					3
+#define CVP_VIDEO_CC_MVS1C_BCR					4
+#define VIDEO_CC_MVS0C_CLK_ARES					5
+#define VIDEO_CC_MVS1C_CLK_ARES					6
+
+#endif
-- 
2.17.1

