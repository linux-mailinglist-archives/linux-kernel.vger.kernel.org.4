Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589B06548C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiLVW6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiLVW6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:58:25 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE2527DEF;
        Thu, 22 Dec 2022 14:58:23 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d20so4987492edn.0;
        Thu, 22 Dec 2022 14:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6S0Lt5KYa3HRAUybKFxyY4GbQJ+ErYvhNV9LKperUw=;
        b=LEKX8KA0cPHJB+BuTxQW5r4j7kDKSEK7TD4yk2JqXULxSAIy5QgTk3VsPP81AFA9AE
         5lFsPdixIK9bj3H7gyAVcFxnEl/SJr4wt1P25SfxWFXkJe6lfAU1aWJwwC7Y3JBoyNmK
         FPUnuEhg9O9zx62HVwPQezZHgiBNjYBGznlHxF7A4i/+Istwyw39yVO4C3aI9r2veUDS
         Ce4bPMh/Bx+jvkqrov9VG5AKKnSmHj7RchQryHS5G5R4+oNwCiW7NNG9lcnf6iRyRudP
         yI5Mr4zp7tmEcCt63w2VuYY4Ow8+mT+Eb28JQSw1zcZLepaK5J+cziIC85mHiykaHaWw
         gXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6S0Lt5KYa3HRAUybKFxyY4GbQJ+ErYvhNV9LKperUw=;
        b=DP8x4TIrV2cmpDjNVqCwCPD+OB4MrQ7E/sOAvw+eJ5z7k/Oph8PGfK6XlOAn8OkWy6
         qgcbs03+vK+b3tHLGK9D1vluFfYxttoJD/CGTndlni3vY7vid8zcjNzEg5CNyYXpcu0N
         Dv5iXP0QaCmkhtKn4BEEr5D3GO8XaXB9QzJ0LzCkSf7vaUmZUo5/fQaSb9LJbyHWPIlv
         q62BV6NlvsrWVGMpx8ekcV0OER9nviw442uM8A0nP9RGSQM4hbyBqoXdc2sBe4k0WMEp
         Ra4g9ACCe3qVAkMBGts3jIJ0FYA2toLzZ1vvrQah+JiAzgfrWiszI6rPbSURFQIsA0yr
         I2CQ==
X-Gm-Message-State: AFqh2kpU4Mume0lB7Phoct8pLpjZWUcJD97/5wvuq/Dm6Ybr6TdnM0Ii
        hbl9nDTy4fFM8dA1THNdEYK4rTC38cOvop7IyAg=
X-Google-Smtp-Source: AMrXdXvGk+67GC7ngRo/E7065hifKi2SjiD3loE771TWBEQ5gDVM8+pi3DKYiz737YP8YCpnjMTLz+9QlOY5lP3Tz7s=
X-Received: by 2002:a05:6402:501a:b0:46d:e66d:cd8f with SMTP id
 p26-20020a056402501a00b0046de66dcd8fmr632854eda.233.1671749901716; Thu, 22
 Dec 2022 14:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20221222223830.2494900-1-javierm@redhat.com> <20221222223830.2494900-5-javierm@redhat.com>
In-Reply-To: <20221222223830.2494900-5-javierm@redhat.com>
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
Date:   Thu, 22 Dec 2022 23:57:45 +0100
Message-ID: <CAO_Mup+P-QMDfVzpg_eg=gmoHUzm6+Kipaq-4q=kdVdS0_xp6A@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rk3399-pinephone-pro: Add internal
 display support
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
        Robert Mader <robert.mader@posteo.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?Q?Kamil_Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Caleb Connolly <kc@postmarketos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
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

Nice to see Pinephone Pro getting worked on.

czw., 22 gru 2022 o 23:39 Javier Martinez Canillas
<javierm@redhat.com> napisa=C5=82(a):
>
> From: Ondrej Jirman <megi@xff.cz>
>
> The phone's display is using Hannstar LCD panel, and Goodix based
> touchscreen. Support it.
>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Martijn Braam <martijn@brixit.nl>
> Signed-off-by: Martijn Braam <martijn@brixit.nl>
> Co-developed-by: Kamil Trzci=C5=84ski <ayufan@ayufan.eu>
> Signed-off-by: Kamil Trzci=C5=84ski <ayufan@ayufan.eu>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  .../dts/rockchip/rk3399-pinephone-pro.dts     | 124 ++++++++++++++++++
>  1 file changed, 124 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch=
/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index 0e4442b59a55..a0439a60395e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -29,6 +29,12 @@ chosen {
>                 stdout-path =3D "serial2:1500000n8";
>         };
>
> +       backlight: backlight {
> +               compatible =3D "pwm-backlight";
> +               pwms =3D <&pwm0 0 1000000 0>;
> +               pwm-delay-us =3D <10000>;
> +       };
> +
>         gpio-keys {
>                 compatible =3D "gpio-keys";
>                 pinctrl-names =3D "default";
> @@ -81,6 +87,32 @@ vcc1v8_codec: vcc1v8-codec-regulator {
>                 regulator-max-microvolt =3D <1800000>;
>                 vin-supply =3D <&vcc3v3_sys>;
>         };
> +
> +       /* MIPI DSI panel 1.8v supply */
> +       vcc1v8_lcd: vcc1v8-lcd {
Node names should be generic, for example "vcc1v8-lcd-regulator".

> +               compatible =3D "regulator-fixed";
> +               enable-active-high;
Is this really needed?
You can set the polarity in "gpios" property.

> +               regulator-name =3D "vcc1v8_lcd";
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;
> +               vin-supply =3D <&vcc3v3_sys>;
> +               gpio =3D <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
Is this a typo? Documentation says "gpios"

> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&display_pwren1>;
> +       };
> +
> +       /* MIPI DSI panel 2.8v supply */
> +       vcc2v8_lcd: vcc2v8-lcd {
> +               compatible =3D "regulator-fixed";
> +               enable-active-high;
Ditto

> +               regulator-name =3D "vcc2v8_lcd";
> +               regulator-min-microvolt =3D <2800000>;
> +               regulator-max-microvolt =3D <2800000>;
> +               vin-supply =3D <&vcc3v3_sys>;
> +               gpio =3D <&gpio3 RK_PA1 GPIO_ACTIVE_HIGH>;
Same as before

> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&display_pwren>;
> +       };
>  };
>
>  &cpu_l0 {
> @@ -111,6 +143,11 @@ &emmc_phy {
>         status =3D "okay";
>  };
>
> +&gpu {
> +       mali-supply =3D <&vdd_gpu>;
> +       status =3D "okay";
> +};
> +
>  &i2c0 {
>         clock-frequency =3D <400000>;
>         i2c-scl-rising-time-ns =3D <168>;
> @@ -193,6 +230,9 @@ vcc3v0_touch: LDO_REG2 {
>                                 regulator-name =3D "vcc3v0_touch";
>                                 regulator-min-microvolt =3D <3000000>;
>                                 regulator-max-microvolt =3D <3000000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         vcca1v8_codec: LDO_REG3 {
> @@ -326,6 +366,26 @@ opp07 {
>         };
>  };
>
> +&i2c3 {
> +       i2c-scl-rising-time-ns =3D <450>;
> +       i2c-scl-falling-time-ns =3D <15>;
> +       status =3D "okay";
> +
> +       touchscreen@14 {
> +               compatible =3D "goodix,gt917s";
> +               reg =3D <0x14>;
> +               interrupt-parent =3D <&gpio3>;
> +               interrupts =3D <RK_PB5 IRQ_TYPE_EDGE_RISING>;
> +               irq-gpios =3D <&gpio3 RK_PB5 GPIO_ACTIVE_HIGH>;
> +               reset-gpios =3D <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
> +               AVDD28-supply =3D <&vcc3v0_touch>;
> +               VDDIO-supply =3D <&vcc3v0_touch>;
> +               touchscreen-size-x =3D <720>;
> +               touchscreen-size-y =3D <1440>;
> +               poweroff-in-suspend;
Are you really sure this property exists in touchscreen driver's dt binding=
s?

> +       };
> +};
> +
>  &io_domains {
>         bt656-supply =3D <&vcc1v8_dvp>;
>         audio-supply =3D <&vcca1v8_codec>;
> @@ -334,6 +394,40 @@ &io_domains {
>         status =3D "okay";
>  };
>
> +&mipi_dsi {
> +       status =3D "okay";
> +       clock-master;
> +
> +       ports {
> +               mipi_out: port@1 {
> +                       #address-cells =3D <0>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <1>;
> +
> +                       mipi_out_panel: endpoint {
> +                               remote-endpoint =3D <&mipi_in_panel>;
> +                       };
> +               };
> +       };
> +
> +       panel@0 {
> +               compatible =3D "hannstar,hsd060bhw4";
> +               reg =3D <0>;
> +               backlight =3D <&backlight>;
> +               reset-gpios =3D <&gpio4 RK_PD1 GPIO_ACTIVE_LOW>;
> +               vcc-supply =3D <&vcc2v8_lcd>; // 2v8
What is the purpose of that comment?

> +               iovcc-supply =3D <&vcc1v8_lcd>; // 1v8
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&display_rst_l>;
> +
> +               port {
> +                       mipi_in_panel: endpoint {
> +                               remote-endpoint =3D <&mipi_out_panel>;
> +                       };
> +               };
> +       };
> +};
> +
>  &pmu_io_domains {
>         pmu1830-supply =3D <&vcc_1v8>;
>         status =3D "okay";
> @@ -360,6 +454,20 @@ vsel2_pin: vsel2-pin {
>                 };
>         };
>
> +       dsi {
> +               display_rst_l: display-rst-l {
> +                       rockchip,pins =3D <4 RK_PD1 RK_FUNC_GPIO &pcfg_pu=
ll_down>;
> +               };
> +
> +               display_pwren: display-pwren {
> +                       rockchip,pins =3D <3 RK_PA1 RK_FUNC_GPIO &pcfg_pu=
ll_down>;
> +               };
> +
> +               display_pwren1: display-pwren1 {
> +                       rockchip,pins =3D <3 RK_PA5 RK_FUNC_GPIO &pcfg_pu=
ll_down>;
> +               };
> +       };
> +
>         sound {
>                 vcc1v8_codec_en: vcc1v8-codec-en {
>                         rockchip,pins =3D <3 RK_PA4 RK_FUNC_GPIO &pcfg_pu=
ll_down>;
> @@ -367,6 +475,10 @@ vcc1v8_codec_en: vcc1v8-codec-en {
>         };
>  };
>
> +&pwm0 {
> +       status =3D "okay";
> +};
> +
>  &sdmmc {
>         bus-width =3D <4>;
>         cap-sd-highspeed;
> @@ -396,3 +508,15 @@ &tsadc {
>  &uart2 {
>         status =3D "okay";
>  };
> +
> +&vopb {
> +       status =3D "okay";
> +       assigned-clocks =3D <&cru DCLK_VOP0_DIV>, <&cru DCLK_VOP0>,
> +                         <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
> +       assigned-clock-rates =3D <0>, <0>, <400000000>, <100000000>;
> +       assigned-clock-parents =3D <&cru PLL_CPLL>, <&cru DCLK_VOP0_FRAC>=
;
> +};
> +
> +&vopb_mmu {
> +       status =3D "okay";
> +};
> --
> 2.38.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Best Regards,
Maya Matuszczyk
