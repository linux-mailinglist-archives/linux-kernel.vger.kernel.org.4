Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C86463CEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiK3Fz1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 00:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK3FzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:55:25 -0500
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Nov 2022 21:55:24 PST
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBED654D6;
        Tue, 29 Nov 2022 21:55:24 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 533A924E1FE;
        Wed, 30 Nov 2022 13:52:42 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:42 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:38 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>
Subject: [PATCH 5/6] dt-bindings: crypto: Add bindings for Starfive crypto driver
Date:   Wed, 30 Nov 2022 13:52:13 +0800
Message-ID: <20221130055214.2416888-6-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Starfive crypto
driver bindings.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
---
 .../bindings/crypto/starfive-crypto.yaml      | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/starfive-crypto.yaml

diff --git a/Documentation/devicetree/bindings/crypto/starfive-crypto.yaml b/Documentation/devicetree/bindings/crypto/starfive-crypto.yaml
new file mode 100644
index 000000000000..6b852f774c32
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/starfive-crypto.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/starfive-crypto.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive Crypto Controller Device Tree Bindings
+
+maintainers:
+  - Jia Jie Ho <jiajie.ho@starfivetech.com>
+  - William Qiu <william.qiu@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-crypto
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: secreg
+
+  clocks:
+    items:
+      - description: Hardware reference clock
+      - description: AHB reference clock
+
+  clock-names:
+    items:
+      - const: sec_hclk
+      - const: sec_ahb
+
+  interrupts:
+    items:
+      - description: Interrupt pin for algo completion
+      - description: Interrupt pin for DMA transfer completion
+
+  interrupt-names:
+    items:
+      - const: secirq
+      - const: dmairq
+
+  resets:
+    items:
+      - description: STG domain reset line
+
+  reset-names:
+    items:
+      - const: sec_hre
+
+  enable-side-channel-mitigation:
+    description: Enable side-channel-mitigation feature for AES module.
+        Enabling this feature will affect the speed performance of
+        crypto engine.
+    type: boolean
+
+  enable-dma:
+    description: Enable data transfer using dedicated DMA controller.
+    type: boolean
+
+  dmas:
+    items:
+      - description: TX DMA channel
+      - description: RX DMA channel
+
+  dma-names:
+    items:
+      - const: sec_m
+      - const: sec_p
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive-jh7110.h>
+    #include <dt-bindings/reset/starfive-jh7110.h>
+
+    soc {
+            #address-cells = <2>;
+            #size-cells = <2>;
+
+            crypto: crypto@16000000 {
+                    compatible = "starfive,jh7110-crypto";
+                    reg = <0x0 0x16000000 0x0 0x4000>;
+                    reg-names = "secreg";
+                    clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
+                    <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
+                    interrupts = <28>, <29>;
+                    interrupt-names = "secirq", "dmairq";
+                    clock-names = "sec_hclk","sec_ahb";
+                    resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
+                    reset-names = "sec_hre";
+                    enable-side-channel-mitigation;
+                    enable-dma;
+                    dmas = <&sec_dma 1 2>,
+                           <&sec_dma 0 2>;
+                    dma-names = "sec_m","sec_p";
+            };
+    };
-- 
2.25.1

