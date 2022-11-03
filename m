Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5444761788C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiKCIUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiKCIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:20:01 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5415A6387;
        Thu,  3 Nov 2022 01:19:59 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8Axz7eteWNjRS8EAA--.9735S3;
        Thu, 03 Nov 2022 16:19:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDuKkeWNjx4ELAA--.33587S3;
        Thu, 03 Nov 2022 16:19:55 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/2] dt-bindings: soc: add loongson-2 chipid
Date:   Thu,  3 Nov 2022 16:19:42 +0800
Message-Id: <20221103081942.3529-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221103081942.3529-1-zhuyinbo@loongson.cn>
References: <20221103081942.3529-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDuKkeWNjx4ELAA--.33587S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF47tF4kJw17CF4UtF4xZwb_yoW5Gryrpa
        17Cr95KF4Iq3W7uanxKa4Ik3WrZF93AanFgFZFyw13KrWqgw1Fqw13K3WDZa17Zr17JayU
        uFyfKr45WF48Cr7anT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jw0_GFyle2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
        Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj
        6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
        JbIYCTnIWIevJa73UjIFyTuYvjxUciL0UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Loongson-2 SoC chipid binding with DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Change in v5:
		1. Add all history change log information.
		2. Add reviewed-by information.
Change in v4:
		1. NO change, but other patch in this series of patches set	
		   has changes.
Change in v3:
		1. Drop "driver" and describe instead what is GUTS, including
		   its acronym.
		2. Add desciption about the SoC register.
		3. Fixup dts node name.
		4. Replace string loongson2/Loongson2 with loongson-2/Loongson-2
                   in binding file and commit message.
Change in v2:
		1. NO change, but other patch in this series of patches set	
		   has changes.

 .../bindings/hwinfo/loongson,ls2k-chipid.yaml | 38 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml

diff --git a/Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml b/Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
new file mode 100644
index 000000000000..9d0c36ec1982
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwinfo/loongson,ls2k-chipid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-2 SoC ChipID
+
+maintainers:
+  - Yinbo Zhu <zhuyinbo@loongson.cn>
+
+description: |
+  Loongson-2 SoC contains many groups of global utilities register
+  blocks, of which the ChipID group registers record SoC version,
+  feature, vendor and id information.
+
+properties:
+  compatible:
+    const: loongson,ls2k-chipid
+
+  reg:
+    maxItems: 1
+
+  little-endian: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    chipid: chipid@1fe00000 {
+        compatible = "loongson,ls2k-chipid";
+        reg = <0x1fe00000 0x3ffc>;
+        little-endian;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 20ce056ae207..916b2d9cffc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12045,6 +12045,7 @@ LOONGSON-2 SOC SERIES GUTS DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	loongarch@lists.linux.dev
 S:	Maintained
+F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
 F:	drivers/soc/loongson/loongson2_guts.c
 
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
-- 
2.20.1

