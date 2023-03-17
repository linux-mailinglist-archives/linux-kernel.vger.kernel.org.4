Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA366BE370
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCQIZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCQIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:24:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A1126E7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:23:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44F61B82504
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C80C433A0;
        Fri, 17 Mar 2023 08:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041404;
        bh=2B9e7zTbjnHiArP7df0efgEJYbKhHWL2S0uHdMgrMRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0/xYEqiyDqkdvCFf4DfuZ9NyLObfivYg5mrdn1GFM0qtvX+6tYdJ49T5xlCLak2T
         e1RLsG04ZoD1p/KszNL53jj2ZtqqJUGN1CKbZgf3UMyg2cAF1T1YPnzx3Rbf5holc0
         bBYVDNV2Qt24I2Qwq1pSvn1Eg5CGhtGytF859v+3EmVPLcERQChRV7T010F7x0L5jI
         tpFGhdfuVKmyNgDH9cLjUuW+1P7evsnnlKAIHn5u54ZQC0/JJpVwXaTwN7xTKBS/0t
         jI4bv2TZ1FXfPF+4bqyIOpfZ9EnxSZXAM3hbkfjDSOtkxJVDvCa2TdKxAgJYUb2PyS
         GlMBEsamP5Oew==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Zhang <dingchen.zhang@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/37] drm/amd/display/dc/dce/dmub_psr: Demote kerneldoc abuse
Date:   Fri, 17 Mar 2023 08:17:08 +0000
Message-Id: <20230317081718.2650744-28-lee@kernel.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:257: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Zhang <dingchen.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 27b8f3435d86f..9705d8f883825 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -253,7 +253,7 @@ static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level, uint8_
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
 }
 
-/**
+/*
  * Set PSR vtotal requirement for FreeSync PSR.
  */
 static void dmub_psr_set_sink_vtotal_in_psr_active(struct dmub_psr *dmub,
-- 
2.40.0.rc1.284.g88254d51c5-goog

