Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D469A5FF9D9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJOLrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOLrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 07:47:39 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED58040BC3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 04:47:37 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1322d768ba7so8729535fac.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jUB8fo9MMJnwwxJWvOyVkFrZtTfJO2gl5Nmsaw1xq7c=;
        b=Ipgf7V6nSwDnZZdF27TMbiNWCO/XmdPJVzbRR+HI+57721p2YmvrvlUArEJqh73rZx
         CgIsbK3Lhw5eDMgbmvljQJbbWO+lwdKMRc0Wci7UTcXBbg1kwA3SZrmie7ZImrDNqgFO
         xnoegaQsGzrkVIri9vBtnLx0lpJS04+/ONO0K1SwIGMSGzXbXYW10wHGZy1t9CSjHPtK
         Y8KjykSUD9IeI4TOD8GOWngqWbHqmBDfkhJyhC/q8kkkUyrlfP8dp7vDQqFnj4+wUdfH
         42N4NUWwUYOs9+CGpG1ITD/pmBSgpxdtKDPTNjoTUuq5+B3NTEFoCp7b8BMFhTmAZzmM
         WBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUB8fo9MMJnwwxJWvOyVkFrZtTfJO2gl5Nmsaw1xq7c=;
        b=v5h9nB4mGO15pyo5J/2KYopF5VtkD+biVFaOJI2G0DXOcVs239wJ5T/d5EaPJHydvn
         zrVWXHDz0MIEtusmm+TADFrv8NqWtYg0a3IGKEDuPIlD2KhnJNAyd1odUNn011HSmqDH
         R5gUvk60zKjFKzE9ERWtLZBjdxzSmyiIsiKokFlcKUb4sFP6MlMFDRK9rOHW3N5Ydrqf
         Kk5w8ffWRl2UBWrYxtQ938j0iANhbZDyCLBNU1edsCoAkIDlx0XH3Am6zHRaiZKTjidZ
         MfThtDVfRcPw3iKXFoRNU0QyvjDXuNVyLYSRkY6Qzki8Fw1yv7k2Tw+GX7H4aoz5oKxa
         MtNg==
X-Gm-Message-State: ACrzQf3QQTEcxH358T9YEh4t3t4vgWtJujJw8eqskZd/n0ct6b76AsdA
        ArVpodws3b5l1RmJcd+SPu4=
X-Google-Smtp-Source: AMsMyM5ElYdfs7lovrfbrFXm5kSdfqzRJB+ZsAIAjPuZCCmKKcEC4CdfbN0dxn9SSAYuhk/Rz6/UMw==
X-Received: by 2002:a05:6870:238a:b0:127:9dba:7c82 with SMTP id e10-20020a056870238a00b001279dba7c82mr10966291oap.28.1665834456587;
        Sat, 15 Oct 2022 04:47:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h7-20020a9d61c7000000b00661c3846b4csm2423308otk.27.2022.10.15.04.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 04:47:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 15 Oct 2022 04:47:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: use kmalloc_node() for off slab freelist_idx_t
 array allocation
Message-ID: <20221015114733.GA2931132@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 01:34:29PM +0900, Hyeonggon Yoo wrote:
> After commit d6a71648dbc0 ("mm/slab: kmalloc: pass requests larger than
> order-1 page to page allocator"), SLAB passes large ( > PAGE_SIZE * 2)
> requests to buddy like SLUB does.
> 
> SLAB has been using kmalloc caches to allocate freelist_idx_t array for
> off slab caches. But after the commit, freelist_size can be bigger than
> KMALLOC_MAX_CACHE_SIZE.
> 
> Instead of using pointer to kmalloc cache, use kmalloc_node() and only
> check if the kmalloc cache is off slab during calculate_slab_order().
> If freelist_size > KMALLOC_MAX_CACHE_SIZE, no looping condition happens
> as it allocates freelist_idx_t array directly from buddy.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: d6a71648dbc0 ("mm/slab: kmalloc: pass requests larger than order-1 page to page allocator")
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
> 
> @Guenter:
> 	This fixes the issue on my emulation.
> 	Can you please test this on your environment?

Yes, that fixes the problem for me.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> 
>  include/linux/slab_def.h |  1 -
>  mm/slab.c                | 37 +++++++++++++++++++------------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> index e24c9aff6fed..f0ffad6a3365 100644
> --- a/include/linux/slab_def.h
> +++ b/include/linux/slab_def.h
> @@ -33,7 +33,6 @@ struct kmem_cache {
>  
>  	size_t colour;			/* cache colouring range */
>  	unsigned int colour_off;	/* colour offset */
> -	struct kmem_cache *freelist_cache;
>  	unsigned int freelist_size;
>  
>  	/* constructor func */
> diff --git a/mm/slab.c b/mm/slab.c
> index a5486ff8362a..d1f6e2c64c2e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1619,7 +1619,7 @@ static void slab_destroy(struct kmem_cache *cachep, struct slab *slab)
>  	 * although actual page can be freed in rcu context
>  	 */
>  	if (OFF_SLAB(cachep))
> -		kmem_cache_free(cachep->freelist_cache, freelist);
> +		kfree(freelist);
>  }
>  
>  /*
> @@ -1671,21 +1671,27 @@ static size_t calculate_slab_order(struct kmem_cache *cachep,
>  		if (flags & CFLGS_OFF_SLAB) {
>  			struct kmem_cache *freelist_cache;
>  			size_t freelist_size;
> +			size_t freelist_cache_size;
>  
>  			freelist_size = num * sizeof(freelist_idx_t);
> -			freelist_cache = kmalloc_slab(freelist_size, 0u);
> -			if (!freelist_cache)
> -				continue;
> -
> -			/*
> -			 * Needed to avoid possible looping condition
> -			 * in cache_grow_begin()
> -			 */
> -			if (OFF_SLAB(freelist_cache))
> -				continue;
> +			if (freelist_size > KMALLOC_MAX_CACHE_SIZE) {
> +				freelist_cache_size = PAGE_SIZE << get_order(freelist_size);
> +			} else {
> +				freelist_cache = kmalloc_slab(freelist_size, 0u);
> +				if (!freelist_cache)
> +					continue;
> +				freelist_cache_size = freelist_cache->size;
> +
> +				/*
> +				 * Needed to avoid possible looping condition
> +				 * in cache_grow_begin()
> +				 */
> +				if (OFF_SLAB(freelist_cache))
> +					continue;
> +			}
>  
>  			/* check if off slab has enough benefit */
> -			if (freelist_cache->size > cachep->size / 2)
> +			if (freelist_cache_size > cachep->size / 2)
>  				continue;
>  		}
>  
> @@ -2061,11 +2067,6 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
>  		cachep->flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
>  #endif
>  
> -	if (OFF_SLAB(cachep)) {
> -		cachep->freelist_cache =
> -			kmalloc_slab(cachep->freelist_size, 0u);
> -	}
> -
>  	err = setup_cpu_cache(cachep, gfp);
>  	if (err) {
>  		__kmem_cache_release(cachep);
> @@ -2292,7 +2293,7 @@ static void *alloc_slabmgmt(struct kmem_cache *cachep,
>  		freelist = NULL;
>  	else if (OFF_SLAB(cachep)) {
>  		/* Slab management obj is off-slab. */
> -		freelist = kmem_cache_alloc_node(cachep->freelist_cache,
> +		freelist = kmalloc_node(cachep->freelist_size,
>  					      local_flags, nodeid);
>  	} else {
>  		/* We will use last bytes at the slab for freelist */
> -- 
> 2.32.0
