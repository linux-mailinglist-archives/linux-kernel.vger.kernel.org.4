Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FD7612F02
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 03:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJaC3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 22:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJaC3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 22:29:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A134B1F2;
        Sun, 30 Oct 2022 19:29:04 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h193so851613pgc.10;
        Sun, 30 Oct 2022 19:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OQIWKXkmwpQVfW4D/7Tax4JrMXlVPbNKPmAD+j7Bx1g=;
        b=qW40gGss28pMue4kjLqOIH6MqvbG2C6DErcprc0HlYe85WZrQ8I/9zjUxEdFfJRyE9
         zInhBumTg3cFspAcHa6WEXoH8OBj1spbvuRUoJGCK6j8T67ktya1ZrRBtGe6luI77P1w
         /jsRUVrh+Hbd8KtzfXr7Jfsmhc97LM2k3nwKKs+hLj5SHr/BnmJ6LT+fmC8nDZsvF28z
         7mGL57i7e52fQ44pzFSAlQ1yLBJiIMC9fX/dwM9iOVxqGM7Qi5uU4QaGOnwYN+G5s1xG
         UFYpNhqvkXz9dYklt6/nndZwHQcAxUEX7en3LJLk20Mjoyh4QAu+RDXtK1h1OZjW8bWW
         pcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQIWKXkmwpQVfW4D/7Tax4JrMXlVPbNKPmAD+j7Bx1g=;
        b=vv41+Cf9vMswJC9XREPolpmE5VmVIApzUI5Z7MlN1vpavV6d1TrPlzqdR2l3tFrWNN
         GyYwyBJYzLk47MVOK/15/1BtxIaYGcJWIMWjWfsvLdHnrHH/mPcUzcyk+Z8DQJmMQO47
         3MqHjZyHMJhJfa3YMt3sJI3OR6IZacwQ6cKUmlKdsgKExAFErJRi4u02lfFCTLI9u+m0
         rzQmpJ8qVPLp9zCQOBq/rb8tbBuIIkoLoIeN1SUP9XPtqDbnG+oF6FZQN4qGjBskOPLQ
         9+UjLBmKvXxS+0o3UcLuJBBXYsHUmqWS50xE13BffpT1ncGWrJd5YUCuEnbZMbBf2viz
         mIZQ==
X-Gm-Message-State: ACrzQf0hGl2ad0rajFtjJ4PRuQYcs631Ip6VOlt6V0casetghsU/GLD7
        SrIfkaP6bMa4Jy80HwpTRaJH+eKII9o=
X-Google-Smtp-Source: AMsMyM58KHw9qJPSA0qgVV14FrkbZi1BDNvNkfzzlfEnDTgaorTXT5MvxD0g9NQrO29lqOYGftI7uw==
X-Received: by 2002:a63:8949:0:b0:46f:57b1:35bd with SMTP id v70-20020a638949000000b0046f57b135bdmr10557158pgd.623.1667183343370;
        Sun, 30 Oct 2022 19:29:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46a:ab6a:820:3d51:c22d:4bb5])
        by smtp.gmail.com with ESMTPSA id q42-20020a17090a17ad00b0021282014066sm3064504pja.9.2022.10.30.19.29.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 19:29:02 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: regulator: Add bindings for Richtek RT6190 regulator
Date:   Mon, 31 Oct 2022 10:28:53 +0800
Message-Id: <1667183334-16511-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667183334-16511-1-git-send-email-u0084500@gmail.com>
References: <1667183334-16511-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add devicetree binding for Richtek RT6190 4-Switch buckboost controller.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi, Rob:

Since I didn't got any reply from the v2 dt-binding question.
https://lore.kernel.org/lkml/CADiBU3_WUeyYdnmnG0Ff2pH+b3u1zOtP1z44LcA53Ba5c9nrEw@mail.gmail.com/
In v3, I aleady fixed it following by your comment.

I'm just wondering the corrent usage.
As I know, 'enable-gpios' comes from 'gpio-consumer-common.yaml'.
In the common yaml file, it's already declared 'enable-gpios' maxItems as '1'.
That's why I just declared it as 'true'.

Since v3:
- Fix the typo 'upply' to 'supply'.
- Declare 'enable-gpios' maxItems as 1.
- Declare the 'maxItems' for the property 'regulator-allowed-modes'.

Since v2:
- Rename binding filename to 'richtek,rt6190.yaml'

---
 .../bindings/regulator/richtek,rt6190.yaml         | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
new file mode 100644
index 00000000..29f7d3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt6190.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT6190 4-Switch BuckBoost controller
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT6190 is 4-Switch BuckBoost controller designed for converting input
+  voltage to output voltage that can be equal to, higher or lower than input
+  voltage. It operates with wide input voltage range from 4.5V to 36V, and
+  the output voltage can be set from 3V to 36V by external FB pin. It's commonly
+  used for the application like as BuckBoost bus supply, docking station and USB
+  power delivery product.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT6190/DS6190-02.pdf
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt6190
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  regulator-allowed-modes:
+    description: |
+      buck allowed operating mode
+        0: PSM mode (light load Power Saving Mode)
+        1: FCCM mode (Forced-CCM mode)
+    maxItems: 2
+    items:
+      enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulator@2c {
+        compatible = "richtek,rt6190";
+        reg = <0x2c>;
+        wakeup-source;
+        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
+        enable-gpios = <&gpio26 1 GPIO_ACTIVE_HIGH>;
+        regulator-name = "richtek,rt6190-buckboost";
+        regulator-min-microvolt = <3000000>;
+        regulator-max-microvolt = <32000000>;
+        regulator-min-microamp = <306000>;
+        regulator-max-microamp = <12114000>;
+        regulator-allowed-modes = <0 1>;
+      };
+    };
-- 
2.7.4

