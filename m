Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F069950A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjBPNAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBPNAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:00:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03BA3D089
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:00:29 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 553F066021A9;
        Thu, 16 Feb 2023 13:00:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676552428;
        bh=97TMHbRWrVSAg8/uwxUMdlr+BulgmbHEjf+Gm3YMplU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYfA3TLdoKnJtcckFUg3uj0biU48euCWvOZxYndWaQVrKErudu2jTPOVjVl5Ps5dn
         X/xihR7FuTamwvikiQQZH090CJZD/eqTWLQl767o1dIXn915uvvuq8o0ZROgdNyN6m
         /Cqq9o9xxy+r5bkwhkxbPIEfbgdVA6ChXEOSqdqV1jnxedUbzzgjkvhr7iCbs4LVm4
         lenX0xMYHWgO3EEEbzwm5DeqPnfK2Yjt+cNaRLMpydNCtiKdBrouLsPn2Pp1iniaZI
         KAxhvmnySxMzGHUmSsTbvTA5o5Kwzy+wx2RFalCGB/yDhb2mbNbjqiRcU1lhTUcgGi
         orgcX2rretFww==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 3/9] soc: mediatek: mtk-mmsys: Compress of_device_id array entries
Date:   Thu, 16 Feb 2023 14:00:15 +0100
Message-Id: <20230216130021.64875-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com>
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compress entries of the of_match_mtk_mmsys array to reduce the amount
of lines and increase readability; this brings us to a maximum of 90
columns.

While at it, also add a sentinel comment to the last entry for the
sole purpose of consistency.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 83 +++++++-------------------------
 1 file changed, 18 insertions(+), 65 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 1a574de9484d..fcf702fda92e 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -372,71 +372,24 @@ static int mtk_mmsys_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_match_mtk_mmsys[] = {
-	{
-		.compatible = "mediatek,mt2701-mmsys",
-		.data = &mt2701_mmsys_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt2712-mmsys",
-		.data = &mt2712_mmsys_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt6779-mmsys",
-		.data = &mt6779_mmsys_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt6797-mmsys",
-		.data = &mt6797_mmsys_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt8167-mmsys",
-		.data = &mt8167_mmsys_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt8173-mmsys",
-		.data = &mt8173_mmsys_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt8183-mmsys",
-		.data = &mt8183_mmsys_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt8186-mmsys",
-		.data = &mt8186_mmsys_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt8188-vdosys0",
-		.data = &mt8188_vdosys0_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt8192-mmsys",
-		.data = &mt8192_mmsys_driver_data,
-	},
-	{	/* deprecated compatible */
-		.compatible = "mediatek,mt8195-mmsys",
-		.data = &mt8195_vdosys0_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt8195-vdosys0",
-		.data = &mt8195_vdosys0_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt8195-vdosys1",
-		.data = &mt8195_vdosys1_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt8195-vppsys0",
-		.data = &mt8195_vppsys0_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt8195-vppsys1",
-		.data = &mt8195_vppsys1_driver_data,
-	},
-	{
-		.compatible = "mediatek,mt8365-mmsys",
-		.data = &mt8365_mmsys_driver_data,
-	},
-	{ }
+	{ .compatible = "mediatek,mt2701-mmsys", .data = &mt2701_mmsys_driver_data },
+	{ .compatible = "mediatek,mt2712-mmsys", .data = &mt2712_mmsys_driver_data },
+	{ .compatible = "mediatek,mt6779-mmsys", .data = &mt6779_mmsys_driver_data },
+	{ .compatible = "mediatek,mt6797-mmsys", .data = &mt6797_mmsys_driver_data },
+	{ .compatible = "mediatek,mt8167-mmsys", .data = &mt8167_mmsys_driver_data },
+	{ .compatible = "mediatek,mt8173-mmsys", .data = &mt8173_mmsys_driver_data },
+	{ .compatible = "mediatek,mt8183-mmsys", .data = &mt8183_mmsys_driver_data },
+	{ .compatible = "mediatek,mt8186-mmsys", .data = &mt8186_mmsys_driver_data },
+	{ .compatible = "mediatek,mt8188-vdosys0", .data = &mt8188_vdosys0_driver_data },
+	{ .compatible = "mediatek,mt8192-mmsys", .data = &mt8192_mmsys_driver_data },
+	/* "mediatek,mt8195-mmsys" compatible is deprecated */
+	{ .compatible = "mediatek,mt8195-mmsys", .data = &mt8195_vdosys0_driver_data },
+	{ .compatible = "mediatek,mt8195-vdosys0", .data = &mt8195_vdosys0_driver_data },
+	{ .compatible = "mediatek,mt8195-vdosys1", .data = &mt8195_vdosys1_driver_data },
+	{ .compatible = "mediatek,mt8195-vppsys0", .data = &mt8195_vppsys0_driver_data },
+	{ .compatible = "mediatek,mt8195-vppsys1", .data = &mt8195_vppsys1_driver_data },
+	{ .compatible = "mediatek,mt8365-mmsys", .data = &mt8365_mmsys_driver_data },
+	{ /* sentinel */ }
 };
 
 static struct platform_driver mtk_mmsys_drv = {
-- 
2.39.1

