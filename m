Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65882658432
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiL1QzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiL1Qyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:54:52 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BD61BEAB;
        Wed, 28 Dec 2022 08:49:37 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id m7-20020a9d73c7000000b00683e2f36c18so5108376otk.0;
        Wed, 28 Dec 2022 08:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3ZAHS1GdnXXv6m46TyRJ8OSb61H01+gm4l6brOc4tw=;
        b=R4Kuiziw8GCsbz4i/6mBQz/GBID8uuA5T0wGtd6YT7qwL7vx0uHGTOcD/8qPDQ3OwK
         HUmczdTeobkHF50rQMkPS+UG+JS2sEk/G0B9iuIt2S+yJiLsevs4hNeyTfm/Vtj+LkRY
         0LW012qLDC3b22Ojf+XSr2GzU7+oodOd818HQZBQdRVYkQcClKx0u4VZCBuUWdWGKD0D
         12g0PVm9Bhsg++inrS4JjKZq54p86Xscra9A0dP5c/VF+AqM0Rf0W4Pqn4jqWmLaHZix
         wNXpHuox/esMTI12YFqA3HDJ2+exD0hdiWjxnpmaTOa3tNxbeVSG8pO7qPksBAFHiz8f
         o/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3ZAHS1GdnXXv6m46TyRJ8OSb61H01+gm4l6brOc4tw=;
        b=capHH2sJJ9qc5V69Bf6sLKH5FuKaultWzBV+dpw6X12zUnVIzt8x5C34feDzMpwFd5
         8A17axJjXfmKLV9ttqRT61wUwfeksvdrU5c//PCUZRTlcG6ZEGCW4Pij9EQChgDiHabo
         +8cmQvMF/bbNY30I9qAGXWjd8M8ykaSdpy0XXpAfFcFlHe/smx/3oEhb3iIsVF2YKZR+
         YYlxm4cAyX8LSXP2LUiQCt72BHTxwj8MIJKbvRDIdJizB+Qs1ka9MA83TLbCoCnZBBeQ
         43PIHavyzl7aiTSy9ZSGTZib7SwYhAeOwSRgM1hvTqrepND7isTiXXJcCbQYDmrzIa5y
         F5iA==
X-Gm-Message-State: AFqh2kpt+ZKppP3cXFX11ypM91Ut7mCM50KywEKsfbMS8dNPDNViShjn
        s1qUCA5+liKzgMRF1oDfA8g=
X-Google-Smtp-Source: AMrXdXu4SZlfU7LpYKGBSk/jugoV6S1vnmVs4+zY1ywaiZbEVAzldEow5jPSGkO3u0CTMzHsQ7QoIw==
X-Received: by 2002:a05:6830:3809:b0:66c:6c78:27f4 with SMTP id bh9-20020a056830380900b0066c6c7827f4mr14768116otb.3.1672246176417;
        Wed, 28 Dec 2022 08:49:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14-20020a05683033ce00b006705e35c4e2sm7966673ott.35.2022.12.28.08.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 08:49:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 08:49:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Cormier, Jonathan" <jcormier@criticallink.com>
Cc:     linux-hwmon@vger.kernel.org,
        John Pruitt <jpruitt@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>
Subject: Re: [PATCH v2 3/4] hwmon: ltc2945: Allow setting shunt resistor
Message-ID: <20221228164934.GB1267483@roeck-us.net>
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221220000457.1163446-1-jcormier@criticallink.com>
 <20221220000457.1163446-4-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220000457.1163446-4-jcormier@criticallink.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 07:04:56PM -0500, Cormier, Jonathan wrote:
> From: John Pruitt <jpruitt@criticallink.com>
> 
> Added the ability to specify the value of the shunt resistor in the

a/Added/Add/

Per Documentation/process/submitting-patches.rst:

"
Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.
"

> device tree instead of assuming it is 1 milliOhm. The value in the
> device tree has the name shunt-resistor-micro-ohms and the
> default value is 1000 micro-ohms in order to preserve the
> current behavior.
> 
> Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
> Signed-off-by: John Pruitt <jpruitt@criticallink.com>
> ---
>  drivers/hwmon/ltc2945.c | 80 +++++++++++++++++++++++++----------------
>  1 file changed, 50 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> index 9af3e3821152..fc7d399b2c85 100644
> --- a/drivers/hwmon/ltc2945.c
> +++ b/drivers/hwmon/ltc2945.c
> @@ -64,6 +64,16 @@ static const struct of_device_id __maybe_unused ltc2945_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ltc2945_of_match);
> 
> +/**
> + * struct ltc2945_data - LTC2945 device data
> + * @regmap: regmap device
> + * @shunt_resistor: shunt resistor value in micro ohms (1000 by default)
> + */
> +struct ltc2945_data {
> +	struct regmap *regmap;
> +	u32 shunt_resistor;
> +};
> +
>  static inline bool is_power_reg(u8 reg)
>  {
>  	return reg < LTC2945_SENSE_H;
> @@ -72,7 +82,9 @@ static inline bool is_power_reg(u8 reg)
>  /* Return the value from the given register in uW, mV, or mA */
>  static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  {
> -	struct regmap *regmap = dev_get_drvdata(dev);
> +	struct ltc2945_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	u32 shunt_resistor = data->shunt_resistor;
>  	unsigned int control;
>  	u8 buf[3];
>  	long long val;
> @@ -98,9 +110,7 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  	case LTC2945_MAX_POWER_THRES_H:
>  	case LTC2945_MIN_POWER_THRES_H:
>  		/*
> -		 * Convert to uW by assuming current is measured with
> -		 * an 1mOhm sense resistor, similar to current
> -		 * measurements.
> +		 * Convert to uW
>  		 * Control register bit 0 selects if voltage at SENSE+/VDD
>  		 * or voltage at ADIN is used to measure power.
>  		 */
> @@ -114,6 +124,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  			/* 0.5 mV * 25 uV = 0.0125 uV resolution. */
>  			val = (val * 25LL) >> 1;
>  		}
> +		val *= 1000;
> +		val = DIV_ROUND_CLOSEST_ULL(val, shunt_resistor);
>  		break;
>  	case LTC2945_VIN_H:
>  	case LTC2945_MAX_VIN_H:
> @@ -136,14 +148,9 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  	case LTC2945_MIN_SENSE_H:
>  	case LTC2945_MAX_SENSE_THRES_H:
>  	case LTC2945_MIN_SENSE_THRES_H:
> -		/*
> -		 * 25 uV resolution. Convert to current as measured with
> -		 * an 1 mOhm sense resistor, in mA. If a different sense
> -		 * resistor is installed, calculate the actual current by
> -		 * dividing the reported current by the sense resistor value
> -		 * in mOhm.
> -		 */
> -		val *= 25;
> +		/* 25 uV resolution. Convert to mA. */
> +		val *= 25 * 1000;
> +		val = DIV_ROUND_CLOSEST_ULL(val, shunt_resistor);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -154,7 +161,9 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  			      unsigned long val)
>  {
> -	struct regmap *regmap = dev_get_drvdata(dev);
> +	struct ltc2945_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	u32 shunt_resistor = data->shunt_resistor;
>  	unsigned int control;
>  	int ret;
> 
> @@ -165,9 +174,6 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  	case LTC2945_MAX_POWER_THRES_H:
>  	case LTC2945_MIN_POWER_THRES_H:
>  		/*
> -		 * Convert to register value by assuming current is measured
> -		 * with an 1mOhm sense resistor, similar to current
> -		 * measurements.
>  		 * Control register bit 0 selects if voltage at SENSE+/VDD
>  		 * or voltage at ADIN is used to measure power, which in turn
>  		 * determines register calculations.
> @@ -177,14 +183,16 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  			return ret;
>  		if (control & CONTROL_MULT_SELECT) {
>  			/* 25 mV * 25 uV = 0.625 uV resolution. */
> -			val = DIV_ROUND_CLOSEST(val, 625);
> +			val *= shunt_resistor;
> +			val = DIV_ROUND_CLOSEST(val, 625 * 1000);

Overflows are introduced and need to be be handled in this patch.
It doesn't make sense to introduce them and fix them in the next patch.

>  		} else {
>  			/*
>  			 * 0.5 mV * 25 uV = 0.0125 uV resolution.
>  			 * Divide first to avoid overflow;
>  			 * accept loss of accuracy.
>  			 */
> -			val = DIV_ROUND_CLOSEST(val, 25) * 2;
> +			val *= shunt_resistor;
> +			val = DIV_ROUND_CLOSEST(val, 25 * 1000) * 2;
>  		}
>  		break;
>  	case LTC2945_VIN_H:
> @@ -208,14 +216,9 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  	case LTC2945_MIN_SENSE_H:
>  	case LTC2945_MAX_SENSE_THRES_H:
>  	case LTC2945_MIN_SENSE_THRES_H:
> -		/*
> -		 * 25 uV resolution. Convert to current as measured with
> -		 * an 1 mOhm sense resistor, in mA. If a different sense
> -		 * resistor is installed, calculate the actual current by
> -		 * dividing the reported current by the sense resistor value
> -		 * in mOhm.
> -		 */
> -		val = DIV_ROUND_CLOSEST(val, 25);
> +		/* 25 uV resolution. Convert to  mA. */
> +		val *= shunt_resistor;
> +		val = DIV_ROUND_CLOSEST(val, 25 * 1000);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -240,7 +243,8 @@ static ssize_t ltc2945_value_store(struct device *dev,
>  				   const char *buf, size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct regmap *regmap = dev_get_drvdata(dev);
> +	struct ltc2945_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
>  	u8 reg = attr->index;
>  	unsigned long val;
>  	u8 regbuf[3];
> @@ -275,7 +279,8 @@ static ssize_t ltc2945_history_store(struct device *dev,
>  				     const char *buf, size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct regmap *regmap = dev_get_drvdata(dev);
> +	struct ltc2945_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
>  	u8 reg = attr->index;
>  	int num_regs = is_power_reg(reg) ? 3 : 2;
>  	u8 buf_min[3] = { 0xff, 0xff, 0xff };
> @@ -327,7 +332,8 @@ static ssize_t ltc2945_bool_show(struct device *dev,
>  				 struct device_attribute *da, char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct regmap *regmap = dev_get_drvdata(dev);
> +	struct ltc2945_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
>  	unsigned int fault;
>  	int ret;
> 
> @@ -456,6 +462,12 @@ static int ltc2945_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
>  	struct regmap *regmap;
> +	struct ltc2945_data *data;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	dev_set_drvdata(dev, data);
> 
>  	regmap = devm_regmap_init_i2c(client, &ltc2945_regmap_config);
>  	if (IS_ERR(regmap)) {
> @@ -463,11 +475,19 @@ static int ltc2945_probe(struct i2c_client *client)
>  		return PTR_ERR(regmap);
>  	}
> 
> +	data->regmap = regmap;
> +	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				     &data->shunt_resistor))
> +		data->shunt_resistor = 1000;
> +
> +	if (data->shunt_resistor == 0)
> +		return -EINVAL;
> +
>  	/* Clear faults */
>  	regmap_write(regmap, LTC2945_FAULT, 0x00);
> 
>  	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> -							   regmap,
> +							   data,
>  							   ltc2945_groups);
>  	return PTR_ERR_OR_ZERO(hwmon_dev);
>  }
> --
> 2.25.1
