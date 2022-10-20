Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7073E6057CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJTHA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJTHAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:00:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBDD107CE1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:00:50 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s196so17117217pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6Twp7uqupA7cKAAQAI5q7h15HGpc5k+vG5y6VE0a6Y=;
        b=FovKRKTZn8KMohHQJ4hwLn/7GlKk3OXBN+oVAPYPtBM7diFdkDzB/fZLZSsJiTylvI
         FvGvGaKUQo+U6Oyige+KS5pvAZEL4nwjFFkn8Ec7m2XL6hwKWLOsUF+vjltoejRSFIAp
         dVSXoZud2/L2ejrxWKSbmvbjkjnWR+GvN5CCLvuB9NWeMtg4bQzl9hyUvUm9/aA2x0iH
         pnpRevEcmkmd4ZrBOP4/xMTbfTriJO6FJ0cqC+OVB+HpN+CCHbnMPhs0U105kfA59YJc
         iTS/QCVKX5gu7+OCBPLam09U3UNwFPPVO7TxXQk0kakVtMDHsm7dZiYv3l3vSvtsdhQe
         xWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6Twp7uqupA7cKAAQAI5q7h15HGpc5k+vG5y6VE0a6Y=;
        b=Cwpm8AcvXDOiGetwbyR6wD2bP1MjBZA60KpGYLv3IVERaCAUbMotplP4x9oosqv0kk
         +/Iwes81mD5S0yMM3YLi2rLXtWjvxs5LyThtk0hCldHztkFtm52CPgYESAFyd2azabEx
         h166+y2eOoYAT0o9es9ponvzfGfhxeRXbNHIerVRaIBZZd/wXLOnAc8L3LLCWDwppm1Z
         BiLSTn2IjfI2Eezpi/WJV2RH3JeHcdm1CrAh1cyPsQ36pWkf/6y0LQiViHfENc/kNsiR
         u4Fgp4mYNBqhIIeMxRpH6czS25JFm2lWo+ZpYpABmoanmofaW120gA9memgvXMQxSDxQ
         2E9A==
X-Gm-Message-State: ACrzQf3boyE14Sut5C2czQ5gKbbepEKyZLepYRqV+QiTZg7jOgq47kWy
        kX6zHQnA7jtEh1aHUfrUPqA=
X-Google-Smtp-Source: AMsMyM5wO2xm+MEn5lRlzCJa/K2DD4yWzaUon4J2ea2LCt8AegTrWyjaUHZ/qPMzPCMjZlFvN7rJVg==
X-Received: by 2002:a62:2983:0:b0:54e:7cd5:adb3 with SMTP id p125-20020a622983000000b0054e7cd5adb3mr12517198pfp.38.1666249249418;
        Thu, 20 Oct 2022 00:00:49 -0700 (PDT)
Received: from localhost.localdomain ([111.203.234.211])
        by smtp.googlemail.com with ESMTPSA id s21-20020a056a00195500b00562ef28aac6sm12733164pfk.185.2022.10.20.00.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 00:00:47 -0700 (PDT)
From:   Jintao Yin <nicememory@gmail.com>
To:     phillip@squashfs.org.uk
Cc:     bagasdotme@gmail.com, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        mirsad.todorovac@alu.unizg.hr, nicememory@gmail.com,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        srw@sladewatkins.net
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through 6.0.0-rc7
Date:   Thu, 20 Oct 2022 14:59:42 +0800
Message-Id: <20221020065942.1828-1-nicememory@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018174157.1897-1-phillip@squashfs.org.uk>
References: <20221018174157.1897-1-phillip@squashfs.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This diff is based on Phillip's latest two patches and fixes another wrong
check of last page in file_direct.c. At the same time, improve the logic
to update the status of pages only if page actor touches them.

Please help test and feedbacks are welcome.

Hi Phillip,

If check (bytes && used_pages > 0) is enough (since bytes is non-zero only
when handling the last block) or should I caculate the real last page index
from the file size and check the page index?

Thanks,

Jintao

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index e56510964b22..5efa2a9f9630 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -506,8 +506,9 @@ static int squashfs_readahead_fragment(struct page **page,
 		squashfs_i(inode)->fragment_size);
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
+	int res = buffer->error;
 
-	if (buffer->error)
+	if (res)
 		goto out;
 
 	expected += squashfs_i(inode)->fragment_offset;
@@ -529,7 +530,7 @@ static int squashfs_readahead_fragment(struct page **page,
 
 out:
 	squashfs_cache_put(buffer);
-	return buffer->error;
+	return res;
 }
 
 static void squashfs_readahead(struct readahead_control *ractl)
@@ -557,6 +558,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
 		int res, bsize;
 		u64 block = 0;
 		unsigned int expected;
+		int nr_used_pages;
 
 		nr_pages = __readahead_batch(ractl, pages, max_pages);
 		if (!nr_pages)
@@ -593,18 +595,18 @@ static void squashfs_readahead(struct readahead_control *ractl)
 
 		res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
 
-		squashfs_page_actor_free(actor);
+		nr_used_pages = squashfs_page_actor_free(actor);
 
 		if (res == expected) {
 			int bytes;
 
 			/* Last page (if present) may have trailing bytes not filled */
 			bytes = res % PAGE_SIZE;
-			if (pages[nr_pages - 1]->index == file_end && bytes)
-				memzero_page(pages[nr_pages - 1], bytes,
+			if (index == file_end && bytes && nr_used_pages > 0)
+				memzero_page(pages[nr_used_pages - 1], bytes,
 					     PAGE_SIZE - bytes);
 
-			for (i = 0; i < nr_pages; i++) {
+			for (i = 0; i < nr_used_pages; i++) {
 				flush_dcache_page(pages[i]);
 				SetPageUptodate(pages[i]);
 			}
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index f1ccad519e28..8d875d8c5709 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -30,7 +30,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
 	int start_index = target_page->index & ~mask;
 	int end_index = start_index | mask;
-	int i, n, pages, bytes, res = -ENOMEM;
+	int i, n, pages, used_pages, bytes, res = -ENOMEM;
 	struct page **page;
 	struct squashfs_page_actor *actor;
 	void *pageaddr;
@@ -74,7 +74,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	/* Decompress directly into the page cache buffers */
 	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
 
-	squashfs_page_actor_free(actor);
+	used_pages = squashfs_page_actor_free(actor);
 
 	if (res < 0)
 		goto mark_errored;
@@ -86,16 +86,18 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 
 	/* Last page (if present) may have trailing bytes not filled */
 	bytes = res % PAGE_SIZE;
-	if (page[pages - 1]->index == end_index && bytes) {
-		pageaddr = kmap_local_page(page[pages - 1]);
+	if (bytes && used_pages > 0) {
+		pageaddr = kmap_local_page(page[used_pages - 1]);
 		memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
 		kunmap_local(pageaddr);
 	}
 
 	/* Mark pages as uptodate, unlock and release */
 	for (i = 0; i < pages; i++) {
-		flush_dcache_page(page[i]);
-		SetPageUptodate(page[i]);
+		if (i < used_pages) {
+			flush_dcache_page(page[i]);
+			SetPageUptodate(page[i]);
+		}
 		unlock_page(page[i]);
 		if (page[i] != target_page)
 			put_page(page[i]);
@@ -112,8 +114,10 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	for (i = 0; i < pages; i++) {
 		if (page[i] == NULL || page[i] == target_page)
 			continue;
-		flush_dcache_page(page[i]);
-		SetPageError(page[i]);
+		if (i < used_pages) {
+			flush_dcache_page(page[i]);
+			SetPageError(page[i]);
+		}
 		unlock_page(page[i]);
 		put_page(page[i]);
 	}
diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
index 95ffbb543d91..c2c5c3937ef9 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -29,10 +29,12 @@ extern struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
 extern struct squashfs_page_actor *squashfs_page_actor_init_special(
 				struct squashfs_sb_info *msblk,
 				struct page **page, int pages, int length);
-static inline void squashfs_page_actor_free(struct squashfs_page_actor *actor)
+static inline int squashfs_page_actor_free(struct squashfs_page_actor *actor)
 {
+	int res = actor->next_page;
 	kfree(actor->tmp_buffer);
 	kfree(actor);
+	return res;
 }
 static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
 {
