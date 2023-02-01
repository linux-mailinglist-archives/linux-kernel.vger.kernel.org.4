Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7D686361
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjBAKGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjBAKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:06:48 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4137962241
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:06:25 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-16332831ed0so22856962fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PYMbS5c58pA+ZLazPFK01vHQz402w+ekY4M7VB1E9lg=;
        b=j0vcCEhh8ChlGacQV1ymgA7g6NE8VRjg94+7+UxO3pF8S1K3dyIC9whrPq0LUsOBi6
         s79tTOA2WaNllVYMDu0RiIhrSDackjIENyWzlbIMgFCLtUuJIECltCxq9bY3VpiiLOFS
         M/bMWHwbX8dJYfRpTlvQJ09RXeHOMDu6XJyIl8+IVAtkZIz4MGxsA+FiFy91k6EnVGwt
         nQAlrUd5gacjMTMdupLZsnNgpKnrnwrkmvm4Z73OvuQyxA991BnrT0nYq+4IwfeCVyh+
         nPVaZEVsQiavcW3tdADlcX84DMFV6BRYEbhDGr5pnrE+lyOtkDiDywkkqGYTHJMRehfB
         Xgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYMbS5c58pA+ZLazPFK01vHQz402w+ekY4M7VB1E9lg=;
        b=4yvUV8Db78A1fXyZLA4k7rPGv5YUceIOAtORkOjwMQ/IcQuJvparThqt48VhF3wTMP
         Htwazr05bM0C98an7qd+PhFC5jv35HDIua+d/zjsTDHH1Hwx0WqUjDFaH7gDLj4eiWrQ
         WRGMTLlpj6Bn3YTPlNZ8LSG78+wkEta21P+3OKt/YFR4dB2rANr/bDVzGhG1fR5umCL5
         pQpG+zLGUYSNSW/vyLN3BkXEF0hnnlxzVxm77fgL4x0D+TLgp/mkGxG9lUIADYCTZjrj
         2u13i2JWXGk2vq9xk05Xtqc0Z0xOECTA96nSXfGPQYUNWyxEmU9wIehcHuq1wTB1ObP9
         ABlA==
X-Gm-Message-State: AO0yUKUahVVL1Y/XdifJf0M8Jqo3vY4KJeGOd6+fSugyXzYdMPiKwYK+
        FEdAOIljDoKikF83WJdRUBGEe/tRscErWkv/Pok/kw==
X-Google-Smtp-Source: AK7set9Yiiz/gLXfK1/25n+reEvTFt5QS+KmJ+V4QGc6jTf4VoITcDUOIFF6/wA1dMm+4Ilqgv9O+YYjUby/OUrg6Uw=
X-Received: by 2002:a05:6871:146:b0:163:88f9:2c51 with SMTP id
 z6-20020a056871014600b0016388f92c51mr132440oab.144.1675245972602; Wed, 01 Feb
 2023 02:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
 <20230119102102.73414-4-jordan.chang@ufispace.com> <3e242c03-f8fd-2136-0263-2306acb9f610@linaro.org>
In-Reply-To: <3e242c03-f8fd-2136-0263-2306acb9f610@linaro.org>
From:   Jordan Chang <jordan.chang@ufispace.com>
Date:   Wed, 1 Feb 2023 18:06:01 +0800
Message-ID: <CAJ3czeT1O3iw2S_SK3z0C6dMiJ+-fUrWXPox4LJpJkMy_rVsJA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: Add device tree for Ufispace
 NCPLite BMC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org, jay.tc.lin@ufispace.com,
        eason.ys.huang@ufispace.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your comments.

On Thu, Jan 19, 2023 at 7:00 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/01/2023 11:21, Jordan Chang wrote:
> > Add initial version of device tree for Ufispace NCPlite platform
> > which is equipped with AST2600-based BMC.
> >
> > Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
> > ---
> >  arch/arm/boot/dts/Makefile                    |   1 +
> >  .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 360 ++++++++++++++++++
> >  2 files changed, 361 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 2ee9c043218b..d26e0651e805 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1626,6 +1626,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> >       aspeed-bmc-inventec-transformers.dtb \
> >       aspeed-bmc-tyan-s7106.dtb \
> >       aspeed-bmc-tyan-s8036.dtb \
> > +     aspeed-bmc-ufispace-ncplite.dtb \
> >       aspeed-bmc-vegman-n110.dtb \
> >       aspeed-bmc-vegman-rx20.dtb \
> >       aspeed-bmc-vegman-sx20.dtb
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
> > new file mode 100644
> > index 000000000000..7ab29129d1e4
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
> > @@ -0,0 +1,360 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +// Copyright (c) 2022 Ufispace Co., Ltd.
> > +/dts-v1/;
> > +
> > +#include "aspeed-g6.dtsi"
> > +#include <dt-bindings/i2c/i2c.h>
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +
> > +/ {
> > +     model = "Ufispace NCPLite BMC";
> > +     compatible = "ufispace,ncplite-bmc", "aspeed,ast2600";
> > +
> > +     aliases {
> > +             serial4 = &uart5;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path = &uart5;
> > +             bootargs = "console=ttyS4,115200n8 earlycon";
>
> earlycon is debugging tool and not suitable for mainline, wide usage. Drop.
>
> Actually drop entire bootags and use proper stdout-path.
>
Will drop the line.

> > +     };
> > +
> > +     memory@80000000 {
> > +             device_type = "memory";
> > +             reg = <0x80000000 0x80000000>;
> > +     };
> > +
> > +     iio-hwmon {
> > +             compatible = "iio-hwmon";
> > +             io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> > +                           <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> > +                           <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
> > +                           <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible = "gpio-keys";
> > +
> > +             fan-status-int-l {
>
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
>
> These will bring warnings. Missing generic name,
>
I have run the `make dtbs_check` command, and did not notice the warning
message 'Missing generic name'. It shows lots of compatible failed messages.
- /ahb/ftgmac@1e670000: failed to match any schema with compatible:

> > +                     label = "fan-status-int-l";
> > +                     gpios = <&gpio0 ASPEED_GPIO(M, 2) GPIO_ACTIVE_LOW>;
> > +                     linux,code = <ASPEED_GPIO(M, 2)>;
> > +             };
> > +
> > +             allpwr-good {
> > +                     label = "allpwr-good";
> > +                     gpios = <&gpio0 ASPEED_GPIO(V, 4) GPIO_ACTIVE_HIGH>;
> > +                     linux,code = <ASPEED_GPIO(V, 4)>;
> > +             };
> > +
> > +             psu0-alert-n {
> > +                     label = "psu0-alert-n";
> > +                     gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_LOW>;
> > +                     linux,code = <ASPEED_GPIO(V, 1)>;
> > +             };
> > +
> > +             psu1-alert-n {
> > +                     label = "psu1-alert-n";
> > +                     gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_LOW>;
> > +                     linux,code = <ASPEED_GPIO(V, 2)>;
> > +             };
> > +
> > +             int-thermal-alert {
> > +                     label = "int-thermal-alert";
> > +                     gpios = <&gpio0 ASPEED_GPIO(P, 2) GPIO_ACTIVE_LOW>;
> > +                     linux,code = <ASPEED_GPIO(P, 2)>;
> > +             };
> > +
> > +             cpu-caterr-l {
> > +                     label = "cpu-caterr-l";
> > +                     gpios = <&gpio0 ASPEED_GPIO(N, 3) GPIO_ACTIVE_LOW>;
> > +                     linux,code = <ASPEED_GPIO(N, 3)>;
> > +             };
> > +
> > +             cpu-thermtrip-l {
> > +                     label = "cpu-thermtrip-l";
> > +                     gpios = <&gpio0 ASPEED_GPIO(V, 5) GPIO_ACTIVE_LOW>;
> > +                     linux,code = <ASPEED_GPIO(V, 5)>;
> > +             };
> > +
> > +             psu0-presence-l {
> > +                     label = "psu0-presence-l";
> > +                     gpios = <&gpio0 ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
> > +                     linux,code = <ASPEED_GPIO(F, 6)>;
> > +             };
> > +
> > +             psu1-presence-l {
> > +                     label = "psu1-presence-l";
> > +                     gpios = <&gpio0 ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
> > +                     linux,code = <ASPEED_GPIO(F, 7)>;
> > +             };
> > +
> > +             psu0-power-ok {
> > +                     label = "psu0-power-ok";
> > +                     gpios = <&gpio0 ASPEED_GPIO(M, 4) GPIO_ACTIVE_HIGH>;
> > +                     linux,code = <ASPEED_GPIO(M, 4)>;
> > +             };
> > +
> > +             psu1-power-ok {
> > +                     label = "psu1-power-ok";
> > +                     gpios = <&gpio0 ASPEED_GPIO(M, 5) GPIO_ACTIVE_HIGH>;
> > +                     linux,code = <ASPEED_GPIO(M, 5)>;
> > +             };
> > +     };
> > +
> > +     gpio-keys-polled {
> > +             compatible = "gpio-keys-polled";
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +             poll-interval = <1000>;
> > +
> > +             fan0-presence {
>
> Same problem - not tested.
>
> > +                     label = "fan0-presence";
> > +                     gpios = <&fan_ioexp 2 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <2>;
> > +             };
> > +
> > +             fan1-presence {
> > +                     label = "fan1-presence";
> > +                     gpios = <&fan_ioexp 6 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <6>;
> > +             };
> > +
> > +             fan2-presence {
> > +                     label = "fan2-presence";
> > +                     gpios = <&fan_ioexp 10 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <10>;
> > +             };
> > +
> > +             fan3-presence {
> > +                     label = "fan3-presence";
> > +                     gpios = <&fan_ioexp 14 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <14>;
> > +             };
> > +     };
> > +};
> > +
> > +&mac2 {
> > +     status = "okay";
> > +     use-ncsi;
> > +
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_rmii3_default>;
> > +     clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>,
> > +              <&syscon ASPEED_CLK_MAC3RCLK>;
> > +     clock-names = "MACCLK", "RCLK";
> > +};
> > +
> > +&fmc {
> > +     status = "okay";
> > +     flash@0 {
> > +             status = "okay";
> > +             m25p,fast-read;
> > +             label = "bmc";
> > +             spi-max-frequency = <50000000>;
> > +#include "openbmc-flash-layout-64.dtsi"
> > +     };
> > +
> > +     flash@1 {
> > +             status = "okay";
> > +             m25p,fast-read;
> > +             label = "alt-bmc";
> > +             spi-max-frequency = <50000000>;
> > +#include "openbmc-flash-layout-64-alt.dtsi"
> > +     };
> > +};
> > +
> > +&uart1 {
> > +     status = "okay";
> > +};
> > +
> > +&uart4 {
> > +     status = "okay";
> > +};
> > +
> > +&uart5 {
> > +     status = "okay";
> > +};
> > +
> > +&kcs3 {
> > +     status = "okay";
> > +     aspeed,lpc-io-reg = <0xca2>;
> > +};
> > +
> > +&lpc_reset {
> > +     status = "okay";
> > +};
> > +
> > +&lpc_ctrl {
> > +     status = "okay";
> > +};
> > +
> > +&uart_routing {
> > +     status = "okay";
> > +};
> > +
> > +&wdt1 {
> > +     status = "okay";
> > +};
> > +
> > +&wdt2 {
> > +     status = "okay";
> > +};
> > +
> > +&peci0 {
> > +     status = "okay";
> > +};
> > +
> > +&udc {
> > +     status = "okay";
> > +};
> > +
> > +&adc0 {
> > +     vref = <2500>;
> > +     status = "okay";
> > +
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> > +             &pinctrl_adc2_default &pinctrl_adc3_default
> > +             &pinctrl_adc4_default &pinctrl_adc5_default
> > +             &pinctrl_adc6_default &pinctrl_adc7_default>;
> > +};
> > +
> > +&adc1 {
> > +     vref = <2500>;
> > +     status = "okay";
> > +
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> > +             &pinctrl_adc10_default &pinctrl_adc11_default
> > +             &pinctrl_adc12_default &pinctrl_adc13_default
> > +             &pinctrl_adc14_default &pinctrl_adc15_default>;
> > +};
> > +
> > +&i2c0 {
> > +     status = "okay";
> > +};
> > +
> > +&i2c1 {
> > +     status = "okay";
> > +
> > +     lm75@48 {
>
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
Will rename the node with the generic name.

> > +             compatible = "nxp,pca9535";
> > +             reg = <0x20>;
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             gpio-line-names =
> > +             "","","presence-fan0","",
> > +             "","","presence-fan1","",
> > +             "","","presence-fan2","",
> > +             "","","presence-fan3","";
> > +     };
> > +};
> > +
> > +&i2c3 {
> > +     status = "okay";
> > +
> > +     eeprom@50 {
> > +             compatible = "atmel,24c128";
> > +             reg = <0x50>;
> > +             pagesize = <64>;
> > +     };
> > +};
> > +
> > +&i2c4 {
> > +     status = "okay";
> > +
> > +     psu@58 {
> > +             compatible = "pmbus";
>
> Where is this compatible documented?
Can not find the corresponding document.
>
> Did you run checkpatch? Did it pass without warnings?
Yes, I did run the ./scripts/checkpatch.pl and there were two warnings left.
- WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
- WARNING: line length of 104 exceeds 100 columns
I just ignore those warnings that Joel has informed me in the previous
mail loop.

Best regards,
Jordan Chang

>
>
> > +             reg = <0x58>;
> > +     };
> > +
> > +     eeprom@50 {
> > +             compatible = "atmel,24c02";
> > +             reg = <0x50>;
> > +             pagesize = <1>;
> > +     };
> > +};
> > +
> > +&i2c5 {
> > +     status = "okay";
> > +
> > +     psu@58 {
> > +             compatible = "pmbus";
> > +             reg = <0x58>;
> > +     };
> > +
> > +     eeprom@50 {
> > +             compatible = "atmel,24c02";
> > +             reg = <0x50>;
> > +             pagesize = <1>;
> > +     };
> > +};
> > +
> > +&i2c8 {
> > +     status = "okay";
> > +};
> > +
> > +&i2c10 {
> > +     status = "okay";
> > +
> > +     lm75@4d {
>
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> > +             compatible = "national,lm75";
> > +             reg = <0x4d>;
> > +     };
> > +};
> Best regards,
> Krzysztof
>
