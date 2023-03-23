Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1576C69DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjCWNr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCWNry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:47:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C748298EF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:47:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d13so21553835pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679579272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T37KZ707+QHRTn2ZNwbjgV1BmdmFpSPmBXvga6GJ1rg=;
        b=JcaocTsHHXgHsyucoQJLY3O+DVOIYGs2I0VaUgRCwTHt+OVC0XjFLZdhozf2Z96TBN
         f9IUehD0sgAO1FYMB/aEsX8Nwvgn8TTjIWLfJzqzxUMtuEX+Pd8mDH4L4aEpr4TIUBpn
         6kG3EflW9Vw3dXdUxGrO74BeA6Mibz/LdOmEcGGSCLwKMhBGVD5+1yVarNVSOncbQjXh
         glQBRD6ip//804TjoohCejD6SHRJLlXO0tOL6T4OyNz7ph/hY8mpZ9Sr4Y9NIaCQDMcQ
         XkZ9a14SIrFmG2/toC2lRJEznN6NzkOW/X7C83vm5Fz6mZEGcDPM1S0XBzIMO9N2f10y
         6Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679579272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T37KZ707+QHRTn2ZNwbjgV1BmdmFpSPmBXvga6GJ1rg=;
        b=TtDqc6jChSvxBAppL4Dj057SNmGJmUawe4S0pg32MwwMMf64r5pMJp3WWiGa9TH4ga
         Xu4zs+w6An6ZUgVulrPrCVtG4uNQJf7nkseyJL/P9zWQpAP0mkGyhGoJaWYsF2Am96zc
         j61dxBOLITgi91Td44Vnz9xS1nq7GpLejWYrVgrk8d6GNsjmMf6ovQLiSX6xMBZ70Ddj
         zy3TMz3bH5Z9fvZaUluxDnjJWTCzEpjNwCT8584Si0DllP3mb3WCrKKr7uGpRFOu7ZN4
         MEABq5CY3uQLhsABmV/dbKJIHFGb0dfppXN3cYXy1LxUskSoKtLulma296nONsOtHugA
         tMrw==
X-Gm-Message-State: AO0yUKXR9ZuaQVRb93fzL2Jd1S6PaQBrBXZSLdFTbLchZElmNVCC52NC
        r9V3CloJyKMUW8kPjrGBNm+JenyatAzmpHifA6Q=
X-Google-Smtp-Source: AK7set/15FOeVzj98mFsBmsEIdJJGvjU+t3LmZdB/MEAf9DuQITMWVFo/nhJFjfJxjf/MEIi02B1+Q==
X-Received: by 2002:a17:90b:3b49:b0:237:62f7:3106 with SMTP id ot9-20020a17090b3b4900b0023762f73106mr7669630pjb.17.1679579272639;
        Thu, 23 Mar 2023 06:47:52 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b0019c61616f82sm12384953plo.230.2023.03.23.06.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 06:47:52 -0700 (PDT)
Message-ID: <0d7c5b82-e48f-4331-07a3-8bfd51f3a1e6@9elements.com>
Date:   Thu, 23 Mar 2023 19:17:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] iio: max597x: Add support for max597x
Content-Language: en-US
To:     Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20230322124316.2147143-1-Naresh.Solanki@9elements.com>
 <826f5de9-3aeb-6f7a-59e6-0504f8e92180@metafoo.de>
 <34756312-8a25-5a10-4ea5-59aeeb9e199b@9elements.com>
 <65b08184-0c6b-0a43-df80-4d5ae537a709@metafoo.de>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <65b08184-0c6b-0a43-df80-4d5ae537a709@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 23-03-2023 06:37 pm, Lars-Peter Clausen wrote:
> On 3/23/23 05:01, Naresh Solanki wrote:
>> Hi,
>>
>> On 22-03-2023 09:28 pm, Lars-Peter Clausen wrote:
>>> Hi,
>>>
>>> This looks really good. A few minor comments inline.
>>>
>>> On 3/22/23 05:43, Naresh Solanki wrote:
>>>> [...]
>>>> +static int max597x_iio_read_raw(struct iio_dev *iio_dev,
>>>> +                struct iio_chan_spec const *chan,
>>>> +                int *val, int *val2, long info)
>>>> +{
>>>> +    int ret;
>>>> +    struct max597x_iio *data = iio_priv(iio_dev);
>>>> +    unsigned int reg_l, reg_h;
>>>> +
>>>> +    switch (info) {
>>>> +    case IIO_CHAN_INFO_RAW:
>>>> +        ret = regmap_read(data->regmap, chan->address, &reg_l);
>>>> +        if (ret < 0)
>>>> +            return ret;
>>>> +        ret = regmap_read(data->regmap, chan->address - 1, &reg_h);
>>>> +        if (ret < 0)
>>>> +            return ret;
>>> Is there any chance of a race condition of getting inconsistent data 
>>> when splitting this over two reads? I.e. registers being updated with 
>>> new values in between the two reads.
>> yes, reg_l holds lower 2 bits. due to latency in reads, value may differ.
>>>> +        *val = (reg_h << 2) | (reg_l & 3);
>>>> +
>>>> +        return IIO_VAL_INT;
>>>> +    case IIO_CHAN_INFO_SCALE:
>>>> +
>>>> +        switch (chan->address) {
>>>> +        case MAX5970_REG_CURRENT_L(0):
>>>> +            fallthrough;
>>>
>>> `fallthrough` should not be needed for multiple case statements right 
>>> on top of each other with no code in between. Same below
>> Sure.
>>>
>>>> +        case MAX5970_REG_CURRENT_L(1):
>>>> +            /* in A, convert to mA */
>>>> +            *val = data->irng[chan->channel] * 1000;
>>>> +            *val2 =
>>>> +                data->shunt_micro_ohms[chan->channel] * ADC_MASK;
>>> ADC_MASK should really have a MAX5970_ prefix, but I guess it is 
>>> defined in max597x.h
>> Yes its taken from max597x.h
>>>> +            return IIO_VAL_FRACTIONAL;
>>>> +
>>>> +        case MAX5970_REG_VOLTAGE_L(0):
>>>> +            fallthrough;
>>>> +        case MAX5970_REG_VOLTAGE_L(1):
>>>> +            /* in uV, convert to mV */
>>>> +            *val = data->mon_rng[chan->channel];
>>>> +            *val2 = ADC_MASK * 1000;
>>>> +            return IIO_VAL_FRACTIONAL;
>>>> +        }
>>>> +
>>>> +        break;
>>>> +    }
>>>> +    return -EINVAL;
>>>> +}
>>>> [..]
>>>> +static int max597x_iio_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
>>>> +    struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
>>>> +    struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
>>>> +    struct iio_dev *indio_dev;
>>>> +    struct max597x_iio *priv;
>>>> +    int ret, i;
>>>> +
>>>> +    if (!regmap)
>>>> +        return -EPROBE_DEFER;
>>>> +
>>>> +    if (!max597x || !max597x->num_switches)
>>>> +        return -EPROBE_DEFER;
>>>> +
>>>> +    /* registering iio */
>>>> +    indio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*priv));
>>> For the devm allocations we should be using &pdev->dev and not the 
>>> I2C device, since this is the device to which the allocations belong 
>>> and where they should be freed when the device is removed.
>> Sure. Will use &pdev->dev
>>>> +    if (!indio_dev) {
>>>> +        dev_err(&i2c->dev, "failed allocating iio device\n");
>>> Consider using dev_err_probe() for error message printing. This will 
>>> give a consistent formatting of the messages. Also again use 
>>> &pdev->dev instead of I2C device to get the right device listed in 
>>> the error messages.
>> Sure. Will use
>> dev_err_probe(&pdev->dev, ret, "could not register iio device");
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +    indio_dev->name = dev_name(&i2c->dev);
>>> The IIO ABI wants the type of the chip for the name. E.g. "max5970", 
>>> using dev_name() of the parent I2C device will result in something else.
>> Sure. Will make it:
>> indio_dev->name = dev_name(&pdev->dev);
>>
> dev_name() in general should not be used for indio_dev->name, it does 
> not meet the ABI requirements for the IIO ABI. Move this into the switch 
> block below and then assign "max5970" or "max5978" depending on the 
> device type.
Sure.
> 
> 
Thanks,
Naresh
