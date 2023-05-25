Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156C3710251
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjEYBXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEYBXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:23:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C67F5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 18:23:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so1706556e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 18:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684977811; x=1687569811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImO6OtSkFfnvqFi/Tdj42NbWs/io79Pf0LI695zdQVY=;
        b=cLEsJxGCeWR0JFmIcbzKPv46zp4Nl1rQF+aCeJitALaDzDdP0m0Dnl7gfz6vwlNqPj
         xp2kGQXVGvaqzlpJIoxk6U6dLDDHWyQoD4snYzy+ZHTadjqyIrgwm+AVPX//PY5VGnmr
         PMh8/910FClKBXpC+Ffitssgdo/KLt/GarDP192FFlK6RT3yTJxHyhYqO3YFG4FLaVvT
         pFmmoholHhL1vxdfVoGxUfSJJNLtWNWHQn+qgj89q2lpoHw5YHQKgAKVdEfqDnuU/NS6
         TYVkQ9yAme5Jp4qflWuebnIfq9FYgpYkXWz4NlDqvK0bfKouPbbqTaJ0w352funqt2Ur
         0gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684977811; x=1687569811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImO6OtSkFfnvqFi/Tdj42NbWs/io79Pf0LI695zdQVY=;
        b=izGgZPiHQxctUsSkO2Jdq9DBE5dYKAHdZwmPHWkAGK1VCEHAD8Vvcn5G7m5Mdk0+5C
         Nqq208rPHgU5HgbjHBVdvJ/EPk4dxkC5EI+7uasahSijHArPwncZLGw6fhazPFZlQBCj
         DGZ+y02ISuIFsA2GLIXj3L0v45ofm5YmqgRjy58QJiDIVFZ9C1whl7eQMWCv2waD/8X2
         4oUVoSaHAN7HSh4KnuVG4zywxg6pydHit+/BUmOmM5bJBBIuK4/lkpE5XFc2blj9Rsdc
         eb4apxdmEF5LRBhFcdiZ3yFQEJrA795om15AN3UlNB94+1IvnnBKhZ1cVv9jfKhA6gwF
         fu5Q==
X-Gm-Message-State: AC+VfDw3uJTpkBDivzXOl4YKUb341SqC0CmbJB6BVSmSnfAZYihK5sHY
        Y10v7hShp6a2PQOuhhbstJ/TkInlYtV9DDskpF4=
X-Google-Smtp-Source: ACHHUZ4R1YP38WQ+w5tcAppMXtmV8ADJBETAAAQK+pQaNcR7Z1INqwa5atnT5D3ecG2LzRAH0mK4g7Qq2e/3e42QVbE=
X-Received: by 2002:ac2:4ad1:0:b0:4f3:8c0d:41c4 with SMTP id
 m17-20020ac24ad1000000b004f38c0d41c4mr6139693lfp.30.1684977811090; Wed, 24
 May 2023 18:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <1684919574-28368-1-git-send-email-zhaoyang.huang@unisoc.com> <CAJuCfpHLdmtzAvhk94vLmkDNBAO8xJMFEdnXy8j=0KGovmmC_w@mail.gmail.com>
In-Reply-To: <CAJuCfpHLdmtzAvhk94vLmkDNBAO8xJMFEdnXy8j=0KGovmmC_w@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 25 May 2023 09:23:07 +0800
Message-ID: <CAGWkznGs=voCMYWsSRMJ7ZKxz0NcB6P9ynOK8AizHBHZG2MoDA@mail.gmail.com>
Subject: Re: [PATCH] mm: deduct the number of pages reclaimed by madvise from workingset
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 4:41=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, May 24, 2023 at 2:13=E2=80=AFAM zhaoyang.huang
> <zhaoyang.huang@unisoc.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > The pages reclaimed by madvise_pageout are made of inactive and dropped=
 from LRU
> > forcefully, which lead to the coming up refault pages possess a large r=
efault
> > distance than it should be. These could affect the accuracy of thrashin=
g when
> > madvise_pageout is used as a common way of memory reclaiming as ANDROID=
 does now.
>
> Doesn't workingset_eviction() in the following call chain already
> handle nonresident page aging?:
>
> reclaim_pages
>   reclaim_folio_list
>     shrink_folio_list
>       __remove_mapping
>         workingset_eviction
>           workingset_age_nonresident
Yes. What I suggest is to minor this pages from non-resident as they
are dropped forcefully
>
>
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  include/linux/swap.h | 2 +-
> >  mm/madvise.c         | 4 ++--
> >  mm/vmscan.c          | 8 +++++++-
> >  3 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 2787b84..0312142 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -428,7 +428,7 @@ extern unsigned long mem_cgroup_shrink_node(struct =
mem_cgroup *mem,
> >  extern int vm_swappiness;
> >  long remove_mapping(struct address_space *mapping, struct folio *folio=
);
> >
> > -extern unsigned long reclaim_pages(struct list_head *page_list);
> > +extern unsigned long reclaim_pages(struct mm_struct *mm, struct list_h=
ead *page_list);
> >  #ifdef CONFIG_NUMA
> >  extern int node_reclaim_mode;
> >  extern int sysctl_min_unmapped_ratio;
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index b6ea204..61c8d7b 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -420,7 +420,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
> >  huge_unlock:
> >                 spin_unlock(ptl);
> >                 if (pageout)
> > -                       reclaim_pages(&page_list);
> > +                       reclaim_pages(mm, &page_list);
> >                 return 0;
> >         }
> >
> > @@ -516,7 +516,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
> >         arch_leave_lazy_mmu_mode();
> >         pte_unmap_unlock(orig_pte, ptl);
> >         if (pageout)
> > -               reclaim_pages(&page_list);
> > +               reclaim_pages(mm, &page_list);
> >         cond_resched();
> >
> >         return 0;
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 20facec..048c10b 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2741,12 +2741,14 @@ static unsigned int reclaim_folio_list(struct l=
ist_head *folio_list,
> >         return nr_reclaimed;
> >  }
> >
> > -unsigned long reclaim_pages(struct list_head *folio_list)
> > +unsigned long reclaim_pages(struct mm_struct *mm, struct list_head *fo=
lio_list)
>
> You would also need to change Damon usage of reclaim_pages() here:
> https://elixir.bootlin.com/linux/v6.4-rc1/source/mm/damon/paddr.c#L253
ok, thanks for reminding
>
> >  {
> >         int nid;
> >         unsigned int nr_reclaimed =3D 0;
> >         LIST_HEAD(node_folio_list);
> >         unsigned int noreclaim_flag;
> > +       struct lruvec *lruvec;
> > +       struct mem_cgroup *memcg =3D get_mem_cgroup_from_mm(mm);
> >
> >         if (list_empty(folio_list))
> >                 return nr_reclaimed;
> > @@ -2764,10 +2766,14 @@ unsigned long reclaim_pages(struct list_head *f=
olio_list)
> >                 }
> >
> >                 nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, =
NODE_DATA(nid));
> > +               lruvec =3D &memcg->nodeinfo[nid]->lruvec;
> > +               workingset_age_nonresident(lruvec, -nr_reclaimed);
> >                 nid =3D folio_nid(lru_to_folio(folio_list));
> >         } while (!list_empty(folio_list));
> >
> >         nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, NODE_DAT=
A(nid));
> > +       lruvec =3D &memcg->nodeinfo[nid]->lruvec;
> > +       workingset_age_nonresident(lruvec, -nr_reclaimed);
> >
> >         memalloc_noreclaim_restore(noreclaim_flag);
> >
> > --
> > 1.9.1
> >
