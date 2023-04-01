Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C602D6D303D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjDALil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 07:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDALii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:38:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B55C159
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 04:38:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d13so23137782pjh.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680349117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wcCR0zpJu7VQLniCgKfkIUTKj7puFk+BLdwp11svwwU=;
        b=CofTxiuEztAUH+5RKda3JyMBHaFnZUxHYxPqOVqfABsMGeDKo0aLimRaT8/9rIxVn7
         RtrN07ZwK3nzsqAorzUh/HZTlSyLoUYwuZwFUHvuaA7S6RG3sBqXpBUQvlMP9/B/c61b
         GnPXv0Kaf4jXkKmgruFwSU1tFL2roJIfDzd/GIk74L6SL1E5gjjIdqBEKZxQGW7ID0S3
         vEiJWrmVnZ1xj/y8zOEiu+HeEaD0mfqxfyONzTtMDNCJrHa+WNNOFa8XGs2/ntOC/vX5
         d8igbpropDmVIuA6jT6SDdtVfVCLMIdGMxUcEsjIRHTW7LIKkG3dcQW4Sf0y8IttJejF
         rk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680349117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcCR0zpJu7VQLniCgKfkIUTKj7puFk+BLdwp11svwwU=;
        b=knc19qn7yi5evKSKj3WREMI9j4NKXo+PX1sy1EmTEBmnziEyLF52f1nHA9zYUfIdWC
         NYDWU3bS0lQTJd72Z3VKx1bzqHP+sqL2BCIqiXBQrtWyAqKCd/WzrGrIob3WNpqgRuWm
         YqYI8AKYq/YKPxdNeWNgHiIFMTmEYORjsdfoGfp3+LYydOzWeHotKDOe3g4IoT/W+Lgw
         qpOMT3jR3CcOgchj77d9j1bGXucYbLfTas3gsDwWKptX3ekIolVJmEalUG8YXMDtef5I
         G+50zAuRv3qMbnz9HM2F7KZHlyKbHagrfW5317CfxkS7r9WskZwQxF1U2ggQGJDx9ZxF
         3JAQ==
X-Gm-Message-State: AAQBX9f6byag/sk2qAzGt5tDdQPkDoL2yZTiOm919Iec+Q1s2cVvu/dn
        9z0gDzDD5irD/zfLddkcueXawnwITjMVl1IW
X-Google-Smtp-Source: AKy350aK6md8FixFJDpdapTWrHtnA37QUe/679Rdn27v3JS7Plt90DWk4XdnrJDa7u/grBOVmiDaeg==
X-Received: by 2002:a17:902:c401:b0:1a1:b9e6:2896 with SMTP id k1-20020a170902c40100b001a1b9e62896mr42079049plk.45.1680349116938;
        Sat, 01 Apr 2023 04:38:36 -0700 (PDT)
Received: from [192.168.0.110] ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id o21-20020a170903211500b001a25fe38789sm3208959ple.60.2023.04.01.04.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 04:38:36 -0700 (PDT)
Message-ID: <51b8ae95-da5f-f426-feef-ff10c8c3e583@gmail.com>
Date:   Sat, 1 Apr 2023 20:38:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: remove all the slab allocators
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230401094658.11146-1-vbabka@suse.cz>
From:   Vlastimil Babka <42.hyeyoo@gmail.com>
In-Reply-To: <20230401094658.11146-1-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/2023 6:46 PM, Vlastimil Babka wrote:

> As the SLOB removal is on track and the SLAB removal is planned, I have
> realized - why should we stop there and not remove also SLUB? What's a
> slab allocator good for in 2023? The RAM sizes are getting larger and
> the modules cheaper [1]. The object constructor trick was perhaps
> interesting in 1994, but not with contemporary CPUs. So all the slab
> allocator does today is just adding an unnecessary layer of complexity
> over the page allocator.

Oh my goodness, I am on vacation now and looks like someone is 
pretending to be me.

Probably my account was hacked. Please ignore this whole thread.

> Thus, with this patch, all three slab allocators are removed, and only a
> layer that passes everything to the page allocator remains in the slab.h
> and mm/slab_common.c files. This will allow users to gradually
> transition away and use the page allocator directly. To summarize the
> advantages:
>
> - Less code to maintain: over 13k lines are removed by this patch, and
>    more could be removed if I wast^Wspent more time on this, and later as
>    users are transitioned from the legacy layer. This no longer needs a
>    separate subsystem so remove it from MAINTAINERS (I hope I can keep the
>    kernel.org account anyway, though).
>
> - Simplified MEMCG_KMEM accounting: while I was lazy and just marked it
>    BROKEN in this patch, it should be trivial to use the page memcg
>    accounting now that we use the page allocator. The per-object
>    accounting went through several iterations in the past and was always
>    complex and added overhead. Page accounting is much simpler by
>    comparison.
>
> - Simplified KASAN and friends: also was lazy in this patch so they
>    can't be enabled but should be easy to fix up and work just on the
>    page level.
>
> - Simpler debugging: just use debug_pagealloc=on, no need to look up the
>    exact syntax of the absurdly complex slub_debug parameter.
>
> - Speed: didn't measure, but for the page allocator we have pcplists, so
>    it should scale just fine. No need for the crazy SLUB's cmpxchg_double()
>    craziness. Maybe that thing could be now removed too? Yeah I can see
>    just two remaining users.
>
> Any downsides? Let's look at memory usage after virtme boot:
>
> Before (with SLUB):
> Slab:              26304 kB
>
> After:
> Slab:             295592 kB
>
> Well, that's not so bad, see [1].
>
> [1] https://www.theregister.com/2023/03/29/dram_prices_crash/
> ---
>   MAINTAINERS              |   15 -
>   include/linux/slab.h     |  211 +-
>   include/linux/slab_def.h |  124 -
>   include/linux/slub_def.h |  198 --
>   init/Kconfig             |    2 +-
>   mm/Kconfig               |  134 +-
>   mm/Makefile              |   10 -
>   mm/slab.c                | 4046 ------------------------
>   mm/slab.h                |  426 ---
>   mm/slab_common.c         |  876 ++---
>   mm/slob.c                |  757 -----
>   mm/slub.c                | 6506 --------------------------------------
>   12 files changed, 228 insertions(+), 13077 deletions(-)
>   delete mode 100644 include/linux/slab_def.h
>   delete mode 100644 include/linux/slub_def.h
>   delete mode 100644 mm/slab.c
>   delete mode 100644 mm/slob.c
>   delete mode 100644 mm/slub.c

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1dc8bd26b6cf..40b05ad03cd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19183,21 +19183,6 @@ F:	drivers/irqchip/irq-sl28cpld.c
>   F:	drivers/pwm/pwm-sl28cpld.c
>   F:	drivers/watchdog/sl28cpld_wdt.c
>   
> -SLAB ALLOCATOR
> -M:	Christoph Lameter <cl@linux.com>
> -M:	Pekka Enberg <penberg@kernel.org>
> -M:	David Rientjes <rientjes@google.com>
> -M:	Joonsoo Kim <iamjoonsoo.kim@lge.com>
> -M:	Andrew Morton <akpm@linux-foundation.org>
> -M:	Vlastimil Babka <vbabka@suse.cz>
> -R:	Roman Gushchin <roman.gushchin@linux.dev>
> -R:	Hyeonggon Yoo <42.hyeyoo@gmail.com>
> -L:	linux-mm@kvack.org
> -S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
> -F:	include/linux/sl?b*.h
> -F:	mm/sl?b
