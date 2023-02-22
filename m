Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F332569F219
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjBVJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBVJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:46:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F305B38678
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:45:01 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B047766021C8;
        Wed, 22 Feb 2023 09:43:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677058983;
        bh=spGpqKbSxXn7OPXf28QXu2nWmpVE56wv353pvm/OWK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KiQGObEP5jZxRUVhDOL6ay7oS1WI1Kiipid2I0XbAIUpfOi/IggijilljCw/MzTpN
         xeML0gjTJUeebPP5T7/jMXmWJutlyVE+AKql56wtHX1INL8H/ytEqE4R6tF3i8ZGCz
         VgMSxhf241mWeIiIqKXHX5C3zkNqPCu62e//DtTFWdmSquxQuLuJgHLkXVIisjKb+0
         XLJkQQuKFtpXUiFIYIS3x1XKVmynltqQ4SYUOZYXmpoqT690P0EqL2+W6RbWY9/g1x
         JKEhzqUyxhrqGPljZWEfXomO9Pwn7rXF4O1wj9ju2c/A/TptJ6FsMcb92bLYOVASJE
         1TIBKLMm1vlEA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 5/9] soc: mediatek: mtk-mutex: Compress of_device_id array entries
Date:   Wed, 22 Feb 2023 10:42:49 +0100
Message-Id: <20230222094253.23678-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
References: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
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
of lines and increase readability; this brings us to a maximum of 95
columns.

While at it, also add a sentinel comment to the last entry for the
sole purpose of consistency.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 41 +++++++++++---------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 7751527fc30d..a59fde2bdcba 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -1040,33 +1040,20 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mutex_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt2701-disp-mutex",
-	  .data = &mt2701_mutex_driver_data},
-	{ .compatible = "mediatek,mt2712-disp-mutex",
-	  .data = &mt2712_mutex_driver_data},
-	{ .compatible = "mediatek,mt6795-disp-mutex",
-	  .data = &mt6795_mutex_driver_data},
-	{ .compatible = "mediatek,mt8167-disp-mutex",
-	  .data = &mt8167_mutex_driver_data},
-	{ .compatible = "mediatek,mt8173-disp-mutex",
-	  .data = &mt8173_mutex_driver_data},
-	{ .compatible = "mediatek,mt8183-disp-mutex",
-	  .data = &mt8183_mutex_driver_data},
-	{ .compatible = "mediatek,mt8186-disp-mutex",
-	  .data = &mt8186_mutex_driver_data},
-	{ .compatible = "mediatek,mt8186-mdp3-mutex",
-	  .data = &mt8186_mdp_mutex_driver_data},
-	{ .compatible = "mediatek,mt8188-disp-mutex",
-	  .data = &mt8188_mutex_driver_data},
-	{ .compatible = "mediatek,mt8192-disp-mutex",
-	  .data = &mt8192_mutex_driver_data},
-	{ .compatible = "mediatek,mt8195-disp-mutex",
-	  .data = &mt8195_mutex_driver_data},
-	{ .compatible = "mediatek,mt8195-vpp-mutex",
-	  .data = &mt8195_vpp_mutex_driver_data},
-	{ .compatible = "mediatek,mt8365-disp-mutex",
-	  .data = &mt8365_mutex_driver_data},
-	{},
+	{ .compatible = "mediatek,mt2701-disp-mutex", .data = &mt2701_mutex_driver_data },
+	{ .compatible = "mediatek,mt2712-disp-mutex", .data = &mt2712_mutex_driver_data },
+	{ .compatible = "mediatek,mt6795-disp-mutex", .data = &mt6795_mutex_driver_data },
+	{ .compatible = "mediatek,mt8167-disp-mutex", .data = &mt8167_mutex_driver_data },
+	{ .compatible = "mediatek,mt8173-disp-mutex", .data = &mt8173_mutex_driver_data },
+	{ .compatible = "mediatek,mt8183-disp-mutex", .data = &mt8183_mutex_driver_data },
+	{ .compatible = "mediatek,mt8186-disp-mutex", .data = &mt8186_mutex_driver_data },
+	{ .compatible = "mediatek,mt8186-mdp3-mutex", .data = &mt8186_mdp_mutex_driver_data },
+	{ .compatible = "mediatek,mt8188-disp-mutex", .data = &mt8188_mutex_driver_data },
+	{ .compatible = "mediatek,mt8192-disp-mutex", .data = &mt8192_mutex_driver_data },
+	{ .compatible = "mediatek,mt8195-disp-mutex", .data = &mt8195_mutex_driver_data },
+	{ .compatible = "mediatek,mt8195-vpp-mutex",  .data = &mt8195_vpp_mutex_driver_data },
+	{ .compatible = "mediatek,mt8365-disp-mutex", .data = &mt8365_mutex_driver_data },
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
 
-- 
2.39.2

