Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20EB63788C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKXMHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKXMHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:07:11 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB72A28B8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:06:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so1470490pjc.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAX5cjv3FV+pwILnpnHsO44lgFo9KZIJeSsheZZLVIg=;
        b=hvY1uDyL0ey9sUdH1VlAPTnxAQ6Z4wMH2cJPwB39IuOLSrbbwT6J/MPAr422yfgWLc
         5WGaaaTTywlbrL3NoU1/EHsbe9MiwUOq2TpFeUEOQSN6X4ePtVOgRn294LHwnYb7ycL4
         NoCmjKIE+2tOJjJFVlEattu1U1hGXPJL/ffS1GurdZM0VamAPKr9iWm7xyDk+vnh8JwP
         Uh86JffdWQSnDgAmeRDZ09uwsBEXgvcIFmqj+UvRb8SohnfsfpUTybWWgoLD0vcVLLHG
         Cu9aX1FLr0ptzWJLb3D212Mt5U+dTjKS3mucKL3wZALgrFmBOqqORl+JPrLHOX1MwMW8
         O8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAX5cjv3FV+pwILnpnHsO44lgFo9KZIJeSsheZZLVIg=;
        b=TypOyKV+jOdl5ZbyedPo5+7dZlqGjberBc5vBA8Oq3AHs9x1LawelDF9rTQwMGDbby
         tBvm8JDhMbHvfrgWxtNnZYiQOi/iIa3i4Dg3bp7qHBjXsyP/wqcsCwIF7hjlKssZkMAp
         HKaRMO/yCDXhTAasKxWu8Ix9kDkf9R5TPkWB2wzKbrYUs0A5Kp2RKKIuCbFo/eW5RRAb
         oH9SbdvKy1GT5RGDKip7KIn45N6HXQdSooYBun+lfQqVbKeHd1Nf/jqkvkA5ReU+fuJI
         LRwOYzlJR6WvpVBF3HTf6qKSoqM/+LExWKUOeVgj0006EqKR13LqjixtuTKb443Om2An
         froA==
X-Gm-Message-State: ANoB5pkzvU1pkVx03ieDz7R5CsetkEyXgPwKz5+K7TJgSc34wSKYaqOU
        uwHKlgKVBj0ngnN3RruCxjc=
X-Google-Smtp-Source: AA0mqf5pZO7aBuavuyzfuW0tbHgET6lLrCyFD/qydLNuN75Z1M9V0V9SMX2yq7hOSsMDdB81BXMWVg==
X-Received: by 2002:a17:90b:2d8b:b0:202:f88d:587 with SMTP id sj11-20020a17090b2d8b00b00202f88d0587mr36177116pjb.232.1669291572617;
        Thu, 24 Nov 2022 04:06:12 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id s1-20020a625e01000000b0056cea9530b6sm1028976pfb.202.2022.11.24.04.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 04:06:11 -0800 (PST)
Date:   Thu, 24 Nov 2022 21:06:05 +0900
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
Subject: Re: [PATCH 06/12] mm, slub: don't create kmalloc-rcl caches with
 CONFIG_SLUB_TINY
Message-ID: <Y39eLaW0mDNrHI6i@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-7-vbabka@suse.cz>
 <d77498f8-b15f-9dae-1803-2d2bbb99da50@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d77498f8-b15f-9dae-1803-2d2bbb99da50@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 02:53:43PM +0100, Vlastimil Babka wrote:
> On 11/21/22 18:11, Vlastimil Babka wrote:
> > Distinguishing kmalloc(__GFP_RECLAIMABLE) can help against fragmentation
> > by grouping pages by mobility, but on tiny systems the extra memory
> > overhead of separate set of kmalloc-rcl caches will probably be worse,
> > and mobility grouping likely disabled anyway.
> > 
> > Thus with CONFIG_SLUB_TINY, don't create kmalloc-rcl caches and use the
> > regular ones.
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Fixed up in response to lkp report for a MEMCG_KMEM+SLUB_TINY combo:
> ---8<---
> From c1ec0b924850a2863d061f316615d596176f15bb Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 15 Nov 2022 18:19:28 +0100
> Subject: [PATCH 06/12] mm, slub: don't create kmalloc-rcl caches with
>  CONFIG_SLUB_TINY
> 
> Distinguishing kmalloc(__GFP_RECLAIMABLE) can help against fragmentation
> by grouping pages by mobility, but on tiny systems the extra memory
> overhead of separate set of kmalloc-rcl caches will probably be worse,
> and mobility grouping likely disabled anyway.
> 
> Thus with CONFIG_SLUB_TINY, don't create kmalloc-rcl caches and use the
> regular ones.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h |  9 +++++++--
>  mm/slab_common.c     | 10 ++++++++--
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 45efc6c553b8..ae2d19ec8467 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -336,12 +336,17 @@ enum kmalloc_cache_type {
>  #endif
>  #ifndef CONFIG_MEMCG_KMEM
>  	KMALLOC_CGROUP = KMALLOC_NORMAL,
> -#else
> -	KMALLOC_CGROUP,
>  #endif
> +#ifdef CONFIG_SLUB_TINY
> +	KMALLOC_RECLAIM = KMALLOC_NORMAL,
> +#else
>  	KMALLOC_RECLAIM,
> +#endif
>  #ifdef CONFIG_ZONE_DMA
>  	KMALLOC_DMA,
> +#endif
> +#ifdef CONFIG_MEMCG_KMEM
> +	KMALLOC_CGROUP,
>  #endif
>  	NR_KMALLOC_TYPES
>  };

Can you please elaborate what the lkp report was about
and how you fixed it? I'm not getting what the problem of previous
version is.

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a8cb5de255fc..907d52963806 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -770,10 +770,16 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
>  #define KMALLOC_CGROUP_NAME(sz)
>  #endif
>  
> +#ifndef CONFIG_SLUB_TINY
> +#define KMALLOC_RCL_NAME(sz)	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #sz,
> +#else
> +#define KMALLOC_RCL_NAME(sz)
> +#endif
> +
>  #define INIT_KMALLOC_INFO(__size, __short_size)			\
>  {								\
>  	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
> -	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size,	\
> +	KMALLOC_RCL_NAME(__short_size)				\
>  	KMALLOC_CGROUP_NAME(__short_size)			\
>  	KMALLOC_DMA_NAME(__short_size)				\
>  	.size = __size,						\
> @@ -859,7 +865,7 @@ void __init setup_kmalloc_cache_index_table(void)
>  static void __init
>  new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  {
> -	if (type == KMALLOC_RECLAIM) {
> +	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
>  		flags |= SLAB_RECLAIM_ACCOUNT;
>  	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
>  		if (mem_cgroup_kmem_disabled()) {
> -- 
> 2.38.1
>

Otherwise looks fine to me.

-- 
Thanks,
Hyeonggon
