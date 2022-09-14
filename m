Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC585B813F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiINGDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiINGDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:03:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB75761DB8;
        Tue, 13 Sep 2022 23:03:31 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E5amUI023638;
        Wed, 14 Sep 2022 06:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SUSazjdY0snCJ38Y+g66WIdC+5m6p/yCAGGGOiTzmx0=;
 b=n8JySnVddNhGdnsAHJ5zXtGhhVN6WqMR1iXmjw09SK9aUNb1XVrvdOSqpen5HEbqyvML
 qPKP1D1IL/a+1II5ag/14gIVEnV+a6/D73CMccxqEe5kMJghrhFKg+M5nFcewV7YTBOX
 EdunVKe6YNLo7VztQj3eMyGl0Po5hLBA769tUEMBDBjo2Y2BP+HkAawHkpGVI9p0iqSv
 JSPF27mO3O9I1EdRPl0TWqGZdKwfBnEbIg6GdyNRVGwtajYvD+Ao07UG7Oujs3RInmRl
 y5ceVmMcFqcFr4Z2sj6Jo4Xh5OFPFC4zZGwbi2mjhD/254ii5/vns0eR0jKlsrB/oJya VQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxyvhf7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 06:03:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E63OCB017847
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 06:03:24 GMT
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 23:03:21 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <jassisinghbrar@gmail.com>,
        <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: mailbox: Add dt binding for QTI CPUCP mailbox controller
Date:   Wed, 14 Sep 2022 11:33:05 +0530
Message-ID: <1663135386-26270-2-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663135386-26270-1-git-send-email-quic_sibis@quicinc.com>
References: <1663135386-26270-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iFb3Ek8MK5-ntZ-iJcgS1UH1tVcL2YLS
X-Proofpoint-ORIG-GUID: iFb3Ek8MK5-ntZ-iJcgS1UH1tVcL2YLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_02,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=651 clxscore=1015 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

