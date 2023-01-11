Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4661A665B96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjAKMhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbjAKMh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:37:26 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED41A65BF;
        Wed, 11 Jan 2023 04:37:23 -0800 (PST)
X-UUID: af57427091ac11ed945fc101203acc17-20230111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=f0tyeVCGLQHUTaZhj2eyO8Q7/skPBVsVWCjbAseVp40=;
        b=mySfKi4Gr4f+Et4yhUnX//d/n5V9jJhediN5dUtKQXQCbzx2JgKStMXxA/WhOrY7qYCA+4AruTzpbC9kZ49TiyhzIqzXyTySLBCXr1GwuSsIM+Qb9ixg0CEtNixttutQWgY7NqlmSEeHPTQJ5Fh5gRAeSNXmsuiBortcCcpLD+c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:1f2d57df-8000-448b-bef5-b88a7623684e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:1f2d57df-8000-448b-bef5-b88a7623684e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:f02285f5-ff42-4fb0-b929-626456a83c14,B
        ulkID:230111203719JF1Y4TIF,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: af57427091ac11ed945fc101203acc17-20230111
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1174826781; Wed, 11 Jan 2023 20:37:18 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 11 Jan 2023 20:37:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Jan 2023 20:37:16 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 4/9] arm64: dts: mediatek: mt8186: Add ADSP mailbox nodes
Date:   Wed, 11 Jan 2023 20:37:06 +0800
Message-ID: <20230111123711.32020-5-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230111123711.32020-1-allen-kh.cheng@mediatek.com>
References: <20230111123711.32020-1-allen-kh.cheng@mediatek.com>
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

Add ADSP mailbox node for MT8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index a8ff984f1192..a0b7dacc10cd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -640,6 +640,20 @@
 			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		adsp_mailbox0: mailbox@10686000 {
+			compatible = "mediatek,mt8186-adsp-mbox";
+			#mbox-cells = <0>;
+			reg = <0 0x10686100 0 0x1000>;
+			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		adsp_mailbox1: mailbox@10687000 {
+			compatible = "mediatek,mt8186-adsp-mbox";
+			#mbox-cells = <0>;
+			reg = <0 0x10687100 0 0x1000>;
+			interrupts = <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
 		nor_flash: spi@11000000 {
 			compatible = "mediatek,mt8186-nor";
 			reg = <0 0x11000000 0 0x1000>;
-- 
2.18.0

