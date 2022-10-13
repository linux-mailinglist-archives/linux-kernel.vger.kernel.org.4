Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F0C5FE4F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJMWH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJMWHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:07:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9220B183E11;
        Thu, 13 Oct 2022 15:07:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso2395634wmb.5;
        Thu, 13 Oct 2022 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4om2GeoB3nGtXKn/D43/nYB9P/nCiP/jXLuVwqGjJh8=;
        b=qotD3NVFSmQhXplxYbqPqkjAPRnZXJjM5FyDJIkLyL/NqOD9fNWDSVuNmGOfPoTTSe
         vswK0k7UPe81Zt44Gyv11EU/AQ/WDV/QLgN4rCTQQ2c725Mts7+BmkEgnnlnZj/hCjJh
         l16JJ2V7KBeKmbNRzg+Y8FUgkHpwNQtVcAxUTUBUurK+H2VBnyqvx4XDa7PpMQ5wq/bB
         xITX0mqArzSfNc36QCKfomjW3GUmatOMkyjAkPLLoNNe26TymIDZXGgKGu8aTRBfN/6c
         9S/+lI7eXSx/JN2FJ5sYPrPpUSCkuQvrqyUikeZUbOJGBzGTcsEvCyg6Z3UxIvXAm9E2
         GAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4om2GeoB3nGtXKn/D43/nYB9P/nCiP/jXLuVwqGjJh8=;
        b=JjkzHxWRy+UGpvk7oMU3H3oS3djoXw/7OKkQwzrVv286aP4caqSIYSjK/S0W0MWzNF
         IQkNeByoupyowKSOnZ6N+6itmRxpzA/2XJOhGDAH0dtaySTmyLpFq12uuNiK6P5qI0G5
         h/lsC510vs9dgKk/BNwGZ96+Zqfk0CVcuq3RpngeRM5taDWiOkddH9uFh3ezcg+vlrQJ
         d6vtSR2CHKVwac0jcE5dAJLVRrYaJOgImKY8Vlw7Y5cTT2vcP1eun16Fh9vyuSyg82q2
         J8n20E2bT/peKAG4xiNREE0j2kOJa6+Cx808vHdiHZv51CM/0k0/lGplfptHnt/y7ky/
         pMIA==
X-Gm-Message-State: ACrzQf3bG8Xt527UpuhWkAgHdk0aP+4riMKY625uMtuT1w8GTndPqwuY
        X5AjcREnPm6402JeR/UypGs=
X-Google-Smtp-Source: AMsMyM5P8Pugtc1EMoY/scdkibvmUsnt2EGPTvpR9fjvU661yr2QC0CRIzsowya071Vy3/LCiotyNg==
X-Received: by 2002:a05:600c:3b99:b0:3c6:8b8e:a624 with SMTP id n25-20020a05600c3b9900b003c68b8ea624mr1301589wms.113.1665698872009;
        Thu, 13 Oct 2022 15:07:52 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm624793wrq.72.2022.10.13.15.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:07:51 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gma500: Fix spelling mistake "patter" -> "pattern"
Date:   Thu, 13 Oct 2022 23:07:50 +0100
Message-Id: <20221013220750.127243-1-colin.i.king@gmail.com>
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

There is a spelling mistake in a DRM_DEBUG_KMS message. Fix it.
Also clean checkpatch warning on the overly long line and remove
braces as the if statement is just one statement.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index 53b967282d6a..bf39728eb86f 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -1546,9 +1546,9 @@ cdv_intel_dp_start_link_train(struct gma_encoder *encoder)
 
 	}
 
-	if (!clock_recovery) {
-		DRM_DEBUG_KMS("failure in DP patter 1 training, train set %x\n", intel_dp->train_set[0]);
-	}
+	if (!clock_recovery)
+		DRM_DEBUG_KMS("failure in DP pattern 1 training, train set %x\n",
+			      intel_dp->train_set[0]);
 
 	intel_dp->DP = DP;
 }
-- 
2.37.3

