Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39B574B87E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjGGVHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGGVHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:07:04 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B382696;
        Fri,  7 Jul 2023 14:07:01 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-345f1e0abf9so8764455ab.3;
        Fri, 07 Jul 2023 14:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764021; x=1691356021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+0fMWDG+4t53Of0wn+p5L3a9T2rXQdBwF9pV7SZhak=;
        b=Kq+SClOpIgY/DK0hHqnnTzAQfrjDWHe194ywvOt2FDZHFn6YjVi4E14VdXsb6HaY7g
         Yy0OWvTRW2Bqvcc7gqz0YRQbvhjbvhITkIxvuvZ5tBLJQY681fgkxTo0nz8mobXgvXFA
         9DBaQdI9z9jEqeYrekmG9PBZx7WbYqjfwl/dDMCkT2Ptyl/S56Hk6aaSoL60qGcG4Dwt
         ZRHN98AQUQ0KQZRBbYda+d4YEfioCozIx+52Y5sHPUST0Ec+IyxAlaPXOmBF1q7LbzFM
         M27ka5IUdIB9/5Uh6GJaKEioVe+tOOociNOfqA5vy4Io/+/P/GMjb6Sn5iFp74bdawqG
         gXfA==
X-Gm-Message-State: ABy/qLY+ND8qcp50QU+8dJt2Lvv66qM1EOI1gXoXwNFB2ZkfODsl66wd
        WvN4YKQe9WYsgzRf+CB41g==
X-Google-Smtp-Source: APBJJlHImbGNK7xjpK4WXbh7gFvDm5zHGeWo8l7UZZYsVYEmBj/iD52Ih7d72XtKaNm2exieB/mg4Q==
X-Received: by 2002:a92:d40d:0:b0:33b:568a:2981 with SMTP id q13-20020a92d40d000000b0033b568a2981mr6161333ilm.8.1688764020857;
        Fri, 07 Jul 2023 14:07:00 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t13-20020a92c90d000000b00345b34fcf34sm1558335ilp.38.2023.07.07.14.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:07:00 -0700 (PDT)
Received: (nullmailer pid 869040 invoked by uid 1000);
        Fri, 07 Jul 2023 21:06:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Simon Shields <simon@lineageos.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: leds: Convert Panasonic AN30259A to DT schema
Date:   Fri,  7 Jul 2023 15:06:52 -0600
Message-Id: <20230707210653.868907-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Panasonic AN30259A 3-channel LED controller binding to DT
schema format.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/leds/leds-an30259a.txt           | 55 ------------
 .../bindings/leds/panasonic,an30259a.yaml     | 84 +++++++++++++++++++
 2 files changed, 84 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-an30259a.txt
 create mode 100644 Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-an30259a.txt b/Documentation/devicetree/bindings/leds/leds-an30259a.txt
deleted file mode 100644
index cbd833906b2b..000000000000
--- a/Documentation/devicetree/bindings/leds/leds-an30259a.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* Panasonic AN30259A 3-channel LED driver
-
-The AN30259A is a LED controller capable of driving three LEDs independently. It supports
-constant current output and sloping current output modes. The chip is connected over I2C.
-
-Required properties:
-	- compatible: Must be "panasonic,an30259a".
-	- reg: I2C slave address.
-	- #address-cells: Must be 1.
-	- #size-cells: Must be 0.
-
-Each LED is represented as a sub-node of the panasonic,an30259a node.
-
-Required sub-node properties:
-	- reg: Pin that the LED is connected to. Must be 1, 2, or 3.
-
-Optional sub-node properties:
-	- function :
-		see Documentation/devicetree/bindings/leds/common.txt
-	- color :
-		see Documentation/devicetree/bindings/leds/common.txt
-	- label :
-		see Documentation/devicetree/bindings/leds/common.txt (deprecated)
-	- linux,default-trigger :
-		see Documentation/devicetree/bindings/leds/common.txt
-
-Example:
-
-#include <dt-bindings/leds/common.h>
-
-led-controller@30 {
-	compatible = "panasonic,an30259a";
-	reg = <0x30>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	led@1 {
-		reg = <1>;
-		linux,default-trigger = "heartbeat";
-		function = LED_FUNCTION_INDICATOR;
-		color = <LED_COLOR_ID_RED>;
-	};
-
-	led@2 {
-		reg = <2>;
-		function = LED_FUNCTION_INDICATOR;
-		color = <LED_COLOR_ID_GREEN>;
-	};
-
-	led@3 {
-		reg = <3>;
-		function = LED_FUNCTION_INDICATOR;
-		color = <LED_COLOR_ID_BLUE>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml b/Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml
new file mode 100644
index 000000000000..f55f8c232bc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/panasonic,an30259a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Panasonic AN30259A 3-channel LED controller
+
+maintainers:
+  - Simon Shields <simon@lineageos.org>
+
+description:
+  The AN30259A is a LED controller capable of driving three LEDs independently.
+  It supports constant current output and sloping current output modes. The chip
+  is connected over I2C.
+
+properties:
+  compatible:
+    const: panasonic,an30259a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[1-3]$":
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [ 1, 2, 3 ]
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@30 {
+            compatible = "panasonic,an30259a";
+            reg = <0x30>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            led@1 {
+                reg = <1>;
+                linux,default-trigger = "heartbeat";
+                function = LED_FUNCTION_INDICATOR;
+                color = <LED_COLOR_ID_RED>;
+            };
+
+            led@2 {
+                reg = <2>;
+                function = LED_FUNCTION_INDICATOR;
+                color = <LED_COLOR_ID_GREEN>;
+            };
+
+            led@3 {
+                reg = <3>;
+                function = LED_FUNCTION_INDICATOR;
+                color = <LED_COLOR_ID_BLUE>;
+            };
+        };
+    };
+...
-- 
2.40.1

