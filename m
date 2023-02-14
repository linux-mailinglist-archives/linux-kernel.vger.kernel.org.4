Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB8C696627
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjBNOLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjBNOKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:10:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA942A6CF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:10:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so15515314pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SNoRludrH/PJjk5Y5xKstKJ+4uWUyNdaH6r2On2qtI=;
        b=F0AzO/XxmHH/U+Y6ZCGR5/4KiatqCa2jfIEP19JvAcfnJThRei+GtGpQfvwGi9hNFO
         Od7K/jbZJ0xyaQHa09+ppTYoRojxQXs/Mg2CdINbyyzfcQ4n6DcUpBsXQuo50G/cpXT/
         ki4jfu2d3wwhYt9Rg+E938DfMnk0bLIy1NSqe15B5lCaRLSGmTjnrhFyNt4urZjqThe7
         yjELh2O+ELXJjB0rj5nk9/wBnYBG33NnN9fwtc2YLGouLHiN/dfvqnowAIi7WIPiK0h3
         e4LE2YomQ2lzZr6Kcc4U7Z0VjbmOwM5WsSRAUtw38VNsT2CaZgpMTyrmhRlb/dPdluM7
         UBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SNoRludrH/PJjk5Y5xKstKJ+4uWUyNdaH6r2On2qtI=;
        b=7XYrDRLjkvgiRhtI8neJPyQNrQdDadTkeOsDg0tSRy1C2T+/LOrLrLORATWGQ/FJj1
         ZhqqJCaFhzIfGctM+0pWqwGwYeX4AIq26osxu1OoXKmdkMoUmmMdevtJfY9pHngsCkIh
         goIkHaGWB/tnRWqgKxAc6/Wy1qbiX6fFv8/TK1daqcEtO8Lc4Nwn9x+WqHocb4oQXyBn
         oRiwd+789xZiRLERG2w+47kExgGTN719d7hmuiAlYSlRKJbsYHxeJQ1KinbrAWtlnUW8
         xaqg8FVFtIHt+kX02XLqxkuLp71qtLHOiyOQHfZr9o0ZfoXclH1/CJbzIsww3n60zgU+
         B1Lw==
X-Gm-Message-State: AO0yUKU9WW1d7yLGpcqBhhAVWUYYMdS22+JqzrdkBFD0UfB4cJWM6zGq
        JPGbhLUKVkTe/bo/9xo8b/sjQQ==
X-Google-Smtp-Source: AK7set8O+20iiTXGKTzhTlkNDJ3dnEDlvQ9/j4Tna9w8k4JZ7aQ6ZLMGwErqrU3lR5548sP/EIvhSg==
X-Received: by 2002:a17:902:db05:b0:199:15bb:8320 with SMTP id m5-20020a170902db0500b0019915bb8320mr3475650plx.31.1676383815847;
        Tue, 14 Feb 2023 06:10:15 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b001947ba0ac8fsm10216459plr.236.2023.02.14.06.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 06:10:15 -0800 (PST)
Message-ID: <b6709234-d83a-689f-3d23-753d390b765e@9elements.com>
Date:   Tue, 14 Feb 2023 19:40:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/4] hwmon: (pmbus/core) Generalise pmbus get status
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230207120241.2800662-1-Naresh.Solanki@9elements.com>
 <20230207120241.2800662-2-Naresh.Solanki@9elements.com>
 <20230211150749.GA202703@roeck-us.net>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230211150749.GA202703@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 11-02-2023 08:37 pm, Guenter Roeck wrote:
> On Tue, Feb 07, 2023 at 01:02:39PM +0100, Naresh Solanki wrote:
>> Add function pmbus get status that can be used to get both pmbus
>> specific status & regulator status
>>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ...
>> Changes in V2:
>> - Add __maybe_unused attribute for pmbus_get_status function
>> - Remove unrelated changes
>> ---
>>   drivers/hwmon/pmbus/pmbus_core.c | 118 +++++++++++++++++--------------
>>   1 file changed, 66 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>> index 1b70cf3be313..5ccae8126a56 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -2735,61 +2735,14 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
>>   	},
>>   };
>>   
>> -#if IS_ENABLED(CONFIG_REGULATOR)
>> -static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
>> -{
>> -	struct device *dev = rdev_get_dev(rdev);
>> -	struct i2c_client *client = to_i2c_client(dev->parent);
>> -	struct pmbus_data *data = i2c_get_clientdata(client);
>> -	u8 page = rdev_get_id(rdev);
>> -	int ret;
>> -
>> -	mutex_lock(&data->update_lock);
>> -	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
>> -	mutex_unlock(&data->update_lock);
>> -
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	return !!(ret & PB_OPERATION_CONTROL_ON);
>> -}
>> -
>> -static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
>> -{
>> -	struct device *dev = rdev_get_dev(rdev);
>> -	struct i2c_client *client = to_i2c_client(dev->parent);
>> -	struct pmbus_data *data = i2c_get_clientdata(client);
>> -	u8 page = rdev_get_id(rdev);
>> -	int ret;
>> -
>> -	mutex_lock(&data->update_lock);
>> -	ret = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
>> -				     PB_OPERATION_CONTROL_ON,
>> -				     enable ? PB_OPERATION_CONTROL_ON : 0);
>> -	mutex_unlock(&data->update_lock);
>> -
>> -	return ret;
>> -}
>> -
>> -static int pmbus_regulator_enable(struct regulator_dev *rdev)
>> -{
>> -	return _pmbus_regulator_on_off(rdev, 1);
>> -}
>> -
>> -static int pmbus_regulator_disable(struct regulator_dev *rdev)
>> -{
>> -	return _pmbus_regulator_on_off(rdev, 0);
>> -}
>>   
>> -static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
>> +static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
>>   {
>> -	int i, status;
>> +	int i, status, ret;
>>   	const struct pmbus_status_category *cat;
>>   	const struct pmbus_status_assoc *bit;
>> -	struct device *dev = rdev_get_dev(rdev);
>> -	struct i2c_client *client = to_i2c_client(dev->parent);
>> -	struct pmbus_data *data = i2c_get_clientdata(client);
>> -	u8 page = rdev_get_id(rdev);
>> +	struct device *dev = data->dev;
>> +	struct i2c_client *client = to_i2c_client(dev);
>>   	int func = data->info->func[page];
>>   
>>   	*flags = 0;
>> @@ -2827,7 +2780,13 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>   	if (status < 0)
>>   		return status;
>>   
>> -	if (pmbus_regulator_is_enabled(rdev)) {
>> +	mutex_lock(&data->update_lock);
>> +	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
>> +	mutex_unlock(&data->update_lock);
>> +	if (ret < 0)
>> +		return status;
>> +
>> +	if (ret & PB_OPERATION_CONTROL_ON) {
> 
> This code is now executed twice. Please keep the original function,
> just rename it to pmbus_is_enabled() or similar, then call it from
> pmbus_regulator_is_enabled() which then just needs to adjust the
> parameter (and maybe pass 'dev' as argument).
> 
Sure
>>   		if (status & PB_STATUS_OFF)
>>   			*flags |= REGULATOR_ERROR_FAIL;
>>   
>> @@ -2855,6 +2814,61 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>   	return 0;
>>   }
>>   
>> +#if IS_ENABLED(CONFIG_REGULATOR)
>> +static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
>> +{
>> +	struct device *dev = rdev_get_dev(rdev);
>> +	struct i2c_client *client = to_i2c_client(dev->parent);
>> +	struct pmbus_data *data = i2c_get_clientdata(client);
>> +	u8 page = rdev_get_id(rdev);
>> +	int ret;
>> +
>> +	mutex_lock(&data->update_lock);
>> +	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
>> +	mutex_unlock(&data->update_lock);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return !!(ret & PB_OPERATION_CONTROL_ON);
> 
> This could then be as simple as
> 
> 	return pmbus_is_enabled(rdev_get_dev(rdev));
> 
Sure
> Thanks,
> Guenter
> 
>> +}
>> +
>> +static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
>> +{
>> +	struct device *dev = rdev_get_dev(rdev);
>> +	struct i2c_client *client = to_i2c_client(dev->parent);
>> +	struct pmbus_data *data = i2c_get_clientdata(client);
>> +	u8 page = rdev_get_id(rdev);
>> +	int ret;
>> +
>> +	mutex_lock(&data->update_lock);
>> +	ret = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
>> +				     PB_OPERATION_CONTROL_ON,
>> +				     enable ? PB_OPERATION_CONTROL_ON : 0);
>> +	mutex_unlock(&data->update_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int pmbus_regulator_enable(struct regulator_dev *rdev)
>> +{
>> +	return _pmbus_regulator_on_off(rdev, 1);
>> +}
>> +
>> +static int pmbus_regulator_disable(struct regulator_dev *rdev)
>> +{
>> +	return _pmbus_regulator_on_off(rdev, 0);
>> +}
>> +
>> +static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
>> +{
>> +	struct device *dev = rdev_get_dev(rdev);
>> +	struct i2c_client *client = to_i2c_client(dev->parent);
>> +	struct pmbus_data *data = i2c_get_clientdata(client);
>> +
>> +	return pmbus_get_flags(data, rdev_get_id(rdev), flags);
>> +}
>> +
>>   static int pmbus_regulator_get_status(struct regulator_dev *rdev)
>>   {
>>   	struct device *dev = rdev_get_dev(rdev);
