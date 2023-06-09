Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD172A218
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjFISZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFISZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:25:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B91035A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:25:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b02fcde49aso8360915ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686335111; x=1688927111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR7meK9SrYWFcO0nvlLiL65rZmB26fYCU3wzB0PdsHQ=;
        b=qglArcF5C7uMcpve+xn5t7ptCNi6uIwQC+132275NZaue9XGXvk2LlsydqyHbQF/U3
         DqGDOaVyGxsv/CLoQQ+cJSGL2UeL8zir0ga1+Abo5JI2r+aP27hXfZWjVrVc7+nGlO9y
         9u1OUn2sDg0x6cURn52ra0KfysNxyLV58Mot6UfubaxwPwWhFxaxu4rVAThwtIcnGxSz
         ODRlWBtbE5Iw0YRgP4H7ajsqBrCHlBQaopXQVcszeTFYAEr7YX3PNDDmVOpAvonA45an
         1Naz+Ou1NmT+z9LmSwdr2FPgcfQBJbPmXQm3FVE7RDniIvyB4w4ssrudcYVPa45nRg7l
         sRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335111; x=1688927111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kR7meK9SrYWFcO0nvlLiL65rZmB26fYCU3wzB0PdsHQ=;
        b=OWeGZ/oh2YFBfPfKN7P8Uq4sem3Xrt/B3UABNXOk6CTt8u9aZhI84MTqJdJf3dyOh3
         3BR2ppqw00oXa6KwA7z3M41fAo3cWEQwaJphrtqZ8u9zzERRb3aCe3dJ4OguggWrc+lE
         b7xlctL2iP+8i5iqJ2yQiF3SeONGSRkHJPisFsANSVOVu0HJ3scPUpkhaD+7nm/mBbR0
         bUNl3iYe4C5pRhP8GfYrGJhxhYRALx7ZH6Hjc8osdLCaxwq9ZQJTDF26/C5DRaMvTZpY
         cyz+SJ6z1P3r6mLKitb49Ka4BJyOFPX5xmgN+3x3wWBHb+4lIHOAjxQu1wkdC/9uLNDL
         c0OQ==
X-Gm-Message-State: AC+VfDwFS2O2nkFRVof1Q8nKiYwytRwuP9XX4RZguvdiZiAv2R8p/mwH
        qk0b3688PNPnTdSyY5Pds9mlNADiEZolkMZR/JE=
X-Google-Smtp-Source: ACHHUZ42DK2++9rk+pzDyjW4Qwrg6Mcv+XFGZIjR22iyoWNSTBK35PJUY7gUtZnBfRv3Wt8R1C0hwV6PYNzfF9SWCmQ=
X-Received: by 2002:a17:903:41ce:b0:1b1:76c2:296a with SMTP id
 u14-20020a17090341ce00b001b176c2296amr2041083ple.60.1686335111206; Fri, 09
 Jun 2023 11:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com> <59fd15dd-4d39-5ec-2043-1d5117f7f85@google.com>
In-Reply-To: <59fd15dd-4d39-5ec-2043-1d5117f7f85@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 9 Jun 2023 11:24:59 -0700
Message-ID: <CAHbLzkpQV6OX=WZevH_Gjr7BASSkdPfxRxOtjdhT-rGh2YR9MA@mail.gmail.com>
Subject: Re: [PATCH v2 25/32] mm/gup: remove FOLL_SPLIT_PMD use of pmd_trans_unstable()
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Ryan Roberts <ryan.roberts@arm.com>,
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

On Thu, Jun 8, 2023 at 6:40=E2=80=AFPM Hugh Dickins <hughd@google.com> wrot=
e:
>
> There is now no reason for follow_pmd_mask()'s FOLL_SPLIT_PMD block to
> distinguish huge_zero_page from a normal THP: follow_page_pte() handles
> any instability, and here it's a good idea to replace any pmd_none(*pmd)
> by a page table a.s.a.p, in the huge_zero_page case as for a normal THP;
> and this removes an unnecessary possibility of -EBUSY failure.
>
> (Hmm, couldn't the normal THP case have hit an unstably refaulted THP
> before?  But there are only two, exceptional, users of FOLL_SPLIT_PMD.)
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

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
