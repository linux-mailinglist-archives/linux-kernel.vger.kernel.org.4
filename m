Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2C1646947
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLHGay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLHGaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:30:23 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963749AE13;
        Wed,  7 Dec 2022 22:30:20 -0800 (PST)
X-UUID: 253a43c99aa24ce78f8c61c1cc53c66f-20221208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=85zkTcq16I6FogF2j5q883c+XhKBUcjePGEXWVTOsrA=;
        b=cerlbdoF6gYuZc5Hoecz/hk4rAeIGKosCoj3xGFQj2Y2MN4nqmBeil2B96yZk8CVbTe1uL6IIRP/+D2xovCzhqZHNUpY7GTt8TujUwmOSwFQ33nlTLPZQrfbn51MJz9EjuLZ0lh/3AiTa/EtTltmJub/BHuFwXaC/773B0V6sho=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:160b8c20-f355-4f09-879a-14c0c87c81b0,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:38c9a924-4387-4253-a41d-4f6f2296b154,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 253a43c99aa24ce78f8c61c1cc53c66f-20221208
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 727455766; Thu, 08 Dec 2022 14:30:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 8 Dec 2022 14:30:12 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 8 Dec 2022 14:30:11 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
CC:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <benliang.zhao@mediatek.com>, <bin.zhang@mediatek.com>
Subject: [PATCH v3 8/9] arm/arm64: dts: mediatek: Fix existing NAND controller node name
Date:   Thu, 8 Dec 2022 14:29:54 +0800
Message-ID: <20221208062955.2546-9-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208062955.2546-1-xiangsheng.hou@mediatek.com>
References: <20221208062955.2546-1-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Change the existing node name in order to match NAND controller DT
bindings.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi             | 2 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 2 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index b8eba3ba153c..049ed797766b 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -360,7 +360,7 @@ thermal: thermal@1100b000 {
 		mediatek,apmixedsys = <&apmixedsys>;
 	};
 
-	nandc: nfi@1100d000 {
+	nandc: nand-controller@1100d000 {
 		compatible = "mediatek,mt2701-nfc";
 		reg = <0 0x1100d000 0 0x1000>;
 		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_LOW>;
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 92212cddd37e..cfbec2a2ed9d 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -560,7 +560,7 @@ spi0: spi@1100a000 {
 		status = "disabled";
 	};
 
-	nandc: nfi@1100e000 {
+	nandc: nand-controller@1100e000 {
 		compatible = "mediatek,mt2712-nfc";
 		reg = <0 0x1100e000 0 0x1000>;
 		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 146e18b5b1f4..d98aa4936092 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -539,7 +539,7 @@ bluetooth {
 		};
 	};
 
-	nandc: nfi@1100d000 {
+	nandc: nand-controller@1100d000 {
 		compatible = "mediatek,mt7622-nfc";
 		reg = <0 0x1100D000 0 0x1000>;
 		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
-- 
2.25.1

