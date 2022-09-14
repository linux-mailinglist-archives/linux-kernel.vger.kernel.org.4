Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E8C5B80E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiINF3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiINF26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:28:58 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109356D54C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:28:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VPlj1Sf_1663133297;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPlj1Sf_1663133297)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 13:28:19 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 7/8] drm/amd/display: make some functions static
Date:   Wed, 14 Sep 2022 13:27:41 +0800
Message-Id: <20220914052742.116297-7-jiapeng.chong@linux.alibaba.com>
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

These functions are not used outside the file dcn32_dccg.c, so the
modification is defined as static.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:257:6: warning: no previous prototype for ‘dccg32_otg_drop_pixel’.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:248:6: warning: no previous prototype for ‘dccg32_otg_add_pixel’.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:211:6: warning: no previous prototype for ‘dccg32_set_dpstreamclk’.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:136:6: warning: no previous prototype for ‘dccg32_set_dtbclk_dto’.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2142
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 0d5e8a441512..26eb04ea472c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -133,7 +133,7 @@ static void dccg32_set_dtbclk_p_src(
 }
 
 /* Controls the generation of pixel valid for OTG in (OTG -> HPO case) */
-void dccg32_set_dtbclk_dto(
+static void dccg32_set_dtbclk_dto(
 		struct dccg *dccg,
 		const struct dtbclk_dto_params *params)
 {
@@ -208,7 +208,7 @@ static void dccg32_get_dccg_ref_freq(struct dccg *dccg,
 	return;
 }
 
-void dccg32_set_dpstreamclk(
+static void dccg32_set_dpstreamclk(
 		struct dccg *dccg,
 		enum streamclk_source src,
 		int otg_inst,
@@ -245,7 +245,7 @@ void dccg32_set_dpstreamclk(
 	}
 }
 
-void dccg32_otg_add_pixel(struct dccg *dccg,
+static void dccg32_otg_add_pixel(struct dccg *dccg,
 		uint32_t otg_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
@@ -254,7 +254,7 @@ void dccg32_otg_add_pixel(struct dccg *dccg,
 			OTG_ADD_PIXEL[otg_inst], 1);
 }
 
-void dccg32_otg_drop_pixel(struct dccg *dccg,
+static void dccg32_otg_drop_pixel(struct dccg *dccg,
 		uint32_t otg_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-- 
2.20.1.7.g153144c

