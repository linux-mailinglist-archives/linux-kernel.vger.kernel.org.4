Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE3E69950C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBPNAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBPNAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:00:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C38C3D089
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:00:31 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A6A4866021AB;
        Thu, 16 Feb 2023 13:00:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676552430;
        bh=vBcYbh7VmrpwGTtIIzae2X0tf278NrdV7i8AmOYxaYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDFOAAaOeLdOc+M5ZjmKyg0SAmLyft6TUc9wsRuD/fRRS61yabypxaPzwPGX4MYBO
         kIndBGCWmZLzokLVSbwHG+KBvKI2a/U44whlxVAEN9vvk97AeUfvSHpJCNoh2ljVRa
         UlzM8XSqa1U6PxE2hOg+OD36HSfgrGVJdQYbT/tKgnPXKDtb8uD+KIPdtvxAiV2HAc
         fZPVmvL2W2vQhpJtfkPCI15zQTLgSoMxHuACsUfS07empo8RRIxQrFjDatDwpvd/Oy
         47EQrzWi/DLGGPPxYprlN96RuEoihEdRWchawz9vQJ3noCXuLLvp1h/Noiuc5dN2r1
         9ma1iivoP8vEg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 5/9] soc: mediatek: mtk-mutex: Compress of_device_id array entries
Date:   Thu, 16 Feb 2023 14:00:17 +0100
Message-Id: <20230216130021.64875-6-angelogioacchino.delregno@collabora.com>
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
of lines and increase readability; this brings us to a maximum of 95
columns.

While at it, also add a sentinel comment to the last entry for the
sole purpose of consistency.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 38 +++++++++++---------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index c5b1b42303ac..5c875139425c 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -921,31 +921,19 @@ static int mtk_mutex_probe(struct platform_device *pdev)
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
+	{ .compatible = "mediatek,mt8365-disp-mutex", .data = &mt8365_mutex_driver_data },
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
 
-- 
2.39.1

