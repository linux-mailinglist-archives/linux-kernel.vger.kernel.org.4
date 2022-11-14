Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B8628998
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiKNToD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:44:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7234DD2;
        Mon, 14 Nov 2022 11:43:59 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f27so30960578eje.1;
        Mon, 14 Nov 2022 11:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lU8I1P144GvSOhwHiZF6qw5ZelJMRGo16i0gCB6ZbAM=;
        b=bR1L+UlHr3QKkLGgGZ2pyKctJem3JL1fPGYnXMJd8TLY8QIU4LdJegcDenb7M/LT93
         9MemmtH1mJ03iXCS7+x7Ze4MPBTMIcL+B5SLEtYpaGHLXf/GHUa+dT83fz76Xb3461tI
         dDV2q2JbIzWomlu5oPoYitlLZB9X6Jc82PG3FBP3Si8hk8ndMXCcwz30ItzzkFUi/AvZ
         ZVizNIkQpZwjjdhfy3aISr2kuOHh9qv6vsG6u/UFnwi3rMdTW+LgrczklVtTHJ1GusWK
         4s2uDxm9Tr4NuUZQToxYjfJWbNTaCSm0VXILqEzN3OSEwJfXKhfNUtMkL5Fs5c8xVWEI
         oNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU8I1P144GvSOhwHiZF6qw5ZelJMRGo16i0gCB6ZbAM=;
        b=vR87hFFYTKmudAsjDssYUE9sbvN4t5GIAV1fyGejKWSLYRVkxnUSwKKg8bxeD6Q95h
         QQr/gAciWFxrsD1HWs3RZmDYpKDKipj7y43GG3e234t90dU2RNQy0GhLAAGX4+wQYIi4
         TOFqS0mczCbtsXk+wpTDBRADnP2yrEf2eaz39Z45KkxhBScbhm8bWtNVEkbIhmeWND1Y
         3O2Ry/oGiDwefIHCN7mFXyqkfH2Yjh8XQXkWiv3eM9ZrOadp8stmy3hiwETX9/6Hv/rA
         zaoP0VS3895Q8XsZoRIXOzfQ1k0aULhsm4RZq3TpOmmrxaHV2uii7omZ/fxYhv6uARE7
         mj5Q==
X-Gm-Message-State: ANoB5pkqKdSRx9Mz0Vr+BB3dBNtct4tap/yuO2b6bXKk4doE2/5FMVar
        OboyAuqmZ1ntJB4ODsD7DLLeOTcw+sU0sq7IKcU=
X-Google-Smtp-Source: AA0mqf5KSDFDdVvVaUgXYBZ51jpGMS7kYfrL+SL1hM7TaQUcSLcFWlzUSChWh34nplA1/Z0b4woIhLCjvUux5OMl4rI=
X-Received: by 2002:a17:907:9d03:b0:7ae:87ef:d9a6 with SMTP id
 kt3-20020a1709079d0300b007ae87efd9a6mr11402944ejc.397.1668455037871; Mon, 14
 Nov 2022 11:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20221112143411.517906-1-maccraft123mc@gmail.com>
 <20221112143411.517906-6-maccraft123mc@gmail.com> <63724f51.9d0a0220.bdb2c.ea2e@mx.google.com>
In-Reply-To: <63724f51.9d0a0220.bdb2c.ea2e@mx.google.com>
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
Date:   Mon, 14 Nov 2022 20:43:21 +0100
Message-ID: <CAO_MupKPXJhmK5+eCf5dotCHBEesHFRtQuPt=3h1+SrqR+dygA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: rockchip: Add Anbernic RG351M
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?B?Sm/Do28gSCAuIFNwaWVz?= <jhlspies@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 14 lis 2022 o 15:23 Chris Morgan <macroalpha82@gmail.com> napisa=C5=
=82(a):
>
> On Sat, Nov 12, 2022 at 03:34:11PM +0100, Maya Matuszczyk wrote:
> > This device is a clone of Odroid Go Advance, with added PWM motor, inte=
rnal
> > gamepad connected on USB instead of just having it be on GPIO + ADC, an=
d
> > missing battery shunt resistor.
>
> I have concerns about using the rk817 battery driver with no shunt
> resistor. For the moment, that would result in wrong values being
> given for battery capacity and current. What could be done is to
> update the driver to only check voltage values when the shunt
> resistor is missing (since it's the current values and columb counter
> that gets affected with no resistor in place). For now though, I'd
> just remove the battery and charger since it's going to report the
> wrong data to users.
I guess that's fair... the device literally has no shunt resistor and DT
should reflect hardware.

>
> >
> > There's also an LED on GPIO 77(I *guess* PB5 on &gpio2), that is contro=
lled in a weird way:
> >
> > - It is set to red by setting output value to 1
> > - Set to green by setting output value to 0
> > - Set to yellow by setting gpio direction to input
> >
> > I have no idea how to describe that in DTS, without adding a custom
> > driver, for now it's just left out.
>
> Check out this document, it says you'd group them together under a
> multicolor led node:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/leds/leds-class-multicolor.yaml
As far as I know there is no support to controlling LED in a way that this
device requires the LED to be controlled.
It's just one GPIO, and setting it to outputting 0, outputting 1 or to inpu=
t
changes the color and there's no way to turn it off.

Best Regards,
Maya Matuszczyk
>
> >
> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
> >  .../dts/rockchip/rk3326-anbernic-rg351m.dts   | 54 +++++++++++++++++++
> >  2 files changed, 55 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m=
.dts
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dt=
s/rockchip/Makefile
> > index 142c83d2e5aa..b379516c15eb 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3308-evb.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3308-roc-cc.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3308-rock-pi-s.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3318-a95x-z2.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3326-anbernic-rg351m.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3326-odroid-go2.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3326-odroid-go2-v11.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3326-odroid-go3.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts b/=
arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
> > new file mode 100644
> > index 000000000000..7f4726d4130e
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2019 Hardkernel Co., Ltd
> > + * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
> > + * Copyright (c) 2022 Maya Matuszczyk <maccraft123mc@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +#include "rk3326-odroid-go.dtsi"
> > +
> > +/ {
> > +     model =3D "Anbernic RG351M";
> > +     compatible =3D "anbernic,rg351m", "rockchip,rk3326";
> > +
> > +     battery: battery {
> > +             compatible =3D "simple-battery";
> > +             charge-full-design-microamp-hours =3D <3450000>;
> > +             charge-term-current-microamp =3D <300000>;
> > +             constant-charge-current-max-microamp =3D <2000000>;
> > +             constant-charge-voltage-max-microvolt =3D <4200000>;
> > +             factory-internal-resistance-micro-ohms =3D <100000>;
> > +             voltage-max-design-microvolt =3D <4100000>;
> > +             voltage-min-design-microvolt =3D <3500000>;
> > +
> > +             ocv-capacity-celsius =3D <20>;
> > +             ocv-capacity-table-0 =3D  <4046950 100>, <4001920 95>, <3=
967900 90>, <3919950 85>,
> > +                                     <3888450 80>, <3861850 75>, <3831=
540 70>, <3799130 65>,
> > +                                     <3768190 60>, <3745650 55>, <3726=
610 50>, <3711630 45>,
> > +                                     <3696720 40>, <3685660 35>, <3674=
950 30>, <3663050 25>,
> > +                                     <3649470 20>, <3635260 15>, <3616=
920 10>, <3592440 5>,
> > +                                     <3574170 0>;
> > +     };
> > +
> > +     vibrator {
> > +             compatible =3D "pwm-vibrator";
> > +             pwms =3D <&pwm0 0 1000000 0>;
> > +             pwm-names =3D "enable";
> > +     };
> > +};
> > +
> > +/delete-node/ &builtin_gamepad;
> > +/delete-node/ &vcc_host; /* conflicts with pwm vibration motor */
> > +
> > +&internal_display {
> > +     compatible =3D "elida,kd35t133";
> > +};
> > +
> > +&pwm0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&rk817_charger {
> > +     monitored-battery =3D <&battery>;
> > +};
> > --
> > 2.38.1
> >
