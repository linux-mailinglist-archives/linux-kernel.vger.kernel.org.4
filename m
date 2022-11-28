Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D47F63A4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiK1JW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiK1JWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:22:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A3E16593;
        Mon, 28 Nov 2022 01:22:24 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2ED796602A89;
        Mon, 28 Nov 2022 09:22:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669627342;
        bh=8E9V/iMHvBxjB98xrLavQ6uGlM/JoXxCkUogZXNGwB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUrC4WjzwumMeYZvcEh7NGbHTOaZphbCWSXFLGRsIXSbnFWikcmqvT0cncOmZxOxd
         KWD9siIn7IGBhe/BJUs7Lksl9o3KiHXGIaFB/0S/oQi6LKQwtBUj2mF0Hzetf5D9h7
         4b7UG72zgRceULxQ+sqcKSMD2XYb58J7fg5m3SDNDRATU75JJVBMKu6IAOKw3rqjDP
         pPNPl/tnaoVRDUxLgiGO/47WCEQ8NYU4uh5aOiCURwxMoM6HktbXLHUtPpWOUPH5Oe
         rqc9VMbwGIYbyqm9CYc61MH6uVqJpcxgbNl8uvKQeESXUQOjXeH7/VLH4xG+1x/clw
         iQGaRLJ/Fg5SA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: interrupt-controller: mediatek,cirq: Migrate to dt schema
Date:   Mon, 28 Nov 2022 10:22:14 +0100
Message-Id: <20221128092217.36552-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128092217.36552-1-angelogioacchino.delregno@collabora.com>
References: <20221128092217.36552-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate mediatek,cirq.txt to dt schema as mediatek,mtk-cirq.yaml.
While at it, I've also fixed some typos that were present in the
original txt binding, as it was suggesting that the compatible
string would have "mediatek,cirq" as compatible but, in reality,
that's supposed to be "mediatek,mtk-cirq" instead.

Little rewording on property descriptions also happened for
them to be more concise.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../interrupt-controller/mediatek,cirq.txt    | 33 ---------
 .../mediatek,mtk-cirq.yaml                    | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
deleted file mode 100644
index 5865f4f2c69d..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-* Mediatek 27xx cirq
-
-In Mediatek SOCs, the CIRQ is a low power interrupt controller designed to
-work outside MCUSYS which comprises with Cortex-Ax cores,CCI and GIC.
-The external interrupts (outside MCUSYS) will feed through CIRQ and connect
-to GIC in MCUSYS. When CIRQ is enabled, it will record the edge-sensitive
-interrupts and generate a pulse signal to parent interrupt controller when
-flush command is executed. With CIRQ, MCUSYS can be completely turned off
-to improve the system power consumption without losing interrupts.
-
-Required properties:
-- compatible: should be one of
-  - "mediatek,mt2701-cirq" for mt2701 CIRQ
-  - "mediatek,mt8135-cirq" for mt8135 CIRQ
-  - "mediatek,mt8173-cirq" for mt8173 CIRQ
-  and "mediatek,cirq" as a fallback.
-- interrupt-controller : Identifies the node as an interrupt controller.
-- #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
-- reg: Physical base address of the cirq registers and length of memory
-  mapped region.
-- mediatek,ext-irq-range: Identifies external irq number range in different
-  SOCs.
-
-Example:
-	cirq: interrupt-controller@10204000 {
-		compatible = "mediatek,mt2701-cirq",
-			     "mediatek,mtk-cirq";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		interrupt-parent = <&sysirq>;
-		reg = <0 0x10204000 0 0x400>;
-		mediatek,ext-irq-start = <32 200>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
new file mode 100644
index 000000000000..4f1132c077ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/mediatek,mtk-cirq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek System Interrupt Controller
+
+maintainers:
+  - Youlin Pei <youlin.pei@mediatek.com>
+
+description:
+  In MediaTek SoCs, the CIRQ is a low power interrupt controller designed to
+  work outside of MCUSYS which comprises with Cortex-Ax cores, CCI and GIC.
+  The external interrupts (outside MCUSYS) will feed through CIRQ and connect
+  to GIC in MCUSYS. When CIRQ is enabled, it will record the edge-sensitive
+  interrupts and generate a pulse signal to parent interrupt controller when
+  flush command is executed. With CIRQ, MCUSYS can be completely turned off
+  to improve the system power consumption without losing interrupts.
+
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt2701-cirq
+          - mediatek,mt8135-cirq
+          - mediatek,mt8173-cirq
+      - const: mediatek,mtk-cirq
+
+  reg:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 3
+
+  interrupt-controller: true
+
+  mediatek,ext-irq-range:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: First CIRQ interrupt
+      - description: Last CIRQ interrupt
+    description:
+      Identifies the range of external interrupts in different SoCs
+
+required:
+  - compatible
+  - reg
+  - '#interrupt-cells'
+  - interrupt-controller
+  - mediatek,ext-irq-range
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cirq: interrupt-controller@10204000 {
+        compatible = "mediatek,mt2701-cirq", "mediatek,mtk-cirq";
+        reg = <0x10204000 0x400>;
+        #interrupt-cells = <3>;
+        interrupt-controller;
+        interrupt-parent = <&sysirq>;
+        mediatek,ext-irq-range = <32 200>;
+    };
-- 
2.38.1

