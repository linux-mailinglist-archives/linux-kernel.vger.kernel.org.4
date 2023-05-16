Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA050705672
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjEPS4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEPS4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:56:06 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE01FD4;
        Tue, 16 May 2023 11:55:54 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-61b58779b93so131986136d6.0;
        Tue, 16 May 2023 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263353; x=1686855353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Gk842cjdG4K5CczpFcCYjTPpnd2QPxUhAOZdTaJ7C0=;
        b=gagBmnpbS1yHWXR+HM/UDTCaKNAyPZNX4WHVuvsFZwaRkrafAciWV4Pl5SUzzs4KLT
         vpR8q1ffO7YMmhHt+W/qvuSd+NyuKc7WQHgM9a0mUduSKSoc/GziJARj/smayteIgRTv
         XU3EbITFlRaqcczRPQsXZ2kB8gmsOn4c7XGjFmU3lFCm83upVX+mBviZLXzpbibDQ5oh
         6xUGqdT1naBHzHqIDbqD/4hCNc9wYDCSl2D4kx8kB0+nYaougBbrMDv9PVsBvdloDseY
         z0UKWGq5+7clKCG2WY0hzTT9kjJFkGSqTv1SBIsamsMb9U4kB5QmPEFBSajeJdGs0a0H
         GX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263353; x=1686855353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Gk842cjdG4K5CczpFcCYjTPpnd2QPxUhAOZdTaJ7C0=;
        b=KDmIEi5NwRC0kQmwG/aOclrqUe7gAfZ1X6m7cXaTpaFGotiejGESMVD5/ApkA6MhWO
         qC9Bxwoz7LZAZal/5I+oeHCO2LsGyVKe9eIN+FGemr3kKRGXSK+0boByyq9AjUnNkuEz
         NI+EXr14+/ResAU89b4QfI5qZTWV0GZcTcisqPdsKeeL7yMLGAo24B3nVFisucrHbv5m
         FSPqjfaF4WCREO5vN3sU+oKSX7JP8oFbQeTkycUhf7DonnrvBbXrlO2VPL7h1IV8d9Pe
         ZKCmBja81Cr/sBDW27nIjk4jtrmpTXyQ4CgdQsZOo4tZ17VNiHHLgOp/2nS0aPuMf+O6
         0XUg==
X-Gm-Message-State: AC+VfDy274LmV2rGlFdQ4TwfOr7oIYcdIUP4uuXz6uvgZxsMTUSG2lsa
        JH01XN6uN5IL+oPktTfR/vp7omaagsFPt4rshAw=
X-Google-Smtp-Source: ACHHUZ7XAuPsG6Afx/bxFCgAWWhfY5B3L0rYnlnXe6OigWDX0i0D/785g4aZkS7MVjXZ1JEywIz1S9SrhlPBBJAjQNc=
X-Received: by 2002:a05:6214:dab:b0:5a9:1bd5:375e with SMTP id
 h11-20020a0562140dab00b005a91bd5375emr66252019qvh.21.1684263353143; Tue, 16
 May 2023 11:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683719613.git.noodles@earth.li> <cover.1684258957.git.noodles@earth.li>
 <dde40307f0ebc23b9841c32e702b481ab5193dc4.1684258957.git.noodles@earth.li>
In-Reply-To: <dde40307f0ebc23b9841c32e702b481ab5193dc4.1684258957.git.noodles@earth.li>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 May 2023 21:55:17 +0300
Message-ID: <CAHp75Vdca-dAzVnoxjDtNKGo+EV-DVT3iRccVgQ4GbsMwU5uYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] pinctrl: axp209: Add support for GPIO3 on the AXP209
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 8:47=E2=80=AFPM Jonathan McDowell <noodles@earth.li=
> wrote:
>
> The AXP209 device has a 4th GPIO which has a slightly different register
> setup, where the control + status bits are held in a single register
> rather than sharing AXP20X_GPIO20_SS with GPIOs 0-2.

LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan McDowell <noodles@earth.li>
> ---
>  drivers/pinctrl/pinctrl-axp209.c | 42 ++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-a=
xp209.c
> index 0bc1b381a2b8..b3ba25435c34 100644
> --- a/drivers/pinctrl/pinctrl-axp209.c
> +++ b/drivers/pinctrl/pinctrl-axp209.c
> @@ -30,6 +30,11 @@
>  #define AXP20X_GPIO_FUNCTION_OUT_HIGH  1
>  #define AXP20X_GPIO_FUNCTION_INPUT     2
>
> +#define AXP20X_GPIO3_FUNCTIONS         GENMASK(2, 1)
> +#define AXP20X_GPIO3_FUNCTION_OUT_LOW  0
> +#define AXP20X_GPIO3_FUNCTION_OUT_HIGH 2
> +#define AXP20X_GPIO3_FUNCTION_INPUT    4
> +
>  #define AXP20X_FUNC_GPIO_OUT           0
>  #define AXP20X_FUNC_GPIO_IN            1
>  #define AXP20X_FUNC_LDO                        2
> @@ -73,6 +78,7 @@ static const struct pinctrl_pin_desc axp209_pins[] =3D =
{
>         PINCTRL_PIN(0, "GPIO0"),
>         PINCTRL_PIN(1, "GPIO1"),
>         PINCTRL_PIN(2, "GPIO2"),
> +       PINCTRL_PIN(3, "GPIO3"),
>  };
>
>  static const struct pinctrl_pin_desc axp22x_pins[] =3D {
> @@ -130,6 +136,14 @@ static int axp20x_gpio_get(struct gpio_chip *chip, u=
nsigned int offset)
>         unsigned int val;
>         int ret;
>
> +       /* AXP209 has GPIO3 status sharing the settings register */
> +       if (offset =3D=3D 3) {
> +               ret =3D regmap_read(pctl->regmap, AXP20X_GPIO3_CTRL, &val=
);
> +               if (ret)
> +                       return ret;
> +               return !!(val & BIT(0));
> +       }
> +
>         ret =3D regmap_read(pctl->regmap, AXP20X_GPIO20_SS, &val);
>         if (ret)
>                 return ret;
> @@ -144,6 +158,17 @@ static int axp20x_gpio_get_direction(struct gpio_chi=
p *chip,
>         unsigned int val;
>         int reg, ret;
>
> +       /* AXP209 GPIO3 settings have a different layout */
> +       if (offset =3D=3D 3) {
> +               ret =3D regmap_read(pctl->regmap, AXP20X_GPIO3_CTRL, &val=
);
> +               if (ret)
> +                       return ret;
> +               if (val & AXP20X_GPIO3_FUNCTION_INPUT)
> +                       return GPIO_LINE_DIRECTION_IN;
> +
> +               return GPIO_LINE_DIRECTION_OUT;
> +       }
> +
>         reg =3D axp20x_gpio_get_reg(offset);
>         if (reg < 0)
>                 return reg;
> @@ -184,6 +209,15 @@ static void axp20x_gpio_set(struct gpio_chip *chip, =
unsigned int offset,
>         struct axp20x_pctl *pctl =3D gpiochip_get_data(chip);
>         int reg;
>
> +       /* AXP209 has GPIO3 status sharing the settings register */
> +       if (offset =3D=3D 3) {
> +               regmap_update_bits(pctl->regmap, AXP20X_GPIO3_CTRL,
> +                                  AXP20X_GPIO3_FUNCTIONS,
> +                                  value ? AXP20X_GPIO3_FUNCTION_OUT_HIGH=
 :
> +                                  AXP20X_GPIO3_FUNCTION_OUT_LOW);
> +               return;
> +       }
> +
>         reg =3D axp20x_gpio_get_reg(offset);
>         if (reg < 0)
>                 return;
> @@ -200,6 +234,14 @@ static int axp20x_pmx_set(struct pinctrl_dev *pctlde=
v, unsigned int offset,
>         struct axp20x_pctl *pctl =3D pinctrl_dev_get_drvdata(pctldev);
>         int reg;
>
> +       /* AXP209 GPIO3 settings have a different layout */
> +       if (offset =3D=3D 3) {
> +               return regmap_update_bits(pctl->regmap, AXP20X_GPIO3_CTRL=
,
> +                                  AXP20X_GPIO3_FUNCTIONS,
> +                                  config =3D=3D AXP20X_MUX_GPIO_OUT ? AX=
P20X_GPIO3_FUNCTION_OUT_LOW :
> +                                  AXP20X_GPIO3_FUNCTION_INPUT);
> +       }
> +
>         reg =3D axp20x_gpio_get_reg(offset);
>         if (reg < 0)
>                 return reg;
> --
> 2.39.2
>


--=20
With Best Regards,
Andy Shevchenko
