Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BDB7233DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 02:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjFFAAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 20:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjFFAAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:00:31 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F1F2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 17:00:30 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565ba2c7554so52861027b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1686009629; x=1688601629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsbKSW9JVbhL1wyuCDwpF4ByVkNni40r/SR21ozZR2o=;
        b=JKH7PpcciV5tJ54qIiSmVG6eqyNgLcbYrySuyMCKnykc7DAxyKfCUBpPSFWPA03JO2
         s+/IrO15jPEpi8w3LCnjkIJIgkIMqYuM8QgyF7cl9w6+TZONOio5LbfjKpuQbSmE7VbT
         3nrwMUvlXKQsOBrZVt4AkNKV8xf1MXXJuMo6m4jA2MjzUZCfloC5wqdrKpw+cEIwlaxL
         XKhjm9IfYArC0fKXlozX1xoS/1bDSU5r9acuDV/7gHyrNayMpqU/NyiLllYzOI+ceZz6
         FhsLCYYYrQ5FAK38bkVuKeog+DSobDcT4CKUD5hxtdhR5OYjIVX4yIWSkLUDgC9TYuGJ
         /EOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009629; x=1688601629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsbKSW9JVbhL1wyuCDwpF4ByVkNni40r/SR21ozZR2o=;
        b=V/sYkXBFt7TEaOBdrML7KL66K/hUYxiLRgJI3kKVvCFQdXs4ahAk7A3oZDOegpxo+H
         FNG2Kwo4MYRSmefIIaruxfX+NM5XvF7lo+DzqzQp1RMdNv6tGThgfWRGzSBQ1BC8obl0
         4AJlw7W6F6FW358ZBLRD2LQK2vjGgIO10eRKcU3kavLVz+LAwnF/zSmbzxb+oz5Dp9F9
         0I0dUeK7mmqOZWfoySzwf9wGLstiCvj4AEqb+0uminTKJ0WhwKv8BSxf3gU8I40W3Ptx
         R9nTdr3pAJCp+pBPbCnZLMxX1CEl5y6JkCxvm145DdVLWkrx7zy7Ibhd5yX7pP5yCMfQ
         KFug==
X-Gm-Message-State: AC+VfDxPmV4ki9VrZz3pBEO3PEL0o6j3qdZwWvyDQeo+keNYTzuVXw2E
        UFwy3daIvXWML+5mD1O8CrRx39PNVanDHqfOknD7wQ==
X-Google-Smtp-Source: ACHHUZ7cC4776/Z0Kpgd/VabrciyjHzXEBo7N6V9TCllS8Nm/kQlhg8mOGFZxvcU+/wXfod3KOapjz2R88y43vElRIs=
X-Received: by 2002:a81:6645:0:b0:564:e951:a7cc with SMTP id
 a66-20020a816645000000b00564e951a7ccmr76517ywc.45.1686009629423; Mon, 05 Jun
 2023 17:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230601193112.4083934-1-tharvey@gateworks.com> <20230605002154.GT4199@dragon>
In-Reply-To: <20230605002154.GT4199@dragon>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 5 Jun 2023 17:00:18 -0700
Message-ID: <CAJ+vNU29qdtYTnby6XBJvnawbAKWc7O8uRVFBY7pPHOBRfNpxA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw74xx: update to revB PCB
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 4, 2023 at 5:22=E2=80=AFPM Shawn Guo <shawnguo@kernel.org> wrot=
e:
>
> On Thu, Jun 01, 2023 at 12:31:12PM -0700, Tim Harvey wrote:
> > Update the imx8mp-venice-gw74xx for revB:
> >  - add CAN1
> >  - add TIS-TPM on SPI2
> >  - add FAN controller
> >  - fix PMIC I2C bus (revA PMIC I2C was non-functional so no need for
> >    backward compatible option)
> >  - M2 socket GPIO's moved
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  .../dts/freescale/imx8mp-venice-gw74xx.dts    | 261 +++++++++++-------
> >  1 file changed, 159 insertions(+), 102 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/a=
rch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > index eb51d648359b..0e389ec5c2d4 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > @@ -125,12 +125,22 @@ reg_usb2_vbus: regulator-usb2 {
> >               regulator-max-microvolt =3D <5000000>;
> >       };
> >
> > +     reg_can1_stby: regulator-can1-stby {
> > +             compatible =3D "regulator-fixed";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_reg_can1>;
> > +             regulator-name =3D "can1_stby";
> > +             gpio =3D <&gpio3 19 GPIO_ACTIVE_LOW>;
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +     };
> > +
> >       reg_can2_stby: regulator-can2-stby {
> >               compatible =3D "regulator-fixed";
> >               pinctrl-names =3D "default";
> > -             pinctrl-0 =3D <&pinctrl_reg_can>;
> > +             pinctrl-0 =3D <&pinctrl_reg_can2>;
> >               regulator-name =3D "can2_stby";
> > -             gpio =3D <&gpio3 19 GPIO_ACTIVE_LOW>;
> > +             gpio =3D <&gpio5 5 GPIO_ACTIVE_LOW>;
> >               regulator-min-microvolt =3D <3300000>;
> >               regulator-max-microvolt =3D <3300000>;
> >       };
> > @@ -164,6 +174,21 @@ &A53_3 {
> >       cpu-supply =3D <&reg_arm>;
> >  };
> >
> > +&ecspi1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_spi1>;
> > +     cs-gpios =3D <&gpio5 9 GPIO_ACTIVE_LOW>;
> > +     status =3D "okay";
> > +
> > +     tpm@0 {
> > +             compatible =3D "tcg,tpm_tis-spi";
> > +             #address-cells =3D <0x1>;
> > +             #size-cells =3D <0x1>;
> > +             reg =3D <0x0>;
> > +             spi-max-frequency =3D <36000000>;
> > +     };
> > +};
> > +
> >  /* off-board header */
> >  &ecspi2 {
> >       pinctrl-names =3D "default";
> > @@ -204,6 +229,13 @@ fixed-link {
> >       };
> >  };
> >
> > +&flexcan1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_flexcan1>;
> > +     xceiver-supply =3D <&reg_can1_stby>;
> > +     status =3D "okay";
> > +};
> > +
> >  &flexcan2 {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&pinctrl_flexcan2>;
> > @@ -214,38 +246,38 @@ &flexcan2 {
> >  &gpio1 {
> >       gpio-line-names =3D
> >               "", "", "", "", "", "", "", "",
> > -             "", "", "dio0", "", "dio1", "", "", "",
> > +             "", "dio0", "", "dio1", "", "", "", "",
> >               "", "", "", "", "", "", "", "",
> >               "", "", "", "", "", "", "", "";
> >  };
> >
> >  &gpio2 {
> >       gpio-line-names =3D
> > -             "", "", "", "", "", "", "", "",
> > -             "", "", "", "", "", "", "pcie3_wdis#", "",
> > +             "", "", "", "", "", "", "m2_pin20", "",
> > +             "", "", "", "", "", "pcie1_wdis#", "pcie3_wdis#", "",
> >               "", "", "pcie2_wdis#", "", "", "", "", "",
> >               "", "", "", "", "", "", "", "";
> >  };
> >
> >  &gpio3 {
> >       gpio-line-names =3D
> > -             "m2_gdis#", "", "", "", "", "", "", "m2_rst#",
> > +             "", "", "", "", "", "", "m2_rst", "",
> > +             "", "", "", "", "", "", "", "",
> >               "", "", "", "", "", "", "", "",
> > -             "m2_off#", "", "", "", "", "", "", "",
> >               "", "", "", "", "", "", "", "";
> >  };
> >
> >  &gpio4 {
> >       gpio-line-names =3D
> > +             "", "", "m2_off#", "", "", "", "", "",
> >               "", "", "", "", "", "", "", "",
> > -             "", "", "", "", "", "", "", "",
> > -             "", "", "", "", "m2_wdis#", "", "", "",
> > -             "", "", "", "", "", "", "", "uart_rs485";
> > +             "", "", "m2_wdis#", "", "", "", "", "",
> > +             "", "", "", "", "", "", "", "rs485_en";
> >  };
> >
> >  &gpio5 {
> >       gpio-line-names =3D
> > -             "uart_half", "uart_term", "", "", "", "", "", "",
> > +             "rs485_hd", "rs485_term", "", "", "", "", "", "",
> >               "", "", "", "", "", "", "", "",
> >               "", "", "", "", "", "", "", "",
> >               "", "", "", "", "", "", "", "";
> > @@ -286,6 +318,12 @@ channel@8 {
> >                               label =3D "vdd_bat";
> >                       };
> >
> > +                     channel@16 {
> > +                             gw,mode =3D <4>;
> > +                             reg =3D <0x16>;
> > +                             label =3D "fan_tach";
> > +                     };
> > +
> >                       channel@82 {
> >                               gw,mode =3D <2>;
> >                               reg =3D <0x82>;
> > @@ -358,6 +396,11 @@ channel@a2 {
> >                               gw,voltage-divider-ohms =3D <10000 10000>=
;
> >                       };
> >               };
> > +
> > +             fan-controller@0 {
>
> The unit-address doesn't match 'reg' property below.
>
> Shawn
>

Shawn,

Thanks - I'll fix this in v2

Best Regards,

Tim
