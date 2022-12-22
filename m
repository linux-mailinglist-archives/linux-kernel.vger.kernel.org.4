Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924CB653CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbiLVITe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiLVITb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:19:31 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511BE101C6;
        Thu, 22 Dec 2022 00:19:30 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id h10so818867qvq.7;
        Thu, 22 Dec 2022 00:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMmfHUYc7ijR6hdADXh8O3NMov5DfuOpW26VTuf213g=;
        b=G7iufXoW54xSvthzqr+3y3wgxQbr3lDveMvCoduyIVYcn9b4Cg4I+TcNr+PMkWZh/s
         m/aN098BMsm3UPZa33963FuAn2pztHalco1dWE7HhMCovhWWVOB3C8CHRkBHilWvU1z8
         1Ni/0sE+CAANhKEeaQ0ibfIu+zSENR1etWSBbZtMy2kUAwM0pvelJ3wfjJOIBPvvxQTt
         voht23L3YzX8y3R5V9TnoRSVAY/I5YhEoG0n/bAvMnKOleEM78xK22BrxMCD8mAi40vp
         LRXFaX4f9Ko5JMqBO/p6KlJOTzc4j3ENgU3T/pM3l98rbvS+AavRmRhiby8rZCn5/Yyq
         hCaQ==
X-Gm-Message-State: AFqh2koCYHTEV04NyuCd7G5tQI8YZDUWMJ6jeJOycNE5bK1xttg00AB5
        CC+pYUne3xSl4F3RC4HsEJjMf0o2hGIU0Q==
X-Google-Smtp-Source: AMrXdXuMuHw41LNCyCvcauLAmzjXyf9yRJ0wH8piUqai+QC5g7ax5FjCLtVhWqCGQWtPwqbEdg8W6g==
X-Received: by 2002:a0c:fc48:0:b0:4e1:bb55:1d8d with SMTP id w8-20020a0cfc48000000b004e1bb551d8dmr6718811qvp.44.1671697169176;
        Thu, 22 Dec 2022 00:19:29 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id s5-20020a05620a254500b006f9f714cb6asm12296746qko.50.2022.12.22.00.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 00:19:28 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-45ef306bd74so18287057b3.2;
        Thu, 22 Dec 2022 00:19:28 -0800 (PST)
X-Received: by 2002:a0d:ca4d:0:b0:38e:e541:d8ca with SMTP id
 m74-20020a0dca4d000000b0038ee541d8camr307319ywd.283.1671697168114; Thu, 22
 Dec 2022 00:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221221000242.340202-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXmKYV7CwuD=ZNgaOTc+LxP9OvEJ8gcW_iS5NamTxEE+w@mail.gmail.com> <CA+V-a8tqvY+Nj391j+zJO21Q=47pyFR1SkDLH-hmJephcorY3g@mail.gmail.com>
In-Reply-To: <CA+V-a8tqvY+Nj391j+zJO21Q=47pyFR1SkDLH-hmJephcorY3g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 22 Dec 2022 09:19:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDbfadxJsrEvQMwQKvxtBxQRA_Bx4+FY90N9v_XVirOA@mail.gmail.com>
Message-ID: <CAMuHMdXDbfadxJsrEvQMwQKvxtBxQRA_Bx4+FY90N9v_XVirOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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

On Wed, Dec 21, 2022 at 10:06 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Dec 21, 2022 at 12:37 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, Dec 21, 2022 at 1:03 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Document RZ/G2UL (R9A07G043U) IRQC bindings. The IRQC block on RZ/G2UL SoC
> > > is almost identical to one found on the RZ/G2L SoC the only difference
> > > being it can support BUS_ERR_INT for which it has additional registers.
> > > Hence new generic compatible string "renesas,rzg2ul-irqc" is added for
> > > RZ/G2UL SoC.
> > >
> > > Now that we have additional interrupt for RZ/G2UL and RZ/Five SoC
> > > interrupt-names property is added so that we can parse them based on
> > > names.
> > >
> > > While at it updated the example node to four spaces and added
> > > interrupt-names property.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > v1- > v2
> > > * Dropped RB tags
> > > * Added generic compatible string for rzg2ul
> > > * Added interrupt-names
> > > * Added checks for RZ/G2UL to make sure interrupts are 42 and interrupt-names
> > > * Updated example node with interrupt-names
> > > * Used 4 spaces for example node
> >
> > Thanks for the update!
> >
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > > @@ -19,16 +19,19 @@ description: |
> > >      - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
> > >        stand-up edge detection interrupts)
> > >
> > > -allOf:
> > > -  - $ref: /schemas/interrupt-controller.yaml#
> > > -
> > >  properties:
> > >    compatible:
> > > -    items:
> > > -      - enum:
> > > -          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
> > > -          - renesas,r9a07g054-irqc    # RZ/V2L
> > > -      - const: renesas,rzg2l-irqc
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
> > > +              - renesas,r9a07g054-irqc    # RZ/V2L
> > > +          - const: renesas,rzg2l-irqc
> > > +
> > > +      - items:
> > > +          - enum:
> > > +              - renesas,r9a07g043u-irqc   # RZ/G2UL
> > > +          - const: renesas,rzg2ul-irqc
> >
> > I'm not sure it's worth splitting into RZ/G2L and RZ/G2UL alike
> > variants, and adding the "renesas,rzg2ul-irqc" family-specific
> > compatible value.  You can easily handle the difference by the presence
> > (or absence) of the "bus-err" interrupt source.
> >
> Yes, the only reason to add "renesas,rzg2ul-irqc" is to differentiate
> RZ/Five later. I have not worked out on how this driver will work in
> case of RZ/Five yet with PLIC (as we sifive plic driver as a chained
> handler and then we have the RISC-V intc driver). If you insist I can
> drop it for now and then later when we add RZ/FIve we could add a
> check for compat string maybe?

Given you already use "renesas,r9a07g043u-irqc" (note the "u") here,
you will have "renesas,r9a07g043f-irqc" to handle the (minor)
differences.

> > I understand there "renesas,r9a07g043f-irqc" will be added later to
> > support RZ/Five?
> >
> Yes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
