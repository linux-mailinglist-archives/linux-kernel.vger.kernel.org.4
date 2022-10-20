Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A696063B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJTPA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJTPAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:00:54 -0400
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2432DCE9E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:00:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id D3B92604F5;
        Thu, 20 Oct 2022 17:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1666278047; bh=TuSnf7VH/47hLkihlYDkdztyFdIkxL/zMa9kMI+xFkE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZR40tnarJk1hlm9GzeXOk1DjYtO7zmkQ+47Y9CN/GAATNboHy/44NGPlZc6jOLjB8
         UhbWsSjidDeX2D3hWDEWLtuGs6raClBORgF5e0HA1NRaRDF10Mxjie0m+BLXCkNROb
         e9V81RUKOBx+nlM9VOoCXtSX9TU7W2VkYWTqOD1h8ejr2VysjviRPlte1vsO/N/IKX
         NSYpod561SPayBoIS8GNy3+0mFitoid7ZrUIu7OjRcoX7wJrL6Lb21wzQgskj6SIty
         4EQ2qoS7Af+0Age5j3cSVMVgaNViUFCMjWBfJ49WJcOmcY5kRF8d6PAxOiQfbE7zfc
         CsHQ2Z2dT1CmQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FrEaZlACrjSK; Thu, 20 Oct 2022 17:00:44 +0200 (CEST)
Received: from [193.198.186.200] (PC-MTODOROV.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 376E9604EC;
        Thu, 20 Oct 2022 17:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1666278044; bh=TuSnf7VH/47hLkihlYDkdztyFdIkxL/zMa9kMI+xFkE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EejsfYpodQwot8WAzX0A/xSMDzJYCyUqXvHFea40jMtGBwUwobV3SNBXuSLB1KLf1
         KnLrLxirSsWEU/mm+RPmX0MV011UtLdu+Djnsl2V/OfhzU33BxFwSu+XmXJU6uSTBL
         UFTTO7PpWILQQYxRX5oFDeRB8DmaGgvrUn9ehTvuPMt4oc/aOoYSjtifJXe3UxA0kP
         TSww8emD0RzXjbcK2D+67qzIkC8s4/Lrl9KxffTosQaguM5VSgnFhAbFxu/x7Mf70Q
         TlCQlZa0VA0FTd+VJ/j6obz70nZHzxd37DiO5TkyOiUTuxqxzGSJCNNfTJJ6kpCJ6q
         VHEXZDndtMOWw==
Message-ID: <2858b6db-b3ff-b64a-1360-d65522ea3631@alu.hr>
Date:   Thu, 20 Oct 2022 17:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
To:     Jintao Yin <nicememory@gmail.com>, phillip@squashfs.org.uk
Cc:     bagasdotme@gmail.com, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        mirsad.todorovac@alu.unizg.hr, regressions@leemhuis.info,
        regressions@lists.linux.dev, srw@sladewatkins.net
References: <20221018174157.1897-1-phillip@squashfs.org.uk>
 <20221020135545.586-1-nicememory@gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <20221020135545.586-1-nicememory@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/2022 3:55 PM, Jintao Yin wrote:
> Hi all,
>
> After review the details of page actor, the tail bytes may be written to
> a temp buffer instead the last used page. So before diff would wrongly
> memzero a page which is not the tail bytes in.
>
> In this diff fixes it by caculation of the real index the trailing bytes
> in and check if the last used page matches this index. If the page is
> the real tail bytes in, then memzero the trailing bypte of the page.
>
> Please help test and any feedbacks are welcome.
>
> Thanks,
>
> Jintao

Hi, Jintao,

Now you've obviously fixed something, as I get no core dumps, but manage 
to start/stop
Firefox with the bug reproduction set of windows and tabs.

Congratulations, but I still need a couple of hours of testing before 
saying anything conclusive.

Thanks.

Mirsad

> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index e56510964b22..e1fafd10a850 100644
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
> @@ -593,18 +595,21 @@ static void squashfs_readahead(struct readahead_control *ractl)
>   
>   		res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
>   
> -		squashfs_page_actor_free(actor);
> +		nr_used_pages = squashfs_page_actor_free(actor);
>   
>   		if (res == expected) {
>   			int bytes;
> +			pgoff_t bytes_index;
>   
>   			/* Last page (if present) may have trailing bytes not filled */
>   			bytes = res % PAGE_SIZE;
> -			if (pages[nr_pages - 1]->index == file_end && bytes)
> -				memzero_page(pages[nr_pages - 1], bytes,
> +			bytes_index = (index << shift) + ((res - bytes) >> PAGE_SHIFT);
> +			if (bytes && nr_used_pages > 0 &&
> +				pages[nr_used_pages - 1]->index == bytes_index)
> +				memzero_page(pages[nr_used_pages - 1], bytes,
>   					     PAGE_SIZE - bytes);
>   
> -			for (i = 0; i < nr_pages; i++) {
> +			for (i = 0; i < nr_used_pages; i++) {
>   				flush_dcache_page(pages[i]);
>   				SetPageUptodate(pages[i]);
>   			}
> diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
> index f1ccad519e28..ee462ef380bf 100644
> --- a/fs/squashfs/file_direct.c
> +++ b/fs/squashfs/file_direct.c
> @@ -26,14 +26,14 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   	struct inode *inode = target_page->mapping->host;
>   	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>   
> -	int file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
> -	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> -	int start_index = target_page->index & ~mask;
> -	int end_index = start_index | mask;
> -	int i, n, pages, bytes, res = -ENOMEM;
> +	pgoff_t file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
> +	pgoff_t mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> +	pgoff_t start_index = target_page->index & ~mask;
> +	pgoff_t end_index = start_index | mask;
> +	int i, pages, used_pages, bytes, res = -ENOMEM;
> +	pgoff_t n, bytes_index;
>   	struct page **page;
>   	struct squashfs_page_actor *actor;
> -	void *pageaddr;
>   
>   	if (end_index > file_end)
>   		end_index = file_end;
> @@ -74,7 +74,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   	/* Decompress directly into the page cache buffers */
>   	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
>   
> -	squashfs_page_actor_free(actor);
> +	used_pages = squashfs_page_actor_free(actor);
>   
>   	if (res < 0)
>   		goto mark_errored;
> @@ -86,16 +86,19 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   
>   	/* Last page (if present) may have trailing bytes not filled */
>   	bytes = res % PAGE_SIZE;
> -	if (page[pages - 1]->index == end_index && bytes) {
> -		pageaddr = kmap_local_page(page[pages - 1]);
> -		memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> -		kunmap_local(pageaddr);
> +	bytes_index = start_index + ((res - bytes) >> PAGE_SHIFT);
> +	if (used_pages > 0 && bytes &&
> +		page[used_pages - 1]->index == bytes_index) {
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
> @@ -112,8 +115,10 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
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

-- 
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
--
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355

