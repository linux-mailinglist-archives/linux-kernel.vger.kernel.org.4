Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B46680C44
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbjA3Lr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbjA3Lrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:47:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713EB2B0BA;
        Mon, 30 Jan 2023 03:47:49 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UBXQw2018578;
        Mon, 30 Jan 2023 11:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ebXnmWAKQ+AfsBaIpQ8igehv8pSTf2dOgM7d7mihQzA=;
 b=irSRTAqGVCDlcX/nCxWtUAYXUXSekr3pBBYHdeaayfZPR7Lv8aPUtGCdyz6e3fgU90mA
 BKB9wakg10wBCVUwAe3OXJVPzAEgVACOzJRatQ+22wGDAvs96M47/unG/H6RrHRKJKLi
 5zCQ9XHXFNwaXajuB0MuF2dW6hMYXfCFSPq9jlev8VLRiMHhNkstbCLUpH+MvGY4yW1C
 qoQCPKCR1ZVirZpa7GaZJiCCJCiZ+7hOebtYu8CAdzNW/mDvtGOSaau/lITmZyP7Dmne
 jF1p3tiBftnbbIZOl7S0AS2eFYo3qB9D454Zo/6kjMpei8PKNTe0ElEE1QrS2lKELO91 yg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvvu3c0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 11:47:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UBlU70032521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 11:47:30 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 03:47:23 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 1/9] dt-bindings: pinctrl: qcom: add IPQ5332 pinctrl
Date:   Mon, 30 Jan 2023 17:16:54 +0530
Message-ID: <20230130114702.20606-2-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230130114702.20606-1-quic_kathirav@quicinc.com>
References: <20230130114702.20606-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XrSNreKC3pIrqEyX_QtkFAqytesSK91T
X-Proofpoint-ORIG-GUID: XrSNreKC3pIrqEyX_QtkFAqytesSK91T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_10,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301300113
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kathiravan T <quic_kathirav@quicinc.com>

Add device tree bindings for IPQ5332 TLMM block.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Renamed the file name to match with compatible
	- Added 'maxItems' for 'interrupt' property
	- Fixed the gpio pattern to 0 to 52 GPIOs instead of 0 to 53 GPIOs
	- Converted the function names to lowercase and sort it

 .../bindings/pinctrl/qcom,ipq5332-tlmm.yaml   | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
new file mode 100644
index 000000000000..9a943d613afa
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,ipq5332-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ5332 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description: |
+  Top Level Mode Multiplexer pin controller in Qualcomm IPQ5332 SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,ipq5332-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+  "#interrupt-cells": true
+  gpio-controller: true
+  "#gpio-cells": true
+  gpio-ranges: true
+  wakeup-parent: true
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 27
+
+  gpio-line-names:
+    maxItems: 53
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-ipq5332-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-ipq5332-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-ipq5332-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: "^gpio([0-9]|[1-4][0-9]|5[0-2])$"
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ atest_char, atest_char0, atest_char1, atest_char2, atest_char3,
+                atest_tic, audio_pri, audio_pri0, audio_pri1, audio_sec,
+                audio_sec0, audio_sec1, blsp0_i2c, blsp0_spi, blsp0_uart0,
+                blsp0_uart1, blsp1_i2c0, blsp1_i2c1, blsp1_spi0, blsp1_spi1,
+                blsp1_uart0, blsp1_uart1, blsp1_uart2, blsp2_i2c0, blsp2_i2c1,
+                blsp2_spi, blsp2_spi0, blsp2_spi1, core_voltage, cri_trng0,
+                cri_trng1, cri_trng2, cri_trng3, cxc_clk, cxc_data, dbg_out,
+                gcc_plltest, gcc_tlmm, gpio, lock_det, mac0, mac1, mdc0, mdc1,
+                mdio0, mdio1, pc, pcie0_clk, pcie0_wake, pcie1_clk, pcie1_wake,
+                pcie2_clk, pcie2_wake, pll_test, prng_rosc0, prng_rosc1,
+                prng_rosc2, prng_rosc3, pta_0, pta_2, pta_1, pwm0, pwm1, pwm2,
+                pwm3, qdss_cti_trig_in_a0, qdss_cti_trig_in_a1,
+                qdss_cti_trig_in_b0, qdss_cti_trig_in_b1, qdss_cti_trig_out_a0,
+                qdss_cti_trig_out_a1, qdss_cti_trig_out_b0,
+                qdss_cti_trig_out_b1, qdss_traceclk_a, qdss_traceclk_b,
+                qdss_tracectl_a, qdss_tracectl_b, qdss_tracedata_a,
+                qdss_tracedata_b, qspi_data, qspi_clk, qspi_cs, resout, rx0,
+                rx1, sdc_data, sdc_clk, sdc_cmd, tsens_max, wci0, wci1, wci10,
+                wci11, wci2, wci3, wci4, wci5, wci6, wci7, wci8, wci9, wsi_clk,
+                wsi_clk3, wsi_data, wsi_data3, wsis_reset, xfem0, xfem1, xfem2,
+                xfem3, xfem4, xfem5, xfem6, xfem7 ]
+
+      bias-pull-down: true
+      bias-pull-up: true
+      bias-disable: true
+      drive-strength: true
+      input-enable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tlmm: pinctrl@1000000 {
+        compatible = "qcom,ipq5332-tlmm";
+        reg = <0x01000000 0x300000>;
+        gpio-controller;
+        #gpio-cells = <0x2>;
+        gpio-ranges = <&tlmm 0 0 53>;
+        interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <0x2>;
+
+        serial0-state {
+            pins = "gpio18", "gpio19";
+            function = "blsp0_uart0";
+            drive-strength = <8>;
+            bias-pull-up;
+        };
+    };
-- 
2.17.1

