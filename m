Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD56399DE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 11:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiK0KSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 05:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiK0KSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 05:18:31 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4516DF1F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 02:18:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so7793487pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 02:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8dFxQI+/RVircnstLupR+wzSTGReSsywaPKKiQaphTk=;
        b=hnybZPSoxrGMsNvTQa88HwLi4nRKBQnfQ95rng4eaARtP2YBPX47HbJDA4LSJ3f+NC
         LmvTllgulvbhEt4p6Rf7Sn4pPx4Jw5QWcVWRfcJSrWDlVysM3RdnPcoKAlG0/x440d6L
         AL4XJ3EttE7l4m4RWpFjc68qW5DUJe4JaWA0FWi2y/rR8D36uxYU780dvcpd9Dtbu7Z/
         dW1A14u+OFQMMLxnEcN30jcagoiVuD8Ff2PzLgtrnA8Pp59P7UwSl507r2oPsmRCA+ws
         GRosVJynkzYce/tQizK6anj6vJLZoBKal/gCU9c80CanVS8y2buAD1R3bu5v72N4J+28
         1b3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dFxQI+/RVircnstLupR+wzSTGReSsywaPKKiQaphTk=;
        b=EoHrjwS1mB60YRnL01OPcD8QIbr5SULnifByB5UpIbQ218M0NzzrogtFSle0K75g7l
         LGljopYy+OUPC1vUot+L0n+fEdN/wcprnWKcJ4ZjI0ZdcM97nmb2ZtJlQ2RupjB0CUGp
         j6u4HThe0Ih0u+AxMPs44ErcZKdD+o2HEo3Q25mV1LzILrYHMyrc3udKPDPRQFTrO0o+
         XkhTp6C6Bdl6WZyHS9MnVW+3eVG8aAKY8gnoJjnG5EJIWHPnruK+BXLFPdyqU+VDKlDZ
         5c8ljTTP8FDYyBTMXBrDSyURMoqZq0E9uM1hCfk0i2JVwwyJuNm5fj0GGkTPjsGTHgai
         V7Cg==
X-Gm-Message-State: ANoB5plCP35eMY52Q85r5ior3icu49YMzoraKWl1AR+gV2T7Fjjer0JO
        WOdv0vSTRFGG6H82DRAvHRk=
X-Google-Smtp-Source: AA0mqf7hyQ/awHJ7ShPcK8/eUKE6NXbFHmLQ6tLT2iWM5FwJAvi7eqXiTFmx7TYF1k5B0B9yeUmhqA==
X-Received: by 2002:a17:90b:888:b0:219:1a88:727b with SMTP id bj8-20020a17090b088800b002191a88727bmr6989938pjb.47.1669544308392;
        Sun, 27 Nov 2022 02:18:28 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id f16-20020aa79690000000b00553d573222fsm5922088pfk.199.2022.11.27.02.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 02:18:27 -0800 (PST)
Date:   Sun, 27 Nov 2022 19:18:21 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] mm, slub: refactor free debug processing
Message-ID: <Y4M5bWgjSWKZEXnO@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-9-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121171202.22080-9-vbabka@suse.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:11:58PM +0100, Vlastimil Babka wrote:
> Since commit c7323a5ad078 ("mm/slub: restrict sysfs validation to debug
> caches and make it safe"), caches with debugging enabled use the
> free_debug_processing() function to do both freeing checks and actual
> freeing to partial list under list_lock, bypassing the fast paths.
> 
> We will want to use the same path for CONFIG_SLUB_TINY, but without the
> debugging checks, so refactor the code so that free_debug_processing()
> does only the checks, while the freeing is handled by a new function
> free_to_partial_list().
> 
> For consistency, change return parameter alloc_debug_processing() from
> int to bool and correct the !SLUB_DEBUG variant to return true and not
> false. This didn't matter until now, but will in the following changes.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 154 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 83 insertions(+), 71 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index bf726dd00f7d..fd56d7cca9c2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1368,7 +1368,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
>  	return 1;
>  }
>  
> -static noinline int alloc_debug_processing(struct kmem_cache *s,
> +static noinline bool alloc_debug_processing(struct kmem_cache *s,
>  			struct slab *slab, void *object, int orig_size)
>  {
>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> @@ -1380,7 +1380,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
>  	trace(s, slab, object, 1);
>  	set_orig_size(s, object, orig_size);
>  	init_object(s, object, SLUB_RED_ACTIVE);
> -	return 1;
> +	return true;
>  
>  bad:
>  	if (folio_test_slab(slab_folio(slab))) {
> @@ -1393,7 +1393,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
>  		slab->inuse = slab->objects;
>  		slab->freelist = NULL;
>  	}
> -	return 0;
> +	return false;
>  }
>  
>  static inline int free_consistency_checks(struct kmem_cache *s,
> @@ -1646,17 +1646,17 @@ static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
>  static inline
>  void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
>  
> -static inline int alloc_debug_processing(struct kmem_cache *s,
> -	struct slab *slab, void *object, int orig_size) { return 0; }
> +static inline bool alloc_debug_processing(struct kmem_cache *s,
> +	struct slab *slab, void *object, int orig_size) { return true; }
>  
> -static inline void free_debug_processing(
> -	struct kmem_cache *s, struct slab *slab,
> -	void *head, void *tail, int bulk_cnt,
> -	unsigned long addr) {}
> +static inline bool free_debug_processing(struct kmem_cache *s,
> +	struct slab *slab, void *head, void *tail, int *bulk_cnt,
> +	unsigned long addr, depot_stack_handle_t handle) { return true; }
>  
>  static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
>  static inline int check_object(struct kmem_cache *s, struct slab *slab,
>  			void *object, u8 val) { return 1; }
> +static inline depot_stack_handle_t set_track_prepare(void) { return 0; }
>  static inline void set_track(struct kmem_cache *s, void *object,
>  			     enum track_item alloc, unsigned long addr) {}
>  static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
> @@ -2833,38 +2833,28 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
>  }
>  
>  /* Supports checking bulk free of a constructed freelist */
> -static noinline void free_debug_processing(
> -	struct kmem_cache *s, struct slab *slab,
> -	void *head, void *tail, int bulk_cnt,
> -	unsigned long addr)
> +static inline bool free_debug_processing(struct kmem_cache *s,
> +	struct slab *slab, void *head, void *tail, int *bulk_cnt,
> +	unsigned long addr, depot_stack_handle_t handle)
>  {
> -	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> -	struct slab *slab_free = NULL;
> +	bool checks_ok = false;
>  	void *object = head;
>  	int cnt = 0;
> -	unsigned long flags;
> -	bool checks_ok = false;
> -	depot_stack_handle_t handle = 0;
> -
> -	if (s->flags & SLAB_STORE_USER)
> -		handle = set_track_prepare();
> -
> -	spin_lock_irqsave(&n->list_lock, flags);
>  
>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>  		if (!check_slab(s, slab))
>  			goto out;
>  	}
>  
> -	if (slab->inuse < bulk_cnt) {
> +	if (slab->inuse < *bulk_cnt) {
>  		slab_err(s, slab, "Slab has %d allocated objects but %d are to be freed\n",
> -			 slab->inuse, bulk_cnt);
> +			 slab->inuse, *bulk_cnt);
>  		goto out;
>  	}
>  
>  next_object:
>  
> -	if (++cnt > bulk_cnt)
> +	if (++cnt > *bulk_cnt)
>  		goto out_cnt;
>  
>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> @@ -2886,57 +2876,18 @@ static noinline void free_debug_processing(
>  	checks_ok = true;
>  
>  out_cnt:
> -	if (cnt != bulk_cnt)
> +	if (cnt != *bulk_cnt) {
>  		slab_err(s, slab, "Bulk free expected %d objects but found %d\n",
> -			 bulk_cnt, cnt);
> -
> -out:
> -	if (checks_ok) {
> -		void *prior = slab->freelist;
> -
> -		/* Perform the actual freeing while we still hold the locks */
> -		slab->inuse -= cnt;
> -		set_freepointer(s, tail, prior);
> -		slab->freelist = head;
> -
> -		/*
> -		 * If the slab is empty, and node's partial list is full,
> -		 * it should be discarded anyway no matter it's on full or
> -		 * partial list.
> -		 */
> -		if (slab->inuse == 0 && n->nr_partial >= s->min_partial)
> -			slab_free = slab;
> -
> -		if (!prior) {
> -			/* was on full list */
> -			remove_full(s, n, slab);
> -			if (!slab_free) {
> -				add_partial(n, slab, DEACTIVATE_TO_TAIL);
> -				stat(s, FREE_ADD_PARTIAL);
> -			}
> -		} else if (slab_free) {
> -			remove_partial(n, slab);
> -			stat(s, FREE_REMOVE_PARTIAL);
> -		}
> +			 *bulk_cnt, cnt);
> +		*bulk_cnt = cnt;
>  	}
>  
> -	if (slab_free) {
> -		/*
> -		 * Update the counters while still holding n->list_lock to
> -		 * prevent spurious validation warnings
> -		 */
> -		dec_slabs_node(s, slab_nid(slab_free), slab_free->objects);
> -	}
> -
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> +out:
>  
>  	if (!checks_ok)
>  		slab_fix(s, "Object at 0x%p not freed", object);
>  
> -	if (slab_free) {
> -		stat(s, FREE_SLAB);
> -		free_slab(s, slab_free);
> -	}
> +	return checks_ok;
>  }
>  #endif /* CONFIG_SLUB_DEBUG */
>  
> @@ -3453,6 +3404,67 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_node);
>  
> +static noinline void free_to_partial_list(
> +	struct kmem_cache *s, struct slab *slab,
> +	void *head, void *tail, int bulk_cnt,
> +	unsigned long addr)
> +{
> +	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> +	struct slab *slab_free = NULL;
> +	int cnt = bulk_cnt;
> +	unsigned long flags;
> +	depot_stack_handle_t handle = 0;
> +
> +	if (s->flags & SLAB_STORE_USER)
> +		handle = set_track_prepare();
> +
> +	spin_lock_irqsave(&n->list_lock, flags);
> +
> +	if (free_debug_processing(s, slab, head, tail, &cnt, addr, handle)) {
> +		void *prior = slab->freelist;
> +
> +		/* Perform the actual freeing while we still hold the locks */
> +		slab->inuse -= cnt;
> +		set_freepointer(s, tail, prior);
> +		slab->freelist = head;
> +
> +		/*
> +		 * If the slab is empty, and node's partial list is full,
> +		 * it should be discarded anyway no matter it's on full or
> +		 * partial list.
> +		 */
> +		if (slab->inuse == 0 && n->nr_partial >= s->min_partial)
> +			slab_free = slab;
> +
> +		if (!prior) {
> +			/* was on full list */
> +			remove_full(s, n, slab);
> +			if (!slab_free) {
> +				add_partial(n, slab, DEACTIVATE_TO_TAIL);
> +				stat(s, FREE_ADD_PARTIAL);
> +			}
> +		} else if (slab_free) {
> +			remove_partial(n, slab);
> +			stat(s, FREE_REMOVE_PARTIAL);
> +		}
> +	}
> +
> +	if (slab_free) {
> +		/*
> +		 * Update the counters while still holding n->list_lock to
> +		 * prevent spurious validation warnings
> +		 */
> +		dec_slabs_node(s, slab_nid(slab_free), slab_free->objects);
> +	}
> +
> +	spin_unlock_irqrestore(&n->list_lock, flags);
> +
> +	if (slab_free) {
> +		stat(s, FREE_SLAB);
> +		free_slab(s, slab_free);
> +	}
> +}
> +
>  /*
>   * Slow path handling. This may still be called frequently since objects
>   * have a longer lifetime than the cpu slabs in most processing loads.
> @@ -3479,7 +3491,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  		return;
>  
>  	if (kmem_cache_debug(s)) {
> -		free_debug_processing(s, slab, head, tail, cnt, addr);
> +		free_to_partial_list(s, slab, head, tail, cnt, addr);
>  		return;
>  	}
>  
> -- 
> 2.38.1
>

Looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
