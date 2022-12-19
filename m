Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4750650DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiLSOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiLSOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:47:14 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC2A6316;
        Mon, 19 Dec 2022 06:47:02 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id x11so8308127qtv.13;
        Mon, 19 Dec 2022 06:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKHY9P32m8mgAHA8zC+eLfMybd3edFH7KlvoI0D1D6w=;
        b=yjqbcP0kb1U9Q52/fNXaP/l2a1evSM6vwOXVFHMc2OxQ9Ldtdemnn3k4d/lz/v4hz8
         zQ84fL2uq50VkDWzbe77PfUimkat8ayAeLOw/PQ7IJt7O/+96BuXetuyjobGfRsAsiMP
         4Z/wG9nv7vX5HZv0CSATPvCL4CNXT4wIarRClxarTZHQ3O+4832tKMOsn9hUbyDXNThe
         LbQRlvty1GfMvTXsYV77j2Q/mFFNZkMnoZAWOhxkrVC1U4+EEsHN/aj7fCHSt/M85xKY
         jgY2r5VXr/ZB4xNWHntqzNVNS4ry/vOki83djczxd0plHuNoaFVKGx1x6sZc2XDNvy4X
         RC5g==
X-Gm-Message-State: ANoB5pnu297nz9o75/XHEnLZxSzQ7FpBrHUXIHn8g4hkO643++tHzzBk
        MRSYNbaOJ1Rt82IpP+jTk2+IH6mRYl3sVA==
X-Google-Smtp-Source: AA0mqf7nSFaluLYdxRTxxYekVmSkLmL5ndtc8GSVDm46qOuXfLRV7bsezW8v6KMpv03l6sE8YdpP0Q==
X-Received: by 2002:ac8:7949:0:b0:3a8:991:bfa5 with SMTP id r9-20020ac87949000000b003a80991bfa5mr49813575qtt.44.1671461221336;
        Mon, 19 Dec 2022 06:47:01 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id g22-20020a05620a40d600b006fa7b5ea2d1sm7185375qko.125.2022.12.19.06.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 06:47:00 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 186so9668798ybe.8;
        Mon, 19 Dec 2022 06:47:00 -0800 (PST)
X-Received: by 2002:a25:7204:0:b0:6f0:9ff5:1151 with SMTP id
 n4-20020a257204000000b006f09ff51151mr67152949ybc.543.1671461220397; Mon, 19
 Dec 2022 06:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV46aMfqu+kMW9E-RURugK-giOx0k-NPe5XX4nxKZJzkg@mail.gmail.com>
 <CA+V-a8uqQ2fK1UjRT864jyHdt6Z47V=iARSJC6B2M6Gikms=Eg@mail.gmail.com>
 <CA+V-a8sGLrsRWFi3-hNmB=Uj-aCQLD5VQesmUFb8N1NAqhyLuQ@mail.gmail.com>
 <CAMuHMdW_QuBUUypyrAbLqWPdZ81bWeYDyPbBf=2KmDht1X44bA@mail.gmail.com> <CA+V-a8uQFiU2KRcsoC5--tjfuWRj3VRJAUaZtv0+U0DziZQOwg@mail.gmail.com>
In-Reply-To: <CA+V-a8uQFiU2KRcsoC5--tjfuWRj3VRJAUaZtv0+U0DziZQOwg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Dec 2022 15:46:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWROUWd0eQXrjx2pUVs2AtvRvu7spbpGWf5EDumemetcw@mail.gmail.com>
Message-ID: <CAMuHMdWROUWd0eQXrjx2pUVs2AtvRvu7spbpGWf5EDumemetcw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Dec 19, 2022 at 3:26 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, Dec 19, 2022 at 1:50 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Dec 19, 2022 at 1:57 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Fri, Nov 18, 2022 at 12:29 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Thu, Nov 17, 2022 at 10:54 AM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > > On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Document RZ/G2UL (R9A07G043) IRQC bindings. The RZ/G2UL IRQC block is
> > > > > > identical to one found on the RZ/G2L SoC. No driver changes are
> > > > > > required as generic compatible string "renesas,rzg2l-irqc" will be
> > > > > > used as a fallback.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > > > > > Note, renesas,r9a07g043u-irqc is added we have slight difference's compared to RZ/Five
> > > > > > - G2UL IRQCHIP (hierarchical IRQ domain) -> GIC where as on RZ/Five we have PLIC (chained interrupt
> > > > > > domain) -> RISCV INTC
> > > > >
> > > > > I think this difference is purely a software difference, and abstracted
> > > > > in DTS through the interrupt hierarchy.
> > > > > Does it have any impact on the bindings?
> > > > >
> > > > > > - On the RZ/Five we have additional registers for IRQC block
> > > > >
> > > > > Indeed, the NMI/IRQ/TINT "Interruput" Mask Control Registers, thus
> > > > > warranting separate compatible values.
> > > > >
> > > > > > - On the RZ/Five we have BUS_ERR_INT which needs to be handled by IRQC
> > > > >
> > > > > Can you please elaborate? I may have missed something, but to me it
> > > > > looks like that is exactly the same on RZ/G2UL and on RZ/Five.
> > > > >
> > > > Now that we have to update the binding doc with the BUS_ERR_INT too,
> > > > do you think it would make sense to add interrupt-names too?
> >
> > > Gentle ping.
> >
> > Thanks for the ping, I had missed you were waiting on input from me.
> > Sorry for that...
> >
> No worries.
>
> > As there are three different groups of parent interrupts, adding
> > interrupt-names makes sense.
> Ok.
>
> > However, as this binding is already in active use since v6.1, you
> > probably need to keep on supporting the
> > ack of interrupt-names.  Or do you think there are no real users yet,
> > and we can drop support for that?
> >
> Sorry can you please elaborate on "ack of interrupt-names".

Oops, s/ack/lack/. I.e. what you described below.

> So moving forward the driver will first check for interrupt-names
> property and if that exists it will map the IRQ0-7 and GPIO-TINIT
> interrupts (based on the names it will create a hierarchy domain) and
> for the NMI and BUS_ERR_INT we request the IRQ numbers and register
> the IRQ handler in IRQC driver itself.
>
> And for backward compatibility we parse the IRQ numbers based on
> indexes i.e. 0 = NMI, 1-8  = IRQ 0-7  and 9-41 GPIO TINT interrupts.

Exactly.

> > > > BUS_ERR_INT will have to be handled IRQC itself (i.e. IRQC will
> > > > register a handler for it).
> >
> > Do you mean you will need a fourth parent type for that?
> >
> No something like what we have for NMI we can add something similar
> below for bus error interrupts:
> interrupts = ....
>               <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
> interrupt-names = ....,
>              "bus-error-int";

Hence a fourth name?

1. legacy index  0 -> "nmi"
2. legacy indices 1-8 -> "irq%u" (0-7)
3. legacy indices 9-41 -> "tint%u" (0-31)
4. (not supported) -> "bus-error-int" (or "bus-err"?)

> As the registers to handle the NMI and BUS_ERR_INT are present on the
> IRQC block, the interrupt handler will have to be registered by the
> IRQC block itself by requesting the IRQ. So we will have to skip
> mapping of BUS_ERR_INT as we do for the NMI case. Does that make
> sense?

OK.

BTW, that means RZG2L_NMI from <dt-bindings/interrupt-controller/irqc-rzg2l.h>
will never be used?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
