Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DF1661CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjAIDvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbjAIDuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:50:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B8DD2DC;
        Sun,  8 Jan 2023 19:50:30 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3093P3w8032703;
        Mon, 9 Jan 2023 03:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=QTiAzREZrLr03iFwr74lfx+Rq7+hFRpE7QBh9leql8k=;
 b=KFcQZ/RR6u5DheNF2iyecsoGb/b29xdf7PB7yZh8ikm4ocPL1o4v4qlb6fqf2zb/v8t+
 cHWFbOD6GRBJaz4ZTayjOvCuLrT2NwWYJCxbu4FpTyUF1oz3QDCG1ETDkMcZG77tYkge
 WyzkD3MOhHENuU4YTGwuDDdJww69F2S/YEcvLqJuoOHjP00EtCME9JpVUUo9d6o4po0H
 2OVhKJmg8nugFk9SbCvlCxfoC4J5l8va+tz9yetcDJWX4A4R5cu/4tnqWsGl6okKcs5a
 dL5RgbcN0HUV2qH3h/sDyGV3L51gbhDMoxeOA29CnZyROzrhrNdcj/PcEMA9rKEPxlY+ 0Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mxxeqtea8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 03:50:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3093oAVq031044
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 03:50:11 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 8 Jan 2023 19:50:06 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <robin.murphy@arm.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 01/11] dt-bindings: remoteproc: qcom,q6v5: Move MSM8996 to schema
Date:   Mon, 9 Jan 2023 09:18:33 +0530
Message-ID: <20230109034843.23759-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230109034843.23759-1-quic_sibis@quicinc.com>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7zsFKFb2tsI9bEZnVbz9dxfOAmN6xAFF
X-Proofpoint-GUID: 7zsFKFb2tsI9bEZnVbz9dxfOAmN6xAFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301090025
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert MSM8996 and similar (MSM8998/SDM845) MSS PIL bindings to schema.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../remoteproc/qcom,msm8996-mss-pil.yaml      | 370 ++++++++++++++++++
 .../bindings/remoteproc/qcom,q6v5.txt         | 137 +------
 2 files changed, 375 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
new file mode 100644
index 000000000000..d3d3fb2fe91d
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
@@ -0,0 +1,370 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,msm8996-mss-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8996 MSS Peripheral Image Loader (and similar)
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Sibi Sankar <quic_sibis@quicinc.com>
+
+description:
+  This document describes the hardware for a component that loads and boots firmware
+  on the Qualcomm Technology Inc. MSM8996 Modem Hexagon Core (and similar).
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - qcom,msm8996-mss-pil
+          - qcom,msm8998-mss-pil
+          - qcom,sdm845-mss-pil
+
+  reg:
+    items:
+      - description: MSS QDSP6 registers
+      - description: RMB registers
+
+  reg-names:
+    items:
+      - const: qdsp6
+      - const: rmb
+
+  iommus:
+    items:
+      - description: MSA Stream 1
+      - description: MSA Stream 2
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
+    minItems: 8
+    maxItems: 9
+
+  clock-names:
+    minItems: 8
+    maxItems: 9
+
+  power-domains:
+    items:
+      - description: CX power domain
+      - description: MX power domain
+      - description: MSS power domain (only valid for qcom,sdm845-mss-pil)
+    minItems: 2
+
+  power-domain-names:
+    items:
+      - const: cx
+      - const: mx
+      - const: mss # only valid for qcom,sdm845-mss-pil
+    minItems: 2
+
+  pll-supply:
+    description: PLL supply
+
+  resets:
+    items:
+      - description: AOSS restart
+      - description: PDC reset (only valid for qcom,sdm845-mss-pil)
+    minItems: 1
+
+  reset-names:
+    items:
+      - const: mss_restart
+      - const: pdc_reset # only valid for qcom,sdm845-mss-pil
+    minItems: 1
+
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: States used by the AP to signal the Hexagon core
+    items:
+      - description: Stop modem
+
+  qcom,smem-state-names:
+    description: Names of the states used by the AP to signal the Hexagon core
+    items:
+      - const: stop
+
+  qcom,halt-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Halt registers are used to halt transactions of various sub-components
+      within MSS.
+    items:
+      - items:
+          - description: phandle to TCSR syscon region
+          - description: offset to the Q6 halt register
+          - description: offset to the modem halt register
+          - description: offset to the nc halt register
+
+  memory-region:
+    items:
+      - description: MBA reserved region
+      - description: Modem reserved region
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    items:
+      - description: Name of MBA firmware
+      - description: Name of modem firmware
+
+  smd-edge:
+    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
+    description:
+      Qualcomm Shared Memory subnode which represents communication edge,
+      channels and devices related to the Modem.
+    unevaluatedProperties: false
+
+  glink-edge:
+    $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
+    description:
+      Qualcomm G-Link subnode which represents communication edge, channels
+      and devices related to the Modem.
+    unevaluatedProperties: false
+
+  # Deprecated properties
+  mba:
+    type: object
+    description:
+      MBA reserved region
+    properties:
+      memory-region: true
+    required:
+      - memory-region
+    deprecated: true
+
+  mpss:
+    type: object
+    description:
+      MPSS reserved region
+    properties:
+      memory-region: true
+    required:
+      - memory-region
+    deprecated: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - power-domain-names
+  - resets
+  - reset-names
+  - qcom,halt-regs
+  - qcom,smem-states
+  - qcom,smem-state-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: qcom,msm8996-mss-pil
+    then:
+      properties:
+        clocks:
+          items:
+            - description: GCC MSS IFACE clock
+            - description: GCC MSS BUS clock
+            - description: GCC MSS MEM clock
+            - description: RPMH XO clock
+            - description: GCC MSS GPLL0 clock
+            - description: GCC MSS SNOC_AXI clock
+            - description: GCC MSS MNOC_AXI clock
+            - description: RPMH PNOC clock
+            - description: GCC MSS PRNG clock
+            - description: RPMH QDSS clock
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: mem
+            - const: xo
+            - const: gpll0_mss
+            - const: snoc_axi
+            - const: mnoc_axi
+            - const: pnoc
+            - const: qdss
+        glink-edge: false
+      required:
+        - pll-supply
+        - smd-edge
+    else:
+      properties:
+        pll-supply: false
+        smd-edge: false
+
+  - if:
+      properties:
+        compatible:
+          const: qcom,msm8998-mss-pil
+    then:
+      properties:
+        clocks:
+          items:
+            - description: GCC MSS IFACE clock
+            - description: GCC MSS BUS clock
+            - description: GCC MSS MEM clock
+            - description: GCC MSS GPLL0 clock
+            - description: GCC MSS SNOC_AXI clock
+            - description: GCC MSS MNOC_AXI clock
+            - description: RPMH QDSS clock
+            - description: RPMH XO clock
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: mem
+            - const: gpll0_mss
+            - const: snoc_axi
+            - const: mnoc_axi
+            - const: qdss
+            - const: xo
+      required:
+        - glink-edge
+
+  - if:
+      properties:
+        compatible:
+          const: qcom,sdm845-mss-pil
+    then:
+      properties:
+        power-domains:
+          minItems: 3
+        power-domain-names:
+          minItems: 3
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+        clocks:
+          items:
+            - description: GCC MSS IFACE clock
+            - description: GCC MSS BUS clock
+            - description: GCC MSS MEM clock
+            - description: GCC MSS GPLL0 clock
+            - description: GCC MSS SNOC_AXI clock
+            - description: GCC MSS MNOC_AXI clock
+            - description: GCC MSS PRNG clock
+            - description: RPMH XO clock
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: mem
+            - const: gpll0_mss
+            - const: snoc_axi
+            - const: mnoc_axi
+            - const: prng
+            - const: xo
+      required:
+        - qcom,qmp
+        - glink-edge
+    else:
+      properties:
+        iommus: false
+        power-domains:
+          maxItems: 2
+        power-domain-names:
+          maxItems: 2
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+        qcom,qmp: false
+
+  # Fallbacks for deprecated properties
+  - oneOf:
+      - required:
+          - memory-region
+      - required:
+          - mba
+          - mpss
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
+    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
+
+    remoteproc@4080000 {
+        compatible = "qcom,sdm845-mss-pil";
+        reg = <0x04080000 0x408>, <0x04180000 0x48>;
+        reg-names = "qdsp6", "rmb";
+
+        interrupts-extended = <&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack",
+                          "shutdown-ack";
+
+        clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+                 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+                 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+                 <&gcc GCC_MSS_GPLL0_DIV_CLK_SRC>,
+                 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+                 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
+                 <&gcc GCC_PRNG_AHB_CLK>,
+                 <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "iface", "bus", "mem", "gpll0_mss",
+                      "snoc_axi", "mnoc_axi", "prng", "xo";
+
+        power-domains = <&rpmhpd SDM845_CX>,
+                        <&rpmhpd SDM845_MX>,
+                        <&rpmhpd SDM845_MSS>;
+        power-domain-names = "cx", "mx", "mss";
+
+        memory-region = <&mba_mem>, <&mpss_mem>;
+
+        resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
+                 <&pdc_reset PDC_MODEM_SYNC_RESET>;
+        reset-names = "mss_restart", "pdc_reset";
+
+        qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
+
+        qcom,qmp = <&aoss_qmp>;
+
+        qcom,smem-states = <&modem_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+            label = "modem";
+            qcom,remote-pid = <1>;
+            mboxes = <&apss_shared 12>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 5923c0447e2d..573a88b60677 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -9,9 +9,6 @@ on the Qualcomm Hexagon core.
 	Definition: must be one of:
 		    "qcom,ipq8074-wcss-pil"
 		    "qcom,qcs404-wcss-pil"
-		    "qcom,msm8996-mss-pil"
-		    "qcom,msm8998-mss-pil"
-		    "qcom,sdm845-mss-pil"
 
 - reg:
 	Usage: required
@@ -32,23 +29,7 @@ on the Qualcomm Hexagon core.
 - interrupt-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: The interrupts needed depends on the compatible
-		    string:
-	qcom,ipq8074-wcss-pil:
-	qcom,qcs404-wcss-pil:
-		    must be "wdog", "fatal", "ready", "handover", "stop-ack"
-	qcom,msm8996-mss-pil:
-	qcom,msm8998-mss-pil:
-	qcom,sdm845-mss-pil:
-		    must be "wdog", "fatal", "ready", "handover", "stop-ack",
-		    "shutdown-ack"
-
-- firmware-name:
-	Usage: optional
-	Value type: <stringlist>
-	Definition: must list the relative firmware image paths for mba and
-		    modem. They are used for booting and authenticating the
-		    Hexagon core.
+	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
 
 - clocks:
 	Usage: required
@@ -66,41 +47,23 @@ on the Qualcomm Hexagon core.
 		    "gcc_axim_cbcr", "lcc_ahbfabric_cbc", "tcsr_lcc_cbc",
 		    "lcc_abhs_cbc", "lcc_tcm_slave_cbc", "lcc_abhm_cbc",
 		    "lcc_axim_cbc", "lcc_bcr_sleep"
-	qcom,msm8996-mss-pil:
-		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
-		    "snoc_axi", "mnoc_axi", "pnoc", "qdss"
-	qcom,msm8998-mss-pil:
-		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
-		    "snoc_axi", "mnoc_axi", "qdss"
-	qcom,sdm845-mss-pil:
-		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
-		    "snoc_axi", "mnoc_axi", "prng"
 
 - resets:
 	Usage: required
 	Value type: <phandle>
-	Definition: reference to the reset-controller for the modem sub-system
-		    reference to the list of 3 reset-controllers for the
+	Definition: reference to the list of 3 reset-controllers for the
 		    wcss sub-system
-		    reference to the list of 2 reset-controllers for the modem
-		    sub-system on SDM845 SoCs
 
 - reset-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "mss_restart" for the modem sub-system
-		    must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
+	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
 		    for the wcss sub-system
-		    must be "mss_restart", "pdc_reset" for the modem
-		    sub-system on SDM845 SoCs
 
-For devices where the mba and mpss sub-nodes are not specified, mba/mpss region
-should be referenced as follows:
 - memory-region:
 	Usage: required
 	Value type: <phandle>
-	Definition: reference to the reserved-memory for the mba region followed
-		    by the mpss region
+	Definition: reference to wcss reserved-memory region.
 
 For the compatible string below the following supplies are required:
   "qcom,qcs404-wcss-pil"
@@ -110,36 +73,6 @@ For the compatible string below the following supplies are required:
 	Definition: reference to the regulators to be held on behalf of the
 		    booting of the Hexagon core
 
-For the compatible string below the following supplies are required:
-  "qcom,msm8996-mss-pil"
-- pll-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the regulators to be held on behalf of the
-		    booting of the Hexagon core
-
-- power-domains:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to power-domains that match power-domain-names
-
-- power-domain-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: The power-domains needed depend on the compatible string:
-	qcom,ipq8074-wcss-pil:
-		    no power-domain names required
-	qcom,msm8996-mss-pil:
-	qcom,msm8998-mss-pil:
-		    must be "cx", "mx"
-	qcom,sdm845-mss-pil:
-		    must be "cx", "mx", "mss"
-
-- qcom,qmp:
-	Usage: optional
-	Value type: <phandle>
-	Definition: reference to the AOSS side-channel message RAM.
-
 - qcom,smem-states:
 	Usage: required
 	Value type: <phandle>
@@ -155,16 +88,9 @@ For the compatible string below the following supplies are required:
 	Usage: required
 	Value type: <prop-encoded-array>
 	Definition: a phandle reference to a syscon representing TCSR followed
-		    by the three offsets within syscon for q6, modem and nc
+		    by the three offsets within syscon for q6, wcss and nc
 		    halt registers.
 
-The Hexagon node must contain iommus property as described in ../iommu/iommu.txt
-on platforms which do not have TrustZone.
-
-= SUBNODES:
-The Hexagon node must contain two subnodes, named "mba" and "mpss" representing
-the memory regions used by the Hexagon firmware. Each sub-node must contain:
-
 - memory-region:
 	Usage: required
 	Value type: <phandle>
@@ -174,56 +100,3 @@ The Hexagon node may also have an subnode named either "smd-edge" or
 "glink-edge" that describes the communication edge, channels and devices
 related to the Hexagon.  See ../soc/qcom/qcom,smd.yaml and
 ../soc/qcom/qcom,glink.txt for details on how to describe these.
-
-= EXAMPLE
-The following example describes the resources needed to boot control the
-Hexagon, as it is found on MSM8974 boards.
-
-	remoteproc@fc880000 {
-		compatible = "qcom,msm8974-mss-pil";
-		reg = <0xfc880000 0x100>, <0xfc820000 0x020>;
-		reg-names = "qdsp6", "rmb";
-
-		interrupts-extended = <&intc GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
-				      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-				      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
-				      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
-				      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
-		interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
-
-		clocks = <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
-			 <&gcc GCC_MSS_CFG_AHB_CLK>,
-			 <&gcc GCC_BOOT_ROM_AHB_CLK>,
-			 <&xo_board>;
-		clock-names = "iface", "bus", "mem", "xo";
-
-		resets = <&gcc GCC_MSS_RESTART>;
-		reset-names = "mss_restart";
-
-		cx-supply = <&pm8841_s2>;
-		mss-supply = <&pm8841_s3>;
-		mx-supply = <&pm8841_s1>;
-		pll-supply = <&pm8941_l12>;
-
-		qcom,halt-regs = <&tcsr_mutex_block 0x1180 0x1200 0x1280>;
-
-		qcom,smem-states = <&modem_smp2p_out 0>;
-		qcom,smem-state-names = "stop";
-
-		mba {
-			memory-region = <&mba_region>;
-		};
-
-		mpss {
-			memory-region = <&mpss_region>;
-		};
-
-		smd-edge {
-			interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
-
-			qcom,ipc = <&apcs 8 12>;
-			qcom,smd-edge = <0>;
-
-			label = "modem";
-		};
-	};
-- 
2.17.1

