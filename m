Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8646B635D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 06:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCLFjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 00:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCLFjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 00:39:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDB728E60;
        Sat, 11 Mar 2023 21:39:09 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j11so11723802lfg.13;
        Sat, 11 Mar 2023 21:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678599548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zdptXNRaqIsqVXuefxQx2pifSS17DVHQm/eRYQjRBg=;
        b=oeoJFHXkeO6VpMjtKsGnKH1jGfKmrs66XhBoUniGgocJ2DNrMJptVkFkWCLaZzo9IC
         iqNGiO0RfdGstqJf4KWfiu4kjeXG8z02FQ9VjWtz4cLmdlEiJYM3FdiPmHa8oKxq818p
         R9teWJOd5Q8C4d0uCpGRFzbe0KNn+eIi4/VhWaOXzoWAmpEQaNcGG0DtV6cyvRqlENCv
         Qje8XRTaqiBmrcYJSLzGJt2P7lrWxNqW7RvIWyb9QAvCI4mpgtZFrCwFq4D/W4bN3edX
         RKshfyn4xbfpMPGupczuLQ03R/HWIATG+bBaNEj76xvPojLsPbmAWl7dDIVTR8hWLP0Q
         v7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678599548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zdptXNRaqIsqVXuefxQx2pifSS17DVHQm/eRYQjRBg=;
        b=66EcGAMaVMGe+1jCVZWq8hwVGKKZXIM/rVCwDejaBbAIdI/VIndY4yxslhq0jmp8jj
         is8ZDbyxCLNHUNya+OJybzr7q0TfSTU8x1hm8KZtkRSRW8/bRSRBqDVqPUwDwBsWZdTb
         UC+y2SVISeerWuLZ4nVDnDrFeszRmX6h4EFQqeWccl65pQjvybLSZ0vhpKYAQA5vHqiw
         J2ZPxs+NyqA6OBT25m7szuaoH+qTJlvxFOCiTccXcXV+IVpiNybnV1h+KcTy9z6Ge11S
         S++6hl3FZTGkasx4X6t1WZp3xx/rsGh6uA2cUNoQE9yaFFeHePEYfIqTe2UfwKgqndqs
         xOfg==
X-Gm-Message-State: AO0yUKVu8qKciaKUQrMPZPgktetgkI5CPLNu/ErMt5NhfoU5oxWiKq/V
        nt9MykgiXkHNWPJGxSn8UahEMlh19SE=
X-Google-Smtp-Source: AK7set+HDO00txndekOmRK77DMyj6aGwmJksOuyyg5xpEqAQ8CiMTV+NFZ/V5AyNKyBi7TjVjk6eTw==
X-Received: by 2002:a19:7405:0:b0:4d8:5096:1c95 with SMTP id v5-20020a197405000000b004d850961c95mr8591982lfe.43.1678599547603;
        Sat, 11 Mar 2023 21:39:07 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25215000000b004dc721ea6a1sm527781lfl.273.2023.03.11.21.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 21:39:07 -0800 (PST)
Message-ID: <8c2b8a20-491f-7fe2-8b28-3dc614fca08c@gmail.com>
Date:   Sun, 12 Mar 2023 07:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] regulator: Use of_property_present() for testing DT
 property presence
To:     Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310144721.1544756-1-robh@kernel.org>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230310144721.1544756-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 16:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/regulator/bd71815-regulator.c | 8 ++++----
>   drivers/regulator/fixed.c             | 2 +-
>   drivers/regulator/gpio-regulator.c    | 2 +-
>   drivers/regulator/pwm-regulator.c     | 2 +-
>   4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71815-regulator.c
> index 8b55046eded8..f4eaea732de7 100644
> --- a/drivers/regulator/bd71815-regulator.c
> +++ b/drivers/regulator/bd71815-regulator.c
> @@ -201,10 +201,10 @@ static int buck12_set_hw_dvs_levels(struct device_node *np,
>   
>   	data = container_of(desc, struct bd71815_regulator, desc);
>   
> -	if (of_find_property(np, "rohm,dvs-run-voltage", NULL) ||
> -	    of_find_property(np, "rohm,dvs-suspend-voltage", NULL) ||
> -	    of_find_property(np, "rohm,dvs-lpsr-voltage", NULL) ||
> -	    of_find_property(np, "rohm,dvs-snvs-voltage", NULL)) {
> +	if (of_property_present(np, "rohm,dvs-run-voltage") ||
> +	    of_property_present(np, "rohm,dvs-suspend-voltage") ||
> +	    of_property_present(np, "rohm,dvs-lpsr-voltage") ||
> +	    of_property_present(np, "rohm,dvs-snvs-voltage")) {
>   		ret = regmap_read(cfg->regmap, desc->vsel_reg, &val);
>   		if (ret)
>   			return ret;
> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> index 2a9867abba20..7c3add05be15 100644
> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c
> @@ -151,7 +151,7 @@ of_get_fixed_voltage_config(struct device *dev,
>   	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
>   	of_property_read_u32(np, "off-on-delay-us", &config->off_on_delay);
>   
> -	if (of_find_property(np, "vin-supply", NULL))
> +	if (of_property_present(np, "vin-supply"))
>   		config->input_supply = "vin";
>   
>   	return config;
> diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
> index 95e61a2f43f5..7602d48609df 100644
> --- a/drivers/regulator/gpio-regulator.c
> +++ b/drivers/regulator/gpio-regulator.c
> @@ -220,7 +220,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
>   				 regtype);
>   	}
>   
> -	if (of_find_property(np, "vin-supply", NULL))
> +	if (of_property_present(np, "vin-supply"))
>   		config->input_supply = "vin";
>   
>   	return config;
> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
> index b9eeaff1c661..214ea866742d 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -334,7 +334,7 @@ static int pwm_regulator_probe(struct platform_device *pdev)
>   
>   	memcpy(&drvdata->desc, &pwm_regulator_desc, sizeof(drvdata->desc));
>   
> -	if (of_find_property(np, "voltage-table", NULL))
> +	if (of_property_present(np, "voltage-table"))
>   		ret = pwm_regulator_init_table(pdev, drvdata);
>   	else
>   		ret = pwm_regulator_init_continuous(pdev, drvdata);

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

