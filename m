Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A417A647DF7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 07:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLIGpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 01:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLIGpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:45:00 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4232ACB30;
        Thu,  8 Dec 2022 22:44:35 -0800 (PST)
X-UUID: 9a0253e5fff144a89a082bb402194dd4-20221209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=88IrPDewJMdiNmtnllWW1ZT8q7OVxFl9yffQnwnQCD4=;
        b=vGJanSUi9xX+UzAzJ6gNAY1cb+DHluuzq7yUQytUdxtzSKoA97VN32NOlWCTdy0TMUus9yq8nYNoGRwPSsCPstKvr60ovgA6w/8Z3Zkk1RRzhLVXnGBMRrMaIEJkYA0aw8Jb3YLzFGmh3+Du0o1X+BbjJG0Jxpf73F5fzmon4cs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:f81f427e-2cd1-4c3d-9bfa-aa627d3a6ad3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:2e60c624-4387-4253-a41d-4f6f2296b154,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9a0253e5fff144a89a082bb402194dd4-20221209
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1009042936; Fri, 09 Dec 2022 14:44:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 9 Dec 2022 14:44:27 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 9 Dec 2022 14:44:26 +0800
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
        <benliang.zhao@mediatek.com>, <bin.zhang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 9/9] dt-bindings: mtd: mediatek,nand-ecc-engine: Add compatible for MT7986
Date:   Fri, 9 Dec 2022 14:43:17 +0800
Message-ID: <20221209064317.2828-10-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209064317.2828-1-xiangsheng.hou@mediatek.com>
References: <20221209064317.2828-1-xiangsheng.hou@mediatek.com>
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

Add dt-bindings documentation of ECC for MediaTek MT7986 SoC
platform.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml b/Documentation/devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml
index b13d801eda76..505baf1e8830 100644
--- a/Documentation/devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml
+++ b/Documentation/devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml
@@ -18,6 +18,7 @@ properties:
       - mediatek,mt2701-ecc
       - mediatek,mt2712-ecc
       - mediatek,mt7622-ecc
+      - mediatek,mt7986-ecc
 
   reg:
     items:
-- 
2.25.1

