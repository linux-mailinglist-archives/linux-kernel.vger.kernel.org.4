Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0836E9439
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjDTM2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjDTM1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:27:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976745BA1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:27:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63d4595d60fso6601424b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681993674; x=1684585674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjsFf7F3a5Cs1Xb0w77dgZ90sOJ/TDGlRy7IBznW0xE=;
        b=GRYwVtXoKy9TxzdBn71HkPGD+v3NsAkyB/4AT9Rv4U+6MFONvmaZUE1hrJmco3Tmet
         UiSN/1Mc/Te4EYMvfljhknirC9Pf0bjIaUQSkBBoNUA7tvawHYvFyxZJrmQWzi6hS9zI
         VrK7JuddvL9M6jMVN+TAee/65aUzIZXvDJWClGFkaj01VS/nlJUnDURP0vJ5L7W6BBuY
         jqVFNNY3pkYuKmhS66s4gV/leNB37rbuw6nhHb05mfHaE8E5taRccXHnsAf9hDKQQCXU
         ckSkhMNS4xqnwy9l2vMXOIydCUdbdMRN2tZTP5jBYT+13dX7q/YNeASddjEnU1lCDjhh
         O6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681993674; x=1684585674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjsFf7F3a5Cs1Xb0w77dgZ90sOJ/TDGlRy7IBznW0xE=;
        b=jE0b95QqCyBrmSPEU2P/aJBQWH4pKVlw7AzfsBRkEZrK0+IX+zAtYeWYPBqiuIkvVk
         3sausW+atxfP6Cn8kysvqVAeThj9rid6XdXiLAv3DbqDABcyxMNyv2K9Jb6lgUBHvAgB
         TYUClgemDL9AiTXKP/0c7zRjVwGVYRfDvLwCBBLrwoblJ5ZqPUSLDwKALpDvg55Z2+b4
         CTCO7NzdkR1cFwzr12cUg0LZvc/g+TdQ99oFsK4hfvaMiS3Q7WRf36CMImUIKfUheVbc
         TvHMUpryxKmBfYs7WYXQw73SqPh/tuxFIL7I7kT8U+SfyCl/UV9dMQV2lHkUUUDIl5bs
         E0aQ==
X-Gm-Message-State: AAQBX9cRqRsE4TcPeufxSP1ikvPImIPZ68IQSUno+cI3TRSTbUFbocYs
        jXj74euNJdXvMSxbeT4rn9/VaA==
X-Google-Smtp-Source: AKy350b+bO/XKg8g2ZO6nCU1KQagjHR6ol0GGvfbFW9dcTu4NuOIP8k83FA1ENpTMzI6Zm6UgPVZgQ==
X-Received: by 2002:a17:90b:10f:b0:23d:870:5244 with SMTP id p15-20020a17090b010f00b0023d08705244mr1484087pjz.13.1681993674054;
        Thu, 20 Apr 2023 05:27:54 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm1097894plo.90.2023.04.20.05.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 05:27:53 -0700 (PDT)
Message-ID: <6848572f-ec5c-39d9-4193-f72fa52f5e81@9elements.com>
Date:   Thu, 20 Apr 2023 17:57:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] regulator: userspace-consumer: Multiple regulators
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20230418145051.4192963-1-Naresh.Solanki@9elements.com>
 <20230418145051.4192963-2-Naresh.Solanki@9elements.com>
 <afdd0170-8b14-451f-96a7-2b5656fa0dd7@hatter.bewilderbeest.net>
 <ba8663c2-b9e6-e999-9324-af8499179464@9elements.com>
 <0e8f4068-70c2-4609-961e-34b5ef9d0113@hatter.bewilderbeest.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <0e8f4068-70c2-4609-961e-34b5ef9d0113@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zev,

On 20-04-2023 04:27 pm, Zev Weiss wrote:
> On Thu, Apr 20, 2023 at 01:46:14AM PDT, Naresh Solanki wrote:
>> Hi Zev,
>>
>> On 20-04-2023 05:32 am, Zev Weiss wrote:
>>> On Tue, Apr 18, 2023 at 07:50:51AM PDT, Naresh Solanki wrote:
>>>> Use property regulator-supplies to determine all regulator
>>>> supplies.
>>>> This is useful in case of a connector having 2 or more supplies.
>>>> Example: PCIe connector on mainboard can be powered by 12V & 3.3V
>>>> suplies.
>>>>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> ---
>>>> drivers/regulator/userspace-consumer.c | 19 +++++++++++++++----
>>>> 1 file changed, 15 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/regulator/userspace-consumer.c 
>>>> b/drivers/regulator/userspace-consumer.c
>>>> index 97f075ed68c9..0bb49547b926 100644
>>>> --- a/drivers/regulator/userspace-consumer.c
>>>> +++ b/drivers/regulator/userspace-consumer.c
>>>> @@ -120,7 +120,10 @@ static int 
>>>> regulator_userspace_consumer_probe(struct platform_device *pdev)
>>>>     struct regulator_userspace_consumer_data tmpdata;
>>>>     struct regulator_userspace_consumer_data *pdata;
>>>>     struct userspace_consumer_data *drvdata;
>>>> -    int ret;
>>>> +    struct device_node *np = pdev->dev.of_node;
>>>> +    struct property *prop;
>>>> +    const char *supply;
>>>> +    int ret, count = 0;
>>>>
>>>>     pdata = dev_get_platdata(&pdev->dev);
>>>>     if (!pdata) {
>>>> @@ -131,11 +134,19 @@ static int 
>>>> regulator_userspace_consumer_probe(struct platform_device *pdev)
>>>>         memset(pdata, 0, sizeof(*pdata));
>>>>
>>>>         pdata->no_autoswitch = true;
>>>> -        pdata->num_supplies = 1;
>>>> -        pdata->supplies = devm_kzalloc(&pdev->dev, 
>>>> sizeof(*pdata->supplies), GFP_KERNEL);
>>>> +        pdata->num_supplies = of_property_count_strings(np, 
>>>> "regulator-supplies");
>>>> +        if (pdata->num_supplies < 0) {
>>>> +            dev_err(&pdev->dev, "could not parse property 
>>>> regulator-supplies");
>>>> +            return -EINVAL;
>>>> +        }
>>>> +        pdata->supplies = devm_kzalloc(&pdev->dev,
>>>> +                           sizeof(*pdata->supplies) * 
>>>> pdata->num_supplies,
>>>> +                           GFP_KERNEL);
>>>
>>> AFAICT this doesn't appear to implement the "vout" default specified 
>>> in the dt-binding patch?
>> The "regulator-supplies" property will hold the default value of 
>> "vout" unless specified otherwise. As a result, the string enumeration 
>> retrieves the value of "vout" by default, and the "vout-supply" 
>> property is utilized for the regulator.
>>
> 
> With the disclaimer that I'm not a DT expert, that's not my 
> understanding of how DT works.  I don't think the 'default' value 
> specified in the binding forces the fdt to always include that value if 
> it's not present in the dts (since I'm pretty sure dtc doesn't even look 
> at the binding to know that a default exists when compiling the dts); 
> rather, it's information meant to be used by the software implementing 
> support for that device (e.g. a driver for it) about what value to 
> assume if the property isn't present in the fdt.
I apologize for the oversight on my part. Upon further testing, I have 
discovered that the default did not reflect in the debug prints. I will 
address this issue and include the proper fix in the next patchset. 
Thank you for bringing this to my attention
> 
>>>
>>> Also, since the core of the userspace-consumer driver itself already 
>>> supports multiple regulators, it might be nice for the subject line 
>>> to mention DT supplies or something a bit more specifically.
>> Sure. How about 'Support multiple supplies' ?
> 
> I meant that it should explicitly mention "DT" (or perhaps "OF").  The 
> driver's structure has supported multiple supplies since it was first 
> introduced in 2009, so "Support multiple supplies" sounds like this 
> commit is adding functionality that was already there.  What this patch 
> is doing is connecting that existing support to the OF support logic so 
> that it can be used in a device-tree context.
Sure. Will make it something like "Support multiple supplies in DT".
> 
>>>
>>>>         if (!pdata->supplies)
>>>>             return -ENOMEM;
>>>> -        pdata->supplies[0].supply = "vout";
>>>> +
>>>> +        of_property_for_each_string(np, "regulator-supplies", prop, 
>>>> supply)
>>>> +            pdata->supplies[count++].supply = supply;
>>>>     }
>>>>
>>>>     if (pdata->num_supplies < 1) {
>>>> -- 
>>>> 2.39.1
>>>>
>>>>
>> Regards,
>> Naresh
Regards,
Naresh
