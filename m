Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D471D6C6914
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjCWNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjCWNFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:05:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1305959E5;
        Thu, 23 Mar 2023 06:05:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so1993055pjz.1;
        Thu, 23 Mar 2023 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679576718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWCXPXA01MTxciO2O9Gpy0spNBsM2s0w3oGvveagMoo=;
        b=EvIAw5uYNDJCs83AkTe8PKJ5PTxaFvQrrndavIdnGESuO3Uval6+/8U5VTh2BJBgV8
         pgpLTIEc64554ew8zGYznC3JjP0rlDsTQurPqqSJ7jRB35auHPVBnn8ZFfBhGLGNo53a
         wBF9MtM8hIAzN57m9kDxcLWIS2xCQf73oyc/njFgodOTWg/eDyE+R47WdheRwUJaDEAx
         QTj3J8jlE5eB1w+D6dsrmxO5QeeMccRnV4aSvajvhP4SfRnzq2pQHYhy+PGrK5iqLyPK
         0LNJc15sUyVZoD85cAhyY8Z+8KP0NIKcFzN9sePx0pQ1ayKzZe/uwdAbNclUafEzOwSU
         uZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWCXPXA01MTxciO2O9Gpy0spNBsM2s0w3oGvveagMoo=;
        b=UkFIAv2D173fL9i0KVjw1bZAPPlgBtXV7PZ0v89FPdv6bdu4Ys+dGwQ6hFuErSIo6N
         oGVpe1hGLB/E0FOSUtPfkPKVdvqedahHeUS4Nc661G9B40fsmtpfiop2nXCd/R3kCilc
         uLJ4UaJUKAIm24dJ4iDqxLNvD6P7FsAPvojuS3V2r2q4g551BtzVB7dYC6vqKSHkd4AZ
         wU6OW1r6ClonVCUlpE+e/AuR+gNCSMUCoPhpZy2hpZuqG4akyouaqhfqUsOtddW46GwL
         CalB+RevHXxmrhKcrWPMs/PQYbPVVeLadJRSYV4S9NqeO/yfxBSpBc+atcVBNSkZROzI
         FXDg==
X-Gm-Message-State: AO0yUKXQrGbPuEettujy14/itwO9gCYyYyTnxvsRHhay1FibV+0H3YkB
        WjJOv+5qUru7SYBmZhlFLZs=
X-Google-Smtp-Source: AK7set8S+0kJoTpHKtB6cXVVZlN4fSFDi/M+zMk/Fq8rKQE2qE0kdzqchatkBUco0c3oAb20eqdpRA==
X-Received: by 2002:a05:6a20:b214:b0:d9:84d2:7aae with SMTP id eh20-20020a056a20b21400b000d984d27aaemr3111303pzb.22.1679576718295;
        Thu, 23 Mar 2023 06:05:18 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:96dd:65b4:8354:3919])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78150000000b005825b8e0540sm11880245pfn.204.2023.03.23.06.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 06:05:17 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: alc5632: Convert to dtschema
Date:   Thu, 23 Mar 2023 18:35:11 +0530
Message-Id: <20230323130511.16367-1-danascape@gmail.com>
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
index 000000000000..7c2de067fb27
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
+  - Liam Girdwood <lgirdwood@gmail.com>
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
+        alc5632: alc5632@1a {
+            compatible = "realtek,alc5632";
+            reg = <0x1a>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
-- 
2.34.1

