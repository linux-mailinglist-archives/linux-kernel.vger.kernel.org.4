Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50D166B930
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjAPIlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjAPIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:41:40 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E0512868
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:41:40 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id t10so17741289vsr.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BkZkpEi0CeU6MXCQi22nmo+dzisL2Q7pZWWWLTKyIYg=;
        b=eBEEA0xD4P2lbLmziKejqaxuN6tJoRwDnWUNAz0bIFcsWljAjg1+0aefohRqs61WUy
         /vNCeg6FWaGFoMAadIPmheGdbXfZyAIpuWSxAt6Ym60swOR5jx44b1K3SkXkkKKkTleD
         Uv7vhmhlIs3yKW7WDGprto2hi3TshA1f/kZW5ZuTRN4uO2J4vMY/Vj/60Z0CDrSr0h+u
         59EFeZtKHYV+ilbghsGUh+W06gQFc2rNzR72ZFgz+00k3u8e6nJ/1RIVd1m7l4IhzUjx
         ndZREge8/rpemjWPLjpshwsSqZdUTWie665gOA+apeMtveu/P3I3SSlxaADoG7Mj5xzg
         mgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkZkpEi0CeU6MXCQi22nmo+dzisL2Q7pZWWWLTKyIYg=;
        b=BTI8X98RbMOJBjscgS8J/ByXQeX9wyFVhqY0e2Gs9IVe0F2LZ/fU+vl1HOF3qf3mHP
         9zuTHDbxd6Zi5FVDE8RSfpfzzdANbaQPDrHi4eGEGQVhgQiZqFYgjvG/AepYEsXcqNLI
         E0g+eRl9MciIC4jtjkRrs8smQDgQTNbttAfICjLCNRvSkgafSweKhbU6HtXYnloikJq/
         MhxWv1Gje/pWAX1wIts0glviibF1sK+6SD2UMWm1bfCv9B9kM3N0v3MjNC9QiAnkcaqL
         8LOoq1xSuDiiaTQUAd9anHUL3jfut9coFF0YyhBBzvrmXhG8k8yVc+kbTnmL1dcG6lEs
         U8FQ==
X-Gm-Message-State: AFqh2ko02Wo9UtYCg5JPESoKkXtyWgUDj2X5JBlMiyhGMlhn6gk82aXv
        kM7Q/2UQNerY3OnfTsRtBfjTBxiAo3cT94qOcG3dDQ==
X-Google-Smtp-Source: AMrXdXv4+htg/4DjXkRZQM6EjzUN4g2g6apbMF56MNNhQHO9V/oSr3CIs/SscMkppu5gZA0t2qJk1ViUV/EOnB+F54c=
X-Received: by 2002:a67:f899:0:b0:3d3:d90c:5ef2 with SMTP id
 h25-20020a67f899000000b003d3d90c5ef2mr387130vso.17.1673858499397; Mon, 16 Jan
 2023 00:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20230112163905.73065-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112163905.73065-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 09:41:28 +0100
Message-ID: <CAMRc=Mc712-FNaHxHhSffL67DfBvRaOjWECx6bu=GgV_sFsiyw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: ge: Remove duplicate assignment of of_gpio_n_cells
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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
>  drivers/gpio/gpio-ge.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
> index f6a3de99f7db..7bd4c2a4cc11 100644
> --- a/drivers/gpio/gpio-ge.c
> +++ b/drivers/gpio/gpio-ge.c
> @@ -81,7 +81,6 @@ static int __init gef_gpio_probe(struct platform_device *pdev)
>
>         gc->base = -1;
>         gc->ngpio = (u16)(uintptr_t)of_device_get_match_data(&pdev->dev);
> -       gc->of_gpio_n_cells = 2;
>
>         /* This function adds a memory mapped GPIO chip */
>         ret = devm_gpiochip_add_data(&pdev->dev, gc, NULL);
> --
> 2.39.0
>

Applied, thanks!

Bart
