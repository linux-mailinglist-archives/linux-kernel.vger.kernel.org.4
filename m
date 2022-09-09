Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A495B2F47
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiIIGvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIIGu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:50:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1DC1023FD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:50:58 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MP65K0Kq7znVDq;
        Fri,  9 Sep 2022 14:48:21 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:50:56 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <shaggy@kernel.org>, <dave.kleikamp@oracle.com>,
        <cuigaosheng1@huawei.com>
CC:     <jfs-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] jfs: remove unused declarations for jfs
Date:   Fri, 9 Sep 2022 14:50:55 +0800
Message-ID: <20220909065055.1154080-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

extRealloc(), xtRelocate(), xtDelete() and extFill() have been
removed since commit e471e5942c00 ("fs/jfs: Remove dead code"),
so remove them.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 fs/jfs/jfs_extent.h | 2 --
 fs/jfs/jfs_xtree.h  | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/fs/jfs/jfs_extent.h b/fs/jfs/jfs_extent.h
index 1c984214e95e..a0ee4ccea66e 100644
--- a/fs/jfs/jfs_extent.h
+++ b/fs/jfs/jfs_extent.h
@@ -10,9 +10,7 @@
 	(addressPXD(&(JFS_IP(ip)->ixpxd)) + lengthPXD(&(JFS_IP(ip)->ixpxd)) - 1)
 
 extern int	extAlloc(struct inode *, s64, s64, xad_t *, bool);
-extern int	extFill(struct inode *, xad_t *);
 extern int	extHint(struct inode *, s64, xad_t *);
-extern int	extRealloc(struct inode *, s64, xad_t *, bool);
 extern int	extRecord(struct inode *, xad_t *);
 
 #endif	/* _H_JFS_EXTENT */
diff --git a/fs/jfs/jfs_xtree.h b/fs/jfs/jfs_xtree.h
index 142caafc73b1..ad7592191d76 100644
--- a/fs/jfs/jfs_xtree.h
+++ b/fs/jfs/jfs_xtree.h
@@ -96,12 +96,8 @@ extern int xtInsert(tid_t tid, struct inode *ip,
 extern int xtExtend(tid_t tid, struct inode *ip, s64 xoff, int xlen,
 		    int flag);
 extern int xtUpdate(tid_t tid, struct inode *ip, struct xad *nxad);
-extern int xtDelete(tid_t tid, struct inode *ip, s64 xoff, int xlen,
-		    int flag);
 extern s64 xtTruncate(tid_t tid, struct inode *ip, s64 newsize, int type);
 extern s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size);
-extern int xtRelocate(tid_t tid, struct inode *ip,
-		      xad_t * oxad, s64 nxaddr, int xtype);
 extern int xtAppend(tid_t tid,
 		    struct inode *ip, int xflag, s64 xoff, int maxblocks,
 		    int *xlenp, s64 * xaddrp, int flag);
-- 
2.25.1

