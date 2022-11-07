Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09B761E880
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 03:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKGCEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 21:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKGCEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:04:11 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 911A0A455;
        Sun,  6 Nov 2022 18:04:10 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E8CC71E80CE5;
        Mon,  7 Nov 2022 10:01:49 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xn8leCsuRSGg; Mon,  7 Nov 2022 10:01:47 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id AE72D1E80D9D;
        Mon,  7 Nov 2022 10:01:46 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     code@tyhicks.com, sforshee@digitalocean.com, brauner@kernel.org,
        amir73il@gmail.com
Cc:     ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] ecryptfs: main: Remove unnecessary (void*) conversions
Date:   Mon,  7 Nov 2022 10:04:04 +0800
Message-Id: <20221107020404.3380-1-zeming@nfschina.com>
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
 fs/ecryptfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2dd23a82e0de..3e499207d4c6 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -649,7 +649,7 @@ MODULE_ALIAS_FS("ecryptfs");
 static void
 inode_info_init_once(void *vptr)
 {
-	struct ecryptfs_inode_info *ei = (struct ecryptfs_inode_info *)vptr;
+	struct ecryptfs_inode_info *ei = vptr;
 
 	inode_init_once(&ei->vfs_inode);
 }
-- 
2.18.2

