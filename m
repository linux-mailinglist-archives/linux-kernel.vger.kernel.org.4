Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C226057C2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJTG5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJTG5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:57:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FAA12791D;
        Wed, 19 Oct 2022 23:57:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l4so19462101plb.8;
        Wed, 19 Oct 2022 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o9QEkVTNvZxbjrViQWFpsEggxeQOyWtEOepfRN2hpAo=;
        b=kiuT10Hvav045F25AT0vhDVgc6hpMQqJO0FJCBvetAv4v+xI7sOmZLwWBDPs690t8S
         CHidmb60IrxDExOOART+3+8d1iOgfFsDDLNkQOwhfY5oAFjNrFB81fy2xqB/rzsyh8iN
         AaPl3EkuPDDXE4lHfH8rjVNtfh70+QewsFhScPFVaDT0vqEW9IGGGqkG3qQo8aEj0yam
         g/k2YfT8ZzmR+tJwhSFxkQ7FbaiCyNSocEH+DnEAsYVckvyLHZDi9k+ORnHQmg0lE/Yn
         5Fzm8+QLCcDNyiyvk+7qhSCJfZ8rgA9nAqx5zkGaumF3cFHBm6K+wg5GDLwxtVX5Rp0d
         Ztaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9QEkVTNvZxbjrViQWFpsEggxeQOyWtEOepfRN2hpAo=;
        b=PvodPLBkOPPgcdwtLSXIko3GeYDCJc1iUYyvy1KXptG906zkqIE1mgLqYVJd1ieAjc
         PEVvqogledpqhCCQhrL4MDvRHcO60cc8kmgFoECu0KZgdCUWuSD4ulgS1JiEZFPAQiG3
         hESF4TL5JUilZ+g0h9gIAxocLB+0d2m5xrRcBfdHgjDeSvptWJbvkI9l7LGW2+cXEGEq
         N2zlvISviN3d9CdcnYqzHttKruRTHlwWE52/1IObUsOo+Eoqq6l1no0Hi8Ejy9zFnbSy
         VJ0S86Jv+ya0rqQXBsLbZtKxrYhncK12zIdgakxIkbTb7DERIZXD+vAtoeW/kBSmnlq7
         8CMw==
X-Gm-Message-State: ACrzQf35DzeQW3921DzZn4i9ZuwDsX2R4DThwEjGXSioAC+SBJlDS6Dc
        RGLmoMlBZXKThIVaQ5xEbXA=
X-Google-Smtp-Source: AMsMyM40yMUrWiyDTQ5WLKyTqk++kmoroW4+j1kWkIE/9dffMnftHGeLDzgAnyDdSajaNOi+1CbbWQ==
X-Received: by 2002:a17:90a:d917:b0:212:a8e4:8a44 with SMTP id c23-20020a17090ad91700b00212a8e48a44mr123880pjv.2.1666249043662;
        Wed, 19 Oct 2022 23:57:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:a12c:444a:ed28:4831:fc95])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902ea0900b001786b712bf7sm989952plg.151.2022.10.19.23.57.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2022 23:57:23 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek RT6190 regulator
Date:   Thu, 20 Oct 2022 14:57:12 +0800
Message-Id: <1666249033-12219-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666249033-12219-1-git-send-email-u0084500@gmail.com>
References: <1666249033-12219-1-git-send-email-u0084500@gmail.com>
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
 .../regulator/richtek,rt6190-regulator.yaml        | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6190-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6190-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6190-regulator.yaml
new file mode 100644
index 00000000..be0fa7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt6190-regulator.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt6190-regulator.yaml#
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

