Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EAC7129A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244123AbjEZPf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbjEZPfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:35:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034FCA3;
        Fri, 26 May 2023 08:35:51 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QERBDP009491;
        Fri, 26 May 2023 15:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Nk4/6uTIpXlSchRSgwdpdSPSZYEUlwATAp2QYHlTI10=;
 b=OEQygwCnOfeDRs8D/MGIljdRYwcZ3vWQzqZIoF8vGkzeDY4qOEVVsy4c54RE6M33dU4b
 MDTkIRmrh/UcYyAj8cDf/7D3ZF7d+ralBQqXFE+McLKoba3DSL+GxmtfaxAQRb4a49pN
 JTqzQQSjUIsBCTeTN90wn62D30JIfBHUOF6mgUQto01bA74oJfd2fmgkbG4FhpZpL+oA
 r+s/oPgbXInzCEq2sa0f2Z0huann8Yyh0nyWtbs/2Amv4/A7M6W2wrBqO64i6pNx3+6U
 4yVuTpjloNjmrHSslrYflU5VfrpRy5r0lEu23gRmD+KmMoqeco/HCauljaIn96ac2VSL sA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt47eugp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:35:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QFZgr1003379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:35:42 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 08:35:38 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v1 3/3] dt-bindings: arm: Adds CoreSight CSR hardware definitions
Date:   Fri, 26 May 2023 23:35:08 +0800
Message-ID: <20230526153508.6208-4-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
References: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _F45BSa2RxZyMLkuekuQimFzCumjr_nn
X-Proofpoint-ORIG-GUID: _F45BSa2RxZyMLkuekuQimFzCumjr_nn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds new coresight-csr.yaml file describing the bindings required
to define csr in the device trees.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/qcom,coresight-csr.yaml      | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
new file mode 100644
index 000000000000..a79b4f6a8bdf
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,coresight-csr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CoreSight Slave Register - TPDA
+
+description: |
+  CoreSight Slave Register block hosts miscellaneous configuration registers.
+  Those configuration registers can be used to control, various coresight
+  configurations.
+
+maintainers:
+  - Mao Jinlong <quic_jinlmao@quicinc.com>
+  - Hao Zhang <quic_hazha@quicinc.com>
+
+properties:
+  $nodename:
+    pattern: "^csr(@[0-9a-f]+)$"
+  compatible:
+    items:
+      - const: qcom,coresight-csr
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  qcom,set-byte-cntr-support:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If set, indicates that CSR supports to set ETR_IRQ_CTRL register.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  # minimum CSR definition.
+  - |
+    csr@10001000 {
+      compatible = "qcom,coresight-csr";
+      reg = <0 0x10001000 0 0x1000>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+      qcom,set-byte-cntr-support;
+    };
+
+...
-- 
2.17.1

