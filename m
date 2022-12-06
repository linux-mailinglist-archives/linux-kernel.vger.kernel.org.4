Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ADB643B56
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiLFCg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLFCgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:36:25 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D931DDF8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:36:24 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id d185so12990261vsd.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 18:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vJc66FGPi+h8aP3Ev7f8S48Ike7VZGAssuraq0iybeQ=;
        b=A4Bcn9BmVhQV7k9chqkEyxWbL9wJ2IRF1E3HkfTVZk/n4EPVyl+QhxoTfeptz33pbQ
         W5FZaCyWRC+2Xnp9+UyuJb0F7oXx/nk4Tmn4Om7iet5/Ytf2j8bYeeWUiAujfaDP2QY8
         Nn9C57zvBiMwjWMG6EpWAzuI44NPntp9xL4NYgh+I4sAFNnRrjSO+QH+IBq58cddLw57
         J9Jzvt5yoP8AMNPhX4mmm0dql1cy2q9jdfhhGER0hd0ARx3xQmktmsfKSCNDhInAhdSX
         73yI5BfQ2ourtRNSkgI8WWL+PTLvtEmBoPrl/MXOea7WSpXxb9pPu6QqZ3+zyXUD2Gbq
         RfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJc66FGPi+h8aP3Ev7f8S48Ike7VZGAssuraq0iybeQ=;
        b=TgeD8I6mmlp+F1aPp0SxhYpRNdTpibbQTWvJIM+iSyTnKHdJrL+cPRX499Y45oM1vP
         TQHAl1AqtPIP+xDDRYk05agJMkVmLdEhAsKdy/eNVOd7NKRFv3d1CKac319Hsy1KotOG
         TCC9ZLjNbDhOa1HQlSd73ywrCJSNWFQ1zAc01DBI2of8yZjLImMWLotZ091SyBRw1Wzz
         u+AyxBbAJ7cFBojpHSipzaIDumoAMcmo4PkuhA9L50jtBrsDOyDFsvU2787+llSa9JY5
         eh0KQsitcB6bUsBnSM7wBQ4V5uZL6xw7Z9R8wHs6tn1YXis7oraRvUItp2zzv094QoGt
         hv8w==
X-Gm-Message-State: ANoB5pmVa/mc1INOp0q7VHICWvM0xSk99Wh/L2X6UuNaawXgAfDAB/Dm
        7gM5OMzYZADvaJE2tLRWnHErcCiMvv0RpKs9pEh0vA==
X-Google-Smtp-Source: AA0mqf7JEuP8Oj7/Oq+tFCzRFfsUuHBr3y6D5z+55lv7eFc4MZwhh+OkxgG4Xh+zyvCQHEAlc28/FyhhpxK7ZdcGS9Q=
X-Received: by 2002:a05:6102:2758:b0:3b1:1962:24f9 with SMTP id
 p24-20020a056102275800b003b1196224f9mr7936041vsu.72.1670294183345; Mon, 05
 Dec 2022 18:36:23 -0800 (PST)
MIME-Version: 1.0
References: <20221203011120.2361610-1-almasrymina@google.com>
 <87lenm1soh.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAHS8izMm4NDhwX-pqEu1RbKoUgi8jFJH5a9LTetdQpQPu6ZsGw@mail.gmail.com>
 <87k035l3vz.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87k035l3vz.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 5 Dec 2022 18:36:11 -0800
Message-ID: <CAHS8izNN=g73u3zDpKVFteWczvBm50ajPLiJ0X7jo-7A=dcffw@mail.gmail.com>
Subject: Re: [PATCH v1] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 5:26 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > On Sun, Dec 4, 2022 at 6:39 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Mina Almasry <almasrymina@google.com> writes:
> >>
> >> > commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> >> > reclaim"") enabled demotion in memcg reclaim, which is the right thing
> >> > to do, however, I suspect it introduced a regression in the behavior of
> >> > try_to_free_mem_cgroup_pages().
> >> >
> >> > The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> >> > reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> >> > of the cgroup should reduce by nr_pages. The callers expect
> >> > try_to_free_mem_cgroup_pages() to also return the number of pages
> >> > reclaimed, not demoted.
> >> >
> >> > However, what try_to_free_mem_cgroup_pages() actually does is it
> >> > unconditionally counts demoted pages as reclaimed pages. So in practice
> >> > when it is called it will often demote nr_pages and return the number of
> >> > demoted pages to the caller. Demoted pages don't lower the memcg usage,
> >> > and so I think try_to_free_mem_cgroup_pages() is not actually doing what
> >> > the callers want it to do.
> >> >
> >> > I suspect various things work suboptimally on memory systems or don't
> >> > work at all due to this:
> >> >
> >> > - memory.high enforcement likely doesn't work (it just demotes nr_pages
> >> >   instead of lowering the memcg usage by nr_pages).
> >> > - try_charge_memcg() will keep retrying the charge while
> >> >   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
> >> >   making any room for the charge.
> >> > - memory.reclaim has a wonky interface. It advertises to the user it
> >> >   reclaims the provided amount but it will actually demote that amount.
> >> >
> >> > There may be more effects to this issue.
> >> >
> >> > To fix these issues I propose shrink_folio_list() to only count pages
> >> > demoted from inside of sc->nodemask to outside of sc->nodemask as
> >> > 'reclaimed'.
> >> >
> >> > For callers such as reclaim_high() or try_charge_memcg() that set
> >> > sc->nodemask to NULL, try_to_free_mem_cgroup_pages() will try to
> >> > actually reclaim nr_pages and return the number of pages reclaimed. No
> >> > demoted pages would count towards the nr_pages requirement.
> >> >
> >> > For callers such as memory_reclaim() that set sc->nodemask,
> >> > try_to_free_mem_cgroup_pages() will free nr_pages from that nodemask
> >> > with either reclaim or demotion.
> >>
> >> Have you checked all callers?  For example, IIUC, in
> >> reclaim_clean_pages_from_list(), although sc.nodemask == NULL, the
> >> demoted pages should be counted as reclaimed.
> >
> > I checked all call stacks leading to shrink_folio_list() now (at least
> > I hope). Here is what I think they do and how I propose to handle
> > them:
> >
> > - reclaim_clean_pages_from_list() & __node_reclaim() & balance_pgdat()
> > These try to free memory from a specific node, and both demotion and
> > reclaim from that node should be counted. I propose these calls set
> > sc>nodemask = pgdat.node_id to signal to shrink_folio_list() that both
> > demotion and reclaim from this node should be counted.
> >
> > - try_to_free_pages()
> > Tries to free pages from a specific nodemask. It sets sc->nodemask to
> > ac->nodemask. In this case pages demoted within the nodemask should
> > not count. Pages demoted outside of the nodemask should count, which
> > this patch already tries to do.
> >
> > - mem_cgroup_shrink_node()
> > This is memcg soft limit reclaim. AFAIU only reclaim should be
> > counted. It already sets sc->nodemask=NULL to indicate that it
> > requires reclaim from all nodes and that only reclaimed memory should
> > be counted, which this patch already tries to do.
> >
> > - try_to_free_mem_cgroup_pages()
> > This is covered in the commit message. Many callers set nodemask=NULL
> > indicating they want reclaim and demotion should not count.
> > memory.reclaim sets nodemask depending on the 'nodes=' arg and wants
> > demotion and reclaim from that nodemask.
> >
> > - reclaim_folio_list()
> > Sets no_demotion = 1. No ambiguity here, only reclaims and counts
> > reclaimed pages.
> >
> > If agreeable I can fix reclaim_clean_pages_from_list() &
> > __node_reclaim() & balance_pgdat() call sites in v3.
>
> Looks good to me, Thanks!
>

Thanks. Sent out v3 with the comments addressed. PTAL whenever convenient:
https://lore.kernel.org/linux-mm/20221206023406.3182800-1-almasrymina@google.com/T/#u

> >> How about count both
> >> "demoted" and "reclaimed" in struct scan_control, and let callers to
> >> determine how to use the number?
> >>
> >
> > I don't think this is by itself enough. Pages demoted between 2 nodes
> > that are both in sc->nodemask should not count, I think. So 'demoted'
> > needs to be specifically pages demoted outside of the nodemask.
>
> Yes.  Maybe we can do that when we need it.  I suggest to change the
> return value description in the comments of shrink_folio_list().
>
> > We can do 2 things:
> >
> > 1. Only allow the kernel to demote outside the nodemask (which you
> > don't prefer).
> > 2. Allow the kernel to demote inside the nodemask but not count them.
> >
> > I will see if I can implement #2.
>
> Thanks!
>
> >> > Tested this change using memory.reclaim interface. With this change,
> >> >
> >> >       echo "1m" > memory.reclaim
> >> >
> >> > Will cause freeing of 1m of memory from the cgroup regardless of the
> >> > demotions happening inside.
> >> >
> >> >       echo "1m nodes=0" > memory.reclaim
> >>
> >> Have you tested these tests in the original kernel?  If so, whether does
> >> the issue you suspected above occurs during testing?
> >>
> >
> > Yes. I set up a test case where I allocate 500m in a cgroup, and then do:
> >
> >     echo "50m" > memory.reclaim
> >
> > Without my fix, my kernel demotes 70mb and reclaims 4 mb.
> >
> > With my v1 fix, my kernel demotes all memory possible and reclaims 60mb.
> >
> > I will add this to the commit message in the next version.
>
> Good!  Thanks!
>
> Best Regards,
> Huang, Ying
>
> >>
> >> > Will cause freeing of 1m of node 0 by demotion if a demotion target is
> >> > available, and by reclaim if no demotion target is available.
> >> >
> >> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >> >
> >> > ---
> >> >
> >> > This is developed on top of mm-unstable largely because I need the
> >> > memory.reclaim nodes= arg to test it properly.
> >> > ---
> >> >  mm/vmscan.c | 13 ++++++++++++-
> >> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> > index 2b42ac9ad755..8f6e993b870d 100644
> >> > --- a/mm/vmscan.c
> >> > +++ b/mm/vmscan.c
> >> > @@ -1653,6 +1653,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >> >       LIST_HEAD(free_folios);
> >> >       LIST_HEAD(demote_folios);
> >> >       unsigned int nr_reclaimed = 0;
> >> > +     unsigned int nr_demoted = 0;
> >> >       unsigned int pgactivate = 0;
> >> >       bool do_demote_pass;
> >> >       struct swap_iocb *plug = NULL;
> >> > @@ -2085,7 +2086,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >> >       /* 'folio_list' is always empty here */
> >> >
> >> >       /* Migrate folios selected for demotion */
> >> > -     nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
> >> > +     nr_demoted = demote_folio_list(&demote_folios, pgdat);
> >> > +
> >> > +     /*
> >> > +      * Only count demoted folios as reclaimed if we demoted them from
> >> > +      * inside of the nodemask to outside of the nodemask, hence reclaiming
> >> > +      * pages in the nodemask.
> >> > +      */
> >> > +     if (sc->nodemask && node_isset(pgdat->node_id, *sc->nodemask) &&
> >> > +         !node_isset(next_demotion_node(pgdat->node_id), *sc->nodemask))
> >> > +             nr_reclaimed += nr_demoted;
> >> > +
> >> >       /* Folios that could not be demoted are still in @demote_folios */
> >> >       if (!list_empty(&demote_folios)) {
> >> >               /* Folios which weren't demoted go back on @folio_list */
> >> > --
> >> > 2.39.0.rc0.267.gcb52ba06e7-goog
> >>
>
