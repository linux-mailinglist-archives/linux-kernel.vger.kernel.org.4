Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38A6C678A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjCWMDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjCWMC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:02:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5DA367F4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:01:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d13so21287219pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679572881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqKCt/HzAeVjL0jwsjWER+U22DnB4fv/DX4FqfpOi6A=;
        b=Gl4P9YWHBoDUo6X0J6my+1rig0zuWw/4B+I5zl1tJqiHdDIHhps2DYaUktHy6rKt7I
         1sWON9A/YKfUzyskgj0SOOFud9rTGbuEVOI1Z5wVjiovWubOSpmhXf8hsZsBi6t/uiJX
         EVEavFHHlUIV0LX8avirEsmdn9DHJjyvUqTcH86cgtNrcSva5vViEWM680KiOpX5dchp
         Q2jatQ/XzjBVS0wVTK63ArCV6p2APoC8JcuvlFBtCSJNPDqIFwBKbbkDlYlhDYCiPFf2
         39cWpX/ASTgOTHwA1yKbifiDGJAijD4QhABHoWC5pLUH8/AT2a42Z9w+oAiP4akAb/zC
         U/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679572881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqKCt/HzAeVjL0jwsjWER+U22DnB4fv/DX4FqfpOi6A=;
        b=fWi5jhFA8mmHAKcuDW1le/HkT/mfKhM3XNT4iZCeX1DwCGJu+Fpa5HQF3y3T6svDEL
         2AcW3u3P6iEMsbVJXpe+/CmVwJt0H/2pJiC+3Mq8dTRt+B3pNuKmh9HJ86kcIO8iIMXa
         WNRPD1eqZd9vha8jIe+WBp6Sk8vaZr5OJLVKylVcur8o/KyRH8bxxkJJZ07Jj588+O7z
         Tutz7Uuaav1GCUt34z6WSY2sEpH+fh+PceEsO0RoDF2dwwo5BsDSik8qP0jfq4x3hqCH
         36G2Dx/OzWCjj6qjPkGYZhen8Z/BW7/Qc0rn1jaPGYRcCx468QjM6pVbjNAbMSXilGQB
         ff1A==
X-Gm-Message-State: AO0yUKXRTSekXohu2yDhjv81BgaB8caj+dbJ0A3Ue59JIV0CpykEuE9p
        rlwVDuz1Psono+VkYLGMSO+aaA==
X-Google-Smtp-Source: AK7set+0QeW1jJR2xjZjBhgvmhIqM+7SS+rqkzLYgriC0p00kpbxGMt3U9zb038BA8JPcnxTLApF9w==
X-Received: by 2002:a17:903:20c9:b0:1a1:7c2b:4aea with SMTP id i9-20020a17090320c900b001a17c2b4aeamr5107766plb.0.1679572881544;
        Thu, 23 Mar 2023 05:01:21 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b0019a773419a6sm12149611plp.170.2023.03.23.05.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 05:01:21 -0700 (PDT)
Message-ID: <34756312-8a25-5a10-4ea5-59aeeb9e199b@9elements.com>
Date:   Thu, 23 Mar 2023 17:31:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] iio: max597x: Add support for max597x
To:     Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20230322124316.2147143-1-Naresh.Solanki@9elements.com>
 <826f5de9-3aeb-6f7a-59e6-0504f8e92180@metafoo.de>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <826f5de9-3aeb-6f7a-59e6-0504f8e92180@metafoo.de>
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

Hi,

On 22-03-2023 09:28 pm, Lars-Peter Clausen wrote:
> Hi,
> 
> This looks really good. A few minor comments inline.
> 
> On 3/22/23 05:43, Naresh Solanki wrote:
>> [...]
>> +static int max597x_iio_read_raw(struct iio_dev *iio_dev,
>> +                struct iio_chan_spec const *chan,
>> +                int *val, int *val2, long info)
>> +{
>> +    int ret;
>> +    struct max597x_iio *data = iio_priv(iio_dev);
>> +    unsigned int reg_l, reg_h;
>> +
>> +    switch (info) {
>> +    case IIO_CHAN_INFO_RAW:
>> +        ret = regmap_read(data->regmap, chan->address, &reg_l);
>> +        if (ret < 0)
>> +            return ret;
>> +        ret = regmap_read(data->regmap, chan->address - 1, &reg_h);
>> +        if (ret < 0)
>> +            return ret;
> Is there any chance of a race condition of getting inconsistent data 
> when splitting this over two reads? I.e. registers being updated with 
> new values in between the two reads.
yes, reg_l holds lower 2 bits. due to latency in reads, value may differ.
>> +        *val = (reg_h << 2) | (reg_l & 3);
>> +
>> +        return IIO_VAL_INT;
>> +    case IIO_CHAN_INFO_SCALE:
>> +
>> +        switch (chan->address) {
>> +        case MAX5970_REG_CURRENT_L(0):
>> +            fallthrough;
> 
> `fallthrough` should not be needed for multiple case statements right on 
> top of each other with no code in between. Same below
Sure.
> 
>> +        case MAX5970_REG_CURRENT_L(1):
>> +            /* in A, convert to mA */
>> +            *val = data->irng[chan->channel] * 1000;
>> +            *val2 =
>> +                data->shunt_micro_ohms[chan->channel] * ADC_MASK;
> ADC_MASK should really have a MAX5970_ prefix, but I guess it is defined 
> in max597x.h
Yes its taken from max597x.h
>> +            return IIO_VAL_FRACTIONAL;
>> +
>> +        case MAX5970_REG_VOLTAGE_L(0):
>> +            fallthrough;
>> +        case MAX5970_REG_VOLTAGE_L(1):
>> +            /* in uV, convert to mV */
>> +            *val = data->mon_rng[chan->channel];
>> +            *val2 = ADC_MASK * 1000;
>> +            return IIO_VAL_FRACTIONAL;
>> +        }
>> +
>> +        break;
>> +    }
>> +    return -EINVAL;
>> +}
>> [..]
>> +static int max597x_iio_probe(struct platform_device *pdev)
>> +{
>> +    struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
>> +    struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
>> +    struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +    struct iio_dev *indio_dev;
>> +    struct max597x_iio *priv;
>> +    int ret, i;
>> +
>> +    if (!regmap)
>> +        return -EPROBE_DEFER;
>> +
>> +    if (!max597x || !max597x->num_switches)
>> +        return -EPROBE_DEFER;
>> +
>> +    /* registering iio */
>> +    indio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*priv));
> For the devm allocations we should be using &pdev->dev and not the I2C 
> device, since this is the device to which the allocations belong and 
> where they should be freed when the device is removed.
Sure. Will use &pdev->dev
>> +    if (!indio_dev) {
>> +        dev_err(&i2c->dev, "failed allocating iio device\n");
> Consider using dev_err_probe() for error message printing. This will 
> give a consistent formatting of the messages. Also again use &pdev->dev 
> instead of I2C device to get the right device listed in the error messages.
Sure. Will use
dev_err_probe(&pdev->dev, ret, "could not register iio device");
>> +        return -ENOMEM;
>> +    }
>> +    indio_dev->name = dev_name(&i2c->dev);
> The IIO ABI wants the type of the chip for the name. E.g. "max5970", 
> using dev_name() of the parent I2C device will result in something else.
Sure. Will make it:
indio_dev->name = dev_name(&pdev->dev);
>> [...]

Regards,
Naresh
