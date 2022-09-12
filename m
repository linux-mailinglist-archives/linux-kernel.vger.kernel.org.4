Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7E5B5589
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiILHsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiILHrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:47:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BD61ADA8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:47:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o23so5913636pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=TI2ojhfudLxFH8Fuvg2TAeKZBTHE7OuPltHLxPniSrk=;
        b=jsLOg/VRVYnMz9qhYEgzwkBccm7RprYYdRJENRUAWQGoXRaFVkyw0qRY+kAlQ1eNuu
         ziclOGYGaeqPjdZC8xnpT7PNqa6q7mknVPem7YVeba15JL+eD2u7qbF2ISTXGzexRnY0
         t7xDZ6Kg/UNzR0Ce8x6zGO5Aa5a7l/k/FIpHQzQhCe2kiwBj6RJV92tMVjW8jYSvMdIR
         U6gpwzik7NiK6dEq4eScYdPMIodqzzntyp7UwCf0d9up/AY9cMZDHrVm12DBhAKwNRcc
         PiAMbBb8+u9Y36BlbCyDHqDiAGkmJGch2fSsUDxStUuGB8GGscnUhDkIt7/s10GF4Eik
         poTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TI2ojhfudLxFH8Fuvg2TAeKZBTHE7OuPltHLxPniSrk=;
        b=WweLnmpj+T3qCdzp5eb+A1msvWyrBuIlJ6QSixsPqEiJ74mvJ3OsOouKi8+IhgQ4xt
         SgSSPNc65vRGnx8wOTkcX46BZn4BUmMWN2EZH4hk9Gl2ua/C+vLYdTJvh/PIlsCO0F90
         SRRP836Oql5y46FzswUhrNKwAm/NnNj2Ch7A6RSgLzXR8t9yqrcxwtyxoJYKimIWQhfV
         jo1lKTeZhXaAuCapWovs6+4UBTuv5iaWQzGxnPy/vpB6MxCDI6BzclLpuAY4gMqceRqb
         5CzE6it5wMG7hx+6woy/R1k1fWKwphIoD9/orNiesevCrnwQcCEvocbI1j7U6jZGwJwD
         ZIvw==
X-Gm-Message-State: ACgBeo1P9X4nsI3vWK2T2SNdxv5booLZBztXq9WhPWv6jbbOifxjLgo6
        IOeCah27y/PLj1LuTPZwR/N7EyDyHUagQw==
X-Google-Smtp-Source: AA6agR5wG/4xaW6lgTRtLgCJEgtzzut5A+IGLXLVbv4Y/ruTFKLddrhbDOfm6SlE7H0unFOeJG2a3Q==
X-Received: by 2002:a17:902:eb82:b0:176:c0e0:55c1 with SMTP id q2-20020a170902eb8200b00176c0e055c1mr25586294plg.168.1662968872813;
        Mon, 12 Sep 2022 00:47:52 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090a070100b00202618f0df4sm4621114pjl.0.2022.09.12.00.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 00:47:51 -0700 (PDT)
Date:   Mon, 12 Sep 2022 16:47:46 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Ben Luo <luoben@linux.alibaba.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: return 0 when object pointer is NULL
Message-ID: <Yx7kIjx+MCLe4So8@hyeyoo>
References: <1662962379-16174-1-git-send-email-luoben@linux.alibaba.com>
 <Yx7dKxwxlNmCr9Ai@hyeyoo>
 <133458f0-23c9-9421-abb8-a50d5551b524@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <133458f0-23c9-9421-abb8-a50d5551b524@linux.alibaba.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 03:29:30PM +0800, Ben Luo wrote:
> Hello Hyeonggon,
> 
> Thanks for replying :)
> 
> 在 2022/9/12 15:18, Hyeonggon Yoo 写道:
> > On Mon, Sep 12, 2022 at 01:59:39PM +0800, Ben Luo wrote:
> > > NULL is definitly not a valid address
> > > 
> > > Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> > > ---
> > >   mm/slub.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 862dbd9..50fad18 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -674,7 +674,7 @@ static inline int check_valid_pointer(struct kmem_cache *s,
> > >   	void *base;
> > >   	if (!object)
> > > -		return 1;
> > > +		return 0;
> > >   	base = slab_address(slab);
> > >   	object = kasan_reset_tag(object);
> > > -- 
> > > 1.8.3.1
> > > 
> > Hello Ben.
> > 
> > The return value is used to check if the @object has valid pointer
> > in @slab. (used for debugging) the return value is 0 if valid, 1 if invalid.
> > 
> > It does not return a pointer. So changing it to 0 because 1 is invalid
> > address does not make sense.
> 
> I know the meaning of this return value, but I think this function was
> expected by returning 0 if invalid ,1 if valid
>

Ah, right. Sorry for my silly mistake. I misread your patch and the code :D

Hmm then the question is: Why does check_valid_pointer() allow passing NULL?

So I just compiled and ran it with debugging enabled.

And I got:

[    0.195507] =============================================================================
[    0.195507] BUG ftrace_event_field (Tainted: G    B             ): Freechain corrupt
[    0.195507] -----------------------------------------------------------------------------
[    0.195507] 
[    0.195507] Slab 0xffffea000400d380 objects=28 used=28 fp=0x0000000000000000 flags=0x17ffffc0000200(slab|node=0|zone=2|lastcpu)
[    0.195508] Object 0xffff88810034eab8 @offset=2744 fp=0x0000000000000000
[    0.195508] 
[    0.195508] Redzone  ffff88810034eab0: bb bb bb bb bb bb bb bb ........
[    0.195509] Object   ffff88810034eab8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[    0.195509] Object   ffff88810034eac8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[    0.195510] Object   ffff88810034ead8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
[    0.195510] Redzone  ffff88810034eae8: bb bb bb bb bb bb bb bb ........
[    0.195510] Padding  ffff88810034eb38: 5a 5a 5a 5a 5a 5a 5a 5a ZZZZZZZZ
[    0.195511] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B 6.0.0-rc3+ #1765
[    0.195511] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[    0.195511] Call Trace:
[    0.195512]  <TASK>
[    0.195512]  dump_stack_lvl+0x45/0x5e
[    0.195513]  object_err+0x30/0x44
[    0.195513]  deactivate_slab.cold+0x15/0x2c
[    0.195514]  ? __trace_early_add_events+0x3e/0x60
[    0.195515]  ? trace_event_init+0xaf/0x2cd
[    0.195516]  ? start_kernel+0x705/0x97d
[    0.195517]  ? check_object+0x138/0x250
[    0.195518]  ? init_object+0x6f/0x90
[    0.195518]  ? trace_define_field+0x50/0xe0
[    0.195519]  ___slab_alloc+0x4a0/0x6c0
[    0.195520]  ? trace_define_field+0x50/0xe0
[    0.195521]  ? trace_create_new_event+0x31/0xf0
[    0.195522]  ? trace_define_field+0x50/0xe0
[    0.195523]  kmem_cache_alloc+0x2a1/0x2f0
[    0.195524]  trace_define_field+0x50/0xe0
[    0.195525]  event_define_fields+0x8a/0xc0
[    0.195527]  __trace_early_add_events+0x3e/0x60
[    0.195528]  trace_event_init+0xaf/0x2cd
[    0.195529]  start_kernel+0x705/0x97d
[    0.195529]  ? x86_family+0x5/0x30
[    0.195530]  secondary_startup_64_no_verify+0xe5/0xeb
[    0.195532]  </TASK>
[    0.195532] FIX ftrace_event_field: Isolate corrupted freechain

The call chain is:

deactivate_slab()
	-> freelist_corrupted()
		check_valid_pointer()

Hmm check_valid_pointer() is used to to check if the free pointer is valid.
and as NULL is used to mark that there is no next object, I think
check_valid_pointer() shuold return 1 if object is NULL.

Thanks!

> Check this original code:
> 
>         if (object < base || object >= base + slab->objects * s->size ||
>                 (object - base) % s->size) {
>                 return 0;
>         }
> 
> Object not in range of [base, base+length) is an invalid slab address, and
> it will return 0
> 
> 
> --
> 
> Thanks,
> 
> Ben
> 
> > 

-- 
Thanks,
Hyeonggon
