Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B18628EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiKOAs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiKOAsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:48:13 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24511DA50
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:48:11 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NB6wn3BqszvLN
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:48:09 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4NB6wW2Gfzz9vSnx
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:47:55 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4NB6wR6tl0z9tyD7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:47:51 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NB6wN4bBmz8QrkZ;
        Tue, 15 Nov 2022 08:47:48 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AF0liFD064621;
        Tue, 15 Nov 2022 08:47:44 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Tue, 15 Nov 2022 08:47:45 +0800 (CST)
Date:   Tue, 15 Nov 2022 08:47:45 +0800 (CST)
X-Zmail-TransId: 2afb6372e1b1ffffffffe7dbc722
X-Mailer: Zmail v1.0
Message-ID: <202211150847452601249@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <gregkh@linuxfoundation.org>
Cc:     <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
        <guo.ziliang@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGtlcm5mczogdXNlIHN0cnNjcHkoKSBpcyBtb3JlIHJvYnVzdCBhbmQgc2FmZXI=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AF0liFD064621
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 6372E1C8.000 by FangMail milter!
X-FangMail-Envelope: 1668473289/4NB6wn3BqszvLN/6372E1C8.000/10.35.20.121/[10.35.20.121]/mxde.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6372E1C8.000/4NB6wn3BqszvLN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guo ziliang <guo.ziliang@zte.com.cn>

The implementation of strscpy() is more robust and safer.  That's now the
recommended way to copy NUL terminated strings.

Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
---
 fs/kernfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 77d7a3a..fbb8df4 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -844,7 +844,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,

        spin_lock_irq(&kernfs_pr_cont_lock);

-       len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
+       len = strscpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));

        if (len >= sizeof(kernfs_pr_cont_buf)) {
                spin_unlock_irq(&kernfs_pr_cont_lock);
--
1.8.3.1
