Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D669950B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBPNAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBPNAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:00:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86483D093
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:00:30 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F37D566021AA;
        Thu, 16 Feb 2023 13:00:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676552429;
        bh=8zBu4kGYwwp9PXGSRlrzgSAywExWb3oFBHKR72jcTw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xr36F/PtZtNxk+3TKAnY6WohFo7esdaFOj+uKoSq4m0fm9cN2bEIWFzNyhL1qpRhB
         FEEYxUt/sY0ExU9aaXsBhoHuPIkx7mJxRbg+gzTi8S9l56dboeYCOtbOq8ZnFK99l3
         KSR1R0CVczWzT6tEttlSPgxt+qUjbFkS9FEIhmkt0tCIA7DFwJY0Q8gAqGYr+Uuuts
         gLwWiYgjHcMB0srvKpJ9aWitgyxorXcVuASvJQvvpXI0aveDlmTzeh+xD6SljLdr2M
         tEW5zorsP7kULKmkbPmP0mkZBcM8C6PRvcXWlpnwlznW8h2sQmcCTl0iE7kUCHhvCx
         uD0U1Igch7K4Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 4/9] soc: mediatek: mtk-mmsys: Add MODULE_DEVICE_TABLE() to allow auto-load
Date:   Thu, 16 Feb 2023 14:00:16 +0100
Message-Id: <20230216130021.64875-5-angelogioacchino.delregno@collabora.com>
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

Allow module auto-loading by adding a MODULE_DEVICE_TABLE for
of_match_mmsys.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.39.1

