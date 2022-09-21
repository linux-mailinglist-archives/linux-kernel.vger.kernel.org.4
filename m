Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56D5BF32E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiIUB4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiIUB4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:56:20 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3AA979632;
        Tue, 20 Sep 2022 18:56:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxReI3bypj2yYfAA--.51844S3;
        Wed, 21 Sep 2022 09:56:13 +0800 (CST)
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
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
Date:   Wed, 21 Sep 2022 09:56:04 +0800
Message-Id: <20220921015605.17078-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220921015605.17078-1-zhuyinbo@loongson.cn>
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxReI3bypj2yYfAA--.51844S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyxtrykGw1UKryxWF1xXwb_yoW8CryUpF
        43Cw1UGr4vgF17ZanxGa48Ar4Yya9YyF9rXrs7Ww1rtF98Ja4Sqw4akr1UX3yxCr1DKFy7
        uFWkur4jk3WDC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
        0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
        0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
        0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
        pf9x0JU2_M3UUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the loongson2 thermal binding to DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v2:
		1. Add description and type about the "id".	
		2. Make the filename was based on compatible.

 .../bindings/thermal/loongson2-thermal.yaml   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
new file mode 100644
index 000000000000..2994ae3a56aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/loongson2-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Thermal sensors on loongson2 SoCs
+
+maintainers:
+  - zhanghongchen <zhanghongchen@loongson.cn>
+  - Yinbo Zhu <zhuyinbo@loongson.cn>
+
+properties:
+  compatible:
+    const: loongson,loongson2-thermal
+
+  reg:
+    maxItems: 1
+
+  id:
+    $ref: '//schemas/types.yaml#/definitions/uint32'
+    description: |
+      Specify the thermal sensor id.
+    minimum: 0
+    maximum: 3
+
+  interrupts:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - id
+  - interrupt-parent
+  - interrupts
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal: thermal@1fe01500 {
+        compatible = "loongson,loongson2-thermal";
+        reg = <0 0x1fe01500 0 0x30>;
+        id = <0>;
+        interrupt-parent = <&icu>;
+        interrupts = <7>;
+        #thermal-sensor-cells = <1>;
+    };
-- 
2.31.1

