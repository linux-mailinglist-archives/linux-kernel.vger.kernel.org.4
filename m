Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9196FDECE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbjEJNmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjEJNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:42:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E6246A5;
        Wed, 10 May 2023 06:42:16 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AD85Bq020505;
        Wed, 10 May 2023 13:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=U51Ht9Ktn3mLHWiSd85/xvzhwUKbwWER+3RV4M3RhFc=;
 b=K3vg25bV0PVRAWKqYWYCx95rgR/AQBwL3U0YYcKBwDGakweqqytScSrOCDbH4txWRSPe
 1Zlzl5BgOomvWQ/11tRdPHgz6NIxy0fV/9MiDvGjECmRcfzH3TQO9kHVVqBARO2Iut1w
 r9xSTzD39/h/ftvVyV6thC2gJZ4W+CD1x9BYAQhILj02QyGaTfOWyAADuVTxptRWEZpT
 xEAhJAQzGXI1tPEwEwuz713/eLnu3BunIL1ypI7tQ88zHVdBVjdR9vPkjOGAFymZIaYq
 5b9aE8XEECKSh2P1+lYKqV8gZjZ63fwpPH/bJLIN4OGBH1mF7MVe4fU6jS0iYCxkkHa7 mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg79crked-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 13:42:05 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34ADfwv7024522
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 13:41:58 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 06:41:52 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_srichara@quicinc.com>
Subject: [PATCH v4 3/8] dt-bindings: pinctrl: qcom: Add support for ipq5018
Date:   Wed, 10 May 2023 19:11:16 +0530
Message-ID: <20230510134121.1232286-4-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510134121.1232286-1-quic_srichara@quicinc.com>
References: <20230510134121.1232286-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AdnFOemGsHPKfL3K0v3VmYFJLc4rG1re
X-Proofpoint-ORIG-GUID: AdnFOemGsHPKfL3K0v3VmYFJLc4rG1re
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding Documentation details for ipq5018
pinctrl driver.

Co-developed-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v4] Fixed all comments from Krzysztof Kozlowski
      Fixed warnings from schema checks

 .../bindings/pinctrl/qcom,ipq5018-tlmm.yaml   | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
new file mode 100644
index 000000000000..fad0118fd521
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,ipq5018-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ5018 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm IPQ5018 SoC.
+
+properties:
+  compatible:
+    const: qcom,ipq5018-tlmm
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
+    maxItems: 24
+
+  gpio-line-names:
+    maxItems: 47
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-ipq5018-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-ipq5018-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-ipq5018-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: "^gpio([0-9]|[1-3][0-9]|4[0-6])$"
+        minItems: 1
+        maxItems: 8
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ atest_char, audio_pdm0, audio_pdm1, audio_rxbclk, audio_rxd,
+                audio_rxfsync, audio_rxmclk, audio_txbclk, audio_txd,
+                audio_txfsync, audio_txmclk, blsp0_i2c, blsp0_spi, blsp0_uart0,
+                blsp0_uart1, blsp1_i2c0, blsp1_i2c1, blsp1_spi0, blsp1_spi1,
+                blsp1_uart0, blsp1_uart1, blsp1_uart2, blsp2_i2c0, blsp2_i2c1,
+                blsp2_spi, blsp2_spi0, blsp2_spi1, btss, burn0, burn1, cri_trng,
+                cri_trng0, cri_trng1, cxc_clk, cxc_data, dbg_out, eud_gpio,
+                gcc_plltest, gcc_tlmm, gpio, led0, led2, mac0, mac1, mdc, mdio,
+                pcie0_clk, pcie0_wake, pcie1_clk, pcie1_wake, pll_test,
+                prng_rosc, pwm0, pwm1, pwm2, pwm3, qdss_cti_trig_in_a0,
+                qdss_cti_trig_in_a1, qdss_cti_trig_in_b0, qdss_cti_trig_in_b1,
+                qdss_cti_trig_out_a0, qdss_cti_trig_out_a1,
+                qdss_cti_trig_out_b0, qdss_cti_trig_out_b1, qdss_traceclk_a,
+                qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b,
+                qdss_tracedata_a, qdss_tracedata_b, qspi_clk, qspi_cs,
+                qspi_data, reset_out, sdc1_clk, sdc1_cmd, sdc1_data, wci_txd,
+                wci_rxd, wsa_swrm, wsi_clk3, wsi_data3, wsis_reset, xfem ]
+
+    required:
+      - pins
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
+    tlmm: pinctrl@1000000 {
+        compatible = "qcom,ipq5018-tlmm";
+        reg = <0x01000000 0x300000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 47>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+        uart-w-state {
+            rx-pins {
+                pins = "gpio33";
+                function = "blsp1_uart1";
+                bias-pull-down;
+            };
+
+            tx-pins {
+                pins = "gpio34";
+                function = "blsp1_uart1";
+                bias-pull-down;
+            };
+        };
+    };
+...
-- 
2.34.1

