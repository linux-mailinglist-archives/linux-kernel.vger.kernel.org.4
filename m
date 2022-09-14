Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6835B80DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiINF2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiINF14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:27:56 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED15E6B8C8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:27:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VPlk9BD_1663133266;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPlk9BD_1663133266)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 13:27:49 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 1/8] drm/amd/display: make some functions static
Date:   Wed, 14 Sep 2022 13:27:35 +0800
Message-Id: <20220914052742.116297-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are not used outside the file dcn30_resource.c, so the
modification is defined as static.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1949:6: warning: no previous prototype for ‘is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch’.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1919:5: warning: no previous prototype for ‘get_frame_rate_at_max_stretch_100hz’.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2143
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 64320e0ca446..f6f3878c99b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1916,7 +1916,7 @@ static int get_refresh_rate(struct dc_state *context)
  */
 #define V_SCALE (10000 / MAX_STRETCHED_V_BLANK)
 
-int get_frame_rate_at_max_stretch_100hz(struct dc_state *context)
+static int get_frame_rate_at_max_stretch_100hz(struct dc_state *context)
 {
 	struct dc_crtc_timing *timing = NULL;
 	uint32_t sec_per_100_lines;
@@ -1946,7 +1946,7 @@ int get_frame_rate_at_max_stretch_100hz(struct dc_state *context)
 	return scaled_refresh_rate;
 }
 
-bool is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(struct dc_state *context)
+static bool is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(struct dc_state *context)
 {
 	int refresh_rate_max_stretch_100hz;
 	int min_refresh_100hz;
-- 
2.20.1.7.g153144c

