Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF934699F75
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjBPVvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjBPVvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:51:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C304654D6E;
        Thu, 16 Feb 2023 13:49:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cp18so1068840pjb.0;
        Thu, 16 Feb 2023 13:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XX55PL86vSqpwFy0eLM4CL0pVCfJIrQzfm/lyyBo490=;
        b=VMA7fP3agf6wAhVY7RwqEa/5+EvrIFixDyKwb5JDyrcPoltSegFgCMDxXYht5EA0Fk
         ZT+Y8rM+QjTFb5YHfQTGAdzxakSvej1tP0XA50pYpSJFxI6+qS+y4xh7haQjvn+edGrU
         MiVxRNy5BnzfcZK4/aEbJUxtSBA+YbHvhx1a8S6WxD6EcBmVQIfL12iBmyPj7Nue7FG4
         Wd+KOTHcsukmbB8K5PNYGOOKKU9MF3Ek4y7+T+7gE/QLKZmFJoMYpWEjuFKHFK2Pc6AR
         5IjoUX0CCePe7wk6tHg5GEthu+cWlfV85LqNP3+xEAInGMS6PPZBempeiq1/7AM1R+nd
         kpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XX55PL86vSqpwFy0eLM4CL0pVCfJIrQzfm/lyyBo490=;
        b=qp3rA1oNNpYffslL8pvPd+4N0+rzelXBqwUico+pRAJjzwAegF9n/lIpINok5zUEYN
         Soo1BxZlDMawY6zd7ttn08OTU/MjPMFaYC5rky/smB9FfU/vDZw5zkvACfuaGL2vMSjC
         6VUzx5YOcStG9PAfUBzi6ezEaOS2KbZZxIvD0s/faMLyr+Wv9vkD7JpZucXYUjLfzL4o
         fDSOFbbDG3nATSynXvRQG722UPP3zvW+pAr6KC9YzBh1HfJRai5dF6bYxVOrMoCdOwan
         q3KWJMghERY0hl4RWbjzmhISmmNGluG9SEd9y7Erby44YmW07KpaFOFaXQ7naMaFn15K
         h41g==
X-Gm-Message-State: AO0yUKWjVoHQKH1lZPeGKLsKizu97wbxx5lnxog8KwJAHYETCwFSCZPe
        1UoguiqdeffbZfSrjwas+GE0kGXP4/GPylRwc6M=
X-Google-Smtp-Source: AK7set/T7+Q5Ke9RAIXNTmgqQbtMEUTRVqygR/D0yPOOLVxW7rdMx82FATVHqvrUVFUW95IfthV6DaNu7gewVFyrgNA=
X-Received: by 2002:a17:90b:1e47:b0:230:b973:a726 with SMTP id
 pi7-20020a17090b1e4700b00230b973a726mr937824pjb.23.1676584180003; Thu, 16 Feb
 2023 13:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20230214190221.1156876-1-shy828301@gmail.com> <alpine.LRH.2.21.2302150716120.5940@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHbLzkr4RrKpR1pGZxs7JdB=R539SiNgO2+Fr7X-rVKcBh5tQQ@mail.gmail.com> <alpine.LRH.2.21.2302161204300.18393@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.21.2302161204300.18393@file01.intranet.prod.int.rdu2.redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 16 Feb 2023 13:49:28 -0800
Message-ID: <CAHbLzkp8odDNqX49mrEQc9Pk3=-3KxXvuhOe5Ny80ABwjBhx=w@mail.gmail.com>
Subject: Re: [dm-devel] [v2 PATCH 0/5] Introduce mempool pages bulk allocator
 and use it in dm-crypt
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 9:45 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Wed, 15 Feb 2023, Yang Shi wrote:
>
> > On Wed, Feb 15, 2023 at 4:23 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > >
> > >
> > >
> > > On Tue, 14 Feb 2023, Yang Shi wrote:
> > >
> > > >
> > > > Changelog:
> > > > RFC -> v2:
> > > >   * Added callback variant for page bulk allocator and mempool bulk allocator
> > > >     per Mel Gorman.
> > > >   * Used the callback version in dm-crypt driver.
> > > >   * Some code cleanup and refactor to reduce duplicate code.
> > > >
> > > > rfc: https://lore.kernel.org/linux-mm/20221005180341.1738796-1-shy828301@gmail.com/
> > >
> > > Hi
> > >
> > > This seems like unneeded complication to me. We have alloc_pages(), it can
> > > allocate multiple pages efficiently, so why not use it?
> >
> > The alloc_pages() allocates *contiguous* pages, but dm-crypt doesn't
> > need contiguous pages at all. This may incur unnecessary compaction
>
> It doesn't hurt that the pages are contiguous - and allocating and freeing
> a few compound pages is even faster than allocating and freeing many
> 0-order pages.

If "allocating many order-0 pages" means calling alloc_page() multiple
times, just like what the dm-crypt code does before this patchset,
yeah, allocating a compound page may be faster.

But it may be not true with bulk allocator. And it also depends on how
bad the fragmentation is and how contended the zone lock is. When
allocating order-0 page, the bulk allocator just could take the pages
from pcp list within one call. And the pcp list could hold a lot pages
actually, on my test machine per pcp list could have more than 1000
pages.

>
> > overhead to the dm-crypt layer when memory is fragmented.
>
> The compaction overhead may be suppressed by the GFP flags (i.e. don't use
> __GFP_DIRECT_RECLAIM).

You could, but you may pressure the mempool quite more often when
light memory pressure and fragmentation exist. The bulk allocator may
just succeed with light reclamation without allocating from mempool.

>
> > The bulk allocator is a good fit to this usecase, which allocates
> > multiple order-0 pages.
> >
> > In addition, filesystem writeback doesn't guarantee power-of-2 pages
> > every time IIUC. But alloc_pages() just can allocate power-of-2 pages.
>
> So, we can allocate more compound pages for the non-power-of-2 case - see
> the next patch that I'm sending.

Thanks for the patch. If the callers are willing to handle the
complexity (calculating the proper orders, dealing with the compound
pages, etc), it is definitely an option for them.

>
> > >
> > > I suggest to modify crypt_alloc_buffer() to use alloc_pages() and if
> > > alloc_pages() fails (either because the system is low on memory or because
> > > memory is too fragmented), fall back to the existing code that does
> > > mempool_alloc().
> >
> > My PoC patches just did this way, but called bulk allocator. There may
> > be other potential mepool users as I listed in this cover letter,
> > which may get benefits from bulk allocator. So introducing a new bulk
> > mempool API seems better for long run although we just have one user
> > for now. And it makes other uses easier to gain the benefit by just
> > calling the new API.
>
> This mempool bulk refactoring just makes the code bigger. And it is not
> needed - dm-crypt can fall-back to non-bulk mempool allocations.

Do you mean the mempool code? It may be inevitable by adding a new
API. But it is not significantly bigger. And the API hides all the
details and complexity from the callers, as well as handle all the
allocation corner cases in mm layer. It would make the users life much
easier. Of course if the callers are happy to handle all the
complexity by themselves, they don't have to call the API.

>
> In the next email, I'm sending a patch that is noticeably smaller and that
> uses alloc_pages()/__free_pages().

Thanks for the patch. But if other potential users would like to do
the same optimization, the code have to be duplicated everywhere.
Maybe not every one is happy to handle this by themselves.

>
> Mikulas
>
