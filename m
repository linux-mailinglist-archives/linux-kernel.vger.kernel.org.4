Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F9862D8D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbiKQLFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239520AbiKQLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:05:43 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D6C40905
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:05:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i21so1981980edj.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzwTxfT1x+tdpgooP5ivmkX3RVGqdvT7BZT7qtokX5U=;
        b=PtFjqmwatJ5oqPLC4R30ElTZwVzSAVrYN4IpUUL3lJQSpqW0H0zorYOwqMAt6V5KFk
         5K+meFzNSqT+2CqiLnHBPJzBdmTUrqDL8Nv+UlNDox6Rm+e9YoQWBAkPEWq45ECL7NKM
         wZvul+J5+6VI2wtIsjl3qK33oyYI6IoGN0gj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzwTxfT1x+tdpgooP5ivmkX3RVGqdvT7BZT7qtokX5U=;
        b=PI4xFzUvsNMJKJ92HKkPTJ9WDXU5AWRpX5MRff9l4IBdIzvRQRw4dKDqvfVD73Y2XY
         UarmHcpnohwKcM1IOUvVGrAcS8cCysKszCuFe6m6XqUNyH2KASXHjPyGIscSfPVMAu8Y
         1UXuWWnR9e3+1BmIPgLxpvzZpvimaM6n/e4+/VRv/9Yl+MlX+9igpI0Wgw1BE1LGcuzh
         yYuhayDDfoB3Pr8zwWbzj0ZiAvaGRs4kq6FofEdnyAWT8sRoPPaL37HeKTFNebJoc8E/
         AFO4xJFrzGoL78k7sa2GoHgPgNhihai4xCrQjhtShRj0bcB0tWklG7cRgNmAF7rNkOuo
         JrJQ==
X-Gm-Message-State: ANoB5pmCosBduFNyH4ZDXZXjn3glmGcx7LrP4Et623ZlvMWq2S/VN1n7
        2G/8nY2ddY6uSsAXlLkCfDTqFw==
X-Google-Smtp-Source: AA0mqf7iKPyFzjDnORQZqi7PMLmBbxb/n6/Jz06bTE6VmW7HRRUdDsWS6Rke32rm5D//Fi1L9UGIgg==
X-Received: by 2002:a05:6402:43cd:b0:467:c68b:b06c with SMTP id p13-20020a05640243cd00b00467c68bb06cmr1612431edc.428.1668683138482;
        Thu, 17 Nov 2022 03:05:38 -0800 (PST)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-54-207.cust.vodafonedsl.it. [188.217.54.207])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm392234edb.42.2022.11.17.03.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 03:05:38 -0800 (PST)
Date:   Thu, 17 Nov 2022 12:05:36 +0100
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 3/4] media: i2c: s5c73m3: remove support for platform data
Message-ID: <20221117110536.GC2725180@tom-ThinkPad-T14s-Gen-2i>
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
 <20221115221145.2550572-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115221145.2550572-3-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:11:44PM -0800, Dmitry Torokhov wrote:
> There are no existing users of s5c73m3_platform_data in the tree, and
> new users shoudl either be using device tree, ACPI, or static device
> properties, so let's remove it from the driver.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/media/i2c/s5c73m3/s5c73m3-core.c  | 19 ++------
>  drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c |  2 -
>  drivers/media/i2c/s5c73m3/s5c73m3.h       |  6 ++-
>  include/media/i2c/s5c73m3.h               | 56 -----------------------
>  4 files changed, 9 insertions(+), 74 deletions(-)
>  delete mode 100644 include/media/i2c/s5c73m3.h
> 
> diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
> index d96ba58ce1e5..561c1a1583ac 100644
> --- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
> +++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
> @@ -27,7 +27,6 @@
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-subdev.h>
>  #include <media/v4l2-mediabus.h>
> -#include <media/i2c/s5c73m3.h>
>  #include <media/v4l2-fwnode.h>
>  
>  #include "s5c73m3.h"
> @@ -1592,26 +1591,16 @@ static int s5c73m3_parse_gpios(struct s5c73m3 *state)
>  	return 0;
>  }
>  
> -static int s5c73m3_get_platform_data(struct s5c73m3 *state)
> +static int s5c73m3_get_dt_data(struct s5c73m3 *state)
>  {
>  	struct device *dev = &state->i2c_client->dev;
> -	const struct s5c73m3_platform_data *pdata = dev->platform_data;
>  	struct device_node *node = dev->of_node;
>  	struct device_node *node_ep;
>  	struct v4l2_fwnode_endpoint ep = { .bus_type = 0 };
>  	int ret;
>  
> -	if (!node) {
> -		if (!pdata) {
> -			dev_err(dev, "Platform data not specified\n");
> -			return -EINVAL;
> -		}
> -
> -		state->mclk_frequency = pdata->mclk_frequency;
> -		state->gpio[STBY] = pdata->gpio_stby;
> -		state->gpio[RSET] = pdata->gpio_reset;
> -		return 0;
> -	}
> +	if (!node)
> +		return -EINVAL;
>  
>  	state->clock = devm_clk_get(dev, S5C73M3_CLK_NAME);
>  	if (IS_ERR(state->clock))
> @@ -1666,7 +1655,7 @@ static int s5c73m3_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	state->i2c_client = client;
> -	ret = s5c73m3_get_platform_data(state);
> +	ret = s5c73m3_get_dt_data(state);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c b/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
> index 141ad0ba7f5a..1c8103670fa2 100644
> --- a/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
> +++ b/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
> @@ -10,7 +10,6 @@
>  #include <linux/sizes.h>
>  #include <linux/delay.h>
>  #include <linux/firmware.h>
> -#include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/media.h>
> @@ -24,7 +23,6 @@
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-subdev.h>
>  #include <media/v4l2-mediabus.h>
> -#include <media/i2c/s5c73m3.h>
>  
>  #include "s5c73m3.h"
>  
> diff --git a/drivers/media/i2c/s5c73m3/s5c73m3.h b/drivers/media/i2c/s5c73m3/s5c73m3.h
> index c3fcfdd3ea66..d68528898249 100644
> --- a/drivers/media/i2c/s5c73m3/s5c73m3.h
> +++ b/drivers/media/i2c/s5c73m3/s5c73m3.h
> @@ -15,7 +15,6 @@
>  #include <media/v4l2-common.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-subdev.h>
> -#include <media/i2c/s5c73m3.h>
>  
>  #define DRIVER_NAME			"S5C73M3"
>  
> @@ -357,6 +356,11 @@ enum s5c73m3_gpio_id {
>  	GPIO_NUM,
>  };
>  
> +struct s5c73m3_gpio {
> +	int gpio;
> +	int level;
> +};
> +
>  enum s5c73m3_resolution_types {
>  	RES_ISP,
>  	RES_JPEG,
> diff --git a/include/media/i2c/s5c73m3.h b/include/media/i2c/s5c73m3.h
> deleted file mode 100644
> index a51f1025ba1c..000000000000
> --- a/include/media/i2c/s5c73m3.h
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -/*
> - * Samsung LSI S5C73M3 8M pixel camera driver
> - *
> - * Copyright (C) 2012, Samsung Electronics, Co., Ltd.
> - * Sylwester Nawrocki <s.nawrocki@samsung.com>
> - * Andrzej Hajda <a.hajda@samsung.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -#ifndef MEDIA_S5C73M3__
> -#define MEDIA_S5C73M3__
> -
> -#include <linux/videodev2.h>
> -#include <media/v4l2-mediabus.h>
> -
> -/**
> - * struct s5c73m3_gpio - data structure describing a GPIO
> - * @gpio:  GPIO number
> - * @level: indicates active state of the @gpio
> - */
> -struct s5c73m3_gpio {
> -	int gpio;
> -	int level;
> -};
> -
> -/**
> - * struct s5c73m3_platform_data - s5c73m3 driver platform data
> - * @mclk_frequency: sensor's master clock frequency in Hz
> - * @gpio_reset:  GPIO driving RESET pin
> - * @gpio_stby:   GPIO driving STBY pin
> - * @bus_type:    bus type
> - * @nlanes:      maximum number of MIPI-CSI lanes used
> - * @horiz_flip:  default horizontal image flip value, non zero to enable
> - * @vert_flip:   default vertical image flip value, non zero to enable
> - */
> -
> -struct s5c73m3_platform_data {
> -	unsigned long mclk_frequency;
> -
> -	struct s5c73m3_gpio gpio_reset;
> -	struct s5c73m3_gpio gpio_stby;
> -
> -	enum v4l2_mbus_type bus_type;
> -	u8 nlanes;
> -	u8 horiz_flip;
> -	u8 vert_flip;
> -};
> -
> -#endif /* MEDIA_S5C73M3__ */
> -- 
> 2.38.1.431.g37b22c650d-goog
> 

Looks good to me.
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
