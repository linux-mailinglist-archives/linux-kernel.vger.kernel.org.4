Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C465B9823
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiIOJwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiIOJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:51:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DF69C236;
        Thu, 15 Sep 2022 02:49:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fv3so17265068pjb.0;
        Thu, 15 Sep 2022 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XZRFVxasDVXXPTfv/lGT5hPcHgNLG3wH8AQQYSGVOn0=;
        b=CHEaj8o6rUnkzlrh5/8SeK87KJ2c9UiiJJ9xh+L1HIvR8lmheucStaJflVyp+/NGFg
         PLmLVDP2m6oz456hzOonnHOAN5BU/7161B9N+zMg0CIM2zfHsqb/kkHzddhAkzDIzwBx
         UWVZwCRpeAfn3P/uuvXy1qTqcf/O1ZvalqDQ6iJ74j6cDNK8eZNZ/TWnJ0YaGLq7tb2+
         XfopZvNH42zV/i8BcxiJ4HF77QylZhZF1ntzxAvWe5q+27H7Ky40YdNwbmrHXiJPCsZU
         gHyiyG+Pdg6n5jG7xLOkp8e2XEQ/cv53/8rxTceGvxjHMOpux54PnxF6ghIwwfNQpSH8
         AmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XZRFVxasDVXXPTfv/lGT5hPcHgNLG3wH8AQQYSGVOn0=;
        b=7QsztCkrwUM39l+ccmr0c7K/kqsQU0iLeOOjengzzbyU5VCoQeoSYAIdB/+MdLV1ct
         uPpR1p96lmHPGWTtxh85iebO4zl0ICuf/FrqJXdS2ZPfgZIia2ddb1W9vZV/LvaJ/ZEg
         8QdPECCP22eOpf33Udy88UcBmerjQMQBccWnX5LJWb57DF9NrPr3ZYh2veBieZJVju1+
         mrPbqjA9/4GtJtmxN5GOMC3+ZaBgHPQBd7I9M/XW4R57+goz2+TCBoh1C7+LUmn0uJPr
         w2LIWKdZ/2jM3rHaW5QP5Tfg0nBJsRHPQ5D5obEm9ZArqA73cPBzA9k08AEY9YIWuDZU
         TTfw==
X-Gm-Message-State: ACrzQf2AWYBjvvDo0UeThX+p1sRXATtYzIkmp/2NI/XZBjWA5Qx8UDaX
        d3wD2wlF+7T3Ob8xpJDa6gc=
X-Google-Smtp-Source: AMsMyM6jw/0irDXX/Ze7py7FgfZpT6tu0F+1SFoo+4JvX8TVTzCtEcOlS3P/UWc9o0xM2cVVA9cx4Q==
X-Received: by 2002:a17:903:32d1:b0:178:1cf0:5081 with SMTP id i17-20020a17090332d100b001781cf05081mr3615240plr.54.1663235351320;
        Thu, 15 Sep 2022 02:49:11 -0700 (PDT)
Received: from RD-3580-24288.rt.l (114-137-177-189.emome-ip.hinet.net. [114.137.177.189])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b00176675adbe1sm12669010plh.208.2022.09.15.02.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:49:11 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        broonie@kernel.org, mazziesaccount@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 2/8] dt-bindings: leds: mt6370: Add MediaTek MT6370 current sink type LED indicator
Date:   Thu, 15 Sep 2022 17:47:30 +0800
Message-Id: <206f5cfdcb62d9f34f1fbbaaa6d43e596c16122d.1663254344.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663254344.git.chiaen_wu@richtek.com>
References: <cover.1663254344.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
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

From: ChiYuan Huang <cy_huang@richtek.com>

Add MediaTek MT6370 current sink type LED indicator binding documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../bindings/leds/mediatek,mt6370-indicator.yaml   | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
new file mode 100644
index 0000000..204b103
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/mediatek,mt6370-indicator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LED driver for MT6370 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Alice Chen <alice_chen@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  Add MT6370 LED driver include 4-channel RGB LED support Register/PWM/Breath Mode
+
+allOf:
+  - $ref: leds-class-multicolor.yaml#
+
+properties:
+  compatible:
+    const: mediatek,mt6370-indicator
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^multi-led@[0-3]$":
+    type: object
+
+    properties:
+      reg:
+        enum: [0, 1, 2, 3]
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-2]$":
+        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            enum: [0, 1, 2]
+
+        required:
+          - reg
+          - color
+
+    required:
+      - reg
+      - color
+      - "#address-cells"
+      - "#size-cells"
+
+  "^led@[0-3]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [0, 1, 2, 3]
+
+    required:
+      - reg
+      - color
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
-- 
2.7.4

