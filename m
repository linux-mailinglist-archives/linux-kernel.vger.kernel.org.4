Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96D5F53F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJELrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJELrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:47:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092BB201B5;
        Wed,  5 Oct 2022 04:45:01 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a23so7351246pgi.10;
        Wed, 05 Oct 2022 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8hLDzEimJnt0JEICQzW/RTVmaSOcB+cnJU9SOjYDEQo=;
        b=dkstLcB4qT8u80g25Ulu4vSdJ9OeiwxLxyJgB2UFAaPg/Xhk/3paEAHVsM1FO76lTx
         HRLAQzg3H+UzCBq8JE7ObheXjYFN/AfPeiBLui/S2K2BCKCRO948orlpJDZovmcRjQ7/
         xjRAar4Fu9Pe92fmZYdJMJc5q0vPHlzseaYq+/gbNkEo4wNF0hLI4vrhVRHGrruhlAp4
         8IwWuHvghAHAs0MuXNLwqyXDv1Qo6E4XuRLWO71XyYDnJeGCNUd2SCMNFWHcG3aVDZOy
         jbceYf2C5EBMKybezEGR43r2P9jv1igACt4YBWnemviL6H6k63uesQBOpnJQ+XhPgxuB
         sO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8hLDzEimJnt0JEICQzW/RTVmaSOcB+cnJU9SOjYDEQo=;
        b=uiPzxp0aXJNREvC8wCx7ARHRab1/eRWHRFSsmR06YKYOt9NOFc9LEXY3/wAQviXYys
         TtrowJsmkk7biXcy1Rr9jPwXym2/o1eYxJUeMuUDylTFiJtVHQFZluo0mi0GBbSq3uOC
         druvM1173ORLL+O+DzkWNU0Z3y3WyqJJm41zxmC+yQoXClYLVCcVoSWezFYDwX41EvmT
         IpBwwYMoXQKuSvJT8rab9ihtCgo4HWPokrQ5X81L6cDVwERU6gSZS5Pi68flktHmnBsY
         F8iNF00NDb/B4g1P1+JP/sfQfq3ZfZHdXaUgC1H4pcb1/TrseL3idGkuAO4wAoJyMMU1
         D0kw==
X-Gm-Message-State: ACrzQf2yVBIcK/jTnwevpA5pVw7QRi8VVcp3KaxWrG111hkZFVE1BLqP
        QD95RBQvu2mPasgtryLgW3g=
X-Google-Smtp-Source: AMsMyM7opPIXFtREokZuT9dKhOxHwWombpjA4KcLpIjgA6WR8FzyQWYIR70rFnD3s8CO4UH8M0URQA==
X-Received: by 2002:a62:e911:0:b0:555:8c06:c9eb with SMTP id j17-20020a62e911000000b005558c06c9ebmr31915818pfh.52.1664970295432;
        Wed, 05 Oct 2022 04:44:55 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-126-108.emome-ip.hinet.net. [42.73.126.108])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b00176e2fa216csm10477447pli.52.2022.10.05.04.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:44:54 -0700 (PDT)
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
Subject: [PATCH v13 1/5] dt-bindings: leds: mt6370: Add MediaTek MT6370 current sink type LED indicator
Date:   Wed,  5 Oct 2022 19:43:54 +0800
Message-Id: <d59807369c2ad245245514c49d9f91d47c8a5851.1664991040.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664991040.git.chiaen_wu@richtek.com>
References: <cover.1664991040.git.chiaen_wu@richtek.com>
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

v13
- Remove 'allOf' property
- Add '$ref' and 'unevaluatedProperties: false' in 'multi-led'
---
 .../bindings/leds/mediatek,mt6370-indicator.yaml   | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
new file mode 100644
index 0000000..7a41647
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
@@ -0,0 +1,82 @@
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
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
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

