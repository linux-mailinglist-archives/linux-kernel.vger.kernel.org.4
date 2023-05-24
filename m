Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194AB710117
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbjEXWpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjEXWpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:45:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCFF90
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:45:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2538aa25873so575520a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684968341; x=1687560341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXTRGd3AFmbTMVgsxsKyk8nn2cSOE6ftnwpeJ/zQVss=;
        b=SJYhROViY0GHxSvAd/fD5Q4qORBZ2UkKvDbO12X5afCbMimDkH4eRu6Jmo2s7bPIk/
         7aUPsGifqbXw0/6PP0DKQYEUT/Hpm0EvV355qezt99cCZfhOzNBYKPOJdY7KM/2e6/Sl
         nbySyQDVCQVjazk5nMZR5A6bQbfj6xj4tg2UgJJuEUMYlnhLSXcxmeH2uB//d5Zo7AFG
         KwtHOaNBvo316rcwToPCkZh2FsJg0DWmnmyAl8VhJDmEWSyT553KaAyV7AnBJWdpvt/x
         Z3EBd/yqvQ81AyhJJKMSfoP9pxFhGxw8SpEpSngq/XxweYcnMmIRmrNKIGtwnifFcfCy
         8ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968341; x=1687560341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXTRGd3AFmbTMVgsxsKyk8nn2cSOE6ftnwpeJ/zQVss=;
        b=Se3cevE8vjo8X9XNnuQGnEHBdCDeFQBHbvTVsgGcJwYFD4nlk3fDuqCdajvjA/DUZ7
         /dv3a9IXsHqS3TDTTJl+1CGlEBntDxzj5zchOiU4w+iy99wSiClYmYXhtIWjORPADd5+
         fuwJisJoeMdkEMRhTbOrtitYlufUs4B0YljaRgEXh6w0Bqpj1G/vthiuOVJz1/BehjHT
         +1bRjuIkb7iDMeZRfQA3zMIlvSv6IF8vICL7+AjVk2Zuo1B02vzqY21dOBXEAgdUj/lc
         7JYt3779TsWt/g/oUCZ6tMej1ekd7Q1n2a8I+WXrKDSE9zaETEJOjdWSls+yQFY/RNZ4
         vWRA==
X-Gm-Message-State: AC+VfDzi6Mjnn74yUD/7D+/vKJO33SavMUmpFXcItK88NXrNxBRFmbYL
        R998oG1HENogEiJ+BRp3cIxK3SyGsXRi+xdppkk=
X-Google-Smtp-Source: ACHHUZ4QZ3TN1ogcQZvX3Dp8o3S0Oeg19zkXAJXbyevuVzFHwZKHXdFxSgSItGkSKtCYyE2mSshfyZE80/8tIJhfNk4=
X-Received: by 2002:a17:90b:1912:b0:24d:e4fd:f487 with SMTP id
 mp18-20020a17090b191200b0024de4fdf487mr13992612pjb.14.1684968340899; Wed, 24
 May 2023 15:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <b9da41bb-b7b6-2fc6-caac-b01b6719334@google.com> <CAHbLzkpdWqLM1+Jb+rzVjxGyRBUtJFU_2O7=7PtE0dNgsvXSrQ@mail.gmail.com>
 <CAHbLzkpOs4fz5NuAzQDdMRQYDLn6HzR1CHQoU5OYZyPW1GQmHg@mail.gmail.com> <3d548f45-9ff9-d73a-83e0-bdd312f524@google.com>
In-Reply-To: <3d548f45-9ff9-d73a-83e0-bdd312f524@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 24 May 2023 15:45:28 -0700
Message-ID: <CAHbLzkrkGx-+OVLexWAx0THeOsD1C1DHt2VjgnkYJe-MqeW3Zw@mail.gmail.com>
Subject: Re: [PATCH 25/31] mm/gup: remove FOLL_SPLIT_PMD use of pmd_trans_unstable()
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

On Tue, May 23, 2023 at 9:26=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Mon, 22 May 2023, Yang Shi wrote:
> > On Mon, May 22, 2023 at 7:26=E2=80=AFPM Yang Shi <shy828301@gmail.com> =
wrote:
> > > On Sun, May 21, 2023 at 10:22=E2=80=AFPM Hugh Dickins <hughd@google.c=
om> wrote:
> > > >
> > > > There is now no reason for follow_pmd_mask()'s FOLL_SPLIT_PMD block=
 to
> > > > distinguish huge_zero_page from a normal THP: follow_page_pte() han=
dles
> > > > any instability, and here it's a good idea to replace any pmd_none(=
*pmd)
> > > > by a page table a.s.a.p, in the huge_zero_page case as for a normal=
 THP.
> > > > (Hmm, couldn't the normal THP case have hit an unstably refaulted T=
HP
> > > > before?  But there are only two, exceptional, users of FOLL_SPLIT_P=
MD.)
> > > >
> > > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > > ---
> > > >  mm/gup.c | 19 ++++---------------
> > > >  1 file changed, 4 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > index bb67193c5460..4ad50a59897f 100644
> > > > --- a/mm/gup.c
> > > > +++ b/mm/gup.c
> > > > @@ -681,21 +681,10 @@ static struct page *follow_pmd_mask(struct vm=
_area_struct *vma,
> > > >                 return follow_page_pte(vma, address, pmd, flags, &c=
tx->pgmap);
> > > >         }
> > > >         if (flags & FOLL_SPLIT_PMD) {
> > > > -               int ret;
> > > > -               page =3D pmd_page(*pmd);
> > > > -               if (is_huge_zero_page(page)) {
> > > > -                       spin_unlock(ptl);
> > > > -                       ret =3D 0;
> > > > -                       split_huge_pmd(vma, pmd, address);
> > > > -                       if (pmd_trans_unstable(pmd))
> > > > -                               ret =3D -EBUSY;
> > >
> > > IIUC the pmd_trans_unstable() check was transferred to the implicit
> > > pmd_none() in pte_alloc(). But it will return -ENOMEM instead of
> > > -EBUSY. Won't it break some userspace? Or the pmd_trans_unstable() is
> > > never true? If so it seems worth mentioning in the commit log about
> > > this return value change.
>
> Thanks a lot for looking at these, but I disagree here.
>
> >
> > Oops, the above comment is not accurate. It will call
> > follow_page_pte() instead of returning -EBUSY if pmd is none.
>
> Yes.  Ignoring secondary races, if pmd is none, pte_alloc() will allocate
> an empty page table there, follow_page_pte() find !pte_present and return
> NULL; or if pmd is not none, follow_page_pte() will return no_page_table(=
)
> i.e. NULL.  And page NULL ends up with __get_user_pages() having another
> go round, instead of failing with -EBUSY.
>
> Which I'd say is better handling for such a transient case - remember,
> it's split_huge_pmd() (which should always succeed, but might be raced)
> in use there, not split_huge_page() (which might take years for pins to
> be removed before it can succeed).

It sounds like an improvement.

>
> > For other unstable cases, it will return -ENOMEM instead of -EBUSY.
>
> I don't think so: the possibly-failing __pte_alloc() only gets called
> in the pmd_none() case.

I mean what if pmd is not none for huge zero page. If it is not
pmd_none pte_alloc() just returns 0, then returns -ENOMEM instead of
-EBUSY. Or it is impossible that pmd end up being pmd_huge_trans or
!pmd_present? It should be very unlikely, for example, migration does
skip huge zero page, but I'm not sure whether there is any corner case
that I missed.

>
> Hugh
>
> >
> > >
> > > > -               } else {
> > > > -                       spin_unlock(ptl);
> > > > -                       split_huge_pmd(vma, pmd, address);
> > > > -                       ret =3D pte_alloc(mm, pmd) ? -ENOMEM : 0;
> > > > -               }
> > > > -
> > > > -               return ret ? ERR_PTR(ret) :
> > > > +               spin_unlock(ptl);
> > > > +               split_huge_pmd(vma, pmd, address);
> > > > +               /* If pmd was left empty, stuff a page table in the=
re quickly */
> > > > +               return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
> > > >                         follow_page_pte(vma, address, pmd, flags, &=
ctx->pgmap);
> > > >         }
> > > >         page =3D follow_trans_huge_pmd(vma, address, pmd, flags);
> > > > --
> > > > 2.35.3
