Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8986E700811
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241183AbjELMad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbjELM36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:29:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D221FDA;
        Fri, 12 May 2023 05:29:26 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C5eUj9031128;
        Fri, 12 May 2023 07:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=rYOv87YfO3csmgu3kUayX9fW+H2LxBm/K9Acaqpzo3s=;
 b=l8zhx9lBRMlhYLMkyjv5GKGQAZcENksM+BXK8s+y6hLWGo6J00vK9bjb8EuLcjj46xDy
 +EO0iJ3wzUwi7xVqG3q490T7+wMVB95kGoOHSK+/GB/oBDh8hvMcvnNkIqfuer5vQevz
 m+kvk1c82tXacGrDaGxGpocjZaRln1sUOEGNCllTJHCs7GnSfURLWyc/tljnhniS0A3q
 7W0O074b3DCKMJzr7S2j67nEXwqaCLkU8IsQAlXXkCbmyokod8uP5KPhcaWC9k5n/BqM
 lfLYE/7rrhhHEc+LCcNneIe6ZnMvhppraF7qG6ZexZ6E7A6FOPEnBrjVB0kzuuzJB8kv +A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7s46b2x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 07:28:41 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 12 May
 2023 07:28:38 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 07:28:38 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8CFD011A8;
        Fri, 12 May 2023 12:28:38 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>
CC:     <lgirdwood@gmail.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/10] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
Date:   Fri, 12 May 2023 13:28:33 +0100
Message-ID: <20230512122838.243002-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FVIHSa9D22LNTL41FIv7qSndA1i2SjHf
X-Proofpoint-GUID: FVIHSa9D22LNTL41FIv7qSndA1i2SjHf
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
(Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
for portable applications. It provides a high dynamic range, stereo
DAC for headphone output, two integrated Class D amplifiers for
loudspeakers, and two ADCs for wired headset microphone input or
stereo line input. PDM inputs are provided for digital microphones.

Add a YAML DT binding document for this device.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 .../bindings/mfd/cirrus,cs42l43.yaml          | 212 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,cs42l43.yaml

diff --git a/Documentation/devicetree/bindings/mfd/cirrus,cs42l43.yaml b/Documentation/devicetree/bindings/mfd/cirrus,cs42l43.yaml
new file mode 100644
index 0000000000000..e1fd70e0a3467
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/cirrus,cs42l43.yaml
@@ -0,0 +1,212 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/cirrus,cs42l43.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS42L43 Audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
+  (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
+  for portable applications. It provides a high dynamic range, stereo
+  DAC for headphone output, two integrated Class D amplifiers for
+  loudspeakers, and two ADCs for wired headset microphone input or
+  stereo line input. PDM inputs are provided for digital microphones.
+
+required:
+  - compatible
+  - reg
+  - VDD_P-supply
+  - VDD_A-supply
+  - VDD_D-supply
+  - VDD_IO-supply
+  - VDD_CP-supply
+
+additionalProperties: false
+
+properties:
+  compatible:
+    enum:
+      - cirrus,cs42l43
+
+  reg:
+    maxItems: 1
+
+  VDD_P-supply:
+    description:
+      Power supply for the high voltage interface.
+
+  VDD_A-supply:
+    description:
+      Power supply for internal analog circuits.
+
+  VDD_D-supply:
+    description:
+      Power supply for internal digital circuits.
+
+  VDD_IO-supply:
+    description:
+      Power supply for external interface and internal digital logic.
+
+  VDD_CP-supply:
+    description:
+      Power supply for the amplifier 3 and 4 charge pump.
+
+  VDD_AMP-supply:
+    description:
+      Power supply for amplifier 1 and 2.
+
+  reset-gpios:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-ranges:
+    items:
+      - description: A phandle to the CODEC pinctrl node
+        minimum: 0
+      - const: 0
+      - const: 0
+      - const: 3
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 1
+
+  clocks:
+    items:
+      - description: Synchronous audio clock provided on mclk_in.
+
+  clock-names:
+    const: mclk
+
+  pinctrl:
+    type: object
+
+    allOf:
+      - $ref: "../pinctrl/pinctrl.yaml#"
+
+    properties:
+      pin-settings:
+        type: object
+
+        additionalProperties: false
+
+        patternProperties:
+          '-pins$':
+            type: object
+
+            allOf:
+              - $ref: "../pinctrl/pincfg-node.yaml#"
+              - $ref: "../pinctrl/pinmux-node.yaml#"
+
+            oneOf:
+              - required: [ groups ]
+              - required: [ pins ]
+
+            unevaluatedProperties: false
+
+            properties:
+              groups:
+                enum: [ gpio1, gpio2, gpio3, asp, pdmout2, pdmout1, i2c, spi ]
+
+              pins:
+                enum: [ gpio1, gpio2, gpio3,
+                        asp_dout, asp_fsync, asp_bclk,
+                        pdmout2_clk, pdmout2_data, pdmout1_clk, pdmout1_data,
+                        i2c_sda, i2c_scl,
+                        spi_miso, spi_sck, spi_ssb ]
+
+              function:
+                enum: [ gpio, spdif, irq, mic-shutter, spk-shutter ]
+
+              drive-strength:
+                description: Set drive strength in mA
+                enum: [ 1, 2, 4, 8, 9, 10, 12, 16 ]
+
+              input-debounce:
+                description: Set input debounce in uS
+                enum: [ 0, 85 ]
+
+  spi:
+    type: object
+
+    allOf:
+      - $ref: "../spi/spi-controller.yaml#"
+
+    unevaluatedProperties: false
+
+examples:
+  - |
+    i2c@e0004000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0xe0004000 0x1000>;
+
+        cs42l43: codec@1a {
+            compatible = "cirrus,cs42l43";
+            reg = <0x1a>;
+
+            VDD_P-supply = <&vdd5v0>;
+            VDD_D-supply = <&vdd1v8>;
+            VDD_A-supply = <&vdd1v8>;
+            VDD_IO-supply = <&vdd1v8>;
+            VDD_CP-supply = <&vdd1v8>;
+            VDD_AMP-supply = <&vdd5v0>;
+
+            reset-gpios = <&gpio 0>;
+
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-ranges = <&cs42l43_pins 0 0 3>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupt-parent = <&gpio>;
+            interrupts = <56 8>;
+
+            #sound-dai-cells = <1>;
+
+            clocks = <&clks 0>;
+            clock-names = "mclk";
+
+            cs42l43_pins: pinctrl {
+                pinctrl-names = "default";
+                pinctrl-0 = <&pinsettings>;
+
+                pinsettings: pin-settings {
+                    shutter-pins {
+                        groups = "gpio3";
+                        function = "mic-shutter";
+                    };
+                };
+            };
+
+            spi {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                cs-gpios = <&cs42l43 1 0>;
+
+                sensor@0 {
+                    compatible = "bosch,bme680";
+                    reg = <0>;
+                    spi-max-frequency = <1400000>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e5..0db9f37eec258 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4926,6 +4926,7 @@ M:	Richard Fitzgerald <rf@opensource.cirrus.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	patches@opensource.cirrus.com
 S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/cirrus,cs*
 F:	Documentation/devicetree/bindings/sound/cirrus,cs*
 F:	include/dt-bindings/sound/cs*
 F:	include/sound/cs*
-- 
2.30.2

