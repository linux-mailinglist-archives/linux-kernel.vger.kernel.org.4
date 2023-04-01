Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0306D2F95
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDAKA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 06:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDAKAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 06:00:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE7EE18F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 03:00:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l27so24744627wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 03:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680343247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LhdjM1ofUF+U/YXzdj6xLRBPPd6M4VWr/3bd72tdsu4=;
        b=Hj+bnZ9gCQOlUtwI07TgFrgx1niC1Pwk8/mhpxVUPW10F1W+xGPFUdAJLlLWTyA38O
         XOPwlpHPlw7B8y/TsYA5jMpMguGJhMhq0f+6jxKj4MVFCRDAcmRW6qwHeM1pYrWYT3tK
         LiTef5rvKrImfzAkg4ckVGzBEHvCiVE7UR2ajMUdyy8GfjmLro+Mreng9ifWUoEjTaeb
         QEOwcOLKoIyXkMlE9aZUMFRaOQOkJvErcsqlFTYXizDoQmIb13XjQtqkc8rFqFZD3COH
         /ziHg0izLxvm85ReoPigrJmQW4jPPgKvHjL34iUOOqE3i7hlJD9SzZ7M5AiRFL/V+VY6
         YGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680343247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhdjM1ofUF+U/YXzdj6xLRBPPd6M4VWr/3bd72tdsu4=;
        b=Fxv6SkPpqDJw1/txwe7Kafo5vmxpDsVGhY9Au9D1CHdM4ZxNkMrBQUpROo6Lto4Ysf
         MVTa8/ibwqkn7XOmzWHF6EDeDZ6jFlAC47chzssy/FYt7jLHrFQxSE9zsmqAC0VW6rMP
         nm6I0G5r+2RiOifYr+KSyI68bXpNquH265uiEHtzC9FeH7BY8zAoEIucWtCpf4GfhETG
         /ROa0P9SyQ+u+vAUNEl/KedoZVlWtaK+sE9IZJqUgLM429aEpVadFzGPZQQcFVykVpOd
         d4zjhP6R3qMZwxwkyLs0DAORx43sGLkE2ORz3Vb+7+T6FTjgmrd3MS0aYyaIKZtwspCj
         xZuQ==
X-Gm-Message-State: AAQBX9etyoCE/sGPutiPD6DgPFEdtI2b1nRbSCqKPzRJZ/W3wsoA4VZl
        1iZX1uF9wDbCZ0g0bqofZSNGiZAdS6s=
X-Google-Smtp-Source: AKy350ZPvdCMLkPoxCpioVbAb5OGd7LBc0//c3Wlk5iimM2Z7W32axcsT8kpKOH01ybeYIoEdIB2eA==
X-Received: by 2002:a5d:4a84:0:b0:2e5:e8d4:5c04 with SMTP id o4-20020a5d4a84000000b002e5e8d45c04mr3521215wrq.6.1680343245486;
        Sat, 01 Apr 2023 03:00:45 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id f14-20020adff58e000000b002e52dfb9256sm4498966wro.41.2023.04.01.03.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 03:00:43 -0700 (PDT)
Date:   Sat, 1 Apr 2023 11:00:42 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] mm: remove all the slab allocators
Message-ID: <bb3ceefa-7597-46b2-bf32-63c9ddf227b2@lucifer.local>
References: <20230401094658.11146-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401094658.11146-1-vbabka@suse.cz>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 11:46:58AM +0200, Vlastimil Babka wrote:
> As the SLOB removal is on track and the SLAB removal is planned, I have
> realized - why should we stop there and not remove also SLUB? What's a
> slab allocator good for in 2023? The RAM sizes are getting larger and
> the modules cheaper [1]. The object constructor trick was perhaps
> interesting in 1994, but not with contemporary CPUs. So all the slab
> allocator does today is just adding an unnecessary layer of complexity
> over the page allocator.
>
> Thus, with this patch, all three slab allocators are removed, and only a
> layer that passes everything to the page allocator remains in the slab.h
> and mm/slab_common.c files. This will allow users to gradually
> transition away and use the page allocator directly. To summarize the
> advantages:
>
> - Less code to maintain: over 13k lines are removed by this patch, and
>   more could be removed if I wast^Wspent more time on this, and later as
>   users are transitioned from the legacy layer. This no longer needs a
>   separate subsystem so remove it from MAINTAINERS (I hope I can keep the
>   kernel.org account anyway, though).
>
> - Simplified MEMCG_KMEM accounting: while I was lazy and just marked it
>   BROKEN in this patch, it should be trivial to use the page memcg
>   accounting now that we use the page allocator. The per-object
>   accounting went through several iterations in the past and was always
>   complex and added overhead. Page accounting is much simpler by
>   comparison.
>
> - Simplified KASAN and friends: also was lazy in this patch so they
>   can't be enabled but should be easy to fix up and work just on the
>   page level.
>
> - Simpler debugging: just use debug_pagealloc=on, no need to look up the
>   exact syntax of the absurdly complex slub_debug parameter.
>
> - Speed: didn't measure, but for the page allocator we have pcplists, so
>   it should scale just fine. No need for the crazy SLUB's cmpxchg_double()
>   craziness. Maybe that thing could be now removed too? Yeah I can see
>   just two remaining users.
>
> Any downsides? Let's look at memory usage after virtme boot:
>
> Before (with SLUB):
> Slab:              26304 kB
>
> After:
> Slab:             295592 kB
>
> Well, that's not so bad, see [1].
>
> [1] https://www.theregister.com/2023/03/29/dram_prices_crash/
> ---
>  MAINTAINERS              |   15 -
>  include/linux/slab.h     |  211 +-
>  include/linux/slab_def.h |  124 -
>  include/linux/slub_def.h |  198 --
>  init/Kconfig             |    2 +-
>  mm/Kconfig               |  134 +-
>  mm/Makefile              |   10 -
>  mm/slab.c                | 4046 ------------------------
>  mm/slab.h                |  426 ---
>  mm/slab_common.c         |  876 ++---
>  mm/slob.c                |  757 -----
>  mm/slub.c                | 6506 --------------------------------------
>  12 files changed, 228 insertions(+), 13077 deletions(-)
>  delete mode 100644 include/linux/slab_def.h
>  delete mode 100644 include/linux/slub_def.h
>  delete mode 100644 mm/slab.c
>  delete mode 100644 mm/slob.c
>  delete mode 100644 mm/slub.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1dc8bd26b6cf..40b05ad03cd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19183,21 +19183,6 @@ F:	drivers/irqchip/irq-sl28cpld.c
>  F:	drivers/pwm/pwm-sl28cpld.c
>  F:	drivers/watchdog/sl28cpld_wdt.c
>
> -SLAB ALLOCATOR
> -M:	Christoph Lameter <cl@linux.com>
> -M:	Pekka Enberg <penberg@kernel.org>
> -M:	David Rientjes <rientjes@google.com>
> -M:	Joonsoo Kim <iamjoonsoo.kim@lge.com>
> -M:	Andrew Morton <akpm@linux-foundation.org>
> -M:	Vlastimil Babka <vbabka@suse.cz>
> -R:	Roman Gushchin <roman.gushchin@linux.dev>
> -R:	Hyeonggon Yoo <42.hyeyoo@gmail.com>
> -L:	linux-mm@kvack.org
> -S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
> -F:	include/linux/sl?b*.h
> -F:	mm/sl?b*
> -
>  SLCAN CAN NETWORK DRIVER
>  M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
>  L:	linux-can@vger.kernel.org
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 45af70315a94..61602d54b1d0 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -140,13 +140,14 @@
>
>  /* The following flags affect the page allocator grouping pages by mobility */
>  /* Objects are reclaimable */
> -#ifndef CONFIG_SLUB_TINY
>  #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
> -#else
> -#define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0)
> -#endif
>  #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
>
> +#define KMALLOC_NOT_NORMAL_BITS					\
> +	(__GFP_RECLAIMABLE |					\
> +	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
> +	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
> +
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>   *
> @@ -278,38 +279,11 @@ static inline unsigned int arch_slab_minalign(void)
>   * Kmalloc array related definitions
>   */
>
> -#ifdef CONFIG_SLAB
> -/*
> - * SLAB and SLUB directly allocates requests fitting in to an order-1 page
> - * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
> - */
> -#define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> -#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
> -#ifndef KMALLOC_SHIFT_LOW
> -#define KMALLOC_SHIFT_LOW	5
> -#endif
> -#endif
> -
> -#ifdef CONFIG_SLUB
> -#define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> -#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
> -#ifndef KMALLOC_SHIFT_LOW
> -#define KMALLOC_SHIFT_LOW	3
> -#endif
> -#endif
> -
> -#ifdef CONFIG_SLOB
> -/*
> - * SLOB passes all requests larger than one page to the page allocator.
> - * No kmalloc array is necessary since objects of different sizes can
> - * be allocated from the same page.
> - */
>  #define KMALLOC_SHIFT_HIGH	PAGE_SHIFT
>  #define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
>  #ifndef KMALLOC_SHIFT_LOW
>  #define KMALLOC_SHIFT_LOW	3
>  #endif
> -#endif
>
>  /* Maximum allocatable size */
>  #define KMALLOC_MAX_SIZE	(1UL << KMALLOC_SHIFT_MAX)
> @@ -336,130 +310,6 @@ static inline unsigned int arch_slab_minalign(void)
>  #define SLAB_OBJ_MIN_SIZE      (KMALLOC_MIN_SIZE < 16 ? \
>                                 (KMALLOC_MIN_SIZE) : 16)
>
> -/*
> - * Whenever changing this, take care of that kmalloc_type() and
> - * create_kmalloc_caches() still work as intended.
> - *
> - * KMALLOC_NORMAL can contain only unaccounted objects whereas KMALLOC_CGROUP
> - * is for accounted but unreclaimable and non-dma objects. All the other
> - * kmem caches can have both accounted and unaccounted objects.
> - */
> -enum kmalloc_cache_type {
> -	KMALLOC_NORMAL = 0,
> -#ifndef CONFIG_ZONE_DMA
> -	KMALLOC_DMA = KMALLOC_NORMAL,
> -#endif
> -#ifndef CONFIG_MEMCG_KMEM
> -	KMALLOC_CGROUP = KMALLOC_NORMAL,
> -#endif
> -#ifdef CONFIG_SLUB_TINY
> -	KMALLOC_RECLAIM = KMALLOC_NORMAL,
> -#else
> -	KMALLOC_RECLAIM,
> -#endif
> -#ifdef CONFIG_ZONE_DMA
> -	KMALLOC_DMA,
> -#endif
> -#ifdef CONFIG_MEMCG_KMEM
> -	KMALLOC_CGROUP,
> -#endif
> -	NR_KMALLOC_TYPES
> -};
> -
> -#ifndef CONFIG_SLOB
> -extern struct kmem_cache *
> -kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
> -
> -/*
> - * Define gfp bits that should not be set for KMALLOC_NORMAL.
> - */
> -#define KMALLOC_NOT_NORMAL_BITS					\
> -	(__GFP_RECLAIMABLE |					\
> -	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
> -	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
> -
> -static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
> -{
> -	/*
> -	 * The most common case is KMALLOC_NORMAL, so test for it
> -	 * with a single branch for all the relevant flags.
> -	 */
> -	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
> -		return KMALLOC_NORMAL;
> -
> -	/*
> -	 * At least one of the flags has to be set. Their priorities in
> -	 * decreasing order are:
> -	 *  1) __GFP_DMA
> -	 *  2) __GFP_RECLAIMABLE
> -	 *  3) __GFP_ACCOUNT
> -	 */
> -	if (IS_ENABLED(CONFIG_ZONE_DMA) && (flags & __GFP_DMA))
> -		return KMALLOC_DMA;
> -	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || (flags & __GFP_RECLAIMABLE))
> -		return KMALLOC_RECLAIM;
> -	else
> -		return KMALLOC_CGROUP;
> -}
> -
> -/*
> - * Figure out which kmalloc slab an allocation of a certain size
> - * belongs to.
> - * 0 = zero alloc
> - * 1 =  65 .. 96 bytes
> - * 2 = 129 .. 192 bytes
> - * n = 2^(n-1)+1 .. 2^n
> - *
> - * Note: __kmalloc_index() is compile-time optimized, and not runtime optimized;
> - * typical usage is via kmalloc_index() and therefore evaluated at compile-time.
> - * Callers where !size_is_constant should only be test modules, where runtime
> - * overheads of __kmalloc_index() can be tolerated.  Also see kmalloc_slab().
> - */
> -static __always_inline unsigned int __kmalloc_index(size_t size,
> -						    bool size_is_constant)
> -{
> -	if (!size)
> -		return 0;
> -
> -	if (size <= KMALLOC_MIN_SIZE)
> -		return KMALLOC_SHIFT_LOW;
> -
> -	if (KMALLOC_MIN_SIZE <= 32 && size > 64 && size <= 96)
> -		return 1;
> -	if (KMALLOC_MIN_SIZE <= 64 && size > 128 && size <= 192)
> -		return 2;
> -	if (size <=          8) return 3;
> -	if (size <=         16) return 4;
> -	if (size <=         32) return 5;
> -	if (size <=         64) return 6;
> -	if (size <=        128) return 7;
> -	if (size <=        256) return 8;
> -	if (size <=        512) return 9;
> -	if (size <=       1024) return 10;
> -	if (size <=   2 * 1024) return 11;
> -	if (size <=   4 * 1024) return 12;
> -	if (size <=   8 * 1024) return 13;
> -	if (size <=  16 * 1024) return 14;
> -	if (size <=  32 * 1024) return 15;
> -	if (size <=  64 * 1024) return 16;
> -	if (size <= 128 * 1024) return 17;
> -	if (size <= 256 * 1024) return 18;
> -	if (size <= 512 * 1024) return 19;
> -	if (size <= 1024 * 1024) return 20;
> -	if (size <=  2 * 1024 * 1024) return 21;
> -
> -	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
> -		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> -	else
> -		BUG();
> -
> -	/* Will never be reached. Needed because the compiler may complain */
> -	return -1;
> -}
> -static_assert(PAGE_SHIFT <= 20);
> -#define kmalloc_index(s) __kmalloc_index(s, true)
> -#endif /* !CONFIG_SLOB */
> -
>  void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
>
>  /**
> @@ -567,57 +417,15 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
>   *	Try really hard to succeed the allocation but fail
>   *	eventually.
>   */
> -#ifndef CONFIG_SLOB
> -static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
> -{
> -	if (__builtin_constant_p(size) && size) {
> -		unsigned int index;
> -
> -		if (size > KMALLOC_MAX_CACHE_SIZE)
> -			return kmalloc_large(size, flags);
> -
> -		index = kmalloc_index(size);
> -		return kmalloc_trace(
> -				kmalloc_caches[kmalloc_type(flags)][index],
> -				flags, size);
> -	}
> -	return __kmalloc(size, flags);
> -}
> -#else
>  static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  {
> -	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> -		return kmalloc_large(size, flags);
> -
> -	return __kmalloc(size, flags);
> +	return kmalloc_large(size, flags);
>  }
> -#endif
>
> -#ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
>  {
> -	if (__builtin_constant_p(size) && size) {
> -		unsigned int index;
> -
> -		if (size > KMALLOC_MAX_CACHE_SIZE)
> -			return kmalloc_large_node(size, flags, node);
> -
> -		index = kmalloc_index(size);
> -		return kmalloc_node_trace(
> -				kmalloc_caches[kmalloc_type(flags)][index],
> -				flags, node, size);
> -	}
> -	return __kmalloc_node(size, flags, node);
> +	return kmalloc_large_node(size, flags, node);
>  }
> -#else
> -static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> -{
> -	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> -		return kmalloc_large_node(size, flags, node);
> -
> -	return __kmalloc_node(size, flags, node);
> -}
> -#endif
>
>  /**
>   * kmalloc_array - allocate memory for an array.
> @@ -785,12 +593,7 @@ size_t kmalloc_size_roundup(size_t size);
>
>  void __init kmem_cache_init_late(void);
>
> -#if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
> -int slab_prepare_cpu(unsigned int cpu);
> -int slab_dead_cpu(unsigned int cpu);
> -#else
>  #define slab_prepare_cpu	NULL
>  #define slab_dead_cpu		NULL
> -#endif
>
>  #endif	/* _LINUX_SLAB_H */
> diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> deleted file mode 100644
> index a61e7d55d0d3..000000000000
> --- a/include/linux/slab_def.h
> +++ /dev/null
> @@ -1,124 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_SLAB_DEF_H
> -#define	_LINUX_SLAB_DEF_H
> -
> -#include <linux/kfence.h>
> -#include <linux/reciprocal_div.h>
> -
> -/*
> - * Definitions unique to the original Linux SLAB allocator.
> - */
> -
> -struct kmem_cache {
> -	struct array_cache __percpu *cpu_cache;
> -
> -/* 1) Cache tunables. Protected by slab_mutex */
> -	unsigned int batchcount;
> -	unsigned int limit;
> -	unsigned int shared;
> -
> -	unsigned int size;
> -	struct reciprocal_value reciprocal_buffer_size;
> -/* 2) touched by every alloc & free from the backend */
> -
> -	slab_flags_t flags;		/* constant flags */
> -	unsigned int num;		/* # of objs per slab */
> -
> -/* 3) cache_grow/shrink */
> -	/* order of pgs per slab (2^n) */
> -	unsigned int gfporder;
> -
> -	/* force GFP flags, e.g. GFP_DMA */
> -	gfp_t allocflags;
> -
> -	size_t colour;			/* cache colouring range */
> -	unsigned int colour_off;	/* colour offset */
> -	unsigned int freelist_size;
> -
> -	/* constructor func */
> -	void (*ctor)(void *obj);
> -
> -/* 4) cache creation/removal */
> -	const char *name;
> -	struct list_head list;
> -	int refcount;
> -	int object_size;
> -	int align;
> -
> -/* 5) statistics */
> -#ifdef CONFIG_DEBUG_SLAB
> -	unsigned long num_active;
> -	unsigned long num_allocations;
> -	unsigned long high_mark;
> -	unsigned long grown;
> -	unsigned long reaped;
> -	unsigned long errors;
> -	unsigned long max_freeable;
> -	unsigned long node_allocs;
> -	unsigned long node_frees;
> -	unsigned long node_overflow;
> -	atomic_t allochit;
> -	atomic_t allocmiss;
> -	atomic_t freehit;
> -	atomic_t freemiss;
> -
> -	/*
> -	 * If debugging is enabled, then the allocator can add additional
> -	 * fields and/or padding to every object. 'size' contains the total
> -	 * object size including these internal fields, while 'obj_offset'
> -	 * and 'object_size' contain the offset to the user object and its
> -	 * size.
> -	 */
> -	int obj_offset;
> -#endif /* CONFIG_DEBUG_SLAB */
> -
> -#ifdef CONFIG_KASAN_GENERIC
> -	struct kasan_cache kasan_info;
> -#endif
> -
> -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> -	unsigned int *random_seq;
> -#endif
> -
> -#ifdef CONFIG_HARDENED_USERCOPY
> -	unsigned int useroffset;	/* Usercopy region offset */
> -	unsigned int usersize;		/* Usercopy region size */
> -#endif
> -
> -	struct kmem_cache_node *node[MAX_NUMNODES];
> -};
> -
> -static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
> -				void *x)
> -{
> -	void *object = x - (x - slab->s_mem) % cache->size;
> -	void *last_object = slab->s_mem + (cache->num - 1) * cache->size;
> -
> -	if (unlikely(object > last_object))
> -		return last_object;
> -	else
> -		return object;
> -}
> -
> -/*
> - * We want to avoid an expensive divide : (offset / cache->size)
> - *   Using the fact that size is a constant for a particular cache,
> - *   we can replace (offset / cache->size) by
> - *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
> - */
> -static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> -					const struct slab *slab, void *obj)
> -{
> -	u32 offset = (obj - slab->s_mem);
> -	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
> -}
> -
> -static inline int objs_per_slab(const struct kmem_cache *cache,
> -				     const struct slab *slab)
> -{
> -	if (is_kfence_address(slab_address(slab)))
> -		return 1;
> -	return cache->num;
> -}
> -
> -#endif	/* _LINUX_SLAB_DEF_H */
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> deleted file mode 100644
> index f6df03f934e5..000000000000
> --- a/include/linux/slub_def.h
> +++ /dev/null
> @@ -1,198 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_SLUB_DEF_H
> -#define _LINUX_SLUB_DEF_H
> -
> -/*
> - * SLUB : A Slab allocator without object queues.
> - *
> - * (C) 2007 SGI, Christoph Lameter
> - */
> -#include <linux/kfence.h>
> -#include <linux/kobject.h>
> -#include <linux/reciprocal_div.h>
> -#include <linux/local_lock.h>
> -
> -enum stat_item {
> -	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> -	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
> -	FREE_FASTPATH,		/* Free to cpu slab */
> -	FREE_SLOWPATH,		/* Freeing not to cpu slab */
> -	FREE_FROZEN,		/* Freeing to frozen slab */
> -	FREE_ADD_PARTIAL,	/* Freeing moves slab to partial list */
> -	FREE_REMOVE_PARTIAL,	/* Freeing removes last object */
> -	ALLOC_FROM_PARTIAL,	/* Cpu slab acquired from node partial list */
> -	ALLOC_SLAB,		/* Cpu slab acquired from page allocator */
> -	ALLOC_REFILL,		/* Refill cpu slab from slab freelist */
> -	ALLOC_NODE_MISMATCH,	/* Switching cpu slab */
> -	FREE_SLAB,		/* Slab freed to the page allocator */
> -	CPUSLAB_FLUSH,		/* Abandoning of the cpu slab */
> -	DEACTIVATE_FULL,	/* Cpu slab was full when deactivated */
> -	DEACTIVATE_EMPTY,	/* Cpu slab was empty when deactivated */
> -	DEACTIVATE_TO_HEAD,	/* Cpu slab was moved to the head of partials */
> -	DEACTIVATE_TO_TAIL,	/* Cpu slab was moved to the tail of partials */
> -	DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects */
> -	DEACTIVATE_BYPASS,	/* Implicit deactivation */
> -	ORDER_FALLBACK,		/* Number of times fallback was necessary */
> -	CMPXCHG_DOUBLE_CPU_FAIL,/* Failure of this_cpu_cmpxchg_double */
> -	CMPXCHG_DOUBLE_FAIL,	/* Number of times that cmpxchg double did not match */
> -	CPU_PARTIAL_ALLOC,	/* Used cpu partial on alloc */
> -	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
> -	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
> -	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
> -	NR_SLUB_STAT_ITEMS };
> -
> -#ifndef CONFIG_SLUB_TINY
> -/*
> - * When changing the layout, make sure freelist and tid are still compatible
> - * with this_cpu_cmpxchg_double() alignment requirements.
> - */
> -struct kmem_cache_cpu {
> -	void **freelist;	/* Pointer to next available object */
> -	unsigned long tid;	/* Globally unique transaction id */
> -	struct slab *slab;	/* The slab from which we are allocating */
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -	struct slab *partial;	/* Partially allocated frozen slabs */
> -#endif
> -	local_lock_t lock;	/* Protects the fields above */
> -#ifdef CONFIG_SLUB_STATS
> -	unsigned stat[NR_SLUB_STAT_ITEMS];
> -#endif
> -};
> -#endif /* CONFIG_SLUB_TINY */
> -
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -#define slub_percpu_partial(c)		((c)->partial)
> -
> -#define slub_set_percpu_partial(c, p)		\
> -({						\
> -	slub_percpu_partial(c) = (p)->next;	\
> -})
> -
> -#define slub_percpu_partial_read_once(c)     READ_ONCE(slub_percpu_partial(c))
> -#else
> -#define slub_percpu_partial(c)			NULL
> -
> -#define slub_set_percpu_partial(c, p)
> -
> -#define slub_percpu_partial_read_once(c)	NULL
> -#endif // CONFIG_SLUB_CPU_PARTIAL
> -
> -/*
> - * Word size structure that can be atomically updated or read and that
> - * contains both the order and the number of objects that a slab of the
> - * given order would contain.
> - */
> -struct kmem_cache_order_objects {
> -	unsigned int x;
> -};
> -
> -/*
> - * Slab cache management.
> - */
> -struct kmem_cache {
> -#ifndef CONFIG_SLUB_TINY
> -	struct kmem_cache_cpu __percpu *cpu_slab;
> -#endif
> -	/* Used for retrieving partial slabs, etc. */
> -	slab_flags_t flags;
> -	unsigned long min_partial;
> -	unsigned int size;	/* The size of an object including metadata */
> -	unsigned int object_size;/* The size of an object without metadata */
> -	struct reciprocal_value reciprocal_size;
> -	unsigned int offset;	/* Free pointer offset */
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -	/* Number of per cpu partial objects to keep around */
> -	unsigned int cpu_partial;
> -	/* Number of per cpu partial slabs to keep around */
> -	unsigned int cpu_partial_slabs;
> -#endif
> -	struct kmem_cache_order_objects oo;
> -
> -	/* Allocation and freeing of slabs */
> -	struct kmem_cache_order_objects min;
> -	gfp_t allocflags;	/* gfp flags to use on each alloc */
> -	int refcount;		/* Refcount for slab cache destroy */
> -	void (*ctor)(void *);
> -	unsigned int inuse;		/* Offset to metadata */
> -	unsigned int align;		/* Alignment */
> -	unsigned int red_left_pad;	/* Left redzone padding size */
> -	const char *name;	/* Name (only for display!) */
> -	struct list_head list;	/* List of slab caches */
> -#ifdef CONFIG_SYSFS
> -	struct kobject kobj;	/* For sysfs */
> -#endif
> -#ifdef CONFIG_SLAB_FREELIST_HARDENED
> -	unsigned long random;
> -#endif
> -
> -#ifdef CONFIG_NUMA
> -	/*
> -	 * Defragmentation by allocating from a remote node.
> -	 */
> -	unsigned int remote_node_defrag_ratio;
> -#endif
> -
> -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> -	unsigned int *random_seq;
> -#endif
> -
> -#ifdef CONFIG_KASAN_GENERIC
> -	struct kasan_cache kasan_info;
> -#endif
> -
> -#ifdef CONFIG_HARDENED_USERCOPY
> -	unsigned int useroffset;	/* Usercopy region offset */
> -	unsigned int usersize;		/* Usercopy region size */
> -#endif
> -
> -	struct kmem_cache_node *node[MAX_NUMNODES];
> -};
> -
> -#if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
> -#define SLAB_SUPPORTS_SYSFS
> -void sysfs_slab_unlink(struct kmem_cache *);
> -void sysfs_slab_release(struct kmem_cache *);
> -#else
> -static inline void sysfs_slab_unlink(struct kmem_cache *s)
> -{
> -}
> -static inline void sysfs_slab_release(struct kmem_cache *s)
> -{
> -}
> -#endif
> -
> -void *fixup_red_left(struct kmem_cache *s, void *p);
> -
> -static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
> -				void *x) {
> -	void *object = x - (x - slab_address(slab)) % cache->size;
> -	void *last_object = slab_address(slab) +
> -		(slab->objects - 1) * cache->size;
> -	void *result = (unlikely(object > last_object)) ? last_object : object;
> -
> -	result = fixup_red_left(cache, result);
> -	return result;
> -}
> -
> -/* Determine object index from a given position */
> -static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
> -					  void *addr, void *obj)
> -{
> -	return reciprocal_divide(kasan_reset_tag(obj) - addr,
> -				 cache->reciprocal_size);
> -}
> -
> -static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> -					const struct slab *slab, void *obj)
> -{
> -	if (is_kfence_address(obj))
> -		return 0;
> -	return __obj_to_index(cache, slab_address(slab), obj);
> -}
> -
> -static inline int objs_per_slab(const struct kmem_cache *cache,
> -				     const struct slab *slab)
> -{
> -	return slab->objects;
> -}
> -#endif /* _LINUX_SLUB_DEF_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 1fb5f313d18f..45be2eedf75c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -973,7 +973,7 @@ config MEMCG
>
>  config MEMCG_KMEM
>  	bool
> -	depends on MEMCG && !SLOB
> +	depends on MEMCG && BROKEN
>  	default y
>
>  config BLK_CGROUP
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 4751031f3f05..f07e81bca39e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -210,134 +210,9 @@ config ZSMALLOC_CHAIN_SIZE
>
>  	  For more information, see zsmalloc documentation.
>
> -menu "SLAB allocator options"
> -
> -choice
> -	prompt "Choose SLAB allocator"
> -	default SLUB
> -	help
> -	   This option allows to select a slab allocator.
> -
> -config SLAB
> -	bool "SLAB"
> -	depends on !PREEMPT_RT
> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> -	help
> -	  The regular slab allocator that is established and known to work
> -	  well in all environments. It organizes cache hot objects in
> -	  per cpu and per node queues.
> -
> -config SLUB
> -	bool "SLUB (Unqueued Allocator)"
> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> -	help
> -	   SLUB is a slab allocator that minimizes cache line usage
> -	   instead of managing queues of cached objects (SLAB approach).
> -	   Per cpu caching is realized using slabs of objects instead
> -	   of queues of objects. SLUB can use memory efficiently
> -	   and has enhanced diagnostics. SLUB is the default choice for
> -	   a slab allocator.
> -
> -config SLOB_DEPRECATED
> -	depends on EXPERT
> -	bool "SLOB (Simple Allocator - DEPRECATED)"
> -	depends on !PREEMPT_RT
> -	help
> -	   Deprecated and scheduled for removal in a few cycles. SLUB
> -	   recommended as replacement. CONFIG_SLUB_TINY can be considered
> -	   on systems with 16MB or less RAM.
> -
> -	   If you need SLOB to stay, please contact linux-mm@kvack.org and
> -	   people listed in the SLAB ALLOCATOR section of MAINTAINERS file,
> -	   with your use case.
> -
> -	   SLOB replaces the stock allocator with a drastically simpler
> -	   allocator. SLOB is generally more space efficient but
> -	   does not perform as well on large systems.
> -
> -endchoice
> -
> -config SLOB
> -	bool
> -	default y
> -	depends on SLOB_DEPRECATED
> -
> -config SLUB_TINY
> -	bool "Configure SLUB for minimal memory footprint"
> -	depends on SLUB && EXPERT
> -	select SLAB_MERGE_DEFAULT
> -	help
> -	   Configures the SLUB allocator in a way to achieve minimal memory
> -	   footprint, sacrificing scalability, debugging and other features.
> -	   This is intended only for the smallest system that had used the
> -	   SLOB allocator and is not recommended for systems with more than
> -	   16MB RAM.
> -
> -	   If unsure, say N.
> -
> -config SLAB_MERGE_DEFAULT
> -	bool "Allow slab caches to be merged"
> -	default y
> -	depends on SLAB || SLUB
> -	help
> -	  For reduced kernel memory fragmentation, slab caches can be
> -	  merged when they share the same size and other characteristics.
> -	  This carries a risk of kernel heap overflows being able to
> -	  overwrite objects from merged caches (and more easily control
> -	  cache layout), which makes such heap attacks easier to exploit
> -	  by attackers. By keeping caches unmerged, these kinds of exploits
> -	  can usually only damage objects in the same cache. To disable
> -	  merging at runtime, "slab_nomerge" can be passed on the kernel
> -	  command line.
> -
> -config SLAB_FREELIST_RANDOM
> -	bool "Randomize slab freelist"
> -	depends on SLAB || (SLUB && !SLUB_TINY)
> -	help
> -	  Randomizes the freelist order used on creating new pages. This
> -	  security feature reduces the predictability of the kernel slab
> -	  allocator against heap overflows.
> -
> -config SLAB_FREELIST_HARDENED
> -	bool "Harden slab freelist metadata"
> -	depends on SLAB || (SLUB && !SLUB_TINY)
> -	help
> -	  Many kernel heap attacks try to target slab cache metadata and
> -	  other infrastructure. This options makes minor performance
> -	  sacrifices to harden the kernel slab allocator against common
> -	  freelist exploit methods. Some slab implementations have more
> -	  sanity-checking than others. This option is most effective with
> -	  CONFIG_SLUB.
> -
> -config SLUB_STATS
> -	default n
> -	bool "Enable SLUB performance statistics"
> -	depends on SLUB && SYSFS && !SLUB_TINY
> -	help
> -	  SLUB statistics are useful to debug SLUBs allocation behavior in
> -	  order find ways to optimize the allocator. This should never be
> -	  enabled for production use since keeping statistics slows down
> -	  the allocator by a few percentage points. The slabinfo command
> -	  supports the determination of the most active slabs to figure
> -	  out which slabs are relevant to a particular load.
> -	  Try running: slabinfo -DA
> -
> -config SLUB_CPU_PARTIAL
> -	default y
> -	depends on SLUB && SMP && !SLUB_TINY
> -	bool "SLUB per cpu partial cache"
> -	help
> -	  Per cpu partial caches accelerate objects allocation and freeing
> -	  that is local to a processor at the price of more indeterminism
> -	  in the latency of the free. On overflow these caches will be cleared
> -	  which requires the taking of locks that may cause latency spikes.
> -	  Typically one would choose no for a realtime system.
> -
> -endmenu # SLAB allocator options
> -
>  config SHUFFLE_PAGE_ALLOCATOR
>  	bool "Page allocator randomization"
> -	default SLAB_FREELIST_RANDOM && ACPI_NUMA
> +	default ACPI_NUMA
>  	help
>  	  Randomization of the page allocator improves the average
>  	  utilization of a direct-mapped memory-side-cache. See section
> @@ -345,10 +220,9 @@ config SHUFFLE_PAGE_ALLOCATOR
>  	  6.2a specification for an example of how a platform advertises
>  	  the presence of a memory-side-cache. There are also incidental
>  	  security benefits as it reduces the predictability of page
> -	  allocations to compliment SLAB_FREELIST_RANDOM, but the
> -	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
> -	  10th order of pages is selected based on cache utilization
> -	  benefits on x86.
> +	  allocations, but the default granularity of shuffling on the
> +	  "MAX_ORDER - 1" i.e, 10th order of pages is selected based on
> +	  cache utilization benefits on x86.
>
>  	  While the randomization improves cache utilization it may
>  	  negatively impact workloads on platforms without a cache. For
> diff --git a/mm/Makefile b/mm/Makefile
> index 8e105e5b3e29..18b0bb245fc3 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -4,16 +4,12 @@
>  #
>
>  KASAN_SANITIZE_slab_common.o := n
> -KASAN_SANITIZE_slab.o := n
> -KASAN_SANITIZE_slub.o := n
>  KCSAN_SANITIZE_kmemleak.o := n
>
>  # These produce frequent data race reports: most of them are due to races on
>  # the same word but accesses to different bits of that word. Re-enable KCSAN
>  # for these when we have more consensus on what to do about them.
>  KCSAN_SANITIZE_slab_common.o := n
> -KCSAN_SANITIZE_slab.o := n
> -KCSAN_SANITIZE_slub.o := n
>  KCSAN_SANITIZE_page_alloc.o := n
>  # But enable explicit instrumentation for memory barriers.
>  KCSAN_INSTRUMENT_BARRIERS := y
> @@ -22,9 +18,6 @@ KCSAN_INSTRUMENT_BARRIERS := y
>  # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
>  # free pages, or a task is migrated between nodes.
>  KCOV_INSTRUMENT_slab_common.o := n
> -KCOV_INSTRUMENT_slob.o := n
> -KCOV_INSTRUMENT_slab.o := n
> -KCOV_INSTRUMENT_slub.o := n
>  KCOV_INSTRUMENT_page_alloc.o := n
>  KCOV_INSTRUMENT_debug-pagealloc.o := n
>  KCOV_INSTRUMENT_kmemleak.o := n
> @@ -81,12 +74,9 @@ obj-$(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)	+= hugetlb_vmemmap.o
>  obj-$(CONFIG_NUMA) 	+= mempolicy.o
>  obj-$(CONFIG_SPARSEMEM)	+= sparse.o
>  obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
> -obj-$(CONFIG_SLOB) += slob.o
>  obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
>  obj-$(CONFIG_KSM) += ksm.o
>  obj-$(CONFIG_PAGE_POISONING) += page_poison.o
> -obj-$(CONFIG_SLAB) += slab.o
> -obj-$(CONFIG_SLUB) += slub.o
>  obj-$(CONFIG_KASAN)	+= kasan/
>  obj-$(CONFIG_KFENCE) += kfence/
>  obj-$(CONFIG_KMSAN)	+= kmsan/
> diff --git a/mm/slab.c b/mm/slab.c
> deleted file mode 100644
> index edbe722fb906..000000000000
> --- a/mm/slab.c
> +++ /dev/null
> @@ -1,4046 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * linux/mm/slab.c
> - * Written by Mark Hemment, 1996/97.
> - * (markhe@nextd.demon.co.uk)
> - *
> - * kmem_cache_destroy() + some cleanup - 1999 Andrea Arcangeli
> - *
> - * Major cleanup, different bufctl logic, per-cpu arrays
> - *	(c) 2000 Manfred Spraul
> - *
> - * Cleanup, make the head arrays unconditional, preparation for NUMA
> - * 	(c) 2002 Manfred Spraul
> - *
> - * An implementation of the Slab Allocator as described in outline in;
> - *	UNIX Internals: The New Frontiers by Uresh Vahalia
> - *	Pub: Prentice Hall	ISBN 0-13-101908-2
> - * or with a little more detail in;
> - *	The Slab Allocator: An Object-Caching Kernel Memory Allocator
> - *	Jeff Bonwick (Sun Microsystems).
> - *	Presented at: USENIX Summer 1994 Technical Conference
> - *
> - * The memory is organized in caches, one cache for each object type.
> - * (e.g. inode_cache, dentry_cache, buffer_head, vm_area_struct)
> - * Each cache consists out of many slabs (they are small (usually one
> - * page long) and always contiguous), and each slab contains multiple
> - * initialized objects.
> - *
> - * This means, that your constructor is used only for newly allocated
> - * slabs and you must pass objects with the same initializations to
> - * kmem_cache_free.
> - *
> - * Each cache can only support one memory type (GFP_DMA, GFP_HIGHMEM,
> - * normal). If you need a special memory type, then must create a new
> - * cache for that memory type.
> - *
> - * In order to reduce fragmentation, the slabs are sorted in 3 groups:
> - *   full slabs with 0 free objects
> - *   partial slabs
> - *   empty slabs with no allocated objects
> - *
> - * If partial slabs exist, then new allocations come from these slabs,
> - * otherwise from empty slabs or new slabs are allocated.
> - *
> - * kmem_cache_destroy() CAN CRASH if you try to allocate from the cache
> - * during kmem_cache_destroy(). The caller must prevent concurrent allocs.
> - *
> - * Each cache has a short per-cpu head array, most allocs
> - * and frees go into that array, and if that array overflows, then 1/2
> - * of the entries in the array are given back into the global cache.
> - * The head array is strictly LIFO and should improve the cache hit rates.
> - * On SMP, it additionally reduces the spinlock operations.
> - *
> - * The c_cpuarray may not be read with enabled local interrupts -
> - * it's changed with a smp_call_function().
> - *
> - * SMP synchronization:
> - *  constructors and destructors are called without any locking.
> - *  Several members in struct kmem_cache and struct slab never change, they
> - *	are accessed without any locking.
> - *  The per-cpu arrays are never accessed from the wrong cpu, no locking,
> - *  	and local interrupts are disabled so slab code is preempt-safe.
> - *  The non-constant members are protected with a per-cache irq spinlock.
> - *
> - * Many thanks to Mark Hemment, who wrote another per-cpu slab patch
> - * in 2000 - many ideas in the current implementation are derived from
> - * his patch.
> - *
> - * Further notes from the original documentation:
> - *
> - * 11 April '97.  Started multi-threading - markhe
> - *	The global cache-chain is protected by the mutex 'slab_mutex'.
> - *	The sem is only needed when accessing/extending the cache-chain, which
> - *	can never happen inside an interrupt (kmem_cache_create(),
> - *	kmem_cache_shrink() and kmem_cache_reap()).
> - *
> - *	At present, each engine can be growing a cache.  This should be blocked.
> - *
> - * 15 March 2005. NUMA slab allocator.
> - *	Shai Fultheim <shai@scalex86.org>.
> - *	Shobhit Dayal <shobhit@calsoftinc.com>
> - *	Alok N Kataria <alokk@calsoftinc.com>
> - *	Christoph Lameter <christoph@lameter.com>
> - *
> - *	Modified the slab allocator to be node aware on NUMA systems.
> - *	Each node has its own list of partial, free and full slabs.
> - *	All object allocations for a node occur from node specific slab lists.
> - */
> -
> -#include	<linux/slab.h>
> -#include	<linux/mm.h>
> -#include	<linux/poison.h>
> -#include	<linux/swap.h>
> -#include	<linux/cache.h>
> -#include	<linux/interrupt.h>
> -#include	<linux/init.h>
> -#include	<linux/compiler.h>
> -#include	<linux/cpuset.h>
> -#include	<linux/proc_fs.h>
> -#include	<linux/seq_file.h>
> -#include	<linux/notifier.h>
> -#include	<linux/kallsyms.h>
> -#include	<linux/kfence.h>
> -#include	<linux/cpu.h>
> -#include	<linux/sysctl.h>
> -#include	<linux/module.h>
> -#include	<linux/rcupdate.h>
> -#include	<linux/string.h>
> -#include	<linux/uaccess.h>
> -#include	<linux/nodemask.h>
> -#include	<linux/kmemleak.h>
> -#include	<linux/mempolicy.h>
> -#include	<linux/mutex.h>
> -#include	<linux/fault-inject.h>
> -#include	<linux/rtmutex.h>
> -#include	<linux/reciprocal_div.h>
> -#include	<linux/debugobjects.h>
> -#include	<linux/memory.h>
> -#include	<linux/prefetch.h>
> -#include	<linux/sched/task_stack.h>
> -
> -#include	<net/sock.h>
> -
> -#include	<asm/cacheflush.h>
> -#include	<asm/tlbflush.h>
> -#include	<asm/page.h>
> -
> -#include <trace/events/kmem.h>
> -
> -#include	"internal.h"
> -
> -#include	"slab.h"
> -
> -/*
> - * DEBUG	- 1 for kmem_cache_create() to honour; SLAB_RED_ZONE & SLAB_POISON.
> - *		  0 for faster, smaller code (especially in the critical paths).
> - *
> - * STATS	- 1 to collect stats for /proc/slabinfo.
> - *		  0 for faster, smaller code (especially in the critical paths).
> - *
> - * FORCED_DEBUG	- 1 enables SLAB_RED_ZONE and SLAB_POISON (if possible)
> - */
> -
> -#ifdef CONFIG_DEBUG_SLAB
> -#define	DEBUG		1
> -#define	STATS		1
> -#define	FORCED_DEBUG	1
> -#else
> -#define	DEBUG		0
> -#define	STATS		0
> -#define	FORCED_DEBUG	0
> -#endif
> -
> -/* Shouldn't this be in a header file somewhere? */
> -#define	BYTES_PER_WORD		sizeof(void *)
> -#define	REDZONE_ALIGN		max(BYTES_PER_WORD, __alignof__(unsigned long long))
> -
> -#ifndef ARCH_KMALLOC_FLAGS
> -#define ARCH_KMALLOC_FLAGS SLAB_HWCACHE_ALIGN
> -#endif
> -
> -#define FREELIST_BYTE_INDEX (((PAGE_SIZE >> BITS_PER_BYTE) \
> -				<= SLAB_OBJ_MIN_SIZE) ? 1 : 0)
> -
> -#if FREELIST_BYTE_INDEX
> -typedef unsigned char freelist_idx_t;
> -#else
> -typedef unsigned short freelist_idx_t;
> -#endif
> -
> -#define SLAB_OBJ_MAX_NUM ((1 << sizeof(freelist_idx_t) * BITS_PER_BYTE) - 1)
> -
> -/*
> - * struct array_cache
> - *
> - * Purpose:
> - * - LIFO ordering, to hand out cache-warm objects from _alloc
> - * - reduce the number of linked list operations
> - * - reduce spinlock operations
> - *
> - * The limit is stored in the per-cpu structure to reduce the data cache
> - * footprint.
> - *
> - */
> -struct array_cache {
> -	unsigned int avail;
> -	unsigned int limit;
> -	unsigned int batchcount;
> -	unsigned int touched;
> -	void *entry[];	/*
> -			 * Must have this definition in here for the proper
> -			 * alignment of array_cache. Also simplifies accessing
> -			 * the entries.
> -			 */
> -};
> -
> -struct alien_cache {
> -	spinlock_t lock;
> -	struct array_cache ac;
> -};
> -
> -/*
> - * Need this for bootstrapping a per node allocator.
> - */
> -#define NUM_INIT_LISTS (2 * MAX_NUMNODES)
> -static struct kmem_cache_node __initdata init_kmem_cache_node[NUM_INIT_LISTS];
> -#define	CACHE_CACHE 0
> -#define	SIZE_NODE (MAX_NUMNODES)
> -
> -static int drain_freelist(struct kmem_cache *cache,
> -			struct kmem_cache_node *n, int tofree);
> -static void free_block(struct kmem_cache *cachep, void **objpp, int len,
> -			int node, struct list_head *list);
> -static void slabs_destroy(struct kmem_cache *cachep, struct list_head *list);
> -static int enable_cpucache(struct kmem_cache *cachep, gfp_t gfp);
> -static void cache_reap(struct work_struct *unused);
> -
> -static inline void fixup_objfreelist_debug(struct kmem_cache *cachep,
> -						void **list);
> -static inline void fixup_slab_list(struct kmem_cache *cachep,
> -				struct kmem_cache_node *n, struct slab *slab,
> -				void **list);
> -
> -#define INDEX_NODE kmalloc_index(sizeof(struct kmem_cache_node))
> -
> -static void kmem_cache_node_init(struct kmem_cache_node *parent)
> -{
> -	INIT_LIST_HEAD(&parent->slabs_full);
> -	INIT_LIST_HEAD(&parent->slabs_partial);
> -	INIT_LIST_HEAD(&parent->slabs_free);
> -	parent->total_slabs = 0;
> -	parent->free_slabs = 0;
> -	parent->shared = NULL;
> -	parent->alien = NULL;
> -	parent->colour_next = 0;
> -	raw_spin_lock_init(&parent->list_lock);
> -	parent->free_objects = 0;
> -	parent->free_touched = 0;
> -}
> -
> -#define MAKE_LIST(cachep, listp, slab, nodeid)				\
> -	do {								\
> -		INIT_LIST_HEAD(listp);					\
> -		list_splice(&get_node(cachep, nodeid)->slab, listp);	\
> -	} while (0)
> -
> -#define	MAKE_ALL_LISTS(cachep, ptr, nodeid)				\
> -	do {								\
> -	MAKE_LIST((cachep), (&(ptr)->slabs_full), slabs_full, nodeid);	\
> -	MAKE_LIST((cachep), (&(ptr)->slabs_partial), slabs_partial, nodeid); \
> -	MAKE_LIST((cachep), (&(ptr)->slabs_free), slabs_free, nodeid);	\
> -	} while (0)
> -
> -#define CFLGS_OBJFREELIST_SLAB	((slab_flags_t __force)0x40000000U)
> -#define CFLGS_OFF_SLAB		((slab_flags_t __force)0x80000000U)
> -#define	OBJFREELIST_SLAB(x)	((x)->flags & CFLGS_OBJFREELIST_SLAB)
> -#define	OFF_SLAB(x)	((x)->flags & CFLGS_OFF_SLAB)
> -
> -#define BATCHREFILL_LIMIT	16
> -/*
> - * Optimization question: fewer reaps means less probability for unnecessary
> - * cpucache drain/refill cycles.
> - *
> - * OTOH the cpuarrays can contain lots of objects,
> - * which could lock up otherwise freeable slabs.
> - */
> -#define REAPTIMEOUT_AC		(2*HZ)
> -#define REAPTIMEOUT_NODE	(4*HZ)
> -
> -#if STATS
> -#define	STATS_INC_ACTIVE(x)	((x)->num_active++)
> -#define	STATS_DEC_ACTIVE(x)	((x)->num_active--)
> -#define	STATS_INC_ALLOCED(x)	((x)->num_allocations++)
> -#define	STATS_INC_GROWN(x)	((x)->grown++)
> -#define	STATS_ADD_REAPED(x, y)	((x)->reaped += (y))
> -#define	STATS_SET_HIGH(x)						\
> -	do {								\
> -		if ((x)->num_active > (x)->high_mark)			\
> -			(x)->high_mark = (x)->num_active;		\
> -	} while (0)
> -#define	STATS_INC_ERR(x)	((x)->errors++)
> -#define	STATS_INC_NODEALLOCS(x)	((x)->node_allocs++)
> -#define	STATS_INC_NODEFREES(x)	((x)->node_frees++)
> -#define STATS_INC_ACOVERFLOW(x)   ((x)->node_overflow++)
> -#define	STATS_SET_FREEABLE(x, i)					\
> -	do {								\
> -		if ((x)->max_freeable < i)				\
> -			(x)->max_freeable = i;				\
> -	} while (0)
> -#define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
> -#define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss)
> -#define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
> -#define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss)
> -#else
> -#define	STATS_INC_ACTIVE(x)	do { } while (0)
> -#define	STATS_DEC_ACTIVE(x)	do { } while (0)
> -#define	STATS_INC_ALLOCED(x)	do { } while (0)
> -#define	STATS_INC_GROWN(x)	do { } while (0)
> -#define	STATS_ADD_REAPED(x, y)	do { (void)(y); } while (0)
> -#define	STATS_SET_HIGH(x)	do { } while (0)
> -#define	STATS_INC_ERR(x)	do { } while (0)
> -#define	STATS_INC_NODEALLOCS(x)	do { } while (0)
> -#define	STATS_INC_NODEFREES(x)	do { } while (0)
> -#define STATS_INC_ACOVERFLOW(x)   do { } while (0)
> -#define	STATS_SET_FREEABLE(x, i) do { } while (0)
> -#define STATS_INC_ALLOCHIT(x)	do { } while (0)
> -#define STATS_INC_ALLOCMISS(x)	do { } while (0)
> -#define STATS_INC_FREEHIT(x)	do { } while (0)
> -#define STATS_INC_FREEMISS(x)	do { } while (0)
> -#endif
> -
> -#if DEBUG
> -
> -/*
> - * memory layout of objects:
> - * 0		: objp
> - * 0 .. cachep->obj_offset - BYTES_PER_WORD - 1: padding. This ensures that
> - * 		the end of an object is aligned with the end of the real
> - * 		allocation. Catches writes behind the end of the allocation.
> - * cachep->obj_offset - BYTES_PER_WORD .. cachep->obj_offset - 1:
> - * 		redzone word.
> - * cachep->obj_offset: The real object.
> - * cachep->size - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
> - * cachep->size - 1* BYTES_PER_WORD: last caller address
> - *					[BYTES_PER_WORD long]
> - */
> -static int obj_offset(struct kmem_cache *cachep)
> -{
> -	return cachep->obj_offset;
> -}
> -
> -static unsigned long long *dbg_redzone1(struct kmem_cache *cachep, void *objp)
> -{
> -	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
> -	return (unsigned long long *) (objp + obj_offset(cachep) -
> -				      sizeof(unsigned long long));
> -}
> -
> -static unsigned long long *dbg_redzone2(struct kmem_cache *cachep, void *objp)
> -{
> -	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
> -	if (cachep->flags & SLAB_STORE_USER)
> -		return (unsigned long long *)(objp + cachep->size -
> -					      sizeof(unsigned long long) -
> -					      REDZONE_ALIGN);
> -	return (unsigned long long *) (objp + cachep->size -
> -				       sizeof(unsigned long long));
> -}
> -
> -static void **dbg_userword(struct kmem_cache *cachep, void *objp)
> -{
> -	BUG_ON(!(cachep->flags & SLAB_STORE_USER));
> -	return (void **)(objp + cachep->size - BYTES_PER_WORD);
> -}
> -
> -#else
> -
> -#define obj_offset(x)			0
> -#define dbg_redzone1(cachep, objp)	({BUG(); (unsigned long long *)NULL;})
> -#define dbg_redzone2(cachep, objp)	({BUG(); (unsigned long long *)NULL;})
> -#define dbg_userword(cachep, objp)	({BUG(); (void **)NULL;})
> -
> -#endif
> -
> -/*
> - * Do not go above this order unless 0 objects fit into the slab or
> - * overridden on the command line.
> - */
> -#define	SLAB_MAX_ORDER_HI	1
> -#define	SLAB_MAX_ORDER_LO	0
> -static int slab_max_order = SLAB_MAX_ORDER_LO;
> -static bool slab_max_order_set __initdata;
> -
> -static inline void *index_to_obj(struct kmem_cache *cache,
> -				 const struct slab *slab, unsigned int idx)
> -{
> -	return slab->s_mem + cache->size * idx;
> -}
> -
> -#define BOOT_CPUCACHE_ENTRIES	1
> -/* internal cache of cache description objs */
> -static struct kmem_cache kmem_cache_boot = {
> -	.batchcount = 1,
> -	.limit = BOOT_CPUCACHE_ENTRIES,
> -	.shared = 1,
> -	.size = sizeof(struct kmem_cache),
> -	.name = "kmem_cache",
> -};
> -
> -static DEFINE_PER_CPU(struct delayed_work, slab_reap_work);
> -
> -static inline struct array_cache *cpu_cache_get(struct kmem_cache *cachep)
> -{
> -	return this_cpu_ptr(cachep->cpu_cache);
> -}
> -
> -/*
> - * Calculate the number of objects and left-over bytes for a given buffer size.
> - */
> -static unsigned int cache_estimate(unsigned long gfporder, size_t buffer_size,
> -		slab_flags_t flags, size_t *left_over)
> -{
> -	unsigned int num;
> -	size_t slab_size = PAGE_SIZE << gfporder;
> -
> -	/*
> -	 * The slab management structure can be either off the slab or
> -	 * on it. For the latter case, the memory allocated for a
> -	 * slab is used for:
> -	 *
> -	 * - @buffer_size bytes for each object
> -	 * - One freelist_idx_t for each object
> -	 *
> -	 * We don't need to consider alignment of freelist because
> -	 * freelist will be at the end of slab page. The objects will be
> -	 * at the correct alignment.
> -	 *
> -	 * If the slab management structure is off the slab, then the
> -	 * alignment will already be calculated into the size. Because
> -	 * the slabs are all pages aligned, the objects will be at the
> -	 * correct alignment when allocated.
> -	 */
> -	if (flags & (CFLGS_OBJFREELIST_SLAB | CFLGS_OFF_SLAB)) {
> -		num = slab_size / buffer_size;
> -		*left_over = slab_size % buffer_size;
> -	} else {
> -		num = slab_size / (buffer_size + sizeof(freelist_idx_t));
> -		*left_over = slab_size %
> -			(buffer_size + sizeof(freelist_idx_t));
> -	}
> -
> -	return num;
> -}
> -
> -#if DEBUG
> -#define slab_error(cachep, msg) __slab_error(__func__, cachep, msg)
> -
> -static void __slab_error(const char *function, struct kmem_cache *cachep,
> -			char *msg)
> -{
> -	pr_err("slab error in %s(): cache `%s': %s\n",
> -	       function, cachep->name, msg);
> -	dump_stack();
> -	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> -}
> -#endif
> -
> -/*
> - * By default on NUMA we use alien caches to stage the freeing of
> - * objects allocated from other nodes. This causes massive memory
> - * inefficiencies when using fake NUMA setup to split memory into a
> - * large number of small nodes, so it can be disabled on the command
> - * line
> -  */
> -
> -static int use_alien_caches __read_mostly = 1;
> -static int __init noaliencache_setup(char *s)
> -{
> -	use_alien_caches = 0;
> -	return 1;
> -}
> -__setup("noaliencache", noaliencache_setup);
> -
> -static int __init slab_max_order_setup(char *str)
> -{
> -	get_option(&str, &slab_max_order);
> -	slab_max_order = slab_max_order < 0 ? 0 :
> -				min(slab_max_order, MAX_ORDER - 1);
> -	slab_max_order_set = true;
> -
> -	return 1;
> -}
> -__setup("slab_max_order=", slab_max_order_setup);
> -
> -#ifdef CONFIG_NUMA
> -/*
> - * Special reaping functions for NUMA systems called from cache_reap().
> - * These take care of doing round robin flushing of alien caches (containing
> - * objects freed on different nodes from which they were allocated) and the
> - * flushing of remote pcps by calling drain_node_pages.
> - */
> -static DEFINE_PER_CPU(unsigned long, slab_reap_node);
> -
> -static void init_reap_node(int cpu)
> -{
> -	per_cpu(slab_reap_node, cpu) = next_node_in(cpu_to_mem(cpu),
> -						    node_online_map);
> -}
> -
> -static void next_reap_node(void)
> -{
> -	int node = __this_cpu_read(slab_reap_node);
> -
> -	node = next_node_in(node, node_online_map);
> -	__this_cpu_write(slab_reap_node, node);
> -}
> -
> -#else
> -#define init_reap_node(cpu) do { } while (0)
> -#define next_reap_node(void) do { } while (0)
> -#endif
> -
> -/*
> - * Initiate the reap timer running on the target CPU.  We run at around 1 to 2Hz
> - * via the workqueue/eventd.
> - * Add the CPU number into the expiration time to minimize the possibility of
> - * the CPUs getting into lockstep and contending for the global cache chain
> - * lock.
> - */
> -static void start_cpu_timer(int cpu)
> -{
> -	struct delayed_work *reap_work = &per_cpu(slab_reap_work, cpu);
> -
> -	if (reap_work->work.func == NULL) {
> -		init_reap_node(cpu);
> -		INIT_DEFERRABLE_WORK(reap_work, cache_reap);
> -		schedule_delayed_work_on(cpu, reap_work,
> -					__round_jiffies_relative(HZ, cpu));
> -	}
> -}
> -
> -static void init_arraycache(struct array_cache *ac, int limit, int batch)
> -{
> -	if (ac) {
> -		ac->avail = 0;
> -		ac->limit = limit;
> -		ac->batchcount = batch;
> -		ac->touched = 0;
> -	}
> -}
> -
> -static struct array_cache *alloc_arraycache(int node, int entries,
> -					    int batchcount, gfp_t gfp)
> -{
> -	size_t memsize = sizeof(void *) * entries + sizeof(struct array_cache);
> -	struct array_cache *ac = NULL;
> -
> -	ac = kmalloc_node(memsize, gfp, node);
> -	/*
> -	 * The array_cache structures contain pointers to free object.
> -	 * However, when such objects are allocated or transferred to another
> -	 * cache the pointers are not cleared and they could be counted as
> -	 * valid references during a kmemleak scan. Therefore, kmemleak must
> -	 * not scan such objects.
> -	 */
> -	kmemleak_no_scan(ac);
> -	init_arraycache(ac, entries, batchcount);
> -	return ac;
> -}
> -
> -static noinline void cache_free_pfmemalloc(struct kmem_cache *cachep,
> -					struct slab *slab, void *objp)
> -{
> -	struct kmem_cache_node *n;
> -	int slab_node;
> -	LIST_HEAD(list);
> -
> -	slab_node = slab_nid(slab);
> -	n = get_node(cachep, slab_node);
> -
> -	raw_spin_lock(&n->list_lock);
> -	free_block(cachep, &objp, 1, slab_node, &list);
> -	raw_spin_unlock(&n->list_lock);
> -
> -	slabs_destroy(cachep, &list);
> -}
> -
> -/*
> - * Transfer objects in one arraycache to another.
> - * Locking must be handled by the caller.
> - *
> - * Return the number of entries transferred.
> - */
> -static int transfer_objects(struct array_cache *to,
> -		struct array_cache *from, unsigned int max)
> -{
> -	/* Figure out how many entries to transfer */
> -	int nr = min3(from->avail, max, to->limit - to->avail);
> -
> -	if (!nr)
> -		return 0;
> -
> -	memcpy(to->entry + to->avail, from->entry + from->avail - nr,
> -			sizeof(void *) *nr);
> -
> -	from->avail -= nr;
> -	to->avail += nr;
> -	return nr;
> -}
> -
> -/* &alien->lock must be held by alien callers. */
> -static __always_inline void __free_one(struct array_cache *ac, void *objp)
> -{
> -	/* Avoid trivial double-free. */
> -	if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> -	    WARN_ON_ONCE(ac->avail > 0 && ac->entry[ac->avail - 1] == objp))
> -		return;
> -	ac->entry[ac->avail++] = objp;
> -}
> -
> -#ifndef CONFIG_NUMA
> -
> -#define drain_alien_cache(cachep, alien) do { } while (0)
> -#define reap_alien(cachep, n) do { } while (0)
> -
> -static inline struct alien_cache **alloc_alien_cache(int node,
> -						int limit, gfp_t gfp)
> -{
> -	return NULL;
> -}
> -
> -static inline void free_alien_cache(struct alien_cache **ac_ptr)
> -{
> -}
> -
> -static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
> -{
> -	return 0;
> -}
> -
> -static inline gfp_t gfp_exact_node(gfp_t flags)
> -{
> -	return flags & ~__GFP_NOFAIL;
> -}
> -
> -#else	/* CONFIG_NUMA */
> -
> -static struct alien_cache *__alloc_alien_cache(int node, int entries,
> -						int batch, gfp_t gfp)
> -{
> -	size_t memsize = sizeof(void *) * entries + sizeof(struct alien_cache);
> -	struct alien_cache *alc = NULL;
> -
> -	alc = kmalloc_node(memsize, gfp, node);
> -	if (alc) {
> -		kmemleak_no_scan(alc);
> -		init_arraycache(&alc->ac, entries, batch);
> -		spin_lock_init(&alc->lock);
> -	}
> -	return alc;
> -}
> -
> -static struct alien_cache **alloc_alien_cache(int node, int limit, gfp_t gfp)
> -{
> -	struct alien_cache **alc_ptr;
> -	int i;
> -
> -	if (limit > 1)
> -		limit = 12;
> -	alc_ptr = kcalloc_node(nr_node_ids, sizeof(void *), gfp, node);
> -	if (!alc_ptr)
> -		return NULL;
> -
> -	for_each_node(i) {
> -		if (i == node || !node_online(i))
> -			continue;
> -		alc_ptr[i] = __alloc_alien_cache(node, limit, 0xbaadf00d, gfp);
> -		if (!alc_ptr[i]) {
> -			for (i--; i >= 0; i--)
> -				kfree(alc_ptr[i]);
> -			kfree(alc_ptr);
> -			return NULL;
> -		}
> -	}
> -	return alc_ptr;
> -}
> -
> -static void free_alien_cache(struct alien_cache **alc_ptr)
> -{
> -	int i;
> -
> -	if (!alc_ptr)
> -		return;
> -	for_each_node(i)
> -	    kfree(alc_ptr[i]);
> -	kfree(alc_ptr);
> -}
> -
> -static void __drain_alien_cache(struct kmem_cache *cachep,
> -				struct array_cache *ac, int node,
> -				struct list_head *list)
> -{
> -	struct kmem_cache_node *n = get_node(cachep, node);
> -
> -	if (ac->avail) {
> -		raw_spin_lock(&n->list_lock);
> -		/*
> -		 * Stuff objects into the remote nodes shared array first.
> -		 * That way we could avoid the overhead of putting the objects
> -		 * into the free lists and getting them back later.
> -		 */
> -		if (n->shared)
> -			transfer_objects(n->shared, ac, ac->limit);
> -
> -		free_block(cachep, ac->entry, ac->avail, node, list);
> -		ac->avail = 0;
> -		raw_spin_unlock(&n->list_lock);
> -	}
> -}
> -
> -/*
> - * Called from cache_reap() to regularly drain alien caches round robin.
> - */
> -static void reap_alien(struct kmem_cache *cachep, struct kmem_cache_node *n)
> -{
> -	int node = __this_cpu_read(slab_reap_node);
> -
> -	if (n->alien) {
> -		struct alien_cache *alc = n->alien[node];
> -		struct array_cache *ac;
> -
> -		if (alc) {
> -			ac = &alc->ac;
> -			if (ac->avail && spin_trylock_irq(&alc->lock)) {
> -				LIST_HEAD(list);
> -
> -				__drain_alien_cache(cachep, ac, node, &list);
> -				spin_unlock_irq(&alc->lock);
> -				slabs_destroy(cachep, &list);
> -			}
> -		}
> -	}
> -}
> -
> -static void drain_alien_cache(struct kmem_cache *cachep,
> -				struct alien_cache **alien)
> -{
> -	int i = 0;
> -	struct alien_cache *alc;
> -	struct array_cache *ac;
> -	unsigned long flags;
> -
> -	for_each_online_node(i) {
> -		alc = alien[i];
> -		if (alc) {
> -			LIST_HEAD(list);
> -
> -			ac = &alc->ac;
> -			spin_lock_irqsave(&alc->lock, flags);
> -			__drain_alien_cache(cachep, ac, i, &list);
> -			spin_unlock_irqrestore(&alc->lock, flags);
> -			slabs_destroy(cachep, &list);
> -		}
> -	}
> -}
> -
> -static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
> -				int node, int slab_node)
> -{
> -	struct kmem_cache_node *n;
> -	struct alien_cache *alien = NULL;
> -	struct array_cache *ac;
> -	LIST_HEAD(list);
> -
> -	n = get_node(cachep, node);
> -	STATS_INC_NODEFREES(cachep);
> -	if (n->alien && n->alien[slab_node]) {
> -		alien = n->alien[slab_node];
> -		ac = &alien->ac;
> -		spin_lock(&alien->lock);
> -		if (unlikely(ac->avail == ac->limit)) {
> -			STATS_INC_ACOVERFLOW(cachep);
> -			__drain_alien_cache(cachep, ac, slab_node, &list);
> -		}
> -		__free_one(ac, objp);
> -		spin_unlock(&alien->lock);
> -		slabs_destroy(cachep, &list);
> -	} else {
> -		n = get_node(cachep, slab_node);
> -		raw_spin_lock(&n->list_lock);
> -		free_block(cachep, &objp, 1, slab_node, &list);
> -		raw_spin_unlock(&n->list_lock);
> -		slabs_destroy(cachep, &list);
> -	}
> -	return 1;
> -}
> -
> -static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
> -{
> -	int slab_node = slab_nid(virt_to_slab(objp));
> -	int node = numa_mem_id();
> -	/*
> -	 * Make sure we are not freeing an object from another node to the array
> -	 * cache on this cpu.
> -	 */
> -	if (likely(node == slab_node))
> -		return 0;
> -
> -	return __cache_free_alien(cachep, objp, node, slab_node);
> -}
> -
> -/*
> - * Construct gfp mask to allocate from a specific node but do not reclaim or
> - * warn about failures.
> - */
> -static inline gfp_t gfp_exact_node(gfp_t flags)
> -{
> -	return (flags | __GFP_THISNODE | __GFP_NOWARN) & ~(__GFP_RECLAIM|__GFP_NOFAIL);
> -}
> -#endif
> -
> -static int init_cache_node(struct kmem_cache *cachep, int node, gfp_t gfp)
> -{
> -	struct kmem_cache_node *n;
> -
> -	/*
> -	 * Set up the kmem_cache_node for cpu before we can
> -	 * begin anything. Make sure some other cpu on this
> -	 * node has not already allocated this
> -	 */
> -	n = get_node(cachep, node);
> -	if (n) {
> -		raw_spin_lock_irq(&n->list_lock);
> -		n->free_limit = (1 + nr_cpus_node(node)) * cachep->batchcount +
> -				cachep->num;
> -		raw_spin_unlock_irq(&n->list_lock);
> -
> -		return 0;
> -	}
> -
> -	n = kmalloc_node(sizeof(struct kmem_cache_node), gfp, node);
> -	if (!n)
> -		return -ENOMEM;
> -
> -	kmem_cache_node_init(n);
> -	n->next_reap = jiffies + REAPTIMEOUT_NODE +
> -		    ((unsigned long)cachep) % REAPTIMEOUT_NODE;
> -
> -	n->free_limit =
> -		(1 + nr_cpus_node(node)) * cachep->batchcount + cachep->num;
> -
> -	/*
> -	 * The kmem_cache_nodes don't come and go as CPUs
> -	 * come and go.  slab_mutex provides sufficient
> -	 * protection here.
> -	 */
> -	cachep->node[node] = n;
> -
> -	return 0;
> -}
> -
> -#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)
> -/*
> - * Allocates and initializes node for a node on each slab cache, used for
> - * either memory or cpu hotplug.  If memory is being hot-added, the kmem_cache_node
> - * will be allocated off-node since memory is not yet online for the new node.
> - * When hotplugging memory or a cpu, existing nodes are not replaced if
> - * already in use.
> - *
> - * Must hold slab_mutex.
> - */
> -static int init_cache_node_node(int node)
> -{
> -	int ret;
> -	struct kmem_cache *cachep;
> -
> -	list_for_each_entry(cachep, &slab_caches, list) {
> -		ret = init_cache_node(cachep, node, GFP_KERNEL);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -#endif
> -
> -static int setup_kmem_cache_node(struct kmem_cache *cachep,
> -				int node, gfp_t gfp, bool force_change)
> -{
> -	int ret = -ENOMEM;
> -	struct kmem_cache_node *n;
> -	struct array_cache *old_shared = NULL;
> -	struct array_cache *new_shared = NULL;
> -	struct alien_cache **new_alien = NULL;
> -	LIST_HEAD(list);
> -
> -	if (use_alien_caches) {
> -		new_alien = alloc_alien_cache(node, cachep->limit, gfp);
> -		if (!new_alien)
> -			goto fail;
> -	}
> -
> -	if (cachep->shared) {
> -		new_shared = alloc_arraycache(node,
> -			cachep->shared * cachep->batchcount, 0xbaadf00d, gfp);
> -		if (!new_shared)
> -			goto fail;
> -	}
> -
> -	ret = init_cache_node(cachep, node, gfp);
> -	if (ret)
> -		goto fail;
> -
> -	n = get_node(cachep, node);
> -	raw_spin_lock_irq(&n->list_lock);
> -	if (n->shared && force_change) {
> -		free_block(cachep, n->shared->entry,
> -				n->shared->avail, node, &list);
> -		n->shared->avail = 0;
> -	}
> -
> -	if (!n->shared || force_change) {
> -		old_shared = n->shared;
> -		n->shared = new_shared;
> -		new_shared = NULL;
> -	}
> -
> -	if (!n->alien) {
> -		n->alien = new_alien;
> -		new_alien = NULL;
> -	}
> -
> -	raw_spin_unlock_irq(&n->list_lock);
> -	slabs_destroy(cachep, &list);
> -
> -	/*
> -	 * To protect lockless access to n->shared during irq disabled context.
> -	 * If n->shared isn't NULL in irq disabled context, accessing to it is
> -	 * guaranteed to be valid until irq is re-enabled, because it will be
> -	 * freed after synchronize_rcu().
> -	 */
> -	if (old_shared && force_change)
> -		synchronize_rcu();
> -
> -fail:
> -	kfree(old_shared);
> -	kfree(new_shared);
> -	free_alien_cache(new_alien);
> -
> -	return ret;
> -}
> -
> -#ifdef CONFIG_SMP
> -
> -static void cpuup_canceled(long cpu)
> -{
> -	struct kmem_cache *cachep;
> -	struct kmem_cache_node *n = NULL;
> -	int node = cpu_to_mem(cpu);
> -	const struct cpumask *mask = cpumask_of_node(node);
> -
> -	list_for_each_entry(cachep, &slab_caches, list) {
> -		struct array_cache *nc;
> -		struct array_cache *shared;
> -		struct alien_cache **alien;
> -		LIST_HEAD(list);
> -
> -		n = get_node(cachep, node);
> -		if (!n)
> -			continue;
> -
> -		raw_spin_lock_irq(&n->list_lock);
> -
> -		/* Free limit for this kmem_cache_node */
> -		n->free_limit -= cachep->batchcount;
> -
> -		/* cpu is dead; no one can alloc from it. */
> -		nc = per_cpu_ptr(cachep->cpu_cache, cpu);
> -		free_block(cachep, nc->entry, nc->avail, node, &list);
> -		nc->avail = 0;
> -
> -		if (!cpumask_empty(mask)) {
> -			raw_spin_unlock_irq(&n->list_lock);
> -			goto free_slab;
> -		}
> -
> -		shared = n->shared;
> -		if (shared) {
> -			free_block(cachep, shared->entry,
> -				   shared->avail, node, &list);
> -			n->shared = NULL;
> -		}
> -
> -		alien = n->alien;
> -		n->alien = NULL;
> -
> -		raw_spin_unlock_irq(&n->list_lock);
> -
> -		kfree(shared);
> -		if (alien) {
> -			drain_alien_cache(cachep, alien);
> -			free_alien_cache(alien);
> -		}
> -
> -free_slab:
> -		slabs_destroy(cachep, &list);
> -	}
> -	/*
> -	 * In the previous loop, all the objects were freed to
> -	 * the respective cache's slabs,  now we can go ahead and
> -	 * shrink each nodelist to its limit.
> -	 */
> -	list_for_each_entry(cachep, &slab_caches, list) {
> -		n = get_node(cachep, node);
> -		if (!n)
> -			continue;
> -		drain_freelist(cachep, n, INT_MAX);
> -	}
> -}
> -
> -static int cpuup_prepare(long cpu)
> -{
> -	struct kmem_cache *cachep;
> -	int node = cpu_to_mem(cpu);
> -	int err;
> -
> -	/*
> -	 * We need to do this right in the beginning since
> -	 * alloc_arraycache's are going to use this list.
> -	 * kmalloc_node allows us to add the slab to the right
> -	 * kmem_cache_node and not this cpu's kmem_cache_node
> -	 */
> -	err = init_cache_node_node(node);
> -	if (err < 0)
> -		goto bad;
> -
> -	/*
> -	 * Now we can go ahead with allocating the shared arrays and
> -	 * array caches
> -	 */
> -	list_for_each_entry(cachep, &slab_caches, list) {
> -		err = setup_kmem_cache_node(cachep, node, GFP_KERNEL, false);
> -		if (err)
> -			goto bad;
> -	}
> -
> -	return 0;
> -bad:
> -	cpuup_canceled(cpu);
> -	return -ENOMEM;
> -}
> -
> -int slab_prepare_cpu(unsigned int cpu)
> -{
> -	int err;
> -
> -	mutex_lock(&slab_mutex);
> -	err = cpuup_prepare(cpu);
> -	mutex_unlock(&slab_mutex);
> -	return err;
> -}
> -
> -/*
> - * This is called for a failed online attempt and for a successful
> - * offline.
> - *
> - * Even if all the cpus of a node are down, we don't free the
> - * kmem_cache_node of any cache. This is to avoid a race between cpu_down, and
> - * a kmalloc allocation from another cpu for memory from the node of
> - * the cpu going down.  The kmem_cache_node structure is usually allocated from
> - * kmem_cache_create() and gets destroyed at kmem_cache_destroy().
> - */
> -int slab_dead_cpu(unsigned int cpu)
> -{
> -	mutex_lock(&slab_mutex);
> -	cpuup_canceled(cpu);
> -	mutex_unlock(&slab_mutex);
> -	return 0;
> -}
> -#endif
> -
> -static int slab_online_cpu(unsigned int cpu)
> -{
> -	start_cpu_timer(cpu);
> -	return 0;
> -}
> -
> -static int slab_offline_cpu(unsigned int cpu)
> -{
> -	/*
> -	 * Shutdown cache reaper. Note that the slab_mutex is held so
> -	 * that if cache_reap() is invoked it cannot do anything
> -	 * expensive but will only modify reap_work and reschedule the
> -	 * timer.
> -	 */
> -	cancel_delayed_work_sync(&per_cpu(slab_reap_work, cpu));
> -	/* Now the cache_reaper is guaranteed to be not running. */
> -	per_cpu(slab_reap_work, cpu).work.func = NULL;
> -	return 0;
> -}
> -
> -#if defined(CONFIG_NUMA)
> -/*
> - * Drains freelist for a node on each slab cache, used for memory hot-remove.
> - * Returns -EBUSY if all objects cannot be drained so that the node is not
> - * removed.
> - *
> - * Must hold slab_mutex.
> - */
> -static int __meminit drain_cache_node_node(int node)
> -{
> -	struct kmem_cache *cachep;
> -	int ret = 0;
> -
> -	list_for_each_entry(cachep, &slab_caches, list) {
> -		struct kmem_cache_node *n;
> -
> -		n = get_node(cachep, node);
> -		if (!n)
> -			continue;
> -
> -		drain_freelist(cachep, n, INT_MAX);
> -
> -		if (!list_empty(&n->slabs_full) ||
> -		    !list_empty(&n->slabs_partial)) {
> -			ret = -EBUSY;
> -			break;
> -		}
> -	}
> -	return ret;
> -}
> -
> -static int __meminit slab_memory_callback(struct notifier_block *self,
> -					unsigned long action, void *arg)
> -{
> -	struct memory_notify *mnb = arg;
> -	int ret = 0;
> -	int nid;
> -
> -	nid = mnb->status_change_nid;
> -	if (nid < 0)
> -		goto out;
> -
> -	switch (action) {
> -	case MEM_GOING_ONLINE:
> -		mutex_lock(&slab_mutex);
> -		ret = init_cache_node_node(nid);
> -		mutex_unlock(&slab_mutex);
> -		break;
> -	case MEM_GOING_OFFLINE:
> -		mutex_lock(&slab_mutex);
> -		ret = drain_cache_node_node(nid);
> -		mutex_unlock(&slab_mutex);
> -		break;
> -	case MEM_ONLINE:
> -	case MEM_OFFLINE:
> -	case MEM_CANCEL_ONLINE:
> -	case MEM_CANCEL_OFFLINE:
> -		break;
> -	}
> -out:
> -	return notifier_from_errno(ret);
> -}
> -#endif /* CONFIG_NUMA */
> -
> -/*
> - * swap the static kmem_cache_node with kmalloced memory
> - */
> -static void __init init_list(struct kmem_cache *cachep, struct kmem_cache_node *list,
> -				int nodeid)
> -{
> -	struct kmem_cache_node *ptr;
> -
> -	ptr = kmalloc_node(sizeof(struct kmem_cache_node), GFP_NOWAIT, nodeid);
> -	BUG_ON(!ptr);
> -
> -	memcpy(ptr, list, sizeof(struct kmem_cache_node));
> -	/*
> -	 * Do not assume that spinlocks can be initialized via memcpy:
> -	 */
> -	raw_spin_lock_init(&ptr->list_lock);
> -
> -	MAKE_ALL_LISTS(cachep, ptr, nodeid);
> -	cachep->node[nodeid] = ptr;
> -}
> -
> -/*
> - * For setting up all the kmem_cache_node for cache whose buffer_size is same as
> - * size of kmem_cache_node.
> - */
> -static void __init set_up_node(struct kmem_cache *cachep, int index)
> -{
> -	int node;
> -
> -	for_each_online_node(node) {
> -		cachep->node[node] = &init_kmem_cache_node[index + node];
> -		cachep->node[node]->next_reap = jiffies +
> -		    REAPTIMEOUT_NODE +
> -		    ((unsigned long)cachep) % REAPTIMEOUT_NODE;
> -	}
> -}
> -
> -/*
> - * Initialisation.  Called after the page allocator have been initialised and
> - * before smp_init().
> - */
> -void __init kmem_cache_init(void)
> -{
> -	int i;
> -
> -	kmem_cache = &kmem_cache_boot;
> -
> -	if (!IS_ENABLED(CONFIG_NUMA) || num_possible_nodes() == 1)
> -		use_alien_caches = 0;
> -
> -	for (i = 0; i < NUM_INIT_LISTS; i++)
> -		kmem_cache_node_init(&init_kmem_cache_node[i]);
> -
> -	/*
> -	 * Fragmentation resistance on low memory - only use bigger
> -	 * page orders on machines with more than 32MB of memory if
> -	 * not overridden on the command line.
> -	 */
> -	if (!slab_max_order_set && totalram_pages() > (32 << 20) >> PAGE_SHIFT)
> -		slab_max_order = SLAB_MAX_ORDER_HI;
> -
> -	/* Bootstrap is tricky, because several objects are allocated
> -	 * from caches that do not exist yet:
> -	 * 1) initialize the kmem_cache cache: it contains the struct
> -	 *    kmem_cache structures of all caches, except kmem_cache itself:
> -	 *    kmem_cache is statically allocated.
> -	 *    Initially an __init data area is used for the head array and the
> -	 *    kmem_cache_node structures, it's replaced with a kmalloc allocated
> -	 *    array at the end of the bootstrap.
> -	 * 2) Create the first kmalloc cache.
> -	 *    The struct kmem_cache for the new cache is allocated normally.
> -	 *    An __init data area is used for the head array.
> -	 * 3) Create the remaining kmalloc caches, with minimally sized
> -	 *    head arrays.
> -	 * 4) Replace the __init data head arrays for kmem_cache and the first
> -	 *    kmalloc cache with kmalloc allocated arrays.
> -	 * 5) Replace the __init data for kmem_cache_node for kmem_cache and
> -	 *    the other cache's with kmalloc allocated memory.
> -	 * 6) Resize the head arrays of the kmalloc caches to their final sizes.
> -	 */
> -
> -	/* 1) create the kmem_cache */
> -
> -	/*
> -	 * struct kmem_cache size depends on nr_node_ids & nr_cpu_ids
> -	 */
> -	create_boot_cache(kmem_cache, "kmem_cache",
> -		offsetof(struct kmem_cache, node) +
> -				  nr_node_ids * sizeof(struct kmem_cache_node *),
> -				  SLAB_HWCACHE_ALIGN, 0, 0);
> -	list_add(&kmem_cache->list, &slab_caches);
> -	slab_state = PARTIAL;
> -
> -	/*
> -	 * Initialize the caches that provide memory for the  kmem_cache_node
> -	 * structures first.  Without this, further allocations will bug.
> -	 */
> -	kmalloc_caches[KMALLOC_NORMAL][INDEX_NODE] = create_kmalloc_cache(
> -				kmalloc_info[INDEX_NODE].name[KMALLOC_NORMAL],
> -				kmalloc_info[INDEX_NODE].size,
> -				ARCH_KMALLOC_FLAGS, 0,
> -				kmalloc_info[INDEX_NODE].size);
> -	slab_state = PARTIAL_NODE;
> -	setup_kmalloc_cache_index_table();
> -
> -	/* 5) Replace the bootstrap kmem_cache_node */
> -	{
> -		int nid;
> -
> -		for_each_online_node(nid) {
> -			init_list(kmem_cache, &init_kmem_cache_node[CACHE_CACHE + nid], nid);
> -
> -			init_list(kmalloc_caches[KMALLOC_NORMAL][INDEX_NODE],
> -					  &init_kmem_cache_node[SIZE_NODE + nid], nid);
> -		}
> -	}
> -
> -	create_kmalloc_caches(ARCH_KMALLOC_FLAGS);
> -}
> -
> -void __init kmem_cache_init_late(void)
> -{
> -	struct kmem_cache *cachep;
> -
> -	/* 6) resize the head arrays to their final sizes */
> -	mutex_lock(&slab_mutex);
> -	list_for_each_entry(cachep, &slab_caches, list)
> -		if (enable_cpucache(cachep, GFP_NOWAIT))
> -			BUG();
> -	mutex_unlock(&slab_mutex);
> -
> -	/* Done! */
> -	slab_state = FULL;
> -
> -#ifdef CONFIG_NUMA
> -	/*
> -	 * Register a memory hotplug callback that initializes and frees
> -	 * node.
> -	 */
> -	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
> -#endif
> -
> -	/*
> -	 * The reap timers are started later, with a module init call: That part
> -	 * of the kernel is not yet operational.
> -	 */
> -}
> -
> -static int __init cpucache_init(void)
> -{
> -	int ret;
> -
> -	/*
> -	 * Register the timers that return unneeded pages to the page allocator
> -	 */
> -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "SLAB online",
> -				slab_online_cpu, slab_offline_cpu);
> -	WARN_ON(ret < 0);
> -
> -	return 0;
> -}
> -__initcall(cpucache_init);
> -
> -static noinline void
> -slab_out_of_memory(struct kmem_cache *cachep, gfp_t gfpflags, int nodeid)
> -{
> -#if DEBUG
> -	struct kmem_cache_node *n;
> -	unsigned long flags;
> -	int node;
> -	static DEFINE_RATELIMIT_STATE(slab_oom_rs, DEFAULT_RATELIMIT_INTERVAL,
> -				      DEFAULT_RATELIMIT_BURST);
> -
> -	if ((gfpflags & __GFP_NOWARN) || !__ratelimit(&slab_oom_rs))
> -		return;
> -
> -	pr_warn("SLAB: Unable to allocate memory on node %d, gfp=%#x(%pGg)\n",
> -		nodeid, gfpflags, &gfpflags);
> -	pr_warn("  cache: %s, object size: %d, order: %d\n",
> -		cachep->name, cachep->size, cachep->gfporder);
> -
> -	for_each_kmem_cache_node(cachep, node, n) {
> -		unsigned long total_slabs, free_slabs, free_objs;
> -
> -		raw_spin_lock_irqsave(&n->list_lock, flags);
> -		total_slabs = n->total_slabs;
> -		free_slabs = n->free_slabs;
> -		free_objs = n->free_objects;
> -		raw_spin_unlock_irqrestore(&n->list_lock, flags);
> -
> -		pr_warn("  node %d: slabs: %ld/%ld, objs: %ld/%ld\n",
> -			node, total_slabs - free_slabs, total_slabs,
> -			(total_slabs * cachep->num) - free_objs,
> -			total_slabs * cachep->num);
> -	}
> -#endif
> -}
> -
> -/*
> - * Interface to system's page allocator. No need to hold the
> - * kmem_cache_node ->list_lock.
> - *
> - * If we requested dmaable memory, we will get it. Even if we
> - * did not request dmaable memory, we might get it, but that
> - * would be relatively rare and ignorable.
> - */
> -static struct slab *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
> -								int nodeid)
> -{
> -	struct folio *folio;
> -	struct slab *slab;
> -
> -	flags |= cachep->allocflags;
> -
> -	folio = (struct folio *) __alloc_pages_node(nodeid, flags, cachep->gfporder);
> -	if (!folio) {
> -		slab_out_of_memory(cachep, flags, nodeid);
> -		return NULL;
> -	}
> -
> -	slab = folio_slab(folio);
> -
> -	account_slab(slab, cachep->gfporder, cachep, flags);
> -	__folio_set_slab(folio);
> -	/* Make the flag visible before any changes to folio->mapping */
> -	smp_wmb();
> -	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
> -	if (sk_memalloc_socks() && folio_is_pfmemalloc(folio))
> -		slab_set_pfmemalloc(slab);
> -
> -	return slab;
> -}
> -
> -/*
> - * Interface to system's page release.
> - */
> -static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
> -{
> -	int order = cachep->gfporder;
> -	struct folio *folio = slab_folio(slab);
> -
> -	BUG_ON(!folio_test_slab(folio));
> -	__slab_clear_pfmemalloc(slab);
> -	page_mapcount_reset(&folio->page);
> -	folio->mapping = NULL;
> -	/* Make the mapping reset visible before clearing the flag */
> -	smp_wmb();
> -	__folio_clear_slab(folio);
> -
> -	if (current->reclaim_state)
> -		current->reclaim_state->reclaimed_slab += 1 << order;
> -	unaccount_slab(slab, order, cachep);
> -	__free_pages(&folio->page, order);
> -}
> -
> -static void kmem_rcu_free(struct rcu_head *head)
> -{
> -	struct kmem_cache *cachep;
> -	struct slab *slab;
> -
> -	slab = container_of(head, struct slab, rcu_head);
> -	cachep = slab->slab_cache;
> -
> -	kmem_freepages(cachep, slab);
> -}
> -
> -#if DEBUG
> -static inline bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
> -{
> -	return debug_pagealloc_enabled_static() && OFF_SLAB(cachep) &&
> -			((cachep->size % PAGE_SIZE) == 0);
> -}
> -
> -#ifdef CONFIG_DEBUG_PAGEALLOC
> -static void slab_kernel_map(struct kmem_cache *cachep, void *objp, int map)
> -{
> -	if (!is_debug_pagealloc_cache(cachep))
> -		return;
> -
> -	__kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
> -}
> -
> -#else
> -static inline void slab_kernel_map(struct kmem_cache *cachep, void *objp,
> -				int map) {}
> -
> -#endif
> -
> -static void poison_obj(struct kmem_cache *cachep, void *addr, unsigned char val)
> -{
> -	int size = cachep->object_size;
> -	addr = &((char *)addr)[obj_offset(cachep)];
> -
> -	memset(addr, val, size);
> -	*(unsigned char *)(addr + size - 1) = POISON_END;
> -}
> -
> -static void dump_line(char *data, int offset, int limit)
> -{
> -	int i;
> -	unsigned char error = 0;
> -	int bad_count = 0;
> -
> -	pr_err("%03x: ", offset);
> -	for (i = 0; i < limit; i++) {
> -		if (data[offset + i] != POISON_FREE) {
> -			error = data[offset + i];
> -			bad_count++;
> -		}
> -	}
> -	print_hex_dump(KERN_CONT, "", 0, 16, 1,
> -			&data[offset], limit, 1);
> -
> -	if (bad_count == 1) {
> -		error ^= POISON_FREE;
> -		if (!(error & (error - 1))) {
> -			pr_err("Single bit error detected. Probably bad RAM.\n");
> -#ifdef CONFIG_X86
> -			pr_err("Run memtest86+ or a similar memory test tool.\n");
> -#else
> -			pr_err("Run a memory test tool.\n");
> -#endif
> -		}
> -	}
> -}
> -#endif
> -
> -#if DEBUG
> -
> -static void print_objinfo(struct kmem_cache *cachep, void *objp, int lines)
> -{
> -	int i, size;
> -	char *realobj;
> -
> -	if (cachep->flags & SLAB_RED_ZONE) {
> -		pr_err("Redzone: 0x%llx/0x%llx\n",
> -		       *dbg_redzone1(cachep, objp),
> -		       *dbg_redzone2(cachep, objp));
> -	}
> -
> -	if (cachep->flags & SLAB_STORE_USER)
> -		pr_err("Last user: (%pSR)\n", *dbg_userword(cachep, objp));
> -	realobj = (char *)objp + obj_offset(cachep);
> -	size = cachep->object_size;
> -	for (i = 0; i < size && lines; i += 16, lines--) {
> -		int limit;
> -		limit = 16;
> -		if (i + limit > size)
> -			limit = size - i;
> -		dump_line(realobj, i, limit);
> -	}
> -}
> -
> -static void check_poison_obj(struct kmem_cache *cachep, void *objp)
> -{
> -	char *realobj;
> -	int size, i;
> -	int lines = 0;
> -
> -	if (is_debug_pagealloc_cache(cachep))
> -		return;
> -
> -	realobj = (char *)objp + obj_offset(cachep);
> -	size = cachep->object_size;
> -
> -	for (i = 0; i < size; i++) {
> -		char exp = POISON_FREE;
> -		if (i == size - 1)
> -			exp = POISON_END;
> -		if (realobj[i] != exp) {
> -			int limit;
> -			/* Mismatch ! */
> -			/* Print header */
> -			if (lines == 0) {
> -				pr_err("Slab corruption (%s): %s start=%px, len=%d\n",
> -				       print_tainted(), cachep->name,
> -				       realobj, size);
> -				print_objinfo(cachep, objp, 0);
> -			}
> -			/* Hexdump the affected line */
> -			i = (i / 16) * 16;
> -			limit = 16;
> -			if (i + limit > size)
> -				limit = size - i;
> -			dump_line(realobj, i, limit);
> -			i += 16;
> -			lines++;
> -			/* Limit to 5 lines */
> -			if (lines > 5)
> -				break;
> -		}
> -	}
> -	if (lines != 0) {
> -		/* Print some data about the neighboring objects, if they
> -		 * exist:
> -		 */
> -		struct slab *slab = virt_to_slab(objp);
> -		unsigned int objnr;
> -
> -		objnr = obj_to_index(cachep, slab, objp);
> -		if (objnr) {
> -			objp = index_to_obj(cachep, slab, objnr - 1);
> -			realobj = (char *)objp + obj_offset(cachep);
> -			pr_err("Prev obj: start=%px, len=%d\n", realobj, size);
> -			print_objinfo(cachep, objp, 2);
> -		}
> -		if (objnr + 1 < cachep->num) {
> -			objp = index_to_obj(cachep, slab, objnr + 1);
> -			realobj = (char *)objp + obj_offset(cachep);
> -			pr_err("Next obj: start=%px, len=%d\n", realobj, size);
> -			print_objinfo(cachep, objp, 2);
> -		}
> -	}
> -}
> -#endif
> -
> -#if DEBUG
> -static void slab_destroy_debugcheck(struct kmem_cache *cachep,
> -						struct slab *slab)
> -{
> -	int i;
> -
> -	if (OBJFREELIST_SLAB(cachep) && cachep->flags & SLAB_POISON) {
> -		poison_obj(cachep, slab->freelist - obj_offset(cachep),
> -			POISON_FREE);
> -	}
> -
> -	for (i = 0; i < cachep->num; i++) {
> -		void *objp = index_to_obj(cachep, slab, i);
> -
> -		if (cachep->flags & SLAB_POISON) {
> -			check_poison_obj(cachep, objp);
> -			slab_kernel_map(cachep, objp, 1);
> -		}
> -		if (cachep->flags & SLAB_RED_ZONE) {
> -			if (*dbg_redzone1(cachep, objp) != RED_INACTIVE)
> -				slab_error(cachep, "start of a freed object was overwritten");
> -			if (*dbg_redzone2(cachep, objp) != RED_INACTIVE)
> -				slab_error(cachep, "end of a freed object was overwritten");
> -		}
> -	}
> -}
> -#else
> -static void slab_destroy_debugcheck(struct kmem_cache *cachep,
> -						struct slab *slab)
> -{
> -}
> -#endif
> -
> -/**
> - * slab_destroy - destroy and release all objects in a slab
> - * @cachep: cache pointer being destroyed
> - * @slab: slab being destroyed
> - *
> - * Destroy all the objs in a slab, and release the mem back to the system.
> - * Before calling the slab must have been unlinked from the cache. The
> - * kmem_cache_node ->list_lock is not held/needed.
> - */
> -static void slab_destroy(struct kmem_cache *cachep, struct slab *slab)
> -{
> -	void *freelist;
> -
> -	freelist = slab->freelist;
> -	slab_destroy_debugcheck(cachep, slab);
> -	if (unlikely(cachep->flags & SLAB_TYPESAFE_BY_RCU))
> -		call_rcu(&slab->rcu_head, kmem_rcu_free);
> -	else
> -		kmem_freepages(cachep, slab);
> -
> -	/*
> -	 * From now on, we don't use freelist
> -	 * although actual page can be freed in rcu context
> -	 */
> -	if (OFF_SLAB(cachep))
> -		kfree(freelist);
> -}
> -
> -/*
> - * Update the size of the caches before calling slabs_destroy as it may
> - * recursively call kfree.
> - */
> -static void slabs_destroy(struct kmem_cache *cachep, struct list_head *list)
> -{
> -	struct slab *slab, *n;
> -
> -	list_for_each_entry_safe(slab, n, list, slab_list) {
> -		list_del(&slab->slab_list);
> -		slab_destroy(cachep, slab);
> -	}
> -}
> -
> -/**
> - * calculate_slab_order - calculate size (page order) of slabs
> - * @cachep: pointer to the cache that is being created
> - * @size: size of objects to be created in this cache.
> - * @flags: slab allocation flags
> - *
> - * Also calculates the number of objects per slab.
> - *
> - * This could be made much more intelligent.  For now, try to avoid using
> - * high order pages for slabs.  When the gfp() functions are more friendly
> - * towards high-order requests, this should be changed.
> - *
> - * Return: number of left-over bytes in a slab
> - */
> -static size_t calculate_slab_order(struct kmem_cache *cachep,
> -				size_t size, slab_flags_t flags)
> -{
> -	size_t left_over = 0;
> -	int gfporder;
> -
> -	for (gfporder = 0; gfporder <= KMALLOC_MAX_ORDER; gfporder++) {
> -		unsigned int num;
> -		size_t remainder;
> -
> -		num = cache_estimate(gfporder, size, flags, &remainder);
> -		if (!num)
> -			continue;
> -
> -		/* Can't handle number of objects more than SLAB_OBJ_MAX_NUM */
> -		if (num > SLAB_OBJ_MAX_NUM)
> -			break;
> -
> -		if (flags & CFLGS_OFF_SLAB) {
> -			struct kmem_cache *freelist_cache;
> -			size_t freelist_size;
> -			size_t freelist_cache_size;
> -
> -			freelist_size = num * sizeof(freelist_idx_t);
> -			if (freelist_size > KMALLOC_MAX_CACHE_SIZE) {
> -				freelist_cache_size = PAGE_SIZE << get_order(freelist_size);
> -			} else {
> -				freelist_cache = kmalloc_slab(freelist_size, 0u);
> -				if (!freelist_cache)
> -					continue;
> -				freelist_cache_size = freelist_cache->size;
> -
> -				/*
> -				 * Needed to avoid possible looping condition
> -				 * in cache_grow_begin()
> -				 */
> -				if (OFF_SLAB(freelist_cache))
> -					continue;
> -			}
> -
> -			/* check if off slab has enough benefit */
> -			if (freelist_cache_size > cachep->size / 2)
> -				continue;
> -		}
> -
> -		/* Found something acceptable - save it away */
> -		cachep->num = num;
> -		cachep->gfporder = gfporder;
> -		left_over = remainder;
> -
> -		/*
> -		 * A VFS-reclaimable slab tends to have most allocations
> -		 * as GFP_NOFS and we really don't want to have to be allocating
> -		 * higher-order pages when we are unable to shrink dcache.
> -		 */
> -		if (flags & SLAB_RECLAIM_ACCOUNT)
> -			break;
> -
> -		/*
> -		 * Large number of objects is good, but very large slabs are
> -		 * currently bad for the gfp()s.
> -		 */
> -		if (gfporder >= slab_max_order)
> -			break;
> -
> -		/*
> -		 * Acceptable internal fragmentation?
> -		 */
> -		if (left_over * 8 <= (PAGE_SIZE << gfporder))
> -			break;
> -	}
> -	return left_over;
> -}
> -
> -static struct array_cache __percpu *alloc_kmem_cache_cpus(
> -		struct kmem_cache *cachep, int entries, int batchcount)
> -{
> -	int cpu;
> -	size_t size;
> -	struct array_cache __percpu *cpu_cache;
> -
> -	size = sizeof(void *) * entries + sizeof(struct array_cache);
> -	cpu_cache = __alloc_percpu(size, sizeof(void *));
> -
> -	if (!cpu_cache)
> -		return NULL;
> -
> -	for_each_possible_cpu(cpu) {
> -		init_arraycache(per_cpu_ptr(cpu_cache, cpu),
> -				entries, batchcount);
> -	}
> -
> -	return cpu_cache;
> -}
> -
> -static int __ref setup_cpu_cache(struct kmem_cache *cachep, gfp_t gfp)
> -{
> -	if (slab_state >= FULL)
> -		return enable_cpucache(cachep, gfp);
> -
> -	cachep->cpu_cache = alloc_kmem_cache_cpus(cachep, 1, 1);
> -	if (!cachep->cpu_cache)
> -		return 1;
> -
> -	if (slab_state == DOWN) {
> -		/* Creation of first cache (kmem_cache). */
> -		set_up_node(kmem_cache, CACHE_CACHE);
> -	} else if (slab_state == PARTIAL) {
> -		/* For kmem_cache_node */
> -		set_up_node(cachep, SIZE_NODE);
> -	} else {
> -		int node;
> -
> -		for_each_online_node(node) {
> -			cachep->node[node] = kmalloc_node(
> -				sizeof(struct kmem_cache_node), gfp, node);
> -			BUG_ON(!cachep->node[node]);
> -			kmem_cache_node_init(cachep->node[node]);
> -		}
> -	}
> -
> -	cachep->node[numa_mem_id()]->next_reap =
> -			jiffies + REAPTIMEOUT_NODE +
> -			((unsigned long)cachep) % REAPTIMEOUT_NODE;
> -
> -	cpu_cache_get(cachep)->avail = 0;
> -	cpu_cache_get(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
> -	cpu_cache_get(cachep)->batchcount = 1;
> -	cpu_cache_get(cachep)->touched = 0;
> -	cachep->batchcount = 1;
> -	cachep->limit = BOOT_CPUCACHE_ENTRIES;
> -	return 0;
> -}
> -
> -slab_flags_t kmem_cache_flags(unsigned int object_size,
> -	slab_flags_t flags, const char *name)
> -{
> -	return flags;
> -}
> -
> -struct kmem_cache *
> -__kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
> -		   slab_flags_t flags, void (*ctor)(void *))
> -{
> -	struct kmem_cache *cachep;
> -
> -	cachep = find_mergeable(size, align, flags, name, ctor);
> -	if (cachep) {
> -		cachep->refcount++;
> -
> -		/*
> -		 * Adjust the object sizes so that we clear
> -		 * the complete object on kzalloc.
> -		 */
> -		cachep->object_size = max_t(int, cachep->object_size, size);
> -	}
> -	return cachep;
> -}
> -
> -static bool set_objfreelist_slab_cache(struct kmem_cache *cachep,
> -			size_t size, slab_flags_t flags)
> -{
> -	size_t left;
> -
> -	cachep->num = 0;
> -
> -	/*
> -	 * If slab auto-initialization on free is enabled, store the freelist
> -	 * off-slab, so that its contents don't end up in one of the allocated
> -	 * objects.
> -	 */
> -	if (unlikely(slab_want_init_on_free(cachep)))
> -		return false;
> -
> -	if (cachep->ctor || flags & SLAB_TYPESAFE_BY_RCU)
> -		return false;
> -
> -	left = calculate_slab_order(cachep, size,
> -			flags | CFLGS_OBJFREELIST_SLAB);
> -	if (!cachep->num)
> -		return false;
> -
> -	if (cachep->num * sizeof(freelist_idx_t) > cachep->object_size)
> -		return false;
> -
> -	cachep->colour = left / cachep->colour_off;
> -
> -	return true;
> -}
> -
> -static bool set_off_slab_cache(struct kmem_cache *cachep,
> -			size_t size, slab_flags_t flags)
> -{
> -	size_t left;
> -
> -	cachep->num = 0;
> -
> -	/*
> -	 * Always use on-slab management when SLAB_NOLEAKTRACE
> -	 * to avoid recursive calls into kmemleak.
> -	 */
> -	if (flags & SLAB_NOLEAKTRACE)
> -		return false;
> -
> -	/*
> -	 * Size is large, assume best to place the slab management obj
> -	 * off-slab (should allow better packing of objs).
> -	 */
> -	left = calculate_slab_order(cachep, size, flags | CFLGS_OFF_SLAB);
> -	if (!cachep->num)
> -		return false;
> -
> -	/*
> -	 * If the slab has been placed off-slab, and we have enough space then
> -	 * move it on-slab. This is at the expense of any extra colouring.
> -	 */
> -	if (left >= cachep->num * sizeof(freelist_idx_t))
> -		return false;
> -
> -	cachep->colour = left / cachep->colour_off;
> -
> -	return true;
> -}
> -
> -static bool set_on_slab_cache(struct kmem_cache *cachep,
> -			size_t size, slab_flags_t flags)
> -{
> -	size_t left;
> -
> -	cachep->num = 0;
> -
> -	left = calculate_slab_order(cachep, size, flags);
> -	if (!cachep->num)
> -		return false;
> -
> -	cachep->colour = left / cachep->colour_off;
> -
> -	return true;
> -}
> -
> -/**
> - * __kmem_cache_create - Create a cache.
> - * @cachep: cache management descriptor
> - * @flags: SLAB flags
> - *
> - * Returns a ptr to the cache on success, NULL on failure.
> - * Cannot be called within an int, but can be interrupted.
> - * The @ctor is run when new pages are allocated by the cache.
> - *
> - * The flags are
> - *
> - * %SLAB_POISON - Poison the slab with a known test pattern (a5a5a5a5)
> - * to catch references to uninitialised memory.
> - *
> - * %SLAB_RED_ZONE - Insert `Red' zones around the allocated memory to check
> - * for buffer overruns.
> - *
> - * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
> - * cacheline.  This can be beneficial if you're counting cycles as closely
> - * as davem.
> - *
> - * Return: a pointer to the created cache or %NULL in case of error
> - */
> -int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
> -{
> -	size_t ralign = BYTES_PER_WORD;
> -	gfp_t gfp;
> -	int err;
> -	unsigned int size = cachep->size;
> -
> -#if DEBUG
> -#if FORCED_DEBUG
> -	/*
> -	 * Enable redzoning and last user accounting, except for caches with
> -	 * large objects, if the increased size would increase the object size
> -	 * above the next power of two: caches with object sizes just above a
> -	 * power of two have a significant amount of internal fragmentation.
> -	 */
> -	if (size < 4096 || fls(size - 1) == fls(size-1 + REDZONE_ALIGN +
> -						2 * sizeof(unsigned long long)))
> -		flags |= SLAB_RED_ZONE | SLAB_STORE_USER;
> -	if (!(flags & SLAB_TYPESAFE_BY_RCU))
> -		flags |= SLAB_POISON;
> -#endif
> -#endif
> -
> -	/*
> -	 * Check that size is in terms of words.  This is needed to avoid
> -	 * unaligned accesses for some archs when redzoning is used, and makes
> -	 * sure any on-slab bufctl's are also correctly aligned.
> -	 */
> -	size = ALIGN(size, BYTES_PER_WORD);
> -
> -	if (flags & SLAB_RED_ZONE) {
> -		ralign = REDZONE_ALIGN;
> -		/* If redzoning, ensure that the second redzone is suitably
> -		 * aligned, by adjusting the object size accordingly. */
> -		size = ALIGN(size, REDZONE_ALIGN);
> -	}
> -
> -	/* 3) caller mandated alignment */
> -	if (ralign < cachep->align) {
> -		ralign = cachep->align;
> -	}
> -	/* disable debug if necessary */
> -	if (ralign > __alignof__(unsigned long long))
> -		flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
> -	/*
> -	 * 4) Store it.
> -	 */
> -	cachep->align = ralign;
> -	cachep->colour_off = cache_line_size();
> -	/* Offset must be a multiple of the alignment. */
> -	if (cachep->colour_off < cachep->align)
> -		cachep->colour_off = cachep->align;
> -
> -	if (slab_is_available())
> -		gfp = GFP_KERNEL;
> -	else
> -		gfp = GFP_NOWAIT;
> -
> -#if DEBUG
> -
> -	/*
> -	 * Both debugging options require word-alignment which is calculated
> -	 * into align above.
> -	 */
> -	if (flags & SLAB_RED_ZONE) {
> -		/* add space for red zone words */
> -		cachep->obj_offset += sizeof(unsigned long long);
> -		size += 2 * sizeof(unsigned long long);
> -	}
> -	if (flags & SLAB_STORE_USER) {
> -		/* user store requires one word storage behind the end of
> -		 * the real object. But if the second red zone needs to be
> -		 * aligned to 64 bits, we must allow that much space.
> -		 */
> -		if (flags & SLAB_RED_ZONE)
> -			size += REDZONE_ALIGN;
> -		else
> -			size += BYTES_PER_WORD;
> -	}
> -#endif
> -
> -	kasan_cache_create(cachep, &size, &flags);
> -
> -	size = ALIGN(size, cachep->align);
> -	/*
> -	 * We should restrict the number of objects in a slab to implement
> -	 * byte sized index. Refer comment on SLAB_OBJ_MIN_SIZE definition.
> -	 */
> -	if (FREELIST_BYTE_INDEX && size < SLAB_OBJ_MIN_SIZE)
> -		size = ALIGN(SLAB_OBJ_MIN_SIZE, cachep->align);
> -
> -#if DEBUG
> -	/*
> -	 * To activate debug pagealloc, off-slab management is necessary
> -	 * requirement. In early phase of initialization, small sized slab
> -	 * doesn't get initialized so it would not be possible. So, we need
> -	 * to check size >= 256. It guarantees that all necessary small
> -	 * sized slab is initialized in current slab initialization sequence.
> -	 */
> -	if (debug_pagealloc_enabled_static() && (flags & SLAB_POISON) &&
> -		size >= 256 && cachep->object_size > cache_line_size()) {
> -		if (size < PAGE_SIZE || size % PAGE_SIZE == 0) {
> -			size_t tmp_size = ALIGN(size, PAGE_SIZE);
> -
> -			if (set_off_slab_cache(cachep, tmp_size, flags)) {
> -				flags |= CFLGS_OFF_SLAB;
> -				cachep->obj_offset += tmp_size - size;
> -				size = tmp_size;
> -				goto done;
> -			}
> -		}
> -	}
> -#endif
> -
> -	if (set_objfreelist_slab_cache(cachep, size, flags)) {
> -		flags |= CFLGS_OBJFREELIST_SLAB;
> -		goto done;
> -	}
> -
> -	if (set_off_slab_cache(cachep, size, flags)) {
> -		flags |= CFLGS_OFF_SLAB;
> -		goto done;
> -	}
> -
> -	if (set_on_slab_cache(cachep, size, flags))
> -		goto done;
> -
> -	return -E2BIG;
> -
> -done:
> -	cachep->freelist_size = cachep->num * sizeof(freelist_idx_t);
> -	cachep->flags = flags;
> -	cachep->allocflags = __GFP_COMP;
> -	if (flags & SLAB_CACHE_DMA)
> -		cachep->allocflags |= GFP_DMA;
> -	if (flags & SLAB_CACHE_DMA32)
> -		cachep->allocflags |= GFP_DMA32;
> -	if (flags & SLAB_RECLAIM_ACCOUNT)
> -		cachep->allocflags |= __GFP_RECLAIMABLE;
> -	cachep->size = size;
> -	cachep->reciprocal_buffer_size = reciprocal_value(size);
> -
> -#if DEBUG
> -	/*
> -	 * If we're going to use the generic kernel_map_pages()
> -	 * poisoning, then it's going to smash the contents of
> -	 * the redzone and userword anyhow, so switch them off.
> -	 */
> -	if (IS_ENABLED(CONFIG_PAGE_POISONING) &&
> -		(cachep->flags & SLAB_POISON) &&
> -		is_debug_pagealloc_cache(cachep))
> -		cachep->flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
> -#endif
> -
> -	err = setup_cpu_cache(cachep, gfp);
> -	if (err) {
> -		__kmem_cache_release(cachep);
> -		return err;
> -	}
> -
> -	return 0;
> -}
> -
> -#if DEBUG
> -static void check_irq_off(void)
> -{
> -	BUG_ON(!irqs_disabled());
> -}
> -
> -static void check_irq_on(void)
> -{
> -	BUG_ON(irqs_disabled());
> -}
> -
> -static void check_mutex_acquired(void)
> -{
> -	BUG_ON(!mutex_is_locked(&slab_mutex));
> -}
> -
> -static void check_spinlock_acquired(struct kmem_cache *cachep)
> -{
> -#ifdef CONFIG_SMP
> -	check_irq_off();
> -	assert_raw_spin_locked(&get_node(cachep, numa_mem_id())->list_lock);
> -#endif
> -}
> -
> -static void check_spinlock_acquired_node(struct kmem_cache *cachep, int node)
> -{
> -#ifdef CONFIG_SMP
> -	check_irq_off();
> -	assert_raw_spin_locked(&get_node(cachep, node)->list_lock);
> -#endif
> -}
> -
> -#else
> -#define check_irq_off()	do { } while(0)
> -#define check_irq_on()	do { } while(0)
> -#define check_mutex_acquired()	do { } while(0)
> -#define check_spinlock_acquired(x) do { } while(0)
> -#define check_spinlock_acquired_node(x, y) do { } while(0)
> -#endif
> -
> -static void drain_array_locked(struct kmem_cache *cachep, struct array_cache *ac,
> -				int node, bool free_all, struct list_head *list)
> -{
> -	int tofree;
> -
> -	if (!ac || !ac->avail)
> -		return;
> -
> -	tofree = free_all ? ac->avail : (ac->limit + 4) / 5;
> -	if (tofree > ac->avail)
> -		tofree = (ac->avail + 1) / 2;
> -
> -	free_block(cachep, ac->entry, tofree, node, list);
> -	ac->avail -= tofree;
> -	memmove(ac->entry, &(ac->entry[tofree]), sizeof(void *) * ac->avail);
> -}
> -
> -static void do_drain(void *arg)
> -{
> -	struct kmem_cache *cachep = arg;
> -	struct array_cache *ac;
> -	int node = numa_mem_id();
> -	struct kmem_cache_node *n;
> -	LIST_HEAD(list);
> -
> -	check_irq_off();
> -	ac = cpu_cache_get(cachep);
> -	n = get_node(cachep, node);
> -	raw_spin_lock(&n->list_lock);
> -	free_block(cachep, ac->entry, ac->avail, node, &list);
> -	raw_spin_unlock(&n->list_lock);
> -	ac->avail = 0;
> -	slabs_destroy(cachep, &list);
> -}
> -
> -static void drain_cpu_caches(struct kmem_cache *cachep)
> -{
> -	struct kmem_cache_node *n;
> -	int node;
> -	LIST_HEAD(list);
> -
> -	on_each_cpu(do_drain, cachep, 1);
> -	check_irq_on();
> -	for_each_kmem_cache_node(cachep, node, n)
> -		if (n->alien)
> -			drain_alien_cache(cachep, n->alien);
> -
> -	for_each_kmem_cache_node(cachep, node, n) {
> -		raw_spin_lock_irq(&n->list_lock);
> -		drain_array_locked(cachep, n->shared, node, true, &list);
> -		raw_spin_unlock_irq(&n->list_lock);
> -
> -		slabs_destroy(cachep, &list);
> -	}
> -}
> -
> -/*
> - * Remove slabs from the list of free slabs.
> - * Specify the number of slabs to drain in tofree.
> - *
> - * Returns the actual number of slabs released.
> - */
> -static int drain_freelist(struct kmem_cache *cache,
> -			struct kmem_cache_node *n, int tofree)
> -{
> -	struct list_head *p;
> -	int nr_freed;
> -	struct slab *slab;
> -
> -	nr_freed = 0;
> -	while (nr_freed < tofree && !list_empty(&n->slabs_free)) {
> -
> -		raw_spin_lock_irq(&n->list_lock);
> -		p = n->slabs_free.prev;
> -		if (p == &n->slabs_free) {
> -			raw_spin_unlock_irq(&n->list_lock);
> -			goto out;
> -		}
> -
> -		slab = list_entry(p, struct slab, slab_list);
> -		list_del(&slab->slab_list);
> -		n->free_slabs--;
> -		n->total_slabs--;
> -		/*
> -		 * Safe to drop the lock. The slab is no longer linked
> -		 * to the cache.
> -		 */
> -		n->free_objects -= cache->num;
> -		raw_spin_unlock_irq(&n->list_lock);
> -		slab_destroy(cache, slab);
> -		nr_freed++;
> -
> -		cond_resched();
> -	}
> -out:
> -	return nr_freed;
> -}
> -
> -bool __kmem_cache_empty(struct kmem_cache *s)
> -{
> -	int node;
> -	struct kmem_cache_node *n;
> -
> -	for_each_kmem_cache_node(s, node, n)
> -		if (!list_empty(&n->slabs_full) ||
> -		    !list_empty(&n->slabs_partial))
> -			return false;
> -	return true;
> -}
> -
> -int __kmem_cache_shrink(struct kmem_cache *cachep)
> -{
> -	int ret = 0;
> -	int node;
> -	struct kmem_cache_node *n;
> -
> -	drain_cpu_caches(cachep);
> -
> -	check_irq_on();
> -	for_each_kmem_cache_node(cachep, node, n) {
> -		drain_freelist(cachep, n, INT_MAX);
> -
> -		ret += !list_empty(&n->slabs_full) ||
> -			!list_empty(&n->slabs_partial);
> -	}
> -	return (ret ? 1 : 0);
> -}
> -
> -int __kmem_cache_shutdown(struct kmem_cache *cachep)
> -{
> -	return __kmem_cache_shrink(cachep);
> -}
> -
> -void __kmem_cache_release(struct kmem_cache *cachep)
> -{
> -	int i;
> -	struct kmem_cache_node *n;
> -
> -	cache_random_seq_destroy(cachep);
> -
> -	free_percpu(cachep->cpu_cache);
> -
> -	/* NUMA: free the node structures */
> -	for_each_kmem_cache_node(cachep, i, n) {
> -		kfree(n->shared);
> -		free_alien_cache(n->alien);
> -		kfree(n);
> -		cachep->node[i] = NULL;
> -	}
> -}
> -
> -/*
> - * Get the memory for a slab management obj.
> - *
> - * For a slab cache when the slab descriptor is off-slab, the
> - * slab descriptor can't come from the same cache which is being created,
> - * Because if it is the case, that means we defer the creation of
> - * the kmalloc_{dma,}_cache of size sizeof(slab descriptor) to this point.
> - * And we eventually call down to __kmem_cache_create(), which
> - * in turn looks up in the kmalloc_{dma,}_caches for the desired-size one.
> - * This is a "chicken-and-egg" problem.
> - *
> - * So the off-slab slab descriptor shall come from the kmalloc_{dma,}_caches,
> - * which are all initialized during kmem_cache_init().
> - */
> -static void *alloc_slabmgmt(struct kmem_cache *cachep,
> -				   struct slab *slab, int colour_off,
> -				   gfp_t local_flags, int nodeid)
> -{
> -	void *freelist;
> -	void *addr = slab_address(slab);
> -
> -	slab->s_mem = addr + colour_off;
> -	slab->active = 0;
> -
> -	if (OBJFREELIST_SLAB(cachep))
> -		freelist = NULL;
> -	else if (OFF_SLAB(cachep)) {
> -		/* Slab management obj is off-slab. */
> -		freelist = kmalloc_node(cachep->freelist_size,
> -					      local_flags, nodeid);
> -	} else {
> -		/* We will use last bytes at the slab for freelist */
> -		freelist = addr + (PAGE_SIZE << cachep->gfporder) -
> -				cachep->freelist_size;
> -	}
> -
> -	return freelist;
> -}
> -
> -static inline freelist_idx_t get_free_obj(struct slab *slab, unsigned int idx)
> -{
> -	return ((freelist_idx_t *) slab->freelist)[idx];
> -}
> -
> -static inline void set_free_obj(struct slab *slab,
> -					unsigned int idx, freelist_idx_t val)
> -{
> -	((freelist_idx_t *)(slab->freelist))[idx] = val;
> -}
> -
> -static void cache_init_objs_debug(struct kmem_cache *cachep, struct slab *slab)
> -{
> -#if DEBUG
> -	int i;
> -
> -	for (i = 0; i < cachep->num; i++) {
> -		void *objp = index_to_obj(cachep, slab, i);
> -
> -		if (cachep->flags & SLAB_STORE_USER)
> -			*dbg_userword(cachep, objp) = NULL;
> -
> -		if (cachep->flags & SLAB_RED_ZONE) {
> -			*dbg_redzone1(cachep, objp) = RED_INACTIVE;
> -			*dbg_redzone2(cachep, objp) = RED_INACTIVE;
> -		}
> -		/*
> -		 * Constructors are not allowed to allocate memory from the same
> -		 * cache which they are a constructor for.  Otherwise, deadlock.
> -		 * They must also be threaded.
> -		 */
> -		if (cachep->ctor && !(cachep->flags & SLAB_POISON)) {
> -			kasan_unpoison_object_data(cachep,
> -						   objp + obj_offset(cachep));
> -			cachep->ctor(objp + obj_offset(cachep));
> -			kasan_poison_object_data(
> -				cachep, objp + obj_offset(cachep));
> -		}
> -
> -		if (cachep->flags & SLAB_RED_ZONE) {
> -			if (*dbg_redzone2(cachep, objp) != RED_INACTIVE)
> -				slab_error(cachep, "constructor overwrote the end of an object");
> -			if (*dbg_redzone1(cachep, objp) != RED_INACTIVE)
> -				slab_error(cachep, "constructor overwrote the start of an object");
> -		}
> -		/* need to poison the objs? */
> -		if (cachep->flags & SLAB_POISON) {
> -			poison_obj(cachep, objp, POISON_FREE);
> -			slab_kernel_map(cachep, objp, 0);
> -		}
> -	}
> -#endif
> -}
> -
> -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> -/* Hold information during a freelist initialization */
> -union freelist_init_state {
> -	struct {
> -		unsigned int pos;
> -		unsigned int *list;
> -		unsigned int count;
> -	};
> -	struct rnd_state rnd_state;
> -};
> -
> -/*
> - * Initialize the state based on the randomization method available.
> - * return true if the pre-computed list is available, false otherwise.
> - */
> -static bool freelist_state_initialize(union freelist_init_state *state,
> -				struct kmem_cache *cachep,
> -				unsigned int count)
> -{
> -	bool ret;
> -	unsigned int rand;
> -
> -	/* Use best entropy available to define a random shift */
> -	rand = get_random_u32();
> -
> -	/* Use a random state if the pre-computed list is not available */
> -	if (!cachep->random_seq) {
> -		prandom_seed_state(&state->rnd_state, rand);
> -		ret = false;
> -	} else {
> -		state->list = cachep->random_seq;
> -		state->count = count;
> -		state->pos = rand % count;
> -		ret = true;
> -	}
> -	return ret;
> -}
> -
> -/* Get the next entry on the list and randomize it using a random shift */
> -static freelist_idx_t next_random_slot(union freelist_init_state *state)
> -{
> -	if (state->pos >= state->count)
> -		state->pos = 0;
> -	return state->list[state->pos++];
> -}
> -
> -/* Swap two freelist entries */
> -static void swap_free_obj(struct slab *slab, unsigned int a, unsigned int b)
> -{
> -	swap(((freelist_idx_t *) slab->freelist)[a],
> -		((freelist_idx_t *) slab->freelist)[b]);
> -}
> -
> -/*
> - * Shuffle the freelist initialization state based on pre-computed lists.
> - * return true if the list was successfully shuffled, false otherwise.
> - */
> -static bool shuffle_freelist(struct kmem_cache *cachep, struct slab *slab)
> -{
> -	unsigned int objfreelist = 0, i, rand, count = cachep->num;
> -	union freelist_init_state state;
> -	bool precomputed;
> -
> -	if (count < 2)
> -		return false;
> -
> -	precomputed = freelist_state_initialize(&state, cachep, count);
> -
> -	/* Take a random entry as the objfreelist */
> -	if (OBJFREELIST_SLAB(cachep)) {
> -		if (!precomputed)
> -			objfreelist = count - 1;
> -		else
> -			objfreelist = next_random_slot(&state);
> -		slab->freelist = index_to_obj(cachep, slab, objfreelist) +
> -						obj_offset(cachep);
> -		count--;
> -	}
> -
> -	/*
> -	 * On early boot, generate the list dynamically.
> -	 * Later use a pre-computed list for speed.
> -	 */
> -	if (!precomputed) {
> -		for (i = 0; i < count; i++)
> -			set_free_obj(slab, i, i);
> -
> -		/* Fisher-Yates shuffle */
> -		for (i = count - 1; i > 0; i--) {
> -			rand = prandom_u32_state(&state.rnd_state);
> -			rand %= (i + 1);
> -			swap_free_obj(slab, i, rand);
> -		}
> -	} else {
> -		for (i = 0; i < count; i++)
> -			set_free_obj(slab, i, next_random_slot(&state));
> -	}
> -
> -	if (OBJFREELIST_SLAB(cachep))
> -		set_free_obj(slab, cachep->num - 1, objfreelist);
> -
> -	return true;
> -}
> -#else
> -static inline bool shuffle_freelist(struct kmem_cache *cachep,
> -				struct slab *slab)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_SLAB_FREELIST_RANDOM */
> -
> -static void cache_init_objs(struct kmem_cache *cachep,
> -			    struct slab *slab)
> -{
> -	int i;
> -	void *objp;
> -	bool shuffled;
> -
> -	cache_init_objs_debug(cachep, slab);
> -
> -	/* Try to randomize the freelist if enabled */
> -	shuffled = shuffle_freelist(cachep, slab);
> -
> -	if (!shuffled && OBJFREELIST_SLAB(cachep)) {
> -		slab->freelist = index_to_obj(cachep, slab, cachep->num - 1) +
> -						obj_offset(cachep);
> -	}
> -
> -	for (i = 0; i < cachep->num; i++) {
> -		objp = index_to_obj(cachep, slab, i);
> -		objp = kasan_init_slab_obj(cachep, objp);
> -
> -		/* constructor could break poison info */
> -		if (DEBUG == 0 && cachep->ctor) {
> -			kasan_unpoison_object_data(cachep, objp);
> -			cachep->ctor(objp);
> -			kasan_poison_object_data(cachep, objp);
> -		}
> -
> -		if (!shuffled)
> -			set_free_obj(slab, i, i);
> -	}
> -}
> -
> -static void *slab_get_obj(struct kmem_cache *cachep, struct slab *slab)
> -{
> -	void *objp;
> -
> -	objp = index_to_obj(cachep, slab, get_free_obj(slab, slab->active));
> -	slab->active++;
> -
> -	return objp;
> -}
> -
> -static void slab_put_obj(struct kmem_cache *cachep,
> -			struct slab *slab, void *objp)
> -{
> -	unsigned int objnr = obj_to_index(cachep, slab, objp);
> -#if DEBUG
> -	unsigned int i;
> -
> -	/* Verify double free bug */
> -	for (i = slab->active; i < cachep->num; i++) {
> -		if (get_free_obj(slab, i) == objnr) {
> -			pr_err("slab: double free detected in cache '%s', objp %px\n",
> -			       cachep->name, objp);
> -			BUG();
> -		}
> -	}
> -#endif
> -	slab->active--;
> -	if (!slab->freelist)
> -		slab->freelist = objp + obj_offset(cachep);
> -
> -	set_free_obj(slab, slab->active, objnr);
> -}
> -
> -/*
> - * Grow (by 1) the number of slabs within a cache.  This is called by
> - * kmem_cache_alloc() when there are no active objs left in a cache.
> - */
> -static struct slab *cache_grow_begin(struct kmem_cache *cachep,
> -				gfp_t flags, int nodeid)
> -{
> -	void *freelist;
> -	size_t offset;
> -	gfp_t local_flags;
> -	int slab_node;
> -	struct kmem_cache_node *n;
> -	struct slab *slab;
> -
> -	/*
> -	 * Be lazy and only check for valid flags here,  keeping it out of the
> -	 * critical path in kmem_cache_alloc().
> -	 */
> -	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> -		flags = kmalloc_fix_flags(flags);
> -
> -	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
> -	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
> -
> -	check_irq_off();
> -	if (gfpflags_allow_blocking(local_flags))
> -		local_irq_enable();
> -
> -	/*
> -	 * Get mem for the objs.  Attempt to allocate a physical page from
> -	 * 'nodeid'.
> -	 */
> -	slab = kmem_getpages(cachep, local_flags, nodeid);
> -	if (!slab)
> -		goto failed;
> -
> -	slab_node = slab_nid(slab);
> -	n = get_node(cachep, slab_node);
> -
> -	/* Get colour for the slab, and cal the next value. */
> -	n->colour_next++;
> -	if (n->colour_next >= cachep->colour)
> -		n->colour_next = 0;
> -
> -	offset = n->colour_next;
> -	if (offset >= cachep->colour)
> -		offset = 0;
> -
> -	offset *= cachep->colour_off;
> -
> -	/*
> -	 * Call kasan_poison_slab() before calling alloc_slabmgmt(), so
> -	 * page_address() in the latter returns a non-tagged pointer,
> -	 * as it should be for slab pages.
> -	 */
> -	kasan_poison_slab(slab);
> -
> -	/* Get slab management. */
> -	freelist = alloc_slabmgmt(cachep, slab, offset,
> -			local_flags & ~GFP_CONSTRAINT_MASK, slab_node);
> -	if (OFF_SLAB(cachep) && !freelist)
> -		goto opps1;
> -
> -	slab->slab_cache = cachep;
> -	slab->freelist = freelist;
> -
> -	cache_init_objs(cachep, slab);
> -
> -	if (gfpflags_allow_blocking(local_flags))
> -		local_irq_disable();
> -
> -	return slab;
> -
> -opps1:
> -	kmem_freepages(cachep, slab);
> -failed:
> -	if (gfpflags_allow_blocking(local_flags))
> -		local_irq_disable();
> -	return NULL;
> -}
> -
> -static void cache_grow_end(struct kmem_cache *cachep, struct slab *slab)
> -{
> -	struct kmem_cache_node *n;
> -	void *list = NULL;
> -
> -	check_irq_off();
> -
> -	if (!slab)
> -		return;
> -
> -	INIT_LIST_HEAD(&slab->slab_list);
> -	n = get_node(cachep, slab_nid(slab));
> -
> -	raw_spin_lock(&n->list_lock);
> -	n->total_slabs++;
> -	if (!slab->active) {
> -		list_add_tail(&slab->slab_list, &n->slabs_free);
> -		n->free_slabs++;
> -	} else
> -		fixup_slab_list(cachep, n, slab, &list);
> -
> -	STATS_INC_GROWN(cachep);
> -	n->free_objects += cachep->num - slab->active;
> -	raw_spin_unlock(&n->list_lock);
> -
> -	fixup_objfreelist_debug(cachep, &list);
> -}
> -
> -#if DEBUG
> -
> -/*
> - * Perform extra freeing checks:
> - * - detect bad pointers.
> - * - POISON/RED_ZONE checking
> - */
> -static void kfree_debugcheck(const void *objp)
> -{
> -	if (!virt_addr_valid(objp)) {
> -		pr_err("kfree_debugcheck: out of range ptr %lxh\n",
> -		       (unsigned long)objp);
> -		BUG();
> -	}
> -}
> -
> -static inline void verify_redzone_free(struct kmem_cache *cache, void *obj)
> -{
> -	unsigned long long redzone1, redzone2;
> -
> -	redzone1 = *dbg_redzone1(cache, obj);
> -	redzone2 = *dbg_redzone2(cache, obj);
> -
> -	/*
> -	 * Redzone is ok.
> -	 */
> -	if (redzone1 == RED_ACTIVE && redzone2 == RED_ACTIVE)
> -		return;
> -
> -	if (redzone1 == RED_INACTIVE && redzone2 == RED_INACTIVE)
> -		slab_error(cache, "double free detected");
> -	else
> -		slab_error(cache, "memory outside object was overwritten");
> -
> -	pr_err("%px: redzone 1:0x%llx, redzone 2:0x%llx\n",
> -	       obj, redzone1, redzone2);
> -}
> -
> -static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
> -				   unsigned long caller)
> -{
> -	unsigned int objnr;
> -	struct slab *slab;
> -
> -	BUG_ON(virt_to_cache(objp) != cachep);
> -
> -	objp -= obj_offset(cachep);
> -	kfree_debugcheck(objp);
> -	slab = virt_to_slab(objp);
> -
> -	if (cachep->flags & SLAB_RED_ZONE) {
> -		verify_redzone_free(cachep, objp);
> -		*dbg_redzone1(cachep, objp) = RED_INACTIVE;
> -		*dbg_redzone2(cachep, objp) = RED_INACTIVE;
> -	}
> -	if (cachep->flags & SLAB_STORE_USER)
> -		*dbg_userword(cachep, objp) = (void *)caller;
> -
> -	objnr = obj_to_index(cachep, slab, objp);
> -
> -	BUG_ON(objnr >= cachep->num);
> -	BUG_ON(objp != index_to_obj(cachep, slab, objnr));
> -
> -	if (cachep->flags & SLAB_POISON) {
> -		poison_obj(cachep, objp, POISON_FREE);
> -		slab_kernel_map(cachep, objp, 0);
> -	}
> -	return objp;
> -}
> -
> -#else
> -#define kfree_debugcheck(x) do { } while(0)
> -#define cache_free_debugcheck(x, objp, z) (objp)
> -#endif
> -
> -static inline void fixup_objfreelist_debug(struct kmem_cache *cachep,
> -						void **list)
> -{
> -#if DEBUG
> -	void *next = *list;
> -	void *objp;
> -
> -	while (next) {
> -		objp = next - obj_offset(cachep);
> -		next = *(void **)next;
> -		poison_obj(cachep, objp, POISON_FREE);
> -	}
> -#endif
> -}
> -
> -static inline void fixup_slab_list(struct kmem_cache *cachep,
> -				struct kmem_cache_node *n, struct slab *slab,
> -				void **list)
> -{
> -	/* move slabp to correct slabp list: */
> -	list_del(&slab->slab_list);
> -	if (slab->active == cachep->num) {
> -		list_add(&slab->slab_list, &n->slabs_full);
> -		if (OBJFREELIST_SLAB(cachep)) {
> -#if DEBUG
> -			/* Poisoning will be done without holding the lock */
> -			if (cachep->flags & SLAB_POISON) {
> -				void **objp = slab->freelist;
> -
> -				*objp = *list;
> -				*list = objp;
> -			}
> -#endif
> -			slab->freelist = NULL;
> -		}
> -	} else
> -		list_add(&slab->slab_list, &n->slabs_partial);
> -}
> -
> -/* Try to find non-pfmemalloc slab if needed */
> -static noinline struct slab *get_valid_first_slab(struct kmem_cache_node *n,
> -					struct slab *slab, bool pfmemalloc)
> -{
> -	if (!slab)
> -		return NULL;
> -
> -	if (pfmemalloc)
> -		return slab;
> -
> -	if (!slab_test_pfmemalloc(slab))
> -		return slab;
> -
> -	/* No need to keep pfmemalloc slab if we have enough free objects */
> -	if (n->free_objects > n->free_limit) {
> -		slab_clear_pfmemalloc(slab);
> -		return slab;
> -	}
> -
> -	/* Move pfmemalloc slab to the end of list to speed up next search */
> -	list_del(&slab->slab_list);
> -	if (!slab->active) {
> -		list_add_tail(&slab->slab_list, &n->slabs_free);
> -		n->free_slabs++;
> -	} else
> -		list_add_tail(&slab->slab_list, &n->slabs_partial);
> -
> -	list_for_each_entry(slab, &n->slabs_partial, slab_list) {
> -		if (!slab_test_pfmemalloc(slab))
> -			return slab;
> -	}
> -
> -	n->free_touched = 1;
> -	list_for_each_entry(slab, &n->slabs_free, slab_list) {
> -		if (!slab_test_pfmemalloc(slab)) {
> -			n->free_slabs--;
> -			return slab;
> -		}
> -	}
> -
> -	return NULL;
> -}
> -
> -static struct slab *get_first_slab(struct kmem_cache_node *n, bool pfmemalloc)
> -{
> -	struct slab *slab;
> -
> -	assert_raw_spin_locked(&n->list_lock);
> -	slab = list_first_entry_or_null(&n->slabs_partial, struct slab,
> -					slab_list);
> -	if (!slab) {
> -		n->free_touched = 1;
> -		slab = list_first_entry_or_null(&n->slabs_free, struct slab,
> -						slab_list);
> -		if (slab)
> -			n->free_slabs--;
> -	}
> -
> -	if (sk_memalloc_socks())
> -		slab = get_valid_first_slab(n, slab, pfmemalloc);
> -
> -	return slab;
> -}
> -
> -static noinline void *cache_alloc_pfmemalloc(struct kmem_cache *cachep,
> -				struct kmem_cache_node *n, gfp_t flags)
> -{
> -	struct slab *slab;
> -	void *obj;
> -	void *list = NULL;
> -
> -	if (!gfp_pfmemalloc_allowed(flags))
> -		return NULL;
> -
> -	raw_spin_lock(&n->list_lock);
> -	slab = get_first_slab(n, true);
> -	if (!slab) {
> -		raw_spin_unlock(&n->list_lock);
> -		return NULL;
> -	}
> -
> -	obj = slab_get_obj(cachep, slab);
> -	n->free_objects--;
> -
> -	fixup_slab_list(cachep, n, slab, &list);
> -
> -	raw_spin_unlock(&n->list_lock);
> -	fixup_objfreelist_debug(cachep, &list);
> -
> -	return obj;
> -}
> -
> -/*
> - * Slab list should be fixed up by fixup_slab_list() for existing slab
> - * or cache_grow_end() for new slab
> - */
> -static __always_inline int alloc_block(struct kmem_cache *cachep,
> -		struct array_cache *ac, struct slab *slab, int batchcount)
> -{
> -	/*
> -	 * There must be at least one object available for
> -	 * allocation.
> -	 */
> -	BUG_ON(slab->active >= cachep->num);
> -
> -	while (slab->active < cachep->num && batchcount--) {
> -		STATS_INC_ALLOCED(cachep);
> -		STATS_INC_ACTIVE(cachep);
> -		STATS_SET_HIGH(cachep);
> -
> -		ac->entry[ac->avail++] = slab_get_obj(cachep, slab);
> -	}
> -
> -	return batchcount;
> -}
> -
> -static void *cache_alloc_refill(struct kmem_cache *cachep, gfp_t flags)
> -{
> -	int batchcount;
> -	struct kmem_cache_node *n;
> -	struct array_cache *ac, *shared;
> -	int node;
> -	void *list = NULL;
> -	struct slab *slab;
> -
> -	check_irq_off();
> -	node = numa_mem_id();
> -
> -	ac = cpu_cache_get(cachep);
> -	batchcount = ac->batchcount;
> -	if (!ac->touched && batchcount > BATCHREFILL_LIMIT) {
> -		/*
> -		 * If there was little recent activity on this cache, then
> -		 * perform only a partial refill.  Otherwise we could generate
> -		 * refill bouncing.
> -		 */
> -		batchcount = BATCHREFILL_LIMIT;
> -	}
> -	n = get_node(cachep, node);
> -
> -	BUG_ON(ac->avail > 0 || !n);
> -	shared = READ_ONCE(n->shared);
> -	if (!n->free_objects && (!shared || !shared->avail))
> -		goto direct_grow;
> -
> -	raw_spin_lock(&n->list_lock);
> -	shared = READ_ONCE(n->shared);
> -
> -	/* See if we can refill from the shared array */
> -	if (shared && transfer_objects(ac, shared, batchcount)) {
> -		shared->touched = 1;
> -		goto alloc_done;
> -	}
> -
> -	while (batchcount > 0) {
> -		/* Get slab alloc is to come from. */
> -		slab = get_first_slab(n, false);
> -		if (!slab)
> -			goto must_grow;
> -
> -		check_spinlock_acquired(cachep);
> -
> -		batchcount = alloc_block(cachep, ac, slab, batchcount);
> -		fixup_slab_list(cachep, n, slab, &list);
> -	}
> -
> -must_grow:
> -	n->free_objects -= ac->avail;
> -alloc_done:
> -	raw_spin_unlock(&n->list_lock);
> -	fixup_objfreelist_debug(cachep, &list);
> -
> -direct_grow:
> -	if (unlikely(!ac->avail)) {
> -		/* Check if we can use obj in pfmemalloc slab */
> -		if (sk_memalloc_socks()) {
> -			void *obj = cache_alloc_pfmemalloc(cachep, n, flags);
> -
> -			if (obj)
> -				return obj;
> -		}
> -
> -		slab = cache_grow_begin(cachep, gfp_exact_node(flags), node);
> -
> -		/*
> -		 * cache_grow_begin() can reenable interrupts,
> -		 * then ac could change.
> -		 */
> -		ac = cpu_cache_get(cachep);
> -		if (!ac->avail && slab)
> -			alloc_block(cachep, ac, slab, batchcount);
> -		cache_grow_end(cachep, slab);
> -
> -		if (!ac->avail)
> -			return NULL;
> -	}
> -	ac->touched = 1;
> -
> -	return ac->entry[--ac->avail];
> -}
> -
> -#if DEBUG
> -static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
> -				gfp_t flags, void *objp, unsigned long caller)
> -{
> -	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
> -	if (!objp || is_kfence_address(objp))
> -		return objp;
> -	if (cachep->flags & SLAB_POISON) {
> -		check_poison_obj(cachep, objp);
> -		slab_kernel_map(cachep, objp, 1);
> -		poison_obj(cachep, objp, POISON_INUSE);
> -	}
> -	if (cachep->flags & SLAB_STORE_USER)
> -		*dbg_userword(cachep, objp) = (void *)caller;
> -
> -	if (cachep->flags & SLAB_RED_ZONE) {
> -		if (*dbg_redzone1(cachep, objp) != RED_INACTIVE ||
> -				*dbg_redzone2(cachep, objp) != RED_INACTIVE) {
> -			slab_error(cachep, "double free, or memory outside object was overwritten");
> -			pr_err("%px: redzone 1:0x%llx, redzone 2:0x%llx\n",
> -			       objp, *dbg_redzone1(cachep, objp),
> -			       *dbg_redzone2(cachep, objp));
> -		}
> -		*dbg_redzone1(cachep, objp) = RED_ACTIVE;
> -		*dbg_redzone2(cachep, objp) = RED_ACTIVE;
> -	}
> -
> -	objp += obj_offset(cachep);
> -	if (cachep->ctor && cachep->flags & SLAB_POISON)
> -		cachep->ctor(objp);
> -	if ((unsigned long)objp & (arch_slab_minalign() - 1)) {
> -		pr_err("0x%px: not aligned to arch_slab_minalign()=%u\n", objp,
> -		       arch_slab_minalign());
> -	}
> -	return objp;
> -}
> -#else
> -#define cache_alloc_debugcheck_after(a, b, objp, d) (objp)
> -#endif
> -
> -static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
> -{
> -	void *objp;
> -	struct array_cache *ac;
> -
> -	check_irq_off();
> -
> -	ac = cpu_cache_get(cachep);
> -	if (likely(ac->avail)) {
> -		ac->touched = 1;
> -		objp = ac->entry[--ac->avail];
> -
> -		STATS_INC_ALLOCHIT(cachep);
> -		goto out;
> -	}
> -
> -	STATS_INC_ALLOCMISS(cachep);
> -	objp = cache_alloc_refill(cachep, flags);
> -	/*
> -	 * the 'ac' may be updated by cache_alloc_refill(),
> -	 * and kmemleak_erase() requires its correct value.
> -	 */
> -	ac = cpu_cache_get(cachep);
> -
> -out:
> -	/*
> -	 * To avoid a false negative, if an object that is in one of the
> -	 * per-CPU caches is leaked, we need to make sure kmemleak doesn't
> -	 * treat the array pointers as a reference to the object.
> -	 */
> -	if (objp)
> -		kmemleak_erase(&ac->entry[ac->avail]);
> -	return objp;
> -}
> -
> -#ifdef CONFIG_NUMA
> -static void *____cache_alloc_node(struct kmem_cache *, gfp_t, int);
> -
> -/*
> - * Try allocating on another node if PFA_SPREAD_SLAB is a mempolicy is set.
> - *
> - * If we are in_interrupt, then process context, including cpusets and
> - * mempolicy, may not apply and should not be used for allocation policy.
> - */
> -static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags)
> -{
> -	int nid_alloc, nid_here;
> -
> -	if (in_interrupt() || (flags & __GFP_THISNODE))
> -		return NULL;
> -	nid_alloc = nid_here = numa_mem_id();
> -	if (cpuset_do_slab_mem_spread() && (cachep->flags & SLAB_MEM_SPREAD))
> -		nid_alloc = cpuset_slab_spread_node();
> -	else if (current->mempolicy)
> -		nid_alloc = mempolicy_slab_node();
> -	if (nid_alloc != nid_here)
> -		return ____cache_alloc_node(cachep, flags, nid_alloc);
> -	return NULL;
> -}
> -
> -/*
> - * Fallback function if there was no memory available and no objects on a
> - * certain node and fall back is permitted. First we scan all the
> - * available node for available objects. If that fails then we
> - * perform an allocation without specifying a node. This allows the page
> - * allocator to do its reclaim / fallback magic. We then insert the
> - * slab into the proper nodelist and then allocate from it.
> - */
> -static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
> -{
> -	struct zonelist *zonelist;
> -	struct zoneref *z;
> -	struct zone *zone;
> -	enum zone_type highest_zoneidx = gfp_zone(flags);
> -	void *obj = NULL;
> -	struct slab *slab;
> -	int nid;
> -	unsigned int cpuset_mems_cookie;
> -
> -	if (flags & __GFP_THISNODE)
> -		return NULL;
> -
> -retry_cpuset:
> -	cpuset_mems_cookie = read_mems_allowed_begin();
> -	zonelist = node_zonelist(mempolicy_slab_node(), flags);
> -
> -retry:
> -	/*
> -	 * Look through allowed nodes for objects available
> -	 * from existing per node queues.
> -	 */
> -	for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
> -		nid = zone_to_nid(zone);
> -
> -		if (cpuset_zone_allowed(zone, flags) &&
> -			get_node(cache, nid) &&
> -			get_node(cache, nid)->free_objects) {
> -				obj = ____cache_alloc_node(cache,
> -					gfp_exact_node(flags), nid);
> -				if (obj)
> -					break;
> -		}
> -	}
> -
> -	if (!obj) {
> -		/*
> -		 * This allocation will be performed within the constraints
> -		 * of the current cpuset / memory policy requirements.
> -		 * We may trigger various forms of reclaim on the allowed
> -		 * set and go into memory reserves if necessary.
> -		 */
> -		slab = cache_grow_begin(cache, flags, numa_mem_id());
> -		cache_grow_end(cache, slab);
> -		if (slab) {
> -			nid = slab_nid(slab);
> -			obj = ____cache_alloc_node(cache,
> -				gfp_exact_node(flags), nid);
> -
> -			/*
> -			 * Another processor may allocate the objects in
> -			 * the slab since we are not holding any locks.
> -			 */
> -			if (!obj)
> -				goto retry;
> -		}
> -	}
> -
> -	if (unlikely(!obj && read_mems_allowed_retry(cpuset_mems_cookie)))
> -		goto retry_cpuset;
> -	return obj;
> -}
> -
> -/*
> - * An interface to enable slab creation on nodeid
> - */
> -static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
> -				int nodeid)
> -{
> -	struct slab *slab;
> -	struct kmem_cache_node *n;
> -	void *obj = NULL;
> -	void *list = NULL;
> -
> -	VM_BUG_ON(nodeid < 0 || nodeid >= MAX_NUMNODES);
> -	n = get_node(cachep, nodeid);
> -	BUG_ON(!n);
> -
> -	check_irq_off();
> -	raw_spin_lock(&n->list_lock);
> -	slab = get_first_slab(n, false);
> -	if (!slab)
> -		goto must_grow;
> -
> -	check_spinlock_acquired_node(cachep, nodeid);
> -
> -	STATS_INC_NODEALLOCS(cachep);
> -	STATS_INC_ACTIVE(cachep);
> -	STATS_SET_HIGH(cachep);
> -
> -	BUG_ON(slab->active == cachep->num);
> -
> -	obj = slab_get_obj(cachep, slab);
> -	n->free_objects--;
> -
> -	fixup_slab_list(cachep, n, slab, &list);
> -
> -	raw_spin_unlock(&n->list_lock);
> -	fixup_objfreelist_debug(cachep, &list);
> -	return obj;
> -
> -must_grow:
> -	raw_spin_unlock(&n->list_lock);
> -	slab = cache_grow_begin(cachep, gfp_exact_node(flags), nodeid);
> -	if (slab) {
> -		/* This slab isn't counted yet so don't update free_objects */
> -		obj = slab_get_obj(cachep, slab);
> -	}
> -	cache_grow_end(cachep, slab);
> -
> -	return obj ? obj : fallback_alloc(cachep, flags);
> -}
> -
> -static __always_inline void *
> -__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid)
> -{
> -	void *objp = NULL;
> -	int slab_node = numa_mem_id();
> -
> -	if (nodeid == NUMA_NO_NODE) {
> -		if (current->mempolicy || cpuset_do_slab_mem_spread()) {
> -			objp = alternate_node_alloc(cachep, flags);
> -			if (objp)
> -				goto out;
> -		}
> -		/*
> -		 * Use the locally cached objects if possible.
> -		 * However ____cache_alloc does not allow fallback
> -		 * to other nodes. It may fail while we still have
> -		 * objects on other nodes available.
> -		 */
> -		objp = ____cache_alloc(cachep, flags);
> -		nodeid = slab_node;
> -	} else if (nodeid == slab_node) {
> -		objp = ____cache_alloc(cachep, flags);
> -	} else if (!get_node(cachep, nodeid)) {
> -		/* Node not bootstrapped yet */
> -		objp = fallback_alloc(cachep, flags);
> -		goto out;
> -	}
> -
> -	/*
> -	 * We may just have run out of memory on the local node.
> -	 * ____cache_alloc_node() knows how to locate memory on other nodes
> -	 */
> -	if (!objp)
> -		objp = ____cache_alloc_node(cachep, flags, nodeid);
> -out:
> -	return objp;
> -}
> -#else
> -
> -static __always_inline void *
> -__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid __maybe_unused)
> -{
> -	return ____cache_alloc(cachep, flags);
> -}
> -
> -#endif /* CONFIG_NUMA */
> -
> -static __always_inline void *
> -slab_alloc_node(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
> -		int nodeid, size_t orig_size, unsigned long caller)
> -{
> -	unsigned long save_flags;
> -	void *objp;
> -	struct obj_cgroup *objcg = NULL;
> -	bool init = false;
> -
> -	flags &= gfp_allowed_mask;
> -	cachep = slab_pre_alloc_hook(cachep, lru, &objcg, 1, flags);
> -	if (unlikely(!cachep))
> -		return NULL;
> -
> -	objp = kfence_alloc(cachep, orig_size, flags);
> -	if (unlikely(objp))
> -		goto out;
> -
> -	local_irq_save(save_flags);
> -	objp = __do_cache_alloc(cachep, flags, nodeid);
> -	local_irq_restore(save_flags);
> -	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
> -	prefetchw(objp);
> -	init = slab_want_init_on_alloc(flags, cachep);
> -
> -out:
> -	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init,
> -				cachep->object_size);
> -	return objp;
> -}
> -
> -static __always_inline void *
> -slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
> -	   size_t orig_size, unsigned long caller)
> -{
> -	return slab_alloc_node(cachep, lru, flags, NUMA_NO_NODE, orig_size,
> -			       caller);
> -}
> -
> -/*
> - * Caller needs to acquire correct kmem_cache_node's list_lock
> - * @list: List of detached free slabs should be freed by caller
> - */
> -static void free_block(struct kmem_cache *cachep, void **objpp,
> -			int nr_objects, int node, struct list_head *list)
> -{
> -	int i;
> -	struct kmem_cache_node *n = get_node(cachep, node);
> -	struct slab *slab;
> -
> -	n->free_objects += nr_objects;
> -
> -	for (i = 0; i < nr_objects; i++) {
> -		void *objp;
> -		struct slab *slab;
> -
> -		objp = objpp[i];
> -
> -		slab = virt_to_slab(objp);
> -		list_del(&slab->slab_list);
> -		check_spinlock_acquired_node(cachep, node);
> -		slab_put_obj(cachep, slab, objp);
> -		STATS_DEC_ACTIVE(cachep);
> -
> -		/* fixup slab chains */
> -		if (slab->active == 0) {
> -			list_add(&slab->slab_list, &n->slabs_free);
> -			n->free_slabs++;
> -		} else {
> -			/* Unconditionally move a slab to the end of the
> -			 * partial list on free - maximum time for the
> -			 * other objects to be freed, too.
> -			 */
> -			list_add_tail(&slab->slab_list, &n->slabs_partial);
> -		}
> -	}
> -
> -	while (n->free_objects > n->free_limit && !list_empty(&n->slabs_free)) {
> -		n->free_objects -= cachep->num;
> -
> -		slab = list_last_entry(&n->slabs_free, struct slab, slab_list);
> -		list_move(&slab->slab_list, list);
> -		n->free_slabs--;
> -		n->total_slabs--;
> -	}
> -}
> -
> -static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
> -{
> -	int batchcount;
> -	struct kmem_cache_node *n;
> -	int node = numa_mem_id();
> -	LIST_HEAD(list);
> -
> -	batchcount = ac->batchcount;
> -
> -	check_irq_off();
> -	n = get_node(cachep, node);
> -	raw_spin_lock(&n->list_lock);
> -	if (n->shared) {
> -		struct array_cache *shared_array = n->shared;
> -		int max = shared_array->limit - shared_array->avail;
> -		if (max) {
> -			if (batchcount > max)
> -				batchcount = max;
> -			memcpy(&(shared_array->entry[shared_array->avail]),
> -			       ac->entry, sizeof(void *) * batchcount);
> -			shared_array->avail += batchcount;
> -			goto free_done;
> -		}
> -	}
> -
> -	free_block(cachep, ac->entry, batchcount, node, &list);
> -free_done:
> -#if STATS
> -	{
> -		int i = 0;
> -		struct slab *slab;
> -
> -		list_for_each_entry(slab, &n->slabs_free, slab_list) {
> -			BUG_ON(slab->active);
> -
> -			i++;
> -		}
> -		STATS_SET_FREEABLE(cachep, i);
> -	}
> -#endif
> -	raw_spin_unlock(&n->list_lock);
> -	ac->avail -= batchcount;
> -	memmove(ac->entry, &(ac->entry[batchcount]), sizeof(void *)*ac->avail);
> -	slabs_destroy(cachep, &list);
> -}
> -
> -/*
> - * Release an obj back to its cache. If the obj has a constructed state, it must
> - * be in this state _before_ it is released.  Called with disabled ints.
> - */
> -static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
> -					 unsigned long caller)
> -{
> -	bool init;
> -
> -	memcg_slab_free_hook(cachep, virt_to_slab(objp), &objp, 1);
> -
> -	if (is_kfence_address(objp)) {
> -		kmemleak_free_recursive(objp, cachep->flags);
> -		__kfence_free(objp);
> -		return;
> -	}
> -
> -	/*
> -	 * As memory initialization might be integrated into KASAN,
> -	 * kasan_slab_free and initialization memset must be
> -	 * kept together to avoid discrepancies in behavior.
> -	 */
> -	init = slab_want_init_on_free(cachep);
> -	if (init && !kasan_has_integrated_init())
> -		memset(objp, 0, cachep->object_size);
> -	/* KASAN might put objp into memory quarantine, delaying its reuse. */
> -	if (kasan_slab_free(cachep, objp, init))
> -		return;
> -
> -	/* Use KCSAN to help debug racy use-after-free. */
> -	if (!(cachep->flags & SLAB_TYPESAFE_BY_RCU))
> -		__kcsan_check_access(objp, cachep->object_size,
> -				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
> -
> -	___cache_free(cachep, objp, caller);
> -}
> -
> -void ___cache_free(struct kmem_cache *cachep, void *objp,
> -		unsigned long caller)
> -{
> -	struct array_cache *ac = cpu_cache_get(cachep);
> -
> -	check_irq_off();
> -	kmemleak_free_recursive(objp, cachep->flags);
> -	objp = cache_free_debugcheck(cachep, objp, caller);
> -
> -	/*
> -	 * Skip calling cache_free_alien() when the platform is not numa.
> -	 * This will avoid cache misses that happen while accessing slabp (which
> -	 * is per page memory  reference) to get nodeid. Instead use a global
> -	 * variable to skip the call, which is mostly likely to be present in
> -	 * the cache.
> -	 */
> -	if (nr_online_nodes > 1 && cache_free_alien(cachep, objp))
> -		return;
> -
> -	if (ac->avail < ac->limit) {
> -		STATS_INC_FREEHIT(cachep);
> -	} else {
> -		STATS_INC_FREEMISS(cachep);
> -		cache_flusharray(cachep, ac);
> -	}
> -
> -	if (sk_memalloc_socks()) {
> -		struct slab *slab = virt_to_slab(objp);
> -
> -		if (unlikely(slab_test_pfmemalloc(slab))) {
> -			cache_free_pfmemalloc(cachep, slab, objp);
> -			return;
> -		}
> -	}
> -
> -	__free_one(ac, objp);
> -}
> -
> -static __always_inline
> -void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
> -			     gfp_t flags)
> -{
> -	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
> -
> -	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, flags, NUMA_NO_NODE);
> -
> -	return ret;
> -}
> -
> -void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
> -{
> -	return __kmem_cache_alloc_lru(cachep, NULL, flags);
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc);
> -
> -void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
> -			   gfp_t flags)
> -{
> -	return __kmem_cache_alloc_lru(cachep, lru, flags);
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc_lru);
> -
> -static __always_inline void
> -cache_alloc_debugcheck_after_bulk(struct kmem_cache *s, gfp_t flags,
> -				  size_t size, void **p, unsigned long caller)
> -{
> -	size_t i;
> -
> -	for (i = 0; i < size; i++)
> -		p[i] = cache_alloc_debugcheck_after(s, flags, p[i], caller);
> -}
> -
> -int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
> -			  void **p)
> -{
> -	struct obj_cgroup *objcg = NULL;
> -	unsigned long irqflags;
> -	size_t i;
> -
> -	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
> -	if (!s)
> -		return 0;
> -
> -	local_irq_save(irqflags);
> -	for (i = 0; i < size; i++) {
> -		void *objp = kfence_alloc(s, s->object_size, flags) ?:
> -			     __do_cache_alloc(s, flags, NUMA_NO_NODE);
> -
> -		if (unlikely(!objp))
> -			goto error;
> -		p[i] = objp;
> -	}
> -	local_irq_restore(irqflags);
> -
> -	cache_alloc_debugcheck_after_bulk(s, flags, size, p, _RET_IP_);
> -
> -	/*
> -	 * memcg and kmem_cache debug support and memory initialization.
> -	 * Done outside of the IRQ disabled section.
> -	 */
> -	slab_post_alloc_hook(s, objcg, flags, size, p,
> -			slab_want_init_on_alloc(flags, s), s->object_size);
> -	/* FIXME: Trace call missing. Christoph would like a bulk variant */
> -	return size;
> -error:
> -	local_irq_restore(irqflags);
> -	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
> -	kmem_cache_free_bulk(s, i, p);
> -	return 0;
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc_bulk);
> -
> -/**
> - * kmem_cache_alloc_node - Allocate an object on the specified node
> - * @cachep: The cache to allocate from.
> - * @flags: See kmalloc().
> - * @nodeid: node number of the target node.
> - *
> - * Identical to kmem_cache_alloc but it will allocate memory on the given
> - * node, which can improve the performance for cpu bound structures.
> - *
> - * Fallback to other node is possible if __GFP_THISNODE is not set.
> - *
> - * Return: pointer to the new object or %NULL in case of error
> - */
> -void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
> -{
> -	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
> -
> -	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, flags, nodeid);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc_node);
> -
> -void *__kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
> -			     int nodeid, size_t orig_size,
> -			     unsigned long caller)
> -{
> -	return slab_alloc_node(cachep, NULL, flags, nodeid,
> -			       orig_size, caller);
> -}
> -
> -#ifdef CONFIG_PRINTK
> -void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
> -{
> -	struct kmem_cache *cachep;
> -	unsigned int objnr;
> -	void *objp;
> -
> -	kpp->kp_ptr = object;
> -	kpp->kp_slab = slab;
> -	cachep = slab->slab_cache;
> -	kpp->kp_slab_cache = cachep;
> -	objp = object - obj_offset(cachep);
> -	kpp->kp_data_offset = obj_offset(cachep);
> -	slab = virt_to_slab(objp);
> -	objnr = obj_to_index(cachep, slab, objp);
> -	objp = index_to_obj(cachep, slab, objnr);
> -	kpp->kp_objp = objp;
> -	if (DEBUG && cachep->flags & SLAB_STORE_USER)
> -		kpp->kp_ret = *dbg_userword(cachep, objp);
> -}
> -#endif
> -
> -static __always_inline
> -void __do_kmem_cache_free(struct kmem_cache *cachep, void *objp,
> -			  unsigned long caller)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	debug_check_no_locks_freed(objp, cachep->object_size);
> -	if (!(cachep->flags & SLAB_DEBUG_OBJECTS))
> -		debug_check_no_obj_freed(objp, cachep->object_size);
> -	__cache_free(cachep, objp, caller);
> -	local_irq_restore(flags);
> -}
> -
> -void __kmem_cache_free(struct kmem_cache *cachep, void *objp,
> -		       unsigned long caller)
> -{
> -	__do_kmem_cache_free(cachep, objp, caller);
> -}
> -
> -/**
> - * kmem_cache_free - Deallocate an object
> - * @cachep: The cache the allocation was from.
> - * @objp: The previously allocated object.
> - *
> - * Free an object which was previously allocated from this
> - * cache.
> - */
> -void kmem_cache_free(struct kmem_cache *cachep, void *objp)
> -{
> -	cachep = cache_from_obj(cachep, objp);
> -	if (!cachep)
> -		return;
> -
> -	trace_kmem_cache_free(_RET_IP_, objp, cachep);
> -	__do_kmem_cache_free(cachep, objp, _RET_IP_);
> -}
> -EXPORT_SYMBOL(kmem_cache_free);
> -
> -void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	for (int i = 0; i < size; i++) {
> -		void *objp = p[i];
> -		struct kmem_cache *s;
> -
> -		if (!orig_s) {
> -			struct folio *folio = virt_to_folio(objp);
> -
> -			/* called via kfree_bulk */
> -			if (!folio_test_slab(folio)) {
> -				local_irq_restore(flags);
> -				free_large_kmalloc(folio, objp);
> -				local_irq_save(flags);
> -				continue;
> -			}
> -			s = folio_slab(folio)->slab_cache;
> -		} else {
> -			s = cache_from_obj(orig_s, objp);
> -		}
> -
> -		if (!s)
> -			continue;
> -
> -		debug_check_no_locks_freed(objp, s->object_size);
> -		if (!(s->flags & SLAB_DEBUG_OBJECTS))
> -			debug_check_no_obj_freed(objp, s->object_size);
> -
> -		__cache_free(s, objp, _RET_IP_);
> -	}
> -	local_irq_restore(flags);
> -
> -	/* FIXME: add tracing */
> -}
> -EXPORT_SYMBOL(kmem_cache_free_bulk);
> -
> -/*
> - * This initializes kmem_cache_node or resizes various caches for all nodes.
> - */
> -static int setup_kmem_cache_nodes(struct kmem_cache *cachep, gfp_t gfp)
> -{
> -	int ret;
> -	int node;
> -	struct kmem_cache_node *n;
> -
> -	for_each_online_node(node) {
> -		ret = setup_kmem_cache_node(cachep, node, gfp, true);
> -		if (ret)
> -			goto fail;
> -
> -	}
> -
> -	return 0;
> -
> -fail:
> -	if (!cachep->list.next) {
> -		/* Cache is not active yet. Roll back what we did */
> -		node--;
> -		while (node >= 0) {
> -			n = get_node(cachep, node);
> -			if (n) {
> -				kfree(n->shared);
> -				free_alien_cache(n->alien);
> -				kfree(n);
> -				cachep->node[node] = NULL;
> -			}
> -			node--;
> -		}
> -	}
> -	return -ENOMEM;
> -}
> -
> -/* Always called with the slab_mutex held */
> -static int do_tune_cpucache(struct kmem_cache *cachep, int limit,
> -			    int batchcount, int shared, gfp_t gfp)
> -{
> -	struct array_cache __percpu *cpu_cache, *prev;
> -	int cpu;
> -
> -	cpu_cache = alloc_kmem_cache_cpus(cachep, limit, batchcount);
> -	if (!cpu_cache)
> -		return -ENOMEM;
> -
> -	prev = cachep->cpu_cache;
> -	cachep->cpu_cache = cpu_cache;
> -	/*
> -	 * Without a previous cpu_cache there's no need to synchronize remote
> -	 * cpus, so skip the IPIs.
> -	 */
> -	if (prev)
> -		kick_all_cpus_sync();
> -
> -	check_irq_on();
> -	cachep->batchcount = batchcount;
> -	cachep->limit = limit;
> -	cachep->shared = shared;
> -
> -	if (!prev)
> -		goto setup_node;
> -
> -	for_each_online_cpu(cpu) {
> -		LIST_HEAD(list);
> -		int node;
> -		struct kmem_cache_node *n;
> -		struct array_cache *ac = per_cpu_ptr(prev, cpu);
> -
> -		node = cpu_to_mem(cpu);
> -		n = get_node(cachep, node);
> -		raw_spin_lock_irq(&n->list_lock);
> -		free_block(cachep, ac->entry, ac->avail, node, &list);
> -		raw_spin_unlock_irq(&n->list_lock);
> -		slabs_destroy(cachep, &list);
> -	}
> -	free_percpu(prev);
> -
> -setup_node:
> -	return setup_kmem_cache_nodes(cachep, gfp);
> -}
> -
> -/* Called with slab_mutex held always */
> -static int enable_cpucache(struct kmem_cache *cachep, gfp_t gfp)
> -{
> -	int err;
> -	int limit = 0;
> -	int shared = 0;
> -	int batchcount = 0;
> -
> -	err = cache_random_seq_create(cachep, cachep->num, gfp);
> -	if (err)
> -		goto end;
> -
> -	/*
> -	 * The head array serves three purposes:
> -	 * - create a LIFO ordering, i.e. return objects that are cache-warm
> -	 * - reduce the number of spinlock operations.
> -	 * - reduce the number of linked list operations on the slab and
> -	 *   bufctl chains: array operations are cheaper.
> -	 * The numbers are guessed, we should auto-tune as described by
> -	 * Bonwick.
> -	 */
> -	if (cachep->size > 131072)
> -		limit = 1;
> -	else if (cachep->size > PAGE_SIZE)
> -		limit = 8;
> -	else if (cachep->size > 1024)
> -		limit = 24;
> -	else if (cachep->size > 256)
> -		limit = 54;
> -	else
> -		limit = 120;
> -
> -	/*
> -	 * CPU bound tasks (e.g. network routing) can exhibit cpu bound
> -	 * allocation behaviour: Most allocs on one cpu, most free operations
> -	 * on another cpu. For these cases, an efficient object passing between
> -	 * cpus is necessary. This is provided by a shared array. The array
> -	 * replaces Bonwick's magazine layer.
> -	 * On uniprocessor, it's functionally equivalent (but less efficient)
> -	 * to a larger limit. Thus disabled by default.
> -	 */
> -	shared = 0;
> -	if (cachep->size <= PAGE_SIZE && num_possible_cpus() > 1)
> -		shared = 8;
> -
> -#if DEBUG
> -	/*
> -	 * With debugging enabled, large batchcount lead to excessively long
> -	 * periods with disabled local interrupts. Limit the batchcount
> -	 */
> -	if (limit > 32)
> -		limit = 32;
> -#endif
> -	batchcount = (limit + 1) / 2;
> -	err = do_tune_cpucache(cachep, limit, batchcount, shared, gfp);
> -end:
> -	if (err)
> -		pr_err("enable_cpucache failed for %s, error %d\n",
> -		       cachep->name, -err);
> -	return err;
> -}
> -
> -/*
> - * Drain an array if it contains any elements taking the node lock only if
> - * necessary. Note that the node listlock also protects the array_cache
> - * if drain_array() is used on the shared array.
> - */
> -static void drain_array(struct kmem_cache *cachep, struct kmem_cache_node *n,
> -			 struct array_cache *ac, int node)
> -{
> -	LIST_HEAD(list);
> -
> -	/* ac from n->shared can be freed if we don't hold the slab_mutex. */
> -	check_mutex_acquired();
> -
> -	if (!ac || !ac->avail)
> -		return;
> -
> -	if (ac->touched) {
> -		ac->touched = 0;
> -		return;
> -	}
> -
> -	raw_spin_lock_irq(&n->list_lock);
> -	drain_array_locked(cachep, ac, node, false, &list);
> -	raw_spin_unlock_irq(&n->list_lock);
> -
> -	slabs_destroy(cachep, &list);
> -}
> -
> -/**
> - * cache_reap - Reclaim memory from caches.
> - * @w: work descriptor
> - *
> - * Called from workqueue/eventd every few seconds.
> - * Purpose:
> - * - clear the per-cpu caches for this CPU.
> - * - return freeable pages to the main free memory pool.
> - *
> - * If we cannot acquire the cache chain mutex then just give up - we'll try
> - * again on the next iteration.
> - */
> -static void cache_reap(struct work_struct *w)
> -{
> -	struct kmem_cache *searchp;
> -	struct kmem_cache_node *n;
> -	int node = numa_mem_id();
> -	struct delayed_work *work = to_delayed_work(w);
> -
> -	if (!mutex_trylock(&slab_mutex))
> -		/* Give up. Setup the next iteration. */
> -		goto out;
> -
> -	list_for_each_entry(searchp, &slab_caches, list) {
> -		check_irq_on();
> -
> -		/*
> -		 * We only take the node lock if absolutely necessary and we
> -		 * have established with reasonable certainty that
> -		 * we can do some work if the lock was obtained.
> -		 */
> -		n = get_node(searchp, node);
> -
> -		reap_alien(searchp, n);
> -
> -		drain_array(searchp, n, cpu_cache_get(searchp), node);
> -
> -		/*
> -		 * These are racy checks but it does not matter
> -		 * if we skip one check or scan twice.
> -		 */
> -		if (time_after(n->next_reap, jiffies))
> -			goto next;
> -
> -		n->next_reap = jiffies + REAPTIMEOUT_NODE;
> -
> -		drain_array(searchp, n, n->shared, node);
> -
> -		if (n->free_touched)
> -			n->free_touched = 0;
> -		else {
> -			int freed;
> -
> -			freed = drain_freelist(searchp, n, (n->free_limit +
> -				5 * searchp->num - 1) / (5 * searchp->num));
> -			STATS_ADD_REAPED(searchp, freed);
> -		}
> -next:
> -		cond_resched();
> -	}
> -	check_irq_on();
> -	mutex_unlock(&slab_mutex);
> -	next_reap_node();
> -out:
> -	/* Set up the next iteration */
> -	schedule_delayed_work_on(smp_processor_id(), work,
> -				round_jiffies_relative(REAPTIMEOUT_AC));
> -}
> -
> -void get_slabinfo(struct kmem_cache *cachep, struct slabinfo *sinfo)
> -{
> -	unsigned long active_objs, num_objs, active_slabs;
> -	unsigned long total_slabs = 0, free_objs = 0, shared_avail = 0;
> -	unsigned long free_slabs = 0;
> -	int node;
> -	struct kmem_cache_node *n;
> -
> -	for_each_kmem_cache_node(cachep, node, n) {
> -		check_irq_on();
> -		raw_spin_lock_irq(&n->list_lock);
> -
> -		total_slabs += n->total_slabs;
> -		free_slabs += n->free_slabs;
> -		free_objs += n->free_objects;
> -
> -		if (n->shared)
> -			shared_avail += n->shared->avail;
> -
> -		raw_spin_unlock_irq(&n->list_lock);
> -	}
> -	num_objs = total_slabs * cachep->num;
> -	active_slabs = total_slabs - free_slabs;
> -	active_objs = num_objs - free_objs;
> -
> -	sinfo->active_objs = active_objs;
> -	sinfo->num_objs = num_objs;
> -	sinfo->active_slabs = active_slabs;
> -	sinfo->num_slabs = total_slabs;
> -	sinfo->shared_avail = shared_avail;
> -	sinfo->limit = cachep->limit;
> -	sinfo->batchcount = cachep->batchcount;
> -	sinfo->shared = cachep->shared;
> -	sinfo->objects_per_slab = cachep->num;
> -	sinfo->cache_order = cachep->gfporder;
> -}
> -
> -void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *cachep)
> -{
> -#if STATS
> -	{			/* node stats */
> -		unsigned long high = cachep->high_mark;
> -		unsigned long allocs = cachep->num_allocations;
> -		unsigned long grown = cachep->grown;
> -		unsigned long reaped = cachep->reaped;
> -		unsigned long errors = cachep->errors;
> -		unsigned long max_freeable = cachep->max_freeable;
> -		unsigned long node_allocs = cachep->node_allocs;
> -		unsigned long node_frees = cachep->node_frees;
> -		unsigned long overflows = cachep->node_overflow;
> -
> -		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu %4lu %4lu %4lu %4lu %4lu",
> -			   allocs, high, grown,
> -			   reaped, errors, max_freeable, node_allocs,
> -			   node_frees, overflows);
> -	}
> -	/* cpu stats */
> -	{
> -		unsigned long allochit = atomic_read(&cachep->allochit);
> -		unsigned long allocmiss = atomic_read(&cachep->allocmiss);
> -		unsigned long freehit = atomic_read(&cachep->freehit);
> -		unsigned long freemiss = atomic_read(&cachep->freemiss);
> -
> -		seq_printf(m, " : cpustat %6lu %6lu %6lu %6lu",
> -			   allochit, allocmiss, freehit, freemiss);
> -	}
> -#endif
> -}
> -
> -#define MAX_SLABINFO_WRITE 128
> -/**
> - * slabinfo_write - Tuning for the slab allocator
> - * @file: unused
> - * @buffer: user buffer
> - * @count: data length
> - * @ppos: unused
> - *
> - * Return: %0 on success, negative error code otherwise.
> - */
> -ssize_t slabinfo_write(struct file *file, const char __user *buffer,
> -		       size_t count, loff_t *ppos)
> -{
> -	char kbuf[MAX_SLABINFO_WRITE + 1], *tmp;
> -	int limit, batchcount, shared, res;
> -	struct kmem_cache *cachep;
> -
> -	if (count > MAX_SLABINFO_WRITE)
> -		return -EINVAL;
> -	if (copy_from_user(&kbuf, buffer, count))
> -		return -EFAULT;
> -	kbuf[MAX_SLABINFO_WRITE] = '\0';
> -
> -	tmp = strchr(kbuf, ' ');
> -	if (!tmp)
> -		return -EINVAL;
> -	*tmp = '\0';
> -	tmp++;
> -	if (sscanf(tmp, " %d %d %d", &limit, &batchcount, &shared) != 3)
> -		return -EINVAL;
> -
> -	/* Find the cache in the chain of caches. */
> -	mutex_lock(&slab_mutex);
> -	res = -EINVAL;
> -	list_for_each_entry(cachep, &slab_caches, list) {
> -		if (!strcmp(cachep->name, kbuf)) {
> -			if (limit < 1 || batchcount < 1 ||
> -					batchcount > limit || shared < 0) {
> -				res = 0;
> -			} else {
> -				res = do_tune_cpucache(cachep, limit,
> -						       batchcount, shared,
> -						       GFP_KERNEL);
> -			}
> -			break;
> -		}
> -	}
> -	mutex_unlock(&slab_mutex);
> -	if (res >= 0)
> -		res = count;
> -	return res;
> -}
> -
> -#ifdef CONFIG_HARDENED_USERCOPY
> -/*
> - * Rejects incorrectly sized objects and objects that are to be copied
> - * to/from userspace but do not fall entirely within the containing slab
> - * cache's usercopy region.
> - *
> - * Returns NULL if check passes, otherwise const char * to name of cache
> - * to indicate an error.
> - */
> -void __check_heap_object(const void *ptr, unsigned long n,
> -			 const struct slab *slab, bool to_user)
> -{
> -	struct kmem_cache *cachep;
> -	unsigned int objnr;
> -	unsigned long offset;
> -
> -	ptr = kasan_reset_tag(ptr);
> -
> -	/* Find and validate object. */
> -	cachep = slab->slab_cache;
> -	objnr = obj_to_index(cachep, slab, (void *)ptr);
> -	BUG_ON(objnr >= cachep->num);
> -
> -	/* Find offset within object. */
> -	if (is_kfence_address(ptr))
> -		offset = ptr - kfence_object_start(ptr);
> -	else
> -		offset = ptr - index_to_obj(cachep, slab, objnr) - obj_offset(cachep);
> -
> -	/* Allow address range falling entirely within usercopy region. */
> -	if (offset >= cachep->useroffset &&
> -	    offset - cachep->useroffset <= cachep->usersize &&
> -	    n <= cachep->useroffset - offset + cachep->usersize)
> -		return;
> -
> -	usercopy_abort("SLAB object", cachep->name, to_user, offset, n);
> -}
> -#endif /* CONFIG_HARDENED_USERCOPY */
> diff --git a/mm/slab.h b/mm/slab.h
> index 43966aa5fadf..53e97b7640e9 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -9,60 +9,12 @@
>  struct slab {
>  	unsigned long __page_flags;
>
> -#if defined(CONFIG_SLAB)
> -
> -	struct kmem_cache *slab_cache;
> -	union {
> -		struct {
> -			struct list_head slab_list;
> -			void *freelist;	/* array of free object indexes */
> -			void *s_mem;	/* first object */
> -		};
> -		struct rcu_head rcu_head;
> -	};
> -	unsigned int active;
> -
> -#elif defined(CONFIG_SLUB)
> -
> -	struct kmem_cache *slab_cache;
> -	union {
> -		struct {
> -			union {
> -				struct list_head slab_list;
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -				struct {
> -					struct slab *next;
> -					int slabs;	/* Nr of slabs left */
> -				};
> -#endif
> -			};
> -			/* Double-word boundary */
> -			void *freelist;		/* first free object */
> -			union {
> -				unsigned long counters;
> -				struct {
> -					unsigned inuse:16;
> -					unsigned objects:15;
> -					unsigned frozen:1;
> -				};
> -			};
> -		};
> -		struct rcu_head rcu_head;
> -	};
> -	unsigned int __unused;
> -
> -#elif defined(CONFIG_SLOB)
> -
>  	struct list_head slab_list;
>  	void *__unused_1;
>  	void *freelist;		/* first free block */
>  	long units;
>  	unsigned int __unused_2;
>
> -#else
> -#error "Unexpected slab allocator configured"
> -#endif
> -
>  	atomic_t __page_refcount;
>  #ifdef CONFIG_MEMCG
>  	unsigned long memcg_data;
> @@ -72,20 +24,13 @@ struct slab {
>  #define SLAB_MATCH(pg, sl)						\
>  	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
>  SLAB_MATCH(flags, __page_flags);
> -#ifndef CONFIG_SLOB
> -SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
> -#else
>  SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
> -#endif
>  SLAB_MATCH(_refcount, __page_refcount);
>  #ifdef CONFIG_MEMCG
>  SLAB_MATCH(memcg_data, memcg_data);
>  #endif
>  #undef SLAB_MATCH
>  static_assert(sizeof(struct slab) <= sizeof(struct page));
> -#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && defined(CONFIG_SLUB)
> -static_assert(IS_ALIGNED(offsetof(struct slab, freelist), 2*sizeof(void *)));
> -#endif
>
>  /**
>   * folio_slab - Converts from folio to slab.
> @@ -200,7 +145,6 @@ static inline size_t slab_size(const struct slab *slab)
>  	return PAGE_SIZE << slab_order(slab);
>  }
>
> -#ifdef CONFIG_SLOB
>  /*
>   * Common fields provided in kmem_cache by all slab allocators
>   * This struct is either used directly by the allocator (SLOB)
> @@ -223,16 +167,6 @@ struct kmem_cache {
>  	struct list_head list;	/* List of all slab caches on the system */
>  };
>
> -#endif /* CONFIG_SLOB */
> -
> -#ifdef CONFIG_SLAB
> -#include <linux/slab_def.h>
> -#endif
> -
> -#ifdef CONFIG_SLUB
> -#include <linux/slub_def.h>
> -#endif
> -
>  #include <linux/memcontrol.h>
>  #include <linux/fault-inject.h>
>  #include <linux/kasan.h>
> @@ -268,26 +202,6 @@ extern struct list_head slab_caches;
>  /* The slab cache that manages slab cache information */
>  extern struct kmem_cache *kmem_cache;
>
> -/* A table of kmalloc cache names and sizes */
> -extern const struct kmalloc_info_struct {
> -	const char *name[NR_KMALLOC_TYPES];
> -	unsigned int size;
> -} kmalloc_info[];
> -
> -#ifndef CONFIG_SLOB
> -/* Kmalloc array related functions */
> -void setup_kmalloc_cache_index_table(void);
> -void create_kmalloc_caches(slab_flags_t);
> -
> -/* Find the kmalloc slab corresponding for a certain size */
> -struct kmem_cache *kmalloc_slab(size_t, gfp_t);
> -
> -void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
> -			      int node, size_t orig_size,
> -			      unsigned long caller);
> -void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller);
> -#endif
> -
>  gfp_t kmalloc_fix_flags(gfp_t flags);
>
>  /* Functions provided by the slab allocators */
> @@ -303,14 +217,6 @@ extern void create_boot_cache(struct kmem_cache *, const char *name,
>  int slab_unmergeable(struct kmem_cache *s);
>  struct kmem_cache *find_mergeable(unsigned size, unsigned align,
>  		slab_flags_t flags, const char *name, void (*ctor)(void *));
> -#ifndef CONFIG_SLOB
> -struct kmem_cache *
> -__kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
> -		   slab_flags_t flags, void (*ctor)(void *));
> -
> -slab_flags_t kmem_cache_flags(unsigned int object_size,
> -	slab_flags_t flags, const char *name);
> -#else
>  static inline struct kmem_cache *
>  __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>  		   slab_flags_t flags, void (*ctor)(void *))
> @@ -321,15 +227,10 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
>  {
>  	return flags;
>  }
> -#endif
>
>  static inline bool is_kmalloc_cache(struct kmem_cache *s)
>  {
> -#ifndef CONFIG_SLOB
> -	return (s->flags & SLAB_KMALLOC);
> -#else
>  	return false;
> -#endif
>  }
>
>  /* Legal flag mask for kmem_cache_create(), for various configurations */
> @@ -337,26 +238,9 @@ static inline bool is_kmalloc_cache(struct kmem_cache *s)
>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
>  			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
>
> -#if defined(CONFIG_DEBUG_SLAB)
> -#define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
> -#elif defined(CONFIG_SLUB_DEBUG)
> -#define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
> -			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS)
> -#else
>  #define SLAB_DEBUG_FLAGS (0)
> -#endif
>
> -#if defined(CONFIG_SLAB)
> -#define SLAB_CACHE_FLAGS (SLAB_MEM_SPREAD | SLAB_NOLEAKTRACE | \
> -			  SLAB_RECLAIM_ACCOUNT | SLAB_TEMPORARY | \
> -			  SLAB_ACCOUNT)
> -#elif defined(CONFIG_SLUB)
> -#define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
> -			  SLAB_TEMPORARY | SLAB_ACCOUNT | \
> -			  SLAB_NO_USER_FLAGS | SLAB_KMALLOC)
> -#else
>  #define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE)
> -#endif
>
>  /* Common flags available with current configuration */
>  #define CACHE_CREATE_MASK (SLAB_CORE_FLAGS | SLAB_DEBUG_FLAGS | SLAB_CACHE_FLAGS)
> @@ -409,19 +293,6 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
>  		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
>  }
>
> -#ifdef CONFIG_SLUB_DEBUG
> -#ifdef CONFIG_SLUB_DEBUG_ON
> -DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
> -#else
> -DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
> -#endif
> -extern void print_tracking(struct kmem_cache *s, void *object);
> -long validate_slab_cache(struct kmem_cache *s);
> -static inline bool __slub_debug_enabled(void)
> -{
> -	return static_branch_unlikely(&slub_debug_enabled);
> -}
> -#else
>  static inline void print_tracking(struct kmem_cache *s, void *object)
>  {
>  }
> @@ -429,7 +300,6 @@ static inline bool __slub_debug_enabled(void)
>  {
>  	return false;
>  }
> -#endif
>
>  /*
>   * Returns true if any of the specified slub_debug flags is enabled for the
> @@ -438,160 +308,9 @@ static inline bool __slub_debug_enabled(void)
>   */
>  static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
>  {
> -	if (IS_ENABLED(CONFIG_SLUB_DEBUG))
> -		VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
> -	if (__slub_debug_enabled())
> -		return s->flags & flags;
>  	return false;
>  }
>
> -#ifdef CONFIG_MEMCG_KMEM
> -/*
> - * slab_objcgs - get the object cgroups vector associated with a slab
> - * @slab: a pointer to the slab struct
> - *
> - * Returns a pointer to the object cgroups vector associated with the slab,
> - * or NULL if no such vector has been associated yet.
> - */
> -static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
> -{
> -	unsigned long memcg_data = READ_ONCE(slab->memcg_data);
> -
> -	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS),
> -							slab_page(slab));
> -	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, slab_page(slab));
> -
> -	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> -}
> -
> -int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
> -				 gfp_t gfp, bool new_slab);
> -void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> -		     enum node_stat_item idx, int nr);
> -
> -static inline void memcg_free_slab_cgroups(struct slab *slab)
> -{
> -	kfree(slab_objcgs(slab));
> -	slab->memcg_data = 0;
> -}
> -
> -static inline size_t obj_full_size(struct kmem_cache *s)
> -{
> -	/*
> -	 * For each accounted object there is an extra space which is used
> -	 * to store obj_cgroup membership. Charge it too.
> -	 */
> -	return s->size + sizeof(struct obj_cgroup *);
> -}
> -
> -/*
> - * Returns false if the allocation should fail.
> - */
> -static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> -					     struct list_lru *lru,
> -					     struct obj_cgroup **objcgp,
> -					     size_t objects, gfp_t flags)
> -{
> -	struct obj_cgroup *objcg;
> -
> -	if (!memcg_kmem_online())
> -		return true;
> -
> -	if (!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT))
> -		return true;
> -
> -	objcg = get_obj_cgroup_from_current();
> -	if (!objcg)
> -		return true;
> -
> -	if (lru) {
> -		int ret;
> -		struct mem_cgroup *memcg;
> -
> -		memcg = get_mem_cgroup_from_objcg(objcg);
> -		ret = memcg_list_lru_alloc(memcg, lru, flags);
> -		css_put(&memcg->css);
> -
> -		if (ret)
> -			goto out;
> -	}
> -
> -	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
> -		goto out;
> -
> -	*objcgp = objcg;
> -	return true;
> -out:
> -	obj_cgroup_put(objcg);
> -	return false;
> -}
> -
> -static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> -					      struct obj_cgroup *objcg,
> -					      gfp_t flags, size_t size,
> -					      void **p)
> -{
> -	struct slab *slab;
> -	unsigned long off;
> -	size_t i;
> -
> -	if (!memcg_kmem_online() || !objcg)
> -		return;
> -
> -	for (i = 0; i < size; i++) {
> -		if (likely(p[i])) {
> -			slab = virt_to_slab(p[i]);
> -
> -			if (!slab_objcgs(slab) &&
> -			    memcg_alloc_slab_cgroups(slab, s, flags,
> -							 false)) {
> -				obj_cgroup_uncharge(objcg, obj_full_size(s));
> -				continue;
> -			}
> -
> -			off = obj_to_index(s, slab, p[i]);
> -			obj_cgroup_get(objcg);
> -			slab_objcgs(slab)[off] = objcg;
> -			mod_objcg_state(objcg, slab_pgdat(slab),
> -					cache_vmstat_idx(s), obj_full_size(s));
> -		} else {
> -			obj_cgroup_uncharge(objcg, obj_full_size(s));
> -		}
> -	}
> -	obj_cgroup_put(objcg);
> -}
> -
> -static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -					void **p, int objects)
> -{
> -	struct obj_cgroup **objcgs;
> -	int i;
> -
> -	if (!memcg_kmem_online())
> -		return;
> -
> -	objcgs = slab_objcgs(slab);
> -	if (!objcgs)
> -		return;
> -
> -	for (i = 0; i < objects; i++) {
> -		struct obj_cgroup *objcg;
> -		unsigned int off;
> -
> -		off = obj_to_index(s, slab, p[i]);
> -		objcg = objcgs[off];
> -		if (!objcg)
> -			continue;
> -
> -		objcgs[off] = NULL;
> -		obj_cgroup_uncharge(objcg, obj_full_size(s));
> -		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
> -				-obj_full_size(s));
> -		obj_cgroup_put(objcg);
> -	}
> -}
> -
> -#else /* CONFIG_MEMCG_KMEM */
>  static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
>  {
>  	return NULL;
> @@ -632,90 +351,12 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  					void **p, int objects)
>  {
>  }
> -#endif /* CONFIG_MEMCG_KMEM */
> -
> -#ifndef CONFIG_SLOB
> -static inline struct kmem_cache *virt_to_cache(const void *obj)
> -{
> -	struct slab *slab;
> -
> -	slab = virt_to_slab(obj);
> -	if (WARN_ONCE(!slab, "%s: Object is not a Slab page!\n",
> -					__func__))
> -		return NULL;
> -	return slab->slab_cache;
> -}
> -
> -static __always_inline void account_slab(struct slab *slab, int order,
> -					 struct kmem_cache *s, gfp_t gfp)
> -{
> -	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> -		memcg_alloc_slab_cgroups(slab, s, gfp, true);
> -
> -	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> -			    PAGE_SIZE << order);
> -}
> -
> -static __always_inline void unaccount_slab(struct slab *slab, int order,
> -					   struct kmem_cache *s)
> -{
> -	if (memcg_kmem_online())
> -		memcg_free_slab_cgroups(slab);
> -
> -	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> -			    -(PAGE_SIZE << order));
> -}
> -
> -static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> -{
> -	struct kmem_cache *cachep;
> -
> -	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> -	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
> -		return s;
> -
> -	cachep = virt_to_cache(x);
> -	if (WARN(cachep && cachep != s,
> -		  "%s: Wrong slab cache. %s but object is from %s\n",
> -		  __func__, s->name, cachep->name))
> -		print_tracking(cachep, x);
> -	return cachep;
> -}
> -
> -void free_large_kmalloc(struct folio *folio, void *object);
> -
> -#endif /* CONFIG_SLOB */
>
>  size_t __ksize(const void *objp);
>
>  static inline size_t slab_ksize(const struct kmem_cache *s)
>  {
> -#ifndef CONFIG_SLUB
>  	return s->object_size;
> -
> -#else /* CONFIG_SLUB */
> -# ifdef CONFIG_SLUB_DEBUG
> -	/*
> -	 * Debugging requires use of the padding between object
> -	 * and whatever may come after it.
> -	 */
> -	if (s->flags & (SLAB_RED_ZONE | SLAB_POISON))
> -		return s->object_size;
> -# endif
> -	if (s->flags & SLAB_KASAN)
> -		return s->object_size;
> -	/*
> -	 * If we have the need to store the freelist pointer
> -	 * back there or track user information then we can
> -	 * only use the space before that information.
> -	 */
> -	if (s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_STORE_USER))
> -		return s->inuse;
> -	/*
> -	 * Else we can use all the padding etc for the allocation
> -	 */
> -	return s->size;
> -#endif
>  }
>
>  static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
> @@ -777,77 +418,18 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>  	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
>  }
>
> -#ifndef CONFIG_SLOB
> -/*
> - * The slab lists for all objects.
> - */
> -struct kmem_cache_node {
> -#ifdef CONFIG_SLAB
> -	raw_spinlock_t list_lock;
> -	struct list_head slabs_partial;	/* partial list first, better asm code */
> -	struct list_head slabs_full;
> -	struct list_head slabs_free;
> -	unsigned long total_slabs;	/* length of all slab lists */
> -	unsigned long free_slabs;	/* length of free slab list only */
> -	unsigned long free_objects;
> -	unsigned int free_limit;
> -	unsigned int colour_next;	/* Per-node cache coloring */
> -	struct array_cache *shared;	/* shared per node */
> -	struct alien_cache **alien;	/* on other nodes */
> -	unsigned long next_reap;	/* updated without locking */
> -	int free_touched;		/* updated without locking */
> -#endif
> -
> -#ifdef CONFIG_SLUB
> -	spinlock_t list_lock;
> -	unsigned long nr_partial;
> -	struct list_head partial;
> -#ifdef CONFIG_SLUB_DEBUG
> -	atomic_long_t nr_slabs;
> -	atomic_long_t total_objects;
> -	struct list_head full;
> -#endif
> -#endif
> -
> -};
> -
> -static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
> -{
> -	return s->node[node];
> -}
> -
> -/*
> - * Iterator over all nodes. The body will be executed for each node that has
> - * a kmem_cache_node structure allocated (which is true for all online nodes)
> - */
> -#define for_each_kmem_cache_node(__s, __node, __n) \
> -	for (__node = 0; __node < nr_node_ids; __node++) \
> -		 if ((__n = get_node(__s, __node)))
> -
> -#endif
> -
> -#if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
> -void dump_unreclaimable_slab(void);
> -#else
>  static inline void dump_unreclaimable_slab(void)
>  {
>  }
> -#endif
>
>  void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr);
>
> -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> -int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count,
> -			gfp_t gfp);
> -void cache_random_seq_destroy(struct kmem_cache *cachep);
> -#else
>  static inline int cache_random_seq_create(struct kmem_cache *cachep,
>  					unsigned int count, gfp_t gfp)
>  {
>  	return 0;
>  }
>  static inline void cache_random_seq_destroy(struct kmem_cache *cachep) { }
> -#endif /* CONFIG_SLAB_FREELIST_RANDOM */
>
>  static inline bool slab_want_init_on_alloc(gfp_t flags, struct kmem_cache *c)
>  {
> @@ -871,11 +453,7 @@ static inline bool slab_want_init_on_free(struct kmem_cache *c)
>  	return false;
>  }
>
> -#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
> -void debugfs_slab_release(struct kmem_cache *);
> -#else
>  static inline void debugfs_slab_release(struct kmem_cache *s) { }
> -#endif
>
>  #ifdef CONFIG_PRINTK
>  #define KS_ADDRS_COUNT 16
> @@ -903,8 +481,4 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  }
>  #endif
>
> -#ifdef CONFIG_SLUB_DEBUG
> -void skip_orig_size_check(struct kmem_cache *s, const void *object);
> -#endif
> -
>  #endif /* MM_SLAB_H */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index bf4e777cfe90..5f6a59e31abd 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -69,11 +69,6 @@ static int __init setup_slab_merge(char *str)
>  	return 1;
>  }
>
> -#ifdef CONFIG_SLUB
> -__setup_param("slub_nomerge", slub_nomerge, setup_slab_nomerge, 0);
> -__setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
> -#endif
> -
>  __setup("slab_nomerge", setup_slab_nomerge);
>  __setup("slab_merge", setup_slab_merge);
>
> @@ -195,15 +190,29 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
>  		if (s->size - size >= sizeof(void *))
>  			continue;
>
> -		if (IS_ENABLED(CONFIG_SLAB) && align &&
> -			(align > s->align || s->align % align))
> -			continue;
> -
>  		return s;
>  	}
>  	return NULL;
>  }
>
> +struct slab_rcu {
> +	struct rcu_head head;
> +	int size;
> +};
> +
> +int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
> +{
> +	if (flags & SLAB_TYPESAFE_BY_RCU) {
> +		/* leave room for rcu footer at the end of object */
> +		c->size += sizeof(struct slab_rcu);
> +	}
> +
> +	/* Actual size allocated */
> +	c->size = PAGE_SIZE << get_order(c->size);
> +	c->flags = flags;
> +	return 0;
> +}
> +
>  static struct kmem_cache *create_cache(const char *name,
>  		unsigned int object_size, unsigned int align,
>  		slab_flags_t flags, unsigned int useroffset,
> @@ -285,20 +294,6 @@ kmem_cache_create_usercopy(const char *name,
>  	const char *cache_name;
>  	int err;
>
> -#ifdef CONFIG_SLUB_DEBUG
> -	/*
> -	 * If no slub_debug was enabled globally, the static key is not yet
> -	 * enabled by setup_slub_debug(). Enable it if the cache is being
> -	 * created with any of the debugging flags passed explicitly.
> -	 * It's also possible that this is the first cache created with
> -	 * SLAB_STORE_USER and we should init stack_depot for it.
> -	 */
> -	if (flags & SLAB_DEBUG_FLAGS)
> -		static_branch_enable(&slub_debug_enabled);
> -	if (flags & SLAB_STORE_USER)
> -		stack_depot_init();
> -#endif
> -
>  	mutex_lock(&slab_mutex);
>
>  	err = kmem_cache_sanity_check(name, size);
> @@ -552,7 +547,8 @@ static void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *
>  {
>  	if (__kfence_obj_info(kpp, object, slab))
>  		return;
> -	__kmem_obj_info(kpp, object, slab);
> +	kpp->kp_ptr = object;
> +	kpp->kp_slab = slab;
>  }
>
>  /**
> @@ -625,462 +621,6 @@ void kmem_dump_obj(void *object)
>  EXPORT_SYMBOL_GPL(kmem_dump_obj);
>  #endif
>
> -#ifndef CONFIG_SLOB
> -/* Create a cache during boot when no slab services are available yet */
> -void __init create_boot_cache(struct kmem_cache *s, const char *name,
> -		unsigned int size, slab_flags_t flags,
> -		unsigned int useroffset, unsigned int usersize)
> -{
> -	int err;
> -	unsigned int align = ARCH_KMALLOC_MINALIGN;
> -
> -	s->name = name;
> -	s->size = s->object_size = size;
> -
> -	/*
> -	 * For power of two sizes, guarantee natural alignment for kmalloc
> -	 * caches, regardless of SL*B debugging options.
> -	 */
> -	if (is_power_of_2(size))
> -		align = max(align, size);
> -	s->align = calculate_alignment(flags, align, size);
> -
> -#ifdef CONFIG_HARDENED_USERCOPY
> -	s->useroffset = useroffset;
> -	s->usersize = usersize;
> -#endif
> -
> -	err = __kmem_cache_create(s, flags);
> -
> -	if (err)
> -		panic("Creation of kmalloc slab %s size=%u failed. Reason %d\n",
> -					name, size, err);
> -
> -	s->refcount = -1;	/* Exempt from merging for now */
> -}
> -
> -struct kmem_cache *__init create_kmalloc_cache(const char *name,
> -		unsigned int size, slab_flags_t flags,
> -		unsigned int useroffset, unsigned int usersize)
> -{
> -	struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);
> -
> -	if (!s)
> -		panic("Out of memory when creating slab %s\n", name);
> -
> -	create_boot_cache(s, name, size, flags | SLAB_KMALLOC, useroffset,
> -								usersize);
> -	list_add(&s->list, &slab_caches);
> -	s->refcount = 1;
> -	return s;
> -}
> -
> -struct kmem_cache *
> -kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1] __ro_after_init =
> -{ /* initialization for https://bugs.llvm.org/show_bug.cgi?id=42570 */ };
> -EXPORT_SYMBOL(kmalloc_caches);
> -
> -/*
> - * Conversion table for small slabs sizes / 8 to the index in the
> - * kmalloc array. This is necessary for slabs < 192 since we have non power
> - * of two cache sizes there. The size of larger slabs can be determined using
> - * fls.
> - */
> -static u8 size_index[24] __ro_after_init = {
> -	3,	/* 8 */
> -	4,	/* 16 */
> -	5,	/* 24 */
> -	5,	/* 32 */
> -	6,	/* 40 */
> -	6,	/* 48 */
> -	6,	/* 56 */
> -	6,	/* 64 */
> -	1,	/* 72 */
> -	1,	/* 80 */
> -	1,	/* 88 */
> -	1,	/* 96 */
> -	7,	/* 104 */
> -	7,	/* 112 */
> -	7,	/* 120 */
> -	7,	/* 128 */
> -	2,	/* 136 */
> -	2,	/* 144 */
> -	2,	/* 152 */
> -	2,	/* 160 */
> -	2,	/* 168 */
> -	2,	/* 176 */
> -	2,	/* 184 */
> -	2	/* 192 */
> -};
> -
> -static inline unsigned int size_index_elem(unsigned int bytes)
> -{
> -	return (bytes - 1) / 8;
> -}
> -
> -/*
> - * Find the kmem_cache structure that serves a given size of
> - * allocation
> - */
> -struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
> -{
> -	unsigned int index;
> -
> -	if (size <= 192) {
> -		if (!size)
> -			return ZERO_SIZE_PTR;
> -
> -		index = size_index[size_index_elem(size)];
> -	} else {
> -		if (WARN_ON_ONCE(size > KMALLOC_MAX_CACHE_SIZE))
> -			return NULL;
> -		index = fls(size - 1);
> -	}
> -
> -	return kmalloc_caches[kmalloc_type(flags)][index];
> -}
> -
> -size_t kmalloc_size_roundup(size_t size)
> -{
> -	struct kmem_cache *c;
> -
> -	/* Short-circuit the 0 size case. */
> -	if (unlikely(size == 0))
> -		return 0;
> -	/* Short-circuit saturated "too-large" case. */
> -	if (unlikely(size == SIZE_MAX))
> -		return SIZE_MAX;
> -	/* Above the smaller buckets, size is a multiple of page size. */
> -	if (size > KMALLOC_MAX_CACHE_SIZE)
> -		return PAGE_SIZE << get_order(size);
> -
> -	/* The flags don't matter since size_index is common to all. */
> -	c = kmalloc_slab(size, GFP_KERNEL);
> -	return c ? c->object_size : 0;
> -}
> -EXPORT_SYMBOL(kmalloc_size_roundup);
> -
> -#ifdef CONFIG_ZONE_DMA
> -#define KMALLOC_DMA_NAME(sz)	.name[KMALLOC_DMA] = "dma-kmalloc-" #sz,
> -#else
> -#define KMALLOC_DMA_NAME(sz)
> -#endif
> -
> -#ifdef CONFIG_MEMCG_KMEM
> -#define KMALLOC_CGROUP_NAME(sz)	.name[KMALLOC_CGROUP] = "kmalloc-cg-" #sz,
> -#else
> -#define KMALLOC_CGROUP_NAME(sz)
> -#endif
> -
> -#ifndef CONFIG_SLUB_TINY
> -#define KMALLOC_RCL_NAME(sz)	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #sz,
> -#else
> -#define KMALLOC_RCL_NAME(sz)
> -#endif
> -
> -#define INIT_KMALLOC_INFO(__size, __short_size)			\
> -{								\
> -	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
> -	KMALLOC_RCL_NAME(__short_size)				\
> -	KMALLOC_CGROUP_NAME(__short_size)			\
> -	KMALLOC_DMA_NAME(__short_size)				\
> -	.size = __size,						\
> -}
> -
> -/*
> - * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
> - * kmalloc_index() supports up to 2^21=2MB, so the final entry of the table is
> - * kmalloc-2M.
> - */
> -const struct kmalloc_info_struct kmalloc_info[] __initconst = {
> -	INIT_KMALLOC_INFO(0, 0),
> -	INIT_KMALLOC_INFO(96, 96),
> -	INIT_KMALLOC_INFO(192, 192),
> -	INIT_KMALLOC_INFO(8, 8),
> -	INIT_KMALLOC_INFO(16, 16),
> -	INIT_KMALLOC_INFO(32, 32),
> -	INIT_KMALLOC_INFO(64, 64),
> -	INIT_KMALLOC_INFO(128, 128),
> -	INIT_KMALLOC_INFO(256, 256),
> -	INIT_KMALLOC_INFO(512, 512),
> -	INIT_KMALLOC_INFO(1024, 1k),
> -	INIT_KMALLOC_INFO(2048, 2k),
> -	INIT_KMALLOC_INFO(4096, 4k),
> -	INIT_KMALLOC_INFO(8192, 8k),
> -	INIT_KMALLOC_INFO(16384, 16k),
> -	INIT_KMALLOC_INFO(32768, 32k),
> -	INIT_KMALLOC_INFO(65536, 64k),
> -	INIT_KMALLOC_INFO(131072, 128k),
> -	INIT_KMALLOC_INFO(262144, 256k),
> -	INIT_KMALLOC_INFO(524288, 512k),
> -	INIT_KMALLOC_INFO(1048576, 1M),
> -	INIT_KMALLOC_INFO(2097152, 2M)
> -};
> -
> -/*
> - * Patch up the size_index table if we have strange large alignment
> - * requirements for the kmalloc array. This is only the case for
> - * MIPS it seems. The standard arches will not generate any code here.
> - *
> - * Largest permitted alignment is 256 bytes due to the way we
> - * handle the index determination for the smaller caches.
> - *
> - * Make sure that nothing crazy happens if someone starts tinkering
> - * around with ARCH_KMALLOC_MINALIGN
> - */
> -void __init setup_kmalloc_cache_index_table(void)
> -{
> -	unsigned int i;
> -
> -	BUILD_BUG_ON(KMALLOC_MIN_SIZE > 256 ||
> -		!is_power_of_2(KMALLOC_MIN_SIZE));
> -
> -	for (i = 8; i < KMALLOC_MIN_SIZE; i += 8) {
> -		unsigned int elem = size_index_elem(i);
> -
> -		if (elem >= ARRAY_SIZE(size_index))
> -			break;
> -		size_index[elem] = KMALLOC_SHIFT_LOW;
> -	}
> -
> -	if (KMALLOC_MIN_SIZE >= 64) {
> -		/*
> -		 * The 96 byte sized cache is not used if the alignment
> -		 * is 64 byte.
> -		 */
> -		for (i = 64 + 8; i <= 96; i += 8)
> -			size_index[size_index_elem(i)] = 7;
> -
> -	}
> -
> -	if (KMALLOC_MIN_SIZE >= 128) {
> -		/*
> -		 * The 192 byte sized cache is not used if the alignment
> -		 * is 128 byte. Redirect kmalloc to use the 256 byte cache
> -		 * instead.
> -		 */
> -		for (i = 128 + 8; i <= 192; i += 8)
> -			size_index[size_index_elem(i)] = 8;
> -	}
> -}
> -
> -static void __init
> -new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
> -{
> -	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
> -		flags |= SLAB_RECLAIM_ACCOUNT;
> -	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
> -		if (mem_cgroup_kmem_disabled()) {
> -			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
> -			return;
> -		}
> -		flags |= SLAB_ACCOUNT;
> -	} else if (IS_ENABLED(CONFIG_ZONE_DMA) && (type == KMALLOC_DMA)) {
> -		flags |= SLAB_CACHE_DMA;
> -	}
> -
> -	kmalloc_caches[type][idx] = create_kmalloc_cache(
> -					kmalloc_info[idx].name[type],
> -					kmalloc_info[idx].size, flags, 0,
> -					kmalloc_info[idx].size);
> -
> -	/*
> -	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
> -	 * KMALLOC_NORMAL caches.
> -	 */
> -	if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_NORMAL))
> -		kmalloc_caches[type][idx]->refcount = -1;
> -}
> -
> -/*
> - * Create the kmalloc array. Some of the regular kmalloc arrays
> - * may already have been created because they were needed to
> - * enable allocations for slab creation.
> - */
> -void __init create_kmalloc_caches(slab_flags_t flags)
> -{
> -	int i;
> -	enum kmalloc_cache_type type;
> -
> -	/*
> -	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
> -	 */
> -	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
> -		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
> -			if (!kmalloc_caches[type][i])
> -				new_kmalloc_cache(i, type, flags);
> -
> -			/*
> -			 * Caches that are not of the two-to-the-power-of size.
> -			 * These have to be created immediately after the
> -			 * earlier power of two caches
> -			 */
> -			if (KMALLOC_MIN_SIZE <= 32 && i == 6 &&
> -					!kmalloc_caches[type][1])
> -				new_kmalloc_cache(1, type, flags);
> -			if (KMALLOC_MIN_SIZE <= 64 && i == 7 &&
> -					!kmalloc_caches[type][2])
> -				new_kmalloc_cache(2, type, flags);
> -		}
> -	}
> -
> -	/* Kmalloc array is now usable */
> -	slab_state = UP;
> -}
> -
> -void free_large_kmalloc(struct folio *folio, void *object)
> -{
> -	unsigned int order = folio_order(folio);
> -
> -	if (WARN_ON_ONCE(order == 0))
> -		pr_warn_once("object pointer: 0x%p\n", object);
> -
> -	kmemleak_free(object);
> -	kasan_kfree_large(object);
> -	kmsan_kfree_large(object);
> -
> -	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
> -			      -(PAGE_SIZE << order));
> -	__free_pages(folio_page(folio, 0), order);
> -}
> -
> -static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
> -static __always_inline
> -void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> -{
> -	struct kmem_cache *s;
> -	void *ret;
> -
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> -		ret = __kmalloc_large_node(size, flags, node);
> -		trace_kmalloc(caller, ret, size,
> -			      PAGE_SIZE << get_order(size), flags, node);
> -		return ret;
> -	}
> -
> -	s = kmalloc_slab(size, flags);
> -
> -	if (unlikely(ZERO_OR_NULL_PTR(s)))
> -		return s;
> -
> -	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
> -	ret = kasan_kmalloc(s, ret, size, flags);
> -	trace_kmalloc(caller, ret, size, s->size, flags, node);
> -	return ret;
> -}
> -
> -void *__kmalloc_node(size_t size, gfp_t flags, int node)
> -{
> -	return __do_kmalloc_node(size, flags, node, _RET_IP_);
> -}
> -EXPORT_SYMBOL(__kmalloc_node);
> -
> -void *__kmalloc(size_t size, gfp_t flags)
> -{
> -	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
> -}
> -EXPORT_SYMBOL(__kmalloc);
> -
> -void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
> -				  int node, unsigned long caller)
> -{
> -	return __do_kmalloc_node(size, flags, node, caller);
> -}
> -EXPORT_SYMBOL(__kmalloc_node_track_caller);
> -
> -/**
> - * kfree - free previously allocated memory
> - * @object: pointer returned by kmalloc.
> - *
> - * If @object is NULL, no operation is performed.
> - *
> - * Don't free memory not originally allocated by kmalloc()
> - * or you will run into trouble.
> - */
> -void kfree(const void *object)
> -{
> -	struct folio *folio;
> -	struct slab *slab;
> -	struct kmem_cache *s;
> -
> -	trace_kfree(_RET_IP_, object);
> -
> -	if (unlikely(ZERO_OR_NULL_PTR(object)))
> -		return;
> -
> -	folio = virt_to_folio(object);
> -	if (unlikely(!folio_test_slab(folio))) {
> -		free_large_kmalloc(folio, (void *)object);
> -		return;
> -	}
> -
> -	slab = folio_slab(folio);
> -	s = slab->slab_cache;
> -	__kmem_cache_free(s, (void *)object, _RET_IP_);
> -}
> -EXPORT_SYMBOL(kfree);
> -
> -/**
> - * __ksize -- Report full size of underlying allocation
> - * @object: pointer to the object
> - *
> - * This should only be used internally to query the true size of allocations.
> - * It is not meant to be a way to discover the usable size of an allocation
> - * after the fact. Instead, use kmalloc_size_roundup(). Using memory beyond
> - * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
> - * and/or FORTIFY_SOURCE.
> - *
> - * Return: size of the actual memory used by @object in bytes
> - */
> -size_t __ksize(const void *object)
> -{
> -	struct folio *folio;
> -
> -	if (unlikely(object == ZERO_SIZE_PTR))
> -		return 0;
> -
> -	folio = virt_to_folio(object);
> -
> -	if (unlikely(!folio_test_slab(folio))) {
> -		if (WARN_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE))
> -			return 0;
> -		if (WARN_ON(object != folio_address(folio)))
> -			return 0;
> -		return folio_size(folio);
> -	}
> -
> -#ifdef CONFIG_SLUB_DEBUG
> -	skip_orig_size_check(folio_slab(folio)->slab_cache, object);
> -#endif
> -
> -	return slab_ksize(folio_slab(folio)->slab_cache);
> -}
> -
> -void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
> -{
> -	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
> -					    size, _RET_IP_);
> -
> -	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
> -
> -	ret = kasan_kmalloc(s, ret, size, gfpflags);
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmalloc_trace);
> -
> -void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
> -			 int node, size_t size)
> -{
> -	void *ret = __kmem_cache_alloc_node(s, gfpflags, node, size, _RET_IP_);
> -
> -	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, node);
> -
> -	ret = kasan_kmalloc(s, ret, size, gfpflags);
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmalloc_node_trace);
> -#endif /* !CONFIG_SLOB */
> -
>  gfp_t kmalloc_fix_flags(gfp_t flags)
>  {
>  	gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
> @@ -1144,202 +684,44 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
>  }
>  EXPORT_SYMBOL(kmalloc_large_node);
>
> -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> -/* Randomize a generic freelist */
> -static void freelist_randomize(struct rnd_state *state, unsigned int *list,
> -			       unsigned int count)
> -{
> -	unsigned int rand;
> -	unsigned int i;
> -
> -	for (i = 0; i < count; i++)
> -		list[i] = i;
> -
> -	/* Fisher-Yates shuffle */
> -	for (i = count - 1; i > 0; i--) {
> -		rand = prandom_u32_state(state);
> -		rand %= (i + 1);
> -		swap(list[i], list[rand]);
> -	}
> -}
> -
> -/* Create a random sequence per cache */
> -int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count,
> -				    gfp_t gfp)
> -{
> -	struct rnd_state state;
> -
> -	if (count < 2 || cachep->random_seq)
> -		return 0;
> -
> -	cachep->random_seq = kcalloc(count, sizeof(unsigned int), gfp);
> -	if (!cachep->random_seq)
> -		return -ENOMEM;
> -
> -	/* Get best entropy at this stage of boot */
> -	prandom_seed_state(&state, get_random_long());
> -
> -	freelist_randomize(&state, cachep->random_seq, count);
> -	return 0;
> -}
> -
> -/* Destroy the per-cache random freelist sequence */
> -void cache_random_seq_destroy(struct kmem_cache *cachep)
> -{
> -	kfree(cachep->random_seq);
> -	cachep->random_seq = NULL;
> -}
> -#endif /* CONFIG_SLAB_FREELIST_RANDOM */
> -
> -#if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
> -#ifdef CONFIG_SLAB
> -#define SLABINFO_RIGHTS (0600)
> -#else
> -#define SLABINFO_RIGHTS (0400)
> -#endif
> -
> -static void print_slabinfo_header(struct seq_file *m)
> -{
> -	/*
> -	 * Output format version, so at least we can change it
> -	 * without _too_ many complaints.
> -	 */
> -#ifdef CONFIG_DEBUG_SLAB
> -	seq_puts(m, "slabinfo - version: 2.1 (statistics)\n");
> -#else
> -	seq_puts(m, "slabinfo - version: 2.1\n");
> -#endif
> -	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
> -	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
> -	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
> -#ifdef CONFIG_DEBUG_SLAB
> -	seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> <alienoverflow>");
> -	seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
> -#endif
> -	seq_putc(m, '\n');
> -}
> -
> -static void *slab_start(struct seq_file *m, loff_t *pos)
> -{
> -	mutex_lock(&slab_mutex);
> -	return seq_list_start(&slab_caches, *pos);
> -}
> -
> -static void *slab_next(struct seq_file *m, void *p, loff_t *pos)
> -{
> -	return seq_list_next(p, &slab_caches, pos);
> -}
> -
> -static void slab_stop(struct seq_file *m, void *p)
> -{
> -	mutex_unlock(&slab_mutex);
> -}
> -
> -static void cache_show(struct kmem_cache *s, struct seq_file *m)
> +static __always_inline void *
> +__do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
>  {
> -	struct slabinfo sinfo;
> +	void *ret;
>
> -	memset(&sinfo, 0, sizeof(sinfo));
> -	get_slabinfo(s, &sinfo);
> +	gfp &= gfp_allowed_mask;
>
> -	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
> -		   s->name, sinfo.active_objs, sinfo.num_objs, s->size,
> -		   sinfo.objects_per_slab, (1 << sinfo.cache_order));
> +	might_alloc(gfp);
>
> -	seq_printf(m, " : tunables %4u %4u %4u",
> -		   sinfo.limit, sinfo.batchcount, sinfo.shared);
> -	seq_printf(m, " : slabdata %6lu %6lu %6lu",
> -		   sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail);
> -	slabinfo_show_stats(m, s);
> -	seq_putc(m, '\n');
> -}
> +	if (unlikely(!size))
> +		ret = ZERO_SIZE_PTR;
> +	else
> +		ret = __kmalloc_large_node(size, gfp, node);
>
> -static int slab_show(struct seq_file *m, void *p)
> -{
> -	struct kmem_cache *s = list_entry(p, struct kmem_cache, list);
> +	trace_kmalloc(caller, ret, size, PAGE_SIZE << get_order(size), gfp, node);
>
> -	if (p == slab_caches.next)
> -		print_slabinfo_header(m);
> -	cache_show(s, m);
> -	return 0;
> +	kmemleak_alloc(ret, size, 1, gfp);
> +	return ret;
>  }
>
> -void dump_unreclaimable_slab(void)
> +void *__kmalloc(size_t size, gfp_t gfp)
>  {
> -	struct kmem_cache *s;
> -	struct slabinfo sinfo;
> -
> -	/*
> -	 * Here acquiring slab_mutex is risky since we don't prefer to get
> -	 * sleep in oom path. But, without mutex hold, it may introduce a
> -	 * risk of crash.
> -	 * Use mutex_trylock to protect the list traverse, dump nothing
> -	 * without acquiring the mutex.
> -	 */
> -	if (!mutex_trylock(&slab_mutex)) {
> -		pr_warn("excessive unreclaimable slab but cannot dump stats\n");
> -		return;
> -	}
> -
> -	pr_info("Unreclaimable slab info:\n");
> -	pr_info("Name                      Used          Total\n");
> -
> -	list_for_each_entry(s, &slab_caches, list) {
> -		if (s->flags & SLAB_RECLAIM_ACCOUNT)
> -			continue;
> -
> -		get_slabinfo(s, &sinfo);
> -
> -		if (sinfo.num_objs > 0)
> -			pr_info("%-17s %10luKB %10luKB\n", s->name,
> -				(sinfo.active_objs * s->size) / 1024,
> -				(sinfo.num_objs * s->size) / 1024);
> -	}
> -	mutex_unlock(&slab_mutex);
> +	return __do_kmalloc_node(size, gfp, NUMA_NO_NODE, _RET_IP_);
>  }
> +EXPORT_SYMBOL(__kmalloc);
>
> -/*
> - * slabinfo_op - iterator that generates /proc/slabinfo
> - *
> - * Output layout:
> - * cache-name
> - * num-active-objs
> - * total-objs
> - * object size
> - * num-active-slabs
> - * total-slabs
> - * num-pages-per-slab
> - * + further values on SMP and with statistics enabled
> - */
> -static const struct seq_operations slabinfo_op = {
> -	.start = slab_start,
> -	.next = slab_next,
> -	.stop = slab_stop,
> -	.show = slab_show,
> -};
> -
> -static int slabinfo_open(struct inode *inode, struct file *file)
> +void *__kmalloc_node(size_t size, gfp_t gfp, int node)
>  {
> -	return seq_open(file, &slabinfo_op);
> +	return __do_kmalloc_node(size, gfp, node, _RET_IP_);
>  }
> +EXPORT_SYMBOL(__kmalloc_node);
>
> -static const struct proc_ops slabinfo_proc_ops = {
> -	.proc_flags	= PROC_ENTRY_PERMANENT,
> -	.proc_open	= slabinfo_open,
> -	.proc_read	= seq_read,
> -	.proc_write	= slabinfo_write,
> -	.proc_lseek	= seq_lseek,
> -	.proc_release	= seq_release,
> -};
> -
> -static int __init slab_proc_init(void)
> +void *__kmalloc_node_track_caller(size_t size, gfp_t gfp,
> +					int node, unsigned long caller)
>  {
> -	proc_create("slabinfo", SLABINFO_RIGHTS, NULL, &slabinfo_proc_ops);
> -	return 0;
> +	return __do_kmalloc_node(size, gfp, node, caller);
>  }
> -module_init(slab_proc_init);
> -
> -#endif /* CONFIG_SLAB || CONFIG_SLUB_DEBUG */
> +EXPORT_SYMBOL(__kmalloc_node_track_caller);
>
>  static __always_inline __realloc_size(2) void *
>  __do_krealloc(const void *p, size_t new_size, gfp_t flags)
> @@ -1402,6 +784,27 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
>  }
>  EXPORT_SYMBOL(krealloc);
>
> +void kfree(const void *block)
> +{
> +	struct folio *sp;
> +	unsigned int order;
> +
> +	trace_kfree(_RET_IP_, block);
> +
> +	if (unlikely(ZERO_OR_NULL_PTR(block)))
> +		return;
> +	kmemleak_free(block);
> +
> +	sp = virt_to_folio(block);
> +	BUG_ON(folio_test_slab(sp));
> +	order = folio_order(sp);
> +
> +	mod_node_page_state(folio_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
> +			    -(PAGE_SIZE << order));
> +	__free_pages(folio_page(sp, 0), order);
> +}
> +EXPORT_SYMBOL(kfree);
> +
>  /**
>   * kfree_sensitive - Clear sensitive information in memory before freeing
>   * @p: object to free memory of
> @@ -1427,6 +830,34 @@ void kfree_sensitive(const void *p)
>  }
>  EXPORT_SYMBOL(kfree_sensitive);
>
> +size_t kmalloc_size_roundup(size_t size)
> +{
> +	/* Short-circuit the 0 size case. */
> +	if (unlikely(size == 0))
> +		return 0;
> +	/* Short-circuit saturated "too-large" case. */
> +	if (unlikely(size == SIZE_MAX))
> +		return SIZE_MAX;
> +
> +	return PAGE_SIZE << get_order(size);
> +}
> +
> +EXPORT_SYMBOL(kmalloc_size_roundup);
> +
> +/* can't use ksize for kmem_cache_alloc memory, only kmalloc */
> +size_t __ksize(const void *block)
> +{
> +	struct folio *folio;
> +
> +	BUG_ON(!block);
> +	if (unlikely(block == ZERO_SIZE_PTR))
> +		return 0;
> +
> +	folio = virt_to_folio(block);
> +	BUG_ON(folio_test_slab(folio));
> +	return folio_size(folio);
> +}
> +
>  size_t ksize(const void *objp)
>  {
>  	/*
> @@ -1451,6 +882,131 @@ size_t ksize(const void *objp)
>  }
>  EXPORT_SYMBOL(ksize);
>
> +static void *__kmem_cache_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
> +{
> +	void *b;
> +
> +	flags &= gfp_allowed_mask;
> +
> +	might_alloc(flags);
> +
> +	b = __kmalloc_large_node(c->size, flags, node);
> +	trace_kmem_cache_alloc(_RET_IP_, b, c, flags, node);
> +
> +	if (b && c->ctor) {
> +		WARN_ON_ONCE(flags & __GFP_ZERO);
> +		c->ctor(b);
> +	}
> +
> +	kmemleak_alloc_recursive(b, c->size, 1, c->flags, flags);
> +	return b;
> +}
> +
> +void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
> +{
> +	return __kmem_cache_alloc_node(cachep, flags, NUMA_NO_NODE);
> +}
> +EXPORT_SYMBOL(kmem_cache_alloc);
> +
> +
> +void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags)
> +{
> +	return __kmem_cache_alloc_node(cachep, flags, NUMA_NO_NODE);
> +}
> +EXPORT_SYMBOL(kmem_cache_alloc_lru);
> +
> +void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int node)
> +{
> +	return __kmem_cache_alloc_node(cachep, gfp, node);
> +}
> +EXPORT_SYMBOL(kmem_cache_alloc_node);
> +
> +static void kmem_rcu_free(struct rcu_head *head)
> +{
> +	struct slab_rcu *slab_rcu = (struct slab_rcu *)head;
> +	void *b = (void *)slab_rcu - (slab_rcu->size - sizeof(struct slab_rcu));
> +
> +	kfree(b);
> +}
> +
> +void kmem_cache_free(struct kmem_cache *c, void *b)
> +{
> +	kmemleak_free_recursive(b, c->flags);
> +	trace_kmem_cache_free(_RET_IP_, b, c);
> +	if (unlikely(c->flags & SLAB_TYPESAFE_BY_RCU)) {
> +		struct slab_rcu *slab_rcu;
> +		slab_rcu = b + (c->size - sizeof(struct slab_rcu));
> +		slab_rcu->size = c->size;
> +		call_rcu(&slab_rcu->head, kmem_rcu_free);
> +	} else {
> +		kfree(b);
> +	}
> +}
> +EXPORT_SYMBOL(kmem_cache_free);
> +
> +void kmem_cache_free_bulk(struct kmem_cache *s, size_t nr, void **p)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < nr; i++) {
> +		if (s)
> +			kmem_cache_free(s, p[i]);
> +		else
> +			kfree(p[i]);
> +	}
> +}
> +EXPORT_SYMBOL(kmem_cache_free_bulk);
> +
> +int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
> +								void **p)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < nr; i++) {
> +		void *x = p[i] = kmem_cache_alloc(s, flags);
> +
> +		if (!x) {
> +			kmem_cache_free_bulk(s, i, p);
> +			return 0;
> +		}
> +	}
> +	return i;
> +}
> +EXPORT_SYMBOL(kmem_cache_alloc_bulk);
> +
> +int __kmem_cache_shutdown(struct kmem_cache *c)
> +{
> +	/* No way to check for remaining objects */
> +	return 0;
> +}
> +
> +void __kmem_cache_release(struct kmem_cache *c)
> +{
> +}
> +
> +int __kmem_cache_shrink(struct kmem_cache *d)
> +{
> +	return 0;
> +}
> +
> +static struct kmem_cache kmem_cache_boot = {
> +	.name = "kmem_cache",
> +	.size = sizeof(struct kmem_cache),
> +	.flags = SLAB_PANIC,
> +	.align = ARCH_KMALLOC_MINALIGN,
> +};
> +
> +void __init kmem_cache_init(void)
> +{
> +	kmem_cache = &kmem_cache_boot;
> +	slab_state = UP;
> +}
> +
> +void __init kmem_cache_init_late(void)
> +{
> +	slab_state = FULL;
> +}
> +
>  /* Tracepoints definitions. */
>  EXPORT_TRACEPOINT_SYMBOL(kmalloc);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
> diff --git a/mm/slob.c b/mm/slob.c
> deleted file mode 100644
> index fe567fcfa3a3..000000000000
> --- a/mm/slob.c
> +++ /dev/null
> @@ -1,757 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * SLOB Allocator: Simple List Of Blocks
> - *
> - * Matt Mackall <mpm@selenic.com> 12/30/03
> - *
> - * NUMA support by Paul Mundt, 2007.
> - *
> - * How SLOB works:
> - *
> - * The core of SLOB is a traditional K&R style heap allocator, with
> - * support for returning aligned objects. The granularity of this
> - * allocator is as little as 2 bytes, however typically most architectures
> - * will require 4 bytes on 32-bit and 8 bytes on 64-bit.
> - *
> - * The slob heap is a set of linked list of pages from alloc_pages(),
> - * and within each page, there is a singly-linked list of free blocks
> - * (slob_t). The heap is grown on demand. To reduce fragmentation,
> - * heap pages are segregated into three lists, with objects less than
> - * 256 bytes, objects less than 1024 bytes, and all other objects.
> - *
> - * Allocation from heap involves first searching for a page with
> - * sufficient free blocks (using a next-fit-like approach) followed by
> - * a first-fit scan of the page. Deallocation inserts objects back
> - * into the free list in address order, so this is effectively an
> - * address-ordered first fit.
> - *
> - * Above this is an implementation of kmalloc/kfree. Blocks returned
> - * from kmalloc are prepended with a 4-byte header with the kmalloc size.
> - * If kmalloc is asked for objects of PAGE_SIZE or larger, it calls
> - * alloc_pages() directly, allocating compound pages so the page order
> - * does not have to be separately tracked.
> - * These objects are detected in kfree() because folio_test_slab()
> - * is false for them.
> - *
> - * SLAB is emulated on top of SLOB by simply calling constructors and
> - * destructors for every SLAB allocation. Objects are returned with the
> - * 4-byte alignment unless the SLAB_HWCACHE_ALIGN flag is set, in which
> - * case the low-level allocator will fragment blocks to create the proper
> - * alignment. Again, objects of page-size or greater are allocated by
> - * calling alloc_pages(). As SLAB objects know their size, no separate
> - * size bookkeeping is necessary and there is essentially no allocation
> - * space overhead, and compound pages aren't needed for multi-page
> - * allocations.
> - *
> - * NUMA support in SLOB is fairly simplistic, pushing most of the real
> - * logic down to the page allocator, and simply doing the node accounting
> - * on the upper levels. In the event that a node id is explicitly
> - * provided, __alloc_pages_node() with the specified node id is used
> - * instead. The common case (or when the node id isn't explicitly provided)
> - * will default to the current node, as per numa_node_id().
> - *
> - * Node aware pages are still inserted in to the global freelist, and
> - * these are scanned for by matching against the node id encoded in the
> - * page flags. As a result, block allocations that can be satisfied from
> - * the freelist will only be done so on pages residing on the same node,
> - * in order to prevent random node placement.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -
> -#include <linux/mm.h>
> -#include <linux/swap.h> /* struct reclaim_state */
> -#include <linux/cache.h>
> -#include <linux/init.h>
> -#include <linux/export.h>
> -#include <linux/rcupdate.h>
> -#include <linux/list.h>
> -#include <linux/kmemleak.h>
> -
> -#include <trace/events/kmem.h>
> -
> -#include <linux/atomic.h>
> -
> -#include "slab.h"
> -/*
> - * slob_block has a field 'units', which indicates size of block if +ve,
> - * or offset of next block if -ve (in SLOB_UNITs).
> - *
> - * Free blocks of size 1 unit simply contain the offset of the next block.
> - * Those with larger size contain their size in the first SLOB_UNIT of
> - * memory, and the offset of the next free block in the second SLOB_UNIT.
> - */
> -#if PAGE_SIZE <= (32767 * 2)
> -typedef s16 slobidx_t;
> -#else
> -typedef s32 slobidx_t;
> -#endif
> -
> -struct slob_block {
> -	slobidx_t units;
> -};
> -typedef struct slob_block slob_t;
> -
> -/*
> - * All partially free slob pages go on these lists.
> - */
> -#define SLOB_BREAK1 256
> -#define SLOB_BREAK2 1024
> -static LIST_HEAD(free_slob_small);
> -static LIST_HEAD(free_slob_medium);
> -static LIST_HEAD(free_slob_large);
> -
> -/*
> - * slob_page_free: true for pages on free_slob_pages list.
> - */
> -static inline int slob_page_free(struct slab *slab)
> -{
> -	return PageSlobFree(slab_page(slab));
> -}
> -
> -static void set_slob_page_free(struct slab *slab, struct list_head *list)
> -{
> -	list_add(&slab->slab_list, list);
> -	__SetPageSlobFree(slab_page(slab));
> -}
> -
> -static inline void clear_slob_page_free(struct slab *slab)
> -{
> -	list_del(&slab->slab_list);
> -	__ClearPageSlobFree(slab_page(slab));
> -}
> -
> -#define SLOB_UNIT sizeof(slob_t)
> -#define SLOB_UNITS(size) DIV_ROUND_UP(size, SLOB_UNIT)
> -
> -/*
> - * struct slob_rcu is inserted at the tail of allocated slob blocks, which
> - * were created with a SLAB_TYPESAFE_BY_RCU slab. slob_rcu is used to free
> - * the block using call_rcu.
> - */
> -struct slob_rcu {
> -	struct rcu_head head;
> -	int size;
> -};
> -
> -/*
> - * slob_lock protects all slob allocator structures.
> - */
> -static DEFINE_SPINLOCK(slob_lock);
> -
> -/*
> - * Encode the given size and next info into a free slob block s.
> - */
> -static void set_slob(slob_t *s, slobidx_t size, slob_t *next)
> -{
> -	slob_t *base = (slob_t *)((unsigned long)s & PAGE_MASK);
> -	slobidx_t offset = next - base;
> -
> -	if (size > 1) {
> -		s[0].units = size;
> -		s[1].units = offset;
> -	} else
> -		s[0].units = -offset;
> -}
> -
> -/*
> - * Return the size of a slob block.
> - */
> -static slobidx_t slob_units(slob_t *s)
> -{
> -	if (s->units > 0)
> -		return s->units;
> -	return 1;
> -}
> -
> -/*
> - * Return the next free slob block pointer after this one.
> - */
> -static slob_t *slob_next(slob_t *s)
> -{
> -	slob_t *base = (slob_t *)((unsigned long)s & PAGE_MASK);
> -	slobidx_t next;
> -
> -	if (s[0].units < 0)
> -		next = -s[0].units;
> -	else
> -		next = s[1].units;
> -	return base+next;
> -}
> -
> -/*
> - * Returns true if s is the last free block in its page.
> - */
> -static int slob_last(slob_t *s)
> -{
> -	return !((unsigned long)slob_next(s) & ~PAGE_MASK);
> -}
> -
> -static void *slob_new_pages(gfp_t gfp, int order, int node)
> -{
> -	struct page *page;
> -
> -#ifdef CONFIG_NUMA
> -	if (node != NUMA_NO_NODE)
> -		page = __alloc_pages_node(node, gfp, order);
> -	else
> -#endif
> -		page = alloc_pages(gfp, order);
> -
> -	if (!page)
> -		return NULL;
> -
> -	mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
> -			    PAGE_SIZE << order);
> -	return page_address(page);
> -}
> -
> -static void slob_free_pages(void *b, int order)
> -{
> -	struct page *sp = virt_to_page(b);
> -
> -	if (current->reclaim_state)
> -		current->reclaim_state->reclaimed_slab += 1 << order;
> -
> -	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
> -			    -(PAGE_SIZE << order));
> -	__free_pages(sp, order);
> -}
> -
> -/*
> - * slob_page_alloc() - Allocate a slob block within a given slob_page sp.
> - * @sp: Page to look in.
> - * @size: Size of the allocation.
> - * @align: Allocation alignment.
> - * @align_offset: Offset in the allocated block that will be aligned.
> - * @page_removed_from_list: Return parameter.
> - *
> - * Tries to find a chunk of memory at least @size bytes big within @page.
> - *
> - * Return: Pointer to memory if allocated, %NULL otherwise.  If the
> - *         allocation fills up @page then the page is removed from the
> - *         freelist, in this case @page_removed_from_list will be set to
> - *         true (set to false otherwise).
> - */
> -static void *slob_page_alloc(struct slab *sp, size_t size, int align,
> -			      int align_offset, bool *page_removed_from_list)
> -{
> -	slob_t *prev, *cur, *aligned = NULL;
> -	int delta = 0, units = SLOB_UNITS(size);
> -
> -	*page_removed_from_list = false;
> -	for (prev = NULL, cur = sp->freelist; ; prev = cur, cur = slob_next(cur)) {
> -		slobidx_t avail = slob_units(cur);
> -
> -		/*
> -		 * 'aligned' will hold the address of the slob block so that the
> -		 * address 'aligned'+'align_offset' is aligned according to the
> -		 * 'align' parameter. This is for kmalloc() which prepends the
> -		 * allocated block with its size, so that the block itself is
> -		 * aligned when needed.
> -		 */
> -		if (align) {
> -			aligned = (slob_t *)
> -				(ALIGN((unsigned long)cur + align_offset, align)
> -				 - align_offset);
> -			delta = aligned - cur;
> -		}
> -		if (avail >= units + delta) { /* room enough? */
> -			slob_t *next;
> -
> -			if (delta) { /* need to fragment head to align? */
> -				next = slob_next(cur);
> -				set_slob(aligned, avail - delta, next);
> -				set_slob(cur, delta, aligned);
> -				prev = cur;
> -				cur = aligned;
> -				avail = slob_units(cur);
> -			}
> -
> -			next = slob_next(cur);
> -			if (avail == units) { /* exact fit? unlink. */
> -				if (prev)
> -					set_slob(prev, slob_units(prev), next);
> -				else
> -					sp->freelist = next;
> -			} else { /* fragment */
> -				if (prev)
> -					set_slob(prev, slob_units(prev), cur + units);
> -				else
> -					sp->freelist = cur + units;
> -				set_slob(cur + units, avail - units, next);
> -			}
> -
> -			sp->units -= units;
> -			if (!sp->units) {
> -				clear_slob_page_free(sp);
> -				*page_removed_from_list = true;
> -			}
> -			return cur;
> -		}
> -		if (slob_last(cur))
> -			return NULL;
> -	}
> -}
> -
> -/*
> - * slob_alloc: entry point into the slob allocator.
> - */
> -static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
> -							int align_offset)
> -{
> -	struct folio *folio;
> -	struct slab *sp;
> -	struct list_head *slob_list;
> -	slob_t *b = NULL;
> -	unsigned long flags;
> -	bool _unused;
> -
> -	if (size < SLOB_BREAK1)
> -		slob_list = &free_slob_small;
> -	else if (size < SLOB_BREAK2)
> -		slob_list = &free_slob_medium;
> -	else
> -		slob_list = &free_slob_large;
> -
> -	spin_lock_irqsave(&slob_lock, flags);
> -	/* Iterate through each partially free page, try to find room */
> -	list_for_each_entry(sp, slob_list, slab_list) {
> -		bool page_removed_from_list = false;
> -#ifdef CONFIG_NUMA
> -		/*
> -		 * If there's a node specification, search for a partial
> -		 * page with a matching node id in the freelist.
> -		 */
> -		if (node != NUMA_NO_NODE && slab_nid(sp) != node)
> -			continue;
> -#endif
> -		/* Enough room on this page? */
> -		if (sp->units < SLOB_UNITS(size))
> -			continue;
> -
> -		b = slob_page_alloc(sp, size, align, align_offset, &page_removed_from_list);
> -		if (!b)
> -			continue;
> -
> -		/*
> -		 * If slob_page_alloc() removed sp from the list then we
> -		 * cannot call list functions on sp.  If so allocation
> -		 * did not fragment the page anyway so optimisation is
> -		 * unnecessary.
> -		 */
> -		if (!page_removed_from_list) {
> -			/*
> -			 * Improve fragment distribution and reduce our average
> -			 * search time by starting our next search here. (see
> -			 * Knuth vol 1, sec 2.5, pg 449)
> -			 */
> -			if (!list_is_first(&sp->slab_list, slob_list))
> -				list_rotate_to_front(&sp->slab_list, slob_list);
> -		}
> -		break;
> -	}
> -	spin_unlock_irqrestore(&slob_lock, flags);
> -
> -	/* Not enough space: must allocate a new page */
> -	if (!b) {
> -		b = slob_new_pages(gfp & ~__GFP_ZERO, 0, node);
> -		if (!b)
> -			return NULL;
> -		folio = virt_to_folio(b);
> -		__folio_set_slab(folio);
> -		sp = folio_slab(folio);
> -
> -		spin_lock_irqsave(&slob_lock, flags);
> -		sp->units = SLOB_UNITS(PAGE_SIZE);
> -		sp->freelist = b;
> -		INIT_LIST_HEAD(&sp->slab_list);
> -		set_slob(b, SLOB_UNITS(PAGE_SIZE), b + SLOB_UNITS(PAGE_SIZE));
> -		set_slob_page_free(sp, slob_list);
> -		b = slob_page_alloc(sp, size, align, align_offset, &_unused);
> -		BUG_ON(!b);
> -		spin_unlock_irqrestore(&slob_lock, flags);
> -	}
> -	if (unlikely(gfp & __GFP_ZERO))
> -		memset(b, 0, size);
> -	return b;
> -}
> -
> -/*
> - * slob_free: entry point into the slob allocator.
> - */
> -static void slob_free(void *block, int size)
> -{
> -	struct slab *sp;
> -	slob_t *prev, *next, *b = (slob_t *)block;
> -	slobidx_t units;
> -	unsigned long flags;
> -	struct list_head *slob_list;
> -
> -	if (unlikely(ZERO_OR_NULL_PTR(block)))
> -		return;
> -	BUG_ON(!size);
> -
> -	sp = virt_to_slab(block);
> -	units = SLOB_UNITS(size);
> -
> -	spin_lock_irqsave(&slob_lock, flags);
> -
> -	if (sp->units + units == SLOB_UNITS(PAGE_SIZE)) {
> -		/* Go directly to page allocator. Do not pass slob allocator */
> -		if (slob_page_free(sp))
> -			clear_slob_page_free(sp);
> -		spin_unlock_irqrestore(&slob_lock, flags);
> -		__folio_clear_slab(slab_folio(sp));
> -		slob_free_pages(b, 0);
> -		return;
> -	}
> -
> -	if (!slob_page_free(sp)) {
> -		/* This slob page is about to become partially free. Easy! */
> -		sp->units = units;
> -		sp->freelist = b;
> -		set_slob(b, units,
> -			(void *)((unsigned long)(b +
> -					SLOB_UNITS(PAGE_SIZE)) & PAGE_MASK));
> -		if (size < SLOB_BREAK1)
> -			slob_list = &free_slob_small;
> -		else if (size < SLOB_BREAK2)
> -			slob_list = &free_slob_medium;
> -		else
> -			slob_list = &free_slob_large;
> -		set_slob_page_free(sp, slob_list);
> -		goto out;
> -	}
> -
> -	/*
> -	 * Otherwise the page is already partially free, so find reinsertion
> -	 * point.
> -	 */
> -	sp->units += units;
> -
> -	if (b < (slob_t *)sp->freelist) {
> -		if (b + units == sp->freelist) {
> -			units += slob_units(sp->freelist);
> -			sp->freelist = slob_next(sp->freelist);
> -		}
> -		set_slob(b, units, sp->freelist);
> -		sp->freelist = b;
> -	} else {
> -		prev = sp->freelist;
> -		next = slob_next(prev);
> -		while (b > next) {
> -			prev = next;
> -			next = slob_next(prev);
> -		}
> -
> -		if (!slob_last(prev) && b + units == next) {
> -			units += slob_units(next);
> -			set_slob(b, units, slob_next(next));
> -		} else
> -			set_slob(b, units, next);
> -
> -		if (prev + slob_units(prev) == b) {
> -			units = slob_units(b) + slob_units(prev);
> -			set_slob(prev, units, slob_next(b));
> -		} else
> -			set_slob(prev, slob_units(prev), b);
> -	}
> -out:
> -	spin_unlock_irqrestore(&slob_lock, flags);
> -}
> -
> -#ifdef CONFIG_PRINTK
> -void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
> -{
> -	kpp->kp_ptr = object;
> -	kpp->kp_slab = slab;
> -}
> -#endif
> -
> -/*
> - * End of slob allocator proper. Begin kmem_cache_alloc and kmalloc frontend.
> - */
> -
> -static __always_inline void *
> -__do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
> -{
> -	unsigned int *m;
> -	unsigned int minalign;
> -	void *ret;
> -
> -	minalign = max_t(unsigned int, ARCH_KMALLOC_MINALIGN,
> -			 arch_slab_minalign());
> -	gfp &= gfp_allowed_mask;
> -
> -	might_alloc(gfp);
> -
> -	if (size < PAGE_SIZE - minalign) {
> -		int align = minalign;
> -
> -		/*
> -		 * For power of two sizes, guarantee natural alignment for
> -		 * kmalloc()'d objects.
> -		 */
> -		if (is_power_of_2(size))
> -			align = max_t(unsigned int, minalign, size);
> -
> -		if (!size)
> -			return ZERO_SIZE_PTR;
> -
> -		m = slob_alloc(size + minalign, gfp, align, node, minalign);
> -
> -		if (!m)
> -			return NULL;
> -		*m = size;
> -		ret = (void *)m + minalign;
> -
> -		trace_kmalloc(caller, ret, size, size + minalign, gfp, node);
> -	} else {
> -		unsigned int order = get_order(size);
> -
> -		if (likely(order))
> -			gfp |= __GFP_COMP;
> -		ret = slob_new_pages(gfp, order, node);
> -
> -		trace_kmalloc(caller, ret, size, PAGE_SIZE << order, gfp, node);
> -	}
> -
> -	kmemleak_alloc(ret, size, 1, gfp);
> -	return ret;
> -}
> -
> -void *__kmalloc(size_t size, gfp_t gfp)
> -{
> -	return __do_kmalloc_node(size, gfp, NUMA_NO_NODE, _RET_IP_);
> -}
> -EXPORT_SYMBOL(__kmalloc);
> -
> -void *__kmalloc_node_track_caller(size_t size, gfp_t gfp,
> -					int node, unsigned long caller)
> -{
> -	return __do_kmalloc_node(size, gfp, node, caller);
> -}
> -EXPORT_SYMBOL(__kmalloc_node_track_caller);
> -
> -void kfree(const void *block)
> -{
> -	struct folio *sp;
> -
> -	trace_kfree(_RET_IP_, block);
> -
> -	if (unlikely(ZERO_OR_NULL_PTR(block)))
> -		return;
> -	kmemleak_free(block);
> -
> -	sp = virt_to_folio(block);
> -	if (folio_test_slab(sp)) {
> -		unsigned int align = max_t(unsigned int,
> -					   ARCH_KMALLOC_MINALIGN,
> -					   arch_slab_minalign());
> -		unsigned int *m = (unsigned int *)(block - align);
> -
> -		slob_free(m, *m + align);
> -	} else {
> -		unsigned int order = folio_order(sp);
> -
> -		mod_node_page_state(folio_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
> -				    -(PAGE_SIZE << order));
> -		__free_pages(folio_page(sp, 0), order);
> -
> -	}
> -}
> -EXPORT_SYMBOL(kfree);
> -
> -size_t kmalloc_size_roundup(size_t size)
> -{
> -	/* Short-circuit the 0 size case. */
> -	if (unlikely(size == 0))
> -		return 0;
> -	/* Short-circuit saturated "too-large" case. */
> -	if (unlikely(size == SIZE_MAX))
> -		return SIZE_MAX;
> -
> -	return ALIGN(size, ARCH_KMALLOC_MINALIGN);
> -}
> -
> -EXPORT_SYMBOL(kmalloc_size_roundup);
> -
> -/* can't use ksize for kmem_cache_alloc memory, only kmalloc */
> -size_t __ksize(const void *block)
> -{
> -	struct folio *folio;
> -	unsigned int align;
> -	unsigned int *m;
> -
> -	BUG_ON(!block);
> -	if (unlikely(block == ZERO_SIZE_PTR))
> -		return 0;
> -
> -	folio = virt_to_folio(block);
> -	if (unlikely(!folio_test_slab(folio)))
> -		return folio_size(folio);
> -
> -	align = max_t(unsigned int, ARCH_KMALLOC_MINALIGN,
> -		      arch_slab_minalign());
> -	m = (unsigned int *)(block - align);
> -	return SLOB_UNITS(*m) * SLOB_UNIT;
> -}
> -
> -int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
> -{
> -	if (flags & SLAB_TYPESAFE_BY_RCU) {
> -		/* leave room for rcu footer at the end of object */
> -		c->size += sizeof(struct slob_rcu);
> -	}
> -
> -	/* Actual size allocated */
> -	c->size = SLOB_UNITS(c->size) * SLOB_UNIT;
> -	c->flags = flags;
> -	return 0;
> -}
> -
> -static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
> -{
> -	void *b;
> -
> -	flags &= gfp_allowed_mask;
> -
> -	might_alloc(flags);
> -
> -	if (c->size < PAGE_SIZE) {
> -		b = slob_alloc(c->size, flags, c->align, node, 0);
> -		trace_kmem_cache_alloc(_RET_IP_, b, c, flags, node);
> -	} else {
> -		b = slob_new_pages(flags, get_order(c->size), node);
> -		trace_kmem_cache_alloc(_RET_IP_, b, c, flags, node);
> -	}
> -
> -	if (b && c->ctor) {
> -		WARN_ON_ONCE(flags & __GFP_ZERO);
> -		c->ctor(b);
> -	}
> -
> -	kmemleak_alloc_recursive(b, c->size, 1, c->flags, flags);
> -	return b;
> -}
> -
> -void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
> -{
> -	return slob_alloc_node(cachep, flags, NUMA_NO_NODE);
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc);
> -
> -
> -void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags)
> -{
> -	return slob_alloc_node(cachep, flags, NUMA_NO_NODE);
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc_lru);
> -
> -void *__kmalloc_node(size_t size, gfp_t gfp, int node)
> -{
> -	return __do_kmalloc_node(size, gfp, node, _RET_IP_);
> -}
> -EXPORT_SYMBOL(__kmalloc_node);
> -
> -void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int node)
> -{
> -	return slob_alloc_node(cachep, gfp, node);
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc_node);
> -
> -static void __kmem_cache_free(void *b, int size)
> -{
> -	if (size < PAGE_SIZE)
> -		slob_free(b, size);
> -	else
> -		slob_free_pages(b, get_order(size));
> -}
> -
> -static void kmem_rcu_free(struct rcu_head *head)
> -{
> -	struct slob_rcu *slob_rcu = (struct slob_rcu *)head;
> -	void *b = (void *)slob_rcu - (slob_rcu->size - sizeof(struct slob_rcu));
> -
> -	__kmem_cache_free(b, slob_rcu->size);
> -}
> -
> -void kmem_cache_free(struct kmem_cache *c, void *b)
> -{
> -	kmemleak_free_recursive(b, c->flags);
> -	trace_kmem_cache_free(_RET_IP_, b, c);
> -	if (unlikely(c->flags & SLAB_TYPESAFE_BY_RCU)) {
> -		struct slob_rcu *slob_rcu;
> -		slob_rcu = b + (c->size - sizeof(struct slob_rcu));
> -		slob_rcu->size = c->size;
> -		call_rcu(&slob_rcu->head, kmem_rcu_free);
> -	} else {
> -		__kmem_cache_free(b, c->size);
> -	}
> -}
> -EXPORT_SYMBOL(kmem_cache_free);
> -
> -void kmem_cache_free_bulk(struct kmem_cache *s, size_t nr, void **p)
> -{
> -	size_t i;
> -
> -	for (i = 0; i < nr; i++) {
> -		if (s)
> -			kmem_cache_free(s, p[i]);
> -		else
> -			kfree(p[i]);
> -	}
> -}
> -EXPORT_SYMBOL(kmem_cache_free_bulk);
> -
> -int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
> -								void **p)
> -{
> -	size_t i;
> -
> -	for (i = 0; i < nr; i++) {
> -		void *x = p[i] = kmem_cache_alloc(s, flags);
> -
> -		if (!x) {
> -			kmem_cache_free_bulk(s, i, p);
> -			return 0;
> -		}
> -	}
> -	return i;
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc_bulk);
> -
> -int __kmem_cache_shutdown(struct kmem_cache *c)
> -{
> -	/* No way to check for remaining objects */
> -	return 0;
> -}
> -
> -void __kmem_cache_release(struct kmem_cache *c)
> -{
> -}
> -
> -int __kmem_cache_shrink(struct kmem_cache *d)
> -{
> -	return 0;
> -}
> -
> -static struct kmem_cache kmem_cache_boot = {
> -	.name = "kmem_cache",
> -	.size = sizeof(struct kmem_cache),
> -	.flags = SLAB_PANIC,
> -	.align = ARCH_KMALLOC_MINALIGN,
> -};
> -
> -void __init kmem_cache_init(void)
> -{
> -	kmem_cache = &kmem_cache_boot;
> -	slab_state = UP;
> -}
> -
> -void __init kmem_cache_init_late(void)
> -{
> -	slab_state = FULL;
> -}
> diff --git a/mm/slub.c b/mm/slub.c
> deleted file mode 100644
> index 39327e98fce3..000000000000
> --- a/mm/slub.c
> +++ /dev/null
> @@ -1,6506 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * SLUB: A slab allocator that limits cache line use instead of queuing
> - * objects in per cpu and per node lists.
> - *
> - * The allocator synchronizes using per slab locks or atomic operations
> - * and only uses a centralized lock to manage a pool of partial slabs.
> - *
> - * (C) 2007 SGI, Christoph Lameter
> - * (C) 2011 Linux Foundation, Christoph Lameter
> - */
> -
> -#include <linux/mm.h>
> -#include <linux/swap.h> /* struct reclaim_state */
> -#include <linux/module.h>
> -#include <linux/bit_spinlock.h>
> -#include <linux/interrupt.h>
> -#include <linux/swab.h>
> -#include <linux/bitops.h>
> -#include <linux/slab.h>
> -#include "slab.h"
> -#include <linux/proc_fs.h>
> -#include <linux/seq_file.h>
> -#include <linux/kasan.h>
> -#include <linux/kmsan.h>
> -#include <linux/cpu.h>
> -#include <linux/cpuset.h>
> -#include <linux/mempolicy.h>
> -#include <linux/ctype.h>
> -#include <linux/stackdepot.h>
> -#include <linux/debugobjects.h>
> -#include <linux/kallsyms.h>
> -#include <linux/kfence.h>
> -#include <linux/memory.h>
> -#include <linux/math64.h>
> -#include <linux/fault-inject.h>
> -#include <linux/stacktrace.h>
> -#include <linux/prefetch.h>
> -#include <linux/memcontrol.h>
> -#include <linux/random.h>
> -#include <kunit/test.h>
> -#include <kunit/test-bug.h>
> -#include <linux/sort.h>
> -
> -#include <linux/debugfs.h>
> -#include <trace/events/kmem.h>
> -
> -#include "internal.h"
> -
> -/*
> - * Lock order:
> - *   1. slab_mutex (Global Mutex)
> - *   2. node->list_lock (Spinlock)
> - *   3. kmem_cache->cpu_slab->lock (Local lock)
> - *   4. slab_lock(slab) (Only on some arches)
> - *   5. object_map_lock (Only for debugging)
> - *
> - *   slab_mutex
> - *
> - *   The role of the slab_mutex is to protect the list of all the slabs
> - *   and to synchronize major metadata changes to slab cache structures.
> - *   Also synchronizes memory hotplug callbacks.
> - *
> - *   slab_lock
> - *
> - *   The slab_lock is a wrapper around the page lock, thus it is a bit
> - *   spinlock.
> - *
> - *   The slab_lock is only used on arches that do not have the ability
> - *   to do a cmpxchg_double. It only protects:
> - *
> - *	A. slab->freelist	-> List of free objects in a slab
> - *	B. slab->inuse		-> Number of objects in use
> - *	C. slab->objects	-> Number of objects in slab
> - *	D. slab->frozen		-> frozen state
> - *
> - *   Frozen slabs
> - *
> - *   If a slab is frozen then it is exempt from list management. It is not
> - *   on any list except per cpu partial list. The processor that froze the
> - *   slab is the one who can perform list operations on the slab. Other
> - *   processors may put objects onto the freelist but the processor that
> - *   froze the slab is the only one that can retrieve the objects from the
> - *   slab's freelist.
> - *
> - *   list_lock
> - *
> - *   The list_lock protects the partial and full list on each node and
> - *   the partial slab counter. If taken then no new slabs may be added or
> - *   removed from the lists nor make the number of partial slabs be modified.
> - *   (Note that the total number of slabs is an atomic value that may be
> - *   modified without taking the list lock).
> - *
> - *   The list_lock is a centralized lock and thus we avoid taking it as
> - *   much as possible. As long as SLUB does not have to handle partial
> - *   slabs, operations can continue without any centralized lock. F.e.
> - *   allocating a long series of objects that fill up slabs does not require
> - *   the list lock.
> - *
> - *   For debug caches, all allocations are forced to go through a list_lock
> - *   protected region to serialize against concurrent validation.
> - *
> - *   cpu_slab->lock local lock
> - *
> - *   This locks protect slowpath manipulation of all kmem_cache_cpu fields
> - *   except the stat counters. This is a percpu structure manipulated only by
> - *   the local cpu, so the lock protects against being preempted or interrupted
> - *   by an irq. Fast path operations rely on lockless operations instead.
> - *
> - *   On PREEMPT_RT, the local lock neither disables interrupts nor preemption
> - *   which means the lockless fastpath cannot be used as it might interfere with
> - *   an in-progress slow path operations. In this case the local lock is always
> - *   taken but it still utilizes the freelist for the common operations.
> - *
> - *   lockless fastpaths
> - *
> - *   The fast path allocation (slab_alloc_node()) and freeing (do_slab_free())
> - *   are fully lockless when satisfied from the percpu slab (and when
> - *   cmpxchg_double is possible to use, otherwise slab_lock is taken).
> - *   They also don't disable preemption or migration or irqs. They rely on
> - *   the transaction id (tid) field to detect being preempted or moved to
> - *   another cpu.
> - *
> - *   irq, preemption, migration considerations
> - *
> - *   Interrupts are disabled as part of list_lock or local_lock operations, or
> - *   around the slab_lock operation, in order to make the slab allocator safe
> - *   to use in the context of an irq.
> - *
> - *   In addition, preemption (or migration on PREEMPT_RT) is disabled in the
> - *   allocation slowpath, bulk allocation, and put_cpu_partial(), so that the
> - *   local cpu doesn't change in the process and e.g. the kmem_cache_cpu pointer
> - *   doesn't have to be revalidated in each section protected by the local lock.
> - *
> - * SLUB assigns one slab for allocation to each processor.
> - * Allocations only occur from these slabs called cpu slabs.
> - *
> - * Slabs with free elements are kept on a partial list and during regular
> - * operations no list for full slabs is used. If an object in a full slab is
> - * freed then the slab will show up again on the partial lists.
> - * We track full slabs for debugging purposes though because otherwise we
> - * cannot scan all objects.
> - *
> - * Slabs are freed when they become empty. Teardown and setup is
> - * minimal so we rely on the page allocators per cpu caches for
> - * fast frees and allocs.
> - *
> - * slab->frozen		The slab is frozen and exempt from list processing.
> - * 			This means that the slab is dedicated to a purpose
> - * 			such as satisfying allocations for a specific
> - * 			processor. Objects may be freed in the slab while
> - * 			it is frozen but slab_free will then skip the usual
> - * 			list operations. It is up to the processor holding
> - * 			the slab to integrate the slab into the slab lists
> - * 			when the slab is no longer needed.
> - *
> - * 			One use of this flag is to mark slabs that are
> - * 			used for allocations. Then such a slab becomes a cpu
> - * 			slab. The cpu slab may be equipped with an additional
> - * 			freelist that allows lockless access to
> - * 			free objects in addition to the regular freelist
> - * 			that requires the slab lock.
> - *
> - * SLAB_DEBUG_FLAGS	Slab requires special handling due to debug
> - * 			options set. This moves	slab handling out of
> - * 			the fast path and disables lockless freelists.
> - */
> -
> -/*
> - * We could simply use migrate_disable()/enable() but as long as it's a
> - * function call even on !PREEMPT_RT, use inline preempt_disable() there.
> - */
> -#ifndef CONFIG_PREEMPT_RT
> -#define slub_get_cpu_ptr(var)		get_cpu_ptr(var)
> -#define slub_put_cpu_ptr(var)		put_cpu_ptr(var)
> -#define USE_LOCKLESS_FAST_PATH()	(true)
> -#else
> -#define slub_get_cpu_ptr(var)		\
> -({					\
> -	migrate_disable();		\
> -	this_cpu_ptr(var);		\
> -})
> -#define slub_put_cpu_ptr(var)		\
> -do {					\
> -	(void)(var);			\
> -	migrate_enable();		\
> -} while (0)
> -#define USE_LOCKLESS_FAST_PATH()	(false)
> -#endif
> -
> -#ifndef CONFIG_SLUB_TINY
> -#define __fastpath_inline __always_inline
> -#else
> -#define __fastpath_inline
> -#endif
> -
> -#ifdef CONFIG_SLUB_DEBUG
> -#ifdef CONFIG_SLUB_DEBUG_ON
> -DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
> -#else
> -DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
> -#endif
> -#endif		/* CONFIG_SLUB_DEBUG */
> -
> -/* Structure holding parameters for get_partial() call chain */
> -struct partial_context {
> -	struct slab **slab;
> -	gfp_t flags;
> -	unsigned int orig_size;
> -};
> -
> -static inline bool kmem_cache_debug(struct kmem_cache *s)
> -{
> -	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
> -}
> -
> -static inline bool slub_debug_orig_size(struct kmem_cache *s)
> -{
> -	return (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
> -			(s->flags & SLAB_KMALLOC));
> -}
> -
> -void *fixup_red_left(struct kmem_cache *s, void *p)
> -{
> -	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE))
> -		p += s->red_left_pad;
> -
> -	return p;
> -}
> -
> -static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
> -{
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -	return !kmem_cache_debug(s);
> -#else
> -	return false;
> -#endif
> -}
> -
> -/*
> - * Issues still to be resolved:
> - *
> - * - Support PAGE_ALLOC_DEBUG. Should be easy to do.
> - *
> - * - Variable sizing of the per node arrays
> - */
> -
> -/* Enable to log cmpxchg failures */
> -#undef SLUB_DEBUG_CMPXCHG
> -
> -#ifndef CONFIG_SLUB_TINY
> -/*
> - * Minimum number of partial slabs. These will be left on the partial
> - * lists even if they are empty. kmem_cache_shrink may reclaim them.
> - */
> -#define MIN_PARTIAL 5
> -
> -/*
> - * Maximum number of desirable partial slabs.
> - * The existence of more partial slabs makes kmem_cache_shrink
> - * sort the partial list by the number of objects in use.
> - */
> -#define MAX_PARTIAL 10
> -#else
> -#define MIN_PARTIAL 0
> -#define MAX_PARTIAL 0
> -#endif
> -
> -#define DEBUG_DEFAULT_FLAGS (SLAB_CONSISTENCY_CHECKS | SLAB_RED_ZONE | \
> -				SLAB_POISON | SLAB_STORE_USER)
> -
> -/*
> - * These debug flags cannot use CMPXCHG because there might be consistency
> - * issues when checking or reading debug information
> - */
> -#define SLAB_NO_CMPXCHG (SLAB_CONSISTENCY_CHECKS | SLAB_STORE_USER | \
> -				SLAB_TRACE)
> -
> -
> -/*
> - * Debugging flags that require metadata to be stored in the slab.  These get
> - * disabled when slub_debug=O is used and a cache's min order increases with
> - * metadata.
> - */
> -#define DEBUG_METADATA_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
> -
> -#define OO_SHIFT	16
> -#define OO_MASK		((1 << OO_SHIFT) - 1)
> -#define MAX_OBJS_PER_PAGE	32767 /* since slab.objects is u15 */
> -
> -/* Internal SLUB flags */
> -/* Poison object */
> -#define __OBJECT_POISON		((slab_flags_t __force)0x80000000U)
> -/* Use cmpxchg_double */
> -#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0x40000000U)
> -
> -/*
> - * Tracking user of a slab.
> - */
> -#define TRACK_ADDRS_COUNT 16
> -struct track {
> -	unsigned long addr;	/* Called from address */
> -#ifdef CONFIG_STACKDEPOT
> -	depot_stack_handle_t handle;
> -#endif
> -	int cpu;		/* Was running on cpu */
> -	int pid;		/* Pid context */
> -	unsigned long when;	/* When did the operation occur */
> -};
> -
> -enum track_item { TRACK_ALLOC, TRACK_FREE };
> -
> -#ifdef SLAB_SUPPORTS_SYSFS
> -static int sysfs_slab_add(struct kmem_cache *);
> -static int sysfs_slab_alias(struct kmem_cache *, const char *);
> -#else
> -static inline int sysfs_slab_add(struct kmem_cache *s) { return 0; }
> -static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
> -							{ return 0; }
> -#endif
> -
> -#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
> -static void debugfs_slab_add(struct kmem_cache *);
> -#else
> -static inline void debugfs_slab_add(struct kmem_cache *s) { }
> -#endif
> -
> -static inline void stat(const struct kmem_cache *s, enum stat_item si)
> -{
> -#ifdef CONFIG_SLUB_STATS
> -	/*
> -	 * The rmw is racy on a preemptible kernel but this is acceptable, so
> -	 * avoid this_cpu_add()'s irq-disable overhead.
> -	 */
> -	raw_cpu_inc(s->cpu_slab->stat[si]);
> -#endif
> -}
> -
> -/*
> - * Tracks for which NUMA nodes we have kmem_cache_nodes allocated.
> - * Corresponds to node_state[N_NORMAL_MEMORY], but can temporarily
> - * differ during memory hotplug/hotremove operations.
> - * Protected by slab_mutex.
> - */
> -static nodemask_t slab_nodes;
> -
> -#ifndef CONFIG_SLUB_TINY
> -/*
> - * Workqueue used for flush_cpu_slab().
> - */
> -static struct workqueue_struct *flushwq;
> -#endif
> -
> -/********************************************************************
> - * 			Core slab cache functions
> - *******************************************************************/
> -
> -/*
> - * Returns freelist pointer (ptr). With hardening, this is obfuscated
> - * with an XOR of the address where the pointer is held and a per-cache
> - * random number.
> - */
> -static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
> -				 unsigned long ptr_addr)
> -{
> -#ifdef CONFIG_SLAB_FREELIST_HARDENED
> -	/*
> -	 * When CONFIG_KASAN_SW/HW_TAGS is enabled, ptr_addr might be tagged.
> -	 * Normally, this doesn't cause any issues, as both set_freepointer()
> -	 * and get_freepointer() are called with a pointer with the same tag.
> -	 * However, there are some issues with CONFIG_SLUB_DEBUG code. For
> -	 * example, when __free_slub() iterates over objects in a cache, it
> -	 * passes untagged pointers to check_object(). check_object() in turns
> -	 * calls get_freepointer() with an untagged pointer, which causes the
> -	 * freepointer to be restored incorrectly.
> -	 */
> -	return (void *)((unsigned long)ptr ^ s->random ^
> -			swab((unsigned long)kasan_reset_tag((void *)ptr_addr)));
> -#else
> -	return ptr;
> -#endif
> -}
> -
> -/* Returns the freelist pointer recorded at location ptr_addr. */
> -static inline void *freelist_dereference(const struct kmem_cache *s,
> -					 void *ptr_addr)
> -{
> -	return freelist_ptr(s, (void *)*(unsigned long *)(ptr_addr),
> -			    (unsigned long)ptr_addr);
> -}
> -
> -static inline void *get_freepointer(struct kmem_cache *s, void *object)
> -{
> -	object = kasan_reset_tag(object);
> -	return freelist_dereference(s, object + s->offset);
> -}
> -
> -#ifndef CONFIG_SLUB_TINY
> -static void prefetch_freepointer(const struct kmem_cache *s, void *object)
> -{
> -	prefetchw(object + s->offset);
> -}
> -#endif
> -
> -/*
> - * When running under KMSAN, get_freepointer_safe() may return an uninitialized
> - * pointer value in the case the current thread loses the race for the next
> - * memory chunk in the freelist. In that case this_cpu_cmpxchg_double() in
> - * slab_alloc_node() will fail, so the uninitialized value won't be used, but
> - * KMSAN will still check all arguments of cmpxchg because of imperfect
> - * handling of inline assembly.
> - * To work around this problem, we apply __no_kmsan_checks to ensure that
> - * get_freepointer_safe() returns initialized memory.
> - */
> -__no_kmsan_checks
> -static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
> -{
> -	unsigned long freepointer_addr;
> -	void *p;
> -
> -	if (!debug_pagealloc_enabled_static())
> -		return get_freepointer(s, object);
> -
> -	object = kasan_reset_tag(object);
> -	freepointer_addr = (unsigned long)object + s->offset;
> -	copy_from_kernel_nofault(&p, (void **)freepointer_addr, sizeof(p));
> -	return freelist_ptr(s, p, freepointer_addr);
> -}
> -
> -static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
> -{
> -	unsigned long freeptr_addr = (unsigned long)object + s->offset;
> -
> -#ifdef CONFIG_SLAB_FREELIST_HARDENED
> -	BUG_ON(object == fp); /* naive detection of double free or corruption */
> -#endif
> -
> -	freeptr_addr = (unsigned long)kasan_reset_tag((void *)freeptr_addr);
> -	*(void **)freeptr_addr = freelist_ptr(s, fp, freeptr_addr);
> -}
> -
> -/* Loop over all objects in a slab */
> -#define for_each_object(__p, __s, __addr, __objects) \
> -	for (__p = fixup_red_left(__s, __addr); \
> -		__p < (__addr) + (__objects) * (__s)->size; \
> -		__p += (__s)->size)
> -
> -static inline unsigned int order_objects(unsigned int order, unsigned int size)
> -{
> -	return ((unsigned int)PAGE_SIZE << order) / size;
> -}
> -
> -static inline struct kmem_cache_order_objects oo_make(unsigned int order,
> -		unsigned int size)
> -{
> -	struct kmem_cache_order_objects x = {
> -		(order << OO_SHIFT) + order_objects(order, size)
> -	};
> -
> -	return x;
> -}
> -
> -static inline unsigned int oo_order(struct kmem_cache_order_objects x)
> -{
> -	return x.x >> OO_SHIFT;
> -}
> -
> -static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
> -{
> -	return x.x & OO_MASK;
> -}
> -
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
> -{
> -	unsigned int nr_slabs;
> -
> -	s->cpu_partial = nr_objects;
> -
> -	/*
> -	 * We take the number of objects but actually limit the number of
> -	 * slabs on the per cpu partial list, in order to limit excessive
> -	 * growth of the list. For simplicity we assume that the slabs will
> -	 * be half-full.
> -	 */
> -	nr_slabs = DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));
> -	s->cpu_partial_slabs = nr_slabs;
> -}
> -#else
> -static inline void
> -slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
> -{
> -}
> -#endif /* CONFIG_SLUB_CPU_PARTIAL */
> -
> -/*
> - * Per slab locking using the pagelock
> - */
> -static __always_inline void slab_lock(struct slab *slab)
> -{
> -	struct page *page = slab_page(slab);
> -
> -	VM_BUG_ON_PAGE(PageTail(page), page);
> -	bit_spin_lock(PG_locked, &page->flags);
> -}
> -
> -static __always_inline void slab_unlock(struct slab *slab)
> -{
> -	struct page *page = slab_page(slab);
> -
> -	VM_BUG_ON_PAGE(PageTail(page), page);
> -	__bit_spin_unlock(PG_locked, &page->flags);
> -}
> -
> -/*
> - * Interrupts must be disabled (for the fallback code to work right), typically
> - * by an _irqsave() lock variant. On PREEMPT_RT the preempt_disable(), which is
> - * part of bit_spin_lock(), is sufficient because the policy is not to allow any
> - * allocation/ free operation in hardirq context. Therefore nothing can
> - * interrupt the operation.
> - */
> -static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
> -		void *freelist_old, unsigned long counters_old,
> -		void *freelist_new, unsigned long counters_new,
> -		const char *n)
> -{
> -	if (USE_LOCKLESS_FAST_PATH())
> -		lockdep_assert_irqs_disabled();
> -#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
> -    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
> -	if (s->flags & __CMPXCHG_DOUBLE) {
> -		if (cmpxchg_double(&slab->freelist, &slab->counters,
> -				   freelist_old, counters_old,
> -				   freelist_new, counters_new))
> -			return true;
> -	} else
> -#endif
> -	{
> -		slab_lock(slab);
> -		if (slab->freelist == freelist_old &&
> -					slab->counters == counters_old) {
> -			slab->freelist = freelist_new;
> -			slab->counters = counters_new;
> -			slab_unlock(slab);
> -			return true;
> -		}
> -		slab_unlock(slab);
> -	}
> -
> -	cpu_relax();
> -	stat(s, CMPXCHG_DOUBLE_FAIL);
> -
> -#ifdef SLUB_DEBUG_CMPXCHG
> -	pr_info("%s %s: cmpxchg double redo ", n, s->name);
> -#endif
> -
> -	return false;
> -}
> -
> -static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
> -		void *freelist_old, unsigned long counters_old,
> -		void *freelist_new, unsigned long counters_new,
> -		const char *n)
> -{
> -#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
> -    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
> -	if (s->flags & __CMPXCHG_DOUBLE) {
> -		if (cmpxchg_double(&slab->freelist, &slab->counters,
> -				   freelist_old, counters_old,
> -				   freelist_new, counters_new))
> -			return true;
> -	} else
> -#endif
> -	{
> -		unsigned long flags;
> -
> -		local_irq_save(flags);
> -		slab_lock(slab);
> -		if (slab->freelist == freelist_old &&
> -					slab->counters == counters_old) {
> -			slab->freelist = freelist_new;
> -			slab->counters = counters_new;
> -			slab_unlock(slab);
> -			local_irq_restore(flags);
> -			return true;
> -		}
> -		slab_unlock(slab);
> -		local_irq_restore(flags);
> -	}
> -
> -	cpu_relax();
> -	stat(s, CMPXCHG_DOUBLE_FAIL);
> -
> -#ifdef SLUB_DEBUG_CMPXCHG
> -	pr_info("%s %s: cmpxchg double redo ", n, s->name);
> -#endif
> -
> -	return false;
> -}
> -
> -#ifdef CONFIG_SLUB_DEBUG
> -static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
> -static DEFINE_SPINLOCK(object_map_lock);
> -
> -static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
> -		       struct slab *slab)
> -{
> -	void *addr = slab_address(slab);
> -	void *p;
> -
> -	bitmap_zero(obj_map, slab->objects);
> -
> -	for (p = slab->freelist; p; p = get_freepointer(s, p))
> -		set_bit(__obj_to_index(s, addr, p), obj_map);
> -}
> -
> -#if IS_ENABLED(CONFIG_KUNIT)
> -static bool slab_add_kunit_errors(void)
> -{
> -	struct kunit_resource *resource;
> -
> -	if (!kunit_get_current_test())
> -		return false;
> -
> -	resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
> -	if (!resource)
> -		return false;
> -
> -	(*(int *)resource->data)++;
> -	kunit_put_resource(resource);
> -	return true;
> -}
> -#else
> -static inline bool slab_add_kunit_errors(void) { return false; }
> -#endif
> -
> -static inline unsigned int size_from_object(struct kmem_cache *s)
> -{
> -	if (s->flags & SLAB_RED_ZONE)
> -		return s->size - s->red_left_pad;
> -
> -	return s->size;
> -}
> -
> -static inline void *restore_red_left(struct kmem_cache *s, void *p)
> -{
> -	if (s->flags & SLAB_RED_ZONE)
> -		p -= s->red_left_pad;
> -
> -	return p;
> -}
> -
> -/*
> - * Debug settings:
> - */
> -#if defined(CONFIG_SLUB_DEBUG_ON)
> -static slab_flags_t slub_debug = DEBUG_DEFAULT_FLAGS;
> -#else
> -static slab_flags_t slub_debug;
> -#endif
> -
> -static char *slub_debug_string;
> -static int disable_higher_order_debug;
> -
> -/*
> - * slub is about to manipulate internal object metadata.  This memory lies
> - * outside the range of the allocated object, so accessing it would normally
> - * be reported by kasan as a bounds error.  metadata_access_enable() is used
> - * to tell kasan that these accesses are OK.
> - */
> -static inline void metadata_access_enable(void)
> -{
> -	kasan_disable_current();
> -}
> -
> -static inline void metadata_access_disable(void)
> -{
> -	kasan_enable_current();
> -}
> -
> -/*
> - * Object debugging
> - */
> -
> -/* Verify that a pointer has an address that is valid within a slab page */
> -static inline int check_valid_pointer(struct kmem_cache *s,
> -				struct slab *slab, void *object)
> -{
> -	void *base;
> -
> -	if (!object)
> -		return 1;
> -
> -	base = slab_address(slab);
> -	object = kasan_reset_tag(object);
> -	object = restore_red_left(s, object);
> -	if (object < base || object >= base + slab->objects * s->size ||
> -		(object - base) % s->size) {
> -		return 0;
> -	}
> -
> -	return 1;
> -}
> -
> -static void print_section(char *level, char *text, u8 *addr,
> -			  unsigned int length)
> -{
> -	metadata_access_enable();
> -	print_hex_dump(level, text, DUMP_PREFIX_ADDRESS,
> -			16, 1, kasan_reset_tag((void *)addr), length, 1);
> -	metadata_access_disable();
> -}
> -
> -/*
> - * See comment in calculate_sizes().
> - */
> -static inline bool freeptr_outside_object(struct kmem_cache *s)
> -{
> -	return s->offset >= s->inuse;
> -}
> -
> -/*
> - * Return offset of the end of info block which is inuse + free pointer if
> - * not overlapping with object.
> - */
> -static inline unsigned int get_info_end(struct kmem_cache *s)
> -{
> -	if (freeptr_outside_object(s))
> -		return s->inuse + sizeof(void *);
> -	else
> -		return s->inuse;
> -}
> -
> -static struct track *get_track(struct kmem_cache *s, void *object,
> -	enum track_item alloc)
> -{
> -	struct track *p;
> -
> -	p = object + get_info_end(s);
> -
> -	return kasan_reset_tag(p + alloc);
> -}
> -
> -#ifdef CONFIG_STACKDEPOT
> -static noinline depot_stack_handle_t set_track_prepare(void)
> -{
> -	depot_stack_handle_t handle;
> -	unsigned long entries[TRACK_ADDRS_COUNT];
> -	unsigned int nr_entries;
> -
> -	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> -	handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> -
> -	return handle;
> -}
> -#else
> -static inline depot_stack_handle_t set_track_prepare(void)
> -{
> -	return 0;
> -}
> -#endif
> -
> -static void set_track_update(struct kmem_cache *s, void *object,
> -			     enum track_item alloc, unsigned long addr,
> -			     depot_stack_handle_t handle)
> -{
> -	struct track *p = get_track(s, object, alloc);
> -
> -#ifdef CONFIG_STACKDEPOT
> -	p->handle = handle;
> -#endif
> -	p->addr = addr;
> -	p->cpu = smp_processor_id();
> -	p->pid = current->pid;
> -	p->when = jiffies;
> -}
> -
> -static __always_inline void set_track(struct kmem_cache *s, void *object,
> -				      enum track_item alloc, unsigned long addr)
> -{
> -	depot_stack_handle_t handle = set_track_prepare();
> -
> -	set_track_update(s, object, alloc, addr, handle);
> -}
> -
> -static void init_tracking(struct kmem_cache *s, void *object)
> -{
> -	struct track *p;
> -
> -	if (!(s->flags & SLAB_STORE_USER))
> -		return;
> -
> -	p = get_track(s, object, TRACK_ALLOC);
> -	memset(p, 0, 2*sizeof(struct track));
> -}
> -
> -static void print_track(const char *s, struct track *t, unsigned long pr_time)
> -{
> -	depot_stack_handle_t handle __maybe_unused;
> -
> -	if (!t->addr)
> -		return;
> -
> -	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
> -	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
> -#ifdef CONFIG_STACKDEPOT
> -	handle = READ_ONCE(t->handle);
> -	if (handle)
> -		stack_depot_print(handle);
> -	else
> -		pr_err("object allocation/free stack trace missing\n");
> -#endif
> -}
> -
> -void print_tracking(struct kmem_cache *s, void *object)
> -{
> -	unsigned long pr_time = jiffies;
> -	if (!(s->flags & SLAB_STORE_USER))
> -		return;
> -
> -	print_track("Allocated", get_track(s, object, TRACK_ALLOC), pr_time);
> -	print_track("Freed", get_track(s, object, TRACK_FREE), pr_time);
> -}
> -
> -static void print_slab_info(const struct slab *slab)
> -{
> -	struct folio *folio = (struct folio *)slab_folio(slab);
> -
> -	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%pGp\n",
> -	       slab, slab->objects, slab->inuse, slab->freelist,
> -	       folio_flags(folio, 0));
> -}
> -
> -/*
> - * kmalloc caches has fixed sizes (mostly power of 2), and kmalloc() API
> - * family will round up the real request size to these fixed ones, so
> - * there could be an extra area than what is requested. Save the original
> - * request size in the meta data area, for better debug and sanity check.
> - */
> -static inline void set_orig_size(struct kmem_cache *s,
> -				void *object, unsigned int orig_size)
> -{
> -	void *p = kasan_reset_tag(object);
> -
> -	if (!slub_debug_orig_size(s))
> -		return;
> -
> -#ifdef CONFIG_KASAN_GENERIC
> -	/*
> -	 * KASAN could save its free meta data in object's data area at
> -	 * offset 0, if the size is larger than 'orig_size', it will
> -	 * overlap the data redzone in [orig_size+1, object_size], and
> -	 * the check should be skipped.
> -	 */
> -	if (kasan_metadata_size(s, true) > orig_size)
> -		orig_size = s->object_size;
> -#endif
> -
> -	p += get_info_end(s);
> -	p += sizeof(struct track) * 2;
> -
> -	*(unsigned int *)p = orig_size;
> -}
> -
> -static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
> -{
> -	void *p = kasan_reset_tag(object);
> -
> -	if (!slub_debug_orig_size(s))
> -		return s->object_size;
> -
> -	p += get_info_end(s);
> -	p += sizeof(struct track) * 2;
> -
> -	return *(unsigned int *)p;
> -}
> -
> -void skip_orig_size_check(struct kmem_cache *s, const void *object)
> -{
> -	set_orig_size(s, (void *)object, s->object_size);
> -}
> -
> -static void slab_bug(struct kmem_cache *s, char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> -	pr_err("=============================================================================\n");
> -	pr_err("BUG %s (%s): %pV\n", s->name, print_tainted(), &vaf);
> -	pr_err("-----------------------------------------------------------------------------\n\n");
> -	va_end(args);
> -}
> -
> -__printf(2, 3)
> -static void slab_fix(struct kmem_cache *s, char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	if (slab_add_kunit_errors())
> -		return;
> -
> -	va_start(args, fmt);
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> -	pr_err("FIX %s: %pV\n", s->name, &vaf);
> -	va_end(args);
> -}
> -
> -static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
> -{
> -	unsigned int off;	/* Offset of last byte */
> -	u8 *addr = slab_address(slab);
> -
> -	print_tracking(s, p);
> -
> -	print_slab_info(slab);
> -
> -	pr_err("Object 0x%p @offset=%tu fp=0x%p\n\n",
> -	       p, p - addr, get_freepointer(s, p));
> -
> -	if (s->flags & SLAB_RED_ZONE)
> -		print_section(KERN_ERR, "Redzone  ", p - s->red_left_pad,
> -			      s->red_left_pad);
> -	else if (p > addr + 16)
> -		print_section(KERN_ERR, "Bytes b4 ", p - 16, 16);
> -
> -	print_section(KERN_ERR,         "Object   ", p,
> -		      min_t(unsigned int, s->object_size, PAGE_SIZE));
> -	if (s->flags & SLAB_RED_ZONE)
> -		print_section(KERN_ERR, "Redzone  ", p + s->object_size,
> -			s->inuse - s->object_size);
> -
> -	off = get_info_end(s);
> -
> -	if (s->flags & SLAB_STORE_USER)
> -		off += 2 * sizeof(struct track);
> -
> -	if (slub_debug_orig_size(s))
> -		off += sizeof(unsigned int);
> -
> -	off += kasan_metadata_size(s, false);
> -
> -	if (off != size_from_object(s))
> -		/* Beginning of the filler is the free pointer */
> -		print_section(KERN_ERR, "Padding  ", p + off,
> -			      size_from_object(s) - off);
> -
> -	dump_stack();
> -}
> -
> -static void object_err(struct kmem_cache *s, struct slab *slab,
> -			u8 *object, char *reason)
> -{
> -	if (slab_add_kunit_errors())
> -		return;
> -
> -	slab_bug(s, "%s", reason);
> -	print_trailer(s, slab, object);
> -	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> -}
> -
> -static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
> -			       void **freelist, void *nextfree)
> -{
> -	if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
> -	    !check_valid_pointer(s, slab, nextfree) && freelist) {
> -		object_err(s, slab, *freelist, "Freechain corrupt");
> -		*freelist = NULL;
> -		slab_fix(s, "Isolate corrupted freechain");
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
> -			const char *fmt, ...)
> -{
> -	va_list args;
> -	char buf[100];
> -
> -	if (slab_add_kunit_errors())
> -		return;
> -
> -	va_start(args, fmt);
> -	vsnprintf(buf, sizeof(buf), fmt, args);
> -	va_end(args);
> -	slab_bug(s, "%s", buf);
> -	print_slab_info(slab);
> -	dump_stack();
> -	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> -}
> -
> -static void init_object(struct kmem_cache *s, void *object, u8 val)
> -{
> -	u8 *p = kasan_reset_tag(object);
> -	unsigned int poison_size = s->object_size;
> -
> -	if (s->flags & SLAB_RED_ZONE) {
> -		memset(p - s->red_left_pad, val, s->red_left_pad);
> -
> -		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> -			/*
> -			 * Redzone the extra allocated space by kmalloc than
> -			 * requested, and the poison size will be limited to
> -			 * the original request size accordingly.
> -			 */
> -			poison_size = get_orig_size(s, object);
> -		}
> -	}
> -
> -	if (s->flags & __OBJECT_POISON) {
> -		memset(p, POISON_FREE, poison_size - 1);
> -		p[poison_size - 1] = POISON_END;
> -	}
> -
> -	if (s->flags & SLAB_RED_ZONE)
> -		memset(p + poison_size, val, s->inuse - poison_size);
> -}
> -
> -static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
> -						void *from, void *to)
> -{
> -	slab_fix(s, "Restoring %s 0x%p-0x%p=0x%x", message, from, to - 1, data);
> -	memset(from, data, to - from);
> -}
> -
> -static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> -			u8 *object, char *what,
> -			u8 *start, unsigned int value, unsigned int bytes)
> -{
> -	u8 *fault;
> -	u8 *end;
> -	u8 *addr = slab_address(slab);
> -
> -	metadata_access_enable();
> -	fault = memchr_inv(kasan_reset_tag(start), value, bytes);
> -	metadata_access_disable();
> -	if (!fault)
> -		return 1;
> -
> -	end = start + bytes;
> -	while (end > fault && end[-1] == value)
> -		end--;
> -
> -	if (slab_add_kunit_errors())
> -		goto skip_bug_print;
> -
> -	slab_bug(s, "%s overwritten", what);
> -	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> -					fault, end - 1, fault - addr,
> -					fault[0], value);
> -	print_trailer(s, slab, object);
> -	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> -
> -skip_bug_print:
> -	restore_bytes(s, what, value, fault, end);
> -	return 0;
> -}
> -
> -/*
> - * Object layout:
> - *
> - * object address
> - * 	Bytes of the object to be managed.
> - * 	If the freepointer may overlay the object then the free
> - *	pointer is at the middle of the object.
> - *
> - * 	Poisoning uses 0x6b (POISON_FREE) and the last byte is
> - * 	0xa5 (POISON_END)
> - *
> - * object + s->object_size
> - * 	Padding to reach word boundary. This is also used for Redzoning.
> - * 	Padding is extended by another word if Redzoning is enabled and
> - * 	object_size == inuse.
> - *
> - * 	We fill with 0xbb (RED_INACTIVE) for inactive objects and with
> - * 	0xcc (RED_ACTIVE) for objects in use.
> - *
> - * object + s->inuse
> - * 	Meta data starts here.
> - *
> - * 	A. Free pointer (if we cannot overwrite object on free)
> - * 	B. Tracking data for SLAB_STORE_USER
> - *	C. Original request size for kmalloc object (SLAB_STORE_USER enabled)
> - *	D. Padding to reach required alignment boundary or at minimum
> - * 		one word if debugging is on to be able to detect writes
> - * 		before the word boundary.
> - *
> - *	Padding is done using 0x5a (POISON_INUSE)
> - *
> - * object + s->size
> - * 	Nothing is used beyond s->size.
> - *
> - * If slabcaches are merged then the object_size and inuse boundaries are mostly
> - * ignored. And therefore no slab options that rely on these boundaries
> - * may be used with merged slabcaches.
> - */
> -
> -static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
> -{
> -	unsigned long off = get_info_end(s);	/* The end of info */
> -
> -	if (s->flags & SLAB_STORE_USER) {
> -		/* We also have user information there */
> -		off += 2 * sizeof(struct track);
> -
> -		if (s->flags & SLAB_KMALLOC)
> -			off += sizeof(unsigned int);
> -	}
> -
> -	off += kasan_metadata_size(s, false);
> -
> -	if (size_from_object(s) == off)
> -		return 1;
> -
> -	return check_bytes_and_report(s, slab, p, "Object padding",
> -			p + off, POISON_INUSE, size_from_object(s) - off);
> -}
> -
> -/* Check the pad bytes at the end of a slab page */
> -static void slab_pad_check(struct kmem_cache *s, struct slab *slab)
> -{
> -	u8 *start;
> -	u8 *fault;
> -	u8 *end;
> -	u8 *pad;
> -	int length;
> -	int remainder;
> -
> -	if (!(s->flags & SLAB_POISON))
> -		return;
> -
> -	start = slab_address(slab);
> -	length = slab_size(slab);
> -	end = start + length;
> -	remainder = length % s->size;
> -	if (!remainder)
> -		return;
> -
> -	pad = end - remainder;
> -	metadata_access_enable();
> -	fault = memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainder);
> -	metadata_access_disable();
> -	if (!fault)
> -		return;
> -	while (end > fault && end[-1] == POISON_INUSE)
> -		end--;
> -
> -	slab_err(s, slab, "Padding overwritten. 0x%p-0x%p @offset=%tu",
> -			fault, end - 1, fault - start);
> -	print_section(KERN_ERR, "Padding ", pad, remainder);
> -
> -	restore_bytes(s, "slab padding", POISON_INUSE, fault, end);
> -}
> -
> -static int check_object(struct kmem_cache *s, struct slab *slab,
> -					void *object, u8 val)
> -{
> -	u8 *p = object;
> -	u8 *endobject = object + s->object_size;
> -	unsigned int orig_size;
> -
> -	if (s->flags & SLAB_RED_ZONE) {
> -		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> -			object - s->red_left_pad, val, s->red_left_pad))
> -			return 0;
> -
> -		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
> -			endobject, val, s->inuse - s->object_size))
> -			return 0;
> -
> -		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> -			orig_size = get_orig_size(s, object);
> -
> -			if (s->object_size > orig_size  &&
> -				!check_bytes_and_report(s, slab, object,
> -					"kmalloc Redzone", p + orig_size,
> -					val, s->object_size - orig_size)) {
> -				return 0;
> -			}
> -		}
> -	} else {
> -		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
> -			check_bytes_and_report(s, slab, p, "Alignment padding",
> -				endobject, POISON_INUSE,
> -				s->inuse - s->object_size);
> -		}
> -	}
> -
> -	if (s->flags & SLAB_POISON) {
> -		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON) &&
> -			(!check_bytes_and_report(s, slab, p, "Poison", p,
> -					POISON_FREE, s->object_size - 1) ||
> -			 !check_bytes_and_report(s, slab, p, "End Poison",
> -				p + s->object_size - 1, POISON_END, 1)))
> -			return 0;
> -		/*
> -		 * check_pad_bytes cleans up on its own.
> -		 */
> -		check_pad_bytes(s, slab, p);
> -	}
> -
> -	if (!freeptr_outside_object(s) && val == SLUB_RED_ACTIVE)
> -		/*
> -		 * Object and freepointer overlap. Cannot check
> -		 * freepointer while object is allocated.
> -		 */
> -		return 1;
> -
> -	/* Check free pointer validity */
> -	if (!check_valid_pointer(s, slab, get_freepointer(s, p))) {
> -		object_err(s, slab, p, "Freepointer corrupt");
> -		/*
> -		 * No choice but to zap it and thus lose the remainder
> -		 * of the free objects in this slab. May cause
> -		 * another error because the object count is now wrong.
> -		 */
> -		set_freepointer(s, p, NULL);
> -		return 0;
> -	}
> -	return 1;
> -}
> -
> -static int check_slab(struct kmem_cache *s, struct slab *slab)
> -{
> -	int maxobj;
> -
> -	if (!folio_test_slab(slab_folio(slab))) {
> -		slab_err(s, slab, "Not a valid slab page");
> -		return 0;
> -	}
> -
> -	maxobj = order_objects(slab_order(slab), s->size);
> -	if (slab->objects > maxobj) {
> -		slab_err(s, slab, "objects %u > max %u",
> -			slab->objects, maxobj);
> -		return 0;
> -	}
> -	if (slab->inuse > slab->objects) {
> -		slab_err(s, slab, "inuse %u > max %u",
> -			slab->inuse, slab->objects);
> -		return 0;
> -	}
> -	/* Slab_pad_check fixes things up after itself */
> -	slab_pad_check(s, slab);
> -	return 1;
> -}
> -
> -/*
> - * Determine if a certain object in a slab is on the freelist. Must hold the
> - * slab lock to guarantee that the chains are in a consistent state.
> - */
> -static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
> -{
> -	int nr = 0;
> -	void *fp;
> -	void *object = NULL;
> -	int max_objects;
> -
> -	fp = slab->freelist;
> -	while (fp && nr <= slab->objects) {
> -		if (fp == search)
> -			return 1;
> -		if (!check_valid_pointer(s, slab, fp)) {
> -			if (object) {
> -				object_err(s, slab, object,
> -					"Freechain corrupt");
> -				set_freepointer(s, object, NULL);
> -			} else {
> -				slab_err(s, slab, "Freepointer corrupt");
> -				slab->freelist = NULL;
> -				slab->inuse = slab->objects;
> -				slab_fix(s, "Freelist cleared");
> -				return 0;
> -			}
> -			break;
> -		}
> -		object = fp;
> -		fp = get_freepointer(s, object);
> -		nr++;
> -	}
> -
> -	max_objects = order_objects(slab_order(slab), s->size);
> -	if (max_objects > MAX_OBJS_PER_PAGE)
> -		max_objects = MAX_OBJS_PER_PAGE;
> -
> -	if (slab->objects != max_objects) {
> -		slab_err(s, slab, "Wrong number of objects. Found %d but should be %d",
> -			 slab->objects, max_objects);
> -		slab->objects = max_objects;
> -		slab_fix(s, "Number of objects adjusted");
> -	}
> -	if (slab->inuse != slab->objects - nr) {
> -		slab_err(s, slab, "Wrong object count. Counter is %d but counted were %d",
> -			 slab->inuse, slab->objects - nr);
> -		slab->inuse = slab->objects - nr;
> -		slab_fix(s, "Object count adjusted");
> -	}
> -	return search == NULL;
> -}
> -
> -static void trace(struct kmem_cache *s, struct slab *slab, void *object,
> -								int alloc)
> -{
> -	if (s->flags & SLAB_TRACE) {
> -		pr_info("TRACE %s %s 0x%p inuse=%d fp=0x%p\n",
> -			s->name,
> -			alloc ? "alloc" : "free",
> -			object, slab->inuse,
> -			slab->freelist);
> -
> -		if (!alloc)
> -			print_section(KERN_INFO, "Object ", (void *)object,
> -					s->object_size);
> -
> -		dump_stack();
> -	}
> -}
> -
> -/*
> - * Tracking of fully allocated slabs for debugging purposes.
> - */
> -static void add_full(struct kmem_cache *s,
> -	struct kmem_cache_node *n, struct slab *slab)
> -{
> -	if (!(s->flags & SLAB_STORE_USER))
> -		return;
> -
> -	lockdep_assert_held(&n->list_lock);
> -	list_add(&slab->slab_list, &n->full);
> -}
> -
> -static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct slab *slab)
> -{
> -	if (!(s->flags & SLAB_STORE_USER))
> -		return;
> -
> -	lockdep_assert_held(&n->list_lock);
> -	list_del(&slab->slab_list);
> -}
> -
> -/* Tracking of the number of slabs for debugging purposes */
> -static inline unsigned long slabs_node(struct kmem_cache *s, int node)
> -{
> -	struct kmem_cache_node *n = get_node(s, node);
> -
> -	return atomic_long_read(&n->nr_slabs);
> -}
> -
> -static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
> -{
> -	return atomic_long_read(&n->nr_slabs);
> -}
> -
> -static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
> -{
> -	struct kmem_cache_node *n = get_node(s, node);
> -
> -	/*
> -	 * May be called early in order to allocate a slab for the
> -	 * kmem_cache_node structure. Solve the chicken-egg
> -	 * dilemma by deferring the increment of the count during
> -	 * bootstrap (see early_kmem_cache_node_alloc).
> -	 */
> -	if (likely(n)) {
> -		atomic_long_inc(&n->nr_slabs);
> -		atomic_long_add(objects, &n->total_objects);
> -	}
> -}
> -static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
> -{
> -	struct kmem_cache_node *n = get_node(s, node);
> -
> -	atomic_long_dec(&n->nr_slabs);
> -	atomic_long_sub(objects, &n->total_objects);
> -}
> -
> -/* Object debug checks for alloc/free paths */
> -static void setup_object_debug(struct kmem_cache *s, void *object)
> -{
> -	if (!kmem_cache_debug_flags(s, SLAB_STORE_USER|SLAB_RED_ZONE|__OBJECT_POISON))
> -		return;
> -
> -	init_object(s, object, SLUB_RED_INACTIVE);
> -	init_tracking(s, object);
> -}
> -
> -static
> -void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr)
> -{
> -	if (!kmem_cache_debug_flags(s, SLAB_POISON))
> -		return;
> -
> -	metadata_access_enable();
> -	memset(kasan_reset_tag(addr), POISON_INUSE, slab_size(slab));
> -	metadata_access_disable();
> -}
> -
> -static inline int alloc_consistency_checks(struct kmem_cache *s,
> -					struct slab *slab, void *object)
> -{
> -	if (!check_slab(s, slab))
> -		return 0;
> -
> -	if (!check_valid_pointer(s, slab, object)) {
> -		object_err(s, slab, object, "Freelist Pointer check fails");
> -		return 0;
> -	}
> -
> -	if (!check_object(s, slab, object, SLUB_RED_INACTIVE))
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static noinline bool alloc_debug_processing(struct kmem_cache *s,
> -			struct slab *slab, void *object, int orig_size)
> -{
> -	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> -		if (!alloc_consistency_checks(s, slab, object))
> -			goto bad;
> -	}
> -
> -	/* Success. Perform special debug activities for allocs */
> -	trace(s, slab, object, 1);
> -	set_orig_size(s, object, orig_size);
> -	init_object(s, object, SLUB_RED_ACTIVE);
> -	return true;
> -
> -bad:
> -	if (folio_test_slab(slab_folio(slab))) {
> -		/*
> -		 * If this is a slab page then lets do the best we can
> -		 * to avoid issues in the future. Marking all objects
> -		 * as used avoids touching the remaining objects.
> -		 */
> -		slab_fix(s, "Marking all objects used");
> -		slab->inuse = slab->objects;
> -		slab->freelist = NULL;
> -	}
> -	return false;
> -}
> -
> -static inline int free_consistency_checks(struct kmem_cache *s,
> -		struct slab *slab, void *object, unsigned long addr)
> -{
> -	if (!check_valid_pointer(s, slab, object)) {
> -		slab_err(s, slab, "Invalid object pointer 0x%p", object);
> -		return 0;
> -	}
> -
> -	if (on_freelist(s, slab, object)) {
> -		object_err(s, slab, object, "Object already free");
> -		return 0;
> -	}
> -
> -	if (!check_object(s, slab, object, SLUB_RED_ACTIVE))
> -		return 0;
> -
> -	if (unlikely(s != slab->slab_cache)) {
> -		if (!folio_test_slab(slab_folio(slab))) {
> -			slab_err(s, slab, "Attempt to free object(0x%p) outside of slab",
> -				 object);
> -		} else if (!slab->slab_cache) {
> -			pr_err("SLUB <none>: no slab for object 0x%p.\n",
> -			       object);
> -			dump_stack();
> -		} else
> -			object_err(s, slab, object,
> -					"page slab pointer corrupt.");
> -		return 0;
> -	}
> -	return 1;
> -}
> -
> -/*
> - * Parse a block of slub_debug options. Blocks are delimited by ';'
> - *
> - * @str:    start of block
> - * @flags:  returns parsed flags, or DEBUG_DEFAULT_FLAGS if none specified
> - * @slabs:  return start of list of slabs, or NULL when there's no list
> - * @init:   assume this is initial parsing and not per-kmem-create parsing
> - *
> - * returns the start of next block if there's any, or NULL
> - */
> -static char *
> -parse_slub_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
> -{
> -	bool higher_order_disable = false;
> -
> -	/* Skip any completely empty blocks */
> -	while (*str && *str == ';')
> -		str++;
> -
> -	if (*str == ',') {
> -		/*
> -		 * No options but restriction on slabs. This means full
> -		 * debugging for slabs matching a pattern.
> -		 */
> -		*flags = DEBUG_DEFAULT_FLAGS;
> -		goto check_slabs;
> -	}
> -	*flags = 0;
> -
> -	/* Determine which debug features should be switched on */
> -	for (; *str && *str != ',' && *str != ';'; str++) {
> -		switch (tolower(*str)) {
> -		case '-':
> -			*flags = 0;
> -			break;
> -		case 'f':
> -			*flags |= SLAB_CONSISTENCY_CHECKS;
> -			break;
> -		case 'z':
> -			*flags |= SLAB_RED_ZONE;
> -			break;
> -		case 'p':
> -			*flags |= SLAB_POISON;
> -			break;
> -		case 'u':
> -			*flags |= SLAB_STORE_USER;
> -			break;
> -		case 't':
> -			*flags |= SLAB_TRACE;
> -			break;
> -		case 'a':
> -			*flags |= SLAB_FAILSLAB;
> -			break;
> -		case 'o':
> -			/*
> -			 * Avoid enabling debugging on caches if its minimum
> -			 * order would increase as a result.
> -			 */
> -			higher_order_disable = true;
> -			break;
> -		default:
> -			if (init)
> -				pr_err("slub_debug option '%c' unknown. skipped\n", *str);
> -		}
> -	}
> -check_slabs:
> -	if (*str == ',')
> -		*slabs = ++str;
> -	else
> -		*slabs = NULL;
> -
> -	/* Skip over the slab list */
> -	while (*str && *str != ';')
> -		str++;
> -
> -	/* Skip any completely empty blocks */
> -	while (*str && *str == ';')
> -		str++;
> -
> -	if (init && higher_order_disable)
> -		disable_higher_order_debug = 1;
> -
> -	if (*str)
> -		return str;
> -	else
> -		return NULL;
> -}
> -
> -static int __init setup_slub_debug(char *str)
> -{
> -	slab_flags_t flags;
> -	slab_flags_t global_flags;
> -	char *saved_str;
> -	char *slab_list;
> -	bool global_slub_debug_changed = false;
> -	bool slab_list_specified = false;
> -
> -	global_flags = DEBUG_DEFAULT_FLAGS;
> -	if (*str++ != '=' || !*str)
> -		/*
> -		 * No options specified. Switch on full debugging.
> -		 */
> -		goto out;
> -
> -	saved_str = str;
> -	while (str) {
> -		str = parse_slub_debug_flags(str, &flags, &slab_list, true);
> -
> -		if (!slab_list) {
> -			global_flags = flags;
> -			global_slub_debug_changed = true;
> -		} else {
> -			slab_list_specified = true;
> -			if (flags & SLAB_STORE_USER)
> -				stack_depot_request_early_init();
> -		}
> -	}
> -
> -	/*
> -	 * For backwards compatibility, a single list of flags with list of
> -	 * slabs means debugging is only changed for those slabs, so the global
> -	 * slub_debug should be unchanged (0 or DEBUG_DEFAULT_FLAGS, depending
> -	 * on CONFIG_SLUB_DEBUG_ON). We can extended that to multiple lists as
> -	 * long as there is no option specifying flags without a slab list.
> -	 */
> -	if (slab_list_specified) {
> -		if (!global_slub_debug_changed)
> -			global_flags = slub_debug;
> -		slub_debug_string = saved_str;
> -	}
> -out:
> -	slub_debug = global_flags;
> -	if (slub_debug & SLAB_STORE_USER)
> -		stack_depot_request_early_init();
> -	if (slub_debug != 0 || slub_debug_string)
> -		static_branch_enable(&slub_debug_enabled);
> -	else
> -		static_branch_disable(&slub_debug_enabled);
> -	if ((static_branch_unlikely(&init_on_alloc) ||
> -	     static_branch_unlikely(&init_on_free)) &&
> -	    (slub_debug & SLAB_POISON))
> -		pr_info("mem auto-init: SLAB_POISON will take precedence over init_on_alloc/init_on_free\n");
> -	return 1;
> -}
> -
> -__setup("slub_debug", setup_slub_debug);
> -
> -/*
> - * kmem_cache_flags - apply debugging options to the cache
> - * @object_size:	the size of an object without meta data
> - * @flags:		flags to set
> - * @name:		name of the cache
> - *
> - * Debug option(s) are applied to @flags. In addition to the debug
> - * option(s), if a slab name (or multiple) is specified i.e.
> - * slub_debug=<Debug-Options>,<slab name1>,<slab name2> ...
> - * then only the select slabs will receive the debug option(s).
> - */
> -slab_flags_t kmem_cache_flags(unsigned int object_size,
> -	slab_flags_t flags, const char *name)
> -{
> -	char *iter;
> -	size_t len;
> -	char *next_block;
> -	slab_flags_t block_flags;
> -	slab_flags_t slub_debug_local = slub_debug;
> -
> -	if (flags & SLAB_NO_USER_FLAGS)
> -		return flags;
> -
> -	/*
> -	 * If the slab cache is for debugging (e.g. kmemleak) then
> -	 * don't store user (stack trace) information by default,
> -	 * but let the user enable it via the command line below.
> -	 */
> -	if (flags & SLAB_NOLEAKTRACE)
> -		slub_debug_local &= ~SLAB_STORE_USER;
> -
> -	len = strlen(name);
> -	next_block = slub_debug_string;
> -	/* Go through all blocks of debug options, see if any matches our slab's name */
> -	while (next_block) {
> -		next_block = parse_slub_debug_flags(next_block, &block_flags, &iter, false);
> -		if (!iter)
> -			continue;
> -		/* Found a block that has a slab list, search it */
> -		while (*iter) {
> -			char *end, *glob;
> -			size_t cmplen;
> -
> -			end = strchrnul(iter, ',');
> -			if (next_block && next_block < end)
> -				end = next_block - 1;
> -
> -			glob = strnchr(iter, end - iter, '*');
> -			if (glob)
> -				cmplen = glob - iter;
> -			else
> -				cmplen = max_t(size_t, len, (end - iter));
> -
> -			if (!strncmp(name, iter, cmplen)) {
> -				flags |= block_flags;
> -				return flags;
> -			}
> -
> -			if (!*end || *end == ';')
> -				break;
> -			iter = end + 1;
> -		}
> -	}
> -
> -	return flags | slub_debug_local;
> -}
> -#else /* !CONFIG_SLUB_DEBUG */
> -static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
> -static inline
> -void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
> -
> -static inline bool alloc_debug_processing(struct kmem_cache *s,
> -	struct slab *slab, void *object, int orig_size) { return true; }
> -
> -static inline bool free_debug_processing(struct kmem_cache *s,
> -	struct slab *slab, void *head, void *tail, int *bulk_cnt,
> -	unsigned long addr, depot_stack_handle_t handle) { return true; }
> -
> -static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
> -static inline int check_object(struct kmem_cache *s, struct slab *slab,
> -			void *object, u8 val) { return 1; }
> -static inline depot_stack_handle_t set_track_prepare(void) { return 0; }
> -static inline void set_track(struct kmem_cache *s, void *object,
> -			     enum track_item alloc, unsigned long addr) {}
> -static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
> -					struct slab *slab) {}
> -static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n,
> -					struct slab *slab) {}
> -slab_flags_t kmem_cache_flags(unsigned int object_size,
> -	slab_flags_t flags, const char *name)
> -{
> -	return flags;
> -}
> -#define slub_debug 0
> -
> -#define disable_higher_order_debug 0
> -
> -static inline unsigned long slabs_node(struct kmem_cache *s, int node)
> -							{ return 0; }
> -static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
> -							{ return 0; }
> -static inline void inc_slabs_node(struct kmem_cache *s, int node,
> -							int objects) {}
> -static inline void dec_slabs_node(struct kmem_cache *s, int node,
> -							int objects) {}
> -
> -#ifndef CONFIG_SLUB_TINY
> -static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
> -			       void **freelist, void *nextfree)
> -{
> -	return false;
> -}
> -#endif
> -#endif /* CONFIG_SLUB_DEBUG */
> -
> -/*
> - * Hooks for other subsystems that check memory allocations. In a typical
> - * production configuration these hooks all should produce no code at all.
> - */
> -static __always_inline bool slab_free_hook(struct kmem_cache *s,
> -						void *x, bool init)
> -{
> -	kmemleak_free_recursive(x, s->flags);
> -	kmsan_slab_free(s, x);
> -
> -	debug_check_no_locks_freed(x, s->object_size);
> -
> -	if (!(s->flags & SLAB_DEBUG_OBJECTS))
> -		debug_check_no_obj_freed(x, s->object_size);
> -
> -	/* Use KCSAN to help debug racy use-after-free. */
> -	if (!(s->flags & SLAB_TYPESAFE_BY_RCU))
> -		__kcsan_check_access(x, s->object_size,
> -				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
> -
> -	/*
> -	 * As memory initialization might be integrated into KASAN,
> -	 * kasan_slab_free and initialization memset's must be
> -	 * kept together to avoid discrepancies in behavior.
> -	 *
> -	 * The initialization memset's clear the object and the metadata,
> -	 * but don't touch the SLAB redzone.
> -	 */
> -	if (init) {
> -		int rsize;
> -
> -		if (!kasan_has_integrated_init())
> -			memset(kasan_reset_tag(x), 0, s->object_size);
> -		rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad : 0;
> -		memset((char *)kasan_reset_tag(x) + s->inuse, 0,
> -		       s->size - s->inuse - rsize);
> -	}
> -	/* KASAN might put x into memory quarantine, delaying its reuse. */
> -	return kasan_slab_free(s, x, init);
> -}
> -
> -static inline bool slab_free_freelist_hook(struct kmem_cache *s,
> -					   void **head, void **tail,
> -					   int *cnt)
> -{
> -
> -	void *object;
> -	void *next = *head;
> -	void *old_tail = *tail ? *tail : *head;
> -
> -	if (is_kfence_address(next)) {
> -		slab_free_hook(s, next, false);
> -		return true;
> -	}
> -
> -	/* Head and tail of the reconstructed freelist */
> -	*head = NULL;
> -	*tail = NULL;
> -
> -	do {
> -		object = next;
> -		next = get_freepointer(s, object);
> -
> -		/* If object's reuse doesn't have to be delayed */
> -		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {
> -			/* Move object to the new freelist */
> -			set_freepointer(s, object, *head);
> -			*head = object;
> -			if (!*tail)
> -				*tail = object;
> -		} else {
> -			/*
> -			 * Adjust the reconstructed freelist depth
> -			 * accordingly if object's reuse is delayed.
> -			 */
> -			--(*cnt);
> -		}
> -	} while (object != old_tail);
> -
> -	if (*head == *tail)
> -		*tail = NULL;
> -
> -	return *head != NULL;
> -}
> -
> -static void *setup_object(struct kmem_cache *s, void *object)
> -{
> -	setup_object_debug(s, object);
> -	object = kasan_init_slab_obj(s, object);
> -	if (unlikely(s->ctor)) {
> -		kasan_unpoison_object_data(s, object);
> -		s->ctor(object);
> -		kasan_poison_object_data(s, object);
> -	}
> -	return object;
> -}
> -
> -/*
> - * Slab allocation and freeing
> - */
> -static inline struct slab *alloc_slab_page(gfp_t flags, int node,
> -		struct kmem_cache_order_objects oo)
> -{
> -	struct folio *folio;
> -	struct slab *slab;
> -	unsigned int order = oo_order(oo);
> -
> -	if (node == NUMA_NO_NODE)
> -		folio = (struct folio *)alloc_pages(flags, order);
> -	else
> -		folio = (struct folio *)__alloc_pages_node(node, flags, order);
> -
> -	if (!folio)
> -		return NULL;
> -
> -	slab = folio_slab(folio);
> -	__folio_set_slab(folio);
> -	/* Make the flag visible before any changes to folio->mapping */
> -	smp_wmb();
> -	if (folio_is_pfmemalloc(folio))
> -		slab_set_pfmemalloc(slab);
> -
> -	return slab;
> -}
> -
> -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> -/* Pre-initialize the random sequence cache */
> -static int init_cache_random_seq(struct kmem_cache *s)
> -{
> -	unsigned int count = oo_objects(s->oo);
> -	int err;
> -
> -	/* Bailout if already initialised */
> -	if (s->random_seq)
> -		return 0;
> -
> -	err = cache_random_seq_create(s, count, GFP_KERNEL);
> -	if (err) {
> -		pr_err("SLUB: Unable to initialize free list for %s\n",
> -			s->name);
> -		return err;
> -	}
> -
> -	/* Transform to an offset on the set of pages */
> -	if (s->random_seq) {
> -		unsigned int i;
> -
> -		for (i = 0; i < count; i++)
> -			s->random_seq[i] *= s->size;
> -	}
> -	return 0;
> -}
> -
> -/* Initialize each random sequence freelist per cache */
> -static void __init init_freelist_randomization(void)
> -{
> -	struct kmem_cache *s;
> -
> -	mutex_lock(&slab_mutex);
> -
> -	list_for_each_entry(s, &slab_caches, list)
> -		init_cache_random_seq(s);
> -
> -	mutex_unlock(&slab_mutex);
> -}
> -
> -/* Get the next entry on the pre-computed freelist randomized */
> -static void *next_freelist_entry(struct kmem_cache *s, struct slab *slab,
> -				unsigned long *pos, void *start,
> -				unsigned long page_limit,
> -				unsigned long freelist_count)
> -{
> -	unsigned int idx;
> -
> -	/*
> -	 * If the target page allocation failed, the number of objects on the
> -	 * page might be smaller than the usual size defined by the cache.
> -	 */
> -	do {
> -		idx = s->random_seq[*pos];
> -		*pos += 1;
> -		if (*pos >= freelist_count)
> -			*pos = 0;
> -	} while (unlikely(idx >= page_limit));
> -
> -	return (char *)start + idx;
> -}
> -
> -/* Shuffle the single linked freelist based on a random pre-computed sequence */
> -static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
> -{
> -	void *start;
> -	void *cur;
> -	void *next;
> -	unsigned long idx, pos, page_limit, freelist_count;
> -
> -	if (slab->objects < 2 || !s->random_seq)
> -		return false;
> -
> -	freelist_count = oo_objects(s->oo);
> -	pos = get_random_u32_below(freelist_count);
> -
> -	page_limit = slab->objects * s->size;
> -	start = fixup_red_left(s, slab_address(slab));
> -
> -	/* First entry is used as the base of the freelist */
> -	cur = next_freelist_entry(s, slab, &pos, start, page_limit,
> -				freelist_count);
> -	cur = setup_object(s, cur);
> -	slab->freelist = cur;
> -
> -	for (idx = 1; idx < slab->objects; idx++) {
> -		next = next_freelist_entry(s, slab, &pos, start, page_limit,
> -			freelist_count);
> -		next = setup_object(s, next);
> -		set_freepointer(s, cur, next);
> -		cur = next;
> -	}
> -	set_freepointer(s, cur, NULL);
> -
> -	return true;
> -}
> -#else
> -static inline int init_cache_random_seq(struct kmem_cache *s)
> -{
> -	return 0;
> -}
> -static inline void init_freelist_randomization(void) { }
> -static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_SLAB_FREELIST_RANDOM */
> -
> -static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
> -{
> -	struct slab *slab;
> -	struct kmem_cache_order_objects oo = s->oo;
> -	gfp_t alloc_gfp;
> -	void *start, *p, *next;
> -	int idx;
> -	bool shuffle;
> -
> -	flags &= gfp_allowed_mask;
> -
> -	flags |= s->allocflags;
> -
> -	/*
> -	 * Let the initial higher-order allocation fail under memory pressure
> -	 * so we fall-back to the minimum order allocation.
> -	 */
> -	alloc_gfp = (flags | __GFP_NOWARN | __GFP_NORETRY) & ~__GFP_NOFAIL;
> -	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
> -		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
> -
> -	slab = alloc_slab_page(alloc_gfp, node, oo);
> -	if (unlikely(!slab)) {
> -		oo = s->min;
> -		alloc_gfp = flags;
> -		/*
> -		 * Allocation may have failed due to fragmentation.
> -		 * Try a lower order alloc if possible
> -		 */
> -		slab = alloc_slab_page(alloc_gfp, node, oo);
> -		if (unlikely(!slab))
> -			return NULL;
> -		stat(s, ORDER_FALLBACK);
> -	}
> -
> -	slab->objects = oo_objects(oo);
> -	slab->inuse = 0;
> -	slab->frozen = 0;
> -
> -	account_slab(slab, oo_order(oo), s, flags);
> -
> -	slab->slab_cache = s;
> -
> -	kasan_poison_slab(slab);
> -
> -	start = slab_address(slab);
> -
> -	setup_slab_debug(s, slab, start);
> -
> -	shuffle = shuffle_freelist(s, slab);
> -
> -	if (!shuffle) {
> -		start = fixup_red_left(s, start);
> -		start = setup_object(s, start);
> -		slab->freelist = start;
> -		for (idx = 0, p = start; idx < slab->objects - 1; idx++) {
> -			next = p + s->size;
> -			next = setup_object(s, next);
> -			set_freepointer(s, p, next);
> -			p = next;
> -		}
> -		set_freepointer(s, p, NULL);
> -	}
> -
> -	return slab;
> -}
> -
> -static struct slab *new_slab(struct kmem_cache *s, gfp_t flags, int node)
> -{
> -	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> -		flags = kmalloc_fix_flags(flags);
> -
> -	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
> -
> -	return allocate_slab(s,
> -		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
> -}
> -
> -static void __free_slab(struct kmem_cache *s, struct slab *slab)
> -{
> -	struct folio *folio = slab_folio(slab);
> -	int order = folio_order(folio);
> -	int pages = 1 << order;
> -
> -	__slab_clear_pfmemalloc(slab);
> -	folio->mapping = NULL;
> -	/* Make the mapping reset visible before clearing the flag */
> -	smp_wmb();
> -	__folio_clear_slab(folio);
> -	if (current->reclaim_state)
> -		current->reclaim_state->reclaimed_slab += pages;
> -	unaccount_slab(slab, order, s);
> -	__free_pages(&folio->page, order);
> -}
> -
> -static void rcu_free_slab(struct rcu_head *h)
> -{
> -	struct slab *slab = container_of(h, struct slab, rcu_head);
> -
> -	__free_slab(slab->slab_cache, slab);
> -}
> -
> -static void free_slab(struct kmem_cache *s, struct slab *slab)
> -{
> -	if (kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
> -		void *p;
> -
> -		slab_pad_check(s, slab);
> -		for_each_object(p, s, slab_address(slab), slab->objects)
> -			check_object(s, slab, p, SLUB_RED_INACTIVE);
> -	}
> -
> -	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU))
> -		call_rcu(&slab->rcu_head, rcu_free_slab);
> -	else
> -		__free_slab(s, slab);
> -}
> -
> -static void discard_slab(struct kmem_cache *s, struct slab *slab)
> -{
> -	dec_slabs_node(s, slab_nid(slab), slab->objects);
> -	free_slab(s, slab);
> -}
> -
> -/*
> - * Management of partially allocated slabs.
> - */
> -static inline void
> -__add_partial(struct kmem_cache_node *n, struct slab *slab, int tail)
> -{
> -	n->nr_partial++;
> -	if (tail == DEACTIVATE_TO_TAIL)
> -		list_add_tail(&slab->slab_list, &n->partial);
> -	else
> -		list_add(&slab->slab_list, &n->partial);
> -}
> -
> -static inline void add_partial(struct kmem_cache_node *n,
> -				struct slab *slab, int tail)
> -{
> -	lockdep_assert_held(&n->list_lock);
> -	__add_partial(n, slab, tail);
> -}
> -
> -static inline void remove_partial(struct kmem_cache_node *n,
> -					struct slab *slab)
> -{
> -	lockdep_assert_held(&n->list_lock);
> -	list_del(&slab->slab_list);
> -	n->nr_partial--;
> -}
> -
> -/*
> - * Called only for kmem_cache_debug() caches instead of acquire_slab(), with a
> - * slab from the n->partial list. Remove only a single object from the slab, do
> - * the alloc_debug_processing() checks and leave the slab on the list, or move
> - * it to full list if it was the last free object.
> - */
> -static void *alloc_single_from_partial(struct kmem_cache *s,
> -		struct kmem_cache_node *n, struct slab *slab, int orig_size)
> -{
> -	void *object;
> -
> -	lockdep_assert_held(&n->list_lock);
> -
> -	object = slab->freelist;
> -	slab->freelist = get_freepointer(s, object);
> -	slab->inuse++;
> -
> -	if (!alloc_debug_processing(s, slab, object, orig_size)) {
> -		remove_partial(n, slab);
> -		return NULL;
> -	}
> -
> -	if (slab->inuse == slab->objects) {
> -		remove_partial(n, slab);
> -		add_full(s, n, slab);
> -	}
> -
> -	return object;
> -}
> -
> -/*
> - * Called only for kmem_cache_debug() caches to allocate from a freshly
> - * allocated slab. Allocate a single object instead of whole freelist
> - * and put the slab to the partial (or full) list.
> - */
> -static void *alloc_single_from_new_slab(struct kmem_cache *s,
> -					struct slab *slab, int orig_size)
> -{
> -	int nid = slab_nid(slab);
> -	struct kmem_cache_node *n = get_node(s, nid);
> -	unsigned long flags;
> -	void *object;
> -
> -
> -	object = slab->freelist;
> -	slab->freelist = get_freepointer(s, object);
> -	slab->inuse = 1;
> -
> -	if (!alloc_debug_processing(s, slab, object, orig_size))
> -		/*
> -		 * It's not really expected that this would fail on a
> -		 * freshly allocated slab, but a concurrent memory
> -		 * corruption in theory could cause that.
> -		 */
> -		return NULL;
> -
> -	spin_lock_irqsave(&n->list_lock, flags);
> -
> -	if (slab->inuse == slab->objects)
> -		add_full(s, n, slab);
> -	else
> -		add_partial(n, slab, DEACTIVATE_TO_HEAD);
> -
> -	inc_slabs_node(s, nid, slab->objects);
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> -
> -	return object;
> -}
> -
> -/*
> - * Remove slab from the partial list, freeze it and
> - * return the pointer to the freelist.
> - *
> - * Returns a list of objects or NULL if it fails.
> - */
> -static inline void *acquire_slab(struct kmem_cache *s,
> -		struct kmem_cache_node *n, struct slab *slab,
> -		int mode)
> -{
> -	void *freelist;
> -	unsigned long counters;
> -	struct slab new;
> -
> -	lockdep_assert_held(&n->list_lock);
> -
> -	/*
> -	 * Zap the freelist and set the frozen bit.
> -	 * The old freelist is the list of objects for the
> -	 * per cpu allocation list.
> -	 */
> -	freelist = slab->freelist;
> -	counters = slab->counters;
> -	new.counters = counters;
> -	if (mode) {
> -		new.inuse = slab->objects;
> -		new.freelist = NULL;
> -	} else {
> -		new.freelist = freelist;
> -	}
> -
> -	VM_BUG_ON(new.frozen);
> -	new.frozen = 1;
> -
> -	if (!__cmpxchg_double_slab(s, slab,
> -			freelist, counters,
> -			new.freelist, new.counters,
> -			"acquire_slab"))
> -		return NULL;
> -
> -	remove_partial(n, slab);
> -	WARN_ON(!freelist);
> -	return freelist;
> -}
> -
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain);
> -#else
> -static inline void put_cpu_partial(struct kmem_cache *s, struct slab *slab,
> -				   int drain) { }
> -#endif
> -static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
> -
> -/*
> - * Try to allocate a partial slab from a specific node.
> - */
> -static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
> -			      struct partial_context *pc)
> -{
> -	struct slab *slab, *slab2;
> -	void *object = NULL;
> -	unsigned long flags;
> -	unsigned int partial_slabs = 0;
> -
> -	/*
> -	 * Racy check. If we mistakenly see no partial slabs then we
> -	 * just allocate an empty slab. If we mistakenly try to get a
> -	 * partial slab and there is none available then get_partial()
> -	 * will return NULL.
> -	 */
> -	if (!n || !n->nr_partial)
> -		return NULL;
> -
> -	spin_lock_irqsave(&n->list_lock, flags);
> -	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
> -		void *t;
> -
> -		if (!pfmemalloc_match(slab, pc->flags))
> -			continue;
> -
> -		if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> -			object = alloc_single_from_partial(s, n, slab,
> -							pc->orig_size);
> -			if (object)
> -				break;
> -			continue;
> -		}
> -
> -		t = acquire_slab(s, n, slab, object == NULL);
> -		if (!t)
> -			break;
> -
> -		if (!object) {
> -			*pc->slab = slab;
> -			stat(s, ALLOC_FROM_PARTIAL);
> -			object = t;
> -		} else {
> -			put_cpu_partial(s, slab, 0);
> -			stat(s, CPU_PARTIAL_NODE);
> -			partial_slabs++;
> -		}
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -		if (!kmem_cache_has_cpu_partial(s)
> -			|| partial_slabs > s->cpu_partial_slabs / 2)
> -			break;
> -#else
> -		break;
> -#endif
> -
> -	}
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> -	return object;
> -}
> -
> -/*
> - * Get a slab from somewhere. Search in increasing NUMA distances.
> - */
> -static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
> -{
> -#ifdef CONFIG_NUMA
> -	struct zonelist *zonelist;
> -	struct zoneref *z;
> -	struct zone *zone;
> -	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
> -	void *object;
> -	unsigned int cpuset_mems_cookie;
> -
> -	/*
> -	 * The defrag ratio allows a configuration of the tradeoffs between
> -	 * inter node defragmentation and node local allocations. A lower
> -	 * defrag_ratio increases the tendency to do local allocations
> -	 * instead of attempting to obtain partial slabs from other nodes.
> -	 *
> -	 * If the defrag_ratio is set to 0 then kmalloc() always
> -	 * returns node local objects. If the ratio is higher then kmalloc()
> -	 * may return off node objects because partial slabs are obtained
> -	 * from other nodes and filled up.
> -	 *
> -	 * If /sys/kernel/slab/xx/remote_node_defrag_ratio is set to 100
> -	 * (which makes defrag_ratio = 1000) then every (well almost)
> -	 * allocation will first attempt to defrag slab caches on other nodes.
> -	 * This means scanning over all nodes to look for partial slabs which
> -	 * may be expensive if we do it every time we are trying to find a slab
> -	 * with available objects.
> -	 */
> -	if (!s->remote_node_defrag_ratio ||
> -			get_cycles() % 1024 > s->remote_node_defrag_ratio)
> -		return NULL;
> -
> -	do {
> -		cpuset_mems_cookie = read_mems_allowed_begin();
> -		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
> -		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
> -			struct kmem_cache_node *n;
> -
> -			n = get_node(s, zone_to_nid(zone));
> -
> -			if (n && cpuset_zone_allowed(zone, pc->flags) &&
> -					n->nr_partial > s->min_partial) {
> -				object = get_partial_node(s, n, pc);
> -				if (object) {
> -					/*
> -					 * Don't check read_mems_allowed_retry()
> -					 * here - if mems_allowed was updated in
> -					 * parallel, that was a harmless race
> -					 * between allocation and the cpuset
> -					 * update
> -					 */
> -					return object;
> -				}
> -			}
> -		}
> -	} while (read_mems_allowed_retry(cpuset_mems_cookie));
> -#endif	/* CONFIG_NUMA */
> -	return NULL;
> -}
> -
> -/*
> - * Get a partial slab, lock it and return it.
> - */
> -static void *get_partial(struct kmem_cache *s, int node, struct partial_context *pc)
> -{
> -	void *object;
> -	int searchnode = node;
> -
> -	if (node == NUMA_NO_NODE)
> -		searchnode = numa_mem_id();
> -
> -	object = get_partial_node(s, get_node(s, searchnode), pc);
> -	if (object || node != NUMA_NO_NODE)
> -		return object;
> -
> -	return get_any_partial(s, pc);
> -}
> -
> -#ifndef CONFIG_SLUB_TINY
> -
> -#ifdef CONFIG_PREEMPTION
> -/*
> - * Calculate the next globally unique transaction for disambiguation
> - * during cmpxchg. The transactions start with the cpu number and are then
> - * incremented by CONFIG_NR_CPUS.
> - */
> -#define TID_STEP  roundup_pow_of_two(CONFIG_NR_CPUS)
> -#else
> -/*
> - * No preemption supported therefore also no need to check for
> - * different cpus.
> - */
> -#define TID_STEP 1
> -#endif /* CONFIG_PREEMPTION */
> -
> -static inline unsigned long next_tid(unsigned long tid)
> -{
> -	return tid + TID_STEP;
> -}
> -
> -#ifdef SLUB_DEBUG_CMPXCHG
> -static inline unsigned int tid_to_cpu(unsigned long tid)
> -{
> -	return tid % TID_STEP;
> -}
> -
> -static inline unsigned long tid_to_event(unsigned long tid)
> -{
> -	return tid / TID_STEP;
> -}
> -#endif
> -
> -static inline unsigned int init_tid(int cpu)
> -{
> -	return cpu;
> -}
> -
> -static inline void note_cmpxchg_failure(const char *n,
> -		const struct kmem_cache *s, unsigned long tid)
> -{
> -#ifdef SLUB_DEBUG_CMPXCHG
> -	unsigned long actual_tid = __this_cpu_read(s->cpu_slab->tid);
> -
> -	pr_info("%s %s: cmpxchg redo ", n, s->name);
> -
> -#ifdef CONFIG_PREEMPTION
> -	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
> -		pr_warn("due to cpu change %d -> %d\n",
> -			tid_to_cpu(tid), tid_to_cpu(actual_tid));
> -	else
> -#endif
> -	if (tid_to_event(tid) != tid_to_event(actual_tid))
> -		pr_warn("due to cpu running other code. Event %ld->%ld\n",
> -			tid_to_event(tid), tid_to_event(actual_tid));
> -	else
> -		pr_warn("for unknown reason: actual=%lx was=%lx target=%lx\n",
> -			actual_tid, tid, next_tid(tid));
> -#endif
> -	stat(s, CMPXCHG_DOUBLE_CPU_FAIL);
> -}
> -
> -static void init_kmem_cache_cpus(struct kmem_cache *s)
> -{
> -	int cpu;
> -	struct kmem_cache_cpu *c;
> -
> -	for_each_possible_cpu(cpu) {
> -		c = per_cpu_ptr(s->cpu_slab, cpu);
> -		local_lock_init(&c->lock);
> -		c->tid = init_tid(cpu);
> -	}
> -}
> -
> -/*
> - * Finishes removing the cpu slab. Merges cpu's freelist with slab's freelist,
> - * unfreezes the slabs and puts it on the proper list.
> - * Assumes the slab has been already safely taken away from kmem_cache_cpu
> - * by the caller.
> - */
> -static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> -			    void *freelist)
> -{
> -	enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
> -	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> -	int free_delta = 0;
> -	enum slab_modes mode = M_NONE;
> -	void *nextfree, *freelist_iter, *freelist_tail;
> -	int tail = DEACTIVATE_TO_HEAD;
> -	unsigned long flags = 0;
> -	struct slab new;
> -	struct slab old;
> -
> -	if (slab->freelist) {
> -		stat(s, DEACTIVATE_REMOTE_FREES);
> -		tail = DEACTIVATE_TO_TAIL;
> -	}
> -
> -	/*
> -	 * Stage one: Count the objects on cpu's freelist as free_delta and
> -	 * remember the last object in freelist_tail for later splicing.
> -	 */
> -	freelist_tail = NULL;
> -	freelist_iter = freelist;
> -	while (freelist_iter) {
> -		nextfree = get_freepointer(s, freelist_iter);
> -
> -		/*
> -		 * If 'nextfree' is invalid, it is possible that the object at
> -		 * 'freelist_iter' is already corrupted.  So isolate all objects
> -		 * starting at 'freelist_iter' by skipping them.
> -		 */
> -		if (freelist_corrupted(s, slab, &freelist_iter, nextfree))
> -			break;
> -
> -		freelist_tail = freelist_iter;
> -		free_delta++;
> -
> -		freelist_iter = nextfree;
> -	}
> -
> -	/*
> -	 * Stage two: Unfreeze the slab while splicing the per-cpu
> -	 * freelist to the head of slab's freelist.
> -	 *
> -	 * Ensure that the slab is unfrozen while the list presence
> -	 * reflects the actual number of objects during unfreeze.
> -	 *
> -	 * We first perform cmpxchg holding lock and insert to list
> -	 * when it succeed. If there is mismatch then the slab is not
> -	 * unfrozen and number of objects in the slab may have changed.
> -	 * Then release lock and retry cmpxchg again.
> -	 */
> -redo:
> -
> -	old.freelist = READ_ONCE(slab->freelist);
> -	old.counters = READ_ONCE(slab->counters);
> -	VM_BUG_ON(!old.frozen);
> -
> -	/* Determine target state of the slab */
> -	new.counters = old.counters;
> -	if (freelist_tail) {
> -		new.inuse -= free_delta;
> -		set_freepointer(s, freelist_tail, old.freelist);
> -		new.freelist = freelist;
> -	} else
> -		new.freelist = old.freelist;
> -
> -	new.frozen = 0;
> -
> -	if (!new.inuse && n->nr_partial >= s->min_partial) {
> -		mode = M_FREE;
> -	} else if (new.freelist) {
> -		mode = M_PARTIAL;
> -		/*
> -		 * Taking the spinlock removes the possibility that
> -		 * acquire_slab() will see a slab that is frozen
> -		 */
> -		spin_lock_irqsave(&n->list_lock, flags);
> -	} else {
> -		mode = M_FULL_NOLIST;
> -	}
> -
> -
> -	if (!cmpxchg_double_slab(s, slab,
> -				old.freelist, old.counters,
> -				new.freelist, new.counters,
> -				"unfreezing slab")) {
> -		if (mode == M_PARTIAL)
> -			spin_unlock_irqrestore(&n->list_lock, flags);
> -		goto redo;
> -	}
> -
> -
> -	if (mode == M_PARTIAL) {
> -		add_partial(n, slab, tail);
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> -		stat(s, tail);
> -	} else if (mode == M_FREE) {
> -		stat(s, DEACTIVATE_EMPTY);
> -		discard_slab(s, slab);
> -		stat(s, FREE_SLAB);
> -	} else if (mode == M_FULL_NOLIST) {
> -		stat(s, DEACTIVATE_FULL);
> -	}
> -}
> -
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
> -{
> -	struct kmem_cache_node *n = NULL, *n2 = NULL;
> -	struct slab *slab, *slab_to_discard = NULL;
> -	unsigned long flags = 0;
> -
> -	while (partial_slab) {
> -		struct slab new;
> -		struct slab old;
> -
> -		slab = partial_slab;
> -		partial_slab = slab->next;
> -
> -		n2 = get_node(s, slab_nid(slab));
> -		if (n != n2) {
> -			if (n)
> -				spin_unlock_irqrestore(&n->list_lock, flags);
> -
> -			n = n2;
> -			spin_lock_irqsave(&n->list_lock, flags);
> -		}
> -
> -		do {
> -
> -			old.freelist = slab->freelist;
> -			old.counters = slab->counters;
> -			VM_BUG_ON(!old.frozen);
> -
> -			new.counters = old.counters;
> -			new.freelist = old.freelist;
> -
> -			new.frozen = 0;
> -
> -		} while (!__cmpxchg_double_slab(s, slab,
> -				old.freelist, old.counters,
> -				new.freelist, new.counters,
> -				"unfreezing slab"));
> -
> -		if (unlikely(!new.inuse && n->nr_partial >= s->min_partial)) {
> -			slab->next = slab_to_discard;
> -			slab_to_discard = slab;
> -		} else {
> -			add_partial(n, slab, DEACTIVATE_TO_TAIL);
> -			stat(s, FREE_ADD_PARTIAL);
> -		}
> -	}
> -
> -	if (n)
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> -
> -	while (slab_to_discard) {
> -		slab = slab_to_discard;
> -		slab_to_discard = slab_to_discard->next;
> -
> -		stat(s, DEACTIVATE_EMPTY);
> -		discard_slab(s, slab);
> -		stat(s, FREE_SLAB);
> -	}
> -}
> -
> -/*
> - * Unfreeze all the cpu partial slabs.
> - */
> -static void unfreeze_partials(struct kmem_cache *s)
> -{
> -	struct slab *partial_slab;
> -	unsigned long flags;
> -
> -	local_lock_irqsave(&s->cpu_slab->lock, flags);
> -	partial_slab = this_cpu_read(s->cpu_slab->partial);
> -	this_cpu_write(s->cpu_slab->partial, NULL);
> -	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -
> -	if (partial_slab)
> -		__unfreeze_partials(s, partial_slab);
> -}
> -
> -static void unfreeze_partials_cpu(struct kmem_cache *s,
> -				  struct kmem_cache_cpu *c)
> -{
> -	struct slab *partial_slab;
> -
> -	partial_slab = slub_percpu_partial(c);
> -	c->partial = NULL;
> -
> -	if (partial_slab)
> -		__unfreeze_partials(s, partial_slab);
> -}
> -
> -/*
> - * Put a slab that was just frozen (in __slab_free|get_partial_node) into a
> - * partial slab slot if available.
> - *
> - * If we did not find a slot then simply move all the partials to the
> - * per node partial list.
> - */
> -static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
> -{
> -	struct slab *oldslab;
> -	struct slab *slab_to_unfreeze = NULL;
> -	unsigned long flags;
> -	int slabs = 0;
> -
> -	local_lock_irqsave(&s->cpu_slab->lock, flags);
> -
> -	oldslab = this_cpu_read(s->cpu_slab->partial);
> -
> -	if (oldslab) {
> -		if (drain && oldslab->slabs >= s->cpu_partial_slabs) {
> -			/*
> -			 * Partial array is full. Move the existing set to the
> -			 * per node partial list. Postpone the actual unfreezing
> -			 * outside of the critical section.
> -			 */
> -			slab_to_unfreeze = oldslab;
> -			oldslab = NULL;
> -		} else {
> -			slabs = oldslab->slabs;
> -		}
> -	}
> -
> -	slabs++;
> -
> -	slab->slabs = slabs;
> -	slab->next = oldslab;
> -
> -	this_cpu_write(s->cpu_slab->partial, slab);
> -
> -	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -
> -	if (slab_to_unfreeze) {
> -		__unfreeze_partials(s, slab_to_unfreeze);
> -		stat(s, CPU_PARTIAL_DRAIN);
> -	}
> -}
> -
> -#else	/* CONFIG_SLUB_CPU_PARTIAL */
> -
> -static inline void unfreeze_partials(struct kmem_cache *s) { }
> -static inline void unfreeze_partials_cpu(struct kmem_cache *s,
> -				  struct kmem_cache_cpu *c) { }
> -
> -#endif	/* CONFIG_SLUB_CPU_PARTIAL */
> -
> -static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
> -{
> -	unsigned long flags;
> -	struct slab *slab;
> -	void *freelist;
> -
> -	local_lock_irqsave(&s->cpu_slab->lock, flags);
> -
> -	slab = c->slab;
> -	freelist = c->freelist;
> -
> -	c->slab = NULL;
> -	c->freelist = NULL;
> -	c->tid = next_tid(c->tid);
> -
> -	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -
> -	if (slab) {
> -		deactivate_slab(s, slab, freelist);
> -		stat(s, CPUSLAB_FLUSH);
> -	}
> -}
> -
> -static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
> -{
> -	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
> -	void *freelist = c->freelist;
> -	struct slab *slab = c->slab;
> -
> -	c->slab = NULL;
> -	c->freelist = NULL;
> -	c->tid = next_tid(c->tid);
> -
> -	if (slab) {
> -		deactivate_slab(s, slab, freelist);
> -		stat(s, CPUSLAB_FLUSH);
> -	}
> -
> -	unfreeze_partials_cpu(s, c);
> -}
> -
> -struct slub_flush_work {
> -	struct work_struct work;
> -	struct kmem_cache *s;
> -	bool skip;
> -};
> -
> -/*
> - * Flush cpu slab.
> - *
> - * Called from CPU work handler with migration disabled.
> - */
> -static void flush_cpu_slab(struct work_struct *w)
> -{
> -	struct kmem_cache *s;
> -	struct kmem_cache_cpu *c;
> -	struct slub_flush_work *sfw;
> -
> -	sfw = container_of(w, struct slub_flush_work, work);
> -
> -	s = sfw->s;
> -	c = this_cpu_ptr(s->cpu_slab);
> -
> -	if (c->slab)
> -		flush_slab(s, c);
> -
> -	unfreeze_partials(s);
> -}
> -
> -static bool has_cpu_slab(int cpu, struct kmem_cache *s)
> -{
> -	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
> -
> -	return c->slab || slub_percpu_partial(c);
> -}
> -
> -static DEFINE_MUTEX(flush_lock);
> -static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
> -
> -static void flush_all_cpus_locked(struct kmem_cache *s)
> -{
> -	struct slub_flush_work *sfw;
> -	unsigned int cpu;
> -
> -	lockdep_assert_cpus_held();
> -	mutex_lock(&flush_lock);
> -
> -	for_each_online_cpu(cpu) {
> -		sfw = &per_cpu(slub_flush, cpu);
> -		if (!has_cpu_slab(cpu, s)) {
> -			sfw->skip = true;
> -			continue;
> -		}
> -		INIT_WORK(&sfw->work, flush_cpu_slab);
> -		sfw->skip = false;
> -		sfw->s = s;
> -		queue_work_on(cpu, flushwq, &sfw->work);
> -	}
> -
> -	for_each_online_cpu(cpu) {
> -		sfw = &per_cpu(slub_flush, cpu);
> -		if (sfw->skip)
> -			continue;
> -		flush_work(&sfw->work);
> -	}
> -
> -	mutex_unlock(&flush_lock);
> -}
> -
> -static void flush_all(struct kmem_cache *s)
> -{
> -	cpus_read_lock();
> -	flush_all_cpus_locked(s);
> -	cpus_read_unlock();
> -}
> -
> -/*
> - * Use the cpu notifier to insure that the cpu slabs are flushed when
> - * necessary.
> - */
> -static int slub_cpu_dead(unsigned int cpu)
> -{
> -	struct kmem_cache *s;
> -
> -	mutex_lock(&slab_mutex);
> -	list_for_each_entry(s, &slab_caches, list)
> -		__flush_cpu_slab(s, cpu);
> -	mutex_unlock(&slab_mutex);
> -	return 0;
> -}
> -
> -#else /* CONFIG_SLUB_TINY */
> -static inline void flush_all_cpus_locked(struct kmem_cache *s) { }
> -static inline void flush_all(struct kmem_cache *s) { }
> -static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
> -static inline int slub_cpu_dead(unsigned int cpu) { return 0; }
> -#endif /* CONFIG_SLUB_TINY */
> -
> -/*
> - * Check if the objects in a per cpu structure fit numa
> - * locality expectations.
> - */
> -static inline int node_match(struct slab *slab, int node)
> -{
> -#ifdef CONFIG_NUMA
> -	if (node != NUMA_NO_NODE && slab_nid(slab) != node)
> -		return 0;
> -#endif
> -	return 1;
> -}
> -
> -#ifdef CONFIG_SLUB_DEBUG
> -static int count_free(struct slab *slab)
> -{
> -	return slab->objects - slab->inuse;
> -}
> -
> -static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
> -{
> -	return atomic_long_read(&n->total_objects);
> -}
> -
> -/* Supports checking bulk free of a constructed freelist */
> -static inline bool free_debug_processing(struct kmem_cache *s,
> -	struct slab *slab, void *head, void *tail, int *bulk_cnt,
> -	unsigned long addr, depot_stack_handle_t handle)
> -{
> -	bool checks_ok = false;
> -	void *object = head;
> -	int cnt = 0;
> -
> -	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> -		if (!check_slab(s, slab))
> -			goto out;
> -	}
> -
> -	if (slab->inuse < *bulk_cnt) {
> -		slab_err(s, slab, "Slab has %d allocated objects but %d are to be freed\n",
> -			 slab->inuse, *bulk_cnt);
> -		goto out;
> -	}
> -
> -next_object:
> -
> -	if (++cnt > *bulk_cnt)
> -		goto out_cnt;
> -
> -	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> -		if (!free_consistency_checks(s, slab, object, addr))
> -			goto out;
> -	}
> -
> -	if (s->flags & SLAB_STORE_USER)
> -		set_track_update(s, object, TRACK_FREE, addr, handle);
> -	trace(s, slab, object, 0);
> -	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
> -	init_object(s, object, SLUB_RED_INACTIVE);
> -
> -	/* Reached end of constructed freelist yet? */
> -	if (object != tail) {
> -		object = get_freepointer(s, object);
> -		goto next_object;
> -	}
> -	checks_ok = true;
> -
> -out_cnt:
> -	if (cnt != *bulk_cnt) {
> -		slab_err(s, slab, "Bulk free expected %d objects but found %d\n",
> -			 *bulk_cnt, cnt);
> -		*bulk_cnt = cnt;
> -	}
> -
> -out:
> -
> -	if (!checks_ok)
> -		slab_fix(s, "Object at 0x%p not freed", object);
> -
> -	return checks_ok;
> -}
> -#endif /* CONFIG_SLUB_DEBUG */
> -
> -#if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
> -static unsigned long count_partial(struct kmem_cache_node *n,
> -					int (*get_count)(struct slab *))
> -{
> -	unsigned long flags;
> -	unsigned long x = 0;
> -	struct slab *slab;
> -
> -	spin_lock_irqsave(&n->list_lock, flags);
> -	list_for_each_entry(slab, &n->partial, slab_list)
> -		x += get_count(slab);
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> -	return x;
> -}
> -#endif /* CONFIG_SLUB_DEBUG || SLAB_SUPPORTS_SYSFS */
> -
> -#ifdef CONFIG_SLUB_DEBUG
> -static noinline void
> -slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
> -{
> -	static DEFINE_RATELIMIT_STATE(slub_oom_rs, DEFAULT_RATELIMIT_INTERVAL,
> -				      DEFAULT_RATELIMIT_BURST);
> -	int node;
> -	struct kmem_cache_node *n;
> -
> -	if ((gfpflags & __GFP_NOWARN) || !__ratelimit(&slub_oom_rs))
> -		return;
> -
> -	pr_warn("SLUB: Unable to allocate memory on node %d, gfp=%#x(%pGg)\n",
> -		nid, gfpflags, &gfpflags);
> -	pr_warn("  cache: %s, object size: %u, buffer size: %u, default order: %u, min order: %u\n",
> -		s->name, s->object_size, s->size, oo_order(s->oo),
> -		oo_order(s->min));
> -
> -	if (oo_order(s->min) > get_order(s->object_size))
> -		pr_warn("  %s debugging increased min order, use slub_debug=O to disable.\n",
> -			s->name);
> -
> -	for_each_kmem_cache_node(s, node, n) {
> -		unsigned long nr_slabs;
> -		unsigned long nr_objs;
> -		unsigned long nr_free;
> -
> -		nr_free  = count_partial(n, count_free);
> -		nr_slabs = node_nr_slabs(n);
> -		nr_objs  = node_nr_objs(n);
> -
> -		pr_warn("  node %d: slabs: %ld, objs: %ld, free: %ld\n",
> -			node, nr_slabs, nr_objs, nr_free);
> -	}
> -}
> -#else /* CONFIG_SLUB_DEBUG */
> -static inline void
> -slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid) { }
> -#endif
> -
> -static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags)
> -{
> -	if (unlikely(slab_test_pfmemalloc(slab)))
> -		return gfp_pfmemalloc_allowed(gfpflags);
> -
> -	return true;
> -}
> -
> -#ifndef CONFIG_SLUB_TINY
> -/*
> - * Check the slab->freelist and either transfer the freelist to the
> - * per cpu freelist or deactivate the slab.
> - *
> - * The slab is still frozen if the return value is not NULL.
> - *
> - * If this function returns NULL then the slab has been unfrozen.
> - */
> -static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
> -{
> -	struct slab new;
> -	unsigned long counters;
> -	void *freelist;
> -
> -	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
> -
> -	do {
> -		freelist = slab->freelist;
> -		counters = slab->counters;
> -
> -		new.counters = counters;
> -		VM_BUG_ON(!new.frozen);
> -
> -		new.inuse = slab->objects;
> -		new.frozen = freelist != NULL;
> -
> -	} while (!__cmpxchg_double_slab(s, slab,
> -		freelist, counters,
> -		NULL, new.counters,
> -		"get_freelist"));
> -
> -	return freelist;
> -}
> -
> -/*
> - * Slow path. The lockless freelist is empty or we need to perform
> - * debugging duties.
> - *
> - * Processing is still very fast if new objects have been freed to the
> - * regular freelist. In that case we simply take over the regular freelist
> - * as the lockless freelist and zap the regular freelist.
> - *
> - * If that is not working then we fall back to the partial lists. We take the
> - * first element of the freelist as the object to allocate now and move the
> - * rest of the freelist to the lockless freelist.
> - *
> - * And if we were unable to get a new slab from the partial slab lists then
> - * we need to allocate a new slab. This is the slowest path since it involves
> - * a call to the page allocator and the setup of a new slab.
> - *
> - * Version of __slab_alloc to use when we know that preemption is
> - * already disabled (which is the case for bulk allocation).
> - */
> -static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> -{
> -	void *freelist;
> -	struct slab *slab;
> -	unsigned long flags;
> -	struct partial_context pc;
> -
> -	stat(s, ALLOC_SLOWPATH);
> -
> -reread_slab:
> -
> -	slab = READ_ONCE(c->slab);
> -	if (!slab) {
> -		/*
> -		 * if the node is not online or has no normal memory, just
> -		 * ignore the node constraint
> -		 */
> -		if (unlikely(node != NUMA_NO_NODE &&
> -			     !node_isset(node, slab_nodes)))
> -			node = NUMA_NO_NODE;
> -		goto new_slab;
> -	}
> -redo:
> -
> -	if (unlikely(!node_match(slab, node))) {
> -		/*
> -		 * same as above but node_match() being false already
> -		 * implies node != NUMA_NO_NODE
> -		 */
> -		if (!node_isset(node, slab_nodes)) {
> -			node = NUMA_NO_NODE;
> -		} else {
> -			stat(s, ALLOC_NODE_MISMATCH);
> -			goto deactivate_slab;
> -		}
> -	}
> -
> -	/*
> -	 * By rights, we should be searching for a slab page that was
> -	 * PFMEMALLOC but right now, we are losing the pfmemalloc
> -	 * information when the page leaves the per-cpu allocator
> -	 */
> -	if (unlikely(!pfmemalloc_match(slab, gfpflags)))
> -		goto deactivate_slab;
> -
> -	/* must check again c->slab in case we got preempted and it changed */
> -	local_lock_irqsave(&s->cpu_slab->lock, flags);
> -	if (unlikely(slab != c->slab)) {
> -		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -		goto reread_slab;
> -	}
> -	freelist = c->freelist;
> -	if (freelist)
> -		goto load_freelist;
> -
> -	freelist = get_freelist(s, slab);
> -
> -	if (!freelist) {
> -		c->slab = NULL;
> -		c->tid = next_tid(c->tid);
> -		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -		stat(s, DEACTIVATE_BYPASS);
> -		goto new_slab;
> -	}
> -
> -	stat(s, ALLOC_REFILL);
> -
> -load_freelist:
> -
> -	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
> -
> -	/*
> -	 * freelist is pointing to the list of objects to be used.
> -	 * slab is pointing to the slab from which the objects are obtained.
> -	 * That slab must be frozen for per cpu allocations to work.
> -	 */
> -	VM_BUG_ON(!c->slab->frozen);
> -	c->freelist = get_freepointer(s, freelist);
> -	c->tid = next_tid(c->tid);
> -	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -	return freelist;
> -
> -deactivate_slab:
> -
> -	local_lock_irqsave(&s->cpu_slab->lock, flags);
> -	if (slab != c->slab) {
> -		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -		goto reread_slab;
> -	}
> -	freelist = c->freelist;
> -	c->slab = NULL;
> -	c->freelist = NULL;
> -	c->tid = next_tid(c->tid);
> -	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -	deactivate_slab(s, slab, freelist);
> -
> -new_slab:
> -
> -	if (slub_percpu_partial(c)) {
> -		local_lock_irqsave(&s->cpu_slab->lock, flags);
> -		if (unlikely(c->slab)) {
> -			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -			goto reread_slab;
> -		}
> -		if (unlikely(!slub_percpu_partial(c))) {
> -			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -			/* we were preempted and partial list got empty */
> -			goto new_objects;
> -		}
> -
> -		slab = c->slab = slub_percpu_partial(c);
> -		slub_set_percpu_partial(c, slab);
> -		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -		stat(s, CPU_PARTIAL_ALLOC);
> -		goto redo;
> -	}
> -
> -new_objects:
> -
> -	pc.flags = gfpflags;
> -	pc.slab = &slab;
> -	pc.orig_size = orig_size;
> -	freelist = get_partial(s, node, &pc);
> -	if (freelist)
> -		goto check_new_slab;
> -
> -	slub_put_cpu_ptr(s->cpu_slab);
> -	slab = new_slab(s, gfpflags, node);
> -	c = slub_get_cpu_ptr(s->cpu_slab);
> -
> -	if (unlikely(!slab)) {
> -		slab_out_of_memory(s, gfpflags, node);
> -		return NULL;
> -	}
> -
> -	stat(s, ALLOC_SLAB);
> -
> -	if (kmem_cache_debug(s)) {
> -		freelist = alloc_single_from_new_slab(s, slab, orig_size);
> -
> -		if (unlikely(!freelist))
> -			goto new_objects;
> -
> -		if (s->flags & SLAB_STORE_USER)
> -			set_track(s, freelist, TRACK_ALLOC, addr);
> -
> -		return freelist;
> -	}
> -
> -	/*
> -	 * No other reference to the slab yet so we can
> -	 * muck around with it freely without cmpxchg
> -	 */
> -	freelist = slab->freelist;
> -	slab->freelist = NULL;
> -	slab->inuse = slab->objects;
> -	slab->frozen = 1;
> -
> -	inc_slabs_node(s, slab_nid(slab), slab->objects);
> -
> -check_new_slab:
> -
> -	if (kmem_cache_debug(s)) {
> -		/*
> -		 * For debug caches here we had to go through
> -		 * alloc_single_from_partial() so just store the tracking info
> -		 * and return the object
> -		 */
> -		if (s->flags & SLAB_STORE_USER)
> -			set_track(s, freelist, TRACK_ALLOC, addr);
> -
> -		return freelist;
> -	}
> -
> -	if (unlikely(!pfmemalloc_match(slab, gfpflags))) {
> -		/*
> -		 * For !pfmemalloc_match() case we don't load freelist so that
> -		 * we don't make further mismatched allocations easier.
> -		 */
> -		deactivate_slab(s, slab, get_freepointer(s, freelist));
> -		return freelist;
> -	}
> -
> -retry_load_slab:
> -
> -	local_lock_irqsave(&s->cpu_slab->lock, flags);
> -	if (unlikely(c->slab)) {
> -		void *flush_freelist = c->freelist;
> -		struct slab *flush_slab = c->slab;
> -
> -		c->slab = NULL;
> -		c->freelist = NULL;
> -		c->tid = next_tid(c->tid);
> -
> -		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -
> -		deactivate_slab(s, flush_slab, flush_freelist);
> -
> -		stat(s, CPUSLAB_FLUSH);
> -
> -		goto retry_load_slab;
> -	}
> -	c->slab = slab;
> -
> -	goto load_freelist;
> -}
> -
> -/*
> - * A wrapper for ___slab_alloc() for contexts where preemption is not yet
> - * disabled. Compensates for possible cpu changes by refetching the per cpu area
> - * pointer.
> - */
> -static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> -{
> -	void *p;
> -
> -#ifdef CONFIG_PREEMPT_COUNT
> -	/*
> -	 * We may have been preempted and rescheduled on a different
> -	 * cpu before disabling preemption. Need to reload cpu area
> -	 * pointer.
> -	 */
> -	c = slub_get_cpu_ptr(s->cpu_slab);
> -#endif
> -
> -	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> -#ifdef CONFIG_PREEMPT_COUNT
> -	slub_put_cpu_ptr(s->cpu_slab);
> -#endif
> -	return p;
> -}
> -
> -static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
> -		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
> -{
> -	struct kmem_cache_cpu *c;
> -	struct slab *slab;
> -	unsigned long tid;
> -	void *object;
> -
> -redo:
> -	/*
> -	 * Must read kmem_cache cpu data via this cpu ptr. Preemption is
> -	 * enabled. We may switch back and forth between cpus while
> -	 * reading from one cpu area. That does not matter as long
> -	 * as we end up on the original cpu again when doing the cmpxchg.
> -	 *
> -	 * We must guarantee that tid and kmem_cache_cpu are retrieved on the
> -	 * same cpu. We read first the kmem_cache_cpu pointer and use it to read
> -	 * the tid. If we are preempted and switched to another cpu between the
> -	 * two reads, it's OK as the two are still associated with the same cpu
> -	 * and cmpxchg later will validate the cpu.
> -	 */
> -	c = raw_cpu_ptr(s->cpu_slab);
> -	tid = READ_ONCE(c->tid);
> -
> -	/*
> -	 * Irqless object alloc/free algorithm used here depends on sequence
> -	 * of fetching cpu_slab's data. tid should be fetched before anything
> -	 * on c to guarantee that object and slab associated with previous tid
> -	 * won't be used with current tid. If we fetch tid first, object and
> -	 * slab could be one associated with next tid and our alloc/free
> -	 * request will be failed. In this case, we will retry. So, no problem.
> -	 */
> -	barrier();
> -
> -	/*
> -	 * The transaction ids are globally unique per cpu and per operation on
> -	 * a per cpu queue. Thus they can be guarantee that the cmpxchg_double
> -	 * occurs on the right processor and that there was no operation on the
> -	 * linked list in between.
> -	 */
> -
> -	object = c->freelist;
> -	slab = c->slab;
> -
> -	if (!USE_LOCKLESS_FAST_PATH() ||
> -	    unlikely(!object || !slab || !node_match(slab, node))) {
> -		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
> -	} else {
> -		void *next_object = get_freepointer_safe(s, object);
> -
> -		/*
> -		 * The cmpxchg will only match if there was no additional
> -		 * operation and if we are on the right processor.
> -		 *
> -		 * The cmpxchg does the following atomically (without lock
> -		 * semantics!)
> -		 * 1. Relocate first pointer to the current per cpu area.
> -		 * 2. Verify that tid and freelist have not been changed
> -		 * 3. If they were not changed replace tid and freelist
> -		 *
> -		 * Since this is without lock semantics the protection is only
> -		 * against code executing on this cpu *not* from access by
> -		 * other cpus.
> -		 */
> -		if (unlikely(!this_cpu_cmpxchg_double(
> -				s->cpu_slab->freelist, s->cpu_slab->tid,
> -				object, tid,
> -				next_object, next_tid(tid)))) {
> -
> -			note_cmpxchg_failure("slab_alloc", s, tid);
> -			goto redo;
> -		}
> -		prefetch_freepointer(s, next_object);
> -		stat(s, ALLOC_FASTPATH);
> -	}
> -
> -	return object;
> -}
> -#else /* CONFIG_SLUB_TINY */
> -static void *__slab_alloc_node(struct kmem_cache *s,
> -		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
> -{
> -	struct partial_context pc;
> -	struct slab *slab;
> -	void *object;
> -
> -	pc.flags = gfpflags;
> -	pc.slab = &slab;
> -	pc.orig_size = orig_size;
> -	object = get_partial(s, node, &pc);
> -
> -	if (object)
> -		return object;
> -
> -	slab = new_slab(s, gfpflags, node);
> -	if (unlikely(!slab)) {
> -		slab_out_of_memory(s, gfpflags, node);
> -		return NULL;
> -	}
> -
> -	object = alloc_single_from_new_slab(s, slab, orig_size);
> -
> -	return object;
> -}
> -#endif /* CONFIG_SLUB_TINY */
> -
> -/*
> - * If the object has been wiped upon free, make sure it's fully initialized by
> - * zeroing out freelist pointer.
> - */
> -static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
> -						   void *obj)
> -{
> -	if (unlikely(slab_want_init_on_free(s)) && obj)
> -		memset((void *)((char *)kasan_reset_tag(obj) + s->offset),
> -			0, sizeof(void *));
> -}
> -
> -/*
> - * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
> - * have the fastpath folded into their functions. So no function call
> - * overhead for requests that can be satisfied on the fastpath.
> - *
> - * The fastpath works by first checking if the lockless freelist can be used.
> - * If not then __slab_alloc is called for slow processing.
> - *
> - * Otherwise we can simply pick the next object from the lockless free list.
> - */
> -static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
> -		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
> -{
> -	void *object;
> -	struct obj_cgroup *objcg = NULL;
> -	bool init = false;
> -
> -	s = slab_pre_alloc_hook(s, lru, &objcg, 1, gfpflags);
> -	if (!s)
> -		return NULL;
> -
> -	object = kfence_alloc(s, orig_size, gfpflags);
> -	if (unlikely(object))
> -		goto out;
> -
> -	object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
> -
> -	maybe_wipe_obj_freeptr(s, object);
> -	init = slab_want_init_on_alloc(gfpflags, s);
> -
> -out:
> -	/*
> -	 * When init equals 'true', like for kzalloc() family, only
> -	 * @orig_size bytes might be zeroed instead of s->object_size
> -	 */
> -	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
> -
> -	return object;
> -}
> -
> -static __fastpath_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *lru,
> -		gfp_t gfpflags, unsigned long addr, size_t orig_size)
> -{
> -	return slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, addr, orig_size);
> -}
> -
> -static __fastpath_inline
> -void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> -			     gfp_t gfpflags)
> -{
> -	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> -
> -	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
> -
> -	return ret;
> -}
> -
> -void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
> -{
> -	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc);
> -
> -void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> -			   gfp_t gfpflags)
> -{
> -	return __kmem_cache_alloc_lru(s, lru, gfpflags);
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc_lru);
> -
> -void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
> -			      int node, size_t orig_size,
> -			      unsigned long caller)
> -{
> -	return slab_alloc_node(s, NULL, gfpflags, node,
> -			       caller, orig_size);
> -}
> -
> -void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
> -{
> -	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
> -
> -	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, node);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc_node);
> -
> -static noinline void free_to_partial_list(
> -	struct kmem_cache *s, struct slab *slab,
> -	void *head, void *tail, int bulk_cnt,
> -	unsigned long addr)
> -{
> -	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> -	struct slab *slab_free = NULL;
> -	int cnt = bulk_cnt;
> -	unsigned long flags;
> -	depot_stack_handle_t handle = 0;
> -
> -	if (s->flags & SLAB_STORE_USER)
> -		handle = set_track_prepare();
> -
> -	spin_lock_irqsave(&n->list_lock, flags);
> -
> -	if (free_debug_processing(s, slab, head, tail, &cnt, addr, handle)) {
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
> -	}
> -
> -	if (slab_free) {
> -		/*
> -		 * Update the counters while still holding n->list_lock to
> -		 * prevent spurious validation warnings
> -		 */
> -		dec_slabs_node(s, slab_nid(slab_free), slab_free->objects);
> -	}
> -
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> -
> -	if (slab_free) {
> -		stat(s, FREE_SLAB);
> -		free_slab(s, slab_free);
> -	}
> -}
> -
> -/*
> - * Slow path handling. This may still be called frequently since objects
> - * have a longer lifetime than the cpu slabs in most processing loads.
> - *
> - * So we still attempt to reduce cache line usage. Just take the slab
> - * lock and free the item. If there is no additional partial slab
> - * handling required then we can return immediately.
> - */
> -static void __slab_free(struct kmem_cache *s, struct slab *slab,
> -			void *head, void *tail, int cnt,
> -			unsigned long addr)
> -
> -{
> -	void *prior;
> -	int was_frozen;
> -	struct slab new;
> -	unsigned long counters;
> -	struct kmem_cache_node *n = NULL;
> -	unsigned long flags;
> -
> -	stat(s, FREE_SLOWPATH);
> -
> -	if (kfence_free(head))
> -		return;
> -
> -	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> -		free_to_partial_list(s, slab, head, tail, cnt, addr);
> -		return;
> -	}
> -
> -	do {
> -		if (unlikely(n)) {
> -			spin_unlock_irqrestore(&n->list_lock, flags);
> -			n = NULL;
> -		}
> -		prior = slab->freelist;
> -		counters = slab->counters;
> -		set_freepointer(s, tail, prior);
> -		new.counters = counters;
> -		was_frozen = new.frozen;
> -		new.inuse -= cnt;
> -		if ((!new.inuse || !prior) && !was_frozen) {
> -
> -			if (kmem_cache_has_cpu_partial(s) && !prior) {
> -
> -				/*
> -				 * Slab was on no list before and will be
> -				 * partially empty
> -				 * We can defer the list move and instead
> -				 * freeze it.
> -				 */
> -				new.frozen = 1;
> -
> -			} else { /* Needs to be taken off a list */
> -
> -				n = get_node(s, slab_nid(slab));
> -				/*
> -				 * Speculatively acquire the list_lock.
> -				 * If the cmpxchg does not succeed then we may
> -				 * drop the list_lock without any processing.
> -				 *
> -				 * Otherwise the list_lock will synchronize with
> -				 * other processors updating the list of slabs.
> -				 */
> -				spin_lock_irqsave(&n->list_lock, flags);
> -
> -			}
> -		}
> -
> -	} while (!cmpxchg_double_slab(s, slab,
> -		prior, counters,
> -		head, new.counters,
> -		"__slab_free"));
> -
> -	if (likely(!n)) {
> -
> -		if (likely(was_frozen)) {
> -			/*
> -			 * The list lock was not taken therefore no list
> -			 * activity can be necessary.
> -			 */
> -			stat(s, FREE_FROZEN);
> -		} else if (new.frozen) {
> -			/*
> -			 * If we just froze the slab then put it onto the
> -			 * per cpu partial list.
> -			 */
> -			put_cpu_partial(s, slab, 1);
> -			stat(s, CPU_PARTIAL_FREE);
> -		}
> -
> -		return;
> -	}
> -
> -	if (unlikely(!new.inuse && n->nr_partial >= s->min_partial))
> -		goto slab_empty;
> -
> -	/*
> -	 * Objects left in the slab. If it was not on the partial list before
> -	 * then add it.
> -	 */
> -	if (!kmem_cache_has_cpu_partial(s) && unlikely(!prior)) {
> -		remove_full(s, n, slab);
> -		add_partial(n, slab, DEACTIVATE_TO_TAIL);
> -		stat(s, FREE_ADD_PARTIAL);
> -	}
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> -	return;
> -
> -slab_empty:
> -	if (prior) {
> -		/*
> -		 * Slab on the partial list.
> -		 */
> -		remove_partial(n, slab);
> -		stat(s, FREE_REMOVE_PARTIAL);
> -	} else {
> -		/* Slab must be on the full list */
> -		remove_full(s, n, slab);
> -	}
> -
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> -	stat(s, FREE_SLAB);
> -	discard_slab(s, slab);
> -}
> -
> -#ifndef CONFIG_SLUB_TINY
> -/*
> - * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
> - * can perform fastpath freeing without additional function calls.
> - *
> - * The fastpath is only possible if we are freeing to the current cpu slab
> - * of this processor. This typically the case if we have just allocated
> - * the item before.
> - *
> - * If fastpath is not possible then fall back to __slab_free where we deal
> - * with all sorts of special processing.
> - *
> - * Bulk free of a freelist with several objects (all pointing to the
> - * same slab) possible by specifying head and tail ptr, plus objects
> - * count (cnt). Bulk free indicated by tail pointer being set.
> - */
> -static __always_inline void do_slab_free(struct kmem_cache *s,
> -				struct slab *slab, void *head, void *tail,
> -				int cnt, unsigned long addr)
> -{
> -	void *tail_obj = tail ? : head;
> -	struct kmem_cache_cpu *c;
> -	unsigned long tid;
> -	void **freelist;
> -
> -redo:
> -	/*
> -	 * Determine the currently cpus per cpu slab.
> -	 * The cpu may change afterward. However that does not matter since
> -	 * data is retrieved via this pointer. If we are on the same cpu
> -	 * during the cmpxchg then the free will succeed.
> -	 */
> -	c = raw_cpu_ptr(s->cpu_slab);
> -	tid = READ_ONCE(c->tid);
> -
> -	/* Same with comment on barrier() in slab_alloc_node() */
> -	barrier();
> -
> -	if (unlikely(slab != c->slab)) {
> -		__slab_free(s, slab, head, tail_obj, cnt, addr);
> -		return;
> -	}
> -
> -	if (USE_LOCKLESS_FAST_PATH()) {
> -		freelist = READ_ONCE(c->freelist);
> -
> -		set_freepointer(s, tail_obj, freelist);
> -
> -		if (unlikely(!this_cpu_cmpxchg_double(
> -				s->cpu_slab->freelist, s->cpu_slab->tid,
> -				freelist, tid,
> -				head, next_tid(tid)))) {
> -
> -			note_cmpxchg_failure("slab_free", s, tid);
> -			goto redo;
> -		}
> -	} else {
> -		/* Update the free list under the local lock */
> -		local_lock(&s->cpu_slab->lock);
> -		c = this_cpu_ptr(s->cpu_slab);
> -		if (unlikely(slab != c->slab)) {
> -			local_unlock(&s->cpu_slab->lock);
> -			goto redo;
> -		}
> -		tid = c->tid;
> -		freelist = c->freelist;
> -
> -		set_freepointer(s, tail_obj, freelist);
> -		c->freelist = head;
> -		c->tid = next_tid(tid);
> -
> -		local_unlock(&s->cpu_slab->lock);
> -	}
> -	stat(s, FREE_FASTPATH);
> -}
> -#else /* CONFIG_SLUB_TINY */
> -static void do_slab_free(struct kmem_cache *s,
> -				struct slab *slab, void *head, void *tail,
> -				int cnt, unsigned long addr)
> -{
> -	void *tail_obj = tail ? : head;
> -
> -	__slab_free(s, slab, head, tail_obj, cnt, addr);
> -}
> -#endif /* CONFIG_SLUB_TINY */
> -
> -static __fastpath_inline void slab_free(struct kmem_cache *s, struct slab *slab,
> -				      void *head, void *tail, void **p, int cnt,
> -				      unsigned long addr)
> -{
> -	memcg_slab_free_hook(s, slab, p, cnt);
> -	/*
> -	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
> -	 * to remove objects, whose reuse must be delayed.
> -	 */
> -	if (slab_free_freelist_hook(s, &head, &tail, &cnt))
> -		do_slab_free(s, slab, head, tail, cnt, addr);
> -}
> -
> -#ifdef CONFIG_KASAN_GENERIC
> -void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
> -{
> -	do_slab_free(cache, virt_to_slab(x), x, NULL, 1, addr);
> -}
> -#endif
> -
> -void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
> -{
> -	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
> -}
> -
> -void kmem_cache_free(struct kmem_cache *s, void *x)
> -{
> -	s = cache_from_obj(s, x);
> -	if (!s)
> -		return;
> -	trace_kmem_cache_free(_RET_IP_, x, s);
> -	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, _RET_IP_);
> -}
> -EXPORT_SYMBOL(kmem_cache_free);
> -
> -struct detached_freelist {
> -	struct slab *slab;
> -	void *tail;
> -	void *freelist;
> -	int cnt;
> -	struct kmem_cache *s;
> -};
> -
> -/*
> - * This function progressively scans the array with free objects (with
> - * a limited look ahead) and extract objects belonging to the same
> - * slab.  It builds a detached freelist directly within the given
> - * slab/objects.  This can happen without any need for
> - * synchronization, because the objects are owned by running process.
> - * The freelist is build up as a single linked list in the objects.
> - * The idea is, that this detached freelist can then be bulk
> - * transferred to the real freelist(s), but only requiring a single
> - * synchronization primitive.  Look ahead in the array is limited due
> - * to performance reasons.
> - */
> -static inline
> -int build_detached_freelist(struct kmem_cache *s, size_t size,
> -			    void **p, struct detached_freelist *df)
> -{
> -	int lookahead = 3;
> -	void *object;
> -	struct folio *folio;
> -	size_t same;
> -
> -	object = p[--size];
> -	folio = virt_to_folio(object);
> -	if (!s) {
> -		/* Handle kalloc'ed objects */
> -		if (unlikely(!folio_test_slab(folio))) {
> -			free_large_kmalloc(folio, object);
> -			df->slab = NULL;
> -			return size;
> -		}
> -		/* Derive kmem_cache from object */
> -		df->slab = folio_slab(folio);
> -		df->s = df->slab->slab_cache;
> -	} else {
> -		df->slab = folio_slab(folio);
> -		df->s = cache_from_obj(s, object); /* Support for memcg */
> -	}
> -
> -	/* Start new detached freelist */
> -	df->tail = object;
> -	df->freelist = object;
> -	df->cnt = 1;
> -
> -	if (is_kfence_address(object))
> -		return size;
> -
> -	set_freepointer(df->s, object, NULL);
> -
> -	same = size;
> -	while (size) {
> -		object = p[--size];
> -		/* df->slab is always set at this point */
> -		if (df->slab == virt_to_slab(object)) {
> -			/* Opportunity build freelist */
> -			set_freepointer(df->s, object, df->freelist);
> -			df->freelist = object;
> -			df->cnt++;
> -			same--;
> -			if (size != same)
> -				swap(p[size], p[same]);
> -			continue;
> -		}
> -
> -		/* Limit look ahead search */
> -		if (!--lookahead)
> -			break;
> -	}
> -
> -	return same;
> -}
> -
> -/* Note that interrupts must be enabled when calling this function. */
> -void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
> -{
> -	if (!size)
> -		return;
> -
> -	do {
> -		struct detached_freelist df;
> -
> -		size = build_detached_freelist(s, size, p, &df);
> -		if (!df.slab)
> -			continue;
> -
> -		slab_free(df.s, df.slab, df.freelist, df.tail, &p[size], df.cnt,
> -			  _RET_IP_);
> -	} while (likely(size));
> -}
> -EXPORT_SYMBOL(kmem_cache_free_bulk);
> -
> -#ifndef CONFIG_SLUB_TINY
> -static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> -			size_t size, void **p, struct obj_cgroup *objcg)
> -{
> -	struct kmem_cache_cpu *c;
> -	unsigned long irqflags;
> -	int i;
> -
> -	/*
> -	 * Drain objects in the per cpu slab, while disabling local
> -	 * IRQs, which protects against PREEMPT and interrupts
> -	 * handlers invoking normal fastpath.
> -	 */
> -	c = slub_get_cpu_ptr(s->cpu_slab);
> -	local_lock_irqsave(&s->cpu_slab->lock, irqflags);
> -
> -	for (i = 0; i < size; i++) {
> -		void *object = kfence_alloc(s, s->object_size, flags);
> -
> -		if (unlikely(object)) {
> -			p[i] = object;
> -			continue;
> -		}
> -
> -		object = c->freelist;
> -		if (unlikely(!object)) {
> -			/*
> -			 * We may have removed an object from c->freelist using
> -			 * the fastpath in the previous iteration; in that case,
> -			 * c->tid has not been bumped yet.
> -			 * Since ___slab_alloc() may reenable interrupts while
> -			 * allocating memory, we should bump c->tid now.
> -			 */
> -			c->tid = next_tid(c->tid);
> -
> -			local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
> -
> -			/*
> -			 * Invoking slow path likely have side-effect
> -			 * of re-populating per CPU c->freelist
> -			 */
> -			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
> -					    _RET_IP_, c, s->object_size);
> -			if (unlikely(!p[i]))
> -				goto error;
> -
> -			c = this_cpu_ptr(s->cpu_slab);
> -			maybe_wipe_obj_freeptr(s, p[i]);
> -
> -			local_lock_irqsave(&s->cpu_slab->lock, irqflags);
> -
> -			continue; /* goto for-loop */
> -		}
> -		c->freelist = get_freepointer(s, object);
> -		p[i] = object;
> -		maybe_wipe_obj_freeptr(s, p[i]);
> -	}
> -	c->tid = next_tid(c->tid);
> -	local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
> -	slub_put_cpu_ptr(s->cpu_slab);
> -
> -	return i;
> -
> -error:
> -	slub_put_cpu_ptr(s->cpu_slab);
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
> -	kmem_cache_free_bulk(s, i, p);
> -	return 0;
> -
> -}
> -#else /* CONFIG_SLUB_TINY */
> -static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> -			size_t size, void **p, struct obj_cgroup *objcg)
> -{
> -	int i;
> -
> -	for (i = 0; i < size; i++) {
> -		void *object = kfence_alloc(s, s->object_size, flags);
> -
> -		if (unlikely(object)) {
> -			p[i] = object;
> -			continue;
> -		}
> -
> -		p[i] = __slab_alloc_node(s, flags, NUMA_NO_NODE,
> -					 _RET_IP_, s->object_size);
> -		if (unlikely(!p[i]))
> -			goto error;
> -
> -		maybe_wipe_obj_freeptr(s, p[i]);
> -	}
> -
> -	return i;
> -
> -error:
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
> -	kmem_cache_free_bulk(s, i, p);
> -	return 0;
> -}
> -#endif /* CONFIG_SLUB_TINY */
> -
> -/* Note that interrupts must be enabled when calling this function. */
> -int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
> -			  void **p)
> -{
> -	int i;
> -	struct obj_cgroup *objcg = NULL;
> -
> -	if (!size)
> -		return 0;
> -
> -	/* memcg and kmem_cache debug support */
> -	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
> -	if (unlikely(!s))
> -		return 0;
> -
> -	i = __kmem_cache_alloc_bulk(s, flags, size, p, objcg);
> -
> -	/*
> -	 * memcg and kmem_cache debug support and memory initialization.
> -	 * Done outside of the IRQ disabled fastpath loop.
> -	 */
> -	if (i != 0)
> -		slab_post_alloc_hook(s, objcg, flags, size, p,
> -			slab_want_init_on_alloc(flags, s), s->object_size);
> -	return i;
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc_bulk);
> -
> -
> -/*
> - * Object placement in a slab is made very easy because we always start at
> - * offset 0. If we tune the size of the object to the alignment then we can
> - * get the required alignment by putting one properly sized object after
> - * another.
> - *
> - * Notice that the allocation order determines the sizes of the per cpu
> - * caches. Each processor has always one slab available for allocations.
> - * Increasing the allocation order reduces the number of times that slabs
> - * must be moved on and off the partial lists and is therefore a factor in
> - * locking overhead.
> - */
> -
> -/*
> - * Minimum / Maximum order of slab pages. This influences locking overhead
> - * and slab fragmentation. A higher order reduces the number of partial slabs
> - * and increases the number of allocations possible without having to
> - * take the list_lock.
> - */
> -static unsigned int slub_min_order;
> -static unsigned int slub_max_order =
> -	IS_ENABLED(CONFIG_SLUB_TINY) ? 1 : PAGE_ALLOC_COSTLY_ORDER;
> -static unsigned int slub_min_objects;
> -
> -/*
> - * Calculate the order of allocation given an slab object size.
> - *
> - * The order of allocation has significant impact on performance and other
> - * system components. Generally order 0 allocations should be preferred since
> - * order 0 does not cause fragmentation in the page allocator. Larger objects
> - * be problematic to put into order 0 slabs because there may be too much
> - * unused space left. We go to a higher order if more than 1/16th of the slab
> - * would be wasted.
> - *
> - * In order to reach satisfactory performance we must ensure that a minimum
> - * number of objects is in one slab. Otherwise we may generate too much
> - * activity on the partial lists which requires taking the list_lock. This is
> - * less a concern for large slabs though which are rarely used.
> - *
> - * slub_max_order specifies the order where we begin to stop considering the
> - * number of objects in a slab as critical. If we reach slub_max_order then
> - * we try to keep the page order as low as possible. So we accept more waste
> - * of space in favor of a small page order.
> - *
> - * Higher order allocations also allow the placement of more objects in a
> - * slab and thereby reduce object handling overhead. If the user has
> - * requested a higher minimum order then we start with that one instead of
> - * the smallest order which will fit the object.
> - */
> -static inline unsigned int calc_slab_order(unsigned int size,
> -		unsigned int min_objects, unsigned int max_order,
> -		unsigned int fract_leftover)
> -{
> -	unsigned int min_order = slub_min_order;
> -	unsigned int order;
> -
> -	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
> -		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
> -
> -	for (order = max(min_order, (unsigned int)get_order(min_objects * size));
> -			order <= max_order; order++) {
> -
> -		unsigned int slab_size = (unsigned int)PAGE_SIZE << order;
> -		unsigned int rem;
> -
> -		rem = slab_size % size;
> -
> -		if (rem <= slab_size / fract_leftover)
> -			break;
> -	}
> -
> -	return order;
> -}
> -
> -static inline int calculate_order(unsigned int size)
> -{
> -	unsigned int order;
> -	unsigned int min_objects;
> -	unsigned int max_objects;
> -	unsigned int nr_cpus;
> -
> -	/*
> -	 * Attempt to find best configuration for a slab. This
> -	 * works by first attempting to generate a layout with
> -	 * the best configuration and backing off gradually.
> -	 *
> -	 * First we increase the acceptable waste in a slab. Then
> -	 * we reduce the minimum objects required in a slab.
> -	 */
> -	min_objects = slub_min_objects;
> -	if (!min_objects) {
> -		/*
> -		 * Some architectures will only update present cpus when
> -		 * onlining them, so don't trust the number if it's just 1. But
> -		 * we also don't want to use nr_cpu_ids always, as on some other
> -		 * architectures, there can be many possible cpus, but never
> -		 * onlined. Here we compromise between trying to avoid too high
> -		 * order on systems that appear larger than they are, and too
> -		 * low order on systems that appear smaller than they are.
> -		 */
> -		nr_cpus = num_present_cpus();
> -		if (nr_cpus <= 1)
> -			nr_cpus = nr_cpu_ids;
> -		min_objects = 4 * (fls(nr_cpus) + 1);
> -	}
> -	max_objects = order_objects(slub_max_order, size);
> -	min_objects = min(min_objects, max_objects);
> -
> -	while (min_objects > 1) {
> -		unsigned int fraction;
> -
> -		fraction = 16;
> -		while (fraction >= 4) {
> -			order = calc_slab_order(size, min_objects,
> -					slub_max_order, fraction);
> -			if (order <= slub_max_order)
> -				return order;
> -			fraction /= 2;
> -		}
> -		min_objects--;
> -	}
> -
> -	/*
> -	 * We were unable to place multiple objects in a slab. Now
> -	 * lets see if we can place a single object there.
> -	 */
> -	order = calc_slab_order(size, 1, slub_max_order, 1);
> -	if (order <= slub_max_order)
> -		return order;
> -
> -	/*
> -	 * Doh this slab cannot be placed using slub_max_order.
> -	 */
> -	order = calc_slab_order(size, 1, MAX_ORDER, 1);
> -	if (order < MAX_ORDER)
> -		return order;
> -	return -ENOSYS;
> -}
> -
> -static void
> -init_kmem_cache_node(struct kmem_cache_node *n)
> -{
> -	n->nr_partial = 0;
> -	spin_lock_init(&n->list_lock);
> -	INIT_LIST_HEAD(&n->partial);
> -#ifdef CONFIG_SLUB_DEBUG
> -	atomic_long_set(&n->nr_slabs, 0);
> -	atomic_long_set(&n->total_objects, 0);
> -	INIT_LIST_HEAD(&n->full);
> -#endif
> -}
> -
> -#ifndef CONFIG_SLUB_TINY
> -static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
> -{
> -	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
> -			NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *
> -			sizeof(struct kmem_cache_cpu));
> -
> -	/*
> -	 * Must align to double word boundary for the double cmpxchg
> -	 * instructions to work; see __pcpu_double_call_return_bool().
> -	 */
> -	s->cpu_slab = __alloc_percpu(sizeof(struct kmem_cache_cpu),
> -				     2 * sizeof(void *));
> -
> -	if (!s->cpu_slab)
> -		return 0;
> -
> -	init_kmem_cache_cpus(s);
> -
> -	return 1;
> -}
> -#else
> -static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
> -{
> -	return 1;
> -}
> -#endif /* CONFIG_SLUB_TINY */
> -
> -static struct kmem_cache *kmem_cache_node;
> -
> -/*
> - * No kmalloc_node yet so do it by hand. We know that this is the first
> - * slab on the node for this slabcache. There are no concurrent accesses
> - * possible.
> - *
> - * Note that this function only works on the kmem_cache_node
> - * when allocating for the kmem_cache_node. This is used for bootstrapping
> - * memory on a fresh node that has no slab structures yet.
> - */
> -static void early_kmem_cache_node_alloc(int node)
> -{
> -	struct slab *slab;
> -	struct kmem_cache_node *n;
> -
> -	BUG_ON(kmem_cache_node->size < sizeof(struct kmem_cache_node));
> -
> -	slab = new_slab(kmem_cache_node, GFP_NOWAIT, node);
> -
> -	BUG_ON(!slab);
> -	inc_slabs_node(kmem_cache_node, slab_nid(slab), slab->objects);
> -	if (slab_nid(slab) != node) {
> -		pr_err("SLUB: Unable to allocate memory from node %d\n", node);
> -		pr_err("SLUB: Allocating a useless per node structure in order to be able to continue\n");
> -	}
> -
> -	n = slab->freelist;
> -	BUG_ON(!n);
> -#ifdef CONFIG_SLUB_DEBUG
> -	init_object(kmem_cache_node, n, SLUB_RED_ACTIVE);
> -	init_tracking(kmem_cache_node, n);
> -#endif
> -	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL, false);
> -	slab->freelist = get_freepointer(kmem_cache_node, n);
> -	slab->inuse = 1;
> -	kmem_cache_node->node[node] = n;
> -	init_kmem_cache_node(n);
> -	inc_slabs_node(kmem_cache_node, node, slab->objects);
> -
> -	/*
> -	 * No locks need to be taken here as it has just been
> -	 * initialized and there is no concurrent access.
> -	 */
> -	__add_partial(n, slab, DEACTIVATE_TO_HEAD);
> -}
> -
> -static void free_kmem_cache_nodes(struct kmem_cache *s)
> -{
> -	int node;
> -	struct kmem_cache_node *n;
> -
> -	for_each_kmem_cache_node(s, node, n) {
> -		s->node[node] = NULL;
> -		kmem_cache_free(kmem_cache_node, n);
> -	}
> -}
> -
> -void __kmem_cache_release(struct kmem_cache *s)
> -{
> -	cache_random_seq_destroy(s);
> -#ifndef CONFIG_SLUB_TINY
> -	free_percpu(s->cpu_slab);
> -#endif
> -	free_kmem_cache_nodes(s);
> -}
> -
> -static int init_kmem_cache_nodes(struct kmem_cache *s)
> -{
> -	int node;
> -
> -	for_each_node_mask(node, slab_nodes) {
> -		struct kmem_cache_node *n;
> -
> -		if (slab_state == DOWN) {
> -			early_kmem_cache_node_alloc(node);
> -			continue;
> -		}
> -		n = kmem_cache_alloc_node(kmem_cache_node,
> -						GFP_KERNEL, node);
> -
> -		if (!n) {
> -			free_kmem_cache_nodes(s);
> -			return 0;
> -		}
> -
> -		init_kmem_cache_node(n);
> -		s->node[node] = n;
> -	}
> -	return 1;
> -}
> -
> -static void set_cpu_partial(struct kmem_cache *s)
> -{
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -	unsigned int nr_objects;
> -
> -	/*
> -	 * cpu_partial determined the maximum number of objects kept in the
> -	 * per cpu partial lists of a processor.
> -	 *
> -	 * Per cpu partial lists mainly contain slabs that just have one
> -	 * object freed. If they are used for allocation then they can be
> -	 * filled up again with minimal effort. The slab will never hit the
> -	 * per node partial lists and therefore no locking will be required.
> -	 *
> -	 * For backwards compatibility reasons, this is determined as number
> -	 * of objects, even though we now limit maximum number of pages, see
> -	 * slub_set_cpu_partial()
> -	 */
> -	if (!kmem_cache_has_cpu_partial(s))
> -		nr_objects = 0;
> -	else if (s->size >= PAGE_SIZE)
> -		nr_objects = 6;
> -	else if (s->size >= 1024)
> -		nr_objects = 24;
> -	else if (s->size >= 256)
> -		nr_objects = 52;
> -	else
> -		nr_objects = 120;
> -
> -	slub_set_cpu_partial(s, nr_objects);
> -#endif
> -}
> -
> -/*
> - * calculate_sizes() determines the order and the distribution of data within
> - * a slab object.
> - */
> -static int calculate_sizes(struct kmem_cache *s)
> -{
> -	slab_flags_t flags = s->flags;
> -	unsigned int size = s->object_size;
> -	unsigned int order;
> -
> -	/*
> -	 * Round up object size to the next word boundary. We can only
> -	 * place the free pointer at word boundaries and this determines
> -	 * the possible location of the free pointer.
> -	 */
> -	size = ALIGN(size, sizeof(void *));
> -
> -#ifdef CONFIG_SLUB_DEBUG
> -	/*
> -	 * Determine if we can poison the object itself. If the user of
> -	 * the slab may touch the object after free or before allocation
> -	 * then we should never poison the object itself.
> -	 */
> -	if ((flags & SLAB_POISON) && !(flags & SLAB_TYPESAFE_BY_RCU) &&
> -			!s->ctor)
> -		s->flags |= __OBJECT_POISON;
> -	else
> -		s->flags &= ~__OBJECT_POISON;
> -
> -
> -	/*
> -	 * If we are Redzoning then check if there is some space between the
> -	 * end of the object and the free pointer. If not then add an
> -	 * additional word to have some bytes to store Redzone information.
> -	 */
> -	if ((flags & SLAB_RED_ZONE) && size == s->object_size)
> -		size += sizeof(void *);
> -#endif
> -
> -	/*
> -	 * With that we have determined the number of bytes in actual use
> -	 * by the object and redzoning.
> -	 */
> -	s->inuse = size;
> -
> -	if (slub_debug_orig_size(s) ||
> -	    (flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
> -	    ((flags & SLAB_RED_ZONE) && s->object_size < sizeof(void *)) ||
> -	    s->ctor) {
> -		/*
> -		 * Relocate free pointer after the object if it is not
> -		 * permitted to overwrite the first word of the object on
> -		 * kmem_cache_free.
> -		 *
> -		 * This is the case if we do RCU, have a constructor or
> -		 * destructor, are poisoning the objects, or are
> -		 * redzoning an object smaller than sizeof(void *).
> -		 *
> -		 * The assumption that s->offset >= s->inuse means free
> -		 * pointer is outside of the object is used in the
> -		 * freeptr_outside_object() function. If that is no
> -		 * longer true, the function needs to be modified.
> -		 */
> -		s->offset = size;
> -		size += sizeof(void *);
> -	} else {
> -		/*
> -		 * Store freelist pointer near middle of object to keep
> -		 * it away from the edges of the object to avoid small
> -		 * sized over/underflows from neighboring allocations.
> -		 */
> -		s->offset = ALIGN_DOWN(s->object_size / 2, sizeof(void *));
> -	}
> -
> -#ifdef CONFIG_SLUB_DEBUG
> -	if (flags & SLAB_STORE_USER) {
> -		/*
> -		 * Need to store information about allocs and frees after
> -		 * the object.
> -		 */
> -		size += 2 * sizeof(struct track);
> -
> -		/* Save the original kmalloc request size */
> -		if (flags & SLAB_KMALLOC)
> -			size += sizeof(unsigned int);
> -	}
> -#endif
> -
> -	kasan_cache_create(s, &size, &s->flags);
> -#ifdef CONFIG_SLUB_DEBUG
> -	if (flags & SLAB_RED_ZONE) {
> -		/*
> -		 * Add some empty padding so that we can catch
> -		 * overwrites from earlier objects rather than let
> -		 * tracking information or the free pointer be
> -		 * corrupted if a user writes before the start
> -		 * of the object.
> -		 */
> -		size += sizeof(void *);
> -
> -		s->red_left_pad = sizeof(void *);
> -		s->red_left_pad = ALIGN(s->red_left_pad, s->align);
> -		size += s->red_left_pad;
> -	}
> -#endif
> -
> -	/*
> -	 * SLUB stores one object immediately after another beginning from
> -	 * offset 0. In order to align the objects we have to simply size
> -	 * each object to conform to the alignment.
> -	 */
> -	size = ALIGN(size, s->align);
> -	s->size = size;
> -	s->reciprocal_size = reciprocal_value(size);
> -	order = calculate_order(size);
> -
> -	if ((int)order < 0)
> -		return 0;
> -
> -	s->allocflags = 0;
> -	if (order)
> -		s->allocflags |= __GFP_COMP;
> -
> -	if (s->flags & SLAB_CACHE_DMA)
> -		s->allocflags |= GFP_DMA;
> -
> -	if (s->flags & SLAB_CACHE_DMA32)
> -		s->allocflags |= GFP_DMA32;
> -
> -	if (s->flags & SLAB_RECLAIM_ACCOUNT)
> -		s->allocflags |= __GFP_RECLAIMABLE;
> -
> -	/*
> -	 * Determine the number of objects per slab
> -	 */
> -	s->oo = oo_make(order, size);
> -	s->min = oo_make(get_order(size), size);
> -
> -	return !!oo_objects(s->oo);
> -}
> -
> -static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> -{
> -	s->flags = kmem_cache_flags(s->size, flags, s->name);
> -#ifdef CONFIG_SLAB_FREELIST_HARDENED
> -	s->random = get_random_long();
> -#endif
> -
> -	if (!calculate_sizes(s))
> -		goto error;
> -	if (disable_higher_order_debug) {
> -		/*
> -		 * Disable debugging flags that store metadata if the min slab
> -		 * order increased.
> -		 */
> -		if (get_order(s->size) > get_order(s->object_size)) {
> -			s->flags &= ~DEBUG_METADATA_FLAGS;
> -			s->offset = 0;
> -			if (!calculate_sizes(s))
> -				goto error;
> -		}
> -	}
> -
> -#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
> -    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
> -	if (system_has_cmpxchg_double() && (s->flags & SLAB_NO_CMPXCHG) == 0)
> -		/* Enable fast mode */
> -		s->flags |= __CMPXCHG_DOUBLE;
> -#endif
> -
> -	/*
> -	 * The larger the object size is, the more slabs we want on the partial
> -	 * list to avoid pounding the page allocator excessively.
> -	 */
> -	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
> -	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
> -
> -	set_cpu_partial(s);
> -
> -#ifdef CONFIG_NUMA
> -	s->remote_node_defrag_ratio = 1000;
> -#endif
> -
> -	/* Initialize the pre-computed randomized freelist if slab is up */
> -	if (slab_state >= UP) {
> -		if (init_cache_random_seq(s))
> -			goto error;
> -	}
> -
> -	if (!init_kmem_cache_nodes(s))
> -		goto error;
> -
> -	if (alloc_kmem_cache_cpus(s))
> -		return 0;
> -
> -error:
> -	__kmem_cache_release(s);
> -	return -EINVAL;
> -}
> -
> -static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
> -			      const char *text)
> -{
> -#ifdef CONFIG_SLUB_DEBUG
> -	void *addr = slab_address(slab);
> -	void *p;
> -
> -	slab_err(s, slab, text, s->name);
> -
> -	spin_lock(&object_map_lock);
> -	__fill_map(object_map, s, slab);
> -
> -	for_each_object(p, s, addr, slab->objects) {
> -
> -		if (!test_bit(__obj_to_index(s, addr, p), object_map)) {
> -			pr_err("Object 0x%p @offset=%tu\n", p, p - addr);
> -			print_tracking(s, p);
> -		}
> -	}
> -	spin_unlock(&object_map_lock);
> -#endif
> -}
> -
> -/*
> - * Attempt to free all partial slabs on a node.
> - * This is called from __kmem_cache_shutdown(). We must take list_lock
> - * because sysfs file might still access partial list after the shutdowning.
> - */
> -static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
> -{
> -	LIST_HEAD(discard);
> -	struct slab *slab, *h;
> -
> -	BUG_ON(irqs_disabled());
> -	spin_lock_irq(&n->list_lock);
> -	list_for_each_entry_safe(slab, h, &n->partial, slab_list) {
> -		if (!slab->inuse) {
> -			remove_partial(n, slab);
> -			list_add(&slab->slab_list, &discard);
> -		} else {
> -			list_slab_objects(s, slab,
> -			  "Objects remaining in %s on __kmem_cache_shutdown()");
> -		}
> -	}
> -	spin_unlock_irq(&n->list_lock);
> -
> -	list_for_each_entry_safe(slab, h, &discard, slab_list)
> -		discard_slab(s, slab);
> -}
> -
> -bool __kmem_cache_empty(struct kmem_cache *s)
> -{
> -	int node;
> -	struct kmem_cache_node *n;
> -
> -	for_each_kmem_cache_node(s, node, n)
> -		if (n->nr_partial || slabs_node(s, node))
> -			return false;
> -	return true;
> -}
> -
> -/*
> - * Release all resources used by a slab cache.
> - */
> -int __kmem_cache_shutdown(struct kmem_cache *s)
> -{
> -	int node;
> -	struct kmem_cache_node *n;
> -
> -	flush_all_cpus_locked(s);
> -	/* Attempt to free all objects */
> -	for_each_kmem_cache_node(s, node, n) {
> -		free_partial(s, n);
> -		if (n->nr_partial || slabs_node(s, node))
> -			return 1;
> -	}
> -	return 0;
> -}
> -
> -#ifdef CONFIG_PRINTK
> -void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
> -{
> -	void *base;
> -	int __maybe_unused i;
> -	unsigned int objnr;
> -	void *objp;
> -	void *objp0;
> -	struct kmem_cache *s = slab->slab_cache;
> -	struct track __maybe_unused *trackp;
> -
> -	kpp->kp_ptr = object;
> -	kpp->kp_slab = slab;
> -	kpp->kp_slab_cache = s;
> -	base = slab_address(slab);
> -	objp0 = kasan_reset_tag(object);
> -#ifdef CONFIG_SLUB_DEBUG
> -	objp = restore_red_left(s, objp0);
> -#else
> -	objp = objp0;
> -#endif
> -	objnr = obj_to_index(s, slab, objp);
> -	kpp->kp_data_offset = (unsigned long)((char *)objp0 - (char *)objp);
> -	objp = base + s->size * objnr;
> -	kpp->kp_objp = objp;
> -	if (WARN_ON_ONCE(objp < base || objp >= base + slab->objects * s->size
> -			 || (objp - base) % s->size) ||
> -	    !(s->flags & SLAB_STORE_USER))
> -		return;
> -#ifdef CONFIG_SLUB_DEBUG
> -	objp = fixup_red_left(s, objp);
> -	trackp = get_track(s, objp, TRACK_ALLOC);
> -	kpp->kp_ret = (void *)trackp->addr;
> -#ifdef CONFIG_STACKDEPOT
> -	{
> -		depot_stack_handle_t handle;
> -		unsigned long *entries;
> -		unsigned int nr_entries;
> -
> -		handle = READ_ONCE(trackp->handle);
> -		if (handle) {
> -			nr_entries = stack_depot_fetch(handle, &entries);
> -			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
> -				kpp->kp_stack[i] = (void *)entries[i];
> -		}
> -
> -		trackp = get_track(s, objp, TRACK_FREE);
> -		handle = READ_ONCE(trackp->handle);
> -		if (handle) {
> -			nr_entries = stack_depot_fetch(handle, &entries);
> -			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
> -				kpp->kp_free_stack[i] = (void *)entries[i];
> -		}
> -	}
> -#endif
> -#endif
> -}
> -#endif
> -
> -/********************************************************************
> - *		Kmalloc subsystem
> - *******************************************************************/
> -
> -static int __init setup_slub_min_order(char *str)
> -{
> -	get_option(&str, (int *)&slub_min_order);
> -
> -	return 1;
> -}
> -
> -__setup("slub_min_order=", setup_slub_min_order);
> -
> -static int __init setup_slub_max_order(char *str)
> -{
> -	get_option(&str, (int *)&slub_max_order);
> -	slub_max_order = min(slub_max_order, (unsigned int)MAX_ORDER - 1);
> -
> -	return 1;
> -}
> -
> -__setup("slub_max_order=", setup_slub_max_order);
> -
> -static int __init setup_slub_min_objects(char *str)
> -{
> -	get_option(&str, (int *)&slub_min_objects);
> -
> -	return 1;
> -}
> -
> -__setup("slub_min_objects=", setup_slub_min_objects);
> -
> -#ifdef CONFIG_HARDENED_USERCOPY
> -/*
> - * Rejects incorrectly sized objects and objects that are to be copied
> - * to/from userspace but do not fall entirely within the containing slab
> - * cache's usercopy region.
> - *
> - * Returns NULL if check passes, otherwise const char * to name of cache
> - * to indicate an error.
> - */
> -void __check_heap_object(const void *ptr, unsigned long n,
> -			 const struct slab *slab, bool to_user)
> -{
> -	struct kmem_cache *s;
> -	unsigned int offset;
> -	bool is_kfence = is_kfence_address(ptr);
> -
> -	ptr = kasan_reset_tag(ptr);
> -
> -	/* Find object and usable object size. */
> -	s = slab->slab_cache;
> -
> -	/* Reject impossible pointers. */
> -	if (ptr < slab_address(slab))
> -		usercopy_abort("SLUB object not in SLUB page?!", NULL,
> -			       to_user, 0, n);
> -
> -	/* Find offset within object. */
> -	if (is_kfence)
> -		offset = ptr - kfence_object_start(ptr);
> -	else
> -		offset = (ptr - slab_address(slab)) % s->size;
> -
> -	/* Adjust for redzone and reject if within the redzone. */
> -	if (!is_kfence && kmem_cache_debug_flags(s, SLAB_RED_ZONE)) {
> -		if (offset < s->red_left_pad)
> -			usercopy_abort("SLUB object in left red zone",
> -				       s->name, to_user, offset, n);
> -		offset -= s->red_left_pad;
> -	}
> -
> -	/* Allow address range falling entirely within usercopy region. */
> -	if (offset >= s->useroffset &&
> -	    offset - s->useroffset <= s->usersize &&
> -	    n <= s->useroffset - offset + s->usersize)
> -		return;
> -
> -	usercopy_abort("SLUB object", s->name, to_user, offset, n);
> -}
> -#endif /* CONFIG_HARDENED_USERCOPY */
> -
> -#define SHRINK_PROMOTE_MAX 32
> -
> -/*
> - * kmem_cache_shrink discards empty slabs and promotes the slabs filled
> - * up most to the head of the partial lists. New allocations will then
> - * fill those up and thus they can be removed from the partial lists.
> - *
> - * The slabs with the least items are placed last. This results in them
> - * being allocated from last increasing the chance that the last objects
> - * are freed in them.
> - */
> -static int __kmem_cache_do_shrink(struct kmem_cache *s)
> -{
> -	int node;
> -	int i;
> -	struct kmem_cache_node *n;
> -	struct slab *slab;
> -	struct slab *t;
> -	struct list_head discard;
> -	struct list_head promote[SHRINK_PROMOTE_MAX];
> -	unsigned long flags;
> -	int ret = 0;
> -
> -	for_each_kmem_cache_node(s, node, n) {
> -		INIT_LIST_HEAD(&discard);
> -		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
> -			INIT_LIST_HEAD(promote + i);
> -
> -		spin_lock_irqsave(&n->list_lock, flags);
> -
> -		/*
> -		 * Build lists of slabs to discard or promote.
> -		 *
> -		 * Note that concurrent frees may occur while we hold the
> -		 * list_lock. slab->inuse here is the upper limit.
> -		 */
> -		list_for_each_entry_safe(slab, t, &n->partial, slab_list) {
> -			int free = slab->objects - slab->inuse;
> -
> -			/* Do not reread slab->inuse */
> -			barrier();
> -
> -			/* We do not keep full slabs on the list */
> -			BUG_ON(free <= 0);
> -
> -			if (free == slab->objects) {
> -				list_move(&slab->slab_list, &discard);
> -				n->nr_partial--;
> -				dec_slabs_node(s, node, slab->objects);
> -			} else if (free <= SHRINK_PROMOTE_MAX)
> -				list_move(&slab->slab_list, promote + free - 1);
> -		}
> -
> -		/*
> -		 * Promote the slabs filled up most to the head of the
> -		 * partial list.
> -		 */
> -		for (i = SHRINK_PROMOTE_MAX - 1; i >= 0; i--)
> -			list_splice(promote + i, &n->partial);
> -
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> -
> -		/* Release empty slabs */
> -		list_for_each_entry_safe(slab, t, &discard, slab_list)
> -			free_slab(s, slab);
> -
> -		if (slabs_node(s, node))
> -			ret = 1;
> -	}
> -
> -	return ret;
> -}
> -
> -int __kmem_cache_shrink(struct kmem_cache *s)
> -{
> -	flush_all(s);
> -	return __kmem_cache_do_shrink(s);
> -}
> -
> -static int slab_mem_going_offline_callback(void *arg)
> -{
> -	struct kmem_cache *s;
> -
> -	mutex_lock(&slab_mutex);
> -	list_for_each_entry(s, &slab_caches, list) {
> -		flush_all_cpus_locked(s);
> -		__kmem_cache_do_shrink(s);
> -	}
> -	mutex_unlock(&slab_mutex);
> -
> -	return 0;
> -}
> -
> -static void slab_mem_offline_callback(void *arg)
> -{
> -	struct memory_notify *marg = arg;
> -	int offline_node;
> -
> -	offline_node = marg->status_change_nid_normal;
> -
> -	/*
> -	 * If the node still has available memory. we need kmem_cache_node
> -	 * for it yet.
> -	 */
> -	if (offline_node < 0)
> -		return;
> -
> -	mutex_lock(&slab_mutex);
> -	node_clear(offline_node, slab_nodes);
> -	/*
> -	 * We no longer free kmem_cache_node structures here, as it would be
> -	 * racy with all get_node() users, and infeasible to protect them with
> -	 * slab_mutex.
> -	 */
> -	mutex_unlock(&slab_mutex);
> -}
> -
> -static int slab_mem_going_online_callback(void *arg)
> -{
> -	struct kmem_cache_node *n;
> -	struct kmem_cache *s;
> -	struct memory_notify *marg = arg;
> -	int nid = marg->status_change_nid_normal;
> -	int ret = 0;
> -
> -	/*
> -	 * If the node's memory is already available, then kmem_cache_node is
> -	 * already created. Nothing to do.
> -	 */
> -	if (nid < 0)
> -		return 0;
> -
> -	/*
> -	 * We are bringing a node online. No memory is available yet. We must
> -	 * allocate a kmem_cache_node structure in order to bring the node
> -	 * online.
> -	 */
> -	mutex_lock(&slab_mutex);
> -	list_for_each_entry(s, &slab_caches, list) {
> -		/*
> -		 * The structure may already exist if the node was previously
> -		 * onlined and offlined.
> -		 */
> -		if (get_node(s, nid))
> -			continue;
> -		/*
> -		 * XXX: kmem_cache_alloc_node will fallback to other nodes
> -		 *      since memory is not yet available from the node that
> -		 *      is brought up.
> -		 */
> -		n = kmem_cache_alloc(kmem_cache_node, GFP_KERNEL);
> -		if (!n) {
> -			ret = -ENOMEM;
> -			goto out;
> -		}
> -		init_kmem_cache_node(n);
> -		s->node[nid] = n;
> -	}
> -	/*
> -	 * Any cache created after this point will also have kmem_cache_node
> -	 * initialized for the new node.
> -	 */
> -	node_set(nid, slab_nodes);
> -out:
> -	mutex_unlock(&slab_mutex);
> -	return ret;
> -}
> -
> -static int slab_memory_callback(struct notifier_block *self,
> -				unsigned long action, void *arg)
> -{
> -	int ret = 0;
> -
> -	switch (action) {
> -	case MEM_GOING_ONLINE:
> -		ret = slab_mem_going_online_callback(arg);
> -		break;
> -	case MEM_GOING_OFFLINE:
> -		ret = slab_mem_going_offline_callback(arg);
> -		break;
> -	case MEM_OFFLINE:
> -	case MEM_CANCEL_ONLINE:
> -		slab_mem_offline_callback(arg);
> -		break;
> -	case MEM_ONLINE:
> -	case MEM_CANCEL_OFFLINE:
> -		break;
> -	}
> -	if (ret)
> -		ret = notifier_from_errno(ret);
> -	else
> -		ret = NOTIFY_OK;
> -	return ret;
> -}
> -
> -/********************************************************************
> - *			Basic setup of slabs
> - *******************************************************************/
> -
> -/*
> - * Used for early kmem_cache structures that were allocated using
> - * the page allocator. Allocate them properly then fix up the pointers
> - * that may be pointing to the wrong kmem_cache structure.
> - */
> -
> -static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
> -{
> -	int node;
> -	struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);
> -	struct kmem_cache_node *n;
> -
> -	memcpy(s, static_cache, kmem_cache->object_size);
> -
> -	/*
> -	 * This runs very early, and only the boot processor is supposed to be
> -	 * up.  Even if it weren't true, IRQs are not up so we couldn't fire
> -	 * IPIs around.
> -	 */
> -	__flush_cpu_slab(s, smp_processor_id());
> -	for_each_kmem_cache_node(s, node, n) {
> -		struct slab *p;
> -
> -		list_for_each_entry(p, &n->partial, slab_list)
> -			p->slab_cache = s;
> -
> -#ifdef CONFIG_SLUB_DEBUG
> -		list_for_each_entry(p, &n->full, slab_list)
> -			p->slab_cache = s;
> -#endif
> -	}
> -	list_add(&s->list, &slab_caches);
> -	return s;
> -}
> -
> -void __init kmem_cache_init(void)
> -{
> -	static __initdata struct kmem_cache boot_kmem_cache,
> -		boot_kmem_cache_node;
> -	int node;
> -
> -	if (debug_guardpage_minorder())
> -		slub_max_order = 0;
> -
> -	/* Print slub debugging pointers without hashing */
> -	if (__slub_debug_enabled())
> -		no_hash_pointers_enable(NULL);
> -
> -	kmem_cache_node = &boot_kmem_cache_node;
> -	kmem_cache = &boot_kmem_cache;
> -
> -	/*
> -	 * Initialize the nodemask for which we will allocate per node
> -	 * structures. Here we don't need taking slab_mutex yet.
> -	 */
> -	for_each_node_state(node, N_NORMAL_MEMORY)
> -		node_set(node, slab_nodes);
> -
> -	create_boot_cache(kmem_cache_node, "kmem_cache_node",
> -		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
> -
> -	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
> -
> -	/* Able to allocate the per node structures */
> -	slab_state = PARTIAL;
> -
> -	create_boot_cache(kmem_cache, "kmem_cache",
> -			offsetof(struct kmem_cache, node) +
> -				nr_node_ids * sizeof(struct kmem_cache_node *),
> -		       SLAB_HWCACHE_ALIGN, 0, 0);
> -
> -	kmem_cache = bootstrap(&boot_kmem_cache);
> -	kmem_cache_node = bootstrap(&boot_kmem_cache_node);
> -
> -	/* Now we can use the kmem_cache to allocate kmalloc slabs */
> -	setup_kmalloc_cache_index_table();
> -	create_kmalloc_caches(0);
> -
> -	/* Setup random freelists for each cache */
> -	init_freelist_randomization();
> -
> -	cpuhp_setup_state_nocalls(CPUHP_SLUB_DEAD, "slub:dead", NULL,
> -				  slub_cpu_dead);
> -
> -	pr_info("SLUB: HWalign=%d, Order=%u-%u, MinObjects=%u, CPUs=%u, Nodes=%u\n",
> -		cache_line_size(),
> -		slub_min_order, slub_max_order, slub_min_objects,
> -		nr_cpu_ids, nr_node_ids);
> -}
> -
> -void __init kmem_cache_init_late(void)
> -{
> -#ifndef CONFIG_SLUB_TINY
> -	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM, 0);
> -	WARN_ON(!flushwq);
> -#endif
> -}
> -
> -struct kmem_cache *
> -__kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
> -		   slab_flags_t flags, void (*ctor)(void *))
> -{
> -	struct kmem_cache *s;
> -
> -	s = find_mergeable(size, align, flags, name, ctor);
> -	if (s) {
> -		if (sysfs_slab_alias(s, name))
> -			return NULL;
> -
> -		s->refcount++;
> -
> -		/*
> -		 * Adjust the object sizes so that we clear
> -		 * the complete object on kzalloc.
> -		 */
> -		s->object_size = max(s->object_size, size);
> -		s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
> -	}
> -
> -	return s;
> -}
> -
> -int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
> -{
> -	int err;
> -
> -	err = kmem_cache_open(s, flags);
> -	if (err)
> -		return err;
> -
> -	/* Mutex is not taken during early boot */
> -	if (slab_state <= UP)
> -		return 0;
> -
> -	err = sysfs_slab_add(s);
> -	if (err) {
> -		__kmem_cache_release(s);
> -		return err;
> -	}
> -
> -	if (s->flags & SLAB_STORE_USER)
> -		debugfs_slab_add(s);
> -
> -	return 0;
> -}
> -
> -#ifdef SLAB_SUPPORTS_SYSFS
> -static int count_inuse(struct slab *slab)
> -{
> -	return slab->inuse;
> -}
> -
> -static int count_total(struct slab *slab)
> -{
> -	return slab->objects;
> -}
> -#endif
> -
> -#ifdef CONFIG_SLUB_DEBUG
> -static void validate_slab(struct kmem_cache *s, struct slab *slab,
> -			  unsigned long *obj_map)
> -{
> -	void *p;
> -	void *addr = slab_address(slab);
> -
> -	if (!check_slab(s, slab) || !on_freelist(s, slab, NULL))
> -		return;
> -
> -	/* Now we know that a valid freelist exists */
> -	__fill_map(obj_map, s, slab);
> -	for_each_object(p, s, addr, slab->objects) {
> -		u8 val = test_bit(__obj_to_index(s, addr, p), obj_map) ?
> -			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
> -
> -		if (!check_object(s, slab, p, val))
> -			break;
> -	}
> -}
> -
> -static int validate_slab_node(struct kmem_cache *s,
> -		struct kmem_cache_node *n, unsigned long *obj_map)
> -{
> -	unsigned long count = 0;
> -	struct slab *slab;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&n->list_lock, flags);
> -
> -	list_for_each_entry(slab, &n->partial, slab_list) {
> -		validate_slab(s, slab, obj_map);
> -		count++;
> -	}
> -	if (count != n->nr_partial) {
> -		pr_err("SLUB %s: %ld partial slabs counted but counter=%ld\n",
> -		       s->name, count, n->nr_partial);
> -		slab_add_kunit_errors();
> -	}
> -
> -	if (!(s->flags & SLAB_STORE_USER))
> -		goto out;
> -
> -	list_for_each_entry(slab, &n->full, slab_list) {
> -		validate_slab(s, slab, obj_map);
> -		count++;
> -	}
> -	if (count != atomic_long_read(&n->nr_slabs)) {
> -		pr_err("SLUB: %s %ld slabs counted but counter=%ld\n",
> -		       s->name, count, atomic_long_read(&n->nr_slabs));
> -		slab_add_kunit_errors();
> -	}
> -
> -out:
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> -	return count;
> -}
> -
> -long validate_slab_cache(struct kmem_cache *s)
> -{
> -	int node;
> -	unsigned long count = 0;
> -	struct kmem_cache_node *n;
> -	unsigned long *obj_map;
> -
> -	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
> -	if (!obj_map)
> -		return -ENOMEM;
> -
> -	flush_all(s);
> -	for_each_kmem_cache_node(s, node, n)
> -		count += validate_slab_node(s, n, obj_map);
> -
> -	bitmap_free(obj_map);
> -
> -	return count;
> -}
> -EXPORT_SYMBOL(validate_slab_cache);
> -
> -#ifdef CONFIG_DEBUG_FS
> -/*
> - * Generate lists of code addresses where slabcache objects are allocated
> - * and freed.
> - */
> -
> -struct location {
> -	depot_stack_handle_t handle;
> -	unsigned long count;
> -	unsigned long addr;
> -	unsigned long waste;
> -	long long sum_time;
> -	long min_time;
> -	long max_time;
> -	long min_pid;
> -	long max_pid;
> -	DECLARE_BITMAP(cpus, NR_CPUS);
> -	nodemask_t nodes;
> -};
> -
> -struct loc_track {
> -	unsigned long max;
> -	unsigned long count;
> -	struct location *loc;
> -	loff_t idx;
> -};
> -
> -static struct dentry *slab_debugfs_root;
> -
> -static void free_loc_track(struct loc_track *t)
> -{
> -	if (t->max)
> -		free_pages((unsigned long)t->loc,
> -			get_order(sizeof(struct location) * t->max));
> -}
> -
> -static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
> -{
> -	struct location *l;
> -	int order;
> -
> -	order = get_order(sizeof(struct location) * max);
> -
> -	l = (void *)__get_free_pages(flags, order);
> -	if (!l)
> -		return 0;
> -
> -	if (t->count) {
> -		memcpy(l, t->loc, sizeof(struct location) * t->count);
> -		free_loc_track(t);
> -	}
> -	t->max = max;
> -	t->loc = l;
> -	return 1;
> -}
> -
> -static int add_location(struct loc_track *t, struct kmem_cache *s,
> -				const struct track *track,
> -				unsigned int orig_size)
> -{
> -	long start, end, pos;
> -	struct location *l;
> -	unsigned long caddr, chandle, cwaste;
> -	unsigned long age = jiffies - track->when;
> -	depot_stack_handle_t handle = 0;
> -	unsigned int waste = s->object_size - orig_size;
> -
> -#ifdef CONFIG_STACKDEPOT
> -	handle = READ_ONCE(track->handle);
> -#endif
> -	start = -1;
> -	end = t->count;
> -
> -	for ( ; ; ) {
> -		pos = start + (end - start + 1) / 2;
> -
> -		/*
> -		 * There is nothing at "end". If we end up there
> -		 * we need to add something to before end.
> -		 */
> -		if (pos == end)
> -			break;
> -
> -		l = &t->loc[pos];
> -		caddr = l->addr;
> -		chandle = l->handle;
> -		cwaste = l->waste;
> -		if ((track->addr == caddr) && (handle == chandle) &&
> -			(waste == cwaste)) {
> -
> -			l->count++;
> -			if (track->when) {
> -				l->sum_time += age;
> -				if (age < l->min_time)
> -					l->min_time = age;
> -				if (age > l->max_time)
> -					l->max_time = age;
> -
> -				if (track->pid < l->min_pid)
> -					l->min_pid = track->pid;
> -				if (track->pid > l->max_pid)
> -					l->max_pid = track->pid;
> -
> -				cpumask_set_cpu(track->cpu,
> -						to_cpumask(l->cpus));
> -			}
> -			node_set(page_to_nid(virt_to_page(track)), l->nodes);
> -			return 1;
> -		}
> -
> -		if (track->addr < caddr)
> -			end = pos;
> -		else if (track->addr == caddr && handle < chandle)
> -			end = pos;
> -		else if (track->addr == caddr && handle == chandle &&
> -				waste < cwaste)
> -			end = pos;
> -		else
> -			start = pos;
> -	}
> -
> -	/*
> -	 * Not found. Insert new tracking element.
> -	 */
> -	if (t->count >= t->max && !alloc_loc_track(t, 2 * t->max, GFP_ATOMIC))
> -		return 0;
> -
> -	l = t->loc + pos;
> -	if (pos < t->count)
> -		memmove(l + 1, l,
> -			(t->count - pos) * sizeof(struct location));
> -	t->count++;
> -	l->count = 1;
> -	l->addr = track->addr;
> -	l->sum_time = age;
> -	l->min_time = age;
> -	l->max_time = age;
> -	l->min_pid = track->pid;
> -	l->max_pid = track->pid;
> -	l->handle = handle;
> -	l->waste = waste;
> -	cpumask_clear(to_cpumask(l->cpus));
> -	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
> -	nodes_clear(l->nodes);
> -	node_set(page_to_nid(virt_to_page(track)), l->nodes);
> -	return 1;
> -}
> -
> -static void process_slab(struct loc_track *t, struct kmem_cache *s,
> -		struct slab *slab, enum track_item alloc,
> -		unsigned long *obj_map)
> -{
> -	void *addr = slab_address(slab);
> -	bool is_alloc = (alloc == TRACK_ALLOC);
> -	void *p;
> -
> -	__fill_map(obj_map, s, slab);
> -
> -	for_each_object(p, s, addr, slab->objects)
> -		if (!test_bit(__obj_to_index(s, addr, p), obj_map))
> -			add_location(t, s, get_track(s, p, alloc),
> -				     is_alloc ? get_orig_size(s, p) :
> -						s->object_size);
> -}
> -#endif  /* CONFIG_DEBUG_FS   */
> -#endif	/* CONFIG_SLUB_DEBUG */
> -
> -#ifdef SLAB_SUPPORTS_SYSFS
> -enum slab_stat_type {
> -	SL_ALL,			/* All slabs */
> -	SL_PARTIAL,		/* Only partially allocated slabs */
> -	SL_CPU,			/* Only slabs used for cpu caches */
> -	SL_OBJECTS,		/* Determine allocated objects not slabs */
> -	SL_TOTAL		/* Determine object capacity not slabs */
> -};
> -
> -#define SO_ALL		(1 << SL_ALL)
> -#define SO_PARTIAL	(1 << SL_PARTIAL)
> -#define SO_CPU		(1 << SL_CPU)
> -#define SO_OBJECTS	(1 << SL_OBJECTS)
> -#define SO_TOTAL	(1 << SL_TOTAL)
> -
> -static ssize_t show_slab_objects(struct kmem_cache *s,
> -				 char *buf, unsigned long flags)
> -{
> -	unsigned long total = 0;
> -	int node;
> -	int x;
> -	unsigned long *nodes;
> -	int len = 0;
> -
> -	nodes = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
> -	if (!nodes)
> -		return -ENOMEM;
> -
> -	if (flags & SO_CPU) {
> -		int cpu;
> -
> -		for_each_possible_cpu(cpu) {
> -			struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab,
> -							       cpu);
> -			int node;
> -			struct slab *slab;
> -
> -			slab = READ_ONCE(c->slab);
> -			if (!slab)
> -				continue;
> -
> -			node = slab_nid(slab);
> -			if (flags & SO_TOTAL)
> -				x = slab->objects;
> -			else if (flags & SO_OBJECTS)
> -				x = slab->inuse;
> -			else
> -				x = 1;
> -
> -			total += x;
> -			nodes[node] += x;
> -
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -			slab = slub_percpu_partial_read_once(c);
> -			if (slab) {
> -				node = slab_nid(slab);
> -				if (flags & SO_TOTAL)
> -					WARN_ON_ONCE(1);
> -				else if (flags & SO_OBJECTS)
> -					WARN_ON_ONCE(1);
> -				else
> -					x = slab->slabs;
> -				total += x;
> -				nodes[node] += x;
> -			}
> -#endif
> -		}
> -	}
> -
> -	/*
> -	 * It is impossible to take "mem_hotplug_lock" here with "kernfs_mutex"
> -	 * already held which will conflict with an existing lock order:
> -	 *
> -	 * mem_hotplug_lock->slab_mutex->kernfs_mutex
> -	 *
> -	 * We don't really need mem_hotplug_lock (to hold off
> -	 * slab_mem_going_offline_callback) here because slab's memory hot
> -	 * unplug code doesn't destroy the kmem_cache->node[] data.
> -	 */
> -
> -#ifdef CONFIG_SLUB_DEBUG
> -	if (flags & SO_ALL) {
> -		struct kmem_cache_node *n;
> -
> -		for_each_kmem_cache_node(s, node, n) {
> -
> -			if (flags & SO_TOTAL)
> -				x = atomic_long_read(&n->total_objects);
> -			else if (flags & SO_OBJECTS)
> -				x = atomic_long_read(&n->total_objects) -
> -					count_partial(n, count_free);
> -			else
> -				x = atomic_long_read(&n->nr_slabs);
> -			total += x;
> -			nodes[node] += x;
> -		}
> -
> -	} else
> -#endif
> -	if (flags & SO_PARTIAL) {
> -		struct kmem_cache_node *n;
> -
> -		for_each_kmem_cache_node(s, node, n) {
> -			if (flags & SO_TOTAL)
> -				x = count_partial(n, count_total);
> -			else if (flags & SO_OBJECTS)
> -				x = count_partial(n, count_inuse);
> -			else
> -				x = n->nr_partial;
> -			total += x;
> -			nodes[node] += x;
> -		}
> -	}
> -
> -	len += sysfs_emit_at(buf, len, "%lu", total);
> -#ifdef CONFIG_NUMA
> -	for (node = 0; node < nr_node_ids; node++) {
> -		if (nodes[node])
> -			len += sysfs_emit_at(buf, len, " N%d=%lu",
> -					     node, nodes[node]);
> -	}
> -#endif
> -	len += sysfs_emit_at(buf, len, "\n");
> -	kfree(nodes);
> -
> -	return len;
> -}
> -
> -#define to_slab_attr(n) container_of(n, struct slab_attribute, attr)
> -#define to_slab(n) container_of(n, struct kmem_cache, kobj)
> -
> -struct slab_attribute {
> -	struct attribute attr;
> -	ssize_t (*show)(struct kmem_cache *s, char *buf);
> -	ssize_t (*store)(struct kmem_cache *s, const char *x, size_t count);
> -};
> -
> -#define SLAB_ATTR_RO(_name) \
> -	static struct slab_attribute _name##_attr = __ATTR_RO_MODE(_name, 0400)
> -
> -#define SLAB_ATTR(_name) \
> -	static struct slab_attribute _name##_attr = __ATTR_RW_MODE(_name, 0600)
> -
> -static ssize_t slab_size_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%u\n", s->size);
> -}
> -SLAB_ATTR_RO(slab_size);
> -
> -static ssize_t align_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%u\n", s->align);
> -}
> -SLAB_ATTR_RO(align);
> -
> -static ssize_t object_size_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%u\n", s->object_size);
> -}
> -SLAB_ATTR_RO(object_size);
> -
> -static ssize_t objs_per_slab_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%u\n", oo_objects(s->oo));
> -}
> -SLAB_ATTR_RO(objs_per_slab);
> -
> -static ssize_t order_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%u\n", oo_order(s->oo));
> -}
> -SLAB_ATTR_RO(order);
> -
> -static ssize_t min_partial_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%lu\n", s->min_partial);
> -}
> -
> -static ssize_t min_partial_store(struct kmem_cache *s, const char *buf,
> -				 size_t length)
> -{
> -	unsigned long min;
> -	int err;
> -
> -	err = kstrtoul(buf, 10, &min);
> -	if (err)
> -		return err;
> -
> -	s->min_partial = min;
> -	return length;
> -}
> -SLAB_ATTR(min_partial);
> -
> -static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
> -{
> -	unsigned int nr_partial = 0;
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -	nr_partial = s->cpu_partial;
> -#endif
> -
> -	return sysfs_emit(buf, "%u\n", nr_partial);
> -}
> -
> -static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
> -				 size_t length)
> -{
> -	unsigned int objects;
> -	int err;
> -
> -	err = kstrtouint(buf, 10, &objects);
> -	if (err)
> -		return err;
> -	if (objects && !kmem_cache_has_cpu_partial(s))
> -		return -EINVAL;
> -
> -	slub_set_cpu_partial(s, objects);
> -	flush_all(s);
> -	return length;
> -}
> -SLAB_ATTR(cpu_partial);
> -
> -static ssize_t ctor_show(struct kmem_cache *s, char *buf)
> -{
> -	if (!s->ctor)
> -		return 0;
> -	return sysfs_emit(buf, "%pS\n", s->ctor);
> -}
> -SLAB_ATTR_RO(ctor);
> -
> -static ssize_t aliases_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", s->refcount < 0 ? 0 : s->refcount - 1);
> -}
> -SLAB_ATTR_RO(aliases);
> -
> -static ssize_t partial_show(struct kmem_cache *s, char *buf)
> -{
> -	return show_slab_objects(s, buf, SO_PARTIAL);
> -}
> -SLAB_ATTR_RO(partial);
> -
> -static ssize_t cpu_slabs_show(struct kmem_cache *s, char *buf)
> -{
> -	return show_slab_objects(s, buf, SO_CPU);
> -}
> -SLAB_ATTR_RO(cpu_slabs);
> -
> -static ssize_t objects_show(struct kmem_cache *s, char *buf)
> -{
> -	return show_slab_objects(s, buf, SO_ALL|SO_OBJECTS);
> -}
> -SLAB_ATTR_RO(objects);
> -
> -static ssize_t objects_partial_show(struct kmem_cache *s, char *buf)
> -{
> -	return show_slab_objects(s, buf, SO_PARTIAL|SO_OBJECTS);
> -}
> -SLAB_ATTR_RO(objects_partial);
> -
> -static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
> -{
> -	int objects = 0;
> -	int slabs = 0;
> -	int cpu __maybe_unused;
> -	int len = 0;
> -
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -	for_each_online_cpu(cpu) {
> -		struct slab *slab;
> -
> -		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
> -
> -		if (slab)
> -			slabs += slab->slabs;
> -	}
> -#endif
> -
> -	/* Approximate half-full slabs, see slub_set_cpu_partial() */
> -	objects = (slabs * oo_objects(s->oo)) / 2;
> -	len += sysfs_emit_at(buf, len, "%d(%d)", objects, slabs);
> -
> -#if defined(CONFIG_SLUB_CPU_PARTIAL) && defined(CONFIG_SMP)
> -	for_each_online_cpu(cpu) {
> -		struct slab *slab;
> -
> -		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
> -		if (slab) {
> -			slabs = READ_ONCE(slab->slabs);
> -			objects = (slabs * oo_objects(s->oo)) / 2;
> -			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
> -					     cpu, objects, slabs);
> -		}
> -	}
> -#endif
> -	len += sysfs_emit_at(buf, len, "\n");
> -
> -	return len;
> -}
> -SLAB_ATTR_RO(slabs_cpu_partial);
> -
> -static ssize_t reclaim_account_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_RECLAIM_ACCOUNT));
> -}
> -SLAB_ATTR_RO(reclaim_account);
> -
> -static ssize_t hwcache_align_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_HWCACHE_ALIGN));
> -}
> -SLAB_ATTR_RO(hwcache_align);
> -
> -#ifdef CONFIG_ZONE_DMA
> -static ssize_t cache_dma_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_CACHE_DMA));
> -}
> -SLAB_ATTR_RO(cache_dma);
> -#endif
> -
> -#ifdef CONFIG_HARDENED_USERCOPY
> -static ssize_t usersize_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%u\n", s->usersize);
> -}
> -SLAB_ATTR_RO(usersize);
> -#endif
> -
> -static ssize_t destroy_by_rcu_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_TYPESAFE_BY_RCU));
> -}
> -SLAB_ATTR_RO(destroy_by_rcu);
> -
> -#ifdef CONFIG_SLUB_DEBUG
> -static ssize_t slabs_show(struct kmem_cache *s, char *buf)
> -{
> -	return show_slab_objects(s, buf, SO_ALL);
> -}
> -SLAB_ATTR_RO(slabs);
> -
> -static ssize_t total_objects_show(struct kmem_cache *s, char *buf)
> -{
> -	return show_slab_objects(s, buf, SO_ALL|SO_TOTAL);
> -}
> -SLAB_ATTR_RO(total_objects);
> -
> -static ssize_t sanity_checks_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_CONSISTENCY_CHECKS));
> -}
> -SLAB_ATTR_RO(sanity_checks);
> -
> -static ssize_t trace_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_TRACE));
> -}
> -SLAB_ATTR_RO(trace);
> -
> -static ssize_t red_zone_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_RED_ZONE));
> -}
> -
> -SLAB_ATTR_RO(red_zone);
> -
> -static ssize_t poison_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_POISON));
> -}
> -
> -SLAB_ATTR_RO(poison);
> -
> -static ssize_t store_user_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_STORE_USER));
> -}
> -
> -SLAB_ATTR_RO(store_user);
> -
> -static ssize_t validate_show(struct kmem_cache *s, char *buf)
> -{
> -	return 0;
> -}
> -
> -static ssize_t validate_store(struct kmem_cache *s,
> -			const char *buf, size_t length)
> -{
> -	int ret = -EINVAL;
> -
> -	if (buf[0] == '1' && kmem_cache_debug(s)) {
> -		ret = validate_slab_cache(s);
> -		if (ret >= 0)
> -			ret = length;
> -	}
> -	return ret;
> -}
> -SLAB_ATTR(validate);
> -
> -#endif /* CONFIG_SLUB_DEBUG */
> -
> -#ifdef CONFIG_FAILSLAB
> -static ssize_t failslab_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_FAILSLAB));
> -}
> -
> -static ssize_t failslab_store(struct kmem_cache *s, const char *buf,
> -				size_t length)
> -{
> -	if (s->refcount > 1)
> -		return -EINVAL;
> -
> -	if (buf[0] == '1')
> -		WRITE_ONCE(s->flags, s->flags | SLAB_FAILSLAB);
> -	else
> -		WRITE_ONCE(s->flags, s->flags & ~SLAB_FAILSLAB);
> -
> -	return length;
> -}
> -SLAB_ATTR(failslab);
> -#endif
> -
> -static ssize_t shrink_show(struct kmem_cache *s, char *buf)
> -{
> -	return 0;
> -}
> -
> -static ssize_t shrink_store(struct kmem_cache *s,
> -			const char *buf, size_t length)
> -{
> -	if (buf[0] == '1')
> -		kmem_cache_shrink(s);
> -	else
> -		return -EINVAL;
> -	return length;
> -}
> -SLAB_ATTR(shrink);
> -
> -#ifdef CONFIG_NUMA
> -static ssize_t remote_node_defrag_ratio_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%u\n", s->remote_node_defrag_ratio / 10);
> -}
> -
> -static ssize_t remote_node_defrag_ratio_store(struct kmem_cache *s,
> -				const char *buf, size_t length)
> -{
> -	unsigned int ratio;
> -	int err;
> -
> -	err = kstrtouint(buf, 10, &ratio);
> -	if (err)
> -		return err;
> -	if (ratio > 100)
> -		return -ERANGE;
> -
> -	s->remote_node_defrag_ratio = ratio * 10;
> -
> -	return length;
> -}
> -SLAB_ATTR(remote_node_defrag_ratio);
> -#endif
> -
> -#ifdef CONFIG_SLUB_STATS
> -static int show_stat(struct kmem_cache *s, char *buf, enum stat_item si)
> -{
> -	unsigned long sum  = 0;
> -	int cpu;
> -	int len = 0;
> -	int *data = kmalloc_array(nr_cpu_ids, sizeof(int), GFP_KERNEL);
> -
> -	if (!data)
> -		return -ENOMEM;
> -
> -	for_each_online_cpu(cpu) {
> -		unsigned x = per_cpu_ptr(s->cpu_slab, cpu)->stat[si];
> -
> -		data[cpu] = x;
> -		sum += x;
> -	}
> -
> -	len += sysfs_emit_at(buf, len, "%lu", sum);
> -
> -#ifdef CONFIG_SMP
> -	for_each_online_cpu(cpu) {
> -		if (data[cpu])
> -			len += sysfs_emit_at(buf, len, " C%d=%u",
> -					     cpu, data[cpu]);
> -	}
> -#endif
> -	kfree(data);
> -	len += sysfs_emit_at(buf, len, "\n");
> -
> -	return len;
> -}
> -
> -static void clear_stat(struct kmem_cache *s, enum stat_item si)
> -{
> -	int cpu;
> -
> -	for_each_online_cpu(cpu)
> -		per_cpu_ptr(s->cpu_slab, cpu)->stat[si] = 0;
> -}
> -
> -#define STAT_ATTR(si, text) 					\
> -static ssize_t text##_show(struct kmem_cache *s, char *buf)	\
> -{								\
> -	return show_stat(s, buf, si);				\
> -}								\
> -static ssize_t text##_store(struct kmem_cache *s,		\
> -				const char *buf, size_t length)	\
> -{								\
> -	if (buf[0] != '0')					\
> -		return -EINVAL;					\
> -	clear_stat(s, si);					\
> -	return length;						\
> -}								\
> -SLAB_ATTR(text);						\
> -
> -STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
> -STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
> -STAT_ATTR(FREE_FASTPATH, free_fastpath);
> -STAT_ATTR(FREE_SLOWPATH, free_slowpath);
> -STAT_ATTR(FREE_FROZEN, free_frozen);
> -STAT_ATTR(FREE_ADD_PARTIAL, free_add_partial);
> -STAT_ATTR(FREE_REMOVE_PARTIAL, free_remove_partial);
> -STAT_ATTR(ALLOC_FROM_PARTIAL, alloc_from_partial);
> -STAT_ATTR(ALLOC_SLAB, alloc_slab);
> -STAT_ATTR(ALLOC_REFILL, alloc_refill);
> -STAT_ATTR(ALLOC_NODE_MISMATCH, alloc_node_mismatch);
> -STAT_ATTR(FREE_SLAB, free_slab);
> -STAT_ATTR(CPUSLAB_FLUSH, cpuslab_flush);
> -STAT_ATTR(DEACTIVATE_FULL, deactivate_full);
> -STAT_ATTR(DEACTIVATE_EMPTY, deactivate_empty);
> -STAT_ATTR(DEACTIVATE_TO_HEAD, deactivate_to_head);
> -STAT_ATTR(DEACTIVATE_TO_TAIL, deactivate_to_tail);
> -STAT_ATTR(DEACTIVATE_REMOTE_FREES, deactivate_remote_frees);
> -STAT_ATTR(DEACTIVATE_BYPASS, deactivate_bypass);
> -STAT_ATTR(ORDER_FALLBACK, order_fallback);
> -STAT_ATTR(CMPXCHG_DOUBLE_CPU_FAIL, cmpxchg_double_cpu_fail);
> -STAT_ATTR(CMPXCHG_DOUBLE_FAIL, cmpxchg_double_fail);
> -STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
> -STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
> -STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
> -STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
> -#endif	/* CONFIG_SLUB_STATS */
> -
> -#ifdef CONFIG_KFENCE
> -static ssize_t skip_kfence_show(struct kmem_cache *s, char *buf)
> -{
> -	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_SKIP_KFENCE));
> -}
> -
> -static ssize_t skip_kfence_store(struct kmem_cache *s,
> -			const char *buf, size_t length)
> -{
> -	int ret = length;
> -
> -	if (buf[0] == '0')
> -		s->flags &= ~SLAB_SKIP_KFENCE;
> -	else if (buf[0] == '1')
> -		s->flags |= SLAB_SKIP_KFENCE;
> -	else
> -		ret = -EINVAL;
> -
> -	return ret;
> -}
> -SLAB_ATTR(skip_kfence);
> -#endif
> -
> -static struct attribute *slab_attrs[] = {
> -	&slab_size_attr.attr,
> -	&object_size_attr.attr,
> -	&objs_per_slab_attr.attr,
> -	&order_attr.attr,
> -	&min_partial_attr.attr,
> -	&cpu_partial_attr.attr,
> -	&objects_attr.attr,
> -	&objects_partial_attr.attr,
> -	&partial_attr.attr,
> -	&cpu_slabs_attr.attr,
> -	&ctor_attr.attr,
> -	&aliases_attr.attr,
> -	&align_attr.attr,
> -	&hwcache_align_attr.attr,
> -	&reclaim_account_attr.attr,
> -	&destroy_by_rcu_attr.attr,
> -	&shrink_attr.attr,
> -	&slabs_cpu_partial_attr.attr,
> -#ifdef CONFIG_SLUB_DEBUG
> -	&total_objects_attr.attr,
> -	&slabs_attr.attr,
> -	&sanity_checks_attr.attr,
> -	&trace_attr.attr,
> -	&red_zone_attr.attr,
> -	&poison_attr.attr,
> -	&store_user_attr.attr,
> -	&validate_attr.attr,
> -#endif
> -#ifdef CONFIG_ZONE_DMA
> -	&cache_dma_attr.attr,
> -#endif
> -#ifdef CONFIG_NUMA
> -	&remote_node_defrag_ratio_attr.attr,
> -#endif
> -#ifdef CONFIG_SLUB_STATS
> -	&alloc_fastpath_attr.attr,
> -	&alloc_slowpath_attr.attr,
> -	&free_fastpath_attr.attr,
> -	&free_slowpath_attr.attr,
> -	&free_frozen_attr.attr,
> -	&free_add_partial_attr.attr,
> -	&free_remove_partial_attr.attr,
> -	&alloc_from_partial_attr.attr,
> -	&alloc_slab_attr.attr,
> -	&alloc_refill_attr.attr,
> -	&alloc_node_mismatch_attr.attr,
> -	&free_slab_attr.attr,
> -	&cpuslab_flush_attr.attr,
> -	&deactivate_full_attr.attr,
> -	&deactivate_empty_attr.attr,
> -	&deactivate_to_head_attr.attr,
> -	&deactivate_to_tail_attr.attr,
> -	&deactivate_remote_frees_attr.attr,
> -	&deactivate_bypass_attr.attr,
> -	&order_fallback_attr.attr,
> -	&cmpxchg_double_fail_attr.attr,
> -	&cmpxchg_double_cpu_fail_attr.attr,
> -	&cpu_partial_alloc_attr.attr,
> -	&cpu_partial_free_attr.attr,
> -	&cpu_partial_node_attr.attr,
> -	&cpu_partial_drain_attr.attr,
> -#endif
> -#ifdef CONFIG_FAILSLAB
> -	&failslab_attr.attr,
> -#endif
> -#ifdef CONFIG_HARDENED_USERCOPY
> -	&usersize_attr.attr,
> -#endif
> -#ifdef CONFIG_KFENCE
> -	&skip_kfence_attr.attr,
> -#endif
> -
> -	NULL
> -};
> -
> -static const struct attribute_group slab_attr_group = {
> -	.attrs = slab_attrs,
> -};
> -
> -static ssize_t slab_attr_show(struct kobject *kobj,
> -				struct attribute *attr,
> -				char *buf)
> -{
> -	struct slab_attribute *attribute;
> -	struct kmem_cache *s;
> -
> -	attribute = to_slab_attr(attr);
> -	s = to_slab(kobj);
> -
> -	if (!attribute->show)
> -		return -EIO;
> -
> -	return attribute->show(s, buf);
> -}
> -
> -static ssize_t slab_attr_store(struct kobject *kobj,
> -				struct attribute *attr,
> -				const char *buf, size_t len)
> -{
> -	struct slab_attribute *attribute;
> -	struct kmem_cache *s;
> -
> -	attribute = to_slab_attr(attr);
> -	s = to_slab(kobj);
> -
> -	if (!attribute->store)
> -		return -EIO;
> -
> -	return attribute->store(s, buf, len);
> -}
> -
> -static void kmem_cache_release(struct kobject *k)
> -{
> -	slab_kmem_cache_release(to_slab(k));
> -}
> -
> -static const struct sysfs_ops slab_sysfs_ops = {
> -	.show = slab_attr_show,
> -	.store = slab_attr_store,
> -};
> -
> -static struct kobj_type slab_ktype = {
> -	.sysfs_ops = &slab_sysfs_ops,
> -	.release = kmem_cache_release,
> -};
> -
> -static struct kset *slab_kset;
> -
> -static inline struct kset *cache_kset(struct kmem_cache *s)
> -{
> -	return slab_kset;
> -}
> -
> -#define ID_STR_LENGTH 32
> -
> -/* Create a unique string id for a slab cache:
> - *
> - * Format	:[flags-]size
> - */
> -static char *create_unique_id(struct kmem_cache *s)
> -{
> -	char *name = kmalloc(ID_STR_LENGTH, GFP_KERNEL);
> -	char *p = name;
> -
> -	if (!name)
> -		return ERR_PTR(-ENOMEM);
> -
> -	*p++ = ':';
> -	/*
> -	 * First flags affecting slabcache operations. We will only
> -	 * get here for aliasable slabs so we do not need to support
> -	 * too many flags. The flags here must cover all flags that
> -	 * are matched during merging to guarantee that the id is
> -	 * unique.
> -	 */
> -	if (s->flags & SLAB_CACHE_DMA)
> -		*p++ = 'd';
> -	if (s->flags & SLAB_CACHE_DMA32)
> -		*p++ = 'D';
> -	if (s->flags & SLAB_RECLAIM_ACCOUNT)
> -		*p++ = 'a';
> -	if (s->flags & SLAB_CONSISTENCY_CHECKS)
> -		*p++ = 'F';
> -	if (s->flags & SLAB_ACCOUNT)
> -		*p++ = 'A';
> -	if (p != name + 1)
> -		*p++ = '-';
> -	p += snprintf(p, ID_STR_LENGTH - (p - name), "%07u", s->size);
> -
> -	if (WARN_ON(p > name + ID_STR_LENGTH - 1)) {
> -		kfree(name);
> -		return ERR_PTR(-EINVAL);
> -	}
> -	kmsan_unpoison_memory(name, p - name);
> -	return name;
> -}
> -
> -static int sysfs_slab_add(struct kmem_cache *s)
> -{
> -	int err;
> -	const char *name;
> -	struct kset *kset = cache_kset(s);
> -	int unmergeable = slab_unmergeable(s);
> -
> -	if (!unmergeable && disable_higher_order_debug &&
> -			(slub_debug & DEBUG_METADATA_FLAGS))
> -		unmergeable = 1;
> -
> -	if (unmergeable) {
> -		/*
> -		 * Slabcache can never be merged so we can use the name proper.
> -		 * This is typically the case for debug situations. In that
> -		 * case we can catch duplicate names easily.
> -		 */
> -		sysfs_remove_link(&slab_kset->kobj, s->name);
> -		name = s->name;
> -	} else {
> -		/*
> -		 * Create a unique name for the slab as a target
> -		 * for the symlinks.
> -		 */
> -		name = create_unique_id(s);
> -		if (IS_ERR(name))
> -			return PTR_ERR(name);
> -	}
> -
> -	s->kobj.kset = kset;
> -	err = kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s", name);
> -	if (err)
> -		goto out;
> -
> -	err = sysfs_create_group(&s->kobj, &slab_attr_group);
> -	if (err)
> -		goto out_del_kobj;
> -
> -	if (!unmergeable) {
> -		/* Setup first alias */
> -		sysfs_slab_alias(s, s->name);
> -	}
> -out:
> -	if (!unmergeable)
> -		kfree(name);
> -	return err;
> -out_del_kobj:
> -	kobject_del(&s->kobj);
> -	goto out;
> -}
> -
> -void sysfs_slab_unlink(struct kmem_cache *s)
> -{
> -	if (slab_state >= FULL)
> -		kobject_del(&s->kobj);
> -}
> -
> -void sysfs_slab_release(struct kmem_cache *s)
> -{
> -	if (slab_state >= FULL)
> -		kobject_put(&s->kobj);
> -}
> -
> -/*
> - * Need to buffer aliases during bootup until sysfs becomes
> - * available lest we lose that information.
> - */
> -struct saved_alias {
> -	struct kmem_cache *s;
> -	const char *name;
> -	struct saved_alias *next;
> -};
> -
> -static struct saved_alias *alias_list;
> -
> -static int sysfs_slab_alias(struct kmem_cache *s, const char *name)
> -{
> -	struct saved_alias *al;
> -
> -	if (slab_state == FULL) {
> -		/*
> -		 * If we have a leftover link then remove it.
> -		 */
> -		sysfs_remove_link(&slab_kset->kobj, name);
> -		return sysfs_create_link(&slab_kset->kobj, &s->kobj, name);
> -	}
> -
> -	al = kmalloc(sizeof(struct saved_alias), GFP_KERNEL);
> -	if (!al)
> -		return -ENOMEM;
> -
> -	al->s = s;
> -	al->name = name;
> -	al->next = alias_list;
> -	alias_list = al;
> -	kmsan_unpoison_memory(al, sizeof(*al));
> -	return 0;
> -}
> -
> -static int __init slab_sysfs_init(void)
> -{
> -	struct kmem_cache *s;
> -	int err;
> -
> -	mutex_lock(&slab_mutex);
> -
> -	slab_kset = kset_create_and_add("slab", NULL, kernel_kobj);
> -	if (!slab_kset) {
> -		mutex_unlock(&slab_mutex);
> -		pr_err("Cannot register slab subsystem.\n");
> -		return -ENOSYS;
> -	}
> -
> -	slab_state = FULL;
> -
> -	list_for_each_entry(s, &slab_caches, list) {
> -		err = sysfs_slab_add(s);
> -		if (err)
> -			pr_err("SLUB: Unable to add boot slab %s to sysfs\n",
> -			       s->name);
> -	}
> -
> -	while (alias_list) {
> -		struct saved_alias *al = alias_list;
> -
> -		alias_list = alias_list->next;
> -		err = sysfs_slab_alias(al->s, al->name);
> -		if (err)
> -			pr_err("SLUB: Unable to add boot slab alias %s to sysfs\n",
> -			       al->name);
> -		kfree(al);
> -	}
> -
> -	mutex_unlock(&slab_mutex);
> -	return 0;
> -}
> -late_initcall(slab_sysfs_init);
> -#endif /* SLAB_SUPPORTS_SYSFS */
> -
> -#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
> -static int slab_debugfs_show(struct seq_file *seq, void *v)
> -{
> -	struct loc_track *t = seq->private;
> -	struct location *l;
> -	unsigned long idx;
> -
> -	idx = (unsigned long) t->idx;
> -	if (idx < t->count) {
> -		l = &t->loc[idx];
> -
> -		seq_printf(seq, "%7ld ", l->count);
> -
> -		if (l->addr)
> -			seq_printf(seq, "%pS", (void *)l->addr);
> -		else
> -			seq_puts(seq, "<not-available>");
> -
> -		if (l->waste)
> -			seq_printf(seq, " waste=%lu/%lu",
> -				l->count * l->waste, l->waste);
> -
> -		if (l->sum_time != l->min_time) {
> -			seq_printf(seq, " age=%ld/%llu/%ld",
> -				l->min_time, div_u64(l->sum_time, l->count),
> -				l->max_time);
> -		} else
> -			seq_printf(seq, " age=%ld", l->min_time);
> -
> -		if (l->min_pid != l->max_pid)
> -			seq_printf(seq, " pid=%ld-%ld", l->min_pid, l->max_pid);
> -		else
> -			seq_printf(seq, " pid=%ld",
> -				l->min_pid);
> -
> -		if (num_online_cpus() > 1 && !cpumask_empty(to_cpumask(l->cpus)))
> -			seq_printf(seq, " cpus=%*pbl",
> -				 cpumask_pr_args(to_cpumask(l->cpus)));
> -
> -		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
> -			seq_printf(seq, " nodes=%*pbl",
> -				 nodemask_pr_args(&l->nodes));
> -
> -#ifdef CONFIG_STACKDEPOT
> -		{
> -			depot_stack_handle_t handle;
> -			unsigned long *entries;
> -			unsigned int nr_entries, j;
> -
> -			handle = READ_ONCE(l->handle);
> -			if (handle) {
> -				nr_entries = stack_depot_fetch(handle, &entries);
> -				seq_puts(seq, "\n");
> -				for (j = 0; j < nr_entries; j++)
> -					seq_printf(seq, "        %pS\n", (void *)entries[j]);
> -			}
> -		}
> -#endif
> -		seq_puts(seq, "\n");
> -	}
> -
> -	if (!idx && !t->count)
> -		seq_puts(seq, "No data\n");
> -
> -	return 0;
> -}
> -
> -static void slab_debugfs_stop(struct seq_file *seq, void *v)
> -{
> -}
> -
> -static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
> -{
> -	struct loc_track *t = seq->private;
> -
> -	t->idx = ++(*ppos);
> -	if (*ppos <= t->count)
> -		return ppos;
> -
> -	return NULL;
> -}
> -
> -static int cmp_loc_by_count(const void *a, const void *b, const void *data)
> -{
> -	struct location *loc1 = (struct location *)a;
> -	struct location *loc2 = (struct location *)b;
> -
> -	if (loc1->count > loc2->count)
> -		return -1;
> -	else
> -		return 1;
> -}
> -
> -static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
> -{
> -	struct loc_track *t = seq->private;
> -
> -	t->idx = *ppos;
> -	return ppos;
> -}
> -
> -static const struct seq_operations slab_debugfs_sops = {
> -	.start  = slab_debugfs_start,
> -	.next   = slab_debugfs_next,
> -	.stop   = slab_debugfs_stop,
> -	.show   = slab_debugfs_show,
> -};
> -
> -static int slab_debug_trace_open(struct inode *inode, struct file *filep)
> -{
> -
> -	struct kmem_cache_node *n;
> -	enum track_item alloc;
> -	int node;
> -	struct loc_track *t = __seq_open_private(filep, &slab_debugfs_sops,
> -						sizeof(struct loc_track));
> -	struct kmem_cache *s = file_inode(filep)->i_private;
> -	unsigned long *obj_map;
> -
> -	if (!t)
> -		return -ENOMEM;
> -
> -	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
> -	if (!obj_map) {
> -		seq_release_private(inode, filep);
> -		return -ENOMEM;
> -	}
> -
> -	if (strcmp(filep->f_path.dentry->d_name.name, "alloc_traces") == 0)
> -		alloc = TRACK_ALLOC;
> -	else
> -		alloc = TRACK_FREE;
> -
> -	if (!alloc_loc_track(t, PAGE_SIZE / sizeof(struct location), GFP_KERNEL)) {
> -		bitmap_free(obj_map);
> -		seq_release_private(inode, filep);
> -		return -ENOMEM;
> -	}
> -
> -	for_each_kmem_cache_node(s, node, n) {
> -		unsigned long flags;
> -		struct slab *slab;
> -
> -		if (!atomic_long_read(&n->nr_slabs))
> -			continue;
> -
> -		spin_lock_irqsave(&n->list_lock, flags);
> -		list_for_each_entry(slab, &n->partial, slab_list)
> -			process_slab(t, s, slab, alloc, obj_map);
> -		list_for_each_entry(slab, &n->full, slab_list)
> -			process_slab(t, s, slab, alloc, obj_map);
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> -	}
> -
> -	/* Sort locations by count */
> -	sort_r(t->loc, t->count, sizeof(struct location),
> -		cmp_loc_by_count, NULL, NULL);
> -
> -	bitmap_free(obj_map);
> -	return 0;
> -}
> -
> -static int slab_debug_trace_release(struct inode *inode, struct file *file)
> -{
> -	struct seq_file *seq = file->private_data;
> -	struct loc_track *t = seq->private;
> -
> -	free_loc_track(t);
> -	return seq_release_private(inode, file);
> -}
> -
> -static const struct file_operations slab_debugfs_fops = {
> -	.open    = slab_debug_trace_open,
> -	.read    = seq_read,
> -	.llseek  = seq_lseek,
> -	.release = slab_debug_trace_release,
> -};
> -
> -static void debugfs_slab_add(struct kmem_cache *s)
> -{
> -	struct dentry *slab_cache_dir;
> -
> -	if (unlikely(!slab_debugfs_root))
> -		return;
> -
> -	slab_cache_dir = debugfs_create_dir(s->name, slab_debugfs_root);
> -
> -	debugfs_create_file("alloc_traces", 0400,
> -		slab_cache_dir, s, &slab_debugfs_fops);
> -
> -	debugfs_create_file("free_traces", 0400,
> -		slab_cache_dir, s, &slab_debugfs_fops);
> -}
> -
> -void debugfs_slab_release(struct kmem_cache *s)
> -{
> -	debugfs_lookup_and_remove(s->name, slab_debugfs_root);
> -}
> -
> -static int __init slab_debugfs_init(void)
> -{
> -	struct kmem_cache *s;
> -
> -	slab_debugfs_root = debugfs_create_dir("slab", NULL);
> -
> -	list_for_each_entry(s, &slab_caches, list)
> -		if (s->flags & SLAB_STORE_USER)
> -			debugfs_slab_add(s);
> -
> -	return 0;
> -
> -}
> -__initcall(slab_debugfs_init);
> -#endif
> -/*
> - * The /proc/slabinfo ABI
> - */
> -#ifdef CONFIG_SLUB_DEBUG
> -void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
> -{
> -	unsigned long nr_slabs = 0;
> -	unsigned long nr_objs = 0;
> -	unsigned long nr_free = 0;
> -	int node;
> -	struct kmem_cache_node *n;
> -
> -	for_each_kmem_cache_node(s, node, n) {
> -		nr_slabs += node_nr_slabs(n);
> -		nr_objs += node_nr_objs(n);
> -		nr_free += count_partial(n, count_free);
> -	}
> -
> -	sinfo->active_objs = nr_objs - nr_free;
> -	sinfo->num_objs = nr_objs;
> -	sinfo->active_slabs = nr_slabs;
> -	sinfo->num_slabs = nr_slabs;
> -	sinfo->objects_per_slab = oo_objects(s->oo);
> -	sinfo->cache_order = oo_order(s->oo);
> -}
> -
> -void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *s)
> -{
> -}
> -
> -ssize_t slabinfo_write(struct file *file, const char __user *buffer,
> -		       size_t count, loff_t *ppos)
> -{
> -	return -EIO;
> -}
> -#endif /* CONFIG_SLUB_DEBUG */
> --
> 2.40.0
>

This is such a trivial fixup that it barely even requires review (I imagine
Andrew will just take it as-is) but for the sake of being pedantic:-

Unnecessarily-Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
