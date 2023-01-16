Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4684866B92D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjAPIlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjAPIlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:41:12 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB612F3E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:41:09 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id j1so6767082uan.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rmy9xWKqZX7zRRun3wsSqylOs2ufElH84diKh425GHw=;
        b=RLZiHyeQz8DQOgSt70ZPLUA4nB8ei/S7Z1eWT6qSdWVBGHqikIPDM8K9hzspnq//Ww
         W94HBuwbonmlktgdf53GYymc0yUumik6qFju2S8PrdrbmRyD9HfozTku4QPCbQh3AS5W
         Ks5bWajowar01Ox5/zV+Vov4MCYqTzO1qPqjrW/E4j4vd4sxkUXUDDw3vYDnhBJF4gCM
         VzcbnOUJgdvX0eF50nziCb1jXeZgOtmS2aVJ7kHL09+9cp8SNGCfbAAGv8rSsOd3gQri
         abTCkAuhmZ9d8znjsmeLCBYJnwz0ShfpVmsK40v6oZKrElBt4qrACUTMvNcgXVlCXYM8
         CGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rmy9xWKqZX7zRRun3wsSqylOs2ufElH84diKh425GHw=;
        b=r+3Dfvq2lWV8eMG69M4KjUf6dUh5NmtyIjhO5N/lSe1s7FRrbLWKo6OByIPB4gG8dB
         8TL+2QYDb3fiGZPAE0FJKp+X/b/ZEN6z7OaiokojDP0xkhZSIPy5BJ/nX7V63/OheEzs
         uV4w6cVx5nBf1WTSA1Nz0+uRYhSs7Klhebasy6IECeRoKWl4t4IgsgkkeaA++S49IIsr
         Zi07Xaz6xoB5H2OJjoKq47WPg40Ts71hkzk8hz46VI3cjWhT4bLMf8f38dxMwQYyiqAo
         hbiBsjn0IS/00knWPHeSNuG8RkaeXGGIRSa8rEcnfLEWzaMrFO1oTWNOhK5ECj3dqbPY
         E5mw==
X-Gm-Message-State: AFqh2kq6zcp/K3/iBPpCabfBE0S+RrCWB+c6yuXtBf82yrOXwbpWV8jH
        7Fq6ap7D70GqyiRzrNocDfEyYY1FodvTveu2pHPnnw==
X-Google-Smtp-Source: AMrXdXvtGOen7EFVr6iZ7fJdRMfcULlUIs9vwZ8oU7pyQnNvrcgWqcNOHozUsAyk6DqWAe781qN6o5VorO64rhmHAA4=
X-Received: by 2002:a9f:362c:0:b0:5d2:c6ce:7c41 with SMTP id
 r41-20020a9f362c000000b005d2c6ce7c41mr4475795uad.112.1673858469027; Mon, 16
 Jan 2023 00:41:09 -0800 (PST)
MIME-Version: 1.0
References: <20230112163855.73032-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112163855.73032-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 09:40:58 +0100
Message-ID: <CAMRc=MdV2eC8ctHL-eu9u3_Yq+s2H4rkF2vx7W54-2JL-_H52g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: davinci: Remove duplicate assignment of of_gpio_n_cells
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Devarsh Thakkar <devarsht@ti.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 5:38 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The of_gpio_n_cells default is 2 when ->of_xlate() callback is
> not defined. No need to assign it explicitly in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-davinci.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index e1c1b9a527db..26b1f7465e09 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -252,7 +252,6 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>         chips->chip.base = pdata->no_auto_base ? pdata->base : -1;
>
>  #ifdef CONFIG_OF_GPIO
> -       chips->chip.of_gpio_n_cells = 2;
>         chips->chip.parent = dev;
>         chips->chip.request = gpiochip_generic_request;
>         chips->chip.free = gpiochip_generic_free;
> --
> 2.39.0
>

Applied, thanks!

Bart
