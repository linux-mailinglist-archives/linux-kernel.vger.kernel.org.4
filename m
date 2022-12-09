Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F752648792
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiLIRRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiLIRQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:16:58 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3163A48406;
        Fri,  9 Dec 2022 09:16:57 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id m204so5105164oib.6;
        Fri, 09 Dec 2022 09:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=373jG6KIJ+2uE1UbtRsBbApBUbmU4Os8skRmsDekqe4=;
        b=CVG/jdrOPROgvhqED2j5kqTHPnuTjJD9yXC96ULhGKBgUzYpy/b2PMoT8RrWD+kt20
         oTm4iugMNP/5nQpJdjTywJ0rZLNGmYt0WqvkHviHbL9u5nnqp2U0Zm6Xb38Wp/hteRer
         nZ0X6aHbWgFIj9e2EoWFuXus0SDdFbTJ2e/07VFoqsHDDzrg9LJ+MNwr1wHxvhOxFfrw
         QmfpEOH0NVElbj5KVXZgg+zSe2xgLN7Dws82+cN03Tb9km1cpRr+mt4aHrg/GGNYe7Wx
         Qi52JUi7o5OWIXHB8UcrYnUcMXHh9vT5qkklCMZIPe1311VkypJHc4m+NU9rIHwuOMAt
         w5OQ==
X-Gm-Message-State: ANoB5pnVrMDSkScFhsmrEjD9ejh1lEpdMtIazDcOthubJ04fw3gHCxD2
        Gh2+80VakEBYOv1M6w0dFh/LYhFPCg==
X-Google-Smtp-Source: AA0mqf72lUTpgl+w8YkV49W/DN78RxNkuEhI1Jry3u/tzoFI+CjfOYJtHgLIu2k+ZhV0fVSWzZoOpw==
X-Received: by 2002:a05:6808:1707:b0:35a:a868:df60 with SMTP id bc7-20020a056808170700b0035aa868df60mr2933773oib.56.1670606216405;
        Fri, 09 Dec 2022 09:16:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a9d3e0e000000b0066e868dbc2esm800991otd.46.2022.12.09.09.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:16:55 -0800 (PST)
Received: (nullmailer pid 3352066 invoked by uid 1000);
        Fri, 09 Dec 2022 17:16:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: Convert Synquacer SPI to DT schema
Date:   Fri,  9 Dec 2022 11:16:43 -0600
Message-Id: <20221209171644.3351787-1-robh@kernel.org>
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

Convert the Socionext Synquacer SPI binding to DT format.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/spi/socionext,synquacer-spi.yaml | 73 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-synquacer.txt | 27 -------
 MAINTAINERS                                   |  2 +-
 3 files changed, 74 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/socionext,synquacer-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt

diff --git a/Documentation/devicetree/bindings/spi/socionext,synquacer-spi.yaml b/Documentation/devicetree/bindings/spi/socionext,synquacer-spi.yaml
new file mode 100644
index 000000000000..45cbe744c7ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/socionext,synquacer-spi.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/socionext,synquacer-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext SynQuacer HS-SPI Controller
+
+maintainers:
+  - Masahisa Kojima <masahisa.kojima@linaro.org>
+  - Jassi Brar <jaswinder.singh@linaro.org>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: socionext,synquacer-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: core clock
+      - description: rate clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: iHCLK
+      - const: iPCLK
+
+  interrupts:
+    items:
+      - description: Receive Interrupt
+      - description: Transmit Interrupt
+      - description: Fault Interrupt
+
+  socionext,use-rtm:
+    type: boolean
+    description: Enable using "retimed clock" for RX
+
+  socionext,set-aces:
+    type: boolean
+    description: Enable same active clock edges field to be set
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@ff110000 {
+        compatible = "socionext,synquacer-spi";
+        reg = <0xff110000 0x1000>;
+        interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+               <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+               <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk_hsspi>;
+        clock-names = "iHCLK";
+        socionext,use-rtm;
+        socionext,set-aces;
+    };
+...
diff --git a/Documentation/devicetree/bindings/spi/spi-synquacer.txt b/Documentation/devicetree/bindings/spi/spi-synquacer.txt
deleted file mode 100644
index 291dfa692d0a..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-synquacer.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Socionext Synquacer HS-SPI bindings
-
-Required Properties:
-- compatible: should be "socionext,synquacer-spi"
-- reg: physical base address of the controller and length of memory mapped
-       region.
-- interrupts: should contain the "spi_rx", "spi_tx" and "spi_fault" interrupts.
-- clocks: core clock iHCLK. Optional rate clock iPCLK (default is iHCLK)
-- clock-names: Shall be "iHCLK" and "iPCLK" respectively
-
-Optional Properties:
-- socionext,use-rtm: boolean, if required to use "retimed clock" for RX
-- socionext,set-aces: boolean, if same active clock edges field to be set.
-
-Example:
-
-	spi0: spi@ff110000 {
-		compatible = "socionext,synquacer-spi";
-		reg = <0xff110000 0x1000>;
-		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clk_hsspi>;
-		clock-names = "iHCLK";
-		socionext,use-rtm;
-		socionext,set-aces;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index cf5a58bac7f8..1f81f0399efa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19037,7 +19037,7 @@ M:	Masahisa Kojima <masahisa.kojima@linaro.org>
 M:	Jassi Brar <jaswinder.singh@linaro.org>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-synquacer.txt
+F:	Documentation/devicetree/bindings/spi/socionext,synquacer-spi.yaml
 F:	drivers/spi/spi-synquacer.c
 
 SOCIONEXT SYNQUACER I2C DRIVER
-- 
2.35.1

