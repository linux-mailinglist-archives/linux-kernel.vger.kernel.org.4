Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8662E8A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbiKQWsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiKQWsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:48:32 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28879B2E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:48:31 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o13so3412915pgu.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FajgVpdht4XHKXNRj93ViLWrNQrYZNmJUwV/61hrII4=;
        b=VZDZ3+ypuuIWzc5LCXg2UadmmLGDb13Dj78uELfo5mtva/4wV5SETeEDoLIwcp6LV8
         nS7l+6rScGksBFydt7KhZSOSTV1+E9tKQ7DgVEzMtiKQpyJyVrxr9TtYfk6nE1u+MyPy
         HN1FyhGBQjMTo10IqqYWnIh3+G3IJ31Oo6LSRBv4COwu6PlPxNJWeHPJfFk0wQULJYyx
         Vkm4otebZtoQ3w0dQsCrEoGNsXsqFtBeZ5Fv5gpxFr9hObAG5rWXkkH8aLTRK23FEs7H
         AeQSIXjfT8CKk7xLR4SpXp43+L3fqLEYwa2l5+0lKQujDnb3hXBJSLJF0xOf6CbMXCBc
         Gg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FajgVpdht4XHKXNRj93ViLWrNQrYZNmJUwV/61hrII4=;
        b=gznnimgU80yMzAU/2kkWGD0BOAVbozZS2QHXCf0+tarPx1JrsKaqW8eU6pYQQ0di4i
         I+Q72LJKfU9BUlJ4ZVQ6Guvk3O70jKB0DL5OsDoA/dzFJjLduQuodl8redY5N6S8W5rU
         OpZJoZvHY/3kl6a0P+BVckzJOcwWxIViWqAniAHvbbo+mwtK1e9Qy4gKcVQqJ/n5cdkd
         eJmXXntqyjTtDAXK/f0AT/J9pDs+q4BlqUSIeytwKVCLQEw2cwWKijM99H/OYW3F+yrr
         HhZq3SmTFwQBzjPKFbt8OIGR8/kE/F2vNnGO3TJ+RogcF9IYVj6BksARdvelWQOdPX8f
         mIfw==
X-Gm-Message-State: ANoB5pn0C5RtzKV0vVsI9rF03/XIB6HaO/JGr1btyR9lbHdqkLmMg7WF
        T7bCLk3BVcQ09rZCEhaunc8=
X-Google-Smtp-Source: AA0mqf590w3nthEWCNVeppXj4os+B0frbjzlRdYI6D47er8YXM23P2O047/14j42HBaENY+eEO7RYw==
X-Received: by 2002:a62:868a:0:b0:56e:3a98:f02 with SMTP id x132-20020a62868a000000b0056e3a980f02mr4983617pfd.53.1668725310535;
        Thu, 17 Nov 2022 14:48:30 -0800 (PST)
Received: from google.com ([2620:15c:211:201:6bbc:b70a:8f80:710d])
        by smtp.gmail.com with ESMTPSA id l20-20020a170902e2d400b0016d9b101413sm1872540plc.200.2022.11.17.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:48:30 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 17 Nov 2022 14:48:28 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH v4 5/5] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3a6PGDB5ievPYgQ@google.com>
References: <20221117163839.230900-1-nphamcs@gmail.com>
 <20221117163839.230900-6-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117163839.230900-6-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:38:39AM -0800, Nhat Pham wrote:
> This commit adds the writeback mechanism for zsmalloc, analogous to the
> zbud allocator. Zsmalloc will attempt to determine the coldest zspage
> (i.e least recently used) in the pool, and attempt to write back all the
> stored compressed objects via the pool's evict handler.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zsmalloc.c | 203 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 184 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 776d0e15a401..0ab9f173e964 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -280,10 +280,13 @@ struct zspage {
>  	struct list_head lru;
>  #endif
> 
> +	bool under_reclaim;
> +
> +	/* list of unfreed handles whose objects have been reclaimed */
> +	unsigned long *deferred_handles;
> +

Guess we don't need to bloat the zspage on !CONFIG_ZPOOL?

>  	struct zs_pool *pool;
> -#ifdef CONFIG_COMPACTION
>  	rwlock_t lock;
> -#endif
>  };
> 
>  struct mapping_area {
> @@ -304,10 +307,11 @@ static bool ZsHugePage(struct zspage *zspage)
>  	return zspage->huge;
>  }
> 
> -#ifdef CONFIG_COMPACTION
>  static void migrate_lock_init(struct zspage *zspage);
>  static void migrate_read_lock(struct zspage *zspage);
>  static void migrate_read_unlock(struct zspage *zspage);
> +
> +#ifdef CONFIG_COMPACTION
>  static void migrate_write_lock(struct zspage *zspage);
>  static void migrate_write_lock_nested(struct zspage *zspage);
>  static void migrate_write_unlock(struct zspage *zspage);
> @@ -315,9 +319,6 @@ static void kick_deferred_free(struct zs_pool *pool);
>  static void init_deferred_free(struct zs_pool *pool);
>  static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
>  #else
> -static void migrate_lock_init(struct zspage *zspage) {}
> -static void migrate_read_lock(struct zspage *zspage) {}
> -static void migrate_read_unlock(struct zspage *zspage) {}
>  static void migrate_write_lock(struct zspage *zspage) {}
>  static void migrate_write_lock_nested(struct zspage *zspage) {}
>  static void migrate_write_unlock(struct zspage *zspage) {}
> @@ -449,6 +450,27 @@ static void zs_zpool_free(void *pool, unsigned long handle)
>  	zs_free(pool, handle);
>  }
> 
> +static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries);
> +
> +static int zs_zpool_shrink(void *pool, unsigned int pages,

                                                       what pages?
                                                       

> +			unsigned int *reclaimed)
> +{
> +	unsigned int total = 0;
> +	int ret = -EINVAL;
> +
> +	while (total < pages) {
> +		ret = zs_reclaim_page(pool, 8);
> +		if (ret < 0)
> +			break;
> +		total++;
> +	}
> +
> +	if (reclaimed)
> +		*reclaimed = total;
> +
> +	return ret;
> +}
> +
>  static void *zs_zpool_map(void *pool, unsigned long handle,
>  			enum zpool_mapmode mm)
>  {
> @@ -487,6 +509,7 @@ static struct zpool_driver zs_zpool_driver = {
>  	.malloc_support_movable = true,
>  	.malloc =		  zs_zpool_malloc,
>  	.free =			  zs_zpool_free,
> +	.shrink =		  zs_zpool_shrink,
>  	.map =			  zs_zpool_map,
>  	.unmap =		  zs_zpool_unmap,
>  	.total_size =		  zs_zpool_total_size,
> @@ -960,6 +983,21 @@ static int trylock_zspage(struct zspage *zspage)
>  	return 0;
>  }
> 
> +/*
> + * Free all the deferred handles whose objects are freed in zs_free.
> + */
> +static void free_handles(struct zs_pool *pool, struct zspage *zspage)
> +{
> +	unsigned long handle = (unsigned long)zspage->deferred_handles;
> +
> +	while (handle) {
> +		unsigned long nxt_handle = handle_to_obj(handle);
> +
> +		cache_free_handle(pool, handle);
> +		handle = nxt_handle;
> +	}
> +}
> +

Shouldn't we have it under CONFIG_ZPOOL?

>  static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>  				struct zspage *zspage)
>  {
> @@ -974,6 +1012,9 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>  	VM_BUG_ON(get_zspage_inuse(zspage));
>  	VM_BUG_ON(fg != ZS_EMPTY);
> 
> +	/* Free all deferred handles from zs_free */
> +	free_handles(pool, zspage);
> +
>  	next = page = get_first_page(zspage);
>  	do {
>  		VM_BUG_ON_PAGE(!PageLocked(page), page);
> @@ -1060,6 +1101,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
>  #ifdef CONFIG_ZPOOL
>  	INIT_LIST_HEAD(&zspage->lru);
>  #endif
> +	zspage->under_reclaim = false;
> +	zspage->deferred_handles = NULL;
> 
>  	set_freeobj(zspage, 0);
>  }
> @@ -1482,13 +1525,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>  		record_obj(handle, obj);
>  		class_stat_inc(class, OBJ_USED, 1);
> 
> -#ifdef CONFIG_ZPOOL
> -		/* Move the zspage to front of pool's LRU */
> -		move_to_front(pool, zspage);
> -#endif
> -		spin_unlock(&pool->lock);
> -
> -		return handle;
> +		goto out;

This chunk should go in "Add a LRU to zs_pool to keep track of zspages in
LRU order"

>  	}
> 
>  	spin_unlock(&pool->lock);
> @@ -1512,12 +1549,12 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> 
>  	/* We completely set up zspage so mark them as movable */
>  	SetZsPageMovable(pool, zspage);
> +out:
>  #ifdef CONFIG_ZPOOL
>  	/* Move the zspage to front of pool's LRU */
>  	move_to_front(pool, zspage);
>  #endif
>  	spin_unlock(&pool->lock);
> -

Unnecessary change.

>  	return handle;
>  }
>  EXPORT_SYMBOL_GPL(zs_malloc);
> @@ -1571,12 +1608,24 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
> 
>  	obj_free(class->size, obj);
>  	class_stat_dec(class, OBJ_USED, 1);
> +
> +	if (zspage->under_reclaim) {
> +		/*
> +		 * Reclaim needs the handles during writeback. It'll free
> +		 * them along with the zspage when it's done with them.
> +		 *
> +		 * Record current deferred handle at the memory location
> +		 * whose address is given by handle.
> +		 */
> +		record_obj(handle, (unsigned long)zspage->deferred_handles);
> +		zspage->deferred_handles = (unsigned long *)handle;
> +		spin_unlock(&pool->lock);
> +		return;
> +	}
>  	fullness = fix_fullness_group(class, zspage);
> -	if (fullness != ZS_EMPTY)
> -		goto out;
> +	if (fullness == ZS_EMPTY)
> +		free_zspage(pool, class, zspage);
> 
> -	free_zspage(pool, class, zspage);
> -out:
>  	spin_unlock(&pool->lock);
>  	cache_free_handle(pool, handle);
>  }
> @@ -1776,7 +1825,7 @@ static enum fullness_group putback_zspage(struct size_class *class,
>  	return fullness;
>  }
> 
> -#ifdef CONFIG_COMPACTION
> +#if defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION)
>  /*
>   * To prevent zspage destroy during migration, zspage freeing should
>   * hold locks of all pages in the zspage.
> @@ -1818,6 +1867,24 @@ static void lock_zspage(struct zspage *zspage)
>  	}
>  	migrate_read_unlock(zspage);
>  }
> +#endif /* defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION) */
> +
> +#ifdef CONFIG_ZPOOL
> +/*
> + * Unlocks all the pages of the zspage.
> + *
> + * pool->lock must be held before this function is called
> + * to prevent the underlying pages from migrating.
> + */
> +static void unlock_zspage(struct zspage *zspage)
> +{
> +	struct page *page = get_first_page(zspage);
> +
> +	do {
> +		unlock_page(page);
> +	} while ((page = get_next_page(page)) != NULL);
> +}
> +#endif /* CONFIG_ZPOOL */
> 
>  static void migrate_lock_init(struct zspage *zspage)
>  {
> @@ -1834,6 +1901,7 @@ static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
>  	read_unlock(&zspage->lock);
>  }
> 
> +#ifdef CONFIG_COMPACTION
>  static void migrate_write_lock(struct zspage *zspage)
>  {
>  	write_lock(&zspage->lock);
> @@ -2398,6 +2466,103 @@ void zs_destroy_pool(struct zs_pool *pool)
>  }
>  EXPORT_SYMBOL_GPL(zs_destroy_pool);
> 
> +#ifdef CONFIG_ZPOOL
> +static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
> +{
> +	int i, obj_idx, ret = 0;
> +	unsigned long handle;
> +	struct zspage *zspage;
> +	struct page *page;
> +	enum fullness_group fullness;
> +
> +	if (retries == 0 || !pool->ops || !pool->ops->evict)
> +		return -EINVAL;
> +
> +	/* Lock LRU and fullness list */
> +	spin_lock(&pool->lock);
> +	if (list_empty(&pool->lru)) {
> +		spin_unlock(&pool->lock);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < retries; i++) {
> +		struct size_class *class;
> +
> +		zspage = list_last_entry(&pool->lru, struct zspage, lru);
> +		list_del(&zspage->lru);
> +
> +		/* zs_free may free objects, but not the zspage and handles */
> +		zspage->under_reclaim = true;
> +
> +		class = zspage_class(pool, zspage);
> +		fullness = get_fullness_group(class, zspage);
> +
> +		/* Lock out object allocations and object compaction */
> +		remove_zspage(class, zspage, fullness);
> +
> +		spin_unlock(&pool->lock);
> +
> +		/* Lock backing pages into place */
> +		lock_zspage(zspage);
> +
> +		obj_idx = 0;
> +		page = zspage->first_page;
> +		while (1) {
> +			handle = find_alloced_obj(class, page, &obj_idx);
> +			if (!handle) {
> +				page = get_next_page(page);
> +				if (!page)
> +					break;
> +				obj_idx = 0;
> +				continue;
> +			}
> +
> +			/*
> +			 * This will write the object and call
> +			 * zs_free.

You want to write in the same line.

> +			 *
> +			 * zs_free will free the object, but the
> +			 * under_reclaim flag prevents it from freeing
> +			 * the zspage altogether. This is necessary so
> +			 * that we can continue working with the
> +			 * zspage potentially after the last object
> +			 * has been freed.
> +			 */
> +			ret = pool->ops->evict(pool, handle);
> +			if (ret)
> +				goto next;
> +
> +			obj_idx++;
> +		}
> +
> +next:
> +		/* For freeing the zspage, or putting it back in the pool and LRU list. */
> +		spin_lock(&pool->lock);
> +		zspage->under_reclaim = false;
> +
> +		if (!get_zspage_inuse(zspage)) {
> +			/*
> +			 * Fullness went stale as zs_free() won't touch it
> +			 * while the page is removed from the pool. Fix it
> +			 * up for the check in __free_zspage().
> +			 */
> +			zspage->fullness = ZS_EMPTY;
> +
> +			__free_zspage(pool, class, zspage);
> +			spin_unlock(&pool->lock);
> +			return 0;
> +		}
> +
> +		putback_zspage(class, zspage);
> +		list_add(&zspage->lru, &pool->lru);
> +		unlock_zspage(zspage);
> +	}
> +
> +	spin_unlock(&pool->lock);
> +	return -EAGAIN;
> +}
> +#endif /* CONFIG_ZPOOL */
> +
>  static int __init zs_init(void)
>  {
>  	int ret;
> --
> 2.30.2
