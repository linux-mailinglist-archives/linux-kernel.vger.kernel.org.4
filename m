Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51478638DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKYPy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKYPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:53:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8774E41D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:53:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so4529532pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYfMzw73P2ZTE4erKf0oRE4JXO8TGT0pLdCv47o+7Ro=;
        b=C+UZC8GQ+3YDoZrUhynpidwz0okF1CFer34cxZ7Uz6oNwmnoKssxbWowVGUM8XSRSV
         JfBjqH7Epc4k6d4TK1otKJe45Zjnjw9flS1O83qQQ79H/mK5hDDQ1ln0Z/P3MN4nkVfD
         uPCor9Cbx6SmBgcGipOtl50LH3ARKiIUXWD5acuUj1qG3b04tKAn9OgfgEYdqwibl5s/
         BuHLXwQUlN0HCxVy1SR5rWlcBV031+enrlp9qyG3mNgYysvCihfnHeM4OlNMWPxZJxPE
         ivj0S5wmDxKIEOAPKAJ/4Eku8GuU1vZnkhVFpInybAxQlCgu64V+HJJI6HsstWTvTAi8
         IOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYfMzw73P2ZTE4erKf0oRE4JXO8TGT0pLdCv47o+7Ro=;
        b=lpgCVC2/PecPovJPoB6DPLnRN5ZNVA49a8W3FM+x5mjo6Shl7hJZyuFAqKff9UsA/O
         fi3KYHs6aLewB12NGtnB0MVinmVd1E1cPBU8OacixbbeMt3xb9khUhhNyfR2ayHAHyx4
         Wrdp/z/pNp49I3isH5AwR4NGtFbnZahKV3loUSYEIRXfM6EYF/NfF4CAo+ktP1qBAnGu
         2qdHhsg2Xq7WV8GC+hbywU0Hn3ofKKYNPpiJNgfUod3VllYiz1Fsvz2d8RHD0Zd1VZan
         wW2BzTgXZ4MnZWiOePfBdDXu7rf6wzS3iuLOdo5OZq6kMls8n2tHLWWS3jjvzPivXF/B
         uJFA==
X-Gm-Message-State: ANoB5pnZ+n2u88XuyF8rbjhfiiPXLQ8hBzwBpoLrKw1/hUC/nvg2+vld
        EVtMZfF8UmsJe4StvMQ3tQ5ciw==
X-Google-Smtp-Source: AA0mqf4YKB2Wr4v1Yhd5DschGfv1FrGPcMHeuojopE0gmxV6aZILHPpYfB8iqjFiduhlGc8JwI//MA==
X-Received: by 2002:a17:902:ee55:b0:189:69cf:9ea0 with SMTP id 21-20020a170902ee5500b0018969cf9ea0mr2611123plo.37.1669391630998;
        Fri, 25 Nov 2022 07:53:50 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902d29400b00176b84eb29asm3498504plc.301.2022.11.25.07.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 07:53:50 -0800 (PST)
Message-ID: <8765db57-3de8-60c1-895c-4a01322df1bd@9elements.com>
Date:   Fri, 25 Nov 2022 21:23:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6] hwmon: (pmbus/core): Implement regulator get_status
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221124193642.4081054-1-Naresh.Solanki@9elements.com>
 <20221125155146.GA1169995@roeck-us.net>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221125155146.GA1169995@roeck-us.net>
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



On 25-11-2022 09:21 pm, Guenter Roeck wrote:
> On Thu, Nov 24, 2022 at 08:36:42PM +0100, Naresh Solanki wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Add get_status for pmbus_regulator_ops.
>> ---
> 
> Adding "---" into the commit description causes everything afterwards
> to get lost when applying the patch, including the signatures.
> I fixed it up and applied it, but please don't do that in the future.
Sure. Thanks
> 
> Guenter
> 
>> Changes:
>> - use lock throughout the function
>> - Avoid line continuation upto 100 column
>> - Optimize use of & and | operator
>> - Check for VOUT, IOUT, TEMPERATURE bit in status word before checking
>>    respective status register for fault.
>> - Report regulator current status.
>> - Utilize get_error_flag to check for regulator errors.
>> - Check for return value of function get_error_flag
>> - Use function pmbus_regulator_get_error_flags directly
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   drivers/hwmon/pmbus/pmbus_core.c | 44 ++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>>
>> base-commit: 2c71b3246ec3246522e8cb7c8191dc7a5d62cc70
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>> index 20ca26e19db7..95e95783972a 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -2855,6 +2855,49 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
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
>> +	ret = pmbus_regulator_get_error_flags(rdev, &status);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	if (status & (REGULATOR_ERROR_UNDER_VOLTAGE | REGULATOR_ERROR_OVER_CURRENT |
>> +	   REGULATOR_ERROR_REGULATION_OUT | REGULATOR_ERROR_FAIL | REGULATOR_ERROR_OVER_TEMP)) {
>> +		ret = REGULATOR_STATUS_ERROR;
>> +		goto unlock;
>> +	}
>> +
>> +	ret = REGULATOR_STATUS_UNDEFINED;
>> +
>> +unlock:
>> +	mutex_unlock(&data->update_lock);
>> +	return ret;
>> +}
>> +
>>   static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
>>   {
>>   	struct pmbus_data *data = i2c_get_clientdata(client);
>> @@ -2995,6 +3038,7 @@ const struct regulator_ops pmbus_regulator_ops = {
>>   	.disable = pmbus_regulator_disable,
>>   	.is_enabled = pmbus_regulator_is_enabled,
>>   	.get_error_flags = pmbus_regulator_get_error_flags,
>> +	.get_status = pmbus_regulator_get_status,
>>   	.get_voltage = pmbus_regulator_get_voltage,
>>   	.set_voltage = pmbus_regulator_set_voltage,
>>   	.list_voltage = pmbus_regulator_list_voltage,

Naresh
