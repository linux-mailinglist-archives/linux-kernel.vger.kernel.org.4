Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2470EC54
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbjEXEBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbjEXEAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:00:44 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EC2E6E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:00:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VjMVrSC_1684900815;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VjMVrSC_1684900815)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 12:00:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 12/13] drm/amd/display: remove unused definition
Date:   Wed, 24 May 2023 11:59:51 +0800
Message-Id: <20230524035952.123590-12-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230524035952.123590-1-yang.lee@linux.alibaba.com>
References: <20230524035952.123590-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
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

Eliminate the following warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:1346:43: warning: unused variable 'res_create_maximus_funcs'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:735:38: warning: unused variable 'debug_defaults_diags'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5296
Fixes: 00df97e1df57 ("drm/amd/display: Clean FPGA code in dc")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../amd/display/dc/dcn321/dcn321_resource.c   | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index af0bb3e94250..bbcd3579fea6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -732,27 +732,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_max_blank_us = 1000,
 };
 
-static const struct dc_debug_options debug_defaults_diags = {
-	.disable_dmcu = true,
-	.force_abm_enable = false,
-	.timing_trace = true,
-	.clock_trace = true,
-	.disable_dpp_power_gate = true,
-	.disable_hubp_power_gate = true,
-	.disable_dsc_power_gate = true,
-	.disable_clock_gate = true,
-	.disable_pplib_clock_request = true,
-	.disable_pplib_wm_range = true,
-	.disable_stutter = false,
-	.scl_reset_length10 = true,
-	.dwb_fi_phase = -1, // -1 = disable
-	.dmub_command_table = true,
-	.enable_tri_buf = true,
-	.use_max_lb = true,
-	.force_disable_subvp = true,
-};
-
-
 static struct dce_aux *dcn321_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
@@ -1343,15 +1322,6 @@ static const struct resource_create_funcs res_create_funcs = {
 	.create_hwseq = dcn321_hwseq_create,
 };
 
-static const struct resource_create_funcs res_create_maximus_funcs = {
-	.read_dce_straps = NULL,
-	.create_audio = NULL,
-	.create_stream_encoder = NULL,
-	.create_hpo_dp_stream_encoder = dcn321_hpo_dp_stream_encoder_create,
-	.create_hpo_dp_link_encoder = dcn321_hpo_dp_link_encoder_create,
-	.create_hwseq = dcn321_hwseq_create,
-};
-
 static void dcn321_resource_destruct(struct dcn321_resource_pool *pool)
 {
 	unsigned int i;
-- 
2.20.1.7.g153144c

