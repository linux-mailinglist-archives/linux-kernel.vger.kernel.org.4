Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2151C710048
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjEXV7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjEXV7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:59:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11862119
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:59:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-255bd112757so246666a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684965569; x=1687557569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekGnm+ojmbb/fz8wYRstsminHdPrXuGm/8fgWUyPuhw=;
        b=pykqwhY+ha3DQ4RES66QRd0SXwR8hR898iPiXoVOJhqVUf/p9Bdw+jbpkCHZFcq5FU
         W4WjZ/mC8FIaEtcG2p+DytxElrp64iWpV+VMJiGhUesCQ3gx7MaH3Kw/7KU0oM86tXmd
         SJu9J1BDXSYGj2qb8cS9rcWiQS5fQrfusIWyRvY9NCf2wnxePW7ja88MokGyZchF+xhr
         8+GUpK0EGnrGBI62a1BxMxS4USuIoNLlSvtKhbLhSSaUarvsyUQAOiCqcjKGyR2gR7ol
         YLZleSLztF3ULdZ/zXV7jRoTzMkhpjHNv5ieE3SNSx87ByHHhh0NaTuWWQmc2AOYJYi1
         X7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684965569; x=1687557569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekGnm+ojmbb/fz8wYRstsminHdPrXuGm/8fgWUyPuhw=;
        b=gBSMHHMDEKdmhHbDeC+SUrPEXK4qs/K2y5D2qP4wJU2M52jmdYzdJgDteEPYkEKSa8
         Jr7DR5RL6MQaX/DEyScMA48jdDyvSmYXaJE2ceSqgVK0M+lAjp9Z2gA8hUtVyMykWT+9
         zt1zdB1miYwEA10aI2R2PAA61RE0EIpD1mFZR4JOPTvfC2y+43mYWaoasrGu12710CeR
         lq/mFAtsCDMraB/GmKMYPP+Du4CiVEYLnH8ZUTyHMs8mjC7B8Hmt0sV4GZXibXE9odJP
         qbxgbfv/1M/v2lPXdsEj23u4Umk845SiR9SYtaHpNmxLMjphM72FP1qR9OZ7EHRm83fm
         gk9g==
X-Gm-Message-State: AC+VfDy7XAvJmX54tK29557BBm+D9Vgu8QkJsRyrVqf0XJkZk1B5CiLl
        bOjDMhidftiuTdWlHug/R+I8m5sJuZnHQfZIDmE=
X-Google-Smtp-Source: ACHHUZ66uapjDit/ygYxj7YqjsQL7g46/nJZtMfuAYZqTARwK1q/17VWytNuBvnYXegTkqOxlWu9p3y8qQ744nx8rjM=
X-Received: by 2002:a17:90b:1e06:b0:253:6b3a:ab1e with SMTP id
 pg6-20020a17090b1e0600b002536b3aab1emr738265pjb.6.1684965569410; Wed, 24 May
 2023 14:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <aef43be2-f877-b0f8-b41c-37f847d3a7b4@google.com> <CAHbLzkrf-Ft6geL0XKwGCY+Btn3cW=FMRjujQ48VJEnCfVki9g@mail.gmail.com>
 <68dddbbb-bc3c-367d-798a-cbe2a69664@google.com>
In-Reply-To: <68dddbbb-bc3c-367d-798a-cbe2a69664@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 24 May 2023 14:59:17 -0700
Message-ID: <CAHbLzkrajUS78b8bM-E2ECmMQmZpOp_J5NYb_UELv3RSyqD9Dg@mail.gmail.com>
Subject: Re: [PATCH 27/31] mm/khugepaged: allow pte_offset_map[_lock]() to fail
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 9:44=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Mon, 22 May 2023, Yang Shi wrote:
> > On Sun, May 21, 2023 at 10:24=E2=80=AFPM Hugh Dickins <hughd@google.com=
> wrote:
> > >
> > > __collapse_huge_page_swapin(): don't drop the map after every pte, it
> > > only has to be dropped by do_swap_page(); give up if pte_offset_map()
> > > fails; trace_mm_collapse_huge_page_swapin() at the end, with result;
> > > fix comment on returned result; fix vmf.pgoff, though it's not used.
> > >
> > > collapse_huge_page(): use pte_offset_map_lock() on the _pmd returned
> > > from clearing; allow failure, but it should be impossible there.
> > > hpage_collapse_scan_pmd() and collapse_pte_mapped_thp() allow for
> > > pte_offset_map_lock() failure.
> > >
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> >
> > Reviewed-by: Yang Shi <shy828301@gmail.com>
>
> Thanks.
>
> >
> > A nit below:
> >
> > > ---
> > >  mm/khugepaged.c | 72 +++++++++++++++++++++++++++++++++--------------=
--
> > >  1 file changed, 49 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 732f9ac393fc..49cfa7cdfe93 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> ...
> > > @@ -1029,24 +1040,29 @@ static int __collapse_huge_page_swapin(struct=
 mm_struct *mm,
> > >                  * resulting in later failure.
> > >                  */
> > >                 if (ret & VM_FAULT_RETRY) {
> > > -                       trace_mm_collapse_huge_page_swapin(mm, swappe=
d_in, referenced, 0);
> > >                         /* Likely, but not guaranteed, that page lock=
 failed */
> > > -                       return SCAN_PAGE_LOCK;
> > > +                       result =3D SCAN_PAGE_LOCK;
> >
> > With per-VMA lock, this may not be true anymore, at least not true
> > until per-VMA lock supports swap fault. It may be better to have a
> > more general failure code, for example, SCAN_FAIL. But anyway you
> > don't have to change it in your patch, I can send a follow-up patch
> > once this series is landed on mm-unstable.
>
> Interesting point (I've not tried to wrap my head around what differences
> per-VMA locking would make to old likelihoods here), and thank you for
> deferring a change on it - appreciated.
>
> Something to beware of, if you do choose to change it: mostly those
> SCAN codes (I'm not a fan of them!) are only for a tracepoint somewhere,
> but madvise_collapse() and madvise_collapse_errno() take some of them
> more seriously than others - I think SCAN_PAGE_LOCK ends up as an
> EAGAIN (rightly), but SCAN_FAIL as an EINVAL (depends).
>
> But maybe there are layers in between which do not propagate the result
> code, I didn't check.  All in all, not something I'd spend time on myself=
.

Thanks, Hugh. A second look shows do_swap_page() should not return
VM_FAULT_RETRY due to per-VMA lock since it depends on
FAULT_FLAG_VMA_LOCK flag, but it is actually not set in khugepaged
path. Khugepaged just has FAULT_FLAG_ALLOW_RETRY flag set. So we don't
have to change anything.

>
> Hugh
