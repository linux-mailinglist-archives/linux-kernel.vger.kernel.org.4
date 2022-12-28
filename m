Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238FA6587EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiL1Xg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL1Xgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:36:54 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963FE13DFA;
        Wed, 28 Dec 2022 15:36:53 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id c124so18931851ybb.13;
        Wed, 28 Dec 2022 15:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gm5dF1TCz05P7Iy/oXiMOgKCZdzl0vuE+lOSnhvhB1I=;
        b=m23rT/oTev+19JERS5Q1QW0yplRprnZiJSp7MFMa8u9ysgZ7AvSFxd7hcTT9rmzne7
         QzV9sqpc84Eq1NKtsU9ZFTMlXn0xshmm5ZxNyhZMl6zLnTwbupw+t5RK2wT1m80DhqS6
         DID2TW+CtcNN1HRN3pdDtnqnd04EztZTFkRIumES1r/PV8bh/db8HN5KGnIFnYGiNSfP
         nAIcTWD4o+zR1rjyKW36m7RU+aM0tdzJFeK0qe4U+B2hqS/fGmquic3N9O/CuT+LovBT
         9/BPISI+flnVPexwPxFXH8dK4Stpba0YEeeEM/wIUhAXC4ksTgARmZaiLrButW03dOie
         MIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gm5dF1TCz05P7Iy/oXiMOgKCZdzl0vuE+lOSnhvhB1I=;
        b=Vh53pHD4Csz0iTCtDKaH4CKImCpAdzrtUCxx2c4ibUK8sYkXgUV7+JcmrLNVui+Im1
         JFaSJ9e2uV+WDRI9a3OqFItEZkLPlsTdlm8k/9QxdZqlsbdx4tz0LXas/IYvYR9X+iAv
         KxoJqatB8K8Q9ker4yodvLG2Q0N5jzXHM5xMeJFB+klafitCheKLvbt5PQDc4dTjOky/
         dDCBflFZZRnNVo/MJmYZo8nWWcoLCoefVZQ0KbgG3a7EQHbcw4hf9iUkh53GlANnaj6B
         gPuuwkuXMzSNGNDk/TAkaeDDBu8moKycFcj1+6z28PcC44VrDDvRGhmCip5BQFBb4X/c
         7cOg==
X-Gm-Message-State: AFqh2krEcNcRAicY8muaNPUOrrkrrpoD4OtgE86b3hEn++P7b7YVHv/o
        CbgH3PJulXKrSQJHNfOpO/F7kldK54NRv/Oivsk=
X-Google-Smtp-Source: AMrXdXth9uqLygFz5q+Ml/vbHiYDL95C6DJSssRFAvIg51n4np68SQvY3Gq+HgqtEKPZjRPzByrKnVthisS02KGmHIE=
X-Received: by 2002:a25:5506:0:b0:768:6ae8:df82 with SMTP id
 j6-20020a255506000000b007686ae8df82mr2467006ybb.398.1672270612800; Wed, 28
 Dec 2022 15:36:52 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221221000242.340202-10-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV1UAF0Pgk6omcLz6-kHLD6xnMFDN-UJ2ge_bhoD7rAcw@mail.gmail.com>
In-Reply-To: <CAMuHMdV1UAF0Pgk6omcLz6-kHLD6xnMFDN-UJ2ge_bhoD7rAcw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 28 Dec 2022 23:36:26 +0000
Message-ID: <CA+V-a8sFV+vqXN8mA4c8wKe15chcZKsiZf1gCdcc+ZoFWtNGtw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] arm64: dts: renesas: rzg2ul-smarc-som: Add PHY
 interrupt support for ETH{0/1}
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
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

Thank you for the review.

On Tue, Dec 27, 2022 at 1:02 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Dec 21, 2022 at 1:04 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ7 for ETH0 and
> > ETH1 respectively.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
> > @@ -6,6 +6,7 @@
> >   */
> >
> >  #include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/irqc-rzg2l.h>
> >  #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
> >
> >  / {
> > @@ -77,6 +78,8 @@ phy0: ethernet-phy@7 {
> >                 compatible = "ethernet-phy-id0022.1640",
> >                              "ethernet-phy-ieee802.3-c22";
> >                 reg = <7>;
> > +               interrupt-parent = <&irqc>;
>
> Note that arch/riscv/boot/dts/renesas/r9a07g043f.dtsi does not have
> the irqc node yet, so I cannot take this as-is.
>
Agreed, is it OK if we temporarily add the (above+below) properties in
the boards DTS and once we have full fledged support for RZ/Five we
move it back to the SoM DTSi (as done in this patch)?

Cheers,
Prabhakar

> > +               interrupts = <RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
> >                 rxc-skew-psec = <2400>;
> >                 txc-skew-psec = <2400>;
> >                 rxdv-skew-psec = <0>;
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
