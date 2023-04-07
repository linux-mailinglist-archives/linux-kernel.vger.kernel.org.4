Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6DE6DAD3F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbjDGNM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjDGNMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:12:54 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B67AF18
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:12:51 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f188so30489328ybb.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680873170; x=1683465170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jogom33BA4lYsCGNiQEHTElBE5htrobQ35E378fTju4=;
        b=Vk87nKeUU93sXRg8q9QQK0+RQ3A/rPafNC/njQ08yjVQuFKrd9hO5LXxQO4nbpizhc
         gF+UwGjQ0ChEpZOaD/MFaPne/fvbQCAhqrhCypfbkj5e4M6rM/LxZeIO8TSalXyGFy9n
         JDMncKaj/92OlOmH8hnk6EFHS+iRHSxTMM5K50Nq7OUACibecdAa4ndc21CgWQ5OgnHj
         mWkBUyRf6EgIOtugHyBlpNJf27+hQjFEbNnb6T67bmg1bXRvSdu/H4yD+uT/O3Qyby9k
         +4Y6iDYGVfkcgpAxS5eV3gEEQJdc/nO9hcHpQ4I1XmBK9Up0RC20KHU28Y/Wmio8rm86
         Ey0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873170; x=1683465170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jogom33BA4lYsCGNiQEHTElBE5htrobQ35E378fTju4=;
        b=liuqO1rjaFcBaWjAxZKm64K/Qm7OoMim03UiF4+aNyz1VJYerwrlbicEAOrR5XuXV/
         /l1qxjztT0jFPfoDs2ns5mO24eVcm1hlMufrJrRKPXxc+YDpkezWafJt0e5wLZWAmh4z
         1Ydr1jYHdCdP12Ru0YIU0T2e06eRP6SQN8Kcj261hHjaDjY+HZ+CKxljRL22oHM5rbyf
         SSAauBVpgbSEe+V3IaCI27aFs8UUEHBJhDxUGQ4awZxWSDs8dZRHRjMchaUMwfk3poaE
         q+POFcfCWe7C34WpSrx4hHtIP8mjVum0lD5THDSpn51aZLI99ODR0nJDg8JUaZCHOCdQ
         qnoQ==
X-Gm-Message-State: AAQBX9ds53USRNt/6L4RN9YQWNrjXMOqL3pKaYh2geg4cos9+R+Ph2u3
        l43BACug6pUDFrnPhfJ819amsbvo94+tXWKJILVOsA==
X-Google-Smtp-Source: AKy350bijn8o3rBblLPfBL1Ss/jCgPrDSmPFvUI5sV3I/0v7aurVKvDdC/NxVZYxnThR0jOq7wtEZe83KaKwIJbGCcI=
X-Received: by 2002:a25:d114:0:b0:b68:7b14:186b with SMTP id
 i20-20020a25d114000000b00b687b14186bmr1502101ybg.1.1680873170538; Fri, 07 Apr
 2023 06:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com> <20230203-evk-board-support-v5-6-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-6-1883c1b405ad@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 7 Apr 2023 15:12:39 +0200
Message-ID: <CAFGrd9q8sPGAhHWoxo_a2uVK35MA0=4hOFtJKesHUTZJMn1m=Q@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] arm64: dts: mediatek: add mmc support for mt8365-evk
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
> - Add EMMC support on mmc0 (internal memory)
> - Add SD-UHS support on mmc1 (external memory)
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 138 ++++++++++++++++++++++=
++++++
>  1 file changed, 138 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boo=
t/dts/mediatek/mt8365-evk.dts
> index a238bd0092d2..cd920d09c3fe 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -95,6 +95,42 @@ &i2c0 {
>         status =3D "okay";
>  };
>
> +&mmc0 {
> +       assigned-clock-parents =3D <&topckgen CLK_TOP_MSDCPLL>;
> +       assigned-clocks =3D <&topckgen CLK_TOP_MSDC50_0_SEL>;
> +       bus-width =3D <8>;
> +       cap-mmc-highspeed;
> +       cap-mmc-hw-reset;
> +       hs400-ds-delay =3D <0x12012>;
> +       max-frequency =3D <200000000>;
> +       mmc-hs200-1_8v;
> +       mmc-hs400-1_8v;
> +       no-sd;
> +       no-sdio;
> +       non-removable;
> +       pinctrl-0 =3D <&mmc0_default_pins>;
> +       pinctrl-1 =3D <&mmc0_uhs_pins>;
> +       pinctrl-names =3D "default", "state_uhs";
> +       vmmc-supply =3D <&mt6357_vemc_reg>;
> +       vqmmc-supply =3D <&mt6357_vio18_reg>;
> +       status =3D "okay";
> +};
> +
> +&mmc1 {
> +       bus-width =3D <4>;
> +       cap-sd-highspeed;
> +       cd-gpios =3D <&pio 76 GPIO_ACTIVE_LOW>;
> +       max-frequency =3D <200000000>;
> +       pinctrl-0 =3D <&mmc1_default_pins>;
> +       pinctrl-1 =3D <&mmc1_uhs_pins>;
> +       pinctrl-names =3D "default", "state_uhs";
> +       sd-uhs-sdr104;
> +       sd-uhs-sdr50;
> +       vmmc-supply =3D <&mt6357_vmch_reg>;
> +       vqmmc-supply =3D <&mt6357_vio18_reg>;
> +       status =3D "okay";
> +};
> +
>  &mt6357_pmic {
>         interrupts-extended =3D <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
>         interrupt-controller;
> @@ -118,6 +154,108 @@ pins {
>                 };
>         };
>
> +       mmc0_default_pins: mmc0-default-pins {
> +               clk-pins {
> +                       pinmux =3D <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_C=
LK>;
> +                       bias-pull-down;
> +               };
> +
> +               cmd-dat-pins {
> +                       pinmux =3D <MT8365_PIN_103_MSDC0_DAT0__FUNC_MSDC0=
_DAT0>,
> +                                <MT8365_PIN_102_MSDC0_DAT1__FUNC_MSDC0_D=
AT1>,
> +                                <MT8365_PIN_101_MSDC0_DAT2__FUNC_MSDC0_D=
AT2>,
> +                                <MT8365_PIN_100_MSDC0_DAT3__FUNC_MSDC0_D=
AT3>,
> +                                <MT8365_PIN_96_MSDC0_DAT4__FUNC_MSDC0_DA=
T4>,
> +                                <MT8365_PIN_95_MSDC0_DAT5__FUNC_MSDC0_DA=
T5>,
> +                                <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DA=
T6>,
> +                                <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DA=
T7>,
> +                                <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD=
>;
> +                       input-enable;
> +                       bias-pull-up;
> +               };
> +
> +               rst-pins {
> +                       pinmux =3D <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_=
RSTB>;
> +                       bias-pull-up;
> +               };
> +       };
> +
> +       mmc0_uhs_pins: mmc0-uhs-pins {
> +               clk-pins {
> +                       pinmux =3D <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_C=
LK>;
> +                       drive-strength =3D <MTK_DRIVE_10mA>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               cmd-dat-pins {
> +                       pinmux =3D <MT8365_PIN_103_MSDC0_DAT0__FUNC_MSDC0=
_DAT0>,
> +                                <MT8365_PIN_102_MSDC0_DAT1__FUNC_MSDC0_D=
AT1>,
> +                                <MT8365_PIN_101_MSDC0_DAT2__FUNC_MSDC0_D=
AT2>,
> +                                <MT8365_PIN_100_MSDC0_DAT3__FUNC_MSDC0_D=
AT3>,
> +                                <MT8365_PIN_96_MSDC0_DAT4__FUNC_MSDC0_DA=
T4>,
> +                                <MT8365_PIN_95_MSDC0_DAT5__FUNC_MSDC0_DA=
T5>,
> +                                <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DA=
T6>,
> +                                <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DA=
T7>,
> +                                <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD=
>;
> +                       input-enable;
> +                       drive-strength =3D <MTK_DRIVE_10mA>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +
> +               ds-pins {
> +                       pinmux =3D <MT8365_PIN_104_MSDC0_DSL__FUNC_MSDC0_=
DSL>;
> +                       drive-strength =3D <MTK_DRIVE_10mA>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               rst-pins {
> +                       pinmux =3D <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_=
RSTB>;
> +                       drive-strength =3D <MTK_DRIVE_10mA>;
> +                       bias-pull-up;
> +               };
> +       };
> +
> +       mmc1_default_pins: mmc1-default-pins {
> +               cd-pins {
> +                       pinmux =3D <MT8365_PIN_76_CMDAT8__FUNC_GPIO76>;
> +                       bias-pull-up;
> +               };
> +
> +               clk-pins {
> +                       pinmux =3D <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_C=
LK>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               cmd-dat-pins {
> +                       pinmux =3D <MT8365_PIN_89_MSDC1_DAT0__FUNC_MSDC1_=
DAT0>,
> +                                <MT8365_PIN_90_MSDC1_DAT1__FUNC_MSDC1_DA=
T1>,
> +                                <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DA=
T2>,
> +                                <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DA=
T3>,
> +                                <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD=
>;
> +                       input-enable;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +       };
> +
> +       mmc1_uhs_pins: mmc1-uhs-pins {
> +               clk-pins {
> +                       pinmux =3D <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_C=
LK>;
> +                       drive-strength =3D <MTK_DRIVE_8mA>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               cmd-dat-pins {
> +                       pinmux =3D <MT8365_PIN_89_MSDC1_DAT0__FUNC_MSDC1_=
DAT0>,
> +                                <MT8365_PIN_90_MSDC1_DAT1__FUNC_MSDC1_DA=
T1>,
> +                                <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DA=
T2>,
> +                                <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DA=
T3>,
> +                                <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD=
>;
> +                       input-enable;
> +                       drive-strength =3D <MTK_DRIVE_6mA>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +       };
> +
>         uart0_pins: uart0-pins {
>                 pins {
>                         pinmux =3D <MT8365_PIN_35_URXD0__FUNC_URXD0>,
>
> --
> 2.25.1
>
