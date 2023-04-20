Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824916E8D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjDTIqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjDTIqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:46:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D623A8E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:46:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so1039064b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681980377; x=1684572377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNexYsyxhNu53d+NlI20mVu1Dg9oYog4h9Lb8OIxrXk=;
        b=N3OFrrQzZbP7GPso9+CsmDxQPqPqom6Y28831GduQG1jk6W+PkA7h8nuxdeutyV5Vw
         vZMHkXX8kUpp2fjGklHocIoeqVxX/sYekUtPSI/+CAMLmTg0C7DfE3Py5jApJPEVWdCZ
         gBpZYgUKXS8kWwa90bjUox8HLvDqNiKcsmTDm/rU9OrkNyCa/RP+XMNy/8H7mKHGeW42
         sRzzYVf+xTOYdIVaqwHyr5VmbFfn03U5XlRH+1Aa3iRI2N+cfqrofdR1LQJgwCc73Pbd
         lrIFCMPOSAe2QXAkDrDAP3CjV5j+9MCOhCmGyXxM3oNDZO+CYGyRR7iM7jBlie0AF9jR
         AF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681980377; x=1684572377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNexYsyxhNu53d+NlI20mVu1Dg9oYog4h9Lb8OIxrXk=;
        b=BxztgfohK74y+SZFNnxgVerkKrN06qwTcBxpKVQJ+klbVmS9EPLqZNa3x2weY7Zk1G
         7+7vRvqxIWGlw35v2waitIHAt9s37wuXVF1uZbaqCvvwKKgzOX++r0RVouXpxeLodASH
         JDsYjyfeQrJDyuMywznB2h4ykBfvEgGlaRkCjZWOl/pByXfr7bExRc2WNBMNS2Wua8dw
         3CzXAvIgjCF0l/VxGcRLuku23E+7dNtmbuhooSdH/qAy9AKv4ohFJXxusIDPW194LsOX
         1Nah0D2cEsbvSMiKhoQovcDDFixV6wjutDCsyowSS/I2gy4krVoaywQjLIj3j/syfwSr
         +TSA==
X-Gm-Message-State: AAQBX9cNFHs6x84oL3G5PrurvZ4kUGGpcJrcQ/LB8tVg2zt09t7IGqe8
        YtJp71pqJCjUzD2ruoqokCxM2g==
X-Google-Smtp-Source: AKy350auT7wgzhrXmU0bzbJP6baw69YzjQr9qm6XtS/L4zVOvAZkEET9Le9Spgx0Ndxsaa/m36MktA==
X-Received: by 2002:a05:6a21:170b:b0:f0:b5d3:4feb with SMTP id nv11-20020a056a21170b00b000f0b5d34febmr1088238pzb.19.1681980377201;
        Thu, 20 Apr 2023 01:46:17 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id a6-20020a62d406000000b00627f054a3cdsm751089pfh.31.2023.04.20.01.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 01:46:16 -0700 (PDT)
Message-ID: <ba8663c2-b9e6-e999-9324-af8499179464@9elements.com>
Date:   Thu, 20 Apr 2023 14:16:14 +0530
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
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <afdd0170-8b14-451f-96a7-2b5656fa0dd7@hatter.bewilderbeest.net>
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

On 20-04-2023 05:32 am, Zev Weiss wrote:
> On Tue, Apr 18, 2023 at 07:50:51AM PDT, Naresh Solanki wrote:
>> Use property regulator-supplies to determine all regulator
>> supplies.
>> This is useful in case of a connector having 2 or more supplies.
>> Example: PCIe connector on mainboard can be powered by 12V & 3.3V
>> suplies.
>>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>> drivers/regulator/userspace-consumer.c | 19 +++++++++++++++----
>> 1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/regulator/userspace-consumer.c 
>> b/drivers/regulator/userspace-consumer.c
>> index 97f075ed68c9..0bb49547b926 100644
>> --- a/drivers/regulator/userspace-consumer.c
>> +++ b/drivers/regulator/userspace-consumer.c
>> @@ -120,7 +120,10 @@ static int 
>> regulator_userspace_consumer_probe(struct platform_device *pdev)
>>     struct regulator_userspace_consumer_data tmpdata;
>>     struct regulator_userspace_consumer_data *pdata;
>>     struct userspace_consumer_data *drvdata;
>> -    int ret;
>> +    struct device_node *np = pdev->dev.of_node;
>> +    struct property *prop;
>> +    const char *supply;
>> +    int ret, count = 0;
>>
>>     pdata = dev_get_platdata(&pdev->dev);
>>     if (!pdata) {
>> @@ -131,11 +134,19 @@ static int 
>> regulator_userspace_consumer_probe(struct platform_device *pdev)
>>         memset(pdata, 0, sizeof(*pdata));
>>
>>         pdata->no_autoswitch = true;
>> -        pdata->num_supplies = 1;
>> -        pdata->supplies = devm_kzalloc(&pdev->dev, 
>> sizeof(*pdata->supplies), GFP_KERNEL);
>> +        pdata->num_supplies = of_property_count_strings(np, 
>> "regulator-supplies");
>> +        if (pdata->num_supplies < 0) {
>> +            dev_err(&pdev->dev, "could not parse property 
>> regulator-supplies");
>> +            return -EINVAL;
>> +        }
>> +        pdata->supplies = devm_kzalloc(&pdev->dev,
>> +                           sizeof(*pdata->supplies) * 
>> pdata->num_supplies,
>> +                           GFP_KERNEL);
> 
> AFAICT this doesn't appear to implement the "vout" default specified in 
> the dt-binding patch?
The "regulator-supplies" property will hold the default value of "vout" 
unless specified otherwise. As a result, the string enumeration 
retrieves the value of "vout" by default, and the "vout-supply" property 
is utilized for the regulator.

> 
> Also, since the core of the userspace-consumer driver itself already 
> supports multiple regulators, it might be nice for the subject line to 
> mention DT supplies or something a bit more specifically.
Sure. How about 'Support multiple supplies' ?
> 
>>         if (!pdata->supplies)
>>             return -ENOMEM;
>> -        pdata->supplies[0].supply = "vout";
>> +
>> +        of_property_for_each_string(np, "regulator-supplies", prop, 
>> supply)
>> +            pdata->supplies[count++].supply = supply;
>>     }
>>
>>     if (pdata->num_supplies < 1) {
>> -- 
>> 2.39.1
>>
>>
Regards,
Naresh
