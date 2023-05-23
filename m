Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0170D26B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjEWDcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEWDcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:32:16 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6245790
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:32:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VjIH3CS_1684812723;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VjIH3CS_1684812723)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 11:32:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     christian.koenig@amd.com
Cc:     Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu/vcn: Modify mismatched function name
Date:   Tue, 23 May 2023 11:32:02 +0800
Message-Id: <20230523033202.109828-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:374: warning: expecting prototype for vcn_v4_0_mc_resume_dpg_mode(). Prototype was for vcn_v4_0_3_mc_resume_dpg_mode() instead.
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:631: warning: expecting prototype for vcn_v4_0_enable_clock_gating(). Prototype was for vcn_v4_0_3_enable_clock_gating() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=5284
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 339842382a1e..5d67b8b8a3d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -362,7 +362,7 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
 }
 
 /**
- * vcn_v4_0_mc_resume_dpg_mode - memory controller programming for dpg mode
+ * vcn_v4_0_3_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
  * @adev: amdgpu_device pointer
  * @inst_idx: instance number index
@@ -620,7 +620,7 @@ static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
 }
 
 /**
- * vcn_v4_0_enable_clock_gating - enable VCN clock gating
+ * vcn_v4_0_3_enable_clock_gating - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
  * @inst_idx: instance number
-- 
2.20.1.7.g153144c

