Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1520603503
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJRVfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiJRVfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:35:05 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF497481DB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:35:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A2ADB604F5;
        Tue, 18 Oct 2022 23:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666128902; bh=VVfvm3QStYhVy5JIubImg8Khq7umuJsFeO0662tmoY0=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=QRBMh5cp/HQVU1LIvm8+uRw7vmM0lttLusHv8LB7nwfGLC3XaRIWw6C3rrnQ5T2pY
         Q9zheR6OseVYw40LcgjpSxIwZdYWb1SJtjj/k+LJvY16HN3lTSyKNv5XrFxXwLbUrn
         4uS/+gEd16ZORpNI2GmuO1U96QGpZ3gc2bMqyAGaaOxpaN6DDSUy510ErqOfE1jxGT
         CKqxXGggcABsJ4Uq7Nz+eqKMWprJJhCCaiB8+DL+wuGDWnbFypaj+WMUF6tq2gJs3z
         WUc9Yob5Ledx/QgOHgE+rGN/JB+xixiVke3xFUSGQ4s1hPmC9L5Lt04QLqzMX4ys/y
         xo2/78uRYoVzg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GWCkvDGqgFvh; Tue, 18 Oct 2022 23:35:00 +0200 (CEST)
Received: from [192.168.0.12] (unknown [188.252.198.228])
        by domac.alu.hr (Postfix) with ESMTPSA id DFD91604F4;
        Tue, 18 Oct 2022 23:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666128900; bh=VVfvm3QStYhVy5JIubImg8Khq7umuJsFeO0662tmoY0=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=yiCiu1202GT9T8zgQRIdJ9ZTzZAqnLNIh/AfldbeU+Ka9mNzN/OY2FnS8VPY4lqln
         Hd6ba3X4EAn/8g94xs7pQUPHdiWMsl9mDJ2SmYIwLqDPtcfBoIT/NXVnHoVEW5sFHZ
         huc5ijsi8QbT9Jy+nuwZaiAa0a7TR6/eA+TyPm+KbDmvxbWUXiexxJIqjhmbxM26rg
         0p1OEgrKpZStOroglPb1C80lJxHvm63xM4bSdes1AEt4jADWXu2X9+xHcT0AQ57a13
         BjmttmEU8aUHmp70Ua8R97tB2B1vev5JlyJ/NY7zn7iiCwbeiFwx5Y85OB8Rz+evJ1
         2SORZzt0uvJ3w==
Message-ID: <37f918e1-91a8-0d32-8ef5-3c8441a2cbd6@alu.unizg.hr>
Date:   Tue, 18 Oct 2022 23:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     bagasdotme@gmail.com, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        nicememory@gmail.com, regressions@leemhuis.info,
        regressions@lists.linux.dev, srw@sladewatkins.net
References: <cfe5dd3a-5820-98cf-ae31-b6a3ff3f0578@squashfs.org.uk>
 <20221018174157.1897-1-phillip@squashfs.org.uk>
 <1b41bf99-754e-8b90-cc2c-67f50642e2dc@alu.unizg.hr>
In-Reply-To: <1b41bf99-754e-8b90-cc2c-67f50642e2dc@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 10. 2022. 19:41, Phillip Lougher wrote:
> This diff has fixed the problem with my repoducer.
> Please test and report your results.
>
> Phillip
>
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index e56510964b22..e526eb7a1658 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -557,6 +557,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
>   		int res, bsize;
>   		u64 block = 0;
>   		unsigned int expected;
> +		struct page *last_page;
>   
>   		nr_pages = __readahead_batch(ractl, pages, max_pages);
>   		if (!nr_pages)
> @@ -593,15 +594,15 @@ static void squashfs_readahead(struct readahead_control *ractl)
>   
>   		res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
>   
> -		squashfs_page_actor_free(actor);
> +		last_page = squashfs_page_actor_free(actor);
>   
>   		if (res == expected) {
>   			int bytes;
>   
>   			/* Last page (if present) may have trailing bytes not filled */
>   			bytes = res % PAGE_SIZE;
> -			if (pages[nr_pages - 1]->index == file_end && bytes)
> -				memzero_page(pages[nr_pages - 1], bytes,
> +			if (index == file_end && bytes && last_page)
> +				memzero_page(last_page, bytes,
>   					     PAGE_SIZE - bytes);
>   
>   			for (i = 0; i < nr_pages; i++) {
> diff --git a/fs/squashfs/page_actor.c b/fs/squashfs/page_actor.c
> index 54b93bf4a25c..6aa38f88e31c 100644
> --- a/fs/squashfs/page_actor.c
> +++ b/fs/squashfs/page_actor.c
> @@ -53,6 +53,7 @@ struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
>   	actor->pages = pages;
>   	actor->next_page = 0;
>   	actor->tmp_buffer = NULL;
> +	actor->last_page = NULL;
>   	actor->squashfs_first_page = cache_first_page;
>   	actor->squashfs_next_page = cache_next_page;
>   	actor->squashfs_finish_page = cache_finish_page;
> @@ -71,11 +72,13 @@ static void *handle_next_page(struct squashfs_page_actor *actor)
>   			(actor->next_index != actor->page[actor->next_page]->index)) {
>   		actor->next_index++;
>   		actor->returned_pages++;
> +		actor->last_page = NULL;
>   		return actor->alloc_buffer ? actor->tmp_buffer : ERR_PTR(-ENOMEM);
>   	}
>   
>   	actor->next_index++;
>   	actor->returned_pages++;
> +	actor->last_page = actor->page[actor->next_page];
>   	return actor->pageaddr = kmap_local_page(actor->page[actor->next_page++]);
>   }
>   
> diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
> index 95ffbb543d91..97d4983559b1 100644
> --- a/fs/squashfs/page_actor.h
> +++ b/fs/squashfs/page_actor.h
> @@ -16,6 +16,7 @@ struct squashfs_page_actor {
>   	void    *(*squashfs_first_page)(struct squashfs_page_actor *);
>   	void    *(*squashfs_next_page)(struct squashfs_page_actor *);
>   	void    (*squashfs_finish_page)(struct squashfs_page_actor *);
> +	struct page *last_page;
>   	int	pages;
>   	int	length;
>   	int	next_page;
> @@ -29,10 +30,13 @@ extern struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
>   extern struct squashfs_page_actor *squashfs_page_actor_init_special(
>   				struct squashfs_sb_info *msblk,
>   				struct page **page, int pages, int length);
> -static inline void squashfs_page_actor_free(struct squashfs_page_actor *actor)
> +static inline struct page *squashfs_page_actor_free(struct squashfs_page_actor *actor)
>   {
> +	struct page *last_page = actor->last_page;
> +
>   	kfree(actor->tmp_buffer);
>   	kfree(actor);
> +	return last_page;
>   }
>   static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
>   {
Dear Mr. Phillip,

Congratulations!

The Firefox "Gah: tab crashed" went away with the same windows and tabs 
(I still had the problems
with OOM killer at that load, but I hope it will be improved with MGLRU 
in 6.1 ...).

I thank the Heavens!

It was really worth it and I feel proud to be a part of the open source 
community and of this speed of
fixing bugs.

Once again I have to apologise, for I failed to regard your great 
contributions to the Linux kernel tree
and treated you as if you didn't know Ubuntu and snaps. My sincere 
apologies. I should have done more
research before posting, but I am very new to bug reporting and alas the 
damage is done :(

Thank you again.

Mirsad

P.S.
My laptop locked up in Wayland soon after finishing the last email which 
didn't happen in the other
builds. The syslog did not reveal much but an OOM kill. I cannot say 
that it is squashfs-related, but
it surely needs more testing.

I will leave it running a couple of days before making a definitive 
conclusion, as I am certain you will
agree.

Thank you
Mirsad

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

