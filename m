Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B076BE37A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjCQI0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjCQIZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:25:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF38DCA45
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D074B82508
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7F7C4339B;
        Fri, 17 Mar 2023 08:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041430;
        bh=PzQsIWfBb2EKaOP67+P9k7aKdDRFtAy32uO9QOMW7BY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjZQ92UhjWf8eZqWnhGv23fVoXeI1IYx+Fk/XeWlfOUtN8UYp4scmG+dL3z7pMoYC
         4cFq2v2+L4pTY2JbSgfXJhZPaAHdtqyb9OSymNNlZZ7pZeNIReIeRmjimSXzEWPAAA
         z1dv3OLHVQFyvHrWaNXBleNtF/JkoAwlOVU/tx/IGH3q063PaXggeUt84P3PUYwm5K
         oZ+U/OWq2LsY+2/X9x+9ZaL85+1e22zKhWNJiNmBJxiIgos8q7t4ol5UK2qmDGpTVE
         ZDuQGSn1GXJ4q+HtXUgfph86wee6xpud3wYSfX5U5C6YnsduEEkcNSa24PoH0xrxUQ
         IdUUmr+CHAcYA==
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
Subject: [PATCH 36/37] drm/amd/display/dc/link/link_detection: Demote a couple of kerneldoc abuses
Date:   Fri, 17 Mar 2023 08:17:17 +0000
Message-Id: <20230317081718.2650744-37-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317081718.2650744-1-lee@kernel.org>
References: <20230317081718.2650744-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_detection.c:877: warning: Function parameter or member 'link' not described in 'detect_link_and_local_sink'
 drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_detection.c:877: warning: Function parameter or member 'reason' not described in 'detect_link_and_local_sink'
 drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_detection.c:1232: warning: Function parameter or member 'link' not described in 'dc_link_detect_connection_type'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lee Jones <lee@kernel.org>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 9a4cfa777622e..67addedd89563 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -832,7 +832,7 @@ static void verify_link_capability(struct dc_link *link, struct dc_sink *sink,
 		verify_link_capability_non_destructive(link);
 }
 
-/**
+/*
  * detect_link_and_local_sink() - Detect if a sink is attached to a given link
  *
  * link->local_sink is created or destroyed as needed.
@@ -1185,7 +1185,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 	return true;
 }
 
-/**
+/*
  * link_detect_connection_type() - Determine if there is a sink connected
  *
  * @type: Returned connection type
-- 
2.40.0.rc1.284.g88254d51c5-goog

