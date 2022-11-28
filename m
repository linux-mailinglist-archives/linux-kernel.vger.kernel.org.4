Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD8663A8E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiK1NGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiK1NGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:06:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD8BBF6E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:06:22 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id k5so9402666pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B3cwuU9wjQ8VbfKUTNnbiIt2B8/rOnQ22JV6mreBMhw=;
        b=cPT++xvoRpH851YV9eYArPjV+xqU7oPu2rsB24Yh0VaoiI41HRHpq0BuI5kjhwJxrw
         OaauRFOykeddywo17as5H5aSfdb3k+ZRK1/HrbhkNJGO6DOeJi2sT+a4VpqYybQDQKis
         LaIAQLPbv5qwbRMFzzXZCxlxYom4ld5FpVwTHDRB9Kty4D6cM0eXW5bmtRdcMDJj7GSF
         rw1hW/1qPQQAtN9TTWY17ci9C9wYfKL4g6BZxDPd42udY0AUwikvzlnMDm+UuQjqRGvf
         uauJd5YIf+vCWVArhUPl5uZt/S+Jx2OzwUCUT7cex60mtf6t3INwYhhhtEWW/CCtmeFX
         1Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3cwuU9wjQ8VbfKUTNnbiIt2B8/rOnQ22JV6mreBMhw=;
        b=J6dFMjbD17I3i4ZUvDPpP6SIhzyE0Ce6l0a9xTZWfi0KS14kAM1tx7OL8oN7kiXjC5
         lxra/0aDDPfInE+tB3Bqa9ysg2k5cRrFedA+YbGufpYZAzCt8ioMQHo2J5/k1v5GUo0n
         KFTrfQhWNVumctoCD2KuVspcNnMGeS6DFsgBuouFKQwxpOPTNsltSUkARsD8BgSd3fA8
         4spCJ63SydoQ4jpon0m173iu7MPXYJhV+44Rbpg1Ve8bIW4F++cYDAvpBudfbpe4i1bx
         Pqunwxw+33tAczbXlnu0OjpfcHxfTDCnQDTK9+Lo4dxrlXjJbJ/dzW8W63hjz49X9EAi
         KOhg==
X-Gm-Message-State: ANoB5pmXeR8RxCmQw1gSt4k7e7bV9evChZtOpFJwLxLaE2MLOXCY/tDM
        oNMQ2Pj6gqoPC0csNDisT7w=
X-Google-Smtp-Source: AA0mqf4eYVs0SA4FTr5QWchx8Qk7YnD3lg4y6T/+aoiZj0IfOxBEayp7dPUotwd21M+rJErjpzG5NQ==
X-Received: by 2002:a17:90a:7d0d:b0:1fa:b51d:8d83 with SMTP id g13-20020a17090a7d0d00b001fab51d8d83mr32931270pjl.169.1669640782164;
        Mon, 28 Nov 2022 05:06:22 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902e88d00b00183c67844aesm8889847plg.22.2022.11.28.05.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:06:21 -0800 (PST)
Date:   Mon, 28 Nov 2022 22:06:15 +0900
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
Subject: Re: [PATCH 09/12] mm, slub: split out allocations from pre/post hooks
Message-ID: <Y4SyR/6C+o/r8DX3@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-10-vbabka@suse.cz>
 <Y4NB5i4WBvLr1GGZ@hyeyoo>
 <863dfdbb-2efc-a1d4-3cb1-3edaa67f67bd@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <863dfdbb-2efc-a1d4-3cb1-3edaa67f67bd@suse.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 12:01:39AM +0100, Vlastimil Babka wrote:
> On 11/27/22 11:54, Hyeonggon Yoo wrote:
> > On Mon, Nov 21, 2022 at 06:11:59PM +0100, Vlastimil Babka wrote:
> >> In the following patch we want to introduce CONFIG_SLUB_TINY allocation
> >> paths that don't use the percpu slab. To prepare, refactor the
> >> allocation functions:
> >> 
> >> Split out __slab_alloc_node() from slab_alloc_node() where the former
> >> does the actual allocation and the latter calls the pre/post hooks.
> >> 
> >> Analogically, split out __kmem_cache_alloc_bulk() from
> >> kmem_cache_alloc_bulk().
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/slub.c | 127 +++++++++++++++++++++++++++++++++---------------------
> >>  1 file changed, 77 insertions(+), 50 deletions(-)
> > 
> > [...]
> > 
> >> +
> >> +/* Note that interrupts must be enabled when calling this function. */
> >> +int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
> >> +			  void **p)
> >> +{
> >> +	int i;
> >> +	struct obj_cgroup *objcg = NULL;
> >> +
> >> +	/* memcg and kmem_cache debug support */
> >> +	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
> >> +	if (unlikely(!s))
> >> +		return false;
> >> +
> >> +	i = __kmem_cache_alloc_bulk(s, flags, size, p, objcg);
> >> +
> >> +	/*
> >> +	 * memcg and kmem_cache debug support and memory initialization.
> >> +	 * Done outside of the IRQ disabled fastpath loop.
> >> +	 */
> >> +	if (i != 0)
> >> +		slab_post_alloc_hook(s, objcg, flags, size, p,
> >> +				slab_want_init_on_alloc(flags, s));
> > 
> > This patch looks mostly good but wondering what happens if someone calls it with size == 0
> > so it does not call slab_post_alloc_hook()?
> 
> Hmm looks like in that case we miss doing obj_cgroup_put(objcg) in
> memcg_slab_post_alloc_hook(). Good catch, thanks!
> 
> Fixing up, also a "return false" from int function
> (existed also before this patch).
> 
> ----8<----
> diff --git a/mm/slub.c b/mm/slub.c
> index b74c4664160e..88f0ce49caab 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3888,10 +3888,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	int i;
>  	struct obj_cgroup *objcg = NULL;
>  
> +	if (!size)
> +		return 0;
> +
>  	/* memcg and kmem_cache debug support */
>  	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
>  	if (unlikely(!s))
> -		return false;
> +		return 0;
>  
>  	i = __kmem_cache_alloc_bulk(s, flags, size, p, objcg);

With that,

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

-- 
Thanks,
Hyeonggon
