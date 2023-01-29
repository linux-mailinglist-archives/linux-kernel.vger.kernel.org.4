Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F9367FC97
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 04:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjA2DKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 22:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA2DKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 22:10:16 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C3022A08
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 19:10:14 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4P4GX535wxz8R03x;
        Sun, 29 Jan 2023 11:10:13 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 30T3A8Yq021450;
        Sun, 29 Jan 2023 11:10:08 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Sun, 29 Jan 2023 11:10:09 +0800 (CST)
Date:   Sun, 29 Jan 2023 11:10:09 +0800 (CST)
X-Zmail-TransId: 2af963d5e3915a445b95
X-Mailer: Zmail v1.0
Message-ID: <202301291110098787982@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <keescook@chromium.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <rdunlap@infradead.org>,
        <geert+renesas@glider.be>, <ojeda@kernel.org>,
        <zhaoyang.huang@unisoc.com>, <vbabka@suse.cz>,
        <dan.j.williams@intel.com>, <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBLY29uZmlnLmRlYnVnOiBmaXggdGhlIGRlcGVuZHMgYWJvdXQgY29uZmlnIFNDSEVEX0RFQlVH?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30T3A8Yq021450
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63D5E395.000 by FangMail milter!
X-FangMail-Envelope: 1674961813/4P4GX535wxz8R03x/63D5E395.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63D5E395.000/4P4GX535wxz8R03x
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Now, the right File Path about SCHED_DEBUG is /sys/kernel/debug/sched.
So, SCHED_DEBUG should depend on DEBUG_FS, not PROC_FS.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 520884f8f8e1..223b4459e710 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1143,7 +1143,7 @@ menu "Scheduler Debugging"

 config SCHED_DEBUG
 	bool "Collect scheduler debugging info"
-	depends on DEBUG_KERNEL && PROC_FS
+	depends on DEBUG_KERNEL && DEBUG_FS
 	default y
 	help
 	  If you say Y here, the /proc/sched_debug file will be provided
-- 
2.25.1
