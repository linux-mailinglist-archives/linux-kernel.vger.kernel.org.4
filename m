Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A966D1E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjCaKqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjCaKqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:46:12 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC39E1CBAB;
        Fri, 31 Mar 2023 03:46:07 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id v5so8739277ilj.4;
        Fri, 31 Mar 2023 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680259567; x=1682851567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxMlaJ1BeHGbxg9ofgk7r/BRvhmnDYafcE/OU7JSLC0=;
        b=Qc4g4T+XpHTgRWXtYwjBB3pEehUDlAB0PvzisZQX3EB7mUc3aylnHHWfve+EIYHERp
         SQKbLgQCUfH6uM/PkFTphZnJkjoLpzcitEMB1mrizlsNZpe6gfpkEq1Y5JUEK79qO+6r
         Ol1pNhJnxR8QiUK12f8BEfM2ty6e12eq/iXi7GSpPiiFB1uCHsIefuM/kqIH+ov+fjhP
         fLQVSe2034LIv168HD0BeyThA98ov1Eyb3BUgJ91tA6AtdGqPQPArCp2xw4sezdNBeZp
         /zf/E7WHpPNWviXjaSy6R5mMTORn8PYe0EYpeOpzs8SLRLeuR5Ts79oVeKeB2H8b4F0x
         5k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680259567; x=1682851567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxMlaJ1BeHGbxg9ofgk7r/BRvhmnDYafcE/OU7JSLC0=;
        b=UJxE0r5r6qx/UKkxgcMKIXpq98CdPNftLE1PEtTi3xMIm1ZPg/R0tQ8+4DBTlE7a/v
         hZBWor1aM2iBQGefWpI50r75AAyhpR+U1iUaca6wY63W0qTMfE7m070Y/3qox4biAM20
         u8GGGIEHY8UJtRtrQFmHJpxhrYJx5yizHY+VFStHivDwCYdEVQd2g6zCx7DXGHJ8ie+O
         9Oynq5ZEQ0r8ZVuLHZap/5U895LUL5Dr3Kuwix04Q6FKsaJ6GmDbbDp9zI1YWmP11uCT
         1t6zZBf/tn/pvFbe2HwqlRvoakghk6xbiHKrT9+FXJgLnotSU5m2zTAXuD+E/xqTD+fQ
         PI2w==
X-Gm-Message-State: AAQBX9cJx8p6/RAs2LKKmyhvZPBP+Vv6qwTi8Wdq8CNuQQnQlRXFV3TL
        azXwllGtQY4oOkxa/E1Sq0dy+1e8bxK/GOhKIBE=
X-Google-Smtp-Source: AKy350aWf54kGpalGeRTLVEMORyDKMQIYATUQVwCoZMfvPGkoQeKkXMORDvUHOKDdT4eai4vmBUDXFdEEp04Tc/inCU=
X-Received: by 2002:a05:6e02:180f:b0:325:dae2:4238 with SMTP id
 a15-20020a056e02180f00b00325dae24238mr6085691ilv.2.1680259566978; Fri, 31 Mar
 2023 03:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVseMfkQw5OnTM4CxW9BUCZ0pVZP6px67h8VPah0x3QAA@mail.gmail.com>
In-Reply-To: <CAMuHMdVseMfkQw5OnTM4CxW9BUCZ0pVZP6px67h8VPah0x3QAA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 31 Mar 2023 11:45:40 +0100
Message-ID: <CA+V-a8v8UDQUtNkhYeLHE_t8dNzYEddAwB0a5AdX04pD2VS9pA@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
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

Hi Geert,

Thank you for the review.

On Fri, Mar 31, 2023 at 8:31=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Thu, Mar 30, 2023 at 10:42=E2=80=AFPM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Currently, selecting which CMOs to use on a given platform is done usin=
g
> > and ALTERNATIVE_X() macro. This was manageable when there were just two
>
> the ALTERNATIVE_X()
>
OK.

> > CMO implementations, but now that there are more and more platforms com=
ing
> > needing custom CMOs, the use of the ALTERNATIVE_X() macro is unmanageab=
le.
> >
> > To avoid such issues this patch switches to use of function pointers
>
> "the use" or "using"
>
OK.

> > instead of ALTERNATIVE_X() macro for cache management (the only drawbac=
k
>
> the ALTERNATIVE_X()
>
OK.

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
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
>
> > +#ifdef CONFIG_ERRATA_THEAD_CMO
>
> > +static void thead_register_cmo_ops(void)
> > +{
> > +       riscv_noncoherent_register_cache_ops(&thead_cmo_ops);
> > +}
> > +#else
> > +static void thead_register_cmo_ops(void) {}
> > +#endif
>
> > --- a/arch/riscv/mm/dma-noncoherent.c
> > +++ b/arch/riscv/mm/dma-noncoherent.c
>
> > @@ -75,3 +83,12 @@ void riscv_noncoherent_supported(void)
> >              "Non-coherent DMA support enabled without a block size\n")=
;
> >         noncoherent_supported =3D true;
> >  }
> > +
> > +void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops=
 *ops)
> > +{
> > +       if (!ops)
> > +               return;
>
> This is never true.
I just wanted to add a sanity check.

> I guess originally you wanted to call riscv_noncoherent_register_cache_op=
s()
> unconditionally from common code, instead of the various *register_cmo_op=
s()?
> But that would have required something like
>
> #ifdef CONFIG_ERRATA_THEAD_CMO
> #define THEAD_CMO_OPS_PTR   (&thead_cmo_ops)
> #else
> #define THEAD_CMO_OPS_PTR   NULL
> #endif
>
riscv_noncoherent_register_cache_ops() will only be called if the
ISA/Errata needs to be applied so I'll drop this check.

Cheers,
Prabhakar
