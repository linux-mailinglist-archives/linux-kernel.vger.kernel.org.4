Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E855E7224
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiIWCwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiIWCwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:52:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEA211BCC0;
        Thu, 22 Sep 2022 19:52:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso6783961pjq.1;
        Thu, 22 Sep 2022 19:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XZRFVxasDVXXPTfv/lGT5hPcHgNLG3wH8AQQYSGVOn0=;
        b=AC7e/YMoRs7PdI4zPqf4eIRJ7TGejv/HIaMzTQwnf69CY8SRLkRIFrumEZn+opLCcO
         GfRpkAGRKXSflmI3c13EP4B+kPpUDmAaesrdD2XOHZxeg2iH5QxzHPncI0o1pAbVVZlv
         VJgPgp1anJls3Y5GWSO2DojXjLEdUOJQzSJlJX7IKDlsA+3WuzEPwe5FXXNMACQ1QPRa
         le8Gu2BOcf69I5JfSqo7yPytwattJFdDGGM4xGSxxbwZYofptc0EkKYt+FSvhruAmQWa
         seci6c3BC6AwTO/9ORAh6Vt4fM7VeJDVEaVXPv55dcPOTYfRRaIT3n3AZQ6w1hYIblHc
         t/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XZRFVxasDVXXPTfv/lGT5hPcHgNLG3wH8AQQYSGVOn0=;
        b=Yfgqz4ILtElE+557IjTNU2CVbrfa1IBKnhu8GqTj4dWzt/jP+048gU6roSovtAbZ3K
         6MUsipvbCNjGq37kXb40wbb5PryLlBi2UV0baKmGW+0OMnI52Q9eBKLUX048sxXOP+UV
         3GOFDOw8wRGxVBswwzqc+YUTPUBd3nXLQ5CNXoHDH3m8EEiZd+YIpm1hDG9CUfF1CFg1
         GU8Q2cYLq/tCY2YeeGTVFk8gz2pNQCqlcBqXQdtfX3/Mg+N6wB5UjZOqYw0XohYMiTJJ
         MHZa5rSnGq2grcdQrFSXDBt521Mu7ge0ICD5QMD/PnSpxuM2k5y4QFcQ+nc4aD/8XoHT
         3B8Q==
X-Gm-Message-State: ACrzQf3PxksaGe00HbvgHdz3H9WB0AbJR4d9cSgXG2A2UwKH/r6nLZnQ
        3rUI1sbozMw2EOUDBwZc15A=
X-Google-Smtp-Source: AMsMyM7eSoJTWL8zXsJbiLVdrPFOqNvwvUL1FyQ+EJ/ijefjMefhf+XTnrFrB8N+Ygdl960fPuCG7g==
X-Received: by 2002:a17:903:40c9:b0:176:e58c:f082 with SMTP id t9-20020a17090340c900b00176e58cf082mr6540418pld.60.1663901526345;
        Thu, 22 Sep 2022 19:52:06 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-76-89-227.emome-ip.hinet.net. [42.76.89.227])
        by smtp.gmail.com with ESMTPSA id f21-20020a623815000000b0053e85a4a2c9sm5167058pfa.5.2022.09.22.19.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 19:52:05 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jic23@kernel.org, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v12 1/5] dt-bindings: leds: mt6370: Add MediaTek MT6370 current sink type LED indicator
Date:   Fri, 23 Sep 2022 10:51:22 +0800
Message-Id: <27df85c30277a171ae85ff6d5b7d867625765d0a.1663926551.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663926551.git.chiaen_wu@richtek.com>
References: <cover.1663926551.git.chiaen_wu@richtek.com>
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

