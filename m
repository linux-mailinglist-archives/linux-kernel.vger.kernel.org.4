Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763EE6230AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiKIQz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKIQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:55:03 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836922316D;
        Wed,  9 Nov 2022 08:53:57 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EDNjQ027347;
        Wed, 9 Nov 2022 10:53:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=fN0zW4Rl3sUJbDXHFHW7XlWiF0bZFHQc8IMVz5ltwaQ=;
 b=bsRyIi+Oo0NcYr6kexzqQk1ecx8P7He+JFIeKDyUIixgLgmMXeZV06mWAfwf5VAzESKy
 aqvRTeWngdZ9jIIEKZoD8vLcZBwcAqkQHd1PJ1BM8DuWgmvGp5JHMZEXLsDczXMgUU5s
 UJw3ycStSlV6a8KqOMuTf855EZL4NJhZluVVwKWRs3z/18QyGwZK3Wgja5QhSAoeuD5Z
 zHR1Qj0JE0eCUp5YGrPpyv/+xOfoWLN3iiA+cfRFYK3CQGdb3jRkMrhYWwdzBGtwmPm4
 nQdpGUg5TtoPfI3df4E37neydloMo/S0vPnkoVBLevkC0iATLnlWuPVpEnAyiDx+lUtI rw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pde7v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:53:34 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 9 Nov
 2022 10:53:32 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Wed, 9 Nov 2022 10:53:32 -0600
Received: from debianA11184.ad.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1DD87B06;
        Wed,  9 Nov 2022 16:53:32 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 01/12] dt-bindings: mfd: Add Cirrus Logic CS48L32 audio codec
Date:   Wed, 9 Nov 2022 16:53:20 +0000
Message-ID: <20221109165331.29332-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109165331.29332-1-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1tRRsN5me2kxuKVQN6G2wOaLmMkAzOi0
X-Proofpoint-GUID: 1tRRsN5me2kxuKVQN6G2wOaLmMkAzOi0
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS48L32 has multiple digital and analog audio I/O, a
high-performance low-power programmable audio DSP, and a variety of
power-efficient fixed-function audio processors, with digital
mixing and routing.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 .../bindings/mfd/cirrus,cs48l32.yaml          | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml

diff --git a/Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml b/Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
new file mode 100644
index 000000000000..d128600c0b72
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/cirrus,cs48l32.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS48L32 audio CODECs Multi-Functional Device
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  The CS48L32 is an audio SoC with extensive digital capabilities
+  and a range of digital and analogue I/O.
+
+  See also the child driver bindings in:
+
+    bindings/pinctrl/cirrus,cs48l32.yaml
+    bindings/regulator/wlf,arizona.yaml
+    bindings/sound/cirrus,cs48l32.yaml
+
+allOf:
+  - $ref: /schemas/pinctrl/cirrus,cs48l32.yaml#
+  - $ref: /schemas/regulator/wlf,arizona.yaml#
+  - $ref: /schemas/sound/cirrus,cs48l32.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - cirrus,cs48l31
+      - cirrus,cs48l32
+      - cirrus,cs48l33
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    description:
+      The first cell is the pin number. The second cell is reserved for
+      future use and must be zero
+    const: 2
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    description:
+      The first cell is the IRQ number.
+      The second cell is the flags, encoded as the trigger masks from
+      bindings/interrupt-controller/interrupts.txt
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      One entry specifying the GPIO controlling /RESET.  As defined in
+      bindings/gpio.txt.  Although optional, it is strongly recommended
+      to use a hardware reset.
+    maxItems: 1
+
+  clocks:
+    description:
+      Should reference the clocks supplied on MCLK1
+    minItems: 1
+    maxItems: 1
+
+  clock-names:
+    description: |
+      Must be "mclk1"
+    const: mclk1
+
+  VDD_A-supply:
+    description:
+      Analogue power supply.
+
+  VDD_D-supply:
+    description:
+      Digital core power supply.
+
+  VDD_IO-supply:
+    description:
+      Digital buffer (I/O) supply.
+
+  VDD_CP-supply:
+    description:
+      Charge pump power supply.
+
+  VOUT_MIC-supply:
+    description:
+      Microphone power supply, normally supplied internally.
+
+  pinctrl-0:
+    description:
+      A phandle to the node containing the subnodes containing pinctrl
+      configurations.
+
+  pinctrl-1:
+    description:
+      A phandle to the node containing the subnodes containing pinctrl
+      configurations.
+
+  pinctrl-names:
+      items:
+      - const: init
+      - const: default
+
+required:
+  - compatible
+  - interrupt-parent
+  - interrupts
+  - VDD_A-supply
+  - VDD_D-supply
+  - VDD_IO-supply
+  - VDD_CP-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/cs48l32.h>
+    &spi1 {
+        cs48l32: cs48l32@1 {
+            compatible = "cirrus,cs48l32";
+            reg = <0x1>;
+
+            spi-max-frequency = <25000000>;
+
+            interrupts = <56 8>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupt-parent = <&gpio0>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            #sound-dai-cells = <1>;
+
+            VDD_A-supply = <&regulator_1v8>;
+            VDD_D-supply = <&lochnagar_1v2>;
+            VDD_IO-supply = <&regulator_1v8>;
+            VDD_CP-supply = <&regulator_1v8>;
+
+            reset-gpios = <&gpio 0 0>;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&cs48l32_defaults>;
+
+            cs48l32_pinctrl: pinctrl {
+                compatible = "cirrus,cs48l32-pinctrl";
+
+                cs48l32_defaults: defaults {
+                    asp1 {
+                        groups = "asp1";
+                        function = "asp1";
+                        bias-bus-hold;
+                    };
+                    asp2 {
+                        groups = "asp2";
+                        function = "asp2";
+                        bias-bus-hold;
+                    };
+                };
+            };
+        };
-- 
2.30.2

