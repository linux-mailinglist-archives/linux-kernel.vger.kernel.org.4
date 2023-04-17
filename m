Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415886E5408
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjDQVlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDQVlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:41:47 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31CB72BC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:41:16 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id oWb2plnaxzvWyoWb2pO3Ap; Mon, 17 Apr 2023 23:41:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681767674;
        bh=hmKpFuD4ncU+rcAtBi5ifTB/BJFqTFHbSAvPEjZcz3w=;
        h=From:To:Cc:Subject:Date;
        b=Ndv3FWjnt02YRKTfsZ2vbwcNqVmy7vEKr+nkYGk6v06OlVMmVmfhdeZJH5u6X1xJH
         CXMA0vfkC+bgSCUisSpkMH+DuB1yV/+g5/JPNWybSxeZyek7WyY/8Y5ZVCOaXjfl/A
         2MaL1KMBkxxn9gDyThLO7YFz+GxhquOA5w5PbDUqF94R+7YH9PGWkr+fk4sqnaNRUg
         nYNFVMlO3/5+l8wsG2P3L9ACpmg1uU+6j9AKq7nPrKGj/65+240vsDZxKhhSnCTM5/
         PKpSAzzOxbsbBsy2zy8XIDoJYBdmmzj2i8ZlJ3qa4OmieEvMnxnbMDZXhiAxwJdgFP
         DgmumidLM/epA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Apr 2023 23:41:14 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix a test dml32_rq_dlg_get_rq_reg()
Date:   Mon, 17 Apr 2023 23:41:11 +0200
Message-Id: <3ba86bbe8cca149774835659885ddf39034a4306.1681767659.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is likely p1_min_meta_chunk_bytes was expected here, instead of
min_meta_chunk_bytes.

Test the correct variable.

Fixes: dda4fb85e433 ("drm/amd/display: DML changes for DCN32/321")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
index 395ae8761980..9ba6cb67655f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
@@ -116,7 +116,7 @@ void dml32_rq_dlg_get_rq_reg(display_rq_regs_st *rq_regs,
 	else
 		rq_regs->rq_regs_l.min_meta_chunk_size = dml_log2(min_meta_chunk_bytes) - 6 + 1;
 
-	if (min_meta_chunk_bytes == 0)
+	if (p1_min_meta_chunk_bytes == 0)
 		rq_regs->rq_regs_c.min_meta_chunk_size = 0;
 	else
 		rq_regs->rq_regs_c.min_meta_chunk_size = dml_log2(p1_min_meta_chunk_bytes) - 6 + 1;
-- 
2.34.1

