Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB0E63E7CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiLACYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLACYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:24:32 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05864B39
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:24:32 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NN0JZ3zMJz4xVnR;
        Thu,  1 Dec 2022 10:24:30 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B12OKOH091870;
        Thu, 1 Dec 2022 10:24:20 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 10:24:21 +0800 (CST)
Date:   Thu, 1 Dec 2022 10:24:21 +0800 (CST)
X-Zmail-TransId: 2af963881055fffffffff8fd5203
X-Mailer: Zmail v1.0
Message-ID: <202212011024212258022@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <alexander.deucher@amd.com>
Cc:     <christian.koenig@amd.com>, <xinhui.pan@amd.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <tao.zhou1@amd.com>,
        <hawking.zhang@amd.com>, <yipeng.chai@amd.com>,
        <john.clements@amd.com>, <stanley.yang@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYW1kZ3B1OiB1c2Ugc3lzZnNfZW1pdCgpIHRvIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B12OKOH091870
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6388105E.001 by FangMail milter!
X-FangMail-Envelope: 1669861470/4NN0JZ3zMJz4xVnR/6388105E.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6388105E.001/4NN0JZ3zMJz4xVnR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 077404a9c935..ad490c1e2f57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1267,7 +1267,7 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
 	struct amdgpu_ras *con =
 		container_of(attr, struct amdgpu_ras, features_attr);

-	return scnprintf(buf, PAGE_SIZE, "feature mask: 0x%x\n", con->features);
+	return sysfs_emit(buf, "feature mask: 0x%x\n", con->features);
 }

 static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
-- 
2.25.1
