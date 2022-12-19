Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B93650D39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiLSOZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiLSOZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:25:35 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE8D1115B;
        Mon, 19 Dec 2022 06:25:29 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bj12so21760102ejb.13;
        Mon, 19 Dec 2022 06:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xYRfbzPEZUDqYHBHO2OONlQoVvt/nOvN/sUxnF9qyWo=;
        b=e9zsbwpgQOJThMSZty56tbhvsX9S6xNi/odqIIFmFXTISKtp5Diio3LBrw28QKJrNt
         xVGQ0jBrPNQFjLyJu109uRPbbo3bwr8SLyIpr7ScEAhKWT0rXqH0IsZ7MjRP8IqjmWsZ
         YnG27KxDFme0jxss425KS02McA/bvwNRqwwl7cFVB/U5hUw3lbwba8MV4Lcz/FHr2DIv
         Gco4gh1UsBUUT8Qq2Mk4HlQ6TopteGaVT0mKR+Q9AewEW7T2kk3s6ue2WqnP5lqLXkQc
         zxFPinfQUtAQ8zaolbAw7sKprMDAr0K5fC9G1h807l19FNab1POxWJXGBwfk+5LDweQG
         KnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYRfbzPEZUDqYHBHO2OONlQoVvt/nOvN/sUxnF9qyWo=;
        b=jRcpeWvaVbJ9h+mF0SAmmK3zdDqbMckiWquRQ58QBUyw8b0Iat9FritBOIysdGr4b6
         NxFf03TqYXmkNWMoXRw/lkt0mZXCBM5DIsbBMTRDmSH1ovWH9cj4ao1uCTHQ8u88p0ue
         RNchMr+QWAle32Gmf/rPpLODpvB97ZTio2vtq2Uz6EhvWZXRG0c8yq7QK2lSQP/NFMKu
         bjc8bTGPJHK/N06d94+f2s0zO8v2d5DCZHatGYVBk1hMFCys7J7oMhUeb8VlkuN5Inq5
         XL7ON7qrhr7HYxTXvxi7e007/NVTD4esbtHKvtIUefEnZ9rGQOj3FZ9I+lAXn6Ykk9+w
         P3jA==
X-Gm-Message-State: ANoB5pmaKPGUW22hqnrY7Wp76VRXJ3o3SItA2SVxzxKSAN0OxV1ePBos
        +H9F6eqEJONnsHX7LZv1ZLxO5qmEIBo2A/yMLbrETnyJOhNO+acA
X-Google-Smtp-Source: AA0mqf4sYmFVPDPZVaDcYXIU6+c12nNnA9tI2uhf4e4+Q1z3PHZyLOqyAStEhWTGWMryL6CJJIVxbfCPwD9VsoOUbfI=
X-Received: by 2002:a17:906:3e41:b0:78d:bc9f:33da with SMTP id
 t1-20020a1709063e4100b0078dbc9f33damr80717346eji.80.1671459928389; Mon, 19
 Dec 2022 06:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV46aMfqu+kMW9E-RURugK-giOx0k-NPe5XX4nxKZJzkg@mail.gmail.com>
 <CA+V-a8uqQ2fK1UjRT864jyHdt6Z47V=iARSJC6B2M6Gikms=Eg@mail.gmail.com>
 <CA+V-a8sGLrsRWFi3-hNmB=Uj-aCQLD5VQesmUFb8N1NAqhyLuQ@mail.gmail.com> <CAMuHMdW_QuBUUypyrAbLqWPdZ81bWeYDyPbBf=2KmDht1X44bA@mail.gmail.com>
In-Reply-To: <CAMuHMdW_QuBUUypyrAbLqWPdZ81bWeYDyPbBf=2KmDht1X44bA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Dec 2022 14:25:01 +0000
Message-ID: <CA+V-a8uQFiU2KRcsoC5--tjfuWRj3VRJAUaZtv0+U0DziZQOwg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Mon, Dec 19, 2022 at 1:50 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Dec 19, 2022 at 1:57 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Fri, Nov 18, 2022 at 12:29 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Thu, Nov 17, 2022 at 10:54 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Document RZ/G2UL (R9A07G043) IRQC bindings. The RZ/G2UL IRQC block is
> > > > > identical to one found on the RZ/G2L SoC. No driver changes are
> > > > > required as generic compatible string "renesas,rzg2l-irqc" will be
> > > > > used as a fallback.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > > > > Note, renesas,r9a07g043u-irqc is added we have slight difference's compared to RZ/Five
> > > > > - G2UL IRQCHIP (hierarchical IRQ domain) -> GIC where as on RZ/Five we have PLIC (chained interrupt
> > > > > domain) -> RISCV INTC
> > > >
> > > > I think this difference is purely a software difference, and abstracted
> > > > in DTS through the interrupt hierarchy.
> > > > Does it have any impact on the bindings?
> > > >
> > > > > - On the RZ/Five we have additional registers for IRQC block
> > > >
> > > > Indeed, the NMI/IRQ/TINT "Interruput" Mask Control Registers, thus
> > > > warranting separate compatible values.
> > > >
> > > > > - On the RZ/Five we have BUS_ERR_INT which needs to be handled by IRQC
> > > >
> > > > Can you please elaborate? I may have missed something, but to me it
> > > > looks like that is exactly the same on RZ/G2UL and on RZ/Five.
> > > >
> > > Now that we have to update the binding doc with the BUS_ERR_INT too,
> > > do you think it would make sense to add interrupt-names too?
>
> > Gentle ping.
>
> Thanks for the ping, I had missed you were waiting on input from me.
> Sorry for that...
>
No worries.

> As there are three different groups of parent interrupts, adding
> interrupt-names makes sense.
Ok.

> However, as this binding is already in active use since v6.1, you
> probably need to keep on supporting the
> ack of interrupt-names.  Or do you think there are no real users yet,
> and we can drop support for that?
>
Sorry can you please elaborate on "ack of interrupt-names".

So moving forward the driver will first check for interrupt-names
property and if that exists it will map the IRQ0-7 and GPIO-TINIT
interrupts (based on the names it will create a hierarchy domain) and
for the NMI and BUS_ERR_INT we request the IRQ numbers and register
the IRQ handler in IRQC driver itself.

And for backward compatibility we parse the IRQ numbers based on
indexes i.e. 0 = NMI, 1-8  = IRQ 0-7  and 9-41 GPIO TINT interrupts.

> > > BUS_ERR_INT will have to be handled IRQC itself (i.e. IRQC will
> > > register a handler for it).
>
> Do you mean you will need a fourth parent type for that?
>
No something like what we have for NMI we can add something similar
below for bus error interrupts:
interrupts = ....
              <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
interrupt-names = ....,
             "bus-error-int";

As the registers to handle the NMI and BUS_ERR_INT are present on the
IRQC block, the interrupt handler will have to be registered by the
IRQC block itself by requesting the IRQ. So we will have to skip
mapping of BUS_ERR_INT as we do for the NMI case. Does that make
sense?

Cheers,
Prabhakar
