Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C686803C1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjA3COI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjA3COG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:14:06 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D671F48B
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:14:04 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4P4sDn4X8Jz6FK2Q;
        Mon, 30 Jan 2023 10:14:01 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 30U2DobQ062007;
        Mon, 30 Jan 2023 10:13:50 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 30 Jan 2023 10:13:51 +0800 (CST)
Date:   Mon, 30 Jan 2023 10:13:51 +0800 (CST)
X-Zmail-TransId: 2af963d727df2c6131f0
X-Mailer: Zmail v1.0
Message-ID: <202301301013518438986@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <alex.williamson@redhat.com>
Cc:     <akrowiak@linux.ibm.com>, <rostedt@goodmis.org>, <jgg@ziepe.ca>,
        <gregkh@linuxfoundation.org>, <mhiramat@kernel.org>,
        <ojeda@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBzYW1wbGVzOiBmaXggdGhlIHByb21wdCBhYm91dCBTQU1QTEVfVkZJT19NREVWX01CT0NIUw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30U2DobQ062007
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63D727E9.000 by FangMail milter!
X-FangMail-Envelope: 1675044841/4P4sDn4X8Jz6FK2Q/63D727E9.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63D727E9.000/4P4sDn4X8Jz6FK2Q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Change the prompt about SAMPLE_VFIO_MDEV_MBOCHS as
'Build VFIO mbochs example mediated device sample code'.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 samples/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 56b191d128d8..1b49f99f3074 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -208,7 +208,7 @@ config SAMPLE_VFIO_MDEV_MDPY_FB
 	  Guest fbdev driver for the virtual display sample driver.

 config SAMPLE_VFIO_MDEV_MBOCHS
-	tristate "Build VFIO mdpy example mediated device sample code"
+	tristate "Build VFIO mbochs example mediated device sample code"
 	select VFIO_MDEV
 	select DMA_SHARED_BUFFER
 	help
-- 
2.25.1
