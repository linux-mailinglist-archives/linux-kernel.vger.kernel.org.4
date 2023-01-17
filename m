Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5075C66E17E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjAQO5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjAQO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:57:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CF63E61C;
        Tue, 17 Jan 2023 06:57:38 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HEeeps013054;
        Tue, 17 Jan 2023 14:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=LpkcXqqeu30kVWj+jTciq4w8QsaLW5f3cjVEzS56N5M=;
 b=bd7ixGAobNOWbmWdy2nxoWgCTdKWZ0nh2QliofxKLixIz59lZpT6gBPUIyfqaqzWIFrT
 rsUWyOSmH7u7l/Uzck7BxQPZWrYUeCPU4jxVzvAWl4c680W1wkaxEuJ1AWsiz3akdpPC
 hIsCam1mJzSv2qzdfVVrW6pgLu4SK97ryvWWvrIeDlCIXrC00CUbwlEcmpYfLGeGFA+s
 R3qaYKVGasUccCusEc/13swOf8honsAdwMD7Jm7ccvEa+qqQqdBrIOiVWEkd5DtHiyk8
 lAmgXwtbrLGFZSPmyyHjU+3ApOE9VjRZq0LPHFKrOQcYK16H22VIddY9gvqvfXLgzfSF aw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3npgdf8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 14:57:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HEvLme025501
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 14:57:21 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 06:57:20 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v17 3/9] dt-bindings: arm: Add CoreSight TPDM hardware
Date:   Tue, 17 Jan 2023 06:57:02 -0800
Message-ID: <20230117145708.16739-4-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
References: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NqvkVdrvSIbRZrzGdqz07wq5FBqwAbhN
X-Proofpoint-ORIG-GUID: NqvkVdrvSIbRZrzGdqz07wq5FBqwAbhN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=6 priorityscore=1501 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170121
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new coresight-tpdm.yaml file describing the bindings required
to define tpdm in the device trees.

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/qcom,coresight-tpdm.yaml     | 93 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
new file mode 100644
index 000000000000..5c08342664ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,coresight-tpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trace, Profiling and Diagnostics Monitor - TPDM
+
+description: |
+  The TPDM or Monitor serves as data collection component for various dataset
+  types specified in the QPMDA spec. It covers Implementation defined ((ImplDef),
+  Basic Counts (BC), Tenure Counts (TC), Continuous Multi-Bit (CMB), and Discrete
+  Single Bit (DSB). It performs data collection in the data producing clock
+  domain and transfers it to the data collection time domain, generally ATB
+  clock domain.
+
+  The primary use case of the TPDM is to collect data from different data
+  sources and send it to a TPDA for packetization, timestamping, and funneling.
+
+maintainers:
+  - Mao Jinlong <quic_jinlmao@quicinc.com>
+  - Tao Zhang <quic_taozha@quicinc.com>
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,coresight-tpdm
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^tpdm(@[0-9a-f]+)$"
+  compatible:
+    items:
+      - const: qcom,coresight-tpdm
+      - const: arm,primecell
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
+  out-ports:
+    description: |
+      Output connections from the TPDM to coresight funnel/TPDA.
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port:
+        description: Output connection from the TPDM to coresight
+            funnel/TPDA.
+        $ref: /schemas/graph.yaml#/properties/port
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
+  # minimum TPDM definition. TPDM connect to coresight TPDA.
+  - |
+    tpdm@684c000 {
+      compatible = "qcom,coresight-tpdm", "arm,primecell";
+      reg = <0x0684c000 0x1000>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+
+      out-ports {
+        port {
+          tpdm_prng_out_tpda_qdss: endpoint {
+            remote-endpoint =
+              <&tpda_qdss_in_tpdm_prng>;
+          };
+        };
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..b11d0540bb9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2124,6 +2124,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
 F:	Documentation/devicetree/bindings/arm/arm,coresight-*.yaml
+F:	Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
 F:	Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
 F:	Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
 F:	Documentation/trace/coresight/*
-- 
2.39.0

