Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD9C71332D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjE0Hys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjE0Hyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:54:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ADDBB;
        Sat, 27 May 2023 00:54:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64f1f133c37so343487b3a.0;
        Sat, 27 May 2023 00:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685174084; x=1687766084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ps1IF/L3y0LuIXv1kuyXMXVV1V92IKkA4nkdR1TZzsU=;
        b=J1k3fPaQZMPaMfdKrnm1zm7gzhHU3qdmAEgC4wn/zWlP5HZ6JqC5OlOYRpBy+aPcQg
         yUhoygdEbaP/d6l50zsX+P2x/nCpG+WCQ3vo2jEYDG6kXl3wiY3GZCZeW+KK7JfJUpXb
         vglxbKZsZSapWDZ6FUSrA82OzrEKw49uNha6r3OrW2h+wK+WUgqPh8mybzRX0ER05svx
         YYA6tu4labf09OfctbtGzSUoFMvh+n05rb5TndVmhR89vfRWC7USJ3BZBiHfKfvK5I6A
         uDJ1Kg6CpMzxNxSyjL2LyjV+88Akn+4O1hOLrEvQDDmCoLXemg9Gg6AS8g50KFwbTkEl
         6+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685174084; x=1687766084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ps1IF/L3y0LuIXv1kuyXMXVV1V92IKkA4nkdR1TZzsU=;
        b=MdtLaB7Exo9P2dk5ePZu+ThbHhs0/u5nPxdYjtyWJ+Btl9CQOsPmTZ6x0Nr6gBAIAu
         sQAsOI21RtiCtVjWXlDjm0eNkI6lk88lCjk8qMHHiR6Sg+SQRi6BUQ62OSFuMUef7TBc
         AoZdSDoTHuQqenT0NM4xIwzU+pSWojfjWYh3inN+36sdDVfTERVKKkCxgpsQLF3xRKcg
         m24lQsWUzQnFe5uz4ra8gxV+Rt2G8u3EEwOE/70QCAtgSrH+L6MYMMvqzx56Gzc7zlfM
         OxKMPnYS56Fgia9Dq4kbThK4KZbXW39tUh7eTldM1WcB+n+Mhde3hGhqiH8nH3CgUkOM
         GKyw==
X-Gm-Message-State: AC+VfDxoLp5zjGxMeY+qXF7gaG4UyH2ALrr0ekzTpFDb/mahK055WP8C
        fhaBI15Wc5q931vaucjb++I=
X-Google-Smtp-Source: ACHHUZ5Wl/x2AX2Bqkt5RQGo8lzJHVe2CTWpN35HVupnCmsS+crSB8FjThb8CWMDAlUiyAzTHgUY6Q==
X-Received: by 2002:a05:6a00:349b:b0:64d:41f1:7c87 with SMTP id cp27-20020a056a00349b00b0064d41f17c87mr5793226pfb.2.1685174083809;
        Sat, 27 May 2023 00:54:43 -0700 (PDT)
Received: from ubuntu.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id v7-20020a63d547000000b0053f22b76cdcsm3770567pgi.82.2023.05.27.00.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 00:54:43 -0700 (PDT)
From:   Min Li <lm0963hack@gmail.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH] drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl
Date:   Fri, 26 May 2023 20:37:53 +0800
Message-Id: <20230526123753.16160-1-lm0963hack@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index bdc5af23f005..450c7cbdd28a 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -478,7 +478,7 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 
 	drm_gem_object_put(gobj);
 	up_read(&rdev->exclusive_lock);
-	r = radeon_gem_handle_lockup(robj->rdev, r);
+	r = radeon_gem_handle_lockup(rdev, r);
 	return r;
 }
 
-- 
2.34.1

