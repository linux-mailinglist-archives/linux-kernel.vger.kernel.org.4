Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C8B6C5290
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCVRfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCVRfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:35:45 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F795D742;
        Wed, 22 Mar 2023 10:35:28 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso20186162fac.4;
        Wed, 22 Mar 2023 10:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2HJVH8NQ+L3dWGKI8LYvcw5V5SCoSUd4ykrUldCTjs=;
        b=xhemJMOkXTr+goFWBnSfPd/See3UVyiCNZXHC0Danu2zglO46cMU9mGfequtJwcdYB
         vSkRp33/X9KGtv32XkTp1NWQBJRsVcNQ0UPfWBXbXcu2L59qGYnp7IKRNdgM8LvkDQD1
         K7fnhv4kd/bYw70QcVpDcxP0OoJa7ebGQBp/fBaTR6nFe0Re54Sevpf0AhWWseVJ4ktU
         K65sAJ9QuDctNVIKmYG8o4zAD7KkeXMsGf3g4R10IXp4GFydUz/N9Zq7TC2mwBYLM+US
         rL92JAeb4tHqXkzM+WM0delMMStMW36rZQRhNxjFQGk+OZ109DQvlDen1tLulISgKCX5
         JPLQ==
X-Gm-Message-State: AO0yUKVBStNOpn9snRDUTwjoNeiFlLOAixXJyyAO3MGx/scLrYYTXNXq
        mcu0i748h5oQUpk6lhnOZg==
X-Google-Smtp-Source: AKy350aKehpe9mY2uKLG/NzguWjKAjUqLy10Rh6whZ8YLNa80OaxPFU52LxNUS4WyXi4QUqD01tEBw==
X-Received: by 2002:a05:6870:392c:b0:177:dfdb:72 with SMTP id b44-20020a056870392c00b00177dfdb0072mr406238oap.9.1679506527672;
        Wed, 22 Mar 2023 10:35:27 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id tk6-20020a05687189c600b0017703cd8ff6sm5379227oab.7.2023.03.22.10.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:35:27 -0700 (PDT)
Received: (nullmailer pid 3971630 invoked by uid 1000);
        Wed, 22 Mar 2023 17:35:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] dt-bindings: mfd: Drop unneeded quotes
Date:   Wed, 22 Mar 2023 12:35:18 -0500
Message-Id: <20230322173519.3971434-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/canaan,k210-sysctl.yaml      |  6 ++---
 .../bindings/mfd/google,cros-ec.yaml          | 22 +++++++++----------
 .../mfd/hisilicon,hi6421-spmi-pmic.yaml       |  2 +-
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  2 +-
 .../bindings/mfd/rohm,bd71815-pmic.yaml       |  2 +-
 .../bindings/mfd/rohm,bd71828-pmic.yaml       |  2 +-
 .../devicetree/bindings/mfd/wlf,arizona.yaml  |  2 +-
 .../bindings/mfd/x-powers,ac100.yaml          |  4 ++--
 .../bindings/mfd/xylon,logicvc.yaml           |  4 ++--
 9 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml b/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
index e2046f07a40e..8459d3642205 100644
--- a/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
@@ -36,7 +36,7 @@ properties:
   clock-controller:
     # Child node
     type: object
-    $ref: "../clock/canaan,k210-clk.yaml"
+    $ref: ../clock/canaan,k210-clk.yaml
     description:
       Clock controller for the SoC clocks. This child node definition
       should follow the bindings specified in
@@ -45,7 +45,7 @@ properties:
   reset-controller:
     # Child node
     type: object
-    $ref: "../reset/canaan,k210-rst.yaml"
+    $ref: ../reset/canaan,k210-rst.yaml
     description:
       Reset controller for the SoC. This child node definition
       should follow the bindings specified in
@@ -54,7 +54,7 @@ properties:
   syscon-reboot:
     # Child node
     type: object
-    $ref: "../power/reset/syscon-reboot.yaml"
+    $ref: ../power/reset/syscon-reboot.yaml
     description:
       Reboot method for the SoC. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index cdf1d719efe9..456465e35114 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -65,7 +65,7 @@ properties:
       ARM Cortex M4 Co-processor. Contains the name of the rpmsg
       device. Used to match the subnode to the rpmsg device announced by
       the SCP.
-    $ref: "/schemas/types.yaml#/definitions/string"
+    $ref: /schemas/types.yaml#/definitions/string
 
   spi-max-frequency: true
 
@@ -94,23 +94,23 @@ properties:
     const: 0
 
   typec:
-    $ref: "/schemas/chrome/google,cros-ec-typec.yaml#"
+    $ref: /schemas/chrome/google,cros-ec-typec.yaml#
 
   ec-pwm:
-    $ref: "/schemas/pwm/google,cros-ec-pwm.yaml#"
+    $ref: /schemas/pwm/google,cros-ec-pwm.yaml#
     deprecated: true
 
   pwm:
-    $ref: "/schemas/pwm/google,cros-ec-pwm.yaml#"
+    $ref: /schemas/pwm/google,cros-ec-pwm.yaml#
 
   kbd-led-backlight:
-    $ref: "/schemas/chrome/google,cros-kbd-led-backlight.yaml#"
+    $ref: /schemas/chrome/google,cros-kbd-led-backlight.yaml#
 
   keyboard-controller:
-    $ref: "/schemas/input/google,cros-ec-keyb.yaml#"
+    $ref: /schemas/input/google,cros-ec-keyb.yaml#
 
   proximity:
-    $ref: "/schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#"
+    $ref: /schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#
 
   codecs:
     type: object
@@ -126,7 +126,7 @@ properties:
     patternProperties:
       "^ec-codec@[a-f0-9]+$":
         type: object
-        $ref: "/schemas/sound/google,cros-ec-codec.yaml#"
+        $ref: /schemas/sound/google,cros-ec-codec.yaml#
 
     required:
       - "#address-cells"
@@ -151,15 +151,15 @@ properties:
 patternProperties:
   "^i2c-tunnel[0-9]*$":
     type: object
-    $ref: "/schemas/i2c/google,cros-ec-i2c-tunnel.yaml#"
+    $ref: /schemas/i2c/google,cros-ec-i2c-tunnel.yaml#
 
   "^regulator@[0-9]+$":
     type: object
-    $ref: "/schemas/regulator/google,cros-ec-regulator.yaml#"
+    $ref: /schemas/regulator/google,cros-ec-regulator.yaml#
 
   "^extcon[0-9]*$":
     type: object
-    $ref: "/schemas/extcon/extcon-usbc-cros-ec.yaml#"
+    $ref: /schemas/extcon/extcon-usbc-cros-ec.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
index 22edcb4b212f..bdff5b653453 100644
--- a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
@@ -53,7 +53,7 @@ properties:
       '^ldo[0-9]+$':
         type: object
 
-        $ref: "/schemas/regulator/regulator.yaml#"
+        $ref: /schemas/regulator/regulator.yaml#
 
         unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
index 9acad9d326eb..9c51c1b19067 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
@@ -49,7 +49,7 @@ patternProperties:
 
   "rtc@[0-9a-f]+$":
     type: object
-    $ref: "../rtc/qcom-pm8xxx-rtc.yaml"
+    $ref: ../rtc/qcom-pm8xxx-rtc.yaml
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
index d6d120a78094..05747e012516 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
@@ -46,7 +46,7 @@ properties:
 
   rohm,clkout-open-drain:
     description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmos".
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 1
 
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
index ec3adcd3483d..11089aa89ec6 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
@@ -46,7 +46,7 @@ properties:
 
   rohm,clkout-open-drain:
     description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmos".
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 1
 
diff --git a/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml b/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
index ea3337dafaf5..7902f3c5d289 100644
--- a/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
+++ b/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
@@ -156,7 +156,7 @@ properties:
       entry has a value that is out of range for a 16 bit register then the
       chip default will be used. If present exactly five values must be
       specified.
-    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 1
     maxItems: 5
 
diff --git a/Documentation/devicetree/bindings/mfd/x-powers,ac100.yaml b/Documentation/devicetree/bindings/mfd/x-powers,ac100.yaml
index 309606d2d806..f3d8394b27e7 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,ac100.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,ac100.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/mfd/x-powers,ac100.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/mfd/x-powers,ac100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: X-Powers AC100
 
diff --git a/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml b/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
index 9efd49c39bd2..6e880a46d7ee 100644
--- a/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
+++ b/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 Bootlin
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/mfd/xylon,logicvc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/mfd/xylon,logicvc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Xylon LogiCVC multi-function device
 
-- 
2.39.2

