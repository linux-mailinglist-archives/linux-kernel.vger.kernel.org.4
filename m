Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698A268EFAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjBHNUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBHNU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:20:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DB65594
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:20:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id mi9so18341336pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 05:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g86eJ6QvJFlbHJIyocK/98OVUIDMMEnl4mLvg+FChTQ=;
        b=jbjrgap1i+FY3/tFyhN2vOs25+zC7JxsqGpdwyY+rjr/5KnGF/yvfiBlofWB7gtVQp
         DXQjR5xPQvUtbsY4PryiQ0EcEv9NLTSG4lzPnxkPXBuopZ3WUrNJruHf++A+YgXGfUl9
         kADs8/I97UYSHuKrsU0gynWR6iFbsLgaJXvYTBaRjh1YcWZJizE+rTMumiP+Mi4WjdS8
         +mxOSFlwkLYyzjinMyPMoL2uZr03x+3XhTAsMAlAIq1fzmQlDzIuMQj4dhuYWydSkKWz
         BD3O4wJmOLIebOKgxbGamF0sirjkoO4wuJ1L3XspE/LkhBAmryizJkkgym+v/kvWVZZk
         vWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g86eJ6QvJFlbHJIyocK/98OVUIDMMEnl4mLvg+FChTQ=;
        b=Vnf8exyKJ2gLN4XyNLEcIA+qN+cp2TutwN/HPdGJmEXLFLB0zw10jnPiYu5458u1vr
         Z48jFoNLV7P4Ej9u8SbemNDJKnZGHVpHpRVQlD6MJNLSV5C8E4F73osJChv+G6EuJn+W
         X2AA9/BJ8TZko0DMOsTeYwxEhNSZtv5RH7KDFrEYVnzbCrm6qQpuhBGagS+Yop33K0NM
         RMRCfosqIA6oPr4EQuIRqqLTMc2gokkwMe3ZntyaXUQAshOUIJ7rZa1kbgJ++wvR5TvX
         X23LagKn0srKB5vX0UFp11EizTBBVztZyLieCmr0UPIOU+QqQHmEBbk/8Pq7fCH2gbZq
         U+ag==
X-Gm-Message-State: AO0yUKWzhFVupcAf4fQ7LnoqHTHaBZJtVMlLMAqPc3xgxIrRf0VUMjJy
        3UEnZalBrJP6ic2BsKhJi5E=
X-Google-Smtp-Source: AK7set89Q7UFM+eQJTwPt6x/a6WVYkssqTbk8s31CP086+0uVA20JhwsxVftwSaeuHBYopdknZW9OQ==
X-Received: by 2002:a05:6a20:1444:b0:bc:ec65:a73f with SMTP id a4-20020a056a20144400b000bcec65a73fmr9589972pzi.58.1675862426229;
        Wed, 08 Feb 2023 05:20:26 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78554000000b005921c46cbadsm11407403pfn.99.2023.02.08.05.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 05:20:24 -0800 (PST)
Date:   Wed, 8 Feb 2023 13:20:14 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: mm, slab/slub: Ensure kmem_cache_alloc_bulk() is available early
Message-ID: <Y+OhjtpYuWbfYZNM@localhost>
References: <202302011308.f53123d2-oliver.sang@intel.com>
 <87o7qdzfay.ffs@tglx>
 <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
 <875ycdwyx6.ffs@tglx>
 <871qn1wofe.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qn1wofe.ffs@tglx>
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

On Tue, Feb 07, 2023 at 03:16:53PM +0100, Thomas Gleixner wrote:
> The memory allocators are available during early boot even in the phase
> where interrupts are disabled and scheduling is not yet possible.
> 
> The setup is so that GFP_KERNEL allocations work in this phase without
> causing might_alloc() splats to be emitted because the system state is
> SYSTEM_BOOTING at that point which prevents the warnings to trigger.
> 
> Most allocation/free functions use local_irq_save()/restore() or a lock
> variant of that. But kmem_cache_alloc_bulk() and kmem_cache_free_bulk() use
> local_[lock]_irq_disable()/enable(), which leads to a lockdep warning when
> interrupts are enabled during the early boot phase.
> 
> This went unnoticed so far as there are no early users of these
> interfaces. The upcoming conversion of the interrupt descriptor store from
> radix_tree to maple_tree triggered this warning as maple_tree uses the bulk
> interface.
> 
> Cure this by moving the kmem_cache_alloc/free() bulk variants of SLUB and
> SLAB to local[_lock]_irq_save()/restore().
> 
> There is obviously no reclaim possible and required at this point so there
> is no need to expand this coverage further.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> Initial version: https://lore.kernel.org/r/87o7qdzfay.ffs@tglx
> Changes: Update SLAB as well and add changelog
> ---
>  mm/slab.c |   18 ++++++++++--------
>  mm/slub.c |    9 +++++----
>  2 files changed, 15 insertions(+), 12 deletions(-)
> 
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3479,14 +3479,15 @@ cache_alloc_debugcheck_after_bulk(struct
>  int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  			  void **p)
>  {
> -	size_t i;
>  	struct obj_cgroup *objcg = NULL;
> +	unsigned long irqflags;
> +	size_t i;
>  
>  	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
>  	if (!s)
>  		return 0;
>  
> -	local_irq_disable();
> +	local_irq_save(irqflags);
>  	for (i = 0; i < size; i++) {
>  		void *objp = kfence_alloc(s, s->object_size, flags) ?:
>  			     __do_cache_alloc(s, flags, NUMA_NO_NODE);
> @@ -3495,7 +3496,7 @@ int kmem_cache_alloc_bulk(struct kmem_ca
>  			goto error;
>  		p[i] = objp;
>  	}
> -	local_irq_enable();
> +	local_irq_restore(irqflags);
>  
>  	cache_alloc_debugcheck_after_bulk(s, flags, size, p, _RET_IP_);
>  
> @@ -3508,7 +3509,7 @@ int kmem_cache_alloc_bulk(struct kmem_ca
>  	/* FIXME: Trace call missing. Christoph would like a bulk variant */
>  	return size;
>  error:
> -	local_irq_enable();
> +	local_irq_restore(irqflags);
>  	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
>  	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
>  	kmem_cache_free_bulk(s, i, p);
> @@ -3610,8 +3611,9 @@ EXPORT_SYMBOL(kmem_cache_free);
>  
>  void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
>  {
> +	unsigned long flags;
>  
> -	local_irq_disable();
> +	local_irq_save(flags);
>  	for (int i = 0; i < size; i++) {
>  		void *objp = p[i];
>  		struct kmem_cache *s;
> @@ -3621,9 +3623,9 @@ void kmem_cache_free_bulk(struct kmem_ca
>  
>  			/* called via kfree_bulk */
>  			if (!folio_test_slab(folio)) {
> -				local_irq_enable();
> +				local_irq_restore(flags);
>  				free_large_kmalloc(folio, objp);
> -				local_irq_disable();
> +				local_irq_save(flags);
>  				continue;
>  			}
>  			s = folio_slab(folio)->slab_cache;
> @@ -3640,7 +3642,7 @@ void kmem_cache_free_bulk(struct kmem_ca
>  
>  		__cache_free(s, objp, _RET_IP_);
>  	}
> -	local_irq_enable();
> +	local_irq_restore(flags);
>  
>  	/* FIXME: add tracing */
>  }
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3913,6 +3913,7 @@ static inline int __kmem_cache_alloc_bul
>  			size_t size, void **p, struct obj_cgroup *objcg)
>  {
>  	struct kmem_cache_cpu *c;
> +	unsigned long irqflags;
>  	int i;
>  
>  	/*
> @@ -3921,7 +3922,7 @@ static inline int __kmem_cache_alloc_bul
>  	 * handlers invoking normal fastpath.
>  	 */
>  	c = slub_get_cpu_ptr(s->cpu_slab);
> -	local_lock_irq(&s->cpu_slab->lock);
> +	local_lock_irqsave(&s->cpu_slab->lock, irqflags);
>  
>  	for (i = 0; i < size; i++) {
>  		void *object = kfence_alloc(s, s->object_size, flags);
> @@ -3942,7 +3943,7 @@ static inline int __kmem_cache_alloc_bul
>  			 */
>  			c->tid = next_tid(c->tid);
>  
> -			local_unlock_irq(&s->cpu_slab->lock);
> +			local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
>  
>  			/*
>  			 * Invoking slow path likely have side-effect
> @@ -3956,7 +3957,7 @@ static inline int __kmem_cache_alloc_bul
>  			c = this_cpu_ptr(s->cpu_slab);
>  			maybe_wipe_obj_freeptr(s, p[i]);
>  
> -			local_lock_irq(&s->cpu_slab->lock);
> +			local_lock_irqsave(&s->cpu_slab->lock, irqflags);
>  
>  			continue; /* goto for-loop */
>  		}
> @@ -3965,7 +3966,7 @@ static inline int __kmem_cache_alloc_bul
>  		maybe_wipe_obj_freeptr(s, p[i]);
>  	}
>  	c->tid = next_tid(c->tid);
> -	local_unlock_irq(&s->cpu_slab->lock);
> +	local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);

Looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

>  	slub_put_cpu_ptr(s->cpu_slab);
>  
>  	return i;
> 
