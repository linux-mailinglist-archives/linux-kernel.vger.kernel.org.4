Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C09F5F65C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJFMIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiJFMHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:07:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDEA642B;
        Thu,  6 Oct 2022 05:07:30 -0700 (PDT)
X-UUID: 6b07ddadbc7542b4bcf4ec9bd8ae2c8b-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IuM248/CKQvqkBvYlSj2q4Pls+MGuvgMcIM4SPkMuOI=;
        b=ob/4h9GkyF8yw1Yc30nMgWjEzHNSpxjDvee3YDoSCcWk2KkP1/kSrVJsTAloVKtdkY5hMcNxH8cC5s8FZjWmlNLYHLVQcDoYI8yH1mDJF3hXo/6uVafF8IznklhQOOwqUTiMjIqOoUzPMiOIg1Z2TbZ7O22LzMAWiAMbIQrDht8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:4a908d2a-70cb-4f13-ae98-6074fbcfc966,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:4a908d2a-70cb-4f13-ae98-6074fbcfc966,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:9c241ce1-2948-402a-a6e4-b5d31fe11eb7,B
        ulkID:221006200723H20NHTE2,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 6b07ddadbc7542b4bcf4ec9bd8ae2c8b-20221006
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 29772435; Thu, 06 Oct 2022 20:07:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 6 Oct 2022 20:07:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 6 Oct 2022 20:07:19 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 3/8] arm64: dts: mediatek: mt7986: Fix watchdog compatible
Date:   Thu, 6 Oct 2022 20:07:10 +0800
Message-ID: <20221006120715.24815-4-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
References: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
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

MT7986's watchdog embeds a reset controller and needs only the
mediatek,mt7986-wdt compatible string as the MT6589 one is there
for watchdogs that don't have any reset controller capability.

Fixes: 50137c150f5f ("arm64: dts: mediatek: add basic mt7986 support")
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 72e0d9722e07..6a94cd618772 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -119,8 +119,7 @@
 		};
 
 		watchdog: watchdog@1001c000 {
-			compatible = "mediatek,mt7986-wdt",
-				     "mediatek,mt6589-wdt";
+			compatible = "mediatek,mt7986-wdt";
 			reg = <0 0x1001c000 0 0x1000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			#reset-cells = <1>;
-- 
2.18.0

