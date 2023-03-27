Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077FE6CB0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjC0V24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjC0V2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:28:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A4A10E;
        Mon, 27 Mar 2023 14:28:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id fd25so6658298pfb.1;
        Mon, 27 Mar 2023 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679952533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NxdwX2D0akAAHFQeGjtNuXXTLf+CXBqbpNejn6s2rPQ=;
        b=CNgY+0HvxXretnJUh6TwLmwHNJBQ5Dteqa/KPd8Vgf1JafDdnHGtXeuM7AqZ1hRk4P
         UX+gK7l02pcmmhMcjf7/GKp6SORxoTh1I+R9OR+46k6JM+OUrsiAag+bkOSLAr/cVbVg
         UC/oXxXgZ2ZOJz+mVBoZ5Q86Ts+Ga1aShfEVT+VHNp7atEgtKb38T8pczJgt5OqXQJvc
         tp9BdxRDtYIGKCpzj7nLbHn1gPThVYSjD6qGot69RoW+mW8G7iD8bL1ha0Ntoq6YGt6d
         2pUrnEp9QIZXJ1mu1TLPDBzuhs9PuNgN7Sgcj/u/6HhU/GiSUWN7XmO+nlORV5N2Lzl0
         R+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxdwX2D0akAAHFQeGjtNuXXTLf+CXBqbpNejn6s2rPQ=;
        b=WVftBWtzXF/bYCFMKwy7j9L1yUWbLS/U4qJmCP3HWFMLJSW5psoqpKr6wOtyU7FQVv
         eWN8H2jn0qE/Pfn84YFV9+sUeaZmT+YcFst7ZsdrobYlpIRaYYJj3suSHISRxumFykqC
         /Ze7MOQRn6Xa95mhlKOgE5vPoskcP38Jd9D+liQwVz7yhw2AhHG7C++VygUuUKEYFIWj
         SM1n0I+hduVDJhRx+t4y0Wght/xG/7IVnvlGf65rVmdzvCboepvGK5TrHeLConvuLDX9
         1CA3RZ2j0scPGAGzwuXZe725Vlnr3Z2AuU3RLLxloNt4F7nMPdjy6pGuwiL5oJ9/fL1P
         CiEw==
X-Gm-Message-State: AAQBX9e1Jv1ZQOSM2UWEcOaq6h1iS3SvUxp+qsmeRkuyUGBGpRIJraTp
        TV7h8P0ugbbo1smbQFetWg4=
X-Google-Smtp-Source: AKy350b0G5xWtgH2YUl068CugJHSnX4vrh0PXrGTf1h20eLEFC6MuwtOTq7nIu/wqDcF1yos9dq4Tw==
X-Received: by 2002:a62:5b04:0:b0:623:6131:66ca with SMTP id p4-20020a625b04000000b00623613166camr11299362pfb.32.1679952532866;
        Mon, 27 Mar 2023 14:28:52 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:db37:2c9f:dcb8:89a9])
        by smtp.gmail.com with ESMTPSA id i26-20020aa7909a000000b0062d85a1df56sm2333616pfa.178.2023.03.27.14.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:28:52 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org, broonie@kernel.org,
        daniel.baluta@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, shengjiu.wang@nxp.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saalim Quadri <danascape@gmail.com>
Subject: [PATCH v2] ASoC: dt-bindings: ak4458: Convert to dtschema
Date:   Tue, 28 Mar 2023 02:58:46 +0530
Message-Id: <20230327212846.28928-1-danascape@gmail.com>
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

 .../devicetree/bindings/sound/ak4458.txt      | 28 --------
 .../bindings/sound/asahi-kasei,ak4458.yaml    | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 28 deletions(-)
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
index 000000000000..a3cd29517a17
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
@@ -0,0 +1,65 @@
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              asahi-kasei,ak4458
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

