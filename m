Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6CF6DB47E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjDGTvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDGTvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:51:42 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4364C15D;
        Fri,  7 Apr 2023 12:50:58 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id bh10so1221503uab.13;
        Fri, 07 Apr 2023 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680897051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15VVg7EMPRsSr3VfXMNN2bKdKqXwtfDwBgRapCn3qCM=;
        b=N/fm83PbbEAtdsJyjkscTvfiznPnsFgRYkY1yp+zSSS5HDweBnb6bZXIBBhVBbzE79
         yBOXm/D8iMDrfM3DrKjlm8/4VSs1JPquMZx2C8jafl3zGzWvxcdjPLqb3DAYZzSAKWZI
         9nNG7JP1mYzan86zTGhl14DokoOP1StGH6xxEyVIWXt/SlR1KMVZtaxvN0W1b+bAHENg
         lGRMVHFMmxR520URoLZYZwpnSxY8vjMBLnBFgU/xOFz09SMF/AQpG/kqFJRgNEyxe9Oa
         23Dcnh5M9xnIaJp0cnkgzkf1JfFj15iXSF3mpjmyrZQphkbkQRxZMlfI+smr/ZyRDz5d
         08Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680897051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15VVg7EMPRsSr3VfXMNN2bKdKqXwtfDwBgRapCn3qCM=;
        b=aAhOvJGxcYSnH75wsF6A9i4ZwokcC+V+IkLhWUDj/gmMnSMjQLSO73zKybRE4KCn6x
         QNr11oRXZKc2pOAI8ZzFLfUnBBNeEYQ63QPrDJkZFsV/UkeSq6QY79qxfvoOjkUrzNi0
         nd1ohznpZGkMlmzY+R2PQT9a2ZhwJnCgqSO6SAZ4yhLnBu/MBnuH9NMr4Uysy82y1f+q
         uCFlMPKUBL9fi8VcYd3NW5Mqsa+3M3a1jX6iyP48SXtLM4o58sGzcuj6wkN5RJJNN5vU
         0BltXjTm+jELYnJC+4+inSHcvFJ0qkfzDnx1RhK11PqGAk3asJnYmZ1+IoG21m96d+Dn
         wpWA==
X-Gm-Message-State: AAQBX9cddc29VE+OtLwk/kZAFN2Pn/hGUfu/Exi5Sohssx2AKKQA+RZP
        7I/TAnxusMbFc4u3SAMKgvTMmCMW7TfGu1utYyEwJVkrYdM=
X-Google-Smtp-Source: AKy350akYFXBbZug+1AtO0L3PEhHfBgG7gLCyRk6gJA/lA/W3Zs/ERqexQsneH7CqJcERga1Coy64SCkRO8cpXe+KI8=
X-Received: by 2002:a1f:278e:0:b0:433:7ae0:6045 with SMTP id
 n136-20020a1f278e000000b004337ae06045mr1751050vkn.0.1680897050688; Fri, 07
 Apr 2023 12:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230216011046.3306-1-mibodhi@gmail.com> <87h6tr3drz.fsf@BL-laptop>
In-Reply-To: <87h6tr3drz.fsf@BL-laptop>
From:   Tony Dinh <mibodhi@gmail.com>
Date:   Fri, 7 Apr 2023 12:50:38 -0700
Message-ID: <CAJaLiFyahj7F4rkrney5Gj3nKgBoJy+z0rpJK20J5+V+oUFTKw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: mvebu: Add support for Thecus N2350 board
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory,

On Fri, Apr 7, 2023 at 8:36=E2=80=AFAM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Hello Tony Dinh,
>
> > Thecus N2350 is a NAS based on Marvell Armada 385 SoC.
> >
> > Board Specification:
> >
> > - Marvel MV88F6820 Dual Core at 1GHz
> > - 1 GiB DDR4 RAM
> > - 4MB Macronix mx25l3205d SPI flash
> > - 512MB Hynix H27U4G8F2DTR-BC NAND flash
> > - I2C
> > - 2x USB 3.0
> > - 1x GBE LAN port (PHY: Marvell 88E1510)
> > - 2x SATA (hot swap slots)
> > - 3x buttons
> > - 10x LEDS
> > - serial console
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
>
> There were some comments on these series. If you already sent a second
> version I missed it, in this case could you send it again to me ?
>
> Else do you plan to send a v2 soon ?

Sorry I have been quite busy the last few weeks. I will send in v2 soon.

Thanks,
Tony

>
> Thanks,
>
> Gregory
>
>
> > ---
> >
> >  arch/arm/boot/dts/Makefile                    |   1 +
> >  arch/arm/boot/dts/armada-385-thecus-n2350.dts | 432 ++++++++++++++++++
> >  2 files changed, 433 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/armada-385-thecus-n2350.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index d08a3c450..749790e6e 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1528,6 +1528,7 @@ dtb-$(CONFIG_MACH_ARMADA_38X) +=3D \
> >       armada-385-linksys-rango.dtb \
> >       armada-385-linksys-shelby.dtb \
> >       armada-385-synology-ds116.dtb \
> > +     armada-385-thecus-n2350.dtb \
> >       armada-385-turris-omnia.dtb \
> >       armada-388-clearfog.dtb \
> >       armada-388-clearfog-base.dtb \
> > diff --git a/arch/arm/boot/dts/armada-385-thecus-n2350.dts b/arch/arm/b=
oot/dts/armada-385-thecus-n2350.dts
> > new file mode 100644
> > index 000000000..38114d842
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/armada-385-thecus-n2350.dts
> > @@ -0,0 +1,432 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Device Tree file for Thecus N2350 board
> > + *
> > + * Copyright (C) 2018-2023 Tony Dinh <mibodhi@gmail.com>
> > + * Copyright (C) 2018 Manuel Jung <manuel.jung@hotmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include "armada-385.dtsi"
> > +
> > +/ {
> > +     model =3D "Thecus N2350";
> > +     compatible =3D "thecus,n2350", "marvell,armada385";
> > +
> > +     aliases {
> > +             ethernet0 =3D &eth0;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +
> > +     memory {
> > +             device_type =3D "memory";
> > +             reg =3D <0x00000000 0x40000000>; /* 1GB */
> > +     };
> > +
> > +     soc {
> > +             ranges =3D <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> > +                       MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
> > +                       MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
> > +                       MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
> > +                       MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
> > +
> > +     };
> > +
> > +     usb3_0_phy: usb3_0_phy {
> > +             compatible =3D "usb-nop-xceiv";
> > +             vcc-supply =3D <&usb3_0_power>;
> > +     };
> > +
> > +     usb3_1_phy: usb3_1_phy {
> > +             compatible =3D "usb-nop-xceiv";
> > +             vcc-supply =3D <&usb3_1_power>;
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible =3D "gpio-keys";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             pinctrl-0 =3D <&pmx_power_button &pmx_copy_button &pmx_re=
set_button>;
> > +             pinctrl-names =3D "default";
> > +
> > +             button@1 {
> > +                     label =3D "Power Button";
> > +                     linux,code =3D <KEY_POWER>;
> > +                     gpios =3D <&gpio1 17 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             button@2 {
> > +                     label =3D "Copy Button";
> > +                     linux,code =3D <KEY_COPY>;
> > +                     gpios =3D <&gpio1 20 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             button@3 {
> > +                     label =3D "Reset Button";
> > +                     linux,code =3D <KEY_RESTART>;
> > +                     gpios =3D <&gpio1 18 GPIO_ACTIVE_HIGH>;
> > +             };
> > +     };
> > +
> > +     gpio-leds {
> > +             compatible =3D "gpio-leds";
> > +             pinctrl-0 =3D <&pmx_sata1_white_led
> > +                             &pmx_sata1_red_led
> > +                             &pmx_sata2_white_led
> > +                             &pmx_sata2_red_led
> > +                             &pmx_sys_white_led
> > +                             &pmx_sys_red_led
> > +                             &pmx_pwr_blue_led
> > +                             &pmx_pwr_red_led
> > +                             &pmx_usb_white_led
> > +                             &pmx_usb_red_led>;
> > +
> > +             pinctrl-names =3D "default";
> > +
> > +             white_sata1 {
> > +                     label =3D "n2350:white:sata1";
> > +                     gpios =3D <&gpio0 20 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             red_sata1 {
> > +                     label =3D "n2350:red:sata1";
> > +                     gpios =3D <&gpio1 14 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             white-sata2 {
> > +                     label =3D "n2350:white:sata2";
> > +                     gpios =3D <&gpio0 19 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             red-sata2 {
> > +                     label =3D "n2350:red:sata2";
> > +                     gpios =3D <&gpio1 15 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             white-sys {
> > +                     label =3D "n2350:white:sys";
> > +                     gpios =3D <&gpio0 14 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger =3D "default-on";
> > +             };
> > +
> > +             red-sys {
> > +                     label =3D "n2350:red:sys";
> > +                     gpios =3D <&gpio0 15 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             blue-pwr {
> > +                     label =3D "n2350:blue:pwr";
> > +                     gpios =3D <&gpio1 11 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             red-pwr {
> > +                     label =3D "n2350:red:pwr";
> > +                     gpios =3D <&gpio0 18 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             white-usb {
> > +                     label =3D "n2350:white:usb";
> > +                     gpios =3D <&gpio0 16 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             red-usb {
> > +                     label =3D "n2350:red:usb";
> > +                     gpios =3D <&gpio0 17 GPIO_ACTIVE_HIGH>;
> > +             };
> > +     };
> > +
> > +     usb3_0_power: regulator@1 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "USB3_0_Power";
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             enable-active-high;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             gpio =3D <&gpio0 21 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +     usb3_1_power: regulator@2 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "USB3_1_Power";
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             enable-active-high;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             gpio =3D <&gpio0 24 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +     reg_sata0: regulator@3 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "pwr_en_sata0";
> > +             regulator-min-microvolt =3D <12000000>;
> > +             regulator-max-microvolt =3D <12000000>;
> > +             enable-active-high;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             gpio =3D <&gpio1 12 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +     reg_5v_sata0: v5-sata0 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "v5.0-sata0";
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             vin-supply =3D <&reg_sata0>;
> > +     };
> > +
> > +     reg_12v_sata0: v12-sata0 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "v12.0-sata0";
> > +             regulator-min-microvolt =3D <12000000>;
> > +             regulator-max-microvolt =3D <12000000>;
> > +             vin-supply =3D <&reg_sata0>;
> > +     };
> > +
> > +     reg_sata1: regulator@4 {
> > +             regulator-name =3D "pwr_en_sata1";
> > +             compatible =3D "regulator-fixed";
> > +             regulator-min-microvolt =3D <12000000>;
> > +             regulator-max-microvolt =3D <12000000>;
> > +             enable-active-high;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             gpio =3D <&gpio1 13 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +     reg_5v_sata1: v5-sata1 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "v5.0-sata1";
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             vin-supply =3D <&reg_sata1>;
> > +     };
> > +
> > +     reg_12v_sata1: v12-sata1 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "v12.0-sata1";
> > +             regulator-min-microvolt =3D <12000000>;
> > +             regulator-max-microvolt =3D <12000000>;
> > +             vin-supply =3D <&reg_sata1>;
> > +     };
> > +
> > +     gpio-poweroff {
> > +             compatible =3D "gpio-poweroff";
> > +             pinctrl-0 =3D <&pmx_pwr_off>;
> > +             pinctrl-names =3D "default";
> > +             gpios =3D <&gpio1 22 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +};
> > +
> > +&ahci0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&bm {
> > +     status =3D "okay";
> > +};
> > +
> > +&bm_bppi {
> > +     status =3D "okay";
> > +};
> > +
> > +&eth0 {
> > +     status =3D "okay";
> > +     phy =3D <&phy0>;
> > +     phy-mode =3D "sgmii";
> > +     buffer-manager =3D <&bm>;
> > +     bm,pool-long =3D <0>;
> > +     bm,pool-short =3D <1>;
> > +};
> > +
> > +&i2c0 {
> > +     status =3D "okay";
> > +     clock-frequency =3D <100000>;
> > +};
> > +
> > +&i2c1 {
> > +     status =3D "okay";
> > +     clock-frequency =3D <100000>;
> > +};
> > +
> > +&mdio {
> > +     phy0: ethernet-phy@0 {
> > +             reg =3D <1>;
> > +     };
> > +};
> > +
> > +&nand_controller {
> > +     status =3D "okay";
> > +
> > +     nand@0 {
> > +             status =3D "okay";
> > +             reg =3D <0>;
> > +             label =3D "pxa3xx_nand-0";
> > +             nand-rb =3D <0>;
> > +             marvell,nand-keep-config;
> > +             nand-on-flash-bbt;
> > +             nand-ecc-strength =3D <4>;
> > +             nand-ecc-step-size =3D <512>;
> > +
> > +             partitions {
> > +                     compatible =3D "fixed-partitions";
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +
> > +                     partition@0 {
> > +                             label =3D "rootfs";
> > +                             reg =3D <0x00000000 0x20000000>;
> > +                     };
> > +
> > +             };
> > +     };
> > +};
> > +
> > +&pciec {
> > +     status =3D "okay";
> > +     pcie@1,0 {
> > +             /* Port 0, Lane 0 */
> > +             status =3D "okay";
> > +     };
> > +     pcie@2,0 {
> > +             /* Port 1, Lane 0 */
> > +             status =3D "okay";
> > +     };
> > +};
> > +
> > +&pinctrl {
> > +     pinctrl-names =3D "default";
> > +
> > +     pmx_power_button: pmx-power-button {
> > +             marvell,pins =3D "mpp49";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_copy_button: pmx-copy-button {
> > +             marvell,pins =3D "mpp52";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_reset_button: pmx-reset-button {
> > +             marvell,pins =3D "mpp50";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_sata1_white_led: pmx-sata1-white-led {
> > +             marvell,pins =3D "mpp20";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_sata1_red_led: pmx-sata1-red-led {
> > +             marvell,pins =3D "mpp46";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_sata2_white_led: pmx-sata2-white-led {
> > +             marvell,pins =3D "mpp19";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_sata2_red_led: pmx-sata2-red-led {
> > +             marvell,pins =3D "mpp47";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_sys_white_led: pmx-sys-white-led {
> > +             marvell,pins =3D "mpp14";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_sys_red_led: pmx-sys-red-led {
> > +             marvell,pins =3D "mpp15";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_buzzer: pmx-buzzer {
> > +             marvell,pins =3D "mpp51";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_pwr_off: pmx-pwr-off {
> > +             marvell,pins =3D "mpp54";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_pwr_blue_led: pmx-pwr-blue-led {
> > +             marvell,pins =3D "mpp43";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_pwr_red_led: pmx-pwr-red-led {
> > +             marvell,pins =3D "mpp18";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_usb_white_led: pmx-usb-white-led {
> > +             marvell,pins =3D "mpp16";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     pmx_usb_red_led: pmx-usb-red-led {
> > +             marvell,pins =3D "mpp17";
> > +             marvell,function =3D "gpio";
> > +     };
> > +};
> > +
> > +&sdhci {
> > +     broken-cd;
> > +     wp-inverted;
> > +     bus-width =3D <8>;
> > +     status =3D "okay";
> > +     no-1-8-v;
> > +};
> > +
> > +&spi1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&spi1_pins>;
> > +     status =3D "okay";
> > +
> > +     /* spi: 4M Flash Macronix MX25L3205D */
> > +     spi-flash@0 {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             compatible =3D "macronix,mx25l3205d", "jedec,spi-nor";
> > +             reg =3D <0>;
> > +
> > +             spi-max-frequency =3D <108000000>;
> > +             spi-cpha;
> > +
> > +             partition@0 {
> > +                     label =3D "u-boot";
> > +                     reg =3D <0x00000000 0x00100000>;
> > +             };
> > +
> > +             partition@100000 {
> > +                     label =3D "u-boot-env";
> > +                     reg =3D <0x00100000 0x00010000>;
> > +             };
> > +     };
> > +};
> > +
> > +&uart0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&usb0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&usb3_0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&usb3_1 {
> > +     status =3D "okay";
> > +};
> > --
> > 2.30.2
> >
>
> --
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
