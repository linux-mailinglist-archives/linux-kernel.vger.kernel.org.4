Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F1C6146AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKAJcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKAJb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:31:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B7C264F;
        Tue,  1 Nov 2022 02:31:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m6so13001818pfb.0;
        Tue, 01 Nov 2022 02:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9VIRZCiJ5gmKs+BRWjCnVIEMt23r/xHSISakg/E7V4=;
        b=a4+Nyl0dzTg6tWdyT+EPhpvC0t3GWT2WCwkIZyKpj+WPfyeEM72uxzp+gfBgHnCZwf
         rKd8jocwcm3msqO6mv3LB8Q+RoALCNejtj3YC7DJY1Fdltijdw0bjozyeDsjDa7H6/fQ
         w5WnfmgBDWKK2htESdGgUcEfa7MttbG8NKlQv6gX2qZtVTBJZ/RCGk8YjPalnlMWM6me
         MTbYsJLZ16ZwYAADfHnM3pMJajh4OZKv4EtQa39syLhJHc6hDbx+VkpjE3VFB+B+H+c4
         IBcfwNTZV6Keyxn+erezCJVoGvI8lBcDefORS8jeCtjzq3ZLfGnrZM5wD/P4daLJOpcE
         L78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9VIRZCiJ5gmKs+BRWjCnVIEMt23r/xHSISakg/E7V4=;
        b=rHVYWzywZTSqyV5R4ebAPS4+/d6rkAt+pm2CmEb2UJ0i31BUnJILGmt4DjAXwLfK+p
         9d+OrSo8Nza/FqHZ0CLK1nwRDvbkiy+304aPPAuuXhQngcQzH367NW8tqNqtj3SFoHiY
         OOhuDO4vbUKTSOY7I7AZ51TzsoxKiEVz6r3yYY7MXboJsEr76KX3ykJlqUin681Im5Et
         QLNPE1IVP22OkTxwxRrIUiPMbhahqYqS5gkdILj/V3VQp6COtMfW0wYs5di1Sj0VhLAm
         w2XflG3NeghxQKOTPe9Q1jF2nZtBWURnp6W7wlAHbrzM4LaN2QulhZdpPDMjVjA7D66+
         aALQ==
X-Gm-Message-State: ACrzQf2c83hyDhMZyVoXXe5Te1JgVVeb1WUKZ9Wb9KZQTFDQWAge6bmE
        hSndT9bncOd8iC9nuLLZBbI=
X-Google-Smtp-Source: AMsMyM7t0mLLMlLPTydO72rFm96lHi0wTH43Oka0AuC5lLv5H2McpH32BH2XxFe0sHZjMKTDSCYrAg==
X-Received: by 2002:aa7:88d4:0:b0:56c:ae9d:6fdf with SMTP id k20-20020aa788d4000000b0056cae9d6fdfmr18949920pff.41.1667295116599;
        Tue, 01 Nov 2022 02:31:56 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id e25-20020aa79819000000b0056bc1d7816dsm6216189pfl.99.2022.11.01.02.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 02:31:55 -0700 (PDT)
Date:   Tue, 1 Nov 2022 18:31:47 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     John Thomson <lists@johnthomson.fastmail.com.au>
Cc:     Feng Tang <feng.tang@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
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
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <Y2DngwUc7cLB0dG7@hyeyoo>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-2-feng.tang@intel.com>
 <becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com>
 <af2ba83d-c3f4-c6fb-794e-c2c7c0892c44@suse.cz>
 <Y180l6zUnNjdCoaE@feng-clx>
 <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
 <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 09:20:21AM +0000, John Thomson wrote:
> On Tue, 1 Nov 2022, at 07:57, Feng Tang wrote:
> > Hi Thomson,
> >
> > Thanks for testing!
> >
> > + mips maintainer and mail list. The original report is here
> >
> > https://lore.kernel.org/lkml/becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com/
>
> I am guessing my issue comes from __kmem_cache_alloc_lru accessing s->object_size when (kmem_cache) s is NULL?
> If that is the case, this change is not to blame, it only exposes the issue?
> 
> I get the following dmesg (note very early NULL kmem_cache) with the below change atop v6.1-rc3:
> 
> transfer started ......................................... transfer ok, time=2.02s
> setting up elf image... OK
> jumping to kernel code
> zimage at:     80B842A0 810B4EFC
> 
> Uncompressing Linux at load address 80001000
> 
> Copy device tree to address  80B80EE0
> 
> Now, booting the kernel...
> 
> [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #61 SMP Tue Nov  1 18:04:13 AEST 2022
> [    0.000000] slub: kmem_cache_alloc called with kmem_cache: 0x0
> [    0.000000] slub: __kmem_cache_alloc_lru called with kmem_cache: 0x0
> [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
> [    0.000000] printk: bootconsole [early0] enabled
> [    0.000000] CPU0 revision is: 0001992f (MIPS 1004Kc)
> [    0.000000] MIPS: machine is MikroTik RouterBOARD 760iGS
> 
> normal boot
> 
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 157527d7101b..10fcdf2520d2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3410,7 +3410,13 @@ static __always_inline
>  void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  			     gfp_t gfpflags)
>  {
> -	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> +	void *ret;
> +	if (IS_ERR_OR_NULL(s)) {
> +		pr_warn("slub: __kmem_cache_alloc_lru called with kmem_cache: %pSR\n", s);
> +		ret = slab_alloc(s, lru, gfpflags, _RET_IP_, 0);
> +	} else {
> +		ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> +	}
>  
>  	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
>  
> @@ -3419,6 +3425,8 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  
>  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
>  {
> +	if (IS_ERR_OR_NULL(s))
> +		pr_warn("slub: kmem_cache_alloc called with kmem_cache: %pSR\n", s);
>  	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc);
> @@ -3426,6 +3434,8 @@ EXPORT_SYMBOL(kmem_cache_alloc);
>  void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  			   gfp_t gfpflags)
>  {
> +	if (IS_ERR_OR_NULL(s))
> +		pr_warn("slub: __kmem_cache_alloc_lru called with kmem_cache: %pSR\n", s);
>  	return __kmem_cache_alloc_lru(s, lru, gfpflags);
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_lru);
> 
> 
> Any hints on where kmem_cache_alloc would be being called from this early?
> I will start looking from /init/main.c around pr_notice("%s", linux_banner);

Great. Would you try calling dump_stack(); when we observed s == NULL?
That would give more information about who passed s == NULL to these
functions.

-- 
Thanks,
Hyeonggon
