Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7009B623CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiKJHrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKJHri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:47:38 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E3CC38B7;
        Wed,  9 Nov 2022 23:47:37 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 38E341E80D74;
        Thu, 10 Nov 2022 15:45:01 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QfhxvQpyzoss; Thu, 10 Nov 2022 15:44:58 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 36B6D1E80D6D;
        Thu, 10 Nov 2022 15:44:58 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] fs/ntfs3: fix spelling mistake "attibute" -> "attribute"
Date:   Thu, 10 Nov 2022 15:46:40 +0800
Message-Id: <20221110074640.16792-1-yuzhe@nfschina.com>
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
 fs/ntfs3/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 7de8718c68a9..1ce8c0957621 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -376,7 +376,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 
 	/*
 	 * 1. Check ea_info.size_pack for overflow.
-	 * 2. New attibute size must fit value from $AttrDef
+	 * 2. New attribute size must fit value from $AttrDef
 	 */
 	if (new_pack > 0xffff || size > sbi->ea_max_size) {
 		ntfs_inode_warn(
-- 
2.11.0

