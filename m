Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A046AE238
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCGOZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCGOZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:25:16 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF26392BC3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:20:46 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p20so14159356plw.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678198828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OGeuDm25l7pIlwQ6+UAa3/akLy9f+p8fTWJVRgtfmU4=;
        b=LeYiLpFHctF9fR7ykudTlA2w+uAmWZ47qqhuNI7NkTsshvbtwBNtTv/EVXBqJhHlw8
         7OOZ43jpDZEuWiYlf4a7pGCxIqq8qne5tJtHbOVQa97pBBJn04XnQtPBI4Mv/gviw8De
         jD3l8FW53Nv9WdzW0aRrmc6crmVK5zpl/3X14lovRUwqnQWPXyfaHYWuLkpq6W/Hak5B
         GesjDcdTRh4ucGHMAG0yDdesvN9+VqOwUrDKqX3zvlfC83XYacr8Ocsl4EiJcqHbuM97
         hPth980I/bY2xxwFMgUSFj8THsbjnI9A0a6GmG85OEWrg72OpJMgmO3SENBET+BxgJo5
         HmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678198828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGeuDm25l7pIlwQ6+UAa3/akLy9f+p8fTWJVRgtfmU4=;
        b=D8aAJVtI4rIkU6uc5CwWJHhPNiKZA+mezg0m3nWGAUflsJ57v+1C7BhxTeMgo2L+bW
         cslU8SstEtqBg/XghD9I7e8tgqE6NEHvUeDHiNB/WOwRLJU64e27hdcZhv+p2VeXB8u8
         dTMD0iFipBc217gnpm5I9V27pTpUSP8144uwf/ZbrGVrut9VyrFhmZE+uyNalPdcoNyS
         8gTiQK3jHFrUXm/BmYPY6zBLeKKvqBS6VlRenZusaQneraHD0OpabLIogWE7xKR/mmfL
         8VjBm3lPznZ1Ggn+X+iLcKPWD9gY/eIMd4fySKoTIy9xn0I5CXq4EBFCVibxSJ7frADC
         ZZ7A==
X-Gm-Message-State: AO0yUKWSc8pXl/27uXFNIeU0YoERJ87h4l0nrjJgEeuAqm0W6w/wd9pf
        WIWHJ4rSCbvYUapp1Nh0cKs=
X-Google-Smtp-Source: AK7set//XoDivEj3N+uGgAm+/oYIUSG2OmdUvW4Yz8KCyqop3LqKCRH/KH1Q/j9YTS4WEsyrrBj5zQ==
X-Received: by 2002:a17:902:b781:b0:19c:eb9a:770d with SMTP id e1-20020a170902b78100b0019ceb9a770dmr12538988pls.53.1678198828322;
        Tue, 07 Mar 2023 06:20:28 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b0019a723a831dsm8495517ply.158.2023.03.07.06.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 06:20:27 -0800 (PST)
Date:   Tue, 7 Mar 2023 14:20:20 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, xuqiang36@huawei.com
Subject: Re: [RFC] mm/slub: Reduce memory consumption in extreme scenarios
Message-ID: <ZAdIJKkT8VHdbPs9@localhost>
References: <20230307082811.120774-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307082811.120774-1-chenjun102@huawei.com>
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 08:28:11AM +0000, Chen Jun wrote:
> If call kmalloc_node with NO __GFP_THISNODE and node[A] with no memory.
> Slub will alloc a slub page which is not belong to A, and put the page
> to kmem_cache_node[page_to_nid(page)]. The page can not be reused
> at next calling, because NULL will be get from get_partical().
> That make kmalloc_node consume more memory.

Hello,

elaborating a little bit:

"When kmalloc_node() is called without __GFP_THISNODE and the target node
lacks sufficient memory, SLUB allocates a folio from a different node other
than the requested node, instead of taking a partial slab from it.

However, since the allocated folio does not belong to the requested node,
it is deactivated and added to the partial slab list of the node it
belongs to.

This behavior can result in excessive memory usage when the requested
node has insufficient memory, as SLUB will repeatedly allocate folios from
other nodes without reusing the previously allocated ones.

To prevent memory wastage, take a partial slab from a different node when
the requested node has no partial slab and __GFP_THISNODE is not explicitly
specified."

> On qemu with 4 numas and each numa has 1G memory, Write a test ko
> to call kmalloc_node(196, 0xd20c0, 3) for 5 * 1024 * 1024 times.
> 
> cat /proc/slabinfo shows:
> kmalloc-256       4302317 15151808    256   32    2 : tunables..
> 
> the total objects is much more then active objects.
> 
> After this patch, cat /prac/slubinfo shows:
> kmalloc-256       5244950 5245088    256   32    2 : tunables..
>
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>  mm/slub.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 39327e98fce3..c0090a5de54e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2384,7 +2384,7 @@ static void *get_partial(struct kmem_cache *s, int node, struct partial_context
>  		searchnode = numa_mem_id();
>  
>  	object = get_partial_node(s, get_node(s, searchnode), pc);
> -	if (object || node != NUMA_NO_NODE)
> +	if (object || (node != NUMA_NO_NODE && (pc->flags & __GFP_THISNODE)))
>  		return object;

I think the problem here is to avoid taking a partial slab from
different node than the requested node even if __GFP_THISNODE is not set.
(and then allocating new slab instead)

Thus this hunk makes sense to me,
even if SLUB currently do not implement __GFP_THISNODE semantics.

>  	return get_any_partial(s, pc);
> @@ -3069,6 +3069,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	struct slab *slab;
>  	unsigned long flags;
>  	struct partial_context pc;
> +	int try_thisndoe = 0;
>
>  
>  	stat(s, ALLOC_SLOWPATH);
>  
> @@ -3181,8 +3182,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	}
>  
>  new_objects:
> -
>  	pc.flags = gfpflags;
> +
> +	/* Try to get page from specific node even if __GFP_THISNODE is not set */
> +	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
> +			pc.flags |= __GFP_THISNODE;
> +
>  	pc.slab = &slab;
>  	pc.orig_size = orig_size;
>  	freelist = get_partial(s, node, &pc);
> @@ -3190,10 +3195,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		goto check_new_slab;
>  
>  	slub_put_cpu_ptr(s->cpu_slab);
> -	slab = new_slab(s, gfpflags, node);
> +	slab = new_slab(s, pc.flags, node);
>  	c = slub_get_cpu_ptr(s->cpu_slab);
>  
>  	if (unlikely(!slab)) {
> +		/* Try to get page from any other node */
> +		if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode) {
> +			try_thisnode = 0;
> +			goto new_objects;
> +		}
> +
>  		slab_out_of_memory(s, gfpflags, node);
>  		return NULL;

But these hunks do not make sense to me.
Why force __GFP_THISNODE even when the caller did not specify it?

(Apart from the fact that try_thisnode is defined as try_thisndoe,
 and try_thisnode is never set to nonzero value.)

IMHO the first hunk is enough to solve the problem.

Thanks,
Hyeonggon

>  	}
> -- 
> 2.17.1
> 
> 
