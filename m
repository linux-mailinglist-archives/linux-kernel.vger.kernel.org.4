Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9084D6399FA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 11:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiK0Kym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 05:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiK0Kyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 05:54:39 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B097655
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 02:54:38 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso11421010pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 02:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaGLCyXdBMIaKuINsSow+H91A2R/a1Mjh2wpGhwGfqc=;
        b=Lr3b8t+b+nSA4PI/Pfz5w8RtWZ0CYsK0Qx+29vlI65Y9TzCMP4rmS7qnx69Ohy0cMk
         n9P6TQiWiDHSrKXfRdHwhWUw8mAk2vSPJqDpViCtxZ6njrYzkNDw63j60++ACy1efjEa
         0mRS6RGREsTNjaEo/PKxwQFjwLoYt+r3kZa1DzUKUssPkr5QgqvaK28TS0xcYf0PuUab
         jbQTeSLjuOUW8NudOa/XT61TzHp2T/IK8zp+3baM4Sj2ZS5dNpODOSOcK+cHgIsPlJTk
         LQb0LVwmbNlaQ405kK5SLpisHMo5V5mmXAfPRf6SiWFLF4k3SeWzNmWIUoVtdIgXXRTB
         NPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaGLCyXdBMIaKuINsSow+H91A2R/a1Mjh2wpGhwGfqc=;
        b=nq4eCi4Xkp855BHeCfqIO7CtLOzegfYij0xD0yiImAOI8BpFodrcnFdnTBSZK065cV
         ZKFGaiSmNtt9G0V8AxnFfIpHj2KgZeKC6gs82ICru92JzRFEqdpMUgGgLT4pXlFMq90M
         eE+ogaOtyWBtiL+n3xPL6o6+CMR07nYbB5ZYzAhSU1SxMG5dBaH7h+t4W8JiiQ2/BGJG
         mshRfSeTDQhoOi/aeNnvTdDNZ2sOaxePMDrV6QiG7spufwkGEBFng1LlgnV59x83ZLYQ
         rgw5yrr05MiK0m0e5pjEdWZ0aOMoINqGIygOnoL5YJyZ81ZY4E/PbQ4LTiJ2xHQT2qP8
         UM3w==
X-Gm-Message-State: ANoB5plxJ7IBK/SnCoYVs1kxHQa60/jgaIOis6prDLENSoTxXZgLcp3Z
        QIXcpXr0Hx4rfNdY9k99ILA=
X-Google-Smtp-Source: AA0mqf6Q4OvnuAJ3a6PQCQkeShpgc1L6HV00PSdTaTzyvG1/h9Bsf5dTkPMiPc9yM2saAJ7+DqHn7Q==
X-Received: by 2002:a17:90a:eac2:b0:219:484:e955 with SMTP id ev2-20020a17090aeac200b002190484e955mr13854997pjb.214.1669546477967;
        Sun, 27 Nov 2022 02:54:37 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id s33-20020a63ff61000000b004772abe41f6sm5071054pgk.83.2022.11.27.02.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 02:54:36 -0800 (PST)
Date:   Sun, 27 Nov 2022 19:54:30 +0900
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
Message-ID: <Y4NB5i4WBvLr1GGZ@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-10-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121171202.22080-10-vbabka@suse.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:11:59PM +0100, Vlastimil Babka wrote:
> In the following patch we want to introduce CONFIG_SLUB_TINY allocation
> paths that don't use the percpu slab. To prepare, refactor the
> allocation functions:
> 
> Split out __slab_alloc_node() from slab_alloc_node() where the former
> does the actual allocation and the latter calls the pre/post hooks.
> 
> Analogically, split out __kmem_cache_alloc_bulk() from
> kmem_cache_alloc_bulk().
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 127 +++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 77 insertions(+), 50 deletions(-)

[...]

> +
> +/* Note that interrupts must be enabled when calling this function. */
> +int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
> +			  void **p)
> +{
> +	int i;
> +	struct obj_cgroup *objcg = NULL;
> +
> +	/* memcg and kmem_cache debug support */
> +	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
> +	if (unlikely(!s))
> +		return false;
> +
> +	i = __kmem_cache_alloc_bulk(s, flags, size, p, objcg);
> +
> +	/*
> +	 * memcg and kmem_cache debug support and memory initialization.
> +	 * Done outside of the IRQ disabled fastpath loop.
> +	 */
> +	if (i != 0)
> +		slab_post_alloc_hook(s, objcg, flags, size, p,
> +				slab_want_init_on_alloc(flags, s));

This patch looks mostly good but wondering what happens if someone calls it with size == 0
so it does not call slab_post_alloc_hook()?

> +	return i;
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_bulk);
>  
> -- 
> 2.38.1
> 

-- 
Thanks,
Hyeonggon
