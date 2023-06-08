Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BF2727A5D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjFHIsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbjFHIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:47:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A949272C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:47:38 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 721426606F15;
        Thu,  8 Jun 2023 09:47:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686214057;
        bh=yBFpvdyvUdE5L7ZiJ3JX8I1dNCEtgPqdfEZ9UKzm1JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4qXIgXsrpU31WLaN06EJ3R+3Ki8sEYa9S8k+I1SUzdew5myZPLJdRoxVXDXhhj/a
         zdVaKQurrls3rwKU6T6iSS3ba2OobbSkRLpCimGp0W33yR7pAmHr/WDWa7HWQmYAMS
         kRLXc8xmG4gX9QK0SVYx4KNsBT6sgP42c2U0uAxnvisUph+WKoija26PuqsvNBdaSn
         Znpb/soYutHbHxYydHmylK2eo70onW/yUDf0JRFt2D7pGjQ+5TojVktq962WH0ry1Y
         MEpeIO3fz95zylk0EXsO3XUxWkd2yL2NkldQzTWw4vLXzrSLMf9iHGJ/D7CuINUDDi
         kMXp9Cl+Nsf1Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        trevor.wu@mediatek.com, amergnat@baylibre.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 1/5] ASoC: mediatek: mt8188-mt6359: Compress of_device_id entries
Date:   Thu,  8 Jun 2023 10:47:23 +0200
Message-Id: <20230608084727.74403-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those entries fit in one line: compress them to reduce line count.
While at it, also add the sentinel comment to the last entry.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index bc4b74970a46..643a7a12a96b 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -1117,15 +1117,9 @@ static struct mt8188_card_data mt8188_nau8825_card = {
 };
 
 static const struct of_device_id mt8188_mt6359_dt_match[] = {
-	{
-		.compatible = "mediatek,mt8188-mt6359-evb",
-		.data = &mt8188_evb_card,
-	},
-	{
-		.compatible = "mediatek,mt8188-nau8825",
-		.data = &mt8188_nau8825_card,
-	},
-	{},
+	{ .compatible = "mediatek,mt8188-mt6359-evb", .data = &mt8188_evb_card, },
+	{ .compatible = "mediatek,mt8188-nau8825", .data = &mt8188_nau8825_card, },
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mt8188_mt6359_dt_match);
 
-- 
2.40.1

