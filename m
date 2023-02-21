Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54AC69E4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjBUQgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjBUQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:36:47 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97006279AB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:36:45 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id g12so6992045vsf.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfMiwamrb5Hsn9MOJ+vir9DkXggh5+lNX55ws8jXDRc=;
        b=FEKXutWwVJH+gZjAsYtZ+YPHAsGEVqh0mp0BUcTJow5DPClTHgz0sndSx5SLgvUQjT
         MBCJ/JdLzDsqiZDu35321Yzn45QflkDayhknpswCH9+o193J4+SXxC36Zueqfnl1gmai
         9jmjt2vIy4orkreW/GXWQgV0MSKCt1CyZff4SaC54zW9J4iALW1Yl+lawyvVtOS01fv8
         h6EqKVR+hOn8MqZ+zh/G95IJaGJe4mSZS1sT2eJCRRzAxxVj/dGtGjG+9u4VW0ZblbiE
         QpdjxqG7QXAXv9U7YacJFICiB4/iQ6a04o/USIyYPu12AecVLKTR4cgAn2B+1gBUO8ol
         vGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfMiwamrb5Hsn9MOJ+vir9DkXggh5+lNX55ws8jXDRc=;
        b=7XFPF6w7lQCtTfSDnyinl8ib0kVUvr2oma8SF9BZSq6+0fJT9afnwHq7gM7Q566Fpm
         +ZHqiUcPQGhK1nxAaoU+xWV6ArlaDDXlmWEXbSPSeT2cfT8fqoytjCwvArTAfLyXylfs
         oDpJ4b2gZ6SH7tNDDWJek2Aw0YaSX8yEsTFfm7N0aH0dkPgSz06Y+x33+xtBevAx2Pg5
         NQH5W/yQoNO1fpb6Ui2b4PQjOYPGwKYQbWn3heZTUGw95QkmErwk0MtdJ72qeZboxG1p
         irTmpZFLz7Bt+lwYVpXv4CLbXe7D7vOMTOU5mSHdLpCcVNrUazthVz0tnaZYbhjkap6c
         cElg==
X-Gm-Message-State: AO0yUKWWbCssz/gf6J9jeJhZgUviiss2u3wO4AjTfrMAvfSzQiW0bDRz
        Y2lg9/A7kmT1O3KAhsuCw44dH8TXh37Jy0PF1ydoUw==
X-Google-Smtp-Source: AK7set9c/bDAaKouOcrbgvzVfteiJt3VOJzqOkD1O6X8VuF5ny26eObWeXS7DM24YoOcPaRILLBjxOsIZznTqtHnM9c=
X-Received: by 2002:a67:dc81:0:b0:41b:ed91:4d51 with SMTP id
 g1-20020a67dc81000000b0041bed914d51mr1385589vsk.84.1676997404573; Tue, 21 Feb
 2023 08:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-12-jthoughton@google.com> <CAHS8izMGR8MZW1dMCCWQagoCKBvHWBJNwvWZQyrCGzZAoQy0sw@mail.gmail.com>
In-Reply-To: <CAHS8izMGR8MZW1dMCCWQagoCKBvHWBJNwvWZQyrCGzZAoQy0sw@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 21 Feb 2023 08:36:08 -0800
Message-ID: <CADrL8HVkrevuvUXLDJ9hvk4e+wnyQu3+z49rZjxg+=OB=KB_+Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/46] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

On Fri, Feb 17, 2023 at 9:24 PM Mina Almasry <almasrymina@google.com> wrote=
:
>
> On Fri, Feb 17, 2023 at 4:28=E2=80=AFPM James Houghton <jthoughton@google=
.com> wrote:
> >
> > After high-granularity mapping, page table entries for HugeTLB pages ca=
n
> > be of any size/type. (For example, we can have a 1G page mapped with a
> > mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> > PTE after we have done a page table walk.
> >
> > Without this, we'd have to pass around the "size" of the PTE everywhere=
.
> > We effectively did this before; it could be fetched from the hstate,
> > which we pass around pretty much everywhere.
> >
> > hugetlb_pte_present_leaf is included here as a helper function that wil=
l
> > be used frequently later on.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> >
>
> Only nits.
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks Mina!

>
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index a1ceb9417f01..eeacadf3272b 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -26,6 +26,25 @@ typedef struct { unsigned long pd; } hugepd_t;
> >  #define __hugepd(x) ((hugepd_t) { (x) })
> >  #endif
> >
> > +enum hugetlb_level {
> > +       HUGETLB_LEVEL_PTE =3D 1,
> > +       /*
> > +        * We always include PMD, PUD, and P4D in this enum definition =
so that,
> > +        * when logged as an integer, we can easily tell which level it=
 is.
> > +        */
> > +       HUGETLB_LEVEL_PMD,
> > +       HUGETLB_LEVEL_PUD,
> > +       HUGETLB_LEVEL_P4D,
> > +       HUGETLB_LEVEL_PGD,
> > +};
> > +
> > +struct hugetlb_pte {
> > +       pte_t *ptep;
> > +       unsigned int shift;
> > +       enum hugetlb_level level;
> > +       spinlock_t *ptl;
> > +};
> > +
> >  #ifdef CONFIG_HUGETLB_PAGE
> >
> >  #include <linux/mempolicy.h>
> > @@ -39,6 +58,20 @@ typedef struct { unsigned long pd; } hugepd_t;
> >   */
> >  #define __NR_USED_SUBPAGE 3
> >
> > +static inline
> > +unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
> > +{
> > +       return 1UL << hpte->shift;
> > +}
> > +
> > +static inline
> > +unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> > +{
> > +       return ~(hugetlb_pte_size(hpte) - 1);
> > +}
> > +
> > +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pt=
e);
> > +
> >  struct hugepage_subpool {
> >         spinlock_t lock;
> >         long count;
> > @@ -1234,6 +1267,45 @@ static inline spinlock_t *huge_pte_lock(struct h=
state *h,
> >         return ptl;
> >  }
> >
> > +static inline
> > +spinlock_t *hugetlb_pte_lockptr(struct hugetlb_pte *hpte)
> > +{
> > +       return hpte->ptl;
> > +}
>
> I find this helper unnecessary. I would remove it.

Ok. Will do.

>
> > +
> > +static inline
> > +spinlock_t *hugetlb_pte_lock(struct hugetlb_pte *hpte)
> > +{
> > +       spinlock_t *ptl =3D hugetlb_pte_lockptr(hpte);
> > +
> > +       spin_lock(ptl);
>
> Here 'spin_lock(hpte->ptl)' would be more immediately understandable
> IMO, for example.
>
> > +       return ptl;
> > +}
> > +
> > +static inline
> > +void __hugetlb_pte_init(struct hugetlb_pte *hpte, pte_t *ptep,
> > +                       unsigned int shift, enum hugetlb_level level,
> > +                       spinlock_t *ptl)
> > +{
> > +       /*
> > +        * If 'shift' indicates that this PTE is contiguous, then @ptep=
 must
> > +        * be the first pte of the contiguous bunch.
> > +        */
>
> I would move the comment to above the function as a pseudo doc. It
> seems to instruct the user of the function of how to use it.

Right. Will do.

>
> > +       hpte->ptl =3D ptl;
> > +       hpte->ptep =3D ptep;
> > +       hpte->shift =3D shift;
> > +       hpte->level =3D level;
> > +}
> > +
> > +static inline
> > +void hugetlb_pte_init(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +                     pte_t *ptep, unsigned int shift,
> > +                     enum hugetlb_level level)
> > +{
> > +       __hugetlb_pte_init(hpte, ptep, shift, level,
> > +                          huge_pte_lockptr(shift, mm, ptep));
> > +}
> > +
> >  #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
> >  extern void __init hugetlb_cma_reserve(int order);
> >  #else
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 5ca9eae0ac42..6c74adff43b6 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1269,6 +1269,35 @@ static bool vma_has_reserves(struct vm_area_stru=
ct *vma, long chg)
> >         return false;
> >  }
> >
> > +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pt=
e)
> > +{
> > +       pgd_t pgd;
> > +       p4d_t p4d;
> > +       pud_t pud;
> > +       pmd_t pmd;
> > +
> > +       switch (hpte->level) {
> > +       case HUGETLB_LEVEL_PGD:
> > +               pgd =3D __pgd(pte_val(pte));
> > +               return pgd_present(pgd) && pgd_leaf(pgd);
> > +       case HUGETLB_LEVEL_P4D:
> > +               p4d =3D __p4d(pte_val(pte));
> > +               return p4d_present(p4d) && p4d_leaf(p4d);
> > +       case HUGETLB_LEVEL_PUD:
> > +               pud =3D __pud(pte_val(pte));
> > +               return pud_present(pud) && pud_leaf(pud);
> > +       case HUGETLB_LEVEL_PMD:
> > +               pmd =3D __pmd(pte_val(pte));
> > +               return pmd_present(pmd) && pmd_leaf(pmd);
> > +       case HUGETLB_LEVEL_PTE:
> > +               return pte_present(pte);
> > +       default:
> > +               WARN_ON_ONCE(1);
> > +               return false;
> > +       }
> > +}
> > +
> > +
> >  static void enqueue_hugetlb_folio(struct hstate *h, struct folio *foli=
o)
> >  {
> >         int nid =3D folio_nid(folio);
> > --
> > 2.39.2.637.g21b0678d19-goog
> >
