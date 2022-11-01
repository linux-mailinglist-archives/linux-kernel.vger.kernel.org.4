Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD86147D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiKAKmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiKAKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:42:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E9A15A2E;
        Tue,  1 Nov 2022 03:42:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso12575699pjc.2;
        Tue, 01 Nov 2022 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmgzejyjag96mf7b7LvimdzM9hQQ74MAnXiZchHz7Ac=;
        b=oR1gZQ+2W8xwL0lIPkLTOqG5Dif9pAvY6sKdvcCoka3qeELX96OK9ZWH7xwCYojfMx
         JSRGkAES0QsC3UKJUfx6vB8ClyeFNRRmzFqtuVo2cP+g0zOfhKTyTcBvkbOiM8P4qype
         ES2CXPljTWKOZoOINfhkaGUTZXTHlJmLwG6eij94a1VAFcukWUo0kXv/3ypsF5aTonDK
         u2eUCDQ7BXEUv0cXLA6HGgwNxVCV6vv55vDL0IJ+yUL7NL6Xvky4BIQwD3pBfIcw9noG
         N/1K/th5AuOa6N1GJ8h6mG7JeSZM2/iYA5C5HV54TnEUNKGoTiMXgBD5P3P0ny5sKjpA
         hVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mmgzejyjag96mf7b7LvimdzM9hQQ74MAnXiZchHz7Ac=;
        b=6nfBD5plT9chr8Bj20KM1ijsLCg6QL6f4W8CVNr/4m7UFogB8/KsaQv50kyjrVAYOR
         qBzzXKiF8pU0fffwrY+5A+/pdhl8ZIQCwaWG3Z5bQ57V9rB1ETZRrLok1wzzSCTOIczn
         6tx/VHjdJhRIVJ8eUs3joawfxTfOZBfG2UBklnoOkWwcMwuacNyQUyk82bK9xJDoDWFF
         p7e6AehdCV5e6G2Aeqs2wmgXUAsd50NRK6NhPysiJTU7DybH0NceulZPBkKRvV4EuFSu
         Mot7npXtNbzYdRaWSLcIc5oo+uU0kV99MVcYoVHMpMD9cJgJjVr4jgVXiQItfW57rI6U
         X43g==
X-Gm-Message-State: ACrzQf2raogQPDVMS1S/hcbv/ygbqK24dsTgrcns/MZxRa9xlu5RayL/
        5G7dQKlzAXIaufx/g8/Q6uA=
X-Google-Smtp-Source: AMsMyM7wkjDGWp6FwreLtonv/rR0QfognoIv2Rc03uzHW3e/Kb0QgTG61mmjisB6K8fcL6imK+agPg==
X-Received: by 2002:a17:902:e84f:b0:187:2127:cc6 with SMTP id t15-20020a170902e84f00b0018721270cc6mr10405486plg.110.1667299352568;
        Tue, 01 Nov 2022 03:42:32 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id jg1-20020a17090326c100b001780a528540sm6007495plb.93.2022.11.01.03.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 03:42:31 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:42:23 +0900
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
        John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <Y2D4D52h5VVa8QpE@hyeyoo>
References: <becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com>
 <af2ba83d-c3f4-c6fb-794e-c2c7c0892c44@suse.cz>
 <Y180l6zUnNjdCoaE@feng-clx>
 <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
 <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
 <Y2DngwUc7cLB0dG7@hyeyoo>
 <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:33:32AM +0000, John Thomson wrote:
> On Tue, 1 Nov 2022, at 09:31, Hyeonggon Yoo wrote:
> > On Tue, Nov 01, 2022 at 09:20:21AM +0000, John Thomson wrote:
> >> On Tue, 1 Nov 2022, at 07:57, Feng Tang wrote:
> >> > Hi Thomson,
> >> >
> >> > Thanks for testing!
> >> >
> >> > + mips maintainer and mail list. The original report is here
> >> >
> >> > https://lore.kernel.org/lkml/becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com/
> >>
> >> I am guessing my issue comes from __kmem_cache_alloc_lru accessing s->object_size when (kmem_cache) s is NULL?
> >> If that is the case, this change is not to blame, it only exposes the issue?
> >> 
> >> I get the following dmesg (note very early NULL kmem_cache) with the below change atop v6.1-rc3:
> >> 
> >> transfer started ......................................... transfer ok, time=2.02s
> >> setting up elf image... OK
> >> jumping to kernel code
> >> zimage at:     80B842A0 810B4EFC
> >> 
> >> Uncompressing Linux at load address 80001000
> >> 
> >> Copy device tree to address  80B80EE0
> >> 
> >> Now, booting the kernel...
> >> 
> >> [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #61 SMP Tue Nov  1 18:04:13 AEST 2022
> >> [    0.000000] slub: kmem_cache_alloc called with kmem_cache: 0x0
> >> [    0.000000] slub: __kmem_cache_alloc_lru called with kmem_cache: 0x0
> >> [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
> >> [    0.000000] printk: bootconsole [early0] enabled
> >> [    0.000000] CPU0 revision is: 0001992f (MIPS 1004Kc)
> >> [    0.000000] MIPS: machine is MikroTik RouterBOARD 760iGS
> >> 
> >> normal boot
> >> 
> >> 
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 157527d7101b..10fcdf2520d2 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -3410,7 +3410,13 @@ static __always_inline
> >>  void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> >>  			     gfp_t gfpflags)
> >>  {
> >> -	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> >> +	void *ret;
> >> +	if (IS_ERR_OR_NULL(s)) {
> >> +		pr_warn("slub: __kmem_cache_alloc_lru called with kmem_cache: %pSR\n", s);
> >> +		ret = slab_alloc(s, lru, gfpflags, _RET_IP_, 0);
> >> +	} else {
> >> +		ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> >> +	}
> >>  
> >>  	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
> >>  
> >> @@ -3419,6 +3425,8 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> >>  
> >>  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
> >>  {
> >> +	if (IS_ERR_OR_NULL(s))
> >> +		pr_warn("slub: kmem_cache_alloc called with kmem_cache: %pSR\n", s);
> >>  	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
> >>  }
> >>  EXPORT_SYMBOL(kmem_cache_alloc);
> >> @@ -3426,6 +3434,8 @@ EXPORT_SYMBOL(kmem_cache_alloc);
> >>  void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> >>  			   gfp_t gfpflags)
> >>  {
> >> +	if (IS_ERR_OR_NULL(s))
> >> +		pr_warn("slub: __kmem_cache_alloc_lru called with kmem_cache: %pSR\n", s);
> >>  	return __kmem_cache_alloc_lru(s, lru, gfpflags);
> >>  }
> >>  EXPORT_SYMBOL(kmem_cache_alloc_lru);
> >> 
> >> 
> >> Any hints on where kmem_cache_alloc would be being called from this early?
> >> I will start looking from /init/main.c around pr_notice("%s", linux_banner);
> >
> > Great. Would you try calling dump_stack(); when we observed s == NULL?
> > That would give more information about who passed s == NULL to these
> > functions.
> >
> 
> With the dump_stack() in place:
> 
> Now, booting the kernel...
> 
> [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #62 SMP Tue Nov  1 19:49:52 AEST 2022
> [    0.000000] slub: __kmem_cache_alloc_lru called with kmem_cache ptr: 0x0
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #62
> [    0.000000] Stack : 810fff78 80084d98 80889d00 00000004 00000000 00000000 80889d5c 80c90000
> [    0.000000]         80920000 807bd380 8089d368 80923bd3 00000000 00000001 80889d08 00000000
> [    0.000000]         00000000 00000000 807bd380 8084bd51 00000002 00000002 00000001 6d6f4320
> [    0.000000]         00000000 80c97ce9 80c97d14 fffffffc 807bd380 00000000 00000003 00000dc0
> [    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000 00000020 80010000 80010000
> [    0.000000]         ...
> [    0.000000] Call Trace:
> [    0.000000] [<80008260>] show_stack+0x28/0xf0
> [    0.000000] [<8070cdc0>] dump_stack_lvl+0x60/0x80
> [    0.000000] [<801c1428>] kmem_cache_alloc+0x5c0/0x740
> [    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
> [    0.000000] [<80928060>] prom_init+0x44/0xf0
> [    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
> [    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
> [    0.000000] 
> [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3

setup_arch() is too early to use slab allocators.
I think slab received NULL pointer because kmalloc is not initialized.

It seems arch/mips/ralink/mt7621.c is using slab too early.

> 
> 
> Now, booting the kernel...
> 
> [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #62 SMP Tue Nov  1 19:49:52 AEST 2022
> [    0.000000] slub: __kmem_cache_alloc_lru called with kmem_cache ptr: 0x0
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #62
> [    0.000000] Stack : 810fff78 80084d98 80889d00 00000004 00000000 00000000 80889d5c 80c90000
> [    0.000000]         80920000 807bd380 8089d368 80923bd3 00000000 00000001 80889d08 00000000
> [    0.000000]         00000000 00000000 807bd380 8084bd51 00000002 00000002 00000001 6d6f4320
> [    0.000000]         00000000 80c97ce9 80c97d14 fffffffc 807bd380 00000000 00000003 00000dc0
> [    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000 00000020 80010000 80010000
> [    0.000000]         ...
> [    0.000000] Call Trace:
> [    0.000000] show_stack (/mnt/pool_ssd/code/linux/linux-stable-mt7621/./arch/mips/include/asm/stacktrace.h:43 /mnt/pool_ssd/code/linux/linux-stable-mt7621/arch/mips/kernel/traps.c:223) 
> [    0.000000] dump_stack_lvl (/mnt/pool_ssd/code/linux/linux-stable-mt7621/lib/dump_stack.c:107 (discriminator 1)) 
> [    0.000000] kmem_cache_alloc (/mnt/pool_ssd/code/linux/linux-stable-mt7621/mm/slub.c:3318 /mnt/pool_ssd/code/linux/linux-stable-mt7621/mm/slub.c:3406 /mnt/pool_ssd/code/linux/linux-stable-mt7621/mm/slub.c:3418 /mnt/pool_ssd/code/linux/linux-stable-mt7621/mm/slub.c:3430) 
> [    0.000000] prom_soc_init (/mnt/pool_ssd/code/linux/linux-stable-mt7621/arch/mips/ralink/mt7621.c:106 /mnt/pool_ssd/code/linux/linux-stable-mt7621/arch/mips/ralink/mt7621.c:177) 
> [    0.000000] prom_init (/mnt/pool_ssd/code/linux/linux-stable-mt7621/arch/mips/ralink/prom.c:64) 
> [    0.000000] setup_arch (/mnt/pool_ssd/code/linux/linux-stable-mt7621/arch/mips/kernel/setup.c:786) 
> [    0.000000] start_kernel (/mnt/pool_ssd/code/linux/linux-stable-mt7621/init/main.c:279 /mnt/pool_ssd/code/linux/linux-stable-mt7621/init/main.c:477 /mnt/pool_ssd/code/linux/linux-stable-mt7621/init/main.c:960) 
> [    0.000000] 
> [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
> 
> 
> I have not found it yet.
> 
> 
> Cheers,
> -- 
>   John Thomson

-- 
Thanks,
Hyeonggon
