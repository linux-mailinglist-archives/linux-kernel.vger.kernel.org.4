Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF82746913
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjGDFmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGDFmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:42:50 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A9DE52
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 22:42:47 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40371070eb7so40331cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 22:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688449367; x=1691041367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YigxfadlPchsL4MPXr4aopZ09B0BS+iCYyFqrVZec08=;
        b=HTau2IopMSSukmHEEFT7Ajeb1RUP10fLukqvpMl7IZwm9gqqTNbIe/heoE4TID1yWf
         79TN7IwbbNAicx9pSr/tIucLX+VIOW5x+UET95cJkBOO++e+PvUFOn73BCa7+fsCMUhW
         iUIu77EjCLYbzdpTz6QCH55aiFYjG1ybd07OyztYAin7wtawkd+0PNqlJp3YvhQISN8I
         DYu7Knk9NQuoDzhxx3uF0YBEbItm7jSE2qpp/rw9WYXw6cxgb6BMYb+UCZVhSX8f5laW
         VH4JeflX4FvhYx5ulzHv/kZlkc3ceK0+VITyFE5epcCs09nLDfDkeeBuPTQNkjZJuNIB
         0OlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688449367; x=1691041367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YigxfadlPchsL4MPXr4aopZ09B0BS+iCYyFqrVZec08=;
        b=DQ7+9PuQR/NseoQwwXRCjovSfk5Wwgn/+HswWrx1qKekQL4BlcH3Y5vrPl0nR1ynTO
         NdbPQZ8N7PKXmaeFfAcBSYjXs6DaU/HRoccTjhEDZ0OHlDL9EvjRmM5qAesdM2O3h1pE
         54c7oHAUhpSKhaRvGYaBcvYSGpCD7qB+D0urBRKn/Zriw6axeiVWBzIaRuRwYfvvu7Hi
         VTQzL3S/fYA67w3Tb/RuxysBY/8Nf1NcaBy+FpRGkkpoyUVdT0CRYJookTfpW0M5FJGZ
         7cdKT1yjHCk6p4aVWgbAav59Ajve0D4eWPOdEb6040vVls9cuzBFjrUT7+a7eCWJ38JI
         iVBg==
X-Gm-Message-State: ABy/qLZ2dKqooj9X9aYLjkmVqOu8gVFZm47epOOF8KZYJZJml3ZYrGQj
        fbRh7z27u1dj+IQovt83XlRWn/MqF0nevGnQoxWxIHyovI4sc/VbCW5IMw==
X-Google-Smtp-Source: APBJJlGSYGP0aXUNUfMGB1LDrsPHibFu70TmMXAlesg4X4WWApqsKf8hnjvcC6yv81eB/X2BJdb+fuPfb+pROgHKAak=
X-Received: by 2002:ac8:7f12:0:b0:3f8:5b2:aeee with SMTP id
 f18-20020ac87f12000000b003f805b2aeeemr58473qtk.22.1688449366648; Mon, 03 Jul
 2023 22:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com> <ac6802f6-01a2-6b39-38c7-2fe3cea75dde@intel.com>
 <CAOUHufbmv0pZ1h9AxBj-SD7OqRZYudHMtXzQxcwD4ky-sFd8kg@mail.gmail.com>
 <CAOUHufbpCU_Z7g1QPJ0+HzE9sdNpSh=Mzi0EByLPu5TE4S_UcQ@mail.gmail.com> <4f86fa34-11d0-8a11-5adf-d099fc9e46b8@intel.com>
In-Reply-To: <4f86fa34-11d0-8a11-5adf-d099fc9e46b8@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 3 Jul 2023 23:42:10 -0600
Message-ID: <CAOUHufaC6bZv+U8hLvF9sR2O7tRW+Bzf0BjrFg9OOUpkm6hQQA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Default implementation of arch_wants_pte_order()
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 11:23=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
>
> On 7/4/2023 11:59 AM, Yu Zhao wrote:
> > On Mon, Jul 3, 2023 at 9:02=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrot=
e:
> >>
> >> On Mon, Jul 3, 2023 at 8:23=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel=
.com> wrote:
> >>>
> >>>
> >>>
> >>> On 7/3/2023 9:53 PM, Ryan Roberts wrote:
> >>>> arch_wants_pte_order() can be overridden by the arch to return the
> >>>> preferred folio order for pte-mapped memory. This is useful as some
> >>>> architectures (e.g. arm64) can coalesce TLB entries when the physica=
l
> >>>> memory is suitably contiguous.
> >>>>
> >>>> The first user for this hint will be FLEXIBLE_THP, which aims to
> >>>> allocate large folios for anonymous memory to reduce page faults and
> >>>> other per-page operation costs.
> >>>>
> >>>> Here we add the default implementation of the function, used when th=
e
> >>>> architecture does not define it, which returns the order correspondi=
ng
> >>>> to 64K.
> >>>>
> >>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>> ---
> >>>>  include/linux/pgtable.h | 13 +++++++++++++
> >>>>  1 file changed, 13 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>>> index a661a17173fa..f7e38598f20b 100644
> >>>> --- a/include/linux/pgtable.h
> >>>> +++ b/include/linux/pgtable.h
> >>>> @@ -13,6 +13,7 @@
> >>>>  #include <linux/errno.h>
> >>>>  #include <asm-generic/pgtable_uffd.h>
> >>>>  #include <linux/page_table_check.h>
> >>>> +#include <linux/sizes.h>
> >>>>
> >>>>  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_F=
OLDED) - \
> >>>>       defined(__PAGETABLE_PMD_FOLDED) !=3D CONFIG_PGTABLE_LEVELS
> >>>> @@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
> >>>>  }
> >>>>  #endif
> >>>>
> >>>> +#ifndef arch_wants_pte_order
> >>>> +/*
> >>>> + * Returns preferred folio order for pte-mapped memory. Must be in =
range [0,
> >>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires=
 large folios
> >>>> + * to be at least order-2.
> >>>> + */
> >>>> +static inline int arch_wants_pte_order(struct vm_area_struct *vma)
> >>>> +{
> >>>> +     return ilog2(SZ_64K >> PAGE_SHIFT);
> >>> Default value which is not related with any silicon may be: PAGE_ALLO=
C_COSTLY_ORDER?
> >>>
> >>> Also, current pcp list support cache page with order 0...PAGE_ALLOC_C=
OSTLY_ORDER, 9.
> >>> If the pcp could cover the page, the pressure to zone lock will be re=
duced by pcp.
> >>
> >> The value of PAGE_ALLOC_COSTLY_ORDER is reasonable but again it's a
> >> s/w policy not a h/w preference. Besides, I don't think we can include
> >> mmzone.h in pgtable.h.
> >
> > I think we can make a compromise:
> > 1. change the default implementation of arch_has_hw_pte_young() to retu=
rn 0, and
> > 2. in memory.c, we can try PAGE_ALLOC_COSTLY_ORDER for archs that
> > don't override arch_has_hw_pte_young(), or if its return value is too
> > large to fit.
> Do you mean arch_wants_pte_order()? Yes. This looks good to me. Thanks.

Sorry, copied the wrong function from above and pasted without looking...
