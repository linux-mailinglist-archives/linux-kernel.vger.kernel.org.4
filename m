Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1BC63DD41
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiK3SZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiK3SZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:25:41 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433BE6257
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:25:39 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id mv18so16470464pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNjUipgdQ3pDV5Xz9PxyK+9V0vzs12ycEkmIFgXDPFM=;
        b=GIKQ40Xllfkr211uBfuMgvEtCnlX4RtW69HDb3TvUXoQcYcyi9RQpLnvJ1E5z4OnEp
         OZuB4OToPiFPBbE/qDDIpDFhugVfg/INgzGzqW8iaqw0y09U8WpuC1NU/R2ssIv26Xsw
         20UbPAJyj7wCC66snjBvihQP41EoOLzK1B5FxMMDmOFGaqENPwU5thHnzgKFuyIe77r1
         W2u3+CzD/wrpnQM/0WiaVbhdaO42x1+BS21dZt1vUGEg96/08VZr7zHZeK0W1JLqKwrs
         Va393Gm06NKCyYf/8gQhbvitXok2yQ2z4zggqS+ctkYkcbP/DTDVokAifcbw+HK2fxry
         dvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNjUipgdQ3pDV5Xz9PxyK+9V0vzs12ycEkmIFgXDPFM=;
        b=tNhUTAJAFwovh9EKN72zdIS+3eqKJRRqEk7s7rBgQ+iX/ZheWSFosv0TFV5ZWyQrQ8
         KEsSpFyRTXjjhWEX0GthRAb5wrVmy4CJY6nKr6E3M8MC4c8YAaJjBDp5kDyNLmC14DoZ
         Ir+beBGyJCAyb7n6TNG/rTCb8muabU0EsReDk/BgQ/MyrxI7+nIjN/+DG1rx6VpOu4JJ
         YbhbnvgNKr4eACM8N0r++RsnlJBvUYpP+fZ+MiIJJQx/mJ5qa2IZ8o5s99Z6hRFgXzvZ
         9Rt9kvKvxvWWuQHnVpUp14MNGWTlOwiut3SC/CBs/XxUNPFk9eovrPQ2pGrlULYYPfN1
         RMDg==
X-Gm-Message-State: ANoB5pndV7ax43w5AffPkvL7RTFTvAZzoKPtj/gpH2PS56AfHY4seWPI
        EOz5JTgxy+dmzS/FPEZv9Rslgg==
X-Google-Smtp-Source: AA0mqf4ZiSiUpwuVKA97Pm7d4SDHcjOOVyPOkyiH8j/SjZbnsTHS9E64h7eOZ2PWd1RvvQ6ApmYMIw==
X-Received: by 2002:a17:902:e313:b0:189:97e9:c8e with SMTP id q19-20020a170902e31300b0018997e90c8emr11244208plc.63.1669832738748;
        Wed, 30 Nov 2022 10:25:38 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b00186b1bfbe79sm1831845plh.66.2022.11.30.10.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 10:25:38 -0800 (PST)
Message-ID: <27b12115-14cc-9c9c-a645-30a6ec018ddb@9elements.com>
Date:   Wed, 30 Nov 2022 23:55:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/4] hwmon: (pmbus/core): Add status byte to regulator
 flag map
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221130165833.3478555-1-Naresh.Solanki@9elements.com>
 <20221130180642.GA2656856@roeck-us.net>
 <b6f0a393-0715-1541-631d-5b98c0d7b155@9elements.com>
 <20221130181905.GA2658232@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221130181905.GA2658232@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-11-2022 11:49 pm, Guenter Roeck wrote:
> On Wed, Nov 30, 2022 at 11:42:32PM +0530, Naresh Solanki wrote:
>> Hi,
>>
>> On 30-11-2022 11:36 pm, Guenter Roeck wrote:
>>> On Wed, Nov 30, 2022 at 05:58:28PM +0100, Naresh Solanki wrote:
>>>> Add PMBus status byte to regulator flag map.
>>>>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>>
>>>> ---
>>>> Changes:
>>>> - Remove status input
>>>
>>> Not really.
>>>
>> This was about PMBUS_STATUS_INPUT & not STATUS_BYTE
>>>> - Add comment for PMBUS status byte.
>>>> ---
>>>>    drivers/hwmon/pmbus/pmbus_core.c | 20 +++++++++++---------
>>>>    1 file changed, 11 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>>>> index 95e95783972a..a7b4ae0f1f3b 100644
>>>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>>>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>>>> @@ -2751,7 +2751,16 @@ struct pmbus_regulator_status_category {
>>>>    };
>>>>    static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
>>>> -	{
>>>> +	{	/* STATUS byte is always present. */
>>>> +		.func = -1,
>>>> +		.reg = PMBUS_STATUS_BYTE,
>>>> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
>>>> +			{ PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT },
>>>> +			{ PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT },
>>>> +			{ PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE },
>>>
>>> Still there.
>>>
>> STATUS_INPUT remove & STATUS_BYTE retained.
> 
> You added a check for PB_STATUS_VIN_UV which reports an input failure
> which was not reported before. You do so silently without mentioning the
> change in the description. In the change log you claim "Remove status input".
> Yet, the above adds reporting on an input voltage error. Maybe the
> change log was supposed to refer to the input status register, but that
> doesn't mean you can silently add a check for PB_STATUS_VIN_UV.
Right. I removed STATUS_INPUT but overlooked VIN in STATUS_BYTE.
Will fix this in next revision.
> 
> Guenter
> 
>>>> +			{ },
>>>> +		},
>>>> +	}, {
>>>>    		.func = PMBUS_HAVE_STATUS_VOUT,
>>>>    		.reg = PMBUS_STATUS_VOUT,
>>>>    		.bits = (const struct pmbus_regulator_status_assoc[]) {
>>>> @@ -2768,6 +2777,7 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>>>>    			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
>>>>    			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>>>>    			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
>>>> +			{ PB_POUT_OP_FAULT,      REGULATOR_ERROR_FAIL },
>>>
>>> Please document your changes in the description. There are two functional
>>> changes hidden under "Add PMBus status byte to regulator flag map".
>>> That is inappropriate. Those, as I have pointed out, should be separate
>>> patches.
>> My bad. I kept this change in this patch. Will remove this from this patch.
>>>
>>> Guenter
>>>
>>>>    			{ },
>>>>    		},
>>>>    	}, {
>>>> @@ -2834,14 +2844,6 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>>>    		if (status & PB_STATUS_POWER_GOOD_N)
>>>>    			*flags |= REGULATOR_ERROR_REGULATION_OUT;
>>>>    	}
>>>> -	/*
>>>> -	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
>>>> -	 * defined strictly as fault indicators (not warnings).
>>>> -	 */
>>>> -	if (status & PB_STATUS_IOUT_OC)
>>>> -		*flags |= REGULATOR_ERROR_OVER_CURRENT;
>>>> -	if (status & PB_STATUS_VOUT_OV)
>>>> -		*flags |= REGULATOR_ERROR_REGULATION_OUT;
>>>>    	/*
>>>>    	 * If we haven't discovered any thermal faults or warnings via
>>>>
>>>> base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
>>>> -- 
>>>> 2.37.3
>>>>
>>
>> Regards,
>> Naresh
Regards,
Naresh
