Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3666965951B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 06:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiL3FzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 00:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiL3FzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 00:55:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFF315825;
        Thu, 29 Dec 2022 21:54:57 -0800 (PST)
X-UUID: 0fea809e99b1460fa439a6efb14195ad-20221230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rGAJ+mx9MnLiMiiPpbATgDzUI/yDjaKJCixkw3y/iRo=;
        b=AT0Ag/+rWfQuFCi2+R8VJ/EV73Sqw8DvMbxUmFjhEAd31Itg4VJvOoYIspwdyV4fAxS4t25uhb51buCxJF+zjgm/dEwuiK3zrRLd7yMZLZ2e2QTvRpQPkQGlolSZlJ+dBuBJVqDTToKZpKE+1sqdY0r2XGOWZ3U05ukd2ZRMBFI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:39ec009d-a132-42bc-956c-90781bf7541d,IP:0,U
        RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:09771b1,CLOUDID:22f45ff4-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 0fea809e99b1460fa439a6efb14195ad-20221230
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2014454617; Fri, 30 Dec 2022 13:54:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Dec 2022 13:54:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Dec 2022 13:54:50 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <p.zabel@pengutronix.de>
CC:     <trevor.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 10/13] dt-bindings: mediatek: mt8188: add audio afe document
Date:   Fri, 30 Dec 2022 13:54:40 +0800
Message-ID: <20221230055443.16024-11-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221230055443.16024-1-trevor.wu@mediatek.com>
References: <20221230055443.16024-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8188 audio afe document.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../bindings/sound/mediatek,mt8188-afe.yaml   | 208 ++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
new file mode 100644
index 000000000000..7402bf7750ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
@@ -0,0 +1,208 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt8188-afe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek AFE PCM controller for mt8188
+
+maintainers:
+  - Trevor Wu <trevor.wu@mediatek.com>
+
+properties:
+  compatible:
+    const: mediatek,mt8188-afe
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: audiosys
+
+  mediatek,topckgen:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the mediatek topckgen controller
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: 26M clock
+      - description: audio pll1 clock
+      - description: audio pll2 clock
+      - description: clock divider for i2si1_mck
+      - description: clock divider for i2si2_mck
+      - description: clock divider for i2so1_mck
+      - description: clock divider for i2so2_mck
+      - description: clock divider for dptx_mck
+      - description: a1sys hoping clock
+      - description: audio intbus clock
+      - description: audio hires clock
+      - description: audio local bus clock
+      - description: mux for dptx_mck
+      - description: mux for i2so1_mck
+      - description: mux for i2so2_mck
+      - description: mux for i2si1_mck
+      - description: mux for i2si2_mck
+      - description: audio 26m clock
+
+  clock-names:
+    items:
+      - const: clk26m
+      - const: apll1
+      - const: apll2
+      - const: apll12_div0
+      - const: apll12_div1
+      - const: apll12_div2
+      - const: apll12_div3
+      - const: apll12_div9
+      - const: a1sys_hp_sel
+      - const: aud_intbus_sel
+      - const: audio_h_sel
+      - const: audio_local_bus_sel
+      - const: dptx_m_sel
+      - const: i2so1_m_sel
+      - const: i2so2_m_sel
+      - const: i2si1_m_sel
+      - const: i2si2_m_sel
+      - const: adsp_audio_26m
+
+  mediatek,etdm-in1-cowork-source:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      etdm modules can share the same external clock pin. Specify
+      which etdm clock source is required by this etdm in module.
+    enum:
+      - 1 # etdm2_in
+      - 2 # etdm1_out
+      - 3 # etdm2_out
+
+  mediatek,etdm-in2-cowork-source:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      etdm modules can share the same external clock pin. Specify
+      which etdm clock source is required by this etdm in module.
+    enum:
+      - 0 # etdm1_in
+      - 2 # etdm1_out
+      - 3 # etdm2_out
+
+  mediatek,etdm-out1-cowork-source:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      etdm modules can share the same external clock pin. Specify
+      which etdm clock source is required by this etdm out module.
+    enum:
+      - 0 # etdm1_in
+      - 1 # etdm2_in
+      - 3 # etdm2_out
+
+  mediatek,etdm-out2-cowork-source:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      etdm modules can share the same external clock pin. Specify
+      which etdm clock source is required by this etdm out module.
+    enum:
+      - 0 # etdm1_in
+      - 1 # etdm2_in
+      - 2 # etdm1_out
+
+patternProperties:
+  "^mediatek,etdm-in[1-2]-chn-disabled$":
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 1
+    maxItems: 16
+    description:
+      This is a list of channel IDs which should be disabled.
+      By default, all data received from ETDM pins will be outputed to
+      memory. etdm in supports disable_out in direct mode(w/o interconn),
+      so user can disable the specified channels by the property.
+    uniqueItems: true
+    items:
+      minimum: 0
+      maximum: 15
+
+  "^mediatek,etdm-in[1-2]-multi-pin-mode$":
+    type: boolean
+    description: if present, the etdm data mode is I2S.
+
+  "^mediatek,etdm-out[1-3]-multi-pin-mode$":
+    type: boolean
+    description: if present, the etdm data mode is I2S.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - resets
+  - reset-names
+  - mediatek,topckgen
+  - power-domains
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    afe@10b10000 {
+        compatible = "mediatek,mt8188-afe";
+        reg = <0x10b10000 0x10000>;
+        interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
+        resets = <&watchdog 14>;
+        reset-names = "audiosys";
+        mediatek,topckgen = <&topckgen>;
+        power-domains = <&spm 13>; //MT8188_POWER_DOMAIN_AUDIO
+        mediatek,etdm-in2-cowork-source = <2>;
+        mediatek,etdm-out2-cowork-source = <0>;
+        mediatek,etdm-in1-multi-pin-mode;
+        mediatek,etdm-in1-chn-disabled = /bits/ 8 <0x0 0x2>;
+        clocks = <&clk26m>,
+                 <&apmixedsys 9>, //CLK_APMIXED_APLL1
+                 <&apmixedsys 10>, //CLK_APMIXED_APLL2
+                 <&topckgen 186>, //CLK_TOP_APLL12_CK_DIV0
+                 <&topckgen 187>, //CLK_TOP_APLL12_CK_DIV1
+                 <&topckgen 188>, //CLK_TOP_APLL12_CK_DIV2
+                 <&topckgen 189>, //CLK_TOP_APLL12_CK_DIV3
+                 <&topckgen 191>, //CLK_TOP_APLL12_CK_DIV9
+                 <&topckgen 83>, //CLK_TOP_A1SYS_HP
+                 <&topckgen 31>, //CLK_TOP_AUD_INTBUS
+                 <&topckgen 32>, //CLK_TOP_AUDIO_H
+                 <&topckgen 69>, //CLK_TOP_AUDIO_LOCAL_BUS
+                 <&topckgen 81>, //CLK_TOP_DPTX
+                 <&topckgen 77>, //CLK_TOP_I2SO1
+                 <&topckgen 78>, //CLK_TOP_I2SO2
+                 <&topckgen 79>, //CLK_TOP_I2SI1
+                 <&topckgen 80>, //CLK_TOP_I2SI2
+                 <&adsp_audio26m 0>; //CLK_AUDIODSP_AUDIO26M
+        clock-names = "clk26m",
+                      "apll1",
+                      "apll2",
+                      "apll12_div0",
+                      "apll12_div1",
+                      "apll12_div2",
+                      "apll12_div3",
+                      "apll12_div9",
+                      "a1sys_hp_sel",
+                      "aud_intbus_sel",
+                      "audio_h_sel",
+                      "audio_local_bus_sel",
+                      "dptx_m_sel",
+                      "i2so1_m_sel",
+                      "i2so2_m_sel",
+                      "i2si1_m_sel",
+                      "i2si2_m_sel",
+                      "adsp_audio_26m";
+    };
+
+...
-- 
2.18.0

