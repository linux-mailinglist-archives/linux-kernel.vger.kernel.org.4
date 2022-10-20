Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31936060DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiJTNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJTNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:02:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D69658048
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:02:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r18so19132340pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyZV+5dHPEm9y2grR1cTVbSv6PIoW3rFM516q3trw+c=;
        b=hYsLr5so2u6zRKph8E5hlUdCPTFdmUEsuA+JUsFndgKNpB1tZEOigIt6Rb/5RoRPHt
         qKpNsT7hDrl61cITpT4k1OU7+QEIKd1bIkS5tE0+jeAmZ+ta0MGZpGWQ9TuBvz+EHo9m
         vwrzgPNKcHCHHquWxkD+f3MJp9QtesaVsHA4GInnePmjyAZhdH5+8A0hCE6KT2ndRaTs
         YOQ2BSXjvUq5WrfllUi2hwkxbafEjXe9zwBBHqmwNP6A65ZGoZArI9QRDLhpdWKygAh6
         T/v0BhTH8swSJF3G3kiGzUpH2vZAH4pDJxG5iYMsCx0NDoupeUSEbza2bAgOHsA47UEv
         Y4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyZV+5dHPEm9y2grR1cTVbSv6PIoW3rFM516q3trw+c=;
        b=fmywQZO+RmuL7Aueuwo6sb6qf0HRbnyiiW+5pxEUReJ3/+VCvvYfL5WgCe4mkiSDMk
         W/2cEDBxf6IO2KPpRjhADcEisK46rH6vb1ffJUmewl3hNe/EcBv8/GiTHWpYQjMLzAtU
         BqroP5yUeOt+4a6/a/wm805hIb1ujaCEGbL9buE8AiNIM0juZ/GD0OCFoql73HQ6nfj8
         jQ9LbOd8Bj0UWivq3/Z/CBcWAC9xufZd9RV22D0O6STJRBq8TAiYPcTisj6+JRirxGiN
         Q7/XecRtKqA+kiAtMbr48Q9cTtNqFALI94txyNxuPL9KV92jWSIKWDeMDb+ZysTFwE/Z
         wnYg==
X-Gm-Message-State: ACrzQf0XlWsZmPGJOlxCZfWSsbTCOt3Tiz1TMJcvyeKmLzPj8F49W2t7
        rqNtP/iL44Lgz29NXXELMbk=
X-Google-Smtp-Source: AMsMyM46qEZekBEhBsL2rQCglZLJDHG7q8ndkFW/p46TQddKcn21DGoW5OUV0AiB9/w7YBS/i3nxOA==
X-Received: by 2002:a63:7e4d:0:b0:43c:8ce9:2a9f with SMTP id o13-20020a637e4d000000b0043c8ce92a9fmr11471320pgn.528.1666270928509;
        Thu, 20 Oct 2022 06:02:08 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-50.three.co.id. [116.206.12.50])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0017300ec80b0sm12655901plk.308.2022.10.20.06.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:02:08 -0700 (PDT)
Message-ID: <9e2e61c9-9d01-bb3a-1dc5-2f48fa7d94cd@gmail.com>
Date:   Thu, 20 Oct 2022 20:02:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
To:     Jintao Yin <nicememory@gmail.com>, phillip@squashfs.org.uk
Cc:     hsinyi@chromium.org, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, mirsad.todorovac@alu.unizg.hr,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        srw@sladewatkins.net
References: <20221018174157.1897-1-phillip@squashfs.org.uk>
 <20221020074341.1431-1-nicememory@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221020074341.1431-1-nicememory@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 14:43, Jintao Yin wrote:
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
>  		squashfs_i(inode)->fragment_size);
>  	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>  	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> +	int res = buffer->error;
>  
> -	if (buffer->error)
> +	if (res)
>  		goto out;
>  
>  	expected += squashfs_i(inode)->fragment_offset;
> @@ -529,7 +530,7 @@ static int squashfs_readahead_fragment(struct page **page,
>  
>  out:
>  	squashfs_cache_put(buffer);
> -	return buffer->error;
> +	return res;
>  }
>  
>  static void squashfs_readahead(struct readahead_control *ractl)
> @@ -557,6 +558,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
>  		int res, bsize;
>  		u64 block = 0;
>  		unsigned int expected;
> +		int nr_used_pages;
>  
>  		nr_pages = __readahead_batch(ractl, pages, max_pages);
>  		if (!nr_pages)
> @@ -593,18 +595,18 @@ static void squashfs_readahead(struct readahead_control *ractl)
>  
>  		res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
>  
> -		squashfs_page_actor_free(actor);
> +		nr_used_pages = squashfs_page_actor_free(actor);
>  
>  		if (res == expected) {
>  			int bytes;
>  
>  			/* Last page (if present) may have trailing bytes not filled */
>  			bytes = res % PAGE_SIZE;
> -			if (pages[nr_pages - 1]->index == file_end && bytes)
> -				memzero_page(pages[nr_pages - 1], bytes,
> +			if (index == file_end && bytes && nr_used_pages > 0)
> +				memzero_page(pages[nr_used_pages - 1], bytes,
>  					     PAGE_SIZE - bytes);
>  
> -			for (i = 0; i < nr_pages; i++) {
> +			for (i = 0; i < nr_used_pages; i++) {
>  				flush_dcache_page(pages[i]);
>  				SetPageUptodate(pages[i]);
>  			}
> diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
> index f1ccad519e28..1bb0347f98b0 100644
> --- a/fs/squashfs/file_direct.c
> +++ b/fs/squashfs/file_direct.c
> @@ -30,10 +30,9 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>  	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
>  	int start_index = target_page->index & ~mask;
>  	int end_index = start_index | mask;
> -	int i, n, pages, bytes, res = -ENOMEM;
> +	int i, n, pages, used_pages, bytes, res = -ENOMEM;
>  	struct page **page;
>  	struct squashfs_page_actor *actor;
> -	void *pageaddr;
>  
>  	if (end_index > file_end)
>  		end_index = file_end;
> @@ -74,7 +73,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>  	/* Decompress directly into the page cache buffers */
>  	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
>  
> -	squashfs_page_actor_free(actor);
> +	used_pages = squashfs_page_actor_free(actor);
>  
>  	if (res < 0)
>  		goto mark_errored;
> @@ -86,16 +85,18 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>  
>  	/* Last page (if present) may have trailing bytes not filled */
>  	bytes = res % PAGE_SIZE;
> -	if (page[pages - 1]->index == end_index && bytes) {
> -		pageaddr = kmap_local_page(page[pages - 1]);
> -		memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> -		kunmap_local(pageaddr);
> +	if (used_pages > 0 && page[used_pages - 1]->index == end_index &&
> +	    bytes) {
> +		memzero_page(page[used_pages - 1], bytes,
> +			     PAGE_SIZE - bytes);
>  	}
>  
>  	/* Mark pages as uptodate, unlock and release */
>  	for (i = 0; i < pages; i++) {
> -		flush_dcache_page(page[i]);
> -		SetPageUptodate(page[i]);
> +		if (i < used_pages) {
> +			flush_dcache_page(page[i]);
> +			SetPageUptodate(page[i]);
> +		}
>  		unlock_page(page[i]);
>  		if (page[i] != target_page)
>  			put_page(page[i]);
> @@ -112,8 +113,10 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>  	for (i = 0; i < pages; i++) {
>  		if (page[i] == NULL || page[i] == target_page)
>  			continue;
> -		flush_dcache_page(page[i]);
> -		SetPageError(page[i]);
> +		if (i < used_pages) {
> +			flush_dcache_page(page[i]);
> +			SetPageError(page[i]);
> +		}
>  		unlock_page(page[i]);
>  		put_page(page[i]);
>  	}
> diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
> index 95ffbb543d91..c2c5c3937ef9 100644
> --- a/fs/squashfs/page_actor.h
> +++ b/fs/squashfs/page_actor.h
> @@ -29,10 +29,12 @@ extern struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
>  extern struct squashfs_page_actor *squashfs_page_actor_init_special(
>  				struct squashfs_sb_info *msblk,
>  				struct page **page, int pages, int length);
> -static inline void squashfs_page_actor_free(struct squashfs_page_actor *actor)
> +static inline int squashfs_page_actor_free(struct squashfs_page_actor *actor)
>  {
> +	int res = actor->next_page;
>  	kfree(actor->tmp_buffer);
>  	kfree(actor);
> +	return res;
>  }
>  static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
>  {

Hi Jintao,

Booting v6.1-rc1 with your patch applied, I got mixed results. On hello-world
snap, it runs without errors. On lxd, I got the Verneed regression as
originally reported. Sometimes I also get snapd panic.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

