Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB61464635E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiLGVoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLGVoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:44:09 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0104C813B0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:44:07 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id o136so499343vka.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 13:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uup7IkDj0Tj4wV+c1b16APmIL8/YUUL2/TzkGwezP54=;
        b=Ktalp9HZmEqYzzFA53wP+de1fhUrCUieTsR0ijbVrH2vpxmqnMu08SGmtDf6uA3hxB
         GYqGNC6CvxNBtX2ikrJPcpNe2FKF8GDITCJgvUQF4MrgphGC3Ih2Z+ansZ/FoxHG6xTB
         75JICu2DCJCamAqbthcAFX63+5E/Gu+sZJUCaML0GEWCYYL+w+J6jmbtvj+LtzZDEU9V
         8gTwjIT749WCnEQVgyEn7lfd7Tvy+V9wT12Hw1EUeEpdrcflFtf/Ao7Px6l2jt6jiIbR
         5cT93ROCIYF6H+m6xUdbx7u44uuJMGny2r9oReJAHt2KkKF9tXdi4IFUdTvbq8k3PmqG
         W6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uup7IkDj0Tj4wV+c1b16APmIL8/YUUL2/TzkGwezP54=;
        b=pkrOnBLhNaw1FsivQL/5O5JliQdqT0wD8peA6MjwHYeXDKTfIav/RrzH8tVxwH+aqz
         RCNlSpKTvyFpoa/m0CZ/PMcxfi+unsirkCTzL8wOOSzrLRInxl333W7K7J2ADbSCFieb
         URATWkVP21nYFHnxDcpeh/zasMR/TCcqem5gXXGoI+qTLtiFDVX3wILliUXorOD5PiLO
         RNK7HiJ8GqpNyyugBk6a+33gE2MYWGslRwUo4tnE5o7I+o9sagLiRIqztlMMXzwdR5Ry
         661A3rQgbDD7V2KoN/A4GXrPAuXPAAXKRRVVUDvvKvjf/+HUK7Zl7N/DHROExNo4TUIu
         VGqw==
X-Gm-Message-State: ANoB5pkiMUSdis2BEMSFsH3l2nDNq/FAA859ASRgPE85CIW8V+oDRmFf
        FSfx6RaPK2TngvtY2sbGta3OOt5dZi3W4xWpJPsYoQ==
X-Google-Smtp-Source: AA0mqf4G+r8VHesiFpRJVFS+4Uqt+AYMPWd4+05cWYFuYFwaSaULZlFLvOXyV30k+oepYxdsjKpoEEf5j0owzBAptak=
X-Received: by 2002:a05:6122:41e:b0:3bd:ad7c:b3ec with SMTP id
 e30-20020a056122041e00b003bdad7cb3ecmr7972933vkd.0.1670449446897; Wed, 07 Dec
 2022 13:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20221206023406.3182800-1-almasrymina@google.com>
 <Y48zlaimOb/wr8qd@dhcp22.suse.cz> <CAHS8izMKz_JtN-P7BTHydE2x2rmSg5-JRoHgaDCdCHV-S0YLJw@mail.gmail.com>
 <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz> <CAHS8izOW70Eb7RRePQv6SP8hW3iUnAcPSD=aOY+aMu=6ReEtHQ@mail.gmail.com>
 <Y5B1K5zAE0PkjFZx@dhcp22.suse.cz>
In-Reply-To: <Y5B1K5zAE0PkjFZx@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 7 Dec 2022 13:43:55 -0800
Message-ID: <CAHS8izMKK107wVFSJvg36nQ=WzXd8_cjYBtR0p47L+XLYUSsqA@mail.gmail.com>
Subject: Re: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
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

On Wed, Dec 7, 2022 at 3:12 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 06-12-22 17:55:58, Mina Almasry wrote:
> > On Tue, Dec 6, 2022 at 11:55 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 06-12-22 08:06:51, Mina Almasry wrote:
> > > > On Tue, Dec 6, 2022 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 05-12-22 18:34:05, Mina Almasry wrote:
> > > > > > commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > > > > > reclaim"") enabled demotion in memcg reclaim, which is the right thing
> > > > > > to do, however, it introduced a regression in the behavior of
> > > > > > try_to_free_mem_cgroup_pages().
> > > > > >
> > > > > > The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> > > > > > reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> > > > > > of the cgroup should reduce by nr_pages. The callers expect
> > > > > > try_to_free_mem_cgroup_pages() to also return the number of pages
> > > > > > reclaimed, not demoted.
> > > > > >
> > > > > > However, what try_to_free_mem_cgroup_pages() actually does is it
> > > > > > unconditionally counts demoted pages as reclaimed pages. So in practice
> > > > > > when it is called it will often demote nr_pages and return the number of
> > > > > > demoted pages to the caller. Demoted pages don't lower the memcg usage,
> > > > > > and so try_to_free_mem_cgroup_pages() is not actually doing what the
> > > > > > callers want it to do.
> > > > > >
> > > > > > Various things work suboptimally on memory tiered systems or don't work
> > > > > > at all due to this:
> > > > > >
> > > > > > - memory.high enforcement likely doesn't work (it just demotes nr_pages
> > > > > >   instead of lowering the memcg usage by nr_pages).
> > > > > > - try_charge_memcg() will keep retrying the charge while
> > > > > >   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
> > > > > >   making any room for the charge.
> > > > >
> > > > > This has been brought up during the review https://lore.kernel.org/all/YoYTEDD+c4GT0xYY@dhcp22.suse.cz/
> > > > >
> > > >
> > > > Ah, I did indeed miss this. Thanks for the pointer. However I don't
> > > > understand this bit from your email (sorry I'm probably missing
> > > > something):
> > > >
> > > > "I suspect this is rather unlikely situation, though. The last tear
> > > > (without any fallback) should have some memory to reclaim most of
> > > > the time."
> > > >
> > > > Reading the code in try_charge_memcg(), I don't see the last retry for
> > > > try_to_free_mem_cgroup_pages() do anything special. My concern here is
> > > > that try_charge_memcg() calls try_to_free_mem_cgroup_pages()
> > > > MAX_RECLAIM_RETRIES times. Each time that call may demote pages and
> > > > report back that it was able to 'reclaim' memory, but the charge keeps
> > > > failing because the memcg reclaim didn't actually make room for the
> > > > charge. What happens in this case? My understanding is that the memcg
> > > > oom-killer gets wrongly invoked.
> > >
> > > The memcg reclaim shrinks from all zones in the allowed zonelist. In
> > > general from all nodes. So unless the lower tier is outside of this
> > > zonelist then there is a zone to reclaim from which cannot demote.
> > > Correct?
> > >
> >
> > Ah, thanks for pointing this out. I did indeed miss that the memcg
> > reclaim tries to apply pressure equally to all the nodes. With some
> > additional testing I'm able to see what you said: there could be no
> > premature oom kill invocation because generally the memcg reclaim will
> > find some pages to reclaim from lower tier nodes.
> >
> > I do find that the first call to try_to_free_mem_cgroup_pages()
> > sometimes will mostly demote and not do much reclaim. I haven't been
> > able to fully track the cause of that down but I suspect that the
> > first call in my test will find most of the cgroup's memory on top
> > tier nodes. However we do retry a bunch of times before we invoke oom,
> > and in my testing subsequent calls will find plenty of memory in the
> > lower tier nodes that it can reclaim. I'll update the commit message
> > in the next version.
>
> In the past we used to break out early from the memcg reclaim if the
> reclaim target has been completed - see 1ba6fc9af35b ("mm: vmscan: do
> not share cgroup iteration between reclaimers"). But I do not see early
> break from the reclaim anywhere anymore so the precise nr_reclaimed
> tracking shouldn't make a lot of difference. There are cases where we
> really have hard time to find proper candidates and need to dip into
> hogher reclaim priorities though.
>

Yes, I agree. Thank you for your patient explanation. I now see why
precise accounting of nr_reclaimed is not an issue (or at least as big
an issue as I once thought).

> Anyway a proper nr_reclaimed tracking should be rather straightforward
> but I do not expect to make a big difference in practice
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 026199c047e0..1b7f2d8cb128 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1633,7 +1633,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>         LIST_HEAD(ret_folios);
>         LIST_HEAD(free_folios);
>         LIST_HEAD(demote_folios);
> -       unsigned int nr_reclaimed = 0;
> +       unsigned int nr_reclaimed = 0, nr_demoted = 0;
>         unsigned int pgactivate = 0;
>         bool do_demote_pass;
>         struct swap_iocb *plug = NULL;
> @@ -2065,8 +2065,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>         }
>         /* 'folio_list' is always empty here */
>
> -       /* Migrate folios selected for demotion */
> -       nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
> +       /*
> +        * Migrate folios selected for demotion.
> +        * Do not consider demoted pages to be reclaimed for the memcg reclaim
> +        * because no charges are really freed during the migration. Global
> +        * reclaim aims at releasing memory from nodes/zones so consider
> +        * demotion to reclaim memory.
> +        */
> +       nr_demoted += demote_folio_list(&demote_folios, pgdat);
> +       if (!cgroup_reclaim(sc))
> +               nr_reclaimed += nr_demoted;
> +
>         /* Folios that could not be demoted are still in @demote_folios */
>         if (!list_empty(&demote_folios)) {
>                 /* Folios which weren't demoted go back on @folio_list for retry: */
>
> [...]

Thank you again, but this patch breaks the memory.reclaim nodes arg
for me. This is my test case. I run it on a machine with 2 memory
tiers.

Memory tier 1= nodes 0-2
Memory tier 2= node 3

    mkdir -p /sys/fs/cgroup/unified/test
    cd /sys/fs/cgroup/unified/test
    echo $$ > cgroup.procs
    head -c 500m /dev/random > /tmp/testfile
    echo $$ > /sys/fs/cgroup/unified/cgroup.procs
    echo "1m nodes=0-2" > memory.reclaim

In my opinion the expected behavior is for the kernel to demote 1mb of
memory from nodes 0-2 to node 3.

Actual behavior on the tip of mm-unstable is as expected.

Actual behavior with your patch cherry-picked to mm-unstable is that
the kernel demotes all 500mb of memory from nodes 0-2 to node 3, and
returns -EAGAIN to the user. This may be the correct behavior you're
intending, but it completely breaks the use case I implemented the
nodes= arg for and listed on the commit message of that change.

> > > Either I am missing something or I simply do not understand why you are
> > > hooked into nodemask so much. Why cannot we have a simple rule that
> > > only global reclaim considers demotions as nr_reclaimed?
> > >
> >
> > Thanks. I think this approach would work for most callers. My issue
> > here is properly supporting the recently added nodes= arg[1] to
> > memory.reclaim. If the user specifies all nodes or provides no arg,
> > I'd like to treat it as memcg reclaim which doesn't count demotions.
> > If the user provides the top tier nodes, I would like to count
> > demotions as this interface is the way to trigger proactive demotion
> > from top tier nodes.
>
> Sorry to repeat myself but nodemask doesn't really make any difference.
> The reclaim should only count pages which really free memory in the
> domain. Even if you demote to a node outside of the given nodemask then
> the charge stays with the existing memcg so it is rather dubious to
> count it as a reclaimed page. Or do I still miss what you are trying to
> achieve?
>

I think you've convinced me that the issue is not as serious as I
first thought, thanks. We can maybe abandon this fix? If we do want to
fix this now or in the future, if possible let the fix be compatible
with memory.reclaim and its nodes= arg. I'm happy to provide patches
for whatever fix you find acceptable.

> --
> Michal Hocko
> SUSE Labs
