Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D46872FC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbjFNLNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbjFNLNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:13:11 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F48A26B6;
        Wed, 14 Jun 2023 04:12:47 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.124])
        by gateway (Coremail) with SMTP id _____8Cx_equoIlk+hkFAA--.11006S3;
        Wed, 14 Jun 2023 19:12:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.124])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxNeSsoIlklIkaAA--.10308S4;
        Wed, 14 Jun 2023 19:12:44 +0800 (CST)
From:   YingKun Meng <mengyingkun@loongson.cn>
To:     krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Yingkun Meng <mengyingkun@loongson.cn>
Subject: [ PATCH RESEND v2 3/3] ASoC: dt-bindings: Add support for Loongson audio card
Date:   Wed, 14 Jun 2023 19:11:39 +0800
Message-Id: <20230614111139.3399284-1-mengyingkun@loongson.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxNeSsoIlklIkaAA--.10308S4
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQACDGSIXIIYSwAFsr
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4DXF4xJF1DArW5ArW3XFc_yoW5Jr15pw
        s3C34UGrW8t3W7Cas5ZFyxAw4fZasayFsrXr42qw1UCFZ8K3WFqw4ak3WUu3W2kF1kJay7
        uFyFkw18Gas3CwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yingkun Meng <mengyingkun@loongson.cn>

The audio card uses loongson I2S controller present in
7axxx/2kxxx chips to transfer audio data.

On loongson platform, the chip has only one I2S controller.

Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
---
v1 -> v2:
* Add chip model restriction for title and description.
* Add 'required' restriction for sound-dai property.

 .../sound/loongson,ls-audio-card.yaml         | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml

diff --git a/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml b/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
new file mode 100644
index 000000000000..61e8babed402
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/loongson,ls-audio-card.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson 7axxx/2kxxx ASoC audio sound card driver
+
+maintainers:
+  - Yingkun Meng <mengyingkun@loongson.cn>
+
+description:
+  The binding describes the sound card present in loongson
+  7axxx/2kxxx platform. The sound card is an ASoC component
+  which uses Loongson I2S controller to transfer the audio data.
+
+properties:
+  compatible:
+    const: loongson,ls-audio-card
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  mclk-fs:
+    $ref: simple-card.yaml#/definitions/mclk-fs
+
+  cpu:
+    description: Holds subnode which indicates cpu dai.
+    type: object
+    additionalProperties: false
+    properties:
+      sound-dai:
+        maxItems: 1
+    required:
+      - sound-dai
+
+  codec:
+    description: Holds subnode which indicates codec dai.
+    type: object
+    additionalProperties: false
+    properties:
+      sound-dai:
+        maxItems: 1
+    required:
+      - sound-dai
+
+required:
+  - compatible
+  - model
+  - mclk-fs
+  - cpu
+  - codec
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "loongson,ls-audio-card";
+        model = "loongson-audio";
+        mclk-fs = <512>;
+
+        cpu {
+            sound-dai = <&i2s>;
+        };
+        codec {
+             sound-dai = <&es8323>;
+        };
+    };
-- 
2.33.0

