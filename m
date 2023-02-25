Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8796A2AF7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjBYRGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBYRGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:06:45 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8DEFAB;
        Sat, 25 Feb 2023 09:06:44 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s41so1206082oiw.13;
        Sat, 25 Feb 2023 09:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFeFtU7vwoR6tJBIQOLazu07bCBGRN26s63bxL/Qg5U=;
        b=fAzddKztYSv9d95crmJmiXV9fYjekgJAt/5aJbSKmAFQPgD6Je2vneMdUGuSbVnC/h
         Po52zawFkA6D0+9HQYWnEMlROc0KwC8S+1MkTUAGcJ0Jy/Aw6PDYpnXUJXVqspDUylRo
         LclnqgZIYZCEuH1jJ8PS+jPQVfbOUh9eGbSe6ICeJczLambw6XXykVQBlH7VG2WHHnp8
         3CxdNi4isjiGQeQZX9i6PUCtzEt7zzBBzeVPFMj069WjiFd9LRXNeRaUg9FhjTgMc0Bz
         sqmPULJDEUj3XjZx1FxlRdndVAmbGRpNp8HRR+9aAemmisIEKtvV2zlP76YPrceODETB
         kIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFeFtU7vwoR6tJBIQOLazu07bCBGRN26s63bxL/Qg5U=;
        b=NFR6YjVZoWKJxq/QvKdUXHJHMwr7bFj/bo/KWxT9PaRvjqHeI+XKbEKLo6yfxCR6HY
         mqLouZMknuUo/IcSusVgEI315c7y/kLIuRkG+W9iOneoYlG+mYo57T6mAj7oSKUSVMPc
         WirScpjkuTQbUdyTyDP1Dl99n8WIV967BBd3iW2jNlc2kcdBSgqcXFfhKEFdin5JC69W
         UbTockUubMfZKTjjorv1N1+z6KqvhLiDF+Ze6cVnnB8jDxlxeQuuRz1cQpCr3633nBXH
         yb3KG59MiTI9wlJvCHfdjAJReutekuTSzy8vKc8wuAiYWgkcQOo9XXvvVwYXfBMs5VzW
         QzzQ==
X-Gm-Message-State: AO0yUKU3pY0ST4E1i4I1jxrMgYQWdWh+hv2xi3wTDjaubgDaIAzW5wo+
        ULTI1LO3UrqTvos3FU08wnmCmAd9qBI=
X-Google-Smtp-Source: AK7set/FI/mUovdd7dXJCV7z2RoqJ62DuKnnCCcZGPFwTT56d9+2EUnEbcij5Ek9pyFR86VUvlJRBg==
X-Received: by 2002:a54:4416:0:b0:384:210d:a650 with SMTP id k22-20020a544416000000b00384210da650mr267076oiw.20.1677344802283;
        Sat, 25 Feb 2023 09:06:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ec12-20020a056808638c00b00383e12bedebsm1088530oib.9.2023.02.25.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 09:06:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 25 Feb 2023 09:06:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] hwmon: (pmbus/core): Generalize pmbus status flag
 map
Message-ID: <20230225170640.GA3972364@roeck-us.net>
References: <20230217083631.657430-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217083631.657430-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 09:36:28AM +0100, Naresh Solanki wrote:
> The PMBus status flag map(pmbus_regulator_status_flag_map) is moved
> outside of the regulator #if block and the associated variable/struct
> name updated to reflect as generic PMBus status.
> 
> This will make the PMBus status flag map more versatile and easier to
> incorporate into different contexts and functions.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 94 ++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 47 deletions(-)
> 
> 
> base-commit: 5720a18baa4686d56d0a235e6ecbcc55f8d716d7
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 95e95783972a..1b70cf3be313 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2692,6 +2692,49 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>  	return 0;
>  }
>  
> +/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
> +struct pmbus_status_assoc {
> +	int pflag, rflag;
> +};
> +
> +/* PMBus->regulator bit mappings for a PMBus status register */
> +struct pmbus_status_category {
> +	int func;
> +	int reg;
> +	const struct pmbus_status_assoc *bits; /* zero-terminated */
> +};
> +
> +static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[] = {
> +	{
> +		.func = PMBUS_HAVE_STATUS_VOUT,
> +		.reg = PMBUS_STATUS_VOUT,
> +		.bits = (const struct pmbus_status_assoc[]) {
> +			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
> +			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
> +			{ },
> +		},
> +	}, {
> +		.func = PMBUS_HAVE_STATUS_IOUT,
> +		.reg = PMBUS_STATUS_IOUT,
> +		.bits = (const struct pmbus_status_assoc[]) {
> +			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
> +			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
> +			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
> +			{ },
> +		},
> +	}, {
> +		.func = PMBUS_HAVE_STATUS_TEMP,
> +		.reg = PMBUS_STATUS_TEMPERATURE,
> +		.bits = (const struct pmbus_status_assoc[]) {
> +			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
> +			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
> +			{ },
> +		},
> +	},
> +};
> +
>  #if IS_ENABLED(CONFIG_REGULATOR)
>  static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
>  {
> @@ -2738,54 +2781,11 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
>  	return _pmbus_regulator_on_off(rdev, 0);
>  }
>  
> -/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
> -struct pmbus_regulator_status_assoc {
> -	int pflag, rflag;
> -};
> -
> -/* PMBus->regulator bit mappings for a PMBus status register */
> -struct pmbus_regulator_status_category {
> -	int func;
> -	int reg;
> -	const struct pmbus_regulator_status_assoc *bits; /* zero-terminated */
> -};
> -
> -static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
> -	{
> -		.func = PMBUS_HAVE_STATUS_VOUT,
> -		.reg = PMBUS_STATUS_VOUT,
> -		.bits = (const struct pmbus_regulator_status_assoc[]) {
> -			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
> -			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
> -			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
> -			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
> -			{ },
> -		},
> -	}, {
> -		.func = PMBUS_HAVE_STATUS_IOUT,
> -		.reg = PMBUS_STATUS_IOUT,
> -		.bits = (const struct pmbus_regulator_status_assoc[]) {
> -			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
> -			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
> -			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
> -			{ },
> -		},
> -	}, {
> -		.func = PMBUS_HAVE_STATUS_TEMP,
> -		.reg = PMBUS_STATUS_TEMPERATURE,
> -		.bits = (const struct pmbus_regulator_status_assoc[]) {
> -			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
> -			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
> -			{ },
> -		},
> -	},
> -};
> -
>  static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
>  {
>  	int i, status;
> -	const struct pmbus_regulator_status_category *cat;
> -	const struct pmbus_regulator_status_assoc *bit;
> +	const struct pmbus_status_category *cat;
> +	const struct pmbus_status_assoc *bit;
>  	struct device *dev = rdev_get_dev(rdev);
>  	struct i2c_client *client = to_i2c_client(dev->parent);
>  	struct pmbus_data *data = i2c_get_clientdata(client);
> @@ -2796,8 +2796,8 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  
>  	mutex_lock(&data->update_lock);
>  
> -	for (i = 0; i < ARRAY_SIZE(pmbus_regulator_flag_map); i++) {
> -		cat = &pmbus_regulator_flag_map[i];
> +	for (i = 0; i < ARRAY_SIZE(pmbus_status_flag_map); i++) {
> +		cat = &pmbus_status_flag_map[i];
>  		if (!(func & cat->func))
>  			continue;
>  
