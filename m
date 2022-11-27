Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD981639AB9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiK0M7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiK0M7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:59:36 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51695DF17
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:59:31 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id zHFnoti5vMQZVzHFno01E7; Sun, 27 Nov 2022 13:59:29 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Nov 2022 13:59:29 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH] 9p: Remove some unneeded #include
Date:   Sun, 27 Nov 2022 13:59:25 +0100
Message-Id: <3d1e0ed9714eaee7e18d9f5b0b4bfa49b00b286d.1669553950.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 9p fs does not use IDR or IDA functionalities. So there is no point in
including <linux/idr.h>.
Remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/9p/fid.c            | 1 -
 fs/9p/v9fs.c           | 1 -
 fs/9p/vfs_addr.c       | 1 -
 fs/9p/vfs_dentry.c     | 1 -
 fs/9p/vfs_dir.c        | 1 -
 fs/9p/vfs_file.c       | 1 -
 fs/9p/vfs_inode.c      | 1 -
 fs/9p/vfs_inode_dotl.c | 1 -
 fs/9p/vfs_super.c      | 1 -
 9 files changed, 9 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 23cf9b2fbfe4..805151114e96 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -11,7 +11,6 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/idr.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 0129de2ea31a..3a9c4517265f 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -14,7 +14,6 @@
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/parser.h>
-#include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
 #include <net/9p/9p.h>
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 47b9a1122f34..93373486ab04 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <linux/inet.h>
 #include <linux/pagemap.h>
-#include <linux/idr.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
 #include <linux/uio.h>
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index f89f01734587..65fa2df5e49b 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -15,7 +15,6 @@
 #include <linux/string.h>
 #include <linux/inet.h>
 #include <linux/namei.h>
-#include <linux/idr.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <net/9p/9p.h>
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 000fbaae9b18..1675a196c2ba 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/inet.h>
-#include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/fscache.h>
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index aec43ba83799..b740017634ef 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -18,7 +18,6 @@
 #include <linux/pagemap.h>
 #include <linux/utsname.h>
 #include <linux/uaccess.h>
-#include <linux/idr.h>
 #include <linux/uio.h>
 #include <linux/slab.h>
 #include <net/9p/9p.h>
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 4d1a4a8d9277..27a04a226d97 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -17,7 +17,6 @@
 #include <linux/string.h>
 #include <linux/inet.h>
 #include <linux/namei.h>
-#include <linux/idr.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/xattr.h>
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 03c1743c4aff..f806b3f11649 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -15,7 +15,6 @@
 #include <linux/string.h>
 #include <linux/inet.h>
 #include <linux/namei.h>
-#include <linux/idr.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/xattr.h>
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 2d9ee073d12c..266c4693e20c 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -15,7 +15,6 @@
 #include <linux/inet.h>
 #include <linux/pagemap.h>
 #include <linux/mount.h>
-#include <linux/idr.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/statfs.h>
-- 
2.34.1

