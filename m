Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CE663F8D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiLAUNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiLAUNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:13:36 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7018A95BD;
        Thu,  1 Dec 2022 12:13:35 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id l127so3220669oia.8;
        Thu, 01 Dec 2022 12:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5dSRzfqfkSw8i/ZMVW5vMGtc7advrpGOhrJeSTbuFM=;
        b=m4ar5l5wjh38U7SAdbd/OfTAgQys8ufT1PooKqpmmDf2cr0xf7faLjbCSfMfkDgafx
         DZl0AB0IZ+nZaR/YsgV5hV1LGZm1VKOP8KrrrqhjhQ0bfCW1Zm6dpJI8WhrzKxCNbu9E
         IHNhQydT1UJirvLGzdZbKlOoleL4tCfuqGA8QCS+LOitZNx8U8zW/8xu+FEV4UTpFgyN
         31kOf9mUIBhrohoiqxcKbd337YYrc7fXUfyiRlRlBE53UJEfPqZMxoenq7uEDXxfw7b8
         xS6CLJLCJkjzum9hgABU1MmKd5IOAUXFoXzkQ8YG/J+Bc4fbQLzXDs4RcFVhEa1Yol51
         trmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5dSRzfqfkSw8i/ZMVW5vMGtc7advrpGOhrJeSTbuFM=;
        b=hlwasTgugdyp5mKRtotY2+PN8IvA0ILPnyhzFvEeZ8wZIR1eStDHncPqcGAqgdGo9Y
         xXnxLEl9SuAQNmsuDfRCXbvI1Qc0oz3zYxUtcvp4sw2GqvfcMI8vQlFjjVQzCeQo24Zv
         UG+QaaQwM+Bd9A9ZvJFOOk/5U+0uH01uA28L67+RGws7Dlt8YPaOLF33TJ2fvk8wWhdo
         4K/xwlWBV2BWTNOEPOY9C3g/e44fNRsdMC6lBeNUQddN9pE8bSCgzAewyiC9zYTI3OrO
         DdHRyhSykT3BwbNQuedx+qwHU17D7ENRD36UbTvOgiYpbmfFNKkP+GBAJ7W0fqRhGD3z
         P8iQ==
X-Gm-Message-State: ANoB5plEPR1C7BXjRoZaoOWzPdAoghlWlnRwtjiczAMRBKiz7TdmkvNZ
        yJiCaBfjwQyA4U3FBUhZUiM=
X-Google-Smtp-Source: AA0mqf7FGdJSLIdugU19QpcyffXtKiQtXa15K8pHvlHAl/JV0KZ5OgOkcRRetLCXgUwc6rypJzsEGg==
X-Received: by 2002:a05:6808:1456:b0:35a:e85d:ac25 with SMTP id x22-20020a056808145600b0035ae85dac25mr23118557oiv.293.1669925615152;
        Thu, 01 Dec 2022 12:13:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8-20020a056870b28800b0013bc40b09dasm3153093oao.17.2022.12.01.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 12:13:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 1 Dec 2022 12:13:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v5 2/5] hwmon: (pmbus/core): Add interrupt support
Message-ID: <20221201201333.GB2110128@roeck-us.net>
References: <20221201193025.1584365-1-Naresh.Solanki@9elements.com>
 <20221201193025.1584365-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201193025.1584365-2-Naresh.Solanki@9elements.com>
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

On Thu, Dec 01, 2022 at 08:30:21PM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Implement PMBUS irq handler.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/pmbus/pmbus.h      |  2 +-
>  drivers/hwmon/pmbus/pmbus_core.c | 89 ++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 1 deletion(-)
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
> index a95f998ca247..6a3a3fd59b8e 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -3077,11 +3077,94 @@ static int pmbus_regulator_register(struct pmbus_data *data)
>  
>  	return 0;
>  }
> +
> +static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
> +{
> +	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
> +}
> +
> +static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
> +{
> +	struct pmbus_data *data = pdata;
> +	struct i2c_client *client = to_i2c_client(data->dev);
> +	int i, status;
> +	u8 page;
> +
> +	for (i = 0; i < data->info->num_regulators; i++) {

This doesn't take into account situations where there is no regulator.
Remember, regulator support is optional. The entire code still completely
depends on regulator support.

> +
> +		if (!data->rdevs[i])
> +			continue;
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
> +	return IRQ_HANDLED;
> +}
> +
> +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
> +{
> +	struct device *dev = &client->dev;
> +	const struct pmbus_regulator_status_category *cat;
> +	const struct pmbus_regulator_status_assoc *bit;
> +	int i, j, err, ret, func;
> +	u8 mask;
> +
> +	for (i = 0; i < data->info->pages; i++) {
> +		func = data->info->func[i];
> +
> +		for (j = 0; j < ARRAY_SIZE(pmbus_regulator_flag_map); j++) {
> +			cat = &pmbus_regulator_flag_map[j];
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
> +
>  #else
>  static int pmbus_regulator_register(struct pmbus_data *data)
>  {
>  	return 0;
>  }
> +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
> +{
> +	return 0;
> +}

I understand that you really only care about regulator support,
but this is still unacceptable. Interrupt support is independent of
regulator support and needs to be handled as such.

Guenter

>  #endif
>  
>  static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
> @@ -3446,6 +3529,12 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
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
