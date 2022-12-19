Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FC665078E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiLSGbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiLSGbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:31:12 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984EB6429;
        Sun, 18 Dec 2022 22:31:10 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Nb8wr2w1Fz8R03x;
        Mon, 19 Dec 2022 14:31:08 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 2BJ6V3Q1089926;
        Mon, 19 Dec 2022 14:31:03 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 19 Dec 2022 14:31:05 +0800 (CST)
Date:   Mon, 19 Dec 2022 14:31:05 +0800 (CST)
X-Zmail-TransId: 2afa63a005295d10edca
X-Mailer: Zmail v1.0
Message-ID: <202212191431057948891@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <bristot@kernel.org>
Cc:     <rostedt@goodmis.org>, <zhang.songyi@zte.com.cn>,
        <linux-trace-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHRvb2xzL3J2OiBSZW1vdmUgdW5uZWVkZWQgc2VtaWNvbG9u?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2BJ6V3Q1089926
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63A0052C.000 by FangMail milter!
X-FangMail-Envelope: 1671431468/4Nb8wr2w1Fz8R03x/63A0052C.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63A0052C.000/4Nb8wr2w1Fz8R03x
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

The semicolon after the "}" is unneeded.

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 tools/verification/rv/src/in_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index 50848d79b38b..ad28582bcf2b 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -519,7 +519,7 @@ static void ikm_usage_print_reactors(void)

 		start = ++end;
 		end = strstr(start, "\n");
-	};
+	}

 	fprintf(stderr, "\n");
 }
-- 
2.15.2
