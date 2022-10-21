Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF2606DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJUClN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJUClJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:41:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8231552C3;
        Thu, 20 Oct 2022 19:41:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pq16so1197548pjb.2;
        Thu, 20 Oct 2022 19:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1igaToWHGa/ZVBMzfJ2iNTyAvxjJ+/zHF5jCtA6H1bQ=;
        b=gOVdSMJ4KLZ3q0s8/cfxgWj63uoRxuj0hp6pXty3G8nhCsCq8jLjWFoHWjxZRpg8wT
         rCvQTf1Shd8lv2Lp2ofOBVtIrvOvr+eAMR+xySLbHGbrViTehscyXlrUhLF/0C4m/+iu
         EKBcw5gJqBmurqiOulQFxVkRjlJfe/XHX0/KeuREOusQijLVxkV4ZwiLghsBFEjW3Q8m
         blLfZons0h/5fcNhd4MC0pwqcZltID1X/jb+KSWy6ph9cwdjlC0HODz4TXL/5iZZf9ph
         i9vZIWk8BrDeLSl4rDUOp3LlE/6pDXO/ssTKjP8L0LX16q3aMf4xaQs67rBInbro3ucJ
         KF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1igaToWHGa/ZVBMzfJ2iNTyAvxjJ+/zHF5jCtA6H1bQ=;
        b=6vd+GwRIZufvYCQr5ujQcHWFIls1ub9nbp/qUx6ICrrlveWJGpQ1I76pbttRdLzswg
         FSqkXtnnyz2i/2FMbmFINQctt2zdksMG/IByoB3lUg2Q9xbcSG+AKjEpF72WAhG2rfX3
         /Jd+WOBFQYPSnXCeHiRBStjrKVZqDdw1k8viSMbK4CKmvLddgIgjmDPRXL5a83SPSOXW
         nGAwUvFNXD/STwbOb7Gltd79Vva5COUoV4g/VSJ9QgOAi7s1R8mMWSt103WHlPNhzbq1
         GUGIdcOfSx8jabMMthqMUxGf3DcoCQkwXxNeuMe5/REwHBh7/nw0kZ224F4A2bYyoWIc
         UrWg==
X-Gm-Message-State: ACrzQf1ZDjIJ/vF4bT05H509pdwuCg/32Fi3ivT+QMeJErp3s/xWKaRO
        2rNsK8z9iGYBnbjMMRAISThLJkfQV0I=
X-Google-Smtp-Source: AMsMyM4J47OkjJC1EdKfdx9ZPQ+UghbHBmTz7ZBA2NyYMCHYNFXvDCclwK+iL6OAgCUEVQ4KeKzlng==
X-Received: by 2002:a17:902:cecd:b0:185:46d3:8cad with SMTP id d13-20020a170902cecd00b0018546d38cadmr16883660plg.83.1666320067940;
        Thu, 20 Oct 2022 19:41:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:b022:150a:a87e:ab3a:9736])
        by smtp.gmail.com with ESMTPSA id a19-20020aa794b3000000b0053e42167a33sm14033023pfl.53.2022.10.20.19.41.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 19:41:07 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: regulator: Add bindings for Richtek RT6190 regulator
Date:   Fri, 21 Oct 2022 10:40:58 +0800
Message-Id: <1666320059-17544-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666320059-17544-1-git-send-email-u0084500@gmail.com>
References: <1666320059-17544-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add devicetree binding for Richtek RT6190 4-Switch buckboost controller.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v2:
- Rename binding filename to 'richtek,rt6190.yaml'

---
 .../bindings/regulator/richtek,rt6190.yaml         | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
new file mode 100644
index 00000000..dced404
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
@@ -0,0 +1,77 @@
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
+  used for the application like as BuckBoost bus upply, docking station and USB
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
+  enable-gpios: true
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

