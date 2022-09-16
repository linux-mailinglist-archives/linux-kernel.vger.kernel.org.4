Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274F95BA4CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIPCva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiIPCvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:51:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210B498C9D;
        Thu, 15 Sep 2022 19:51:09 -0700 (PDT)
X-UUID: 7ca34679584b4ff5845b10ce81e95bf4-20220916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oNoZT8GHmsYXrwIBJ4X7UKKmHGPDl6GG2bXgSJSl9OY=;
        b=UoriI0uAU24ILb9nfJUnXzbLRlzx1qwg2tEqt5bjkStwZATwX58J157Df0RfOzPeIgw0Y5BqEES/cnB9N8Zj0v+QyS2QCIhXr4O7Ucfik6bEE0WifukrQUfCXEEj3nThUwPDWlw20gK0jb/8mhl0Jg5lS3Ws0vZooYK24ifXuuI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:1d640cda-9f2b-4213-8fd9-4063be07e34d,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:dc58d17b-ea28-4199-b57e-003c7d60873a,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7ca34679584b4ff5845b10ce81e95bf4-20220916
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1467601953; Fri, 16 Sep 2022 10:51:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 16 Sep 2022 10:51:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Sep 2022 10:51:00 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v3 2/4] arm64: dts: mt8195: Add edptx and dptx nodes
Date:   Fri, 16 Sep 2022 10:50:57 +0800
Message-ID: <20220916025059.16673-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220916025059.16673-1-rex-bc.chen@mediatek.com>
References: <20220916025059.16673-1-rex-bc.chen@mediatek.com>
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

In MT8195, we use edptx as the internal display interface and use
dptx as the external display interface. Therefore, we need to add
these nodes to support the internal display and the external display.

- Add dp calibration data in the efuse node.
- Add edptx and dptx nodes for MT8195.

Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 82d28e9f60c3..83567d90ede6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1241,6 +1241,9 @@
 				reg = <0x189 0x2>;
 				bits = <7 5>;
 			};
+			dp_calibration: dp-data@1ac {
+				reg = <0x1ac 0x10>;
+			};
 		};
 
 		u3phy2: t-phy@11c40000 {
@@ -2178,5 +2181,27 @@
 			clock-names = "engine", "pixel", "pll";
 			status = "disabled";
 		};
+
+		edp_tx: edp-tx@1c500000 {
+			compatible = "mediatek,mt8195-edp-tx";
+			reg = <0 0x1c500000 0 0x8000>;
+			nvmem-cells = <&dp_calibration>;
+			nvmem-cell-names = "dp_calibration_data";
+			power-domains = <&spm MT8195_POWER_DOMAIN_EPD_TX>;
+			interrupts = <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0>;
+			max-linkrate-mhz = <8100>;
+			status = "disabled";
+		};
+
+		dp_tx: dp-tx@1c600000 {
+			compatible = "mediatek,mt8195-dp-tx";
+			reg = <0 0x1c600000 0 0x8000>;
+			nvmem-cells = <&dp_calibration>;
+			nvmem-cell-names = "dp_calibration_data";
+			power-domains = <&spm MT8195_POWER_DOMAIN_DP_TX>;
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH 0>;
+			max-linkrate-mhz = <8100>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.18.0

