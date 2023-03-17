Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC476BE395
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjCQIcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCQIcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:32:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34FC719137;
        Fri, 17 Mar 2023 01:31:03 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8CxjdoGJRRky0sNAA--.7788S3;
        Fri, 17 Mar 2023 16:29:58 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxT+T_JBRkaXIDAA--.15924S3;
        Fri, 17 Mar 2023 16:29:57 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v2 1/2] dt-bindings: spi: add loongson spi
Date:   Fri, 17 Mar 2023 16:29:49 +0800
Message-Id: <20230317082950.12738-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230317082950.12738-1-zhuyinbo@loongson.cn>
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxT+T_JBRkaXIDAA--.15924S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cr43Aw47ur17Cw4kXF17trb_yoW8uFW5pF
        nrCrs7GF4IqF17Aws3Ka48Cw4rZ3s5C3ZFgFW2yw1jkas8K3Z5Za13KF1DZanrAF4UXFW7
        ZF92kr4UK3WUXF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bVAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1s
        IEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jU
        EfOUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Loongson platform spi binding with DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 .../bindings/spi/loongson,ls-spi.yaml         | 44 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
new file mode 100644
index 000000000000..936b8dc82ce8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/loongson,ls-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson SPI controller
+
+maintainers:
+  - Yinbo Zhu <zhuyinbo@loongson.cn>
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - loongson,ls2k-spi
+      - loongson,ls7a-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/loongson,ls2k-clk.h>
+    spi0: spi@1fff0220{
+        compatible = "loongson,ls2k-spi";
+        reg = <0x1fff0220 0x10>;
+        clocks = <&clk LOONGSON2_BOOT_CLK>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 25a0981c74b6..9bc2158c735d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12157,6 +12157,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
 F:	include/dt-bindings/clock/loongson,ls2k-clk.h
 
+LOONGSON SPI DRIVER
+M:	Yinbo Zhu <zhuyinbo@loongson.cn>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
-- 
2.20.1

