Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00715B80E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiINF2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiINF2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:28:37 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18786D9E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:28:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VPlhali_1663133292;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPlhali_1663133292)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 13:28:14 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 6/8] drm/amd/display: make some functions static
Date:   Wed, 14 Sep 2022 13:27:40 +0800
Message-Id: <20220914052742.116297-6-jiapeng.chong@linux.alibaba.com>
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

These functions are not used outside the file dcn32_hubbub.c, so the
modification is defined as static.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hubbub.c:912:6: warning: no previous prototype for ‘hubbub32_force_wm_propagate_to_pipes’.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hubbub.c:823:6: warning: no previous prototype for ‘hubbub32_wm_read_state’.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hubbub.c:772:6: warning: no previous prototype for ‘hubbub32_init_watermarks’.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hubbub.c:712:6: warning: no previous prototype for ‘hubbub32_force_usr_retraining_allow’.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2141
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index 99eb239bbc7b..d4963959426c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -709,7 +709,7 @@ static bool hubbub32_program_usr_watermarks(
 	return wm_pending;
 }
 
-void hubbub32_force_usr_retraining_allow(struct hubbub *hubbub, bool allow)
+static void hubbub32_force_usr_retraining_allow(struct hubbub *hubbub, bool allow)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
@@ -769,7 +769,7 @@ static bool hubbub32_program_watermarks(
 }
 
 /* Copy values from WM set A to all other sets */
-void hubbub32_init_watermarks(struct hubbub *hubbub)
+static void hubbub32_init_watermarks(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	uint32_t reg;
@@ -820,7 +820,7 @@ void hubbub32_init_watermarks(struct hubbub *hubbub)
 	REG_WRITE(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D, reg);
 }
 
-void hubbub32_wm_read_state(struct hubbub *hubbub,
+static void hubbub32_wm_read_state(struct hubbub *hubbub,
 		struct dcn_hubbub_wm *wm)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
@@ -909,7 +909,7 @@ void hubbub32_wm_read_state(struct hubbub *hubbub,
 			DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D, &s->fclk_pstate_change);
 }
 
-void hubbub32_force_wm_propagate_to_pipes(struct hubbub *hubbub)
+static void hubbub32_force_wm_propagate_to_pipes(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	uint32_t refclk_mhz = hubbub->ctx->dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
-- 
2.20.1.7.g153144c

