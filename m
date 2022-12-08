Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67E646B3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLHJA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLHJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:00:55 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2627D4841C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:00:53 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id d185so904236vsd.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 01:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JR2pG9tV9FSrRFa+WDb2jw9B3fBXybAeCMdReMmHEA=;
        b=EzjyjnhEaXK3XlFKfEJjDH1m9eC1v0n0aiIRocc6iwyNzpxSguqz7Syw2fSRQYYHlE
         PAUpRLlr+qnUS0aPIFl0oc+rsoV1z6bWBoDe5Z6u9j8osJYs8xRLDBQWPxgEWT7zX6dh
         KJp0OUQpQ2EIS7H9wajb7F/tL/xECMxIU8fEAniQNmhWbfkkLsU5BzR/DpXVkP1/sn+7
         Szdki1JXv2nwz8AOldezpoDfYZb21LXhPOHvf/tGmMrpgR30pm9Dx6wrd+5PQLKBgTUr
         qcVV3TKhw620Fyp9kf5AbyfFgPy8mA9anJOBqyYiqqrsiuM31or4uoNaAF74GKX4+V6T
         t3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JR2pG9tV9FSrRFa+WDb2jw9B3fBXybAeCMdReMmHEA=;
        b=bbWkA6oHXlIsXrFzhDCY+0BqsHU/MSmrbq5M05Y8Glm/1DvaWIYfqeKKew/4KWfqz0
         inU84AHu+cOlpN2GEyiAjYU/7oecDi5JqV0z/y0i9NjOzjxKDh+QQnd66/0KveRdAGfM
         g+ZMBpA1gFFiKryQ8zPxEgw92PAHX7OVDPT40tyj4AyAUPp3ef43Y3C1GvVoSsOQQ5YT
         4A3lSGXEZxVkAuy7Z6bQrTLDnrOGgY6IniPY7ARIn+1lQUPU4mZM3/S91TDrceho+rUi
         YmIHHDcJ/rEEalZBAf+iIbdNwMWKLr7evjNO/hYjFhcH2/eBzdTpmiqlnpi/pYMMR2JE
         TyLg==
X-Gm-Message-State: ANoB5pnSAqkU4laD/ESeETFRsemqjptRhnNw5b4H22Tecsi9e/k7zJVK
        Rsh3ag2IUWIvtFvBkZRJzhA1slU+1OM5JpHS/OYdmA==
X-Google-Smtp-Source: AA0mqf5IM9NcRNgCI2Fdb5O6N4IdAmRg2deTbxr+Xj6ercC607o7pe9uQk8QDVhskwWn0bUuEFC+Vb/kzRdzuAo2JeY=
X-Received: by 2002:a67:ea04:0:b0:3a7:d7bc:c2e9 with SMTP id
 g4-20020a67ea04000000b003a7d7bcc2e9mr42911158vso.61.1670490051902; Thu, 08
 Dec 2022 01:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20221206023406.3182800-1-almasrymina@google.com>
 <Y48zlaimOb/wr8qd@dhcp22.suse.cz> <CAHS8izMKz_JtN-P7BTHydE2x2rmSg5-JRoHgaDCdCHV-S0YLJw@mail.gmail.com>
 <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz> <CAHS8izOW70Eb7RRePQv6SP8hW3iUnAcPSD=aOY+aMu=6ReEtHQ@mail.gmail.com>
 <Y5B1K5zAE0PkjFZx@dhcp22.suse.cz> <CAHS8izMKK107wVFSJvg36nQ=WzXd8_cjYBtR0p47L+XLYUSsqA@mail.gmail.com>
 <Y5Gbwwp7AlFiltuu@dhcp22.suse.cz>
In-Reply-To: <Y5Gbwwp7AlFiltuu@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 8 Dec 2022 01:00:40 -0800
Message-ID: <CAHS8izMhRXMB5QJab5AvuHiWiQUAzUf81-7Y71ueEEnz71dwiQ@mail.gmail.com>
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

On Thu, Dec 8, 2022 at 12:09 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 07-12-22 13:43:55, Mina Almasry wrote:
> > On Wed, Dec 7, 2022 at 3:12 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > Anyway a proper nr_reclaimed tracking should be rather straightforward
> > > but I do not expect to make a big difference in practice
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 026199c047e0..1b7f2d8cb128 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -1633,7 +1633,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> > >         LIST_HEAD(ret_folios);
> > >         LIST_HEAD(free_folios);
> > >         LIST_HEAD(demote_folios);
> > > -       unsigned int nr_reclaimed = 0;
> > > +       unsigned int nr_reclaimed = 0, nr_demoted = 0;
> > >         unsigned int pgactivate = 0;
> > >         bool do_demote_pass;
> > >         struct swap_iocb *plug = NULL;
> > > @@ -2065,8 +2065,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> > >         }
> > >         /* 'folio_list' is always empty here */
> > >
> > > -       /* Migrate folios selected for demotion */
> > > -       nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
> > > +       /*
> > > +        * Migrate folios selected for demotion.
> > > +        * Do not consider demoted pages to be reclaimed for the memcg reclaim
> > > +        * because no charges are really freed during the migration. Global
> > > +        * reclaim aims at releasing memory from nodes/zones so consider
> > > +        * demotion to reclaim memory.
> > > +        */
> > > +       nr_demoted += demote_folio_list(&demote_folios, pgdat);
> > > +       if (!cgroup_reclaim(sc))
> > > +               nr_reclaimed += nr_demoted;
> > > +
> > >         /* Folios that could not be demoted are still in @demote_folios */
> > >         if (!list_empty(&demote_folios)) {
> > >                 /* Folios which weren't demoted go back on @folio_list for retry: */
> > >
> > > [...]
> >
> > Thank you again, but this patch breaks the memory.reclaim nodes arg
> > for me. This is my test case. I run it on a machine with 2 memory
> > tiers.
> >
> > Memory tier 1= nodes 0-2
> > Memory tier 2= node 3
> >
> >     mkdir -p /sys/fs/cgroup/unified/test
> >     cd /sys/fs/cgroup/unified/test
> >     echo $$ > cgroup.procs
> >     head -c 500m /dev/random > /tmp/testfile
> >     echo $$ > /sys/fs/cgroup/unified/cgroup.procs
> >     echo "1m nodes=0-2" > memory.reclaim
> >
> > In my opinion the expected behavior is for the kernel to demote 1mb of
> > memory from nodes 0-2 to node 3.
> >
> > Actual behavior on the tip of mm-unstable is as expected.
> >
> > Actual behavior with your patch cherry-picked to mm-unstable is that
> > the kernel demotes all 500mb of memory from nodes 0-2 to node 3, and
> > returns -EAGAIN to the user. This may be the correct behavior you're
> > intending, but it completely breaks the use case I implemented the
> > nodes= arg for and listed on the commit message of that change.
>
> Yes, strictly speaking the behavior is correct albeit unexpected. You
> have told the kernel to _reclaim_ that much memory but demotion are
> simply aging handling rather than a reclaim if the demotion target has a
> lot of memory free.

Yes, by the strict definition of reclaim, you're completely correct.
But in reality earlier I proposed a patch to the kernel that disables
demotion in proactive reclaim. That would have been a correct change
by the strict definition of reclaim, but Johannes informed me that
meta already has a dependency on proactive reclaim triggering demotion
and directed me to add a nodes= arg to memory.reclaim to trigger
demotion instead, to satisfy both use cases. Seems both us and meta
are using this interface to trigger both reclaim and demotion, despite
the strict definition of the word?

> This would be the case without any nodemask as well
> btw.
>

The difference here is that without any nodemask, the kernel will also
reclaim from bottom tier nodes, which will count towards the user's
request so the behavior makes sense in my opinion. If nodemask=NULL or
nodemask=ALL_NODES, then the caller is asking for reclaim across all
nodes which should not count demoted pages IMO. The kernel can still
look for demotion opportunities, but the demoted pages would not count
towards the user's request.

> I am worried this will popping up again and again. I thought your nodes
> subset approach could deal with this but I have overlooked one important
> thing in your patch. The user provided nodemask controls where to
> reclaim from but it doesn't constrain demotion targets. Is this
> intentional? Would it actually make more sense to control demotion by
> addint demotion nodes into the nodemask?
>

IMO, yes it is intentional, and no I would not recommend adding
demotion nodes (I assume you mean adding both demote_from_nodes and
demote_to_nodes as arg). My opinion is based on 2 reasons:

1. We control proactive reclaim by looking for nodes/tiers approaching
pressure and triggering reclaim/demotion from said nodes/tiers. So we
know the node/tier we would like to reclaim from, but not necessarily
have a requirement on where the memory should go. I think it should be
up to the kernel.
2. Currently I think most tiered machines will have 2 memory tiers,
but I think the code is designed to support N memory tiers. What
happens if N=3 and the user asks you to demote from the top tier nodes
to the bottom tier nodes (skipping the middle tier)? The user in this
case is explicitly asking to break the aging pipeline. From my short
while on the mailing list I see great interest in respecting the aging
pipeline, so it seems to me the demotion target should be decided by
the kernel based on the aging pipeline, and the user should not be
able to override it? I don't know. Maybe there is a valid use case for
that somewhere.

> --
> Michal Hocko
> SUSE Labs
