Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50BB696639
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjBNONU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjBNOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:12:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19882820A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:12:17 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso7873709pjn.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBRSJ/850lpcvhrPddtFi8OtzyTgr3C1oIhbwpQOV+A=;
        b=LCxzmGGqVpvip3MreelaQGBlCqmmH9TfJAiwjirjXwHbejxi6zRdfpv+lDzCIzfBga
         u6c9uVt4gb+/uqzDdvBU4bAtW7P7QL1fcRsKRZtABoAqX0l86S4f3roLK6vWdwzesFTT
         YmtUqfMHVLdk5uVjAZehj5SxY5vmYpb7my/S34mh7PMmed0W1E0CbgVBVbDAweE1YBWH
         boNQmreGRWVWdM7H8psF8ns1+As0tek2eDDvrNYk5ylQOUBZSqipFC+hP2qcePtGBaRb
         C1KJloPtqXqa9QnvpGKUJy682EiNrA2QHyPJd+jZH+8njkc8VFmXnkyNH3EyBMVxNNR7
         QS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBRSJ/850lpcvhrPddtFi8OtzyTgr3C1oIhbwpQOV+A=;
        b=2fOPo/XPbh0Dw+/pLD6xlIKF/R/yJDRfJ76npctfN0TZXgl5HodPVlPwtBsK7vP9mH
         14LzEpk/Z6djUM8dAiBEvwTOWfXnWPdJm1uUqOY+o+gusvuemNo8x4VaNxdhPaoiX+MS
         Zt0Jf7LUEk+MFZRhAxArPQcB5ypLHzZXCJWSMOxcElKap/jdbPEainNTVS+10+Zndi7p
         8vBg5HZUEatCVeVEEinht9UK1lFfJ2K4M9YyX7B+O/cUnnDvXGdViylVYA0pTOJRyQRH
         +1uPI2as1feUq3CfD9ZjqT+u//ZNXJ+R+V8Vuju4spON+8Yy//1h2LS6TM2ntv1T5v1r
         mzpg==
X-Gm-Message-State: AO0yUKVofB5FISapwokZm0zjkskTpmIDgIIrIdIZPvKlKfej08N5Y+Lp
        EBxCFYG3mURIPPQtdsBI8RgybA==
X-Google-Smtp-Source: AK7set/A26k3GHX7cExFN9tZ63pti9KWqv9TNGokEqPmNb2E+2Jvf+KndRCaHcD1j1+QviGgJOl0EQ==
X-Received: by 2002:a17:902:b610:b0:19a:b6bf:1df6 with SMTP id b16-20020a170902b61000b0019ab6bf1df6mr1857528pls.20.1676383906881;
        Tue, 14 Feb 2023 06:11:46 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ee8a00b001992e74d058sm5588462pld.7.2023.02.14.06.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 06:11:46 -0800 (PST)
Message-ID: <102b8dfe-9779-da64-71c1-dc5bf998b4fe@9elements.com>
Date:   Tue, 14 Feb 2023 19:41:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/4] hwmon: (pmbus/core): Notify hwmon events
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230207120241.2800662-1-Naresh.Solanki@9elements.com>
 <20230207120241.2800662-4-Naresh.Solanki@9elements.com>
 <20230211154647.GA204954@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230211154647.GA204954@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-02-2023 09:16 pm, Guenter Roeck wrote:
> On Tue, Feb 07, 2023 at 01:02:41PM +0100, Naresh Solanki wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Notify hwmon events using the pmbus irq handler.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ...
>> Changes in V2
>> - Remove __maybe_unsed attribute as its not needed.
>> ---
>>   drivers/hwmon/pmbus/pmbus_core.c | 48 ++++++++++++++++++++++++++++----
>>   1 file changed, 43 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>> index d5403baad60a..f6778a9c7126 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -2735,8 +2735,36 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
>>   	},
>>   };
>>   
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
>> +static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags,
>> +			   bool notify)
>>   
>> -static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
>>   {
>>   	int i, status, ret;
>>   	const struct pmbus_status_category *cat;
>> @@ -2764,6 +2792,10 @@ static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsi
>>   			if (status & bit->pflag)
>>   				*flags |= bit->rflag;
>>   		}
>> +
>> +		if (notify && status)
>> +			pmbus_notify(data, page, cat->reg, status);
>> +
>>   	}
>>   
>>   	/*
>> @@ -2866,7 +2898,7 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>   	struct i2c_client *client = to_i2c_client(dev->parent);
>>   	struct pmbus_data *data = i2c_get_clientdata(client);
>>   
>> -	return pmbus_get_flags(data, rdev_get_id(rdev), flags);
>> +	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
>>   }
>>   
>>   static int pmbus_regulator_get_status(struct regulator_dev *rdev)
>> @@ -3108,10 +3140,14 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>>   {
>>   	struct pmbus_data *data = pdata;
>>   	struct i2c_client *client = to_i2c_client(data->dev);
>> -	int i, status;
>> +	int i, status, ret;
>>   
>> -	mutex_lock(&data->update_lock);
>>   	for (i = 0; i < data->info->pages; i++) {
>> +		ret = pmbus_get_flags(data, i, &status, true);
>> +		if (ret)
>> +			return ret;
>> +
>> +		mutex_lock(&data->update_lock);
> 
> You should introduce a locked version of pmbus_get_flags() and call
> that function, and keep the existing locking in place.
> 
I'm not sure if you meant to have pmbus_get_flags that wont use lock?

>>   		status = pmbus_read_status_word(client, i);
>>   		if (status < 0) {
>>   			mutex_unlock(&data->update_lock);
>> @@ -3120,8 +3156,10 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>>   
>>   		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
>>   			pmbus_clear_fault_page(client, i);
>> +
>> +		mutex_unlock(&data->update_lock);
>>   	}
>> -	mutex_unlock(&data->update_lock);
>> +
> 
> This would add a second empty line (not that it matters because the code
> should not change the locking in the first place).
> 
Will remove the new line
>>   
>>   	return IRQ_HANDLED;
>>   }
