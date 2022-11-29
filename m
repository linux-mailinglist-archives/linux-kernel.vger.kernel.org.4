Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45763C3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiK2PZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiK2PY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:24:59 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B33C1A81B;
        Tue, 29 Nov 2022 07:24:58 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-142faa7a207so17354706fac.13;
        Tue, 29 Nov 2022 07:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJDPWKUhea1UYF8DZSQeMkG2RUkLbDvjdRtmBNddCi4=;
        b=ZWYszs34HQk0bUSdwnbG4hx4lSlDzM6z2rqcI2+ga2dubwbe7NYOmo2fudGTm/zoWw
         ScB1UzymEXlBIO4gKc3fHT8XXNZDIYC8U9Nx++013Ns1W2Vj3JewMmWaGrNfzXFGE52C
         1ecUtEhPDIu4yuXLKUeeQNgmIqQ90lIua7gH5KZOFjfb/2FXKcjcDaZPGsauQHDconJn
         T7WQtCwexuS4ouE52Kquiz/zZsGSuVztCPNgIV1b2akIAdVhZ1eoH6Iixl0jZizoeTXs
         jFUmsAbEd/L6i2YE2BXXf1M/DV4Nju4JerdgrqWmD+geEK43FPi7bBx+NlXLf6o+6Kl5
         beUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJDPWKUhea1UYF8DZSQeMkG2RUkLbDvjdRtmBNddCi4=;
        b=FPIH4l5ABkR9g60WyzQzBMqLFyrtdfqWEh+Cem5T0BGpERgNPZKWXC+KTLcPJdGkYz
         KJIHizCN5DMykUkaRGdaGwiGznEWfnwnmowfbKKUUb0eApUKVXvLi+rF5gv88NyPxMdb
         D0NaS02cqt6NNM7UARY+6cN7BtbxLIaNqQcIlj1nbEeBF3+m01qiVtUpquIEOcLGDbVf
         IaEJ/Cjzjt8zJkgVWeFLKbzZ7/j/OTcKm/rN6V8VywdP5ETvA6fJ16TLv4anKvzEsZ2u
         wgHIdm+TWKY1CxK76Rr2gyTUxECSdIZQMTDymabVNATCsyDrJBpP8JBN9P9Bt5JFRDha
         J0Kg==
X-Gm-Message-State: ANoB5pl8jCdE/dffGzu9OBN76vMXOxalW2Eiy6evBNFc5MWZF+jk40bk
        15s10Xi6djMrz/4YjHE4XbA=
X-Google-Smtp-Source: AA0mqf7QpmXo7URc+f118DeqDUlk64u0wUJhe2um7JNlrd9AGjXmrymSMEzwQfk6eoH1RIwwamPHNw==
X-Received: by 2002:a05:6870:bf14:b0:13b:5d72:f110 with SMTP id qh20-20020a056870bf1400b0013b5d72f110mr33633119oab.252.1669735497552;
        Tue, 29 Nov 2022 07:24:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d5-20020a05680808e500b0035acd0a6eb2sm5580109oic.41.2022.11.29.07.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 07:24:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6366dfd8-9e81-1ada-f41d-a687b4ab8e5a@roeck-us.net>
Date:   Tue, 29 Nov 2022 07:24:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221128174715.1969957-1-Naresh.Solanki@9elements.com>
 <bbba5774-b886-df08-1263-7e3489b84a8e@roeck-us.net>
 <32b17cb1-754f-684b-a7d2-583d2e32030f@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/3] hwmon: (pmbus/core): Update regulator flag map
In-Reply-To: <32b17cb1-754f-684b-a7d2-583d2e32030f@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 23:55, Naresh Solanki wrote:
> Hi Guenter,
> 
> On 29-11-2022 04:11 am, Guenter Roeck wrote:
>> On 11/28/22 09:47, Naresh Solanki wrote:
>>> Add regulator flag map for PMBUS status byte & status input.
>>>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>
>> You are adding a lot of input errors here. The regulator documentation
>> only covers output errors. I am not sure if this set of changes is
>> really appropriate. You'll have to make a much better case for those changes;
>> from what I can see they are all controversial and were originally left out
>> on purpose.
> I felt it may be worth to monitor status input, but you feel otherwise then shall I remove this in next revision ?

It is a set of changes which needs input from regulator subsystem maintainers.
Maybe it even needs changes on the regulator side, for example to report
input and/or power failures properly.

It isn't something I would have expected as part of a patch or patch series
series which is supposed to add interrupt support to pmbus drivers.
Since it is the first patch in your series, in may hold up the series
for some period of time until the questions around it are resolved.
Your call, really, how to handle it. Just don't be surprised if it takes
a while to resolve the issues.

>>
>>> ---
>>>   drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++++++++++++++--------
>>>   1 file changed, 22 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>>> index 95e95783972a..f5caceaaef2a 100644
>>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>>> @@ -2752,6 +2752,15 @@ struct pmbus_regulator_status_category {
>>>   static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
>>>       {
>>> +        .func = -1,
>>
>> This would need a comment. I don't really see the benefit over the original
>> code.
> I pulled that in so as to handle it in same way as other status register.

That would have to be a separate patch. It took me a while to understand
how .func = -1 is handled, so without comment it just adds confusion.

>>
>>> +        .reg = PMBUS_STATUS_BYTE,
>>> +        .bits = (const struct pmbus_regulator_status_assoc[]) {
>>> +            { PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT },
>>> +            { PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT },
>>> +            { PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE },
>>> +            { },
>>> +        },
>>> +    }, {
>>>           .func = PMBUS_HAVE_STATUS_VOUT,
>>>           .reg = PMBUS_STATUS_VOUT,
>>>           .bits = (const struct pmbus_regulator_status_assoc[]) {
>>> @@ -2768,6 +2777,7 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>>>               { PB_IOUT_OC_WARNING, REGULATOR_ERROR_OVER_CURRENT_WARN },
>>>               { PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>>>               { PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
>>> +            { PB_POUT_OP_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>>
>> OP_FAULT (power fault) and over current are really not the same thing.
>>
> I agree. But thats best I could think of. Not sure if there is better REGULATOR_ERROR_* code for this scenario. Suggestions?

Options are REGULATOR_ERROR_OVER_CURRENT or REGULATOR_ERROR_FAIL or
a new failure code or doing nothing. Personally I think REGULATOR_ERROR_FAIL
would be better if adding a new failure code is not an option.

Anyway, clarify on the regulator subsystem mailing list how to handle input
errors, and how to handle power failures. If they say it is acceptable to
report input errors as output errors, and to report power failures as
current failures, resubmit. Say in comments that this is what you are doing,
and in the commit description that this is how input errors and power
failures are handled in the regulator subsystem. Copy regulator subsystem
maintainers on your patch.

Thanks,
Guenter

>>>               { },
>>>           },
>>>       }, {
>>> @@ -2778,6 +2788,18 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>>>               { PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
>>>               { },
>>>           },
>>> +    }, {
>>> +        .func = PMBUS_HAVE_STATUS_INPUT,
>>> +        .reg = PMBUS_STATUS_INPUT,
>>> +        .bits = (const struct pmbus_regulator_status_assoc[]) {
>>> +            { PB_IIN_OC_FAULT,       REGULATOR_ERROR_OVER_CURRENT },
>>> +            { PB_IIN_OC_WARNING, REGULATOR_ERROR_OVER_CURRENT_WARN },
>>> +            { PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
>>> +            { PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
>>> +            { PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
>>> +            { PB_VOLTAGE_OV_FAULT, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
>>
>> fault -> warning ? Shouldn't this be REGULATOR_ERROR_FAIL (Regulator
>> output has failed) ?
>>
> Yes. REGULATOR_ERROR_FAIL is best fit here. Will update in next revision.
>>> +            { },
>>> +        },
>>>       },
>>>   };
>>> @@ -2834,14 +2856,6 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>>           if (status & PB_STATUS_POWER_GOOD_N)
>>>               *flags |= REGULATOR_ERROR_REGULATION_OUT;
>>>       }
>>> -    /*
>>> -     * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
>>> -     * defined strictly as fault indicators (not warnings).
>>> -     */
>>> -    if (status & PB_STATUS_IOUT_OC)
>>> -        *flags |= REGULATOR_ERROR_OVER_CURRENT;
>>> -    if (status & PB_STATUS_VOUT_OV)
>>> -        *flags |= REGULATOR_ERROR_REGULATION_OUT;
>>>       /*
>>>        * If we haven't discovered any thermal faults or warnings via
>>>
>>> base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
>>

