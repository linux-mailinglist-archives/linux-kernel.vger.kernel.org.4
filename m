Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767736FB082
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjEHMqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjEHMqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:46:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB4C18C;
        Mon,  8 May 2023 05:46:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so19586985e9.1;
        Mon, 08 May 2023 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683549965; x=1686141965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asbulxWBBUUI7EhpI6L3ou9HymcJhGeGWLD2VK7v0Wk=;
        b=TIzCwj/pI/o0/YWw8CTrR3fZHS2yw48fL9IAOdDFNArHQUatheY+o7DJ2aCyUvy23N
         j+9Q7cGYTUhJeUQKhvdga0DWYOtSwdcZK6woZAa2jGJ8o2RuOwPKrh2oetm18m31uWHs
         OXtZmd0tVqYb15iqkpfB85kiUVTa469JT9RgQZOK7gHPMpIwGNSAT2tgbL/HvoQc7GaM
         V0VHMt1zd9J/5hzWfPi5Ubw2VkIAxWeTS4xL0yEtfD/cDVCWaicb4nfKzijY4ojLx5j9
         3OSuitk4sLousbcMjEQn+lthDgyN7QiauUJm8pICKubK6yaupSV63ppnPesac4mFbZ+7
         +KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683549965; x=1686141965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asbulxWBBUUI7EhpI6L3ou9HymcJhGeGWLD2VK7v0Wk=;
        b=HDnOIWObXfG+havnbnX8zqzoN1UPpuqyl91wWLZqnK5HI+eXLTzTeAjMn/j1K3wgBb
         MhhxfewTMJK6XqnGemOPRCuEU9wWD3ArIQ9JKOZylkflN8IiFk9DhOL7Pxh5AXFAhTF5
         DFsw1AcfxyMcZzlreRy0Z7Z2QGfnuD2ASZqgdskRNjXXJ3ZMCE0swMreozEqgdk2Gosu
         kr9Gl/NbE4r57UMMGvhR/bFp2Jz+b0hvsYmWyKAGZs6CJDUa2lN193sz9FSNhAeD4MiN
         jO4wdfyqWTyEeDFD/h0wDpWGFU98qDyQ+S59IWqPv1iKsI5jcSpg1i8BIroKnN+hXYP3
         /ttQ==
X-Gm-Message-State: AC+VfDwIhaQepP6XxiYpUv3eVQmWVX7yKdMp1o4VwtJLKwOg3Yo3MT2W
        PGrI4X+Qau8dBOvhYXo/3+jEzX9jX2nQHg==
X-Google-Smtp-Source: ACHHUZ4Caw1eB1LyVaPjHrWuOkjvhK/LDxL+ZU7Tdq6wIDisHDEgaQ1pyNkzVDQ0KBXmSLZ1QgxqHQ==
X-Received: by 2002:a7b:cb46:0:b0:3f1:82a1:122 with SMTP id v6-20020a7bcb46000000b003f182a10122mr7240608wmj.21.1683549965505;
        Mon, 08 May 2023 05:46:05 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id l11-20020a7bc34b000000b003f195d2f1a9sm16696200wmj.15.2023.05.08.05.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 05:46:05 -0700 (PDT)
Date:   Mon, 8 May 2023 14:46:03 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: mmc: brcm,kona-sdhci: convert to YAML
Message-ID: <a1fd4092b8a31c2ee58a3cd4cca062db13197b45.1683548624.git.stano.jakubek@gmail.com>
References: <88c64da50a1af868d8b14054c440e5ff96a63399.1683548624.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c64da50a1af868d8b14054c440e5ff96a63399.1683548624.git.stano.jakubek@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Broadcom Kona family SDHCI controller bindings to DT schema.

Changes during conversion:
  - also mark reg and interrupts as required
  - drop deprecated compatible (it's been deprecated for ~10 years)

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/mmc/brcm,kona-sdhci.txt          | 21 --------
 .../bindings/mmc/brcm,kona-sdhci.yaml         | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt b/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt
deleted file mode 100644
index 7f5dd83f5bd9..000000000000
--- a/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Broadcom BCM281xx SDHCI
-
-This file documents differences between the core properties in mmc.txt
-and the properties present in the bcm281xx SDHCI
-
-Required properties:
-- compatible : Should be "brcm,kona-sdhci"
-- DEPRECATED: compatible : Should be "bcm,kona-sdhci"
-- clocks: phandle + clock specifier pair of the external clock
-
-Refer to clocks/clock-bindings.txt for generic clock consumer properties.
-
-Example:
-
-sdio2: sdio@3f1a0000 {
-	compatible = "brcm,kona-sdhci";
-	reg = <0x3f1a0000 0x10000>;
-	clocks = <&sdio3_clk>;
-	interrupts = <0x0 74 0x4>;
-};
-
diff --git a/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.yaml
new file mode 100644
index 000000000000..87711edf9b39
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/brcm,kona-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family SDHCI controller
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: sdhci-common.yaml#
+
+properties:
+  compatible:
+    const: brcm,kona-sdhci
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
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include "dt-bindings/clock/bcm281xx.h"
+
+    mmc@3f1a0000 {
+        compatible = "brcm,kona-sdhci";
+        reg = <0x3f1a0000 0x10000>;
+        clocks = <&master_ccu BCM281XX_MASTER_CCU_SDIO3>;
+        interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
-- 
2.25.1

