Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEC963DD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiK3SYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiK3SYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:24:32 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F320C102B;
        Wed, 30 Nov 2022 10:24:30 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so11774892otl.3;
        Wed, 30 Nov 2022 10:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNUvSXQfvyKXAOeaSOMjcREySFXKMC/WQZfGT8y6zYg=;
        b=CuO2sR778rOXA3/z60MDbJAlNh+9z+7DQx79PvcTwPpgwPdLs7cGN4vasL09dFJMk2
         vh7FK8W48MTVvV94T9/ElrKj1L8fJceqLm/q3Z2+KDi/1U9xDjc+aIJpD4maHWjI3qeC
         dVH1m+7FEmhkE6mbjJ8juRWaGz4vzNFsZM90Pqo7VQivPJCz8r+85ME5LmrW7ZFAIv6r
         HUdXx1b7f2Jwa76bqoTSu26mEpo34twq14bDuGq+dx7rbuof+Va9BPTYHJxWoiGhi2yZ
         6OTHReUT18/tzU8iapXAV9DujNQf7PU5zvLpmLdRIF6xTsiQhKz4JV+mvWhQCbvpgeaA
         HtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNUvSXQfvyKXAOeaSOMjcREySFXKMC/WQZfGT8y6zYg=;
        b=1PWxrgpfSd348ml7zhLLo/qNVV0yX9YO2nqpK5wByq2q/EAqMzFECZSac6P+qLQoe6
         ikQzyzRxauEGl11FG477kZ0mdaqyYVJXxkvD9LyQ7d6anodl82gdYzmLYo4LWWxvrIe6
         +SzdBMYgCA9zaBvUe5h+pG3lUW1hA8vxRFwGSAGH1kYOnv927SoXTkyDeHZQSKsesUkW
         b1IxGme3Tct0olWVPngF+OUqILzL1lYeqPXasO0WquJCmN4UZ8XXOYP6kokc7GqT7Ojc
         a/lCgY/GXB49BoZHPdlru1MK/JDrpkSn9Sji2r3rKLgBhKh5H1+Trlv0bFEMQMttg6M8
         Q92Q==
X-Gm-Message-State: ANoB5pmWNEFJxNrOeWPPPG1vvTqzaJiSrcioS3E+jwOUOOfsCyATubQB
        4GTb36IG1ejADKOssnH8nOM=
X-Google-Smtp-Source: AA0mqf7T9hXaEY+9oswLmhJjj1blqzOcuWEnq4YiuFWXMImTvOc4fjYqwdmnv4mA1Ic6h1XU16an6Q==
X-Received: by 2002:a05:6830:1097:b0:66d:31ad:7217 with SMTP id y23-20020a056830109700b0066d31ad7217mr31561250oto.27.1669832670239;
        Wed, 30 Nov 2022 10:24:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l25-20020a4ad9d9000000b004a05e943f9esm995585oou.21.2022.11.30.10.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:24:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Nov 2022 10:24:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v3 3/4] hwmon: (pmbus/core): Implement irq support
Message-ID: <20221130182428.GB2658232@roeck-us.net>
References: <20221130165955.3479143-1-Naresh.Solanki@9elements.com>
 <20221130165955.3479143-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130165955.3479143-3-Naresh.Solanki@9elements.com>
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

On Wed, Nov 30, 2022 at 05:59:53PM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Implement PMBUS irq handler to notify regulator events.
> 

There should be separate patches for adding irq support, adding
hwmon notifications, and adding regulator notifications. The order
should be:

- Add interrupt support
- Add hwmon notifications
- Add events to regulator flag map
- Add regulator notifications

Guenter

> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/pmbus/pmbus.h      |   2 +-
>  drivers/hwmon/pmbus/pmbus_core.c | 151 ++++++++++++++++++++++++++++---
>  2 files changed, 137 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 10fb17879f8e..6b2e6cf93b19 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -26,7 +26,7 @@ enum pmbus_regs {
>  
>  	PMBUS_CAPABILITY		= 0x19,
>  	PMBUS_QUERY			= 0x1A,
> -
> +	PMBUS_SMBALERT_MASK		= 0x1B,
>  	PMBUS_VOUT_MODE			= 0x20,
>  	PMBUS_VOUT_COMMAND		= 0x21,
>  	PMBUS_VOUT_TRIM			= 0x22,
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 9a9e380acc23..613e2e484a0f 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -81,6 +81,7 @@ struct pmbus_label {
>  struct pmbus_data {
>  	struct device *dev;
>  	struct device *hwmon_dev;
> +	struct regulator_dev **rdevs;
>  
>  	u32 flags;		/* from platform data */
>  
> @@ -2804,7 +2805,8 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>  	},
>  };
>  
> -static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> +static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *error,
> +				    unsigned int *event)
>  {
>  	int i, status;
>  	const struct pmbus_regulator_status_category *cat;
> @@ -2815,7 +2817,8 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	u8 page = rdev_get_id(rdev);
>  	int func = data->info->func[page];
>  
> -	*flags = 0;
> +	*error = 0;
> +	*event = 0;
>  
>  	mutex_lock(&data->update_lock);
>  
> @@ -2831,8 +2834,10 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  		}
>  
>  		for (bit = cat->bits; bit->pflag; bit++) {
> -			if (status & bit->pflag)
> -				*flags |= bit->rflag;
> +			if (status & bit->pflag) {
> +				*error |= bit->rflag;
> +				*event |= bit->eflag;
> +			}
>  		}
>  	}
>  
> @@ -2851,11 +2856,15 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  		return status;
>  
>  	if (pmbus_regulator_is_enabled(rdev)) {
> -		if (status & PB_STATUS_OFF)
> -			*flags |= REGULATOR_ERROR_FAIL;
> +		if (status & PB_STATUS_OFF) {
> +			*error |= REGULATOR_ERROR_FAIL;
> +			*event |= REGULATOR_EVENT_FAIL;
> +		}
>  
> -		if (status & PB_STATUS_POWER_GOOD_N)
> -			*flags |= REGULATOR_ERROR_REGULATION_OUT;
> +		if (status & PB_STATUS_POWER_GOOD_N) {
> +			*error |= REGULATOR_ERROR_REGULATION_OUT;
> +			*event |= REGULATOR_EVENT_REGULATION_OUT;
> +		}
>  	}
>  
>  	/*
> @@ -2863,13 +2872,22 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	 * PMBUS_STATUS_TEMPERATURE, map PB_STATUS_TEMPERATURE to a warning as
>  	 * a (conservative) best-effort interpretation.
>  	 */
> -	if (!(*flags & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
> -	    (status & PB_STATUS_TEMPERATURE))
> -		*flags |= REGULATOR_ERROR_OVER_TEMP_WARN;
> +	if (!(*error & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
> +	    (status & PB_STATUS_TEMPERATURE)) {
> +		*error |= REGULATOR_ERROR_OVER_TEMP_WARN;
> +		*event |= REGULATOR_EVENT_OVER_TEMP_WARN;
> +	}
>  
>  	return 0;
>  }
>  
> +static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> +{
> +	unsigned int event;
> +
> +	return pmbus_regulator_get_flags(rdev, flags, &event);
> +}
> +
>  static int pmbus_regulator_get_status(struct regulator_dev *rdev)
>  {
>  	struct device *dev = rdev_get_dev(rdev);
> @@ -3060,14 +3078,61 @@ const struct regulator_ops pmbus_regulator_ops = {
>  };
>  EXPORT_SYMBOL_NS_GPL(pmbus_regulator_ops, PMBUS);
>  
> +static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
> +{
> +	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
> +}
> +
> +static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
> +{
> +	struct pmbus_data *data = pdata;
> +	struct i2c_client *client = to_i2c_client(data->dev);
> +	int i, ret = IRQ_NONE, status, event;
> +	u8 page;
> +
> +	for (i = 0; i < data->info->num_regulators; i++) {
> +
> +		if (!data->rdevs[i])
> +			continue;
> +
> +		ret = pmbus_regulator_get_flags(data->rdevs[i], &status, &event);
> +		if (ret)
> +			return ret;
> +
> +		if (event) {
> +			regulator_notifier_call_chain(data->rdevs[i], event, NULL);
> +			ret = IRQ_HANDLED;
> +		}
> +
> +		page = rdev_get_id(data->rdevs[i]);
> +		mutex_lock(&data->update_lock);
> +		status = pmbus_read_status_word(client, page);
> +		if (status < 0) {
> +			mutex_unlock(&data->update_lock);
> +			return status;
> +		}
> +
> +		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
> +			pmbus_clear_fault_page(client, page);
> +
> +		mutex_unlock(&data->update_lock);
> +	}
> +
> +	return ret;
> +}
> +
>  static int pmbus_regulator_register(struct pmbus_data *data)
>  {
>  	struct device *dev = data->dev;
>  	const struct pmbus_driver_info *info = data->info;
>  	const struct pmbus_platform_data *pdata = dev_get_platdata(dev);
> -	struct regulator_dev *rdev;
>  	int i;
>  
> +	data->rdevs = devm_kzalloc(dev, sizeof(struct regulator_dev *) * info->num_regulators,
> +				  GFP_KERNEL);
> +	if (!data->rdevs)
> +		return -ENOMEM;
> +
>  	for (i = 0; i < info->num_regulators; i++) {
>  		struct regulator_config config = { };
>  
> @@ -3077,21 +3142,71 @@ static int pmbus_regulator_register(struct pmbus_data *data)
>  		if (pdata && pdata->reg_init_data)
>  			config.init_data = &pdata->reg_init_data[i];
>  
> -		rdev = devm_regulator_register(dev, &info->reg_desc[i],
> +		data->rdevs[i] = devm_regulator_register(dev, &info->reg_desc[i],
>  					       &config);
> -		if (IS_ERR(rdev))
> -			return dev_err_probe(dev, PTR_ERR(rdev),
> +		if (IS_ERR(data->rdevs[i]))
> +			return dev_err_probe(dev, PTR_ERR(data->rdevs[i]),
>  					     "Failed to register %s regulator\n",
>  					     info->reg_desc[i].name);
>  	}
>  
>  	return 0;
>  }
> +
> +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
> +{
> +	struct device *dev = &client->dev;
> +	const struct pmbus_regulator_status_category *cat;
> +	const struct pmbus_regulator_status_assoc *bit;
> +	int i, j, err, ret;
> +	u8 mask;
> +	int func;
> +
> +	for (i = 0; i < data->info->pages; i++) {
> +		func = data->info->func[i];
> +
> +		for (j = 0; j < ARRAY_SIZE(pmbus_regulator_flag_map); j++) {
> +			cat = &pmbus_regulator_flag_map[i];
> +			if (!(func & cat->func))
> +				continue;
> +			mask = 0;
> +			for (bit = cat->bits; bit->pflag; bit++)
> +				mask |= bit->pflag;
> +
> +			err = pmbus_write_smbalert_mask(client, i, cat->reg, ~mask);
> +			if (err)
> +				dev_err(dev, "Failed to set smbalert for reg 0x%02x\n",	cat->reg);
> +		}
> +
> +		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_CML, 0xff);
> +		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_OTHER, 0xff);
> +		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_MFR_SPECIFIC, 0xff);
> +		if (data->info->func[i] & PMBUS_HAVE_FAN12)
> +			pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_FAN_12, 0xff);
> +		if (data->info->func[i] & PMBUS_HAVE_FAN34)
> +			pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_FAN_34, 0xff);
> +
> +	}
> +
> +	/* Register notifiers - can fail if IRQ is not given */
> +	ret = devm_request_threaded_irq(dev, client->irq, NULL, pmbus_fault_handler,
> +			      0, "pmbus-irq", data);
> +	if (ret) {
> +		dev_warn(dev, "IRQ disabled %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
>  #else
>  static int pmbus_regulator_register(struct pmbus_data *data)
>  {
>  	return 0;
>  }
> +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
> +{
> +	return 0;
> +}
>  #endif
>  
>  static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
> @@ -3456,6 +3571,12 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
>  	if (ret)
>  		return ret;
>  
> +	if (client->irq > 0) {
> +		ret = pmbus_irq_setup(client, data);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = pmbus_init_debugfs(client, data);
>  	if (ret)
>  		dev_warn(dev, "Failed to register debugfs\n");
> -- 
> 2.37.3
> 
