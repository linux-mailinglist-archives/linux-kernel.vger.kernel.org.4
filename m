Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6E6715E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjARIKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjARIIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:08:00 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7D18B28
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:39:07 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Nxd1N3nh7z6FK2Q;
        Wed, 18 Jan 2023 15:39:04 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl1.zte.com.cn with SMTP id 30I7cwNo067361;
        Wed, 18 Jan 2023 15:38:58 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 18 Jan 2023 15:39:00 +0800 (CST)
Date:   Wed, 18 Jan 2023 15:39:00 +0800 (CST)
X-Zmail-TransId: 2af963c7a214131734d8
X-Mailer: Zmail v1.0
Message-ID: <202301181539003991927@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <alexander.deucher@amd.com>
Cc:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <rodrigo.siqueira@amd.com>, <christian.koenig@amd.com>,
        <xinhui.pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <wenjing.liu@amd.com>, <george.shen@amd.com>, <jun.lei@amd.com>,
        <jimmy.kizito@amd.com>, <michael.strauss@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IHJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZWQgaGVhZGVyIGZpbGVz?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30I7cwNo067361
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63C7A218.000 by FangMail milter!
X-FangMail-Envelope: 1674027544/4Nxd1N3nh7z6FK2Q/63C7A218.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C7A218.000/4Nxd1N3nh7z6FK2Q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

resource.h is included more than once.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 1e60827911c6..6747e4b199de 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -47,7 +47,6 @@
 #include "link/link_dp_training_auxless.h"
 #include "link/link_dp_phy.h"
 #include "link/link_dp_capability.h"
-#include "resource.h"
 #define DC_LOGGER \
 	link->ctx->logger

-- 
2.25.1
