Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9741720E89
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 09:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjFCHn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 03:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFCHny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 03:43:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C01B4;
        Sat,  3 Jun 2023 00:43:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d3bc0dce9so354810b3a.0;
        Sat, 03 Jun 2023 00:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685778233; x=1688370233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AWur87b6+FWCBKqxfBacalad+HJLdADtjiXHWwWG+kk=;
        b=HdR32jWEiMDgRFNHZ4AmO+HfNOYRhIeMt1Z5uNTHesSQqHDELs6TlofSvDyhAYT35y
         JtaJAitoMYef8byzb4Q/v3Q1X37KaWjsPrprQlD57U3+I6XKSx204zCQ1EOG7U21K4fq
         fXT6MUWv5fX/6d68aknWQA62HaAXaJ7DT2OMuNznhhusSLzEaG5OodKAGVCBaeTD9In5
         UhGE6Caok7XVhyUI2FU8bRU0U+QCu7mWwwuYcu4PH+H+U4yRVxt3yqk20JfkptJRMas7
         0UZzD5imjL3NijdOtD+bWCh0OhMtk0o+uTjgUT+aeEfbUcXYkTQbxshWNa3CPUXt94Qk
         PETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685778233; x=1688370233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWur87b6+FWCBKqxfBacalad+HJLdADtjiXHWwWG+kk=;
        b=Q5j3DyyBLozk4djJhqFIOJfYkfcUt2wBwQzONJrw1v3c1GHVlhZyGDzo4QC2lej1SG
         ZgskMl09MlWqLRM1WsoLjb2CS3a3j3we7g8GdISxL+l236eFRiqNsHxBNqKgwpZXCblI
         4kRSsf2xAit83lmVGh/+rMF6v/V2fpO5BKbyVyfSpCp0psvYxXtBnLU44n2BxPW3nW9b
         5cjSqKTxyV8Md6CfDtvcw74g6Yl7a7jjc8zd990fTK3NyPuqD125XQXgJkHZXygGSwAn
         ph1eMggDW/eyYOrcN5ZLNFRDRgQWdQJirA1o9XY3EKQGvizZEIEHaqXUiOFw6poWfTHx
         2s1w==
X-Gm-Message-State: AC+VfDybrFjP8Flf11fFWaXBc5wlLAenYR56F4EaDfOh0Cg6oC8kWK/h
        LI/lUvY9dZe9HcBYUKqrETf2t59o1Rk1MH9+
X-Google-Smtp-Source: ACHHUZ7Sb3282pwyR3Z2zP7ICZ4Es7PNecGCmDTkrXI02OgZnCeM/hb458Wo12XIa+dX4RK3fGmPTQ==
X-Received: by 2002:a17:902:ecc5:b0:1ae:1364:6086 with SMTP id a5-20020a170902ecc500b001ae13646086mr12068845plh.2.1685778232982;
        Sat, 03 Jun 2023 00:43:52 -0700 (PDT)
Received: from ubuntu.localdomain ([183.208.21.185])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001afd275e186sm2525846pli.286.2023.06.03.00.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 00:43:52 -0700 (PDT)
From:   Min Li <lm0963hack@gmail.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH v2] drm/radeon: fix race condition UAF in  radeon_gem_set_domain_ioctl
Date:   Sat,  3 Jun 2023 15:43:45 +0800
Message-Id: <20230603074345.17907-1-lm0963hack@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can race to free the gobj(robj converted from), robj should not
be accessed again after drm_gem_object_put, otherwith it will result in
use-after-free.

Signed-off-by: Min Li <lm0963hack@gmail.com>
---
Changes in v2:
- Remove unused robj, avoid compile complain

 drivers/gpu/drm/radeon/radeon_gem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index bdc5af23f005..d3f5ddbc1704 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -459,7 +459,6 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_radeon_gem_set_domain *args = data;
 	struct drm_gem_object *gobj;
-	struct radeon_bo *robj;
 	int r;
 
 	/* for now if someone requests domain CPU -
@@ -472,13 +471,12 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 		up_read(&rdev->exclusive_lock);
 		return -ENOENT;
 	}
-	robj = gem_to_radeon_bo(gobj);
 
 	r = radeon_gem_set_domain(gobj, args->read_domains, args->write_domain);
 
 	drm_gem_object_put(gobj);
 	up_read(&rdev->exclusive_lock);
-	r = radeon_gem_handle_lockup(robj->rdev, r);
+	r = radeon_gem_handle_lockup(rdev, r);
 	return r;
 }
 
-- 
2.34.1

