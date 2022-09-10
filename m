Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5275B4704
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiIJOw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIJOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:52:24 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21443C8D5;
        Sat, 10 Sep 2022 07:52:23 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v4so4173715pgi.10;
        Sat, 10 Sep 2022 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1SY4TpHE+AZHvW2ko6rmWpSmMSJGc1ThHZPB1PChNlY=;
        b=IBIf/R174iWgXiAXzZeFMJSypsrDZneiiYk7dVIZclSibo924xZwGDpFngMKABuqDV
         uiUHbCK1or1MNCJW5/sam+8bSOm67h9guFuD1pxRLFSkUOy9ZHH7pY8brFKPUby66/+g
         h0Gdf0r1CjJRVMW2HvvgMD+Xt1/VNRJyj/ck5i47+OcfEXBBN+HXDPIjqGriaKaSlx5F
         /idmiNhy6ld6errIqaQbqN/bYUSAZ+vp32h13uZAu3J6abOKmmw963RK5jOQLmHe0Gx1
         JTEC2cA0IEL2SbfzTWn1dJYJbdwdxW9we8PIGfD0HEMM2i/0Xs+lZ857IJ/8/sMUKnan
         w8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1SY4TpHE+AZHvW2ko6rmWpSmMSJGc1ThHZPB1PChNlY=;
        b=OECAuratXvXrZ0r61DgOYcbbVkcdUYLABN07NgdNpTAEIhyP0GjOCyZ3Oo7+f7Jr0W
         rZYD05ManuKzkvxIa4Rx0f5X2quJoa/tnl41AaRei3Q5RysudIqnxQwcZK2fKq8ZNYwX
         03f7+1mu0oOqg2O7qm06pxParNUrcIIma1hr3qM6S5OZdrp4jbbKzteP8+M3ypljACo0
         ft2PqyhIGa1Gu50geYVTNv0CBa+FFXDi8LZnkmPYJmQNQx9F3GTUDs1lPKD4iV8aSGB5
         jy10NeQ9+/qYuYFE8AKA7HsLqd0jS2qPoa396WA8Fwes86nd4QdqPWliZJqePTrGlOcn
         bmPA==
X-Gm-Message-State: ACgBeo1QudvsT280jREqirb0pEQqcgND3qDpZtpXic6NPQHdsvkUrlrV
        ncAq9rcJf2NSTe0upyQtUso=
X-Google-Smtp-Source: AA6agR7JYxqz+DfLIDFex45W7fgHwUlQI8Oc6iBo+PKUvJqQBV34rQd5Aan0q9KwQD9m16oET4HrSw==
X-Received: by 2002:a63:89c2:0:b0:438:c64a:f1a1 with SMTP id v185-20020a6389c2000000b00438c64af1a1mr1405064pgd.314.1662821543080;
        Sat, 10 Sep 2022 07:52:23 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0015e8d4eb1d5sm2412426plk.31.2022.09.10.07.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 07:52:22 -0700 (PDT)
Date:   Sat, 10 Sep 2022 22:52:18 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
Message-ID: <YxykorLetCjAls/Z@sol>
References: <20220909121329.42004-1-brgl@bgdev.pl>
 <20220909121329.42004-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909121329.42004-3-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:13:29PM +0200, Bartosz Golaszewski wrote:
> It's useful for user-space to be able to know the PIDs of processes
> holding GPIO lines in case they have the permissions and need to kill
> them.
> 

"the PID of the process holding a GPIO line"

As written it could be interpreted to imply that multiple processes can
hold a line, so go singular to remove that possibility.

> Extend the gpio_v2_line_info structure with the consumer_pid field
> that's set to the PID of the user-space process or 0 if the user lives
> in the kernel.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpiolib-cdev.c |  2 ++
>  drivers/gpio/gpiolib.c      | 24 +++++++++++++++++++-----
>  drivers/gpio/gpiolib.h      |  2 ++
>  include/uapi/linux/gpio.h   |  5 ++++-
>  4 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index f8041d4898d1..9b6d518680dc 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -2120,6 +2120,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
>  	if (desc->label)
>  		strscpy(info->consumer, desc->label, sizeof(info->consumer));
>  
> +	info->consumer_pid = desc->pid;
> +
>  	/*
>  	 * Userspace only need to know that the kernel is using this GPIO so
>  	 * it can't use it.
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 6768734b9e15..0c9d1639b04d 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -96,6 +96,11 @@ static inline void desc_set_label(struct gpio_desc *d, const char *label)
>  	d->label = label;
>  }
>  
> +static inline void desc_set_pid(struct gpio_desc *d, pid_t pid)
> +{
> +	d->pid = pid;
> +}
> +
>  /**
>   * gpio_to_desc - Convert a GPIO number to its descriptor
>   * @gpio: global GPIO number
> @@ -1892,7 +1897,8 @@ EXPORT_SYMBOL_GPL(gpiochip_remove_pin_ranges);
>   * on each other, and help provide better diagnostics in debugfs.
>   * They're called even less than the "set direction" calls.
>   */
> -static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
> +static int
> +gpiod_request_commit(struct gpio_desc *desc, const char *label, pid_t pid)
>  {
>  	struct gpio_chip	*gc = desc->gdev->chip;
>  	int			ret;
> @@ -1913,6 +1919,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
>  
>  	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0) {
>  		desc_set_label(desc, label ? : "?");
> +		desc_set_pid(desc, pid);
>  	} else {
>  		ret = -EBUSY;
>  		goto out_free_unlock;
> @@ -1987,7 +1994,8 @@ static int validate_desc(const struct gpio_desc *desc, const char *func)
>  		return; \
>  	} while (0)
>  
> -int gpiod_request(struct gpio_desc *desc, const char *label)
> +static int
> +gpiod_request_with_pid(struct gpio_desc *desc, const char *label, pid_t pid)
>  {
>  	int ret = -EPROBE_DEFER;
>  	struct gpio_device *gdev;
> @@ -1996,7 +2004,7 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
>  	gdev = desc->gdev;
>  
>  	if (try_module_get(gdev->owner)) {
> -		ret = gpiod_request_commit(desc, label);
> +		ret = gpiod_request_commit(desc, label, pid);
>  		if (ret)
>  			module_put(gdev->owner);
>  		else
> @@ -2009,11 +2017,16 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
>  	return ret;
>  }
>  
> +int gpiod_request(struct gpio_desc *desc, const char *label)
> +{
> +	return gpiod_request_with_pid(desc, label, 0);
> +}
> +
>  int gpiod_request_user(struct gpio_desc *desc, const char *label)
>  {
>  	int ret;
>  
> -	ret = gpiod_request(desc, label);
> +	ret = gpiod_request_with_pid(desc, label, current->pid);
>  	if (ret == -EPROBE_DEFER)
>  		ret = -ENODEV;
>  
> @@ -2042,6 +2055,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
>  		}
>  		kfree_const(desc->label);
>  		desc_set_label(desc, NULL);
> +		desc_set_pid(desc, 0);
>  		clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
>  		clear_bit(FLAG_REQUESTED, &desc->flags);
>  		clear_bit(FLAG_OPEN_DRAIN, &desc->flags);
> @@ -2140,7 +2154,7 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
>  		return desc;
>  	}
>  
> -	ret = gpiod_request_commit(desc, label);
> +	ret = gpiod_request_commit(desc, label, 0);
>  	if (ret < 0)
>  		return ERR_PTR(ret);
>  
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index b35deb08a7f5..d1535677e162 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -165,6 +165,8 @@ struct gpio_desc {
>  
>  	/* Connection label */
>  	const char		*label;
> +	/* Consumer's PID (if consumer is in user-space, otherwise 0) */
> +	pid_t			pid;
>  	/* Name of the GPIO */
>  	const char		*name;
>  #ifdef CONFIG_OF_DYNAMIC
> diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
> index cb9966d49a16..37f10021d1aa 100644
> --- a/include/uapi/linux/gpio.h
> +++ b/include/uapi/linux/gpio.h
> @@ -219,6 +219,8 @@ struct gpio_v2_line_request {
>   * gpio_v2_line_flag, such as %GPIO_V2_LINE_FLAG_ACTIVE_LOW,
>   * %GPIO_V2_LINE_FLAG_OUTPUT etc, added together.
>   * @attrs: the configuration attributes associated with the line
> + * @consumer_pid: process ID of the user-space consumer or 0 if the consumer
> + * lives in kernel space
>   * @padding: reserved for future use
>   */
>  struct gpio_v2_line_info {
> @@ -228,8 +230,9 @@ struct gpio_v2_line_info {
>  	__u32 num_attrs;
>  	__aligned_u64 flags;
>  	struct gpio_v2_line_attribute attrs[GPIO_V2_LINE_NUM_ATTRS_MAX];
> +	__s32 consumer_pid;

My knee-jerk reaction here was to make the pid unsigned, as we never
pass a negative PID.
Keeping in mind that the existing kernel will return 0 for this field
(the existing padding), so 0 needs to be excluded from valid PIDs
anyway.

Andy suggests returning -1 for kernel held lines.
In that case 0 would mean "old kernel", while -1 would mean "kernel
held".

As libgpiod will have to convert the 0 to -1 when returning the PID to
user-space as a pid_t, I'm good with the uAPI using 0 to mean
"no PID available" for all cases. I'm still open to passing -1 for
kernel held is there is a use case for it, but I don't see one.

Cheers,
Kent.

>  	/* Space reserved for future use. */
> -	__u32 padding[4];
> +	__u32 padding[3];
>  };
>  
>  /**
> -- 
> 2.34.1
> 
