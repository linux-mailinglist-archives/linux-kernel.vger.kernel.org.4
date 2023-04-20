Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351806E8D20
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjDTIsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjDTIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:47:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEA34EF1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AA05616CB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66EBC433D2;
        Thu, 20 Apr 2023 08:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681980464;
        bh=kKXjO3ninqXIeQWB3eu4IcT9qlvhS73M2v92M/DhaYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8hUmpyBvEpn1bAMEJqiJ2hz5yLrxb0Rzw+7oB16SXGLEhk2JWmXprLGbgmPrBQSu
         c6P4kKlqouNjAnEvtuL/S3PsMIINvdjMFLL41sNToG6p2+ciDEW0im0ZJv09IrdXq1
         vGx1/9ihXL6eYhArihJSmV/xHs59wZSBoVnw7I3Ax1Ywhffxh0idl6sMTxU6JUpYeX
         1W8BTJhKyA8lSJBIhHEsK2WDaIcnQ7QwX3x7HokfpL1r4UA3zuAJ4zoXYexlKx5iqB
         lkcl9/t1dA2PCkn2d3ENv9CambLwfjJg08CaPYQwCP6V03oFrjcOIMGBRcri0ZxeSv
         aRcOc0ehtjXLg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Huang <Leon.Huang1@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/amd/display: remove unused variables in dcn21_set_backlight_level
Date:   Thu, 20 Apr 2023 10:47:02 +0200
Message-Id: <20230420084711.3063453-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420084711.3063453-1-arnd@kernel.org>
References: <20230420084711.3063453-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The only references to these variables were removed, so they now cause
warnings and have to be removed as well:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:226:20: error: unused variable 'cmd' [-Werror,-Wunused-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:229:11: error: unused variable 'otg_inst' [-Werror,-Wunused-variable]

Fixes: 6f0ef80a00ad ("drm/amd/display: Fix ABM pipe/backlight issues when change backlight")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 55a464a39529..43463d08f21b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -223,10 +223,8 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp)
 {
-	union dmub_rb_cmd cmd;
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct abm *abm = pipe_ctx->stream_res.abm;
-	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 
 	if (dc->dc->res_pool->dmcu) {
-- 
2.39.2

