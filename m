Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3455F638909
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiKYLps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYLpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:45:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1233319001;
        Fri, 25 Nov 2022 03:45:46 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fy37so9716690ejc.11;
        Fri, 25 Nov 2022 03:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WnWzpuk7Fe04fSZwbn2NzRu+EG7+nGTvMdlTedNh0so=;
        b=McOLIbuYjtbFO9iH9lHO/kmEoDMrqzPqVJEVvJFx4PuARS9AbXt6aq0iSRM0ATX+5r
         Vt4stcYtUUyKLQtjs6M7lTzQzhS0tbGW6fi3m+/kEJlFmhjGTl5krD2tNdN/Ib5gO1Sc
         RCFEs7XGlB7bUck/Yz6rfhTi4CCulEtRv0aS8J6X97r75Jm8QvVrAGLiLw2gRvFnR5ey
         3p68n7bt7DqQ9bT+SIn9m0IG5gX7O2zTzc6NaJ0qm6VtJP9Xq0fVKh7kZQPvzQ2HFHXm
         u83UQe7J91Bo0IcuoxSSRu91MLJR6MZ8wJx2tdy/sh6axSX0stwnZ5gnFp8wtptXbfsu
         YL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnWzpuk7Fe04fSZwbn2NzRu+EG7+nGTvMdlTedNh0so=;
        b=kyHOoB0gUKw1Q9For/JB1lE3/NfdGuvuUI8O648Nxrc8xC40jLoBi1ZguePae9myBt
         VHP5Nkbv1ivW+7oDVO5VMDQBQbZtniShGKT5Ex42AcpzSca2fIKdxw/1wcpowJLj/5tE
         aqCyQL52ZC7trZ0/7BsxVMglc/ShKdlSrNBUDL0IhzkUHGETCcp6mwXtl61bZNfqkwk0
         YH7Kz19336nWZgyWyrx4kJBha5ae/N/XIA2C9o3xKsIhpeYk+68GKE4oznzjePRbyHU4
         1ndMxk0huZ+78dwzs26OJXJRX96hRK6iTRb6tXDFdONj7SgXVk0DfOdNRPG1Z1yCyx1b
         BAQg==
X-Gm-Message-State: ANoB5pnyL57fhzeXadDEWuAyMTMEV7xKbWVcQgidkmuSD5X+pMTjwhzM
        31mihOdM8Q8+oDdqCHZAyKczAZOaz7y4vvHLykA=
X-Google-Smtp-Source: AA0mqf7IubZa1gVPfYiGD5E7i0Jzn7mDxMJIH5SkqjavpTlcvWOw33JXPhHjOAy06Ubt0XOI8dVwKtbv1bbqWy/TyF0=
X-Received: by 2002:a17:907:7650:b0:781:e568:294f with SMTP id
 kj16-20020a170907765000b00781e568294fmr17649629ejc.447.1669376744514; Fri, 25
 Nov 2022 03:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <70d1bfde-f57f-1741-08d3-23e362793595@linaro.org> <CA+V-a8s2awLp=YvbhA1Ohe500Oh1easLUcG9V4_FWov7Pf2i6g@mail.gmail.com>
 <CAMuHMdXktJWskc8m-hL75gfkkkZnqsiuraAG+wPjWcs2JZpGKA@mail.gmail.com>
In-Reply-To: <CAMuHMdXktJWskc8m-hL75gfkkkZnqsiuraAG+wPjWcs2JZpGKA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Nov 2022 11:45:17 +0000
Message-ID: <CA+V-a8ui9vyLC7_PdwCdeSsOujFPuJ8LU3WeV4uOKpjcphhaWQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Nov 25, 2022 at 11:18 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> , Hi Prabhakar,
>
> On Fri, Nov 25, 2022 at 11:34 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Fri, Nov 25, 2022 at 8:16 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 24/11/2022 18:22, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> > > >
> > > > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > > > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > > > describes the L2 cache block.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > RFC v3 -> v4
> > > > * Dropped l2 cache configuration parameters
> > > > * s/larger/large
> > > > * Added minItems/maxItems for andestech,pma-regions
>
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
>
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > > +    #include <dt-bindings/cache/andestech,ax45mp-cache.h>
> > > > +
> > > > +    cache-controller@2010000 {
> > > > +        reg = <0x13400000 0x100000>;
> > > > +        compatible = "andestech,ax45mp-cache", "cache";
> > > > +        interrupts = <508 IRQ_TYPE_LEVEL_HIGH>;
> > > > +        cache-line-size = <64>;
> > > > +        cache-level = <2>;
> > > > +        cache-sets = <1024>;
> > > > +        cache-size = <262144>;
> > > > +        cache-unified;
> > > > +        andestech,pma-regions = <0x58000000 0x08000000
> > > > +                                 (AX45MP_PMACFG_ETYP_NAPOT | AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
> > > > +    };
> > > > diff --git a/include/dt-bindings/cache/andestech,ax45mp-cache.h b/include/dt-bindings/cache/andestech,ax45mp-cache.h
> > > > new file mode 100644
> > > > index 000000000000..aa1cad24075d
> > > > --- /dev/null
> > > > +++ b/include/dt-bindings/cache/andestech,ax45mp-cache.h
> > > > @@ -0,0 +1,38 @@
> > > > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > > > +/*
> > > > + * This header provides constants for Andes AX45MP PMA configuration
> > > > + *
> > > > + * Copyright (C) 2022 Renesas Electronics Corp.
> > > > + */
> > > > +
> > > > +#ifndef __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H
> > > > +#define __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H
> > > > +
> > > > +/* OFF: PMA entry is disabled */
> > > > +#define AX45MP_PMACFG_ETYP_DISABLED                  0
> > > > +/* Naturally aligned power of 2 region */
> > > > +#define AX45MP_PMACFG_ETYP_NAPOT                     3
> > > > +
> > > > +/* Device, Non-bufferable */
> > > > +#define AX45MP_PMACFG_MTYP_DEV_NON_BUF                       (0 << 2)
> > > > +/* Device, bufferable */
> > > > +#define AX45MP_PMACFG_MTYP_DEV_BUF                   (1 << 2)
> > > > +/* Memory, Non-cacheable, Non-bufferable */
> > > > +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF     (2 << 2)
> > > > +/* Memory, Non-cacheable, Bufferable */
> > > > +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF         (3 << 2)
> > >
> > > What are all these? They don't look like flags, because 3 = 1 | 2...
> > > they don't look like constants, because we do not use shifts in
> > > constants. Are these some register values? I also do not see the header
> > > being used in the code, so why having a bindings header if it is not
> > > used (DTS is not usage...)?
> > >
> > These are register bit values for the MTYP[5:2] field. The DTS example
> > in the binding doc (above) uses these macros. I haven't included the
> > DTS/I patches with this patchset yet do think I should?
>
> I think the main objection from Rob is that these look too much like
> raw register values to be written unchanged to registers, which is
> frowned upon in DT.
>
> Now, can we make this more generic?
>
>   1. Do you need AX45MP_PMACFG_ETYP_DISABLED, i.e. will it ever be
>      specified in DTS, or is this a pure software thing?
>   2. Obviously you can let the driver decide if AX45MP_PMACFG_ETYP_NAPOT
>      can be set, based on address/size?
>   3. If the two above are removed, the shifts can be handled in the
>      driver instead,
Yes we can get rid of AX45MP_PMACFG_ETYP_DISABLED and
AX45MP_PMACFG_ETYP_NAPOT. If we are setting up the PMA region it
always has to be a power of 2. So AX45MP_PMACFG_ETYP_NAPOT can be
passed either from the driver or in the OpenSBI just OR it while
setting up the PMA.


>   4. Are there existing (more generic) definitions that can be used
>      instead?
>
You mean for the MTYP flags? I haven't come across any in the kernel.

> BTW, what's the difference between non-bufferable and non-cacheable?
>
non-cacheable, from the Andes manual: Accessing to non-cacheable
memory and device will bypass I-Cache, D-Cache and L2-Cache no matter
the data is cached or not. The cache states are not changed by these
accesses.

TBH I dont have a clear answer for non-bufferable nor do we have in
the Andes HW manual. I'll get the details from Andes.

Cheers,
Prabhakar
