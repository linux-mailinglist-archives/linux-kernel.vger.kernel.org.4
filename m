Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFBA607295
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJUIkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJUIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:40:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34423239222;
        Fri, 21 Oct 2022 01:40:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso1497624wmb.5;
        Fri, 21 Oct 2022 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IuIo8QgEpxZytSZiMkYCyIw8CLrNCmcth/q5uc8EsFM=;
        b=UHxwHPQZYfeM6TtcZA0hz6s5eZl47HFNwIHZl2Q+0k/BynwTC1k0cxMLFTP99F/dt+
         S274d4Fska8oBvu0BR9cJBvtSr6/lx1nkjh+rDY+BVd6+psgDOARiFwa97qp86+IYf3O
         zkQF4rh7RUb7UsNGZmJUlwPZ78nQgWEaOtW5vuwVlcDVDX7A8z95CD9U7UQEqjggeOU0
         wdf9Ps8UqZlCzybEHiDHZkqIj6tYVh+uwjW7TiYz5hE4CkxcXFS8ewOuJb9/7Cd3fb0Y
         z2/f8+kXKBqxV7gX3V3DYfVj8BvIHixiaf1H0Vdp1Wxe2Wlc2vZmcAcZis01yOK0wFMM
         ay9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IuIo8QgEpxZytSZiMkYCyIw8CLrNCmcth/q5uc8EsFM=;
        b=R5LQtkDcKxWlR/xKJd+aIJDBwGmosMaoFXw+F5TwAdo7bWkKq1nZESJBTU5QjzLsjD
         p6R/OJUVWPrCDwovl/pFxkOM6q8ZQ5YIla+r07d7B37ZNNVvsbQT3EBL/qj58V2G47bQ
         5j163ZdHCvAPje22X17Le9n5gx40354qxranIJureK3gnCVEOBUr7etSwpTcyF9ztidv
         RIZ5CpsFLC7FgaHNgENkYMirJLNfBOyza2wRzeHeNEswXgihmhcFyXg3b2FgM59NZnla
         A8bLLMFRFalCezxJ5ecGCny7y7rpI4Y12iHlafbQfGiJMbxvSd9jrpqnXBiRyxhe/4lp
         8xnQ==
X-Gm-Message-State: ACrzQf3e/zGcQk8Cb3eWsT80jIQQptY8j5AqDvaxZM6s6Iyk2VwtszCS
        j9lQIv0m7X78U4sTV5yB9ik=
X-Google-Smtp-Source: AMsMyM77h+/1qaABrXb0HXJ77rL95cQYqKYRk18PhHLY1AAMY6D0/AHxac0gzRA3fbvGbpseDDt34g==
X-Received: by 2002:a05:600c:3b11:b0:3c6:c02d:babb with SMTP id m17-20020a05600c3b1100b003c6c02dbabbmr32495826wms.69.1666341637633;
        Fri, 21 Oct 2022 01:40:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id ay18-20020a5d6f12000000b0022e62529888sm5166607wrb.67.2022.10.21.01.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:40:36 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vc4: Fix spelling mistake "mmaping" -> "mmapping"
Date:   Fri, 21 Oct 2022 09:40:35 +0100
Message-Id: <20221021084035.65367-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are a couple of spelling mistakes in DRM_DEBUG messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_bo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 231add8b8e12..43d9b3a6a352 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -736,12 +736,12 @@ static int vc4_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
 	struct vc4_bo *bo = to_vc4_bo(obj);
 
 	if (bo->validated_shader && (vma->vm_flags & VM_WRITE)) {
-		DRM_DEBUG("mmaping of shader BOs for writing not allowed.\n");
+		DRM_DEBUG("mmapping of shader BOs for writing not allowed.\n");
 		return -EINVAL;
 	}
 
 	if (bo->madv != VC4_MADV_WILLNEED) {
-		DRM_DEBUG("mmaping of %s BO not allowed\n",
+		DRM_DEBUG("mmapping of %s BO not allowed\n",
 			  bo->madv == VC4_MADV_DONTNEED ?
 			  "purgeable" : "purged");
 		return -EINVAL;
-- 
2.37.3

