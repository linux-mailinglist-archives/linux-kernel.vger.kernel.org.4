Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FFB64519C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiLGB4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiLGB4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:56:16 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A68532D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:56:11 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id f189so11441081vsc.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 17:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mL42ZLeHwCOgm2dvIiRUP/S/P8aaOI55orVdQTEq1so=;
        b=p8ZTQ2rU5P4QOtPRFnTYHuXdD+XDdWS37wPhaV6Vzsl06SEO63uhm5y8g5EY4pVhHt
         vZ/WZm1jjEnByccyvCIV8pS12Gnll4Vns3pQ1kk8YJWbgGaiw4TrKIGGyqj45oZ1YFFe
         0dSIWF7rVcT5bNaqFYEy6JH/GmKfvqQeTdqyZSRbphVYy9hGksGun8HPh+NqpWfPhkiy
         SdgwG8QD74z9eeJc+IN5LumC8Co5cOyVoWz9UpdZKaUVBSYDPaJRPkyfx0LtPQD1TRzg
         7cgd86WssXlHvN31iH8Z7rZ1uNOY7NiiNA0pJE/4KIgCyQKo9XZ0v34+6FaEQbMX65kq
         z+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mL42ZLeHwCOgm2dvIiRUP/S/P8aaOI55orVdQTEq1so=;
        b=IK3JHr320scAOYhCiTnyU/tKYb2q34qwhTePL9Jd+/aq9B/nYISHgDsiv/yLT3bb4S
         qhWNGTLZKhpf/16t4nZefuhGk5WOMp/UAbDjlJr3O3HYwYjS1A3FWMB4hJl25UPiQW5X
         v00UamunufylGvEaxw+likbs2vemO1xb00dczybPpZLZb3G+2jmc/53HvrfxF0fssTJn
         zZJzlzRfGKmK81hB47wxmcDzxqPkw2U8fKBNbKz7K62KD0+kuvMNyTJKb6I5bJ5JlnJN
         cU1PK0HwLsck86NPmP9LuTcw3TVWxYpWh5W2n0XI3eU519fGGtIQf0jS+Rw0F6zORzgF
         JuKw==
X-Gm-Message-State: ANoB5pnB+djX8DhACsgJl0kfQB4Vp4BMZlaAk2EVl3Af+XYz4ai0LBop
        2Vkq/47G5zcUkg+s3YrWqHasLXG8lC2vSY5b2CrWwQ==
X-Google-Smtp-Source: AA0mqf7Q5B67Pew3oFXM7oertV7l9BHogxhEnaO+dnmzmB/oGQH6BC7i3f6rXUCoLEzBckkxwigZoGYxLfaVPlELQLI=
X-Received: by 2002:a05:6102:54a5:b0:3b0:7462:a88c with SMTP id
 bk37-20020a05610254a500b003b07462a88cmr34065725vsb.49.1670378170228; Tue, 06
 Dec 2022 17:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20221206023406.3182800-1-almasrymina@google.com>
 <Y48zlaimOb/wr8qd@dhcp22.suse.cz> <CAHS8izMKz_JtN-P7BTHydE2x2rmSg5-JRoHgaDCdCHV-S0YLJw@mail.gmail.com>
 <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz>
In-Reply-To: <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 6 Dec 2022 17:55:58 -0800
Message-ID: <CAHS8izOW70Eb7RRePQv6SP8hW3iUnAcPSD=aOY+aMu=6ReEtHQ@mail.gmail.com>
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

On Tue, Dec 6, 2022 at 11:55 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 06-12-22 08:06:51, Mina Almasry wrote:
> > On Tue, Dec 6, 2022 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 05-12-22 18:34:05, Mina Almasry wrote:
> > > > commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > > > reclaim"") enabled demotion in memcg reclaim, which is the right thing
> > > > to do, however, it introduced a regression in the behavior of
> > > > try_to_free_mem_cgroup_pages().
> > > >
> > > > The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> > > > reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> > > > of the cgroup should reduce by nr_pages. The callers expect
> > > > try_to_free_mem_cgroup_pages() to also return the number of pages
> > > > reclaimed, not demoted.
> > > >
> > > > However, what try_to_free_mem_cgroup_pages() actually does is it
> > > > unconditionally counts demoted pages as reclaimed pages. So in practice
> > > > when it is called it will often demote nr_pages and return the number of
> > > > demoted pages to the caller. Demoted pages don't lower the memcg usage,
> > > > and so try_to_free_mem_cgroup_pages() is not actually doing what the
> > > > callers want it to do.
> > > >
> > > > Various things work suboptimally on memory tiered systems or don't work
> > > > at all due to this:
> > > >
> > > > - memory.high enforcement likely doesn't work (it just demotes nr_pages
> > > >   instead of lowering the memcg usage by nr_pages).
> > > > - try_charge_memcg() will keep retrying the charge while
> > > >   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
> > > >   making any room for the charge.
> > >
> > > This has been brought up during the review https://lore.kernel.org/all/YoYTEDD+c4GT0xYY@dhcp22.suse.cz/
> > >
> >
> > Ah, I did indeed miss this. Thanks for the pointer. However I don't
> > understand this bit from your email (sorry I'm probably missing
> > something):
> >
> > "I suspect this is rather unlikely situation, though. The last tear
> > (without any fallback) should have some memory to reclaim most of
> > the time."
> >
> > Reading the code in try_charge_memcg(), I don't see the last retry for
> > try_to_free_mem_cgroup_pages() do anything special. My concern here is
> > that try_charge_memcg() calls try_to_free_mem_cgroup_pages()
> > MAX_RECLAIM_RETRIES times. Each time that call may demote pages and
> > report back that it was able to 'reclaim' memory, but the charge keeps
> > failing because the memcg reclaim didn't actually make room for the
> > charge. What happens in this case? My understanding is that the memcg
> > oom-killer gets wrongly invoked.
>
> The memcg reclaim shrinks from all zones in the allowed zonelist. In
> general from all nodes. So unless the lower tier is outside of this
> zonelist then there is a zone to reclaim from which cannot demote.
> Correct?
>

Ah, thanks for pointing this out. I did indeed miss that the memcg
reclaim tries to apply pressure equally to all the nodes. With some
additional testing I'm able to see what you said: there could be no
premature oom kill invocation because generally the memcg reclaim will
find some pages to reclaim from lower tier nodes.

I do find that the first call to try_to_free_mem_cgroup_pages()
sometimes will mostly demote and not do much reclaim. I haven't been
able to fully track the cause of that down but I suspect that the
first call in my test will find most of the cgroup's memory on top
tier nodes. However we do retry a bunch of times before we invoke oom,
and in my testing subsequent calls will find plenty of memory in the
lower tier nodes that it can reclaim. I'll update the commit message
in the next version.

> > > > - memory.reclaim has a wonky interface. It advertises to the user it
> > > >   reclaims the provided amount but it will actually often demote that
> > > >   amount.
> > > >
> > > > There may be more effects to this issue.
> > > >
> > > > To fix these issues I propose shrink_folio_list() to only count pages
> > > > demoted from inside of sc->nodemask to outside of sc->nodemask as
> > > > 'reclaimed'.
> > >
> > > Could you expand on why the node mask matters? From the charge point of
> > > view it should be completely uninteresting as the charge remains.
> > >
> > > I suspect we really need to change to reclaim metrics for memcg reclaim.
> > > In the memory balancing reclaim we can indeed consider demotions as a
> > > reclaim because the memory is freed in the end but for the memcg reclaim
> > > we really should be counting discharges instead. No demotion/migration will
> > > free up charges.
> >
> > I think what you're describing is exactly what this patch aims to do.
> > I'm proposing an interface change to shrink_folio_list() such that it
> > only counts demoted pages as reclaimed iff sc->nodemask is provided by
> > the caller and the demotion removed pages from inside sc->nodemask to
> > outside sc->nodemask. In this case:
> >
> > 1. memory balancing reclaim would pass sc->nodemask=nid to
> > shrink_folio_list() indicating that it should count pages demoted from
> > sc->nodemask as reclaimed.
> >
> > 2. memcg reclaim would pass sc->nodemask=NULL to shrink_folio_list()
> > indicating that it is looking for reclaim across all nodes and no
> > demoted pages should count as reclaimed.
> >
> > Sorry if the commit message was not clear. I can try making it clearer
> > in the next version but it's already very long.
>
> Either I am missing something or I simply do not understand why you are
> hooked into nodemask so much. Why cannot we have a simple rule that
> only global reclaim considers demotions as nr_reclaimed?
>

Thanks. I think this approach would work for most callers. My issue
here is properly supporting the recently added nodes= arg[1] to
memory.reclaim. If the user specifies all nodes or provides no arg,
I'd like to treat it as memcg reclaim which doesn't count demotions.
If the user provides the top tier nodes, I would like to count
demotions as this interface is the way to trigger proactive demotion
from top tier nodes.

I guess I can check which args the user is passing and decide whether
or not to count demotions. But the user right now can specify any
combination of nodes, some of them top tier, some lower tier, some in
the middle. I can return -EINVAL for that, but that seems like a
shame. I thought a generic way to address this was what I'm doing
here, i.e. counting pages demoted from the nodemask as reclaimed. Is
that not acceptable? Is -EINVAL preferred here?

[1] https://lore.kernel.org/linux-mm/87tu2a1v3y.fsf@yhuang6-desk2.ccr.corp.intel.com/

> --
> Michal Hocko
> SUSE Labs
