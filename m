Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D359D6B4B53
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjCJPlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjCJPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:41:23 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354D21EFD8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:28:16 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id x1so3744448uav.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678462094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE8oKgAfKxMJqHJj3SLWLDD7fxQDQxShPcAFSDzkcdg=;
        b=7tFn7dlaCMSGtEmJH0lZ1Q1S6tbzEszDw8nGWbm2vst1EYH/Jq4MIuEaa38hyxfSbw
         xJ5z/5u2Tu0IVeJBbVvWPDhPA1rvHduZttpbw3pnRsx0HVZhV9hHlqIJF7GosxFQfh7Q
         2CXEg7Fb0EAox+o4uKJihWkmVX3Q+hZcNEfzi8Ai6P3w//1Hbym3/zjlYfHt9gE+hyS2
         AS4j8IvyR4JfE3wXbZdxclle0yc4QUjhwAtkdDv5Rm6a7ublziaSXpbKvlSgn9t4duIZ
         an/eI45s0fOqwjqsBkZN83ZPOZGkBHwKixp7I/aOp9qfbktSTVs0NnEP72Jm51S0U7fs
         tO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678462094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cE8oKgAfKxMJqHJj3SLWLDD7fxQDQxShPcAFSDzkcdg=;
        b=AWRC2eNLLmmVisC/yU5eqNjkS4U1daW2z4s8nY9kq9WOvJVAg6JFX+bp+mqYRaLe2c
         +gUxzpNkdYeKU7EFCp+SEUtW2W0+x9HF4QSO80tkV+T3NWclWKaCBC2ZbDMdofGpIHtJ
         u2EijNo6wlDAmDxxyogiO1vgoPOUCDyTEzOWFOq8hJzIti49XuD2ILHFadLfWehs/Nyl
         mAs+tc3wLbOCHmWmMo0OC4gRg64VOvEhqhPfK76Tkomtd/+fn1jjtR7tle06TVmQFHTw
         oeCjdwyRfvAPj0zNEGti/garChA3klDGv+I0UWOEKmNHKQbFg840GrKHnIV/nkrqxpnx
         BebQ==
X-Gm-Message-State: AO0yUKU2l92/q5HZJ9iMWt3Q9hplUJKYXlz300uJ+9wGPDAD5J/bFFAa
        vHkNq2guN+SnXEtuhdCoprCszfFMllS4zO6Ah1Q4HA==
X-Google-Smtp-Source: AK7set+b8GW3CohEypYpFclkJbSoK3j2pazVHxiZ+au+wZOWgS2POhtshvSu4L+2cxG51w3WLyRW04Ci57Hvhrwg+hk=
X-Received: by 2002:a1f:c10d:0:b0:42d:6663:d32 with SMTP id
 r13-20020a1fc10d000000b0042d66630d32mr6197135vkf.1.1678462094113; Fri, 10 Mar
 2023 07:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20230309031755.38561-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230309031755.38561-1-jiapeng.chong@linux.alibaba.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Mar 2023 16:28:03 +0100
Message-ID: <CAMRc=MeKN_RWx6x7nu13Sib80sooT=s7ZuWhg6Cow18cuLwGsA@mail.gmail.com>
Subject: Re: [PATCH] gpio: loongson: Remove unnecessary .owner
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     zhuyinbo@loongson.cn, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 4:18=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Remove .owner field if calls are used which set it automatically.
>
> ./drivers/gpio/gpio-loongson-64bit.c:225:3-8: No need to set .owner here.=
 The core will do it.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4450
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpio/gpio-loongson-64bit.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-loongson-64bit.c b/drivers/gpio/gpio-loong=
son-64bit.c
> index 20a68e5e66c1..06213bbfabdd 100644
> --- a/drivers/gpio/gpio-loongson-64bit.c
> +++ b/drivers/gpio/gpio-loongson-64bit.c
> @@ -222,7 +222,6 @@ MODULE_DEVICE_TABLE(acpi, loongson_gpio_acpi_match);
>  static struct platform_driver loongson_gpio_driver =3D {
>         .driver =3D {
>                 .name =3D "loongson-gpio",
> -               .owner =3D THIS_MODULE,
>                 .of_match_table =3D loongson_gpio_of_match,
>                 .acpi_match_table =3D loongson_gpio_acpi_match,
>         },
> --
> 2.20.1.7.g153144c
>

Applied, thanks!

Bart
