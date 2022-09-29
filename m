Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D365EF39B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiI2KiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiI2KiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:38:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860B1432A4;
        Thu, 29 Sep 2022 03:37:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w2so1108868pfb.0;
        Thu, 29 Sep 2022 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jx8RfvPDI5yD/Mm9JzciycnHCqW+XwB94MO7H+ntjuY=;
        b=SWhwwKjKmXIrvUCxy4ozDdsSFugPu9oEBWx7DvF8PItOW2DM0VdrTAAEnG8vWux6ZU
         MMdyjwGUnZYBae9KCi3VzlQ1qFMPrG0IqcEbpgTSGTHwAgW+s4xBrQu4UklerI8CFxny
         k1r0wFIzp5bwFZK4H/+tdBk5TVYqfS/3VoGjj9UoPeHtMn9B2HZSsoIuVjpMPNFq5xWl
         nZ9znIwJ4+XQDocARrX+RLyNr4VdwKs81tqUpZRVWoIlJCT8hXNU3dHKS9LDNuX/wX2N
         nc9jKQH+mQcqB2Ux+4IyByA9xD5TtrPr1nNWB8mtMVsBePDXD1kPJgpT5UziJjAgvTNp
         5ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jx8RfvPDI5yD/Mm9JzciycnHCqW+XwB94MO7H+ntjuY=;
        b=2AE/PDgWmi/BjDHNfLfQHVNJDAk3KItuvxcCndYsLdqExm7N4ucmd5C+pFfQvMMhsG
         e6YMGMa+nicEZmv9544Ks8EiYGjP4EZcVGYMHk8klr8q8D10oXmlySYifOViLdDJ5VMA
         wMfvxF8QDduk78/uZll4+Ec2VipIzv4KaSxX3slQF14207KYR7L2fHT6aMp/ySXxrq3J
         luzyoNxUjG4WPHmnDxoyjcf2OcxZBRoD4OmDvc4mQ/npxFWuQRIDI3lYZcQANQCIoe7x
         IQOjSG2LwcxBjjj0J2gdmh3lC/UCt/s7/BgSuktcFTRyhTq2YXury3Jql6z0zAeHNbNe
         ZubQ==
X-Gm-Message-State: ACrzQf2Pu8sEr3sYhnerMFGZCPgljISAzqhBut/fDv4TsW2WLa6O+zHh
        VaE+DIriQZxXWgzu9PSzF3k=
X-Google-Smtp-Source: AMsMyM4YaqsrlKluOMYl5MiaoDCyBo89zfaC6jDwYKbRIwozxVm1bOsH79k//0+WhP4IwU67A3nwiQ==
X-Received: by 2002:a63:e452:0:b0:42c:60ce:8b78 with SMTP id i18-20020a63e452000000b0042c60ce8b78mr2296513pgk.453.1664447879407;
        Thu, 29 Sep 2022 03:37:59 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-73-54.emome-ip.hinet.net. [42.73.73.54])
        by smtp.gmail.com with ESMTPSA id k31-20020a17090a4ca200b001ef81574355sm3145861pjh.12.2022.09.29.03.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:37:59 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: power: supply: Add Richtek RT9467 battery charger
Date:   Thu, 29 Sep 2022 18:37:19 +0800
Message-Id: <2590163cabaef9ece537c5453eeef9f259e56cef.1664475743.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664475743.git.chiaen_wu@richtek.com>
References: <cover.1664475743.git.chiaen_wu@richtek.com>
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

Co-developed-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../power/supply/richtek,rt9467-charger.yaml       | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
new file mode 100644
index 0000000..874bd01
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
@@ -0,0 +1,83 @@
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
+      enable-gpios:
+        maxItems: 1
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
+      rt9467@5b {
+        compatible = "richtek,rt9467-charger";
+        reg = <0x5b>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
+        charge-enable-gpios = <&gpio26 1 0>;
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
2.7.4

