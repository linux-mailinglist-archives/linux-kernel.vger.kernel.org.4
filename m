Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E20637405
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKXIew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKXIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:34:50 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88173CEB9C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:34:49 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q1so997730pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5ccKx8fizG4gCscMAGllzhhGT1asbD46ZbtRMN7NAQ=;
        b=NaWt9gAey74YX97MIcdsLCn1TP41z+UNuwg9OtGNLyX+60MqAG3WXZorgpUxG4fGR4
         tJPrYRQhsuMC9lfocuTF19x7DKZ1PVSx5CAScNk2LVDFBUdtNO5DJMaeY38/gAd2Nh3d
         DCIb1BSzCMukm/v/MgXpViy8d8f4Yjg8pUraZnFx8qkBagdpo/L3BAh9noM4WZx0vIt6
         8Rh90JIbrg2fOk763xeNf81wRGJtZzIYcKk1l2WaifDPfiig9YuNceghGkjs0h+mj1JG
         81h5JzuFYfeJZTXTQINku6Y2sK3J2imw2gTzHoQz5dkG7dM7FPR6XiQjQ4h9WK3HB51/
         gy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5ccKx8fizG4gCscMAGllzhhGT1asbD46ZbtRMN7NAQ=;
        b=ME3dc9J1F4jlvj8NEOSmNKopJJGVtFceUQbcCmJNJeOWBQJlZyB81QiQFYrKotMnY2
         pwhxuLo9WnmxAi4xyERbg21ErLZGM6jTEppWktA5ngyRCsX1roRlwiHTDfN7CoqP9POp
         uyMB9xvC/3vNfSH8VaiuB62IffByFuYxo9iXnMAylmsUTgbqsrv1vYgZhPr5akbGjeyw
         Ax26gpUdE6T7z29lAv8qgHVA8rnfaoJrUyciviqz9zllDzTZYIcRwMlrLVmDM9Yss1uu
         BUT6YDAMQtja07D8yfdU3f6+nTNQspD4w259txJN6PXvlSKxwIj+VarG5aY0tBhkD0fR
         2gPQ==
X-Gm-Message-State: ANoB5pk8UR8rFOq8bzfZU6DaKU3LCLgpa62i3p4vIRi0b+eLe+oz+59U
        lf3ZyaSH9mvNsp/eYInKvZwJ4w==
X-Google-Smtp-Source: AA0mqf4DAzzZjePiOdegknXnqqa9pAMSzXuDf5861QUnn4iLF0a1NGsDAmotvzNuKDt77HW+x7FFOg==
X-Received: by 2002:a62:6142:0:b0:56c:cde:1a49 with SMTP id v63-20020a626142000000b0056c0cde1a49mr13274150pfb.9.1669278888988;
        Thu, 24 Nov 2022 00:34:48 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id ne12-20020a17090b374c00b00218d55b33d9sm2759511pjb.8.2022.11.24.00.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 00:34:48 -0800 (PST)
Message-ID: <f158bc8a-8351-49a7-3246-91b8a1413ccd@9elements.com>
Date:   Thu, 24 Nov 2022 14:04:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] hwmon: (pmbus/core): Implement regulator get_status
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        broonie@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221122090302.3053092-1-Naresh.Solanki@9elements.com>
 <20221122184828.GA554748@roeck-us.net>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221122184828.GA554748@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 23-11-2022 12:18 am, Guenter Roeck wrote:
> On Tue, Nov 22, 2022 at 10:03:02AM +0100, Naresh Solanki wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Add get_status for pmbus_regulator_ops.
>> ---
>> Changes:
>> - use lock throughout the function
>> - Avoid line continuation upto 100 column
>> - Optimize use of & and | operator
>> - Check for VOUT, IOUT, TEMPERATURE bit in status word before checking
>>    respective status register for fault.
>> - Report regulator current status.
>> - Utilize get_error_flag to check for regulator errors.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   drivers/hwmon/pmbus/pmbus_core.c | 41 ++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>>
>> base-commit: 27fea302952d8c90cafbdbee96bafeca03544401
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>> index 7ec04934747e..5df2aee549e6 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -2851,6 +2851,46 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>   	return 0;
>>   }
>>   
>> +static int pmbus_regulator_get_status(struct regulator_dev *rdev)
>> +{
>> +	struct device *dev = rdev_get_dev(rdev);
>> +	struct i2c_client *client = to_i2c_client(dev->parent);
>> +	struct pmbus_data *data = i2c_get_clientdata(client);
>> +	u8 page = rdev_get_id(rdev);
>> +	int status, ret;
>> +
>> +	mutex_lock(&data->update_lock);
>> +	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
>> +	if (status < 0) {
>> +		ret = status;
>> +		goto unlock;
>> +	}
>> +
>> +	if (status & PB_STATUS_OFF) {
>> +		ret = REGULATOR_STATUS_OFF;
>> +		goto unlock;
>> +	}
>> +
>> +	/* If regulator is ON & reports power good then return ON */
>> +	if (!(status & PB_STATUS_POWER_GOOD_N)) {
>> +		ret = REGULATOR_STATUS_ON;
>> +		goto unlock;
>> +	}
>> +
>> +	if (rdev->desc->ops->get_error_flags)
>> +		ret = rdev->desc->ops->get_error_flags(rdev, &status);
>> +
> 
> What about checking ret ?
Fixed in next revision.
> 
>> +	if (status & (REGULATOR_ERROR_UNDER_VOLTAGE | REGULATOR_ERROR_OVER_CURRENT |
>> +	   REGULATOR_ERROR_REGULATION_OUT | REGULATOR_ERROR_FAIL | REGULATOR_ERROR_OVER_TEMP))
>> +		ret = REGULATOR_STATUS_ERROR;
>> +	else
>> +		ret = REGULATOR_STATUS_UNDEFINED;
> 
> This part has to be inside "if (rdev->desc->ops->get_error_flags)"
> or status will still contain the status word.
Yes. fixed in next version.
> 
> Guenter
> 
>> +
>> +unlock:
>> +	mutex_unlock(&data->update_lock);
>> +	return ret;
>> +}
>> +
>>   static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
>>   {
>>   	struct pmbus_data *data = i2c_get_clientdata(client);
>> @@ -2991,6 +3031,7 @@ const struct regulator_ops pmbus_regulator_ops = {
>>   	.disable = pmbus_regulator_disable,
>>   	.is_enabled = pmbus_regulator_is_enabled,
>>   	.get_error_flags = pmbus_regulator_get_error_flags,
>> +	.get_status = pmbus_regulator_get_status,
>>   	.get_voltage = pmbus_regulator_get_voltage,
>>   	.set_voltage = pmbus_regulator_set_voltage,
>>   	.list_voltage = pmbus_regulator_list_voltage,

Regards,
Naresh
