Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950A15B8CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiINQVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiINQVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:21:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D97E29C95;
        Wed, 14 Sep 2022 09:21:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso14923895pjd.4;
        Wed, 14 Sep 2022 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=shM0eqNoMydvRAfh5X2W/4dKK3wTBlBQ4aC9T4BQqfg=;
        b=kcubW4pb2r1dEEI6wGBXa/T3e5Y3jn3NUoMTWrXy5lOGSJ7aG7+Fog+9DXpTCTssDj
         fa/CAceoKm7llY8WVmV4FfEsuni/8b6xbyHHthtVtUZxDH5xMtMohcd6bdkEcYw3uBRA
         cmWP776uBIEUm2vUWc1zfjm6lcukFaNsYXAfB3jv7T81oA/OaD8IQsTdi13zf0kWjdtC
         /lvzIUXShE3F77HI58tO7+fyOBswkgEtS4dt9/p9T+dVpsAzsNxP5+gCkbWmwNay45Cn
         vt24bXsq+Ht1XEUFrhlBu6CiVUERDJZelaXOlJKHXcSZynySClB/FXRkdDIj07Tg1ADe
         Mizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=shM0eqNoMydvRAfh5X2W/4dKK3wTBlBQ4aC9T4BQqfg=;
        b=C0Bvm6b8Ljr5E5Q6yhoHwPLNujBgsHRTrmlkyJXbVE2JLjzxDW+bU4r4ckq9vHclbG
         3wTgMjDoehDtDC3kGg4djMVMtPRuudBwcOgfs6JuHzqiSSJQvLiJinEl+qQo8gtw2O7q
         hCy+lIJY8+tyZwYIGkt7GFxKNh5ewl6xNA+pK698nIJyxQxC5CwTdH0E49Z3WwfK9QHZ
         Bu2eTBC6tgliUTgneX5qE/tY4pmnFxiKwN1sE3FFRZPPk6ccV6kOj8kUvTEUrDNcwx8p
         dyMNTcUAL/10sUwafMw2neqfnGElKAnQMeHcoltDAS2S3Gkj18cPzlv29hj69jGdlevH
         BjAA==
X-Gm-Message-State: ACgBeo3h6DAZxAm+launElJs0ubZNm10MpSpN/rELOSb8RshvmGyb+GI
        VWPpAyEbJRfGpglATwM4fyU=
X-Google-Smtp-Source: AA6agR7uXLwWob9Fp5eAutVNUkTRWtusCfxZ6KXsndnXXc6s1vO+w3cPOE5XRwqeru5FHomSutm/ug==
X-Received: by 2002:a17:902:f644:b0:172:b074:d1f5 with SMTP id m4-20020a170902f64400b00172b074d1f5mr37227188plg.29.1663172490861;
        Wed, 14 Sep 2022 09:21:30 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id nh12-20020a17090b364c00b002006428f01esm9392891pjb.55.2022.09.14.09.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:21:30 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:21:24 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: TODO: add an item about GPIO safe-state
Message-ID: <YyH/hJMyPZSqyvQj@sol>
References: <20220914151145.73253-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914151145.73253-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 05:11:45PM +0200, Bartosz Golaszewski wrote:
> This adds a new TODO item for gpiolib and can also be used to start
> a discussion about the need for it and implementation details.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/TODO | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
> index f87ff3fa8a53..6ab39c5cec9d 100644
> --- a/drivers/gpio/TODO
> +++ b/drivers/gpio/TODO
> @@ -197,3 +197,25 @@ A small number of drivers have been converted (pl061, tegra186, msm,
>  amd, apple), and can be used as examples of how to proceed with this
>  conversion. Note that drivers using the generic irqchip framework
>  cannot be converted yet, but watch this space!
> +
> +Safe-state of GPIOs
> +
> +During 2022 Linux Plumbers Conference's GPIO & pinctrl BOF it's been discussed
> +that we don't have any middle ground between hogging GPIO lines and letting the
> +user (either in-kernel or user-space) control them. Either the lines are forever
> +reserved as hogs or their state is undefined unless requested.
> +
> +Currently the behavior of GPIOs that were not requested or were released is
> +largely driver dependent (the provider driver decides whether the line's state
> +is reverted to some predefined value or left as-is). This can be problematic
> +as the output state of a line can damage physical hardware.
> +
> +This item is about proposing a solution, most likely in the form of a new device
> +property called "safe-state" that would define the safe states of specific lines
> +(e.g. output-high) but not block the line from being requested by users who 
> +could then modify that default state. Once released the GPIO core would then
> +put the line back into the "safe-state".
> +

Geert suggests idle-state, rather than safe-state, but you call it
the "default state" here as well - pick one.

So this idle-state would be another attribute on a line that the user
could configure via the GPIO uAPI, and so replicate the "set and forget"
sysfs behavior that we are currently missing, and which seems to be the
biggest sticking point for a transition away from sysfs?

For backward compatibility the default idle-state, i.e. the value the
idle-state would take if not explicitly set, would map to existing
behaviour, so let the driver decide?

What happens when gpiolib frees the line?  Isn't the driver still able
to do what it likes to the line at that point, no matter what GPIO core
has set it to previously? e.g. gpio_sim_free() restores the line to its
own internal pull value.
 
Cheers,
Kent.

