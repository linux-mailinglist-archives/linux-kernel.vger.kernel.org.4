Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4561E6DAD50
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbjDGNOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjDGNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:13:58 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0156C83FB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:13:50 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i6so48989339ybu.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680873230; x=1683465230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/EkXHhpekudgYRSVvD2Wp54aMGgIOeanmC+1OUeyjw=;
        b=Lmi33RpPAeAf0TiyeOM6CEzn/jQzfV9SihWbM/WsNHUP6UpULDqWC0TZnWQGpF2olD
         uGLvtNPlIAmdsHfDkoW4BnfZs1flgjgkdPMh+gx9rppah0S/hajaOFAfaPHlGlGRhAUw
         UOQ3YRUabWENsRnhFMr6JaHXktYn7krBaTpR/rIyb31stu94zFYRgkVcv5YURQM7qhV2
         t5NFe73izFRSjn1s8XL99h3w8uZ/1NHm39yoKyHcmq+dmIhxY4/lGiv9tjtSjt2tHjLn
         kreZgT+O723mZsRmhFfP14yop6Zjt5IEqPDiY6sL0aLx1/UoxqcBfBFm8fgkNbAfCVNW
         zh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873230; x=1683465230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/EkXHhpekudgYRSVvD2Wp54aMGgIOeanmC+1OUeyjw=;
        b=mrHdMidJ7tPovgJPfIpcRjpB7ELDUTQ3gnL7mxexU6dSD4/gsm4u+i3SRWm4/xR42b
         ZK9hvb77iyxizgYFnYhOdsgMCWSS9GhBCr6eZJ8YnPPna+PsjfnJ6E6poZ+5o9VHk1o4
         a8ZfEJG1VN6wKimsRVTOi2IyG17tBiyicBgTJjlkcpP0PCt27J+kDuOXH1Jx8wZAqkZV
         mGGwlkuCIaWXVniA6sk4rz3vIqds+ABVRjj862g84pGZa/m9mXq3RGa2J6l0k9mydglP
         vUDdsSeSmgqgQyJABRwIKkyLPxg2AXTpuh0bnBk3ScXhdupyFMC0nZL6B6Vr4ZCEUDaL
         GHmg==
X-Gm-Message-State: AAQBX9ek3ZgBLmQ9+8ZPtrMjC9GuOf2y8kY04Sn9L8OMig4pJfLXIgs6
        ryQKAnYkYlYP8Xt5DgT4pQunJ0ibBKSGUvWrgkT/xQ==
X-Google-Smtp-Source: AKy350akqDsJXu8LyrjpR3lx1Wv1xBy9qWRvVsjm6zQR79fUvbUwSsanR9UopPQcb5ZzGjYyfda/gmvkrWB1tttm4+o=
X-Received: by 2002:a25:6e85:0:b0:b78:1b26:a642 with SMTP id
 j127-20020a256e85000000b00b781b26a642mr1408026ybc.1.1680873230051; Fri, 07
 Apr 2023 06:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com> <20230203-evk-board-support-v5-9-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-9-1883c1b405ad@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 7 Apr 2023 15:13:39 +0200
Message-ID: <CAFGrd9oZW0xjoXXPgZoqwMbgT5ovnRbDr+mZMPO=D2oee7tuuw@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] arm64: dts: mediatek: add ethernet support for mt8365-evk
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        catalin.marinas@arm.com, Will Deacon <will@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ To: Catalin Marinas <catalin.marinas@arm.com>
+ To: Will Deacon <will@kernel.org>

Sorry for the noise.

Regards,
Alexandre

Le ven. 7 avr. 2023 =C3=A0 14:59, Alexandre Mergnat <amergnat@baylibre.com>=
 a =C3=A9crit :
>
> - Enable "vibr" and "vsim2" regulators to power the ethernet chip.
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 57 +++++++++++++++++++++++=
++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boo=
t/dts/mediatek/mt8365-evk.dts
> index 9760f181eb34..431078f8670e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -88,6 +88,28 @@ optee_reserved: optee@43200000 {
>         };
>  };
>
> +&ethernet {
> +       pinctrl-0 =3D <&ethernet_pins>;
> +       pinctrl-names =3D "default";
> +       phy-handle =3D <&eth_phy>;
> +       phy-mode =3D "rmii";
> +       /*
> +        * Ethernet and HDMI (DSI0) are sharing pins.
> +        * Only one can be enabled at a time and require the physical swi=
tch
> +        * SW2101 to be set on LAN position
> +        */
> +       status =3D "disabled";
> +
> +       mdio {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               eth_phy: ethernet-phy@0 {
> +                       reg =3D <0>;
> +               };
> +       };
> +};
> +
>  &i2c0 {
>         clock-frequency =3D <100000>;
>         pinctrl-0 =3D <&i2c0_pins>;
> @@ -137,12 +159,47 @@ &mt6357_pmic {
>         #interrupt-cells =3D <2>;
>  };
>
> +/* Needed by analog switch (multiplexer), HDMI and ethernet */
> +&mt6357_vibr_reg {
> +       regulator-always-on;
> +};
> +
>  /* Needed by MSDC1 */
>  &mt6357_vmc_reg {
>         regulator-always-on;
>  };
>
> +/* Needed by ethernet */
> +&mt6357_vsim2_reg {
> +       regulator-always-on;
> +};
> +
>  &pio {
> +       ethernet_pins: ethernet-pins {
> +               phy_reset_pins {
> +                       pinmux =3D <MT8365_PIN_133_TDM_TX_DATA1__FUNC_GPI=
O133>;
> +               };
> +
> +               rmii_pins {
> +                       pinmux =3D <MT8365_PIN_0_GPIO0__FUNC_EXT_TXD0>,
> +                                <MT8365_PIN_1_GPIO1__FUNC_EXT_TXD1>,
> +                                <MT8365_PIN_2_GPIO2__FUNC_EXT_TXD2>,
> +                                <MT8365_PIN_3_GPIO3__FUNC_EXT_TXD3>,
> +                                <MT8365_PIN_4_GPIO4__FUNC_EXT_TXC>,
> +                                <MT8365_PIN_5_GPIO5__FUNC_EXT_RXER>,
> +                                <MT8365_PIN_6_GPIO6__FUNC_EXT_RXC>,
> +                                <MT8365_PIN_7_GPIO7__FUNC_EXT_RXDV>,
> +                                <MT8365_PIN_8_GPIO8__FUNC_EXT_RXD0>,
> +                                <MT8365_PIN_9_GPIO9__FUNC_EXT_RXD1>,
> +                                <MT8365_PIN_10_GPIO10__FUNC_EXT_RXD2>,
> +                                <MT8365_PIN_11_GPIO11__FUNC_EXT_RXD3>,
> +                                <MT8365_PIN_12_GPIO12__FUNC_EXT_TXEN>,
> +                                <MT8365_PIN_13_GPIO13__FUNC_EXT_COL>,
> +                                <MT8365_PIN_14_GPIO14__FUNC_EXT_MDIO>,
> +                                <MT8365_PIN_15_GPIO15__FUNC_EXT_MDC>;
> +               };
> +       };
> +
>         gpio_keys: gpio-keys-pins {
>                 pins {
>                         pinmux =3D <MT8365_PIN_24_KPCOL0__FUNC_KPCOL0>;
>
> --
> 2.25.1
>
