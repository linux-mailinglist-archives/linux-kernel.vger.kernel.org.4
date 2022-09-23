Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC965E7B59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiIWNG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiIWNGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:06:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC6313A38E;
        Fri, 23 Sep 2022 06:06:48 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NCwrjF030314;
        Fri, 23 Sep 2022 13:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6O7UySE4kFRKgq5vI5ybo6BrU33JJN34iQbugYUnpv0=;
 b=hb/2x5Qp56HkcKTPx5ajBavJIFAF4/sAofSY/lQq3AhYMUQ6Kz4PRDjPg7KhVFZTuH1r
 +vPUUkDfRRK9wzpwU0CrmwAxeVXnMO/AI55llcCsLBajfIOeeb+DsHN4jkktJtstsDN+
 do1hMi6AUdJ6KKdic9v1+gwQCHlTcw1iixGxZsPCj1G7+pTXLmVuAs3vw2mD5ldXUID4
 j9HMIzWZb6qzZEf+Ct0oKzvhmOrVJ92qJPMXLwCV1Ac+ZA5g97en87pZ3VOSTSIPuKRf
 uXA/emKQI/LB8ZQbn3v5/5dJVuNHrN3PA7rLuAXysdT0MSYhBp6DZXZTp2qpgLRp/M/a Nw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jsbmxrg38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 13:06:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28ND65Rp017852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 13:06:05 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 23 Sep 2022 06:06:00 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v8 1/7] dt-bindings: remoteproc: qcom: Add SC7280 ADSP support
Date:   Fri, 23 Sep 2022 18:35:34 +0530
Message-ID: <1663938340-24345-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663938340-24345-1-git-send-email-quic_srivasam@quicinc.com>
References: <1663938340-24345-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PC3j_LsLZrd_e1HSoWZTY8wSGnRVN-JD
X-Proofpoint-ORIG-GUID: PC3j_LsLZrd_e1HSoWZTY8wSGnRVN-JD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADSP PIL loading support for SC7280 SoCs.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes since V7:
	-- Remove redundant clocks in dt bindings.
	-- Fix dt compilation error in dt bindings.
Changes since V6:
	-- Update glink-edge property.
	-- Add qcom,qmp property.
Changes since V5:
	-- Remove qcom,adsp-memory-regions property.
Changes since V4:
	-- Update halt registers description in dt bindings.

 .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 207 +++++++++++++++++++++
 1 file changed, 207 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
new file mode 100644
index 0000000..79ef3c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
@@ -0,0 +1,207 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-adsp-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC7280 ADSP Peripheral Image Loader
+
+maintainers:
+  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
+
+description:
+  This document describes the hardware for a component that loads and boots firmware
+  on the Qualcomm Technology Inc. ADSP.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc7280-adsp-pil
+
+  reg:
+    minItems: 1
+    items:
+      - description: qdsp6ss register
+      - description: efuse q6ss register
+
+  interrupts:
+    items:
+      - description: Watchdog interrupt
+      - description: Fatal interrupt
+      - description: Ready interrupt
+      - description: Handover interrupt
+      - description: Stop acknowledge interrupt
+      - description: Shutdown acknowledge interrupt
+
+  interrupt-names:
+    items:
+      - const: wdog
+      - const: fatal
+      - const: ready
+      - const: handover
+      - const: stop-ack
+      - const: shutdown-ack
+
+  clocks:
+    items:
+      - description: XO clock
+      - description: GCC CFG NOC LPASS clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: gcc_cfg_noc_lpass
+
+  power-domains:
+    items:
+      - description: LCX power domain
+
+  resets:
+    items:
+      - description: PDC AUDIO SYNC RESET
+      - description: CC LPASS restart
+
+  reset-names:
+    items:
+      - const: pdc_sync
+      - const: cc_lpass
+
+  memory-region:
+    maxItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
+  qcom,halt-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandle reference to a syscon representing TCSR followed by the
+      four offsets within syscon for q6, CE, AXI and qv6 halt registers.
+    items:
+      items:
+        - description: phandle to TCSR MUTEX
+        - description: offset to q6 halt registers
+        - description: offset to CE halt registers
+        - description: offset to AXI halt registers
+        - description: offset to qv6 halt registers
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: States used by the AP to signal the Hexagon core
+    items:
+      - description: Stop the modem
+
+  qcom,smem-state-names:
+    description: The names of the state bits used for SMP2P output
+    const: stop
+
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
+  glink-edge:
+    type: object
+    description: |
+      Qualcomm G-Link subnode which represents communication edge, channels
+      and devices related to the ADSP.
+
+    properties:
+      interrupts:
+        items:
+          - description: IRQ from ADSP to GLINK
+
+      mboxes:
+        items:
+          - description: Mailbox for communication between APPS and ADSP
+
+      label:
+        description: The names of the state bits used for SMP2P output
+        items:
+          - const: lpass
+
+      qcom,remote-pid:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: ID of the shared memory used by GLINK for communication with ADSP
+
+      gpr: true
+      apr: false
+      fastrpc: false
+
+    required:
+      - interrupts
+      - mboxes
+      - label
+      - qcom,remote-pid
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+  - qcom,halt-regs
+  - memory-region
+  - qcom,smem-states
+  - qcom,smem-state-names
+  - qcom,qmp
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
+    #include <dt-bindings/clock/qcom,lpass-sc7280.h>
+    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
+    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+
+    remoteproc@3000000 {
+        compatible = "qcom,sc7280-adsp-pil";
+        reg = <0x03000000 0x5000>,
+              <0x0355b000 0x10>;
+
+        interrupts-extended = <&pdc 162 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+
+        interrupt-names = "wdog", "fatal", "ready",
+                "handover", "stop-ack", "shutdown-ack";
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>,
+                 <&gcc GCC_CFG_NOC_LPASS_CLK>;
+        clock-names = "xo", "gcc_cfg_noc_lpass";
+
+        power-domains = <&rpmhpd SC7280_LCX>;
+
+        resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
+                 <&aoss_reset AOSS_CC_LPASS_RESTART>;
+        reset-names = "pdc_sync", "cc_lpass";
+
+        qcom,halt-regs = <&tcsr_mutex 0x23000 0x25000 0x28000 0x33000>;
+
+        memory-region = <&adsp_mem>;
+
+        qcom,smem-states = <&adsp_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        qcom,qmp = <&aoss_qmp>;
+
+        glink-edge {
+            interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+                                         IPCC_MPROC_SIGNAL_GLINK_QMP
+                                         IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_CLIENT_LPASS
+                            IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+            label = "lpass";
+            qcom,remote-pid = <2>;
+        };
+    };
-- 
2.7.4

