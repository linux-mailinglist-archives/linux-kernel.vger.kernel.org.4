Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2115ED7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiI1Ihz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiI1IhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:37:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B8BDA284E;
        Wed, 28 Sep 2022 01:37:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbWuwBzRjdjMjAA--.18971S3;
        Wed, 28 Sep 2022 16:37:10 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v5 2/3] dt-bindings: thermal: add loongson2k thermal binding
Date:   Wed, 28 Sep 2022 16:37:01 +0800
Message-Id: <20220928083702.17309-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220928083702.17309-1-zhuyinbo@loongson.cn>
References: <20220928083702.17309-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbWuwBzRjdjMjAA--.18971S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur43WF18Kry7uryrCF1DGFg_yoW8AryUpF
        43Cr1DCr4v9F17Z39xJFy8Cws8trnYyF9rXrs7K3W5tr95Ga4Sq3y3KryDZ34fCr1jgFW7
        uFWI9r4jk3WDG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
        3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
        WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
        Xa7VUjLL07UUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the loongson2k thermal binding with DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v5:
		1. Keep use same quotes "'" in all places. 

 .../thermal/loongson,ls2k-thermal.yaml        | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
new file mode 100644
index 000000000000..3fb841797771
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/loongson,ls2k-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Thermal sensors on loongson2k SoCs
+
+maintainers:
+  - zhanghongchen <zhanghongchen@loongson.cn>
+  - Yinbo Zhu <zhuyinbo@loongson.cn>
+
+properties:
+  compatible:
+    const: loongson,ls2k-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    thermal: thermal-sensor@1fe01500 {
+        compatible = "loongson,ls2k-thermal";
+        reg = <0 0x1fe01500 0 0x30>;
+        interrupt-parent = <&liointc0>;
+        interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+        #thermal-sensor-cells = <1>;
+    };
-- 
2.31.1

