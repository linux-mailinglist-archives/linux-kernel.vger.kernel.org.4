Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE1650AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiLSLPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiLSLPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:15:48 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2524F1C;
        Mon, 19 Dec 2022 03:15:45 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u19so20609462ejm.8;
        Mon, 19 Dec 2022 03:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sULm/S6ctvHgsxCE9dNljDGGzik1S/Aj6TzzkY/co2Q=;
        b=Cg5hiCoT38OhoJ6Bne97SPV5T/4u55mVWC85pj/w41gRATbSBW+BUAKeaNWUWtNzCY
         qnwhZAhlI/7cnvViPw/bfzsFbUvba1ok93/1qDUBoN8/NDl2eaMur26PD4munFHSY0Q7
         ikAl4FerrTytdL0z81UCCwL/P0v3xPeXiYAW3KiQeXAkL69pxnlbRlSyx84sCAL4SrlF
         Sqh16rHAVd9JZg4OBxGFfFldJALBHIvMY9cg5d536PmFhNrZRZn/XBUXnWOIE1CyD9UZ
         CEZjBkJTXjP4DTSgN5//ygeM5NOlnOmZ10tUV+sThLbF4VYGkzTZZqEe/TTVSwsrKjTa
         oeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sULm/S6ctvHgsxCE9dNljDGGzik1S/Aj6TzzkY/co2Q=;
        b=0g74H0qnuTP36rGki1IrnyLv4wV07EYV99HnqL7gx73dNG/IaIG002fBJNBsuI4N2M
         9pVJULUJ7jpGjLEO3aOFa6cpQ2IUDkAgnFssRW7ufYalbQnq7ixP2gMgrEGWTiADJpWL
         JNEK0g+WUDX1MgizguVNuCAwzgudDpdG+7j92eGikP/5/UHwZTCVG78UxZ+AhNzq5A9z
         Iz5l3IbICh/+6hWs1Z5PFSE3i2z+F+YhEUtSnAx6h3Rg4Kk/9PX7ceO4tr2tWFx1mxgW
         jWvYs2065k5AiHU6/XNYkg+PxIo+L+1tlGPBEnWLmT7Qb4dupLV2yyIfYCNii7LaE6L4
         Ie5g==
X-Gm-Message-State: ANoB5plF2gz/9Mef2l5tn6UTy7bNQNHL6SWsEK+hLg4+f4OWyqTpxHfy
        BfwUE5b6YDphV+daDmWRKzVMpLzvXy7wcEv0y1Y=
X-Google-Smtp-Source: AA0mqf6DSq68HqwwXjoJBjzLaxcy23gNleXYuq16vF5JPGyGgRZfsMM7aZQjJaDzh/QNNHekgnhbEGhA3xhTXdp3SqQ=
X-Received: by 2002:a17:906:9615:b0:7c0:f459:a0e4 with SMTP id
 s21-20020a170906961500b007c0f459a0e4mr16004795ejx.155.1671448544424; Mon, 19
 Dec 2022 03:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y543kM4070CSDtZi@spud>
In-Reply-To: <Y543kM4070CSDtZi@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Dec 2022 11:15:17 +0000
Message-ID: <CA+V-a8ss0idLDoc+J8-Undqd+DUGrpeytenzSxV8xMs2N3dh1g@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Sat, Dec 17, 2022 at 9:41 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Mon, Dec 12, 2022 at 11:55:00AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Introduce ALTERNATIVE_3() macro.
> >
> > A vendor wants to replace an old_content, but another vendor has used
> > ALTERNATIVE_2() to patch its customized content at the same location.
> > In this case, this vendor can use macro ALTERNATIVE_3() and then replace
> > ALTERNATIVE_2() with ALTERNATIVE_3() to append its customized content.
> >
> > While at it update comment above ALTERNATIVE_2() macro and make it generic
> > so that the comment holds good for any new addition of ALTERNATIVE_X()
> > macros.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v4->v5
> > * Rebased the patch on top of Andrew's series (now in Palmers for next-branch)
> > * Updated comment for ALTERNATIVE_x() as suggested by Heiko
> >
> > RFC v3 -> v4
> > * New patch
> > ---
> >  arch/riscv/include/asm/alternative-macros.h | 46 ++++++++++++++++++---
> >  1 file changed, 41 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> > index 7226e2462584..a5b4691520da 100644
> > --- a/arch/riscv/include/asm/alternative-macros.h
> > +++ b/arch/riscv/include/asm/alternative-macros.h
> > @@ -50,8 +50,17 @@
> >       ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
> >  .endm
> >
> > +.macro ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
> > +                             new_c_2, vendor_id_2, errata_id_2, enable_2,    \
> > +                             new_c_3, vendor_id_3, errata_id_3, enable_3
> > +       ALTERNATIVE_CFG_2 \old_c, \new_c_1, \vendor_id_1, \errata_id_1, \enable_1,    \
> > +                                 \new_c_2, \vendor_id_2, \errata_id_2, \enable_2
> > +       ALT_NEW_CONTENT \vendor_id_3, \errata_id_3, \enable_3, \new_c_3
> > +.endm
> > +
> >  #define __ALTERNATIVE_CFG(...)               ALTERNATIVE_CFG __VA_ARGS__
> >  #define __ALTERNATIVE_CFG_2(...)     ALTERNATIVE_CFG_2 __VA_ARGS__
> > +#define __ALTERNATIVE_CFG_3(...)     ALTERNATIVE_CFG_3 __VA_ARGS__
> >
> >  #else /* !__ASSEMBLY__ */
> >
> > @@ -98,6 +107,13 @@
> >       __ALTERNATIVE_CFG(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1)   \
> >       ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)
> >
> > +#define __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1,      \
> > +                                new_c_2, vendor_id_2, errata_id_2, enable_2, \
> > +                                new_c_3, vendor_id_3, errata_id_3, enable_3) \
> > +     __ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
> > +                                   new_c_2, vendor_id_2, errata_id_2, enable_2)      \
> > +     ALT_NEW_CONTENT(vendor_id_3, errata_id_3, enable_3, new_c_3)
> > +
> >  #endif /* __ASSEMBLY__ */
> >
> >  #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k)       \
> > @@ -108,6 +124,13 @@
> >       __ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLED(CONFIG_k_1),   \
> >                                  new_c_2, vendor_id_2, errata_id_2, IS_ENABLED(CONFIG_k_2))
> >
> > +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, CONFIG_k_1,             \
> > +                               new_c_2, vendor_id_2, errata_id_2, CONFIG_k_2,                \
> > +                               new_c_3, vendor_id_3, errata_id_3, CONFIG_k_3)                \
> > +     __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLED(CONFIG_k_1),   \
> > +                                new_c_2, vendor_id_2, errata_id_2, IS_ENABLED(CONFIG_k_2),   \
> > +                                new_c_3, vendor_id_3, errata_id_3, IS_ENABLED(CONFIG_k_3))
> > +
> >  #else /* CONFIG_RISCV_ALTERNATIVE */
> >  #ifdef __ASSEMBLY__
> >
> > @@ -152,15 +175,28 @@
> >       _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
> >
> >  /*
> > - * A vendor wants to replace an old_content, but another vendor has used
> > - * ALTERNATIVE() to patch its customized content at the same location. In
> > - * this case, this vendor can create a new macro ALTERNATIVE_2() based
> > - * on the following sample code and then replace ALTERNATIVE() with
> > - * ALTERNATIVE_2() to append its customized content.
> > + * ALTERNATIVE_x macros allow providing multiple replacement options
> > + * for an ALTERNATIVE code section. This is helpful if multiple
> > + * implementation variants for the same functionality exist for
> > + * different cpu cores.
>
> I think this last sentence should be:
> "This is helpful if multiple implementation variants exist for the same
> functionality."
> I don't think CPU cores is the right level of "granularity".
>
Ok, I'll update it as above.

> > + *
> > + * Usage:
> > + *   ALTERNATIVE_x(old_content,
> > + *      new_content1, vendor_id1, errata_id1, CONFIG_k1,
> > + *      new_content2, vendor_id2, errata_id2, CONFIG_k2,
> > + *      ...
> > + *      new_contentx, vendor_idx, errata_idx, CONFIG_kx)
> >   */
> >  #define ALTERNATIVE_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,              \
> >                                  new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)         \
> >       _ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,    \
> >                                       new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)
> >
> > +#define ALTERNATIVE_3(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,              \
> > +                                new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2,         \
> > +                                new_content_3, vendor_id_3, errata_id_3, CONFIG_k_3)         \
> > +       _ALTERNATIVE_CFG_3(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,  \
> > +                                       new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2,  \
> > +                                       new_content_3, vendor_id_3, errata_id_3, CONFIG_k_3)
>
> btw, why is this indented with spaces when the line above it is indented
> with tabs? (At least, that is how it appears in mutt).
>
I'll update it with spaces.

> With those minor bits & the suggested fixes from Drew/Geert:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
Cheers,
Prabhakar
