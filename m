Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608AF5B600C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiILSQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiILSQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:16:20 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37B5422F2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:16:18 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1274ec87ad5so25679171fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oekw6kZjcCeqsI7HX9Z3i9C/xLekyt/H98jp4dKJ06w=;
        b=mlGfmSDapv/J/8Sn8FZzdvlTtfbWN5Gw5LLg8U31Gp/JWi++16eTt0UTphXcibiSiE
         D+uZT2qnSsAgTvNXTGfcEgpDeRz5B42TZ8+3LoeZrAUyzvxHgO8G26Pwx6yhmhnu/VBP
         hEng49xD7Aewkk2NgIpBPHPxU6XMprn63woFuHEmhxOMEFHq4xGWHF/rrkttpRRaH8YI
         bZ8qGJU2fpz16jMaUdUrgXoitpaWb6i0ypBfaDQ8p6PpjkH0kxqf6o0YDze+ua4Mw4dS
         zMDW6GXWLaUXLxXab41R173WxI+rNG1brxX4hKbipHbIkpwFF8FkQuvlzlUGBtH/plZX
         ZTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oekw6kZjcCeqsI7HX9Z3i9C/xLekyt/H98jp4dKJ06w=;
        b=K3iaz1DstunRtsRcG1zQsny0lQ2MBUx/luClN3+F2ECAdvC5/aorzlKIcldmmTfCvI
         ScX6UJ7A3etdmOXiydApVy860cwHZ4WrZD2t0B7c0R9Zud7JUqbDBKrP1HwRqayqkKvK
         gb8PZjcbytnpGMmNtOQjS0tQ6Ko4h/oKoV0LETf6fFizei/iI6SMSgbl3A62xgkahAyN
         iMzRYCtdygbQ8vXlNrNyovAGXKmqHsCl3vcFyhhVvhga5tkU32nHhCfnSNCxpAS7NkQ/
         aeeO4t8r8wgO0Xj502I7fqoBwnCUmBEfIEGrKi3VpDn6kaut8BO5F9RoPF4Z2nfB8siz
         VS9g==
X-Gm-Message-State: ACgBeo3qqZNCSzzTj6zkZlDuOnEnu4olcyIL4E+RGg68uq330+WBf64O
        yhNHbN3lAVV5G+7bC7SydugRtuL/7uNMlV5NRaKbag==
X-Google-Smtp-Source: AA6agR4Hjm/5Kqd95B1nov/ZCMFXXJn1itM0FAwvnUN4UDyBjC6BGjIcsudnQ9QX7b2dAo5SNGN9oaTBh3zYN0Bp1X0=
X-Received: by 2002:a05:6870:b511:b0:12b:5871:2129 with SMTP id
 v17-20020a056870b51100b0012b58712129mr5786992oap.80.1663006578179; Mon, 12
 Sep 2022 11:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220902230500.2624739-1-tharvey@gateworks.com>
 <20220902230500.2624739-2-tharvey@gateworks.com> <20220912085407.GS1728671@dragon>
In-Reply-To: <20220912085407.GS1728671@dragon>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 12 Sep 2022 11:16:06 -0700
Message-ID: <CAJ+vNU1wp4sROxZHaBE21Wi9xPcVP4TceDFSN0k0hXK1xZeqaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx: Add i.mx8mm Gateworks gw7904 dts support
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 1:54 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Sep 02, 2022 at 04:05:00PM -0700, Tim Harvey wrote:
> > The GW7904 is based on the i.MX 8M Mini SoC featuring:
> >  - LPDDR4 DRAM
> >  - eMMC FLASH
> >  - microSD connector with UHS support
> >  - LIS2DE12 3-axis accelerometer
> >  - Gateworks System Controller
> >  - IMX8M FEC
> >  - 2x RS232 off-board connectors
> >  - PMIC
> >  - 10x bi-color LED's
> >  - 1x miniPCIe socket with PCIe and USB2.0
> >  - 802.3at Class 4 PoE
> >  - 10-30VDC input via barrel-jack
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
>
> Could you move these Cc after --- below?
>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../dts/freescale/imx8mm-venice-gw7904.dts    | 888 ++++++++++++++++++
> >  2 files changed, 889 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index 8bf7f7ecebaa..d7ae965d2b36 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -67,6 +67,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7903.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7904.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dahlia.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dev.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-dahlia.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
> > new file mode 100644
> > index 000000000000..02ba85a0842a
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
> > @@ -0,0 +1,888 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2022 Gateworks Corporation
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/linux-event-codes.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/phy/phy-imx8-pcie.h>
> > +
> > +#include "imx8mm.dtsi"
> > +
> > +/ {
> > +     model = "Gateworks Venice GW7904 i.MX8MM board";
> > +     compatible = "gateworks,imx8mm-gw7904", "fsl,imx8mm";
> > +
> > +     chosen {
> > +             stdout-path = &uart2;
> > +     };
> > +
> > +     memory@40000000 {
> > +             device_type = "memory";
> > +             reg = <0x0 0x40000000 0 0x80000000>;
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible = "gpio-keys";
> > +
> > +             key-0 {
> > +                     label = "user_pb";
> > +                     gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <BTN_0>;
> > +             };
> > +
> > +             key-1 {
> > +                     label = "user_pb1x";
> > +                     linux,code = <BTN_1>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <0>;
> > +             };
> > +
> > +             key-2 {
> > +                     label = "key_erased";
> > +                     linux,code = <BTN_2>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <1>;
> > +             };
> > +
> > +             key-3 {
> > +                     label = "eeprom_wp";
> > +                     linux,code = <BTN_3>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <2>;
> > +             };
> > +
> > +             key-4 {
> > +                     label = "switch_hold";
> > +                     linux,code = <BTN_5>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <7>;
> > +             };
> > +     };
> > +
> > +     led-controller {
> > +             compatible = "gpio-leds";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_gpio_leds>;
> > +
> > +             led-0 {
> > +                     function = LED_FUNCTION_STATUS;
> > +                     color = <LED_COLOR_ID_GREEN>;
> > +                     label = "led01_grn";
> > +                     gpios = <&gpioled 0 GPIO_ACTIVE_LOW>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led-1 {
> > +                     function = LED_FUNCTION_STATUS;
> > +                     color = <LED_COLOR_ID_YELLOW>;
> > +                     label = "led01_yel";
> > +                     gpios = <&gpioled 1 GPIO_ACTIVE_LOW>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led-2 {
> > +                     function = LED_FUNCTION_STATUS;
> > +                     color = <LED_COLOR_ID_GREEN>;
> > +                     label = "led02_grn";
> > +                     gpios = <&gpioled 2 GPIO_ACTIVE_LOW>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led-3 {
> > +                     function = LED_FUNCTION_STATUS;
> > +                     color = <LED_COLOR_ID_YELLOW>;
> > +                     label = "led02_yel";
> > +                     gpios = <&gpioled 3 GPIO_ACTIVE_LOW>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led-4 {
> > +                     function = LED_FUNCTION_STATUS;
> > +                     color = <LED_COLOR_ID_GREEN>;
> > +                     label = "led03_grn";
> > +                     gpios = <&gpioled 4 GPIO_ACTIVE_LOW>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led-5 {
> > +                     function = LED_FUNCTION_STATUS;
> > +                     color = <LED_COLOR_ID_YELLOW>;
> > +                     label = "led03_yel";
> > +                     gpios = <&gpioled 5 GPIO_ACTIVE_LOW>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led-6 {
> > +                     function = LED_FUNCTION_STATUS;
> > +                     color = <LED_COLOR_ID_GREEN>;
> > +                     label = "led04_grn";
> > +                     gpios = <&gpioled 6 GPIO_ACTIVE_LOW>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led-7 {
> > +                     function = LED_FUNCTION_STATUS;
> > +                     color = <LED_COLOR_ID_YELLOW>;
> > +                     label = "led04_yel";
> > +                     gpios = <&gpioled 7 GPIO_ACTIVE_LOW>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led-8 {
> > +                     function = LED_FUNCTION_STATUS;
> > +                     color = <LED_COLOR_ID_GREEN>;
> > +                     label = "led05_grn";
> > +                     gpios = <&gpioled 8 GPIO_ACTIVE_LOW>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led-9 {
> > +                     function = LED_FUNCTION_STATUS;
> > +                     color = <LED_COLOR_ID_YELLOW>;
> > +                     label = "led05_yel";
> > +                     gpios = <&gpioled 9 GPIO_ACTIVE_LOW>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led-a {
>
> The binding doesn't seem to define the number explicitly.  I understand
> we use hex in unit-address, but not sure a hex number is better than
> decimal as part of node name, mostly meant to count the instance.
>
> Shawn

Shawn,

Ok - I will change them to decimal. I didn't really like the look of it either.

Thanks,

Tim+
> > +&usbotg1 {
> > +     dr_mode = "host";
> > +     disable-over-current;
> > +     status = "okay";
> > +};
> > +
> > +/* microSD */
> > +&usdhc2 {
> > +     pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +     pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> > +     pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> > +     pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> > +     cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> > +     bus-width = <4>;
> > +     vmmc-supply = <&reg_3p3v>;
> > +     status = "okay";
> > +};
> > +
> > +/* eMMC */
> > +&usdhc3 {
> > +     pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +     pinctrl-0 = <&pinctrl_usdhc3>;
> > +     pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> > +     pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> > +     bus-width = <8>;
> > +     non-removable;
> > +     status = "okay";
> > +};
> > +
> > +&wdog1 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_wdog>;
> > +     fsl,ext-reset-output;
> > +     status = "okay";
> > +};
> > +
> > +&iomuxc {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_hog>;
> > +
> > +     pinctrl_hog: hoggrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12      0x40000041 /* RS232# */
> > +                     MX8MM_IOMUXC_ECSPI2_MISO_GPIO5_IO12     0x40000041 /* PCI_WDIS# */
> > +             >;
> > +     };
> > +
> > +     pinctrl_accel: accelgrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15      0x159
> > +             >;
> > +     };
> > +
> > +     pinctrl_fec1: fec1grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                 0x3
> > +                     MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO               0x3
> > +                     MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3           0x1f
> > +                     MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2           0x1f
> > +                     MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1           0x1f
> > +                     MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0           0x1f
> > +                     MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3           0x91
> > +                     MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2           0x91
> > +                     MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1           0x91
> > +                     MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0           0x91
> > +                     MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC           0x1f
> > +                     MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC           0x91
> > +                     MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL     0x91
> > +                     MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0x1f
> > +                     MX8MM_IOMUXC_SAI2_TXFS_GPIO4_IO24               0x19 /* IRQ# */
> > +                     MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25                0x19 /* RST# */
> > +             >;
> > +     };
> > +
> > +     pinctrl_gpio_leds: gpioledsgrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8       0x40000019
> > +                     MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9       0x40000019
> > +                     MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10      0x40000019
> > +                     MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11      0x40000019
> > +             >;
> > +     };
> > +
> > +     pinctrl_gsc: gscgrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26       0x159
> > +             >;
> > +     };
> > +
> > +     pinctrl_i2c1: i2c1grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL          0x400001c3
> > +                     MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA          0x400001c3
> > +             >;
> > +     };
> > +
> > +     pinctrl_i2c2: i2c2grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL          0x400001c3
> > +                     MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA          0x400001c3
> > +             >;
> > +     };
> > +
> > +     pinctrl_i2c3: i2c3grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL          0x400001c3
> > +                     MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA          0x400001c3
> > +             >;
> > +     };
> > +
> > +     pinctrl_i2c4: i2c4grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL          0x400001c3
> > +                     MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA          0x400001c3
> > +             >;
> > +     };
> > +
> > +     pinctrl_pcie0: pciegrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_ECSPI2_MOSI_GPIO5_IO11     0x41
> > +             >;
> > +     };
> > +
> > +     pinctrl_pmic: pmicgrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_NAND_DATA02_GPIO3_IO8      0x41
> > +             >;
> > +     };
> > +
> > +     pinctrl_uart1: uart1grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX     0x140
> > +                     MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX     0x140
> > +             >;
> > +     };
> > +
> > +     pinctrl_uart2: uart2grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
> > +                     MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX     0x140
> > +             >;
> > +     };
> > +
> > +     pinctrl_uart3: uart3grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX     0x140
> > +                     MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX     0x140
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc2: usdhc2grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         0x190
> > +                     MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         0x1d0
> > +                     MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     0x1d0
> > +                     MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     0x1d0
> > +                     MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     0x1d0
> > +                     MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     0x1d0
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         0x194
> > +                     MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         0x1d4
> > +                     MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     0x1d4
> > +                     MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     0x1d4
> > +                     MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     0x1d4
> > +                     MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     0x1d4
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         0x196
> > +                     MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         0x1d6
> > +                     MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     0x1d6
> > +                     MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     0x1d6
> > +                     MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     0x1d6
> > +                     MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     0x1d6
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12        0x1c4
> > +                     MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT  0x1d0
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc3: usdhc3grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK       0x190
> > +                     MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD       0x1d0
> > +                     MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0   0x1d0
> > +                     MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1   0x1d0
> > +                     MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2   0x1d0
> > +                     MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3   0x1d0
> > +                     MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4     0x1d0
> > +                     MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5    0x1d0
> > +                     MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6    0x1d0
> > +                     MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7      0x1d0
> > +                     MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE   0x190
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK       0x194
> > +                     MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD       0x1d4
> > +                     MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0   0x1d4
> > +                     MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1   0x1d4
> > +                     MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2   0x1d4
> > +                     MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3   0x1d4
> > +                     MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4     0x1d4
> > +                     MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5    0x1d4
> > +                     MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6    0x1d4
> > +                     MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7      0x1d4
> > +                     MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE   0x194
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK       0x196
> > +                     MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD       0x1d6
> > +                     MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0   0x1d6
> > +                     MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1   0x1d6
> > +                     MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2   0x1d6
> > +                     MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3   0x1d6
> > +                     MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4     0x1d6
> > +                     MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5    0x1d6
> > +                     MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6    0x1d6
> > +                     MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7      0x1d6
> > +                     MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE   0x196
> > +             >;
> > +     };
> > +
> > +     pinctrl_wdog: wdoggrp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B    0xc6
> > +             >;
> > +     };
> > +};
> > --
> > 2.25.1
> >
