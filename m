Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1AF6BE373
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjCQIZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjCQIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:24:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B872813525
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5625FB824EC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8179BC4339C;
        Fri, 17 Mar 2023 08:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041414;
        bh=Cr4jztM/jT6uRXyXs0wSG6822LEfj7acA8by/4R7UwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3wFIdKQuXNYprr4+dndpX6xjfjGsu5XEYhu/qtf62VERx9ECy2EOOjY4IO/iOt/Q
         skXHkVp/veAoo4q5NiLM7GZO2z6tvrC4l8R2hNEVw8ZASeHT9aX5Dly5fcQkxLCAkR
         47PZOcqAm9zN7qhd4yMqF47F6iT9sbu7F/uckwklbiENHJZk+bzZ1TkRwHSfbniZmN
         guqHNszY/2H5nz3ONUb5YPM9SbJimcIcG+p6RxpqnMR4jGiTlW0wFlIrtWmLrbAqR0
         GNpOejoJup+km/kUE8f0O11uUa274LWdc199VjKxy8leRLGecFMDF5nv36ulfjPZX2
         xl8cLf9mSoqSw==
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
        Wenjing Liu <wenjing.liu@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/37] drm/amd/display/dc/link/protocols/link_dp_training: Remove set but unused variable 'result'
Date:   Fri, 17 Mar 2023 08:17:11 +0000
Message-Id: <20230317081718.2650744-31-lee@kernel.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.c: In function ‘perform_link_training_with_retries’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.c:1586:38: warning: variable ‘result’ set but not used [-Wunused-but-set-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c   | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index a9025671ee4a8..10261764a0cea 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1580,8 +1580,7 @@ bool perform_link_training_with_retries(
 				 * Report and continue with eDP panel mode to
 				 * perform eDP link training with right settings
 				 */
-				bool result;
-				result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
+				cp_psp->funcs.enable_assr(cp_psp->handle, link);
 			}
 		}
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

