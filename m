Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2EC5BBD97
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIRLZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIRLZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:25:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F357122BFB;
        Sun, 18 Sep 2022 04:25:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u18so42475395lfo.8;
        Sun, 18 Sep 2022 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AFDUSyQgNlFhUnX6gC0TWQYVHNBF5uk8WMp2yAC/xFA=;
        b=FPQHZTTO1ue6JTGT3mFVZIiMOFrpR87Kpb3MHD8fWNx8m9CgWcjzw5vyu8QvV3EZj1
         Vin3tJChC2YmCYJqN4bqoEywtPFkY4CkzD6Ze6o/Rsd4OKP1AdaqJ4xB0vFO6dHrd6ab
         Dt1MlOnS99/ZVP2FXgF0mIsxRF/q38+cTu7jgEAA4IKKpuIepQ8pEHWI6eDUtSRSov3P
         O4LEoMqLwHl1b4E9XQmgetc2giVxyLgTZ9ez/CBkYGAw6U3ANp1HSscGuQIqtriMY0k/
         sch86g+H7N2smTRkyLn5GQWoxgx6ul8IhI+w7jpxbhI50PmRyg/BtuPjITR/FfFAy0ty
         UpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AFDUSyQgNlFhUnX6gC0TWQYVHNBF5uk8WMp2yAC/xFA=;
        b=hUSgvJnhK4yTqPuMpuWH/l9dr2JCke15LztgbB52IM7H147CpA7PL+vNWPskgEnEy9
         zQI5CE1oq0O7vy4FSv6YTNxR74N+0iigPiHRLoVbxGK/VNoHd6DIjRL0x5deEcLOuTBM
         9WNDdFNZM9SffbvYK/5mFgLJOEvKXDqH/UtsqktiljTTQ0t+FlAZ3KX0quDNKroYKXVh
         u3hHqJiyJ0NCtzURG7JilWQ6T5RlKQtdFQNQdpJAspZnwLQmgmWAl9pzMrRy6uOEzChV
         0Rtn5Umsopvh3NPVRKBZc0pPJ99uafIvPReUh1hvqysvE8u46fj9eekrMP5vznFiNYIl
         po2w==
X-Gm-Message-State: ACrzQf3bHwpEFfb2zuSU/cJGLZr0r4pQjULEEKDJglsUGauYlyWypFmn
        qVzTpfiHLAh6EmMnxNdjjpTYmbU66Hw=
X-Google-Smtp-Source: AMsMyM6oj784v1TWWqszkZAASkrkb5fG5c6QKGWkpDAsrbvctOQzYE2CS0n4WcUAlu1esLaN9ccLsA==
X-Received: by 2002:a05:6512:2215:b0:49e:ac45:22e1 with SMTP id h21-20020a056512221500b0049eac4522e1mr4805851lfu.33.1663500336249;
        Sun, 18 Sep 2022 04:25:36 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id q8-20020a2eb4a8000000b00266af46abccsm4473742ljm.72.2022.09.18.04.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 04:25:35 -0700 (PDT)
Message-ID: <0f6e0dc0-7101-ff17-09ce-14bd2a0189fb@gmail.com>
Date:   Sun, 18 Sep 2022 13:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v3 2/4] leds: class: store the color index in
 struct led_classdev
Content-Language: en-US
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>, pavel@ucw.cz,
        robh+dt@kernel.org, sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, marijn.suijten@somainline.org,
        bjorn.andersson@linaro.org, andy.shevchenko@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sha@pengutronix.de
References: <20220917081339.3354075-1-jjhiblot@traphandler.com>
 <20220917081339.3354075-3-jjhiblot@traphandler.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20220917081339.3354075-3-jjhiblot@traphandler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 9/17/22 10:13, Jean-Jacques Hiblot wrote:
> This information might be useful for more than only deriving the led's
> name.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>   drivers/leds/led-class.c | 7 +++++++
>   include/linux/leds.h     | 1 +
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 2c0d979d0c8a..537379f09801 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -350,6 +350,10 @@ int led_classdev_register_ext(struct device *parent,
>   			if (fwnode_property_present(init_data->fwnode,
>   						    "retain-state-shutdown"))
>   				led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
> +
> +			if (fwnode_property_present(init_data->fwnode, "color"))
> +				fwnode_property_read_u32(init_data->fwnode, "color",
> +							 &led_cdev->color);
>   		}
>   	} else {
>   		proposed_name = led_cdev->name;
> @@ -359,6 +363,9 @@ int led_classdev_register_ext(struct device *parent,
>   	if (ret < 0)
>   		return ret;
>   
> +	if (led_cdev->color >= LED_COLOR_ID_MAX)
> +		dev_warn(parent, "LED %s color identifier out of range\n", final_name);
> +
>   	mutex_init(&led_cdev->led_access);
>   	mutex_lock(&led_cdev->led_access);
>   	led_cdev->dev = device_create_with_groups(leds_class, parent, 0,
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index ba4861ec73d3..fe6346604e36 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -71,6 +71,7 @@ struct led_classdev {
>   	const char		*name;
>   	unsigned int brightness;
>   	unsigned int max_brightness;
> +	unsigned int color;

We have color_index in struct mc_subled. What would this serve for?

>   	int			 flags;
>   
>   	/* Lower 16 bits reflect status */

-- 
Best regards,
Jacek Anaszewski
