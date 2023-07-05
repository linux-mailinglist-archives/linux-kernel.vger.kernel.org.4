Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6A748BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjGESXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjGESXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:23:04 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE9E1BD8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 11:22:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40371070eb7so38271cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688581324; x=1691173324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avVYCKbHiJhOupBox2rPu3Kc3oLm07Y5UrCkryiPEfc=;
        b=ZBle+FGiI/+oKmppf7TF2BlE3mHVYEEHBOSoaMyMq/1IB7NyglPEJeLCEksV/f7bMR
         v0aTI8mTCu26TlHwJ/px2joHn0PTI2lWl6CPqUsQ0jJL2SUXrYd4QCJkY7MaNQEiICgt
         +BW2fOuGGwZ27VczohQG+Xa0J3qaNZ9dmGF+s9rMq6mHSGYk31M5EJs9nHSoAI6AMhfr
         IKx6FY9J+vVFHCGH2NOFBtcH6QYx0ZE1WLlIoaVwiorlQH8RDgR8AISMFunkqpx7TVzG
         t8+XFq90GU+Nw3fh1h8SRDVE9ahoViZoUISAXbZgltqc1fLiXzyT2PAH7bubi5Mqsmio
         WteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688581324; x=1691173324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avVYCKbHiJhOupBox2rPu3Kc3oLm07Y5UrCkryiPEfc=;
        b=Ior8oftu5VND7CopYoL2ZmUD2i+OSY/jN94SSJo3Wx027k7Fb1fY9rE0VjPpNWnIoo
         xnuZPkF6KdaxGxf3TNvCejn0oC+TRvClCt7Wqb2gTKzYagkjc5bto4f7mkcB+C4PeuHs
         jLMdu3ElVJE9esQW3yh1WhO5BJHfAx9ZXb9F19gRpr2JOlIt7mgSoizExWW2iDzYKVWW
         XzaPuWCfEz7VdWwvJ4hu9FcUvri7O65W6HB3tQ1oXK7Zf8JltsT8PnvnQKv768hM7pIa
         tIuYp7GXCkRmMIrgxNcTbhn4+9ytVJ8GX3OM0LZl5U5ojDHFvHZEN0fNNxHtsZLRBUkI
         FckQ==
X-Gm-Message-State: ABy/qLaxBth4Brcy7l0C1oriJzpzGwB7ITsVuzmo27NgS195W+tjG4eW
        MSoSAuEPX4SRwPtPLo7s57MqArf4FvEUshJhsAceww==
X-Google-Smtp-Source: APBJJlGTHlkEBqKKQUQxAS0nn1n5NO03cH8n26ikVQ910595sciQNU2NHkrkdt17W6roe0R7ewsHN5CFcaRdRu9AAGs=
X-Received: by 2002:ac8:5ac7:0:b0:3f0:af20:1a37 with SMTP id
 d7-20020ac85ac7000000b003f0af201a37mr15460qtd.15.1688581323594; Wed, 05 Jul
 2023 11:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230621175002.2832640-1-rananta@google.com> <20230621175002.2832640-6-rananta@google.com>
 <9f9906b5-cdae-273c-06a3-5e100fe2ccd8@redhat.com>
In-Reply-To: <9f9906b5-cdae-273c-06a3-5e100fe2ccd8@redhat.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Wed, 5 Jul 2023 11:21:52 -0700
Message-ID: <CAJHc60zU3iqf9bse2Hm=ZF2xLY68_Xf30oxYs23PW8fHT09cQQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 05/11] arm64: tlb: Refactor the core flush
 algorithm of __flush_tlb_range
To:     Gavin Shan <gshan@redhat.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
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

On Tue, Jul 4, 2023 at 5:11=E2=80=AFPM Gavin Shan <gshan@redhat.com> wrote:
>
> On 6/22/23 03:49, Raghavendra Rao Ananta wrote:
> > Currently, the core TLB flush functionality of __flush_tlb_range()
> > hardcodes vae1is (and variants) for the flush operation. In the
> > upcoming patches, the KVM code reuses this core algorithm with
> > ipas2e1is for range based TLB invalidations based on the IPA.
> > Hence, extract the core flush functionality of __flush_tlb_range()
> > into its own macro that accepts an 'op' argument to pass any
> > TLBI operation, such that other callers (KVM) can benefit.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >   arch/arm64/include/asm/tlbflush.h | 108 +++++++++++++++--------------=
-
> >   1 file changed, 55 insertions(+), 53 deletions(-)
> >
>
> With the following nits addressed:
>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
>
> > diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm=
/tlbflush.h
> > index 412a3b9a3c25d..4775378b6da1b 100644
> > --- a/arch/arm64/include/asm/tlbflush.h
> > +++ b/arch/arm64/include/asm/tlbflush.h
> > @@ -278,14 +278,61 @@ static inline void flush_tlb_page(struct vm_area_=
struct *vma,
> >    */
> >   #define MAX_TLBI_OPS        PTRS_PER_PTE
> >
> > +/* When the CPU does not support TLB range operations, flush the TLB
> > + * entries one by one at the granularity of 'stride'. If the TLB
> > + * range ops are supported, then:
> > + *
> > + * 1. If 'pages' is odd, flush the first page through non-range
> > + *    operations;
> > + *
> > + * 2. For remaining pages: the minimum range granularity is decided
> > + *    by 'scale', so multiple range TLBI operations may be required.
> > + *    Start from scale =3D 0, flush the corresponding number of pages
> > + *    ((num+1)*2^(5*scale+1) starting from 'addr'), then increase it
> > + *    until no pages left.
> > + *
> > + * Note that certain ranges can be represented by either num =3D 31 an=
d
> > + * scale or num =3D 0 and scale + 1. The loop below favours the latter
> > + * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
> > + */
> > +#define __flush_tlb_range_op(op, start, pages, stride,                =
       \
> > +                             asid, tlb_level, tlbi_user) do {        \
> > +     int num =3D 0;                                                   =
 \
> > +     int scale =3D 0;                                                 =
 \
> > +     unsigned long addr;                                             \
> > +                                                                     \
> > +     while (pages > 0) {                                             \
> > +             if (!system_supports_tlb_range() ||                     \
> > +                 pages % 2 =3D=3D 1) {                                =
   \
> > +                     addr =3D __TLBI_VADDR(start, asid);              =
 \
> > +                     __tlbi_level(op, addr, tlb_level);              \
> > +                     if (tlbi_user)                                  \
> > +                             __tlbi_user_level(op, addr, tlb_level); \
> > +                     start +=3D stride;                               =
 \
> > +                     pages -=3D stride >> PAGE_SHIFT;                 =
 \
> > +                     continue;                                       \
> > +             }                                                       \
> > +                                                                     \
> > +             num =3D __TLBI_RANGE_NUM(pages, scale);                  =
 \
> > +             if (num >=3D 0) {                                        =
 \
> > +                     addr =3D __TLBI_VADDR_RANGE(start, asid, scale,  =
 \
> > +                                               num, tlb_level);      \
> > +                     __tlbi(r##op, addr);                            \
> > +                     if (tlbi_user)                                  \
> > +                             __tlbi_user(r##op, addr);               \
> > +                     start +=3D __TLBI_RANGE_PAGES(num, scale) << PAGE=
_SHIFT; \
> > +                     pages -=3D __TLBI_RANGE_PAGES(num, scale);       =
 \
> > +             }                                                       \
> > +             scale++;                                                \
> > +     }                                                               \
> > +} while (0)
> > +
>
> There is a warning reported from 'checkpatch.pl'.
>
>      WARNING: suspect code indent for conditional statements (32, 8)
>      #52: FILE: arch/arm64/include/asm/tlbflush.h:299:
>      +                          asid, tlb_level, tlbi_user) do {        \
>      [...]
>      +  unsigned long addr;                                             \
>
>      total: 0 errors, 1 warnings, 125 lines checked
>
> You probably need to tweak it as below, to avoid the warning.
>
>      #define __flush_tlb_range_op(op, start, pages, stride,              =
  \
>                                   asid, tlb_level, tlbi_user)            =
  \
>      do {                                                                =
  \
>
Thanks for the suggestion, Gavin. I'll fix this.

- Raghavendra
>
> >   static inline void __flush_tlb_range(struct vm_area_struct *vma,
> >                                    unsigned long start, unsigned long e=
nd,
> >                                    unsigned long stride, bool last_leve=
l,
> >                                    int tlb_level)
> >   {
> > -     int num =3D 0;
> > -     int scale =3D 0;
> > -     unsigned long asid, addr, pages;
> > +     unsigned long asid, pages;
> >
> >       start =3D round_down(start, stride);
> >       end =3D round_up(end, stride);
> > @@ -307,56 +354,11 @@ static inline void __flush_tlb_range(struct vm_ar=
ea_struct *vma,
> >       dsb(ishst);
> >       asid =3D ASID(vma->vm_mm);
> >
> > -     /*
> > -      * When the CPU does not support TLB range operations, flush the =
TLB
> > -      * entries one by one at the granularity of 'stride'. If the TLB
> > -      * range ops are supported, then:
> > -      *
> > -      * 1. If 'pages' is odd, flush the first page through non-range
> > -      *    operations;
> > -      *
> > -      * 2. For remaining pages: the minimum range granularity is decid=
ed
> > -      *    by 'scale', so multiple range TLBI operations may be requir=
ed.
> > -      *    Start from scale =3D 0, flush the corresponding number of p=
ages
> > -      *    ((num+1)*2^(5*scale+1) starting from 'addr'), then increase=
 it
> > -      *    until no pages left.
> > -      *
> > -      * Note that certain ranges can be represented by either num =3D =
31 and
> > -      * scale or num =3D 0 and scale + 1. The loop below favours the l=
atter
> > -      * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
> > -      */
> > -     while (pages > 0) {
> > -             if (!system_supports_tlb_range() ||
> > -                 pages % 2 =3D=3D 1) {
> > -                     addr =3D __TLBI_VADDR(start, asid);
> > -                     if (last_level) {
> > -                             __tlbi_level(vale1is, addr, tlb_level);
> > -                             __tlbi_user_level(vale1is, addr, tlb_leve=
l);
> > -                     } else {
> > -                             __tlbi_level(vae1is, addr, tlb_level);
> > -                             __tlbi_user_level(vae1is, addr, tlb_level=
);
> > -                     }
> > -                     start +=3D stride;
> > -                     pages -=3D stride >> PAGE_SHIFT;
> > -                     continue;
> > -             }
> > -
> > -             num =3D __TLBI_RANGE_NUM(pages, scale);
> > -             if (num >=3D 0) {
> > -                     addr =3D __TLBI_VADDR_RANGE(start, asid, scale,
> > -                                               num, tlb_level);
> > -                     if (last_level) {
> > -                             __tlbi(rvale1is, addr);
> > -                             __tlbi_user(rvale1is, addr);
> > -                     } else {
> > -                             __tlbi(rvae1is, addr);
> > -                             __tlbi_user(rvae1is, addr);
> > -                     }
> > -                     start +=3D __TLBI_RANGE_PAGES(num, scale) << PAGE=
_SHIFT;
> > -                     pages -=3D __TLBI_RANGE_PAGES(num, scale);
> > -             }
> > -             scale++;
> > -     }
> > +     if (last_level)
> > +             __flush_tlb_range_op(vale1is, start, pages, stride, asid,=
 tlb_level, true);
> > +     else
> > +             __flush_tlb_range_op(vae1is, start, pages, stride, asid, =
tlb_level, true);
> > +
> >       dsb(ish);
> >   }
> >
>
> Thanks,
> Gavin
>
