Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A16A8581
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjCBPpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:45:30 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764EB3D0B3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:45:28 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id by13so5276695vsb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677771927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjXGHa4EroNXT3gLEIRkeIrKvt5m5lkc5NjvxIOYA7M=;
        b=RSFFWFEHk4qVxyHZ8nxZQVcPHMdItX9tW/O1x9DJFUNXT3FUeU9YzZSOH0whRAgemY
         E9DG0dQXUD0RY5cHdk7RUHd0jseALf2MNqw6Ykk0vhW5i06Seqj/YSHsgQlpPA1xC+Xn
         R5xjsm6OoxsjNHg0aZ4Cg9r2IoiUEpSoSoxxpSX2IlM4D5GqClzl6kwr7NrtFde/mF0s
         /TKf87PhgH+A42EOClfbPCWNUqT0AAes95bMpsQlM6uWLmNxI7wSnZFKXkZchFfo7miA
         L1tNQQa9iZ6mMudGkN/+pVl1SRx5PfK0v3cZe25qmxwtpX+2MWL4EuyUuZMcVXyhUa87
         tVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677771927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjXGHa4EroNXT3gLEIRkeIrKvt5m5lkc5NjvxIOYA7M=;
        b=LZy0gGFj+9DiISvbln4IL883jEPlJ6Jzei6PI6baluPkahkaWB8zwRtZ/Pfu8C16Tp
         Hn8F3AqZ3xj1+oJE6YyT8zIGpVzIaEf013LPKyS+zcvyNAPD8aWLurV+VzlTd+6ReC0l
         YsePY6/nI4P/+i7FFitPoyrwr9+wzQPsBwsIuijJOnvjsKiGLlOaQJ3/pyygpjptVNIS
         NBXf9q4lPLCz/Hao6qdxp8YnJWFMF1PE2V1smoG/FPFXCBfODEca64cGKhrYzW5tCQp+
         uV3YafjEq+GNXECwphAPXCs+OoXmMWV05/pfTplLmnwesnpbSzwyNnkbhzmDM1DQwe/T
         y+Ww==
X-Gm-Message-State: AO0yUKVRAnG6RttxMnwENNB+YhPIRIWacUkhx2Iq/iyuQxoU/Hed+T5H
        adtuMG7g+LIWCrypnF2/lRU6mPvOcIW7uVMD2jDXGw==
X-Google-Smtp-Source: AK7set+QZM7DvFhgUYUzYA9B/U5ASo6vV2oB5xM5bFvi4qz/G5ZFyV/yENXSnm8tS1b+l+4Zj/VqimM6gvV+Jw41fYE=
X-Received: by 2002:a67:fd50:0:b0:415:48dd:e0b9 with SMTP id
 g16-20020a67fd50000000b0041548dde0b9mr6706409vsr.3.1677771927420; Thu, 02 Mar
 2023 07:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-6-jthoughton@google.com> <CACw3F538H+bYcvSY-qG4-gmrgGPRBgTScDzrX9suLyp_q+v_bQ@mail.gmail.com>
In-Reply-To: <CACw3F538H+bYcvSY-qG4-gmrgGPRBgTScDzrX9suLyp_q+v_bQ@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 2 Mar 2023 07:44:51 -0800
Message-ID: <CADrL8HVMp9kA=c904pUCqa-J_1vY4UPtsL9up+ZVVDp4TZbG2w@mail.gmail.com>
Subject: Re: [PATCH v2 05/46] rmap: hugetlb: switch from page_dup_file_rmap to page_add_file_rmap
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 1, 2023 at 5:06=E2=80=AFPM Jiaqi Yan <jiaqiyan@google.com> wrot=
e:
>
> On Fri, Feb 17, 2023 at 4:28 PM James Houghton <jthoughton@google.com> wr=
ote:
> >
> > This only applies to file-backed HugeTLB, and it should be a no-op unti=
l
> > high-granularity mapping is possible. Also update page_remove_rmap to
> > support the eventual case where !compound && folio_test_hugetlb().
> >
> > HugeTLB doesn't use LRU or mlock, so we avoid those bits. This also
> > means we don't need to use subpage_mapcount; if we did, it would
> > overflow with only a few mappings.

This is wrong; I guess I misunderstood the code when I wrote this
commit. subpages_mapcount (now called _nr_pages_mapped) won't overflow
(unless HugeTLB pages could be greater than 16G). It is indeed a bug
not to update _nr_pages_mapped the same way THPs do.

>
> >
> > There is still one caller of page_dup_file_rmap left: copy_present_pte,
> > and it is always called with compound=3Dfalse in this case.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 08004371cfed..6c008c9de80e 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5077,7 +5077,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst=
, struct mm_struct *src,
> >                          * sleep during the process.
> >                          */
> >                         if (!PageAnon(ptepage)) {
> > -                               page_dup_file_rmap(ptepage, true);
> > +                               page_add_file_rmap(ptepage, src_vma, tr=
ue);
> >                         } else if (page_try_dup_anon_rmap(ptepage, true=
,
> >                                                           src_vma)) {
> >                                 pte_t src_pte_old =3D entry;
> > @@ -5910,7 +5910,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struc=
t *mm,
> >         if (anon_rmap)
> >                 hugepage_add_new_anon_rmap(folio, vma, haddr);
> >         else
> > -               page_dup_file_rmap(&folio->page, true);
> > +               page_add_file_rmap(&folio->page, vma, true);
> >         new_pte =3D make_huge_pte(vma, &folio->page, ((vma->vm_flags & =
VM_WRITE)
> >                                 && (vma->vm_flags & VM_SHARED)));
> >         /*
> > @@ -6301,7 +6301,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *ds=
t_mm,
> >                 goto out_release_unlock;
> >
> >         if (folio_in_pagecache)
> > -               page_dup_file_rmap(&folio->page, true);
> > +               page_add_file_rmap(&folio->page, dst_vma, true);
> >         else
> >                 hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index d3964c414010..b0f87f19b536 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -254,7 +254,7 @@ static bool remove_migration_pte(struct folio *foli=
o,
> >                                 hugepage_add_anon_rmap(new, vma, pvmw.a=
ddress,
> >                                                        rmap_flags);
> >                         else
> > -                               page_dup_file_rmap(new, true);
> > +                               page_add_file_rmap(new, vma, true);
> >                         set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.=
pte, pte);
> >                 } else
> >  #endif
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 15ae24585fc4..c010d0af3a82 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
>
> Given you are making hugetlb's ref/mapcount mechanism to be consistent
> with THP, I think the special folio_test_hugetlb checks you added in
> this commit will break page_mapped() and folio_mapped() if page/folio
> is HGMed. With these checks, folio->_nr_pages_mapped are not properly
> increased/decreased.

Thank you, Jiaqi! I didn't realize I broke
folio_mapped()/page_mapped(). The end result is that page_mapped() may
report that an HGMed page isn't mapped when it is. Not good!

>
> > @@ -1318,21 +1318,21 @@ void page_add_file_rmap(struct page *page, stru=
ct vm_area_struct *vma,
> >         int nr =3D 0, nr_pmdmapped =3D 0;
> >         bool first;
> >
> > -       VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
> > +       VM_BUG_ON_PAGE(compound && !PageTransHuge(page)
> > +                               && !folio_test_hugetlb(folio), page);
> >
> >         /* Is page being mapped by PTE? Is this its first map to be add=
ed? */
> >         if (likely(!compound)) {
> >                 first =3D atomic_inc_and_test(&page->_mapcount);
> >                 nr =3D first;
> > -               if (first && folio_test_large(folio)) {
> > +               if (first && folio_test_large(folio)
> > +                         && !folio_test_hugetlb(folio)) {
>
> So we should still increment _nr_pages_mapped for hugetlb case here,
> and decrement in the corresponding place in page_remove_rmap.
>
> >                         nr =3D atomic_inc_return_relaxed(mapped);
> >                         nr =3D (nr < COMPOUND_MAPPED);
> >                 }
> > -       } else if (folio_test_pmd_mappable(folio)) {
> > -               /* That test is redundant: it's for safety or to optimi=
ze out */
> > -
> > +       } else {
> >                 first =3D atomic_inc_and_test(&folio->_entire_mapcount)=
;
> > -               if (first) {
> > +               if (first && !folio_test_hugetlb(folio)) {
>
> Same here: we should still increase _nr_pages_mapped by
> COMPOUND_MAPPED and decrease by COMPOUND_MAPPED in the corresponding
> place in page_remove_rmap.
>
> >                         nr =3D atomic_add_return_relaxed(COMPOUND_MAPPE=
D, mapped);
> >                         if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPP=
ED)) {
> >                                 nr_pmdmapped =3D folio_nr_pages(folio);
> > @@ -1347,6 +1347,9 @@ void page_add_file_rmap(struct page *page, struct=
 vm_area_struct *vma,
> >                 }
> >         }
> >
> > +       if (folio_test_hugetlb(folio))
> > +               return;
> > +
> >         if (nr_pmdmapped)
> >                 __lruvec_stat_mod_folio(folio, folio_test_swapbacked(fo=
lio) ?
> >                         NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdm=
apped);
> > @@ -1376,8 +1379,7 @@ void page_remove_rmap(struct page *page, struct v=
m_area_struct *vma,
> >         VM_BUG_ON_PAGE(compound && !PageHead(page), page);
> >
> >         /* Hugetlb pages are not counted in NR_*MAPPED */
> > -       if (unlikely(folio_test_hugetlb(folio))) {
> > -               /* hugetlb pages are always mapped with pmds */
> > +       if (unlikely(folio_test_hugetlb(folio)) && compound) {
> >                 atomic_dec(&folio->_entire_mapcount);
> >                 return;
> >         }
>
> This entire if-block should be removed after you remove the
> !folio_test_hugetlb checks in page_add_file_rmap.

This is the not-so-obvious change that is needed. Thank you!

>
> > @@ -1386,15 +1388,14 @@ void page_remove_rmap(struct page *page, struct=
 vm_area_struct *vma,
> >         if (likely(!compound)) {
> >                 last =3D atomic_add_negative(-1, &page->_mapcount);
> >                 nr =3D last;
> > -               if (last && folio_test_large(folio)) {
> > +               if (last && folio_test_large(folio)
> > +                        && !folio_test_hugetlb(folio)) {
>
> ditto.
>
> >                         nr =3D atomic_dec_return_relaxed(mapped);
> >                         nr =3D (nr < COMPOUND_MAPPED);
> >                 }
> > -       } else if (folio_test_pmd_mappable(folio)) {
> > -               /* That test is redundant: it's for safety or to optimi=
ze out */
> > -
> > +       } else {
> >                 last =3D atomic_add_negative(-1, &folio->_entire_mapcou=
nt);
> > -               if (last) {
> > +               if (last && !folio_test_hugetlb(folio)) {
>
> ditto.

I agree with all of your suggestions. Testing with the hugetlb-hgm
selftest, nothing seems to break. :)

Given that this is at least the third or fourth major bug in this
version of the series, I'll go ahead and send a v3 sooner rather than
later.

>
> >                         nr =3D atomic_sub_return_relaxed(COMPOUND_MAPPE=
D, mapped);
> >                         if (likely(nr < COMPOUND_MAPPED)) {
> >                                 nr_pmdmapped =3D folio_nr_pages(folio);
> > @@ -1409,6 +1410,9 @@ void page_remove_rmap(struct page *page, struct v=
m_area_struct *vma,
> >                 }
> >         }
> >
> > +       if (folio_test_hugetlb(folio))
> > +               return;
> > +
> >         if (nr_pmdmapped) {
> >                 if (folio_test_anon(folio))
> >                         idx =3D NR_ANON_THPS;
> > --
> > 2.39.2.637.g21b0678d19-goog
> >
