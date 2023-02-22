Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139E169F969
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBVQz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjBVQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:55:23 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1432D12BCA;
        Wed, 22 Feb 2023 08:55:18 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.133])
        by gateway (Coremail) with SMTP id _____8CxC9r0SPZjf6YDAA--.7811S3;
        Thu, 23 Feb 2023 00:55:16 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.133])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTL7ySPZjRes4AA--.38394S3;
        Thu, 23 Feb 2023 00:55:15 +0800 (CST)
From:   suijingfeng <suijingfeng@loongson.cn>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] dt-bindings: display: Add Loongson display controller
Date:   Thu, 23 Feb 2023 00:55:14 +0800
Message-Id: <20230222165514.684729-2-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222165514.684729-1-suijingfeng@loongson.cn>
References: <20230222165514.684729-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxTL7ySPZjRes4AA--.38394S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tF48ur1DKF45Gw47XF4xWFg_yoW8uFW5pa
        nxCan7Gr4jqFnFy3yfta48Wr45Zr95AFn7GFsrJw17K3srWayFvw15KF1kXF47GF9rZa4j
        vFy0gF4xK3Z7Cw7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2
        AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_
        Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add a trival DT usages for loongson display controller found
in LS2k1000 SoC.

Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
---
 .../loongson/loongson,display-controller.yaml | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml

diff --git a/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
new file mode 100644
index 000000000000..98b78f449a80
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/loongson/loongson,display-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson Display Controller Device Tree Bindings
+
+maintainers:
+  - Sui Jingfeng <suijingfeng@loongson.cn>
+
+description: |+
+
+  The display controller is a PCI device, it has two display pipe.
+  For the DC in LS2K1000 each way has a DVO output interface which
+  provide RGB888 signals, vertical & horizontal synchronisations
+  and the pixel clock. Each CRTC is able to support 1920x1080@60Hz,
+  the maximum resolution is 2048x2048 according to the hardware spec.
+
+properties:
+  $nodename:
+    pattern: "^display-controller@[0-9a-f],[0-9a-f]$"
+
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - loongson,ls2k1000-dc
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    bus {
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <2>;
+
+        display-controller@6,0 {
+            compatible = "loongson,ls2k1000-dc";
+            reg = <0x3000 0x0 0x0 0x0 0x0>;
+            interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+
+...
-- 
2.34.1

