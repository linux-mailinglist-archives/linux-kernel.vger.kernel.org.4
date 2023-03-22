Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE696C512C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCVQsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCVQss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:48:48 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9B57D39
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:48:42 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id m5so13073714uae.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679503721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w0LAtw9cPfSNM4qX5A/16NLh+XxymxwSqd/uu1gfQU=;
        b=RyjBxDPR9Gaa2RWhPtZwOgt/F7XlwPMCS9VUiT2DPq+iirNmsZnpWZUIFrFJo7YSid
         OTI4uancfUSnhPkwaehBVH+XRm32vttS69BLXU/wY/gWONf+Wxr1HdQoJmRmBLepuIMG
         c3B9YgQTrYX9KGhqMlwANDi8yY5dJVd4cf6zFbtg91qD8/0tTA87NAAbaXBQOjwHeFaS
         i1ZlwAWQ40NjAlIDGmBcKdym3nD79WlUE8ZRSvfu6N7l1numhTv/q8SxQow1kmRetpm1
         pkk4gx35heDUY/1HkanuMYR3dqdBfSzdIiWVBJvVNDrJ3fApnCjTNSqxxefzkZZQlrlE
         z1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2w0LAtw9cPfSNM4qX5A/16NLh+XxymxwSqd/uu1gfQU=;
        b=xLXjytaQlF/AeuXYvEWTH8dzEpP4zROKkzLAvkCBYGlvnx5UJgmJokUGbjfy16xrVI
         Z6GauacMAXBpue2ScErbZWnvF4r/F1Sepq5BhL3KBkO2ON568Dan/bxzf1oCYHGdxREx
         hvbm1SdN9ktpLnpli9/n3nD1PvykXnKnoBZLH+iwFMP14Q4EI7vWyxMsJVuG1Qq/lft3
         +4bSrqTDA1vI4q6pp6dc9PISF4IwDepAA3IUmLDxzwsGeBUTufYhlS1Mm90gDIw7f3gz
         Z7ujkt79Hx95w0vZd9yvfg/Acevpe2YDgG/ORx+Nv98B5AOCZoRHJ8dhayD1eQ9wfCjg
         RYDA==
X-Gm-Message-State: AAQBX9fICOMk9HY3eXpc6TYqcUe1tbFATEpgJy7MaEqmWbIS6q3NaMLa
        NQC0oioldyXSASq/hz6Z/4dL4mTWO0QHYxLub7nMVA==
X-Google-Smtp-Source: AKy350ZLZo/F6L7OujzYN41ze3NYo682Vo6dkHIwnotz4DMq72LZxaPffaxLlojXIZ4FO8//leYaf4FE/3yOtteccKU=
X-Received: by 2002:a05:6130:290:b0:688:d612:2024 with SMTP id
 q16-20020a056130029000b00688d6122024mr3518649uac.2.1679503721140; Wed, 22 Mar
 2023 09:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230315110650.142577-1-keguang.zhang@gmail.com> <20230315110650.142577-4-keguang.zhang@gmail.com>
In-Reply-To: <20230315110650.142577-4-keguang.zhang@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 22 Mar 2023 17:48:30 +0100
Message-ID: <CAMRc=MezbVO93WYw2PPV-0qTFid5BE01dfPptNWS4Kc9AXL+fA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] gpio: loongson1: Add DT support
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 12:07=E2=80=AFPM Keguang Zhang <keguang.zhang@gmail=
.com> wrote:
>
> This patch adds DT support for Loongson-1 GPIO driver.
>
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V2 -> V3: None
> V1 -> V2: Let gpiolib parse ngpios property
>           Remove unnecessary alias id parsing
>           Remove superfluous initialization done by bgpio_init()
>           Add MODULE_DEVICE_TABLE()
>           Other minor fixes
> ---
>  drivers/gpio/gpio-loongson1.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.=
c
> index dddfc71f0e10..6ca3b969db4d 100644
> --- a/drivers/gpio/gpio-loongson1.c
> +++ b/drivers/gpio/gpio-loongson1.c
> @@ -68,25 +68,38 @@ static int ls1x_gpio_probe(struct platform_device *pd=
ev)
>         ls1x_gc->gc.owner =3D THIS_MODULE;
>         ls1x_gc->gc.request =3D ls1x_gpio_request;
>         ls1x_gc->gc.free =3D ls1x_gpio_free;
> -       ls1x_gc->gc.base =3D pdev->id * 32;
> +       /*
> +        * Clear ngpio to let gpiolib get the correct number
> +        * by reading ngpios property
> +        */
> +       ls1x_gc->gc.ngpio =3D 0;
>
>         ret =3D devm_gpiochip_add_data(dev, &ls1x_gc->gc, ls1x_gc);
>         if (ret)
>                 goto err;
>
>         platform_set_drvdata(pdev, ls1x_gc);
> -       dev_info(dev, "Loongson1 GPIO driver registered\n");
> +
> +       dev_info(dev, "GPIO controller registered with %d pins\n",
> +                ls1x_gc->gc.ngpio);
>
>         return 0;
>  err:
> -       dev_err(dev, "failed to register GPIO device\n");
> +       dev_err(dev, "failed to register GPIO controller\n");
>         return ret;
>  }
>
> +static const struct of_device_id ls1x_gpio_dt_ids[] =3D {
> +       { .compatible =3D "loongson,ls1x-gpio" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ls1x_gpio_dt_ids);
> +
>  static struct platform_driver ls1x_gpio_driver =3D {
>         .probe  =3D ls1x_gpio_probe,
>         .driver =3D {
>                 .name   =3D "ls1x-gpio",
> +               .of_match_table =3D ls1x_gpio_dt_ids,
>         },
>  };
>
> --
> 2.34.1
>

I applied this and the last one but switched patches 3 and 4 as it's
customary to have bindings in the tree before DT support.

Bart
