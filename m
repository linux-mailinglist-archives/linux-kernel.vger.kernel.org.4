Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D0A5F5BAC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiJEV0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJEV0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:26:42 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E2B6292C;
        Wed,  5 Oct 2022 14:26:41 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id w70so4872852oie.2;
        Wed, 05 Oct 2022 14:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xTAUGvQFV5dOfW+1G7/dUfNq1caWoLnlGaJPpXqOts=;
        b=mOOhvvOAqkWr2ul3bUmesXcHBH761tLVLz/Q4dE5WH4THtvJ/97V+nq+79uP0/lGrP
         mOwrzGJlTeUeBRbueQF32x/XSHaFvDyHtFQX9FEBZuIe9IwaurZHWxXG20OJeh/jjSJm
         OagfjfF/WDnd5VRSS2n25kWKnbyNaewfyKiQyrnpVHDfc2WcbNWe1qWKJjpUYwPL1/8T
         0lrBmq4KDR/NGoAcdywxKTTlgAjs7O5YgulVmukLZ4P6A9yCtCK95L7UQvE2FbV+LOjA
         yVSVopmgIeZ848U8b99KIk3xL2uVCX9E/v5SvwY0s6LyW2mZokt5VDX5KOlS7f7fKeQD
         +nnw==
X-Gm-Message-State: ACrzQf3XbTWo2MScYJUVrUkEdQM+ziUmQ/spCTxsZWgMI2353o5Hxz9k
        IY0Gm2/67iZh2tw1BUuGFw==
X-Google-Smtp-Source: AMsMyM7DsNQswsQGbYuUgMMC4zg/a9tHbi3BPyQPXvPExzfujz79SgKUqYx5TQQdTKa89CvFT0Oa1w==
X-Received: by 2002:a05:6808:190e:b0:350:4905:734c with SMTP id bf14-20020a056808190e00b003504905734cmr3414960oib.158.1665005200902;
        Wed, 05 Oct 2022 14:26:40 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i205-20020acaead6000000b00353ef11d6c9sm1815744oih.19.2022.10.05.14.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 14:26:39 -0700 (PDT)
Received: (nullmailer pid 122305 invoked by uid 1000);
        Wed, 05 Oct 2022 21:26:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: misc: Convert IDT 89HPESx to DT schema
Date:   Wed,  5 Oct 2022 16:26:31 -0500
Message-Id: <20221005212631.122145-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the IDT 89HPESx device binding to DT schema format.

"onsemi,24c64" was not a documented compatible string, so update the
example to "atmel,24c64". It's not clear what's in use here as no
upstream dts files have the eeprom child node.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Serge, Okay with dual licensing?
---
 .../devicetree/bindings/misc/idt,89hpesx.yaml | 72 +++++++++++++++++++
 .../devicetree/bindings/misc/idt_89hpesx.txt  | 44 ------------
 2 files changed, 72 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/idt,89hpesx.yaml
 delete mode 100644 Documentation/devicetree/bindings/misc/idt_89hpesx.txt

diff --git a/Documentation/devicetree/bindings/misc/idt,89hpesx.yaml b/Documentation/devicetree/bindings/misc/idt,89hpesx.yaml
new file mode 100644
index 000000000000..452236e79354
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/idt,89hpesx.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/idt,89hpesx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EEPROM / CSR SMBus-slave interface of IDT 89HPESx devices
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        pattern: '^idt,89hpes'
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - pattern: '^idt,89hpes(8nt2|12nt3|12n3a?|24n3a?|(12|24)t3g2|4t4g2|10t4g2|[56]t5|8t5a?)$'
+      - pattern: '^idt,89hpes(6t6g2|16t7|(24t6|32t8|48t12|16t4a?)(g2)?)$'
+      - pattern: '^idt,89hpes(24nt6a|32nt8[ab]|12nt12|16nt16|24nt24|32nt24[ab])g2$'
+      - pattern: '^idt,89hpes((32h8|48h12a?|22h16|34h16|64h16a?)(g2)?|16h16)$'
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+  
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^eeprom@':
+    $ref: /schemas/eeprom/at24.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      compatible:
+        description: Only a subset of devices are supported
+        pattern: ',24c(32|64|128|256|512)$'
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        idt@74 {
+            compatible = "idt,89hpes32nt8ag2";
+            reg = <0x74>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            eeprom@50 {
+                compatible = "atmel,24c64";
+                reg = <0x50>;
+                read-only;
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/misc/idt_89hpesx.txt b/Documentation/devicetree/bindings/misc/idt_89hpesx.txt
deleted file mode 100644
index b9093b79ab7d..000000000000
--- a/Documentation/devicetree/bindings/misc/idt_89hpesx.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-EEPROM / CSR SMBus-slave interface of IDT 89HPESx devices
-
-Required properties:
-  - compatible : should be "<manufacturer>,<type>"
-		 Basically there is only one manufacturer: idt, but some
-		 compatible devices may be produced in future. Following devices
-		 are supported: 89hpes8nt2, 89hpes12nt3, 89hpes24nt6ag2,
-		 89hpes32nt8ag2, 89hpes32nt8bg2, 89hpes12nt12g2, 89hpes16nt16g2,
-		 89hpes24nt24g2, 89hpes32nt24ag2, 89hpes32nt24bg2;
-		 89hpes12n3, 89hpes12n3a, 89hpes24n3, 89hpes24n3a;
-		 89hpes32h8, 89hpes32h8g2, 89hpes48h12, 89hpes48h12g2,
-		 89hpes48h12ag2, 89hpes16h16, 89hpes22h16, 89hpes22h16g2,
-		 89hpes34h16, 89hpes34h16g2, 89hpes64h16, 89hpes64h16g2,
-		 89hpes64h16ag2;
-		 89hpes12t3g2, 89hpes24t3g2, 89hpes16t4, 89hpes4t4g2,
-		 89hpes10t4g2, 89hpes16t4g2, 89hpes16t4ag2, 89hpes5t5,
-		 89hpes6t5, 89hpes8t5, 89hpes8t5a, 89hpes24t6, 89hpes6t6g2,
-		 89hpes24t6g2, 89hpes16t7, 89hpes32t8, 89hpes32t8g2,
-		 89hpes48t12, 89hpes48t12g2.
-  - reg :	 I2C address of the IDT 89HPESx device.
-
-Optionally there can be EEPROM-compatible subnode:
-  - compatible:  There are five EEPROM devices supported: 24c32, 24c64, 24c128,
-		 24c256 and 24c512 differed by size.
-  - reg:         Custom address of EEPROM device (If not specified IDT 89HPESx
-    (optional)	 device will try to communicate with EEPROM sited by default
-		 address - 0x50)
-  - read-only :	 Parameterless property disables writes to the EEPROM
-    (optional)
-
-Example:
-	idt@60 {
-		compatible = "idt,89hpes32nt8ag2";
-		reg = <0x74>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		eeprom@50 {
-			compatible = "onsemi,24c64";
-			reg = <0x50>;
-			read-only;
-		};
-	};
-
-- 
2.35.1

