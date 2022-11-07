Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1061E876
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiKGB5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiKGB5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:57:06 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7228363CC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 17:57:05 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id AF2441E80D89;
        Mon,  7 Nov 2022 09:54:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s7qn6hQCpt30; Mon,  7 Nov 2022 09:54:41 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 81A841E80D87;
        Mon,  7 Nov 2022 09:54:41 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] hugetlbfs: inode: Remove unnecessary (void*) conversions
Date:   Mon,  7 Nov 2022 09:56:59 +0800
Message-Id: <20221107015659.3221-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ei pointer does not need to cast the type.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f7a5b5124d8a..0728531992a2 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1160,7 +1160,7 @@ static const struct address_space_operations hugetlbfs_aops = {
 
 static void init_once(void *foo)
 {
-	struct hugetlbfs_inode_info *ei = (struct hugetlbfs_inode_info *)foo;
+	struct hugetlbfs_inode_info *ei = foo;
 
 	inode_init_once(&ei->vfs_inode);
 }
-- 
2.18.2

