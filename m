Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6806C5BB735
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 10:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiIQIYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 04:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIQIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 04:24:08 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEE94DF08;
        Sat, 17 Sep 2022 01:24:06 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id s13so18320722qvq.10;
        Sat, 17 Sep 2022 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qbcnscgbXlnx/VthFKwUQQtGIklihJr0+Aj2GEclzE4=;
        b=N99iXbB0KSwbZ5ywZGr73/OGP3+8+3/7ZYXD8jFOVMZ+xEkWO9++jg25CP80nYNCPS
         KITuUA3c6MnYtcICZpAATL7rnPYOkLgkn/wSz0rlWmJ2ANtPnI5QADPNyKHVEaS66Zdt
         IxFYmKdxR3KLXOZv5zJw93maWYOqLgqpzhwvUvlSmzj+A6avIf5Fw9E6mUkA8NtNCKcN
         B+SH2J2UznuhKibThEb/UoLpQhIkw7//XkalPFF0nw5daKT5WmRgINuIzeEu2YaBguVv
         CaogL/xuHvoVjU8HkEv6pN96+htciLYBkBzQw/7ZNiYX0NJLuQkyxSR4rtCOrZgfAME4
         8axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qbcnscgbXlnx/VthFKwUQQtGIklihJr0+Aj2GEclzE4=;
        b=iXmbKTgn1wmADVYdjiU0ALZ4jpCxqODEW6rsr/0E5Hope9+TLgSocPNsX1brRL5CAf
         nl2QwJ27zZtfTA6uxpR6OkmqZRufLibc22DdkOYuROIsM4y5JRr3foWaTEnENnZJbLBV
         2aqIR9GeGB0+PYXaMNLAVzVLYXUMB91fRIsrCYx/Os0Vi3UjMrSLZOOQv1O5gdcwnC1K
         Fim3KxGO+2pL88jmP3/GccV6GdGmy+kdgdtQV7cjVyvYsRO3t+rsD6iTVStUNwGVJ1Un
         KvX6qKnKXkiNnG0SvMPDQc8UTUSFiSZGz4995zazaIh0uUA1Ci/x/ELPUgsL/UHxmhsg
         sOEg==
X-Gm-Message-State: ACrzQf0S5cpgD7TwADo0uGW2MF8bFth7bh9nwvghIL84Q7iwl8paoWKR
        xWmj/gCOuq4p52ws+ZwL5Np8oTKpcdOZ5zMLsGA=
X-Google-Smtp-Source: AMsMyM57bJfAaZYhl8xi9KuDqcpsLcgwfzyHSLBWcacgwyzEBG4YON5o/1nnCpjOZNF+SNVbabmOf/yYKW1OJwF0iEE=
X-Received: by 2002:a05:6214:19cf:b0:4a9:4241:2399 with SMTP id
 j15-20020a05621419cf00b004a942412399mr6976820qvc.64.1663403045831; Sat, 17
 Sep 2022 01:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220917081339.3354075-1-jjhiblot@traphandler.com> <20220917081339.3354075-2-jjhiblot@traphandler.com>
In-Reply-To: <20220917081339.3354075-2-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 17 Sep 2022 11:23:29 +0300
Message-ID: <CAHp75VfcpM9rVkWTZzytLgEqM5TOrhYHhntAFKa220AJbshxzw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/4] leds: class: simplify the implementation of devm_of_led_get()
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sha@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 11:14 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> Use the devm_add_action_or_reset() helper.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  drivers/leds/led-class.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 6a8ea94834fa..2c0d979d0c8a 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -258,11 +258,9 @@ void led_put(struct led_classdev *led_cdev)
>  }
>  EXPORT_SYMBOL_GPL(led_put);
>
> -static void devm_led_release(struct device *dev, void *res)
> +static void devm_led_release(void *cdev)
>  {
> -       struct led_classdev **p = res;
> -
> -       led_put(*p);
> +       led_put(cdev);
>  }
>
>  /**
> @@ -280,7 +278,7 @@ struct led_classdev *__must_check devm_of_led_get(struct device *dev,
>                                                   int index)
>  {
>         struct led_classdev *led;
> -       struct led_classdev **dr;
> +       int ret;
>
>         if (!dev)
>                 return ERR_PTR(-EINVAL);
> @@ -289,15 +287,9 @@ struct led_classdev *__must_check devm_of_led_get(struct device *dev,
>         if (IS_ERR(led))
>                 return led;
>
> -       dr = devres_alloc(devm_led_release, sizeof(struct led_classdev *),
> -                         GFP_KERNEL);
> -       if (!dr) {
> -               led_put(led);
> -               return ERR_PTR(-ENOMEM);
> -       }
> -
> -       *dr = led;
> -       devres_add(dev, dr);
> +       ret = devm_add_action_or_reset(dev, devm_led_release, led);
> +       if (ret)
> +               return ERR_PTR(ret);
>
>         return led;
>  }
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
