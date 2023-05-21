Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A7370B17E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjEUW3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjEUW3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:29:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE8DE3;
        Sun, 21 May 2023 15:29:29 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMPLji009157;
        Sun, 21 May 2023 22:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=LtCWgoSeg2IVr0yifkpkcLi30+ylQs9PMCOVzVX4M0s=;
 b=JvmL+6PkvVuHiuCA/RLWuR5iQXx+h1oImARg5AmCmjNUzDknwi08v6cBZBhBOkTX+Lz2
 dtF01wLz2e/tfisb03nFJWPJrEi7r3u9/jlrkgUgymir0i1sNzQlgig7XUSQOQEBtwM4
 oOl4wIRpuJjgpGcR6L04WH9QsJoKqkCSv4BB1ApnkDGSilS8kPcptzH6Jp3zQO7ERffY
 rt3/lQarUhUQMRrwC7/Mb1kzaiju2tt7NE32xVj6HpG+1As3fT9Q4lO0ItvaA8d2oHde
 ae/y/QGZpp1xYlJW6TDZr7WqDPo9K2kC/9/6I64ZVnEbYxKIkYdak7ORch29/YfV45PZ Uw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppkdj8cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:29:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LMTNTH025424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:29:23 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 21 May 2023 15:29:16 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <quic_mmanikan@quicinc.com>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for multipd model
Date:   Mon, 22 May 2023 03:58:40 +0530
Message-ID: <20230521222852.5740-2-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KeF7L1x08_YwqFNNVY_42006eraE6GaI
X-Proofpoint-GUID: KeF7L1x08_YwqFNNVY_42006eraE6GaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_17,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new binding document for multipd model remoteproc.
IPQ5018, IPQ9574 follows multipd model.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V2:
	- Fixed all comments and rebased for TOT.
	- Changed to BSD-3-Clause based on internal open source team
          suggestion.
	- Added firmware-name.

 .../bindings/remoteproc/qcom,multipd-pil.yaml | 265 ++++++++++++++++++
 1 file changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
new file mode 100644
index 000000000000..3257f27dc569
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
@@ -0,0 +1,265 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,multipd-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Multipd Secure Peripheral Image Loader
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+
+description:
+  Multipd Peripheral Image Loader loads firmware and boots Q6 pd, WCSS pd
+  remoteproc's on the Qualcomm IPQ5018, IPQ9574 SoC. Pd means protection
+  domain. It's similar to process in Linux. Here QDSP6 processor runs each
+  wifi radio functionality on a separate process. One process can't access
+  other process resources, so this is termed as PD i.e protection domain.
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq5018-q6-mpd
+      - qcom,ipq9574-q6-mpd
+
+  reg:
+    maxItems: 1
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Firmware name of the Hexagon core
+
+  interrupts-extended:
+    items:
+      - description: Watchdog interrupt
+      - description: Fatal interrupt
+      - description: Ready interrupt
+      - description: Handover interrupt
+      - description: Stop acknowledge interrupt
+
+  interrupt-names:
+    items:
+      - const: wdog
+      - const: fatal
+      - const: ready
+      - const: handover
+      - const: stop-ack
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: States used by the AP to signal the remote processor
+    items:
+      - description: Shutdown Q6
+      - description: Stop Q6
+
+  qcom,smem-state-names:
+    description:
+      Names of the states used by the AP to signal the remote processor
+    items:
+      - const: shutdown
+      - const: stop
+
+  memory-region:
+    items:
+      - description: Q6 pd reserved region
+
+  glink-edge:
+    $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
+    description:
+      Qualcomm G-Link subnode which represents communication edge, channels
+      and devices related to the Modem.
+
+patternProperties:
+  "^pd-1|pd-2|pd-3":
+    type: object
+    description:
+      In Multipd model, WCSS pd depends on Q6 pd i.e Q6 pd should be up before
+      WCSS. It can be achieved by keeping wcss pd node as subnode of Q6
+      device node.
+
+    properties:
+      compatible:
+        enum:
+          - qcom,ipq5018-wcss-ahb-mpd
+          - qcom,ipq9574-wcss-ahb-mpd
+          - qcom,ipq5018-wcss-pcie-mpd
+
+      firmware-name:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        items:
+          - description: Firmware name of the Hexagon core
+
+      interrupts-extended:
+        items:
+          - description: Fatal interrupt
+          - description: Ready interrupt
+          - description: Spawn acknowledge interrupt
+          - description: Stop acknowledge interrupt
+
+      interrupt-names:
+        items:
+          - const: fatal
+          - const: ready
+          - const: spawn-ack
+          - const: stop-ack
+
+      qcom,smem-states:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description: States used by the AP to signal the remote processor
+        items:
+          - description: Shutdown WCSS pd
+          - description: Stop WCSS pd
+          - description: Spawn WCSS pd
+
+      qcom,smem-state-names:
+        description:
+          Names of the states used by the AP to signal the remote processor
+        items:
+          - const: shutdown
+          - const: stop
+          - const: spawn
+
+    required:
+      - compatible
+      - firmware-name
+      - interrupts-extended
+      - interrupt-names
+      - qcom,smem-states
+      - qcom,smem-state-names
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - firmware-name
+  - reg
+  - interrupts-extended
+  - interrupt-names
+  - qcom,smem-states
+  - qcom,smem-state-names
+  - memory-region
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5018-q6-mpd
+    then:
+      properties:
+        firmware-name:
+          items:
+            - const: IPQ5018/q6_fw.mdt
+            - const: IPQ5018/m3_fw.mdt
+            - const: qcn6122/m3_fw.mdt
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-q6-mpd
+    then:
+      properties:
+        firmware-name:
+          items:
+            - const: IPQ9574/q6_fw.mdt
+            - const: IPQ9574/m3_fw.mdt
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    q6v5_wcss: remoteproc@cd00000 {
+      compatible = "qcom,ipq5018-q6-mpd";
+      reg = <0x0cd00000 0x4040>;
+      firmware-name = "IPQ5018/q6_fw.mdt",
+                      "IPQ5018/m3_fw.mdt",
+                      "qcn6122/m3_fw.mdt";
+      interrupts-extended = <&intc GIC_SPI 291 IRQ_TYPE_EDGE_RISING>,
+                            <&wcss_smp2p_in 0 0>,
+                            <&wcss_smp2p_in 1 0>,
+                            <&wcss_smp2p_in 2 0>,
+                            <&wcss_smp2p_in 3 0>;
+      interrupt-names = "wdog",
+                        "fatal",
+                        "ready",
+                        "handover",
+                        "stop-ack";
+
+      qcom,smem-states = <&wcss_smp2p_out 0>,
+                         <&wcss_smp2p_out 1>;
+      qcom,smem-state-names = "shutdown",
+                              "stop";
+
+      memory-region = <&q6_region>;
+
+      glink-edge {
+        interrupts = <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
+        label = "rtr";
+        qcom,remote-pid = <1>;
+        mboxes = <&apcs_glb 8>;
+      };
+
+      pd-1 {
+        compatible = "qcom,ipq5018-wcss-ahb-mpd";
+        firmware-name = "IPQ5018/q6_fw.mdt";
+        interrupts-extended = <&wcss_smp2p_in 8 0>,
+                              <&wcss_smp2p_in 9 0>,
+                              <&wcss_smp2p_in 12 0>,
+                              <&wcss_smp2p_in 11 0>;
+        interrupt-names = "fatal",
+                          "ready",
+                          "spawn-ack",
+                          "stop-ack";
+        qcom,smem-states = <&wcss_smp2p_out 8>,
+                           <&wcss_smp2p_out 9>,
+                           <&wcss_smp2p_out 10>;
+        qcom,smem-state-names = "shutdown",
+                                "stop",
+                                "spawn";
+      };
+
+      pd-2 {
+        compatible = "qcom,ipq5018-wcss-pcie-mpd";
+        firmware-name = "IPQ5018/q6_fw.mdt";
+        interrupts-extended = <&wcss_smp2p_in 16 0>,
+                              <&wcss_smp2p_in 17 0>,
+                              <&wcss_smp2p_in 20 0>,
+                              <&wcss_smp2p_in 19 0>;
+        interrupt-names = "fatal",
+                          "ready",
+                          "spawn-ack",
+                          "stop-ack";
+
+        qcom,smem-states = <&wcss_smp2p_out 16>,
+                           <&wcss_smp2p_out 17>,
+                           <&wcss_smp2p_out 18>;
+        qcom,smem-state-names = "shutdown",
+                                "stop",
+                                "spawn";
+      };
+
+      pd-3 {
+        compatible = "qcom,ipq5018-wcss-pcie-mpd";
+        firmware-name = "IPQ5018/q6_fw.mdt";
+        interrupts-extended = <&wcss_smp2p_in 24 0>,
+                              <&wcss_smp2p_in 25 0>,
+                              <&wcss_smp2p_in 28 0>,
+                              <&wcss_smp2p_in 27 0>;
+        interrupt-names = "fatal",
+                          "ready",
+                          "spawn-ack",
+                          "stop-ack";
+
+        qcom,smem-states = <&wcss_smp2p_out 24>,
+                           <&wcss_smp2p_out 25>,
+                           <&wcss_smp2p_out 26>;
+        qcom,smem-state-names = "shutdown",
+                                "stop",
+                                "spawn";
+       };
+    };
--
2.17.1

