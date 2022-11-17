Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7667062DAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbiKQMdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239529AbiKQMcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:32:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4C0748C6;
        Thu, 17 Nov 2022 04:31:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s12so2306843edd.5;
        Thu, 17 Nov 2022 04:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jNlwoVZ6isbTxQ6Fyi04RsVlWpKWGpVpX4qwF59U3k0=;
        b=jDqBvSXSDnn5qg+QnHzXcI7c08NsFOOHtVnQ161mlGnRQ5pp6Wj4ihkDz6QZW/II4j
         qKt3pKxHh6LAlsPJfYa7tWUuRhu4sa8Znh+6AqiR97dQPqz1lxHvGVjLixhapGjyK9iG
         KUNqf5gm0crsFNa/+zNU30R3ia6+UbeWsa2cAlyQGBKjyJC58NYVkeQOkDSuh/c4ADhZ
         Kc1X+jEusaPrDtcQwRmnB9hOk629pl6bVCR4YAiJM3mEBZtWKIQLSWUT6Os6xmL1ZRMQ
         ozVcs1W5F1ZIEn3mzjP4LxTYGnAQQOHjX/Gg7nB9zodbNlxMx+41QNos6ncYoE5g1WyE
         rL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNlwoVZ6isbTxQ6Fyi04RsVlWpKWGpVpX4qwF59U3k0=;
        b=2qLMblnHjOoSidNiw2Oxc++zmTzNOTsFPnQrQic7XrA2Vla53KcJZNYx/0dmBGECut
         lzncudgn4+5CPpwhgWrgwAQKU1U0otSRivziEa9AMeI7ZJaHR87SiwtGSguHuDTr6tsl
         R0gKrjmC0DPSr3+LhVcOwJK0oUObinFshxy8pakRZmUmRbi1VSP2+1fqODD6eYbGFx5V
         /Wx6n9TBsatx1sv4W8xOoju50dCrc/j0Uz562tFL2wU+YBQhEt/udGK1pvvO7grufaga
         0cxbPhqoOHZCMfZ9TIHFVO0eqvwWetDUkKlBI8caFgQDZTAUtj/n+K0RkxP/HXtIUIfd
         Dn9A==
X-Gm-Message-State: ANoB5pm/XZYp6cK2b/h9oRpAC+Cb/MQPQmD8khUVYjbey/XnlCUf8RUY
        AlJJHsy0IET/raQMKLyu/Qm4LvsVshS+Z69fooYz7GeJNRw=
X-Google-Smtp-Source: AA0mqf5ojvCHVZasiK8GgXehtbh0pi3YqZa9rEl1/7vRevJBctBpQcu74pPoX3eFtAXLSLJINq0fK7RuissmhP/zdL4=
X-Received: by 2002:a05:6402:2987:b0:45c:a9d3:d535 with SMTP id
 eq7-20020a056402298700b0045ca9d3d535mr2006776edb.0.1668688280422; Thu, 17 Nov
 2022 04:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWgCdR8E+bgAprfSmL3S-1aY2R7frba9du-XfCeEV7T0g@mail.gmail.com>
In-Reply-To: <CAMuHMdWgCdR8E+bgAprfSmL3S-1aY2R7frba9du-XfCeEV7T0g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 17 Nov 2022 12:30:54 +0000
Message-ID: <CA+V-a8soA=7bLXXqJCLtrceNhMCgwnHg9KUOr4m0DkHUuCYi4Q@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] arm64: dts: renesas: r9a07g043[u]: Add IRQC node
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

Thank you for the review.

On Thu, Nov 17, 2022 at 11:13 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add IRQC node to R9A07G043 (RZ/G2UL) SoC DTSI.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > ---
> > Note,
> > - clocks and resets are differnt when compared to RZ/Five hence its added
> >   in r9a07g043u.dtsi
> > - We have additional interrupt on RZ/Five hence interrupts are added in
> >   r9a07g043u.dtsi
>
> Which additional interrupts?
> Do you already have the r9a06g043f-variant ready, so we can compare?
>
I missed this RZ/G2UL has this interrupt too. So ignore this point.

> > - clock-names is also added in r9a07g043u.dtsi to avoid dtbs_check warning
>
> Why does this warn?
>
If we add the clock-names property in the base dtsi we get a
dtbs_check warning "clocks is a dependency of clock-names" for RZ/Five
as we haven't added the clocks property to it.

> > --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > @@ -538,6 +538,14 @@ pinctrl: pinctrl@11030000 {
> >                                  <&cpg R9A07G043_GPIO_SPARE_RESETN>;
> >                 };
> >
> > +               irqc: interrupt-controller@110a0000 {
> > +                       #interrupt-cells = <2>;
> > +                       #address-cells = <0>;
> > +                       interrupt-controller;
> > +                       reg = <0 0x110a0000 0 0x10000>;
>
> The size of the "reg" property will be 0x20000 on RZ/Five, to cover the
> extra [NIT]MSK registers, so I think this belongs in r9a07g043u.dtsi, too.
>
Agreed.

Cheers,
Prabhakar
