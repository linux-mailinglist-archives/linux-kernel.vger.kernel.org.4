Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241B86BACFC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjCOKFr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Mar 2023 06:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCOKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:05:24 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E483866B;
        Wed, 15 Mar 2023 03:04:40 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4F49524E1EC;
        Wed, 15 Mar 2023 18:04:26 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 18:04:26 +0800
Received: from ubuntu.localdomain (113.72.145.194) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 18:04:25 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Date:   Wed, 15 Mar 2023 03:04:19 -0700
Message-ID: <20230315100421.133428-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315100421.133428-1-changhuang.liang@starfivetech.com>
References: <20230315100421.133428-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.194]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

StarFive SoCs like the jh7110 use a MIPI D-PHY RX controller based on
a M31 IP. Add a binding for it.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../bindings/phy/starfive,jh7110-dphy-rx.yaml | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml

diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
new file mode 100644
index 000000000000..b72ac44bc29d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/starfive,jh7110-dphy-rx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive SoC MIPI D-PHY Rx Controller
+
+maintainers:
+  - Jack Zhu <jack.zhu@starfivetech.com>
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+description:
+  The StarFive SoC uses the MIPI CSI D-PHY based on M31 IP to transfer
+  CSI camera data.
+
+properties:
+  compatible:
+    const: starfive,jh7110-dphy-rx
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: config clock
+      - description: reference clock
+      - description: escape mode transmit clock
+
+  clock-names:
+    items:
+      - const: cfg
+      - const: ref
+      - const: tx
+
+  resets:
+    items:
+      - description: DPHY_HW reset
+      - description: DPHY_B09_ALWAYS_ON reset
+
+  starfive,aon-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle of AON SYSCON
+          - description: register offset
+    description: The power of dphy rx is configured by AON SYSCON
+      in this property.
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - starfive,aon-syscon
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@19820000 {
+      compatible = "starfive,jh7110-dphy-rx";
+      reg = <0x19820000 0x10000>;
+      clocks = <&ispcrg 3>,
+               <&ispcrg 4>,
+               <&ispcrg 5>;
+      clock-names = "cfg", "ref", "tx";
+      resets = <&ispcrg 2>,
+               <&ispcrg 3>;
+      starfive,aon-syscon = <&aon_syscon 0x00>;
+      #phy-cells = <0>;
+    };
-- 
2.25.1

