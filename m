Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ABE5FB403
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJKOAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJKOAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:00:11 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF0120374;
        Tue, 11 Oct 2022 07:00:09 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id g130so15898362oia.13;
        Tue, 11 Oct 2022 07:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpinFLGyfMz5LuoFScjs1SYGNlDOoMK18vHAn2nhxCo=;
        b=5ZybirFQCUgwVRA4joHZ/hUemxB3JPKlCCjx4mOyFeoDCBeI1m7mSqgeRrkB7N6mRp
         VY7foDCblqKgvVU5o5jX6Mav4oPImMevSY2IIWl3G8OhzJZs1qo+1IRtLROeIPprIuU4
         nIyGdtW+Nl8f6QOZ4u0Qr4VpLujv7uz7melkcUZmAFHz4J43hW18hGulNXKdO899LB9E
         8vHkCZG7d8gm0ftcXW4Kcb1YJ4CL6JnUIgJRLdniyrgWD2WSCPlWYZFXsIbiSEQZq1on
         PjU2dVcSjOLmFb9+uaqbDtkgWuCw8a00Im8YZJkBIge9v3AJlih7jePdjKXvRvz7qUcF
         B0Vg==
X-Gm-Message-State: ACrzQf3aPNSm14kBl4cYqQe3qFI4UTbQXSREMHgSmjPKhQ6ZyEddx67h
        TEpiMmO6FopdxR+1hXoM5Y9uGdhmpA==
X-Google-Smtp-Source: AMsMyM5HM5siP22QE9AFMbURQF+/Q7yQHyaDxP66PMEWANnBNS8+u9VKkNiJULC0pZeLlabGvBFvog==
X-Received: by 2002:aca:f056:0:b0:350:f0ba:9caa with SMTP id o83-20020acaf056000000b00350f0ba9caamr11984375oih.198.1665496808582;
        Tue, 11 Oct 2022 07:00:08 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r12-20020a4abf0c000000b0044897475dd0sm5292461oop.43.2022.10.11.07.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:00:08 -0700 (PDT)
Received: (nullmailer pid 2787286 invoked by uid 1000);
        Tue, 11 Oct 2022 14:00:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Shiyan <shc_work@mail.ru>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: Add 'ata-generic' binding
Date:   Tue, 11 Oct 2022 08:58:50 -0500
Message-Id: <20221011135849.2785834-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'ata-generic' binding has been around since 2008, but never
documented.

Cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Rob Herring <robh@kernel.org>
---
AFAICT, the ata-generic,use16bit property has no effect in Linux. The
32-bit transfers fallback to 16-bit if ATA_PFLAG_PIO32 flag is not set
which it doesn't appear to ever be set. Looking at the history, the
driver always used 16-bit mode.

Linus, Okay with being maintainer here?

---
 .../devicetree/bindings/ata/ata-generic.yaml  | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ata-generic.yaml

diff --git a/Documentation/devicetree/bindings/ata/ata-generic.yaml b/Documentation/devicetree/bindings/ata/ata-generic.yaml
new file mode 100644
index 000000000000..0697927f3d7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ata-generic.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/ata-generic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Parallel ATA Controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  Generic Parallel ATA controllers supporting PIO modes only.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - arm,vexpress-cf
+          - fsl,mpc8349emitx-pata
+      - const: ata-generic
+
+  reg:
+    items:
+      - description: Command interface registers
+      - description: Control interface registers
+
+  reg-shift:
+    enum: [ 1, 2 ]
+
+  interrupts:
+    maxItems: 1
+
+  ata-generic,use16bit:
+    type: boolean
+    description: Use 16-bit accesses instead of 32-bit for data transfers
+
+  pio-mode:
+    description: Maximum ATA PIO transfer mode
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 6
+    default: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    compact-flash@1a000 {
+        compatible = "arm,vexpress-cf", "ata-generic";
+        reg = <0x1a000 0x100>,
+              <0x1a100 0xf00>;
+        reg-shift = <2>;
+    };
+...
-- 
2.35.1

