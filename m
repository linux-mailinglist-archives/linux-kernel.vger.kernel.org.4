Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E91E6D1E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjCaKiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjCaKh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:37:58 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B88E4C13;
        Fri, 31 Mar 2023 03:37:57 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j6so11287648ilr.7;
        Fri, 31 Mar 2023 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680259076; x=1682851076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUiku2B78vEOH052ZN8XRaDAeW3h69Wsq5FDDUf//oM=;
        b=pI4yOYgL0ekEvp5y5Rs1jD0v72Hknn+4BAAYXJkuwySgS/8eGcwVLC4LpnaxmuiJAT
         DLBYCIN0PyuqrWohQKXduCRG3pf5ukRTeyIomgnHuTfKKpml+JUeK5DP/qAhxZ0rkRQX
         Mi3aP2yTG/n7rUFEpYFyi0ipMNAHtKAzbNQZHGNrxf6f7RT64DmKckmKF/Nf7JfrZk01
         KVZrYHsbfciCXovvxRAzNWArcSLE+ZtjiAdDubFTHLmh7HS50/b1WUl5H1k251GGiC0v
         DgDtAp6/4OoiHzAcoEcxiXMFVxUc5OZRvC1UKTpJiCdAlQOhIHX4X7ZJh3Sb/KbBVUv4
         xq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680259076; x=1682851076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUiku2B78vEOH052ZN8XRaDAeW3h69Wsq5FDDUf//oM=;
        b=UPH7Lsp4R2bnPR8COc4NbObJvAK02yL5AIGFeQV5+7wWlspLtjH1ESDI0yWyojDjSL
         ju0UUtqqDj7ebQulg+oUvGcfxljkzElRdjRpaawuAekA+U2+Bf5qzUrFD5E1nd+R70Ik
         HHqj5cXo16zjQEilXzwdgaE2Vyek51C9rW31VAchqgFJv4ex4SC6wSR7gRiQBB9gpKay
         MRWF9Y76hKZD/ozhXQtb9GvY47PuwjFqLwsnY/7pFypm/f7CYhykqudcC+OdqbQl4tDp
         kEk5sqyyBYnZ8hfW4/GNYnDFAavjK4KVSLcS7cHqJ3aQQoLPDkynLO9KN4KKMMSqbmbl
         87BQ==
X-Gm-Message-State: AAQBX9fgBIVG3OOLwnpiLy8+M1/INKRHVcI+bkkpYYReKtNIFUIogPFD
        ywT9Q2C/ij53s4/wPPid57OFNuhvCIg4TYvocEM=
X-Google-Smtp-Source: AKy350b+1wX54SGQACYQNp6bcyF5SliWY7u6rIqm1x12bFKcs3OKgJfvcculvD/olhBqGwByiFqeZeHcBWEJpYVDD2w=
X-Received: by 2002:a05:6e02:180f:b0:325:dae2:4238 with SMTP id
 a15-20020a056e02180f00b00325dae24238mr6073826ilv.2.1680259076444; Fri, 31 Mar
 2023 03:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <6ca5941a-8803-477d-8b40-17292decc5af@app.fastmail.com>
In-Reply-To: <6ca5941a-8803-477d-8b40-17292decc5af@app.fastmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 31 Mar 2023 11:37:30 +0100
Message-ID: <CA+V-a8tkiDXG37YjFKPxrGoXVQMVBemMdBcfb+uUDzBofOWH_A@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Arnd,

Thank you for the review.

On Thu, Mar 30, 2023 at 10:34=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Thu, Mar 30, 2023, at 22:42, Prabhakar wrote:
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
> >
> > The above function pointers are provided to be overridden for platforms
> > needing CMO.
> >
> > Convert ZICBOM and T-HEAD CMO to use function pointers.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This is looking pretty good. There are a few things that I
> still see sticking out, and I think I've mentioned some of
> them before, but don't remember if there was a reason for
> doing it like this:
>
> > +#ifdef CONFIG_ERRATA_THEAD_CMO
>
> I would rename this to not call this an 'ERRATA' but
> just make it a driver. Not important though, and there
> was probably a reason you did it like this.
>
As agreed, we will keep this as is.

> > +extern struct riscv_cache_ops noncoherent_cache_ops;
> > +
> > +void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops
> > *ops);
> > +
> > +static inline void riscv_dma_noncoherent_clean(void *vaddr, size_t
> > size)
> > +{
> > +     if (noncoherent_cache_ops.clean_range) {
> > +             unsigned long addr =3D (unsigned long)vaddr;
> > +
> > +             noncoherent_cache_ops.clean_range(addr, size);
> > +     }
> > +}
>
> The type case should not be necessary here. Instead I would
> make the callbacks use 'void *' as well, not 'unsigned long'.
>
Ok, I'll update this on using void *

> It's possible that some future cache controller driver requires
> passing physical addresses, as is common for last level cache,
> but as long as all drivers pass virtual addresses, it's easier
> to do the phys_to_virt() in common code.
>
Agreed.

> It also seems wrong to have the fallback be to do nothing
> when the pointer is NULL, since that cannot actually work
> when a device is not cache coherent.
>
If the device is non cache coherent and if it doesn't support ZICBOM
ISA extension the device won't work anyway. So non-cache coherent
devices until they have their CMO config enabled won't work anyway. So
I didn't see any benefit in enabling ZICBOM by default. Please let me
know if I am misunderstanding.

> I would either initialize the function pointer to the
> zicbom version and remove the NULL check, or keep the
> pointer NULL and have an explicit
> 'else zicbom_clean_range()' fallback.
>
> > +static void zicbom_register_cmo_ops(void)
> > +{
> > +     riscv_noncoherent_register_cache_ops(&zicbom_cmo_ops);
> > +}
> > +#else
> > +static void zicbom_register_cmo_ops(void) {}
> > +#endif
>
> As far as I recall, the #else path here was needed previously
> to work around a binutils dependency, but with the current
> code, it should be possible to just always enable
> CONFIG_RISCV_ISA_ZICBOM when RISCV_DMA_NONCOHERENT is used.
>
Are you suggesting something like below?

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4dadf35ac721..a55dee98ccf8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -242,6 +242,7 @@ config RISCV_DMA_NONCOHERENT
        select ARCH_HAS_SYNC_DMA_FOR_CPU
        select ARCH_HAS_SYNC_DMA_FOR_DEVICE
        select DMA_DIRECT_REMAP
+       select RISCV_ISA_ZICBOM

 config AS_HAS_INSN
        def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma)
t0$(comma) t0$(comma) zero)
@@ -465,7 +466,6 @@ config RISCV_ISA_ZICBOM
        depends on MMU
        depends on RISCV_ALTERNATIVE
        default y
-       select RISCV_DMA_NONCOHERENT
        help
           Adds support to dynamically detect the presence of the ZICBOM
           extension (Cache Block Management Operations) and enable its

But what if the platform doesn't have the ZICBOM ISA extension?

Cheers,
Prabhakar
