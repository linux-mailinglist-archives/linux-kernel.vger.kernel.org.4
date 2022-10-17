Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEF4600C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJQKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJQKXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:23:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A3F5FDEA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:23:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bp11so17722480wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BtCteD54q02kgUkMkj2OAC+PDkYwPzaE7W/pW2qQxs=;
        b=dAaFQ8MmIj1mfftRn85kI1Q3UM+UcI9CdXnNOaS2QeJCFzWf2UxzefLcCo+UhC3YWL
         WiAhVTEQC2unmT6AJp663ECO4dkEISWkrz33zUnpLotiJKeUkSOk7lsEmWU/QuF/yc66
         Im6qqKpiDh2c58jZp76TnILCsv61o9ifH3xGVs3K78SGQDSN5ZGSRq0KY0R4HyR02xYC
         QFtPm2gmwr7hPvxr2TMPfwAJcIN1qHSpkGaA4zVuUgq4K0JoAz7uDlyCtYmA2HXgAZSj
         5usxkYO2bGWWWj9sRjKFpkKWu2p6Mk1+rS8800SkzzJwcdWimT9pdX2MEW1iiEuYqaOT
         9tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BtCteD54q02kgUkMkj2OAC+PDkYwPzaE7W/pW2qQxs=;
        b=hQs8PRSmm0D1VFz/chxwnyEDLyagc8h9NxN5ExuvYOEvfJcSJ/Jc9h07Rjt52Xx4K2
         WidEa9iK06orezS1Z7iQ+kCc4XGtAubsFBupxEwT9Pb1FyhEs9VETbWzagQseLLE2zLz
         cDyxIIYvatQwxoja++Qlrlm9+2rraF8/+ygCe/8P6VNcHLwXTUBqoP3kPxUOVIS0/pYE
         wIWdm+mk/6YAhUe89Ah7SY0vniT6EvFeJyfwryJcvB6QMgMZ2wZOZSo/XtwKZoAHs4Xv
         zesKYAYNnBkVVU9qRQoDZ51xrljvpbBwc2ldTAx5fE1EcN91JD7wdFZVF0iuxvFl2KaA
         BORA==
X-Gm-Message-State: ACrzQf1otXRXNGb6D2Fdg7pIyPnPiG8rPKkfUwcTs4uddi70O4UnIySg
        h44r4T6ekpgCFbPOhHaPQFNhhg==
X-Google-Smtp-Source: AMsMyM5wgwpm9McR2B2qeS/Q6AZZTiAotClK7y2ZgtebZYU5yvFANNlfloXRllnAVKNZFDL37ScBag==
X-Received: by 2002:a5d:4150:0:b0:22f:f9f6:cca1 with SMTP id c16-20020a5d4150000000b0022ff9f6cca1mr5974819wrq.510.1666002191072;
        Mon, 17 Oct 2022 03:23:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003b4fe03c881sm15590707wmq.48.2022.10.17.03.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 03:23:10 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 17 Oct 2022 12:23:05 +0200
Subject: [PATCH v2 1/5] dt-bindings: pinctrl: convert qcom,mdm9615-pinctrl.txt to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-pinctrl-yaml-v2-1-639fe67a04be@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MDM9515 pinctrl bindings to dt-schema.
Keep the parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, optional children with '-pins').

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ---------------------
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 120 +++++++++++++++
 2 files changed, 120 insertions(+), 161 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.txt
deleted file mode 100644
index d46973968873..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.txt
+++ /dev/null
@@ -1,161 +0,0 @@
-Qualcomm MDM9615 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-MDM9615 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,mdm9615-pinctrl"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the base address and size of the TLMM register space.
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should specify the TLMM summary IRQ.
-
-- interrupt-controller:
-	Usage: required
-	Value type: <none>
-	Definition: identifies this node as an interrupt controller
-
-- #interrupt-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 2. Specifying the pin number and flags, as defined
-		    in <dt-bindings/interrupt-controller/irq.h>
-
-- gpio-controller:
-	Usage: required
-	Value type: <none>
-	Definition: identifies this node as a gpio controller
-
-- #gpio-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 2. Specifying the pin number and flags, as defined
-		    in <dt-bindings/gpio/gpio.h>
-
-- gpio-ranges:
-	Usage: required
-	Definition:  see ../gpio/gpio.txt
-
-- gpio-reserved-ranges:
-	Usage: optional
-	Definition: see ../gpio/gpio.txt
-
-Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
-a general description of GPIO and interrupt bindings.
-
-Please refer to pinctrl-bindings.txt in this directory for details of the
-common pinctrl bindings used by client devices, including the meaning of the
-phrase "pin configuration node".
-
-The pin configuration nodes act as a container for an arbitrary number of
-subnodes. Each of these subnodes represents some desired configuration for a
-pin, a group, or a list of pins or groups. This configuration can include the
-mux function to select on those pin(s)/group(s), and various pin configuration
-parameters, such as pull-up, drive strength, etc.
-
-
-PIN CONFIGURATION NODES:
-
-The name of each subnode is not important; all subnodes should be enumerated
-and processed purely based on their content.
-
-Each subnode only affects those parameters that are explicitly listed. In
-other words, a subnode that lists a mux function but no pin configuration
-parameters implies no information about any pin configuration parameters.
-Similarly, a pin subnode that describes a pullup parameter implies no
-information about e.g. the mux function.
-
-
-The following generic properties as defined in pinctrl-bindings.txt are valid
-to specify in a pin configuration subnode:
-
-- pins:
-	Usage: required
-	Value type: <string-array>
-	Definition: List of gpio pins affected by the properties specified in
-		    this subnode.  Valid pins are:
-		    gpio0-gpio87
-
-- function:
-	Usage: required
-	Value type: <string>
-	Definition: Specify the alternative function to be configured for the
-		    specified pins.
-		    Valid values are:
-		    gpio, gsbi2_i2c, gsbi3, gsbi4, gsbi5_i2c, gsbi5_uart,
-		    sdc2, ebi2_lcdc, ps_hold, prim_audio, sec_audio,
-		    cdc_mclk
-
-- bias-disable:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins should be configured as no pull.
-
-- bias-pull-down:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins should be configured as pull down.
-
-- bias-pull-up:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins should be configured as pull up.
-
-- output-high:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins are configured in output mode, driven
-		    high.
-
-- output-low:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins are configured in output mode, driven
-		    low.
-
-- drive-strength:
-	Usage: optional
-	Value type: <u32>
-	Definition: Selects the drive strength for the specified pins, in mA.
-		    Valid values are: 2, 4, 6, 8, 10, 12, 14 and 16
-
-Example:
-
-	msmgpio: pinctrl@800000 {
-		compatible = "qcom,mdm9615-pinctrl";
-		reg = <0x800000 0x4000>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&msmgpio 0 0 88>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <0 16 0x4>;
-
-		gsbi8_uart: gsbi8-uart {
-			mux {
-				pins = "gpio34", "gpio35";
-				function = "gsbi8";
-			};
-
-			tx {
-				pins = "gpio34";
-				drive-strength = <4>;
-				bias-disable;
-			};
-
-			rx {
-				pins = "gpio35";
-				drive-strength = <2>;
-				bias-pull-up;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
new file mode 100644
index 000000000000..69a8549beef6
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,mdm9615-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. MDM9615 TLMM block
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description: Top Level Mode Multiplexer pin controller in Qualcomm MDM9615 SoC.
+
+$ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,mdm9615-pinctrl
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+  interrupt-controller: true
+  '#interrupt-cells': true
+  gpio-controller: true
+  '#gpio-cells': true
+  gpio-ranges: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-mdm9615-pinctrl-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-mdm9615-pinctrl-state"
+        additionalProperties: false
+
+$defs:
+  qcom-mdm9615-pinctrl-state:
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
+          pattern: "^gpio([0-9]|[1-7][0-9]|8[0-7])$"
+        minItems: 1
+        maxItems: 16
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, gsbi2_i2c, gsbi3, gsbi4, gsbi5_i2c, gsbi5_uart,
+                sdc2, ebi2_lcdc, ps_hold, prim_audio, sec_audio, cdc_mclk, ]
+
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      drive-strength: true
+      output-high: true
+      output-low: true
+      input-enable: true
+
+    required:
+      - pins
+      - function
+
+    additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@1000000 {
+      compatible = "qcom,mdm9615-pinctrl";
+      reg = <0x01000000 0x300000>;
+      interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+      gpio-controller;
+      gpio-ranges = <&msmgpio 0 0 88>;
+      #gpio-cells = <2>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+
+      gsbi3-state {
+        pins = "gpio8", "gpio9", "gpio10", "gpio11";
+        function = "gsbi3";
+        drive-strength = <8>;
+        bias-disable;
+      };
+
+      gsbi5-i2c-state {
+        sda-pins {
+          pins = "gpio16";
+          function = "gsbi5_i2c";
+          drive-strength = <8>;
+          bias-disable;
+        };
+
+        scl-pins {
+          pins = "gpio17";
+          function = "gsbi5_i2c";
+          drive-strength = <2>;
+          bias-disable;
+        };
+      };
+    };

-- 
b4 0.10.1
