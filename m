Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC68762FC67
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiKRSU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiKRSU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:20:57 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B584072139;
        Fri, 18 Nov 2022 10:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1668795656; x=1700331656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZ0L5qMp+P3X3Ql3wEzGSMJacYIriCBWvjOdKjV90QE=;
  b=EuA99BrUi1mxzMt6Apb/E2qaIIYrSYx0w04Cy/uXDE5zIbQj/Rbe3q2U
   qBtZM+iI2hHROVrYH/ic9fm+L1YHNGC6vbsBX/PQpdiXTN/IbROrhWiAp
   b63Wh444cK2acBnxH4NNTv7A7KnDgpUb+Bansp3kMfZ4rGnaF4fXUtE94
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Nov 2022 10:20:56 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:20:56 -0800
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 18 Nov 2022 10:20:55 -0800
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
Subject: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and QRU1000 pinctrl
Date:   Fri, 18 Nov 2022 10:20:38 -0800
Message-ID: <20221118182039.29236-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118182039.29236-1-quic_molvera@quicinc.com>
References: <20221118182039.29236-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
index 000000000000..cb0c496d8666
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
+  This Top Level Mode Multiplexer block (TLMM) is found in the QDU1000 and
+  QRU1000 platforms.
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
+    maxItems: 75
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

