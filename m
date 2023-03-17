Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603856BE329
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCQIXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCQIXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBDA24C8B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB920B824F6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FA0C433D2;
        Fri, 17 Mar 2023 08:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041355;
        bh=4rP7Q179tbTvCSUKwAzPPtZsKqDUSIpQRWF6HpGnePA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVhwKFKiV1cxOEDYVLNmAw+Ttc+ctOvR2CMYxrlVnt5c+VR+IBkiBEBXvfg4c+P2v
         ww7kr5s7k0Ey/V+3DcdmZDySMEd0l/S+lZkzunftFdGpb3UB62OIqwSJ4taQm24DED
         y9aFiwIogQBsz8EOkTbSIocdmHV/pv+MlsBqtdCpebFetJPmUUMVvePRnzSIshTvqZ
         QLuPPNREusjSJNG5CmkLB7l9yW5QnI2VtPQSYRbVyr5LrfCvYIJJsw2NNjf5e7kPr8
         RCB/dy8Tc9+fyirQFGo4Hs90MNOmyddUAynKTBHkYq8337LYShi7p8CN8NrNvcQGTY
         H72KsiFEsDZhw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/37] drm/mediatek/mtk_disp_aal: Remove half completed incorrect struct header
Date:   Fri, 17 Mar 2023 08:16:48 +0000
Message-Id: <20230317081718.2650744-8-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317081718.2650744-1-lee@kernel.org>
References: <20230317081718.2650744-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.40.0.rc1.284.g88254d51c5-goog

