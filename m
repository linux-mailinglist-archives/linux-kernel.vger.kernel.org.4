Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8411D63BB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiK2Hz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiK2Hz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:55:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C58451C3A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:55:25 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y17so4740267plp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+X5frHfglcLMfFZZdbAe3FYJY88P4ZdoDjrnq9Py3M=;
        b=WVZRjW3a9VdX49xA6uo8vt3+MFxU0tkpKAd7nKukabUMm3vj0/IlT/JODKYkZ85/d7
         lIZwTO1vAoma06BJC9fDc1f1eLGAt4bq4e9VVsxV5SceEz/iLZQMoai+adQZ6Mt695Yu
         3zyMDfTiPKngn01Y/Ezm925AvjlulxrJgDuIZ7mf0RPFFjEhZJRT8i7HZkLqorpghdoV
         oBS26EqBTXiotQnR5akb8lSmxEAEi0QvHPY5mP1CYjWRogySInzFcLpGQ/rzxcJhEtbb
         mKqU4OhC7gkSUA9sPGu89dCpv4Yxseu0uKyIL6h2UzU6D5sgSTb/D1lT9SL30ei1i5FI
         kkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+X5frHfglcLMfFZZdbAe3FYJY88P4ZdoDjrnq9Py3M=;
        b=DWYEZp5cRowPCAb/zLE0e4V5kp/10zU02y78pRpO71ndYajESfwiVTH/YSFFl3WbbV
         CC3hVrk0o3V6WfLTSlAEjEitadN6MZ1UngvilyUMN/LWecyB9WOQH1ZlW5+V9dgwkSdc
         MMTLn3C8DFPoaMM8WiJ2OF/I4Wm1fE3R8pSMk+fAr/Cvz7V6AKRa+/cmf0UkHQfD19Iw
         KezZ2OaHjm6Zzynrjyh6MsisXbRNJqkyqdV/3edaQEekjtL5DM+Z+StVzOfMCoWL5Nbc
         uRBcO+P3Apg0hZELwYSg/ZwqOCY6nSv1MT4bSTCYMeqLbSp2uy6aqnTm9gaISiFuNMaR
         rVRQ==
X-Gm-Message-State: ANoB5pl32mJcinlepR+cbN5k5BEZnWXhn7AybJR//kyIa2vpxhh5scAt
        mghepSubb8cR2Kp/vewFk/k0iw==
X-Google-Smtp-Source: AA0mqf7L1a0XjmktIXvwVoLRx/qAbMFLo8irDtBY52R5AUh+TZhWGwOdjMrQGi5C2rjeRXvSBeCHRg==
X-Received: by 2002:a17:90a:d38b:b0:218:821e:f734 with SMTP id q11-20020a17090ad38b00b00218821ef734mr55074924pju.87.1669708524679;
        Mon, 28 Nov 2022 23:55:24 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b005625ef68eecsm9255798pfl.31.2022.11.28.23.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 23:55:24 -0800 (PST)
Message-ID: <32b17cb1-754f-684b-a7d2-583d2e32030f@9elements.com>
Date:   Tue, 29 Nov 2022 13:25:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] hwmon: (pmbus/core): Update regulator flag map
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221128174715.1969957-1-Naresh.Solanki@9elements.com>
 <bbba5774-b886-df08-1263-7e3489b84a8e@roeck-us.net>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <bbba5774-b886-df08-1263-7e3489b84a8e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 29-11-2022 04:11 am, Guenter Roeck wrote:
> On 11/28/22 09:47, Naresh Solanki wrote:
>> Add regulator flag map for PMBUS status byte & status input.
>>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> You are adding a lot of input errors here. The regulator documentation
> only covers output errors. I am not sure if this set of changes is
> really appropriate. You'll have to make a much better case for those 
> changes;
> from what I can see they are all controversial and were originally left out
> on purpose.
I felt it may be worth to monitor status input, but you feel otherwise 
then shall I remove this in next revision ?
> 
>> ---
>>   drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++++++++++++++--------
>>   1 file changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c 
>> b/drivers/hwmon/pmbus/pmbus_core.c
>> index 95e95783972a..f5caceaaef2a 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -2752,6 +2752,15 @@ struct pmbus_regulator_status_category {
>>   static const struct pmbus_regulator_status_category 
>> pmbus_regulator_flag_map[] = {
>>       {
>> +        .func = -1,
> 
> This would need a comment. I don't really see the benefit over the original
> code.
I pulled that in so as to handle it in same way as other status register.
> 
>> +        .reg = PMBUS_STATUS_BYTE,
>> +        .bits = (const struct pmbus_regulator_status_assoc[]) {
>> +            { PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT },
>> +            { PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT },
>> +            { PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE },
>> +            { },
>> +        },
>> +    }, {
>>           .func = PMBUS_HAVE_STATUS_VOUT,
>>           .reg = PMBUS_STATUS_VOUT,
>>           .bits = (const struct pmbus_regulator_status_assoc[]) {
>> @@ -2768,6 +2777,7 @@ static const struct 
>> pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>>               { PB_IOUT_OC_WARNING,    
>> REGULATOR_ERROR_OVER_CURRENT_WARN },
>>               { PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>>               { PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
>> +            { PB_POUT_OP_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
> 
> OP_FAULT (power fault) and over current are really not the same thing.
> 
I agree. But thats best I could think of. Not sure if there is better 
REGULATOR_ERROR_* code for this scenario. Suggestions?
>>               { },
>>           },
>>       }, {
>> @@ -2778,6 +2788,18 @@ static const struct 
>> pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>>               { PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
>>               { },
>>           },
>> +    }, {
>> +        .func = PMBUS_HAVE_STATUS_INPUT,
>> +        .reg = PMBUS_STATUS_INPUT,
>> +        .bits = (const struct pmbus_regulator_status_assoc[]) {
>> +            { PB_IIN_OC_FAULT,       REGULATOR_ERROR_OVER_CURRENT },
>> +            { PB_IIN_OC_WARNING,     
>> REGULATOR_ERROR_OVER_CURRENT_WARN },
>> +            { PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
>> +            { PB_VOLTAGE_UV_WARNING, 
>> REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
>> +            { PB_VOLTAGE_OV_WARNING, 
>> REGULATOR_ERROR_OVER_VOLTAGE_WARN },
>> +            { PB_VOLTAGE_OV_FAULT,   
>> REGULATOR_ERROR_OVER_VOLTAGE_WARN },
> 
> fault -> warning ? Shouldn't this be REGULATOR_ERROR_FAIL (Regulator
> output has failed) ?
> 
Yes. REGULATOR_ERROR_FAIL is best fit here. Will update in next revision.
>> +            { },
>> +        },
>>       },
>>   };
>> @@ -2834,14 +2856,6 @@ static int 
>> pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>           if (status & PB_STATUS_POWER_GOOD_N)
>>               *flags |= REGULATOR_ERROR_REGULATION_OUT;
>>       }
>> -    /*
>> -     * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
>> -     * defined strictly as fault indicators (not warnings).
>> -     */
>> -    if (status & PB_STATUS_IOUT_OC)
>> -        *flags |= REGULATOR_ERROR_OVER_CURRENT;
>> -    if (status & PB_STATUS_VOUT_OV)
>> -        *flags |= REGULATOR_ERROR_REGULATION_OUT;
>>       /*
>>        * If we haven't discovered any thermal faults or warnings via
>>
>> base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
> 
