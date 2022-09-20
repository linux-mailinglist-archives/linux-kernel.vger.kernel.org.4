Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB35BDDA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiITGuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiITGuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:50:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32FD53D00
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:50:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso1525662pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=z/Tchuzx5XrbBDdO9w4M3sFc5h9bSSk8PEfVnx2P8/U=;
        b=WQjOnEYC+y93ri5C3gfgi4eAcw2Ee2jsooGZ+bMtbH4Jeg3J9rL2kNmUVvrKWziPjz
         QE8zfRsA1PEMCS0N/DjeTqM/8RQJeF2mX5C2MrCIOo9+zrbl1nN2i/tAvCXDiw0pvd+z
         Q5nZ4Ksj/ue6goG2WlZY5PjYr5xiJ/+YX4UMr22iz+qkYutsos38zQnu/claxXNQW5JJ
         pMnJky3zOBIuvwwPid80hu9ONDWsLccjytf7OZBrytCAvv3XUkz3X9vdWiqIcmkb0dIB
         Ln6v/bsni/nHM1ruhRzpU/P1KdCAzsRVph/P/oqMI1Y3b6uFbxroCCykgK1lg1sv7bPN
         CF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=z/Tchuzx5XrbBDdO9w4M3sFc5h9bSSk8PEfVnx2P8/U=;
        b=b9LxfgqfgmAIE5SEY1wRatPhKxCp/ZWe5AhHqdy2d+Ws7+CoO2nT1nq6FRUQkY9VuV
         Sl1qhbvGBBG3o5RGjZajRjCvx9hysvBCqC/YZo0bVCPmuPZt1mRixYD2D5MXXCSqOc1o
         a2WVtRktClUYxcwYfuStgyuuihUME5W22vYmFU6SDv4Cn+Bg18vF73XkGnXU/6nNYVOS
         j/03ihgvFaXwER6A/INpUBfYVruSKQeCuaieCCOpP/mSoOG0leSs0+0PTZ3JmTEWBNKJ
         Al64vBM8PbnDnYCBm+Ao/gY+5I3gaZp6tTp68hVxhVYZB7q7InWIEoQs2XL/3tdAB//1
         7EVw==
X-Gm-Message-State: ACrzQf0YrA6oCzteDpu22EXiiycqO08xbqIlbBuryf//OqC68nIhWfQ5
        AdBCOs5F6Hf0Qz2pqgGB0nE=
X-Google-Smtp-Source: AMsMyM5wtBWnT3s8RXcMiyF1rJz966LX0wfq0IzfHPhH5x9N9TRfa245fDBVHXRMkzoZilb48kNycA==
X-Received: by 2002:a17:90b:4c50:b0:202:c7b1:b1f9 with SMTP id np16-20020a17090b4c5000b00202c7b1b1f9mr2305401pjb.77.1663656608279;
        Mon, 19 Sep 2022 23:50:08 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w71-20020a627b4a000000b00537d7cc774bsm659252pfc.139.2022.09.19.23.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:50:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     zackr@vmware.com
Cc:     linux-graphics-maintainer@vmware.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/vmwgfx: Remove the unneeded result variable
Date:   Tue, 20 Sep 2022 06:50:04 +0000
Message-Id: <20220920065004.215601-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value ttm_pool_alloc() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index 4e3938e62c08..f17e0da7475d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -470,15 +470,11 @@ static void vmw_ttm_destroy(struct ttm_device *bdev, struct ttm_tt *ttm)
 static int vmw_ttm_populate(struct ttm_device *bdev,
 			    struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
 {
-	int ret;
-
 	/* TODO: maybe completely drop this ? */
 	if (ttm_tt_is_populated(ttm))
 		return 0;
 
-	ret = ttm_pool_alloc(&bdev->pool, ttm, ctx);
-
-	return ret;
+	return ttm_pool_alloc(&bdev->pool, ttm, ctx);
 }
 
 static void vmw_ttm_unpopulate(struct ttm_device *bdev,
-- 
2.25.1
