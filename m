Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C3652D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiLUGyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLUGyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:54:12 -0500
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Dec 2022 22:54:09 PST
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0B741DF18
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=eo8a3S3q6PpwkEMGff
        mZODF2xFDRJbXrhcoHqMsVYPI=; b=ATh+jS1zomD22OVmBMauicbYqxUbQ4ym/j
        GeEYMcgEB1UsgBGdXf0QpK+0/wNRY/dM/04JUJCFv+dvk9kntzVQ3niVeuTn13CK
        DBZuTbp2fdsqnHq05rHOO7TniGxFiE2jFWhysR6xhqoMyRPa6byvLNo1q4RDTdST
        yKfNnWbzA=
Received: from localhost.localdomain (unknown [36.4.209.128])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wAnX6_BqaJjT+lLAA--.45478S4;
        Wed, 21 Dec 2022 14:38:38 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     linux@dominikbrodowski.net
Cc:     linux-kernel@vger.kernel.org, lizhe <sensor1010@163.com>
Subject: [PATCH] drivers/tcic.c : remove the "&" of the second parameter
Date:   Tue, 20 Dec 2022 22:37:49 -0800
Message-Id: <20221221063749.82666-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wAnX6_BqaJjT+lLAA--.45478S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrGr48ZF17WrWkKF4fJrWxCrg_yoWxXrX_Wr
        1FqF47Ar4UKFn8ur47Cw1fZry3ta9xWF4kAF1Ig34fCF4fZF1jv3s8Wry5K3s7urWDJFyD
        ArZrtry5urWUXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRCxRh5UUUUU==
X-Originating-IP: [36.4.209.128]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBXhDeq1aEAN10jwAAsP
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	The second parameter is the entry address of the function,
	Not required&

Signed-off-by: lizhe <sensor1010@163.com>
---
 drivers/pcmcia/tcic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
index 1a0e3f098759..5ef888688e23 100644
--- a/drivers/pcmcia/tcic.c
+++ b/drivers/pcmcia/tcic.c
@@ -435,7 +435,7 @@ static int __init init_tcic(void)
     }
     
     /* Set up polling */
-    timer_setup(&poll_timer, &tcic_timer, 0);
+    timer_setup(&poll_timer, tcic_timer, 0);
 
     /* Build interrupt mask */
     printk(KERN_CONT ", %d sockets\n", sockets);
-- 
2.17.1

