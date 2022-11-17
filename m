Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4962DA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbiKQMPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbiKQMO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:14:56 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6436C72F;
        Thu, 17 Nov 2022 04:14:54 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id k2so4621377ejr.2;
        Thu, 17 Nov 2022 04:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30Evq79zECYrxJQ0aLDQD8Gv3fjzDC3E9Fl79Br+Hz8=;
        b=auNimxq/45H6SDO3vky7POlzUEJCauq832U99WM5r9wrqlkPKfI6RYAuNSeTXl4ykW
         tPDQ0w0EQ8mRX/dtggKB6zl2a2UB8l2T0SCSYgLrpedyvBDRXn/9lZZQWme6yGAq5td1
         SAyIKM5wQldHJoqo7U45252D6zmYNbkpM9kYhQSlXZ1r7d6VITPmCFL2kI+Tnho8BMcm
         QrLJhge32UIEGTCHT1xGLwmF9bX3jCu8D6QUBQ1MyfvbaynSKUsAoldQ3H26WGEVeLWz
         mrWqfdtAy7/QRtKYZe0DRr6IFUvWKD7QtsryKKuoDye7ZA1Y+PreW2TdjFMC13wf2P9H
         TWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30Evq79zECYrxJQ0aLDQD8Gv3fjzDC3E9Fl79Br+Hz8=;
        b=IOOpWMWAgAKV+15390ZaobkYTSZu+7fuMHE3WQD56aOmt13+7J7ObNJwsCzI7e1kUm
         R8LxXmTfvx+9M46Lypn8fxalHXLNwZl+LD28x7YpuQ6Uz5GAh7QCyNaZ1EG/NKneDlUe
         R0iDzfEjJcWb6OeBEpBve4O6ZHKEENDYx4rzGc5s7ON8ZaPRAXQyaAbZ7Zh8mb6p3UNd
         kAC4AYj+iSMYfrqdNxmq67jZAEfteNW9tdfOG+eAJaHx3dPPNyZ3Gy6iXaAl8uLhNr8o
         BNBgvC5jwiVFHOP76QK2TU8Srljl+NpGBrWZ/BimVAMr87IPZJeOCimnuE3Ngz3wKxkg
         gczg==
X-Gm-Message-State: ANoB5pkzTH4pK5wRR1Ge+avyFSou8DfmqQec/4AmFMWoIeUNUt88xery
        X+E1G+Eu2qQJqm7Cxs3JPOUv6/dUsQCBgGPYthA=
X-Google-Smtp-Source: AA0mqf4E+FLYJqRjO9fTTonpvJCaxpvTEVX1VZTTQwaXeADfXJrSuVEtRH//Dm92r5J8qv6wj6AFlEkL8x4pCtS+fJE=
X-Received: by 2002:a17:906:79c4:b0:778:e3e2:8311 with SMTP id
 m4-20020a17090679c400b00778e3e28311mr2002726ejo.342.1668687293127; Thu, 17
 Nov 2022 04:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdW9K=gd7F-G-7v0J5Mz8jyZa_Vu3UZWsNZin76tff7f3g@mail.gmail.com>
In-Reply-To: <CAMuHMdW9K=gd7F-G-7v0J5Mz8jyZa_Vu3UZWsNZin76tff7f3g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 17 Nov 2022 12:14:26 +0000
Message-ID: <CA+V-a8ugHB2NqH4qa01LQm6yXaeSk2WweUX3ZP+fT3F_bU99Pg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] pinctrl: renesas: rzg2l: Fix configuring the GPIO
 pins as interrupts
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

On Thu, Nov 17, 2022 at 11:09 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On the RZ/G2UL SoC we have less number of pins compared to RZ/G2L and also
> > the pin configs are completely different. This patch makes sure we use the
> > appropriate pin configs for each SoC (which is passed as part of the OF
> > data) while configuring the GPIO pin as interrupts instead of using
> > rzg2l_gpio_configs[] for all the SoCs.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> But I do think there is room for improvement...
>
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -127,6 +127,7 @@ struct rzg2l_dedicated_configs {
> >  struct rzg2l_pinctrl_data {
> >         const char * const *port_pins;
> >         const u32 *port_pin_configs;
> > +       unsigned int n_port_pin_configs;
>
> n_ports?
>
Ok I will rename it to n_ports.

> >         struct rzg2l_dedicated_configs *dedicated_pins;
> >         unsigned int n_port_pins;
>
> n_port_pins is now always n_port_pin_configs * RZG2L_PINS_PER_PORT,
> right?
>
Yes, that's right. So are you suggesting to drop it and use it runtime instead?

> >         unsigned int n_dedicated_pins;
>
> > @@ -1517,6 +1518,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
> >  static struct rzg2l_pinctrl_data r9a07g043_data = {
> >         .port_pins = rzg2l_gpio_names,
> >         .port_pin_configs = r9a07g043_gpio_configs,
> > +       .n_port_pin_configs = ARRAY_SIZE(r9a07g043_gpio_configs),
> >         .dedicated_pins = rzg2l_dedicated_pins.common,
> >         .n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
> >         .n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
> > @@ -1525,6 +1527,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
> >  static struct rzg2l_pinctrl_data r9a07g044_data = {
> >         .port_pins = rzg2l_gpio_names,
>
> .port_pins is always rzg2l_gpio_names
>
Yes to avoid the huge array to be duplicated for other SoCs but bound
checking is done by  n_port_pins.

> >         .port_pin_configs = rzg2l_gpio_configs,
> > +       .n_port_pin_configs = ARRAY_SIZE(rzg2l_gpio_configs),
> >         .dedicated_pins = rzg2l_dedicated_pins.common,
> >         .n_port_pins = ARRAY_SIZE(rzg2l_gpio_names),
>
> I think this should have become
> ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT)
> when support for r9a07g043 was introduced.
>
Agreed, I will update it as part of v2.

> To avoid overflows when adding support for more SoCs, you can add a
> bunch of checks like
>
>     BUILD_BUG_ON(ARRAY_SIZE(r9a07g043_gpio_configs) *
> RZG2L_PINS_PER_PORT > ARRAY_SIZE(rzg2l_gpio_names))
>     BUILD_BUG_ON(ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT
> > ARRAY_SIZE(rzg2l_gpio_names))
>
OK, I'll add those checks in the probe as a separate patch.

Cheers,
Prabhakar
