Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF16BADFA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjCOKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjCOKoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:44:18 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE6F7C9C8;
        Wed, 15 Mar 2023 03:44:16 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 90C4E24E361;
        Wed, 15 Mar 2023 18:44:15 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 18:44:15 +0800
Received: from ubuntu.localdomain (113.72.145.194) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 18:44:14 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Minda Chen" <minda.chen@starfivetech.com>
Subject: [PATCH v3 1/5] dt-bindings: phy: Add StarFive JH7110 USB/PCIe document
Date:   Wed, 15 Mar 2023 18:44:07 +0800
Message-ID: <20230315104411.73614-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230315104411.73614-1-minda.chen@starfivetech.com>
References: <20230315104411.73614-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.194]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX071.cuchost.com
 (172.16.6.81)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add StarFive JH7110 SoC USB 2.0/3.0 and PCIe 2.0 PHY dt-binding.
PCIe 2.0 phy can use as USB 3.0 PHY.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../phy/starfive,jh7110-usb-pcie-phy.yaml     | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-pcie-phy.yaml
new file mode 100644
index 000000000000..aa1c3fe93100
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-pcie-phy.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/starfive,jh7110-usb-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive USB 2.0 and PCIe 2.0 PHY
+
+maintainers:
+  - Minda Chen <minda.chen@starfivetech.com>
+
+properties:
+  compatible:
+    enum:
+      - starfive,jh7110-usb-phy
+      - starfive,jh7110-pcie-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: usb 125m clock
+      - description: app 125m clock
+
+  clock-names:
+    items:
+      - const: 125m
+      - const: app_125
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@10200000 {
+      compatible = "starfive,jh7110-usb-phy";
+      reg = <0x10200000 0x10000>;
+      clocks = <&syscrg 95>,
+               <&stgcrg 6>;
+      clock-names = "125m", "app_125";
+      #phy-cells = <0>;
+    };
+
+    phy@10210000 {
+      compatible = "starfive,jh7110-pcie-phy";
+      reg = <0x10210000 0x10000>;
+      #phy-cells = <0>;
+    };
+
+    phy@10220000 {
+      compatible = "starfive,jh7110-pcie-phy";
+      reg = <0x10220000 0x10000>;
+      #phy-cells = <0>;
+    };
-- 
2.17.1

