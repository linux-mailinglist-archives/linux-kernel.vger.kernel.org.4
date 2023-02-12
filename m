Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B91693B12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 00:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBLXVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 18:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjBLXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 18:21:44 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8158A1BC8;
        Sun, 12 Feb 2023 15:21:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n33so1562078wms.0;
        Sun, 12 Feb 2023 15:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxzNaW6I0fLNWCS9Oc9e/6gDL8buv4rI/3fG8NdUfZM=;
        b=YxAW4UwTezMfmdVo1Nl41KG8a4sWPOcryhtlVzJT6IDZQys7SAk5XgHXBH+Mg273iV
         5+yYjnaZhL1+NWtm3/KlVHau/wjEB+F/cIi1/ORB/gOdnmu8BUgit3HH7BcoRHZj+FSa
         F4GdZsFS5+eFfZyTcLs9TK6Yw2kCdqKXz/sEH4cN7e0C2gMZb1fSqYB9usEghhjSkmuR
         QMLT8x1F+wp+hASXNroo9caQGZx+3xTYVNcTfMI4rbMq3iYS2pxrhtRi28FPTjmaQjFx
         zoX3OSAuAuSMmbCOINuwSGPWupzrpCKJjatfUV8fiD3PX3RgQ6vOzdcs1qjvBjmG1IHS
         kgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxzNaW6I0fLNWCS9Oc9e/6gDL8buv4rI/3fG8NdUfZM=;
        b=JxI8ytgNxo6gyAfekrff87h6MPTmNzHRGSC5+8nrqpEWh5KNc2nOm4cUeEdHo3qzzq
         Ybbuds+vgTrbFkgszhLMwJuLzhp63DqM3Kgy3kSXRbIiC/7WAAjgNZQudnLik0E5qKdw
         vwcZgXcfe+xFNVYdf81GBX8bL5WuO2sqvPdar+UumzY4ZlGvTjdwioGynAWtqhJKb5xU
         7NRwPhUlq0hdxaRt4W1YfQ4deW8+4eBBvywzbKoQ8CaDPJrbmH95H+hhM0QxJsbfou8k
         5OsXfqaXe1wKzR319wNRu+ZHcloy/fIVX+uYk/gUTsyV5/J4DphLySlNNbVypoiBYuQK
         lZSw==
X-Gm-Message-State: AO0yUKW8j/bwg0XRQ+EjUiJ/Di1wGSPO9sTzh01TV5PO2pYOUZ0ervt0
        HjIFQXE41qXVFnx9Fhxw4EGEkK1B9Zw9A7U7
X-Google-Smtp-Source: AK7set8FeLsNAVdoImo2fwRuicgKBYl6QRDgEjD9OLjW+s7/9U/IdECxA+GDa3j7X7NsiZx3ZSGzXg==
X-Received: by 2002:a05:600c:3086:b0:3dc:5c86:12f3 with SMTP id g6-20020a05600c308600b003dc5c8612f3mr21658640wmn.1.1676244101006;
        Sun, 12 Feb 2023 15:21:41 -0800 (PST)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id g20-20020a7bc4d4000000b003a3442f1229sm15417359wmk.29.2023.02.12.15.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 15:21:40 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: sound: ep93xx: Add I2S and AC'97 descriptions
Date:   Mon, 13 Feb 2023 00:21:36 +0100
Message-Id: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Cirrus Logic EP93xx internal SoCs' I2S and
AC'97 controllers.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 .../bindings/sound/cirrus,ep9301-ac97.yaml    | 47 ++++++++++++++
 .../bindings/sound/cirrus,ep9301-i2s.yaml     | 63 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml
new file mode 100644
index 000000000000..bfa5d392f525
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,ep9301-ac97.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus EP93xx AC'97 Controller
+
+description: |
+  The AC’97 Controller includes a 5-pin serial interface to an external audio
+  codec.
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+properties:
+  compatible:
+    const: cirrus,ep9301-ac97
+
+  '#sound-dai-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#sound-dai-cells'
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    ac97: ac97@80880000 {
+        compatible = "cirrus,ep9301-ac97";
+        #sound-dai-cells = <0>;
+        reg = <0x80880000 0xac>;
+        interrupt-parent = <&vic0>;
+        interrupts = <6>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
new file mode 100644
index 000000000000..b47d28dc8389
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,ep9301-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus EP93xx I2S Controller
+
+description: |
+  The I2S controller is used to stream serial audio data between the external
+  I2S CODECs’, ADCs/DACs, and the ARM Core. The controller supports I2S, Left-
+  and Right-Justified DSP formats.
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+properties:
+  compatible:
+    const: cirrus,ep9301-i2s
+
+  '#sound-dai-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: sclk
+      - const: lrclk
+
+required:
+  - compatible
+  - '#sound-dai-cells'
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    i2s: i2s@80820000 {
+        compatible = "cirrus,ep9301-i2s";
+        #sound-dai-cells = <0>;
+        reg = <0x80820000 0x100>;
+        interrupt-parent = <&vic1>;
+        interrupts = <28>;
+        clocks = <&syscon 29
+                  &syscon 30
+                  &syscon 31>;
+        clock-names = "mclk", "sclk", "lrclk";
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 254aab631fd4..765902756c37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2092,6 +2092,7 @@ M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
+F:	Documentation/devicetree/bindings/sound/cirrus,ep9301-*
 F:	arch/arm/mach-ep93xx/
 F:	arch/arm/mach-ep93xx/include/mach/
 F:	drivers/iio/adc/ep93xx_adc.c
-- 
2.39.1

