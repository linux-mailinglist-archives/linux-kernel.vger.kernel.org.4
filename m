Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BCD6BE34C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCQIXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCQIXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C0B22A30
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3953BB824FC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7057C4339C;
        Fri, 17 Mar 2023 08:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041358;
        bh=AZ4f26d9dqcor4C6tToQIXogEQaco3qVRXdmtPvq5zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aph6c4rK6rPq7ZhNtTxNv+7HBTPhPdIWPAkXSFyUK/AA83IGHwANNoh+lPggxzzYD
         hodMF7rLTU/hrq4i1dN6mvBtbdh9SmeYCuAKmw5sPh85dEeF606gEhVTrp/T3TxIew
         +TiaTNz/t9+o4neTLR0lSQMzuEYpc4GFT/H/Eb4o2emS3C7rUBD2nL7Fg7i29uDJd3
         wcPT1j4Axegq/QxuXdf4Nw3PeAY3DPeVXXWa7nJprSlZ1EfcOSgWE4CTR6WPWmI8nj
         PkMFvKkWIl64UOUg+namCJ59KjEnKlpKbJgi1Rw39d5G1ha9pDUFPVgPU+XKJKjYLr
         KoICkQ8HngDhw==
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
Subject: [PATCH 08/37] drm/mediatek/mtk_disp_ccorr: Remove half completed incorrect struct header
Date:   Fri, 17 Mar 2023 08:16:49 +0000
Message-Id: <20230317081718.2650744-9-lee@kernel.org>
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

 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'clk' not described in 'mtk_disp_ccorr'
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'regs' not described in 'mtk_disp_ccorr'
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'cmdq_reg' not described in 'mtk_disp_ccorr'
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'data' not described in 'mtk_disp_ccorr'

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
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 1773379b24398..720f3c7ef7b4f 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -34,11 +34,6 @@ struct mtk_disp_ccorr_data {
 	u32 matrix_bits;
 };
 
-/**
- * struct mtk_disp_ccorr - DISP_CCORR driver structure
- * @ddp_comp - structure containing type enum and hardware resources
- * @crtc - associated crtc to report irq events to
- */
 struct mtk_disp_ccorr {
 	struct clk *clk;
 	void __iomem *regs;
-- 
2.40.0.rc1.284.g88254d51c5-goog

