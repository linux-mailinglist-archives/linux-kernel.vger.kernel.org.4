Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5856C2610
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCTXuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCTXuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:50:02 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A02D5E;
        Mon, 20 Mar 2023 16:49:21 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s8so83939ois.2;
        Mon, 20 Mar 2023 16:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679356047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09zhwGZdslyyy0wEVjKWFObTfJyiv32GzYkmakn90gk=;
        b=MA/T70/CCgY7qQ/VDG+SBiDLHMmSuHrL4gVP3joV7QRe0tFBI/oVCJhj9xkn2Fc/Ec
         2CWRscpjLn07BQGtFUUimQr1vpCOOrorwY5sq2KRbiGZtoKfcgPcpHH1MzfHV7y0/CX0
         DlE8PHV+iu6FuxG8qSs0bIShrfNln9pajG694+35xr9CHBWh6bvYiHPcE5HCWxdoqBbq
         cb0/yKHBvslt2Ig1/+juny1QWV4X43CaNBM4G2UVy3BraJ0gc84TD3TGpIUHRVPBadAk
         +Q2SH/+u73pZebLad6Ep0sXVpHk/NhEBf2J4NXC45mk7fO0I+zyVLskf2VIwx/TwDwal
         KPvQ==
X-Gm-Message-State: AO0yUKVHhjmtYKN62BfSuC2mvJB3REKjweCncGSuyOGzR5VS+qeXnLDj
        pFxYy/XQaEr3h5at7xDB3Q==
X-Google-Smtp-Source: AK7set9WTfaJXM41TJy22yCuZh1qIWa2bJcddNw/957CohV/gMvQrnK7rg84XkJp//b3oWasSQ68WQ==
X-Received: by 2002:a05:6808:656:b0:383:e7c8:4000 with SMTP id z22-20020a056808065600b00383e7c84000mr129044oih.13.1679356047370;
        Mon, 20 Mar 2023 16:47:27 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b66-20020aca3445000000b0037d7c3cfac7sm4263116oia.15.2023.03.20.16.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:47:27 -0700 (PDT)
Received: (nullmailer pid 2930320 invoked by uid 1000);
        Mon, 20 Mar 2023 23:47:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: input: Drop unneeded quotes
Date:   Mon, 20 Mar 2023 18:47:18 -0500
Message-Id: <20230320234718.2930154-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/adc-joystick.yaml     | 4 ++--
 .../devicetree/bindings/input/google,cros-ec-keyb.yaml        | 2 +-
 Documentation/devicetree/bindings/input/imx-keypad.yaml       | 2 +-
 Documentation/devicetree/bindings/input/matrix-keymap.yaml    | 2 +-
 .../devicetree/bindings/input/mediatek,mt6779-keypad.yaml     | 2 +-
 .../devicetree/bindings/input/microchip,cap11xx.yaml          | 4 ++--
 Documentation/devicetree/bindings/input/pwm-vibrator.yaml     | 4 ++--
 Documentation/devicetree/bindings/input/regulator-haptic.yaml | 4 ++--
 .../bindings/input/touchscreen/elan,elants_i2c.yaml           | 4 ++--
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
index da0f8dfca8bf..6c244d66f8ce 100644
--- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
+++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019-2020 Artur Rojek
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/input/adc-joystick.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/input/adc-joystick.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: ADC attached joystick
 
diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
index e05690b3e963..3486c81699a8 100644
--- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
+++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
@@ -57,7 +57,7 @@ if:
       contains:
         const: google,cros-ec-keyb
 then:
-  $ref: "/schemas/input/matrix-keymap.yaml#"
+  $ref: /schemas/input/matrix-keymap.yaml#
   required:
     - keypad,num-rows
     - keypad,num-columns
diff --git a/Documentation/devicetree/bindings/input/imx-keypad.yaml b/Documentation/devicetree/bindings/input/imx-keypad.yaml
index 7514df62b592..b110eb1f3358 100644
--- a/Documentation/devicetree/bindings/input/imx-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/imx-keypad.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Liu Ying <gnuiyl@gmail.com>
 
 allOf:
-  - $ref: "/schemas/input/matrix-keymap.yaml#"
+  - $ref: /schemas/input/matrix-keymap.yaml#
 
 description: |
   The KPP is designed to interface with a keypad matrix with 2-point contact
diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.yaml b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
index 4d6dbe91646d..a715c2a773fe 100644
--- a/Documentation/devicetree/bindings/input/matrix-keymap.yaml
+++ b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
@@ -21,7 +21,7 @@ description: |
 
 properties:
   linux,keymap:
-    $ref: '/schemas/types.yaml#/definitions/uint32-array'
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     description: |
       An array of packed 1-cell entries containing the equivalent of row,
       column and linux key-code. The 32-bit big endian cell is packed as:
diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
index d768c30f48fb..47aac8794b68 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Mattijs Korpershoek <mkorpershoek@baylibre.com>
 
 allOf:
-  - $ref: "/schemas/input/matrix-keymap.yaml#"
+  - $ref: /schemas/input/matrix-keymap.yaml#
 
 description: |
   Mediatek's Keypad controller is used to interface a SoC with a matrix-type
diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 5fa625b5c5fb..5b5d4f7d3482 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/input/microchip,cap11xx.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/input/microchip,cap11xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip CAP11xx based capacitive touch sensors
 
diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
index a70a636ee112..d32716c604fe 100644
--- a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
+++ b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/input/pwm-vibrator.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/input/pwm-vibrator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: PWM vibrator
 
diff --git a/Documentation/devicetree/bindings/input/regulator-haptic.yaml b/Documentation/devicetree/bindings/input/regulator-haptic.yaml
index 627891e1ef55..cf63f834dd7d 100644
--- a/Documentation/devicetree/bindings/input/regulator-haptic.yaml
+++ b/Documentation/devicetree/bindings/input/regulator-haptic.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/input/regulator-haptic.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/input/regulator-haptic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Regulator Haptic
 
diff --git a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
index f9053e5e9b24..3255c2c8951a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/input/touchscreen/elan,elants_i2c.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/input/touchscreen/elan,elants_i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Elantech I2C Touchscreen
 
-- 
2.39.2

