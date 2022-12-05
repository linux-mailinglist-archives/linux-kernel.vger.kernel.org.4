Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D7864236E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiLEHIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiLEHIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:08:04 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633B6DEAA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:07:59 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id a9so9977726pld.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 23:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCeYJurbgyO+nL655ExDiSNWRqYe0gXmml8lBML9H2U=;
        b=QEkIW2fRqUp2t4BkqsBbbHMkP0T61HngVh0rr9beqzdFbjIwAWVe/E/8fnHOqsXwcQ
         oswhEzvLSveFBupjfAtkgE+Q/kM/ZOVPIf0AwUlE99u7DtucVQ/qtsEcwPP5ZTJqHinV
         BCGUi8NsZwmtwxmClfy1Gp9moKg9UTVWM6DzTRgIwMCkRAVr7BtqGj2GXxoMmpE+Rg2/
         OhxiZlTBEfEvXH1f3sqvEe4JPY0FxGmgsw1y0fqP1AoYpk9IeOTDNRZKL3g9YaiD91JJ
         FF/rLqo0iEk9nLS+JK2uZLOEW3uq5KyMOId/EDE1f4RRHL23ZCnUYSR0dNlw/mveR7T7
         GWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCeYJurbgyO+nL655ExDiSNWRqYe0gXmml8lBML9H2U=;
        b=OU74uj7Kn+NXu6saSE9N6yVi8T0pNY6xN5ctVscQAYnURw8LxZ1rrPXCWBwUzq7QlN
         K304C2x7oDsaudnHrsBUxYHGLe+6C70E6yWbm80yRwGi8XG/MDRWCZURJH7Ta5BVKS7M
         NXbxmrDdHtj4B/EYeM6oaD8c97rspOFZ1EKQJ8r+KCQ+VbgmsFN5EAugeNVjwSrSZdLH
         h7YO5QnhLCTIG0MKqJwgEGx8HaKsmOhq2IS65pQ+wS8hdxV1gsFkGKe4hRGBi2AyI0ny
         Ff8DzAzxf4I2HtbGoaDPuxQSVIZE9k+n8M7HP398x1n85tkOctFomDeKs78y3vXSMeU+
         ICvQ==
X-Gm-Message-State: ANoB5plv9GM+7fXe1UaXkaJTaMx66cgaQDdnYoJUauUoAul7ZGz+inPB
        auDTwlyI4YxlUirfXWpoZv2w2g==
X-Google-Smtp-Source: AA0mqf6t87rDcq3fLtVfOimsu10TxjiC/3mJ3jlM2px6j+fTKTUCsybiqTvYhUgtKNO38goGbrZOPw==
X-Received: by 2002:a17:902:f707:b0:176:b0ce:3472 with SMTP id h7-20020a170902f70700b00176b0ce3472mr75856340plo.169.1670224078825;
        Sun, 04 Dec 2022 23:07:58 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e5ca00b00188f07c10c9sm9813900plf.192.2022.12.04.23.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 23:07:58 -0800 (PST)
Message-ID: <6b8dd272-1ccc-3d68-d8d5-15c9081e6313@9elements.com>
Date:   Mon, 5 Dec 2022 12:37:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 3/5] hwmon: (pmbus/core): Notify hwmon events
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221201193025.1584365-1-Naresh.Solanki@9elements.com>
 <20221201193025.1584365-3-Naresh.Solanki@9elements.com>
 <20221201201537.GC2110128@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221201201537.GC2110128@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter

On 02-12-2022 01:45 am, Guenter Roeck wrote:
> On Thu, Dec 01, 2022 at 08:30:22PM +0100, Naresh Solanki wrote:
>> Notify hwmon events using the pmbus irq handler.
>>
> 
> Unfortunately, as implemented, this only works if regulator support
> is enabled, which is unacceptable.
Will work on this to check all pages instead of regulators. I hope that 
is ok.

Regards,
Naresh
> 
> Guenter
> 
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   drivers/hwmon/pmbus/pmbus_core.c | 46 +++++++++++++++++++++++++++++---
>>   1 file changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>> index 6a3a3fd59b8e..ad3c0cc884a4 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -2782,7 +2782,35 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
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
>> +
>> +static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *error,
>> +				    bool notify)
>>   {
>>   	int i, status;
>>   	const struct pmbus_regulator_status_category *cat;
>> @@ -2812,6 +2840,9 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>   			if (status & bit->pflag)
>>   				*flags |= bit->rflag;
>>   		}
>> +
>> +		if (notify && status)
>> +			pmbus_notify(data, page, cat->reg, status);
>>   	}
>>   
>>   	/*
>> @@ -2856,6 +2887,11 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>   	return 0;
>>   }
>>   
>> +static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
>> +{
>> +	return pmbus_regulator_get_flags(rdev, flags, false);
>> +}
>> +
>>   static int pmbus_regulator_get_status(struct regulator_dev *rdev)
>>   {
>>   	struct device *dev = rdev_get_dev(rdev);
>> @@ -3087,7 +3123,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>>   {
>>   	struct pmbus_data *data = pdata;
>>   	struct i2c_client *client = to_i2c_client(data->dev);
>> -	int i, status;
>> +	int i, ret = IRQ_NONE, status;
>>   	u8 page;
>>   
>>   	for (i = 0; i < data->info->num_regulators; i++) {
>> @@ -3095,6 +3131,10 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>>   		if (!data->rdevs[i])
>>   			continue;
>>   
>> +		ret = pmbus_regulator_get_flags(data->rdevs[i], &status, true);
>> +		if (ret)
>> +			return ret;
>> +
>>   		page = rdev_get_id(data->rdevs[i]);
>>   		mutex_lock(&data->update_lock);
>>   		status = pmbus_read_status_word(client, page);
>> @@ -3109,7 +3149,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>>   		mutex_unlock(&data->update_lock);
>>   	}
>>   
>> -	return IRQ_HANDLED;
>> +	return ret;
>>   }
>>   
>>   static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
>> -- 
>> 2.37.3
>>
