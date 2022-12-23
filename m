Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412626552C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiLWQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiLWQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:26:43 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C545F6D;
        Fri, 23 Dec 2022 08:26:42 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so13102730ejc.4;
        Fri, 23 Dec 2022 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tmle9hGeHtFydMSBtgkAcVzOGdcFV8HSXUbv12rRhk=;
        b=DuCzDDYB1efLMrFzeKbjpXMIdenAT/evrDjfSH4ROqcb57yXZxPQaaPsOECnTdVgaa
         mnVCCZF7OBigddCiz5LjfaakAxcDbEaEJZJHyf8UdDMekciN4+Z8RvYAKphWfG099Y9y
         5XmMXFUyiXRhz2s2wHRPxktRpT/3M9LVNBQe7ggWnB/EoDs8PhB4ER3THmbo0N3w+Bzr
         gcf37PSwJXA6HBVBxs1e8nxhVytZV5hChoZQwjM3zOvuyw42xIvIjIvuZeI//DZdBa+4
         o61fiZVb7UYTS7/yzbtxEP5DZrWjcnDHaiDhkr4H8XwsDxmMg6LapfAHeVrSTgG5kWoA
         po7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Tmle9hGeHtFydMSBtgkAcVzOGdcFV8HSXUbv12rRhk=;
        b=2B19icutL9noquz+L5XOnf46KSo7BH4+l3LNoFlQLEWp6allEIpxqk+lCkfzk1k8If
         Vhtg3XdYheSsrZx61SXbiz+W3oqDXdsKJ0dPoeeanPAKiHX6gOswku5tNMtUU4J7bGrj
         /BoUODUQDpIc5pctTRbCT7J0EekP4vqZiX7cbT0pn9lnU3B8XHRNe7ko9DUt8YAoilOX
         o9DFVc7C3X/x+vhK9zhtfsqZ3xbMoCm49aFo5d83SlQ+nXWkmw/SkHaO61fh/PZ2JpZt
         1en1hZzHgaq6S/hhAJ6EUbZikGu6nnzEqLaUN1OX6Q6gq2HscWduuXNebNnfvUiTRKNf
         sF6A==
X-Gm-Message-State: AFqh2krVa+7u64vE7VHqnenwIthLWWeHqYQZsbYgLkSlu5AIjliOotCu
        Ck3qLgKcZU2l9bL3iEcnJGnmid2hNq4=
X-Google-Smtp-Source: AMrXdXuoA73NZ+Z3iFqWAxu4G6uvxB5rCJdSWOYyYJZzGXnBuH6ZBsR7lHoreRNKNFxrBe5FW1KiPA==
X-Received: by 2002:a17:906:30c2:b0:7ae:c0b:a25c with SMTP id b2-20020a17090630c200b007ae0c0ba25cmr8067700ejb.13.1671812800819;
        Fri, 23 Dec 2022 08:26:40 -0800 (PST)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id bx4-20020a170906a1c400b007c0e6d6bd10sm1539009ejb.132.2022.12.23.08.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 08:26:39 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: ep93xx: Add cirrus,ep9301-adc description
Date:   Fri, 23 Dec 2022 17:26:35 +0100
Message-Id: <20221223162636.6488-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Add device tree bindings for Cirrus Logic EP9301/EP9302 internal SoCs' ADC
block.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v2: removed clock-names property, soc node and include as Krzysztof suggested

 .../bindings/iio/adc/cirrus,ep9301-adc.yaml   | 47 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
new file mode 100644
index 000000000000..6d4fb3e1d2a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/cirrus,ep9301-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP930x internal ADC
+
+description: |
+  Cirrus Logic EP9301/EP9302 SoCs' internal ADC block.
+
+  User's manual:
+  https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.pdf
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+properties:
+  compatible:
+    const: cirrus,ep9301-adc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    adc: adc@80900000 {
+        compatible = "cirrus,ep9301-adc";
+        reg = <0x80900000 0x28>;
+        clocks = <&syscon 24>;
+        interrupt-parent = <&vic1>;
+        interrupts = <30>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 69565ac0c224..4a914d5bc2e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2027,8 +2027,10 @@ M:	Hartley Sweeten <hsweeten@visionengravers.com>
 M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
 F:	arch/arm/mach-ep93xx/
 F:	arch/arm/mach-ep93xx/include/mach/
+F:	drivers/iio/adc/ep93xx_adc.c
 
 ARM/CLKDEV SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
-- 
2.39.0

