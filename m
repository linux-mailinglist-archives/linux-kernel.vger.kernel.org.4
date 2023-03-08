Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E656B12C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCHUPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCHUPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:15:24 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FBE62865;
        Wed,  8 Mar 2023 12:14:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so16562959wrw.2;
        Wed, 08 Mar 2023 12:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678306495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f18ANY0TsdSX/8E9h2Omny/ch19FPWElNHD1AD0jqsM=;
        b=kt7Kt6z7dNCg0V+0cRO8Eh6LQ5y0SaaZludgo3vtyRtAEUHPS70cMcezc0gSrDEXHW
         QIKnL3aW2XDeUGZkNgL3kHa3jy5Dm2mUbhdzM4kEE0PL6D6hcZL+leE44hJyctBsPKWP
         buVAE8WZJKdJCD4aHs6m1L5w2RXHi9ghuRLuyUlvDbz78ncATgMOVLS94xHuIkuq0D8e
         qm2maaoJo8fPzdy1T7g8QL/rnh6LA0SzYcrbmvwSZqM6VCmZ2BvurktE0yAEY1441BGK
         dzbRrwg/eNP0AKHduEGl2wf9DQFrMaYtSOTdE+XqSKxVoYNqmj4KnjAuDkTVhHaOEfGx
         gc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678306495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f18ANY0TsdSX/8E9h2Omny/ch19FPWElNHD1AD0jqsM=;
        b=K/CnVCL/xpNV7lI+7mHDze90dXCAQlgwQ0tE7zij+/1jJkuxcdh5lhJwAUf7p/Mqn8
         cvQv/RvBwb9p3AY6cx9jAymwm0fDGaheEtlNdZncK7RnM6oEhoycIg3Vjrl7uO9oYGy2
         gOT9/fJuON7cFxrb+u8WHhdQooTxnSRO9KnJUfnEhcPfAQBH0HIOcqveTtR7BOBaLFLF
         zG0NEE3cy73H/TW2ECKUwzS4xD4mvvVzyVmPYoabVuZzbS6uMyFZpP0SL3IU+awc27iX
         WZZDZWE4zKmDl8MlRetJyW6llD5OqwT8UysozQiF7ZuIkZRLbWTXxDVEm/O7n5cqenhc
         dC6w==
X-Gm-Message-State: AO0yUKV3uYXoclPJfOrW6Y4QrRVf4uhEiOaIA+g7whTOYSVHdS3W88OX
        94n5qkn6ZKzcc8Xv0jYcYKo=
X-Google-Smtp-Source: AK7set+MmOJoByX+oFWP8ct8it2tRbVM/EeVH6ttZOehUsOttjwWNmkVS79P+0sI5UDTy0+BVEhYjQ==
X-Received: by 2002:a5d:45c9:0:b0:2c6:a953:850f with SMTP id b9-20020a5d45c9000000b002c6a953850fmr10715843wrs.19.1678306495623;
        Wed, 08 Mar 2023 12:14:55 -0800 (PST)
Received: from Beasty.Home ([2a02:c7f:a63c:de00:a170:c7f8:586:6319])
        by smtp.gmail.com with ESMTPSA id g11-20020adffc8b000000b002c7b229b1basm16129796wrr.15.2023.03.08.12.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:14:55 -0800 (PST)
From:   Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.or, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
Subject: [PATCH 1/2] dt-bindings: leds: Document rohm,bd65b60 bindings
Date:   Wed,  8 Mar 2023 20:14:50 +0000
Message-Id: <20230308201451.11629-1-bogdan.ionescu.work@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is my first patch to the kernel, so I expect to have made
some mistakes. I did my best to follow the documentation and
submitting patches guidelines, but if I missed something, please
let me know.

I wasn't sure if I had to add myself to the MAINTAINERS file for such a
small patch, so I didn't.

Patch begins here:

Added devicetree bindings documentation for the rohm,bd65b60
led driver.

Signed-off-by: Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
---
 .../bindings/leds/rohm,bd65b60-leds.yaml      | 77 +++++++++++++++++++
 include/dt-bindings/leds/leds-bd65b60.h       | 20 +++++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.yaml
 create mode 100644 include/dt-bindings/leds/leds-bd65b60.h

diff --git a/Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.yaml b/Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.yaml
new file mode 100644
index 000000000000..f69d7acd39c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/rohm,bd65b60-leds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD65B60 device tree bindings
+
+maintainers:
+  - Bogdan Ionescu <bogdan.ionescu.work+kernel@gmail.com>
+
+description: |
+  BD65B60 is a white LED driver IC that integrates PWM
+  step-up DC/DC converter with boost-capability of up to
+  maximum 28.5V and current driver with drive capability of up
+  to 25mA(Typ.) maximum setting. Precise brightness can be
+  controlled at wide ranges through the external PWM pulse
+  input.
+
+properties:
+  compatible:
+    const: rohm,bd65b60
+
+  reg:
+    maxItems: 1
+
+  led:
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      rohm,enable-outputs:
+        description:
+          Select which leds are being controlled.
+          Values defined in <dt-bindings/leds/leds-bd65b60.h>
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        enum: [ 0, 1, 4, 5 ]
+
+      rohm,ovp:
+        description:
+          Select Over-Voltage-Portection level.
+          Values defined in <dt-bindings/leds/leds-bd65b60.h>
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        enum: [ 0, 8, 16 ]
+        default: 16
+
+    required:
+      - rohm,enable-outputs
+
+required:
+  - compatible
+  - reg
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+    #include <dt-bindings/leds/leds-bd65b60.h>
+
+    i2c {
+
+        led_controler@64 {
+            compatible = "rohm,bd65b60";
+            reg = <0x64>;
+
+            backlight_led: led {
+                function = LED_FUNCTION_BACKLIGHT;
+                color = <LED_COLOR_ID_WHITE>;
+                rohm,enable-outputs = <BD65B60_ENABLE_LED1>;
+                default-state = "keep";
+                linux,default-trigger = "backlight";
+            };
+        };
+    };
+
+...
diff --git a/include/dt-bindings/leds/leds-bd65b60.h b/include/dt-bindings/leds/leds-bd65b60.h
new file mode 100644
index 000000000000..8634faae58f4
--- /dev/null
+++ b/include/dt-bindings/leds/leds-bd65b60.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides macros for the ROHM BD65B60 device tree bindings.
+ *
+ * Copyright (C) 2023 Bogdan Ionescu <bogdan.ionescu.work+kernel@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_LEDS_BD65B60_H
+#define _DT_BINDINGS_LEDS_BD65B60_H
+
+#define BD65B60_ENABLE_NONE 0
+#define BD65B60_ENABLE_LED1 1
+#define BD65B60_ENABLE_LED2 4
+#define BD65B60_ENABLE_BOTH (BD65B60_ENABLE_LED1 | BD65B60_ENABLE_LED2)
+
+#define BD65B60_OVP_25V 0
+#define BD65B60_OVP_30V 0x08
+#define BD65B60_OVP_35V 0x10
+
+#endif /* _DT_BINDINGS_LEDS_BD65B60_H */
-- 
2.39.2

