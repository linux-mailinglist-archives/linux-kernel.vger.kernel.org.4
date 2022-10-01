Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F82B5F1D43
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJAPo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 11:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJAPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:44:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6112D303FF
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 08:44:53 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c68so378253pfc.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=l8AJIv2HBjDB/yDQa4ygr534dqCGouRFLsujKjMoqFc=;
        b=huJA1/0Mz7laxdBKNDGajloVrWHM5GlrBCt3lJLt/2vA9kOKITi/ndqLlDJ3yloiBj
         d6kZvjEUq4XIfBrHJIOgm1Q0fWIM48jnBWnDGOFB9vHLZZbaTTnLHx3CkcnlZ1IbvEx6
         cwmwT1PsawCLA5ApnmOrtyYG5fvTfrEs0Uim5M38kAUc2t3RyDw1xyqr2Z6TsC5YDM+J
         ruKVDJNy/nLK58BZIEVzSEThcjJT3PJOT4XK++xdiWON0ih71fubBnAR8OMjxHacDWxO
         cLiMmqZyWUY8hT/tBfUMR4Que5NPUPrcQTL8TtCbeLFWrxEOycsYrKe4H9Wp8eY5obLm
         wuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=l8AJIv2HBjDB/yDQa4ygr534dqCGouRFLsujKjMoqFc=;
        b=CmZe2rdswi0vg3SWNE/wYXZd8TE+6bzRYVHrLqPtoaHckEAwpyDkASMR9wWIb2fUfW
         3V5nwgb4zoMLaM7Eh/+Ar2+mBHUb0DcoiQeUcpqQrO/pz3XZ4moZtPEQsXyMdOwb7hma
         BgzhFWDaNIKbQUH3eHd1ttRRI7gchEa+c/xKwBQdGcRSAreb8F4AI3fLf7TPDX56ncXh
         tMdIeJiEszExUlseJFsuYcLfAyPIgMwr9931KlVQqItuQT/AM86YcbTODuzDdRMXB//P
         vIsnC9/CrHMlFkruI6JWE5l+OX/yWpL9Y/jEDxPPCUYRSn9RzzR/pSpa0ML1nk0EKL3Q
         zCdw==
X-Gm-Message-State: ACrzQf2+iiWGOkI9ghIrYUBcFulrlNvupdDn9Lmpl8MvK4VpdduIODvY
        WqsKuVQrIVhyH8uiyJzDrqc=
X-Google-Smtp-Source: AMsMyM7hnM0hNdEZWR5+OucPhgyvWohtGVndqd/NTucWwc8E1IAh+rmsLV7ZqETHtKe+py87KrAH8w==
X-Received: by 2002:a65:538e:0:b0:434:aa53:2244 with SMTP id x14-20020a65538e000000b00434aa532244mr11567961pgq.343.1664639092640;
        Sat, 01 Oct 2022 08:44:52 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id x30-20020aa79a5e000000b0054cbad1cd21sm3851354pfj.180.2022.10.01.08.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 08:44:51 -0700 (PDT)
Date:   Sun, 2 Oct 2022 00:44:46 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Feng Tang <feng.tang@intel.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mm/slub: fix a slab missed to be freed problem
Message-ID: <Yzhgbrm73CTa7s7p@hyeyoo>
References: <20220930100730.250248-1-feng.tang@intel.com>
 <13417330-2a81-e775-8875-fb31a5d5e078@suse.cz>
 <YzbYUo1EpYzd4jtw@feng-clx>
 <51b4d3e7-655a-8083-ff0c-0feb1946bd04@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b4d3e7-655a-8083-ff0c-0feb1946bd04@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:43:23PM +0200, Vlastimil Babka wrote:
> On 9/30/22 13:51, Feng Tang wrote:
> > On Fri, Sep 30, 2022 at 07:25:54PM +0800, Vlastimil Babka wrote:
> >> 
> >> On 9/30/22 12:07, Feng Tang wrote:
> >> > When enable kasan and kfence's in-kernel kunit test with slub_debug on,
> >> > it caught a problem (in linux-next tree):
> >> > 
> >> >  ------------[ cut here ]------------
> >> >  kmem_cache_destroy test: Slab cache still has objects when called from test_exit+0x1a/0x30
> >> >  WARNING: CPU: 3 PID: 240 at mm/slab_common.c:492 kmem_cache_destroy+0x16c/0x170
> >> 
> >> Assuming the warning was preceded by some kunit test failures?
> >> I don't see how leaving more empty slabs on free list than needed would
> >> cause this warning, the shutdown should just drop the empty slab.
> > 
> > The previous code only call remove_partial() to dequeue the slab from
> > partial list, and miss to call discard_slab() for it.
> > 
> > From the debug dump, the n->nr_partils stays at 5, while n->nr_slabs
> > keeps increasing. And during shutdown, the free_partial() only free
> > the 5 slabs on partial list, and n->nr_slabs still has a big numbers
> > of orphan slabs
> 
> Thanks, finally I get the exact cause now. I've added the more detailed
> explanation to commit log and the result is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=for-6.1/slub_validation_locking&id=b731e3575f7a45a46512708f9fdf953b40c46a53
>

Very nice finding Feng, thanks!

Yeah, there are some cases where first and second check do not agree,
leading unfreed slabs.

the latest version looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Nit:
- discard_slab() is not what's actually called, but I get what you mean anyway...
- s/Reoganize/Reorganize/g

> >> >  Modules linked in:
> >> >  CPU: 3 PID: 240 Comm: kunit_try_catch Tainted: G    B            N 6.0.0-rc7-next-20220929 #52
> >> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> >> >  RIP: 0010:kmem_cache_destroy+0x16c/0x170
> >> >  Code: 41 5c 41 5d e9 a5 04 0b 00 c3 cc cc cc cc 48 8b 55 60 48 8b 4c 24 20 48 c7 c6 40 37 d2 82 48 c7 c7 e8 a0 33 83 e8 4e d7 14 01 <0f> 0b eb a7 41 56 41 89 d6 41 55 49 89 f5 41 54 49 89 fc 55 48 89
> >> >  RSP: 0000:ffff88800775fea0 EFLAGS: 00010282
> >> >  RAX: 0000000000000000 RBX: ffffffff83bdec48 RCX: 0000000000000000
> >> >  RDX: 0000000000000001 RSI: 1ffff11000eebf9e RDI: ffffed1000eebfc6
> >> >  RBP: ffff88804362fa00 R08: ffffffff81182e58 R09: ffff88800775fbdf
> >> >  R10: ffffed1000eebf7b R11: 0000000000000001 R12: 000000008c800d00
> >> >  R13: ffff888005e78040 R14: 0000000000000000 R15: ffff888005cdfad0
> >> >  FS:  0000000000000000(0000) GS:ffff88807ed00000(0000) knlGS:0000000000000000
> >> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> >  CR2: 0000000000000000 CR3: 000000000360e001 CR4: 0000000000370ee0
> >> >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> >  Call Trace:
> >> >   <TASK>
> >> >   test_exit+0x1a/0x30
> >> >   kunit_try_run_case+0xad/0xc0
> >> >   kunit_generic_run_threadfn_adapter+0x26/0x50
> >> >   kthread+0x17b/0x1b0
> >> > 
> >> > It was biscted to commit c7323a5ad078 ("mm/slub: restrict sysfs
> >> > validation to debug caches and make it safe")
> >> > 
> >> > The problem is inside free_debug_processing(), in one path, the slab
> >> > on partial list is missed to be freed when partial list is full.
> >> > 
> >> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> >> > ---
> >> > 
> >> > Hi reviewers,
> >> > 
> >> > Sorry for the late reporting, but it's curious that this problem didn't
> >> > show up in my earlier test (which caught some other problems).
> >> 
> >> I think we can reuse the slab_free and don't need a new bool?
> > 
> > Yes, much simpler!
> > 
> > Thanks,
> > Feng
> > 
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 5c3c31a154ba..a63953f649ed 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -2886,22 +2886,25 @@ static noinline void free_debug_processing(
> >>                 set_freepointer(s, tail, prior);
> >>                 slab->freelist = head;
> >>  
> >> -               /* Do we need to remove the slab from full or partial list? */
> >> +               /*
> >> +                * If the slab is empty, and node's partial list is full,
> >> +                * it should be discarded anyway no matter it's on full or
> >> +                * partial list.
> >> +                */
> >> +               if (slab->inuse == 0 && n->nr_partial >= s->min_partial)
> >> +                       slab_free = slab;
> >> +
> >>                 if (!prior) {
> >> +                       /* was on full list */
> >>                         remove_full(s, n, slab);
> >> -               } else if (slab->inuse == 0 &&
> >> -                          n->nr_partial >= s->min_partial) {
> >> +                       if (!slab_free) {
> >> +                               add_partial(n, slab, DEACTIVATE_TO_TAIL);
> >> +                               stat(s, FREE_ADD_PARTIAL);
> >> +                       }
> >> +               } else if (slab_free) {
> >>                         remove_partial(n, slab);
> >>                         stat(s, FREE_REMOVE_PARTIAL);
> >>                 }
> >> -
> >> -               /* Do we need to discard the slab or add to partial list? */
> >> -               if (slab->inuse == 0 && n->nr_partial >= s->min_partial) {
> >> -                       slab_free = slab;
> >> -               } else if (!prior) {
> >> -                       add_partial(n, slab, DEACTIVATE_TO_TAIL);
> >> -                       stat(s, FREE_ADD_PARTIAL);
> >> -               }
> >>         }
> >>  
> >>         if (slab_free) {
> 

-- 
Thanks,
Hyeonggon
