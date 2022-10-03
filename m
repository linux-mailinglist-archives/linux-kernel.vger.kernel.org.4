Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7F5F2E76
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiJCJtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiJCJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:49:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F330623BC1;
        Mon,  3 Oct 2022 02:48:24 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 3so9256213pga.1;
        Mon, 03 Oct 2022 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=5mygVAeb+okazNpWHFc/r08PAR7GJtsUFHb0BZGcCrE=;
        b=fKZz+gyjMuV4SPTx9NYFvn+UaPPwf8HEWHFZiz6j4WGgI6tSe3d+2dgFYOlF3+UNnE
         aMzFMt2AHae9F4Z5S78lpi8RQgUPd4Mn/i2PuxEzgY+YqTKhVX8zFbPSPcSZl4u35dG1
         FK4lkEuGppuPBliAWo0sGAuVtkGew5OysEDR5Nmh2eQuB5m1VhULy1SyYvgd83lRoCvn
         rYVq01pvspk+xpVUlqMTq1tmEjHRI+l53M+nbll3G4tQ6g7Q9EYh8rkfUppZ70JOSB2C
         9Dv4WDX6r65N5U61bljfQbrH5W4pDUO6fg8kL4qNgJ2yzGx8EqJ451aB5XTq5KFHwBH/
         IQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5mygVAeb+okazNpWHFc/r08PAR7GJtsUFHb0BZGcCrE=;
        b=lX7yRXORH4KHz7IKFuP67TrgJpEcJBoNfspTJn5d1kzPBlYZEKiO5OqmchWTyEwtsK
         SJiyFgQ7mIrmo7EI7bGDSyGfYgHkw7NgcD304f9XLg4Z1GULSfEI8vJfXfm5jAgYveFa
         Rr49iMeTFMj8MkXWRgxFLkpVyMxRoNWZQcLipXGTxhde182zTKM0WbzwOkmmxhxZLq2n
         66dwW6BNuJk5H40efNGVJ1gWqyXc17TvRj6rUYEXwqzYzgU5q27MSvhHiZvFHeHcp+iZ
         LHtmuWwECsj/wy+LHjGRJPcF4KdPQdi/lmLKPtqdFc89cXZ6Qk5Uj5FshRz7EuhZOLfx
         fiaw==
X-Gm-Message-State: ACrzQf3WC8IlxM696y+54aPp7aodJFWCp+M9sq/GRnSbaXz91JF2PPhi
        7OsVLMoETpR9/Ef/6GDjcCM=
X-Google-Smtp-Source: AMsMyM6eVqjl/kWPW/aXnWjlEHGfqllxRco7+xY4afM+K6UZUrXP++why0HwrzQE0dtgD+ZZQqkMfg==
X-Received: by 2002:a65:4048:0:b0:441:85ee:7a6a with SMTP id h8-20020a654048000000b0044185ee7a6amr13614459pgp.39.1664790503137;
        Mon, 03 Oct 2022 02:48:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:da00:1dbc:8208:4596:9e9c])
        by smtp.gmail.com with ESMTPSA id t23-20020a6564d7000000b0043014f9a4c9sm6142230pgv.93.2022.10.03.02.48.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2022 02:48:22 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     cy_huang@richtek.com, allen_chiang@richtek.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: power: supply: Add Richtek RT9759 smart cap divider charger
Date:   Mon,  3 Oct 2022 17:48:11 +0800
Message-Id: <1664790493-16386-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664790493-16386-1-git-send-email-u0084500@gmail.com>
References: <1664790493-16386-1-git-send-email-u0084500@gmail.com>
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

Add bindings for the Richtek RT9759 smart cap divider charger.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../bindings/power/supply/richtek,rt9759.yaml      | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
new file mode 100644
index 00000000..04fc6b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9759.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9759 Smart Cap Divider Charger
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT9759 is a high efficiency and high charge current charger.
+  The efficiency is up to 97.8% when VBAT = 4.2V, IBAT = 2.5A and the maximum
+  charge current is up to 8A. The device integrates smart cap divider topology
+  with dual phase charge pump core. The ADCs provide input and output voltage,
+  current and temperature information to monitor the whole charging process.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9759/DS9759-02.pdf
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt9759
+
+  reg:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description: Battery current sense resistor mounted.
+    default: 2000
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@66 {
+        compatible = "richtek,rt9759";
+        reg = <0x66>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_EDGE_FALLING>;
+        shunt-resistor-micro-ohms = <5000>;
+      };
+    };
-- 
2.7.4

