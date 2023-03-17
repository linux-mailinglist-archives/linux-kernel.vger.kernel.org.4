Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDFE6BE375
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjCQIZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCQIYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:24:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCA9DC082
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43927B824FE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB68C4339B;
        Fri, 17 Mar 2023 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041421;
        bh=+1k+/Wr58YHp0ZBe0/GKFULYVUDa3a7um1fJIRdhuAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QlNPE6sc5Q5bwZouBokneQqzsTOtXqgy4CKlOMgKBgADLkgIAjJvgMj1gV+78ymd9
         mhE1voP2gCsDnLX6u6Cg998RkwXS8g5qjLRtBjMczAt1604UeJNElRIUgBQNcng+HT
         ydRhhneS4FLRnOGc1FKSbpoabTGZ73nrV6a3DpiPmWQqSlyoYepKMtt7AG3j9PI5qR
         j1AF42fxhINHTxwdRmFm3wpP6wIvMQKjFMDAtpOa5MFHmk9SO3xyomfo1V6xC9qMea
         +x+j1kXhL23V+M+zrz4yOFheRnRBm5jAzAefTvR3BkS3wVaztciB5+lbfqJDUuzL0k
         hemBp0C1gdNrw==
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
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/37] drm/amd/display/dc/link/protocols/link_dp_capability: Demote non-compliant kerneldoc
Date:   Fri, 17 Mar 2023 08:17:14 +0000
Message-Id: <20230317081718.2650744-34-lee@kernel.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:2190: warning: Function parameter or member 'link' not described in 'dc_link_is_dp_sink_present'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 51427f5081642..2a2443535b676 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2177,7 +2177,7 @@ bool dp_verify_link_cap_with_retries(
 	return success;
 }
 
-/**
+/*
  * Check if there is a native DP or passive DP-HDMI dongle connected
  */
 bool dp_is_sink_present(struct dc_link *link)
-- 
2.40.0.rc1.284.g88254d51c5-goog

