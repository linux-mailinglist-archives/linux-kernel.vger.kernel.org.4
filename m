Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E691F6C5B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCWAKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCWAKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:10:33 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C8231BD2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 17:10:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VeRymBp_1679530191;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VeRymBp_1679530191)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 08:09:52 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] erofs: rename init_inode_xattrs with erofs_ prefix
Date:   Thu, 23 Mar 2023 08:09:43 +0800
Message-Id: <20230323000949.57608-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230323000949.57608-1-jefflexu@linux.alibaba.com>
References: <20230323000949.57608-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename init_inode_xattrs() to erofs_init_inode_xattrs() without logic
change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 760ec864a39c..ab4517e5ec84 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -29,7 +29,7 @@ struct xattr_iter {
 	unsigned int ofs;
 };
 
-static int init_inode_xattrs(struct inode *inode)
+static int erofs_init_inode_xattrs(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct xattr_iter it;
@@ -404,7 +404,7 @@ static int erofs_getxattr(struct inode *inode, int index, const char *name,
 	if (!name)
 		return -EINVAL;
 
-	ret = init_inode_xattrs(inode);
+	ret = erofs_init_inode_xattrs(inode);
 	if (ret)
 		return ret;
 
@@ -619,7 +619,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	int ret;
 	struct listxattr_iter it;
 
-	ret = init_inode_xattrs(d_inode(dentry));
+	ret = erofs_init_inode_xattrs(d_inode(dentry));
 	if (ret == -ENOATTR)
 		return 0;
 	if (ret)
-- 
2.19.1.6.gb485710b

