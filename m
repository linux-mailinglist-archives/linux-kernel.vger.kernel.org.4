Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF7A6C7121
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjCWThS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjCWThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:37:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0991F5F6;
        Thu, 23 Mar 2023 12:37:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z11so13949640pfh.4;
        Thu, 23 Mar 2023 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679600236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMfwb3TCzp70bUxfAja9iS7wP2uDmc7/MEKN6Jse4+0=;
        b=Tyq07Llj4yiXh9EQMmqQMIq8BQLxO18QD05Vgjhh4AM3aZ4i2177E/uaC8ORp6G/IH
         rQ2aJpHyXkzmZW7+3lSTfP8ABgGKI9gfS9Wp/v7W3J3ldi/rIPCsB2wNkiww5CgEi7aU
         biuhGvTOG44lSNrcioRUPf6kwr0yJ/UAjQzltt1qlWDeBgsJLckwu8un+3xTPE2z+AZp
         BSSY/8+KuFQRJaL7wrQ3ll4r06Id7vdCqHncU5isF66AZX/5ymG2uvdu6Ntow9KedWq0
         NImn4cKVj6gX0uCuUYDvAa/bXed5cyDDL5aRBV4E9paVqJClw3IUA4LrfiZyrrgF9ztQ
         yulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679600236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMfwb3TCzp70bUxfAja9iS7wP2uDmc7/MEKN6Jse4+0=;
        b=PEGzhNr6QS2Ttnm3J2s/YbkFwwPkSBbMEXghInUHZCm1Rzfk7T22CzytmqE9uBwWgy
         3ajqqEUxYUYmhkFCZbPfbY7sjH5GqaXqjiPhacfwyDAFoe6nCBlFNvcUqYotNgdmzPOa
         FdcIS48dC1fOhDHextbvUWYVxROHPYoL0eIELG6lu031/eSbmmS8s12LuI2GxMGUuYas
         fUFefQWa2XWLj0vPVKgBZ1RXt52zYX0aQSosX4bCwuBWk1CQRNeBnGEHsR8ZcG7ornPv
         N8Eh7GkFKu4iReM9sOOaJXntVDR0o8svSZIc7Jcy1V2WIvSCkAzZ2R7j3DR3vWzjSYYJ
         bBMA==
X-Gm-Message-State: AAQBX9cmUvD1E7fy24PvjKbQVn8kEbGbeYa1wc94PxRk5ZHQQFOqkZDx
        wuNK1LXOEmlupx5YCHfuHfk=
X-Google-Smtp-Source: AKy350a+ymKVySVKSP248E+HQG5uYdQ3Oo95FGshpHfjANiaJu+AbEtHMen8G3kPn2KfXT/OSjuUTA==
X-Received: by 2002:aa7:954a:0:b0:625:cb74:9e01 with SMTP id w10-20020aa7954a000000b00625cb749e01mr458611pfq.25.1679600235728;
        Thu, 23 Mar 2023 12:37:15 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:af8a:74c0:ae9:c475])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b005d4360ed2bbsm12374489pfm.197.2023.03.23.12.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:37:15 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, danascape@gmail.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: [PATCH v2] ASoC: dt-bindings: alc5632: Convert to dtschema
Date:   Fri, 24 Mar 2023 01:07:09 +0530
Message-Id: <20230323193709.5176-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4a553ab8-4cd3-4ce4-8225-20f43b70a5be@sirena.org.uk>
References: <4a553ab8-4cd3-4ce4-8225-20f43b70a5be@sirena.org.uk>
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
 .../bindings/sound/realtek,alc5632.yaml       | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 43 deletions(-)
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
index 000000000000..3de18b0fd3fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,alc5632.yaml
@@ -0,0 +1,64 @@
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
+  - Mark Brown <broonie@kernel.org>
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

