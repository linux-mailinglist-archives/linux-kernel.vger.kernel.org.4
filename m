Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3DC5F6402
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiJFJ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiJFJ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:58:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053C889821
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:58:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso2482929wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=aYkfRfGGG33NVlFWLnEwqVw3+p9JgyEArCSm1tnJcu4=;
        b=ra++jUyBiLyiJTtqLECW8xOyUdOgbQZvfjZlbSDvGGTISwHuU+dBg1ETnyhRQZHqNh
         5W1lUbgJffPw0xIPvATxsEETu5EllRTwIcvgnAzAaRMqBCASrTRheDfhtQ5W2+1RbU3G
         F6hSl1cgwlMK5Sqib4GD+yH10l8hwaOQnli7cqbBfoKs0vOVuEETQwQtVaw5mTtpuJGT
         Wq4B1J/JbYSmywuo3LPXNhjdSKsT3pCG9k2WzJ3liRK2yKJYkI1nVp9Z22Ya+T77rMeH
         wCMW3T381gzYn4TgvNgyd6umDYFbPEPGKvofFKXfoeh6pfF0135CFYKfXUGBaPsbOAbF
         84XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aYkfRfGGG33NVlFWLnEwqVw3+p9JgyEArCSm1tnJcu4=;
        b=rV3JuEDGCHag68ABErJg60W+OVSnUL33EW5iJnuc0qGUE2b/Omo9KLak9z7xQZZbIJ
         iSe2IQvgZTZfjgtPcDB9ue9HaRMk1Jc7qUAq9D4sn6mXErkakOQ6e/YKtELQORXlqnn0
         rxv5ylwrH+mwVctuRRnkmn5ngnqOcxdAjfhmCaBFzWTykt+WKliDCH6VOfjuWeiHKNxy
         NlZ7gb2nIlXso/6BTELBW6fy+wSeZM1BBKHxDOphZojvbOVye4oF0R46dgrEAwPKnhkl
         zP3TJ3cgsjqYXR01IddybsW/H3YrYSq7dEohZJEzAEKhWe+zB3F9r01Tz2aUUHJtb6Qi
         LYYA==
X-Gm-Message-State: ACrzQf3lxxQGzUwjN6Yk8dXPy7h+S001eagFnGUDjChC80+3JusnAxZ+
        pJSIVlCpGqbybp34NK4fLdskmQ==
X-Google-Smtp-Source: AMsMyM5ZUjwMExsCBFvRLtOpcK6fRw2Am1EccgV7JlH9hWAgoX+9rIGoGBTui6iHlt9jnOe4Mh2MOw==
X-Received: by 2002:a05:600c:3843:b0:3b4:f86b:e0a4 with SMTP id s3-20020a05600c384300b003b4f86be0a4mr2477743wmr.195.1665050281431;
        Thu, 06 Oct 2022 02:58:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b0022ac672654dsm17935603wre.58.2022.10.06.02.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 02:58:00 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 06 Oct 2022 09:57:58 +0000
Subject: [PATCH 1/6] dt-bindings: pinctrl: convert qcom,mdm9615-pinctrl.txt to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-pinctrl-yaml-v1-1-0cbc006e2a30@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MDM9515 pinctrl bindings to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ---------------------
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 101 +++++++++++++
 2 files changed, 101 insertions(+), 161 deletions(-)

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
index 000000000000..6a5966fc0098
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
@@ -0,0 +1,101 @@
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
+description: |
+  This binding describes the Top Level Mode Multiplexer block found in the
+  MDM9615 platform.
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
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
+  '-state$':
+    oneOf:
+      - $ref: "#/$defs/qcom-mdm9615-pinctrl-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-mdm9615-pinctrl-state"
+
+'$defs':
+  qcom-mdm9615-pinctrl-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-7][0-9]|8[0-7])$"
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
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+        tlmm: pinctrl@1000000 {
+          compatible = "qcom,mdm9615-pinctrl";
+          reg = <0x01000000 0x300000>;
+          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+          gpio-controller;
+          gpio-ranges = <&msmgpio 0 0 88>;
+          #gpio-cells = <2>;
+          interrupt-controller;
+          #interrupt-cells = <2>;
+        };

-- 
b4 0.10.1
