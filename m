Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B886C90A2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 21:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCYUKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 16:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCYUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 16:10:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B37C656;
        Sat, 25 Mar 2023 13:10:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j13so4343984pjd.1;
        Sat, 25 Mar 2023 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679775014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3MDnfgRR+FKWTZeyRUEXrJ/4XfAf+pAOJ+XLicsZDFY=;
        b=px9wskqbmul8hBoJORyRP4neV8/Hvmjf5eTbvPjtT3Cs23m7w+hLnhS1ZuAGVhiV2I
         YqbQf9Nlxvh0b0VDWewSiK3W9gm6IhidjWox1/53fSNDqoGVeu03hy6UiRtWG98Vug9f
         NFhw/Hr3YYskB/qYkPBNeo6t+7akLNIb/miYLph3qS79x59ai4ED1vxid8IiddXWnITd
         jzdZXk2hC8Ulqn6+xF0BqERu17RGBc7U4OiAET8yBEfylpDP/y68mwUAkQpIfUwqdk3x
         IIqPzeeH0XuaF6IXCzqTDzIC7mVc1h5ezXzFfqtIEsw6Gt5iXmwKnYlUk7a2g5EOcbFx
         hdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679775014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MDnfgRR+FKWTZeyRUEXrJ/4XfAf+pAOJ+XLicsZDFY=;
        b=j7e9PlHiFgJ1et7I+2ge2LdvC7ehJC8tNy1s+xMyecT27BLi/gSdxSRrVR8bzzPw6E
         cBQDwPeosa4Xw4XJ1RzNNeBOAICh0dEeF4VLOma4nDI0ZJ22Xnr7t9K7XJe/NPRib0tc
         sMH2Be+H1QATMs5rkkD3XcYHn++UuCk8l1DI06Qs5/xmACRNfPCcVfnwxa55iUmYOkvf
         16mqKJzi9swGkkLbE/pWdVh/Vhki12iGScMxZnARR0q/cIxswSw27vG7wYUkiUfxLLr6
         Xh/Gp5/NYW9I54faz5zjkTcu1rmGJrJmZSfAc22wRKxoMr2zXRB8Mi19nswCeYxC9x61
         ckug==
X-Gm-Message-State: AAQBX9dp0jt4ld9M40ky4EeMJgTVN/bIy4S99cfvvqYSTVoZ8GCKijMj
        C2EpsOEFkIS2WymceS1h568=
X-Google-Smtp-Source: AKy350YoJZmEKk7JQ3rokJa/yebKHOjEddC4sTXKvMiAnVB0jfaCLehulWplY+iwJJyJq9RfC9pY6A==
X-Received: by 2002:a17:902:cec6:b0:19a:ad2f:2df9 with SMTP id d6-20020a170902cec600b0019aad2f2df9mr7745873plg.55.1679775013718;
        Sat, 25 Mar 2023 13:10:13 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:dbe7:6935:261d:5dd6])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902b28400b001a06b33923bsm16358813plr.164.2023.03.25.13.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 13:10:13 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     shengjiu.wang@nxp.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: ak4458: Convert to dtschema
Date:   Sun, 26 Mar 2023 01:40:07 +0530
Message-Id: <20230325201007.13006-1-danascape@gmail.com>
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
 .../devicetree/bindings/sound/ak4458.txt      | 28 ---------
 .../bindings/sound/asahi-kasei,ak4458.yaml    | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 28 deletions(-)
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
index 000000000000..b97aee96fa17
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
@@ -0,0 +1,62 @@
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
+        ak4458: codec@10 {
+            compatible = "asahi-kasei,ak4458";
+            reg = <0x10>;
+            reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+            mute-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.34.1

