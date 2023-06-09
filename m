Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8BC7292D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbjFIIUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbjFIITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3B64228
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FAC765476
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2E1C433EF;
        Fri,  9 Jun 2023 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298679;
        bh=4OOUF/ysv6+g/EYobM5DFqzUmhksGsgNibALRCne10Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrM08NU/TNcTOa4aa43rG6Ow5ypxWfYIfpqP3DKV10rSJC8k009h8xtD2bXajOV9s
         WvuDzj7pV4j28I0gl6bjmyuIHsXj9MomOpnWDHx9K3/mcBn2nFeJ1mi1ZE4SdBvnyI
         y0ggX15wASY/8gCJVPz11NlgZ+1/5svac5vlFUh7BNq0yyDjcLWP1KeqbWN5YaJ6At
         gehgITgO1vPHEAzIdT5bF1sGH7yxga+ng++spGWxtaKd+C1G8VRgiOmOgI78WC/tNQ
         oY4tHa1oyZbHcL4Pom7ebnUims/vZ3mNlMRIMhX09hb8g6kydCCLT2fVjTPRcPb9J1
         Fe+Ewb/UapYng==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [RESEND 06/15] drm/nouveau/nvkm/subdev/acr/lsfw: Remove unused variable 'loc'
Date:   Fri,  9 Jun 2023 09:17:09 +0100
Message-ID: <20230609081732.3842341-7-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609081732.3842341-1-lee@kernel.org>
References: <20230609081732.3842341-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

 drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c: In function ‘nvkm_acr_lsfw_load_sig_image_desc_v2’:
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c:221:21: warning: variable ‘loc’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Gourav Samaiya <gsamaiya@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
index f36a359d4531c..bd104a030243a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
@@ -218,7 +218,7 @@ nvkm_acr_lsfw_load_sig_image_desc_v2(struct nvkm_subdev *subdev,
 		const struct firmware *hsbl;
 		const struct nvfw_ls_hsbl_bin_hdr *hdr;
 		const struct nvfw_ls_hsbl_hdr *hshdr;
-		u32 loc, sig, cnt, *meta;
+		u32 sig, cnt, *meta;
 
 		ret = nvkm_firmware_load_name(subdev, path, "hs_bl_sig", ver, &hsbl);
 		if (ret)
@@ -227,7 +227,6 @@ nvkm_acr_lsfw_load_sig_image_desc_v2(struct nvkm_subdev *subdev,
 		hdr = nvfw_ls_hsbl_bin_hdr(subdev, hsbl->data);
 		hshdr = nvfw_ls_hsbl_hdr(subdev, hsbl->data + hdr->header_offset);
 		meta = (u32 *)(hsbl->data + hshdr->meta_data_offset);
-		loc = *(u32 *)(hsbl->data + hshdr->patch_loc);
 		sig = *(u32 *)(hsbl->data + hshdr->patch_sig);
 		cnt = *(u32 *)(hsbl->data + hshdr->num_sig);
 
-- 
2.41.0.162.gfafddb0af9-goog

