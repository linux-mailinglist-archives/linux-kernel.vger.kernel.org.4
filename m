Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074AB620F8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiKHLxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiKHLx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:53:29 -0500
X-Greylist: delayed 1290 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 03:53:26 PST
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F5ADF76
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:53:26 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N661d0Cgdz8RV6H
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:53:25 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N661Y6Vqpz4xq1X;
        Tue,  8 Nov 2022 19:53:21 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl1.zte.com.cn with SMTP id 2A8BrE7n071574;
        Tue, 8 Nov 2022 19:53:14 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 8 Nov 2022 19:53:17 +0800 (CST)
Date:   Tue, 8 Nov 2022 19:53:17 +0800 (CST)
X-Zmail-TransId: 2b05636a432d5fbbdaa2
X-Mailer: Zmail v1.0
Message-ID: <202211081953176181859@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <rafael@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <xu.panda668@gmail.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRyaXZlcnMvYmFzZS9ub2RlOiByZW1vdmUgZHVwbGljYXRlZCBpbmNsdWRlZCBsaW51eC9odWdldGxiLmg=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2A8BrE7n071574
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 636A4335.000 by FangMail milter!
X-FangMail-Envelope: 1667908405/4N661d0Cgdz8RV6H/636A4335.000/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636A4335.000/4N661d0Cgdz8RV6H
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The linux/hugetlb.h is included more than once.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/base/node.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index faf3597a96da..4306611ac092 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,7 +20,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
-#include <linux/hugetlb.h>

 static struct bus_type node_subsys = {
 	.name = "node",
-- 
2.15.2
