Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4EF65BAFB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbjACGyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbjACGyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:54:15 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDF35F7F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:54:14 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p4so32031285pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 22:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Opo/Hg1HYv0dDEG3+YYjERBKK4XAeSo3rsEnyl3wq8I=;
        b=OLda5p2x3pWZwojHIMVHz86YQeongl6IVl/K1+Dy2BiazBgEHvjxz7Wdh1WRL7GKKW
         6ZbjR733IbfmHVRBQjPLNBejk+aNbdv6E/lAzBDdzdGQZerTCx/HX2mFLtW2y7nn1izm
         6p3yVodaYkeF9uisFOShByR1+bW/qCvPx07vWnAHLUmNBryczjzropqEQwLyZvZ583Vk
         60XxdeglM2GzOUoQ7h9I2QO59zrgC43PubfJR5HM+6eP9aECrBA8n2k/v1/rwdNiiCYe
         4BMGjgAxCwmiqG4U1m8+3PCnjlnr8G8K74Ecbddc+qBxyJ3OmNXceD3JgQEXDLr+ttpO
         YfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Opo/Hg1HYv0dDEG3+YYjERBKK4XAeSo3rsEnyl3wq8I=;
        b=AjeY6C4QK8BhC1qoUEsVQhy0+3MhIljlvUBG/WzZzE0KqNpVLU/yw2v2f28OAszaje
         94G3nm7QBx60ZdzENNpR2ZZb46PMHn0sb6vv+hlc9J5hmzwu7INRJ3lNBaNhJebXlaWB
         WoK85PrXCyOq4cONs7XfubUCiKst6DrZ2z3j/v1QgROqvoHXkNLOFqc0RP2VEYJLpYe0
         aSeBEb4DoUCkWBfKQWYINnqTvX/WjrCGnL2udMmAFkwAvOapJ0JNm/EUVEO4WHgSqejq
         WeGuUMIVFQCYMVBfrwv07Zm78xFdfFqcJU0MBBgLjhn8+gnk2p7ATW7iVW7jOTI/uPDR
         07gQ==
X-Gm-Message-State: AFqh2ko1y6UFEyWg7O1Of5pmq7ph5vUhfxcSpySGMNZ76hyI6I9FLNIl
        Lzl7CMdk/P5uxGs4OkbXyaWtRg==
X-Google-Smtp-Source: AMrXdXsa2YsxSfHS5kt+4CgStOyp1YDc5nAaBrJmNUL+Z4Q1KjV8y85Zmgpkbg42G2rRlfYQfi4QLA==
X-Received: by 2002:a17:90a:540a:b0:219:9da5:40d3 with SMTP id z10-20020a17090a540a00b002199da540d3mr45781219pjh.1.1672728853709;
        Mon, 02 Jan 2023 22:54:13 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090a2a0f00b00225e670e4c7sm14125822pjd.35.2023.01.02.22.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 22:54:13 -0800 (PST)
Message-ID: <37782482-1441-6be0-e66c-0e8c344d2368@9elements.com>
Date:   Tue, 3 Jan 2023 12:24:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND v6 2/5] hwmon: (pmbus/core): Notify hwmon events
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221214080715.2700442-1-Naresh.Solanki@9elements.com>
 <20221214080715.2700442-2-Naresh.Solanki@9elements.com>
 <20221229144643.GA21642@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221229144643.GA21642@roeck-us.net>
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

On 29-12-2022 08:16 pm, Guenter Roeck wrote:
> On Wed, Dec 14, 2022 at 09:07:12AM +0100, Naresh Solanki wrote:
>> Notify hwmon events using the pmbus irq handler.
>>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   drivers/hwmon/pmbus/pmbus_core.c | 95 ++++++++++++++++++++++++--------
>>   1 file changed, 72 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>> index 244fd2597252..b005a1c8ad7e 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -2781,18 +2781,43 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>>   	},
>>   };
>>   
>> -static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
>> +#define to_dev_attr(_dev_attr) \
>> +	container_of(_dev_attr, struct device_attribute, attr)
>> +
>> +static void pmbus_notify(struct pmbus_data *data, int page, int reg, int flags)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < data->num_attributes; i++) {
>> +		struct device_attribute *da = to_dev_attr(data->group.attrs[i]);
>> +		struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>> +		int index = attr->index;
>> +		u16 smask = pb_index_to_mask(index);
>> +		u8 spage = pb_index_to_page(index);
>> +		u16 sreg = pb_index_to_reg(index);
>> +
>> +		if (reg == sreg && page == spage && (smask & flags)) {
>> +			dev_dbg(data->dev, "sysfs notify: %s", da->attr.name);
>> +			sysfs_notify(&data->dev->kobj, NULL, da->attr.name);
>> +			kobject_uevent(&data->dev->kobj, KOBJ_CHANGE);
>> +			flags &= ~smask;
>> +		}
>> +
>> +		if (!flags)
>> +			break;
>> +	}
>> +}
> 
> Interrupt aupport as well as sysfs and kobject notifications are not
> regulator specific and do not depend on regulator support. It has to be
> independent of regulator support, meaning it must also work if regulator
> support is disabled.
> 
> I seem to have trouble expressing myself, but I don't know how else to say
> it, sorry.
> 
> It doesn't make sense to review the series further until this is addressed.
I understand your concern about the independence of the interrupt 
support, sysfs, and kobject notifications from the regulator support. I 
will make sure to address this issue and ensure that these features work 
regardless of whether regulator support is enabled or disabled in the 
next revision. Thank you for your patience and for your feedback.
I will make sure to address your concerns.
> 
> Guenter
> 
>> +
>> +static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error,
>> +				    bool notify)
>>   {
>> -	int i, status;
>>   	const struct pmbus_regulator_status_category *cat;
>>   	const struct pmbus_regulator_status_assoc *bit;
>> -	struct device *dev = rdev_get_dev(rdev);
>> -	struct i2c_client *client = to_i2c_client(dev->parent);
>> -	struct pmbus_data *data = i2c_get_clientdata(client);
>> -	u8 page = rdev_get_id(rdev);
>> +	struct i2c_client *client = to_i2c_client(data->dev);
>>   	int func = data->info->func[page];
>> +	int i, status, ret;
>>   
>> -	*flags = 0;
>> +	*error = 0;
>>   
>>   	mutex_lock(&data->update_lock);
>>   
>> @@ -2803,14 +2828,17 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>   
>>   		status = _pmbus_read_byte_data(client, page, cat->reg);
>>   		if (status < 0) {
>> -			mutex_unlock(&data->update_lock);
>> -			return status;
>> +			ret = status;
>> +			goto unlock;
>>   		}
>>   
>>   		for (bit = cat->bits; bit->pflag; bit++) {
>>   			if (status & bit->pflag)
>> -				*flags |= bit->rflag;
>> +				*error |= bit->rflag;
>>   		}
>> +
>> +		if (notify && status)
>> +			pmbus_notify(data, page, cat->reg, status);
>>   	}
>>   
>>   	/*
>> @@ -2823,36 +2851,53 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>   	 * REGULATOR_ERROR_<foo>_WARN.
>>   	 */
>>   	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
>> -	mutex_unlock(&data->update_lock);
>> -	if (status < 0)
>> -		return status;
>>   
>> -	if (pmbus_regulator_is_enabled(rdev)) {
>> +	if (status < 0) {
>> +		ret = status;
>> +		goto unlock;
>> +	}
>> +
>> +	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
>> +	if (ret < 0)
>> +		goto unlock;
>> +
>> +	if (ret & PB_OPERATION_CONTROL_ON) {
>>   		if (status & PB_STATUS_OFF)
>> -			*flags |= REGULATOR_ERROR_FAIL;
>> +			*error |= REGULATOR_ERROR_FAIL;
>>   
>>   		if (status & PB_STATUS_POWER_GOOD_N)
>> -			*flags |= REGULATOR_ERROR_REGULATION_OUT;
>> +			*error |= REGULATOR_ERROR_REGULATION_OUT;
>>   	}
>>   	/*
>>   	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
>>   	 * defined strictly as fault indicators (not warnings).
>>   	 */
>>   	if (status & PB_STATUS_IOUT_OC)
>> -		*flags |= REGULATOR_ERROR_OVER_CURRENT;
>> +		*error |= REGULATOR_ERROR_OVER_CURRENT;
>>   	if (status & PB_STATUS_VOUT_OV)
>> -		*flags |= REGULATOR_ERROR_REGULATION_OUT;
>> +		*error |= REGULATOR_ERROR_REGULATION_OUT;
>>   
>>   	/*
>>   	 * If we haven't discovered any thermal faults or warnings via
>>   	 * PMBUS_STATUS_TEMPERATURE, map PB_STATUS_TEMPERATURE to a warning as
>>   	 * a (conservative) best-effort interpretation.
>>   	 */
>> -	if (!(*flags & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
>> +	if (!(*error & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
>>   	    (status & PB_STATUS_TEMPERATURE))
>> -		*flags |= REGULATOR_ERROR_OVER_TEMP_WARN;
>> +		*error |= REGULATOR_ERROR_OVER_TEMP_WARN;
>>   
>> -	return 0;
>> +unlock:
>> +	mutex_unlock(&data->update_lock);
>> +	return ret;
>> +}
>> +
>> +static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
>> +{
>> +	struct device *dev = rdev_get_dev(rdev);
>> +	struct i2c_client *client = to_i2c_client(dev->parent);
>> +	struct pmbus_data *data = i2c_get_clientdata(client);
>> +
>> +	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
>>   }
>>   
>>   static int pmbus_regulator_get_status(struct regulator_dev *rdev)
>> @@ -3082,10 +3127,14 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>>   {
>>   	struct pmbus_data *data = pdata;
>>   	struct i2c_client *client = to_i2c_client(data->dev);
>> -	int i, status;
>> +	int i, status, ret;
>>   
>>   	for (i = 0; i < data->info->pages; i++) {
>>   
>> +		ret = pmbus_get_flags(data, i, &status, true);
>> +		if (ret)
>> +			return ret;
>> +
>>   		mutex_lock(&data->update_lock);
>>   		status = pmbus_read_status_word(client, i);
>>   		if (status < 0) {
>> @@ -3099,7 +3148,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>>   		mutex_unlock(&data->update_lock);
>>   	}
>>   
>> -	return IRQ_HANDLED;
>> +	return ret;
>>   }
>>   
>>   static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
Regards,
Naresh
