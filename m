Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B309270D185
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjEWCpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjEWCpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:45:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AABFE9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:45:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2537909d28cso3057861a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684809908; x=1687401908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHxjOHFezdgtF4NBYBIMb6jc3c6vhP3piT2YLvnyXjM=;
        b=RrzmUBLXd13viYNCNSEK8TDRcqf5eaBA4G+zJtgpMI+fsu+1pOaRNG+/oKmMWQnlZP
         qlFB4/7tYWmrgn/z8IPz4PEqNB7ipFpdi41qBHSqH4CYbs2cBkczRrF2q8/mSitCMOlf
         PYGa6rAYQtV1dfSAJPvrMK416VSV+45kWPeoEzIN/v3kFmhpnrdKNCjZJ95oriDYLC9H
         RJYh57YBFi2kBDRzdRiLEVf8TkkO0FrxMY3y/JB/FSe5T1kDKhaVsgTV/kIbHDL6FEic
         pigp9+ZFKMCBRp67VuAfYnOXx7K6dhb0l+Fn3ob+t4z8JYcdtF2GFVlmZ0ZlkBuigYPQ
         AFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684809908; x=1687401908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHxjOHFezdgtF4NBYBIMb6jc3c6vhP3piT2YLvnyXjM=;
        b=EA5rKr+/OufpKmIKZIg2yO/fqKaaQGqWkT9uOT8hzWJZBFUQebBt4vlmmxat/T0qQp
         Mue+eWnli1uWTgofY0LaHJtwV8siQYtQ1whcyt8uPuAeSEYVaZQJOG1h3TRIvuQ9SPws
         Ba5xwBkcJvy4gVsNOMI9+b8UaPwfcbSmiR6bvv4lPJsLXU/LdLPTEed9KndlCWtXRRD6
         CDXzNPX/Go9KGHpimeR+PWH2z1su1fa18pbW/1ldWeqRUqgdjkBw27GzdBTTsmN1jPND
         dQamL88A6BUaB99M6OJmfesKQ1lPExG04IQ5ArinlC2UmXoKUnAy2sBIFfmRSWSo1+kb
         e1ZA==
X-Gm-Message-State: AC+VfDyvWT7B5d9HUGk9CJGVGAAMOKtMjenMhdRqO/brnOCIc55EyQAu
        u1bCoFrIUyQvJwHC5HEyH38Jyj+/UPHE0NB1R9I=
X-Google-Smtp-Source: ACHHUZ4chL0XGofs+/tcpaAexxFoaQEXDZdeFGq6AqniMDKnp1aBqQdRf7eyg8sAi0RLHM+ZfqGrISR4y6ZJAE/WBZg=
X-Received: by 2002:a17:90a:6309:b0:24d:f1a5:e279 with SMTP id
 e9-20020a17090a630900b0024df1a5e279mr11549623pjj.12.1684809908632; Mon, 22
 May 2023 19:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <b9da41bb-b7b6-2fc6-caac-b01b6719334@google.com> <CAHbLzkpdWqLM1+Jb+rzVjxGyRBUtJFU_2O7=7PtE0dNgsvXSrQ@mail.gmail.com>
In-Reply-To: <CAHbLzkpdWqLM1+Jb+rzVjxGyRBUtJFU_2O7=7PtE0dNgsvXSrQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 22 May 2023 19:44:57 -0700
Message-ID: <CAHbLzkpOs4fz5NuAzQDdMRQYDLn6HzR1CHQoU5OYZyPW1GQmHg@mail.gmail.com>
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

On Mon, May 22, 2023 at 7:26=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Sun, May 21, 2023 at 10:22=E2=80=AFPM Hugh Dickins <hughd@google.com> =
wrote:
> >
> > There is now no reason for follow_pmd_mask()'s FOLL_SPLIT_PMD block to
> > distinguish huge_zero_page from a normal THP: follow_page_pte() handles
> > any instability, and here it's a good idea to replace any pmd_none(*pmd=
)
> > by a page table a.s.a.p, in the huge_zero_page case as for a normal THP=
.
> > (Hmm, couldn't the normal THP case have hit an unstably refaulted THP
> > before?  But there are only two, exceptional, users of FOLL_SPLIT_PMD.)
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  mm/gup.c | 19 ++++---------------
> >  1 file changed, 4 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index bb67193c5460..4ad50a59897f 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -681,21 +681,10 @@ static struct page *follow_pmd_mask(struct vm_are=
a_struct *vma,
> >                 return follow_page_pte(vma, address, pmd, flags, &ctx->=
pgmap);
> >         }
> >         if (flags & FOLL_SPLIT_PMD) {
> > -               int ret;
> > -               page =3D pmd_page(*pmd);
> > -               if (is_huge_zero_page(page)) {
> > -                       spin_unlock(ptl);
> > -                       ret =3D 0;
> > -                       split_huge_pmd(vma, pmd, address);
> > -                       if (pmd_trans_unstable(pmd))
> > -                               ret =3D -EBUSY;
>
> IIUC the pmd_trans_unstable() check was transferred to the implicit
> pmd_none() in pte_alloc(). But it will return -ENOMEM instead of
> -EBUSY. Won't it break some userspace? Or the pmd_trans_unstable() is
> never true? If so it seems worth mentioning in the commit log about
> this return value change.

Oops, the above comment is not accurate. It will call
follow_page_pte() instead of returning -EBUSY if pmd is none. For
other unstable cases, it will return -ENOMEM instead of -EBUSY.

>
> > -               } else {
> > -                       spin_unlock(ptl);
> > -                       split_huge_pmd(vma, pmd, address);
> > -                       ret =3D pte_alloc(mm, pmd) ? -ENOMEM : 0;
> > -               }
> > -
> > -               return ret ? ERR_PTR(ret) :
> > +               spin_unlock(ptl);
> > +               split_huge_pmd(vma, pmd, address);
> > +               /* If pmd was left empty, stuff a page table in there q=
uickly */
> > +               return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
> >                         follow_page_pte(vma, address, pmd, flags, &ctx-=
>pgmap);
> >         }
> >         page =3D follow_trans_huge_pmd(vma, address, pmd, flags);
> > --
> > 2.35.3
> >
