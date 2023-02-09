Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457356900B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBIHLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIHLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:11:35 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D202516AE7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:11:32 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PC7MQ6Cyfz6FK2T;
        Thu,  9 Feb 2023 15:11:30 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 3197BK4w016072;
        Thu, 9 Feb 2023 15:11:20 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 9 Feb 2023 15:11:22 +0800 (CST)
Date:   Thu, 9 Feb 2023 15:11:22 +0800 (CST)
X-Zmail-TransId: 2af963e49c9afffffffffe960917
X-Mailer: Zmail v1.0
Message-ID: <202302091511222329971@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <alexander.deucher@amd.com>
Cc:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <rodrigo.siqueira@amd.com>, <christian.koenig@amd.com>,
        <xinhui.pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <qingqing.zhuo@amd.com>, <george.shen@amd.com>,
        <wenjing.liu@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYW1kZ3B1L2Rpc3BsYXk6IHJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZSBoZWFkZXIgaW7CoGxpbmtfZHBtcy5j?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3197BK4w016072
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63E49CA2.000 by FangMail milter!
X-FangMail-Envelope: 1675926690/4PC7MQ6Cyfz6FK2T/63E49CA2.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E49CA2.000/4PC7MQ6Cyfz6FK2T
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

link_hwss.h is included more than once.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
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
