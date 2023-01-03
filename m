Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7465C208
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbjACOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjACOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:36:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEBAFCC5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:36:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z11so28191005ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=bQLJIF5vy6+GHX5o/6FOMmbiOn2O8W3BvocWFKR+0zs=;
        b=HiU9qv2UwS+gm1ITFwOMhSvhztleGatSztz4iLC0dw9gNdgpguiOFoR5rf6tgfVk2i
         CbW4Z5sLQsnFWGZlzjwlziX2EXI7R3yBSj6rpQo0fFuzwiFgRajFw2Ez9jhf+iZelvtM
         hJS4MVcXCTO4/pCppR+TDsNJedxCzDx6OMihY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQLJIF5vy6+GHX5o/6FOMmbiOn2O8W3BvocWFKR+0zs=;
        b=Ag3/DJFQM748fsGplBqohDinF3RrqHVjp3Ng/4uotcrBf0JozMRNvcVMPc/pBGirUx
         0OJ0O4qy0zCVqKcV5ysAanv5JHdvVE2CuKyEi2R3+N119S6KEoTDn4/LAYzyJExdz7lb
         yaSAf0MJtORT1dJWdIxcYYGyYxZzEpYqS5sgOH8IKNzTPmNy01O/yccRQRmWz4iV7Rhc
         YlJh4aQPbudS1GCfoXGdUapwsohDEUDi7Sgo7HJ1WyAstKUBtVSENG8Vg3TLXkCqWPIO
         NwDH7a4ukk4CGC6xEb15yBMu8v+y2YL5kgmrTxngaND4xjaMRd+pFjC5l+tNCC1mkywQ
         d3qQ==
X-Gm-Message-State: AFqh2koTq0sUbk1LHmljuQL8TZ6R3Zop/yXAAiZRJc+J+t8VSHtI+gy1
        uz7x3xCdDW2rLJ1/6HZTQ9SYAvYVRi3Dm/fZgp8=
X-Google-Smtp-Source: AMrXdXuR86mJY8EWv7/0juuqHXymeKVYrcIuQfVtyPn4DMnXqCc0wQHCfiskr9QKwC+5foub/Pi4kg==
X-Received: by 2002:a05:6402:1caa:b0:46f:a73d:367c with SMTP id cz10-20020a0564021caa00b0046fa73d367cmr34359462edb.34.1672756603397;
        Tue, 03 Jan 2023 06:36:43 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:9789:8e2b:74ac:a9a0])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640243ce00b0048ebf8a5736sm877245edc.21.2023.01.03.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:36:42 -0800 (PST)
Subject: [PATCH v3 0/8] Follow-up patches for uvc v4l2-compliance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGI9tGMC/43NwQ6CMAwG4FchOzvTlSHiyfcwHtgosGRsZpMlhv
 DuNh696Kn52/xfN5EpOcriUm0iUXHZxcChPlTCzn2YSLqBs0BAhA5BJsoUBlm0R2nj8vCuD5akHg
 dDejRDaxrBZdNnkibxbeZ6WL3n5ezyM6bX51lRPG4/3aIkyLOqT9qqBrEzVzunuLh1OcY0iTurBf
 +TkKXWQqcRNADoL2nf9zeOgp1jDgEAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 03 Jan 2023 15:36:18 +0100
Message-Id: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=vKvmLcxuc2nhyZmIFds/cTOVNUVZGR27hg3cdx6vtU8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtD1lvOQH9GQnmKx8nTiQPN27ataN1Lx8oOhVq//+
 txFjF1WJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7Q9ZQAKCRDRN9E+zzrEiE64D/
 4u3lmLINT08iWDzuFNXp4oFu2i7pcPGED45veSMDpp2EHLvS/x92YUwn5jcMej1ucOvNfmfihgnPHf
 JM849JwuWOOI63ZlNgwjaLiUD/A5O/ZF5RGQP5p46uBm3ZhvCXpO+FjnjGAqvNkjeqGkZ1HvJ7Lvu/
 uYlcuQHCCd0fiptNDGsFxbRpaTkUpUeP4fq2s1cQoxrcRRD0R2J0apUOJDGsUDsmUETRnmbM8NDs+3
 jqi+CMIwVzgNoWJ7MKrKqxa0qvohI1WxuahQW70FMbc903W9ANrziIFy0V39wXF9DQSKXVBnjzqXl/
 N4w7jxVlW85cmCESpYLjnRjTPqfgIn74h+2DXdUPsZyTiX7brNFbVPOuGO7xMIegKrVdQ6TM+pobJW
 r1M6QhB6BWcCp11Tw3LOxO1cJXh4h84MRK85IE9C2s3ejAr8b6kz4d0IPCYLikT4NidWSksMX1bg1z
 Sl5ThJplSs+k0OtXG02trWrpRNIJzf0PJGIPipD1k+44bCsUhIK3B7j/cw5s9m35dI3t5iWUdW0s81
 pjNTzZ6aPfTB+Y41x86IhDs8jed5gHxVegeoT5Ck5WU3Za8sjzCmemzpEskVbkNupDZXaWUjFrONAq
 5ff3OUz3HxdIeH/bShwoOuXEEz2Q7PRp7x8lVqMMRUvzGXtSjU1/DbUiIVIA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains the fixes for the comments on "v10 of Fix
v4l2-compliance errors series". In particular to the patches

-uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
-uvcvideo: improve error handling in uvc_query_ctrl()

And the patch:
-uvcvideo: Fix handling on Bitmask controls

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v3 (Thanks Laurent):
- Add a new patch for refactoring __uvc_ctrl_add_mapping
- Use standard names for menus
  - Return error on uvc_mapping_get_menu_value
  - Add const
  - StyLe!
- Do not return positive errors in uvc_query_ctrl()
   - Improve commit message
- improve error logging in uvc_query_ctrl()
   - Fix comment
   - Improve doc
- Fix handling on Bitmask controls
   - s/uvc/UVC
   - Reflow comments to 80 chars
   - Test with GET_RES first
   - Remove clamp to (0,..)
- Return -EACCES for Wrong state error
   - Full rewrite of commit message
- uvc_ctrl_is_accessible: check for INACTIVE
   - Update commit message
   - Remove try variable
   - Update documentation
- Implement mask for V4L2_CTRL_TYPE_MENU
   - Include linux/bits.h
- Link to v2: https://lore.kernel.org/r/20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org

Changes in v2:
- Include "Get menu names from framework series"
  https://lore.kernel.org/r/20220920-standard-menues-v2-0-a35af3243c2f@chromium.org
- Link to v1: https://lore.kernel.org/r/20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org

---
Hans Verkuil (2):
      media: uvcvideo: Check for INACTIVE in uvc_ctrl_is_accessible()
      media: uvcvideo: improve error logging in uvc_query_ctrl()

Ricardo Ribalda (6):
      media: uvcvideo: Return -EACCES for Wrong state error
      media: uvcvideo: Do not return positive errors in uvc_query_ctrl()
      media: uvcvideo: Fix handling on Bitmask controls
      media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
      media: uvcvideo: Refactor __uvc_ctrl_add_mapping
      media: uvcvideo: Use standard names for menus

 drivers/media/usb/uvc/uvc_ctrl.c   | 238 ++++++++++++++++++++++++++++---------
 drivers/media/usb/uvc/uvc_driver.c |  10 +-
 drivers/media/usb/uvc/uvc_v4l2.c   | 108 ++++++++++++-----
 drivers/media/usb/uvc/uvc_video.c  |  15 +--
 drivers/media/usb/uvc/uvcvideo.h   |   8 +-
 include/uapi/linux/uvcvideo.h      |   4 +-
 6 files changed, 281 insertions(+), 102 deletions(-)
---
base-commit: 69b41ac87e4a664de78a395ff97166f0b2943210
change-id: 20220920-resend-v4l2-compliance-4fdbe4fbd7b5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
