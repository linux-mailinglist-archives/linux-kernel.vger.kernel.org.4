Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705CB699EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjBPVZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBPVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:25:49 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D30D4BE88;
        Thu, 16 Feb 2023 13:25:47 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id h10so3385958vsu.11;
        Thu, 16 Feb 2023 13:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZD10K8mNM34ErBkCYs7buk9tHYA6JKPC1Z4GBHwEyU=;
        b=htQ8NjnLKw9Ot+FQA5iKBl1rwmJRaUs9R2MLSEGnlVLIFMfifRYixsBMoYEsYDpbAA
         M39l1HvIwJWDkfq8F/7ckPgWjOxEnZie2w7OjHt7QEmginuugvlFfKuGe4JRvKplwMrA
         q/C2zAVodyQok/qEusJkNdq18vQSGzczS6iLomgT+xzD6vg0V6VlxOuQvqPWVDAW91DN
         WcLV5XdNvE9jz7GtDJ3XHeh0bOSs5GHwCOuv8ZJNqywB16WEgnxy0ngfe9IJfZZvb066
         uHDsUvZB0JGbEXV6waWAyc0KKET30AIBMw6Zd7hyHieoJ8qLU3sAa2ojvYnZNHVtA0Lk
         xKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZD10K8mNM34ErBkCYs7buk9tHYA6JKPC1Z4GBHwEyU=;
        b=t7jkOyLDOdkqoalwxixHZfJ+23nI1sEIPj1ijmp1JUZPAJVPQNUKlTFUa9aqDxYE87
         mhNqXRf9vXXKM5dPKIb/AmfzIdE9xr04JnCZ8V1tePwOhEmKybBiNY9soSdatXDzLYIB
         SjGn4s+8LRhBERA32oQNFkTBD1iR9RlpeRIT/5X1Q9aKPEYdq3zcEe+3Fl8NVyr/YNAZ
         asgsh+5fhBR0BFfY6hpn4PhYmLxFmorsMVp7SEoeK5G/l/kOFXewGQAjBBDowugDrmiT
         o2OAsY4M+WINDoiOeh9nKztfCjESoNiWnntr3mms7AyZaxlxRwrAJYY8Y/rj6hbymZOg
         MzQQ==
X-Gm-Message-State: AO0yUKW3ReNqLPuYXmUoSAvGOP5IZTDPTIDl59xPlT0W9iG6adczX/eh
        67VEOli+iTZ3US8FHkv94K+QLokzwtNSqpvNGmDeTT6mrKA=
X-Google-Smtp-Source: AK7set/p7xF5r3H8lGGDVUv9/arHAW/l1a1JFQ4wJJRiHLjGWOir6jLNENACwgrC0SH38xV7XjQ12ZSTQVs000lSlmk=
X-Received: by 2002:a67:f4c2:0:b0:401:1444:817c with SMTP id
 s2-20020a67f4c2000000b004011444817cmr1559761vsn.17.1676582746423; Thu, 16 Feb
 2023 13:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20230216011046.3306-1-mibodhi@gmail.com> <b9af4410-2352-b5f1-0fa8-8fc481001065@linaro.org>
In-Reply-To: <b9af4410-2352-b5f1-0fa8-8fc481001065@linaro.org>
From:   Tony Dinh <mibodhi@gmail.com>
Date:   Thu, 16 Feb 2023 13:25:33 -0800
Message-ID: <CAJaLiFypS2wtsj65D1WrSjsgDeN+jpUVYcbvOHdiYvneiCK_Aw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: mvebu: Add support for Thecus N2350 board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, soc@kernel.org
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

Hi Andrew,
Hi Krzysztof,

On Thu, Feb 16, 2023 at 12:31 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/02/2023 02:10, Tony Dinh wrote:
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
> > @@ -1528,6 +1528,7 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
> >       armada-385-linksys-rango.dtb \
> >       armada-385-linksys-shelby.dtb \
> >       armada-385-synology-ds116.dtb \
> > +     armada-385-thecus-n2350.dtb \
> >       armada-385-turris-omnia.dtb \
> >       armada-388-clearfog.dtb \
> >       armada-388-clearfog-base.dtb \
> > diff --git a/arch/arm/boot/dts/armada-385-thecus-n2350.dts b/arch/arm/boot/dts/armada-385-thecus-n2350.dts
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
> > +     model = "Thecus N2350";
> > +     compatible = "thecus,n2350", "marvell,armada385";
>
> Missing vendor prefix documentation. I wanted to say: "missing new
> compatible documentation", but seems Marvell is missing these. Let's
> start documenting at least new compatibles in YAML? Like Rob proposed
> here for OMAP:
> https://lore.kernel.org/all/20230209173534.GA539622-robh@kernel.org/

I was under the impression that the Documentation patch has to be a
separate patch, as stated in
Documentation/devicetree/bindings/submitting-patches.rst. Should I
include documentation in this add-support patch?

>
> > +
> > +     aliases {
> > +             ethernet0 = &eth0;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path = "serial0:115200n8";
> > +     };
> > +
> > +     memory {
> > +             device_type = "memory";
> > +             reg = <0x00000000 0x40000000>; /* 1GB */
> > +     };
> > +
> > +     soc {
> > +             ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> > +                       MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
> > +                       MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
> > +                       MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
> > +                       MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
> > +
> > +     };
> > +
> > +     usb3_0_phy: usb3_0_phy {
>
> No underscores in node names. Generic node names, so usb-phy. Also this
> misses several properties, so:
>
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
>
> > +             compatible = "usb-nop-xceiv";
> > +             vcc-supply = <&usb3_0_power>;
> > +     };
> > +
> > +     usb3_1_phy: usb3_1_phy {
>
> Same problems.
>
> > +             compatible = "usb-nop-xceiv";
> > +             vcc-supply = <&usb3_1_power>;
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible = "gpio-keys";
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
>
> These are not valid.
>
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
>
> > +             pinctrl-0 = <&pmx_power_button &pmx_copy_button &pmx_reset_button>;
> > +             pinctrl-names = "default";
> > +
> > +             button@1 {
>
> button-1
>
> > +                     label = "Power Button";
> > +                     linux,code = <KEY_POWER>;
> > +                     gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             button@2 {
>
> button-2
>
> > +                     label = "Copy Button";
> > +                     linux,code = <KEY_COPY>;
> > +                     gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             button@3 {
> > +                     label = "Reset Button";
> > +                     linux,code = <KEY_RESTART>;
> > +                     gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
> > +             };
> > +     };
> > +
> > +     gpio-leds {
> > +             compatible = "gpio-leds";
> > +             pinctrl-0 = <&pmx_sata1_white_led
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
> > +             pinctrl-names = "default";
> > +
> > +             white_sata1 {
>
> No underscores in node names. Incorrect name - missing led:
>
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
>
> > +                     label = "n2350:white:sata1";
> > +                     gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             red_sata1 {
> > +                     label = "n2350:red:sata1";
> > +                     gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             white-sata2 {
> > +                     label = "n2350:white:sata2";
> > +                     gpios = <&gpio0 19 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             red-sata2 {
> > +                     label = "n2350:red:sata2";
> > +                     gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             white-sys {
> > +                     label = "n2350:white:sys";
> > +                     gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger = "default-on";
> > +             };
> > +
> > +             red-sys {
> > +                     label = "n2350:red:sys";
> > +                     gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             blue-pwr {
> > +                     label = "n2350:blue:pwr";
> > +                     gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             red-pwr {
> > +                     label = "n2350:red:pwr";
> > +                     gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             white-usb {
> > +                     label = "n2350:white:usb";
> > +                     gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             red-usb {
> > +                     label = "n2350:red:usb";
> > +                     gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
> > +             };
> > +     };
> > +
> > +     usb3_0_power: regulator@1 {
>
> Incorrect unit address. This does not pass `make dtbs W=1` at all...
>
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "USB3_0_Power";
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +             enable-active-high;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +     usb3_1_power: regulator@2 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "USB3_1_Power";
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +             enable-active-high;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             gpio = <&gpio0 24 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +     reg_sata0: regulator@3 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "pwr_en_sata0";
> > +             regulator-min-microvolt = <12000000>;
> > +             regulator-max-microvolt = <12000000>;
> > +             enable-active-high;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +     reg_5v_sata0: v5-sata0 {
>
> And here you stopped using unit addresses? At least code thing
> consistently...
>
> Missing generic prefix - regulator.
>
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "v5.0-sata0";
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +             vin-supply = <&reg_sata0>;
> > +     };
> > +
> > +     reg_12v_sata0: v12-sata0 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "v12.0-sata0";
> > +             regulator-min-microvolt = <12000000>;
> > +             regulator-max-microvolt = <12000000>;
> > +             vin-supply = <&reg_sata0>;
> > +     };
> > +
> > +     reg_sata1: regulator@4 {
>
> And now back to unit addresses...
>
> > +             regulator-name = "pwr_en_sata1";
> > +             compatible = "regulator-fixed";
> > +             regulator-min-microvolt = <12000000>;
> > +             regulator-max-microvolt = <12000000>;
> > +             enable-active-high;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +     reg_5v_sata1: v5-sata1 {
>
> And not :)
>
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "v5.0-sata1";
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +             vin-supply = <&reg_sata1>;
> > +     };
> > +
> > +     reg_12v_sata1: v12-sata1 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "v12.0-sata1";
> > +             regulator-min-microvolt = <12000000>;
> > +             regulator-max-microvolt = <12000000>;
> > +             vin-supply = <&reg_sata1>;
> > +     };
> > +
> > +     gpio-poweroff {
> > +             compatible = "gpio-poweroff";
> > +             pinctrl-0 = <&pmx_pwr_off>;
> > +             pinctrl-names = "default";
> > +             gpios = <&gpio1 22 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +};
> > +
> > +&ahci0 {
> > +     status = "okay";
> > +};
> > +
> > +&bm {
> > +     status = "okay";
> > +};
> > +
> > +&bm_bppi {
> > +     status = "okay";
> > +};
> > +
> > +&eth0 {
> > +     status = "okay";
> > +     phy = <&phy0>;
> > +     phy-mode = "sgmii";
> > +     buffer-manager = <&bm>;
> > +     bm,pool-long = <0>;
> > +     bm,pool-short = <1>;
> > +};
> > +
> > +&i2c0 {
> > +     status = "okay";
> > +     clock-frequency = <100000>;
> > +};
> > +
> > +&i2c1 {
> > +     status = "okay";
> > +     clock-frequency = <100000>;
> > +};
> > +
> > +&mdio {
> > +     phy0: ethernet-phy@0 {
> > +             reg = <1>;
> > +     };
> > +};
> > +
> > +&nand_controller {
> > +     status = "okay";
> > +
> > +     nand@0 {
> > +             status = "okay";
>
> okay is by default. Do you need this?
>
> > +             reg = <0>;
> > +             label = "pxa3xx_nand-0";
> > +             nand-rb = <0>;
> > +             marvell,nand-keep-config;
> > +             nand-on-flash-bbt;
> > +             nand-ecc-strength = <4>;
> > +             nand-ecc-step-size = <512>;
> > +
> > +             partitions {
> > +                     compatible = "fixed-partitions";
> > +                     #address-cells = <1>;
> > +                     #size-cells = <1>;
> > +
> > +                     partition@0 {
> > +                             label = "rootfs";
> > +                             reg = <0x00000000 0x20000000>;
> > +                     };
> > +
> > +             };
> > +     };
> > +};
> > +
> > +&pciec {
> > +     status = "okay";
> > +     pcie@1,0 {
> > +             /* Port 0, Lane 0 */
> > +             status = "okay";
> > +     };
> > +     pcie@2,0 {
> > +             /* Port 1, Lane 0 */
> > +             status = "okay";
> > +     };
> > +};
> > +
> > +&pinctrl {
> > +     pinctrl-names = "default";
> > +
> > +     pmx_power_button: pmx-power-button {
> > +             marvell,pins = "mpp49";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_copy_button: pmx-copy-button {
> > +             marvell,pins = "mpp52";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_reset_button: pmx-reset-button {
> > +             marvell,pins = "mpp50";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_sata1_white_led: pmx-sata1-white-led {
> > +             marvell,pins = "mpp20";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_sata1_red_led: pmx-sata1-red-led {
> > +             marvell,pins = "mpp46";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_sata2_white_led: pmx-sata2-white-led {
> > +             marvell,pins = "mpp19";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_sata2_red_led: pmx-sata2-red-led {
> > +             marvell,pins = "mpp47";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_sys_white_led: pmx-sys-white-led {
> > +             marvell,pins = "mpp14";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_sys_red_led: pmx-sys-red-led {
> > +             marvell,pins = "mpp15";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_buzzer: pmx-buzzer {
> > +             marvell,pins = "mpp51";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_pwr_off: pmx-pwr-off {
> > +             marvell,pins = "mpp54";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_pwr_blue_led: pmx-pwr-blue-led {
> > +             marvell,pins = "mpp43";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_pwr_red_led: pmx-pwr-red-led {
> > +             marvell,pins = "mpp18";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_usb_white_led: pmx-usb-white-led {
> > +             marvell,pins = "mpp16";
> > +             marvell,function = "gpio";
> > +     };
> > +
> > +     pmx_usb_red_led: pmx-usb-red-led {
> > +             marvell,pins = "mpp17";
> > +             marvell,function = "gpio";
> > +     };
> > +};
> > +
> > +&sdhci {
> > +     broken-cd;
> > +     wp-inverted;
> > +     bus-width = <8>;
> > +     status = "okay";
> > +     no-1-8-v;
> > +};
> > +
> > +&spi1 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&spi1_pins>;
> > +     status = "okay";
> > +
> > +     /* spi: 4M Flash Macronix MX25L3205D */
> > +     spi-flash@0 {
>
> Isn't this just flash?
>
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
>
>
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +             compatible = "macronix,mx25l3205d", "jedec,spi-nor";
> > +             reg = <0>;
>
> Put compatible first, reg as second. Then the rest.
> > +
> > +             spi-max-frequency = <108000000>;
> > +             spi-cpha;
> > +
> > +             partition@0 {
> > +                     label = "u-boot";
> > +                     reg = <0x00000000 0x00100000>;
> > +             };
> > +
> > +             partition@100000 {
> > +                     label = "u-boot-env";
> > +                     reg = <0x00100000 0x00010000>;
> > +             };
> > +     };
> > +};
> > +
> > +&uart0 {
> > +     status = "okay";
> > +};
> > +
> > +&usb0 {
> > +     status = "okay";
> > +};
> > +
> > +&usb3_0 {
> > +     status = "okay";
> > +};
> > +
> > +&usb3_1 {
> > +     status = "okay";
> > +};

Thanks for the reviews! I will submit the V2 patch.

All the best,
Tony

> Best regards,
> Krzysztof
>
