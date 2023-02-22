Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D9969F230
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjBVJun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjBVJuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:50:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73041B76C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:48:13 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 00AB766021BC;
        Wed, 22 Feb 2023 09:43:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677058982;
        bh=HdA9LzRyfYNiXvz7Hffi4ApU2JZCzXJht1XHORTPc54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aj2IRggvt5KoR/paEff124zVV1bz7iA05sKUjbBbqW53DSgsrF8Ac/HSDp9MWgTPS
         HCEO/WtQLd3yHAz+y093jCIDbYYvNkG4FSh3yTRWXVMKQ+o3m164hFc9o3K2RA3OLO
         DlWsdQcMy7Y+l8cQoLZMs/jiS10fdbjVz6XMmRDk6zQFPyIiXNywAbaDYA5/ZBlmJZ
         IiqjB8+S4VW5TWxrsSsFtb+B6Cj+O9Z+K+o/8pO/bg/YVMWnqSp9oxyQW/ayp5tbjB
         DcAzhUnKvKoO4Vr6zuprIgzbgbLnuziDblLf2e+xnq84MjeDErNiD61Ibm35tP4Fg6
         zI4jnG1pL1B5A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 4/9] soc: mediatek: mtk-mmsys: Add MODULE_DEVICE_TABLE() to allow auto-load
Date:   Wed, 22 Feb 2023 10:42:48 +0100
Message-Id: <20230222094253.23678-5-angelogioacchino.delregno@collabora.com>
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

Allow module auto-loading by adding a MODULE_DEVICE_TABLE for
of_match_mmsys.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/soc/mediatek/mtk-mmsys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index fcf702fda92e..0f0fa27e17a5 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -391,6 +391,7 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 	{ .compatible = "mediatek,mt8365-mmsys", .data = &mt8365_mmsys_driver_data },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, of_match_mtk_mmsys);
 
 static struct platform_driver mtk_mmsys_drv = {
 	.driver = {
-- 
2.39.2

