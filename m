Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698FB6F5C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjECRGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjECRGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:06:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1D62690;
        Wed,  3 May 2023 10:05:39 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343FkTLw022611;
        Wed, 3 May 2023 17:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7l6EDYrPTQe3WhAZRwY4kqyZv1s5vyuzSkVpyZrbOU0=;
 b=O3GNuDQ84mTIiqU6IytVvQWmJDHoDyXEi91Z1fZu6LJVDdToOElIbKEip1k/IVPe3m8E
 dK9mQBNUnEPDBAGxJ76owLBtq0JfHgoyrW3/AY4MFU2Lu8MUK1a5mOoaKcPY32IHDrWo
 rJSp0eDTHcV1REEoJqcO9aEr6gIhLTKoanR5ITYh2B31wfdT7HI1ysBXrO5YnezaDI0o
 P/Dv1/eCHCn2g4Bjb3SJDjPOmHMn/VOOXAmVuj0n1NTAGTiEzBz09bY4sQP4PqO+LuaL
 B+I/8dDGx6s+9EW5aDDgdW8tiAPkAdfuo7ERuY5WRIGN8L5B8ViI33FDwNdfbtNnQMeP Nw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbruvrg2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:04:10 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343H3qj6003817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 17:03:52 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 10:03:46 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v3 10/18] dt-bindings: reserved-memory: Add qcom,ramoops-minidump binding
Date:   Wed, 3 May 2023 22:32:24 +0530
Message-ID: <1683133352-10046-11-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kqFYsdQB7Sa79CFON0MZqZxU1GuulYhW
X-Proofpoint-ORIG-GUID: kqFYsdQB7Sa79CFON0MZqZxU1GuulYhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_12,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm ramoops minidump logger provide a means of storing the ramoops data
to some dynamically reserved memory instead of traditionally implemented
ramoops where the region should be statically fixed ram region.

Add qcom,ramoops-minidump binding under "/reserved-memory", and is named
"qcom,ramoops-minidump" and the reason of naming like this is because
as it is going to contain ramoops frontend data and this content will
be collected via Qualcomm minidump infrastructure provided from the
boot firmware.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 .../reserved-memory/qcom,ramoops-minidump.yaml     | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,ramoops-minidump.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,ramoops-minidump.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,ramoops-minidump.yaml
new file mode 100644
index 0000000..a308db0
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,ramoops-minidump.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reserved-memory/qcom,ramoops-minidump.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Ramoops minidump logger
+
+description: |
+  Qualcomm ramoops minidump logger provide a means of storing the ramoops data
+  to some dynamically reserved memory instead of traditionally implemented
+  ramoops where the region should be statically fixed ram region.
+
+  This is a child-node of "/reserved-memory", and is named "qcom_ramoops_md_region"
+  and the reason of naming like this is because as it is going to contain ramoops
+  frontend data and this content will be collected via Qualcomm minidump
+  infrastructure provided from the boot firmware.
+
+maintainers:
+  - Mukesh Ojha <quic_mojha@quicinc.com>
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,sm8450-ramoops-minidump
+      - const: qcom,ramoops-minidump
+
+  memory-region:
+    maxItems: 1
+    items:
+      - description: handle to memory reservation for qcom,ramoops-minidump region.
+
+  no-map: true
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - memory-region
+
+examples:
+  - |
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        reserved-memory {
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+
+            qcom_ramoops_md_region@qcom_ramoops_md {
+                alloc-ranges = <0x0 0x00000000 0xffffffff 0xffffffff>;
+                size = <0x0 0x200000>;
+                no-map
+            };
+        };
+
+	qcom_ramoops_md {
+            compatible = "qcom,sm8450-ramoops-minidump", "qcom,ramoops-minidump";
+            memory-region = <&qcom_ramoops_md_region>;
+        };
+    };
-- 
2.7.4

