Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4103620911
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiKHFtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbiKHFtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:49:16 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6262CE35;
        Mon,  7 Nov 2022 21:49:15 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id b185so12868907pfb.9;
        Mon, 07 Nov 2022 21:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+TEMXtlD8IfIyObCOJOIDxMSfmiP50ZU+lxr4CNSac=;
        b=CcQIEsSxAgnaDV9YBaCU1fDGSrUS6pW2uZRJ3AD00icgA++4VKFKINOLqavdCpCABB
         L4nTKwO/HCbVxn3WT1SyJqdiOsdcPHaVxeIOi3DqkK+5EYFqjm/BAbmGb2RSyQVDuoIb
         9BOT28yijRefEvTQjer9WvbzwPHnHcfiMgT6/TgQn9gOQFJ8UjUv1S8wVjoYdXs2ZMvd
         RSL6VJX+qKcsP7pjXHjeQ5OuU6kFBBEQrodWF6XC/RVz42MCt4zCTmyA8seRv6/0oBov
         Mzw9wDOuTTZGUlAMKruN6cNvBrAUSj/Wniel7maA253nj84vr8HuQDJ7s5OU7kk9ub98
         nE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+TEMXtlD8IfIyObCOJOIDxMSfmiP50ZU+lxr4CNSac=;
        b=dMZXey/6ZgJVymZb0eGTaXgssPDmNA7JnuW2q8wuZA+1yxvlfxTJYAszdS8HfGMhq7
         UlVCJrEELnAlVqvmUzT9z4ZyRm/nIMdeZ/WV9aPLWJNXRSn/2oM2dv2O6IJkr5ozJKay
         NAq1e83FFDRIKmus1MwNrmeT37yyhWkTgV+OWKMoySlyRNAm6gh5hPr+Y/Vw3u1ixM/G
         FJyjSBMLnQB0WnS3+OKeszMBxckMY396DEVc7tDfETeGIHzjm+R/chwBZ/en/wa0uqg8
         pmuaK6a3I65Y8P5AR7mcpynCtoQJepqRzKx5fFBA/AM8Uq0g7FghT/tUdYRSB4IaZE7x
         e1Zw==
X-Gm-Message-State: ACrzQf1MiB+lQiT2VaAMlLrXUu/5DDMl63oTaSGw2LJucM2PwOUxSO+h
        mV/u9RTqZuNz3gC2B5CufGM8htVEZQ6syw==
X-Google-Smtp-Source: AMsMyM5wwYDaJS0QuGOlY/cl92Sc1KQDTLcZLhFoDIpjzqmj8d3NoKSZeaMwjwf6S9MRqr4Xlcs6wA==
X-Received: by 2002:a63:ce0f:0:b0:46f:868f:291 with SMTP id y15-20020a63ce0f000000b0046f868f0291mr43886877pgf.23.1667886554725;
        Mon, 07 Nov 2022 21:49:14 -0800 (PST)
Received: from RD-3580-24288.rt.l (42-72-183-173.emome-ip.hinet.net. [42.72.183.173])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7982a000000b005618189b0ffsm5482163pfl.104.2022.11.07.21.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 21:49:14 -0800 (PST)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 RESEND 1/3] dt-bindings: power: supply: Add Richtek RT9467 battery charger
Date:   Tue,  8 Nov 2022 13:48:52 +0800
Message-Id: <9015389176cd56328256511106bae0060c63b809.1667886055.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667886055.git.chiaen_wu@richtek.com>
References: <cover.1667886055.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiaEn Wu <chiaen_wu@richtek.com>

Add bindings for the Richtek RT9467 battery charger.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../power/supply/richtek,rt9467-charger.yaml  | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
new file mode 100644
index 000000000000..92c570643d2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9467-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9467 Switching Battery Charger with Power Path Management
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+  - ChiaEn Wu <chiaen_wu@richtek.com>
+
+description: |
+  RT9467 is a switch-mode single cell Li-Ion/Li-Polymer battery charger for
+  portable applications. It integrates a synchronous PWM controller, power
+  MOSFETs, input current sensing and regulation, high-accuracy voltage
+  regulation, and charge termination. The charge current is regulated through
+  integrated sensing resistors.
+
+  The RT9467 also features USB On-The-Go (OTG) support. It also integrates
+  D+/D- pin for USB host/charging port detection.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9467/DS9467-01.pdf
+
+properties:
+  compatible:
+    const: richtek,rt9467-charger
+
+  reg:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  charge-enable-gpios:
+    description: GPIO is used to turn on and off charging.
+    maxItems: 1
+
+  usb-otg-vbus-regulator:
+    type: object
+    description: OTG boost regulator.
+    unevaluatedProperties: false
+    $ref: /schemas/regulator/regulator.yaml#
+
+    properties:
+      enable-gpios: true
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
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@5b {
+        compatible = "richtek,rt9467-charger";
+        reg = <0x5b>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
+        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_LOW>;
+
+        rt9467_otg_vbus: usb-otg-vbus-regulator {
+          regulator-name = "rt9467-usb-otg-vbus";
+          regulator-min-microvolt = <4425000>;
+          regulator-max-microvolt = <5825000>;
+          regulator-min-microamp = <500000>;
+          regulator-max-microamp = <3000000>;
+        };
+      };
+    };
-- 
2.25.1

