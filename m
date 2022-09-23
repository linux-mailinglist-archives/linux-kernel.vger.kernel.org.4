Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418C85E7B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiIWNMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiIWNMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:12:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27A0B56E3;
        Fri, 23 Sep 2022 06:11:59 -0700 (PDT)
X-UUID: 214770cb40d04d479282de158b18eddf-20220923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3op6r+zBloxUZmPBYopLhjOoMBMFIxK210nn9z153CQ=;
        b=c8FieRMpAZmftuyJdTIt5uY4U4g9S8maJsnefnFulbYASFXzILEiFY3xd4JOh7OCDVCXKk7aglz3SRNlLl37MhFak5cjGS8CoAGPnkQl6ZAmLe7m1uMdeKPHfnIdZxXPbA8d0UdsJDTn4RJp+FDuUfRC94ZCK6Yze3Uma5RTL0c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:9f63690c-dbac-4f48-bdc1-949376ed7e5d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.11,REQID:9f63690c-dbac-4f48-bdc1-949376ed7e5d,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:39a5ff1,CLOUDID:addb04e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220923211155UN3PRWDG,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 214770cb40d04d479282de158b18eddf-20220923
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1336173041; Fri, 23 Sep 2022 21:11:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Sep 2022 21:11:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 23 Sep 2022 21:11:52 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 4/5] arm64: dts: mt8186: Add dpi node
Date:   Fri, 23 Sep 2022 21:11:47 +0800
Message-ID: <20220923131148.6678-5-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220923131148.6678-1-allen-kh.cheng@mediatek.com>
References: <20220923131148.6678-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dpi node for mt8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 68f06bef88f3..c6809fdc7d15 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -976,6 +976,25 @@
 			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
 		};
 
+		dsi0: dsi@14013000 {
+			compatible = "mediatek,mt8186-dsi";
+			reg = <0 0x14013000 0 0x1000>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+			interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&mmsys CLK_MM_DSI0>,
+				 <&mmsys CLK_MM_DSI0_DSI_CK_DOMAIN>,
+				 <&mipi_tx0>;
+			clock-names = "engine", "digital", "hs";
+			resets = <&mmsys MT8186_MMSYS_SW0_RST_B_DISP_DSI0>;
+			phys = <&mipi_tx0>;
+			phy-names = "dphy";
+			status = "disabled";
+
+			port {
+				dsi_out: endpoint { };
+			};
+		};
+
 		iommu_mm: iommu@14016000 {
 			compatible = "mediatek,mt8186-iommu-mm";
 			reg = <0 0x14016000 0 0x1000>;
-- 
2.18.0

