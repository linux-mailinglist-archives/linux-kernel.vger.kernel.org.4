Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080206540A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiLVMCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiLVMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:01:27 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BC02B26C;
        Thu, 22 Dec 2022 03:54:07 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a1so2585356edf.5;
        Thu, 22 Dec 2022 03:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUc9ftQEfhd/MV6cYGaYztTCR+BYKCTunlj8uFzmn+4=;
        b=i93t2b/Htglle9vUzVQKJQ7VAo/2qMpxF89GS76QCzCoUyAUdZMEz1b1Aa+PFTUuop
         b1saCaoF31Ralebjc1qZPgfTtQi/hFc55f5xDvPlBgDvfTh/gQIWNRySpcUhg+LXmC8I
         5V+1cBSppUMktXDusJmnQcbEbLoa+TpYIz2vWqI+p8f5CodZr0+6hsha76TA2zeLvm08
         zMWQAlrQ0E0xMDlXIJsGztoTRPDH+2pWoGdhHCJx50vqao+HcvR3ClJVZ7aSwsWSqK7r
         RCDyk72raqqWUZidbHuIIFfm4Q5xPNthfq2e3fCzlsgQYXcfHNgk6DlzHhEHhOv/ffMS
         jvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUc9ftQEfhd/MV6cYGaYztTCR+BYKCTunlj8uFzmn+4=;
        b=ZlmH/6MG57gBV41uCoYFeksMuj7D04VlQ30lbf7jGTxvBmGrkMWo4TWoEjIILgKW0G
         xYWtOG69WtFdJjupxYetCPHs5seK1HkZqMbaiPB4BAxgwW+x0ZFWZNIRCbZCycEWgCTL
         UuY3kCcqrvlYsttb0fG1OLXHRXfWcJPhQKqHZDMM6O4luW/bPMAj8kSm9WD3XPaM8gID
         guBg3X0vtMg7gGw0teOxVqrRNzOVfzXikscF1rYCn42a+WqU4qBzjmXgqxgdWRanKzp3
         /bcFja9KSoV1CBOKBt1a9iTXFolEwrikb5p7m/Yog6n0HrofALIzIhKnU/Qcy9xnFSqz
         PtGw==
X-Gm-Message-State: AFqh2kp6KOO5iLYZbcgAnkUIYh+m8fWYaGFjzupD0CTq0M3hPAuMR5M3
        Nsdib36vKfGy1vT8XgCI2exTGyo0XsrPo5TpGSk=
X-Google-Smtp-Source: AMrXdXts0LR79dHOd6WwBj5aSIMsk5SRX5i2AP+zNxuECLbTY24XvwP3oGjtrdUQX9zHVFa8JV2WtWA2w6J+yeSCkXU=
X-Received: by 2002:a05:6402:22a8:b0:468:cae8:f5a6 with SMTP id
 cx8-20020a05640222a800b00468cae8f5a6mr645677edb.263.1671710046207; Thu, 22
 Dec 2022 03:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221221000242.340202-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXmKYV7CwuD=ZNgaOTc+LxP9OvEJ8gcW_iS5NamTxEE+w@mail.gmail.com>
 <CA+V-a8tqvY+Nj391j+zJO21Q=47pyFR1SkDLH-hmJephcorY3g@mail.gmail.com> <CAMuHMdXDbfadxJsrEvQMwQKvxtBxQRA_Bx4+FY90N9v_XVirOA@mail.gmail.com>
In-Reply-To: <CAMuHMdXDbfadxJsrEvQMwQKvxtBxQRA_Bx4+FY90N9v_XVirOA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 22 Dec 2022 11:53:40 +0000
Message-ID: <CA+V-a8vmxDMTVJuxo9=6451_Y3e1+7SUu9R38LBsQyuzXch5_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
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

On Thu, Dec 22, 2022 at 8:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Dec 21, 2022 at 10:06 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Wed, Dec 21, 2022 at 12:37 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Wed, Dec 21, 2022 at 1:03 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Document RZ/G2UL (R9A07G043U) IRQC bindings. The IRQC block on RZ/G2UL SoC
> > > > is almost identical to one found on the RZ/G2L SoC the only difference
> > > > being it can support BUS_ERR_INT for which it has additional registers.
> > > > Hence new generic compatible string "renesas,rzg2ul-irqc" is added for
> > > > RZ/G2UL SoC.
> > > >
> > > > Now that we have additional interrupt for RZ/G2UL and RZ/Five SoC
> > > > interrupt-names property is added so that we can parse them based on
> > > > names.
> > > >
> > > > While at it updated the example node to four spaces and added
> > > > interrupt-names property.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > v1- > v2
> > > > * Dropped RB tags
> > > > * Added generic compatible string for rzg2ul
> > > > * Added interrupt-names
> > > > * Added checks for RZ/G2UL to make sure interrupts are 42 and interrupt-names
> > > > * Updated example node with interrupt-names
> > > > * Used 4 spaces for example node
> > >
> > > Thanks for the update!
> > >
> > > > --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > > > @@ -19,16 +19,19 @@ description: |
> > > >      - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
> > > >        stand-up edge detection interrupts)
> > > >
> > > > -allOf:
> > > > -  - $ref: /schemas/interrupt-controller.yaml#
> > > > -
> > > >  properties:
> > > >    compatible:
> > > > -    items:
> > > > -      - enum:
> > > > -          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
> > > > -          - renesas,r9a07g054-irqc    # RZ/V2L
> > > > -      - const: renesas,rzg2l-irqc
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - enum:
> > > > +              - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
> > > > +              - renesas,r9a07g054-irqc    # RZ/V2L
> > > > +          - const: renesas,rzg2l-irqc
> > > > +
> > > > +      - items:
> > > > +          - enum:
> > > > +              - renesas,r9a07g043u-irqc   # RZ/G2UL
> > > > +          - const: renesas,rzg2ul-irqc
> > >
> > > I'm not sure it's worth splitting into RZ/G2L and RZ/G2UL alike
> > > variants, and adding the "renesas,rzg2ul-irqc" family-specific
> > > compatible value.  You can easily handle the difference by the presence
> > > (or absence) of the "bus-err" interrupt source.
> > >
> > Yes, the only reason to add "renesas,rzg2ul-irqc" is to differentiate
> > RZ/Five later. I have not worked out on how this driver will work in
> > case of RZ/Five yet with PLIC (as we sifive plic driver as a chained
> > handler and then we have the RISC-V intc driver). If you insist I can
> > drop it for now and then later when we add RZ/FIve we could add a
> > check for compat string maybe?
>
> Given you already use "renesas,r9a07g043u-irqc" (note the "u") here,
> you will have "renesas,r9a07g043f-irqc" to handle the (minor)
> differences.
>
Ok, so I'll revert back to the previous version of the patch and still
add the interrupt names.

Cheers,
Prabhakar
