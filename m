Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E4F6CB9C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjC1IsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjC1IsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:48:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDE449E2;
        Tue, 28 Mar 2023 01:48:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y19so6753181pgk.5;
        Tue, 28 Mar 2023 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679993279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VNI6lV401OYe10HsNLcwnXIFZPlsfUPtF81FXRtAZ3E=;
        b=j/cEpRRM19UVVeWZS9niuGCxErtarIdoC5kbPGQwNCHySTyUcwjwkGkeQ5z+J6kfzR
         pYKJm8Dg19Q6o+B3Eo1N1xNf/tfLq46xtFWvSAoMA/yWP+VPQ5IIZPzyg/LPvDHIODtv
         uFsBwVQpryiNlQuSQksTImQOAvcdT1DhL/WeWgUtCt5GlhKY6bmqB+uO5yD0P7VDZgwG
         KtJieIxpzUlm3dNPc3a1P6FMu2OdWXIVEMTBGdg6bzMRqfIijzNUOVLOS/VOm5j7jQsr
         gVwwuLLr/M52JlOmbLFwAqHVVeSlt9PTBkEtjUH3WyrDkomBFsFqqOoCxQ/eFCkQydUp
         9Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679993279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNI6lV401OYe10HsNLcwnXIFZPlsfUPtF81FXRtAZ3E=;
        b=74WVm9SElZttT2PSF3JdkF4CptVv/Q4cp1fm5UUxdTkjzXK+YATWjIZBn/ze9UyMLa
         r6oU5b4UI6ZQv5hRq7n4CyWubywxexnPzbCmfvXY5T4mwiKeVGCGzZ0MfLnkNdnKfOr4
         WKJ6OIVtStEc+G3NfSY3vI20tPhBSgoOIptQ32BEkUNnw+5mYhX9VlGAm1XjF7p0yZiR
         jQmEdbROtQa7aGw+GrKr7BrOWR20cJFjZWmTtoE0ojjSVgYes893XisH3rrtlzm/ihEP
         3CY8zKvUGwGQaLk+Uq+4/ZDlIxrPmsCSi5tjCcocL2ziVbeI7TkDDcUBtvnh6PTws1zM
         o2Ng==
X-Gm-Message-State: AAQBX9eS7nJIDYGeU42YZ/yPc5oNNfUc1GfNjqUU2VRjymsgJZq0gKs8
        a31S7dzV7YKF6DKHihRrMnk=
X-Google-Smtp-Source: AKy350Y270PTe8vasybxuEgWv07q7aaaBzY21O1foTzqSD2vg28QsUxiKBuKth5huZcm4YiEF70L5w==
X-Received: by 2002:a62:8496:0:b0:627:f659:a771 with SMTP id k144-20020a628496000000b00627f659a771mr16150885pfd.12.1679993279393;
        Tue, 28 Mar 2023 01:47:59 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:db37:2c9f:dcb8:89a9])
        by smtp.gmail.com with ESMTPSA id e27-20020a63545b000000b00513092bdca1sm9119548pgm.73.2023.03.28.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 01:47:59 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org, broonie@kernel.org,
        daniel.baluta@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, shengjiu.wang@nxp.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saalim Quadri <danascape@gmail.com>
Subject: [PATCH v4] ASoC: dt-bindings: ak4458: Convert to dtschema
Date:   Tue, 28 Mar 2023 14:17:53 +0530
Message-Id: <20230328084753.55200-1-danascape@gmail.com>
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

Convert the AK4458 audio DAC bindings to DT schema.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
Changes:
V1 -> V2: Use the correct way for dsd-path property
          Drop ak4458 label form example
V2 -> V3: ak4458 is the only one that does not support dsd-path, so we
          do not require to define an array
V3 -> V4: Add back dsd-path property description

 .../devicetree/bindings/sound/ak4458.txt      | 28 -------
 .../bindings/sound/asahi-kasei,ak4458.yaml    | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
 create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
deleted file mode 100644
index 0416c14895d6..000000000000
--- a/Documentation/devicetree/bindings/sound/ak4458.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-AK4458 audio DAC
-
-This device supports I2C mode.
-
-Required properties:
-
-- compatible : "asahi-kasei,ak4458" or "asahi-kasei,ak4497"
-- reg : The I2C address of the device for I2C
-
-Optional properties:
-- reset-gpios: A GPIO specifier for the power down & reset pin
-- mute-gpios: A GPIO specifier for the soft mute pin
-- AVDD-supply: Analog power supply
-- DVDD-supply: Digital power supply
-- dsd-path: Select DSD input pins for ak4497
-            0: select #16, #17, #19 pins
-            1: select #3, #4, #5 pins
-
-Example:
-
-&i2c {
-	ak4458: dac@10 {
-		compatible = "asahi-kasei,ak4458";
-		reg = <0x10>;
-		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>
-		mute-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
new file mode 100644
index 000000000000..608dce956be0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/asahi-kasei,ak4458.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AK4458 audio DAC
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - asahi-kasei,ak4458
+      - asahi-kasei,ak4497
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog power supply
+
+  dvdd-supply:
+    description: Digital power supply
+
+  reset-gpios:
+    maxItems: 1
+
+  mute-gpios:
+    maxItems: 1
+    description:
+      GPIO used to mute all the outputs
+
+  dsd-path:
+    description: Select DSD input pins for ak4497
+    $ref: /schemas/types.yaml#/definitions/uint32
+    oneOf:
+      - const: 0
+        description: select #16, #17, #19 pins
+      - const: 1
+        description: select #3, #4, #5 pins
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: asahi-kasei,ak4458
+
+    then:
+      properties:
+        dsd-path: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@10 {
+            compatible = "asahi-kasei,ak4458";
+            reg = <0x10>;
+            reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+            mute-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.34.1

