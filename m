Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4AA74CE4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGJHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjGJHYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:24:31 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C481B1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:24:20 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4QzwVS1zQZzbNJW
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:24:16 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4QzwVB42FNzBRP06
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:24:02 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QzwV46M5Vz7QYRf
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:23:56 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4QzwTt1tbVz501NP;
        Mon, 10 Jul 2023 15:23:46 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 36A7NcXG031627;
        Mon, 10 Jul 2023 15:23:38 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 10 Jul 2023 15:23:40 +0800 (CST)
Date:   Mon, 10 Jul 2023 15:23:40 +0800 (CST)
X-Zmail-TransId: 2afa64abb1fc43d-f7b4d
X-Mailer: Zmail v1.0
Message-ID: <202307101523409041269@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <rafael.j.wysocki@intel.com>
Cc:     <peterz@infradead.org>, <ebiederm@xmission.com>,
        <elver@google.com>, <tglx@linutronix.de>,
        <michael.christie@oracle.com>, <haifeng.xu@shopee.com>,
        <viro@zeniv.linux.org.uk>, <mcgrof@kernel.org>,
        <dvyukov@google.com>, <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBzaWduYWw6IHJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZSBoZWFkZXIgaW4gc2lnbmFsLmM=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 36A7NcXG031627
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64ABB21F.000/4QzwVS1zQZzbNJW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

linux/file.h is included more than once.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 kernel/signal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9a3ff8157ceb..b1da4e81bde6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -25,7 +25,6 @@
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/tty.h>
-#include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/coredump.h>
 #include <linux/security.h>
-- 
2.25.1
