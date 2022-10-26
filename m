Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA4560D9CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiJZD1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiJZD0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:26:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787CF760DB;
        Tue, 25 Oct 2022 20:26:42 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q3AnOY023915;
        Wed, 26 Oct 2022 03:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+2FJ+N3puCdTPZTboge4XK064xbayKUoBZpkfHgsgp0=;
 b=c8kfPXzC9sKeGwoc/BqQNdkR/sFkWNeZZkZpi8BxY24am290WvX8U+m/iCR05KQepsxl
 oqMxbT7aEw31cTflGNN/mo4ukTUR3aPC8bXISxvn//wyA2aCXmvgfmj4ixePQmtP3Dgt
 MLZpS32Q2eOcVZZNWMyU8VxGDzCocm8o5sOf39PiKCR+UweyIcf6+UrWq7oJLG41uWkM
 58qTXYuFGpN4T8djq8VipXRtzxwvMlB+vQtlX/yfEwPuVeCwcdSdo/05QyAZwG0SUs2/
 2l0fMNkkguNcAr92/6Y/42CpEfSAPHqomyJCjc3pyeNGhDLDjKBd/s6EzB6FdHw4NmHf /g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ken718tj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 03:26:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29Q3QV4V029632
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 03:26:31 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 25 Oct 2022 20:26:31 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Kuogee Hsieh" <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 01/12] dt-bindings: display/msm: Add binding for SC8280XP MDSS
Date:   Tue, 25 Oct 2022 20:26:13 -0700
Message-ID: <20221026032624.30871-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221026032624.30871-1-quic_bjorande@quicinc.com>
References: <20221026032624.30871-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WHGAxJqE5x4TNeLX9IO0ABTjScsd7w_b
X-Proofpoint-ORIG-GUID: WHGAxJqE5x4TNeLX9IO0ABTjScsd7w_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_15,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add binding for the display subsystem and display processing unit in the
Qualcomm SC8280XP platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v2:
- Cleaned up description and interconnect definitions
- Added opp-table

 .../bindings/display/msm/dpu-sc8280xp.yaml    | 287 ++++++++++++++++++
 1 file changed, 287 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
new file mode 100644
index 000000000000..24e7a1562fe7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
@@ -0,0 +1,287 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/dpu-sc8280xp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Processing Unit for SC8280XP
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  Device tree bindings for MSM Mobile Display Subsystem (MDSS) that encapsulates
+  sub-blocks like DPU display controller, DSI and DP interfaces etc.
+
+properties:
+  compatible:
+    const: qcom,sc8280xp-mdss
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    const: mdss
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Display AHB clock from gcc
+      - description: Display AHB clock from dispcc
+      - description: Display core clock
+
+  clock-names:
+    items:
+      - const: iface
+      - const: ahb
+      - const: core
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  "#interrupt-cells":
+    const: 1
+
+  iommus:
+    items:
+      - description: Phandle to apps_smmu node with SID mask for Hard-Fail port0
+
+  ranges: true
+
+  interconnects:
+    items:
+      - description: Interconnect path for first data bus
+      - description: Interconnect path for second data bus
+
+  interconnect-names:
+    items:
+      - const: mdp0-mem
+      - const: mdp1-mem
+
+  resets:
+    items:
+      - description: MDSS_CORE reset
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    description: Node containing the properties of DPU.
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: qcom,sc8280xp-dpu
+
+      reg:
+        items:
+          - description: Address offset and size for mdp register set
+          - description: Address offset and size for vbif register set
+
+      reg-names:
+        items:
+          - const: mdp
+          - const: vbif
+
+      clocks:
+        items:
+          - description: Display hf axi clock
+          - description: Display sf axi clock
+          - description: Display ahb clock
+          - description: Display lut clock
+          - description: Display core clock
+          - description: Display vsync clock
+
+      clock-names:
+        items:
+          - const: bus
+          - const: nrt_bus
+          - const: iface
+          - const: lut
+          - const: core
+          - const: vsync
+
+      interrupts:
+        maxItems: 1
+
+      power-domains:
+        maxItems: 1
+
+      operating-points-v2: true
+      opp-table:
+        type: object
+
+      ports:
+        $ref: /schemas/graph.yaml#/properties/ports
+        description: |
+          Contains the list of output ports from DPU device. These ports
+          connect to interfaces that are external to the DPU hardware,
+          such as DSI, DP etc. Each output port contains an endpoint that
+          describes how it is connected to an external interface.
+
+        patternProperties:
+          '^port@[0-8]$':
+            $ref: /schemas/graph.yaml#/properties/port
+            description: DPU interfaces
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+      - clocks
+      - interrupts
+      - power-domains
+      - operating-points-v2
+      - ports
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - power-domains
+  - clocks
+  - interrupts
+  - interrupt-controller
+  - iommus
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interconnect/qcom,sc8280xp.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    display-subsystem@ae00000 {
+      compatible = "qcom,sc8280xp-mdss";
+      reg = <0x0ae00000 0x1000>;
+      reg-names = "mdss";
+
+      power-domains = <&dispcc0 MDSS_GDSC>;
+
+      clocks = <&gcc GCC_DISP_AHB_CLK>,
+               <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
+               <&dispcc0 DISP_CC_MDSS_MDP_CLK>;
+      clock-names = "iface",
+                    "ahb",
+                    "core";
+
+      assigned-clocks = <&dispcc0 DISP_CC_MDSS_MDP_CLK>;
+      assigned-clock-rates = <460000000>;
+
+      resets = <&dispcc0 DISP_CC_MDSS_CORE_BCR>;
+
+      interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+
+      interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
+                      <&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>;
+      interconnect-names = "mdp0-mem", "mdp1-mem";
+
+      iommus = <&apps_smmu 0x1000 0x402>;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+
+      display-controller@ae01000 {
+        compatible = "qcom,sc8280xp-dpu";
+        reg = <0x0ae01000 0x8f000>,
+              <0x0aeb0000 0x2008>;
+        reg-names = "mdp", "vbif";
+
+        clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&gcc GCC_DISP_SF_AXI_CLK>,
+                 <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
+                 <&dispcc0 DISP_CC_MDSS_MDP_LUT_CLK>,
+                 <&dispcc0 DISP_CC_MDSS_MDP_CLK>,
+                 <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
+        clock-names = "bus",
+                      "nrt_bus",
+                      "iface",
+                      "lut",
+                      "core",
+                      "vsync";
+
+        assigned-clocks = <&dispcc0 DISP_CC_MDSS_MDP_CLK>,
+                          <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
+        assigned-clock-rates = <460000000>,
+                               <19200000>;
+
+        operating-points-v2 = <&mdss0_mdp_opp_table>;
+        power-domains = <&rpmhpd SC8280XP_MMCX>;
+
+        interrupt-parent = <&mdss0>;
+        interrupts = <0>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+              endpoint {
+                remote-endpoint = <&mdss0_dp0_in>;
+              };
+          };
+
+          port@4 {
+            reg = <4>;
+            endpoint {
+              remote-endpoint = <&mdss0_dp1_in>;
+            };
+          };
+
+          port@5 {
+            reg = <5>;
+              endpoint {
+                remote-endpoint = <&mdss0_dp3_in>;
+              };
+          };
+
+          port@6 {
+            reg = <6>;
+              endpoint {
+                remote-endpoint = <&mdss0_dp2_in>;
+              };
+          };
+        };
+
+        mdss0_mdp_opp_table: opp-table {
+          compatible = "operating-points-v2";
+
+          opp-200000000 {
+            opp-hz = /bits/ 64 <200000000>;
+            required-opps = <&rpmhpd_opp_low_svs>;
+          };
+
+          opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            required-opps = <&rpmhpd_opp_svs>;
+          };
+
+          opp-345000000 {
+            opp-hz = /bits/ 64 <345000000>;
+            required-opps = <&rpmhpd_opp_svs_l1>;
+          };
+
+          opp-460000000 {
+            opp-hz = /bits/ 64 <460000000>;
+            required-opps = <&rpmhpd_opp_nom>;
+          };
+        };
+      };
+    };
+...
+
-- 
2.37.3

