Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7348B605B86
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJTJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJTJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:51:28 -0400
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC7115D0A9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:51:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 537A3604F5;
        Thu, 20 Oct 2022 11:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666259475; bh=LjJuL9IH78BZ6fEbIHO45nkq29mnvQS02U3sloS4zUk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zkKymqJ5LqkG//PVvcK0pmiZgZXFTBmteUGBaBWpgAH0LSPYjxgYr78rMEwe4XdSk
         xCxVlxV2rqHrQrisDpBEZAi92Eb47Uknh4EAaDKZhm1dWR6ywZ0oACTwzulWKlPp7N
         IYpxEITDqUZcaQA4oSYvg2An+M9lVBC50pzfwSuLhA2KTBpnznM8v7fNhaY7tR9XCK
         ZvrlqGoEgS8QDrqDhUhZLg4FlZHSqbXlXL9A9eQ9iUQjnJnlLOq8Jusp33fbZZnyF2
         p7cgIo53FzyviSjG+3EYhBFn7jjguPyk3R+zfKgi2fEIpo1RwX05wViPyLPDgXP0c4
         zqywRKvCR3p+g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7GAhUvRuT_dh; Thu, 20 Oct 2022 11:51:12 +0200 (CEST)
Received: from [192.168.223.51] (unknown [95.168.107.19])
        by domac.alu.hr (Postfix) with ESMTPSA id 76530604EC;
        Thu, 20 Oct 2022 11:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666259472; bh=LjJuL9IH78BZ6fEbIHO45nkq29mnvQS02U3sloS4zUk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fbrD5O9Jrwh/gWCBcSQ56oWj6/yvYix2OksPo+SsurjGzdwe/ZPRJlpH+U9EWjBv2
         Z7GKZV/4glMJhw2h1rc+btFpBmbgFIuoJ4+iFJkghpVEpE84LudsZWbPqOkNJCgSif
         z+27STGcJmh00x1qq8diuVpIeM4sUGdgJ3TCBecdWadObvJyYU0tbnKCRI82xtUFod
         24nP5cBNn5gS65IGtNGcW4sH4OAwbV+r3XDxPqiGaHKiZ17zXaHBXLAT5tCvglQ/Ma
         ZRxvZ2JCVfv8uDefdV5/sKdEjnzIW4XbnODE8ImhcPgDHvLNVt5asm4c/GjmUeLaGi
         SSMGOzJ5mDITA==
Message-ID: <b884a2f9-745e-158d-a96d-a79240ddbcff@alu.unizg.hr>
Date:   Thu, 20 Oct 2022 11:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Jintao Yin <nicememory@gmail.com>, phillip@squashfs.org.uk
Cc:     bagasdotme@gmail.com, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        srw@sladewatkins.net
References: <20221018174157.1897-1-phillip@squashfs.org.uk>
 <20221020074341.1431-1-nicememory@gmail.com>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20221020074341.1431-1-nicememory@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 10. 2022. 09:43, Jintao Yin wrote:

> Ignore my before diff. I didn't notice the end_index caculation greater
> than file_end part. Use the following diff instead.
>
> This diff is based on Phillip's latest two patches and improves the logic
> to update the status of pages only if page actor touches them.
>
> Please help test and feedbacks are welcome.
>
> Thanks,
>
> Jintao
>
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index e56510964b22..5efa2a9f9630 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -506,8 +506,9 @@ static int squashfs_readahead_fragment(struct page **page,
>   		squashfs_i(inode)->fragment_size);
>   	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>   	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> +	int res = buffer->error;
>   
> -	if (buffer->error)
> +	if (res)
>   		goto out;
>   
>   	expected += squashfs_i(inode)->fragment_offset;
> @@ -529,7 +530,7 @@ static int squashfs_readahead_fragment(struct page **page,
>   
>   out:
>   	squashfs_cache_put(buffer);
> -	return buffer->error;
> +	return res;
>   }
>   
>   static void squashfs_readahead(struct readahead_control *ractl)
> @@ -557,6 +558,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
>   		int res, bsize;
>   		u64 block = 0;
>   		unsigned int expected;
> +		int nr_used_pages;
>   
>   		nr_pages = __readahead_batch(ractl, pages, max_pages);
>   		if (!nr_pages)
> @@ -593,18 +595,18 @@ static void squashfs_readahead(struct readahead_control *ractl)
>   
>   		res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
>   
> -		squashfs_page_actor_free(actor);
> +		nr_used_pages = squashfs_page_actor_free(actor);
>   
>   		if (res == expected) {
>   			int bytes;
>   
>   			/* Last page (if present) may have trailing bytes not filled */
>   			bytes = res % PAGE_SIZE;
> -			if (pages[nr_pages - 1]->index == file_end && bytes)
> -				memzero_page(pages[nr_pages - 1], bytes,
> +			if (index == file_end && bytes && nr_used_pages > 0)
> +				memzero_page(pages[nr_used_pages - 1], bytes,
>   					     PAGE_SIZE - bytes);
>   
> -			for (i = 0; i < nr_pages; i++) {
> +			for (i = 0; i < nr_used_pages; i++) {
>   				flush_dcache_page(pages[i]);
>   				SetPageUptodate(pages[i]);
>   			}
> diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
> index f1ccad519e28..1bb0347f98b0 100644
> --- a/fs/squashfs/file_direct.c
> +++ b/fs/squashfs/file_direct.c
> @@ -30,10 +30,9 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
>   	int start_index = target_page->index & ~mask;
>   	int end_index = start_index | mask;
> -	int i, n, pages, bytes, res = -ENOMEM;
> +	int i, n, pages, used_pages, bytes, res = -ENOMEM;
>   	struct page **page;
>   	struct squashfs_page_actor *actor;
> -	void *pageaddr;
>   
>   	if (end_index > file_end)
>   		end_index = file_end;
> @@ -74,7 +73,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   	/* Decompress directly into the page cache buffers */
>   	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
>   
> -	squashfs_page_actor_free(actor);
> +	used_pages = squashfs_page_actor_free(actor);
>   
>   	if (res < 0)
>   		goto mark_errored;
> @@ -86,16 +85,18 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   
>   	/* Last page (if present) may have trailing bytes not filled */
>   	bytes = res % PAGE_SIZE;
> -	if (page[pages - 1]->index == end_index && bytes) {
> -		pageaddr = kmap_local_page(page[pages - 1]);
> -		memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> -		kunmap_local(pageaddr);
> +	if (used_pages > 0 && page[used_pages - 1]->index == end_index &&
> +	    bytes) {
> +		memzero_page(page[used_pages - 1], bytes,
> +			     PAGE_SIZE - bytes);
>   	}
>   
>   	/* Mark pages as uptodate, unlock and release */
>   	for (i = 0; i < pages; i++) {
> -		flush_dcache_page(page[i]);
> -		SetPageUptodate(page[i]);
> +		if (i < used_pages) {
> +			flush_dcache_page(page[i]);
> +			SetPageUptodate(page[i]);
> +		}
>   		unlock_page(page[i]);
>   		if (page[i] != target_page)
>   			put_page(page[i]);
> @@ -112,8 +113,10 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   	for (i = 0; i < pages; i++) {
>   		if (page[i] == NULL || page[i] == target_page)
>   			continue;
> -		flush_dcache_page(page[i]);
> -		SetPageError(page[i]);
> +		if (i < used_pages) {
> +			flush_dcache_page(page[i]);
> +			SetPageError(page[i]);
> +		}
>   		unlock_page(page[i]);
>   		put_page(page[i]);
>   	}
> diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
> index 95ffbb543d91..c2c5c3937ef9 100644
> --- a/fs/squashfs/page_actor.h
> +++ b/fs/squashfs/page_actor.h
> @@ -29,10 +29,12 @@ extern struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
>   extern struct squashfs_page_actor *squashfs_page_actor_init_special(
>   				struct squashfs_sb_info *msblk,
>   				struct page **page, int pages, int length);
> -static inline void squashfs_page_actor_free(struct squashfs_page_actor *actor)
> +static inline int squashfs_page_actor_free(struct squashfs_page_actor *actor)
>   {
> +	int res = actor->next_page;
>   	kfree(actor->tmp_buffer);
>   	kfree(actor);
> +	return res;
>   }
>   static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
>   {
Sorry to have disappointing news: vanilla mainline stable branch v6.0.2 
kernel + your latest patch
doesn't run well with my test case of firefox windows and tabs (other 
kernel versions start it OK).

What I got was:

Oct 20 11:46:50 marvin-IdeaPad-3-15ITL6 kernel: [  213.292487] 
desktop-launch[4687]: segfault at 8 ip 00007f5dc6c38f29 sp 
00007ffdb5429470 error 4 in ld-2.31.so[7f5dc6c27000+23000]
Oct 20 11:46:50 marvin-IdeaPad-3-15ITL6 kernel: [  213.292506] Code: 8b 
44 24 08 4c 8b 40 08 41 80 38 00 75 18 48 8b 05 ec a6 01 00 4c 8b 00 48 
8d 05 74 21 01 00 4d 85 c0 4c 0f 44 c0 48 8b 45 68 <48> 8b 40 08 48 89 
04 24 48 8d 05 e8 a6 01 00 f6 00 10 0f 85 c7 01

I think we're getting somewhere.

Did I understand well that your patch replaced both Phillip's patches?

Thank you.

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

