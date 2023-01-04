Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D653965CECA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbjADIwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbjADIwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:52:00 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2FBB9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:51:59 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id d14so5942301uak.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 00:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pUKsoV4Lm/CWZW8qi8AxjB5QcnN+u3WoDRCFgIJvRGg=;
        b=JrJ2p1o+y2QfQPv83Y9jQ8FhwJ10JLWuRCN/A7ttuek/HpHP2BSQD+0V5GOF3LVtrj
         djP3n+tApFeAMDb3VYf+kkVJzaDcjuepyt/RTMIwuR2ZIvjc4U6VpcQFgyELWJOou80M
         5H/6c1uCx+PAupXq2aAdYs0l5jPhtiATPTdU1iPdeMVtevVajievN9dTqzyQaiEymuXT
         6wHdrURo8P7+QJTGkujGpG7QLvM65M1CEh1FP/FxqlqEljr0hlHI1R2l6mEg/jFBfrlO
         yVDHiQts5WRyp2mW9qFB/3Nf3iqGQSm/Yz4wKMNzjHOnUlGO2ZIPnH+N5OkA5AOt0icC
         7oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUKsoV4Lm/CWZW8qi8AxjB5QcnN+u3WoDRCFgIJvRGg=;
        b=pxNJ6ES2ff6X0EY+A3+5BGqS4v5Z0YE6bKiUT59HnxsgKwel9xhomcjo7GzukCnjiT
         LZmS5LHn5qJDftWTrlgzblSCEHHp+Tav5CwkEw+uxKfU8bVHK3Cch47u7gx861UVP8Tq
         9HwjWEjPAjDIdQBiyhrlHWcKJqtXiA7V3tQFN7ZgFpBMp4vRgtxzKlzWOI9ODoGh4wGY
         cwQyd6g+pP46/dFy/ZL2q5Q6dCc17nyVrkLktGqkDzPgo0+e5FVnU0ju9D1xZNujGDvp
         viqFoJDgoC3fU1wiotcmJgjWKCDsymLQ5/wyv9XULYu5jwHHd2aylhhryxphbP5KiGip
         BXOA==
X-Gm-Message-State: AFqh2kp2fKezBdGKis0+C46sMz7NXAknZAPrz8yBjHk/JLsqsWTZFWUs
        6g/zog6S5wVjktOwM7fXi/fDzK2sauTNakqUNycyQg==
X-Google-Smtp-Source: AMrXdXvywqTwg5gwiAgwD6OwzN41CwmUiVACqEFuvW80D3qdhKKKjymm4mzEWpsTC5AxtOAlbJ8TPh/TQwzCCdZL+tg=
X-Received: by 2002:ab0:5a49:0:b0:424:e8b8:7bcb with SMTP id
 m9-20020ab05a49000000b00424e8b87bcbmr4312189uad.123.1672822318273; Wed, 04
 Jan 2023 00:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 4 Jan 2023 09:51:47 +0100
Message-ID: <CAMRc=Mdvc=VC=9pVaB8spj6ErS1rRM37qyDZ_03P1R-sQ0soCw@mail.gmail.com>
Subject: Re: [rft, PATCH v4 0/3] gpiolib: eventual of_node retirement
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 10:20 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Now that all GPIO library users are converted to use fwnode,
> Drop redundant field from struct gpio_chip and accompanying
> code.
>
> Bart, I prefer this series to go as soon as possible if you
> have no objection. Or even as v6.2 material.
>
> Thierry, can you please test it once again, so we will be sure
> there is no breakage for OF platforms?
>
> Cc: Thierry Reding <treding@nvidia.com>
>
> v4: added couple of additional patches to the bundle that missed
>     the merge window by one or another reason
>
> v3: rebased against latest Linux Next: expected not to fail now
>     (Also keeping in mind Thierry's report, so reworked a bit)
>
> v2: resent against latest Linux Next: expected not to fail now
>     (Linux Next has no more users of of_node member of gpio_chip)
>
> v1: to test for now (using CIs and build bots) what is left unconverted
>     (Expected to fail in some configurations!)
>
> Andy Shevchenko (3):
>   gpiolib: Introduce gpio_device_get() and gpio_device_put()
>   gpiolib: Get rid of not used of_node member
>   gpiolib: sort header inclusion alphabetically
>
>  drivers/gpio/gpiolib-acpi.c | 10 -------
>  drivers/gpio/gpiolib-acpi.h |  4 ---
>  drivers/gpio/gpiolib-cdev.c | 21 ++++++-------
>  drivers/gpio/gpiolib-of.c   | 25 ++++------------
>  drivers/gpio/gpiolib-of.h   |  5 ----
>  drivers/gpio/gpiolib.c      | 60 +++++++++++++++++--------------------
>  drivers/gpio/gpiolib.h      | 10 +++++++
>  include/linux/gpio/driver.h |  7 -----
>  8 files changed, 51 insertions(+), 91 deletions(-)
>
>
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> --
> 2.35.1
>

I applied the series, let's give it some time in next and see that
nothing breaks.

Bart
