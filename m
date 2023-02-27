Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83F36A37C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 03:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjB0CLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 21:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjB0CKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:10:22 -0500
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EE31A673
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 18:09:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VcVCSC._1677463663;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VcVCSC._1677463663)
          by smtp.aliyun-inc.com;
          Mon, 27 Feb 2023 10:07:45 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu: make umc_v8_10_convert_error_address static
Date:   Mon, 27 Feb 2023 10:07:31 +0800
Message-Id: <20230227020731.114822-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of umc_v8_10.c, so marks it static.

drivers/gpu/drm/amd/amdgpu/umc_v8_10.c:212:6: warning: no previous prototype for function 'umc_v8_10_convert_error_address'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4230
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index 66158219f791..048ab4202e9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -209,7 +209,7 @@ static int umc_v8_10_swizzle_mode_na_to_pa(struct amdgpu_device *adev,
 	return 0;
 }
 
-void umc_v8_10_convert_error_address(struct amdgpu_device *adev,
+static void umc_v8_10_convert_error_address(struct amdgpu_device *adev,
 				    struct ras_err_data *err_data, uint64_t err_addr,
 				    uint32_t ch_inst, uint32_t umc_inst,
 				    uint32_t node_inst, uint64_t mc_umc_status)
-- 
2.20.1.7.g153144c

