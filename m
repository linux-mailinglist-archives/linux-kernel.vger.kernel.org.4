Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B24E5B4701
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIJOvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIJOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:51:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BBB3B940;
        Sat, 10 Sep 2022 07:51:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id jm11so4399783plb.13;
        Sat, 10 Sep 2022 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ANbC7V7linGqjBKUDmHk4DP21iYZKUWj1fW/jDsV194=;
        b=GyEQyfDONQXkBgxZeO9i2cNwRXXzzf/liAXdroQ1bUc3OUjv6vO4bEftxILt1KOqVa
         orbztvQYu96HPi/ygIKcYJRf3jBvi2qzKW80KI1BcX55pC9IgkJNGNmmlKEe5lj9Q9zH
         eKHsO55GkIyGF/HjekeGp1Il+q0D55yoOtIu33gKbIaOcmiyrmi2LOo7/ZsYq/mNCURn
         jnJFuf3u9K/ojfRBJwc5UYWQ+pE/HrJvpk/RcQJLys+HSPmVi+lJaQF1JlV62vbx0dx3
         O/jzfkmKDyGJ3cZR0cGBwRO/31w46i0zT6PCcykYIFpgjceGLroliiHR/w3vBp0Yk0Ov
         YafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ANbC7V7linGqjBKUDmHk4DP21iYZKUWj1fW/jDsV194=;
        b=3QcMS9VeL0wTFGpVAPJ9mUSPzhbd4ZG9IuCzdKmh/aFXBlmEmH30ln6+EZO+CO6nuz
         pqPyHk8QWH9E2wyRwaC5PWPrrBATpKBZgD+fv/nCmY5DxKP0/6wGqpEnzEUF0iCpYi/6
         gwUo+9+xgLQtFfRVX601V5cE3eyzfpQqV3d5RNT+Fj7H5QK4Wqcb5rg3lfnIzi0tZM45
         mBe7TBUYLrMhelR0/43EJsc1KJ8a8MTbG9vYiuZvj2eEyfcF0wX8Sl+5h7PkcMwGRo8k
         4aVntSZOWilPxBeuHO0L2ISijl8/6pkywn3gcN8GligkPsegyPbZBcCVSA4DlzQjP62J
         vAmQ==
X-Gm-Message-State: ACgBeo3bgqLAKQYRzDTYJZNmXjo25bmt6sJEvOyhb3eGaxokScRfX14S
        HPZNJacbyryPhAIFy00V0kM=
X-Google-Smtp-Source: AA6agR5Lw7Nr+uzFQju8e3I7ebHlRgyOAgAv1TRSIXX54GKKbgvZjzxlMb4g4WshZtYl1XsjVQEt9Q==
X-Received: by 2002:a17:903:1109:b0:170:a092:c881 with SMTP id n9-20020a170903110900b00170a092c881mr18337221plh.68.1662821470005;
        Sat, 10 Sep 2022 07:51:10 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b00176b63535adsm2355255plc.260.2022.09.10.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 07:51:09 -0700 (PDT)
Date:   Sat, 10 Sep 2022 22:51:03 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpiolib: un-inline gpiod_request_user()
Message-ID: <YxykV6GiYH79gg+X@sol>
References: <20220909121329.42004-1-brgl@bgdev.pl>
 <20220909121329.42004-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909121329.42004-2-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:13:28PM +0200, Bartosz Golaszewski wrote:
> Pull this bit of code into gpiolib.c as we're soon be calling certain
> symbols static in this compilation unit.
> 

Nit: "we'll soon be calling certain static symbols"

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpiolib.c | 11 +++++++++++
>  drivers/gpio/gpiolib.h | 12 +-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index cc9c0a12259e..6768734b9e15 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2009,6 +2009,17 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
>  	return ret;
>  }
>  
> +int gpiod_request_user(struct gpio_desc *desc, const char *label)
> +{
> +	int ret;
> +
> +	ret = gpiod_request(desc, label);
> +	if (ret == -EPROBE_DEFER)
> +		ret = -ENODEV;
> +
> +	return ret;
> +}
> +
>  static bool gpiod_free_commit(struct gpio_desc *desc)
>  {
>  	bool			ret = false;
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index d900ecdbac46..b35deb08a7f5 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -179,19 +179,9 @@ struct gpio_desc {
>  #define gpiod_not_found(desc)		(IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
>  
>  int gpiod_request(struct gpio_desc *desc, const char *label);
> +int gpiod_request_user(struct gpio_desc *desc, const char *label);
>  void gpiod_free(struct gpio_desc *desc);
>  
> -static inline int gpiod_request_user(struct gpio_desc *desc, const char *label)
> -{
> -	int ret;
> -
> -	ret = gpiod_request(desc, label);
> -	if (ret == -EPROBE_DEFER)
> -		ret = -ENODEV;
> -
> -	return ret;
> -}
> -
>  int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
>  		unsigned long lflags, enum gpiod_flags dflags);
>  int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
> -- 
> 2.34.1
> 
