Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254F16D2F8C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjDAJ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDAJ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:57:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4D7AE043;
        Sat,  1 Apr 2023 02:57:00 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxJNjr_ydkLzYVAA--.21122S3;
        Sat, 01 Apr 2023 17:56:59 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axlrzl_ydkPcgSAA--.13901S3;
        Sat, 01 Apr 2023 17:56:58 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v6 1/2] dt-bindings: spi: add loongson spi
Date:   Sat,  1 Apr 2023 17:56:51 +0800
Message-Id: <20230401095652.17364-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230401095652.17364-1-zhuyinbo@loongson.cn>
References: <20230401095652.17364-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axlrzl_ydkPcgSAA--.13901S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cr43Aw47ur17ZrWkKr4DJwb_yoW8ur1fpF
        nrCrs3GF4IqF17A393Ka48Cw4rZr95C3W2gFW2ywnFkF98K3Z8Za13Kr1UZa17AF18XFW7
        ZF92gr45K3WUJF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b38Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7
        Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
        43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        7K9aDUUUU
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Loongson platform spi binding with DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 .../bindings/spi/loongson,ls-spi.yaml         | 42 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
new file mode 100644
index 000000000000..ef113296529b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
+    maxItems: 1
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
+    spi0: spi@1fff0220{
+        compatible = "loongson,ls2k-spi";
+        reg = <0x1fff0220 0x10>;
+        clocks = <&clk 17>;
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

