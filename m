Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3003173D5E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFZCgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjFZCgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:36:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D5EE65;
        Sun, 25 Jun 2023 19:35:47 -0700 (PDT)
X-UUID: 264fafee13ca11ee9cb5633481061a41-20230626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=To/hkL+XsHV+7bzfuPa862srWIZ++zvnkd6g5DhdBek=;
        b=ihMKutjG9CfJJvKPG3KWJTX55sPZlCyPFfbXheR85Ugk/B+VrFrxncOXpyP4QFOzsrZlEREdzMEARjbiNQ+XTJ7SL0MwADD76AU76d3XbLM4QP9PWdiThjyHspoqac5tYs9OLx+fquyfSCD6wfKKE9ohQyYnlD8kgiXRT48YqUA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:5716ea10-fdf7-4bf1-bcee-552509a8c80a,IP:0,U
        RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:4d00703f-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 264fafee13ca11ee9cb5633481061a41-20230626
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1405323478; Mon, 26 Jun 2023 10:35:44 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 10:35:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 26 Jun 2023 10:35:42 +0800
From:   Maso Huang <maso.huang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH v2 7/7] ASoC: dt-bindings: mediatek,mt7986-afe: add audio afe document
Date:   Mon, 26 Jun 2023 10:35:01 +0800
Message-ID: <20230626023501.11120-8-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230626023501.11120-1-maso.huang@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt7986 audio afe document.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 .../bindings/sound/mediatek,mt7986-afe.yaml   | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt7986-afe.yaml

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt7986-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt7986-afe.yaml
new file mode 100644
index 000000000000..257327a33ea1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt7986-afe.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt7986-afe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek AFE PCM controller for MT7986
+
+maintainers:
+  - Maso Huang <maso.huang@mediatek.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: mediatek,mt7986-afe
+      - items:
+          - enum:
+              - mediatek,mt7981-afe
+              - mediatek,mt7988-afe
+          - const: mediatek,mt7986-afe
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 5
+    items:
+      - description: audio bus clock
+      - description: audio 26M clock
+      - description: audio intbus clock
+      - description: audio hopping clock
+      - description: audio pll clock
+      - description: mux for pcm_mck
+      - description: audio i2s/pcm mck
+
+  clock-names:
+    minItems: 5
+    items:
+      - const: aud_bus_ck
+      - const: aud_26m_ck
+      - const: aud_l_ck
+      - const: aud_aud_ck
+      - const: aud_eg2_ck
+      - const: aud_sel
+      - const: aud_i2s_m
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - assigned-clocks
+  - assigned-clock-parents
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mt7986-clk.h>
+
+    afe@11210000 {
+        compatible = "mediatek,mt7986-afe";
+        reg = <0x11210000 0x9000>;
+        interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&infracfg_ao CLK_INFRA_AUD_BUS_CK>,
+                 <&infracfg_ao CLK_INFRA_AUD_26M_CK>,
+                 <&infracfg_ao CLK_INFRA_AUD_L_CK>,
+                 <&infracfg_ao CLK_INFRA_AUD_AUD_CK>,
+                 <&infracfg_ao CLK_INFRA_AUD_EG2_CK>;
+        clock-names = "aud_bus_ck",
+                      "aud_26m_ck",
+                      "aud_l_ck",
+                      "aud_aud_ck",
+                      "aud_eg2_ck";
+        assigned-clocks = <&topckgen CLK_TOP_A1SYS_SEL>,
+                          <&topckgen CLK_TOP_AUD_L_SEL>,
+                          <&topckgen CLK_TOP_A_TUNER_SEL>;
+        assigned-clock-parents = <&topckgen CLK_TOP_APLL2_D4>,
+                                 <&apmixedsys CLK_APMIXED_APLL2>,
+                                 <&topckgen CLK_TOP_APLL2_D4>;
+    };
+
+...
-- 
2.18.0

