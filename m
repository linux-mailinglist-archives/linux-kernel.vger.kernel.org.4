Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C168C1C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjBFPhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBFPhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:37:08 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9AA2A998;
        Mon,  6 Feb 2023 07:35:55 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k13so12526265plg.0;
        Mon, 06 Feb 2023 07:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFAbb0Q992diuRUuGb5zzfTb2heUqqslWuNG7BHd+yw=;
        b=GBmNCuzez9ViTbo5c31j8U7hoafrS4Hf2kTye8ahc4Abeoj1Ee3GASHIhmJK7w9gyn
         GHvLHWsI59WKRaYUwL31G2QDgNtXBMMq0EXqvwbO4uD+n4oo/r+1RPGIW79HHm+qi2dX
         BO3VV1RbFijXSmd/E+AWs9Q5Ev6WrCC+biMYhsUK4CgOyHpfZJ35NMrKjSVbAKYKrR2D
         fKz1EHQ2H1xUIfwz+tUXrFa+u4D8K4tAUvMo6M7anvaIWEaiU+IZYKty3nBxPYeT6C9y
         cGzVGOUKfaqav04heydFDtYjFz1fOFvl1tDikQeYaW6vwGaYdMc9SDb0BBKyoPkoNkYN
         1mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFAbb0Q992diuRUuGb5zzfTb2heUqqslWuNG7BHd+yw=;
        b=Jbdz0O4ERq+dG33CBj9n0LrHNuShudeU06heTx6AnOsuIuCEFSAKDLka2jz0QEsgg/
         PYYnweCCxsrKhWl9BHmXN5F632amkZnYjd1hAG/R95gv1jyd3+bXXg66mTPc+V21VlvK
         JT1LlxQv9tMU4bw0C3oqnD26F6XSW1jDuKD75oiEBzagFLvS5qA/rIqCTlKdyeZytwpp
         tgkm1EvZE8fzLvuMd1Dbhu18wNRQU4uJsF5VsHeQrA5Dldyd0A+FQYp0wenbmHNbrq1+
         tY1HNrOOoY2q8Um6j+IBYmhz8E+qLlihUU8hON/gy3vkctcO0QLoV+jpz3Pu8+NTJ9vW
         faNQ==
X-Gm-Message-State: AO0yUKXkEhvVVjE1/SGAJrRbmhJR3sVfq8lcH56DQLDBmbE32eSp5LlR
        kMIv8yrXBDUzdFLekNw3EXo=
X-Google-Smtp-Source: AK7set+Qq712Bfv+AuekZLeLJcQT4YU4H9ICuPwDYw37RtiqHrDF/vgnFMZzQe8TkU4x2JeeSMtlwQ==
X-Received: by 2002:a17:90b:4b8a:b0:22c:afa2:4783 with SMTP id lr10-20020a17090b4b8a00b0022cafa24783mr21747537pjb.39.1675697696308;
        Mon, 06 Feb 2023 07:34:56 -0800 (PST)
Received: from localhost.localdomain ([14.139.38.195])
        by smtp.googlemail.com with ESMTPSA id p11-20020a17090a4f0b00b00230c425adbcsm1696091pjh.20.2023.02.06.07.34.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Feb 2023 07:34:55 -0800 (PST)
From:   Vijaya Anand <sunrockers8@gmail.com>
Cc:     sunrockers8@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings : misc : aspeed,cvic interrupt controller : convert the binding document to yaml
Date:   Mon,  6 Feb 2023 21:03:09 +0530
Message-Id: <20230206153325.43692-1-sunrockers8@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Convert the binding document for ASPEED AST2400 and AST2500 coprocessor interrupt controller
    from txt to yaml so one could validate dt-entries correctly and any future additions can go
    into yaml format. The options for compatability described according to the example given.
---
 .../devicetree/bindings/misc/aspeed,cvic.txt  | 35 ----------
 .../devicetree/bindings/misc/aspeed,cvic.yaml | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.txt
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.yaml

diff --git a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt b/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
deleted file mode 100644
index d62c783d1d5e..000000000000
--- a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* ASPEED AST2400 and AST2500 coprocessor interrupt controller
-
-This file describes the bindings for the interrupt controller present
-in the AST2400 and AST2500 BMC SoCs which provides interrupt to the
-ColdFire coprocessor.
-
-It is not a normal interrupt controller and it would be rather
-inconvenient to create an interrupt tree for it as it somewhat shares
-some of the same sources as the main ARM interrupt controller but with
-different numbers.
-
-The AST2500 supports a SW generated interrupt
-
-Required properties:
-- reg: address and length of the register for the device.
-- compatible: "aspeed,cvic" and one of:
-		"aspeed,ast2400-cvic"
-	      or
-		"aspeed,ast2500-cvic"
-
-- valid-sources: One cell, bitmap of supported sources for the implementation
-
-Optional properties;
-- copro-sw-interrupts: List of interrupt numbers that can be used as
-		       SW interrupts from the ARM to the coprocessor.
-		       (AST2500 only)
-
-Example:
-
-	cvic: copro-interrupt-controller@1e6c2000 {
-		compatible = "aspeed,ast2500-cvic";
-		valid-sources = <0xffffffff>;
-		copro-sw-interrupts = <1>;
-		reg = <0x1e6c2000 0x80>;
-	};
diff --git a/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml b/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
new file mode 100644
index 000000000000..bbff0418fa2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/aspeed,cvic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2400 and AST2500 coprocessor interrupt controller
+
+maintainers: 
+  - Benjamin Herrenschmidt <benh@kernel.crashing.org>
+  - Rob Herring <robh@kernel.org>
+
+description: |
+  This file describes the bindings for the interrupt controller present
+  in the AST2400 and AST2500 BMC SoCs which provides interrupt to the
+  ColdFire coprocessor.
+
+  It is not a normal interrupt controller and it would be rather
+  inconvenient to create an interrupt tree for it as it somewhat shares
+  some of the same sources as the main ARM interrupt controller but with
+  different numbers.
+
+  The AST2500 supports a SW generated interruptThe Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
+  which provides high-throughput LDPC and Turbo Code implementations.
+  The LDPC decode & encode functionality is capable of covering a range of
+  customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
+  principally covers codes used by LTE. The FEC Engine offers significant
+  power and area savings versus implementations done in the FPGA fabric.
+
+properties:
+
+  compatible:
+    enum: 
+      - aspeed,ast2400-cvic
+      - aspeed,ast2500-cvic
+
+  reg:
+    maxItems: 1
+    description: address and length of the register for the device.
+  
+  valid-sources:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: One cell, bitmap of supported sources for the implementation
+
+  copro-sw-interrupts:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+                  List of interrupt numbers that can be used as
+                  SW interrupts from the ARM to the coprocessor.
+                  (AST2500 only)
+
+required:
+  - compatible
+  - reg
+  - valid-sources
+
+additionalProperties: false
+
+examples:
+  - |
+    cvic: copro-interrupt-controller@1e6c2000 
+    {
+        compatible = "aspeed,ast2500-cvic";
+        valid-sources = <0xffffffff>;
+        copro-sw-interrupts = <1>;
+        reg = <0x1e6c2000 0x80>;
+    };
-- 
2.37.1 (Apple Git-137.1)

