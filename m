Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9E617FAB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiKCOgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiKCOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:36:29 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E1110CC;
        Thu,  3 Nov 2022 07:36:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 64so1832141pgc.5;
        Thu, 03 Nov 2022 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SGnUSCPqCRbqwfTPIsUS28tudEAjZuU81okBvbtR/vY=;
        b=N4Ta5MP/lW1TqOZwXvFTBqgjKwaDjju1t8ugm4TnQt9VyA5yzDQ5QWKaNlvYQWLCkn
         4HiotHaGSAp3NDKySj+1jmPaZloC7GwIvxj1D+Ut+kyfUGVAUVGtJj8sDEhK2GSLtGY3
         QxDjZPpZvjuIaEdtlzxGXv1s7S5xFFjJLeWdKtej/C5kSkw8r5AzSknQ3CHX6SNJoehl
         nrzXDQ6UByBiD95bhOhtypRIA8OedV7qOsF3Az8Ucl8Z+DJv/jkfU1BaDQCTKWknxdyk
         eq7RbEMm0ePQ2J5KPRP1i9dTWzWxyy3+n6rG6lJ7esg9p1CrqsP302H73xYqiPd2PjhU
         Zgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGnUSCPqCRbqwfTPIsUS28tudEAjZuU81okBvbtR/vY=;
        b=za1ZNX/3mDVBqGCgqxHPxXxDDvlCDgEEQTvfAChXZhLarQIRp8mhq3GKkrMcE1BgTv
         0E2titEps5iZ0gCESmgfjbTVlU18hT/ckzBMrICIHhWV82AhpaDy04xdZEqquhuhbKWA
         XzP2miJzOorFG96BGOD5XpsUTTWNuuAGf1Gu/V96NzgheE3Sp4XrLZBSXpcHRqVWarzZ
         DoUQDMO1M3HLTU/Zo61rg2tvGkzxBSk1XCRa/A5mRVl2nHWHPOlKcSUDPTx9aRQ6tPFo
         6fpj6jxqaxm9mTJfsNN+sX8oADoXUJqLDtEJmZwDpq6EmiIPEp9KIzFMQqREZcsd9lMZ
         zzvg==
X-Gm-Message-State: ACrzQf0L3ppVO4Dirk5aM2TNuDa7sfSANCfSj3aOK1sThF3o1Jyg/QlI
        hAGR1d1zO3J1RGJy3DSidK8=
X-Google-Smtp-Source: AMsMyM6EZwtp8NumyCU5PgiRjz0NyUu0VgjZcAPxUpvyqbgL4wX14Djsepez9jpShCpJREbFeePr1g==
X-Received: by 2002:a05:6a00:340f:b0:56d:b039:202 with SMTP id cn15-20020a056a00340f00b0056db0390202mr16913722pfb.2.1667486187927;
        Thu, 03 Nov 2022 07:36:27 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00000200b00562cfc80864sm850829pfk.36.2022.11.03.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:36:26 -0700 (PDT)
Date:   Thu, 3 Nov 2022 23:36:19 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        John Thomson <lists@johnthomson.fastmail.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <Y2PR45BW2mgLLMwC@hyeyoo>
References: <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
 <Y2DngwUc7cLB0dG7@hyeyoo>
 <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
 <097d8fba-bd10-a312-24a3-a4068c4f424c@suse.cz>
 <Y2NXiiAF6V2DnBrB@feng-clx>
 <f88a5d34-de05-25d7-832d-36b3a3eddd72@suse.cz>
 <Y2PNLENnxxpqZ74g@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PNLENnxxpqZ74g@feng-clx>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:16:12PM +0800, Feng Tang wrote:
> On Thu, Nov 03, 2022 at 09:33:28AM +0100, Vlastimil Babka wrote:
> [...]
> > >> AFAICS before this patch, we "survive" "kmem_cache *s" being NULL as
> > >> slab_pre_alloc_hook() will happen to return NULL and we bail out from
> > >> slab_alloc_node(). But this is a side-effect, not an intended protection.
> > >> Also the CONFIG_TRACING variant of kmalloc_trace() would have called
> > >> trace_kmalloc dereferencing s->size anyway even before this patch.
> > >> 
> > >> I don't think we should add WARNS in the slab hot paths just to prevent this
> > >> rare error of using slab too early. At most VM_WARN... would be acceptable
> > >> but still not necessary as crashing immediately from a NULL pointer is
> > >> sufficient.
> > >> 
> > >> So IMHO mips should fix their soc init, 
> > > 
> > > Yes, for the mips fix, John has proposed to defer the calling of prom_soc_init(),
> > > which looks reasonable.
> > > 
> > >> and we should look into the
> > >> CONFIG_TRACING=n variant of kmalloc_trace(), to pass orig_size properly.
> > > 
> > > You mean check if the pointer is NULL and bail out early. 
> > 
> > No I mean here:
> > 
> > #else /* CONFIG_TRACING */
> > /* Save a function call when CONFIG_TRACING=n */
> > static __always_inline __alloc_size(3)                                   
> > void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
> > {       
> >         void *ret = kmem_cache_alloc(s, flags);
> >                     
> >         ret = kasan_kmalloc(s, ret, size, flags);
> >         return ret;
> > }
> > 
> > we call kmem_cache_alloc() and discard the size parameter, so it will assume
> > s->object_size (and as the side-effect, crash if s is NULL). We shouldn't
> > add "s is NULL?" checks, but fix passing the size - probably switch to
> > __kmem_cache_alloc_node()? and in the following kmalloc_node_trace() analogically.
>  
> Got it, thanks! I might have missed it during some rebasing for the
> kmalloc wastage debug patch.

That was good catch and I missed too!
But FYI I'm suggesting to drop CONFIG_TRACING=n variant:

https://lore.kernel.org/linux-mm/20221101222520.never.109-kees@kernel.org/T/#m20ecf14390e406247bde0ea9cce368f469c539ed

Any thoughts?

> 
> How about the following fix?
> 
> Thanks,
> Feng
> 
> ---
> From 9f9fa9da8946fd44625f873c0f51167357075be1 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Thu, 3 Nov 2022 21:32:10 +0800
> Subject: [PATCH] mm/slub: Add missing orig_size parameter for wastage debug
> 
> commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting of
> kmalloc") was introduced for debugging kmalloc memory wastage,
> and it missed to pass the original request size for kmalloc_trace()
> and kmalloc_node_trace() in CONFIG_TRACING=n path.
> 
> Fix it by using __kmem_cache_alloc_node() with correct original
> request size.
> 
> Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc")
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  include/linux/slab.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 90877fcde70b..9691afa569e1 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -469,6 +469,9 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignm
>  							 __alloc_size(1);
>  void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
>  									 __malloc;
> +void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node,
> +				size_t orig_size, unsigned long caller) __assume_slab_alignment
> +									 __malloc;
>  
>  #ifdef CONFIG_TRACING
>  void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
> @@ -482,7 +485,8 @@ void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
>  static __always_inline __alloc_size(3)
>  void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
>  {
> -	void *ret = kmem_cache_alloc(s, flags);
> +	void *ret = __kmem_cache_alloc_node(s, flags, NUMA_NO_NODE,
> +					    size, _RET_IP_);
>  
>  	ret = kasan_kmalloc(s, ret, size, flags);
>  	return ret;
> @@ -492,7 +496,8 @@ static __always_inline __alloc_size(4)
>  void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
>  			 int node, size_t size)
>  {
> -	void *ret = kmem_cache_alloc_node(s, gfpflags, node);
> +	void *ret = __kmem_cache_alloc_node(s, gfpflags, node,
> +					    size, _RET_IP_);
>  
>  	ret = kasan_kmalloc(s, ret, size, gfpflags);
>  	return ret;
> -- 
> 2.34.1
> 
> 
> 

-- 
Thanks,
Hyeonggon
