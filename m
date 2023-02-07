Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99D68CC4B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBGBsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjBGBsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:48:18 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A056511669;
        Mon,  6 Feb 2023 17:48:08 -0800 (PST)
X-UUID: 75c6aaa4a68911eda06fc9ecc4dadd91-20230207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=C58C6erRFcj0Y1gzWfGeq542Z89QLIHIvaY5QVjo2Tk=;
        b=CCJWWqxvB0UMpdFPdOyblH00iKv4d+B1EGRMtgburWSk2l965+YG+y7W32MoEIc+mkMGdj0t30zlR643N5ozg44IhuRP4nOB0REUKQzHyZjJm4S20VAHvuj3t2pBmryxl9UeXSM1KsRlLZIKpDlcKJ6Q8XgEDnZO1NxeO/MoTpo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:edd9af3d-b235-494b-99fe-21b5d4effdc3,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:885ddb2,CLOUDID:dd437f56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 75c6aaa4a68911eda06fc9ecc4dadd91-20230207
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1536976094; Tue, 07 Feb 2023 09:48:03 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 7 Feb 2023 09:48:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 7 Feb 2023 09:48:02 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v7 1/1] clk: mediatek: remove MT8195 vppsys/0/1 simple_probe
Date:   Tue, 7 Feb 2023 09:48:00 +0800
Message-ID: <20230207014800.7619-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230207014800.7619-1-moudy.ho@mediatek.com>
References: <20230207014800.7619-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195 VPPSYS0/1 will be probed by the compatible name in
the mtk-mmsys driver and then probe its own clock driver as
a platform driver.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8195-vpp0.c | 58 +++++++++++++++++++-------
 drivers/clk/mediatek/clk-mt8195-vpp1.c | 58 +++++++++++++++++++-------
 2 files changed, 86 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
index bf2939c3a0230..debff9a8c071a 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
@@ -86,26 +86,54 @@ static const struct mtk_gate vpp0_clks[] = {
 	GATE_VPP0_2(CLK_VPP0_WARP1_MDP_DL_ASYNC, "vpp0_warp1_mdp_dl_async", "top_wpe_vpp", 3),
 };
 
-static const struct mtk_clk_desc vpp0_desc = {
-	.clks = vpp0_clks,
-	.num_clks = ARRAY_SIZE(vpp0_clks),
-};
+static int clk_mt8195_vpp0_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_hw_onecell_data *clk_data;
+	int r;
 
-static const struct of_device_id of_match_clk_mt8195_vpp0[] = {
-	{
-		.compatible = "mediatek,mt8195-vppsys0",
-		.data = &vpp0_desc,
-	}, {
-		/* sentinel */
-	}
-};
+	clk_data = mtk_alloc_clk_data(CLK_VPP0_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_gates(&pdev->dev, node, vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
+	if (r)
+		goto free_vpp0_data;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_gates;
+
+	platform_set_drvdata(pdev, clk_data);
+
+	return r;
+
+unregister_gates:
+	mtk_clk_unregister_gates(vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
+free_vpp0_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static int clk_mt8195_vpp0_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_gates(vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
 
 static struct platform_driver clk_mt8195_vpp0_drv = {
-	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.probe = clk_mt8195_vpp0_probe,
+	.remove = clk_mt8195_vpp0_remove,
 	.driver = {
 		.name = "clk-mt8195-vpp0",
-		.of_match_table = of_match_clk_mt8195_vpp0,
 	},
 };
 builtin_platform_driver(clk_mt8195_vpp0_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
index ffd52c7628909..beacbd94ef02a 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
@@ -84,26 +84,54 @@ static const struct mtk_gate vpp1_clks[] = {
 	GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_26M, "vpp1_vpp_split_26m", "clk26m", 26),
 };
 
-static const struct mtk_clk_desc vpp1_desc = {
-	.clks = vpp1_clks,
-	.num_clks = ARRAY_SIZE(vpp1_clks),
-};
+static int clk_mt8195_vpp1_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_hw_onecell_data *clk_data;
+	int r;
 
-static const struct of_device_id of_match_clk_mt8195_vpp1[] = {
-	{
-		.compatible = "mediatek,mt8195-vppsys1",
-		.data = &vpp1_desc,
-	}, {
-		/* sentinel */
-	}
-};
+	clk_data = mtk_alloc_clk_data(CLK_VPP1_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_gates(&pdev->dev, node, vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
+	if (r)
+		goto free_vpp1_data;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_gates;
+
+	platform_set_drvdata(pdev, clk_data);
+
+	return r;
+
+unregister_gates:
+	mtk_clk_unregister_gates(vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
+free_vpp1_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static int clk_mt8195_vpp1_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_gates(vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
 
 static struct platform_driver clk_mt8195_vpp1_drv = {
-	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.probe = clk_mt8195_vpp1_probe,
+	.remove = clk_mt8195_vpp1_remove,
 	.driver = {
 		.name = "clk-mt8195-vpp1",
-		.of_match_table = of_match_clk_mt8195_vpp1,
 	},
 };
 builtin_platform_driver(clk_mt8195_vpp1_drv);
-- 
2.18.0

