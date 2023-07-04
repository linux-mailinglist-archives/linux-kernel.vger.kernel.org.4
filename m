Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3006A746C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGDIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjGDIsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:48:11 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70A107;
        Tue,  4 Jul 2023 01:48:09 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77a62a84855so214199139f.1;
        Tue, 04 Jul 2023 01:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688460489; x=1691052489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FthdFNqIrNBSp4Ff+7I5wf7NZtageiCvQNjA6zok5uo=;
        b=FWmDAOGksUr/QGz4CDArxktNgIPvc38M0/lTa2VYxzTVeVXDKhc0qoUYZD0sOXLih9
         j6RAkMSJEozSwhuSUUcBY81gGKJ8sobh71Guq2n/+i7QmSzIAf1Z83n747otQ4Rjj/kz
         2abUbgxbKbr3lra+9jHftNgHXBX7YBPK3dbY7bkTrj4QwJt1EpllB8rHiDAsrrVKsSNn
         uOGMFcoxSYxPV6fzWJ457wh3zqEXEYfCXheAyQCCWLIH/ShD4N/SdmUVJjxL+359KNfF
         VhkR0XPPey0Gp5aUvWqes8X9AwQy++ZJsuctYxSjkmNZLErWsCdv0Co/HAyqvW0sXoTi
         6YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688460489; x=1691052489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FthdFNqIrNBSp4Ff+7I5wf7NZtageiCvQNjA6zok5uo=;
        b=SBy9Jkl7QYh1gxQt8tsHFdqljSykclHaxfC9VaC2ajMauuuOx8eW+l/YDo6VG1OCRp
         hpzHwri+4H2UobrOMISBg5799yUeuKkCfoutOPG2CGLoUOaHNfJGyl/HCxEK+RkMFy6+
         BJn1/m+3qMv1poOrglzxfFdEOqeT5kAj60IAL8fVYVdvK/hArQ26bIVeajSlhUSnUPG3
         vGoTbls12s3f4E7UX7dLDiB5lUi7bno2LpWsYfD7Oia1OfauRQrAomOziz4VEb5aa9zN
         j4/P4/IgYGg/sRx3VBIGVtqImaY1mcPhw0zi0+QxXEx1aZIMlWkgRp1yJ4XWxb3gjubK
         zisg==
X-Gm-Message-State: AC+VfDwRw4ZflHhQRHaF5jH9IGVKQ3ImRS6UIam43+T66K2SdmmT+jXs
        XdprALi5kCzuINtWdCsUh1keq44+xoTLDWixnBw=
X-Google-Smtp-Source: ACHHUZ6jPnIKynBJ0oBa8Pc4sTNHuq++xhfssqh0qa7MHJnSLGSiG5AVhvinJsEW9ITj1tJfYUv+P6Ll5u31M9KK3a8=
X-Received: by 2002:a5e:8b03:0:b0:76c:56fb:3c59 with SMTP id
 g3-20020a5e8b03000000b0076c56fb3c59mr13828031iok.10.1688460489189; Tue, 04
 Jul 2023 01:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB59223E030DAE587A49C9D0FE862EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8um0xQ2FJyrHs=5Pc2PNvgW6B6z31zyFQ6zAYhi6=zgvQ@mail.gmail.com> <OS0PR01MB5922BFC7C34062876E53BBB7862EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922BFC7C34062876E53BBB7862EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 4 Jul 2023 09:47:43 +0100
Message-ID: <CA+V-a8t3PveWo==GQNPWV3cTAQebtsgKwrFvc5qJVc_RsBKcGA@mail.gmail.com>
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

On Tue, Jul 4, 2023 at 9:42=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.com=
> wrote:
>
> Hi Prabhakar,
>
> > -----Original Message-----
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Tuesday, July 4, 2023 9:36 AM
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
> > On Tue, Jul 4, 2023 at 9:30=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas=
.com>
> > wrote:
> > >
> > > Hi Prabhakar,
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
> > > > -#define RZG2L_GPIO_PORT_PACK(
>
> , a, f)        (((n) << 28) | ((a) <<
> > 20) |
> > > > (f))
> > > > +#define RZG2L_GPIO_PORT_PACK(m, n, a, f)     ((UL(m) << 32) |
> > (UL(n) << 28)
> > > > | ((a) << 20) | (f))
> > > > +#define RZG2L_GPIO_PORT_GET_PINMAP(x)        (((x) & GENMASK(39,
> > 32)) >> 32)
> > > >  #define RZG2L_GPIO_PORT_GET_PINCNT(x)        (((x) & GENMASK(30,
> > 28)) >> 28)
> > > >  #define RZG2L_GPIO_PORT_GET_INDEX(x) (((x) & GENMASK(26, 20)) >>
> > > > 20)  #define RZG2L_GPIO_PORT_GET_CFGS(x)  ((x) & GENMASK(19, 0)) @@
> > > > -129,7 +131,7 @@ struct rzg2l_dedicated_configs {
> > > >
> > > >  struct rzg2l_pinctrl_data {
> > > >       const char * const *port_pins;
> > > > -     const u32 *port_pin_configs;
> > > > +     const u64 *port_pin_configs;
> > >
> > > Can this be SoC specific? Only for RZ/Five you need this changes.
> > > Others SoCs like RZ/{G2L,G2LC,V2L and G2UL) still work with u32* as
> > > there is no holes. With this change memory usage is doubled as we
> > > change from
> > > u32->u64.
> > >
> > This is to avoid writing to undocumented registers so I have added for
> > all the SoCs. For example on the RZ/G2L SOC P0 has two pins P0_1 and
> > P0_0 but DT/SYSFS could use the P0_2-P0_7. This patch restricts users t=
o
> > use only available GPIO pins.
>
> I guess that still can be achieved, as the below macro has valid
> pins info??
>
> #define RZG2L_GPIO_PORT_GET_PINCNT(x)   (((x) & GENMASK(30, 28)) >> 28)
>
> if (!(BIT(bit) & GENMASK(RZG2L_GPIO_PORT_GET_PINCNT(x), 0))
> return -EINVAL;
>
Agreed, If Geert is OK to have SoC specific checks around I'll do the above=
.

Cheers,
Prabhakar
