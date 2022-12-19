Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82408650CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiLSNuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLSNuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:50:52 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F07BE25;
        Mon, 19 Dec 2022 05:50:51 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id h26so4359117qtu.2;
        Mon, 19 Dec 2022 05:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMpAZw6S6JvATf2B1ykxy7jXVkmfHoXtkV8PdpVE9/I=;
        b=YcQmAiImD94tGo2tQE+svnYRZMdvoG/6WQ2Fjp6xTrF6G2nRvBg400ciDvuf/P79P0
         rs6dDkboFCw7+eLd/f4RbiX5VPAihh77YByMqwDEW7/El34oterd6uegg3HCL24ACqct
         A5AyW111gadcSmFLUejq1V/8B+lSipoLe98Bm/ZIWm8e3CnlCnE7ahcFOkDQ9Ojo+Q8C
         yC41LmLFn4PRmdQUgI28sc0CRkX3YuoK5FMdoSu1akj/sdWtOUJ9ouM8dZ23U9jKvHw5
         TFV4WCWUdxJDa8BA/SAyRhFvZORlECjJD3NyK+YEUvp0mcRMt6ZE0OTnRY21Er10BB1W
         noMA==
X-Gm-Message-State: ANoB5pntU5QuM95j99hxro7mo7OupxCmI0lsfMexRGKfHBLoja7z+UG8
        RXgtpVXJS9/8nkeDxRxlPD3FRRioaTV6Wg==
X-Google-Smtp-Source: AA0mqf6p4vwTP+3AkeYlGoBK1w16eYvuUY+YBns06d1D4IDpc3Fzrn1klY0kHzdlDc9s35kEQ+Hz5Q==
X-Received: by 2002:ac8:1004:0:b0:39c:da20:d48d with SMTP id z4-20020ac81004000000b0039cda20d48dmr49738354qti.34.1671457849991;
        Mon, 19 Dec 2022 05:50:49 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id y21-20020ac85255000000b00398313f286dsm6018434qtn.40.2022.12.19.05.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 05:50:49 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id b16so9550924yba.0;
        Mon, 19 Dec 2022 05:50:48 -0800 (PST)
X-Received: by 2002:a25:9e84:0:b0:6de:6183:c5c3 with SMTP id
 p4-20020a259e84000000b006de6183c5c3mr79384857ybq.89.1671457848676; Mon, 19
 Dec 2022 05:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV46aMfqu+kMW9E-RURugK-giOx0k-NPe5XX4nxKZJzkg@mail.gmail.com>
 <CA+V-a8uqQ2fK1UjRT864jyHdt6Z47V=iARSJC6B2M6Gikms=Eg@mail.gmail.com> <CA+V-a8sGLrsRWFi3-hNmB=Uj-aCQLD5VQesmUFb8N1NAqhyLuQ@mail.gmail.com>
In-Reply-To: <CA+V-a8sGLrsRWFi3-hNmB=Uj-aCQLD5VQesmUFb8N1NAqhyLuQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Dec 2022 14:50:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW_QuBUUypyrAbLqWPdZ81bWeYDyPbBf=2KmDht1X44bA@mail.gmail.com>
Message-ID: <CAMuHMdW_QuBUUypyrAbLqWPdZ81bWeYDyPbBf=2KmDht1X44bA@mail.gmail.com>
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

On Mon, Dec 19, 2022 at 1:57 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, Nov 18, 2022 at 12:29 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Nov 17, 2022 at 10:54 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Document RZ/G2UL (R9A07G043) IRQC bindings. The RZ/G2UL IRQC block is
> > > > identical to one found on the RZ/G2L SoC. No driver changes are
> > > > required as generic compatible string "renesas,rzg2l-irqc" will be
> > > > used as a fallback.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > > > Note, renesas,r9a07g043u-irqc is added we have slight difference's compared to RZ/Five
> > > > - G2UL IRQCHIP (hierarchical IRQ domain) -> GIC where as on RZ/Five we have PLIC (chained interrupt
> > > > domain) -> RISCV INTC
> > >
> > > I think this difference is purely a software difference, and abstracted
> > > in DTS through the interrupt hierarchy.
> > > Does it have any impact on the bindings?
> > >
> > > > - On the RZ/Five we have additional registers for IRQC block
> > >
> > > Indeed, the NMI/IRQ/TINT "Interruput" Mask Control Registers, thus
> > > warranting separate compatible values.
> > >
> > > > - On the RZ/Five we have BUS_ERR_INT which needs to be handled by IRQC
> > >
> > > Can you please elaborate? I may have missed something, but to me it
> > > looks like that is exactly the same on RZ/G2UL and on RZ/Five.
> > >
> > Now that we have to update the binding doc with the BUS_ERR_INT too,
> > do you think it would make sense to add interrupt-names too?

> Gentle ping.

Thanks for the ping, I had missed you were waiting on input from me.
Sorry for that...

As there are three different groups of parent interrupts, adding
interrupt-names makes sense.  However, as this binding is already
in active use since v6.1, you probably need to keep on supporting the
ack of interrupt-names.  Or do you think there are no real users yet,
and we can drop support for that?

> > BUS_ERR_INT will have to be handled IRQC itself (i.e. IRQC will
> > register a handler for it).

Do you mean you will need a fourth parent type for that?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
