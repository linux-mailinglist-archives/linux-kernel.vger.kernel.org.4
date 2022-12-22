Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6019165407C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiLVL5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiLVLzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:55:51 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5034E28E38;
        Thu, 22 Dec 2022 03:50:01 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id u9so4438785ejo.0;
        Thu, 22 Dec 2022 03:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJeiwtCwvbFZRIQTLTx02v7vDRrPNqXpj4utmGnBGBM=;
        b=RvDMYvCfFf6vYNpg3Ev2D3liLm4RIqRGg7xA7Sq7wO+ZDOg5tU8i8roFWbTJ4QSb2u
         XOGbTjBnY6P43RWrFOJcGzen7WHP8IZOGMi/XN4buBEX58cOW0ylHc7MsZR5YhBChvD4
         IYn2y560lNjGW+MI0uWs54rX/E8ekLdU43QeLurDFg4Exk+w2xQ7SknEk+REnbIvvair
         VTM92pU76YEElFttcHpUr/CDa7eg7WoS+1keuJ277doeMnjt+oKfDQVuy2yiyW7/WWJ1
         eM0bvC0njqsIkeDsUbWKc13jqlb8RZg73AjJ82TINx23U7DiYNg6p0Ujtq48wtVHpT4Y
         gqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJeiwtCwvbFZRIQTLTx02v7vDRrPNqXpj4utmGnBGBM=;
        b=vQMALmeqL/8oNjIccTxVV/gf0ugMqjO1APjmhj3JLzm5NuhvwF9PC7Mc5DwF4wxbuL
         I7n2nCZEDwrBUaBBgoB5p21FZuwrLxUObVb4RjjttmiNL4oSNcXh8R8OVMTVG3sAkE2W
         f/3YypaKMUyVB1+ExBU9JzbepF4adE4tzV/Nc7SgEFaa5CFIRFNOdgFDp9lWVvuEPDTd
         T2ei+LMQJr8SXejPjIHF1P8hcrUUtP3yb55BQ3kYYcNUUNYfBPC7bioHQ4AQW+l3cHKV
         3rsJdddNeAKSnQr5Yq0Ei8WpybB02iXi26SaDMP0j4udv/Z32z2buEZUc7BleEzcPZuM
         K8pQ==
X-Gm-Message-State: AFqh2krlAyrwCn2o95eSNXZ4BplYPqMV9wWUyXHRShycdv5Ckp9HIeZN
        Qn73fdHFrnKMabC4NcPig6t8k4RUP1tRbd8KBfI=
X-Google-Smtp-Source: AMrXdXuBAzNpx1C0N/2VT4CHW34cPXonoNMDl+rpKp7IRprinbDgVEXWzuvAzLkLdzHLvaY359uBFAc1rMo1UNsjwwU=
X-Received: by 2002:a17:906:b01:b0:7c1:808e:765b with SMTP id
 u1-20020a1709060b0100b007c1808e765bmr340302ejg.196.1671709799747; Thu, 22 Dec
 2022 03:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221221000242.340202-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <86o7rxawhn.wl-maz@kernel.org> <CAMuHMdX++dbcsxyGRqiRzgukeU4aoAi3hDV5zyfH1s11dFba-A@mail.gmail.com>
In-Reply-To: <CAMuHMdX++dbcsxyGRqiRzgukeU4aoAi3hDV5zyfH1s11dFba-A@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 22 Dec 2022 11:49:33 +0000
Message-ID: <CA+V-a8uRTPhQqtkQqUVtW=HE02YaW0oi=Os__OgtUgQVwWq+Mw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] irqchip: irq-renesas-rzg2l: Add support for
 RZ/G2UL SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Dec 21, 2022 at 12:18 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Wed, Dec 21, 2022 at 11:20 AM Marc Zyngier <maz@kernel.org> wrote:
> > On Wed, 21 Dec 2022 00:02:37 +0000,
> > Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > >
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > The IRQC block on RZ/G2UL SoC is almost identical to one found on the
> > > RZ/G2L SoC the only difference being it can support BUS_ERR_INT for
> > > which it has additional registers.
> > >
> > > This patch adds a new entry for "renesas,rzg2ul-irqc" compatible string
> > > and now that we have interrupt-names property the driver code parses the
> > > interrupts based on names and for backward compatibility we fallback to
> > > parse interrupts based on index.
> > >
> > > For now we will be using rzg2l_irqc_init() as a callback for RZ/G2UL SoC
> > > too and in future when the interrupt handler will be registered for
> > > BUS_ERR_INT we will have to implement a new callback.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > > +/* Parse hierarchy domain interrupts ie only IRQ0-7 and TINT0-31 */
> > > +static int rzg2l_irqc_parse_hierarchy_interrupts(struct rzg2l_irqc_priv *priv,
> > > +                                              struct device_node *np)
> > > +{
> > > +     struct property *pp;
> > >       unsigned int i;
> > >       int ret;
> > >
> > > +     /*
> > > +      * first check if interrupt-names property exists if so parse them by name
> > > +      * or else parse them by index for backward compatibility.
> > > +      */
> > > +     pp = of_find_property(np, "interrupt-names", NULL);
> > > +     if (pp) {
> > > +             char *irq_name;
> > > +
> > > +             /* parse IRQ0-7 */
> > > +             for (i = 0; i < IRQC_IRQ_COUNT; i++) {
> > > +                     irq_name = kasprintf(GFP_KERNEL, "irq%d", i);
>
> %u
>
Ok.

> > > +                     if (!irq_name)
> > > +                             return -ENOMEM;
> > > +
> > > +                     ret = rzg2l_irqc_parse_interrupt_by_name_to_fwspec(priv, np, irq_name, i);
> >
> > Am I the only one that find it rather odd to construct a name from an
> > index, only to get another index back?
>
> The issue is that there are two number ranges ("irq%u" and "tint%u"),
> stored in a single interrupts property.
>
> An alternative solution would be to get rid of the "interrupt-names",
> and use two separate prefixed interrupts properties instead, like is
> common for e.g. gpios: "irq-interrupts" and "tint-interrupts".
>
Maybe I will read all the interrupts based on index only for all the
SoCs and we still add interrupt-names in dt bindings with the
dt_binding check we can make sure all the interrupts for each SoC
exist in the DT and the driver still reads them based on index. Does
that sound good?

Cheers,
Prabhakar
