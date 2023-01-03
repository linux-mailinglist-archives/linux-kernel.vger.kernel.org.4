Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4044465BAEF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbjACGtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbjACGtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:49:03 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F2ED2E5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:48:54 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so22365043pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 22:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOLjQ0SfRbtrkqrkch5GrcFqVEymhIn0qzHuKEHkf1Q=;
        b=LZVJleUqcS9hGd2mO/5kYqyLhUK6aAz8EoIMSHTEV/hKqLX2c+tFJ7xEKTK9dwp1pf
         sxBvE4iCfe8j62U1MFyUkgGZ8YtasuLKJiTiDsHuVG2VXJH7B5VZ1LdhUzALt39QBWYt
         pr+q7TvCuDOohyiPdRh5ZS11OBW9+mLaWXDUtjO22WmU9/opEGn90brNUG+p15t/rrYB
         2GVOoc94iKxHSYaf9HIb4eFG9mBsm1R2qp/zvbK8UCNkvIlmJIRSMgtgBTmoMjCFFvoH
         6++08abU/b5T58akos0kqQ7U9zOeue81gdkrfubt9br6LWVt96r5G6YCUcvBscfpDqTm
         4YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOLjQ0SfRbtrkqrkch5GrcFqVEymhIn0qzHuKEHkf1Q=;
        b=jp8fgt8njGpkJx+BYmQ6R69k+WDIaJauKDI+JadyB4uFL910Kb3TKt5bB6nJkAtAMZ
         cugFWj8BW/KCt1WuI8aHYS5jU3VUqHZVNY9HaKvIbWNAh4/y68FEopW0SUIbxYDvAttK
         CF1d1KJwf7IJu0pJYRvnuwvabctsXObbgUHqwRWLDvhKgq91Yp9F5/dQp9hMOJa4v7fP
         qpTZQvjBRTxARy5ywKkdRI5QKvdT36kQDcL7Xqr/wuuFexXUhtuSPeQcKUx9bnzvsWko
         XckOi4TZrUcIXWVmHJfBWePsIZIvgTie0qD41kqdiGwUkK7dqbKuhctoJ0t8aR8mqnPW
         xtZA==
X-Gm-Message-State: AFqh2ko8PQsqoc4Ndy/QogpE+jswsYbj0AifaZqGBBAnYyejwdtamb2j
        SzSxOLvK3fwgydmus3iMeCZLzw==
X-Google-Smtp-Source: AMrXdXsHVE6HtwVk072XLAae1liRFjKuG7KJEPnrZ3RC0q6EnP4sbgc4CFRNh+egRlk/B2qxfNeg1g==
X-Received: by 2002:a17:90a:a788:b0:219:9a7b:b6a8 with SMTP id f8-20020a17090aa78800b002199a7bb6a8mr47008451pjq.32.1672728533730;
        Mon, 02 Jan 2023 22:48:53 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090a3f8a00b002195819d541sm20402551pjc.8.2023.01.02.22.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 22:48:53 -0800 (PST)
Message-ID: <ecdf887d-d2c8-d9d4-ab19-3b30ee1d4607@9elements.com>
Date:   Tue, 3 Jan 2023 12:18:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND v6 1/5] hwmon: (pmbus/core): Add interrupt support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221214080715.2700442-1-Naresh.Solanki@9elements.com>
 <20221229144012.GA21213@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221229144012.GA21213@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 29-12-2022 08:10 pm, Guenter Roeck wrote:
> On Wed, Dec 14, 2022 at 09:07:11AM +0100, Naresh Solanki wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Implement PMBUS irq handler.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> $ scripts/checkpatch.pl --strict index.html
> CHECK: Blank lines aren't necessary after an open brace '{'
> #131: FILE: drivers/hwmon/pmbus/pmbus_core.c:3088:
> +	for (i = 0; i < data->info->pages; i++) {
> +
> 
> CHECK: Alignment should match open parenthesis
> #183: FILE: drivers/hwmon/pmbus/pmbus_core.c:3140:
> +	ret = devm_request_threaded_irq(dev, client->irq, NULL, pmbus_fault_handler,
> +			      0, "pmbus-irq", data);
> 
> CHECK: Please use a blank line after function/struct/union/enum declarations
> #197: FILE: drivers/hwmon/pmbus/pmbus_core.c:3154:
>   }
> +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
> 
> total: 0 errors, 0 warnings, 3 checks, 109 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>        mechanically convert to the typical style using --fix or --fix-inplace.
> 
> index.html has style problems, please review.
> 
> Please run checkpatch --strict on your patches.
> Also see Documentation/hwmon/submitting-patches.rst.
I will take care of these errors in the updated version.
> 
>> ---
>>   drivers/hwmon/pmbus/pmbus.h      |  2 +-
>>   drivers/hwmon/pmbus/pmbus_core.c | 84 ++++++++++++++++++++++++++++++++
>>   2 files changed, 85 insertions(+), 1 deletion(-)
>>
>>
>> base-commit: 364ffd2537c44cb6914ff5669153f4a86fffad29
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
>> index 10fb17879f8e..6b2e6cf93b19 100644
>> --- a/drivers/hwmon/pmbus/pmbus.h
>> +++ b/drivers/hwmon/pmbus/pmbus.h
>> @@ -26,7 +26,7 @@ enum pmbus_regs {
>>   
>>   	PMBUS_CAPABILITY		= 0x19,
>>   	PMBUS_QUERY			= 0x1A,
>> -
>> +	PMBUS_SMBALERT_MASK		= 0x1B,
>>   	PMBUS_VOUT_MODE			= 0x20,
>>   	PMBUS_VOUT_COMMAND		= 0x21,
>>   	PMBUS_VOUT_TRIM			= 0x22,
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>> index 95e95783972a..244fd2597252 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -3072,11 +3072,89 @@ static int pmbus_regulator_register(struct pmbus_data *data)
>>   
>>   	return 0;
>>   }
>> +
>> +static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
>> +{
>> +	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
>> +}
>> +
>> +static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>> +{
>> +	struct pmbus_data *data = pdata;
>> +	struct i2c_client *client = to_i2c_client(data->dev);
>> +	int i, status;
>> +
>> +	for (i = 0; i < data->info->pages; i++) {
>> +
>> +		mutex_lock(&data->update_lock);
>> +		status = pmbus_read_status_word(client, i);
>> +		if (status < 0) {
>> +			mutex_unlock(&data->update_lock);
>> +			return status;
>> +		}
>> +
>> +		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
>> +			pmbus_clear_fault_page(client, i);
>> +
>> +		mutex_unlock(&data->update_lock);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
>> +{
>> +	struct device *dev = &client->dev;
>> +	const struct pmbus_regulator_status_category *cat;
>> +	const struct pmbus_regulator_status_assoc *bit;
>> +	int i, j, err, ret, func;
>> +	u8 mask;
>> +
>> +	for (i = 0; i < data->info->pages; i++) {
>> +		func = data->info->func[i];
>> +
>> +		for (j = 0; j < ARRAY_SIZE(pmbus_regulator_flag_map); j++) {
>> +			cat = &pmbus_regulator_flag_map[j];
>> +			if (!(func & cat->func))
>> +				continue;
>> +			mask = 0;
>> +			for (bit = cat->bits; bit->pflag; bit++)
>> +				mask |= bit->pflag;
>> +
>> +			err = pmbus_write_smbalert_mask(client, i, cat->reg, ~mask);
>> +			if (err)
>> +				dev_err(dev, "Failed to set smbalert for reg 0x%02x\n",	cat->reg);
> 
> This concerns me. It might mean that the chip does not support
> PMBUS_SMBALERT_MASK. If so, there would be lots of error messages.
After going through the PMBus specification, it appears that this should 
not be an issue unless there is a violation of the specification.
> 
>> +		}
>> +
>> +		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_CML, 0xff);
>> +		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_OTHER, 0xff);
>> +		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_MFR_SPECIFIC, 0xff);
> 
> Why check the return value from pmbus_write_smbalert_mask above but not here ?
Thank you for pointing out the oversight. I will make sure to include an 
error check at this point.
> 
>> +		if (data->info->func[i] & PMBUS_HAVE_FAN12)
>> +			pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_FAN_12, 0xff);
>> +		if (data->info->func[i] & PMBUS_HAVE_FAN34)
>> +			pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_FAN_34, 0xff);
>> +	}
>> +
>> +	/* Register notifiers - can fail if IRQ is not given */
> 
> The comment does not make sense. pmbus_irq_setup() is not called
> if the interrupt "is not given".
Yes. The comment here is not relevant and will be removed.
> 
>> +	ret = devm_request_threaded_irq(dev, client->irq, NULL, pmbus_fault_handler,
>> +			      0, "pmbus-irq", data);
>> +	if (ret) {
>> +		dev_warn(dev, "IRQ disabled %d\n", ret);
> 
> This is not a warning, it is an error.
Thank you for bringing this to my attention. I will make sure to update 
the code to reflect that this is an error.
> 
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   #else
> 
> This is still in regulator code. I said several times that this is not
> acceptable.
Thank you for pointing out the mistake. I will make sure to correct this 
in the next revision.
> 
>>   static int pmbus_regulator_register(struct pmbus_data *data)
>>   {
>>   	return 0;
>>   }
>> +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
>> +{
>> +	return 0;
>> +}
>>   #endif
>>   
>>   static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
>> @@ -3441,6 +3519,12 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
>>   	if (ret)
>>   		return ret;
>>   
>> +	if (client->irq > 0) {
>> +		ret = pmbus_irq_setup(client, data);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	ret = pmbus_init_debugfs(client, data);
>>   	if (ret)
>>   		dev_warn(dev, "Failed to register debugfs\n");

Thanks,
Naresh
