Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11D8650C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiLSM55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiLSM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:57:53 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AECAF59C;
        Mon, 19 Dec 2022 04:57:52 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kw15so21181278ejc.10;
        Mon, 19 Dec 2022 04:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4LQE62+2wuigm3XEvUptVNxTDjUyXyDiBAp0xKdO5OI=;
        b=avXCIb03aNF+/2KOLLu/1s2Q8CZXuni1vKuNEJpnt7VtrfmbOhDmbl0vMtN+C+YHjr
         4dWIH1fOJEtgcUmuzMbis1uKmtya1+9bhRMNgkAtFvwiC53K/787JLPqh5Rf1wE4I3iJ
         9NxduGDW8iJz9kUD3YidXhuVs/PCGE260dRl58DkgTRNDatt2EXvPgtOSBaRWE9kq8hs
         F4ow8PV8ZYzIdaX04IWD/oKip4e0ZtPFL46uib+twstsTdMuKAblcFCT252wd+iOlC9t
         eiGqikfD2lNDXthOFgQJfZ8BX+vlv91WAjebj4+znAIUrX9kja7+TfzdclkiT0sdWyr0
         HBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LQE62+2wuigm3XEvUptVNxTDjUyXyDiBAp0xKdO5OI=;
        b=4fu9SqdF4rcWLgEocX5vkwLdQHYYLUF+ELDKAG7eNZaVhjQll0oqRYpBxWCafSCIim
         dJA93twdCOKTSiFqu1YYK1k/1UuPfkcQnJwNSLiaSY2mQBjDLrM1fyRmZ/F1a/4RXFN5
         osGAp+GPooAJKDXbDYGYFFLeHKy43v08izuiuls6E0aqqB9HjSrozLwECJ6Grg7oeIwq
         vkLVBPJSaGEXyryc03SWPsTpeiqIp5Q+ZJm27RnV5LqkIZcHoHAxcC3ofgmDzKLsQIu5
         REQtl3PMQDkE5AvBfI2BPs+J53b0N0sWpAsxKm8wakmJ+y2rfu7HmG0qbfvW/oFg3I5s
         NXrw==
X-Gm-Message-State: ANoB5pmGgsCyhlz/Qa220U7TEdymROr3IAqdhB+7fJjq/KZoJG31xH7u
        iZt7/TKuCmVoKuemZm2YiErjK51ggDKP0bHvAKc=
X-Google-Smtp-Source: AA0mqf5xgU7O52hFIF6NaDL0v2bRjjn0g9Ry8We7IY1pr/I/+8hC77HKha6QNBV1ZJVq2Im1KSZXfdhQASsR1y4jrUE=
X-Received: by 2002:a17:906:79c4:b0:778:e3e2:8311 with SMTP id
 m4-20020a17090679c400b00778e3e28311mr72270959ejo.342.1671454670943; Mon, 19
 Dec 2022 04:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV46aMfqu+kMW9E-RURugK-giOx0k-NPe5XX4nxKZJzkg@mail.gmail.com> <CA+V-a8uqQ2fK1UjRT864jyHdt6Z47V=iARSJC6B2M6Gikms=Eg@mail.gmail.com>
In-Reply-To: <CA+V-a8uqQ2fK1UjRT864jyHdt6Z47V=iARSJC6B2M6Gikms=Eg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Dec 2022 12:57:24 +0000
Message-ID: <CA+V-a8sGLrsRWFi3-hNmB=Uj-aCQLD5VQesmUFb8N1NAqhyLuQ@mail.gmail.com>
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

On Fri, Nov 18, 2022 at 12:29 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Geert,
>
> On Thu, Nov 17, 2022 at 10:54 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Prabhakar,
> >
> > On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Document RZ/G2UL (R9A07G043) IRQC bindings. The RZ/G2UL IRQC block is
> > > identical to one found on the RZ/G2L SoC. No driver changes are
> > > required as generic compatible string "renesas,rzg2l-irqc" will be
> > > used as a fallback.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > ---
> > > Note, renesas,r9a07g043u-irqc is added we have slight difference's compared to RZ/Five
> > > - G2UL IRQCHIP (hierarchical IRQ domain) -> GIC where as on RZ/Five we have PLIC (chained interrupt
> > > domain) -> RISCV INTC
> >
> > I think this difference is purely a software difference, and abstracted
> > in DTS through the interrupt hierarchy.
> > Does it have any impact on the bindings?
> >
> > > - On the RZ/Five we have additional registers for IRQC block
> >
> > Indeed, the NMI/IRQ/TINT "Interruput" Mask Control Registers, thus
> > warranting separate compatible values.
> >
> > > - On the RZ/Five we have BUS_ERR_INT which needs to be handled by IRQC
> >
> > Can you please elaborate? I may have missed something, but to me it
> > looks like that is exactly the same on RZ/G2UL and on RZ/Five.
> >
> Now that we have to update the binding doc with the BUS_ERR_INT too,
> do you think it would make sense to add interrupt-names too?
>
> BUS_ERR_INT will have to be handled IRQC itself (i.e. IRQC will
> register a handler for it).
>
Gentle ping.

Cheers,
Prabhakar
