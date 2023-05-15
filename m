Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9A2702D34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbjEOMzA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 May 2023 08:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242014AbjEOMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:54:18 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A819AE;
        Mon, 15 May 2023 05:54:17 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 72198807C;
        Mon, 15 May 2023 20:54:15 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 20:54:15 +0800
Received: from ubuntu.localdomain (161.142.156.10) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 20:54:09 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v8 1/4] dt-bindings: crypto: Add StarFive crypto module
Date:   Mon, 15 May 2023 20:53:52 +0800
Message-ID: <20230515125355.624250-2-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515125355.624250-1-jiajie.ho@starfivetech.com>
References: <20230515125355.624250-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [161.142.156.10]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe StarFive cryptographic engine.

Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../crypto/starfive,jh7110-crypto.yaml        | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml

diff --git a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
new file mode 100644
index 000000000000..71a2876bd6e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/starfive,jh7110-crypto.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive Cryptographic Module
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
+  clocks:
+    items:
+      - description: Hardware reference clock
+      - description: AHB reference clock
+
+  clock-names:
+    items:
+      - const: hclk
+      - const: ahb
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: TX DMA channel
+      - description: RX DMA channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    crypto: crypto@16000000 {
+        compatible = "starfive,jh7110-crypto";
+        reg = <0x16000000 0x4000>;
+        clocks = <&clk 15>, <&clk 16>;
+        clock-names = "hclk", "ahb";
+        interrupts = <28>;
+        resets = <&reset 3>;
+        dmas = <&dma 1 2>,
+               <&dma 0 2>;
+        dma-names = "tx", "rx";
+    };
+...
-- 
2.25.1

