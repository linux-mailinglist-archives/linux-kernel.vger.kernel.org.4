Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F545B9273
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiIOB63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiIOB6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:58:16 -0400
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0578F8F955
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:58:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VPqLcz8_1663207087;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VPqLcz8_1663207087)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 09:58:08 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/6] drm/amd/display: clean up some inconsistent indentings
Date:   Thu, 15 Sep 2022 09:57:58 +0800
Message-Id: <20220915015802.59967-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220915015802.59967-1-yang.lee@linux.alibaba.com>
References: <20220915015802.59967-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clean up some inconsistent indentings

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2178
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 10477ca52a41..47159e9a0884 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -406,14 +406,14 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 		if (adev->reset_domain->type != XGMI_HIVE) {
 			hive->reset_domain =
 				amdgpu_reset_create_reset_domain(XGMI_HIVE, "amdgpu-reset-hive");
-				if (!hive->reset_domain) {
-					dev_err(adev->dev, "XGMI: failed initializing reset domain for xgmi hive\n");
-					ret = -ENOMEM;
-					kobject_put(&hive->kobj);
-					kfree(hive);
-					hive = NULL;
-					goto pro_end;
-				}
+			if (!hive->reset_domain) {
+				dev_err(adev->dev, "XGMI: failed initializing reset domain for xgmi hive\n");
+				ret = -ENOMEM;
+				kobject_put(&hive->kobj);
+				kfree(hive);
+				hive = NULL;
+				goto pro_end;
+			}
 		} else {
 			amdgpu_reset_get_reset_domain(adev->reset_domain);
 			hive->reset_domain = adev->reset_domain;
-- 
2.20.1.7.g153144c

