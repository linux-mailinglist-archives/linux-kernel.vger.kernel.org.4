Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B42A6058ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiJTHpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJTHoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:44:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F55260C9E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:44:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f23so19564907plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31xLf1EgDc/7pNYCx0W1lRbF7B/2EJqpAJLAQFhU4pA=;
        b=hLZ4EDHn5e5XKZLeVGdrJAxjgo2nZdTH5hCZVq++yfNJpdyURRh6RvJVYPnshCuETM
         yzWst8Wr1L1rKs70jLRlXhn5/rW6rs6eHGj4cgRdm3N8hDycDu6O1nnAoxQJdXAHyXGj
         9lvhJYF5QStHcFV1dpQAph1WG3XbUgDkrBie+PSgBxA5Qjg9BeeXtO/JPrxbu3llWV5Y
         J6Qr2uQeN5X05z2wvsLuDgAz41JRfA7SAAMBc8RQ/qfO/NC5xm2FdIEGPTxZlWzHaWk6
         m7RMvWkJlz5vynYQ+il2NOTNduCoukyO91HcQ+NmgBqKY4iIaK3catuedAhdRLCMKhHi
         08Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31xLf1EgDc/7pNYCx0W1lRbF7B/2EJqpAJLAQFhU4pA=;
        b=uGHscidH302jxg5T4h+u1tt/txdPf2EtfP1dJIsAfh+6I6cWHKxQlJ3uL1TXAEsMqF
         9h7KQRPXqqRZoCLE/9KTz8HmlGp/8V99X+u0sW0dDcNNrfGklDOVL7TfBbaSRi2WVkO/
         BuftDD2EwXJ3kbPt4PrA9/8TaSh9YE4QanaEPcwd77Vcne/IuIt4RRhqAxYEzB4j3YVJ
         8dzMIyNqFhDLtFqgLhT0sosAsH5WQxdbvvGgP7IvmpRUqRv2Oseivi8haly4X/kemKJB
         9n8xIk/7nWIAriWFNpoC25k2a93JSDvfewGmGVpogWRdJrO3hTZ2kUNZdfw50WNffCZ/
         PjeA==
X-Gm-Message-State: ACrzQf0LhKq5AWzKNyePVJHouWC7yiR+TZAT7yTvJieRqm2/pV7tk/h4
        mXOTK/GzmNygWVunaX7Raoo=
X-Google-Smtp-Source: AMsMyM7wVOs3/7Syx3s4A6kSKGsTiOR9rIICIzDAw8ID7n1gMa/+w8G6qbSELt1FYXzFqfVchbnDSA==
X-Received: by 2002:a17:902:e845:b0:184:8078:be88 with SMTP id t5-20020a170902e84500b001848078be88mr12550001plg.99.1666251886432;
        Thu, 20 Oct 2022 00:44:46 -0700 (PDT)
Received: from localhost.localdomain ([111.203.234.211])
        by smtp.googlemail.com with ESMTPSA id m5-20020a17090a668500b002008d0e5cb5sm614278pjj.47.2022.10.20.00.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 00:44:46 -0700 (PDT)
From:   Jintao Yin <nicememory@gmail.com>
To:     phillip@squashfs.org.uk
Cc:     bagasdotme@gmail.com, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        mirsad.todorovac@alu.unizg.hr, nicememory@gmail.com,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        srw@sladewatkins.net
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through 6.0.0-rc7
Date:   Thu, 20 Oct 2022 15:43:41 +0800
Message-Id: <20221020074341.1431-1-nicememory@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Ignore my before diff. I didn't notice the end_index caculation greater
than file_end part. Use the following diff instead.

This diff is based on Phillip's latest two patches and improves the logic
to update the status of pages only if page actor touches them.

Please help test and feedbacks are welcome.

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
index f1ccad519e28..1bb0347f98b0 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -30,10 +30,9 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
 	int start_index = target_page->index & ~mask;
 	int end_index = start_index | mask;
-	int i, n, pages, bytes, res = -ENOMEM;
+	int i, n, pages, used_pages, bytes, res = -ENOMEM;
 	struct page **page;
 	struct squashfs_page_actor *actor;
-	void *pageaddr;
 
 	if (end_index > file_end)
 		end_index = file_end;
@@ -74,7 +73,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	/* Decompress directly into the page cache buffers */
 	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
 
-	squashfs_page_actor_free(actor);
+	used_pages = squashfs_page_actor_free(actor);
 
 	if (res < 0)
 		goto mark_errored;
@@ -86,16 +85,18 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 
 	/* Last page (if present) may have trailing bytes not filled */
 	bytes = res % PAGE_SIZE;
-	if (page[pages - 1]->index == end_index && bytes) {
-		pageaddr = kmap_local_page(page[pages - 1]);
-		memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
-		kunmap_local(pageaddr);
+	if (used_pages > 0 && page[used_pages - 1]->index == end_index &&
+	    bytes) {
+		memzero_page(page[used_pages - 1], bytes,
+			     PAGE_SIZE - bytes);
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
@@ -112,8 +113,10 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
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
