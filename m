Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB50166B96B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjAPIyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjAPIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:54:33 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE59A5F2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:54:32 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 12so2046847vkj.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8AoNhE9nlR/QGp4z87SryZWRWBB4ufblvx66JVKBkQg=;
        b=WpORYWNejzln9pw3GjGAWoD9UJKVYIO1dL95+WnV0IArOLSWW1Lv9QroS957BJwWCB
         9ZPvLC2pUXLT31xp2iNJYfQ/jVYoW/6jubp5g6DwSEVrtnL0N05K4zrBOYAba/lf+npp
         xAeK08JWiaF1b8EkZhNW/LIVpDwcyJxhQkt1TU5vH9NziFk18KnppaUeo3AkXkDMQXP1
         I607/1jMgT0I+7zPravRCsOJ6KOlJ7GFEBvUznp5GRYPArS38zXLHmZR56e/T185eXoQ
         GzVQ8q+kGkxqKw4u9g8hDVb4fPVKttiXIRYVlZn6UwM5pj1+jsQbzvwwkxcHLw62w6dF
         aVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AoNhE9nlR/QGp4z87SryZWRWBB4ufblvx66JVKBkQg=;
        b=jaaVt/W+kJmulk/5zL3atl5EN9ZfydKUlkMNRb0xqBTX1yn1o60P8v//YUDlJe6mRd
         MGeJrNByit/ou+8xeeorsvt8x0r58I6RCVWSG7eQna8+PXqAB+9JOx3WaTWfgQNnV6Pf
         E5MCvmdTF+cAuQoCDw2JgjULc30yFwQ5ql0yQ8xF5jEOfltrpYogK1ZpNv8MDAHp+lNr
         aLWhTplTdEB1JJB0nhL0c/799twQ36ufTnMEJs5wuSzUAEUn17B/ZA/r0+UBRbsv1W2z
         ws7g/mMIRxzpMQKDKg7xOIw18dsuRPwOHif/h6r7az4w3J5/KZ5FBJulqTgRAiem3cFc
         6RRw==
X-Gm-Message-State: AFqh2ko1e9tzPaSHYUj7qMEsIiE69yBOSfe8eVeWnuKvsoWEVe+iOPjx
        1J/69uqfCs20mSDxnurdlXiS/vzTvV3OWbmxXEUlqQ==
X-Google-Smtp-Source: AMrXdXsg/hyJNGENEoEO7DJDfE66mlBgOB9nb1h59SVSiEt1dmlwhZcn6g6wCHM06JL/qKuDITRh/U2Z1Ai7/KFnh7c=
X-Received: by 2002:a1f:4cc4:0:b0:3dd:f5ea:63a2 with SMTP id
 z187-20020a1f4cc4000000b003ddf5ea63a2mr1001270vka.10.1673859271898; Mon, 16
 Jan 2023 00:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20230112163951.73180-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112163951.73180-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 09:54:21 +0100
Message-ID: <CAMRc=Mc+zSfM=eiWScuhDr9kasmhyCMHDxavoMbPd6TmGAuWdw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: xilinx: Remove duplicate assignment of of_gpio_n_cells
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
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

On Thu, Jan 12, 2023 at 5:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The of_gpio_n_cells default is 2 when ->of_xlate() callback is
> not defined. No need to assign it explicitly in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-xilinx.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index 619a00ad71d4..bbcde91135b9 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -558,7 +558,6 @@ static int xgpio_probe(struct platform_device *pdev)
>         int status = 0;
>         struct device_node *np = pdev->dev.of_node;
>         u32 is_dual = 0;
> -       u32 cells = 2;
>         u32 width[2];
>         u32 state[2];
>         u32 dir[2];
> @@ -591,15 +590,6 @@ static int xgpio_probe(struct platform_device *pdev)
>
>         bitmap_from_arr32(chip->dir, dir, 64);
>
> -       /* Update cells with gpio-cells value */
> -       if (of_property_read_u32(np, "#gpio-cells", &cells))
> -               dev_dbg(&pdev->dev, "Missing gpio-cells property\n");
> -
> -       if (cells != 2) {
> -               dev_err(&pdev->dev, "#gpio-cells mismatch\n");
> -               return -EINVAL;
> -       }
> -
>         /*
>          * Check device node and parent device node for device width
>          * and assume default width of 32
> @@ -630,7 +620,6 @@ static int xgpio_probe(struct platform_device *pdev)
>         chip->gc.parent = &pdev->dev;
>         chip->gc.direction_input = xgpio_dir_in;
>         chip->gc.direction_output = xgpio_dir_out;
> -       chip->gc.of_gpio_n_cells = cells;
>         chip->gc.get = xgpio_get;
>         chip->gc.set = xgpio_set;
>         chip->gc.request = xgpio_request;
> --
> 2.39.0
>

Applied, thanks!

Bart
