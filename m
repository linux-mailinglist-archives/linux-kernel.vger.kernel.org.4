Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2556BE37C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjCQI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCQIZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397ABE1918
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7DC621EF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C174C433D2;
        Fri, 17 Mar 2023 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041408;
        bh=ZlS/GNeGQgSgiA5XT2FCbE2X1vZ2yBY3Mq2Etnbekhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j31dTC8X0eOQrOT2QXaovP1tshj8tnd9kSzvTeHtoq0na1OSkwwyNZ4/Udtl5Lp5k
         lWG2S/2Ism3NRmBkwzWBO/RkYtcqCh3Tt+zeRDeXSpoUwqV0CX7bd5F7NB5NKMcnUw
         2taLPu1/j1rm/Mlm+KMwOAdKH/SEeD+YkFx1+u8RqwlNKMupJ2+mGMgVjL4N3yoZof
         nmfVuyYBFPSwl+KIY5k+sCHyTk3IcLI3c+eeojaVVqxt23gCgl+BIzleKEUol2hcAF
         +EZawmcWZv2z3E6Am6Ol2SOx89glt9SR4dZjUdza5ARzWdd8mB/6ZGFy2hDjy7uR1b
         ECFg6O2O/na/w==
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
        Mustapha Ghaddar <mghaddar@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Jasdeep Dhillon <jdhillon@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/37] drm/amd/display/dc/core/dc_stat: Convert a couple of doc headers to kerneldoc format
Date:   Fri, 17 Mar 2023 08:17:09 +0000
Message-Id: <20230317081718.2650744-29-lee@kernel.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stat.c:38: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stat.c:76: warning: Cannot understand  *****************************************************************************

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mustapha Ghaddar <mghaddar@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Jasdeep Dhillon <jdhillon@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c | 28 +++++++------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
index 6c06587dd88c2..5f6392ae31a66 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
@@ -35,19 +35,15 @@
  */
 
 /**
- *****************************************************************************
- *  Function: dc_stat_get_dmub_notification
+ *  dc_stat_get_dmub_notification
  *
- *  @brief
- *		Calls dmub layer to retrieve dmub notification
+ * Calls dmub layer to retrieve dmub notification
  *
- *  @param
- *		[in] dc: dc structure
- *		[in] notify: dmub notification structure
+ * @dc: dc structure
+ * @notify: dmub notification structure
  *
- *  @return
+ * Returns
  *     None
- *****************************************************************************
  */
 void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification *notify)
 {
@@ -73,19 +69,15 @@ void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification
 }
 
 /**
- *****************************************************************************
- *  Function: dc_stat_get_dmub_dataout
+ * dc_stat_get_dmub_dataout
  *
- *  @brief
- *		Calls dmub layer to retrieve dmub gpint dataout
+ * Calls dmub layer to retrieve dmub gpint dataout
  *
- *  @param
- *		[in] dc: dc structure
- *		[in] dataout: dmub gpint dataout
+ * @dc: dc structure
+ * @dataout: dmub gpint dataout
  *
- *  @return
+ * Returns
  *     None
- *****************************************************************************
  */
 void dc_stat_get_dmub_dataout(const struct dc *dc, uint32_t *dataout)
 {
-- 
2.40.0.rc1.284.g88254d51c5-goog

