Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E65267F3C8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjA1BjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjA1BjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:39:18 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B16410A3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:39:16 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4P3cYZ2KBQz8R039;
        Sat, 28 Jan 2023 09:39:14 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 30S1d71v045972;
        Sat, 28 Jan 2023 09:39:07 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Sat, 28 Jan 2023 09:39:08 +0800 (CST)
Date:   Sat, 28 Jan 2023 09:39:08 +0800 (CST)
X-Zmail-TransId: 2af963d47cbcffffffffea16db64
X-Mailer: Zmail v1.0
Message-ID: <202301280939083976293@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <alexander.deucher@amd.com>
Cc:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <rodrigo.siqueira@amd.com>, <christian.koenig@amd.com>,
        <xinhui.pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <wenjing.liu@amd.com>, <haoping.liu@amd.com>,
        <george.shen@amd.com>, <dingchen.zhang@amd.com>,
        <ian.chen@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYW1kZ3B1L2Rpc3BsYXk6IHJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZSBoZWFkZXIgaW4gZmlsZXM=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30S1d71v045972
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63D47CC2.000 by FangMail milter!
X-FangMail-Envelope: 1674869954/4P3cYZ2KBQz8R039/63D47CC2.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63D47CC2.000/4P3cYZ2KBQz8R039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

opp.h is included more than once.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6475664baa8a..1a2ab934b4bd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -46,7 +46,6 @@
 #include "dpcd_defs.h"
 #include "dmcu.h"
 #include "dsc.h"
-#include "opp.h"
 #include "hw/clk_mgr.h"
 #include "dce/dmub_psr.h"
 #include "dmub/dmub_srv.h"
-- 
2.25.1
