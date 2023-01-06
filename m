Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F9660077
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjAFMpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjAFMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:45:19 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D4B74588;
        Fri,  6 Jan 2023 04:45:18 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id l184so1367313vsc.0;
        Fri, 06 Jan 2023 04:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jL6yKbuIG5bg58/evB7hjRBzcxcNlKUiVEr9ODI7ufw=;
        b=TkItBn/CS4JazJCi5yzrFkv4FFdOD+vEwo92+R3UjHUPhT79HVut13Xw6h2RdP/ktJ
         HDEyslFM9HktYRF/ZTJqaJE3OtTmB/H5I/L2FRbZEWQ/87WoULShnlX7Xt9IIBFH9XBk
         TuWfM7Zum6RmJOQLUTqEDpiheoFzB1V7tpRPysMlJk/PDii1+ByLczX7zBljYjs8tiPQ
         vf0yapYm2fivghkpWaJLXvgDiImzKzz6bPWOD/yIfuFa/hyhpzTiG5dbK0DZsF+LJJQB
         /Dj9xpH4ruQNObqHHKVd5lD8+yTt/afcy3jJ7vc7mnkJxy3JG5XkCqzYMvW0A6TltuPp
         3Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jL6yKbuIG5bg58/evB7hjRBzcxcNlKUiVEr9ODI7ufw=;
        b=tXAS2O0dCzKREnrpWFczf+nwyc4omT/XFsiOc8Ng6pesPD8tQNFt/osrVzI+U81yvL
         Q+vMtGAsamB/5j2+i82RR+Kr0IxM3AmTCCBmHncUcsfMafb+Pu4jyJkGiuXI/Sb/3uw2
         XxK6ChnQUABY2RgV0EJy77IRtpn3+PuN7gIk2Jd6maD5g6QUiv1NhnuK7/VcSQYPyqaD
         L/Gq810z8M9vt2gcLd1eSoErEDR4g9UCizGX3YwREMYEb0nSfkuuH7nJ+LoPw2W+1oSa
         7ONQ+KRxmqDo5Cth49yFzL6qdmK4H5ZpPM0Ql6xbYr0MmiT5nE+ExLTzDHVgUkjeOETe
         Or2A==
X-Gm-Message-State: AFqh2kodlhmjLi7upkXW+thy5Nb3pIEmnulrl9auyotCpwX2GXUuSJSd
        WpunckUGNJWp367pLGiqK7SpG4llPIiVIcOt0L69uavmbv35Fg==
X-Google-Smtp-Source: AMrXdXvYT2C0w2+sD74BfOfSicY9vAuLMtmsc92pY36FpG7KMWfK0oehgZvbwnJzvhULP62lifut0FGhYqxS7x3FbK4=
X-Received: by 2002:a05:6102:510e:b0:3b1:2b83:1861 with SMTP id
 bm14-20020a056102510e00b003b12b831861mr6419257vsb.10.1673009117334; Fri, 06
 Jan 2023 04:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20221220112927.440506-1-alistair@alistair23.me>
 <20221220112927.440506-2-alistair@alistair23.me> <20221220132033.s5idqrol5kqxjasy@pengutronix.de>
 <7a2dfaab-5340-236a-064d-15db3e00f409@pengutronix.de>
In-Reply-To: <7a2dfaab-5340-236a-064d-15db3e00f409@pengutronix.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 6 Jan 2023 22:44:50 +1000
Message-ID: <CAKmqyKOtDXUd6oxSmZjDc6NJHfVonBE67C-ddTmpfyPMaTtAnQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Alistair Francis <alistair@alistair23.me>,
        devicetree@vger.kernel.org, kernel@pengutronix.de, arnd@arndb.de,
        festevam@gmail.com, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com,
        linux@armlinux.org.uk, robh+dt@kernel.org, linux-imx@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 2:51 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Alistair,
> Hello Marco,
>
> On 20.12.22 14:20, Marco Felsch wrote:
> > Hi Alistair,
> >
> > thanks for your patch, please see below.
> >
> > On 22-12-20, Alistair Francis wrote:
> >> Add support for the cyttsp5 touchscreen controller for the reMarkable 2.
> >>
> >> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> >> ---
> >>  arch/arm/boot/dts/imx7d-remarkable2.dts | 98 +++++++++++++++++++++++++
> >>  1 file changed, 98 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> >> index 8b2f11e85e05..a138b292ec6a 100644
> >> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> >> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> >> @@ -8,6 +8,7 @@
> >>  /dts-v1/;
> >>
> >>  #include "imx7d.dtsi"
> >> +#include <dt-bindings/input/linux-event-codes.h>
> >>
> >>  / {
> >>      model = "reMarkable 2.0";
> >> @@ -69,6 +70,18 @@ reg_digitizer: regulator-digitizer {
> >>              startup-delay-us = <100000>; /* 100 ms */
> >>      };
> >>
> >> +    reg_touch: regulator-touch {
> >> +            compatible = "regulator-fixed";
> >> +            regulator-name = "VDD_3V3_TOUCH";
> >> +            regulator-min-microvolt = <3300000>;
> >> +            regulator-max-microvolt = <3300000>;
> >> +            pinctrl-names = "default", "sleep";
> >> +            pinctrl-0 = <&pinctrl_touch_reg>;
> >> +            pinctrl-1 = <&pinctrl_touch_reg>;
> >
> > Why do we need a "sleep" state here?

Removed

> >
> >> +            gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
> >> +            enable-active-high;
> >> +    };
> >> +
> >>      wifi_pwrseq: wifi_pwrseq {
> >>              compatible = "mmc-pwrseq-simple";
> >>              pinctrl-names = "default";
> >> @@ -106,6 +119,68 @@ wacom_digitizer: digitizer@9 {
> >>      };
> >>  };
> >>
> >> +&i2c3 {
> >> +    clock-frequency = <100000>;
> >
> > This can be set to 400kHz, the driver handle the quirks internal.
>
> I would either leave this at 100kHz or increase to the maximum of
> 384 kHz. DT is supposed to describe the hardware and if 400 kHz
> isn't a safe frequency, it should be avoided, even if the Linux
> driver handles it gracefully.

I'm going to leave this at 100kHz then. Let me know if you want me to
bump it to 384kHz instead.

Alistair

>
> Cheers,
> Ahmad
>
> >
> > Regards,
> >   Marco
> >
> >> +    pinctrl-names = "default";
> >> +    pinctrl-0 = <&pinctrl_i2c3>;
> >> +    status = "okay";
> >> +
> >> +    touchscreen@24 {
> >> +            compatible = "cypress,tt21000";
> >> +            reg = <0x24>;
> >> +            pinctrl-names = "default";
> >> +            pinctrl-0 = <&pinctrl_touch>;
> >> +            interrupt-parent = <&gpio1>;
> >> +            interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
> >> +            reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> >> +            vdd-supply = <&reg_touch>;
> >> +            touchscreen-size-x = <880>;
> >> +            touchscreen-size-y = <1280>;
> >> +            #address-cells = <1>;
> >> +            #size-cells = <0>;
> >> +
> >> +            button@0 {
> >> +                    reg = <0>;
> >> +                    linux,keycodes = <KEY_HOMEPAGE>;
> >> +            };
> >> +
> >> +            button@1 {
> >> +                    reg = <1>;
> >> +                    linux,keycodes = <KEY_MENU>;
> >> +            };
> >> +
> >> +            button@2 {
> >> +                    reg = <2>;
> >> +                    linux,keycodes = <KEY_BACK>;
> >> +            };
> >> +
> >> +            button@3 {
> >> +                    reg = <3>;
> >> +                    linux,keycodes = <KEY_SEARCH>;
> >> +            };
> >> +
> >> +            button@4 {
> >> +                    reg = <4>;
> >> +                    linux,keycodes = <KEY_VOLUMEDOWN>;
> >> +            };
> >> +
> >> +            button@5 {
> >> +                    reg = <5>;
> >> +                    linux,keycodes = <KEY_VOLUMEUP>;
> >> +            };
> >> +
> >> +            button@6 {
> >> +                    reg = <6>;
> >> +                    linux,keycodes = <KEY_CAMERA>;
> >> +            };
> >> +
> >> +            button@7 {
> >> +                    reg = <7>;
> >> +                    linux,keycodes = <KEY_POWER>;
> >> +            };
> >> +    };
> >> +};
> >> +
> >>  &i2c4 {
> >>      clock-frequency = <100000>;
> >>      pinctrl-names = "default", "sleep";
> >> @@ -232,6 +307,15 @@ MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11    0x00000014
> >>              >;
> >>      };
> >>
> >> +    pinctrl_touch: touchgrp {
> >> +            fsl,pins = <
> >> +                    /* CYTTSP interrupt */
> >> +                    MX7D_PAD_GPIO1_IO14__GPIO1_IO14         0x54
> >> +                    /* CYTTSP reset */
> >> +                    MX7D_PAD_GPIO1_IO13__GPIO1_IO13         0x04
> >> +            >;
> >> +    };
> >> +
> >>      pinctrl_i2c1: i2c1grp {
> >>              fsl,pins = <
> >>                      MX7D_PAD_I2C1_SDA__I2C1_SDA             0x4000007f
> >> @@ -239,6 +323,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL             0x4000007f
> >>              >;
> >>      };
> >>
> >> +    pinctrl_i2c3: i2c3grp {
> >> +            fsl,pins = <
> >> +                    MX7D_PAD_I2C3_SDA__I2C3_SDA             0x4000007f
> >> +                    MX7D_PAD_I2C3_SCL__I2C3_SCL             0x4000007f
> >> +            >;
> >> +    };
> >> +
> >>      pinctrl_i2c4: i2c4grp {
> >>              fsl,pins = <
> >>                      MX7D_PAD_I2C4_SDA__I2C4_SDA             0x4000007f
> >> @@ -246,6 +337,13 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL             0x4000007f
> >>              >;
> >>      };
> >>
> >> +    pinctrl_touch_reg: touchreggrp {
> >> +            fsl,pins = <
> >> +                    /* TOUCH_PWR_EN */
> >> +                    MX7D_PAD_GPIO1_IO11__GPIO1_IO11         0x14
> >> +            >;
> >> +    };
> >> +
> >>      pinctrl_uart1: uart1grp {
> >>              fsl,pins = <
> >>                      MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX    0x79
> >> --
> >> 2.38.1
> >>
> >>
> >>
> >
> >
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>
