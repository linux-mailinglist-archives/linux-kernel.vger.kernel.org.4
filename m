Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAF5735725
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjFSMqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjFSMqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:46:08 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCF0D7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:46:07 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4715cbe0422so701725e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687178766; x=1689770766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeXj0XRmxJkhMzDEa0RW0GnXbzKNrynleouz0bB/HXs=;
        b=kB7uzqcL3a4UrpAckq6QwAXK4QA1lOuxNUwc3EC7e0At4W47ImySk1/5ghPXKGKQeu
         AT8WVDITFsOQAYMKTCBpaCtcfhp/vBvwlOlY0lWq4I6ZJIgUAsk4i+m0VawO5z+iMXyi
         M4cLdkjPRtpVNJJRDfuQfenoaDvyslLyvPwIOhR2EN1r6z5ZuAKYm7mucuuSmEA9Wfgw
         vQQrfIjtc9JUcu+Ax0uuWWrRSbtt9yvdwcAWhdYGdhlUUEDkHx28FD5FEoLeL1mBaY87
         OLkS+Xayb2ISPQtDoGsQDNWdmd0uwJMnW8btRtQJJLmDLyqwa0pALrOwBZRXJEgVjCrB
         5SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687178766; x=1689770766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeXj0XRmxJkhMzDEa0RW0GnXbzKNrynleouz0bB/HXs=;
        b=j+m5JgYosUS4EMm3s+iDRF05N3b8HUS0ctlSbNCybvedbOsHzehIoHZjwUtB4qs6MY
         /Dku1GukNMw156htqGw2UGrPwp9ykjvkHdPunBY0QtsltTV4HTupK+Mo/MPaboaKkOmO
         AhGE26FSF4eKPytzdYipe9bewzJVgC9/jOLUv1SqudOMbl+8P3HCKTieB9jaI3FTj58d
         sa7LpFCzwdKZuuTPd56mE2BqNi87tC1DYp46/4y5Oi8cGwI2Ecya/ZImmKh8sVRXl54M
         B74xPrAN7UffROoKJezTpmVSZ746KWnq4l4pb4OsUudwqMLEYR/DQSJnIhegW7Zte26j
         YHKg==
X-Gm-Message-State: AC+VfDxRVzncJnvN8pyxnmE1i+8kKvsEe63i/hyAzAwZpEN2aX5rcjYw
        KhMSWgIpc/5b2SUzDRV9QpDHPmwXFkQmkxBuxe9CAw==
X-Google-Smtp-Source: ACHHUZ7GeLaP59fWXOaUs5eMlNC61ZGJ3dYv6uJ/4i6HbzzZwVqhg6xWaRnZAwvnpEslgLGiCeVGGqZzppCiK8xjXcM=
X-Received: by 2002:a1f:d643:0:b0:46e:9f33:adcf with SMTP id
 n64-20020a1fd643000000b0046e9f33adcfmr591169vkg.11.1687178766631; Mon, 19 Jun
 2023 05:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230615162519.21244-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230615162519.21244-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 19 Jun 2023 14:45:55 +0200
Message-ID: <CAMRc=Me_PtAO9EERaThvQy=8=4nHYBNbth5h5WH0Hz5=GFbF0w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: lpc18xx: Remove unused of_gpio.h inclusion
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 6:25=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The of_gpio.h is not and shouldn't be used in the GPIO drivers.
> Remove it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-lpc18xx.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
> index d711ae06747e..ed3f653a1dfc 100644
> --- a/drivers/gpio/gpio-lpc18xx.c
> +++ b/drivers/gpio/gpio-lpc18xx.c
> @@ -14,7 +14,6 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_irq.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> --
> 2.40.0.1.gaa8946217a0b
>

Applied, thanks!

Bart
