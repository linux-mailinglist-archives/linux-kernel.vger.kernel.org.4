Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5290B5BDD97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiITGrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiITGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:47:18 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387ED17A84
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:47:12 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q9so1599358pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=c5KSSWVkQxJDHC069bgwLU2fYk2mKQxGKTjcX09JPwY=;
        b=HGj8MOzY5CZ5wxY9nmVqBylRA4qoVO1HOk9+EhvXCILBr9M4OZJo0YdHC6FurSSr/Z
         7CJtTPLAHtRDD1EkTvAEtJAep51AV8xpS2UDs7KXapD+l/86KL+PiNrJZo9ulcWhnGqD
         UdhKPlUfLsyqSBENOGCLXdg1RMflt4EvN9baVT4GNEnSpYsXzW3HUK/uC6sW95Rb2SvH
         FHBmMvLDHttahh9qmLz3+f9//48KTDqNjvhgX842FvRn0Lf/WIVFGmuWBSyMCcmkYLwj
         XjqpuhxKWs4SxYBUqQhSX08HMFlRg+Pus5Z0tYWilQWqgwDyKi381Cdvf79bOu3Yhf8i
         q6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=c5KSSWVkQxJDHC069bgwLU2fYk2mKQxGKTjcX09JPwY=;
        b=t4yepVC5N1O0pAqqMTa7mLxkTdN/3T6JZ2WQ10PqslcnxS6Kap2yMKVxoEi0J9luXi
         nVsscFxkFWHls6e1lzsUGLYKMS4NyAigfrXihmf0wwl4Bg7Ds++ts0SUq6GNjPRGvNKa
         uaOXaY+DyMHLJ5bsGKJ04hC2jhI6tKFkRSkKbLadENbwDXLlJdh1JZXRP3GYyoT6VvfG
         quwdTW6q3uxAd2PHRTkkCBp3MPwCpFm9wAQV4/OnNzpaYCyw2wGlNrKbCYdrD+rSOOLV
         0qLuEzNwDfo0ayOuv3PM2xvKuYdkFUpu6VVnLoZqlrFGsYxdcOuBPTnQtCoMvlpq93YK
         ZBXQ==
X-Gm-Message-State: ACrzQf2FdcO1dAnXUekiSNPhB4qzUsfMsJNDgooI1P0/vYFZ2SWmxU0i
        SM8e7E8rG5FJVcpGHcAUB7I=
X-Google-Smtp-Source: AMsMyM5XcLxF8MhhH/PMsaRm36L2TkcyH9kq6drtdeDhum5yfRYVmKGhA1mMkFg3ixyXD2tyXWzvxg==
X-Received: by 2002:a62:8403:0:b0:540:c1e4:fb31 with SMTP id k3-20020a628403000000b00540c1e4fb31mr22297478pfd.85.1663656431635;
        Mon, 19 Sep 2022 23:47:11 -0700 (PDT)
Received: from autolfshost ([117.228.7.95])
        by smtp.gmail.com with ESMTPSA id i6-20020a056a00224600b0054aa69bc192sm651383pfu.72.2022.09.19.23.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:47:11 -0700 (PDT)
Date:   Tue, 20 Sep 2022 12:16:44 +0530
From:   Anup K Parikh <parikhanupk.foss@gmail.com>
To:     skhan@linuxfoundation.org, andrey.grodzovsky@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] A simple doc fix
Message-ID: <Yylh1Nst25I6u6Uh@autolfshost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two warnings during doc build which also results in corresponding
additions in generated docs

Warnings Fixed:
1. include/drm/gpu_scheduler.h:462: warning: Function parameter or member
   'dev' not described in 'drm_gpu_scheduler'
2. drivers/gpu/drm/scheduler/sched_main.c:1005: warning: Function
   parameter or member 'dev' not described in 'drm_sched_init'

Signed-off-by: Anup K Parikh <parikhanupk.foss@gmail.com>
---
Changes in v2:
    Correct the doc strings according to
    Link: https://lore.kernel.org/all/f528a8e4-5162-66d5-09da-5252076882b8@amd.com/
 drivers/gpu/drm/scheduler/sched_main.c | 2 ++
 include/drm/gpu_scheduler.h            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 68317d3a7a27..979685830671 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -994,6 +994,8 @@ static int drm_sched_main(void *param)
  *		used
  * @score: optional score atomic shared with other schedulers
  * @name: name used for debugging
+ * @dev: A device pointer - primarily useful for printing standardized
+ *       messages with DRM_DEV_ERROR().
  *
  * Return 0 on success, otherwise error code.
  */
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index addb135eeea6..80a525dd19bd 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -435,6 +435,8 @@ struct drm_sched_backend_ops {
  * @_score: score used when the driver doesn't provide one
  * @ready: marks if the underlying HW is ready to work
  * @free_guilty: A hit to time out handler to free the guilty job.
+ * @dev: A device pointer - primarily useful for printing standardized
+ *       messages with DRM_DEV_ERROR().
  *
  * One scheduler is implemented for each hardware ring.
  */
-- 
2.35.1

