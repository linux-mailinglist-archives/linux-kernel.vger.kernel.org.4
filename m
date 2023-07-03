Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1DE745C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGCMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCMnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:43:33 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39B9BC;
        Mon,  3 Jul 2023 05:43:32 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-345db6c12b4so16740205ab.0;
        Mon, 03 Jul 2023 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688388212; x=1690980212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcEoocC19pvVvckXEfOwPq0UrW7yuRC8cKDF3dCYEz4=;
        b=Xknf2hwH10pOXp2JSYKV5VMG25V29YwSCtAF1bztkGfwW1rGJHKDMcWVI7c1RRZJtz
         wdtoI40NHgRDbD0DvHw/0gUjHO4pnAdQRAeMWEByAK+mqgBCTExDYRuuisz4c6LcH7Cu
         lbefqBP2iBDZRZM6GhsVbEahUoSxwXYqWi0i1JQiaDvEpo6NgDzET3zJpDesMnb9lcu8
         S2q1OYub0sdyeWS65VHBzhH6gIgGynBzeCJ1WwVCfzFyFItirpwAAAcfu41D8PGbVEyF
         UbeXgx3xtNy+8lD8iBLNS9HwmTP3xMrvFva1f1h3lfDYQyj0Gh7/4jsJablMW5y0+HtK
         X0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388212; x=1690980212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcEoocC19pvVvckXEfOwPq0UrW7yuRC8cKDF3dCYEz4=;
        b=MnHxA/gXIpQHDW7COsXDdJQO0oe60mzYXx0S6o9AclECjkB/YHptb7WwoTvhrEP1ZM
         2RjkLG64RoTN66CZ1yf3wLc7QhRkLw1iXKgVvG90hXgNBw0EYP3tGWVl6st6fB0No3pA
         jeqw+n3HLoGbMpdR5g9T6leOQChe9jM5DXVJ8nBcr95HgqyCwlCVibNXCIZw7WoWjgHu
         q5FkTSVwjwe88KGwFrrueL8zaQu5imZC6zNlpdMZOP9V6aNPY57tcUMuoM93uSlCMGqh
         i5VvIVqf9K1NqPttVkKoY+3oD/IWMTNk2IsKJZaS4wyiTMtO1sqdmaUbcJkPoZSf0sXj
         cifA==
X-Gm-Message-State: AC+VfDw2KZpvrBe4IF+3LLx3CluzgFkawSGLsJavHIY9fXJUHxl2vc6e
        Yw1CyV2mYkZvsZmlyJtmD/WRRSzsVmlUcAHIgh8=
X-Google-Smtp-Source: ACHHUZ5Zk75GyTJn8VfVPthaCVH4awdI5bmJizAK7v91XelWS1kU8rpKLdAAWEQH3wcA/yiXqvhxLSQ+BwE8f0ktwnw=
X-Received: by 2002:a6b:7a02:0:b0:785:d017:c16f with SMTP id
 h2-20020a6b7a02000000b00785d017c16fmr11368650iom.14.1688388212208; Mon, 03
 Jul 2023 05:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB592217C4028606B67B39C6858629A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592217C4028606B67B39C6858629A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 3 Jul 2023 13:43:06 +0100
Message-ID: <CA+V-a8sXcHP2AYYLLONLLBDVctMb=fnU=D4+6hNoHGx5Dk2O3Q@mail.gmail.com>
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

Thank you for the review.

On Mon, Jul 3, 2023 at 12:42=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch.
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
>
> I guess, you can still achieve RZG2L_GPIO_PORT_PACK(n, a, f) with
> ((UL(PINMAP(n)) << 32) | (UL(n) << 28) | ((a) << 20) | (f))
>
> #define PINMAP(n) GENMASK(n,0) ?? Then you don't need to modify rzg2l_gpi=
o_configs.
>
Good point, but this would work if port pins didn't have any holes.
For example on RZ/Five port P19 we have P19_1 pin only and P19_0 is
not available (and similarly for port P25 we have P25_1).

Cheers,
Prabhakar
