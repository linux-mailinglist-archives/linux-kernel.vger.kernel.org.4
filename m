Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D379735720
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjFSMpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjFSMot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:44:49 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A07410E3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:44:27 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-4409a40965aso426621137.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687178665; x=1689770665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7CKBeX87YWHS9TvTpuZmP0rgiJkHHO7gYE8rYW2waw=;
        b=LpZI7AJLhjMRHWLyGrjvb6783louHBna0u3GvsrdlRHQT6ch0ZMlFHwYrj/Vmvqbl5
         +whNFsYRb2bkr1F9pY9CJprCxiHi8U7g19O15iCXHt7IlKl/gB4XqBck+kPOGFwZRgrZ
         K18XvyXfSJ1zvma4KxwmEp2MQAf2WtcZcR4eZXTaB1cybAfTQiitvODJaQbe8+PrxKkk
         o5Le82RBEKgAzAPQB1/X1fXqkPB4y01lGFYfUlLGuVNmgdEZtKwppQnJ9fyVELe8yGjk
         9TsflDEDXf34Q2O52hoFaCmWwsqSr+yWUhlpB5P+yGL9w2wJNd2Dxo4g+WK6SJ030SHH
         6IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687178665; x=1689770665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7CKBeX87YWHS9TvTpuZmP0rgiJkHHO7gYE8rYW2waw=;
        b=aPU8awLOLJqB193bCFMuz9FbrJd5mC/f7lEWSyWxQd78n9gGah5Zgxg3lcx+V51cE5
         YoJG1vk6yTj+1cjgg4zA/Rvcxjm3FcUJyUM/FWlIA2zATtg4bQCiwuzKF9OaEUdoRZiG
         Un3W06552jXxsAHH2MXh2hk2nj1F+CeO3ERlVxaBweKAWv1F9wn6aVyG5BSubsXx5ZK4
         nzM6nZqWXAhPQ9PQs2jOrVe1mups7bQSzVONs8wmB4JkpHTB+W3X56UPFG3enneE/pT7
         LKiZoXWxOnPevdMFq8rYn63iE+AK9lqUC08xUbdT1Nsl2lMtV+CK4t8jp9mAWXsexmsq
         MbvA==
X-Gm-Message-State: AC+VfDxsFFWC2u39YNX+lJbFrAATVrQPMJ03SgCP/vKx7rWiIOLBv/KY
        0zGgKJXKUIqV/P1EgGtrwDNcHDMn0Jsx14RA5ZOe6g==
X-Google-Smtp-Source: ACHHUZ6JLEcVfllJN+8HU3wxqopA6udVFcyfWqpvoHDy/5/SREzTJHQroaNRAnsOiiFMXjJqUO3BpfsYsXjAIL8MSDE=
X-Received: by 2002:a67:f615:0:b0:43f:5eb2:8e9b with SMTP id
 k21-20020a67f615000000b0043f5eb28e9bmr1100501vso.27.1687178665371; Mon, 19
 Jun 2023 05:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230615162612.21487-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230615162612.21487-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 19 Jun 2023 14:44:14 +0200
Message-ID: <CAMRc=MeYmriM=2QibvAo92pgyxb15CCBbMZKFKdQwHSsu0Y4jw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: xra1403: Remove unused of_gpio.h inclusion
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nandor Han <nandor.han@ge.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 6:26=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The of_gpio.h is not and shouldn't be used in the GPIO drivers.
> Remove it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-xra1403.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-xra1403.c b/drivers/gpio/gpio-xra1403.c
> index 51d6119e1bb4..bbc06cdd9634 100644
> --- a/drivers/gpio/gpio-xra1403.c
> +++ b/drivers/gpio/gpio-xra1403.c
> @@ -11,7 +11,6 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
>  #include <linux/seq_file.h>
>  #include <linux/spi/spi.h>
>  #include <linux/regmap.h>
> --
> 2.40.0.1.gaa8946217a0b
>

Applied, thanks!

Bart
