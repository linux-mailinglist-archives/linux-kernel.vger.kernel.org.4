Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37916C946C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCZNKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZNKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:10:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B24865AC;
        Sun, 26 Mar 2023 06:10:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l7so5360520pjg.5;
        Sun, 26 Mar 2023 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679836249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKzFjxvODhKBwF/acym2OeXma7IHtjh3I+0sz9iqry4=;
        b=cIoMGxeASn0k2cD9f1D4DCfywcu6OWGUTdAh408RbXTx4AaQbbav2p9vZ62myaAAgA
         Sdkg+m1tT+8LsdsEFsC5mQRN/dlspGKc/ZHqLh0VwwPbVOzmuRleGqLXhCuq/f/KW62C
         kCQ2NwK37Fi00tcKhKTevb+V3vIHy0E/q1ApYykww+ZC9QqJ3lCMteI3i+92qeRGr2Ze
         03K1hwcnJE0MP5LaDV3HOrpj0y70925gERwEeB4XyM6JePDDdnJFyC52kPvfd8qv9O52
         TZ1EZIR18QmsaRDv3Cyfr9F1SjOtDjfdjvKWlDj1++Ht8L/o/f8evjGbsUWdcN2KlNPg
         4AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679836249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKzFjxvODhKBwF/acym2OeXma7IHtjh3I+0sz9iqry4=;
        b=OJHSdHuR5ST45VQHZPoqGlOGWKkC4jVH/1ZUw32VONHBZeNBWLhJfZ68sdkgv4AFJz
         bWsz7cLigRmIJ9Rv1KxLCIEeSfKTTrIG9zJy21hjn9Qt9FJ4UL4AyFNWPSNlg64FqCZT
         +UjaQlAPprIZC2rZZ0dqiCpmLGJdW8cx8vF+LnCTtRu3IA7G/WX2tNH7MCQwz3tEEBgz
         Ycg0K/er0M5JfuFK5Bg2Ux4ZBhx5rXgt5Rz+bBLq68OYIjpTlVBkI6jBghbxUZvvyOoK
         k101VDcxkRTGVTmKz+SFcrDYCWHETyTt3KGANYzLY5fuV12f7EHdUnXevqVC2ty+yVdS
         163Q==
X-Gm-Message-State: AAQBX9cqU9ubCuL69swKfgjRBd+b7336CDhUSLQ6+gMgDVbxUk2POvMw
        UOo7oJUTpTAMsgiF+RlfcV4=
X-Google-Smtp-Source: AKy350bnddRpIkB4HXMrVBbVA8T+5P6VvlnavRCXlNjYvO3XINXoOoySCKVKzRQ1vEFyCGhB3T28nA==
X-Received: by 2002:a17:903:787:b0:1a1:b5ce:5d03 with SMTP id kn7-20020a170903078700b001a1b5ce5d03mr6935847plb.10.1679836248556;
        Sun, 26 Mar 2023 06:10:48 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:1d70:a8f1:a55a:6f4a])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902e99500b001a2130e2cc0sm5063037plb.160.2023.03.26.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 06:10:48 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     danascape@gmail.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3] ASoC: dt-bindings: alc5632: Convert to dtschema
Date:   Sun, 26 Mar 2023 18:40:39 +0530
Message-Id: <20230326131039.19190-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323130511.16367-1-danascape@gmail.com>
References: <20230323130511.16367-1-danascape@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ALC5632 audio codec bindings to DT schema.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../devicetree/bindings/sound/alc5632.txt     | 43 -------------
 .../bindings/sound/realtek,alc5632.yaml       | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/alc5632.txt
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,alc5632.yaml

diff --git a/Documentation/devicetree/bindings/sound/alc5632.txt b/Documentation/devicetree/bindings/sound/alc5632.txt
deleted file mode 100644
index ffd886d110bd..000000000000
--- a/Documentation/devicetree/bindings/sound/alc5632.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-ALC5632 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-  - compatible : "realtek,alc5632"
-
-  - reg : the I2C address of the device.
-
-  - gpio-controller : Indicates this device is a GPIO controller.
-
-  - #gpio-cells : Should be two. The first cell is the pin number and the
-    second cell is used to specify optional parameters (currently unused).
-
-Pins on the device (for linking into audio routes):
-
-  * SPK_OUTP
-  * SPK_OUTN
-  * HP_OUT_L
-  * HP_OUT_R
-  * AUX_OUT_P
-  * AUX_OUT_N
-  * LINE_IN_L
-  * LINE_IN_R
-  * PHONE_P
-  * PHONE_N
-  * MIC1_P
-  * MIC1_N
-  * MIC2_P
-  * MIC2_N
-  * MICBIAS1
-  * DMICDAT
-
-Example:
-
-alc5632: alc5632@1e {
-	compatible = "realtek,alc5632";
-	reg = <0x1a>;
-
-	gpio-controller;
-	#gpio-cells = <2>;
-};
diff --git a/Documentation/devicetree/bindings/sound/realtek,alc5632.yaml b/Documentation/devicetree/bindings/sound/realtek,alc5632.yaml
new file mode 100644
index 000000000000..e399c35f48e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,alc5632.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,alc5632.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ALC5632 audio CODEC
+
+description: |
+  Pins on the device (for linking into audio routes):
+      * SPK_OUTP
+      * SPK_OUTN
+      * HP_OUT_L
+      * HP_OUT_R
+      * AUX_OUT_P
+      * AUX_OUT_N
+      * LINE_IN_L
+      * LINE_IN_R
+      * PHONE_P
+      * PHONE_N
+      * MIC1_P
+      * MIC1_N
+      * MIC2_P
+      * MIC2_N
+      * MICBIAS1
+      * DMICDAT
+
+maintainers:
+  - Leon Romanovsky <leon@leon.nu>
+
+properties:
+  compatible:
+    const: realtek,alc5632
+
+  reg:
+    maxItems: 1
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - reg
+  - '#gpio-cells'
+  - gpio-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        alc5632: codec@1a {
+            compatible = "realtek,alc5632";
+            reg = <0x1a>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
-- 
2.34.1

