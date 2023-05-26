Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A84712BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjEZRbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEZRbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:31:53 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8089A9C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:31:51 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-561b50c1856so15494477b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685122310; x=1687714310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsiqf3KeMf8SZgsPZx8qRFpWcMM2svqWyVYP+PQoum8=;
        b=A9FnJrxAqw8i9zJjexoiZDtmxMLDAUtDkl/L4bhYnErEIWSjKU6yxnPh8xVSHrG9dL
         jr7bhNZeQpdXOT0odN+gI+3HYMdm5JzFrD/nU3E8cSF/IwjBlIm0IKu53CuQuaV09Uj0
         Z7Q9Lv66J9JtzpDTYuQtctwxz8NDeTk70UEuv0rtXjzG96oK+gRaHviov6YD8JnWxHlQ
         0WNOPLWoOR1vZO2qiIJygYOxew2jnjJ6E/6pRbEguEFwCG1sn8QTbgU3STW+ODJ33CJf
         StPVH+v9hgv4vgAvLbV8A2ugV9zzgPYYFiLZhixEmC7bfQcAxt/Ea6qe0hnXtk+f44qS
         tFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685122310; x=1687714310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsiqf3KeMf8SZgsPZx8qRFpWcMM2svqWyVYP+PQoum8=;
        b=guor7qen8wH+WppOQaf+bFiTg3hJFyvNoJpsfb27Vjqpar2zeLb/1IzxpWPOZpbqld
         dGb9K0kZVqbpeR0zOWYTPbgHlYXwVtifBWeN6RkVC6RnQwpdv5RlH6fDFSaGMUW+9UNj
         PkW4Ym6sII3a86FnxNSJbzqQ5+RxIS8HpTrJvmtWqIQADq0GsjjXEWu8k9+jpg30CmOY
         EFb3usFDPAY020xDR+EFEwZvYDZ8Pq1HJjstm+O8N5CyscRDfTcFh6Du1wUzFRfcdGQ2
         k0HnhUhbI/p5rZs1bhjC+/sJe8TytCJyy2NaX6hk3FVgyNPWxarR3+kB9XIhcFyZfJT7
         5cYg==
X-Gm-Message-State: AC+VfDxfZBEjRVBW2LR/WGMjJssBSDhqVUIaGLAM6TOPwyR73til7HsM
        /Fw74P/CoXjrp/sSSI1P4nrZUfAw8xj2rJ2FZo2R88UuaPJrPCoOe/hffA==
X-Google-Smtp-Source: ACHHUZ5fH6LR36TQmul3i3nk6N5YueZ5SAk1gkFVGYrfLMcEJyNFYTzgtPNkecjHttyWW1gdyw5RRbhYpG6HKby+jyc=
X-Received: by 2002:a0d:dbc6:0:b0:556:c2e1:6258 with SMTP id
 d189-20020a0ddbc6000000b00556c2e16258mr2859892ywe.11.1685122310458; Fri, 26
 May 2023 10:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <1684919574-28368-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20230525135407.GA31865@cmpxchg.org> <CAGWkznE0bNS6bZE99s1PkWdC9UkTQCC0aWo0pS94n8_nkQv7Rg@mail.gmail.com>
In-Reply-To: <CAGWkznE0bNS6bZE99s1PkWdC9UkTQCC0aWo0pS94n8_nkQv7Rg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 26 May 2023 10:31:39 -0700
Message-ID: <CAJuCfpE5oZpnOugpqHPRcgrbsB5QATiqyXgTd3gX3CafuiKgjg@mail.gmail.com>
Subject: Re: [PATCH] mm: deduct the number of pages reclaimed by madvise from workingset
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 11:39=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmai=
l.com> wrote:
>
> On Thu, May 25, 2023 at 9:54=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Wed, May 24, 2023 at 05:12:54PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > The pages reclaimed by madvise_pageout are made of inactive and dropp=
ed from LRU
> > > forcefully, which lead to the coming up refault pages possess a large=
 refault
> > > distance than it should be. These could affect the accuracy of thrash=
ing when
> > > madvise_pageout is used as a common way of memory reclaiming as ANDRO=
ID does now.
> >
> > This alludes to, but doesn't explain, a real world usecase.
> More block io(wait_on_page_bit_common) observed during APP start in
> latest android version where user space memory reclaiming changes from
> in-kernel PPR to madvise_pageout. We believe that it could be related
> with inaccuracy of workingset.

Do you mean the userspace incorrectly treats the active workingset as
inactive and purges it? If so, it sounds like the fix should be in the
userspace, not in the kernel.

> >
> > Yes, madvise_pageout() will record non-resident entries today. This
> > means refault and thrash detection is on for user-driven reclaim.
> >
> > So why is that undesirable?
> Let's raise an extreme scenario, that is, the tail page of LRU could
> experience a given refault distance without any in-kernel reclaiming
> and be wrongly deemed as inactive and get less protection.

madvise_pageout is a hint to the kernel that this page should be
treated as inactive, which it does. Why is that wrong?

> >
> > Today we measure and report the cost of reclaim and memory pressure
> > for physical memory shortages, cgroup limits, and user-driven cgroup
> > reclaim. Why should we not do the same for madv_pageout()? If the
> > userspace code that drives pageout has a bug and the result is extreme
> > thrashing, wouldn't you want to know that?
> Actually, the pages evicted by madv_cold/pageout from active_lru are
> not marked as WORKINGSET, which will surpass the thrashing account
> when it faults back and gets struck by IO. I think they should be
> treated in the same way in terms of SetPageWorkingset and
> lruvec->non-resident. Please refer to my previous patch "mm: mark
> folio as workingset in lru_deactivate_fn index 70e2063..4d1c14f
> 100644"

I see your point but it's debatable. If madvise_pageout is a hint to
treat the page as inactive, then why should the kernel treat it as
part of the active workingset when evicting?
I guess it boils down to whether the kernel should try fixing a wrong
hint from the userspace. I think not but I would be interested in the
opinions of others.
Thanks,
Suren.

>
>
> >
> > Please explain the idea here better.
> >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  include/linux/swap.h | 2 +-
> > >  mm/madvise.c         | 4 ++--
> > >  mm/vmscan.c          | 8 +++++++-
> > >  3 files changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > index 2787b84..0312142 100644
> > > --- a/include/linux/swap.h
> > > +++ b/include/linux/swap.h
> > > @@ -428,7 +428,7 @@ extern unsigned long mem_cgroup_shrink_node(struc=
t mem_cgroup *mem,
> > >  extern int vm_swappiness;
> > >  long remove_mapping(struct address_space *mapping, struct folio *fol=
io);
> > >
> > > -extern unsigned long reclaim_pages(struct list_head *page_list);
> > > +extern unsigned long reclaim_pages(struct mm_struct *mm, struct list=
_head *page_list);
> > >  #ifdef CONFIG_NUMA
> > >  extern int node_reclaim_mode;
> > >  extern int sysctl_min_unmapped_ratio;
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index b6ea204..61c8d7b 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -420,7 +420,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_=
t *pmd,
> > >  huge_unlock:
> > >               spin_unlock(ptl);
> > >               if (pageout)
> > > -                     reclaim_pages(&page_list);
> > > +                     reclaim_pages(mm, &page_list);
> > >               return 0;
> > >       }
> > >
> > > @@ -516,7 +516,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_=
t *pmd,
> > >       arch_leave_lazy_mmu_mode();
> > >       pte_unmap_unlock(orig_pte, ptl);
> > >       if (pageout)
> > > -             reclaim_pages(&page_list);
> > > +             reclaim_pages(mm, &page_list);
> > >       cond_resched();
> > >
> > >       return 0;
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 20facec..048c10b 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -2741,12 +2741,14 @@ static unsigned int reclaim_folio_list(struct=
 list_head *folio_list,
> > >       return nr_reclaimed;
> > >  }
> > >
> > > -unsigned long reclaim_pages(struct list_head *folio_list)
> > > +unsigned long reclaim_pages(struct mm_struct *mm, struct list_head *=
folio_list)
> > >  {
> > >       int nid;
> > >       unsigned int nr_reclaimed =3D 0;
> > >       LIST_HEAD(node_folio_list);
> > >       unsigned int noreclaim_flag;
> > > +     struct lruvec *lruvec;
> > > +     struct mem_cgroup *memcg =3D get_mem_cgroup_from_mm(mm);
> > >
> > >       if (list_empty(folio_list))
> > >               return nr_reclaimed;
> > > @@ -2764,10 +2766,14 @@ unsigned long reclaim_pages(struct list_head =
*folio_list)
> > >               }
> > >
> > >               nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, =
NODE_DATA(nid));
> > > +             lruvec =3D &memcg->nodeinfo[nid]->lruvec;
> > > +             workingset_age_nonresident(lruvec, -nr_reclaimed);
> > >               nid =3D folio_nid(lru_to_folio(folio_list));
> > >       } while (!list_empty(folio_list));
> > >
> > >       nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, NODE_DAT=
A(nid));
> > > +     lruvec =3D &memcg->nodeinfo[nid]->lruvec;
> > > +     workingset_age_nonresident(lruvec, -nr_reclaimed);
> >
> > The task might have moved cgroups in between, who knows what kind of
> > artifacts it will introduce if you wind back the wrong clock.
> >
> > If there are reclaim passes that shouldn't participate in non-resident
> > tracking, that should be plumbed through the stack to __remove_mapping
> > (which already has that bool reclaimed param to not record entries).
