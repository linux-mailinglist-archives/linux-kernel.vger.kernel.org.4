Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F91564878F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLIRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLIRQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:16:38 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A14C251;
        Fri,  9 Dec 2022 09:16:34 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-144b21f5e5fso462946fac.12;
        Fri, 09 Dec 2022 09:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT7n1C9HDmnfsMXK1UZuW3ewHAZmx+WKrb59B2B6QMA=;
        b=f46QawZYXSrQ0PusiWjBuUfDYHaMVJJmI5cdhCneih3pzc5gmjt8Z849nYmtr/kDj8
         S44yowASsbH8II0FNQvFfwevLNjdvpT9tKtvv44/E2qz6ksQO1Pc6NoLZ1/CI0ju7RUT
         Z1a3zhG5ka0i5YInu3y3CjAiTJ2wckL+6Fan+EpRGp5qzczeNEmvskTi1uS0a8vGAXU7
         iXkk0UMO8YKm8vpfxTnBq8R9UjtYvmS5/5NN5i7apDDSurjYFXCZ2DUi+DSzqMN9Gb0+
         WFCaz06yZNlFwhaAGMnf4SecD0P57OCNQ86DhQTlDXW5p97cMlSdscmPZvt+9FNoCsrA
         Dslg==
X-Gm-Message-State: ANoB5plCAJRdlFMrXfhUBePj/g8SsznDml+cISl/w8+y+TI6KAaG01A+
        9AeEQ8OwQbXoTwvRXq9ukg==
X-Google-Smtp-Source: AA0mqf4HrdS5onXU+aUkto9dfahliOHsa9I12pdQqETUJZeqoXQjSEDFdvR+RaBO4mKtfpdT29vIZQ==
X-Received: by 2002:a05:6870:4624:b0:13c:5f3:c24f with SMTP id z36-20020a056870462400b0013c05f3c24fmr4362920oao.7.1670606193889;
        Fri, 09 Dec 2022 09:16:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l20-20020a056870205400b001438fb3b0a0sm1068668oad.44.2022.12.09.09.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:16:33 -0800 (PST)
Received: (nullmailer pid 3351538 invoked by uid 1000);
        Fri, 09 Dec 2022 17:16:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio: Convert Fujitsu MB86S7x GPIO to DT schema
Date:   Fri,  9 Dec 2022 11:16:28 -0600
Message-Id: <20221209171629.3351420-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Fujitsu MB86S7x GPIO binding to DT schema format.

The "socionext,synquacer-gpio" compatible was not documented, but is
compatible with "fujitsu,mb86s70-gpio" and is in use (in u-boot
Synquacer dts).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/gpio/fujitsu,mb86s70-gpio.txt    | 20 --------
 .../bindings/gpio/fujitsu,mb86s70-gpio.yaml   | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt b/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
deleted file mode 100644
index bef353f370d8..000000000000
--- a/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Fujitsu MB86S7x GPIO Controller
--------------------------------
-
-Required properties:
-- compatible: Should be "fujitsu,mb86s70-gpio"
-- reg: Base address and length of register space
-- clocks: Specify the clock
-- gpio-controller: Marks the device node as a gpio controller.
-- #gpio-cells: Should be <2>. The first cell is the pin number and the
-  second cell is used to specify optional parameters:
-   - bit 0 specifies polarity (0 for normal, 1 for inverted).
-
-Examples:
-	gpio0: gpio@31000000 {
-		compatible = "fujitsu,mb86s70-gpio";
-		reg = <0 0x31000000 0x10000>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		clocks = <&clk 0 2 1>;
-	};
diff --git a/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.yaml b/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.yaml
new file mode 100644
index 000000000000..d18d95285465
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/fujitsu,mb86s70-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fujitsu MB86S7x GPIO Controller
+
+maintainers:
+  - Jassi Brar <jaswinder.singh@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: socionext,synquacer-gpio
+          - const: fujitsu,mb86s70-gpio
+      - const: fujitsu,mb86s70-gpio
+
+  reg:
+    maxItems: 1
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-controller: true
+  gpio-line-names: true
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#gpio-cells'
+  - gpio-controller
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio@31000000 {
+        compatible = "fujitsu,mb86s70-gpio";
+        reg = <0x31000000 0x10000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        clocks = <&clk 0 2 1>;
+    };
+...
-- 
2.35.1

