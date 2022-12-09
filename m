Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B417648790
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiLIRRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLIRQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:16:44 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01E342F74;
        Fri,  9 Dec 2022 09:16:42 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-12c8312131fso505527fac.4;
        Fri, 09 Dec 2022 09:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUCMEPAc0ItYMidHL9pJyPU9zA5x1vxWVmNffFo1fys=;
        b=sSV5Tj7SCvLVgyeI2yneDsEINJxCTXDGS40fPUdEqWM1AhE2hmJov/CktMNcvR1mNp
         KjfR3k2KBXW2mdfnOFiVNLE+msZ6emPQBKSzd+8FBCwN19OIyHLSJ3oTQ1LBVp+WQGzc
         4JHXB+ArveKS0T5b8d1LQ4alq883wqRXZuPGokcYd/+4bYXJf8n4LGGEGlenUfhu0SRH
         tjrOen1mtiOm0QudZq8/aMjdDiGVHUWqyAmqhekmezxKElPasj9sckmB7gKWaI2eTMq4
         qKzdj2In/DwvzSaHTBwv/74G4Zhbq4xf/mhA+KI6njSrEtTdc/nvqLdjzJQzXjpsvkGC
         +T4w==
X-Gm-Message-State: ANoB5pmnFUX6dl58eVV221cyYbXhvkKec1tPlZN98PUavUvmMyVE4ZT+
        Xr20DZ3vNRiNsx2EjBt0lQ==
X-Google-Smtp-Source: AA0mqf5of9ZqjvJRAqGzwiCMU4zgKpQoFemTMBz1C0EKlNbMdFAmXu+bSrIEBJ+tAnAdNZyyx40bPA==
X-Received: by 2002:a05:6870:3d8d:b0:144:a9ea:ba9f with SMTP id lm13-20020a0568703d8d00b00144a9eaba9fmr3370140oab.58.1670606201915;
        Fri, 09 Dec 2022 09:16:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b10-20020a4ad88a000000b004908a9542f8sm599624oov.31.2022.12.09.09.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:16:41 -0800 (PST)
Received: (nullmailer pid 3351734 invoked by uid 1000);
        Fri, 09 Dec 2022 17:16:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: Convert Synquacer EXIU to DT schema
Date:   Fri,  9 Dec 2022 11:16:36 -0600
Message-Id: <20221209171636.3351602-1-robh@kernel.org>
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

Convert the Socionext Synquacer EXIU interrupt controller to DT schema
format.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../socionext,synquacer-exiu.txt              | 31 -----------
 .../socionext,synquacer-exiu.yaml             | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt b/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt
deleted file mode 100644
index dac0846fe789..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Socionext SynQuacer External Interrupt Unit (EXIU)
-
-The Socionext Synquacer SoC has an external interrupt unit (EXIU)
-that forwards a block of 32 configurable input lines to 32 adjacent
-level-high type GICv3 SPIs.
-
-Required properties:
-
-- compatible           : Should be "socionext,synquacer-exiu".
-- reg                  : Specifies base physical address and size of the
-                         control registers.
-- interrupt-controller : Identifies the node as an interrupt controller.
-- #interrupt-cells     : Specifies the number of cells needed to encode an
-                         interrupt source. The value must be 3.
-- socionext,spi-base   : The SPI number of the first SPI of the 32 adjacent
-                         ones the EXIU forwards its interrups to.
-
-Notes:
-
-- Only SPIs can use the EXIU as an interrupt parent.
-
-Example:
-
-	exiu: interrupt-controller@510c0000 {
-		compatible = "socionext,synquacer-exiu";
-		reg = <0x0 0x510c0000 0x0 0x20>;
-		interrupt-controller;
-		interrupt-parent = <&gic>;
-		#interrupt-cells = <3>;
-		socionext,spi-base = <112>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.yaml b/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.yaml
new file mode 100644
index 000000000000..a0d65022f07b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/socionext,synquacer-exiu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext SynQuacer External Interrupt Unit (EXIU)
+
+maintainers:
+  - Ard Biesheuvel <ardb@kernel.org>
+
+description: |+
+  The Socionext SynQuacer SoC has an external interrupt unit (EXIU)
+  that forwards a block of 32 configurable input lines to 32 adjacent
+  level-high type GICv3 SPIs.
+
+properties:
+  compatible:
+    const: socionext,synquacer-exiu
+
+  reg:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 3
+
+  interrupt-controller: true
+
+  socionext,spi-base:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The SPI number of the first SPI of the 32 adjacent ones the
+      EXIU forwards its interrups to.
+
+required:
+  - compatible
+  - reg
+  - '#interrupt-cells'
+  - interrupt-controller
+  - socionext,spi-base
+
+unevaluatedProperties: false
+examples:
+  - |
+
+    interrupt-controller@510c0000 {
+        compatible = "socionext,synquacer-exiu";
+        reg = <0x510c0000 0x20>;
+        interrupt-controller;
+        interrupt-parent = <&gic>;
+        #interrupt-cells = <3>;
+        socionext,spi-base = <112>;
+    };
+...
-- 
2.35.1

