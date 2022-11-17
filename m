Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2768D62DFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiKQPZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbiKQPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:24:58 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B457C026;
        Thu, 17 Nov 2022 07:22:05 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so5899377ejc.4;
        Thu, 17 Nov 2022 07:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kHlNj4O/Pkd3jf55FT+J3SAuNDsxwz0o4xLf5wKOfyc=;
        b=jwj13zCsqmeLmCJaVaYld5WUp5M3AV3FwuHFjBiio/M3bHvl9dzTcrINTk5mdQOTMc
         fKFjZ8LumHTOFu7hheBie9CDjxV6MIWNmEdC9tloCRz2dXTAf1QgcateoQyk+cltkuJv
         3NRQNS4LrkT0FGf9doY0826kfKdrA+YF1zZfn/r9u7l/gJT/W3WN6utU58R/bQY6Xa+g
         D7jgJZ8tqpGv9n3vyAGo2npvjPtkxqsy3wXPlhPKiuppkZ93ryV7sKsy3Vd6YWiwPj+2
         JmLVCALOcxu0dBmkFja0aBj/822FE6Usxc4gdFKSiVYlS7D+yg5kAMz/gJPtJrmCaL43
         spbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHlNj4O/Pkd3jf55FT+J3SAuNDsxwz0o4xLf5wKOfyc=;
        b=jtfqJuO48oF82X65c/vnH92dCeKJwRULVFD4uzPdzU5c3LRumKhGo34h/FdRVeWggi
         JtmyOXfAJw+PEfQHKRufMmPc5aAtqn+pDG2w2tfBbFM6Prv9ENE+SsEZ6llaXaQh22zF
         YnFGW5xyGbthK5ekulhuS65NwxH7Uhs2qqpXk15IiEVwkeSdA8Kv2g8eZTvyeAJRwGpn
         7HL5soazW+a1uRfyPfxgzzF/i91EUVv551sXK8CV+ANPfBDW4oPphRFxWxZKV4RIWhTn
         WGluEYVICMJVR912J/TbxBm8us2+yLxYHeSgXwN/WD65lGxj0RpfbNpUQCFkih72YEKv
         mhwA==
X-Gm-Message-State: ANoB5pkD3gzbb/LrJxkJ07wJyeNnpY05KXkqRGIjKO6Tmetd1o/o6kEP
        dkoU3ASNHryZv+4y5KnG5YH5hS4c2/NDWc4Vvko=
X-Google-Smtp-Source: AA0mqf5w2J1tdb1H1EOElNjJmXYe8wvp54py3DQbMGunNSgaTqrGRNvwr/3YTfYQvubV11kel7XDu8fDLN45Tf8OhgI=
X-Received: by 2002:a17:906:3792:b0:7aa:97c7:2bfe with SMTP id
 n18-20020a170906379200b007aa97c72bfemr2499104ejc.196.1668698523974; Thu, 17
 Nov 2022 07:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV+e63iW2yCNaTqYv6_b7zSnok-1i07sbNfgJvq5vGUCQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV+e63iW2yCNaTqYv6_b7zSnok-1i07sbNfgJvq5vGUCQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 17 Nov 2022 15:21:37 +0000
Message-ID: <CA+V-a8sFfT5eUQaxQWrYraWEBDMhxDcG6fWcioV_i8aJ5Fg+3g@mail.gmail.com>
Subject: Re: [PATCH RFC 4/5] arm64: dts: renesas: r9a07g043[u]: Update pinctrl
 node to handle GPIO interrupts
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

On Thu, Nov 17, 2022 at 11:20 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add required properties in pinctrl node to handle GPIO interrupts.
> >
> > Note as IRQC is not enabled in RZ/Five the phandle for interrupt-parent
> > is added in RZ/G2UL specific dtsi so that RZ/Five pinctrl driver
> > continues without waiting for IRQC to probe.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > @@ -531,6 +531,8 @@ pinctrl: pinctrl@11030000 {
> >                         gpio-controller;
> >                         #gpio-cells = <2>;
> >                         gpio-ranges = <&pinctrl 0 0 152>;
> > +                       #interrupt-cells = <2>;
> > +                       interrupt-controller;
> >                         clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
> >                         power-domains = <&cpg>;
> >                         resets = <&cpg R9A07G043_GPIO_RSTN>,
> > diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
> > index 7a8ed7ae253b..65e7b029361e 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
> > @@ -98,6 +98,10 @@ &irqc {
> >         resets = <&cpg R9A07G043_IA55_RESETN>;
> >  };
> >
> > +&pinctrl {
> > +       interrupt-parent = <&irqc>;
> > +};
>
> Do you plan to move it back to the common r9a07g043.dtsi later?
Yes we should be doing that.

> Perhaps it makes sense to move the full irqc node to r9a07g043[uf].dtsi?
> There is not that much common left, even the compatible value differs.
> We don't keep the few common properties of the cpu0 node in
> r9a07g043.dtsi neither.
>
Agreed, I will move it in the next version.

Cheers,
Prabhakar
