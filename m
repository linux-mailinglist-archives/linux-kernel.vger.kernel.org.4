Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBCF6E538B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjDQVDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDQVDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3759137
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A875623E8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E1AC433EF;
        Mon, 17 Apr 2023 21:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681765395;
        bh=6v5l4vPJTur+E1/6K1HeqdG2RoCvkceddg82nGQhHzo=;
        h=From:To:Cc:Subject:Date:From;
        b=uYSogoOgT3vkHqwAHouEmEcZ1WY9ayQbD/3q4D41z4V5W2bvOcpjGr+v+6RcS/ToR
         ksjBYY8BTb2gZZnZ0G17NgHokSTPCyuics1K/YIDbFQFwiCNJswJzMe8i7FW+6DPt9
         52zM9KfWyr7b5MYhgF9JxykVPv/YC3pT2XZXAJje/5IFUzIT1evA79NODj8MbJHPOy
         Amxip8uDsZS2YSK4nY3QAUDOEEtTN/mY+2GR7t4gnHNpv3MuD+OktfnJchWFgFJ+zn
         uLpUN1SU8EpmkuHjdaPSKbZtvNshNng42Z2WkAmiA4ZETtmOX+uK9ncFHVzxrHIzq6
         DHQ31NPo574MQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: remove unused tu102_gr_load() function
Date:   Mon, 17 Apr 2023 23:03:04 +0200
Message-Id: <20230417210310.2443152-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

tu102_gr_load() is completely unused and can be removed to address
this warning:

drivers/gpu/drm/nouveau/dispnv50/disp.c:2517:1: error: no previous prototype for 'nv50_display_create'

Fixes: 1cd97b5490c8 ("drm/nouveau/gr/tu102-: use sw_veid_bundle_init from firmware")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
index 3b6c8100a242..a7775aa18541 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
@@ -206,19 +206,6 @@ tu102_gr_av_to_init_veid(struct nvkm_blob *blob, struct gf100_gr_pack **ppack)
 	return gk20a_gr_av_to_init_(blob, 64, 0x00100000, ppack);
 }
 
-int
-tu102_gr_load(struct gf100_gr *gr, int ver, const struct gf100_gr_fwif *fwif)
-{
-	int ret;
-
-	ret = gm200_gr_load(gr, ver, fwif);
-	if (ret)
-		return ret;
-
-	return gk20a_gr_load_net(gr, "gr/", "sw_veid_bundle_init", ver, tu102_gr_av_to_init_veid,
-				 &gr->bundle_veid);
-}
-
 static const struct gf100_gr_fwif
 tu102_gr_fwif[] = {
 	{  0, gm200_gr_load, &tu102_gr, &gp108_gr_fecs_acr, &gp108_gr_gpccs_acr },
-- 
2.39.2

