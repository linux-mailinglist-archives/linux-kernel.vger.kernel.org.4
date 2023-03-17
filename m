Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F86BE361
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjCQIYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCQIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB00110272
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E911B6222D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C23C433EF;
        Fri, 17 Mar 2023 08:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041385;
        bh=Yy6qQhiWlQeyRXwDMARwFhqS8zBGMG54yD+MPv2mfpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EjxtDlZyH9IgO2RrdO8cPGAXjcXr/cr9/taRKEB359jIZzlOSKIZiOLhafVN05amT
         B43Yyacb9tFrPYub1uHBTYJAY3rkO+IzwpY24lal5neRg0gKHn2z5vObTkojNxtM8h
         uKunhQxvc0pA7cbj7Mn4cHz4hzwAwU35bRyIH2M7cIHpRv00Y0ETIyM/yR4Zol3Xbv
         GBFLDU9/kq2WJk8pk4GnWH9NLe9t9+TemPeL2wDSf7QntdpobBn9UKMYmR6MTHNHeQ
         E0YhjH8jnhnS7Tsk+urMBX83n2gnnvEqC89mFyWbo9i7AYhqWwE0FmllDpthylwM7p
         IdiNp5YFmkYNw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Ma <li.ma@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/37] drm/amd/pm/swsmu/smu11/vangogh_ppt: Provide a couple of missing parameter descriptions
Date:   Fri, 17 Mar 2023 08:17:00 +0000
Message-Id: <20230317081718.2650744-20-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317081718.2650744-1-lee@kernel.org>
References: <20230317081718.2650744-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:2381: warning: Function parameter or member 'residency' not described in 'vangogh_get_gfxoff_residency'
 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:2399: warning: Function parameter or member 'entrycount' not described in 'vangogh_get_gfxoff_entrycount'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Li Ma <li.ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 4590374251f3b..7433dcaa16e04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2389,6 +2389,7 @@ static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool start)
  * vangogh_get_gfxoff_residency
  *
  * @smu: amdgpu_device pointer
+ * @residency: placeholder for return value
  *
  * This function will be used to get gfxoff residency.
  *
@@ -2407,6 +2408,7 @@ static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint32_t *resid
  * vangogh_get_gfxoff_entrycount - get gfxoff entry count
  *
  * @smu: amdgpu_device pointer
+ * @entrycount: placeholder for return value
  *
  * This function will be used to get gfxoff entry count
  *
-- 
2.40.0.rc1.284.g88254d51c5-goog

