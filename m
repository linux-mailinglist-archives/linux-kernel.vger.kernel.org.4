Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFADB741126
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjF1MiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:38:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:63262 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231321AbjF1Mgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:36 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SCTrlE025858;
        Wed, 28 Jun 2023 12:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=vKhd0hCzjKWECoQ8ex5R8NLhg6eW+IOM7kKZ7L7MqSE=;
 b=Zs1EZfc8tYL6+zA4HDFM8a8S284LoYDJvhhSmynmVoQAfG4HWIv+KZwfW8hpkt2jsw4e
 B2i6O96FrkdplsKWQFsMJ4fRVkMyinJhg/koZt4xvcoOLwQjLbloWUs6yL/ASZQlpju9
 2lWsOkgaTQ9ILaoBtIr5l98ED2jXjiUa273i+7ZkX9+W1+fTZQH1i0OgfqAbJ8AxGX0I
 t6v+lSgJ065vd2YqiZr/exXhPUo94+6zwMVoZXdPTWY+i3boR/OwQ7xuPasu+GKkwbkA
 c2XUJSKjaEtL4JwtwrCRSnrFpjjJwf+fJlFD+Kzcj6g9qyjO/ecY/OJNsmPD6iiwipMN XQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg9pb1esy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:10 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCa9Mb024209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:09 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:36:03 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v4 08/21] dt-bindings: reserved-memory: Add qcom,ramoops binding
Date:   Wed, 28 Jun 2023 18:04:35 +0530
Message-ID: <1687955688-20809-9-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lMrIh8eaOsYycp--0WBftOdLtQt8YtVb
X-Proofpoint-ORIG-GUID: lMrIh8eaOsYycp--0WBftOdLtQt8YtVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm ramoops minidump logger provide a means of storing
the ramoops data to some dynamically reserved memory instead
of traditionally implemented ramoops where the region should
be statically fixed ram region. Its device tree binding
would be exactly same as ramoops device tree binding and is
going to contain traditional ramoops frontend data and this
content will be collected via Qualcomm minidump infrastructure
provided from the boot firmware.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 .../devicetree/bindings/soc/qcom/qcom,ramoops.yaml | 126 +++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
new file mode 100644
index 000000000000..b1fdcf3f8ad4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,ramoops.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Ramoops minidump logger
+
+description: |
+  Qualcomm ramoops minidump logger provide a means of storing the ramoops
+  data to some dynamically reserved memory instead of traditionally
+  implemented ramoops where the region should be statically fixed ram
+  region. Because of its similarity with ramoops it will also have same
+  set of property what ramoops have it in its schema and is going to
+  contain traditional ramoops frontend data and this region will be
+  collected via Qualcomm minidump infrastructure provided from the
+  boot firmware.
+
+maintainers:
+  - Mukesh Ojha <quic_mojha@quicinc.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,sm8450-ramoops
+      - const: qcom,ramoops
+
+  memory-region:
+    maxItems: 1
+    description: handle to memory reservation for qcom,ramoops region.
+
+  ecc-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: enables ECC support and specifies ECC buffer size in bytes
+    default: 0 # no ECC
+
+  record-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum size in bytes of each kmsg dump
+    default: 0
+
+  console-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size in bytes of log buffer reserved for kernel messages
+    default: 0
+
+  ftrace-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size in bytes of log buffer reserved for function tracing and profiling
+    default: 0
+
+  pmsg-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size in bytes of log buffer reserved for userspace messages
+    default: 0
+
+  mem-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: if present, sets the type of mapping is to be used to map the reserved region.
+    default: 0
+    oneOf:
+      - const: 0
+        description: write-combined
+      - const: 1
+        description: unbuffered
+      - const: 2
+        description: cached
+
+  max-reason:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 2 # log oopses and panics
+    maximum: 0x7fffffff
+    description: |
+      If present, sets maximum type of kmsg dump reasons to store.
+      This can be set to INT_MAX to store all kmsg dumps.
+      See include/linux/kmsg_dump.h KMSG_DUMP_* for other kmsg dump reason values.
+      Setting this to 0 (KMSG_DUMP_UNDEF), means the reason filtering will be
+      controlled by the printk.always_kmsg_dump boot param.
+      If unset, it will be 2 (KMSG_DUMP_OOPS), otherwise 5 (KMSG_DUMP_MAX).
+
+  flags:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description: |
+      If present, pass ramoops behavioral flags
+      (see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
+
+  no-dump-oops:
+    deprecated: true
+    type: boolean
+    description: |
+      Use max_reason instead. If present, and max_reason is not specified,
+      it is equivalent to max_reason = 1 (KMSG_DUMP_PANIC).
+
+  unbuffered:
+    deprecated: true
+    type: boolean
+    description: |
+      Use mem_type instead. If present, and mem_type is not specified,
+      it is equivalent to mem_type = 1 and uses unbuffered mappings to map
+      the reserved region (defaults to buffered mappings mem_type = 0).
+      If both are specified -- "mem_type" overrides "unbuffered".
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - memory-region
+
+anyOf:
+  - required: [record-size]
+  - required: [console-size]
+  - required: [ftrace-size]
+  - required: [pmsg-size]
+
+examples:
+  - |
+
+    qcom_ramoops {
+        compatible = "qcom,sm8450-ramoops", "qcom,ramoops";
+        memory-region = <&qcom_ramoops_region>;
+        console-size = <0x8000>;    /* 32kB */
+        record-size = <0x400>;      /*  1kB */
+        ecc-size = <16>;
+    };
-- 
2.7.4

