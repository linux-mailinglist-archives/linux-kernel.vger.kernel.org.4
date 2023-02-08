Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BBD68F471
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjBHR0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBHR0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:26:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A8B4FCF6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:26:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ba1so13456117wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9JFREJcKJkYdP/88uPvjsxnj+T4bEHbknUKvEXZNqY=;
        b=WEHDYdfnJ8nDQFSNnJpgLbP+WnlJVKrnP8awHy99ZFytgDDz9IEE4eDjI1jzDgvdPT
         SAc2+33pRmjlQcRjW6L1gSjSPYIStI/Zm4DsfuG/XUurKLRflVfsEsXKzwedIJKkFYwc
         UTZjkt+Nx/qUZZHKwth7xsi2ggDBTAnyioEWgBFN2q46QP1tJsIZOnX/nc7ItYyuX75p
         HSHc0rVdQnc2niLr/DqNDXemLG2Ce2N7hF6maL7Jv8a87RSY36QhmVokSGBC/Elv2ISD
         k+2MTsNoZbVTvXyU+NkVEdR5janG7LKkb1O/lC7vP364/sVQRkJ+Y25COtefMInEZs5t
         3AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9JFREJcKJkYdP/88uPvjsxnj+T4bEHbknUKvEXZNqY=;
        b=DccUt2GwvG5bjygzX7xjOALTOUchXgdLcTHicWn3FdE1J7x0oo9Go3glB+taGmLmRA
         P3mMuNmj+eAlpp8UyguB/DfrplmTGy1Ed9zu8IDorHWkIjt2DjvYEUiRfJLsn9LiUlrD
         a8rO9sB+5t0wJ8aadDdqqknL4LakBJbYy4Dml0sGH3BUeFpJpN0GfT3xVS3UtjmeW8l8
         o5tMXz9Vu4fVXMEUqjWSzgC0e0FP8ZR/2Amni1WUwbePxe8+vVEtXm0LelZ7eqQbAWK1
         pAz2y8ootzcfiD6U4GpFJ+sYvXAz1CQam75rz67ZcMibfzvBKHAgVlm61vTNyz8SGdDV
         IxoA==
X-Gm-Message-State: AO0yUKWISUTHeCfFvdb4ksofOCAUYoSrUJghrB3TmqCRTnyM84IYiMsc
        S7iQUo4ZqbaL1wr6B6lCYr41IQ==
X-Google-Smtp-Source: AK7set+/MQIHsZkZpnlqjVXQQcXiPMd+TF5xhMDJ5SqQGvVcxZGnm+UnuqJtdd9W8QXuWNU901LRKg==
X-Received: by 2002:a5d:6102:0:b0:2bf:cfb4:2e1 with SMTP id v2-20020a5d6102000000b002bfcfb402e1mr7274198wrt.45.1675877156432;
        Wed, 08 Feb 2023 09:25:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c12-20020adffb4c000000b002b6bcc0b64dsm14039457wrs.4.2023.02.08.09.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:25:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: wlf,wm8994: Convert to dtschema
Date:   Wed,  8 Feb 2023 18:25:52 +0100
Message-Id: <20230208172552.404324-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Wolfson WM1811/WM8994/WM8958 audio codecs bindings to DT
schema.

Changes against original binding:
1. Add missing LDO1VDD-supply for WM1811.
2. Use "gpios" suffix for wlf,ldo1ena and wlf,ldo2ena (Linux kernel's
   gpiolib already looks for both variants).
3. Do not require AVDD1-supply and DCVDD-supply, because at least on
   Arndale board with Exynos5250 these are grounded.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/wlf,wm8994.yaml | 203 ++++++++++++++++++
 .../devicetree/bindings/sound/wm8994.txt      | 112 ----------
 2 files changed, 203 insertions(+), 112 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8994.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8994.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8994.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8994.yaml
new file mode 100644
index 000000000000..24eabca7c173
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8994.yaml
@@ -0,0 +1,203 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8994.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wolfson WM1811/WM8994/WM8958 audio codecs
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - patches@opensource.cirrus.com
+
+description: |
+  These devices support both I2C and SPI (configured with pin strapping on the
+  board).
+
+  Pins on the device (for linking into audio routes):
+  IN1LN, IN1LP, IN2LN, IN2LP:VXRN, IN1RN, IN1RP, IN2RN, IN2RP:VXRP, SPKOUTLP,
+  SPKOUTLN, SPKOUTRP, SPKOUTRN, HPOUT1L, HPOUT1R, HPOUT2P, HPOUT2N, LINEOUT1P,
+  LINEOUT1N, LINEOUT2P, LINEOUT2N.
+
+properties:
+  compatible:
+    enum:
+      - wlf,wm1811
+      - wlf,wm8994
+      - wlf,wm8958
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: MCLK1
+      - const: MCLK2
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the IRQ number. The second cell is the flags, encoded
+      as the trigger masks.
+
+  AVDD1-supply: true
+  AVDD2-supply: true
+  CPVDD-supply: true
+  DBVDD-supply: true
+  DBVDD1-supply: true
+  DBVDD2-supply: true
+  DBVDD3-supply: true
+  DCVDD-supply: true
+  LDO1VDD-supply: true
+  SPKVDD1-supply: true
+  SPKVDD2-supply: true
+
+  '#sound-dai-cells':
+    const: 0
+
+  wlf,gpio-cfg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 11
+    description:
+      A list of GPIO configuration register values. If absent, no configuration
+      of these registers is performed. If any value is over 0xffff then the
+      register will be left as default. If present 11 values must be supplied.
+
+  wlf,micbias-cfg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 2
+    description:
+      Two MICBIAS register values for WM1811 or WM8958.  If absent the register
+      defaults will be used.
+
+  wlf,ldo1ena-gpios:
+    maxItems: 1
+    description:
+      Control of LDO1ENA input to device.
+
+  wlf,ldo2ena-gpios:
+    maxItems: 1
+    description:
+      Control of LDO2ENA input to device.
+
+  wlf,lineout1-se:
+    type: boolean
+    description:
+      LINEOUT1 is in single ended mode.
+
+  wlf,lineout2-se:
+    type: boolean
+    description:
+      INEOUT2 is in single ended mode.
+
+  wlf,lineout1-feedback:
+    type: boolean
+    description:
+      LINEOUT1 has common mode feedback connected.
+
+  wlf,lineout2-feedback:
+    type: boolean
+    description:
+      LINEOUT2 has common mode feedback connected.
+
+  wlf,ldoena-always-driven:
+    type: boolean
+    description:
+      LDOENA is always driven.
+
+  wlf,spkmode-pu:
+    type: boolean
+    description:
+      Enable the internal pull-up resistor on the SPKMODE pin.
+
+  wlf,csnaddr-pd:
+    type: boolean
+    description:
+      Enable the internal pull-down resistor on the CS/ADDR pin.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - wlf,wm1811
+            - wlf,wm8958
+    then:
+      properties:
+        DBVDD-supply: false
+      required:
+        - CPVDD-supply
+        - DBVDD1-supply
+        - DBVDD2-supply
+        - DBVDD3-supply
+        - SPKVDD1-supply
+        - SPKVDD2-supply
+      anyOf:
+        - required:
+            - AVDD1-supply
+        - required:
+            - AVDD2-supply
+    else:
+      properties:
+        DBVDD1-supply: false
+        DBVDD2-supply: false
+        DBVDD3-supply: false
+      required:
+        - AVDD1-supply
+        - AVDD2-supply
+        - CPVDD-supply
+        - DBVDD-supply
+        - DCVDD-supply
+        - SPKVDD1-supply
+        - SPKVDD2-supply
+
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        audio-codec@1a {
+            compatible = "wlf,wm1811";
+            reg = <0x1a>;
+            clocks = <&i2s0 0>;
+            clock-names = "MCLK1";
+
+            AVDD2-supply = <&main_dc_reg>;
+            CPVDD-supply = <&main_dc_reg>;
+            DBVDD1-supply = <&main_dc_reg>;
+            DBVDD2-supply = <&main_dc_reg>;
+            DBVDD3-supply = <&main_dc_reg>;
+            LDO1VDD-supply = <&main_dc_reg>;
+            SPKVDD1-supply = <&main_dc_reg>;
+            SPKVDD2-supply = <&main_dc_reg>;
+
+            wlf,ldo1ena-gpios = <&gpb0 0 GPIO_ACTIVE_HIGH>;
+            wlf,ldo2ena-gpios = <&gpb0 1 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8994.txt b/Documentation/devicetree/bindings/sound/wm8994.txt
deleted file mode 100644
index 8fa947509c10..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8994.txt
+++ /dev/null
@@ -1,112 +0,0 @@
-WM1811/WM8994/WM8958 audio CODEC
-
-These devices support both I2C and SPI (configured with pin strapping
-on the board).
-
-Required properties:
-
-  - compatible : One of "wlf,wm1811", "wlf,wm8994" or "wlf,wm8958".
-
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
-  - gpio-controller : Indicates this device is a GPIO controller.
-  - #gpio-cells : Must be 2. The first cell is the pin number and the
-    second cell is used to specify optional parameters (currently unused).
-
-  - power supplies for the device, as covered in
-    Documentation/devicetree/bindings/regulator/regulator.txt, depending
-    on compatible:
-    - for wlf,wm1811 and wlf,wm8958:
-      AVDD1-supply, AVDD2-supply, DBVDD1-supply, DBVDD2-supply, DBVDD3-supply,
-      DCVDD-supply, CPVDD-supply, SPKVDD1-supply, SPKVDD2-supply
-    - for wlf,wm8994:
-      AVDD1-supply, AVDD2-supply, DBVDD-supply, DCVDD-supply, CPVDD-supply,
-      SPKVDD1-supply, SPKVDD2-supply
-
-Optional properties:
-
-  - interrupts : The interrupt line the IRQ signal for the device is
-    connected to.  This is optional, if it is not connected then none
-    of the interrupt related properties should be specified.
-  - interrupt-controller : These devices contain interrupt controllers
-    and may provide interrupt services to other devices if they have an
-    interrupt line connected.
-  - #interrupt-cells: the number of cells to describe an IRQ, this should be 2.
-    The first cell is the IRQ number.
-    The second cell is the flags, encoded as the trigger masks from
-    Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-  - clocks : A list of up to two phandle and clock specifier pairs
-  - clock-names : A list of clock names sorted in the same order as clocks.
-                  Valid clock names are "MCLK1" and "MCLK2".
-
-  - wlf,gpio-cfg : A list of GPIO configuration register values. If absent,
-    no configuration of these registers is performed. If any value is
-    over 0xffff then the register will be left as default. If present 11
-    values must be supplied.
-
-  - wlf,micbias-cfg : Two MICBIAS register values for WM1811 or
-    WM8958.  If absent the register defaults will be used.
-
-  - wlf,ldo1ena : GPIO specifier for control of LDO1ENA input to device.
-  - wlf,ldo2ena : GPIO specifier for control of LDO2ENA input to device.
-
-  - wlf,lineout1-se : If present LINEOUT1 is in single ended mode.
-  - wlf,lineout2-se : If present LINEOUT2 is in single ended mode.
-
-  - wlf,lineout1-feedback : If present LINEOUT1 has common mode feedback
-    connected.
-  - wlf,lineout2-feedback : If present LINEOUT2 has common mode feedback
-    connected.
-
-  - wlf,ldoena-always-driven : If present LDOENA is always driven.
-
-  - wlf,spkmode-pu : If present enable the internal pull-up resistor on
-    the SPKMODE pin.
-
-  - wlf,csnaddr-pd : If present enable the internal pull-down resistor on
-    the CS/ADDR pin.
-
-Pins on the device (for linking into audio routes):
-
-  * IN1LN
-  * IN1LP
-  * IN2LN
-  * IN2LP:VXRN
-  * IN1RN
-  * IN1RP
-  * IN2RN
-  * IN2RP:VXRP
-  * SPKOUTLP
-  * SPKOUTLN
-  * SPKOUTRP
-  * SPKOUTRN
-  * HPOUT1L
-  * HPOUT1R
-  * HPOUT2P
-  * HPOUT2N
-  * LINEOUT1P
-  * LINEOUT1N
-  * LINEOUT2P
-  * LINEOUT2N
-
-Example:
-
-wm8994: codec@1a {
-	compatible = "wlf,wm8994";
-	reg = <0x1a>;
-
-	gpio-controller;
-	#gpio-cells = <2>;
-
-	lineout1-se;
-
-	AVDD1-supply = <&regulator>;
-	AVDD2-supply = <&regulator>;
-	CPVDD-supply = <&regulator>;
-	DBVDD-supply = <&regulator>;
-	DCVDD-supply = <&regulator>;
-	SPKVDD1-supply = <&regulator>;
-	SPKVDD2-supply = <&regulator>;
-};
-- 
2.34.1

