Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272265B5502
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiILHG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiILHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:06:54 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B22AC48;
        Mon, 12 Sep 2022 00:06:53 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h188so7397223pgc.12;
        Mon, 12 Sep 2022 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VPkcWUP8a7bxjZ+WnoIZDgbqJYUoZq4umIQXPyi4AwU=;
        b=Az0bMM9e4dFt4KHB2/pRHFbq9bHidUOx4uwY+g5vmKGfujje6higRXjTPrQv9h09zc
         OJ+zoqvKJGygUBoY7C0K8uRCvNqviM45Rh54aQTAVjs7nBfUXFIoJVcbw3Qk3IKolU3r
         Qc8zWrVkUUv4acgeKlNwqErbMzQNQq+AG01AjbxMCuNqwUo0U+whAuYtz+bWorSSQ+7H
         /BHBa3p+QM7qrtxihgqoKy/jDht3kPBPr595gWZ/fOfeqORMCKdM1ICkgduzRqawJjLq
         ntTLtjM1+FY4HxEJGqonauBnnwIjlYThL859HZoochqRJJCVIZPPlgfxFt/u9CaxjMTx
         Nf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VPkcWUP8a7bxjZ+WnoIZDgbqJYUoZq4umIQXPyi4AwU=;
        b=WeDkoDOiO3P50Qplxtohmc02M/HKdYv/M24Yg3Gy6FcG5YcnX7C6oQVEKo0fdUk3aA
         0amHrhZq4LTvCB6k2p8ZDI3wwEaAoUFqtMBwFcjfhanxq07aJgjsbWjcZjb/XeujcfWv
         Q0HkCBo/59lg/TWuoynGs70DEzVFst3RqihvCy979TIxlj+7kuye6pxrURY4tiakljL5
         rf9j5FDjmba/S8vqTZ/uIFWeBEalotCU0jv7KYRtc69VGyK467gZTZRtV+scziT0xlbO
         A4IOaVlmJSs+AdE3ng4Bta//oPY1J4Y2zssXZ34GcuZ7Q+3qLoLlO3DTeM5iuoDkZHSI
         b+pg==
X-Gm-Message-State: ACgBeo3HMz0uyA5DiVITXiU/3OV5+2kWJTtYm9x2I9blnRMLDF+MtaP+
        Huq7dUKVoXzjfKllHG+hvw==
X-Google-Smtp-Source: AA6agR5sOzgwjECD1D0nDs7nRdEwTgd64nguOrzqvuMeMOIlt4aTkfSLaD6/5aTj/YYygs27FibgfA==
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:630e with SMTP id b12-20020a056a00114c00b005282c7a630emr26125991pfm.86.1662966412655;
        Mon, 12 Sep 2022 00:06:52 -0700 (PDT)
Received: from localhost.localdomain ([113.110.235.160])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e80e00b0017685f53537sm5123557plg.186.2022.09.12.00.06.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Sep 2022 00:06:52 -0700 (PDT)
From:   Ban Tao <fengzheng923@gmail.com>
To:     fengzheng923@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Date:   Mon, 12 Sep 2022 00:05:33 -0700
Message-Id: <1662966333-18000-1-git-send-email-fengzheng923@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding documentation for this new ASoC driver.

Signed-off-by: Ban Tao <fengzheng923@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
---
v1->v2:
1.Fix some build errors.

v2->v3:
1.Fix some build errors.

v3->v4:
1.None.

v4->v5:
1.Add interrupt.
2.Keep clock and reset index.

v5->v6:
1.None.

v6->v7:
1.None.

v7->v8:
1.Fix some build errors.

v8->v9:
1.None.

v9->v10:
1.Put compatible first in the list of properties.
---
 .../bindings/sound/allwinner,sun50i-h6-dmic.yaml   | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
new file mode 100644
index 0000000..2f12cab
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/allwinner,sun50i-h6-dmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner H6 DMIC
+
+maintainers:
+  - Ban Tao <fengzheng923@gmail.com>
+
+properties:
+  compatible:
+    const: allwinner,sun50i-h6-dmic
+
+  "#sound-dai-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mod
+
+  dmas:
+    items:
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    #include <dt-bindings/clock/sun50i-h6-ccu.h>
+    #include <dt-bindings/reset/sun50i-h6-ccu.h>
+
+    dmic: dmic@5095000 {
+      #sound-dai-cells = <0>;
+      compatible = "allwinner,sun50i-h6-dmic";
+      reg = <0x05095000 0x400>;
+      interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&ccu CLK_BUS_DMIC>, <&ccu CLK_DMIC>;
+      clock-names = "bus", "mod";
+      dmas = <&dma 7>;
+      dma-names = "rx";
+      resets = <&ccu RST_BUS_DMIC>;
+    };
+
+...
-- 
2.7.4

