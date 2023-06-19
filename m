Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44A973571D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjFSMoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFSMoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:44:16 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481EC10C8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:43:48 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-78f32e233a0so1033357241.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687178611; x=1689770611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TO0+KaIcX1mDL3lougizkSx+E71ioKejbCq345UZmAY=;
        b=rTRrxKQgUdRHf46Q/zRXVw3ISO83K7NzoIXhhuA58IpCaqjEmoCp2d1TKTSX4WeLzA
         K9iD+abhpbOWCIc7VR/3AQvhTISHcKRYzbMA/daVQwbljmEUbDv0B+XQS5W6Ph+btL1C
         x3nYMkyvonGDzRpHqlyGjODuenVSqz0AAzp25K4f+jl82qpKPZgceHHjldj/1S2tV2Sh
         1BPaTUVrdmAIZ/13k4nfyPqHpcGsUrXldoTZJg2vl7GY8Xml3IWC3yrvkjmhaiPZ9Afh
         km83xtp18IBE8LNnnBdKkfnO6pcmcC8uMjaUtvubuvPc5nWCbcR9qXBFb4BFVB3xyJoy
         fjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687178611; x=1689770611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO0+KaIcX1mDL3lougizkSx+E71ioKejbCq345UZmAY=;
        b=gQZhUfLqzhL/Qaf2eZtb0zw4zL0wZZDD2Nc6tVnLfKybAqXGGd8Lle961mDP4wIQkd
         L0La1xtYIQTS5sm6axw/R1KY8fNCVYCUIiTPer3YMOqO3rVXY22LdMx/lSPWICh1dFy7
         Tl4/bVOtuJQ8D+4xlHIlHvdJ4MxQfVS9SZXzKC+BZWvy2TEC75RwTvJ+iOQQspuGJksT
         dhnCfjc5snjY3bFSIhKV9A1z0MQ082UdBBW5d3wBh5bUBfGImHJvjM7fe3CMqBORkEPW
         qBR7WeyvVPry8EBDOwrck7G3XEJlqXgrrNB52/Y1bw/Z4KNRmzWL1SkhB97G5stbkdTt
         vVNA==
X-Gm-Message-State: AC+VfDw8cTsc6j83Gw56R4PGDrb8vXjW40wHyuug9bmqsNTvZqj4ljfZ
        xQ9qRAGRssJ4uCt2F68K8ueISqXjdEJcV5lSn+7CNg==
X-Google-Smtp-Source: ACHHUZ7HzyXt985XCyJrybc/J8a368/p10qr4hjO7GCPD2aZHB21AFCfJHrIj6ffVRyXGzXQlTUllyy+7+X7hN+n404=
X-Received: by 2002:a67:fbd8:0:b0:440:b25f:5cab with SMTP id
 o24-20020a67fbd8000000b00440b25f5cabmr478257vsr.15.1687178611633; Mon, 19 Jun
 2023 05:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230615162514.21195-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230615162514.21195-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 19 Jun 2023 14:43:20 +0200
Message-ID: <CAMRc=MfPwVLnWquVkj9wZA+NtkONO6KgcNeEAa+Z+WGooHe22w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: mpc8xxx: Remove unused of_gpio.h inclusion
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, Jun 15, 2023 at 6:25=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The of_gpio.h is not and shouldn't be used in the GPIO drivers.
> Remove it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-mpc8xxx.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index 3eb08cd1fdc0..35214e9de4ce 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -12,7 +12,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> --
> 2.40.0.1.gaa8946217a0b
>

Applied, thanks!

Bart
