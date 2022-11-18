Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF54162F44C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbiKRMLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbiKRMLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:11:14 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89A79AC94;
        Fri, 18 Nov 2022 04:10:52 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13be3ef361dso5661574fac.12;
        Fri, 18 Nov 2022 04:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOuXcYIWLATtdUwk8V09y+iwBKLEJSqVVImR++M8UIw=;
        b=TMUHkw3udH0LdFvhj414EMUF3h3ESNesBnSUCJ0pl6U2xdYUW5/dXRPs+ghwOV/maB
         +7ujvaY6sR43s0vIt3fhr7p6/KDfI4QHyCHLGMhAdJeTHV7xlWaXC6bbYisSy23vpZYI
         ZmTNwLv9uApLO8n5yLhCcWwYdeT2/3BNSFmKkR0AWjoY/QTnlfvr7zp6ALTuRkWOiLUj
         lz+XypJ04j9GABXF+QdAx4wcrbDwu8bo10SgRYhSTTx/500o2QvvAC83vR+VbxIT5vRK
         m2A3ym37nQJfvvgQzmH19XTdcKHku/X5fzcmMkNN8dzUEIqdxstdqq97hrYKylYv2YEX
         RK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOuXcYIWLATtdUwk8V09y+iwBKLEJSqVVImR++M8UIw=;
        b=0mUTia3/Cv1zArSrVN1gEbf7+ZzYCvh5Z4YVofa2ya1SbfFDHAB0ZtbOdQHXOiC2ij
         nVDzlNHP+cKpQerdwtqM+MKv57KKijwOqUb54m5SJGJ0rQ3cacqVoGdbNKEK+1sp7kMh
         2awKs1ZnhJWJYHf7Zqg2C+eZ7iRe08tGyHWqPI/FoRhx8bPC5eXm8Rlayl3EbsASXKVh
         heOyX6t+ANrqtasN9J89sIsdjMhY8UIepF/9fSl1ToPs8NSPjizVeOS+vCXB2qrvio2j
         5g81CQeAl+6l/grwdyXNMEQUxSQQS3mt0EyFMAxEMOqgJtOtvy8FUniw+FRGjBm6M2D/
         4FDw==
X-Gm-Message-State: ANoB5pl6amG3YvfHqX5V64r3bZhfGtZhtJeu+1t6RrtMdLuLA35DJZtE
        mo4AfXgy2Ao1ymQra7iyJkaFe9RruNI=
X-Google-Smtp-Source: AA0mqf55E4HZ26FehEQDDr3FZjotk/pnM1qEnVGunB+9NTWFiXLzNHM46sfEPAjPE6jUe2dfHk0oqA==
X-Received: by 2002:a05:6870:780e:b0:13b:a8da:6bd6 with SMTP id hb14-20020a056870780e00b0013ba8da6bd6mr3811500oab.268.1668773450891;
        Fri, 18 Nov 2022 04:10:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c2-20020a056830000200b006619533d1ddsm1443080otp.76.2022.11.18.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:10:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 18 Nov 2022 04:10:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: pm_bus: core: Implement regulator get_status
Message-ID: <20221118121049.GB3670981@roeck-us.net>
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
> ---

Please provide change logs.

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

I do not see the point of this lock here and elsewhere in this function.
If you want to ensure that the status is consistent, you would need to
hold the lock over the entire function, not repeatedly acquire and release
it. Even then there would be no guarantee that the status is consistent
because it can change anytime on the chip side.

> +	if (status < 0)
> +		return status;
> +
> +	if (status & (PB_STATUS_VIN_UV | PB_STATUS_IOUT_OC | PB_STATUS_VOUT_OV |
> +	    PB_STATUS_UNKNOWN))

Please align continuation lines with the matching '('.

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

Ok to avoid continuation lines as long as the result has less then 100
columns.

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
