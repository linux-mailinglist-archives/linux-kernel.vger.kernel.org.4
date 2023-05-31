Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB788718E55
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjEaWTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEaWTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:19:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C57A9F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:19:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ac65ab7432so57705ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685571561; x=1688163561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRWZmpqRL5XiZgWOPMSUq0KvjrtvR8XR5rQAecF0oZ4=;
        b=iFly5zo2sy/lAtQ3HhlOMridVqfu6qfPcrLzIVcmWu/D50gTe+1qsog0OpXKba34AM
         7esxxoXOZgU2b+4rTYCP+2F/ejY/GbJXfa8A0sXnuFj7+DxPAktAXb+wGoZtLoXg5tim
         8FVVTy8jjyDam8f/fgX6o6yBT5D2Ux5xVafJN8A3GMDq9V/Or1MzonxwP3QsfC+snDRI
         SG3rH2NlTWHLM+fLjB0A3DIE2aVMGT4l8yR+KOkWkwY4wfKWwzHbJ5Lt9eMn+eI2VQ5P
         tEC9elQXXr9HqOHN0kX0stjJ0Pj3TwUHQMpx82B74M3E43CdU87AkDrhxLhNvlnutHZ1
         tGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685571561; x=1688163561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRWZmpqRL5XiZgWOPMSUq0KvjrtvR8XR5rQAecF0oZ4=;
        b=LBGvmSH5DpcIeoy3pcHkw/SgRiOa+IGl0aHttg/Rsohl4N+zWQkVu3geyjYWYgjS7E
         lXYtJNDRGhXTJmNRsE18D3J/X+bBTMypcrNtx4n3u3rF68TjJTSpRpKENAgrsLLlrSvW
         lHPwDMV82PPT2ys54P1JV3ZB4pTz4XV4AxoWBx+fGX1XBJz1CfMqwN7aGvNkmW/+pVC+
         fLNmQFO5jwsjOQW+KCQpALMysdSmoAePXl7Xx4TSEYiNHuHo71DfhUTPNCFRLla5u78o
         gh2OsbSSvNUhu7bhXCqhykXEo9zJD6i5kr3tuqiMFX4JnEc7X4K/Pc9F+hV9K8LGxlB5
         8NVQ==
X-Gm-Message-State: AC+VfDw34zl8csbL0V30qUNMTv39SG/bP1sxdS06PoJ3E9JkRTK0ifmY
        q+W9YypKq9FeIKHC3ZI19v/conRk5DndeD0W4yG0WQ==
X-Google-Smtp-Source: ACHHUZ7bko0KTAnjbjNbOVblk4XWzcVkxerfCOFFo5yNT5TaXIaEurY3iGbtCSYhOAX0x9zwiXMTvT/Osanj9HTXgSc=
X-Received: by 2002:a17:902:e54e:b0:1b0:4a2:5920 with SMTP id
 n14-20020a170902e54e00b001b004a25920mr13931plf.19.1685571560674; Wed, 31 May
 2023 15:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <2e9996fa-d238-e7c-1194-834a2bd1f60@google.com> <CAG48ez0aF1Rf1apSjn9YcnfyFQ4YqSd4GqB6f2wfhF7jMdi5Hg@mail.gmail.com>
 <ZHe0A079X9B8jWlH@x1n>
In-Reply-To: <ZHe0A079X9B8jWlH@x1n>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Jun 2023 00:18:43 +0200
Message-ID: <CAG48ez1UNFfpTUph6ZMuN61CoTGne05NLAweL_=ijRfqj5evMg@mail.gmail.com>
Subject: Re: [PATCH 09/12] mm/khugepaged: retract_page_tables() without mmap
 or vma lock
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:54=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
> On Wed, May 31, 2023 at 05:34:58PM +0200, Jann Horn wrote:
> > On Mon, May 29, 2023 at 8:25=E2=80=AFAM Hugh Dickins <hughd@google.com>=
 wrote:
> > > -static int retract_page_tables(struct address_space *mapping, pgoff_=
t pgoff,
> > > -                              struct mm_struct *target_mm,
> > > -                              unsigned long target_addr, struct page=
 *hpage,
> > > -                              struct collapse_control *cc)
> > > +static void retract_page_tables(struct address_space *mapping, pgoff=
_t pgoff)
> > >  {
> > >         struct vm_area_struct *vma;
> > > -       int target_result =3D SCAN_FAIL;
> > >
> > > -       i_mmap_lock_write(mapping);
> > > +       i_mmap_lock_read(mapping);
> > >         vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff=
) {
> > > -               int result =3D SCAN_FAIL;
> > > -               struct mm_struct *mm =3D NULL;
> > > -               unsigned long addr =3D 0;
> > > -               pmd_t *pmd;
> > > -               bool is_target =3D false;
> > > +               struct mm_struct *mm;
> > > +               unsigned long addr;
> > > +               pmd_t *pmd, pgt_pmd;
> > > +               spinlock_t *pml;
> > > +               spinlock_t *ptl;
> > >
> > >                 /*
> > >                  * Check vma->anon_vma to exclude MAP_PRIVATE mapping=
s that
> > > -                * got written to. These VMAs are likely not worth in=
vesting
> > > -                * mmap_write_lock(mm) as PMD-mapping is likely to be=
 split
> > > -                * later.
> > > +                * got written to. These VMAs are likely not worth re=
moving
> > > +                * page tables from, as PMD-mapping is likely to be s=
plit later.
> > >                  *
> > > -                * Note that vma->anon_vma check is racy: it can be s=
et up after
> > > -                * the check but before we took mmap_lock by the faul=
t path.
> > > -                * But page lock would prevent establishing any new p=
tes of the
> > > -                * page, so we are safe.
> > > -                *
> > > -                * An alternative would be drop the check, but check =
that page
> > > -                * table is clear before calling pmdp_collapse_flush(=
) under
> > > -                * ptl. It has higher chance to recover THP for the V=
MA, but
> > > -                * has higher cost too. It would also probably requir=
e locking
> > > -                * the anon_vma.
> > > +                * Note that vma->anon_vma check is racy: it can be s=
et after
> > > +                * the check, but page locks (with XA_RETRY_ENTRYs in=
 holes)
> > > +                * prevented establishing new ptes of the page. So we=
 are safe
> > > +                * to remove page table below, without even checking =
it's empty.
> >
> > This "we are safe to remove page table below, without even checking
> > it's empty" assumes that the only way to create new anonymous PTEs is
> > to use existing file PTEs, right? What about private shmem VMAs that
> > are registered with userfaultfd as VM_UFFD_MISSING? I think for those,
> > the UFFDIO_COPY ioctl lets you directly insert anonymous PTEs without
> > looking at the mapping and its pages (except for checking that the
> > insertion point is before end-of-file), protected only by mmap_lock
> > (shared) and pte_offset_map_lock().
>
> Hmm, yes.  We probably need to keep that though, and 5b51072e97 explained
> the reason (to still respect file permissions).
>
> Maybe the anon_vma check can also be moved into the pgtable lock section,
> with some comments explaining (but it's getting a bit ugly..)?

Or check that all entries are pte_none() or something like that inside
the pgtable-locked section?

[...]
> > The old code called collapse_and_free_pmd(), which involves MMU
> > notifier invocation...
[...]
> > ... while the new code only does pmdp_collapse_flush(), which clears
> > the pmd entry and does a TLB flush, but AFAICS doesn't use MMU
> > notifiers. My understanding is that that's problematic - maybe (?) it
> > is sort of okay with regards to classic MMU notifier users like KVM,
> > but it's probably wrong for IOMMUv2 users, where an IOMMU directly
> > consumes the normal page tables?
>
> The iommuv2 wasn't "consuming" the pgtables?

My wording was confusing, I meant that as "the iommuv2 hardware
directly uses/walks the page tables".

> IIUC it relies on that to
> make sure no secondary (and illegal) tlb exists in the iommu tlbs.
>
> For this case if the pgtable _must_ be empty when reaching here (we'd
> better make sure of it..), maybe we're good?  Because we should have just
> invalidated once when unmap all the pages in the thp range, so no existin=
g
> tlb should generate anyway for either cpu or iommu hardwares.

My headcanon is that there are approximately three reasons why we
normally have to do iommuv2 invalidations and I think one or two of
them might still apply here, though admittedly I haven't actually dug
up documentation on how this stuff actually works for IOMMUv2, so
maybe one of y'all can tell me that my concerns here are unfounded:

1. We have to flush normal TLB entries. This is probably not necessary
if the page table contains no entries.
2. We might have to flush "paging-structure caches" / "intermediate
table walk caches", if the IOMMU caches the physical addresses of page
tables to skip some levels of page table walk. IDK if IOMMUs do that,
but normal MMUs definitely do it, so I wouldn't be surprised if the
IOMMUs did it too (or reserved the right to do it in a future hardware
generation or whatever).
3. We have to *serialize* with page table walks performed by the
IOMMU. We're doing an RCU barrier to synchronize against page table
walks from the MMU, but without an appropriate mmu_notifier call, we
have nothing to ensure that we aren't yanking a page table out from
under an IOMMU page table walker while it's in the middle of its walk.
Sure, this isn't very likely in practice, the IOMMU page table walker
is probably pretty fast, but still we need some kind of explicit
synchronization to make this robust, I think.

> However OTOH, maybe it'll also be safer to just have the mmu notifiers li=
ke
> before (e.g., no idea whether anything can cache invalidate tlb
> translations from the empty pgtable)? As that doesn't seems to beat the
> purpose of the patchset as notifiers shouldn't fail.
>
> >
> > (FWIW, last I looked, there also seemed to be some other issues with
> > MMU notifier usage wrt IOMMUv2, see the thread
> > <https://lore.kernel.org/linux-mm/Yzbaf9HW1%2FreKqR8@nvidia.com/>.)
