Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7158A7464B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjGCVKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGCVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:10:50 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145BBE59;
        Mon,  3 Jul 2023 14:10:49 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7835ae70e46so192218039f.3;
        Mon, 03 Jul 2023 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688418648; x=1691010648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzVkmEgU5WzK/Ygg1Ob57YCyS+9xMsLU8cmnnEEo+/M=;
        b=ggNSk/H1Gu+SWvUTcFKzi52A/Nuq5OjwcnWpXPbpm5zYS5lRO/GqinQIi6LRvFf5js
         9Ngg0qC9cVjdZcSTmjXDHFeUIRkRBls9EEhikCDCOxNawCsO8WILiqeW5+JB58sDyB69
         29LRRFms3nDEznT2wR6Zf6+jhz3o8/NAV1fnTnUP1aWW53+ZLN0abqkjojIHkP+CEOGw
         Ofe3cRV0hk0KI1mZrS2cIrcU4qQjvD3lLI+oahSb4kVllxLodasgApQgSGNK7iHTwW8i
         jJ1q3whXmgGphg/X6maRg+ZWZSWrDnijv2tJCTeyhSnK3xJQQ1PvBM97VTBWWBNDuU57
         x//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688418648; x=1691010648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzVkmEgU5WzK/Ygg1Ob57YCyS+9xMsLU8cmnnEEo+/M=;
        b=laqMVwS7fH9bPv8m7JpByAFBEHDl/+hdr2SX7I2i80zbQmaivQ7lzf5YReGGT2rDt1
         MLkqIy0+j8+Ggfq7DQ6QH4Hn2mhSLCci07fmWF79vwmx2F5yGA/ZW7CSO+ldc42WbbiV
         BTSziVSOQByOka7e4O1Zwl5cB969hxWa1C6VIYDSOQSf8R1+93feROGh80kR2sE/oyz5
         x0E1qQFkvZE9gv8eOVs24DNAYahLTnlDVWu5zh9HdzWo0Vu7vSmz592Qg2kUgFTJ+CWH
         HaN1t5gNLkr1jHqLV5IjbD+bGu62DnH6XGWf5y4LJYqweVCLVBawtJZI1AODR5l2PnJU
         9RgQ==
X-Gm-Message-State: AC+VfDw+HpuuPr5fiMC/o/HXrbVQk3m7WC8HMhQG1YPSUh+aao8999Zy
        PEtu41Fcei+L3bZA9NsgGuWFdVRrFUc4/BuYb4v/xEtkht2JnA==
X-Google-Smtp-Source: ACHHUZ6FkDf1mZszo/F/op4b4PfzyWqxR/zwCVmySCW6VP4GNg/zqvWZRGF5OdMpO5oqXZ9qEIDoJKf1z4mgA7m5tJE=
X-Received: by 2002:a6b:f10d:0:b0:783:727b:7073 with SMTP id
 e13-20020a6bf10d000000b00783727b7073mr11630255iog.20.1688418648099; Mon, 03
 Jul 2023 14:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592217C4028606B67B39C6858629A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8sXcHP2AYYLLONLLBDVctMb=fnU=D4+6hNoHGx5Dk2O3Q@mail.gmail.com> <OS0PR01MB592285AB361A6C25CEDC21F68629A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592285AB361A6C25CEDC21F68629A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 3 Jul 2023 22:10:21 +0100
Message-ID: <CA+V-a8tkZ8vbMPqReQ+CixQgHZWBXxzmNdjv1EL9skgaf+Mmvw@mail.gmail.com>
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

On Mon, Jul 3, 2023 at 3:13=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.com=
> wrote:
>
> Hi Prabhakar,
>
> > -----Original Message-----
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Monday, July 3, 2023 1:43 PM
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>; Magnus Damm
> > <magnus.damm@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Linus Walleij
> > <linus.walleij@linaro.org>; linux-renesas-soc@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-gpio@vger.kernel.org; Prabhakar Mahadev
> > Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: Re: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
> > RZG2L_GPIO_PORT_PACK() macro
> >
> > Hi Biju,
> >
> > Thank you for the review.
> >
> > On Mon, Jul 3, 2023 at 12:42=E2=80=AFPM Biju Das <biju.das.jz@bp.renesa=
s.com>
> > wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > Thanks for the patch.
> > >
> > > > -----Original Message-----
> > > > From: Prabhakar <prabhakar.csengg@gmail.com>
> > > > Sent: Friday, June 30, 2023 1:05 PM
> > > > To: Geert Uytterhoeven <geert+renesas@glider.be>; Magnus Damm
> > > > <magnus.damm@gmail.com>
> > > > Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > > <krzysztof.kozlowski+dt@linaro.org>; Linus Walleij
> > > > <linus.walleij@linaro.org>; linux-renesas-soc@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linux-riscv@lists.infradead.org; linux-
> > > > kernel@vger.kernel.org; linux-gpio@vger.kernel.org; Biju Das
> > > > <biju.das.jz@bp.renesas.com>; Prabhakar
> > > > <prabhakar.csengg@gmail.com>; Prabhakar Mahadev Lad
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Subject: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
> > > > RZG2L_GPIO_PORT_PACK() macro
> > > >
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Currently we assume all the port pins are sequential ie always PX_0
> > > > to PX_n (n=3D1..7) exist, but on RZ/Five SoC we have additional pin=
s
> > > > P19_1 to
> > > > P28_5 which have holes in them, for example only one pin on port19
> > > > is available and that is P19_1 and not P19_0.
> > > >
> > > > So to handle such cases include pinmap for each port which would
> > > > indicate the pin availability on each port. With this we also get
> > > > additional pin validation, for example on the RZ/G2L SOC P0 has two
> > > > pins
> > > > P0_1 and P0_0 but with DT/SYSFS could use the P0_2-P0_7.
> > > >
> > > > While at it, update rzg2l_validate_gpio_pin() to use the port pinma=
p
> > > > to validate the gpio pin.
> > > >
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 167
> > > > ++++++++++++------------
> > > >  1 file changed, 86 insertions(+), 81 deletions(-)
> > > >
> > > > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > index 9511d920565e..a0c2e585e765 100644
> > > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > @@ -67,10 +67,12 @@
> > > >                                        PIN_CFG_FILCLKSEL)
> > > >
> > > >  /*
> > > > - * n indicates number of pins in the port, a is the register index
> > > > - * and f is pin configuration capabilities supported.
> > > > + * m indicates the bitmap of supported pins, n indicates number
> > > > + * of pins in the port, a is the register index and f is pin
> > > > + * configuration capabilities supported.
> > > >   */
> > > > -#define RZG2L_GPIO_PORT_PACK(n, a, f)        (((n) << 28) | ((a) <=
<
> > 20) |
> > > > (f))
> > > > +#define RZG2L_GPIO_PORT_PACK(m, n, a, f)     ((UL(m) << 32) |
> > (UL(n) << 28)
> > > > | ((a) << 20) | (f))
> > >
> > > I guess, you can still achieve RZG2L_GPIO_PORT_PACK(n, a, f) with
> > > ((UL(PINMAP(n)) << 32) | (UL(n) << 28) | ((a) << 20) | (f))
> > >
> > > #define PINMAP(n) GENMASK(n,0) ?? Then you don't need to modify
> > rzg2l_gpio_configs.
> > >
> > Good point, but this would work if port pins didn't have any holes.
> > For example on RZ/Five port P19 we have P19_1 pin only and P19_0 is not
> > available (and similarly for port P25 we have P25_1).
>
> Maybe introduce a helper macro to address this case.
>
> #define RZG2L_GPIO_PORT_PACK_WITH_HOLES(m, n, a, f) for these 2 cases
>
> and use RZG2L_GPIO_PORT_PACK(n, a, f) for the one without holes.
>
Agreed will do.

Cheers,
Prabhakar
