Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7694F70D132
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjEWC1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEWC1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:27:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F968CD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:27:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25332422531so3157546a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684808829; x=1687400829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5HZbHCclTPTsAbhxHOSs80OfYhrVMw6jkGXw+YoSR0=;
        b=gMh+bNLtP0wa0RLL9qhizk1/Kzy9cplh+MWPxJZM5cjj0xpy7o+KdeEtKOJSPM7ALj
         o/u6r32pm4+3hXXEwh1ExjDFI+PKaBvLJHhcBvtMyV6uvrQO6IaJFR4SFcxVydrnAG8w
         RORBDo9OOejdryaFnVazFJicmcrsMHglxnVchUT8fAoYIKil2GEajK1zwSuKYpquVTDx
         echFIiHowHrWKGQHccpE4YkJ6oZjjFtLwkDu+S+H724x/4oSWt2Nh/nmwQcdHqwiOZ+u
         JuyHOYfdL+GgWDVe4oQJpCHtVd/myhPwgZFEH9fr3VqunYKh2VH06edtzzfEK3v8uW23
         LQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684808829; x=1687400829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5HZbHCclTPTsAbhxHOSs80OfYhrVMw6jkGXw+YoSR0=;
        b=ZR5lnGvPrYDJMVZy7nuStq4fqpRu6T4dNug+1vOwlKs/wb5NpDdacAal51vcCXQKG4
         SWLg0GDp76fEJjtqK1F8PLHBCfWJ8N8IIvfVH54Qq4RLmOzRG04hY1gW5kz6Vygpcvzn
         0Y6UVyWNOfCRXztgY/cO5lluseh1+S5XPT9DQDUG+Dl93S1JpMCV00dJXeUU6Sg2QRd1
         /bhyitWJi9OnrXCRA/f+MFaXsB3zD/SuLdPb+C7stde8L+nnJliVZedO2cLszCEUbn/P
         cHC1lmexqK9RJLQXGwh+UkMySHCpLKngBzuMttDdEuYp+4kK+z+U8TLYSdTHPdBKSPYR
         z+qg==
X-Gm-Message-State: AC+VfDwxArMsZtqIG/g8gUetrR/+Jm6R5nTpJ3+xPJay/85ZeMr8JFsE
        /UMttk1tL62/MTeqezkv+QpgEO6wcHIu3zN863w=
X-Google-Smtp-Source: ACHHUZ6WzlFEoYOzBP/0jqmbIKsaRKJbS2GCbtj2bbyJ10rJz8qubggHF3P5jvPje6oOxpTBAqKZ5SDx9Rrw0PutRBI=
X-Received: by 2002:a17:90a:9dc6:b0:255:38ed:9dcd with SMTP id
 x6-20020a17090a9dc600b0025538ed9dcdmr8996454pjv.0.1684808828559; Mon, 22 May
 2023 19:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <b9da41bb-b7b6-2fc6-caac-b01b6719334@google.com>
In-Reply-To: <b9da41bb-b7b6-2fc6-caac-b01b6719334@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 22 May 2023 19:26:57 -0700
Message-ID: <CAHbLzkpdWqLM1+Jb+rzVjxGyRBUtJFU_2O7=7PtE0dNgsvXSrQ@mail.gmail.com>
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

On Sun, May 21, 2023 at 10:22=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> There is now no reason for follow_pmd_mask()'s FOLL_SPLIT_PMD block to
> distinguish huge_zero_page from a normal THP: follow_page_pte() handles
> any instability, and here it's a good idea to replace any pmd_none(*pmd)
> by a page table a.s.a.p, in the huge_zero_page case as for a normal THP.
> (Hmm, couldn't the normal THP case have hit an unstably refaulted THP
> before?  But there are only two, exceptional, users of FOLL_SPLIT_PMD.)
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/gup.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index bb67193c5460..4ad50a59897f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -681,21 +681,10 @@ static struct page *follow_pmd_mask(struct vm_area_=
struct *vma,
>                 return follow_page_pte(vma, address, pmd, flags, &ctx->pg=
map);
>         }
>         if (flags & FOLL_SPLIT_PMD) {
> -               int ret;
> -               page =3D pmd_page(*pmd);
> -               if (is_huge_zero_page(page)) {
> -                       spin_unlock(ptl);
> -                       ret =3D 0;
> -                       split_huge_pmd(vma, pmd, address);
> -                       if (pmd_trans_unstable(pmd))
> -                               ret =3D -EBUSY;

IIUC the pmd_trans_unstable() check was transferred to the implicit
pmd_none() in pte_alloc(). But it will return -ENOMEM instead of
-EBUSY. Won't it break some userspace? Or the pmd_trans_unstable() is
never true? If so it seems worth mentioning in the commit log about
this return value change.

> -               } else {
> -                       spin_unlock(ptl);
> -                       split_huge_pmd(vma, pmd, address);
> -                       ret =3D pte_alloc(mm, pmd) ? -ENOMEM : 0;
> -               }
> -
> -               return ret ? ERR_PTR(ret) :
> +               spin_unlock(ptl);
> +               split_huge_pmd(vma, pmd, address);
> +               /* If pmd was left empty, stuff a page table in there qui=
ckly */
> +               return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
>                         follow_page_pte(vma, address, pmd, flags, &ctx->p=
gmap);
>         }
>         page =3D follow_trans_huge_pmd(vma, address, pmd, flags);
> --
> 2.35.3
>
