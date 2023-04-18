Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534446E6B73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjDRRwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjDRRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:52:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A74C10E0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:52:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id hg12so13256115pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681840330; x=1684432330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ecJfBqabO7lqZzAX7J4vFKzXJzBbVDV46eKIKNvjRGA=;
        b=UuRVKbYHNO2+ypBmSsydrxG8hH0RsWKq/LU/ZHKXV3YRapO0ysKFvJSkROA9g7vm9B
         kLFt2FJPSyJKCbQOci0pY9obi5lV3WhsPGxGZCQOvGTRpPXXNfeJ+YiKMsoWUFYfYVVC
         brzT+MNq4jqVKJ0DhI5dCPneI/MVeL9HK+9+VVuccBxTEIyGtwUDbxfQFDizQEXMSGHS
         CC3WtzHnHWxWEoebWLZ+Squf20SfvvP28iI3yEsj8IvyblGco7JE/OvflzMQMJddtIWS
         VK92b2mxVVLsDvnzBJjk+35Ap9aTyT4X8bk/cmStc14JO8egcGxG0gNu7bYh+C/DLGPx
         LLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840330; x=1684432330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecJfBqabO7lqZzAX7J4vFKzXJzBbVDV46eKIKNvjRGA=;
        b=T1EK1LQE5c9zw2kD+05Zfu1GocXvgxq9U2JA5Trbibmn53U/KaivnTx1bkbgZJMK+X
         y4kNKv2NuaL8jQglw3Nw1gnJIT05RiK82qE/wnii+hm+SS8+vrYTgzNusxRkBgP6Z5SS
         DnMmXiUFjdzGlklW16ysRXXVsDn0mVWceOtELecSnu0YlTa8W2m/E25okNmf0prSXBEh
         sD7ZLmx0Zn+P6mObiZQlhYygtqiqWjjNuLRxLNl+qL/37PqhBt2GbE9m6MQILrX1sqo9
         fp34tjwZZyMxwEbg8Feucb5DmOcn1gqzx7tatBfoMoG73Hzgs7vxEV1ZmIWG329Csh5p
         DW1g==
X-Gm-Message-State: AAQBX9dw+PDuMfb+sO3H7hlmSSyPXsnh4ynMDKVI7FawYXQIjmS1Ty10
        lW+V5RaLs4YEqRFC38brWZGA0taqXKM=
X-Google-Smtp-Source: AKy350bRDp0Yo5TSKicloGZlgruDCfWjNghh4tbzOOhERT6f6BCtJkiJzdsOxSs6PKdY33rl8XzJIQ==
X-Received: by 2002:a05:6a20:a110:b0:ef:8b50:56b7 with SMTP id q16-20020a056a20a11000b000ef8b5056b7mr470860pzk.60.1681840330484;
        Tue, 18 Apr 2023 10:52:10 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:e22b:bd7c:4df6:1ae0])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090ac98300b00227223c58ecsm8881772pjt.42.2023.04.18.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:52:10 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: use cow inode data when updating atomic write
Date:   Tue, 18 Apr 2023 10:52:06 -0700
Message-ID: <20230418175206.3282328-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Need to use cow inode data content instead of the one in the original
inode, when we try to write the already updated atomic write files.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8df225014304..7165b1202f53 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3491,7 +3491,7 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
 
 static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 			struct page *page, loff_t pos, unsigned int len,
-			block_t *blk_addr, bool *node_changed)
+			block_t *blk_addr, bool *node_changed, bool *use_cow)
 {
 	struct inode *inode = page->mapping->host;
 	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
@@ -3505,10 +3505,12 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 
 	/* Look for the block in COW inode first */
 	err = __find_data_block(cow_inode, index, blk_addr);
-	if (err)
+	if (err) {
 		return err;
-	else if (*blk_addr != NULL_ADDR)
+	} else if (*blk_addr != NULL_ADDR) {
+		*use_cow = true;
 		return 0;
+	}
 
 	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
 		goto reserve_block;
@@ -3538,6 +3540,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	struct page *page = NULL;
 	pgoff_t index = ((unsigned long long) pos) >> PAGE_SHIFT;
 	bool need_balance = false;
+	bool use_cow = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
@@ -3597,7 +3600,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	if (f2fs_is_atomic_file(inode))
 		err = prepare_atomic_write_begin(sbi, page, pos, len,
-					&blkaddr, &need_balance);
+					&blkaddr, &need_balance, &use_cow);
 	else
 		err = prepare_write_begin(sbi, page, pos, len,
 					&blkaddr, &need_balance);
@@ -3637,7 +3640,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			goto fail;
 		}
-		err = f2fs_submit_page_read(inode, page, blkaddr, 0, true);
+		err = f2fs_submit_page_read(use_cow ?
+				F2FS_I(inode)->cow_inode : inode, page,
+				blkaddr, 0, true);
 		if (err)
 			goto fail;
 
-- 
2.40.0.634.g4ca3ef3211-goog

