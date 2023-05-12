Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E29700B06
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbjELPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjELPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:08:14 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D608D4C1C
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:08:11 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b9d8b2e1576so13106636276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1683904091; x=1686496091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zfq1bNLkPksle3YwDBy0byBIEq/1R4JLNCSq5qN0ok=;
        b=ZYMP5tFOdEjYWlgkfRJdkPMkllYyRSXSIsXADlkNKDgNOHSL8KrJRfwAqdLsHDKJaO
         Yd4MMIklYgEoZMESeGi0s6CUmKV8dSluijqHTuSpmynlzLOhnqK7m6H77d5SR2jcoB7g
         Mht9KPyIaQFN6FxvvKlf2Yfd3SYUyx2K2J0kXwEJesbgvwzVHRuRZJDRG5FdSF4PyvNM
         e2OdsjCgtm1Y1K7BChUxtG4dd3IpyuRj697apngLRPgEdSVmikQBO6O7Y0VpRcBo9/Ze
         G7MOIpvuKX3XZr70zrv19NqmNXNfKTGMXmy6lgzULBnbQqZVMXc4JhOP+WrZKy8EOLrb
         JOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683904091; x=1686496091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zfq1bNLkPksle3YwDBy0byBIEq/1R4JLNCSq5qN0ok=;
        b=JYqpsVpziuAiox1dN1tolXXN2gL8iqarKWv492vQUTDBULG215qwKoep7J9Gjlbi66
         C7xw0AQnLOc+yt85dGx9WyU2WdY8fw2dq5rQIrIt6JxMunbhtsRA2WNkEkWRjjBfmB9C
         BLK5+fpOgZwTxS8mgUTlqKFEx+0nY0/w8gqikJvGHWeEyzkcr62uh1WYvoGZj0omTETI
         RrNJxyT6fmZjc26tVDuUBB5hyja23UClY7y445GhPo2e2aTfSWtMA0mk6FkoYCKjhJPq
         KbaClFqMCPShmw0EH5+bDC33GLibZzIdVUGHBRkvJyonSCDQ3mByruVQ2yEQP/lcMcO4
         /QgA==
X-Gm-Message-State: AC+VfDxS+bi3DWmjSXoN4D6R0ZELalAk+IYEDVh8yKXNcJFkQJKULWSt
        FgZ5phva8DNSAOovN4LvWFdt5x/hDIljzNcRBwIWBREFGuJYrFBfK6Y=
X-Google-Smtp-Source: ACHHUZ6Zr3Frz8r0DxpQrkmBfJWU62YT6rWrplPlREpUN+ogx46ExKLmzR/d/BJ4NDIRyG3/CFimypH0X/36lJTcpFs=
X-Received: by 2002:a25:40d4:0:b0:b9d:ea9c:d3b9 with SMTP id
 n203-20020a2540d4000000b00b9dea9cd3b9mr22436590yba.32.1683904090900; Fri, 12
 May 2023 08:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230511171041.4011087-1-tharvey@gateworks.com>
 <20230511171041.4011087-2-tharvey@gateworks.com> <1b3b58b9-b441-f04f-a3e1-8b5fb7f19f9d@linaro.org>
In-Reply-To: <1b3b58b9-b441-f04f-a3e1-8b5fb7f19f9d@linaro.org>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 12 May 2023 08:07:59 -0700
Message-ID: <CAJ+vNU3VBnhy_u-t_161V6Rr9MEs558dg=Sa_wNBEB-Bqq6wkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Add imx8mp-venice-gw7905-2x
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:23=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/05/2023 19:10, Tim Harvey wrote:
> > The Gateworks imx8mp-venice-gw7905-2x consists of a SOM + baseboard.
> >
> > The GW702x SOM contains the following:
> >  - i.MX8M Plus SoC
> >  - LPDDR4 memory
> >  - eMMC Boot device
> >  - Gateworks System Controller (GSC) with integrated EEPROM, button
> >    controller, and ADC's
> >  - PMIC
> >  - RGMII PHY (eQoS)
> >  - SOM connector providing:
> >   - eQoS GbE MII
> >   - 1x SPI
> >   - 2x I2C
> >   - 4x UART
> >   - 2x USB 3.0
> >   - 1x PCI
> >   - 1x SDIO (4-bit 3.3V)
> >   - 1x SDIO (4-bit 3.3V/1.8V)
> >   - GPIO
> >
> > The GW7905 Baseboard contains the following:
> >  - GPS
> >  - microSD
> >  - off-board I/O connector with I2C, SPI, GPIO
> >  - EERPOM
> >  - PCIe clock generator
> >  - 1x full-length miniPCIe socket with PCI/USB3 (via mux) and USB2.0
> >  - 1x half-length miniPCIe socket with USB2.0 and USB3.0
> >  - USB 3.0 HUB
> >  - USB Type-C with USB PD Sink capability and peripheral support
> >  - USB Type-C with USB 3.0 host support
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  .../dts/freescale/imx8mp-venice-gw702x.dtsi   | 589 ++++++++++++++++++
> >  .../dts/freescale/imx8mp-venice-gw7905-2x.dts |  28 +
> >  .../dts/freescale/imx8mp-venice-gw7905.dtsi   | 358 +++++++++++
>

Hi Krzysztof,

Thanks for the review!

>
> How do you compile it? Missing Makefile. This also suggests that maybe
> you did not test it with dtbs_check...
>

I am in the habbit of using 'make dtbs W=3D1' and 'make dtbs_check' but
I accidently put the Makefile change in a future commit. With this new
board we add a new SOM compatible with 3 other baseboards and a new
baseboard compatible with one other SOM so there will be 4 more boards
added shortly: imx8mm-venice-gw7905-0x, imx8mp-venice-gw71xx-2x,
imx8mp-venice-gw72xx-2x, imx8mp-venice-gw73xx-2x. I assume its still
best to submit each of those as a 2-part series (add the binding, then
add the dt) instead of bulking multiple boards into one submission
correct?

>
> >  3 files changed, 975 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.=
dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905-=
2x.dts
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905.=
dtsi
>
> ...
>
> > +     gsc: gsc@20 {
> > +             compatible =3D "gw,gsc";
> > +             reg =3D <0x20>;
> > +             pinctrl-0 =3D <&pinctrl_gsc>;
> > +             interrupt-parent =3D <&gpio2>;
> > +             interrupts =3D <6 IRQ_TYPE_EDGE_FALLING>;
> > +             interrupt-controller;
> > +             #interrupt-cells =3D <1>;
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             adc {
> > +                     compatible =3D "gw,gsc-adc";
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     channel@6 {
> > +                             gw,mode =3D <0>;
> > +                             reg =3D <0x06>;
> > +                             label =3D "temp";
> > +                     };
> > +
> > +                     channel@8 {
> > +                             gw,mode =3D <1>;
> > +                             reg =3D <0x08>;
> > +                             label =3D "vdd_bat";
> > +                     };
> > +
> > +                     channel@16 {
> > +                             gw,mode =3D <4>;
> > +                             reg =3D <0x16>;
> > +                             label =3D "fan_tach";
> > +                     };
> > +
> > +                     channel@82 {
> > +                             gw,mode =3D <2>;
> > +                             reg =3D <0x82>;
> > +                             label =3D "vdd_vin";
> > +                             gw,voltage-divider-ohms =3D <22100 1000>;
> > +                     };
> > +
> > +                     channel@84 {
> > +                             gw,mode =3D <2>;
> > +                             reg =3D <0x84>;
> > +                             label =3D "vdd_adc1";
> > +                             gw,voltage-divider-ohms =3D <10000 10000>=
;
> > +                     };
> > +
> > +                     channel@86 {
> > +                             gw,mode =3D <2>;
> > +                             reg =3D <0x86>;
> > +                             label =3D "vdd_adc2";
> > +                             gw,voltage-divider-ohms =3D <10000 10000>=
;
> > +                     };
> > +
> > +                     channel@88 {
> > +                             gw,mode =3D <2>;
> > +                             reg =3D <0x88>;
> > +                             label =3D "vdd_1p0";
> > +                     };
> > +
> > +                     channel@8c {
> > +                             gw,mode =3D <2>;
> > +                             reg =3D <0x8c>;
> > +                             label =3D "vdd_1p8";
> > +                     };
> > +
> > +                     channel@8e {
> > +                             gw,mode =3D <2>;
> > +                             reg =3D <0x8e>;
> > +                             label =3D "vdd_2p5";
> > +                     };
> > +
> > +                     channel@90 {
> > +                             gw,mode =3D <2>;
> > +                             reg =3D <0x90>;
> > +                             label =3D "vdd_3p3";
> > +                             gw,voltage-divider-ohms =3D <10000 10000>=
;
> > +                     };
> > +
> > +                     channel@92 {
> > +                             gw,mode =3D <2>;
> > +                             reg =3D <0x92>;
> > +                             label =3D "vdd_dram";
> > +                     };
> > +
> > +                     channel@98 {
> > +                             gw,mode =3D <2>;
> > +                             reg =3D <0x98>;
> > +                             label =3D "vdd_soc";
> > +                     };
> > +
> > +                     channel@9a {
> > +                             gw,mode =3D <2>;
> > +                             reg =3D <0x9a>;
> > +                             label =3D "vdd_arm";
> > +                     };
> > +
> > +                     channel@a2 {
> > +                             gw,mode =3D <2>;
> > +                             reg =3D <0xa2>;
> > +                             label =3D "vdd_gsc";
> > +                             gw,voltage-divider-ohms =3D <10000 10000>=
;
> > +                     };
> > +             };
> > +
> > +             fan-controller@0 {
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
>
> Why do you need these two? I know binding expects them, but why? Anyway
> compatible is first, reg is second property.

I never needed them for GSC functionality but ended up having to add
them to the gateworks-gsc.yaml to make binding checks happy.

When I was working on gateworks-gsc.yaml I was getting the following
error until I added #address-cells=3D1 and #size-cells=3D0:
> $ make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindin=
gs/mfd/gateworks-gsc.yaml
>   CHKDT   Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
>   DTC     Documentation/devicetree/bindings/mfd/gateworks-gsc.example.dt.=
yaml
> Documentation/devicetree/bindings/mfd/gateworks-gsc.example.dts:58.21-34:=
 Warning (reg_format): /example-0/i2c/gsc@20/fan-controller@2c:reg: propert=
y has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D=
 1)

I didn't completely understand the issue and dt_binding_check no
longer complains with the above if I remove the requirement so it
seems I should submit the following patch along with removing the
properties from all the dt's that have the fan-controller node:
diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
index acb9c54942d9..dc379f3ebf24 100644
--- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
@@ -122,12 +122,6 @@ patternProperties:
       compatible:
         const: gw,gsc-fan

-      "#address-cells":
-        const: 1
-
-      "#size-cells":
-        const: 0
-
       reg:
         description: The fan controller base address
         maxItems: 1
@@ -135,8 +129,6 @@ patternProperties:
     required:
       - compatible
       - reg
-      - "#address-cells"
-      - "#size-cells"

 required:
   - compatible
@@ -194,8 +186,6 @@ examples:
             };

             fan-controller@2c {
-                #address-cells =3D <1>;
-                #size-cells =3D <0>;
                 compatible =3D "gw,gsc-fan";
                 reg =3D <0x2c>;
             };
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch=
/arm6
4/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index 4fca4aae8f72..74b0fda235ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -222,8 +222,6 @@ channel@a2 {
                };

                fan-controller@0 {
-                       #address-cells =3D <1>;
-                       #size-cells =3D <0>;
                        compatible =3D "gw,gsc-fan";
                        reg =3D <0x0a>;
                };

Would that make sense?

Is it that the fan-controller because it does not have addressable
child nodes does not need address-cells?

>
>
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905-2x.dts =
b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905-2x.dts
> > new file mode 100644
> > index 000000000000..4a1bbbbe19e6
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905-2x.dts
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2023 Gateworks Corporation
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx8mp.dtsi"
> > +#include "imx8mp-venice-gw702x.dtsi"
> > +#include "imx8mp-venice-gw7905.dtsi"
> > +
> > +/ {
> > +     model =3D "Gateworks Venice GW7905-2x i.MX8MP Development Kit";
> > +     compatible =3D "gateworks,imx8mp-gw7905-2x", "fsl,imx8mp";
> > +
> > +     chosen {
> > +             stdout-path =3D &uart2;
> > +     };
> > +};
> > +
> > +/* Disable SOM interfaces not used on baseboard */
> > +&eqos {
> > +     status =3D "disabled";
> > +};
> > +
> > +&usdhc1 {
> > +     status =3D "disabled";
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905.dtsi b/=
arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905.dtsi
> > new file mode 100644
> > index 000000000000..479190a6391f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905.dtsi
> > @@ -0,0 +1,358 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2023 Gateworks Corporation
> > + */
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/phy/phy-imx8-pcie.h>
> > +
> > +/ {
> > +     aliases {
> > +             ethernet0 =3D &eqos;
> > +     };
> > +
> > +     led-controller {
> > +             compatible =3D "gpio-leds";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_gpio_leds>;
> > +
> > +             led-0 {
> > +                     function =3D LED_FUNCTION_STATUS;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&gpio4 22 GPIO_ACTIVE_HIGH>;
> > +                     default-state =3D "on";
> > +                     linux,default-trigger =3D "heartbeat";
> > +             };
> > +
> > +             led-1 {
> > +                     function =3D LED_FUNCTION_STATUS;
> > +                     color =3D <LED_COLOR_ID_RED>;
> > +                     gpios =3D <&gpio4 27 GPIO_ACTIVE_HIGH>;
> > +                     default-state =3D "off";
> > +             };
> > +     };
> > +
> > +     pcie0_refclk: pcie0-refclk {
> > +             compatible =3D "fixed-clock";
> > +             #clock-cells =3D <0>;
> > +             clock-frequency =3D <100000000>;
> > +     };
> > +
> > +     pps {
> > +             compatible =3D "pps-gpio";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_pps>;
> > +             gpios =3D <&gpio4 21 GPIO_ACTIVE_HIGH>;
> > +             status =3D "okay";
> > +     };
> > +
> > +     reg_usb2_vbus: regulator-usb2-vbus {
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_reg_usb2_en>;
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "usb2_vbus";
> > +             gpio =3D <&gpio4 12 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +     };
> > +
> > +     reg_usdhc2_vmmc: regulator-usdhc2 {
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_reg_usdhc2_vmmc>;
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "SD2_3P3V";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +     };
> > +
>
> Drop stay blank line

will do in v2.

Best Regards,

Tim


>
> > +};
> > +
> > +/* off-board header */
> > +&ecspi2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_spi2>;
> > +     cs-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
> > +     status =3D "okay";
> > +};
>
>
>
> Best regards,
> Krzysztof
>
