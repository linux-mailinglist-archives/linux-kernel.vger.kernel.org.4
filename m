Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2865BD2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiISRAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiISRAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:00:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB241D0C7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:59:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y3so180865ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=69nrv/BKayymEj9f70cbXjRoS8M413ZGsp2FP8B+6Cc=;
        b=2ZDgXmtX7kBtwoUAyxz8rI/gnLo1usAqRIcFp//WkgUEpHJhCUTPn56LV4nSD4vc96
         4ADNXslH3B5Shd0LcD3JYJ/7M2ZPxpmYvmlBYDwnciQmIb+dd8rT5emdFWvOx80yejKt
         MMM8QfLsaPoNoAkDCdmmVoQB2LnGEf+DCqPv8SpIhTDkZiFUJpu0OAbbaTMsM6wKYWVG
         lg3lGETEKJf+8OgeAlqZ+L88vbRecsFHARHMiEUM2ZXJKQC9sUEXHYWN4IGWITGu4Cvj
         f6wMQhd6qOjwNEIuq/p2LxdNHcLGhBDZkGkNOuxddNG8AASoFiH/teUXDgyW9sEztL18
         s+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=69nrv/BKayymEj9f70cbXjRoS8M413ZGsp2FP8B+6Cc=;
        b=UtbDF3DAiL9aiNXCL2y3lV4aH43yEdNV8OM3o3hzKew38AoGb0aYD8AvNI3epRMYpH
         qfLpX0umfpSG+Qgjp9eXzqIKotJ1KfUPb/D51a7MP2IKUpFfB2GwV2LRJ7iYG/NmMcit
         Zj6lOOrhC8aJyiae5t8mPo5WzgaCkQRE4gPAPExvaJ66Ou+lMe11qW+ylbw8CbUsfZmX
         3UsZfmSAZBiBMu1qqjs5iheR0o0yXkItLdiYOjetmMcB2qd/FpcKjdaOgBy2n/Dtw0+4
         s91EevTGxkP3QkwQvomSHie2nct1xMqezl4d9k/eq1aXumEzMBYwLVa7wiEcntRwWsim
         fmUw==
X-Gm-Message-State: ACrzQf3lFoSoi619cAfofmM3PNBb/kkg+UjGKl0C9USSLvmiL/8UlyPD
        8BUPDTw/4NZpkN0EbtsxNtlY2A==
X-Google-Smtp-Source: AMsMyM6XlPFlhgC04B9QuW2zwPNOCYiGRhmcbXp9t18fVx3nugtxHUNV8fsXdbf/C+/TYrDgfmHhoA==
X-Received: by 2002:a17:907:7b9a:b0:778:adc1:1b0b with SMTP id ne26-20020a1709077b9a00b00778adc11b0bmr13092811ejc.569.1663606791165;
        Mon, 19 Sep 2022 09:59:51 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6340-f287-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6340:f287:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id cf16-20020a0564020b9000b0044fc3c0930csm20424246edb.16.2022.09.19.09.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:59:50 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 19 Sep 2022 18:56:02 +0200
Subject: [PATCH v1 04/17] dt-bindings: display: mediatek: add MT8195 hdmi bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v1-4-4844816c9808@baylibre.com>
References: <20220919-v1-0-4844816c9808@baylibre.com>
In-Reply-To: <20220919-v1-0-4844816c9808@baylibre.com>
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8195 SoC bindings for hdmi and hdmi-ddc

Make port1 optional for mt8195 as it only supports HDMI tx for now.
Requires a ddc-i2c-bus phandle.
Requires a power-domains phandle.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
index bdaf0b51e68c..abb231a0694b 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
@@ -21,6 +21,10 @@ properties:
       - mediatek,mt7623-hdmi
       - mediatek,mt8167-hdmi
       - mediatek,mt8173-hdmi
+      - mediatek,mt8195-hdmi
+
+  clocks: true
+  clock-names: true
 
   reg:
     maxItems: 1
@@ -28,20 +32,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  clocks:
-    items:
-      - description: Pixel Clock
-      - description: HDMI PLL
-      - description: Bit Clock
-      - description: S/PDIF Clock
-
-  clock-names:
-    items:
-      - const: pixel
-      - const: pll
-      - const: bclk
-      - const: spdif
-
   phys:
     maxItems: 1
 
@@ -58,6 +48,16 @@ properties:
     description: |
       phandle link and register offset to the system configuration registers.
 
+  ddc-i2c-bus:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: Phandle to the ddc-i2c device
+
+  power-domains:
+    description:
+      A phandle and PM domain specifier as defined by bindings
+      of the power controller specified by phandle. See
+      Documentation/devicetree/bindings/power/power-domain.yaml for details.
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -76,7 +76,6 @@ properties:
 
     required:
       - port@0
-      - port@1
 
 required:
   - compatible
@@ -86,9 +85,55 @@ required:
   - clock-names
   - phys
   - phy-names
-  - mediatek,syscon-hdmi
   - ports
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8195-hdmi
+    then:
+      properties:
+        clocks:
+          items:
+            - description: APB
+            - description: HDCP
+            - description: HDCP 24M
+            - description: Split HDMI
+        clock-names:
+          items:
+            - const: hdmi_apb_sel
+            - const: hdcp_sel
+            - const: hdcp24_sel
+            - const: split_hdmi
+
+      required:
+        - power-domains
+        - ddc-i2c-bus
+    else:
+      properties:
+        clocks:
+          items:
+            - description: Pixel Clock
+            - description: HDMI PLL
+            - description: Bit Clock
+            - description: S/PDIF Clock
+
+        clock-names:
+          items:
+            - const: pixel
+            - const: pll
+            - const: bclk
+            - const: spdif
+
+        ports:
+          required:
+            - port@1
+
+      required:
+        - mediatek,syscon-hdmi
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
new file mode 100644
index 000000000000..3c80bcebe6d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek HDMI DDC Device Tree Bindings for mt8195
+
+maintainers:
+  - CK Hu <ck.hu@mediatek.com>
+  - Jitao shi <jitao.shi@mediatek.com>
+
+description: |
+  The HDMI DDC i2c controller is used to interface with the HDMI DDC pins.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-hdmi-ddc
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ddc-i2c
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    hdmiddc0: ddc_i2c {
+      compatible = "mediatek,mt8195-hdmi-ddc";
+      clocks = <&clk26m>;
+      clock-names = "ddc-i2c";
+    };
+
+...

-- 
b4 0.10.0-dev
