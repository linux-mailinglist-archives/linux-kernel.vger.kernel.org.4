Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AF35B80E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiINF3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiINF26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:28:58 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5AE6FA01
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:28:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VPlhaq2_1663133301;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPlhaq2_1663133301)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 13:28:24 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 8/8] drm/amd/display: make optc32_phantom_crtc_post_enable, optc32_setup_manual_trigger and optc32_set_drr static
Date:   Wed, 14 Sep 2022 13:27:42 +0800
Message-Id: <20220914052742.116297-8-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220914052742.116297-1-jiapeng.chong@linux.alibaba.com>
References: <20220914052742.116297-1-jiapeng.chong@linux.alibaba.com>
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

These three functions are not used outside the function
dcn32_optc.c, so the modification is defined as static.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_optc.c:159:6: warning: no previous prototype for function 'optc32_phantom_crtc_post_enable'.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_optc.c:218:6: warning: no previous prototype for ‘optc32_set_drr’.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_optc.c:193:6: warning: no previous prototype for ‘optc32_setup_manual_trigger’.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2140
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 1fad7b48bd5b..ec3989d37086 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -156,7 +156,7 @@ static bool optc32_disable_crtc(struct timing_generator *optc)
 	return true;
 }
 
-void optc32_phantom_crtc_post_enable(struct timing_generator *optc)
+static void optc32_phantom_crtc_post_enable(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -190,7 +190,7 @@ static void optc32_set_odm_bypass(struct timing_generator *optc,
 	optc1->opp_count = 1;
 }
 
-void optc32_setup_manual_trigger(struct timing_generator *optc)
+static void optc32_setup_manual_trigger(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	struct dc *dc = optc->ctx->dc;
@@ -215,7 +215,7 @@ void optc32_setup_manual_trigger(struct timing_generator *optc)
 	}
 }
 
-void optc32_set_drr(
+static void optc32_set_drr(
 	struct timing_generator *optc,
 	const struct drr_params *params)
 {
-- 
2.20.1.7.g153144c

