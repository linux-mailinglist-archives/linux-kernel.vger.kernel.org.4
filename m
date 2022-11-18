Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1990762F017
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbiKRIwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbiKRIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:52:11 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF194F2B;
        Fri, 18 Nov 2022 00:52:09 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 3BF1B1E80D82;
        Fri, 18 Nov 2022 16:48:56 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8TqIVJEq5iht; Fri, 18 Nov 2022 16:48:53 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 40C7A1E80D72;
        Fri, 18 Nov 2022 16:48:51 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     dwmw2@infradead.org, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] jffs2: fix spelling mistake "neccecary"->"necessary"
Date:   Fri, 18 Nov 2022 16:51:04 +0800
Message-Id: <20221118085104.19106-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in comment. Fix it.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 fs/jffs2/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 39cec28096a7..af433c4271ff 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -403,7 +403,7 @@ int jffs2_do_remount_fs(struct super_block *sb, struct fs_context *fc)
 	/* We stop if it was running, then restart if it needs to.
 	   This also catches the case where it was stopped and this
 	   is just a remount to restart it.
-	   Flush the writebuffer, if neccecary, else we loose it */
+	   Flush the writebuffer, if necessary, else we loose it */
 	if (!sb_rdonly(sb)) {
 		jffs2_stop_garbage_collect_thread(c);
 		mutex_lock(&c->alloc_sem);
-- 
2.11.0

