Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CE168C077
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjBFOt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjBFOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:49:23 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C31BAF2;
        Mon,  6 Feb 2023 06:49:21 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 7FAB16000D;
        Mon,  6 Feb 2023 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675694960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hc6tSYGP6pagK3HP8K5vQ3QQwbkp4/tptja2Ht0GKFQ=;
        b=gyaIhfKU3HeXmm3q7l9+kcBrul7dOc3Y05n+SoLGJRlpgK0BypASD7/fgtSK0m9fwCewPu
        LzCeCb0slfEN5GNjo62KkrOvCPddVn1JhteeOljtZBOdKSeIvxsz8pfSPx0pSgu7n1QBBn
        9IKoTBwKoc9llEh/vMAv7bNiCE2E2HTnd2Gf8umYwCNO7CG61DE9u5MHkRbnPvcTwJtqGY
        xv4FLTsxSXZpYaSEC4fGUm4We7UwUK1f91IZpRDzgKxbJtbNd2SKmZz0P/6f1btinp4IOV
        kRBkuYuD/Cto75NHKpvZyegLMzAbWQFyuA0Uv+yFmSYjRjh4GPAqbaLckacOrg==
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
Subject: [PATCH 1/3] dt-bindings: sound: Add the Infineon PEB2466 codec
Date:   Mon,  6 Feb 2023 15:49:02 +0100
Message-Id: <20230206144904.91078-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206144904.91078-1-herve.codina@bootlin.com>
References: <20230206144904.91078-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Infineon PEB2466 codec is a programmable DSP-based four channels
codec with filters capabilities.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/infineon,peb2466.yaml      | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/infineon,peb2466.yaml

diff --git a/Documentation/devicetree/bindings/sound/infineon,peb2466.yaml b/Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
new file mode 100644
index 000000000000..66993d378aaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/infineon,peb2466.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon PEB2466 codec
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  The Infineon PEB2466 codec is a programmable DSP-based four channels codec
+  with filters capabilities.
+
+  The time-slots used by the codec must be set and so, the properties
+  'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
+  'dai-tdm-slot-rx-mask' must be present in the sound card node for sub-nodes
+  that involve the codec. The codec uses one 8bit time-slot per channel.
+  'dai-tdm-tdm-slot-with' must be set to 8.
+
+  The PEB2466 codec also supports 28 gpios (signaling pins).
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: infineon,peb2466
+
+  reg:
+    description:
+      SPI device address.
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Master clock
+
+  clock-names:
+    items:
+      - const: mclk
+
+  spi-max-frequency:
+    maximum: 8192000
+
+  reset-gpios:
+    description:
+      GPIO used to reset the device.
+    maxItems: 1
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Filters coefficients file to load. If this property is omitted, internal
+      filters are disabled.
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
+  - '#sound-dai-cells'
+  - gpio-controller
+  - '#gpio-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        audio-codec@0 {
+            compatible = "infineon,peb2466";
+            reg = <0>;
+            spi-max-frequency = <8192000>;
+            reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
+            #sound-dai-cells = <0>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
-- 
2.39.1

