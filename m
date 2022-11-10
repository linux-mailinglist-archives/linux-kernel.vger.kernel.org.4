Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77C8623BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiKJGhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiKJGh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:37:29 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3F42CE07;
        Wed,  9 Nov 2022 22:37:23 -0800 (PST)
X-UUID: 36bc58a447eb43bfa44a11f2f46079b6-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=d7zkDnaWEabyE5XdwVr4ccYWpjzTXOcJn5mpauaL9LQ=;
        b=eS+UP88zr6TB3FWCnaXYoj/F6JJavvVbvhcUzv2BzB5myEz8Op2N3A/LR/ec9+KeDufd8gCvmX7DTPexRKRW77B8FDM8as+40pnyXvmoO/mKudAJbp/5CQCmoe/he/dF15Zvn9qR+a0Eh9TpV8XhdnPSgWH3oYcMhnZ4nWxNcCA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:b8dea487-a329-4893-9474-a8dc4b9bd756,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.12,REQID:b8dea487-a329-4893-9474-a8dc4b9bd756,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:62cd327,CLOUDID:6099de85-088c-4756-8f76-577be701e693,B
        ulkID:221110143719DAY63BKH,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 36bc58a447eb43bfa44a11f2f46079b6-20221110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 460132987; Thu, 10 Nov 2022 14:37:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 10 Nov 2022 14:37:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 10 Nov 2022 14:37:18 +0800
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
Subject: [PATCH v4 2/4] arm64: dts: mt8195: Add edptx and dptx nodes
Date:   Thu, 10 Nov 2022 14:37:14 +0800
Message-ID: <20221110063716.25677-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221110063716.25677-1-rex-bc.chen@mediatek.com>
References: <20221110063716.25677-1-rex-bc.chen@mediatek.com>
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
index c380738d10cb..7acbef5a4517 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1244,6 +1244,9 @@
 				reg = <0x189 0x2>;
 				bits = <7 5>;
 			};
+			dp_calibration: dp-data@1ac {
+				reg = <0x1ac 0x10>;
+			};
 		};
 
 		u3phy2: t-phy@11c40000 {
@@ -2205,5 +2208,27 @@
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

