Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1365B69AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiIMIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiIMIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:38:33 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27145B070
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:38:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VPf2T1G_1663058305;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPf2T1G_1663058305)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 16:38:27 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/5] drm/amd/display: make dscl32_calc_lb_num_partitions static
Date:   Tue, 13 Sep 2022 16:38:02 +0800
Message-Id: <20220913083805.22549-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220913083805.22549-1-jiapeng.chong@linux.alibaba.com>
References: <20220913083805.22549-1-jiapeng.chong@linux.alibaba.com>
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

This symbol is not used outside of dcn32_dpp.c, so marks it static.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dpp.c:34:6: warning: no previous prototype for ‘dscl32_calc_lb_num_partitions’.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2118
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.c
index f349cbe2a0f0..dcf12a0b031c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.c
@@ -31,7 +31,7 @@
 #include "dcn30/dcn30_cm_common.h"
 
 /* Compute the maximum number of lines that we can fit in the line buffer */
-void dscl32_calc_lb_num_partitions(
+static void dscl32_calc_lb_num_partitions(
 		const struct scaler_data *scl_data,
 		enum lb_memory_config lb_config,
 		int *num_part_y,
-- 
2.20.1.7.g153144c

