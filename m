Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED5637F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKXTP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKXTPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:15:24 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A487A5D;
        Thu, 24 Nov 2022 11:15:23 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ho10so6001766ejc.1;
        Thu, 24 Nov 2022 11:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWeAC6tVqoQ6bNA7whBca/Z25C/J+Qx03REs2nGyD7A=;
        b=lPSQbOINQxMXT+unJ0mshlxYmnlkNXq1M658zJNMI6XNi60l8MdT4SqaAKByvLexEt
         L81yxMT3JA8b+ku9YUOab8bjrQ2S+DwYX3DjsefZzvwKHDZmFpeE50l8/w32qvrAZiYg
         efhZr0c7YGbjYQ+3Fo6cayGSIU1jEE1BzjGmqxBhZUXYrkx2+8ryQCKl5ICk4VWI0gzj
         HqUjUHKvYS8KLqPa5rwwfFKBD7FKmZtC8USRuA09eXEZ94+GQFoi+3QIT1gPfRhI3OGT
         HDPbFqPKnCeTSKFT7/c+e5G7ph6Dg3pGl7/7ArPE4gHQ6LakyEiq/74acw0OnlB+JW2w
         1V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWeAC6tVqoQ6bNA7whBca/Z25C/J+Qx03REs2nGyD7A=;
        b=M6RaW5eBVZBTIwYLLjYs4V5toYH37YmaqEkARqMbx1g4AsM+E6hQRDHWXpRc/84LDy
         q2e/OLtsu5wM2p52D4GrOelAioDZppBOJ1Lyypd3rguTP+LM6un+YhTDLIMfsP7+vv2M
         6gA+9rRPgSr64qW1joAAknzW0YaauUg4a9ZNBnzq2XhFMoGDz3Ci2vnR/qraCaeIz5Rx
         ojSgEmKx5IitYunl60A4ZvQimebUq2NJK4FydLVY75Ubf+vHuA2E4xOBPxLNedS3HgXP
         JeFDqISlykshxFGVxTFXjIChbEp0NUr1aXKd851PATJRoP1jkLzKEwrS2FeWX06K3+Fm
         S19g==
X-Gm-Message-State: ANoB5pnV7e4US6WoWRBogqdgATVo/PcFZ2qt0F5TIopserpvSWVxhp+F
        l0XeAs+aWDYYXSYP/h9GxYkWvFsYmVhbD85TtfQ=
X-Google-Smtp-Source: AA0mqf5ok9xKhUigClOCzJ/g0cQ1rY0k5p19eoRhweDVXGsjFwjIINpC/tel64cTzP0N5/jVCdXGqfEtPHiuLf8z7zE=
X-Received: by 2002:a17:906:79c4:b0:778:e3e2:8311 with SMTP id
 m4-20020a17090679c400b00778e3e28311mr14512080ejo.342.1669317321518; Thu, 24
 Nov 2022 11:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <4542837.QJadu78ljV@diego>
In-Reply-To: <4542837.QJadu78ljV@diego>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 24 Nov 2022 19:14:54 +0000
Message-ID: <CA+V-a8uB8LVc4rPehYOYM2OKa4hW2TPegB2zmm5xV-ZcznqNQA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] riscv: errata: Add Andes alternative ports
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Thank you for the review.

On Thu, Nov 24, 2022 at 6:25 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 24. November 2022, 18:22:03 CET schrieb Prabhakar:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add required ports of the Alternative scheme for Andes CPU cores.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > RFC v3 -> v4
> > * New patch
> > ---
>
> > diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> > index a1055965fbee..81828e80f6dc 100644
> > --- a/arch/riscv/errata/Makefile
> > +++ b/arch/riscv/errata/Makefile
> > @@ -1,2 +1,3 @@
> >  obj-$(CONFIG_ERRATA_SIFIVE) +=3D sifive/
> >  obj-$(CONFIG_ERRATA_THEAD) +=3D thead/
> > +obj-$(CONFIG_ERRATA_ANDES) +=3D andes/
>
> alphabetical sorting please
>
>
> > diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes=
/errata.c
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
> > +static bool errata_probe_iocp(unsigned int stage, unsigned long arch_i=
d, unsigned long impid)
> > +{
> > +     if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
> > +             return false;
> > +
> > +     if (arch_id !=3D 0x8000000000008a45 || impid !=3D 0x500)
> > +             return false;
> > +
> > +     riscv_cbom_block_size =3D 1;
>
> as this is mainly to make the core cbo code happy, maybe add a comment
> above that line to explain.
>
Agreed, I'll add a comment here.

>
> > +     riscv_noncoherent_supported();
> > +
> > +     return true;
> > +}
> > +
>
> > diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/=
asm/alternative.h
> > index 6511dd73e812..d8012af30cbd 100644
> > --- a/arch/riscv/include/asm/alternative.h
> > +++ b/arch/riscv/include/asm/alternative.h
> > @@ -46,6 +46,9 @@ void sifive_errata_patch_func(struct alt_entry *begin=
, struct alt_entry *end,
> >  void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry=
 *end,
> >                            unsigned long archid, unsigned long impid,
> >                            unsigned int stage);
> > +void andes_errata_patch_func(struct alt_entry *begin, struct alt_entry=
 *end,
> > +                          unsigned long archid, unsigned long impid,
> > +                          unsigned int stage);
>
> again alphabetical please (i.e. above sifive)
>
>
> > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/=
asm/errata_list.h
> > index 4180312d2a70..2ba7e6e74540 100644
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -9,6 +9,11 @@
> >  #include <asm/csr.h>
> >  #include <asm/vendorid_list.h>
> >
> > +#ifdef CONFIG_ERRATA_ANDES
> > +#define ERRATA_ANDESTECH_NO_IOCP     0
> > +#define ERRATA_ANDESTECH_NUMBER              1
> > +#endif
> > +
> >  #ifdef CONFIG_ERRATA_SIFIVE
> >  #define      ERRATA_SIFIVE_CIP_453 0
> >  #define      ERRATA_SIFIVE_CIP_1200 1
> > diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/altern=
ative.c
> > index a7d26a00beea..4ded3e9aa3bc 100644
> > --- a/arch/riscv/kernel/alternative.c
> > +++ b/arch/riscv/kernel/alternative.c
> > @@ -47,6 +47,11 @@ static void __init_or_module riscv_fill_cpu_mfr_info=
(struct cpu_manufacturer_inf
> >       case THEAD_VENDOR_ID:
> >               cpu_mfr_info->patch_func =3D thead_errata_patch_func;
> >               break;
> > +#endif
> > +#ifdef CONFIG_ERRATA_ANDES
> > +     case ANDESTECH_VENDOR_ID:
> > +             cpu_mfr_info->patch_func =3D andes_errata_patch_func;
> > +             break;
>
> and again alphabetical please
>
Oops I missed that, I'll sort this and all the above.

Cheers,
Prabhakar
