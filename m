Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A133C647B12
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLIA7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLIA7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:59:50 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B817FF2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:59:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so6438033pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 16:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2U9eMXhbenP56WJasdNaIIj3GD4/sTO3KV8+xVkcYe8=;
        b=s73H+aXNz8dOAPCoTCrwWNBKOg1X8ONzNYgVkuVHCHXYPwr1vTFLnG5c4VKnUaBCkb
         gWBbcrrjXsxZfRSHGSCey3c5Tq91ta2QnaX3sugxG7yfyFHxC1gysv5PbfXtFUfljLj+
         FbjLm9yr7q4H5cqQtr3xI28emZ0hnWyl+F1gtPdwP54ZAv0Sj0Gkejcy3Y2OgPiXVqo5
         MPJpyCHex5uCZksVhUviq8hF8uLGK0PCgZf5utopHm5hyYgtuNNNfBlmPcOwqNh5DFMc
         auLC/t/VZqkTjTTNmAQK+QrdvbCAYbRksroieoO7KfJrSRP0SspXt+lRiF9S+ZBMJ0yX
         YhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2U9eMXhbenP56WJasdNaIIj3GD4/sTO3KV8+xVkcYe8=;
        b=1+yoDinSzI/kWJ+8u+6ldgSUpsL7XHEVss6ekS/Gujp6FraP8XagOOSng2omI/KWrg
         QBHcoq3Owf/KJcQt6PyLzFwZVaMO5wmcErn24p8ggTiC45nf/HvFFAdHK0It8EzzpZV6
         c8IpzTVgJT/NhP4ZSHKeJe69bE/dvW+Xe39FmZopyOn7i8KNuBEdLXdxE2tlOE7ZD8gn
         ta2M9S7umCes5svplgUCisP9A/IYJ5gvMmFjGKYtwBx41Q26Qo9H/spWwMC29djeiLH5
         LysdDyMrf6soIM4vWZj3fsqGqdJjdiQCjCNbHj04iLCCJcVgv+SYRvba0nElpmKRvnxa
         Q04g==
X-Gm-Message-State: ANoB5pmtzHjiehskc6sFH9OqZFYln+PFevamS5ubLHHcNpBXhzEiZgOe
        o6f7vSkqH7CTP+i2/5ueJqhEUwLK6GpW++m4GXD17A==
X-Google-Smtp-Source: AA0mqf4+L6Y8rNezsq0n5sCmTN4mV923L0eBFglJ5E/dGjr/OpWA5PXz898gQTrVdiwye7p2NKWbUqOZVRWJOwmKY1I=
X-Received: by 2002:a17:903:240a:b0:188:5d24:87e with SMTP id
 e10-20020a170903240a00b001885d24087emr79630543plo.87.1670547588394; Thu, 08
 Dec 2022 16:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20221206023406.3182800-1-almasrymina@google.com>
 <Y48zlaimOb/wr8qd@dhcp22.suse.cz> <CAHS8izMKz_JtN-P7BTHydE2x2rmSg5-JRoHgaDCdCHV-S0YLJw@mail.gmail.com>
 <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz> <CAHS8izOW70Eb7RRePQv6SP8hW3iUnAcPSD=aOY+aMu=6ReEtHQ@mail.gmail.com>
 <Y5B1K5zAE0PkjFZx@dhcp22.suse.cz> <CAHS8izMKK107wVFSJvg36nQ=WzXd8_cjYBtR0p47L+XLYUSsqA@mail.gmail.com>
 <Y5Gbwwp7AlFiltuu@dhcp22.suse.cz> <CAHS8izMhRXMB5QJab5AvuHiWiQUAzUf81-7Y71ueEEnz71dwiQ@mail.gmail.com>
 <Y5HQgpRvPQWteNvz@dhcp22.suse.cz>
In-Reply-To: <Y5HQgpRvPQWteNvz@dhcp22.suse.cz>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 8 Dec 2022 16:59:36 -0800
Message-ID: <CAAPL-u_bEhCCCnepmCuNe7q7qJY3G3wckGvG-QsF2SYpAVXhEA@mail.gmail.com>
Subject: Re: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, fvdl@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Thu, Dec 8, 2022 at 3:54 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 08-12-22 01:00:40, Mina Almasry wrote:
> > On Thu, Dec 8, 2022 at 12:09 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 07-12-22 13:43:55, Mina Almasry wrote:
> > > > On Wed, Dec 7, 2022 at 3:12 AM Michal Hocko <mhocko@suse.com> wrote:
> > > [...]
> > > > > Anyway a proper nr_reclaimed tracking should be rather straightforward
> > > > > but I do not expect to make a big difference in practice
> > > > >
> > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > index 026199c047e0..1b7f2d8cb128 100644
> > > > > --- a/mm/vmscan.c
> > > > > +++ b/mm/vmscan.c
> > > > > @@ -1633,7 +1633,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> > > > >         LIST_HEAD(ret_folios);
> > > > >         LIST_HEAD(free_folios);
> > > > >         LIST_HEAD(demote_folios);
> > > > > -       unsigned int nr_reclaimed = 0;
> > > > > +       unsigned int nr_reclaimed = 0, nr_demoted = 0;
> > > > >         unsigned int pgactivate = 0;
> > > > >         bool do_demote_pass;
> > > > >         struct swap_iocb *plug = NULL;
> > > > > @@ -2065,8 +2065,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> > > > >         }
> > > > >         /* 'folio_list' is always empty here */
> > > > >
> > > > > -       /* Migrate folios selected for demotion */
> > > > > -       nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
> > > > > +       /*
> > > > > +        * Migrate folios selected for demotion.
> > > > > +        * Do not consider demoted pages to be reclaimed for the memcg reclaim
> > > > > +        * because no charges are really freed during the migration. Global
> > > > > +        * reclaim aims at releasing memory from nodes/zones so consider
> > > > > +        * demotion to reclaim memory.
> > > > > +        */
> > > > > +       nr_demoted += demote_folio_list(&demote_folios, pgdat);
> > > > > +       if (!cgroup_reclaim(sc))
> > > > > +               nr_reclaimed += nr_demoted;
> > > > > +
> > > > >         /* Folios that could not be demoted are still in @demote_folios */
> > > > >         if (!list_empty(&demote_folios)) {
> > > > >                 /* Folios which weren't demoted go back on @folio_list for retry: */
> > > > >
> > > > > [...]
> > > >
> > > > Thank you again, but this patch breaks the memory.reclaim nodes arg
> > > > for me. This is my test case. I run it on a machine with 2 memory
> > > > tiers.
> > > >
> > > > Memory tier 1= nodes 0-2
> > > > Memory tier 2= node 3
> > > >
> > > >     mkdir -p /sys/fs/cgroup/unified/test
> > > >     cd /sys/fs/cgroup/unified/test
> > > >     echo $$ > cgroup.procs
> > > >     head -c 500m /dev/random > /tmp/testfile
> > > >     echo $$ > /sys/fs/cgroup/unified/cgroup.procs
> > > >     echo "1m nodes=0-2" > memory.reclaim
> > > >
> > > > In my opinion the expected behavior is for the kernel to demote 1mb of
> > > > memory from nodes 0-2 to node 3.
> > > >
> > > > Actual behavior on the tip of mm-unstable is as expected.
> > > >
> > > > Actual behavior with your patch cherry-picked to mm-unstable is that
> > > > the kernel demotes all 500mb of memory from nodes 0-2 to node 3, and
> > > > returns -EAGAIN to the user. This may be the correct behavior you're
> > > > intending, but it completely breaks the use case I implemented the
> > > > nodes= arg for and listed on the commit message of that change.
> > >
> > > Yes, strictly speaking the behavior is correct albeit unexpected. You
> > > have told the kernel to _reclaim_ that much memory but demotion are
> > > simply aging handling rather than a reclaim if the demotion target has a
> > > lot of memory free.
> >
> > Yes, by the strict definition of reclaim, you're completely correct.
> > But in reality earlier I proposed a patch to the kernel that disables
> > demotion in proactive reclaim. That would have been a correct change
> > by the strict definition of reclaim, but Johannes informed me that
> > meta already has a dependency on proactive reclaim triggering demotion
> > and directed me to add a nodes= arg to memory.reclaim to trigger
> > demotion instead, to satisfy both use cases. Seems both us and meta
> > are using this interface to trigger both reclaim and demotion, despite
> > the strict definition of the word?
>
> Well, demotion is a part of aging and that is a part of the reclaim so I
> believe we want both and demotion mostly an implementation detail. If
> you want to have a very precise control then the nodemask should drive
> you there.
>
> [...]
> > > I am worried this will popping up again and again. I thought your nodes
> > > subset approach could deal with this but I have overlooked one important
> > > thing in your patch. The user provided nodemask controls where to
> > > reclaim from but it doesn't constrain demotion targets. Is this
> > > intentional? Would it actually make more sense to control demotion by
> > > addint demotion nodes into the nodemask?
> > >
> >
> > IMO, yes it is intentional, and no I would not recommend adding
> > demotion nodes (I assume you mean adding both demote_from_nodes and
> > demote_to_nodes as arg).
>
> What I really mean is to add demotion nodes to the nodemask along with
> the set of nodes you want to reclaim from. To me that sounds like a
> more natural interface allowing for all sorts of usecases:
> - free up demotion targets (only specify demotion nodes in the mask)
> - control where to demote (e.g. select specific demotion target(s))
> - do not demote at all (skip demotion nodes from the node mask)

For clarification, do you mean to add another argument (e.g.
demotion_nodes) in addition to the "nodes" argument?   Also, which
meaning do these arguments have?

- Option 1: The "nodes" argument specifies the source nodes where
pages should be reclaimed (but not demoted) from and the
"demotion_nodes" argument specifies the source nodes where pages
should be demoted (but not reclaimed) from.

- Option 2: The "nodes" argument specifies the source nodes where
pages should be reclaimed or demoted from and the "demotion_nodes"
argument specifies the allowed demotion target nodes.

Option 1 is more flexible in allowing various use cases. Option 2 can
also support the use cases to reclaim only without demotion and
demotion with fallback to reclaim, but cannot support demotion only
without reclaim.

> > My opinion is based on 2 reasons:
> >
> > 1. We control proactive reclaim by looking for nodes/tiers approaching
> > pressure and triggering reclaim/demotion from said nodes/tiers. So we
> > know the node/tier we would like to reclaim from, but not necessarily
> > have a requirement on where the memory should go. I think it should be
> > up to the kernel.
> > 2. Currently I think most tiered machines will have 2 memory tiers,
> > but I think the code is designed to support N memory tiers. What
> > happens if N=3 and the user asks you to demote from the top tier nodes
> > to the bottom tier nodes (skipping the middle tier)? The user in this
> > case is explicitly asking to break the aging pipeline. From my short
> > while on the mailing list I see great interest in respecting the aging
> > pipeline, so it seems to me the demotion target should be decided by
> > the kernel based on the aging pipeline, and the user should not be
> > able to override it? I don't know. Maybe there is a valid use case for
> > that somewhere.
>
> I agree that the agining should be preserved as much as possible unless
> there is an explicit requirement to do otherwise which might be
> something application specific.
>
> It is really hard to assume all the usecases at this stage but we should
> keep in mind that the semantic of the interface will get cast into stone
> once it is released. As of now I do see a great confusion point in the
> nodemask semantic which pretends to allow some fine control while it is
> largerly hard to predict because it makes some assumptions about the
> reclaim while it has a very limited control of the demotion.
>
> --
> Michal Hocko
> SUSE Labs
