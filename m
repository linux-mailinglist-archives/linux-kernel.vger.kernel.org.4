Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662B4623C74
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiKJHP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiKJHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:12:53 -0500
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA52B31EE2;
        Wed,  9 Nov 2022 23:12:18 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 154DC1E80D9C;
        Thu, 10 Nov 2022 15:09:42 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UnqlKQPIieaq; Thu, 10 Nov 2022 15:09:39 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id E76DB1E80D87;
        Thu, 10 Nov 2022 15:09:38 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     agruenba@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] pid: fix spelling mistake "alreay" -> "already"
Date:   Thu, 10 Nov 2022 15:11:26 +0800
Message-Id: <20221110071126.6706-1-yuzhe@nfschina.com>
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
 kernel/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 3fbc5e46b721..f68b9c5ee469 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -213,7 +213,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 				       tid + 1, GFP_ATOMIC);
 			/*
 			 * If ENOSPC is returned it means that the PID is
-			 * alreay in use. Return EEXIST in that case.
+			 * already in use. Return EEXIST in that case.
 			 */
 			if (nr == -ENOSPC)
 				nr = -EEXIST;
-- 
2.11.0

