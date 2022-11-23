Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4D6360DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbiKWOBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbiKWOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:00:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19936176B;
        Wed, 23 Nov 2022 05:55:48 -0800 (PST)
X-UUID: 5071442ff2af49778222e16a093a2163-20221123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=klauKXCf43JuiajHUBH7MpaxLTiLUHqUoqZsiMJI5jk=;
        b=loA3n3nmyKGqZsFA/xlymN+wVXVxPd/mFa2VKrJUhPTgZQcocaWV7Ot472nFQALbnboWUwPUX/67yI8DFfOTrP8Dx7TAcTY9hR8ZNsLgQuKDRh7YNjx7t1xOhHR9UYqZg9/TmrWv0K+iTZQFHGAFLpZ+cqtyLxVgYFWXNo4vmww=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:a4a5265d-4309-426b-88ca-32c8fa5a2ebe,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.12,REQID:a4a5265d-4309-426b-88ca-32c8fa5a2ebe,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:62cd327,CLOUDID:cf4a1bf9-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:221123215544DLJVZW4D,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5071442ff2af49778222e16a093a2163-20221123
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1589566403; Wed, 23 Nov 2022 21:55:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 23 Nov 2022 21:55:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 23 Nov 2022 21:55:40 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 4/5] arm64: dts: mt8186: Add dsi node
Date:   Wed, 23 Nov 2022 21:55:30 +0800
Message-ID: <20221123135531.23221-5-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
References: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dsi node for mt8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index c0481f0dc527..4a2f7ad3c6f0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -979,6 +979,25 @@
 			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
 		};
 
+		dsi0: dsi@14013000 {
+			compatible = "mediatek,mt8186-dsi";
+			reg = <0 0x14013000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DSI0>,
+				 <&mmsys CLK_MM_DSI0_DSI_CK_DOMAIN>,
+				 <&mipi_tx0>;
+			clock-names = "engine", "digital", "hs";
+			interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
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

