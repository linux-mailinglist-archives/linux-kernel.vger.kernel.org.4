Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55767710B83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbjEYLxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjEYLxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:53:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB49C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:53:07 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D2B096605873;
        Thu, 25 May 2023 12:53:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685015586;
        bh=MoBImu80zRJLNrIylFPj8ddmA5b0Asfo7LRys0h84Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVBEcI9ahUXaJXN448On565H6zdBKU95wp/y1ZvBKINEPWuCIw+kg+z6GCt5V3zsl
         7oze6tsHLIb/sMuUJLy180HiOLrwB0GvlXFPvyWQKQ5SaGSsMVmv0+X+LLJEmOqMys
         aMzHW+qyeJ9oIpea7t6W9MZYUu8WzQ8xIpr1u0JPy6BVHCy8uRN3d1eQ7WFljI8EpK
         atAjfwUy8AuS1XsidThCn9LY8d34ybReXeGDsLWOcFcPazUrlKMhIvgqn5pQS/cn0f
         l7/ClU6K++2TUGjJXOvRcQ0PXl/h6GONldIhGAuHeuElqHoe3mEhGqrqsQkc6goowo
         N0f69sdpw2ThQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 3/3] phy: mediatek: mipi-dsi: Compress of_device_id match entries
Date:   Thu, 25 May 2023 13:52:58 +0200
Message-Id: <20230525115258.90091-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525115258.90091-1-angelogioacchino.delregno@collabora.com>
References: <20230525115258.90091-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the entries do fit in a maximum of 82 columns, which is
acceptable. While at it, also remove the useless comma on the
last entry and add the usual sentinel comment.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
index 4e75c34c819b..065ea626093a 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
@@ -180,13 +180,10 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_mipi_tx_match[] = {
-	{ .compatible = "mediatek,mt2701-mipi-tx",
-	  .data = &mt2701_mipitx_data },
-	{ .compatible = "mediatek,mt8173-mipi-tx",
-	  .data = &mt8173_mipitx_data },
-	{ .compatible = "mediatek,mt8183-mipi-tx",
-	  .data = &mt8183_mipitx_data },
-	{ },
+	{ .compatible = "mediatek,mt2701-mipi-tx", .data = &mt2701_mipitx_data },
+	{ .compatible = "mediatek,mt8173-mipi-tx", .data = &mt8173_mipitx_data },
+	{ .compatible = "mediatek,mt8183-mipi-tx", .data = &mt8183_mipitx_data },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_mipi_tx_match);
 
-- 
2.40.1

