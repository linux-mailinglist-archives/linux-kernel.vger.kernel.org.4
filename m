Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959EC6C38E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCUSIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCUSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:08:23 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF8037F00;
        Tue, 21 Mar 2023 11:08:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y35so7935365pgl.4;
        Tue, 21 Mar 2023 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679422101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2/rMnDzTtzdcuKbx17fhDdJNMf1h2Fo2LL02Vb+CLhM=;
        b=V6AhfyZ51y2qPm+yKR8DM2g0Jq0GoidDfLpWizKuMgFMzA0XWVkgTp0MoZNW5r5HoL
         PU8ENnUvZdXNJBgyOgTvLeQYj4CwZob5eET0wvQjIou9+jdmJWrJvwOkX7codPxd6+bc
         bj8mnRj/bZR+ilrbv8GACzV6xAuRmlXowjHHwEH0BKpwvO3MxqIT51C2y3b136V9jEaQ
         UIE3HjyZFUu/0+aHIWOpfv/GZaaWjvmfOjMA+LgCC2nt2ubGPtntdsbZWkSwNsHPZYJC
         SmRBW11b3hhOsgW9brRov0AoeyGWDgurAw61HPKlWl1KpUN3pg11NJRajLizT4i1OS8N
         AcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/rMnDzTtzdcuKbx17fhDdJNMf1h2Fo2LL02Vb+CLhM=;
        b=0OPbqWNwEPVQdhOH/ToE9ySrIr6mNu+ZW4g9xsnYq9x78xHEBBou9X3o0wSDC+jM75
         xbsoum0J/cUCRQfo/n0f7VSFkPhzfbbI2gQNXkc8ziZH4mYUyqKNWPGYAOy96aoq0fI3
         pQkSpYpVQhM/oqrAmJHzGwUEXAuSqzfnTa72PPvAC57P6WgL5mnJXYtatHi9p9S8Cq6D
         7mz5UHnpgt+J4+s5jgIsCaxl0EWjB8Wu7Ip98RdmNmVfRUCuPV9gPLEdWtJ0nZ4i9EcO
         SNul4SUIgvubjKaiYTX8iH8WqESjvjvcE4KpU3/4URDBKOPGGIqb74GjnoUF+NxY8PQW
         rXhw==
X-Gm-Message-State: AO0yUKXObq0NlbD1ajckQ8aP6vnkWT/4tJyELPzmp4s0H8lUmbImLOmw
        Va7VPNUhzrdnWcEFzFNHD+k=
X-Google-Smtp-Source: AK7set8Y5LDotwJmgDk9x8Q5w4bKASWDV6/0OiAfBWqilwxolMKj/ewwXe85vIJsjNQ8JOrk8MgXag==
X-Received: by 2002:aa7:98db:0:b0:628:cff:1440 with SMTP id e27-20020aa798db000000b006280cff1440mr545007pfm.28.1679422101460;
        Tue, 21 Mar 2023 11:08:21 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:1776:b945:875a:a34])
        by smtp.gmail.com with ESMTPSA id a21-20020a62bd15000000b005895f9657ebsm8522918pff.70.2023.03.21.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:08:21 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: ak5558: Convert to dtschema
Date:   Tue, 21 Mar 2023 23:38:09 +0530
Message-Id: <20230321180809.9215-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Convert the AK5558 ADC audio codec bindings to DT schema.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../devicetree/bindings/sound/ak5558.txt      | 24 ---------
 .../devicetree/bindings/sound/ak5558.yaml     | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.yaml

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
diff --git a/Documentation/devicetree/bindings/sound/ak5558.yaml b/Documentation/devicetree/bindings/sound/ak5558.yaml
new file mode 100644
index 000000000000..90fd734daeec
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak5558.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ak5558.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AK5558 ADC Device Tree Bindings
+
+maintainers:
+  - Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
+  - Mihai Serban <mihai.serban@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - asahi-kasei,ak5558
+      - asahi-kasei,ak5552
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device.
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

