Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4849687774
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjBBIcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjBBIby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:31:54 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3923CC17;
        Thu,  2 Feb 2023 00:31:51 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3127d0Js024842;
        Thu, 2 Feb 2023 08:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YBaP7F9d5bfv5PvGUN02ZSzZVgZtxZJ2LnG+6x0HxqU=;
 b=PHumposlHiH7XeKElLir+BOfDIIIpUrDB4UGWbB1FphAlFutHupFmYUWPTcwd/iXmLh8
 ANuZ6NhUoF4yiBtguOAnR77YMe7p71a8rbG9gPU4Ac4StiaB0YE+uFqcu8++HsGBM7FZ
 BSQk4V7xEtO/y0QZBaiiSDDxUeCQoWN7pMyWv64rZdxOiZStEjtAhAGyBk63vywYvunL
 wrB/Hfmj9QxgO3lnG18ZLmBFsaTtlAXd6nlWSz9HvquagzHwdvC4SCaGGpUhkSHlf3az
 B3S9mJo67KYMnKxOHCjKTeSMcmoYTPkCwQ+10B74d9zDk/xjXR52RQ+GKgS/epjKedsY gg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfvgbhhuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 08:31:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3128VQ9l025645
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 08:31:26 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 00:31:14 -0800
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH V5 3/7] dt-bindings: pinctrl: qcom: Add support for IPQ9574
Date:   Thu, 2 Feb 2023 14:00:27 +0530
Message-ID: <20230202083031.10457-4-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230202083031.10457-1-quic_devipriy@quicinc.com>
References: <20230202083031.10457-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g6tURlgkoyc-jASsmW8myluUiKamBj8e
X-Proofpoint-ORIG-GUID: g6tURlgkoyc-jASsmW8myluUiKamBj8e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_15,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new binding document for pinctrl on IPQ9574

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V5:
	- No changes

 .../bindings/pinctrl/qcom,ipq9574-tlmm.yaml   | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
new file mode 100644
index 000000000000..053b15ccb7a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,ipq9574-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. IPQ9574 TLMM block
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm IPQ9574 SoC.
+
+properties:
+  compatible:
+    const: qcom,ipq9574-tlmm
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
+    maxItems: 33
+
+  gpio-line-names:
+    maxItems: 65
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-ipq9574-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-ipq9574-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-ipq9574-tlmm-state:
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
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-5][0-9]|6[0-4])$"
+            - enum: [ qdsd_cmd, qdsd_data0, qdsd_data1, qdsd_data2, qdsd_cmd,
+                      qdsd_data0, qdsd_data1, qdsd_data2, qdsd_data3, sdc1_clk,
+                      sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 8
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ atest_char, atest_char0, atest_char1, atest_char2, atest_char3,
+                audio_pdm0, audio_pdm1, audio_pri, audio_sec, blsp0_spi, blsp0_uart,
+                blsp1_i2c, blsp1_spi, blsp1_uart, blsp2_i2c, blsp2_spi,
+                blsp2_uart, blsp3_i2c, blsp3_spi, blsp3_uart, blsp4_i2c,
+                blsp4_spi, blsp4_uart, blsp5_i2c, blsp5_uart, cri_trng0,
+                cri_trng1, cri_trng3, cxc0, cxc1, dbg_out, dwc_ddrphy,
+                gcc_plltest, gcc_tlmm, mac00, mac01, mac10, mac11, mdc,
+                mdio, pcie0_clk, pcie0_wake, pcie1_clk, pcie1_wake, pcie2_clk,
+                pcie2_wake, pcie3_clk, pcie3_wake, prng_rosc0, prng_rosc1,
+                prng_rosc2, prng_rosc3, pta1_0, pta1_1, pta1_2, pta20, pta21,
+                pwm00, pwm01, pwm02, pwm03, pwm04, pwm10, pwm11, pwm12, pwm13,
+                pwm14, pwm20, pwm21, pwm22, pwm23, pwm24, pwm30, pwm31, pwm32,
+                pwm33, qdss_cti_trig_in_a0, qdss_cti_trig_in_a1, qdss_cti_trig_in_b0,
+                qdss_cti_trig_in_b1, qdss_cti_trig_out_a0, qdss_cti_trig_out_a1,
+                qdss_cti_trig_out_b0, qdss_cti_trig_out_b1, qdss_traceclk_a,
+                qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b, qdss_tracedata_a,
+                qdss_tracedata_b, qdss_tracedata_b, qspi_clk, qspi_cs, qspi_data,
+                rx0, rx1, sdc_clk, sdc_cmd, sdc_data, sdc_rclk, tsens_max,
+                wci20, wci21, wsa_swrm ]
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
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
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
+        compatible = "qcom,ipq9574-tlmm";
+        reg = <0x01000000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 65>;
+
+        uart2-state {
+            pins = "gpio34", "gpio35";
+            function = "blsp2_uart";
+            drive-strength = <8>;
+            bias-pull-down;
+        };
+    };
-- 
2.17.1

