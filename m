Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E06665CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjAKNto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjAKNtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:49:25 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D562661;
        Wed, 11 Jan 2023 05:49:21 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id F3FB4FF80D;
        Wed, 11 Jan 2023 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673444960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMswGhUaze/v3+qic5VpHszBxBNoPuzv9ek9RV8ZYW4=;
        b=itfjrbvWHwsoMaF5WE3s7Am2NwNtjC5JHm6CMoCMWzMKNI++OcAbyr4Hx5DC5TqB/1n1wc
        kJd51ocvxxrZsrG/VslKSbyv53CfTJXhlnDMVESUMuQjCv6RBRjqqQ6sUd+aOeTR0JyxoU
        V/D3kxbR9B+EetgXovAsGhYgm6MITU6Ox+vP7iNZIkTa0SeFB7LyRsBII1ljsJtFTQPDVQ
        NYPtWbC+DSVIRMEIc5NPEb6BX8CWsl75qjlLwQPJqSRqABKgKFxTPgRhM+SWsA25nlzxnS
        X5rlwNs/iKuKRsSBIX313a1KCNN77uaWrFhQ3vSULTc8pB8cCYpY4Hp1pEBRAg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/3] dt-bindings: sound: Add Renesas IDT821034 codec
Date:   Wed, 11 Jan 2023 14:49:03 +0100
Message-Id: <20230111134905.248305-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230111134905.248305-1-herve.codina@bootlin.com>
References: <20230111134905.248305-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas IDT821034 codec is a quad PCM codec with
programmable gain.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/renesas,idt821034.yaml     | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,idt821034.yaml

diff --git a/Documentation/devicetree/bindings/sound/renesas,idt821034.yaml b/Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
new file mode 100644
index 000000000000..2c29b770e3f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/renesas,idt821034.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas IDT821034 codec device
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  The IDT821034 codec is a four channel PCM codec with onchip filters and
+  programmable gain setting.
+
+  The time-slots used by the codec must be set and so, the properties
+  'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
+  'dai-tdm-slot-rx-mask' must be present in the ALSA sound card node for
+  sub-nodes that involve the codec. The codec uses one 8bit time-slot per
+  channel.
+  'dai-tdm-tdm-slot-with' must be set to 8.
+
+  The IDT821034 codec also supports 5 gpios (SLIC signals) per channel.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: /schemas/gpio/gpio.yaml#
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: renesas,idt821034
+
+  reg:
+    description:
+      SPI device address.
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 8192000
+
+  spi-cpha: true
+
+  '#sound-dai-cells':
+    const: 0
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - '#sound-dai-cells'
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec: idt821034@0 {
+            compatible = "renesas,idt821034";
+            reg = <0>;
+            spi-max-frequency = <8192000>;
+            spi-cpha;
+            #sound-dai-cells = <0>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
+    sound {
+        compatible = "simple-audio-card";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        simple-audio-card,dai-link@0 {
+            reg = <0>;
+            format = "dsp_b";
+            cpu {
+                sound-dai = <&cpu_dai>;
+            };
+            codec {
+                sound-dai = <&codec>;
+                dai-tdm-slot-num = <4>;
+                dai-tdm-slot-width = <8>;
+                /* TS 2, 3, 5, 7 */
+                dai-tdm-slot-tx-mask = <0 0 1 1 0 1 0 1>;
+                dai-tdm-slot-rx-mask = <0 0 1 1 0 1 0 1>;
+            };
+        };
+    };
-- 
2.38.1

