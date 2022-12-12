Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969BE64A509
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiLLQii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiLLQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:38:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769DC1648C;
        Mon, 12 Dec 2022 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670863007; x=1702399007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pAKxK37YXhqrsUkc+3DMZ5ZEleN2hTTXdA9Gs5kqlbU=;
  b=BPUDlXKWsO1zlmfZ6c/25xJ8za8/wwB1EB7AGNs4WszDhQmcX4/NfoVm
   y27N0cF3ca+/6sBbvaDF19rjCCgLrCu9zfZO86rzXB9lpKHETEFMzakIf
   s558zbp+oD1NdhFkLz7fBKm6zIm3QDxPQ2I/SbNC5Mm8a4f/uBbZ7Mebd
   p1bXS/MX7JMxYXJ2G+VEvjKLERkOeQQ/E91u4bv6yKG+b0yzS/aduMm97
   Oue804JCn067EH+aWIwikqhypizNvUpdc8GIXRCir9GLt/B9U5F0+WtDl
   rSshXm1UFRzfJjQG2CsxUFAxUnlsL1RFJELPFCI3YZ2Szys5/jVM1tke8
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="127727121"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Dec 2022 09:36:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 09:36:36 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 09:36:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/4] ASoC: dt-bindings: microchip: use proper naming syntax
Date:   Mon, 12 Dec 2022 18:41:50 +0200
Message-ID: <20221212164153.78677-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221212164153.78677-1-claudiu.beznea@microchip.com>
References: <20221212164153.78677-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the following syntax for Microchip ASoC YAML files:
vendor,device.yaml

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../bindings/sound/mchp,i2s-mcc.yaml          | 108 ------------------
 ...,pdmc.yaml => microchip,sama7g5-pdmc.yaml} |   0
 ...rx.yaml => microchip,sama7g5-spdifrx.yaml} |   0
 ...tx.yaml => microchip,sama7g5-spdiftx.yaml} |   0
 4 files changed, 108 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
 rename Documentation/devicetree/bindings/sound/{microchip,pdmc.yaml => microchip,sama7g5-pdmc.yaml} (100%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdifrx.yaml => microchip,sama7g5-spdifrx.yaml} (100%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdiftx.yaml => microchip,sama7g5-spdiftx.yaml} (100%)

diff --git a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml b/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
deleted file mode 100644
index 0481315cb5f2..000000000000
--- a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
+++ /dev/null
@@ -1,108 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/mchp,i2s-mcc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Microchip I2S Multi-Channel Controller
-
-maintainers:
-  - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
-
-description:
-  The I2SMCC complies with the Inter-IC Sound (I2S) bus specification and
-  supports a Time Division Multiplexed (TDM) interface with external
-  multi-channel audio codecs. It consists of a receiver, a transmitter and a
-  common clock generator that can be enabled separately to provide Adapter,
-  Client or Controller modes with receiver and/or transmitter active.
-  On later I2SMCC versions (starting with Microchip's SAMA7G5) I2S
-  multi-channel is supported by using multiple data pins, output and
-  input, without TDM.
-
-properties:
-  "#sound-dai-cells":
-    const: 0
-
-  compatible:
-    enum:
-      - microchip,sam9x60-i2smcc
-      - microchip,sama7g5-i2smcc
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-  clocks:
-    items:
-      - description: Peripheral Bus Clock
-      - description: Generic Clock (Optional). Should be set mostly when Master
-          Mode is required.
-    minItems: 1
-
-  clock-names:
-    items:
-      - const: pclk
-      - const: gclk
-    minItems: 1
-
-  dmas:
-    items:
-      - description: TX DMA Channel
-      - description: RX DMA Channel
-
-  dma-names:
-    items:
-      - const: tx
-      - const: rx
-
-  microchip,tdm-data-pair:
-    description:
-      Represents the DIN/DOUT pair pins that are used to receive/send
-      TDM data. It is optional and it is only needed if the controller
-      uses the TDM mode.
-    $ref: /schemas/types.yaml#/definitions/uint8
-    enum: [0, 1, 2, 3]
-    default: 0
-
-if:
-  properties:
-    compatible:
-      const: microchip,sam9x60-i2smcc
-then:
-  properties:
-    microchip,tdm-data-pair: false
-
-required:
-  - "#sound-dai-cells"
-  - compatible
-  - reg
-  - interrupts
-  - clocks
-  - clock-names
-  - dmas
-  - dma-names
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/dma/at91.h>
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-
-    i2s@f001c000 {
-        #sound-dai-cells = <0>;
-        compatible = "microchip,sam9x60-i2smcc";
-        reg = <0xf001c000 0x100>;
-        interrupts = <34 IRQ_TYPE_LEVEL_HIGH 7>;
-        dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-                       AT91_XDMAC_DT_PERID(36))>,
-               <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-                       AT91_XDMAC_DT_PERID(37))>;
-        dma-names = "tx", "rx";
-        clocks = <&i2s_clk>, <&i2s_gclk>;
-        clock-names = "pclk", "gclk";
-        pinctrl-names = "default";
-        pinctrl-0 = <&pinctrl_i2s_default>;
-    };
diff --git a/Documentation/devicetree/bindings/sound/microchip,pdmc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/microchip,pdmc.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
diff --git a/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
diff --git a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdiftx.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-spdiftx.yaml
-- 
2.34.1

