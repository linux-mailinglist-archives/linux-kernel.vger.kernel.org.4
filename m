Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0E268E677
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjBHDJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBHDJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:09:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4F642DF2;
        Tue,  7 Feb 2023 19:09:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m2-20020a17090a414200b00231173c006fso114603pjg.5;
        Tue, 07 Feb 2023 19:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pcJABX9SBwG6pPS5DjwAnhlxkRIEfiApGxt/FynRJo=;
        b=NQLpdQzqtkNTjlZnAFmYvECW4shVtkzs5rj3imtn0QvzxQel6HfaPydDaee0kB/SEW
         mI/OwbgEDfO9g7fWKbxu0++f4LMV7ejQJHxTSe4DKDvqs3rlmB4H8s4vCwaqGSltLUBg
         vBQpTv9/0++wMFLUao/vWKMOTps4LYZ79oe3fpIc24iRu0DD1j3vdZgdaZ49BvUPlhhe
         k3wHIk1N9tDD5jEA+j0vRtil3na65bGmYF0SiBuUKh46uRMSMcdkEAApZzKGwlJBkgBm
         SVStwnM9zJxx66cZMRHnOmWXXFF09oDj+O3CjthVRoRoE4+6toaNQToWmci92CoX2vrd
         TO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pcJABX9SBwG6pPS5DjwAnhlxkRIEfiApGxt/FynRJo=;
        b=Ln4j8btsn3cOHBuO43KE1wmHW+sdeoL5QTHrl5Q8gsTRdajwEK0WzIaKWwnD56N97c
         +mx1/4YNm/1z9QKTVxUj3GyJ6wCe+f/JddsfUjCnCRnVuwHa/goa3IsvRBmOi6Y/qS9C
         xAmydMbB1EjPsNgcM7QQWwLlWdtFMGWayfj6H+NaS7qnyBgicXd04IzzUHS37ZBiXfc4
         mqfr+HprKS3/P7M5S3JhKUZWt0feMY7vSC35fxdAxPVVYkbQMJBjiTwPQaErJoxlWbqG
         xaJGSIYBpynEJSqtEpqsUfgqTBmVPwXns07ni0UUEFcVmkIZ8z3KltjS13MLr3M0XAso
         DW5Q==
X-Gm-Message-State: AO0yUKWqoFJjw87DJj+iHgeITU/qeu8ujmtQjf8pmcUZpHjaKWD/7U5z
        aXFhzX012noe3GgilD5/PXo=
X-Google-Smtp-Source: AK7set/6vxOwf+TUnnqTkeSQhzEi+9JnVJPT8aBmwW/pb0McArGoBFe2U81frQbkTQ2cUYp7VcSc4g==
X-Received: by 2002:a17:902:f549:b0:199:3f82:ef49 with SMTP id h9-20020a170902f54900b001993f82ef49mr2121757plf.49.1675825780630;
        Tue, 07 Feb 2023 19:09:40 -0800 (PST)
Received: from localhost.localdomain (arc.lsta.media.kyoto-u.ac.jp. [130.54.10.65])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902c38d00b00189e7cb8b89sm9675043plg.127.2023.02.07.19.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 19:09:40 -0800 (PST)
From:   Taichi Nishimura <awkrail01@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, skhan@linuxfoundation.org,
        Taichi Nishimura <awkrail01@gmail.com>
Subject: [PATCH] Fix drm documentation warning
Date:   Wed,  8 Feb 2023 12:09:28 +0900
Message-Id: <20230208030928.760176-1-awkrail01@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to re-send this patch again.
I forgot to attach description.

When running make htmldocs, I found that drm_accel_node
does not exist. The documents do not have any links to
acceleration nodes, so I removed them.

This patch is an extra credit for documentation task
in the Linux kernel Bug Fixing Spring unpaid 2023.

Best,
Taichi

Signed-off-by: Taichi Nishimura <awkrail01@gmail.com>
---
 include/drm/drm_file.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 0d1f853092ab..cffccf6b94de 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -407,8 +407,6 @@ static inline bool drm_is_render_client(const struct drm_file *file_priv)
  *
  * Returns true if this is an open file of the compute acceleration node, i.e.
  * &drm_file.minor of @file_priv is a accel minor.
- *
- * See also the :ref:`section on accel nodes <drm_accel_node>`.
  */
 static inline bool drm_is_accel_client(const struct drm_file *file_priv)
 {
-- 
2.25.1

