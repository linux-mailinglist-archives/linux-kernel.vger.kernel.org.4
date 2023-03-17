Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB186BE374
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCQIZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjCQIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF32DCF68
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A58B462224
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BC3C4339B;
        Fri, 17 Mar 2023 08:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041411;
        bh=79iAvhZFRGEvtnZme2ps1FOUDz1tuFW8RI7HfSRsKrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlrgMtSkoRGw5phNB19c9q5leoa9sBOe+WFRzK6J/2ksv0eObO3zdafcDaEDSv3f2
         A/NETGTlaIRob9JniBVKZDQHxIh+2CF8oD7nY9WfBDG7Xmh3cxfTnDdudySURoG5aY
         SbBii3l/sknzFXtnhERM3DZFnZdMQ2kDcoVk2vCufNQ2d7uDZILZiJiRnR+NJAewHo
         IGEertbiQsI4IFV+/i+7K6u4Zy2pl6wwi3geQ9ObU0GvV+yFnP6qysofUSKOU8DuS8
         vJOTjgBxa6nFXJN7WDXiKNorqir/LX15yltNon5R2Vu1JEjMq3d4sQBeCL1N17Z0/C
         ChhK6RNxCSc6w==
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
Subject: [PATCH 29/37] drm/amd/display/dc/link/link_detection: Remove unused variable 'status'
Date:   Fri, 17 Mar 2023 08:17:10 +0000
Message-Id: <20230317081718.2650744-30-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317081718.2650744-1-lee@kernel.org>
References: <20230317081718.2650744-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_detection.c: In function ‘query_hdcp_capability’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_detection.c:501:42: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]

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
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 9177b146a80a8..9a4cfa777622e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -498,8 +498,6 @@ static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
 	dc_process_hdcp_msg(signal, link, &msg22);
 
 	if (signal == SIGNAL_TYPE_DISPLAY_PORT || signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-		enum hdcp_message_status status = HDCP_MESSAGE_UNSUPPORTED;
-
 		msg14.data = &link->hdcp_caps.bcaps.raw;
 		msg14.length = sizeof(link->hdcp_caps.bcaps.raw);
 		msg14.msg_id = HDCP_MESSAGE_ID_READ_BCAPS;
@@ -507,7 +505,7 @@ static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
 		msg14.link = HDCP_LINK_PRIMARY;
 		msg14.max_retries = 5;
 
-		status = dc_process_hdcp_msg(signal, link, &msg14);
+		dc_process_hdcp_msg(signal, link, &msg14);
 	}
 
 }
-- 
2.40.0.rc1.284.g88254d51c5-goog

