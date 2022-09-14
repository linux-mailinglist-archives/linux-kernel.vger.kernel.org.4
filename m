Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1105B80DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiINF2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiINF2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:28:16 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E06C75A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:28:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VPlk9J-_1663133283;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPlk9J-_1663133283)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 13:28:05 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 4/8] drm/amd/display: make some functions static
Date:   Wed, 14 Sep 2022 13:27:38 +0800
Message-Id: <20220914052742.116297-4-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220914052742.116297-1-jiapeng.chong@linux.alibaba.com>
References: <20220914052742.116297-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are not used outside the file dcn32_hubbub.c, so the
modification is defined as static.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_dccg.c:223:6: warning: no previous prototype for ‘dccg314_set_valid_pixel_rate’.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_dccg.c:184:6: warning: no previous prototype for ‘dccg314_set_dpstreamclk’.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_dccg.c:140:6: warning: no previous prototype for ‘dccg314_set_dtbclk_dto’.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2144
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 232cc15979dd..36630d532c18 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -137,7 +137,7 @@ static void dccg314_set_dtbclk_p_src(
 }
 
 /* Controls the generation of pixel valid for OTG in (OTG -> HPO case) */
-void dccg314_set_dtbclk_dto(
+static void dccg314_set_dtbclk_dto(
 		struct dccg *dccg,
 		const struct dtbclk_dto_params *params)
 {
@@ -181,7 +181,7 @@ void dccg314_set_dtbclk_dto(
 	}
 }
 
-void dccg314_set_dpstreamclk(
+static void dccg314_set_dpstreamclk(
 		struct dccg *dccg,
 		enum streamclk_source src,
 		int otg_inst,
@@ -220,7 +220,7 @@ void dccg314_set_dpstreamclk(
 	}
 }
 
-void dccg314_set_valid_pixel_rate(
+static void dccg314_set_valid_pixel_rate(
 		struct dccg *dccg,
 		int ref_dtbclk_khz,
 		int otg_inst,
-- 
2.20.1.7.g153144c

