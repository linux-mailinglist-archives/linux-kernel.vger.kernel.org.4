Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3029760E09E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiJZM3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiJZM3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:29:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E633120982;
        Wed, 26 Oct 2022 05:29:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id io19so8935370plb.8;
        Wed, 26 Oct 2022 05:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOg9sdjLc0iWjtEaJQwtEr4xH27MKqVCDQfQzW2bqsE=;
        b=fBTlc+WwkqVaXS5dsKGnG9QcPxBgLnpY7O83A5v5vLQoSKmJPYYSamLMPMTLGdo8zE
         tSgTZjOVYHOhtUgo3dXgqY9Ik9QmlZv2RVVEyAX6djL8WY/o4+SkBfmomfkJCk4ykd6k
         +aBl4NrycoHw3ov5SYhGtG8Ba3SaYunLHamS1zG9mYTOjbazWHr3lL7TtEgcv4eMXYJ3
         oFXGCVOarau3kYJd8M14R3uRLmTye4l7e6D5r5wv/8Gds7IHm7XLvPHqXxeqXcgsY76D
         aVh2L9E31Nryts25vjTix904g8BQDrM5qeh92qVNYuIq2+yvgDeDZ8YKbmJ1XrZ4j27H
         91Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOg9sdjLc0iWjtEaJQwtEr4xH27MKqVCDQfQzW2bqsE=;
        b=iiWHHOSX1fr3D8w8lXFXUunPCIvsAPbexgAuihv8dYDShB4TVRTf42TFSYYpWWWk4W
         dajPGkLLhhZOCPLfqkWmjcSG60VKRoD9iCOLhJsW95ApZFR9wuRtU9rH77zybiDwT5AB
         TVxFjjxjx54KcfN4ziIUyAP1cr/ndI8aaRDl4GjYpGwF1YxgqOrls9Bp21KoPiaGrAyp
         S0MAqkXiccr+xev2ta63OIuKSJp+MesplFFTa7SQb+8a59yTjan1MxxLF0NaUXErmkNZ
         jARWNKQ+xK1ln0jPS8bZDvQRQGxhpFrj0e2b6U+VAmEBJABgQ2QdjOmHI9h+RsB00VVk
         6a1Q==
X-Gm-Message-State: ACrzQf28YKd/m2hSR+CXErQJByF7czP6s4GfirVVx8tZww2Wv5uKVUUT
        9tL6s6LlUs5ss0cjhTbMMgc=
X-Google-Smtp-Source: AMsMyM7AGl2M9WvkjBfMPDuohfpIh3yzchNotCkRm9Qx6lfz3bo02QctePvDCtoPE/mgZjcmDign0Q==
X-Received: by 2002:a17:90a:86c6:b0:213:36b6:1b4c with SMTP id y6-20020a17090a86c600b0021336b61b4cmr4031412pjv.7.1666787376229;
        Wed, 26 Oct 2022 05:29:36 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id g9-20020a656cc9000000b004308422060csm2678169pgw.69.2022.10.26.05.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:29:35 -0700 (PDT)
Date:   Wed, 26 Oct 2022 21:29:29 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Message-ID: <Y1koKX002Lc91qWL@hyeyoo>
References: <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
 <YzkmErHFyYW3awRn@hyeyoo>
 <YzsVM8eToHUeTP75@casper.infradead.org>
 <7dddca4c-bc36-2cf0-de1c-a770bef9e1b7@suse.cz>
 <Y1fpABCR3/Vs/u0H@hyeyoo>
 <ad3fae63-984b-3a4e-4bfc-a09db0ad35b0@suse.cz>
 <521ecc3f-c45a-74bb-9c2b-2d6284589e15@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521ecc3f-c45a-74bb-9c2b-2d6284589e15@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 12:52:01PM +0200, Vlastimil Babka wrote:
> On  10/25/22 16:08, Vlastimil Babka wrote:
> > On 10/25/22 15:47, Hyeonggon Yoo wrote:
> >> On Mon, Oct 24, 2022 at 04:35:04PM +0200, Vlastimil Babka wrote:
> >> 
> >> [,,,]
> >> 
> >>> diff --git a/mm/slab.c b/mm/slab.c
> >>> index 59c8e28f7b6a..219beb48588e 100644
> >>> --- a/mm/slab.c
> >>> +++ b/mm/slab.c
> >>> @@ -1370,6 +1370,8 @@ static struct slab *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
> >>>  
> >>>  	account_slab(slab, cachep->gfporder, cachep, flags);
> >>>  	__folio_set_slab(folio);
> >>> +	/* Make the flag visible before any changes to folio->mapping */
> >>> +	smp_wmb();
> >>>  	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
> >>>  	if (sk_memalloc_socks() && page_is_pfmemalloc(folio_page(folio, 0)))
> >>>  		slab_set_pfmemalloc(slab);
> >>> @@ -1387,9 +1389,11 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
> >>>  
> >>>  	BUG_ON(!folio_test_slab(folio));
> >>>  	__slab_clear_pfmemalloc(slab);
> >>> -	__folio_clear_slab(folio);
> >>>  	page_mapcount_reset(folio_page(folio, 0));
> >>>  	folio->mapping = NULL;
> >>> +	/* Make the mapping reset visible before clearing the flag */
> >>> +	smp_wmb();
> >>> +	__folio_clear_slab(folio);
> >>>  
> >>>  	if (current->reclaim_state)
> >>>  		current->reclaim_state->reclaimed_slab += 1 << order;
> >>> diff --git a/mm/slub.c b/mm/slub.c
> >>> index 157527d7101b..6dc17cb915c5 100644
> >>> --- a/mm/slub.c
> >>> +++ b/mm/slub.c
> >>> @@ -1800,6 +1800,8 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
> >>>  
> >>>  	slab = folio_slab(folio);
> >>>  	__folio_set_slab(folio);
> >>> +	/* Make the flag visible before any changes to folio->mapping */
> >>> +	smp_wmb();
> >>>  	if (page_is_pfmemalloc(folio_page(folio, 0)))
> >>>  		slab_set_pfmemalloc(slab);
> >>>  
> >>> @@ -2008,8 +2010,10 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
> >>>  	}
> >>>  
> >>>  	__slab_clear_pfmemalloc(slab);
> >>> -	__folio_clear_slab(folio);
> >>>  	folio->mapping = NULL;
> >>> +	/* Make the mapping reset visible before clearing the flag */
> >>> +	smp_wmb();
> >>> +	__folio_clear_slab(folio);
> >>>  	if (current->reclaim_state)
> >>>  		current->reclaim_state->reclaimed_slab += pages;
> >>>  	unaccount_slab(slab, order, s);
> >>> -- 
> >>> 2.38.0
> >> 
> >> Do we need to try this with memory barriers before frozen refcount lands in?
> > 
> > There was IIRC an unresolved issue with frozen refcount tripping the page
> > isolation code so I didn't want to be depending on that.

Understood.

> >> It's quite complicated and IIUC there is a still theoretical race:
> >> 
> >> At isolate_movable_page:        At slab alloc:                          At slab free:
> >>                                 folio = alloc_pages(flags, order)
> >> 
> >> folio_try_get()
> >> folio_test_slab() == false
> >>                                 __folio_set_slab(folio)
> >>                                 smp_wmb()
> >> 
> >>                                                                         call_rcu(&slab->rcu_head, rcu_free_slab);
> >> 
> >> 
> >> smp_rmb()
> >> __folio_test_movable() == true
> >> 
> >>                                                                         folio->mapping = NULL;
> >>                                                                         smp_wmb()
> >>                                                                         __folio_clear_slab(folio);
> >> smp_rmb()
> >> folio_test_slab() == false
> >> 
> >> folio_trylock()
> > 
> > There's also between above and below:
> > 
> > if (!PageMovable(page) || PageIsolated(page))
> > 	goto out_no_isolated;
> > 
> > mops = page_movable_ops(page);
> > 
> > If we put another smp_rmb() before the PageMovable test, could that have
> > helped? It would assure we observe the folio->mapping = NULL; from the "slab
> > free" side?
> > 
> > But yeah, it's getting ridiculous. Maybe there's a simpler way to check two
> > bits in two different bytes atomically. Or maybe it's just an impossible
> > task, I feel I just dunno computers at this point.
> 
> After more thought, I think I just made a mistake by doing two
> folio_test_slab() tests around a single __folio_test_movable(). What I was
> supposed to do was two __folio_test_movable() tests around a single
> folio_test_slab()... I hope. That should take care of your scenario, or do
> you see another one? Thanks.

I couldn't find one with this patch.
To best my understanding this looks at least correct to me.

Hope there is no other place that is confused
by anonymous checking for random page like here.

Thanks.

> ----8----
> From 5ca1c10f6411d73ad579b58d4fa10326bf77cf0a Mon Sep 17 00:00:00 2001
> From: Matthew Wilcox <willy@infradead.org>
> Date: Mon, 24 Oct 2022 16:11:27 +0200
> Subject: [PATCH] mm/migrate: make isolate_movable_page() skip slab pages
> 
> In the next commit we want to rearrange struct slab fields to allow a
> larger rcu_head. Afterwards, the page->mapping field will overlap
> with SLUB's "struct list_head slab_list", where the value of prev
> pointer can become LIST_POISON2, which is 0x122 + POISON_POINTER_DELTA.
> Unfortunately the bit 1 being set can confuse PageMovable() to be a
> false positive and cause a GPF as reported by lkp [1].
> 
> I think the real problem here is that isolate_movable_page() is
> insufficiently paranoid.  Looking at the gyrations that GUP and the
> page cache do to convince themselves that the page they got really is
> the page they wanted, there are a few missing pieces (eg checking that
> you actually got a refcount on _this_ page and not some random other
> page you were temporarily part of a compound page with).
> 
> This patch does three things:
> 
>  - Turns one of the comments into English.  There are some others
>    which I'm still scratching my head over.
>  - Uses a folio to help distinguish which operations are being done
>    to the head vs the specific page (this is somewhat an abuse of the
>    folio concept, but it's acceptable)
>  - Add the aforementioned check that we're actually operating on the
>    page that we think we want to be.
>  - Add a check that the folio isn't secretly a slab.
> 
> We could put the slab check in PageMapping and call it after taking
> the folio lock, but that seems pointless.  It's the acquisition of
> the refcount which stabilises the slab flag, not holding the lock.
> 
> [ vbabka@suse.cz: add memory barriers to SLAB and SLUB's page allocation
>   and freeing, and their counterparts to isolate_movable_page(), to make
>   the checks for folio_test_slab() and __folio_test_movable() SMP safe ]
> 
> [1] https://lore.kernel.org/all/208c1757-5edd-fd42-67d4-1940cc43b50f@intel.com/
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/migrate.c | 40 ++++++++++++++++++++++++++++------------
>  mm/slab.c    |  6 +++++-
>  mm/slub.c    |  6 +++++-
>  3 files changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 1379e1912772..f0f58e42c1d4 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -60,6 +60,7 @@
>  
>  int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  {
> +	struct folio *folio = page_folio(page);
>  	const struct movable_operations *mops;
>  
>  	/*
> @@ -71,16 +72,31 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	 * the put_page() at the end of this block will take care of
>  	 * release this page, thus avoiding a nasty leakage.
>  	 */
> -	if (unlikely(!get_page_unless_zero(page)))
> +	if (unlikely(!folio_try_get(folio)))
>  		goto out;
>  
> +	/* Recheck the page is still part of the folio we just got */
> +	if (unlikely(page_folio(page) != folio))
> +		goto out_put;
> +
>  	/*
> -	 * Check PageMovable before holding a PG_lock because page's owner
> -	 * assumes anybody doesn't touch PG_lock of newly allocated page
> -	 * so unconditionally grabbing the lock ruins page's owner side.
> +	 * Check movable flag before taking the folio lock because
> +	 * we use non-atomic bitops on newly allocated page flags so
> +	 * unconditionally grabbing the lock ruins page's owner side.
> +	 * Make sure we don't have a slab folio here as its usage of the
> +	 * mapping field can cause a false positive movable flag.
>  	 */
> -	if (unlikely(!__PageMovable(page)))
> -		goto out_putpage;
> +	if (unlikely(!__folio_test_movable(folio)))
> +		goto out_put;
> +	/* Pairs with smp_wmb() in slab allocation, e.g. SLUB's alloc_slab_page() */
> +	smp_rmb();
> +	if (unlikely(folio_test_slab(folio)))
> +		goto out_put;
> +	/* Pairs with smp_wmb() in slab freeing, e.g. SLUB's __free_slab() */
> +	smp_rmb();
> +	if (unlikely(!__folio_test_movable(folio)))
> +		goto out_put;
> +
>  	/*
>  	 * As movable pages are not isolated from LRU lists, concurrent
>  	 * compaction threads can race against page migration functions
> @@ -92,8 +108,8 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	 * lets be sure we have the page lock
>  	 * before proceeding with the movable page isolation steps.
>  	 */
> -	if (unlikely(!trylock_page(page)))
> -		goto out_putpage;
> +	if (unlikely(!folio_trylock(folio)))
> +		goto out_put;
>  
>  	if (!PageMovable(page) || PageIsolated(page))
>  		goto out_no_isolated;
> @@ -107,14 +123,14 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	/* Driver shouldn't use PG_isolated bit of page->flags */
>  	WARN_ON_ONCE(PageIsolated(page));
>  	SetPageIsolated(page);
> -	unlock_page(page);
> +	folio_unlock(folio);
>  
>  	return 0;
>  
>  out_no_isolated:
> -	unlock_page(page);
> -out_putpage:
> -	put_page(page);
> +	folio_unlock(folio);
> +out_put:
> +	folio_put(folio);
>  out:
>  	return -EBUSY;
>  }
> diff --git a/mm/slab.c b/mm/slab.c
> index 59c8e28f7b6a..219beb48588e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1370,6 +1370,8 @@ static struct slab *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>  
>  	account_slab(slab, cachep->gfporder, cachep, flags);
>  	__folio_set_slab(folio);
> +	/* Make the flag visible before any changes to folio->mapping */
> +	smp_wmb();
>  	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
>  	if (sk_memalloc_socks() && page_is_pfmemalloc(folio_page(folio, 0)))
>  		slab_set_pfmemalloc(slab);
> @@ -1387,9 +1389,11 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>  
>  	BUG_ON(!folio_test_slab(folio));
>  	__slab_clear_pfmemalloc(slab);
> -	__folio_clear_slab(folio);
>  	page_mapcount_reset(folio_page(folio, 0));
>  	folio->mapping = NULL;
> +	/* Make the mapping reset visible before clearing the flag */
> +	smp_wmb();
> +	__folio_clear_slab(folio);
>  
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += 1 << order;
> diff --git a/mm/slub.c b/mm/slub.c
> index 99ba865afc4a..5e6519d5169c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1800,6 +1800,8 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>  
>  	slab = folio_slab(folio);
>  	__folio_set_slab(folio);
> +	/* Make the flag visible before any changes to folio->mapping */
> +	smp_wmb();
>  	if (page_is_pfmemalloc(folio_page(folio, 0)))
>  		slab_set_pfmemalloc(slab);
>  
> @@ -2000,8 +2002,10 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>  	int pages = 1 << order;
>  
>  	__slab_clear_pfmemalloc(slab);
> -	__folio_clear_slab(folio);
>  	folio->mapping = NULL;
> +	/* Make the mapping reset visible before clearing the flag */
> +	smp_wmb();
> +	__folio_clear_slab(folio);
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += pages;
>  	unaccount_slab(slab, order, s);
> -- 
> 2.38.0
