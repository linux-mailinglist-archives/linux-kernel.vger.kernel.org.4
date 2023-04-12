Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD46DF441
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDLLxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjDLLw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:52:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E1A49C7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:52:56 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52D9266031FE;
        Wed, 12 Apr 2023 12:52:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681300375;
        bh=8iaiiDcFwWvEikKyBM/EHvngwZZN5lPfvgSCIoQUJv0=;
        h=From:To:Cc:Subject:Date:From;
        b=HHHKkgfyhj8S7yhY+Yhqg5BII5aB2y4NIJHNgD+UjIk95Qs4+XnnnbmvVgE6gcy5B
         VUkR5cIoL6Qz7QKfOgOknbZKRJAKvrQ9LIg7FNPrdgXhaVff43Uxp9OfiPiF1IhswS
         2IWH/up5QzCII5y3wzkkDi+ZX/wZO2D4tp27kk3WJNpwSj4ScylG+oGjAWgtKvCB0s
         T8I6atAlXtuPgL4qZMlujWS6wFGf4dxa0mJCx9UcF1WDYRQKNJ4Uoht5S8YvsQdneo
         B2qmRBiJov9X8jsAX72k0C9alFpSGqjl7tflXp7cV+u1z03CrJGOaLVBXqCPUQVIGK
         5ufVyt/9cF+nA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 0/4] drm/mediatek: Small mtk-dpi cleanups
Date:   Wed, 12 Apr 2023 13:52:46 +0200
Message-Id: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small cleanup of the mtk-dpi driver, switching it to devm
variants where possible and where it made sense, and reducing lines
while retaining and improving human readability.

AngeloGioacchino Del Regno (4):
  drm/mediatek: mtk_dpi: Simplify with devm_drm_bridge_add()
  drm/mediatek: mtk_dpi: Simplify with dev_err_probe()
  drm/mediatek: mtk_dpi: Switch to devm_drm_of_get_bridge()
  drm/mediatek: mtk_dpi: Use devm_platform_get_and_ioremap_resource()

 drivers/gpu/drm/mediatek/mtk_dpi.c | 59 +++++++++++-------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

-- 
2.40.0

