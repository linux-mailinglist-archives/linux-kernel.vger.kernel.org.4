Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C316CB079
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjC0VQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0VQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:16:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01C1703;
        Mon, 27 Mar 2023 14:16:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso237611pjf.0;
        Mon, 27 Mar 2023 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679951798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHbx2+i6d7WFk9FZPMTqiI0CTx6nH8Bhl3pHJcsKVZI=;
        b=MwU8vqEn95ASx7oGflXK9X6O7CvMq+dJHT/8wNlGJEgIUuVCnWuMTbT2OdcLTlEmcm
         mxtm0N4DChvB/wumC6pK8m65JpVlEqbuBvGSlc38aBp9NEqQ2l0EG8SK3QhpN/Z6uRGO
         u0StbdPeSmm/OllhbF76mrTyDKgJHeVNr+Mjqad+aoZyMTG4/ouRbzwlbJAr7FGpRSXj
         OXxPvdg2g6QWiGHRs/icKkGNUi/MUcqt8iF6bE+spTQSOKyPQ52xvVrsw776iQGi5KAZ
         UOLoFkl2fr1Jk36nuyktFNAJAO4r+ZfwC3/QOn6aopSeIhqINYqMzzSV1PjGN0HmZC+I
         RMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679951798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHbx2+i6d7WFk9FZPMTqiI0CTx6nH8Bhl3pHJcsKVZI=;
        b=7lfy30QKEfrO2/U7KmYTQznTihpMlOGE8tjCLrZX/9YGAvUBf1wLQ68gwZBNURTalH
         ul0TDNKBVBhskOywQOPRu2vi7TJCuGQIdNh1o4cKSuaqRnftY9lz7prhtMOpSKzj62rG
         cYtDDH5OJfNDjNQekAtXe4K6xZpDzo6sCbGSCHsfEMqtVq0c574Ynao1IsAptSj3WNfY
         UTWBMAJlfnAiLyT2GlFNkbn5B5OMglCDFPWjk7mCHoM1cDEx3VFd0qpQuUmZvHBsadQJ
         5GMTUwW5ymf9N1kpMTobKfVUItnXrmc8e1UuIxw2VfEMqtlbkXsEe6hWPIdWhI5psAAw
         /c/g==
X-Gm-Message-State: AAQBX9f/z+VnUrjHpoPTyLQcn7qKno7tQLVe7aWHG9ehMxwyoRyAvXOk
        Z1110C01A6xMQLuTCtkKgcs=
X-Google-Smtp-Source: AKy350YtYRsSrUBMMwteIyDuBFeHhB3bhAGF0ICkTYrV+gWx4xbh8tYmYsZ619XiDEAwYCsSYgmuMQ==
X-Received: by 2002:a17:90a:ab01:b0:237:b4c0:e15b with SMTP id m1-20020a17090aab0100b00237b4c0e15bmr13940176pjq.44.1679951797912;
        Mon, 27 Mar 2023 14:16:37 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:db37:2c9f:dcb8:89a9])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090aeb0c00b00230b8431323sm8020724pjz.30.2023.03.27.14.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:16:37 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org, daniel.baluta@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] ASoC: dt-bindings: alc5632: Convert to dtschema
Date:   Tue, 28 Mar 2023 02:46:29 +0530
Message-Id: <20230327211629.28643-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
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
Changes:                                                          
V1 -> V2: Use correct node name 
V2 -> V3: Add correct maintainer name                   
V3 -> V4: Drop alc5632 label name

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
index 000000000000..fb05988ff7ea
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
+        codec@1a {
+            compatible = "realtek,alc5632";
+            reg = <0x1a>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
-- 
2.34.1

