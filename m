Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C662164BB65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiLMRus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbiLMRuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:50:22 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6217B23BD8;
        Tue, 13 Dec 2022 09:50:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vv4so38416932ejc.2;
        Tue, 13 Dec 2022 09:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8Te+90Me7/DNYLPITblwKP6ief4DtrmuQhpnuDMS7U=;
        b=Q/ccRBM54iGaMR0IPvniv4srFLJhIy4+mj2F/jaqSwhIAU1D15nqC+B6n+80uwSGEb
         b/rzjFeTMIwuy8Dh0olaztxosTG8WXMoPpYrAguxYQroEyTe7kCnmiQeYl4LraWXtk/d
         UuILSPSfLNxntm2DoE+TWxjQ39otbf1t8Ei/dOcQSmSJJT2njZFAZslU9i5rIH/exG8q
         1vCN1s/20src/cIITU9innMymBL5VDIAUPiR49sbNmgmv32OhQ920GgppUdqsnE0xkC2
         WLFfs0OM6v24OUZ8m0Hf9bJDrvQUn6FmjoSlGbTVlJS+mLPbUA+xwbweBB7QKID1BK0e
         5YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8Te+90Me7/DNYLPITblwKP6ief4DtrmuQhpnuDMS7U=;
        b=x9XjQX9PYLZzQvYSE7tt5CPN3JCaxKdM5qh3N26/QPrTCa9HYn3hP/8A51kXasqATh
         Wi0PsDPy3HQQMb02eX1SpcM486NoNxTXLns1oHyeHaKcaWJnqayStoqnfo1WCFx8GG1V
         2yz4Nbno2NPa95iW2VvseSibNwy9dgyg99CWxSFIoOBe6PScKFAVD35wPdp+nBp0x8RV
         3r9rndPzldsts59l8yP3/nq5+r/0MBSxvJPRhhw5ziTLrpR2nqxFMUY7MN7u188V6+j2
         4PeyfbSr2z+107R5o2d/z/STwd8snT5S4Hht7sS/dn2ZkerBk5Vg1zOJABsVLrLGQSYc
         Rq8A==
X-Gm-Message-State: ANoB5plHu8DIGp/hPTeu4q2rSwExhMdmniAWg6jAh0FnofbgP66gCYEt
        GKleTq2xahcDWiLTxrNg9cxKJOktZo8ADIoqKSc=
X-Google-Smtp-Source: AA0mqf6yr4V5eqVv903blKuzHqJwxMbngwRZQLWei/lpeJdIbxZ/byCj1cPbuB7C5GwaJ79ieqB+ow5quffMIpms0NI=
X-Received: by 2002:a17:906:5156:b0:7c0:efb6:8744 with SMTP id
 jr22-20020a170906515600b007c0efb68744mr16980605ejc.267.1670953798879; Tue, 13
 Dec 2022 09:49:58 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXXXN9g8o1j7k-TC=F-kuyf-KngFSKi7z9z0SY9BLxmHA@mail.gmail.com>
In-Reply-To: <CAMuHMdXXXN9g8o1j7k-TC=F-kuyf-KngFSKi7z9z0SY9BLxmHA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 13 Dec 2022 17:49:32 +0000
Message-ID: <CA+V-a8s9iAtFVzdA4R_tSMuBTkoY3JmZ12MJw__Pgfyetsz34g@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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

Hi Geert,

Thank you for the review.

On Tue, Dec 13, 2022 at 5:21 PM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> Hi Prabhakar,
>
> On Mon, Dec 12, 2022 at 12:58 PM Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Introduce ALTERNATIVE_3() macro.
> >
> > A vendor wants to replace an old_content, but another vendor has used
> > ALTERNATIVE_2() to patch its customized content at the same location.
> > In this case, this vendor can use macro ALTERNATIVE_3() and then replac=
e
> > ALTERNATIVE_2() with ALTERNATIVE_3() to append its customized content.
> >
> > While at it update comment above ALTERNATIVE_2() macro and make it gene=
ric
> > so that the comment holds good for any new addition of ALTERNATIVE_X()
> > macros.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v4->v5
> > * Rebased the patch on top of Andrew's series (now in Palmers for next-=
branch)
> > * Updated comment for ALTERNATIVE_x() as suggested by Heiko
>
> Thanks for the update!
>
> > --- a/arch/riscv/include/asm/alternative-macros.h
> > +++ b/arch/riscv/include/asm/alternative-macros.h
> > @@ -50,8 +50,17 @@
> >         ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
> >  .endm
> >
> > +.macro ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1, ena=
ble_1,   \
> > +                               new_c_2, vendor_id_2, errata_id_2, enab=
le_2,    \
> > +                               new_c_3, vendor_id_3, errata_id_3, enab=
le_3
> > +       ALTERNATIVE_CFG_2 \old_c, \new_c_1, \vendor_id_1, \errata_id_1,=
 \enable_1,      \
> > +                                 \new_c_2, \vendor_id_2, \errata_id_2,=
 \enable_2
> > +       ALT_NEW_CONTENT \vendor_id_3, \errata_id_3, \enable_3, \new_c_3
> > +.endm
> > +
> >  #define __ALTERNATIVE_CFG(...)         ALTERNATIVE_CFG __VA_ARGS__
> >  #define __ALTERNATIVE_CFG_2(...)       ALTERNATIVE_CFG_2 __VA_ARGS__
> > +#define __ALTERNATIVE_CFG_3(...)       ALTERNATIVE_CFG_3 __VA_ARGS__
> >
> >  #else /* !__ASSEMBLY__ */
> >
> > @@ -98,6 +107,13 @@
> >         __ALTERNATIVE_CFG(old_c, new_c_1, vendor_id_1, errata_id_1, ena=
ble_1)   \
> >         ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)
> >
> > +#define __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, =
enable_1,        \
> > +                                  new_c_2, vendor_id_2, errata_id_2, e=
nable_2, \
> > +                                  new_c_3, vendor_id_3, errata_id_3, e=
nable_3) \
> > +       __ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, e=
nable_1, \
> > +                                   new_c_2, vendor_id_2, errata_id_2, =
enable_2)        \
> > +       ALT_NEW_CONTENT(vendor_id_3, errata_id_3, enable_3, new_c_3)
> > +
> >  #endif /* __ASSEMBLY__ */
> >
> >  #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k)=
 \
> > @@ -108,6 +124,13 @@
> >         __ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, I=
S_ENABLED(CONFIG_k_1),   \
> >                                    new_c_2, vendor_id_2, errata_id_2, I=
S_ENABLED(CONFIG_k_2))
> >
> > +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, C=
ONFIG_k_1,               \
> > +                                 new_c_2, vendor_id_2, errata_id_2, CO=
NFIG_k_2,                \
> > +                                 new_c_3, vendor_id_3, errata_id_3, CO=
NFIG_k_3)                \
> > +       __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, I=
S_ENABLED(CONFIG_k_1),   \
> > +                                  new_c_2, vendor_id_2, errata_id_2, I=
S_ENABLED(CONFIG_k_2),   \
> > +                                  new_c_3, vendor_id_3, errata_id_3, I=
S_ENABLED(CONFIG_k_3))
> > +
> >  #else /* CONFIG_RISCV_ALTERNATIVE */
>
> To avoid breaking the build for K210 (and VexRiscv), you need to provide
> _ALTERNATIVE_CFG_3() for the !CONFIG_RISCV_ALTERNATIVE case, too:
>
Thanks for testing this.

> @@ -144,6 +144,9 @@
>  #define _ALTERNATIVE_CFG_2(old_c, ...) \
>         ALTERNATIVE_CFG old_c
>
> +#define _ALTERNATIVE_CFG_3(old_c, ...) \
> +       ALTERNATIVE_CFG old_c
> +
>  #else /* !__ASSEMBLY__ */
>
>  #define __ALTERNATIVE_CFG(old_c)       \
> @@ -155,6 +158,9 @@
>  #define _ALTERNATIVE_CFG_2(old_c, ...) \
>         __ALTERNATIVE_CFG(old_c)
>
> +#define _ALTERNATIVE_CFG_3(old_c, ...) \
> +       __ALTERNATIVE_CFG(old_c)
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* CONFIG_RISCV_ALTERNATIVE */
>
> Else it fails (on riscv/for-next) with:
>
I'll include the above hunk in next version.

> arch/riscv/mm/pmem.c: In function =E2=80=98arch_wb_cache_pmem=E2=80=99:
> arch/riscv/include/asm/alternative-macros.h:198:8: error: expected
> string literal before =E2=80=98_ALTERNATIVE_CFG_3=E2=80=99
>   198 |        _ALTERNATIVE_CFG_3(old_content, new_content_1,
> vendor_id_1, errata_id_1, CONFIG_k_1, \
>       |        ^~~~~~~~~~~~~~~~~~
> arch/riscv/include/asm/errata_list.h:128:14: note: in expansion of
> macro =E2=80=98ALTERNATIVE_3=E2=80=99
>   128 | asm volatile(ALTERNATIVE_3(      \
>       |              ^~~~~~~~~~~~~
> arch/riscv/mm/pmem.c:13:2: note: in expansion of macro =E2=80=98ALT_CMO_O=
P=E2=80=99
>    13 |  ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size, 0, 0);
>       |  ^~~~~~~~~~
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
