Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC20748A10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjGERZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjGERZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:25:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74FA188
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:25:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401d1d967beso20881cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688577907; x=1691169907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvJl8XInaVm4n5AR4AD2zyrea1AdB/Yqy4IKMB7L0Iw=;
        b=DM87sN9etq3pLXS2B0O0x8/s69x8n8NtNg54LKnNdle2WaUIVHRKv2ggFtINDm6Wmq
         Tqw4LejYbfeB0xcvLh0X5mpLO2lh9LpxapgsVfLpB4qGdv5keyAOHiOqlruV+bBp6iiO
         a5WlNuHufIBSuqJ2SAN8sH3TvZVGH6x9hwxTX6ugTClo7DgB6YkQzk6WIqj0g+uYRm8y
         kXIH5o6hAztnIiTFDahGGEEUxi6AN4Z5VtkqouFT1mEOhKAkIyquMjVfHFRZRLPK2Icq
         7xfArJI7fgL0ZRiqzznqyR1obr7TvIYfcjc+NfAlpM3GDURvTgdjB79Tg0SfJ8vjbbvN
         odYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577907; x=1691169907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvJl8XInaVm4n5AR4AD2zyrea1AdB/Yqy4IKMB7L0Iw=;
        b=XsUd20EfKqzVrlhdcU9kht2XYTOsh/VWBoij70zModkO7CtPENzcsRH4PEnYiZO4NX
         MOAFvnX54tE5dVeVv9NUJRGr4RdtxSI54rK3+sODrCujRkwSRCzQFv6Jbcxa783DianV
         Q9yVlVXNVJ9IdjRhmvG/H1L23qmNmgHdHe6b9Twm9WUlESlanwK6UP1jZsT1EtZPLxf3
         23is7O/Rhje940Kd/pbq4bm8yOfH2ewJViHVWU7tyyzhgwx/5tOliNxVwr/SpM66ocqo
         IRYzh8QlRl7aM/TOvdXWXutnpfK7l4PjcOIBFfexwO8jPOusv/gJV+Mv4VBUwb9PfnO9
         tMSA==
X-Gm-Message-State: ABy/qLbgA9jpouE1VKSuRP05Pdb2Li5YkIx9fT0vCsu8+ZrdCgJO5cPi
        QcXf9gcKAZcAWuSrEa1sdFg21US/FBfVKvC+/TUjdg==
X-Google-Smtp-Source: APBJJlFvsrxca+yc7W6N+OGa5E4od+AwyUaACPlOJi2RIZLZQoFjwJXpzRBVXAIhOwUbSGzbP0UszSU6QIsPScInIuU=
X-Received: by 2002:a05:622a:18e:b0:3f8:5b2:aeec with SMTP id
 s14-20020a05622a018e00b003f805b2aeecmr2782qtw.20.1688577906947; Wed, 05 Jul
 2023 10:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com> <CAOUHufa_xFJvFFvmw1Tkdc9cXaZ1GPA1dVSauH+J9zGX-sO1UA@mail.gmail.com>
 <eea2b36d-9c6d-64ca-4e21-57cfd5a93d57@arm.com> <CAOUHufZypv+kLFu3r8iPYbceBh0KSE=gus-_iC1Q35_QVQdnMQ@mail.gmail.com>
 <9c5f3515-ad39-e416-902e-96e9387a3b60@arm.com>
In-Reply-To: <9c5f3515-ad39-e416-902e-96e9387a3b60@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 5 Jul 2023 11:24:30 -0600
Message-ID: <CAOUHufYvRYO=x==+i1aDQHvO=fx_sa6kmi5T4CMvsYiw1wgWqw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Default implementation of arch_wants_pte_order()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
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

On Wed, Jul 5, 2023 at 3:11=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 05/07/2023 03:07, Yu Zhao wrote:
> > On Tue, Jul 4, 2023 at 7:20=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> On 03/07/2023 20:50, Yu Zhao wrote:
> >>> On Mon, Jul 3, 2023 at 7:53=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>>>
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
> >>>
> >>> I don't really mind a non-zero default value. But people would ask wh=
y
> >>> non-zero and why 64KB. Probably you could argue this is the large siz=
e
> >>> all known archs support if they have TLB coalescing. For x86, AMD CPU=
s
> >>> would want to override this. I'll leave it to Fengwei to decide
> >>> whether Intel wants a different default value.>
> >>> Also I don't like the vma parameter because it makes
> >>> arch_wants_pte_order() a mix of hw preference and vma policy. From my
> >>> POV, the function should be only about the former; the latter should
> >>> be decided by arch-independent MM code. However, I can live with it i=
f
> >>> ARM MM people think this is really what you want. ATM, I'm skeptical
> >>> they do.
> >>
> >> Here's the big picture for what I'm tryng to achieve:
> >>
> >>  - In the common case, I'd like all programs to get a performance bump=
 by
> >> automatically and transparently using large anon folios - so no explic=
it
> >> requirement on the process to opt-in.
> >
> > We all agree on this :)
> >
> >>  - On arm64, in the above case, I'd like the preferred folio size to b=
e 64K;
> >> from the (admittedly limitted) testing I've done that's about where th=
e
> >> performance knee is and it doesn't appear to increase the memory wasta=
ge very
> >> much. It also has the benefits that for 4K base pages this is the cont=
pte size
> >> (order-4) so I can take full benefit of contpte mappings transparently=
 to the
> >> process. And for 16K this is the HPA size (order-2).
> >
> > My highest priority is to get 16KB proven first because it would
> > benefit both client and server devices. So it may be different from
> > yours but I don't see any conflict.
>
> Do you mean 16K folios on a 4K base page system

Yes.

> or large folios on a 16K base
> page system? I thought your focus was on speeding up 4K base page client =
systems
> but this statement has got me wondering?

Sorry, I should have said 4x4KB.

> >>  - On arm64 when the process has marked the VMA for THP (or when
> >> transparent_hugepage=3Dalways) but the VMA does not meet the requireme=
nts for a
> >> PMD-sized mapping (or we failed to allocate, ...) then I'd like to map=
 using
> >> contpte. For 4K base pages this is 64K (order-4), for 16K this is 2M (=
order-7)
> >> and for 64K this is 2M (order-5). The 64K base page case is very impor=
tant since
> >> the PMD size for that base page is 512MB which is almost impossible to=
 allocate
> >> in practice.
> >
> > Which case (server or client) are you focusing on here? For our client
> > devices, I can confidently say that 64KB has to be after 16KB, if it
> > happens at all. For servers in general, I don't know of any major
> > memory-intensive workloads that are not THP-aware, i.e., I don't think
> > "VMA does not meet the requirements" is a concern.
>
> For the 64K base page case, the focus is server. The problem reported by =
our
> partner is that the 512M huge page size is too big to reliably allocate a=
nd so
> the fauls always fall back to 64K base pages in practice. I would also sp=
eculate
> (happy to be proved wrong) that there are many THP-aware workloads that a=
ssume
> the THP size is 2M. In this case, their VMAs may well be too small to fit=
 a 512M
> huge page when running on 64K base page system.

Interesting. When you have something ready to share, I might be able
to try it on our ARM servers as well.

> But the TL;DR is that Arm has a partner for which enabling 2M THP on a 64=
K base
> page system is a very real requirement. Our intent is that this will be t=
he
> mechanism we use to enable it.

Yes, contpte makes more sense for what you described. It'd fit in a
lot better in the hugetlb case, but I guess your partner uses anon.
