Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0660A69190F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjBJHUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjBJHUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:20:18 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348F3BD9A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 23:20:14 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PClW05cvFz4xpyD;
        Fri, 10 Feb 2023 15:20:12 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 31A7K4AQ029688;
        Fri, 10 Feb 2023 15:20:04 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 10 Feb 2023 15:20:07 +0800 (CST)
Date:   Fri, 10 Feb 2023 15:20:07 +0800 (CST)
X-Zmail-TransId: 2af963e5f027082ca04e
X-Mailer: Zmail v1.0
Message-ID: <202302101520071730986@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <sudeep.holla@arm.com>
Cc:     <cristian.marussi@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBmaXJtd2FyZTogYXJtX3NjbWk6IHJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZSBoZWFkZXI=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 31A7K4AQ029688
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E5F02C.000/4PClW05cvFz4xpyD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

linux/of.h is included more than once.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/firmware/arm_scmi/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 73140b854b31..b2d242178fbc 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/device.h>
-#include <linux/of.h>

 #include "common.h"

-- 
2.25.1
