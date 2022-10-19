Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE261604B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiJSPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiJSPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:22:56 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9ED1DA37E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:16:19 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id r8-20020a056830120800b00661a0a236efso9674882otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSVgaKNXyxpO41DTy0BTahGVEiOe5fIDHOgNw0HwhPM=;
        b=cCbTjFt+C5i0OVzcCHYuZzDRxMgeqNVGqFVUD+UeT4GQu+O1iPL9HnNphGCLOOyNa4
         XUCBZVDPXZK43OOd1YQMu/f/u3MszrQne0aFnaZT25PST6VaXIhdBHX1zEqXoGDrNf22
         0eDyYL3UoK09bkfyDu+LL8pGout1AfknvWMdSY1pzTO94N18wXQ8izdfOvDnNsFqc3eA
         18gWlcNlZx1efYPcchHg76f6MwoNpMOtK5KJocgCtPdFuJNn+NA6Q5kHZKKJmlblECbn
         UJeLDGLy/Z4fNpt7dvZuxcUntFpZnTa09GqFByKkqqYTWV+/PVGNGtkFnbV6JpLg82/D
         qNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSVgaKNXyxpO41DTy0BTahGVEiOe5fIDHOgNw0HwhPM=;
        b=d23RkA/ikOYvIXY49qlsHfA4R3Oi+wfiSFFuiVPRohvDtPyjyyug7oOLr6gZ1q45Sz
         ifJW1z4LGsV+bB3nNHtdYI9q/3YmtDn05qQmeaIYIK3E6PaNHsdvd0e4UC7KOdy+t+CP
         siRnW0Kik1lXdJkmdNVgdZSBt0sfLayOOhZh3crHjB/340dZi5NIm/eg/DdNB9bx88MK
         XxlltaIA5/IFfdRHiBooWtdDs34P/Ns6zhDqbM8khYf3uSAvtLMH1RISUdwgcF/TCefo
         NZJc/tk1ApKWtpVd8NB/naKk68uKzVg40BSsJZMgWv1YkE9siILw2cfaTqJMFzgafxJt
         n7jQ==
X-Gm-Message-State: ACrzQf3rBDPmAN+BIa4qsh3pwaeubOK6FYzSCb67S2pvciCu4OT8MURt
        Sx2DabH+jF5WZPtw0rhUmbUkiNikMtKCPglz
X-Google-Smtp-Source: AMsMyM6rbHe6IbHaUmgRC1aH6iIMov2Nl64pN/edAXH6uoCOmsf2ixnJtpb4/cSPzWSKg7Mj8utmmQ==
X-Received: by 2002:a05:6830:4b5:b0:661:d8ee:b4ac with SMTP id l21-20020a05683004b500b00661d8eeb4acmr4123516otd.296.1666192550659;
        Wed, 19 Oct 2022 08:15:50 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id h5-20020a4aa9c5000000b00480e77f90f9sm707635oon.41.2022.10.19.08.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 08:15:49 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     harry.wentland@amd.com
Cc:     amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
Subject: [PATCH] drm/amd/display: Revert logic for plane modifiers
Date:   Wed, 19 Oct 2022 12:15:43 -0300
Message-Id: <20221019151543.22753-1-samsagax@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file was split in commit 5d945cbcd4b16a29d6470a80dfb19738f9a4319f
("drm/amd/display: Create a file dedicated to planes") the logic in
dm_plane_format_mod_supported() function got changed by a switch logic.
That change broke drm_plane modifiers setting on series 5000 APUs
(tested on OXP mini AMD 5800U and HP Dev One 5850U PRO)
leading to Gamescope not working as reproted on GitHub[1]

To reproduce the issue, enter a TTY and run:

$ gamescope -- vkcube

With said commit applied it will abort. This one restores the old logic,
fixing the issue that affects Gamescope.

[1](https://github.com/Plagman/gamescope/issues/624)

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 50 +++----------------
 1 file changed, 8 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index dfd3be49eac8..81c1fc9468b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1371,6 +1371,8 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 	const struct drm_format_info *info = drm_format_info(format);
 	struct hw_asic_id asic_id = adev->dm.dc->ctx->asic_id;
 
+	int i;
+
 	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
 
 	if (!info)
@@ -1386,49 +1388,13 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 		return true;
 	}
 
-	/* check if swizzle mode is supported by this version of DCN */
-	switch (asic_id.chip_family) {
-	case FAMILY_SI:
-	case FAMILY_CI:
-	case FAMILY_KV:
-	case FAMILY_CZ:
-	case FAMILY_VI:
-		/* asics before AI does not have modifier support */
-		return false;
-	case FAMILY_AI:
-	case FAMILY_RV:
-	case FAMILY_NV:
-	case FAMILY_VGH:
-	case FAMILY_YELLOW_CARP:
-	case AMDGPU_FAMILY_GC_10_3_6:
-	case AMDGPU_FAMILY_GC_10_3_7:
-		switch (AMD_FMT_MOD_GET(TILE, modifier)) {
-		case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_D:
-			return true;
-		default:
-			return false;
-		}
-		break;
-	case AMDGPU_FAMILY_GC_11_0_0:
-	case AMDGPU_FAMILY_GC_11_0_1:
-		switch (AMD_FMT_MOD_GET(TILE, modifier)) {
-		case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_D:
-			return true;
-		default:
-			return false;
-		}
-		break;
-	default:
-		ASSERT(0); /* Unknown asic */
-		break;
+	/* Check that the modifier is on the list of the plane's supported modifiers. */
+	for (i = 0; i < plane->modifier_count; i++) {
+		if (modifier == plane->modifiers[i])
+			break;
 	}
+	if (i == plane->modifier_count)
+		return false;
 
 	/*
 	 * For D swizzle the canonical modifier depends on the bpp, so check
-- 
2.38.0

