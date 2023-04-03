Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD756D5033
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjDCSYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjDCSYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:24:06 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB7C170A;
        Mon,  3 Apr 2023 11:24:05 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h14so14414678ilj.0;
        Mon, 03 Apr 2023 11:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680546244; x=1683138244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLcYkBQ6zlbiLXorhcUGXvnBxQ6eez111cDSr+vpQ3I=;
        b=S7qbEl+v2sdnA3rkEm1vOAgL+NUKHBQIEk9qzKAGVoQa+3K7EuSN9AHp+srdKkmEWY
         VfPDndddKuQTO3cVQx6pZ9aFR6zglYxPNy2r9V267lAm1SASscLaSwVz+mIsExlLFOhh
         dSk4vdL/xGaaUOtJBTyj9S0aYGSsqRz2wdN86xJf0pbv5ZrJoARtDR6qbSA43TMG9OXc
         yZVBJL72UEx14eJ1/bMOiglImMp1IlsbjddqH6lvvYLS20/ZRH0Hufc0yCE9Ev/eJf0A
         qVWaxc1liDA2FN2tC06bC8Q4rQFezWqFNBlTiWRdAcK+yUGxOGMDQOWpaIT+WDdSzNMo
         Q2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680546244; x=1683138244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLcYkBQ6zlbiLXorhcUGXvnBxQ6eez111cDSr+vpQ3I=;
        b=4rQDRiM4N39RbR2Y6dlTijHRsRWzfSP7e06eSolGl0XCe4LMP6jEklDIolJcnMjcmS
         jW7zioEMcKZKIT8FEOBr4qQrq8n1KQXfoCS5K1NGKYgUbVxyP+yM9FTtDl14cHwVZYtd
         i1T4ux22giqy8GUxn/+ohXpqp4U8XhHJ/4SqUKBaiypaKyvX53UxULppCqj3fBpN9kvu
         lwpxM4SfsEWpniDmTVTzuNBOge3Sz/W2jiufVB1ALHGjqbZrek8bo4vJsK5NAPsCk3nP
         vZgLhgnC4iW3Cu8mavG7o1cgq79M0tqHnD14MvGqRxTf55eMpuG9H6ULdAR1sOxAUs18
         /IrA==
X-Gm-Message-State: AAQBX9c4r5UVNOJ2suKF3rxkhmMUprpFIPKoYe79C/C4eGtqe3IwcVCJ
        wdKC7Et8pVQ1ZJXqeP2d9akh4ui+nIWcH0oLPY0=
X-Google-Smtp-Source: AKy350b3ENLXo3KDjAtD/3eyk+24aIZQL1Zpoc6eQj6JAT14NdrcAFxaQCuw6vmBHfaUgEQ/Ocn/t7Yp80NS7aFVttw=
X-Received: by 2002:a92:ac03:0:b0:316:fa49:3705 with SMTP id
 r3-20020a92ac03000000b00316fa493705mr14897ilh.1.1680546244503; Mon, 03 Apr
 2023 11:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <f12f9773-77b5-4ba6-9e9e-adbc67ca0110@spud>
In-Reply-To: <f12f9773-77b5-4ba6-9e9e-adbc67ca0110@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 3 Apr 2023 19:23:37 +0100
Message-ID: <CA+V-a8s0UViJ0tBSyiL0ZG8iVT3QSW77=VujJJOfiuM8T=9ntg@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thank you for the review.

On Fri, Mar 31, 2023 at 1:24=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey,
>
> I think most of what I wanted to talk about has been raised by Arnd or
> Geert, so I kinda only have a couple of small comments for you here.
>
> On Thu, Mar 30, 2023 at 09:42:12PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Currently, selecting which CMOs to use on a given platform is done usin=
g
> > and ALTERNATIVE_X() macro. This was manageable when there were just two
> > CMO implementations, but now that there are more and more platforms com=
ing
> > needing custom CMOs, the use of the ALTERNATIVE_X() macro is unmanageab=
le.
> >
> > To avoid such issues this patch switches to use of function pointers
> > instead of ALTERNATIVE_X() macro for cache management (the only drawbac=
k
> > being performance over the previous approach).
> >
> > void (*clean_range)(unsigned long addr, unsigned long size);
> > void (*inv_range)(unsigned long addr, unsigned long size);
> > void (*flush_range)(unsigned long addr, unsigned long size);
>
> So, given Arnd has renamed the generic helpers, should we use the
> writeback/invalidate/writeback & invalidate terminology here too?
> I think it'd be nice to make the "driver" functions match the generic
> implementations's names (even though that means not making the
> instruction naming).
>
> > The above function pointers are provided to be overridden for platforms
> > needing CMO.
> >
> > Convert ZICBOM and T-HEAD CMO to use function pointers.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v6->v7
> > * Updated commit description
> > * Fixed build issues when CONFIG_ERRATA_THEAD_CMO=3Dn
> > * Used static const struct ptr to register CMO ops
> > * Dropped riscv_dma_noncoherent_cmo_ops
>
> > * Moved ZICBOM CMO setup to setup.c
>
> Why'd you do that?
> What is the reason that the Zicbom stuff cannot live in
> dma-noncoherent.[ch] and only expose, say:
> void riscv_cbom_register_cmo_ops(void)
> {
>         riscv_noncoherent_register_cache_ops(&zicbom_cmo_ops);
> }
> which you then call from setup.c?
>
Commit abcc445acd ("riscv: move riscv_noncoherent_supported() out of
ZICBOM probe) moved the zicbom the setup to setup.c hence I moved the
CMO stuff here. Said that, now I am defaulting to zicbom ops so I have
mode the functions to dma-noncoherent.c  .

> > v5->v6
> > * New patch
> > ---
> >  arch/riscv/errata/thead/errata.c         | 76 ++++++++++++++++++++++++
> >  arch/riscv/include/asm/dma-noncoherent.h | 73 +++++++++++++++++++++++
> >  arch/riscv/include/asm/errata_list.h     | 53 -----------------
> >  arch/riscv/kernel/setup.c                | 49 ++++++++++++++-
> >  arch/riscv/mm/dma-noncoherent.c          | 25 ++++++--
> >  arch/riscv/mm/pmem.c                     |  6 +-
> >  6 files changed, 221 insertions(+), 61 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
>
> > +#ifdef CONFIG_RISCV_ISA_ZICBOM
> > +
> > +#define ZICBOM_CMO_OP(_op, _start, _size, _cachesize)                 =
               \
> > +     asm volatile("mv a0, %1\n\t"                                     =
       \
> > +                  "j 2f\n\t"                                          =
       \
> > +                  "3:\n\t"                                            =
       \
> > +                  CBO_##_op(a0)                                       =
       \
> > +                  "add a0, a0, %0\n\t"                                =
       \
> > +                  "2:\n\t"                                            =
       \
> > +                  "bltu a0, %2, 3b\n\t"                               =
       \
> > +                  : : "r"(_cachesize),                                =
       \
> > +                      "r"((unsigned long)(_start) & ~((_cachesize) - 1=
UL)),  \
> > +                      "r"((unsigned long)(_start) + (_size))          =
       \
> > +                  : "a0")
> > +
> > +static void zicbom_cmo_clean_range(unsigned long addr, unsigned long s=
ize)
> > +{
> > +     ZICBOM_CMO_OP(clean, addr, size, riscv_cbom_block_size);
> > +}
> > +
> > +static void zicbom_cmo_flush_range(unsigned long addr, unsigned long s=
ize)
> > +{
> > +     ZICBOM_CMO_OP(flush, addr, size, riscv_cbom_block_size);
> > +}
> > +
> > +static void zicbom_cmo_inval_range(unsigned long addr, unsigned long s=
ize)
> > +{
> > +     ZICBOM_CMO_OP(inval, addr, size, riscv_cbom_block_size);
> > +}
> > +
> > +const struct riscv_cache_ops zicbom_cmo_ops =3D {
> > +     .clean_range =3D &zicbom_cmo_clean_range,
> > +     .inv_range =3D &zicbom_cmo_inval_range,
> > +     .flush_range =3D &zicbom_cmo_flush_range,
> > +};
> > +
> > +static void zicbom_register_cmo_ops(void)
> > +{
> > +     riscv_noncoherent_register_cache_ops(&zicbom_cmo_ops);
> > +}
> > +#else
> > +static void zicbom_register_cmo_ops(void) {}
> > +#endif
>
> I think all of the above should be prefixed with riscv_cbom to match the
> other riscv_cbom stuff we already have.
Just to clarify, the riscv_cbom prefix should just be applied to the
ZICOM functions and not to T-HEAD?

Cheers,
Prabhakar
