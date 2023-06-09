Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410C27292D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbjFIIUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbjFIITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:19:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFDA4200
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE8A465489
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B3AC4339C;
        Fri,  9 Jun 2023 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298674;
        bh=6nACEsyetZN3OUoYGXb4359dV9rTnnaW9/DUyUqGZho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZgVJ9J+UoIK5BN7noJJRiZiNJe8fGbSfYhreSPHefi7Qb9T0wOVpIRRV7ScZl/OgU
         f5UjYN8IR158Zrf8fq89pCDpE3GztYIErTQhGqolqbcZxAGUcRbbdzzY/eIq91XvIF
         xpgLcOCgp7b7WgpAtYxVnqAYk4OpvVDCKwmOojz9C4obvWELfwA6AXNVOjAA0QWXTr
         nY4cwjBW5RZYuIOAqZXNTbwHAydDJjo5XW9r8ZshzqBnW53SY4L0gxBNlZGiBj3t+m
         uK1gDPYTYRVyZwc8wozUtsAe+lpQ7Q40zHOydUQhPJrxnbl5vO0QG4V8W0zdRgTGH3
         mvy9MfyImORuA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND 04/15] drm/mediatek/mtk_disp_aal: Remove half completed incorrect struct header
Date:   Fri,  9 Jun 2023 09:17:07 +0100
Message-ID: <20230609081732.3842341-5-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609081732.3842341-1-lee@kernel.org>
References: <20230609081732.3842341-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_disp_aal.c:39: warning: Function parameter or member 'clk' not described in 'mtk_disp_aal'
 drivers/gpu/drm/mediatek/mtk_disp_aal.c:39: warning: Function parameter or member 'regs' not described in 'mtk_disp_aal'
 drivers/gpu/drm/mediatek/mtk_disp_aal.c:39: warning: Function parameter or member 'cmdq_reg' not described in 'mtk_disp_aal'
 drivers/gpu/drm/mediatek/mtk_disp_aal.c:39: warning: Function parameter or member 'data' not described in 'mtk_disp_aal'

Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_aal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index 434e8a9ce8ab7..d4e831c6f03cf 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -26,11 +26,6 @@ struct mtk_disp_aal_data {
 	bool has_gamma;
 };
 
-/**
- * struct mtk_disp_aal - DISP_AAL driver structure
- * @ddp_comp - structure containing type enum and hardware resources
- * @crtc - associated crtc to report irq events to
- */
 struct mtk_disp_aal {
 	struct clk *clk;
 	void __iomem *regs;
-- 
2.41.0.162.gfafddb0af9-goog

