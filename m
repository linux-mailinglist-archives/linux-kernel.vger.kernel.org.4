Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44BB6464D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiLGXOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGXOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:14:03 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A784E87CB8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:14:02 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i2so18762322vsc.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3AMraPxTEMML2QwIVTCEcNgf8lB6EELFHw2faoFhz0=;
        b=JfQA+TEzoiHOj0cgo8aRIAdrr1vXuO7gCmCpgnRv/LqryVKtMxM90wYWRCOfJhdBYZ
         vCFZZJjUUfImOp2oVS38W4AtJgY8i3PYAdRjHPf4iZdZFgThJdMTtiB08NgGKxaueAc2
         IsBDgCy5EDpc0XdhQ+PCu9RAqOne071/FE0LZrMZ3C2wVxYiDQzpHuzDOptoRNPYtlRO
         8SDzgWTqIltwPCk/SuX83NmJUhXGOeUd4715cFXy/BMAmNdQD9Vf40zz95vvFFt3fUlQ
         0bOtcK5H4t0A2wKKF89etmINGB3nugcdbfYC7rI/nefgy6CXbjY/YlFMyRKom/r3pVCq
         v1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3AMraPxTEMML2QwIVTCEcNgf8lB6EELFHw2faoFhz0=;
        b=Kj0pPyFtvfjBXFEjp758I8EVlov+Af4LPuMJjWn9qpWRprKGP0DRxE1ykZ6RADV9Mb
         nsdwWtF1gU6wK7fqah4O5j9WueszKQ1EiDaaByIE2K6OkKGHdS0aMqmh+3UWlt8mUsYZ
         U87dkA8p9mRhqZxI6RQhVS9JLpi59Hp/wiIijDC2bOplQEdqfeE22wxddYgS4iwlMF+1
         V4B2XvPpnqLAcTxAFADbrQ2LSR/G2F2U2ME+GLH0mw2pqIcFc49Clxs3ueJGXIG90XDJ
         OwH4GuSKXv4imOnW9SpgW9Ep8ONQjZ74v9rFYyzTTOy+Nrslx6857IC2XxuUZVnWu1ON
         L/1w==
X-Gm-Message-State: ANoB5pk8a2XRKl0osqL0pD1hkqN05sM0u2O8lGeLGDLSNOZf8BuWCk4Z
        V6EnWEYCAtxLXzGO/XTXCbfZxTGGq06u9ce9fS37Bw==
X-Google-Smtp-Source: AA0mqf5hc2cyG+r40eIgDTUY2j584KDq0fVV2uUzVoIpSZ9CKcMf4xVlyU03mDhKWsozpDgxpp+aZJFN1i8V0OV6qAs=
X-Received: by 2002:a05:6102:cd1:b0:3aa:1bff:a8a5 with SMTP id
 g17-20020a0561020cd100b003aa1bffa8a5mr52101595vst.67.1670454841616; Wed, 07
 Dec 2022 15:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com> <20221021163703.3218176-3-jthoughton@google.com>
In-Reply-To: <20221021163703.3218176-3-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 7 Dec 2022 15:13:50 -0800
Message-ID: <CAHS8izMyO=AJcZAKRNVfWS2-AQvzxk6mNsTgK_6u7V=P09Ykcg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/47] hugetlb: remove mk_huge_pte; it is unused
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Fri, Oct 21, 2022 at 9:37 AM James Houghton <jthoughton@google.com> wrote:
>
> mk_huge_pte is unused and not necessary. pte_mkhuge is the appropriate
> function to call to create a HugeTLB PTE (see
> Documentation/mm/arch_pgtable_helpers.rst).
>
> It is being removed now to avoid complicating the implementation of
> HugeTLB high-granularity mapping.
>
> Signed-off-by: James Houghton <jthoughton@google.com>

Acked-by: Mina Almasry <almasrymina@google.com>

> ---
>  arch/s390/include/asm/hugetlb.h | 5 -----
>  include/asm-generic/hugetlb.h   | 5 -----
>  mm/debug_vm_pgtable.c           | 2 +-
>  mm/hugetlb.c                    | 7 +++----
>  4 files changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
> index ccdbccfde148..c34893719715 100644
> --- a/arch/s390/include/asm/hugetlb.h
> +++ b/arch/s390/include/asm/hugetlb.h
> @@ -77,11 +77,6 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>         set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
>  }
>
> -static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
> -{
> -       return mk_pte(page, pgprot);
> -}
> -
>  static inline int huge_pte_none(pte_t pte)
>  {
>         return pte_none(pte);
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index a57d667addd2..aab9e46fa628 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -5,11 +5,6 @@
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
>
> -static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
> -{
> -       return mk_pte(page, pgprot);
> -}
> -
>  static inline unsigned long huge_pte_write(pte_t pte)
>  {
>         return pte_write(pte);
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 2b61fde8c38c..10573a283a12 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -929,7 +929,7 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
>          * as it was previously derived from a real kernel symbol.
>          */
>         page = pfn_to_page(args->fixed_pmd_pfn);
> -       pte = mk_huge_pte(page, args->page_prot);
> +       pte = mk_pte(page, args->page_prot);
>
>         WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
>         WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte))));
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 650761cdd2f6..20a111b532aa 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4728,11 +4728,10 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
>         unsigned int shift = huge_page_shift(hstate_vma(vma));
>
>         if (writable) {
> -               entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
> -                                        vma->vm_page_prot)));
> +               entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_pte(page,
> +                                               vma->vm_page_prot)));
>         } else {
> -               entry = huge_pte_wrprotect(mk_huge_pte(page,
> -                                          vma->vm_page_prot));
> +               entry = huge_pte_wrprotect(mk_pte(page, vma->vm_page_prot));
>         }
>         entry = pte_mkyoung(entry);
>         entry = arch_make_huge_pte(entry, shift, vma->vm_flags);
> --
> 2.38.0.135.g90850a2211-goog
>
