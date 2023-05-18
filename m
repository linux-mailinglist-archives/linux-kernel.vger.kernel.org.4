Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9554F707F49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjERL2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjERL2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:28:07 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D21BC1;
        Thu, 18 May 2023 04:28:01 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BE07080D3;
        Thu, 18 May 2023 19:27:54 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 19:27:54 +0800
Received: from ubuntu.localdomain (113.72.146.100) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 19:27:53 +0800
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
        "Minda Chen" <minda.chen@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: [PATCH v6 2/7] dt-bindings: phy: Add StarFive JH7110 PCIe PHY
Date:   Thu, 18 May 2023 19:27:45 +0800
Message-ID: <20230518112750.57924-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518112750.57924-1-minda.chen@starfivetech.com>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.100]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add StarFive JH7110 SoC PCIe 2.0 PHY dt-binding.
PCIe PHY0 (phy@10210000) can be used as USB 3.0 PHY.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../phy/starfive,jh7110-pcie-phy.yaml         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml
new file mode 100644
index 000000000000..2e83a6164cd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/starfive,jh7110-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 PCIe 2.0 PHY
+
+maintainers:
+  - Minda Chen <minda.chen@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-pcie-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  starfive,sys-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to System Register Controller sys_syscon node.
+          - description: PHY connect offset of SYS_SYSCONSAIF__SYSCFG register for USB PHY.
+    description:
+      The phandle to System Register Controller syscon node and the PHY connect offset
+      of SYS_SYSCONSAIF__SYSCFG register. Connect PHY to USB3 controller.
+
+  starfive,stg-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to System Register Controller stg_syscon node.
+          - description: PHY mode offset of STG_SYSCONSAIF__SYSCFG register.
+          - description: PHY enable for USB offset of STG_SYSCONSAIF__SYSCFG register.
+    description:
+      The phandle to System Register Controller syscon node and the offset
+      of STG_SYSCONSAIF__SYSCFG register for PCIe PHY. Total 2 regsisters offset.
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
+    phy@10210000 {
+        compatible = "starfive,jh7110-pcie-phy";
+        reg = <0x10210000 0x10000>;
+        #phy-cells = <0>;
+        starfive,sys-syscon = <&sys_syscon 0x18>;
+        starfive,stg-syscon = <&stg_syscon 0x148 0x1f4>;
+    };
-- 
2.17.1

