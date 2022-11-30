Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F7A63DB06
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiK3Qw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiK3Qwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:52:49 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CDA1CFD4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:52:46 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z17so12552134pff.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70hrIKE/Lh0Xe2sfkWCWl/PvBxei19HaDqCvJkKWhco=;
        b=UFRitgEDGJg5MoCtIDYXjzCjzLyMME5GtargjP8D8ozTmzgApORZIIQ+vWBAvTpKan
         EHCJPLCiNhPpIc4devgESIWMvAM1H72/Ag4hbBWEaGrF/kBa3YHXS89t2E7Mu8pqF7bx
         R4zK/oggbVyqqL17hjTLeVGdjpP2bchNhL+P1JQXXC2KPyJB8DsxZ+kJgQ4Bhi1cVeep
         WnfqYROyJzaURETqFMUgAbTrCG91HWyJ7XbmmHoiYRf9mh9vxo9JcHNVQ6TDe0ZTznCo
         UJJ80zO0dkFVQ7cGpCAl17Bh/9n4FmWAa81jSUe+6AIaTXjdzmfrKFehO9H5x+CkElvc
         cxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70hrIKE/Lh0Xe2sfkWCWl/PvBxei19HaDqCvJkKWhco=;
        b=8GfSESuwVV19lm5bBRFtacpG+IY+BYqUbHydDYehwG2FIE3zxJJ5I8y4Ga2dvXpgKe
         k15+t7X08CMm3i6aaLFSUwu5dkZqAPjx/6RwVDbpdaSGoamGFo8fnIKooNuGyzW5cK0R
         mH2G136+7+J/sFQJcZvvoh9fahvfEJzegxGM9Bx1mKnbn7GyMBoIIPgAxQON6/OFI2U0
         Of1WLV2qW0bxyjbWandg8P6s9isKCysbAAkKxwWei8mU+QO5eSJTIXngs8us4avn3IU2
         n1bI5WoVtU7QO/+gQ4GIsOgxbQMI80snlymL6IlyPu8Mc6yuQmfkOgoidmibKwxLJqw5
         Gi5w==
X-Gm-Message-State: ANoB5pmYDhWw5TkOIIQUzPHiT2N4aOTBj+9tYjKfIyz3eP6MJ6UKedX/
        U1BqC4M/hvf4Fopd9YSoZUCsNg==
X-Google-Smtp-Source: AA0mqf5NLJOmwyNwn/gipNidE9gEHwgNDNMVWONi/Dr1Lruk/b6q4wvYsV25K0Zt4f4DtIuXWhSiNA==
X-Received: by 2002:a63:eb16:0:b0:477:5f10:204f with SMTP id t22-20020a63eb16000000b004775f10204fmr37251550pgh.144.1669827166047;
        Wed, 30 Nov 2022 08:52:46 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027e4a00b001898aa48d17sm1700015pln.185.2022.11.30.08.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:52:45 -0800 (PST)
Message-ID: <75f01776-a95f-d0a7-4803-0b3d17f19800@9elements.com>
Date:   Wed, 30 Nov 2022 22:22:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] hwmon: (pmbus/core): Update regulator flag map
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221128174715.1969957-1-Naresh.Solanki@9elements.com>
 <bbba5774-b886-df08-1263-7e3489b84a8e@roeck-us.net>
 <32b17cb1-754f-684b-a7d2-583d2e32030f@9elements.com>
 <6366dfd8-9e81-1ada-f41d-a687b4ab8e5a@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <6366dfd8-9e81-1ada-f41d-a687b4ab8e5a@roeck-us.net>
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

On 29-11-2022 08:54 pm, Guenter Roeck wrote:
> On 11/28/22 23:55, Naresh Solanki wrote:
>> Hi Guenter,
>>
>> On 29-11-2022 04:11 am, Guenter Roeck wrote:
>>> On 11/28/22 09:47, Naresh Solanki wrote:
>>>> Add regulator flag map for PMBUS status byte & status input.
>>>>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>
>>> You are adding a lot of input errors here. The regulator documentation
>>> only covers output errors. I am not sure if this set of changes is
>>> really appropriate. You'll have to make a much better case for those 
>>> changes;
>>> from what I can see they are all controversial and were originally 
>>> left out
>>> on purpose.
>> I felt it may be worth to monitor status input, but you feel otherwise 
>> then shall I remove this in next revision ?
> 
> It is a set of changes which needs input from regulator subsystem 
> maintainers.
> Maybe it even needs changes on the regulator side, for example to report
> input and/or power failures properly.
> 
> It isn't something I would have expected as part of a patch or patch series
> series which is supposed to add interrupt support to pmbus drivers.
> Since it is the first patch in your series, in may hold up the series
> for some period of time until the questions around it are resolved.
> Your call, really, how to handle it. Just don't be surprised if it takes
> a while to resolve the issues.
I'll check with regulator subsystem maintainer on input error & based on 
feedback will post separate patch.
> 
>>>
>>>> ---
>>>>   drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++++++++++++++--------
>>>>   1 file changed, 22 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c 
>>>> b/drivers/hwmon/pmbus/pmbus_core.c
>>>> index 95e95783972a..f5caceaaef2a 100644
>>>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>>>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>>>> @@ -2752,6 +2752,15 @@ struct pmbus_regulator_status_category {
>>>>   static const struct pmbus_regulator_status_category 
>>>> pmbus_regulator_flag_map[] = {
>>>>       {
>>>> +        .func = -1,
>>>
>>> This would need a comment. I don't really see the benefit over the 
>>> original
>>> code.
>> I pulled that in so as to handle it in same way as other status register.
> 
> That would have to be a separate patch. It took me a while to understand
> how .func = -1 is handled, so without comment it just adds confusion.
Yes. Will make separate patch & add comment here.
> 
>>>
>>>> +        .reg = PMBUS_STATUS_BYTE,
>>>> +        .bits = (const struct pmbus_regulator_status_assoc[]) {
>>>> +            { PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT },
>>>> +            { PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT },
>>>> +            { PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE },
>>>> +            { },
>>>> +        },
>>>> +    }, {
>>>>           .func = PMBUS_HAVE_STATUS_VOUT,
>>>>           .reg = PMBUS_STATUS_VOUT,
>>>>           .bits = (const struct pmbus_regulator_status_assoc[]) {
>>>> @@ -2768,6 +2777,7 @@ static const struct 
>>>> pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>>>>               { PB_IOUT_OC_WARNING, 
>>>> REGULATOR_ERROR_OVER_CURRENT_WARN },
>>>>               { PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>>>>               { PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
>>>> +            { PB_POUT_OP_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>>>
>>> OP_FAULT (power fault) and over current are really not the same thing.
>>>
>> I agree. But thats best I could think of. Not sure if there is better 
>> REGULATOR_ERROR_* code for this scenario. Suggestions?
> 
> Options are REGULATOR_ERROR_OVER_CURRENT or REGULATOR_ERROR_FAIL or
> a new failure code or doing nothing. Personally I think 
> REGULATOR_ERROR_FAIL
> would be better if adding a new failure code is not an option.
Will update to REGULATOR_ERROR_FAIL.
> 
> Anyway, clarify on the regulator subsystem mailing list how to handle input
> errors, and how to handle power failures. If they say it is acceptable to
> report input errors as output errors, and to report power failures as
> current failures, resubmit. Say in comments that this is what you are 
> doing,
> and in the commit description that this is how input errors and power
> failures are handled in the regulator subsystem. Copy regulator subsystem
> maintainers on your patch.
Sure. Will hold back input errors for now & after checking with 
regulator maintainer, will make separate patch accordingly.
> 
> Thanks,
> Guenter
> 
>>>>               { },
>>>>           },
>>>>       }, {
>>>> @@ -2778,6 +2788,18 @@ static const struct 
>>>> pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>>>>               { PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
>>>>               { },
>>>>           },
>>>> +    }, {
>>>> +        .func = PMBUS_HAVE_STATUS_INPUT,
>>>> +        .reg = PMBUS_STATUS_INPUT,
>>>> +        .bits = (const struct pmbus_regulator_status_assoc[]) {
>>>> +            { PB_IIN_OC_FAULT,       REGULATOR_ERROR_OVER_CURRENT },
>>>> +            { PB_IIN_OC_WARNING, REGULATOR_ERROR_OVER_CURRENT_WARN },
>>>> +            { PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
>>>> +            { PB_VOLTAGE_UV_WARNING, 
>>>> REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
>>>> +            { PB_VOLTAGE_OV_WARNING, 
>>>> REGULATOR_ERROR_OVER_VOLTAGE_WARN },
>>>> +            { PB_VOLTAGE_OV_FAULT, 
>>>> REGULATOR_ERROR_OVER_VOLTAGE_WARN },
>>>
>>> fault -> warning ? Shouldn't this be REGULATOR_ERROR_FAIL (Regulator
>>> output has failed) ?
>>>
>> Yes. REGULATOR_ERROR_FAIL is best fit here. Will update in next revision.
>>>> +            { },
>>>> +        },
>>>>       },
>>>>   };
>>>> @@ -2834,14 +2856,6 @@ static int 
>>>> pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>>>           if (status & PB_STATUS_POWER_GOOD_N)
>>>>               *flags |= REGULATOR_ERROR_REGULATION_OUT;
>>>>       }
>>>> -    /*
>>>> -     * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
>>>> -     * defined strictly as fault indicators (not warnings).
>>>> -     */
>>>> -    if (status & PB_STATUS_IOUT_OC)
>>>> -        *flags |= REGULATOR_ERROR_OVER_CURRENT;
>>>> -    if (status & PB_STATUS_VOUT_OV)
>>>> -        *flags |= REGULATOR_ERROR_REGULATION_OUT;
>>>>       /*
>>>>        * If we haven't discovered any thermal faults or warnings via
>>>>
>>>> base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
>>>
> 

Regards,
Naresh
