Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6807160AEE5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJXPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiJXPVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:21:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE032F000
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:04:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso6568197pjc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=54kX8KDXQhkF+Q470pyPNzIGi7dKEvffdL2ryBeituk=;
        b=P1UXV1aQ2xIn6+nfeoVYOCwP23g1rKm7rOqwVcSXyueYjNUUEjmr4djsO8Maj/xzlD
         ttEup0VfXhEmGqGMUpsC7DwrAbb7qwGHVJi3cdEWQGtKbUD2vpHTDXsjmSBytEfCMf9t
         MvMeXRyRdrDBAW0VXeXUEfydQTbrMKB3Y0Og5oHDWgVAw7eSwIUR43bOE3xgOvsjC/qx
         ObwEsZtmO0/C8uJSOv9M6XZ03SKmq/+Qrs+valNgrIEudc8d7reL/C2bqLnwJr+LGQ1y
         fJ+btOODQfPadp+0Slrk5WlePbWgVWUKb7YpkRPQj35M3lGc09ntgqWFY5cMMker4gHC
         YWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54kX8KDXQhkF+Q470pyPNzIGi7dKEvffdL2ryBeituk=;
        b=wQsxqv8Y6cLiCnoFobC2dkS4T/CaiYTAyjSsnDZd+hHNja73bCoH9yFuehrcVJujlf
         kagAQDsykvwua4kwEzYssN0CyMnYgGMVEfsSyho2RkXjQv0uh5OEhV3laBzOsAzoF0Qj
         IDD9eV/NwQsV/W4o/4Q1n+RCw+9mt46rKeQID23ealJs+oG2+Q9YtR1oBg3p5GMLBt4e
         R0ZvMTCWzWG9kbDDnGgiqKDMtlgm6P6l5IhzLiS9gASSH0wNInCmbkxU6ca7J3yH4HrJ
         jUKm/SGH3dojTiRTwu/OJE61fVe15U/7d0Lvmyg+kVCbWM3Jx+b5gvyGBRTQ35r7QjlW
         zSTQ==
X-Gm-Message-State: ACrzQf1em0dgyRtfV6X36ERsVO6vYf98edoLYIH+7OlLGL+ispUn5f7R
        4JQWvulWGI6YgtaUmqqLRVc=
X-Google-Smtp-Source: AMsMyM6qTovmErhU3eWJrcBLdokz9s5GdSBhO0/sG3Ym4jLAcqs32AzsS0NTOYpgLK7fBWs9iNsHtg==
X-Received: by 2002:a17:903:18c:b0:186:994c:51b8 with SMTP id z12-20020a170903018c00b00186994c51b8mr9260281plg.44.1666620062372;
        Mon, 24 Oct 2022 07:01:02 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id v7-20020a17090abb8700b001faf7a88138sm5712448pjr.42.2022.10.24.07.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 07:01:01 -0700 (PDT)
Date:   Mon, 24 Oct 2022 23:00:55 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 1/3] mm/slub: only zero requested size of buffer for
 kzalloc when debug enabled
Message-ID: <Y1aal/VXQZRBwSgq@hyeyoo>
References: <20221021032405.1825078-1-feng.tang@intel.com>
 <20221021032405.1825078-2-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021032405.1825078-2-feng.tang@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:24:03AM +0800, Feng Tang wrote:
> kzalloc/kmalloc will round up the request size to a fixed size
> (mostly power of 2), so the allocated memory could be more than
> requested. Currently kzalloc family APIs will zero all the
> allocated memory.
> 
> To detect out-of-bound usage of the extra allocated memory, only
> zero the requested part, so that redzone sanity check could be
> added to the extra space later.
> 
> For kzalloc users who will call ksize() later and utilize this
> extra space, please be aware that the space is not zeroed any
> more when debug is enabled. (Thanks to Kees Cook's effort to
> sanitize all ksize() user cases [1], this won't be a big issue).
> 
> [1]. https://lore.kernel.org/all/20220922031013.2150682-1-keescook@chromium.org/#r
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/slab.c |  7 ++++---
>  mm/slab.h | 18 ++++++++++++++++--
>  mm/slub.c | 10 +++++++---
>  3 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index a5486ff8362a..4594de0e3d6b 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3253,7 +3253,8 @@ slab_alloc_node(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
>  	init = slab_want_init_on_alloc(flags, cachep);
>  
>  out:
> -	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
> +	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init,
> +				cachep->object_size);
>  	return objp;
>  }
>  
> @@ -3506,13 +3507,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	 * Done outside of the IRQ disabled section.
>  	 */
>  	slab_post_alloc_hook(s, objcg, flags, size, p,
> -				slab_want_init_on_alloc(flags, s));
> +			slab_want_init_on_alloc(flags, s), s->object_size);
>  	/* FIXME: Trace call missing. Christoph would like a bulk variant */
>  	return size;
>  error:
>  	local_irq_enable();
>  	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
>  	kmem_cache_free_bulk(s, i, p);
>  	return 0;
>  }
> diff --git a/mm/slab.h b/mm/slab.h
> index 0202a8c2f0d2..8b4ee02fc14a 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -720,12 +720,26 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>  
>  static inline void slab_post_alloc_hook(struct kmem_cache *s,
>  					struct obj_cgroup *objcg, gfp_t flags,
> -					size_t size, void **p, bool init)
> +					size_t size, void **p, bool init,
> +					unsigned int orig_size)
>  {
> +	unsigned int zero_size = s->object_size;
>  	size_t i;
>  
>  	flags &= gfp_allowed_mask;
>  
> +	/*
> +	 * For kmalloc object, the allocated memory size(object_size) is likely
> +	 * larger than the requested size(orig_size). If redzone check is
> +	 * enabled for the extra space, don't zero it, as it will be redzoned
> +	 * soon. The redzone operation for this extra space could be seen as a
> +	 * replacement of current poisoning under certain debug option, and
> +	 * won't break other sanity checks.
> +	 */
> +	if (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
> +	    (s->flags & SLAB_KMALLOC))
> +		zero_size = orig_size;
> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * kasan_slab_alloc and initialization memset must be
> @@ -736,7 +750,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>  	for (i = 0; i < size; i++) {
>  		p[i] = kasan_slab_alloc(s, p[i], flags, init);
>  		if (p[i] && init && !kasan_has_integrated_init())
> -			memset(p[i], 0, s->object_size);
> +			memset(p[i], 0, zero_size);
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, flags);
>  		kmsan_slab_alloc(s, p[i], flags);
> diff --git a/mm/slub.c b/mm/slub.c
> index 12354fb8d6e4..17292c2d3eee 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3395,7 +3395,11 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>  	init = slab_want_init_on_alloc(gfpflags, s);
>  
>  out:
> -	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
> +	/*
> +	 * When init equals 'true', like for kzalloc() family, only
> +	 * @orig_size bytes will be zeroed instead of s->object_size
> +	 */
> +	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
>  
>  	return object;
>  }
> @@ -3852,11 +3856,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	 * Done outside of the IRQ disabled fastpath loop.
>  	 */
>  	slab_post_alloc_hook(s, objcg, flags, size, p,
> -				slab_want_init_on_alloc(flags, s));
> +			slab_want_init_on_alloc(flags, s), s->object_size);
>  	return i;
>  error:
>  	slub_put_cpu_ptr(s->cpu_slab);
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
>  	kmem_cache_free_bulk(s, i, p);
>  	return 0;
>  }
> -- 
> 2.34.1

Looks good to me.

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
