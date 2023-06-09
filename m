Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943C87292D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbjFIIU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240508AbjFIIU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D230270F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E4396548A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0246C433A0;
        Fri,  9 Jun 2023 08:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298676;
        bh=Xwk4+4906LxoPOQvJy2nJCGhGicOPCINkG/q+wgp1HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WnT5Nm3Nqb+fZ43YcskNRpDLUAzNH2KDlKr2VBEHKhU7LXxnC3PxLCk+K6XJR+xbP
         VZ1ZS8RAtYpjzxfzr72CAu0XPYOuAzn8vtNfSXRx5mVvwEMbs+vZt63dkLEHSeN7Mv
         fp2iWaRj8E+ZWRlSk7vbl8USPnMqM6OjbPWnfOyB3HpSUZgAv+Dd7vd8pkW8tomE80
         ETNi/QV16RjK0CNGkZfZwE/6w0JT5Hy4OA0/Gy3zs9QciQEUI0j9M4F4iDdveeTv9R
         J1W96IAClipiIyNlNqqd0EoQ6VrFru0nxaySAaOBasWIkz4Aiqic327P24uWIQHyYF
         leRA2sqAvCRxg==
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
Subject: [RESEND 05/15] drm/mediatek/mtk_disp_ccorr: Remove half completed incorrect struct header
Date:   Fri,  9 Jun 2023 09:17:08 +0100
Message-ID: <20230609081732.3842341-6-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609081732.3842341-1-lee@kernel.org>
References: <20230609081732.3842341-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.41.0.162.gfafddb0af9-goog

