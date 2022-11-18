Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3980062F44E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiKRMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiKRMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:11:48 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6528F90388;
        Fri, 18 Nov 2022 04:11:46 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13bd19c3b68so5694894fac.7;
        Fri, 18 Nov 2022 04:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOQRmr5Zel5uhC4SPgt5MNw+32kmhutmrt94tWvKrlc=;
        b=nJek4fTYF+EuwKrz75Nn8iUYOa6bckGiVZLcMidzSI5QNrW3+hhVcwZyVl7F5mz3sS
         r4MGnVJKjte6xRJQUzevDr6uWFqzwHC+HUtw7r0xaeH1Sbv/RQpUO/fsS+JrdsjBKI+K
         /PheTMtEKUzZopzsDD+CCKCPYoX1vdm9Xo8PkNEC1OX0HZjgGqYFPvbpYznhylZq2WLT
         sD7HGuomFUe7wYusoQrF2kLPk4siXn+YgmjCgdECh4ZHZY3tKVy2hz8nBniAv0kIfD6g
         +ckv51r8KVTIA7vmTKjAaFAbRNpgqWFOX99gTK/5awKo6a5Njjxpt/ED+HGw3LT77sNM
         atRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOQRmr5Zel5uhC4SPgt5MNw+32kmhutmrt94tWvKrlc=;
        b=fmWMMGVW5BEosYPlpz/OuFmTI7nME4sQEzhF7hhCh+GxaXeD0F4b2fZDf2Vi54XR29
         GY/ioi2FOKJT0CNCylB2ErhtmFVwcnt26cRwggXDNsC1fL9U1H3jAm3ShlgC0GVk/7cl
         WMn66wXECi28YkqUb5O24ycKGdzFxXYli701n3wQJmyuY1n7cAXtHge+/tLWOONvbZi0
         Z3PJ7Ks7deLmxg1hJwAQGstUCznc1Wk0V+mZsa0bxSHPfZkmm5AWtx0PS0+PrvcfqYZt
         NsVAGfC4sZtdqyBQrWMv0ZzwwaOqNSYABdKdn1urZyLZR/mKS4Inv/J/fNKQxjYNwPEa
         W4mg==
X-Gm-Message-State: ANoB5pnkaeAGVuGZG+JMRb6xciZ7a6ZeRDh5lgb4QGMYHisBqf0wvroP
        ZQm13cCD3z8Vp6tK+673dSY=
X-Google-Smtp-Source: AA0mqf46anPt7eE40v9lvMb95+B0i9foom2F/4waHFHxG7eS21yFiDcJQXR+0tNeN9oe4MiQDDJ0QQ==
X-Received: by 2002:a05:6870:6692:b0:142:9c49:91f with SMTP id ge18-20020a056870669200b001429c49091fmr222410oab.111.1668773505669;
        Fri, 18 Nov 2022 04:11:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c23-20020a4ad8d7000000b0047f94999318sm1314792oov.29.2022.11.18.04.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:11:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 18 Nov 2022 04:11:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: pm_bus: core: Implement regulator get_status
Message-ID: <20221118121144.GC3670981@roeck-us.net>
References: <20221118084637.1973838-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118084637.1973838-1-Naresh.Solanki@9elements.com>
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

On Fri, Nov 18, 2022 at 09:46:36AM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add get_status for pmbus_regulator_ops.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Just noticed: The subject should start with "hwmon: (pmbus/core)"

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 72 ++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 7ec04934747e..5dde345c7679 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2851,6 +2851,77 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	return 0;
>  }
>  
> +static int pmbus_regulator_get_status(struct regulator_dev *rdev)
> +{
> +	struct device *dev = rdev_get_dev(rdev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	u8 page = rdev_get_id(rdev);
> +	int status, status2;
> +
> +	mutex_lock(&data->update_lock);
> +	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
> +	mutex_unlock(&data->update_lock);
> +	if (status < 0)
> +		return status;
> +
> +	if (status & (PB_STATUS_VIN_UV | PB_STATUS_IOUT_OC | PB_STATUS_VOUT_OV |
> +	    PB_STATUS_UNKNOWN))
> +		return REGULATOR_STATUS_ERROR;
> +
> +	if (status & (PB_STATUS_OFF | PB_STATUS_POWER_GOOD_N))
> +		return REGULATOR_STATUS_OFF;
> +
> +	if (status & PB_STATUS_VOUT &&
> +	    data->info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
> +		mutex_lock(&data->update_lock);
> +		status2 = _pmbus_read_byte_data(client, page,
> +					 PMBUS_STATUS_VOUT);
> +		mutex_unlock(&data->update_lock);
> +		if (status2 < 0)
> +			return status2;
> +		if (status2 & (PB_VOLTAGE_OV_FAULT | PB_VOLTAGE_UV_FAULT))
> +			return REGULATOR_STATUS_ERROR;
> +	}
> +	if (status & PB_STATUS_IOUT_POUT &&
> +	    data->info->func[page] & PMBUS_HAVE_STATUS_IOUT) {
> +		mutex_lock(&data->update_lock);
> +		status2 = _pmbus_read_byte_data(client, page,
> +						 PMBUS_STATUS_IOUT);
> +		mutex_unlock(&data->update_lock);
> +		if (status2 < 0)
> +			return status2;
> +		if (status2 & (PB_POUT_OP_FAULT | PB_IOUT_UC_FAULT |
> +		    PB_IOUT_OC_LV_FAULT | PB_IOUT_OC_FAULT))
> +			return REGULATOR_STATUS_ERROR;
> +	}
> +	if (status & PB_STATUS_INPUT &&
> +	    data->info->func[page] & PMBUS_HAVE_STATUS_INPUT) {
> +		mutex_lock(&data->update_lock);
> +		status2 = _pmbus_read_byte_data(client, page,
> +						 PMBUS_STATUS_INPUT);
> +		mutex_unlock(&data->update_lock);
> +		if (status2 < 0)
> +			return status2;
> +		if (status2 & (PB_IIN_OC_FAULT | PB_VOLTAGE_OV_FAULT |
> +		    PB_VOLTAGE_UV_FAULT))
> +			return REGULATOR_STATUS_ERROR;
> +	}
> +	if (status & PB_STATUS_TEMPERATURE &&
> +	    data->info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
> +		mutex_lock(&data->update_lock);
> +		status2 = _pmbus_read_byte_data(client, page,
> +						 PMBUS_STATUS_TEMPERATURE);
> +		mutex_unlock(&data->update_lock);
> +		if (status2 < 0)
> +			return status2;
> +		if (status2 & (PB_TEMP_UT_FAULT | PB_TEMP_OT_FAULT))
> +			return REGULATOR_STATUS_ERROR;
> +	}
> +
> +	return REGULATOR_STATUS_ON;
> +}
> +
>  static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
>  {
>  	struct pmbus_data *data = i2c_get_clientdata(client);
> @@ -2991,6 +3062,7 @@ const struct regulator_ops pmbus_regulator_ops = {
>  	.disable = pmbus_regulator_disable,
>  	.is_enabled = pmbus_regulator_is_enabled,
>  	.get_error_flags = pmbus_regulator_get_error_flags,
> +	.get_status = pmbus_regulator_get_status,
>  	.get_voltage = pmbus_regulator_get_voltage,
>  	.set_voltage = pmbus_regulator_set_voltage,
>  	.list_voltage = pmbus_regulator_list_voltage,
> 
> base-commit: 27fea302952d8c90cafbdbee96bafeca03544401
> -- 
> 2.37.3
> 
