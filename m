Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16F774980E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjGFJNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGFJNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:13:25 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BDDDB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 02:13:24 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5661eb57452so294638eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688634803; x=1691226803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4z5eEpTPvay/6CVOmHJTXP35NdcdpfCaDARpCSZzWY=;
        b=zRRM+Qi7i521/2BjoIcMMyQsW70ZQ3Ssy71LW2GvcNcK+5fX5NQD84Yinngk3VBd8m
         XyZBVtxoFMzeQmKRK8atiYMT3E+NI8n5HHrum7sVnfC6QpDAOivKBaZLbSihup3xCu71
         dKmi4N8qVZ5onjL4Zw0B4mi/XFzQVQD2YgIjin6B9JLuVm0c1sIfrryl8yiq2uJd9nsW
         mB7M1evckNTBIA45xyPXZw2lc4+oI9qAAVzKKiIdLg4vrg5rKADcuSnBe/KB1Q7Yh6N2
         1ZNO6wPs++FGp/G9LTiIbtK1rTenMobFKcF7girsmTIDaPLfe/qcZEScoUPoQN43E/Xx
         5u2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688634803; x=1691226803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4z5eEpTPvay/6CVOmHJTXP35NdcdpfCaDARpCSZzWY=;
        b=SbMm0DdZmwBjr/SC9vn5u4qD6043WgJoHE5Z7w0KCXg5K38iRAQ0wyu8O8CFRtd00g
         /CJ0cHyQeymgoUrlP0sq7LMW7b6ynaGAsz9botLSZwT3HzkfOvGyER34DujlerzH+xoZ
         IhzgobPQW2cpNkOzhJwCcOW9B2DNzqmmQ9kWgSBrq1TsEOBaSXOdmTj15fNJfP2Twk0T
         24hZK1r9g4NYlD05sSAlabSGlUQOo+kR0in9wAFdFlUcp5U0evl1Bh49GeoHFkE6nVOM
         9kNZaZLdbWUyIgO1cNxt2VXHRbNz1iVKnlPajAAk8xlCJraruTCUAHhu1gB58SJVIFbz
         M7Og==
X-Gm-Message-State: ABy/qLaFjenwP/amkwCbQO4Ng+JGLlbysn8aYcfU6pnNoYP6e5vCQYVY
        UxJzKEvaetGK2C2qRNs7vLuwmJLYBE/as3KXcv8vVw==
X-Google-Smtp-Source: APBJJlFzql70CAJbc773CoOpi1a/c9q5w16gLNnXGHdoZRoQRQ+3+t7luebj7FnnTVYn+HRl0U3IUC1qN2UEy5Myf04=
X-Received: by 2002:a05:6358:2490:b0:134:c584:5585 with SMTP id
 m16-20020a056358249000b00134c5845585mr1757370rwc.3.1688634803446; Thu, 06 Jul
 2023 02:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org> <20230703-fix-boe-tv101wum-nl6-v3-4-bd6e9432c755@linaro.org>
In-Reply-To: <20230703-fix-boe-tv101wum-nl6-v3-4-bd6e9432c755@linaro.org>
From:   cong yang <yangcong5@huaqin.corp-partner.google.com>
Date:   Thu, 6 Jul 2023 17:13:12 +0800
Message-ID: <CAHwB_NKuhPzH-0qPDgXnjr-giKmDu3kP9-nLpiS8+f7XrHZoFA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/panel: ili9882t: Break out function for
 switching page
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 3, 2023 at 9:22=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> The ILI9882t has similarities with other Ilitek panels, such
> as the characteristic internal page switching code that uses
> the model number (0x98, 0x82) as parameter.
>
> We can clearly abstract out the page switching sequence from
> the initialization code.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 54 ++++++++++++++++++---=
------
>  1 file changed, 37 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9882t.c
> index 20f3cc37fa83..c1a0f10fbaf7 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> @@ -55,13 +55,33 @@ struct ili9882t {
>         struct gpio_desc *enable_gpio;
>  };
>
> +/* ILI9882-specific commands, add new commands as you decode them */
> +#define ILI9882T_DCS_SWITCH_PAGE       0xFF
> +
> +static int ili9882t_switch_page(struct mipi_dsi_device *dsi, u8 page)
> +{
> +       u8 switch_cmd[] =3D {0x98, 0x82, 0x00};
> +       int ret;
> +
> +       switch_cmd[2] =3D page;
> +
> +       ret =3D mipi_dsi_dcs_write(dsi, ILI9882T_DCS_SWITCH_PAGE, switch_=
cmd, 3);
> +       if (ret) {
> +               dev_err(&dsi->dev,
> +                       "error switching panel controller page (%d)\n", r=
et);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static int starry_ili9882t_init(struct mipi_dsi_device *dsi)
>  {
>         int ret;
>
>         msleep(5);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x01);
> +       ili9882t_switch_page(dsi, 0x01);
>         mipi_dsi_dcs_write_seq(dsi, 0x00, 0x42);
>         mipi_dsi_dcs_write_seq(dsi, 0x01, 0x11);
>         mipi_dsi_dcs_write_seq(dsi, 0x02, 0x00);
> @@ -192,7 +212,7 @@ static int starry_ili9882t_init(struct mipi_dsi_devic=
e *dsi)
>         mipi_dsi_dcs_write_seq(dsi, 0x8B, 0x07);
>         mipi_dsi_dcs_write_seq(dsi, 0x8C, 0x07);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x02);
> +       ili9882t_switch_page(dsi, 0x02);
>         mipi_dsi_dcs_write_seq(dsi, 0x29, 0x3A);
>         mipi_dsi_dcs_write_seq(dsi, 0x2A, 0x3B);
>
> @@ -211,12 +231,12 @@ static int starry_ili9882t_init(struct mipi_dsi_dev=
ice *dsi)
>         mipi_dsi_dcs_write_seq(dsi, 0x5E, 0x40);
>         mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x03);
> +       ili9882t_switch_page(dsi, 0x03);
>         mipi_dsi_dcs_write_seq(dsi, 0x20, 0x01);
>         mipi_dsi_dcs_write_seq(dsi, 0x21, 0x3C);
>         mipi_dsi_dcs_write_seq(dsi, 0x22, 0xFA);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x0A);
> +       ili9882t_switch_page(dsi, 0x0a);
>         mipi_dsi_dcs_write_seq(dsi, 0xE0, 0x01);
>         mipi_dsi_dcs_write_seq(dsi, 0xE2, 0x01);
>         mipi_dsi_dcs_write_seq(dsi, 0xE5, 0x91);
> @@ -224,10 +244,10 @@ static int starry_ili9882t_init(struct mipi_dsi_dev=
ice *dsi)
>         mipi_dsi_dcs_write_seq(dsi, 0xE7, 0x00);
>         mipi_dsi_dcs_write_seq(dsi, 0xE8, 0xFA);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x12);
> +       ili9882t_switch_page(dsi, 0x12);
>         mipi_dsi_dcs_write_seq(dsi, 0x87, 0x2C);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x05);
> +       ili9882t_switch_page(dsi, 0x05);
>         mipi_dsi_dcs_write_seq(dsi, 0x73, 0xE5);
>         mipi_dsi_dcs_write_seq(dsi, 0x7F, 0x6B);
>         mipi_dsi_dcs_write_seq(dsi, 0x6D, 0xA4);
> @@ -242,7 +262,7 @@ static int starry_ili9882t_init(struct mipi_dsi_devic=
e *dsi)
>         mipi_dsi_dcs_write_seq(dsi, 0x1D, 0x90);
>         mipi_dsi_dcs_write_seq(dsi, 0x86, 0x87);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x06);
> +       ili9882t_switch_page(dsi, 0x06);
>         mipi_dsi_dcs_write_seq(dsi, 0xC0, 0x80);
>         mipi_dsi_dcs_write_seq(dsi, 0xC1, 0x07);
>         mipi_dsi_dcs_write_seq(dsi, 0xCA, 0x58);
> @@ -256,7 +276,7 @@ static int starry_ili9882t_init(struct mipi_dsi_devic=
e *dsi)
>         mipi_dsi_dcs_write_seq(dsi, 0xD6, 0x55);
>         mipi_dsi_dcs_write_seq(dsi, 0xDC, 0x38);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x08);
> +       ili9882t_switch_page(dsi, 0x08);
>         mipi_dsi_dcs_write_seq(dsi, 0xE0, 0x00, 0x10, 0x2A, 0x4D, 0x61, 0=
x56, 0x6A, 0x6E, 0x79,
>                                0x76, 0x8F, 0x95, 0x98, 0xAE, 0xAA, 0xB2, =
0xBB, 0xCE, 0xC6, 0xBD,
>                                0xD5, 0xE2, 0xE8);
> @@ -264,10 +284,10 @@ static int starry_ili9882t_init(struct mipi_dsi_dev=
ice *dsi)
>                                0x76, 0x8F, 0x95, 0x98, 0xAE, 0xAA, 0xB2, =
0xBB, 0xCE, 0xC6, 0xBD,
>                                0xD5, 0xE2, 0xE8);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x04);
> +       ili9882t_switch_page(dsi, 0x04);
>         mipi_dsi_dcs_write_seq(dsi, 0xBA, 0x81);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x0C);
> +       ili9882t_switch_page(dsi, 0x0c);
>         mipi_dsi_dcs_write_seq(dsi, 0x00, 0x02);
>         mipi_dsi_dcs_write_seq(dsi, 0x01, 0x00);
>         mipi_dsi_dcs_write_seq(dsi, 0x02, 0x03);
> @@ -333,10 +353,10 @@ static int starry_ili9882t_init(struct mipi_dsi_dev=
ice *dsi)
>         mipi_dsi_dcs_write_seq(dsi, 0x3E, 0x0A);
>         mipi_dsi_dcs_write_seq(dsi, 0x3F, 0x1F);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x04);
> +       ili9882t_switch_page(dsi, 0x04);
>         mipi_dsi_dcs_write_seq(dsi, 0xBA, 0x01);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x0E);
> +       ili9882t_switch_page(dsi, 0x0e);
>         mipi_dsi_dcs_write_seq(dsi, 0x02, 0x0C);
>         mipi_dsi_dcs_write_seq(dsi, 0x20, 0x10);
>         mipi_dsi_dcs_write_seq(dsi, 0x25, 0x16);
> @@ -373,12 +393,12 @@ static int starry_ili9882t_init(struct mipi_dsi_dev=
ice *dsi)
>         mipi_dsi_dcs_write_seq(dsi, 0x07, 0x21);
>         mipi_dsi_dcs_write_seq(dsi, 0x04, 0x10);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x1E);
> +       ili9882t_switch_page(dsi, 0x1e);
>         mipi_dsi_dcs_write_seq(dsi, 0x60, 0x00);
>         mipi_dsi_dcs_write_seq(dsi, 0x64, 0x00);
>         mipi_dsi_dcs_write_seq(dsi, 0x6D, 0x00);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x0B);
> +       ili9882t_switch_page(dsi, 0x0b);
>         mipi_dsi_dcs_write_seq(dsi, 0xA6, 0x44);
>         mipi_dsi_dcs_write_seq(dsi, 0xA7, 0xB6);
>         mipi_dsi_dcs_write_seq(dsi, 0xA8, 0x03);
> @@ -389,13 +409,13 @@ static int starry_ili9882t_init(struct mipi_dsi_dev=
ice *dsi)
>         mipi_dsi_dcs_write_seq(dsi, 0xBD, 0x92);
>         mipi_dsi_dcs_write_seq(dsi, 0xBE, 0xA1);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x05);
> +       ili9882t_switch_page(dsi, 0x05);
>         mipi_dsi_dcs_write_seq(dsi, 0x86, 0x87);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x06);
> +       ili9882t_switch_page(dsi, 0x06);
>         mipi_dsi_dcs_write_seq(dsi, 0x92, 0x22);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x00);
> +       ili9882t_switch_page(dsi, 0x00);
>
>         ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
>         if (ret)
>
> --
> 2.34.1
>

Tested-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
