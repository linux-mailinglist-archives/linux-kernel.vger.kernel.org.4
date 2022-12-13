Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDEE64B6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiLMOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbiLMOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:05:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2381FF93;
        Tue, 13 Dec 2022 06:05:15 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD7Qf2x027501;
        Tue, 13 Dec 2022 14:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SUSazjdY0snCJ38Y+g66WIdC+5m6p/yCAGGGOiTzmx0=;
 b=PlkTtBgq5BRg5jDS1mGM9xUn0tiet95fe4SvapIjlQUuAViswNOfC6alIlAeFVvXilHV
 2DvGPDX/3HvXyhR6/uRxEYUku5bHwKDbWakpN6h+tLDV+MyldsYfjG+HSeHnWjcAjX0b
 6P0MGZGLx+BLnwJnLiPidZlga1Hr/N5boDIiYIM+G3HbfZzSh4rXLmlV3IEw05QG+m1t
 samTOFaczW5SEgt4QUjy6PxXEAtwLiTL7nm8fRCntHJ+ChLovQHHEe0h83lg+Ajylv1r
 ZdqFxuiDxs22BxbmgxiVHR7c0NCrhNBO5z1tdyMfofAiJ+LIl+D/Q2MQ5rUgvX+cBRp1 MQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3meh7u9mu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:04:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDE4wGp008550
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:04:58 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 13 Dec 2022 06:04:49 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <konrad.dybcio@somainline.org>,
        <amit.pundir@linaro.org>, <regressions@leemhuis.info>,
        <sumit.semwal@linaro.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <robin.murphy@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: mailbox: Add dt binding for QTI CPUCP mailbox controller
Date:   Tue, 13 Dec 2022 19:34:08 +0530
Message-ID: <20221213140409.772-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221213140409.772-1-quic_sibis@quicinc.com>
References: <20221213140409.772-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CkoTYJzroy1tw3MVgP986wW7uhSkV_nl
X-Proofpoint-ORIG-GUID: CkoTYJzroy1tw3MVgP986wW7uhSkV_nl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=715 impostorscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
controller.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../bindings/mailbox/qcom,cpucp-mbox.yaml          | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
new file mode 100644
index 000000000000..1f7e1204cda0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/qcom,cpucp-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. CPUCP Mailbox Controller
+
+maintainers:
+  - Sibi Sankar <quic_sibis@qti.qualcomm.com>
+
+description:
+  The CPUSS Control Processor (CPUCP) mailbox controller enables communication
+  between AP and CPUCP by acting as a doorbell between them.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,sc7280-cpucp-mbox
+      - const: qcom,cpucp-mbox
+
+  reg:
+    items:
+      - description: CPUCP tx register region
+      - description: CPUCP rx register region
+
+  interrupts:
+    maxItems: 1
+
+  "#mbox-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mailbox@17400000 {
+        compatible = "qcom,sc7280-cpucp-mbox", "qcom,cpucp-mbox";
+        reg = <0x0 0x17c00000 0x0 0x10>, <0x0 0x18590300 0x0 0x700>;
+        interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+        #mbox-cells = <0>;
+    };
-- 
2.7.4

