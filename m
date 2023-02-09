Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439AD6905A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjBIKuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjBIKtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:49:51 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375B2572B2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:48:03 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PCD9D0gGPz501Qq;
        Thu,  9 Feb 2023 18:48:00 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 319Alpag050447;
        Thu, 9 Feb 2023 18:47:51 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 9 Feb 2023 18:47:54 +0800 (CST)
Date:   Thu, 9 Feb 2023 18:47:54 +0800 (CST)
X-Zmail-TransId: 2af963e4cf5affffffffd643d4b7
X-Mailer: Zmail v1.0
Message-ID: <202302091847543326041@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <alexander.deucher@amd.com>
Cc:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <rodrigo.siqueira@amd.com>, <christian.koenig@amd.com>,
        <xinhui.pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <qingqing.zhuo@amd.com>, <wenjing.liu@amd.com>,
        <george.shen@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <jani.nikula@linux.intel.com>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBkcm0vYW1kL2Rpc3BsYXk6IHJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZSBoZWFkZXI=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 319Alpag050447
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E4CF60.000/4PCD9D0gGPz501Qq
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

link_hwss.h is included more than once in link_dpms.c .

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
Fix the U+00A0 non-breaking space in the subject line.
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 9cdfa7f7dc77..0c26b3589608 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -51,7 +51,6 @@
 #include "link_enc_cfg.h"
 #include "resource.h"
 #include "dsc.h"
-#include "link_hwss.h"
 #include "dccg.h"
 #include "clk_mgr.h"
 #include "atomfirmware.h"
-- 
2.25.1
