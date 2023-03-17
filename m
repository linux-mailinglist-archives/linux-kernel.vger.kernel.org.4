Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921196BE376
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjCQIZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjCQIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:24:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37ADDCF6D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A15E462232
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B73C433D2;
        Fri, 17 Mar 2023 08:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041427;
        bh=NOYuJBkMG2aOIrnVVrxx/Uchnlhk4g81Tk/YznxqtK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bz8yjHpRJnZpy8Xf3vb3h/RB7nif+Ma1ZlOfk+2alBULuT4mos9yOs0Kr6GRuZGCR
         nChmB/jM8jCY8ZGQQNW66dU5Iifo2ncpooVfw8g3SwEz+QopwQhl7pklpoHe27puZm
         gno5+q8LJZw6QMCit60fRJQVHCKcfBtxY8t4poe/gj1TAMRMLt2csA5bu9HQ4zZFiU
         SD644ajHJIBOPmI6CmTVgk0pWgrb8Jm3sk92EZUKzf+G6vz+toOEsYmHiAJ1sKuPs8
         rnuVEJS0M6I/pgE8vfr4Mv/JIhPbHVEBk+GVDV1+smYVREzrrbr7zewe0eXhynk+du
         EIe0FxO3/0JBQ==
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
        Mauro Rossi <issor.oruam@gmail.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/37] drm/amd/display/dc/dce60/Makefile: Fix previous attempt to silence known override-init warnings
Date:   Fri, 17 Mar 2023 08:17:16 +0000
Message-Id: <20230317081718.2650744-36-lee@kernel.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:21: note: in expansion of macro ‘mmCRTC1_DCFE_MEM_LIGHT_SLEEP_CNTL’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:9: note: in expansion of macro ‘SRI’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:17: note: in expansion of macro ‘XFM_COMMON_REG_LIST_DCE60’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:188:17: note: in expansion of macro ‘transform_regs’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:722:43: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:21: note: in expansion of macro ‘mmCRTC2_DCFE_MEM_LIGHT_SLEEP_CNTL’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:9: note: in expansion of macro ‘SRI’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:17: note: in expansion of macro ‘XFM_COMMON_REG_LIST_DCE60’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:189:17: note: in expansion of macro ‘transform_regs’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:722:43: note: (near initialization for ‘xfm_regs[2].DCFE_MEM_LIGHT_SLEEP_CN

[100 lines snipped for brevity]

Fixes: ceb3cf476a441 ("drm/amd/display/dc/dce60/Makefile: Ignore -Woverride-init warning")
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce60/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/Makefile b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
index dda596fa1cd76..fee331accc0e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
-CFLAGS_AMDDALPATH)/dc/dce60/dce60_resource.o = $(call cc-disable-warning, override-init)
+CFLAGS_$(AMDDALPATH)/dc/dce60/dce60_resource.o = $(call cc-disable-warning, override-init)
 
 DCE60 = dce60_timing_generator.o dce60_hw_sequencer.o \
 	dce60_resource.o
-- 
2.40.0.rc1.284.g88254d51c5-goog

