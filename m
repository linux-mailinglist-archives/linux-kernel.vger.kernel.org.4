Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C296008A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJQI3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJQI3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:29:33 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A65DC7D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:29:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VSLGo6w_1665995358;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VSLGo6w_1665995358)
          by smtp.aliyun-inc.com;
          Mon, 17 Oct 2022 16:29:27 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu: Remove the unused function get_umc_v6_7_channel_index()
Date:   Mon, 17 Oct 2022 16:27:28 +0800
Message-Id: <20221017082728.73154-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function get_umc_v6_7_channel_index() is defined in the umc_v6_7.c
file, but not called elsewhere, so delete this unused function.

drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:60:24: warning: unused function 'get_umc_v6_7_channel_index'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2413
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 5d5d031c9e7d..6837fc89ba8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -57,13 +57,6 @@ static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
 	return adev->umc.channel_offs * ch_inst + UMC_V6_7_INST_DIST * umc_inst;
 }
 
-static inline uint32_t get_umc_v6_7_channel_index(struct amdgpu_device *adev,
-					      uint32_t umc_inst,
-					      uint32_t ch_inst)
-{
-	return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
-}
-
 static void umc_v6_7_query_error_status_helper(struct amdgpu_device *adev,
 						  uint64_t mc_umc_status, uint32_t umc_reg_offset)
 {
-- 
2.20.1.7.g153144c

