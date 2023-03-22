Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314AB6C5764
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjCVUVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjCVUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:20:39 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C744664D2;
        Wed, 22 Mar 2023 13:10:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y19so11311150pgk.5;
        Wed, 22 Mar 2023 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679515797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WLHEQY3qr/o+G8te336ZMutrRR6CDO4ZScoVVO+SV4=;
        b=auefz9E1FR6JZgzvalJ+0wMPa2TDyb6NRN2uO/9+eUj3SFrMnbacTAsoA+igzDORqP
         5I/AyVCOB0c+W6fVEFVG29FJDHwmF85BLfOwM1pNrhEkqlhH4LHQiHbXEzzwQEonO7FG
         zHqJ8Xzr2Hld8DA7VoXsA1w8bChbRXmYN4rMY9jAhg+ap9ifsxI7MhbTMcKzsnkpHlaE
         KvS5X0EXG6uvqqnz6IwdEJU3BABtHj6lPTlfScpHFd58POCMIpYMXqKsi1sCBD77lBzs
         9zHur+jX3CWTf/fhdcOLfqQSGMdN0DBP1NaPtiVozeZT8wBSXrrnZ+2Fx04ok1w1kEd8
         zeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WLHEQY3qr/o+G8te336ZMutrRR6CDO4ZScoVVO+SV4=;
        b=3C5BKRQlebTW3TPbgzxXvPnRGwVVvpiqJqE7AbZBIHJuvepiS640XgmdpITBM7hvI+
         JnqR9aZwiYmiwSK5GRn5x5WEWrzBhBAs1i9ieFfnNoi/bZkciAADfJYNh6OGqSle4zgv
         eAml3w2eN/NU1QS9xzXx3U/J6+Fajxe0GTVckepf9xMYYdPvUavhElCpvBu9wu46cm7J
         GcVH8GXUU8/BKwz/l1LOtCfqSOCgKtPpQcBg8hN8f0pqS+G6weguCfxz2J6OWfWnYG8r
         2sVlmvEkXmY6PAdb4bFc6fWTtGFxQpZdIie1SJwl/GDbJSVVCzKe/xdS+aRTt79Q9OaZ
         o76Q==
X-Gm-Message-State: AO0yUKWwXT/3V80rmMaDd1L7mQISC2dLvGkCH5zaW1EnPYtu9lSyLZ3v
        /o21JTA0YIPkAyuZl9XNvvg=
X-Google-Smtp-Source: AK7set/g3mhJQ57vML1TthZqf1YSYb97c0MPrveW4ry4C0r2RMlL2jI18MlVCZ8bu4EIu2FpJbHW4w==
X-Received: by 2002:a05:6a00:3002:b0:626:2bb0:30d4 with SMTP id ay2-20020a056a00300200b006262bb030d4mr2762060pfb.8.1679515796742;
        Wed, 22 Mar 2023 13:09:56 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:3ad4:4b40:d590:7df2])
        by smtp.gmail.com with ESMTPSA id r1-20020a62e401000000b005e4c3e2022fsm10523059pfh.72.2023.03.22.13.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:09:56 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org, daniel.baluta@nxp.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2] ASoC: dt-bindings: ak5558: Convert to dtschema
Date:   Thu, 23 Mar 2023 01:39:49 +0530
Message-Id: <20230322200949.8986-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d1559192-8f6d-26e0-ef19-d14ac7987a74@linaro.org>
References: <d1559192-8f6d-26e0-ef19-d14ac7987a74@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the AK5558 ADC audio codec bindings to DT schema.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../devicetree/bindings/sound/ak5558.txt      | 24 ----------
 .../bindings/sound/asahi-kasei,ak5558.yaml    | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
 create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak5558.yaml

diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
deleted file mode 100644
index e28708db6686..000000000000
--- a/Documentation/devicetree/bindings/sound/ak5558.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-AK5558 8 channel differential 32-bit delta-sigma ADC
-
-This device supports I2C mode only.
-
-Required properties:
-
-- compatible : "asahi-kasei,ak5558" or "asahi-kasei,ak5552".
-- reg : The I2C address of the device.
-
-Optional properties:
-
-- reset-gpios: A GPIO specifier for the power down & reset pin.
-- AVDD-supply: Analog power supply
-- DVDD-supply: Digital power supply
-
-Example:
-
-&i2c {
-	ak5558: adc@10 {
-		compatible = "asahi-kasei,ak5558";
-		reg = <0x10>;
-		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak5558.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak5558.yaml
new file mode 100644
index 000000000000..d3d494ae8abf
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak5558.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/asahi-kasei,ak5558.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AK5558 8 channel differential 32-bit delta-sigma ADC
+
+maintainers:
+  - Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
+  - Mihai Serban <mihai.serban@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - asahi-kasei,ak5552
+      - asahi-kasei,ak5558
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description: A 1.8V supply that powers up the AVDD pin.
+
+  dvdd-supply:
+    description: A 1.2V supply that powers up the DVDD pin.
+
+  reset-gpios:
+    maxItems: 1
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
+        ak5558: codec@10 {
+            compatible = "asahi-kasei,ak5558";
+            reg = <0x10>;
+            reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.34.1

