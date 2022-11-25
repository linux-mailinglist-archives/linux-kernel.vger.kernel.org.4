Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516AC638712
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKYKIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKYKIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:08:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6053A1D0FF;
        Fri, 25 Nov 2022 02:08:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r26so3633212edc.10;
        Fri, 25 Nov 2022 02:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LW+tamRHbjP1mfqbA3Ded0ngAklCtatsu4yoSddFO8c=;
        b=TA54suU8YpDsgwK+gCYNC1hnRxH/GXp5jshHxJFpA2ZeQYIq345/e0qRfmJmeuJBM6
         uZTk4HvkQowFDjP9Om3gj78PNhHXT1jpWAfUtpq4h6KnOjDqc+l+0QhrtBlPvaDvejJg
         PTkxVTGXu9CuXPBHNVT8G0Qv1Wk6x2GD7v6oNMS0KkDxWWprmz91SOXjp1I8z8Jrv2SQ
         Vnio8BQXhijH6HaPELKvoKcQPvwJBtVBGjZwH8Yipi4EJnKKzagnJwxyoJtFxk/vRgzx
         ZZ9v28PfthRlOfH6A4j7mCTxFGpR01pQG2rHC8ILpPECe6tI8OpGJ5/xQg6uOxghEKrL
         3png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LW+tamRHbjP1mfqbA3Ded0ngAklCtatsu4yoSddFO8c=;
        b=fsXQ0UMt+KGdcvK5IZNwqPhjJqpleiA2AxJLjd7B/fYujclGgngE0mC9IeXvBg01Ez
         3gfE846GpJ9zByz02TvE06lectuipzvdu/+L7CFnzDZFm3IA317n/gHYwqr0CIbecPPA
         VNFXlH9s/H0Q4GZRGnqAg2W2fLWh/XHASwmZfJt6fpOhpkZnOQHXlOvy8haikg02ji6c
         DMmJ0wxBijpYvGJYZaxLQLTYJO3M3i71+eb647XWXSyw+w8Ei85kiAg7VBwnzkijk02M
         eUvu2BNn3zvl03vdSGjOebyoJUpQOpEaXG/TEMd8EgNaLdSihqUTOYk7qGpWIzPZFp11
         HVmw==
X-Gm-Message-State: ANoB5pnusPeuDqModK3+h0aOl+tTHWRF2MXqTNNCX47LIv8RC98univG
        rHeTYCoGIbnogxpJYFOWE6EbEyWH/HYn/xzLUKs=
X-Google-Smtp-Source: AA0mqf4b5LchYvnEyBXJafepREoQx51r3HyOSAelZFgx98WKe8rtMye2xP54PO+EREtz7Qs/WaF6DOR5mbCt+BneGR8=
X-Received: by 2002:a05:6402:530b:b0:461:f919:caa4 with SMTP id
 eo11-20020a056402530b00b00461f919caa4mr34465411edb.255.1669370907771; Fri, 25
 Nov 2022 02:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y3/SZPjzXsd8dfkl@spud>
In-Reply-To: <Y3/SZPjzXsd8dfkl@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Nov 2022 10:08:01 +0000
Message-ID: <CA+V-a8ucDPnbnuVz+yfLtB=mhsBL9Rr9Aa7zg+rQ3sfu_5kyJw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] riscv: errata: Add Andes alternative ports
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
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

Hi Conor,

Thank you for the review.

On Thu, Nov 24, 2022 at 8:22 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Thu, Nov 24, 2022 at 05:22:03PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add required ports of the Alternative scheme for Andes CPU cores.
>
> You've got a lot of nice info in your cover letter that would be nice in
> the git history. Could you add some of the commentary about why the
> Andes cache needs special handling from there to this commit message
> please?
>
Sure, I'll update the commit message here.

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > RFC v3 -> v4
> > * New patch
> > ---
> >  arch/riscv/Kconfig.erratas           | 22 +++++++++
> >  arch/riscv/errata/Makefile           |  1 +
> >  arch/riscv/errata/andes/Makefile     |  1 +
> >  arch/riscv/errata/andes/errata.c     | 68 ++++++++++++++++++++++++++++
> >  arch/riscv/include/asm/alternative.h |  3 ++
> >  arch/riscv/include/asm/errata_list.h |  5 ++
> >  arch/riscv/kernel/alternative.c      |  5 ++
> >  7 files changed, 105 insertions(+)
> >  create mode 100644 arch/riscv/errata/andes/Makefile
> >  create mode 100644 arch/riscv/errata/andes/errata.c
>
> > diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
> > new file mode 100644
> > index 000000000000..ec3e052ca8c7
> > --- /dev/null
> > +++ b/arch/riscv/errata/andes/errata.c
> > @@ -0,0 +1,68 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Erratas to be applied for Andes CPU cores
> > + *
> > + *  Copyright (C) 2022 Renesas Electronics Corporation.
> > + *
> > + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +
> > +#include <asm/alternative.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/errata_list.h>
> > +#include <asm/patch.h>
> > +#include <asm/vendorid_list.h>
> > +
> > +static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
>
> To the lay reader, what's an "iocp" when it's at home? "I/O coherency
> port"? Again, commit message would be a good place for the introduction
> of that term :)
>
Agree, I'll update that.

> > +{
> > +     if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
> > +             return false;
> > +
> > +     if (arch_id != 0x8000000000008a45 || impid != 0x500)
>
> Can you #define these?
>
> > +             return false;
> > +
> > +     riscv_cbom_block_size = 1;
> > +     riscv_noncoherent_supported();
> > +
> > +     return true;
> > +}
> > +
> > +static u32 andes_errata_probe(unsigned int stage, unsigned long archid, unsigned long impid)
> > +{
> > +     u32 cpu_req_errata = 0;
> > +
>
> I read some code and when it does the opposite of what I'd expect, I
> feel inclined to add a comment. In this case, you're probing for the
> presence of the port `probe_iocp()`, but the interesting case is when
> you don't find it. You can leave it uncommented if you like, but even
> something like the below I think fits.
>
>         /*
>          * In the absence of the I/O Coherency Port, access to certain peripherals
>          * requires vendor specific DMA handling.
>          */
Makes sense, I'll include the above.

> > +     if (errata_probe_iocp(stage, archid, impid))
> > +             cpu_req_errata |= BIT(ERRATA_ANDESTECH_NO_IOCP);
> > +
> > +     return cpu_req_errata;
> > +}
> > +
> > +void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> > +                                           unsigned long archid, unsigned long impid,
> > +                                           unsigned int stage)
> > +{
> > +     u32 cpu_req_errata = andes_errata_probe(stage, archid, impid);
> > +     struct alt_entry *alt;
> > +     u32 tmp;
> > +
> > +     if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> > +             return;
> > +
> > +     for (alt = begin; alt < end; alt++) {
> > +             if (alt->vendor_id != ANDESTECH_VENDOR_ID)
> > +                     continue;
> > +             if (alt->errata_id >= ERRATA_ANDESTECH_NUMBER)
> > +                     continue;
> > +
> > +             tmp = (1U << alt->errata_id);
>
> Is this not BIT(alt->errata_id)?
>
Yep, I will switch to BIT().

Cheers,
Prabhakar
