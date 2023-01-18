Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B93C671F91
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjARO2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjARO2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:28:23 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4424F71F14
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:14:32 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id v127so31446983vsb.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yplg9S1JhovxIGfaL6Q6VaDnzZMitHU7C7LFyjrBCuM=;
        b=mGOjDpy3dF95PKoyeVvrLC5FeH+PXh22DunupbTN82XxucIOoB9IfnAGgZWsA0bugk
         ghgVxgGaqxmR1Suz1X/FfKWLNnkW3ZVoxc9K0HMrtBSkHdXD8DVM7N1sJaasijyFGpnR
         L/1aqNTzRZrH3sdOcPKK1ofJQarqe9W68GcIg7QcyjwAzPuDPqSirGWp7t9mK1jTsa0i
         WSgvuq7Y96gAC3j8N+B+YTGhhCGZDenxGIp5XgUgDA6CxWmjlDdcPunypgl1EpnbTA1F
         yuNk7YZRFtrL0oFiPy1YRkh6kQwTk/WoF30VksoF4gQ7irgW1QWeXKd5LsQO9ulEYE34
         1QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yplg9S1JhovxIGfaL6Q6VaDnzZMitHU7C7LFyjrBCuM=;
        b=gZ5Lus+TeNLPqGZZqHAhsBt4DeS50isxaqmcZqd6+VNtM/+ZgnekXD0Mq/ZAz0dm/c
         gBL/pZhV3Ew0FPaQU1eaU5QLff7Y1bXQPhFVWD+G8j5WAjT23es0yxMe8i+XrQI8jEbK
         gxrqGAqxR/261YgBCLdiuG1BXOjJAk8EFR9hf8VhWnb/8Hmt3c4nmArkI74Ocupx6ad6
         YufW6iAGHVS10Tf/2Vpc4R2iV586H5/YKHsYyjwcGf3zowo+g/U9tQSoT0sHZ0cclA04
         bz/IcWwcCzCvLsuTJhLr/U5A3MpDoT93bB6gOJprv+KSoQNUSlFpi9t8u++KxmwQO41C
         l5Qw==
X-Gm-Message-State: AFqh2krQLvDLatKQ8qbnZ8jzSyLFCjYifRdulXV3OSkbTYVvqvE0a/AV
        4LekXS+HptiRyOT871LOtg63CrrLZCPYKCjS1UWN3A==
X-Google-Smtp-Source: AMrXdXsOVriRa6oQhyPR0ZpbJLJH4CUKQQvaM0V7d5YeQLv6Q29OqDl6sUg6xmxGgO5mtPbL0SJUElCeOqG5CnHMkcw=
X-Received: by 2002:a05:6102:3e08:b0:3c5:1ac1:bf38 with SMTP id
 j8-20020a0561023e0800b003c51ac1bf38mr1062676vsv.78.1674051271374; Wed, 18 Jan
 2023 06:14:31 -0800 (PST)
MIME-Version: 1.0
References: <08de3f4b-e33f-95c8-3297-814ea107272a@gmail.com> <1510c02c-f640-9924-e42e-fa34e28a580f@gmail.com>
In-Reply-To: <1510c02c-f640-9924-e42e-fa34e28a580f@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 18 Jan 2023 15:14:20 +0100
Message-ID: <CAMRc=Me2yj6A5ZvLXbWn8H0yuL5pUqOJ7B7kGaOyN=jLXGJEGQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] gpio: gpio-rockchip: add compatible string per SoC
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 1:14 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Currently all Rockchip gpio nodes have the same compatible.
> Replace all the compatibles in gpio nodes to be able to
> give them a consistent ID independent from probe order or alias.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>
> For now only add new compatibles.
> No changes to rockchip_gpio_probe() function yet.
> ---
>  drivers/gpio/gpio-rockchip.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index e5de15a2a..493207de1 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -790,7 +790,22 @@ static int rockchip_gpio_remove(struct platform_device *pdev)
>
>  static const struct of_device_id rockchip_gpio_match[] = {
>         { .compatible = "rockchip,gpio-bank", },
> +       { .compatible = "rockchip,px30-gpio-bank", },
> +       { .compatible = "rockchip,rk3036-gpio-bank", },
> +       { .compatible = "rockchip,rk3066a-gpio-bank", },
> +       { .compatible = "rockchip,rk3128-gpio-bank", },
> +       { .compatible = "rockchip,rk3188-gpio-bank", },
>         { .compatible = "rockchip,rk3188-gpio-bank0" },
> +       { .compatible = "rockchip,rk3228-gpio-bank", },
> +       { .compatible = "rockchip,rk3288-gpio-bank", },
> +       { .compatible = "rockchip,rk3328-gpio-bank", },
> +       { .compatible = "rockchip,rk3308-gpio-bank", },
> +       { .compatible = "rockchip,rk3368-gpio-bank", },
> +       { .compatible = "rockchip,rk3399-gpio-bank", },
> +       { .compatible = "rockchip,rk3568-gpio-bank", },
> +       { .compatible = "rockchip,rk3588-gpio-bank", },
> +       { .compatible = "rockchip,rv1108-gpio-bank", },
> +       { .compatible = "rockchip,rv1126-gpio-bank", },
>         { },
>  };
>
> --
> 2.20.1
>

If they don't have any additional data associated with each compatible
- why not just use "rockchip,gpio-bank" as the fallback in DT?

Bart
