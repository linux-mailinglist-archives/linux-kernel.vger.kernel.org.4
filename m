Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1665B867F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiINKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiINKjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:39:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045F77A539
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:39:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h188so13914049pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=HqhuQ7GCm2rsYRiDOgm7J5PsMumYPik+gWgifMr97AI=;
        b=StmhHATsSBjXLCwbnOcC98gLAHHkq/FQNlkVoPGZZWORq2lKWYM5Rbq5fl3tC7VXuy
         GpTWuWsG93szuALYeLyy64tcGq9ZIRBXyMJN5fo/FZfifTyKqe01so8vVYnQOK4T2/GT
         q510RtcF90HORXzfWfjBNgYFPYc7VKho3Rb3LjZsqisZnWbTywMmDap7flaCV1ECcU2z
         9gtRFoVO/Urj4t+AqJjIakkTDp1LT78EiIV/IMDHO9uf+Xez2g6Ud0Cj5Ou11wohRq2d
         YcU2Mguku+45alZIKpIANfnV0XOdjFc4lTlqrevZDFu6ZYPJPLSB+kJiYHuvHOjojEiF
         8f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HqhuQ7GCm2rsYRiDOgm7J5PsMumYPik+gWgifMr97AI=;
        b=4bo+KmAvHS6HLMyrtX2rNxUvwKE/7URn42wYaMRGgqG54mPVcgIAaBSJ+jVWcRFVTa
         LHkKXm4yttS/M037taGFfiqUyi9DRiNFpqJ+sKlLFtXMi+UN0psFRcIcZXU33NTgwerU
         2g3pkdVIK8G8rvaka4wbim2rZyiUC5I3GeK5VZCc7O87w25XVjLVmJLlI6ypfvxGUEIs
         odjzkTW8Mqcb8nmGSFHkEydAY3cTb/r5zxOq6OE6quY954EqEUWGAsrT3GLfm7hHLy73
         YCO4c0XiH4J+Env9IfnQauV0xulpbLpRB4cgRzviJ2IYDdYJ4rJRqJ9E5QcbXAvxbFXr
         BFXA==
X-Gm-Message-State: ACgBeo2PZkY/20QRiq4U47vCWViKtXDKrZTuFmB7i027zB6Or46o2qAA
        AmOTXbFBjC1ikbU6D7VgaFs=
X-Google-Smtp-Source: AA6agR4HeqN2eZDyKsWWb4m6kP1HZfLjFFCmv/LW5KI5/KL+W8U2yNsIM9AOQCeszeNUMjt6zKEfWQ==
X-Received: by 2002:a63:2444:0:b0:438:63d9:bd65 with SMTP id k65-20020a632444000000b0043863d9bd65mr24427868pgk.560.1663151940531;
        Wed, 14 Sep 2022 03:39:00 -0700 (PDT)
Received: from autolfshost ([2409:4041:d9d:79ec:78cd:7d4c:66f8:5f42])
        by smtp.gmail.com with ESMTPSA id y10-20020a62640a000000b0053e6bda08e0sm9729768pfb.219.2022.09.14.03.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:39:00 -0700 (PDT)
Date:   Wed, 14 Sep 2022 16:06:50 +0530
From:   Anup K Parikh <parikhanupk.foss@gmail.com>
To:     skhan@linuxfoundation.org, andrey.grodzovsky@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] A simple doc fix
Message-ID: <YyGuwqpuwq+PT3K1@autolfshost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/scheduler/sched_main.c | 1 +
 include/drm/gpu_scheduler.h            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 68317d3a7a27..875d00213849 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -994,6 +994,7 @@ static int drm_sched_main(void *param)
  *		used
  * @score: optional score atomic shared with other schedulers
  * @name: name used for debugging
+ * @dev: A device pointer for use in error reporting in a multiple GPU scenario.
  *
  * Return 0 on success, otherwise error code.
  */
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index addb135eeea6..920b91fd1719 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -435,6 +435,7 @@ struct drm_sched_backend_ops {
  * @_score: score used when the driver doesn't provide one
  * @ready: marks if the underlying HW is ready to work
  * @free_guilty: A hit to time out handler to free the guilty job.
+ * @dev: A device pointer for use in error reporting in a multiple GPU scenario.
  *
  * One scheduler is implemented for each hardware ring.
  */
-- 
2.35.1

