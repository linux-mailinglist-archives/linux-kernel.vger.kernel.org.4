Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B459614637
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKAJCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiKAJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:01:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD4D186E5;
        Tue,  1 Nov 2022 02:01:42 -0700 (PDT)
X-UUID: e5e80a36cf484195b9e2d1578be32acc-20221101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LDx7k5RFHyQFyr+eb9E7z51WQb2M4Lzn/qohfNC7QSQ=;
        b=FfE7RUROaGR/gkPblF7atMWbPMbOpbh/fdWQZ1kpCVzqN85fgAdxlGGC7Vvw5ZhOi0oCKZFWPLtyiMFAyNwaDP+Ei1vsLk6Ak3N3RXJ9wX2Ittd3Fkkmfy3wb7n3rAtNWdGkXO/llfCI3pYoxCxqvsuwJmj4U7Ooe1IPVFOfT6A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:8990ac61-3a5a-4dd1-968c-80fa3d6b45d5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:47e313eb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e5e80a36cf484195b9e2d1578be32acc-20221101
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1663096407; Tue, 01 Nov 2022 17:01:28 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 1 Nov 2022 17:01:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 1 Nov 2022 17:01:27 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <nfraprado@collabora.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v3 1/7] arm64: dts: mediatek: mt8186: Fix watchdog compatible
Date:   Tue, 1 Nov 2022 17:01:10 +0800
Message-ID: <20221101090116.27130-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221101090116.27130-1-allen-kh.cheng@mediatek.com>
References: <20221101090116.27130-1-allen-kh.cheng@mediatek.com>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

MT8186's watchdog embeds a reset controller and needs only the
mediatek,mt8186-wdt compatible string as the MT6589 one is there
for watchdogs that don't have any reset controller capability.

Fixes: 2e78620b1350 ("arm64: dts: Add MediaTek MT8186 dts and evaluation board and Makefile")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Co-developed-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 64693c17af9e..e4366144cca5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -330,8 +330,7 @@
 		};
 
 		watchdog: watchdog@10007000 {
-			compatible = "mediatek,mt8186-wdt",
-				     "mediatek,mt6589-wdt";
+			compatible = "mediatek,mt8186-wdt";
 			mediatek,disable-extrst;
 			reg = <0 0x10007000 0 0x1000>;
 			#reset-cells = <1>;
-- 
2.18.0

