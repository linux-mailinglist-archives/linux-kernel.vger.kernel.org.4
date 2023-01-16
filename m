Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A976A66BD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjAPMBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjAPMAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:00:51 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015E31A49F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:00:03 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so19505768pgh.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjK5pV8lbB2+/iOpg5dZ+FqsEmAxLEbjxKcHJJZtats=;
        b=Cb7mojGp5V/dmR3xIWSy3C5h1dAUB+67iYTjOwzrvjU/baqnzYeuM+9j4dFADpKXlR
         rHZc4yfBF9VzP750vYbG2dgoWSjYqYk7pbhL7yfdguF1LFMFf95XSTy5Zt1ZrWIiZFZ4
         KIB+O4BRYWWv9Qe5Dy3I8uizc4ckekucSARK4n5QgDIFXXzzEn6CojQrjU/mC9z/slyY
         mm8CtsMGNM8wf4UwV33cwLBwK9oU6cLL1bmDLkOLxlUcxRdI3PLRdCeKoVa/1z140uQh
         q9qK387DTMIRhj95KUq8dVmXM4jmOvRfoP8bWO+D+To+vcPfFmuYsMWPlorqJMiaoMEM
         GHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjK5pV8lbB2+/iOpg5dZ+FqsEmAxLEbjxKcHJJZtats=;
        b=rUynzrTwlfyuaF2MgBQR0m3fsMNGAzsVEYbdL2n3yvkGQc4gt1himI6EY+w5JQOHGY
         HW9CW3YFZOdgHbdpy4cH052x/0zSRCVE361GfxyMUbFWBYKwRzbfqFbhyTWEav121LZr
         ad1ok4XAWhXEH7GzBRles+7Uw8ATcYLQvD1Pj3WyzcznwiqM9YdSFAFm+/2jLJW78thl
         JxvCUA0T6URGurG2KTVy1FsoLcF0Lh05Vq5hP3F0ikYRtJfFZnvnlrObJN7s1pRdNv75
         Q1/WlJimN9HC94Bxx9hA/7H426O8qmn/wZ+AqjeDNziBZ1sizXYAvJhP/2J3xNdn7jC6
         WE7w==
X-Gm-Message-State: AFqh2kok9g2yOUDaFoU9hefW4s1u2hMO3MIbPo4hB9LpQmpwy4AaV7RF
        13Kn0+RfkqTIDjg2QkGnS+E=
X-Google-Smtp-Source: AMrXdXuBl7tE8Nkx4UQUUlvHQnT8+6ZszDtfmoQ/QXjkPdrVIlHq7pgD6rBIJzXONVOElLrCXA1Zog==
X-Received: by 2002:aa7:99da:0:b0:58d:90d2:8b12 with SMTP id v26-20020aa799da000000b0058d90d28b12mr8038396pfi.3.1673870403272;
        Mon, 16 Jan 2023 04:00:03 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id x186-20020a6231c3000000b0058bcb42dd1asm3687140pfx.111.2023.01.16.03.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:00:02 -0800 (PST)
Date:   Mon, 16 Jan 2023 11:59:53 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     cl@linux.com, sdf@google.com, yhs@fb.com,
        Rong Tao <rongtao@cestc.cn>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: Functions used internally should not be put into
 slub_def.h
Message-ID: <Y8U8OfoVwkJPdJcv@localhost>
References: <tencent_ABA832E296819D1053D6C625ADCAF76BC706@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_ABA832E296819D1053D6C625ADCAF76BC706@qq.com>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 04:50:05PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>
> commit 40f3bf0cb04c("mm: Convert struct page to struct slab in functions
> used by other subsystems") introduce 'slab_address()' and 'struct slab'
> in slab_def.h(CONFIG_SLAB) and slub_def.h(CONFIG_SLUB). When referencing
> a header file <linux/slub_def.h> in a module or BPF code, 'slab_address()'
> and 'struct slab' are not recognized, resulting in incomplete and
> undefined errors(see bcc slabratetop.py error [0]).
> 

Hello Rong,

IMO sl*b_def.h is not intended to be used externally.
and I'm not sure if it's worth for -stable release too.

IIUC The reason for slabratetop.py to rely on sl*b_def.h is to read
cachep->cache and cachep->size.

I think this can be solved if you use a tool that supports BPF Type Format?

> Moving the function definitions of reference data structures such as
> struct slab and slab_address() such as nearest_obj(), obj_to_index(),
> and objs_per_slab() to the internal header file slab.h solves this
> fatal problem.
>
> [0] https://github.com/iovisor/bcc/issues/4438
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  include/linux/slab_def.h | 33 --------------------
>  include/linux/slub_def.h | 32 -------------------
>  mm/slab.h                | 66 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 65 deletions(-)
> 
> diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> index 5834bad8ad78..5658b5fddf9b 100644
> --- a/include/linux/slab_def.h
> +++ b/include/linux/slab_def.h
> @@ -88,37 +88,4 @@ struct kmem_cache {
>  	struct kmem_cache_node *node[MAX_NUMNODES];
>  };
>  
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
>  #endif	/* _LINUX_SLAB_DEF_H */
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index aa0ee1678d29..660fd6b2a748 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -163,36 +163,4 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
>  
>  void *fixup_red_left(struct kmem_cache *s, void *p);
>  
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
>  #endif /* _LINUX_SLUB_DEF_H */
> diff --git a/mm/slab.h b/mm/slab.h
> index 7cc432969945..38350a0efa91 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -227,10 +227,76 @@ struct kmem_cache {
>  
>  #ifdef CONFIG_SLAB
>  #include <linux/slab_def.h>
> +
> +static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
> +				void *x)
> +{
> +	void *object = x - (x - slab->s_mem) % cache->size;
> +	void *last_object = slab->s_mem + (cache->num - 1) * cache->size;
> +
> +	if (unlikely(object > last_object))
> +		return last_object;
> +	else
> +		return object;
> +}
> +
> +/*
> + * We want to avoid an expensive divide : (offset / cache->size)
> + *   Using the fact that size is a constant for a particular cache,
> + *   we can replace (offset / cache->size) by
> + *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
> + */
> +static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> +					const struct slab *slab, void *obj)
> +{
> +	u32 offset = (obj - slab->s_mem);
> +	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
> +}
> +
> +static inline int objs_per_slab(const struct kmem_cache *cache,
> +				     const struct slab *slab)
> +{
> +	if (is_kfence_address(slab_address(slab)))
> +		return 1;
> +	return cache->num;
> +}
>  #endif
>  
>  #ifdef CONFIG_SLUB
>  #include <linux/slub_def.h>
> +
> +static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
> +				void *x) {
> +	void *object = x - (x - slab_address(slab)) % cache->size;
> +	void *last_object = slab_address(slab) +
> +		(slab->objects - 1) * cache->size;
> +	void *result = (unlikely(object > last_object)) ? last_object : object;
> +
> +	result = fixup_red_left(cache, result);
> +	return result;
> +}
> +
> +/* Determine object index from a given position */
> +static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
> +					  void *addr, void *obj)
> +{
> +	return reciprocal_divide(kasan_reset_tag(obj) - addr,
> +				 cache->reciprocal_size);
> +}
> +
> +static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> +					const struct slab *slab, void *obj)
> +{
> +	if (is_kfence_address(obj))
> +		return 0;
> +	return __obj_to_index(cache, slab_address(slab), obj);
> +}
> +
> +static inline int objs_per_slab(const struct kmem_cache *cache,
> +				     const struct slab *slab)
> +{
> +	return slab->objects;
> +}
>  #endif
>  
>  #include <linux/memcontrol.h>
> -- 
> 2.39.0
> 
