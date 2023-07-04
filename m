Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCCD746C10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjGDIg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjGDIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:36:06 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF44E62;
        Tue,  4 Jul 2023 01:36:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7866189cff1so162631639f.0;
        Tue, 04 Jul 2023 01:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688459764; x=1691051764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDbe9ViOonNjf+BBw3JuRqHmgJYIIlBwInsX6f0IRLM=;
        b=TQLyOlk0eahcefxNZxdEkYY4uoaj3wt4Qz+GBpYpx7x3IdFzZCLTbG9qi/rgajUFE1
         VOE3tHXIgM7MDq1HkgQNVl1ATHv8v5ybVbYlgVRcWzDpzp9YMFLf2e9rcPgkTHbfPaEE
         jG5pvryseieVu7Xh9BeTzC/WOO7QZX1fZW0cenBpiA9nFcgzDpWWFEa6Jy/hjW0PmRh3
         NpVCJo+lH5PFzZ35VhHXODIKwPh5vipGjWDrnCcNF6YhFdfXV3sefUGOyFJV35d8n7vx
         NRzg891eJ1pskGFhdhqeqJIeRR4DSoMykSz3NhZLnGckrmZdWMNuX79VIHlkAV1+9hW1
         Sk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688459764; x=1691051764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDbe9ViOonNjf+BBw3JuRqHmgJYIIlBwInsX6f0IRLM=;
        b=BKgIdPFFx/1JTYy/5Djl0EFAhx6s4fE44B7HdZeajcuM2Cp8Vcu/EzVArvcQ711jfP
         3hj+FYvCI3kosjhaXYkXPDdawyIPIEHKHBpFfnSkpIg68WAt+2AXoV5gZfrVUDkS9xWW
         I1AeL0gM0Mi4Qvdxh5RzydNxCwukkoKwk5ZJ9Rmf0Z3RF2X4FMbjkIOG6/fRlw+NPY3K
         8oCr2KrwZH/F7RnuIrGR0DYhoc4ApW8XDf2rvV2DyqU6qMQddqZjkHNGVvbKLyd654H1
         Ym6WMu6ud3LoNYgnSUiantxXnvczUXE+7at+bmAQs4+V0I9cGu5QOi49eBzd4QxuHj1E
         GlAA==
X-Gm-Message-State: ABy/qLYk2FXttr1DZpG9fqvZQyKPHlK0plHoa2aNuy5iu7qL2b9cBtSU
        l22cWa6ijua9qDgEAURb3rlQvoCaI8RAfv0F7qE=
X-Google-Smtp-Source: APBJJlFm8e2Rtt9z4cD1DSowp2JLzmeFSI9AzgM8Vpb5g7V1rrKYRXK7jMCrC1I4ijYY626IemvqkOpwgLLhJTQz3TE=
X-Received: by 2002:a6b:6f10:0:b0:786:7389:51d7 with SMTP id
 k16-20020a6b6f10000000b00786738951d7mr7180271ioc.5.1688459764550; Tue, 04 Jul
 2023 01:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB59223E030DAE587A49C9D0FE862EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59223E030DAE587A49C9D0FE862EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 4 Jul 2023 09:35:38 +0100
Message-ID: <CA+V-a8um0xQ2FJyrHs=5Pc2PNvgW6B6z31zyFQ6zAYhi6=zgvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
 RZG2L_GPIO_PORT_PACK() macro
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Tue, Jul 4, 2023 at 9:30=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.com=
> wrote:
>
> Hi Prabhakar,
>
> > -----Original Message-----
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Friday, June 30, 2023 1:05 PM
> > To: Geert Uytterhoeven <geert+renesas@glider.be>; Magnus Damm
> > <magnus.damm@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Linus Walleij
> > <linus.walleij@linaro.org>; linux-renesas-soc@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-gpio@vger.kernel.org; Biju Das
> > <biju.das.jz@bp.renesas.com>; Prabhakar <prabhakar.csengg@gmail.com>;
> > Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
> > RZG2L_GPIO_PORT_PACK() macro
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Currently we assume all the port pins are sequential ie always PX_0 to
> > PX_n (n=3D1..7) exist, but on RZ/Five SoC we have additional pins P19_1=
 to
> > P28_5 which have holes in them, for example only one pin on port19 is
> > available and that is P19_1 and not P19_0.
> >
> > So to handle such cases include pinmap for each port which would
> > indicate the pin availability on each port. With this we also get
> > additional pin validation, for example on the RZ/G2L SOC P0 has two pin=
s
> > P0_1 and P0_0 but with DT/SYSFS could use the P0_2-P0_7.
> >
> > While at it, update rzg2l_validate_gpio_pin() to use the port pinmap to
> > validate the gpio pin.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 167 ++++++++++++------------
> >  1 file changed, 86 insertions(+), 81 deletions(-)
> >
> > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > index 9511d920565e..a0c2e585e765 100644
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -67,10 +67,12 @@
> >                                        PIN_CFG_FILCLKSEL)
> >
> >  /*
> > - * n indicates number of pins in the port, a is the register index
> > - * and f is pin configuration capabilities supported.
> > + * m indicates the bitmap of supported pins, n indicates number
> > + * of pins in the port, a is the register index and f is pin
> > + * configuration capabilities supported.
> >   */
> > -#define RZG2L_GPIO_PORT_PACK(n, a, f)        (((n) << 28) | ((a) << 20=
) |
> > (f))
> > +#define RZG2L_GPIO_PORT_PACK(m, n, a, f)     ((UL(m) << 32) | (UL(n) <=
< 28)
> > | ((a) << 20) | (f))
> > +#define RZG2L_GPIO_PORT_GET_PINMAP(x)        (((x) & GENMASK(39, 32)) =
>> 32)
> >  #define RZG2L_GPIO_PORT_GET_PINCNT(x)        (((x) & GENMASK(30, 28)) =
>> 28)
> >  #define RZG2L_GPIO_PORT_GET_INDEX(x) (((x) & GENMASK(26, 20)) >> 20)
> >  #define RZG2L_GPIO_PORT_GET_CFGS(x)  ((x) & GENMASK(19, 0))
> > @@ -129,7 +131,7 @@ struct rzg2l_dedicated_configs {
> >
> >  struct rzg2l_pinctrl_data {
> >       const char * const *port_pins;
> > -     const u32 *port_pin_configs;
> > +     const u64 *port_pin_configs;
>
> Can this be SoC specific? Only for RZ/Five you need this changes.
> Others SoCs like RZ/{G2L,G2LC,V2L and G2UL) still work with u32* as there
> is no holes. With this change memory usage is doubled as we change from
> u32->u64.
>
This is to avoid writing to undocumented registers so I have added for
all the SoCs. For example on the RZ/G2L SOC P0 has two pins P0_1 and
P0_0 but DT/SYSFS could use the P0_2-P0_7. This patch restricts users
to use only available GPIO pins.

Cheers,
Prabhakar
