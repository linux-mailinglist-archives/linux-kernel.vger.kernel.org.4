Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB62164F4B6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLPXJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLPXJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:09:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EC72611;
        Fri, 16 Dec 2022 15:09:09 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGLq5Ee022268;
        Fri, 16 Dec 2022 23:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=S4FT+SBwhJb5Xaaps1mzqEw7T9mOtMWZmy/Z7HN+d88=;
 b=lxjDRTQAkHHY9nBP0C0SIwUcSpPEriJn1JJS6TOMqs8zmaCJqiRr3+YPRcP05htxu6ta
 n6jpHZlNkZUcUyW/40Vclc5qqm7uZhKqr2S+rrFcyRb2hZTIEE7QCYM5JLtpkGxWJwl0
 q9A2GKBBiY/i3e0Lk849mdR6RtBnWfu0x/fRKCBlEdgMaVtG7uRDqlj6ULoypY22YE9+
 jHe/1rei4PoEUY9aVTQ1FlkjFMTMb1bP1o0sEohqG3WjD1vdalzyYF/SHYr0qDh+Q5xv
 OfUxquSuH6jZk5eVwhdr3oBnQgvmf+rnJYeKOoZN3SfYWtKlFyAYKB+KR2HDECaOFmUW Tg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg3f8week-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 23:09:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BGN94uD030902
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 23:09:04 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 15:09:04 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v5 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and QRU1000 pinctrl
Date:   Fri, 16 Dec 2022 15:08:51 -0800
Message-ID: <20221216230852.21691-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221216230852.21691-1-quic_molvera@quicinc.com>
References: <20221216230852.21691-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EopsATRhLxiXXR-ZjOiJSjPttSJfI705
X-Proofpoint-ORIG-GUID: EopsATRhLxiXXR-ZjOiJSjPttSJfI705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160205
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for QDU1000 and QRU1000 TLMM devices.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml   | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
new file mode 100644
index 000000000000..7e5fb9a6e7d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
+
+maintainers:
+  - Melody Olvera <quic_molvera@quicinc.com>
+
+description: |
+  Top Level Mode Multiplexer pin controller found in the QDU1000 and
+  QRU1000 SoCs.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,qdu1000-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+  interrupt-controller: true
+  "#interrupt-cells": true
+  gpio-controller: true
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 76
+
+  gpio-line-names:
+    maxItems: 151
+
+  "#gpio-cells": true
+  gpio-ranges: true
+  wakeup-parent: true
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-qdu1000-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-qdu1000-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-qdu1000-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|150)$"
+            - enum: [ sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ atest_char, atest_usb, char_exec, CMO_PRI, cmu_rng,
+                dbg_out_clk, ddr_bist, ddr_pxi1, ddr_pxi2, ddr_pxi3, ddr_pxi4,
+                ddr_pxi5, ddr_pxi6, ddr_pxi7, eth012_int_n, eth345_int_n,
+                gcc_gp1, gcc_gp2, gcc_gp3, gpio, gps_pps_in, hardsync_pps_in,
+                intr_c, jitter_bist_ref, pcie_clkreqn, phase_flag, pll_bist,
+                pll_clk, prng_rosc, qdss_cti, qdss_gpio, qlink0_enable,
+                qlink0_request, qlink0_wmss, qlink1_enable, qlink1_request,
+                qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss,
+                qlink3_enable, qlink3_request, qlink3_wmss, qlink4_enable,
+                qlink4_request, qlink4_wmss, qlink5_enable, qlink5_request,
+                qlink5_wmss, qlink6_enable, qlink6_request, qlink6_wmss,
+                qlink7_enable, qlink7_request, qlink7_wmss, qspi_clk, qspi_cs,
+                qspi0, qspi1, qspi2, qspi3, qup00, qup01, qup02, qup03, qup04,
+                qup05, qup06, qup07, qup08, qup10, qup11, qup12, qup13, qup14,
+                qup15, qup16, qup17, qup20, qup21, qup22, SI5518_INT, smb_alert,
+                smb_clk, smb_dat, tb_trig, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3,
+                tgu_ch4, tgu_ch5, tgu_ch6, tgu_ch7, tmess_prng0, tmess_prng1,
+                tmess_prng2, tmess_prng3, tod_pps_in, tsense_pwm1, tsense_pwm2,
+                usb2phy_ac, usb_con_det, usb_dfp_en, usb_phy, vfr_0, vfr_1,
+                vsense_trigger ]
+
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
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
+    pinctrl@f000000 {
+        compatible = "qcom,qdu1000-tlmm";
+        reg = <0xf000000 0x1000000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 151>;
+        wakeup-parent = <&pdc>;
+
+        uart0-default-state {
+            pins = "gpio6", "gpio7", "gpio8", "gpio9";
+            function = "qup00";
+        };
+    };
-- 
2.38.1

